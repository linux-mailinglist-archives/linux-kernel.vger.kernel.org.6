Return-Path: <linux-kernel+bounces-514186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0856CA353BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D62D7A46FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 01:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EAD8634A;
	Fri, 14 Feb 2025 01:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqGyRiip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4166586324
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739496912; cv=none; b=VDbpzNTzoVgwBhOYH21FFKraOOeCNqTUqyUPaXB7++hqq8i9OTLapm6wjPYQITXH9BkoHgoc2Y5p2LlMAC8NTNaawfDL/x8YNz8BFpUK/qv9KfjD6drNO49f5Cx49oAzxEt1hswu7i5IXkeFec67/ExzFKcLoCA7DYUom1WHK9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739496912; c=relaxed/simple;
	bh=CADuvBrVBIT5LuqPjR3kLYoWYDmCrsfTi2YERJfMO3s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZN0os3UzY1trW8QdXsIZSGmndGhxQOOeVyyExF6Hw8jbjUue0sqqr2OBsqaUBjSig4Otlwrkslvkiy+NUC9ga+kzhcM6ctgEukIfcoGfQzqjMUJEjKoy22F7jPUPD35TtHdXJkVuFk6a+RyeoQobnnGks/Gw7ZKX0HW5/O83brY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqGyRiip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1E5C4CED1;
	Fri, 14 Feb 2025 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739496911;
	bh=CADuvBrVBIT5LuqPjR3kLYoWYDmCrsfTi2YERJfMO3s=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=IqGyRiipNhvUJ0BRBKvBKxg6WD1mZbcYHtLqxPY05xhjvW4GZ/scX6Xxo0o9CH6Bh
	 jL+IzjcPraL0WIV+pz3tV4mxujZUuwPXCczRlj5DoYY9JSON2f5j8bfVgSL8YdCq2r
	 17qQ3b0lgQxjd/p1lUoxp/JwmuqxO2BmBvSzSKTvUwIWGqnF6pWzLxKGrU9Uqn6KnN
	 cU5+AX6eiApAy4kBIEcV99mToB0jd0n9n0g5+NycaB9YLSygRw9muYNAWgeVLUdF/V
	 VLmBDgqbZpKcRI765fc6VVbIE5dx8E4JnkUL7d2nO4LBI+SZi+AdSnuuBwaDgjnP12
	 8LnQnPcIJ5zww==
Message-ID: <bdda86bd-3977-4c77-b8d5-b37feda9e98a@kernel.org>
Date: Fri, 14 Feb 2025 09:35:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
Subject: Re: [PATCH] f2fs: fix to avoid accessing uninitialized curseg
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250212075242.988652-1-chao@kernel.org>
 <Z64zcac0_dw1_rML@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Z64zcac0_dw1_rML@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/14/25 02:01, Jaegeuk Kim wrote:
> On 02/12, Chao Yu wrote:
>> syzbot reports a f2fs bug as below:
>>
>> F2FS-fs (loop3): Stopped filesystem due to reason: 7
>> kworker/u8:7: attempt to access beyond end of device
>> BUG: unable to handle page fault for address: ffffed1604ea3dfa
>> RIP: 0010:get_ckpt_valid_blocks fs/f2fs/segment.h:361 [inline]
>> RIP: 0010:has_curseg_enough_space fs/f2fs/segment.h:570 [inline]
>> RIP: 0010:__get_secs_required fs/f2fs/segment.h:620 [inline]
>> RIP: 0010:has_not_enough_free_secs fs/f2fs/segment.h:633 [inline]
>> RIP: 0010:has_enough_free_secs+0x575/0x1660 fs/f2fs/segment.h:649
>>  <TASK>
>>  f2fs_is_checkpoint_ready fs/f2fs/segment.h:671 [inline]
>>  f2fs_write_inode+0x425/0x540 fs/f2fs/inode.c:791
>>  write_inode fs/fs-writeback.c:1525 [inline]
>>  __writeback_single_inode+0x708/0x10d0 fs/fs-writeback.c:1745
>>  writeback_sb_inodes+0x820/0x1360 fs/fs-writeback.c:1976
>>  wb_writeback+0x413/0xb80 fs/fs-writeback.c:2156
>>  wb_do_writeback fs/fs-writeback.c:2303 [inline]
>>  wb_workfn+0x410/0x1080 fs/fs-writeback.c:2343
>>  process_one_work kernel/workqueue.c:3236 [inline]
>>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>>  worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>>  kthread+0x7a9/0x920 kernel/kthread.c:464
>>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>
>> Commit 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT") allows to trigger
>> no free segment fault in allocator, then it will update curseg->segno to
>> NULL_SEGNO, though, CP_ERROR_FLAG has been set, f2fs_write_inode() missed
>> to check the flag, and access invalid curseg->segno directly in below call
>> path, then resulting in panic:
>>
>> - f2fs_write_inode
>>  - f2fs_is_checkpoint_ready
>>   - has_enough_free_secs
>>    - has_not_enough_free_secs
>>     - __get_secs_required
>>      - has_curseg_enough_space
>>       - get_ckpt_valid_blocks
>>       : access invalid curseg->segno
>>
>> To avoid this issue, let's:
>> - check CP_ERROR_FLAG flag in prior to f2fs_is_checkpoint_ready() in
>> f2fs_write_inode().
>> - in has_curseg_enough_space(), a) verify status of curseg before accessing
>> its field, and b) grab curseg_mutex lock to avoid race condition.
>>
>> Fixes: 8b10d3653735 ("f2fs: introduce FAULT_NO_SEGMENT")
>> Reported-by: syzbot+b6b347b7a4ea1b2e29b6@syzkaller.appspotmail.com
>> Closes: https://lore.kernel.org/all/67973c2b.050a0220.11b1bb.0089.GAE@google.com
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/inode.c   |  7 +++++++
>>  fs/f2fs/segment.h | 27 ++++++++++++++++++++++-----
>>  2 files changed, 29 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index 02f1b69d03d8..5c1b515eab36 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -799,6 +799,13 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
>>  		!is_inode_flag_set(inode, FI_DIRTY_INODE))
>>  		return 0;
>>  
>> +	/*
>> +	 * no need to update inode page, ultimately f2fs_evict_inode() will
>> +	 * clear dirty status of inode.
>> +	 */
>> +	if (f2fs_cp_error(sbi))
>> +		return -EIO;
>> +
>>  	if (!f2fs_is_checkpoint_ready(sbi)) {
>>  		f2fs_mark_inode_dirty_sync(inode, true);
>>  		return -ENOSPC;
>> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
>> index 943be4f1d6d2..e9fcf2b85b76 100644
>> --- a/fs/f2fs/segment.h
>> +++ b/fs/f2fs/segment.h
>> @@ -559,15 +559,23 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>>  			unsigned int node_blocks, unsigned int data_blocks,
>>  			unsigned int dent_blocks)
>>  {
>> -
>> +	struct curseg_info *curseg;
>>  	unsigned int segno, left_blocks, blocks;
>>  	int i;
>>  
>>  	/* check current data/node sections in the worst case. */
>>  	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
>> -		segno = CURSEG_I(sbi, i)->segno;
>> -		left_blocks = CAP_BLKS_PER_SEC(sbi) -
>> +		curseg = CURSEG_I(sbi, i);
>> +
>> +		mutex_lock(&curseg->curseg_mutex);
>> +		if (!curseg->inited || curseg->segno == NULL_SEGNO) {
>> +			left_blocks = 0;
>> +		} else {
>> +			segno = curseg->segno;
>> +			left_blocks = CAP_BLKS_PER_SEC(sbi) -
>>  				get_ckpt_valid_blocks(sbi, segno, true);
>> +		}
>> +		mutex_unlock(&curseg->curseg_mutex);
> 
> This looks a bit worrisome, as it'll block user-facing allocation. Can we
> have another way to prevent the issue?

How about this? It'll be fine to use a temp valid segno in
get_ckpt_valid_blocks(), it can get rid of curseg_mutex use.

segno = CURSEG_I(sbi, i)->segno;
if (!curseg->inited || segno == NULL_SEGNO) {
	left_blocks = 0;
} else {
	...

Thanks,

> 
>>  
>>  		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
>>  		if (blocks > left_blocks)
>> @@ -575,9 +583,18 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
>>  	}
>>  
>>  	/* check current data section for dentry blocks. */
>> -	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
>> -	left_blocks = CAP_BLKS_PER_SEC(sbi) -
>> +	curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
>> +
>> +	mutex_lock(&curseg->curseg_mutex);
>> +	if (!curseg->inited || curseg->segno == NULL_SEGNO) {
>> +		left_blocks = 0;
>> +	} else {
>> +		segno = curseg->segno;
>> +		left_blocks = CAP_BLKS_PER_SEC(sbi) -
>>  			get_ckpt_valid_blocks(sbi, segno, true);
>> +	}
>> +	mutex_unlock(&curseg->curseg_mutex);
>> +
>>  	if (dent_blocks > left_blocks)
>>  		return false;
>>  	return true;
>> -- 
>> 2.48.1.502.g6dc24dfdaf-goog


