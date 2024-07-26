Return-Path: <linux-kernel+bounces-262753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC2893CC37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06721C20F92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8104C99;
	Fri, 26 Jul 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wix3Zta3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966C4430
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721955974; cv=none; b=QbwN10t9qmSOpP9gdTtnOPf6NaSA0RykwiwSS4FK3t6l+d5UwZaiPprlDs3g/Tq0dxJHMUo2GXXqtSSwv5IMiX+Trab/ANd1VzRiYcIbfbQ247HdPN/C1WmeI2N9GVhqsyl5hzibnEoP3kiWwA310u5fNp8z7UgtzBsI2OEJfEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721955974; c=relaxed/simple;
	bh=sYVnj9xdCeSe7R1pi1xns6VDN4e1inwVA9ogtzZ53cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=peX2UZqnj3zgwjsNB51OprPRdEnfVKZU+sl2y3vHmRxQCzqPWn6NhuR+9VHk/zy/fqrpvFMwdSWSz+MRTaBI4pcjJ7IO/A00qJLmNkZ6dZkysnPoLEZE2VHjLYRy0JXr4AysDQNu0sOkGIbOMD0xvtqdZ9e5w9a2khBrpJVgZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wix3Zta3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8179AC116B1;
	Fri, 26 Jul 2024 01:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721955974;
	bh=sYVnj9xdCeSe7R1pi1xns6VDN4e1inwVA9ogtzZ53cg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wix3Zta330LmeX96By18flpG7LgZ+hqzOtE76omRc1r0xBVRILfy5GvD9liqDv1Xs
	 7hETGZqsOS/+tp2nWRnwkQN9LqYVSawLWIHy5TSkerYSbtZkTE2hOhRMkLiWWBaxJU
	 ZwMNYh9njjmI/UxXuHD02lxBYrJ3Lut5SR1kmmrhojommpPCBcGchwLPh39jmwWN5m
	 yusQK2bcjG4P7x9z/ZlIiPIUd70Hz5NmywKtBf5UWCiAowhxoxkTforkCtPPLdDczz
	 DxHHTOjIF9Dsjz5ArV88cke9ocoJU7tbhmHj5G58/FEdjgmxasFQb1IoGkMfP9Ft5c
	 rVX4IPzZ1GG6g==
Message-ID: <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
Date: Fri, 26 Jul 2024 09:06:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: don't traverse directory blocks after EOF
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240712073415.227226-1-chao@kernel.org>
 <ZqKDnpzwX85RyGaa@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqKDnpzwX85RyGaa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/26 0:55, Jaegeuk Kim wrote:
> On 07/12, Chao Yu wrote:
>> All directory blocks are within the scope of i_size, so let's limit
>> the end_block to just check valid dirent blocks.
> 
> Do we really need this?

f2fs_readdir() and f2fs_empty_dir() uses dir_blocks() for upper boundary,
this patch aligns find_in_level() w/ them.

Also, it can avoid grabbing never used page cache across EOF.

So, we can consider taking this patch?

Thanks,

> 
>>
>> Meanwhile, it uses dir_blocks() instead of variable for cleanup in
>> __f2fs_find_entry().
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/dir.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>> index 02c9355176d3..d4591c215f07 100644
>> --- a/fs/f2fs/dir.c
>> +++ b/fs/f2fs/dir.c
>> @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>>   	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
>>   	unsigned int nbucket, nblock;
>>   	unsigned int bidx, end_block;
>> +	unsigned long last_block;
>>   	struct page *dentry_page;
>>   	struct f2fs_dir_entry *de = NULL;
>>   	pgoff_t next_pgofs;
>>   	bool room = false;
>>   	int max_slots;
>>   
>> +	last_block = dir_blocks(dir);
>>   	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
>>   	nblock = bucket_blocks(level);
>>   
>>   	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
>>   			       le32_to_cpu(fname->hash) % nbucket);
>>   	end_block = bidx + nblock;
>> +	end_block = min_t(unsigned int, end_block, last_block);
>>   
>>   	while (bidx < end_block) {
>>   		/* no need to allocate new dentry pages to all the indices */
>> @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>   					 const struct f2fs_filename *fname,
>>   					 struct page **res_page)
>>   {
>> -	unsigned long npages = dir_blocks(dir);
>>   	struct f2fs_dir_entry *de = NULL;
>>   	unsigned int max_depth;
>>   	unsigned int level;
>> @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>   		goto out;
>>   	}
>>   
>> -	if (npages == 0)
>> +	if (dir_blocks(dir) == 0)
>>   		goto out;
>>   
>>   	max_depth = F2FS_I(dir)->i_current_depth;
>> -- 
>> 2.40.1

