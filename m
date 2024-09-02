Return-Path: <linux-kernel+bounces-310646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26841967F93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5819E1C2166F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 06:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50655155739;
	Mon,  2 Sep 2024 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAwB8SNs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F12B9BB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 06:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259235; cv=none; b=LXhsGAmjca/SoesEsR5GpyU9Woa+o4MXz0np293d0d+dDm0a0EN9pmEV9jrlmkV8xO27L+n7K80h+3BIWHI92gSJDql8YLdRxTKRLqoUzTRSJLK7SylmP+VoTzv4zcoTk7fAv05jbok6Lg1qxwxTA5XSOX5isGw4O7ds+JkZqVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259235; c=relaxed/simple;
	bh=l92+Z4TkBHTdsYUS62K+3LCo79KmnnuNLTIBVaXKZ6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6N3hMJXANVCRD35zjdcPIfpIzDvCEHwNV2GKPFXgE2nHIDmLdNfbHck/YjettX/X6PdUXmNQHMPCRYbBQi2Abt2ZUQuO5ck9Ov3/LPjCaBsmqLlN+BhvdzzWolZWXcIRhvBcWRwT/XL25RCpOPqdC3G+iktWT1WquIMhVK6X+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAwB8SNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF75C4CEC2;
	Mon,  2 Sep 2024 06:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725259235;
	bh=l92+Z4TkBHTdsYUS62K+3LCo79KmnnuNLTIBVaXKZ6U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IAwB8SNs9kGonJff6htuVbG+RaUf9/DXW8b7Fleg9/WdBbufzaupcS+9VulgDgnXU
	 gzG+FgR2N8dAC6adGGQoqN6XQfLZSZ11WM6UQ2Rz2FQo38O7k/jTAcpQlnuVkbvDkb
	 HEH+yb5H8rFGgdROEi448pyS60Xjb2xXfUcfEB6prNgRz9ciUjJuHoyPZOPqPZcc4R
	 XpquAomVDosd00EEl9PqSgpXUxnuGbAxgEgZ/BALQY3f1iFHnKgTnk5pEao2qPCIsS
	 MXpE+hSQILiGSxpgrNutVrqDKGw0nahRKGbmEeaXVMjAqKXVYs0mCJc70NJPLchc5g
	 Vfpf3cmSj204g==
Message-ID: <2905d4bf-279c-45f0-a434-b9d47766bbd1@kernel.org>
Date: Mon, 2 Sep 2024 14:40:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] f2fs: atomic: fix to not allow GC to pollute
 atomic_file
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240814134815.801303-1-chao@kernel.org>
 <Zs9B6-ocRysmPOKD@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zs9B6-ocRysmPOKD@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/28 23:27, Jaegeuk Kim wrote:
> On 08/14, Chao Yu wrote:
>> SQLite App			GC Thread	Shrinker
>> - f2fs_ioc_start_atomic_write
>>
>> - f2fs_ioc_commit_atomic_write
>>   - f2fs_commit_atomic_write
>>    - filemap_write_and_wait_range
>>    : write atomic_file's data to cow_inode
>> 						echo 3 > drop_caches
>> 				- f2fs_gc
>> 				 - gc_data_segment
>> 				  - move_data_page
>> 				   - set_page_dirty
>> 				   : it may load data of previous
>> 				     transaction into pagecache.
>>    - f2fs_down_write(&fi->i_gc_rwsem[WRITE])
>>    - __f2fs_commit_atomic_write
>>    - f2fs_up_write(&fi->i_gc_rwsem[WRITE])
>>
>> During committing atomic_file, GC may be triggered to migrate
>> atomic_file's block, so it may contain data of previous transaction
>> in page cache, we should drop atomic_file's cache once it was
>> migrated by GC.
>>
>> And also, we should writeback atomic_file and cow_file's data
>> w/ i_gc_rwsem lock held, in order to avoid block address change
>> during __f2fs_commit_atomic_write().
>>
>> Meahwhile, this patch adds f2fs_wait_on_block_writeback_range()
>> to wait completion of block migration.
>>
>> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - fix error path handling.
>>   fs/f2fs/segment.c | 27 +++++++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 3aee71c9f3c6..a43054ab0cf1 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -236,6 +236,9 @@ static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
>>   		return err;
>>   	}
>>   
>> +	if (__is_valid_data_blkaddr(dn.data_blkaddr))
>> +		f2fs_wait_on_block_writeback_range(inode, dn.data_blkaddr, 1);
>> +
>>   	if (recover) {
>>   		/* dn.data_blkaddr is always valid */
>>   		if (!__is_valid_data_blkaddr(new_addr)) {
>> @@ -339,6 +342,9 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>>   				goto out;
>>   			}
>>   
>> +			f2fs_wait_on_block_writeback_range(cow_inode,
>> +								blkaddr, 1);
>> +
>>   			new = f2fs_kmem_cache_alloc(revoke_entry_slab, GFP_NOFS,
>>   							true, NULL);
>>   
>> @@ -379,16 +385,29 @@ int f2fs_commit_atomic_write(struct inode *inode)
>>   	struct f2fs_inode_info *fi = F2FS_I(inode);
>>   	int err;
>>   
>> +	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
>> +
>>   	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
>>   	if (err)
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
> 
> Performance impact?

Please drop this patch due to commit b40a2b003709 (f2fs: use meta inode for
GC of atomic file) has fixed this issue. Thanks.

Thanks,

> 
>>   
>> +	f2fs_lock_op(sbi);
>> +	err = __f2fs_commit_atomic_write(inode);
>>   	f2fs_unlock_op(sbi);
>> +
>> +	filemap_invalidate_unlock(inode->i_mapping);
>> +out:
>>   	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
>>   
>>   	return err;
>> -- 
>> 2.40.1


