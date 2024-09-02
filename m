Return-Path: <linux-kernel+bounces-310645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9E967F91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C254AB21727
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C791155398;
	Mon,  2 Sep 2024 06:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeEZQhFA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8C2AE99
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259137; cv=none; b=tjlvWX8mqVI2RL+lAt7A8mF3cClIaYRQs5lLPMSa99aQoG4cwpeB5LL8ykEfVCO/cwoT2/9+f69dU/AMPipkNSua5zl3/5Kqk46h6DEkfsaPB0YfDnbMSE3WyWEY+fktLsFWVvEJRBIN41epMqrJRXO6mbiUKYeBtJN9GfRemC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259137; c=relaxed/simple;
	bh=G1icPgc+gQNpQFnudDAc0SplXHoQua417+2XKBssUF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TI7HrXe6NnaOC5O4M881Npgs8MSAX2clbX6gTITlzgDqIEEDHoF7OvyfsT03NVNdqVGXry3r5oxWaZ1xP+0JRwfOyvH0ZUad/wy0swQrKdTAtCZQ9CWDCkpB5sQwUGCEJyg/oNx5Q2H802X5YUGkDP0QZjOKZqfOHMqvnJmRqJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeEZQhFA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177C2C4CEC2;
	Mon,  2 Sep 2024 06:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725259137;
	bh=G1icPgc+gQNpQFnudDAc0SplXHoQua417+2XKBssUF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aeEZQhFAX8FbCd32gz78SW3SBnaldTRBkhooG5WkqOKIqRmvCPIC1NaLorw0QR2ia
	 TsmcdiQP2o3UHLSLyumM5JQfuOdz/WUH4vHDbvQZjAK2ETW0dJrWE31oFH0LJ8ataG
	 xKzVhI4d08YKru25jj1JNi/0ejTP0g9tsTiQuhE75nGGiB6Sx8T394iitQgLz3rEMI
	 irusV1GUfEq8JJg4gP4ycMTDx1o8rEzLo8GllvdJAQ3Ao22HqwFJLNSFMwJKcG2dyv
	 fwgx4lBlRELEtvTb5nIdOlZ5cwcT9TpAsz6ESRZqO1xMaKUZWP97yMyhuUlEms/qBD
	 QI57grHzbj9mA==
Message-ID: <27e01c20-2fb6-4d51-b2c0-1c5e3f0d4f26@kernel.org>
Date: Mon, 2 Sep 2024 14:38:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2 2/4] f2fs: atomic: fix to not allow GC to
 pollute atomic_file
To: Sunmin Jeong <s_min.jeong@samsung.com>, jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <CGME20240814135008epcas1p3e11d629481d51a4cc4af78dbe3e66fda@epcas1p3.samsung.com>
 <20240814134815.801303-1-chao@kernel.org>
 <002e01daf2aa$f22d5430$d687fc90$@samsung.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <002e01daf2aa$f22d5430$d687fc90$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/20 10:44, Sunmin Jeong wrote:
> Hello Chao Yu,
> 
>> SQLite App			GC Thread	Shrinker
>> - f2fs_ioc_start_atomic_write
>>
>> - f2fs_ioc_commit_atomic_write
>> - f2fs_commit_atomic_write
>>   - filemap_write_and_wait_range
>>   : write atomic_file's data to cow_inode
>> 						echo 3 > drop_caches
>> 				- f2fs_gc
>> 				 - gc_data_segment
>> 				  - move_data_page
> 
> We modified the code to make GC of the atomic file go to move_data_block
> in commit b40a2b003709 (f2fs: use meta inode for GC of atomic file).
> Could you please check if this patch is still necessary?

Sunmin,

Yes, you're right.

Also, I've checked f2fs/003 of xfstests w/ commit b40a2b003709, it can fix the
regression issue as well, so let's drop it.

Thanks for pointing it out. :)

Thanks,

> 
> Thanks,
> 
>> 				   - set_page_dirty
>> 				   : it may load data of previous
>> 				     transaction into pagecache.
>>   - f2fs_down_write(&fi->i_gc_rwsem[WRITE])
>>   - __f2fs_commit_atomic_write
>>   - f2fs_up_write(&fi->i_gc_rwsem[WRITE])
>>
>> During committing atomic_file, GC may be triggered to migrate atomic_file's
>> block, so it may contain data of previous transaction in page cache, we
>> should drop atomic_file's cache once it was migrated by GC.
>>
>> And also, we should writeback atomic_file and cow_file's data w/ i_gc_rwsem
>> lock held, in order to avoid block address change during
>> __f2fs_commit_atomic_write().
>>
>> Meahwhile, this patch adds f2fs_wait_on_block_writeback_range()
>> to wait completion of block migration.
>>
>> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - fix error path handling.
>> fs/f2fs/segment.c | 27 +++++++++++++++++++++++----
>> 1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c index
>> 3aee71c9f3c6..a43054ab0cf1 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -236,6 +236,9 @@ static int __replace_atomic_write_block(struct inode
>> *inode, pgoff_t index,
>> 		return err;
>> 	}
>>
>> +	if (__is_valid_data_blkaddr(dn.data_blkaddr))
>> +		f2fs_wait_on_block_writeback_range(inode, dn.data_blkaddr,
> 1);
>> +
>> 	if (recover) {
>> 		/* dn.data_blkaddr is always valid */
>> 		if (!__is_valid_data_blkaddr(new_addr)) { @@ -339,6 +342,9
> @@
>> static int __f2fs_commit_atomic_write(struct inode *inode)
>> 				goto out;
>> 			}
>>
>> +			f2fs_wait_on_block_writeback_range(cow_inode,
>> +								blkaddr, 1);
>> +
>> 			new = f2fs_kmem_cache_alloc(revoke_entry_slab,
> GFP_NOFS,
>> 							true, NULL);
>>
>> @@ -379,16 +385,29 @@ int f2fs_commit_atomic_write(struct inode *inode)
>> 	struct f2fs_inode_info *fi = F2FS_I(inode);
>> 	int err;
>>
>> +	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>> +
>> 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>> 	if (err)
>> -		return err;
>> +		goto out;
>>
>> -	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>> -	f2fs_lock_op(sbi);
>> +	/* writeback GCing page of cow_inode */
>> +	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
>> +							0, LLONG_MAX);
>> +	if (err)
>> +		goto out;
>>
>> -	err = __f2fs_commit_atomic_write(inode);
>> +	filemap_invalidate_lock(inode->i_mapping);
>> +
>> +	/* don't allow clean page loaded by GC to pollute atomic_file */
>> +	truncate_pagecache(inode, 0);
>>
>> +	f2fs_lock_op(sbi);
>> +	err = __f2fs_commit_atomic_write(inode);
>> 	f2fs_unlock_op(sbi);
>> +
>> +	filemap_invalidate_unlock(inode->i_mapping);
>> +out:
>> 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>>
>> 	return err;
>> --
>> 2.40.1
>>
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 


