Return-Path: <linux-kernel+bounces-264980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47D93EACC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE48B20CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3841C6A;
	Mon, 29 Jul 2024 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R0ACaJE8"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AA14293
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218295; cv=none; b=IRk/u6eU4KIrlITXw8rhLQhF9Nh7uJf+S2vaEH4TVMY/G7g20YVPqBrZescaEQpaTJUnyfXeOrP1dxLmR2LjJUJsc0R8Om/fjydf8ukB7ErcYB6bHgmcXl3X37WFdOfRmptg18BMaD+T5WB4m8Lunh6+ZMvreIsjSbKdDX4JC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218295; c=relaxed/simple;
	bh=gz5caAAmZ9LsCOQGBh4VhKqiF50JS/7RKc2s2zmQa0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxoL6m/VLS2cE8+XmHthaxN0pN5vwuqJFxpNDkZf2eAirpnvDBXRLSak7Jclx5L89/iNwXfPrQsFhCVUlSDu/SWN7GELQzqY9Bnm7Itta53YjpgPUHXIggBAzSqJEMTOk35MjhY3zdQw0abEILkbjPiXHFETQUMEs7UREWCRupI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R0ACaJE8; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722218284; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NPs32fx1nWtLVVkhAFV5Sj0qrMlLQyRD5CLhhDczwDI=;
	b=R0ACaJE8KuS3xIdIh3tjn4Ix5IjxUnItcmYNC/mrks7sVVL0zf1ubVtCcxoJj4M0b2WCnk7wmvZsqL6Mp6wVxJer42uJU/XbL4pIi0lIMSlcU95Mke1T2utEcxooFqwgZqak3KpxxMmiYHfsTrIjTUkXLrnIqO0sdDO6ddheTb4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0WBSYqdD_1722218282;
Received: from 30.97.48.242(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WBSYqdD_1722218282)
          by smtp.aliyun-inc.com;
          Mon, 29 Jul 2024 09:58:04 +0800
Message-ID: <d93b06a5-20f2-41bd-a7f5-d06906d88ba4@linux.alibaba.com>
Date: Mon, 29 Jul 2024 09:58:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
 <87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <87plqx0yh2.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ying,

On 2024/7/29 09:38, Huang, Ying wrote:
> Hi, Xiang,
> 
> Gao Xiang <hsiangkao@linux.alibaba.com> writes:
> 
>> Currently, migrate_pages_batch() can lock multiple locked folios
>> with an arbitrary order.  Although folio_trylock() is used to avoid
>> deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
>> asynchronously firstly") mentioned, it seems try_split_folio() is
>> still missing.
>>
>> It was found by compaction stress test when I explicitly enable EROFS
>> compressed files to use large folios, which case I cannot reproduce with
>> the same workload if large folio support is off (current mainline).
>> Typically, filesystem reads (with locked file-backed folios) could use
>> another bdev/meta inode to load some other I/Os (e.g. inode extent
>> metadata or caching compressed data), so the locking order will be:
>>
>>    file-backed folios  (A)
>>       bdev/meta folios (B)
>>
>> The following calltrace shows the deadlock:
>>     Thread 1 takes (B) lock and tries to take folio (A) lock
>>     Thread 2 takes (A) lock and tries to take folio (B) lock
>>
>> [Thread 1]
>> INFO: task stress:1824 blocked for more than 30 seconds.
>>        Tainted: G           OE      6.10.0-rc7+ #6
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:stress          state:D stack:0     pid:1824  tgid:1824  ppid:1822   flags:0x0000000c
>> Call trace:
>>   __switch_to+0xec/0x138
>>   __schedule+0x43c/0xcb0
>>   schedule+0x54/0x198
>>   io_schedule+0x44/0x70
>>   folio_wait_bit_common+0x184/0x3f8
>> 			<-- folio mapping ffff00036d69cb18 index 996  (**)
>>   __folio_lock+0x24/0x38
>>   migrate_pages_batch+0x77c/0xea0	// try_split_folio (mm/migrate.c:1486:2)
>> 						// migrate_pages_batch (mm/migrate.c:1734:16)
>> 		<--- LIST_HEAD(unmap_folios) has
>> 			..
>> 			folio mapping 0xffff0000d184f1d8 index 1711;   (*)
>> 			folio mapping 0xffff0000d184f1d8 index 1712;
>> 			..
>>   migrate_pages+0xb28/0xe90
>>   compact_zone+0xa08/0x10f0
>>   compact_node+0x9c/0x180
>>   sysctl_compaction_handler+0x8c/0x118
>>   proc_sys_call_handler+0x1a8/0x280
>>   proc_sys_write+0x1c/0x30
>>   vfs_write+0x240/0x380
>>   ksys_write+0x78/0x118
>>   __arm64_sys_write+0x24/0x38
>>   invoke_syscall+0x78/0x108
>>   el0_svc_common.constprop.0+0x48/0xf0
>>   do_el0_svc+0x24/0x38
>>   el0_svc+0x3c/0x148
>>   el0t_64_sync_handler+0x100/0x130
>>   el0t_64_sync+0x190/0x198
>>
>> [Thread 2]
>> INFO: task stress:1825 blocked for more than 30 seconds.
>>        Tainted: G           OE      6.10.0-rc7+ #6
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:stress          state:D stack:0     pid:1825  tgid:1825  ppid:1822   flags:0x0000000c
>> Call trace:
>>   __switch_to+0xec/0x138
>>   __schedule+0x43c/0xcb0
>>   schedule+0x54/0x198
>>   io_schedule+0x44/0x70
>>   folio_wait_bit_common+0x184/0x3f8
>> 			<-- folio = 0xfffffdffc6b503c0 (mapping == 0xffff0000d184f1d8 index == 1711) (*)
>>   __folio_lock+0x24/0x38
>>   z_erofs_runqueue+0x384/0x9c0 [erofs]
>>   z_erofs_readahead+0x21c/0x350 [erofs]       <-- folio mapping 0xffff00036d69cb18 range from [992, 1024] (**)
>>   read_pages+0x74/0x328
>>   page_cache_ra_order+0x26c/0x348
>>   ondemand_readahead+0x1c0/0x3a0
>>   page_cache_sync_ra+0x9c/0xc0
>>   filemap_get_pages+0xc4/0x708
>>   filemap_read+0x104/0x3a8
>>   generic_file_read_iter+0x4c/0x150
>>   vfs_read+0x27c/0x330
>>   ksys_pread64+0x84/0xd0
>>   __arm64_sys_pread64+0x28/0x40
>>   invoke_syscall+0x78/0x108
>>   el0_svc_common.constprop.0+0x48/0xf0
>>   do_el0_svc+0x24/0x38
>>   el0_svc+0x3c/0x148
>>   el0t_64_sync_handler+0x100/0x130
>>   el0t_64_sync+0x190/0x198
>>
>> Fixes: 5dfab109d519 ("migrate_pages: batch _unmap and _move")
>> Cc: "Huang, Ying" <ying.huang@intel.com>
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>>   mm/migrate.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 20cb9f5f7446..a912e4b83228 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1483,7 +1483,8 @@ static inline int try_split_folio(struct folio *folio, struct list_head *split_f
>>   {
>>   	int rc;
>>   
>> -	folio_lock(folio);
>> +	if (!folio_trylock(folio))
>> +		return -EAGAIN;
>>   	rc = split_folio_to_list(folio, split_folios);
>>   	folio_unlock(folio);
>>   	if (!rc)
> 
> Good catch!  Thanks for the fixing!
> 
> The deadlock is similar as the one we fixed in commit fb3592c41a44
> ("migrate_pages: fix deadlock in batched migration").  But apparently,
> we missed this case.
> 
> For the fix, I think that we should still respect migrate_mode because
> users may prefer migration success over blocking.
> 
> @@ -1492,11 +1492,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
>   	return rc;
>   }
>   
> -static inline int try_split_folio(struct folio *folio, struct list_head *split_folios)
> +static inline int try_split_folio(struct folio *folio, struct list_head *split_folios,
> +				  enum migrate_mode mode)
>   {
>   	int rc;
>   
> -	folio_lock(folio);
> +	if (mode == MIGRATE_ASYNC) {
> +		if (!folio_trylock(folio))
> +			return -EAGAIN;
> +	} else {
> +		folio_lock(folio);
> +	}
>   	rc = split_folio_to_list(folio, split_folios);
>   	folio_unlock(folio);
>   	if (!rc)

Okay, yeah it looks better since it seems I missed the fallback
part in migrate_pages_sync().

Let me send the next version to follow your advice, thanks.

Thanks,
Gao Xiang


> 
> 
> --
> Best Regards,
> Huang, Ying

