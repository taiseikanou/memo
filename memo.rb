require "csv"

def create_new_memo
  puts "拡張子を除いたファイルを入力してください"
  memo_name = gets.chomp.strip

  memo_name += '.csv' 

  CSV.open(memo_name, "w") do |csv|
    puts "メモしたい内容を記入してください"
    puts "完了したらCtrl + Dをおします"
    while input = gets
      break if input.chomp.empty?
      csv << input.chomp.split(',')
    end
  end

end

def edit_existing_memo
  puts "拡張子を除いた編集するCSVファイル名を入力してください:"
  memo_name = gets.chomp.strip

 
  memo_name += '.csv'

  unless File.exist?(memo_name)
    puts "指定されたファイルは存在しません。"
    return
  end

  
  data = CSV.read(memo_name)
  puts "現在のデータ:"
  data.each { |row| puts row.join(', ') }

  puts "編集する行の番号を入力してください:"
  row_index = gets.chomp.to_i - 1

  puts "新しいデータを入力してください:"
  new_data = gets.chomp.split(',')
  data[row_index] = new_data

  CSV.open(file_name, "w") do |csv|
    data.each { |row| csv << row }
  end

end

puts "1(新規でメモを作成) 2(既存のメモ編集する)"
memo_type = gets.to_i

if memo_type == 1
  create_new_memo
elsif memo_type == 2
  edit_existing_memo
else
  puts "不正な値です"
end