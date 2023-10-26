require "colorize"

word_list = File.readlines("wordle_list.txt").map(&:chomp)
today_answer = word_list.sample.to_s.upcase

def ask_for_word
  while true
    print "Please enter a 5-letter word: "
    user_word = gets.chomp
    if user_word.length == 5
      return user_word
      break
    else
      puts "That's not five letters."
    end
  end
end

def assign_colors(word, answer)
  word = word.upcase
  word_array = word.split(//)
  answer_array = answer.split(//)
  word_display_array = word.split(//)
  word_hash = {}
  answer_hash = {}

  #Assign greens only and remove letters from answer array
  word_array.each_index do |x|
    answer_array.each_index do |y|
      if word_array[x] == answer_array[y] && x == y
        word_display_array[x] = answer_array[y].on_green
        answer_array[y] = ""
      end
    end
  end

  #Assign yellows only and remove letters from answer array
  word_array.each_index do |x|
    answer_array.each_index do |y|
      if word_array[x] == answer_array[y]
        word_display_array[x] = answer_array[y].on_yellow
        if x == y
          word_display_array[x] = answer_array[y].on_green
        end
        answer_array[y] = ""
      end
    end
  end

  return word_display_array
end

def check_word(word, answer, guess_count)
  answer = answer.upcase
  word = word.upcase
  if answer == word
    puts "You got it right! The word is #{answer.upcase.on_green}"
    return 7
  else
    if guess_count == 5
      puts "You didn't get it. The word was #{answer.upcase.on_green}"
    end
    return (guess_count + 1)
  end
end

guess_count = 0

while guess_count < 6
  user_word = ask_for_word
  user_colored = assign_colors(user_word, today_answer)
  puts user_colored.join("")
  guess_count = check_word(user_word, today_answer, guess_count)
end
