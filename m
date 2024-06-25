Return-Path: <linux-kernel+bounces-228152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BD915B84
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3181F22279
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 01:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056471B7F7;
	Tue, 25 Jun 2024 01:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXtQsr1K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC601A270
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278077; cv=none; b=aSfFNswNDn9hwxEtSL3mvIwCdimYLmRvPEHyDDcapSI/Gj7pAb5XthP8oFFtxFh37Zy0o473MmxdGkKtKhlBq51aQYVcM0dKoJ+esgWTWQL3yUNlr4A+soKXNs5IselrzZIeq0f4EZq2vAxmC7KypmR2qn4fVmrzgPSVktHLo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278077; c=relaxed/simple;
	bh=zue60nLKRM9hqp7Y2+yqVUlGb8bESpFQm08i1f8AibQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqTpoZACqNyPPWOuRw8D3wGRuJCrWE5yq57i09QIZkMzJ105Re9/ezb1xs4PG3go7R9riCqRvn62xsz4RTBT8ogaGpWbJRgOmlx3ujitjPQvZMg3qVqFttWtR90/1WWaV7qPzwrNxKTGpz/8c6U5oepja2KjhddbZivxd46VPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXtQsr1K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE13C2BBFC;
	Tue, 25 Jun 2024 01:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719278076;
	bh=zue60nLKRM9hqp7Y2+yqVUlGb8bESpFQm08i1f8AibQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QXtQsr1KkNNyPrUujsETwUHpG/tBp/hBqa81QZ+o/H6RXq4ZDGaNYr6cHY3eoobWm
	 JYwdrLrfDKD6+V8B5TwnFbH3i19QbMRerWrbTSunDCGP8bKsUDmu4ijtk4JE36TZa2
	 NCDUCYO5glFDw9PTI68qqCazP+RO81st6ABlpOgRC3PA5v1ddfai/7FxVGsvRgHP4+
	 aLsknnM6fYyE3Mg+usUCrDyKG13a4pBD3mf8IHhuGkK4EJUg0AKd5aL7ORsT9m6ASZ
	 SX2O3o8lv20VRJI5AC4EYg2bc+fIoNFqWr1OgKM5oYgWT6nrX+b4+QNBKXprqCmFBN
	 5lst4wena6yLg==
Message-ID: <f0adf39a-5c07-49bd-910d-eebbc5f41dc1@kernel.org>
Date: Tue, 25 Jun 2024 09:14:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to update user block counts in
 block_operations()
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Yunlei He <heyunlei@oppo.com>
References: <20240606095451.4088735-1-chao@kernel.org>
 <ZnmylaqsdF65PVDp@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZnmylaqsdF65PVDp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/25 1:53, Jaegeuk Kim wrote:
> On 06/06, Chao Yu wrote:
>> Commit 59c9081bc86e ("f2fs: allow write page cache when writting cp")
>> allows write() to write data to page cache during checkpoint, so block
>> count fields like .total_valid_block_count, .alloc_valid_block_count
>> and .rf_node_block_count may encounter race condition as below:
>>
>> CP				Thread A
>> - write_checkpoint
>>   - block_operations
>>    - f2fs_down_write(&sbi->node_change)
>>    - __prepare_cp_block
>>    : ckpt->valid_block_count = .total_valid_block_count
>>    - f2fs_up_write(&sbi->node_change)
>> 				- write
>> 				 - f2fs_preallocate_blocks
>> 				  - f2fs_map_blocks(,F2FS_GET_BLOCK_PRE_AIO)
>> 				   - f2fs_map_lock
>> 				    - f2fs_down_read(&sbi->node_change)
>> 				   - f2fs_reserve_new_blocks
>> 				    - inc_valid_block_count
>> 				    : percpu_counter_add(&sbi->alloc_valid_block_count, count)
>> 				    : sbi->total_valid_block_count += count
>> 				    - f2fs_up_read(&sbi->node_change)
>>   - do_checkpoint
>>   : sbi->last_valid_block_count = sbi->total_valid_block_count
>>   : percpu_counter_set(&sbi->alloc_valid_block_count, 0)
>>   : percpu_counter_set(&sbi->rf_node_block_count, 0)
>> 				- fsync
>> 				 - need_do_checkpoint
>> 				  - f2fs_space_for_roll_forward
>> 				  : alloc_valid_block_count was reset to zero,
>> 				    so, it may missed last data during checkpoint
>>
>> Let's change to update .total_valid_block_count, .alloc_valid_block_count
>> and .rf_node_block_count in block_operations(), then their access can be
>> protected by .node_change and .cp_rwsem lock, so that it can avoid above
>> race condition.
>>
>> Fixes: 59c9081bc86e ("f2fs: allow write page cache when writting cp")
>> Cc: Yunlei He <heyunlei@oppo.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>   fs/f2fs/checkpoint.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 66eaad591b60..010bbd5af211 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1298,6 +1298,12 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>   	 * dirty node blocks and some checkpoint values by block allocation.
>>   	 */
>>   	__prepare_cp_block(sbi);
>> +
>> +	/* update user_block_counts */
>> +	sbi->last_valid_block_count = sbi->total_valid_block_count;
>> +	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>> +	percpu_counter_set(&sbi->rf_node_block_count, 0);
> 
> Need to add this in __prepare_cp_block()?

Fine to me, will update in v2.

Thanks,

> 
>> +
>>   	f2fs_up_write(&sbi->node_change);
>>   	return err;
>>   }
>> @@ -1575,11 +1581,6 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>>   		start_blk += NR_CURSEG_NODE_TYPE;
>>   	}
>>   
>> -	/* update user_block_counts */
>> -	sbi->last_valid_block_count = sbi->total_valid_block_count;
>> -	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
>> -	percpu_counter_set(&sbi->rf_node_block_count, 0);
>> -
>>   	/* Here, we have one bio having CP pack except cp pack 2 page */
>>   	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>>   	/* Wait for all dirty meta pages to be submitted for IO */
>> -- 
>> 2.40.1
>>

