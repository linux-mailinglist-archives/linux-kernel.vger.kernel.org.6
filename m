Return-Path: <linux-kernel+bounces-265033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8353793EBB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E577281652
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A157F7CA;
	Mon, 29 Jul 2024 02:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+3HO33a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18442768EF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221692; cv=none; b=Xqug7gtLdSc8cRFnIwBCANw1hYgA1om0wCl23ztnIZIfy62CaOyEKyNE0owRX1vJsBnoVlL/vEer1h9a0Qz/0HWT7c/AeinKmWXPiWequIuaK5yCEQBUtVrYv+0p71RZH4hBUiNbGdSD936w/yqO1pWw6gIIGsaw9mmk3wvd8Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221692; c=relaxed/simple;
	bh=CxoLcnEcwOVtU1sK4vdRlZkJkyUaqBQg4RZqDYGsewc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6uUTU2PbSBiBcsUBMh0RQ6+rT6ZrzvbupPcQVqQEIUUv8j1qKqUTd7NjqW6eXkRC1UyJHmgRtVtccXmdFUh/T7O0I5g1CfqaBBSzch1t6TqEplrAx0HkJA0cnkqYiuCvrAanERtKMnTwhKaM2bJWGPvECiNdxhLJ5T4Vkp3bVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+3HO33a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA7BC116B1;
	Mon, 29 Jul 2024 02:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722221691;
	bh=CxoLcnEcwOVtU1sK4vdRlZkJkyUaqBQg4RZqDYGsewc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t+3HO33axhe4bI77zQ7MMUu9NHRW2zqAhWCzNCGNupsn9Xqru9T7dLBfxCJXuDhLg
	 xW5vS/sN/7jlZe+hWiTzDkmBgZFOqDxM4LhoImfgz/+RTdvnfk4pif3yk0Lmzu1moW
	 dDZQJjkDQ1juI1cWVrO4+W6ZVPGhLo34mXn53tteyCtjx1Zqb6GbWDvhnAWF9eucBY
	 Z46hGqzKls8vSZks2XGCLNo0DEUheNEr/goct9SySfk6Q4NuXLav5hQYfbDY/aAwFu
	 fg8Tx/R2XukD+mQQIryc6nTGSgRB3vcSoj2yf9m+7ks2Pcl9Ttqnbe6+mAFhjp4m6K
	 IYNJNt08u7rtg==
Message-ID: <74dbb5f1-1565-4971-ae5c-c176d62cfa8f@kernel.org>
Date: Mon, 29 Jul 2024 10:54:46 +0800
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
 <c2b7d0cd-ea10-4e25-829c-53967927bd03@kernel.org>
 <ZqRpHOJyWU3Sn8Ma@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZqRpHOJyWU3Sn8Ma@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/27 11:27, Jaegeuk Kim wrote:
> On 07/26, Chao Yu wrote:
>> On 2024/7/26 0:55, Jaegeuk Kim wrote:
>>> On 07/12, Chao Yu wrote:
>>>> All directory blocks are within the scope of i_size, so let's limit
>>>> the end_block to just check valid dirent blocks.
>>>
>>> Do we really need this?
>>
>> f2fs_readdir() and f2fs_empty_dir() uses dir_blocks() for upper boundary,
>> this patch aligns find_in_level() w/ them.
>>
>> Also, it can avoid grabbing never used page cache across EOF.
>>
>> So, we can consider taking this patch?
> 
> I'm wondering whether the current code has a bug or not.

I think it's not a bug, but, in corner case it may waste memory and
cause a bit performance reduction.

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>>>
>>>> Meanwhile, it uses dir_blocks() instead of variable for cleanup in
>>>> __f2fs_find_entry().
>>>>
>>>> Signed-off-by: Chao Yu <chao@kernel.org>
>>>> ---
>>>>    fs/f2fs/dir.c | 6 ++++--
>>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
>>>> index 02c9355176d3..d4591c215f07 100644
>>>> --- a/fs/f2fs/dir.c
>>>> +++ b/fs/f2fs/dir.c
>>>> @@ -305,18 +305,21 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
>>>>    	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
>>>>    	unsigned int nbucket, nblock;
>>>>    	unsigned int bidx, end_block;
>>>> +	unsigned long last_block;
>>>>    	struct page *dentry_page;
>>>>    	struct f2fs_dir_entry *de = NULL;
>>>>    	pgoff_t next_pgofs;
>>>>    	bool room = false;
>>>>    	int max_slots;
>>>> +	last_block = dir_blocks(dir);
>>>>    	nbucket = dir_buckets(level, F2FS_I(dir)->i_dir_level);
>>>>    	nblock = bucket_blocks(level);
>>>>    	bidx = dir_block_index(level, F2FS_I(dir)->i_dir_level,
>>>>    			       le32_to_cpu(fname->hash) % nbucket);
>>>>    	end_block = bidx + nblock;
>>>> +	end_block = min_t(unsigned int, end_block, last_block);
>>>>    	while (bidx < end_block) {
>>>>    		/* no need to allocate new dentry pages to all the indices */
>>>> @@ -361,7 +364,6 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>>>    					 const struct f2fs_filename *fname,
>>>>    					 struct page **res_page)
>>>>    {
>>>> -	unsigned long npages = dir_blocks(dir);
>>>>    	struct f2fs_dir_entry *de = NULL;
>>>>    	unsigned int max_depth;
>>>>    	unsigned int level;
>>>> @@ -373,7 +375,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
>>>>    		goto out;
>>>>    	}
>>>> -	if (npages == 0)
>>>> +	if (dir_blocks(dir) == 0)
>>>>    		goto out;
>>>>    	max_depth = F2FS_I(dir)->i_current_depth;
>>>> -- 
>>>> 2.40.1

