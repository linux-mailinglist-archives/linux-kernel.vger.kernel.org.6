Return-Path: <linux-kernel+bounces-306896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A094E964525
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC433B275DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0CF1AD9FA;
	Thu, 29 Aug 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LGBNMBF+"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90B19E806
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935276; cv=none; b=oDr74Ki5yFLjTQ53Dn+X2qUGvQZv6cahdZ9GeFTrknkHropuroWkyd1dBUKT0edeq/pGPvK9hJ0ZvpMvJ/YXLw39w36mTRr7qzz/xxj8zvgqTsp/2tEa0uLlISgggF5GLr5q3tBA+srijMm6vFpg31wIf/pY/Il7lDVO7d4Yk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935276; c=relaxed/simple;
	bh=oEt6/1/2dTYTT38BTVtY63MzsRFx1ivEXxQ6wx1zG3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSZF+vISzXJih7wSqV6X7xMfkqpZv7DPTB90DLt6lhu9sg5uGw8nsYgF/T4n+8ls4UfuYROJMpFM4UZAyO/mNksbMptGr1MUaXwJyk3Zmlm6DlpvHBA+yQ3P97JnAWI/+BVtUjg0xEx1IAk+HCUv2+1ytml4ReADWKQkSopUtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LGBNMBF+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724935265; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nAudkI0+JvHhkm0M7Sh7ypY6bb03Eg6fINXHetDbltY=;
	b=LGBNMBF+XmyM2uLLNjwY3hY3ZTAPAA8poeCrYRRWR7B/023YzeWDd2jct2YVcy4wUE9+X4boNh9tIbH8SEChs5KqUYZ8G18eB8QdeAvZ9fJ/6rCfOnR6rzHHhw4yko626e6b+3qMiv+BhG33kBOfqCMFFHX6JnnK5VRamCBm0Sg=
Received: from 30.15.214.20(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDt43.n_1724935261)
          by smtp.aliyun-inc.com;
          Thu, 29 Aug 2024 20:41:03 +0800
Message-ID: <3c7e4800-ec9c-4288-85bf-89f3fef18827@linux.alibaba.com>
Date: Thu, 29 Aug 2024 20:40:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/9] mm: filemap: use xa_get_order() to get the swap
 entry order
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
 chrisl@kernel.org, ying.huang@intel.com, 21cnbao@gmail.com,
 ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
 ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
 <6876d55145c1cc80e79df7884aa3a62e397b101d.1723434324.git.baolin.wang@linux.alibaba.com>
 <d3dc75e2-40a7-8439-734c-19d83707164c@google.com>
 <3c020874-4cf3-418c-b89b-4e6ed158e5b9@linux.alibaba.com>
 <c336e6e4-da7f-b714-c0f1-12df715f2611@google.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <c336e6e4-da7f-b714-c0f1-12df715f2611@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/29 16:07, Hugh Dickins wrote:
> On Tue, 27 Aug 2024, Baolin Wang wrote:
>> On 2024/8/26 05:55, Hugh Dickins wrote:
>>> On Mon, 12 Aug 2024, Baolin Wang wrote:
>>>
>>>> In the following patches, shmem will support the swap out of large folios,
>>>> which means the shmem mappings may contain large order swap entries, so
>>>> using xa_get_order() to get the folio order of the shmem swap entry to
>>>> update the '*start' correctly.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/filemap.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 4130be74f6fd..4c312aab8b1f 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -2056,6 +2056,8 @@ unsigned find_get_entries(struct address_space
>>>> *mapping, pgoff_t *start,
>>>>      folio = fbatch->folios[idx];
>>>>      if (!xa_is_value(folio))
>>>>    			nr = folio_nr_pages(folio);
>>>> +		else
>>>> +			nr = 1 << xa_get_order(&mapping->i_pages,
>>>> indices[idx]);
>>>>     	*start = indices[idx] + nr;
>>>>     }
>>>>     return folio_batch_count(fbatch);
>>>> @@ -2120,6 +2122,8 @@ unsigned find_lock_entries(struct address_space
>>>> *mapping, pgoff_t *start,
>>>>      folio = fbatch->folios[idx];
>>>>      if (!xa_is_value(folio))
>>>>    			nr = folio_nr_pages(folio);
>>>> +		else
>>>> +			nr = 1 << xa_get_order(&mapping->i_pages,
>>>> indices[idx]);
>>>>     	*start = indices[idx] + nr;
>>>>     }
>>>>     return folio_batch_count(fbatch);
>>>> -- 
>>>
>>> Here we have a problem, but I'm not suggesting a fix for it yet: I
>>> need to get other fixes out first, then turn to thinking about this -
>>> it's not easy.
>>
>> Thanks for raising the issues.
>>
>>>
>>> That code is almost always right, so it works well enough for most
>>> people not to have noticed, but there are two issues with it.
>>>
>>> The first issue is that it's assuming indices[idx] is already aligned
>>> to nr: not necessarily so.  I believe it was already wrong in the
>>> folio_nr_pages() case, but the time I caught it wrong with a printk
>>> was in the swap (value) case.  (I may not be stating this correctly:
>>> again more thought needed but I can't spend so long writing.)
>>>
>>> And immediately afterwards that kernel build failed with a corrupted
>>> (all 0s) .o file - I'm building on ext4 on /dev/loop0 on huge tmpfs while
>>> swapping, and happen to be using the "-o discard" option to ext4 mount.
>>>
>>> I've been chasing these failures (maybe a few minutes in, maybe half an
>>> hour) for days, then had the idea of trying without the "-o discard":
>>> whereupon these builds can be repeated successfully for many hours.
>>> IIRC ext4 discard to /dev/loop0 entails hole-punch to the tmpfs.
>>>
>>> The alignment issue can easily be corrected, but that might not help.
>>> (And those two functions would look better with the rcu_read_unlock()
>>> moved down to just before returning: but again, wouldn't really help.)
>>>
>>> The second issue is that swap is more slippery to work with than
>>> folios or pages: in the folio_nr_pages() case, that number is stable
>>> because we hold a refcount (which stops a THP from being split), and
>>> later we'll be taking folio lock too.  None of that in the swap case,
>>> so (depending on how a large entry gets split) the xa_get_order() result
>>> is not reliable. Likewise for other uses of xa_get_order() in this series.
>>
>> Now we have 2 users of xa_get_order() in this series:
>>
>> 1) shmem_partial_swap_usage(): this is acceptable, since racy results are not
>> a problem for the swap statistics.
> 
> Yes: there might be room for improvement, but no big deal there.
> 
>>
>> 2) shmem_undo_range(): when freeing a large swap entry, it will use
>> xa_cmpxchg_irq() to make sure the swap value is not changed (in case the large
>> swap entry is split). If failed to cmpxchg, then it will use current index to
>> retry in shmem_undo_range(). So seems not too bad?
> 
> Right, I was missing the cmpxchg aspect. I am not entirely convinced of
> the safety in proceeding in this way, but I shouldn't spread FUD without
> justification. Today, no yesterday, I realized what might be the actual
> problem, and it's not at all these entry splitting races I had suspected.
> 
> Fix below.  Successful testing on mm-everything-2024-08-24-07-21 (well,
> that minus the commit which spewed warnings from bootup) confirmed it.
> But testing on mm-everything-2024-08-28-21-38 very quickly failed:
> unrelated to this series, presumably caused by patch or patches added
> since 08-24, one kind of crash on one machine (some memcg thing called
> from isolate_migratepages_block), another kind of crash on another (some
> memcg thing called from __read_swap_cache_async), I'm exhausted by now
> but will investigate later in the day (or hope someone else has).

I saw the isolate_migratepages_block crash issue on 
mm-everything-2024-08-28-09-32, and I reverted Kefeng's series "[PATCH 
0/4] mm: convert to folio_isolate_movable()", the 
isolate_migratepages_block issue seems to be resolved (at least I can 
not reproduce it).

And I have already pointed out some potential issues in Kefeng’s 
series[1]. Andrew has dropped this series from 
mm-everything-2024-08-28-21-38. However, you can still encounter the 
isolate_migratepages_block issue on mm-everything-2024-08-28-21-38, 
while I cannot, weird.

[1] 
https://lore.kernel.org/all/3f8300d9-1c21-46ad-a311-e97dc94eda08@linux.alibaba.com/

[  337.999054] page: refcount:0 mapcount:0 mapping:0000000000000000 
index:0x3bbda pfn:0xf09041
[  337.999065] memcg:ffff0000c642f000
[  337.999066] anon flags: 
0x17fffe0000020808(uptodate|owner_2|swapbacked|node=0|zone=2|lastcpupid=0x3ffff)
[  337.999071] raw: 17fffe0000020808 dead000000000100 dead000000000122 
ffff00047c6537b9
[  337.999073] raw: 000000000003bbda 0000000000000000 00000000ffffffff 
ffff0000c642f000
[  337.999074] page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) 
== 0)
[  337.999082] ------------[ cut here ]------------
[  337.999083] kernel BUG at include/linux/mm.h:1126!
[  337.999384] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[  338.002828] CPU: 31 UID: 0 PID: 87531 Comm: transhuge-stres Kdump: 
loaded Tainted: G            E      6.11.0-rc4+ #830
[  338.003372] Tainted: [E]=UNSIGNED_MODULE
[  338.003570] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS 
1.0.0 01/01/2017
[  338.003939] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS 
BTYPE=--)
[  338.004282] pc : isolate_migratepages_block+0xb84/0x1000
[  338.004553] lr : isolate_migratepages_block+0xb84/0x1000
[  338.004817] sp : ffff8000a730b5d0
[......]
[  338.008538] Call trace:
[  338.008661]  isolate_migratepages_block+0xb84/0x1000
[  338.008910]  isolate_migratepages+0x118/0x330
[  338.009127]  compact_zone+0x2c8/0x640
[  338.009311]  compact_zone_order+0xbc/0x110
[  338.009516]  try_to_compact_pages+0xf8/0x368
[  338.009730]  __alloc_pages_direct_compact+0x8c/0x260
[  338.010002]  __alloc_pages_slowpath.constprop.0+0x388/0x900
[  338.010279]  __alloc_pages_noprof+0x1f8/0x270
[  338.010497]  alloc_pages_mpol_noprof+0x8c/0x210
[  338.010724]  folio_alloc_mpol_noprof+0x18/0x68
[  338.010945]  vma_alloc_folio_noprof+0x7c/0xd0
[  338.011162]  do_huge_pmd_anonymous_page+0xe0/0x3b0
[  338.011401]  __handle_mm_fault+0x428/0x440
[  338.011606]  handle_mm_fault+0x68/0x210

> [PATCH] mm: filemap: use xa_get_order() to get the swap entry order: fix
> 
> find_lock_entries(), used in the first pass of shmem_undo_range() and
> truncate_inode_pages_range() before partial folios are dealt with, has
> to be careful to avoid those partial folios: as its doc helpfully says,
> "Folios which are partially outside the range are not returned".  Of
> course, the same must be true of any value entries returned, otherwise
> truncation and hole-punch risk erasing swapped areas - as has been seen.
> 
> Rewrite find_lock_entries() to emphasize that, following the same pattern
> for folios and for value entries.
> 
> Adjust find_get_entries() slightly, to get order while still holding
> rcu_read_lock(), and to round down the updated start: good changes, like
> find_lock_entries() now does, but it's unclear if either is ever important.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks Hugh. The changes make sense to me.

> ---
>   mm/filemap.c | 41 +++++++++++++++++++++++++----------------
>   1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 885a8ed9d00d..88a2ed008474 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2047,10 +2047,9 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>   		if (!folio_batch_add(fbatch, folio))
>   			break;
>   	}
> -	rcu_read_unlock();
>   
>   	if (folio_batch_count(fbatch)) {
> -		unsigned long nr = 1;
> +		unsigned long nr;
>   		int idx = folio_batch_count(fbatch) - 1;
>   
>   		folio = fbatch->folios[idx];
> @@ -2058,8 +2057,10 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
>   			nr = folio_nr_pages(folio);
>   		else
>   			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
> -		*start = indices[idx] + nr;
> +		*start = round_down(indices[idx] + nr, nr);
>   	}
> +	rcu_read_unlock();
> +
>   	return folio_batch_count(fbatch);
>   }
>   
> @@ -2091,10 +2092,17 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>   
>   	rcu_read_lock();
>   	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
> +		unsigned long base;
> +		unsigned long nr;
> +
>   		if (!xa_is_value(folio)) {
> -			if (folio->index < *start)
> +			nr = folio_nr_pages(folio);
> +			base = folio->index;
> +			/* Omit large folio which begins before the start */
> +			if (base < *start)
>   				goto put;
> -			if (folio_next_index(folio) - 1 > end)
> +			/* Omit large folio which extends beyond the end */
> +			if (base + nr - 1 > end)
>   				goto put;
>   			if (!folio_trylock(folio))
>   				goto put;
> @@ -2103,7 +2111,19 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>   				goto unlock;
>   			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
>   					folio);
> +		} else {
> +			nr = 1 << xa_get_order(&mapping->i_pages, xas.xa_index);
> +			base = xas.xa_index & ~(nr - 1);
> +			/* Omit order>0 value which begins before the start */
> +			if (base < *start)
> +				continue;
> +			/* Omit order>0 value which extends beyond the end */
> +			if (base + nr - 1 > end)
> +				break;
>   		}
> +
> +		/* Update start now so that last update is correct on return */
> +		*start = base + nr;
>   		indices[fbatch->nr] = xas.xa_index;
>   		if (!folio_batch_add(fbatch, folio))
>   			break;
> @@ -2115,17 +2135,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
>   	}
>   	rcu_read_unlock();
>   
> -	if (folio_batch_count(fbatch)) {
> -		unsigned long nr = 1;
> -		int idx = folio_batch_count(fbatch) - 1;
> -
> -		folio = fbatch->folios[idx];
> -		if (!xa_is_value(folio))
> -			nr = folio_nr_pages(folio);
> -		else
> -			nr = 1 << xa_get_order(&mapping->i_pages, indices[idx]);
> -		*start = indices[idx] + nr;
> -	}
>   	return folio_batch_count(fbatch);
>   }
>   

