Return-Path: <linux-kernel+bounces-272049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A994563C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD141B22E16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D3717C95;
	Fri,  2 Aug 2024 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OUShvBSY"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EADB67E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 02:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722564604; cv=none; b=s4MbtP5/Dy3AX1ccAr93VjJeQXBxujtpHsWKP7BlkHCbL2Cb0syR6HrSFf7kXDYTh9FI7xFDOsHTM9+XGQ8df9mrd9zWDADCujPuR20IyTXX/UxH6S3Wta6f8J3YfP2EY7MgGdkRIYobAMLbXvXgl3rLStw2mI2KtM3Efr/6zvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722564604; c=relaxed/simple;
	bh=76dudD5b6Lb3j6PBOVkzeU/2fGT22Qcl2jOeZZqA3x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElldLvM8pkgIPJmvGV1p1Py3LvOhbExyHqqt+qQ48InAlxGCutGfvLet1iAfgxmU24scaLBj3Jjo+YLk5NyFtCL03RLMxQZ0gASDZWei4bjl+i7LO5cfj9Me2tFWbsxaIRJgFnkMKlXjqhdbwnVBYN8Dv+xOBFoQoviOiamQGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OUShvBSY; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722564599; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gLurZOJ2zskorg7UXJtTXMjc16vqpy3IgxaglNm6Wwo=;
	b=OUShvBSYxPNzhIl/z+Dow1bLjWhVBXgP1KNQqNDcCyOfEC6BLAwIpoxDhKsmBxNOZU0qSsJmYn1Z78TaMQ1/V9jgvFjUJlI6s+Skv8DX8BlLIyaW33dqJZiJQgWJumro5fiFbFOZNjbo578qcSl7x8ls5gAbAeDeKZTrB9Hy60Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0WBvZjmz_1722564595;
Received: from 30.97.56.76(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WBvZjmz_1722564595)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 10:09:57 +0800
Message-ID: <b31b8638-8def-44a4-8f69-f14117ea6193@linux.alibaba.com>
Date: Fri, 2 Aug 2024 10:09:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: swap: add nr argument in swapcache_prepare and
 swapcache_clear to support large folios
To: Barry Song <21cnbao@gmail.com>, ying.huang@intel.com
Cc: akpm@linux-foundation.org, chrisl@kernel.org, david@redhat.com,
 hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com,
 ryan.roberts@arm.com, senozhatsky@chromium.org, shakeel.butt@linux.dev,
 shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, yosryahmed@google.com
References: <87sevpj6xp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <20240801092014.41549-1-21cnbao@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20240801092014.41549-1-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/1 17:20, Barry Song wrote:
> On Thu, Aug 1, 2024 at 2:50 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>>> On Thu, Aug 1, 2024 at 10:37 AM Huang, Ying <ying.huang@intel.com> wrote:
>>>>
>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>
>>>>> On Thu, Aug 1, 2024 at 9:13 AM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>
>>>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>>>
>>>>>>> On Wed, Jul 31, 2024 at 4:28 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>>
>>>>>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>>>>>
>>>>>>>>> On Wed, Jul 31, 2024 at 4:14 PM Huang, Ying <ying.huang@intel.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi, Barry,
>>>>>>>>>>
>>>>>>>>>> Barry Song <21cnbao@gmail.com> writes:
>>>>>>>>>>
>>>>>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>>>>
>>>>>>>>>>> Right now, swapcache_prepare() and swapcache_clear() supports one entry
>>>>>>>>>>> only, to support large folios, we need to handle multiple swap entries.
>>>>>>>>>>>
>>>>>>>>>>> To optimize stack usage, we iterate twice in __swap_duplicate(): the
>>>>>>>>>>> first time to verify that all entries are valid, and the second time
>>>>>>>>>>> to apply the modifications to the entries.
>>>>>>>>>>>
>>>>>>>>>>> Currently, we're using nr=1 for the existing users.
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>>>>>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>>>>>>>>> ---
>>>>>>>>>>>   include/linux/swap.h |   4 +-
>>>>>>>>>>>   mm/memory.c          |   6 +--
>>>>>>>>>>>   mm/swap.h            |   5 ++-
>>>>>>>>>>>   mm/swap_state.c      |   2 +-
>>>>>>>>>>>   mm/swapfile.c        | 101 +++++++++++++++++++++++++------------------
>>>>>>>>>>>   5 files changed, 68 insertions(+), 50 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>>>>>>>> index ba7ea95d1c57..5b920fa2315b 100644
>>>>>>>>>>> --- a/include/linux/swap.h
>>>>>>>>>>> +++ b/include/linux/swap.h
>>>>>>>>>>> @@ -480,7 +480,7 @@ extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
>>>>>>>>>>>   extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>>>>>>>>>>   extern void swap_shmem_alloc(swp_entry_t);
>>>>>>>>>>>   extern int swap_duplicate(swp_entry_t);
>>>>>>>>>>> -extern int swapcache_prepare(swp_entry_t);
>>>>>>>>>>> +extern int swapcache_prepare(swp_entry_t entry, int nr);
>>>>>>>>>>>   extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>>>>>>>>>>>   extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>>>>>>>>>>   extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>>>>>>>>>>> @@ -554,7 +554,7 @@ static inline int swap_duplicate(swp_entry_t swp)
>>>>>>>>>>>        return 0;
>>>>>>>>>>>   }
>>>>>>>>>>>
>>>>>>>>>>> -static inline int swapcache_prepare(swp_entry_t swp)
>>>>>>>>>>> +static inline int swapcache_prepare(swp_entry_t swp, int nr)
>>>>>>>>>>>   {
>>>>>>>>>>>        return 0;
>>>>>>>>>>>   }
>>>>>>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>>>>>>> index 833d2cad6eb2..b8675617a5e3 100644
>>>>>>>>>>> --- a/mm/memory.c
>>>>>>>>>>> +++ b/mm/memory.c
>>>>>>>>>>> @@ -4081,7 +4081,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>>>>                         * reusing the same entry. It's undetectable as
>>>>>>>>>>>                         * pte_same() returns true due to entry reuse.
>>>>>>>>>>>                         */
>>>>>>>>>>> -                     if (swapcache_prepare(entry)) {
>>>>>>>>>>> +                     if (swapcache_prepare(entry, 1)) {
>>>>>>>>>>>                                /* Relax a bit to prevent rapid repeated page faults */
>>>>>>>>>>>                                schedule_timeout_uninterruptible(1);
>>>>>>>>>>>                                goto out;
>>>>>>>>>>> @@ -4387,7 +4387,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>>>>   out:
>>>>>>>>>>>        /* Clear the swap cache pin for direct swapin after PTL unlock */
>>>>>>>>>>>        if (need_clear_cache)
>>>>>>>>>>> -             swapcache_clear(si, entry);
>>>>>>>>>>> +             swapcache_clear(si, entry, 1);
>>>>>>>>>>>        if (si)
>>>>>>>>>>>                put_swap_device(si);
>>>>>>>>>>>        return ret;
>>>>>>>>>>> @@ -4403,7 +4403,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>>>>>>>                folio_put(swapcache);
>>>>>>>>>>>        }
>>>>>>>>>>>        if (need_clear_cache)
>>>>>>>>>>> -             swapcache_clear(si, entry);
>>>>>>>>>>> +             swapcache_clear(si, entry, 1);
>>>>>>>>>>>        if (si)
>>>>>>>>>>>                put_swap_device(si);
>>>>>>>>>>>        return ret;
>>>>>>>>>>> diff --git a/mm/swap.h b/mm/swap.h
>>>>>>>>>>> index baa1fa946b34..7c6330561d84 100644
>>>>>>>>>>> --- a/mm/swap.h
>>>>>>>>>>> +++ b/mm/swap.h
>>>>>>>>>>> @@ -59,7 +59,7 @@ void __delete_from_swap_cache(struct folio *folio,
>>>>>>>>>>>   void delete_from_swap_cache(struct folio *folio);
>>>>>>>>>>>   void clear_shadow_from_swap_cache(int type, unsigned long begin,
>>>>>>>>>>>                                  unsigned long end);
>>>>>>>>>>> -void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>>>>>>>>>>> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr);
>>>>>>>>>>>   struct folio *swap_cache_get_folio(swp_entry_t entry,
>>>>>>>>>>>                struct vm_area_struct *vma, unsigned long addr);
>>>>>>>>>>>   struct folio *filemap_get_incore_folio(struct address_space *mapping,
>>>>>>>>>>> @@ -120,7 +120,7 @@ static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
>>>>>>>>>>>        return 0;
>>>>>>>>>>>   }
>>>>>>>>>>>
>>>>>>>>>>> -static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
>>>>>>>>>>> +static inline void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry, int nr)
>>>>>>>>>>>   {
>>>>>>>>>>>   }
>>>>>>>>>>>
>>>>>>>>>>> @@ -172,4 +172,5 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
>>>>>>>>>>>        return 0;
>>>>>>>>>>>   }
>>>>>>>>>>>   #endif /* CONFIG_SWAP */
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> NITPICK: Is it necessary to add a blank line here?  But I don't think a
>>>>>>>>>> new version is necessary if this is the only change needed.
>>>>>>>>>
>>>>>>>>> No need to add a blank line; it was probably a mistake I made in Vim.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>   #endif /* _MM_SWAP_H */
>>>>>>>>>>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>>>>>>>>>>> index a1726e49a5eb..b06f2a054f5a 100644
>>>>>>>>>>> --- a/mm/swap_state.c
>>>>>>>>>>> +++ b/mm/swap_state.c
>>>>>>>>>>> @@ -477,7 +477,7 @@ struct folio *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>>>>>>>>>>>                /*
>>>>>>>>>>>                 * Swap entry may have been freed since our caller observed it.
>>>>>>>>>>>                 */
>>>>>>>>>>> -             err = swapcache_prepare(entry);
>>>>>>>>>>> +             err = swapcache_prepare(entry, 1);
>>>>>>>>>>>                if (!err)
>>>>>>>>>>>                        break;
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>>>>>>>>> index 5f73a8553371..757d38a86f56 100644
>>>>>>>>>>> --- a/mm/swapfile.c
>>>>>>>>>>> +++ b/mm/swapfile.c
>>>>>>>>>>> @@ -3363,7 +3363,7 @@ void si_swapinfo(struct sysinfo *val)
>>>>>>>>>>>   }
>>>>>>>>>>>
>>>>>>>>>>>   /*
>>>>>>>>>>> - * Verify that a swap entry is valid and increment its swap map count.
>>>>>>>>>>> + * Verify that nr swap entries are valid and increment their swap map counts.
>>>>>>>>>>>    *
>>>>>>>>>>>    * Returns error code in following case.
>>>>>>>>>>>    * - success -> 0
>>>>>>>>>>> @@ -3373,60 +3373,77 @@ void si_swapinfo(struct sysinfo *val)
>>>>>>>>>>>    * - swap-cache reference is requested but the entry is not used. -> ENOENT
>>>>>>>>>>>    * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
>>>>>>>>>>>    */
>>>>>>>>>>> -static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>>>>>>>>>>> +static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>>>>>>>>>>>   {
>>>>>>>>>>>        struct swap_info_struct *p;
>>>>>>>>>>>        struct swap_cluster_info *ci;
>>>>>>>>>>>        unsigned long offset;
>>>>>>>>>>>        unsigned char count;
>>>>>>>>>>>        unsigned char has_cache;
>>>>>>>>>>> -     int err;
>>>>>>>>>>> +     int err, i;
>>>>>>>>>>>
>>>>>>>>>>>        p = swp_swap_info(entry);
>>>>>>>>>>>
>>>>>>>>>>>        offset = swp_offset(entry);
>>>>>>>>>>> +     VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
>>>>>>>>>>>        ci = lock_cluster_or_swap_info(p, offset);
>>>>>>>>>>>
>>>>>>>>>>> -     count = p->swap_map[offset];
>>>>>>>>>>> +     err = 0;
>>>>>>>>>>> +     for (i = 0; i < nr; i++) {
>>>>>>>>>>> +             count = p->swap_map[offset + i];
>>>>>>>>>>>
>>>>>>>>>>> -     /*
>>>>>>>>>>> -      * swapin_readahead() doesn't check if a swap entry is valid, so the
>>>>>>>>>>> -      * swap entry could be SWAP_MAP_BAD. Check here with lock held.
>>>>>>>>>>> -      */
>>>>>>>>>>> -     if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
>>>>>>>>>>> -             err = -ENOENT;
>>>>>>>>>>> -             goto unlock_out;
>>>>>>>>>>> -     }
>>>>>>>>>>> +             /*
>>>>>>>>>>> +              * swapin_readahead() doesn't check if a swap entry is valid, so the
>>>>>>>>>>> +              * swap entry could be SWAP_MAP_BAD. Check here with lock held.
>>>>>>>>>>> +              */
>>>>>>>>>>> +             if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
>>>>>>>>>>> +                     err = -ENOENT;
>>>>>>>>>>> +                     goto unlock_out;
>>>>>>>>>>> +             }
>>>>>>>>>>>
>>>>>>>>>>> -     has_cache = count & SWAP_HAS_CACHE;
>>>>>>>>>>> -     count &= ~SWAP_HAS_CACHE;
>>>>>>>>>>> -     err = 0;
>>>>>>>>>>> +             has_cache = count & SWAP_HAS_CACHE;
>>>>>>>>>>> +             count &= ~SWAP_HAS_CACHE;
>>>>>>>>>>>
>>>>>>>>>>> -     if (usage == SWAP_HAS_CACHE) {
>>>>>>>>>>> +             if (usage == SWAP_HAS_CACHE) {
>>>>>>>>>>> +                     /* set SWAP_HAS_CACHE if there is no cache and entry is used */
>>>>>>>>>>> +                     if (!has_cache && count)
>>>>>>>>>>> +                             continue;
>>>>>>>>>>> +                     else if (has_cache)             /* someone else added cache */
>>>>>>>>>>> +                             err = -EEXIST;
>>>>>>>>>>> +                     else                            /* no users remaining */
>>>>>>>>>>> +                             err = -ENOENT;
>>>>>>>>>>>
>>>>>>>>>>> -             /* set SWAP_HAS_CACHE if there is no cache and entry is used */
>>>>>>>>>>> -             if (!has_cache && count)
>>>>>>>>>>> -                     has_cache = SWAP_HAS_CACHE;
>>>>>>>>>>> -             else if (has_cache)             /* someone else added cache */
>>>>>>>>>>> -                     err = -EEXIST;
>>>>>>>>>>> -             else                            /* no users remaining */
>>>>>>>>>>> -                     err = -ENOENT;
>>>>>>>>>>> +             } else if (count || has_cache) {
>>>>>>>>>>>
>>>>>>>>>>> -     } else if (count || has_cache) {
>>>>>>>>>>> +                     if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>>>>>>>>>>> +                             continue;
>>>>>>>>>>> +                     else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
>>>>>>>>>>> +                             err = -EINVAL;
>>>>>>>>>>> +                     else if (swap_count_continued(p, offset + i, count))
>>>>>>>>>>> +                             continue;
>>>>>>>>>>
>>>>>>>>>> IIUC, this will make the change to swap map directly instead of
>>>>>>>>>> verification.  If the verification failed for some entry later, the
>>>>>>>>>> count will be wrong?  Or I missed something?
>>>>>>>>>
>>>>>>>>> To avoid using a bitmap or a larger stack, we actually verify during
>>>>>>>>> the first iteration.
>>>>>>>>> This ensures that by the second iteration, we can safely commit the
>>>>>>>>> modification.
>>>>>>>>>
>>>>>>>>> I actually put some words in the changelog :-)
>>>>>>>>>
>>>>>>>>> To optimize stack usage, we iterate twice in __swap_duplicate(): the
>>>>>>>>> first time to verify that all entries are valid, and the second time
>>>>>>>>> to apply the modifications to the entries.
>>>>>>>>
>>>>>>>> Yes, I have seen it and I think that it is a good strategy.
>>>>>>>>
>>>>>>>> But, IIUC, swap_count_continued() will change the higher bits of the
>>>>>>>> swap_map instead of verifying.  Or, my understanding is wrong?
>>>>>>>>
>>>>>>>
>>>>>>> Ying, your understanding is 100% correct. but the code also has nothing
>>>>>>> broken. we didn't extend swap_duplicate() to have argument nr,
>>>>>>> so all users which can set usage=1 will definitely have nr=1.
>>>>>>>
>>>>>>> int swap_duplicate(swp_entry_t entry)
>>>>>>> {
>>>>>>>          int err = 0;
>>>>>>>
>>>>>>>          while (!err && __swap_duplicate(entry, 1, 1) == -ENOMEM)
>>>>>>>                  err = add_swap_count_continuation(entry, GFP_ATOMIC);
>>>>>>>          return err;
>>>>>>> }
>>>>>>
>>>>>> I understand that we don't have requirements to support "usage == 1 &&
>>>>>> nr > 1" case for __swap_duplicate() at least for now.
>>>>>>
>>>>>>> Maybe I can add a VM_WARN_ON to warn those people who might
>>>>>>> want to extend swap_duplicate()? in that case, things could be quite
>>>>>>> tricky.
>>>>>>>
>>>>>>> --- a/mm/swapfile.c
>>>>>>> +++ b/mm/swapfile.c
>>>>>>> @@ -3386,6 +3386,7 @@ static int __swap_duplicate(swp_entry_t entry,
>>>>>>> unsigned char usage, int nr)
>>>>>>>
>>>>>>>          offset = swp_offset(entry);
>>>>>>>          VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
>>>>>>> +       VM_WARN_ON(usage == 1 && nr > 1);
>>>>>>>          ci = lock_cluster_or_swap_info(p, offset);
>>>>>>>
>>>>>>>          err = 0;
>>>>>>
>>>>>> Please add this.  And, I think that we need to make it explicit in patch
>>>>>> description and comments to avoid potential confusing.
>>>>>
>>>>> cool. make sense to me. I will post something for Andrew to squash into.
>>>>>
>>>>>>
>>>>>> And, because it's hard to implement the verify and change strategy if
>>>>>> "usage == 1".  Can we only use that strategy for "usage ==
>>>>>> SWAP_HAS_CACHE"?
>>>>>
>>>>> I believe Baolin also needs the case for shmem. I don't feel a strong
>>>>> need to split two logics(1 and non-1) as the code will be quite ugly :-)
>>>>
>>>> Don't need to split like that, it could be something like
>>>>
>>>>          for (i = 0; i < nr; i++) {
>>>>                  if (usage == SWAP_HAS_CACHE) {
>>>>                          /* Only verify for SWAP_HAS_CACHE */
>>>>                  }
>>>>          }
>>>>
>>>>          for (i = 0; i < nr; i++) {
>>>>                  if (usage == SWAP_HAS_CACHE) {
>>>>                  } else {
>>>>                          /* Verify and change for usage == 1 */
>>>>                  }
>>>>          }
>>>>
>>>
>>> but we also have cases where nr can be > 1
>>>          __swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
>>
>> If we can do verification for "usage == SWAP_MAP_SHMEM", we can add that
>> in the first loop.
>>
>> That is, we only do verification in the first loop, not do committing.
>> In the second loop, we can ignore verifying if we have done that in the
>> first loop.
>>
>> IMHO, this make code easier to be understood.
> 
> Right. I believe the change below can help improve readability and also
> clarify the swap_count_continued() case.
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2fa29bdec171..75a89ce18edc 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3538,6 +3538,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>   
>   	offset = swp_offset(entry);
>   	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
> +	VM_WARN_ON(usage == 1 && nr > 1);
>   	ci = lock_cluster_or_swap_info(p, offset);
>   
>   	err = 0;
> @@ -3564,17 +3565,9 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>   				err = -EEXIST;
>   			else				/* no users remaining */
>   				err = -ENOENT;
> -
>   		} else if (count || has_cache) {
> -
> -			if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> -				continue;
> -			else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> +			if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
>   				err = -EINVAL;
> -			else if (swap_count_continued(p, offset + i, count))
> -				continue;
> -			else
> -				err = -ENOMEM;
>   		} else
>   			err = -ENOENT;			/* unused swap entry */
>   
> @@ -3591,8 +3584,12 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
>   			has_cache = SWAP_HAS_CACHE;
>   		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
>   			count += usage;
> -		else
> +		else if (swap_count_continued(p, offset + i, count))
>   			count = COUNT_CONTINUED;
> +		else {
> +			err = -ENOMEM;
> +			goto unlock_out;
> +		}
>   
>   		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
>   	}
> 
> This makes the two iterations become:
> 
> 	for (i = 0; i < nr; i++) {
> 		count = p->swap_map[offset + i];
> 
> 		/*
> 		 * swapin_readahead() doesn't check if a swap entry is valid, so the
> 		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
> 		 */
> 		if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
> 			err = -ENOENT;
> 			goto unlock_out;
> 		}
> 
> 		has_cache = count & SWAP_HAS_CACHE;
> 		count &= ~SWAP_HAS_CACHE;
> 
> 		if (usage == SWAP_HAS_CACHE) {
> 			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
> 			if (!has_cache && count)
> 				continue;
> 			else if (has_cache)		/* someone else added cache */
> 				err = -EEXIST;
> 			else				/* no users remaining */
> 				err = -ENOENT;
> 		} else if (count || has_cache) {
> 			if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
> 				err = -EINVAL;
> 		} else
> 			err = -ENOENT;			/* unused swap entry */
> 
> 		if (err)
> 			goto unlock_out;
> 	}
> 
> 	for (i = 0; i < nr; i++) {
> 		count = p->swap_map[offset + i];
> 		has_cache = count & SWAP_HAS_CACHE;
> 		count &= ~SWAP_HAS_CACHE;
> 
> 		if (usage == SWAP_HAS_CACHE)
> 			has_cache = SWAP_HAS_CACHE;
> 		else if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
> 			count += usage;
> 		else if (swap_count_continued(p, offset + i, count))
> 			count = COUNT_CONTINUED;
> 		else {
> 			err = -ENOMEM;
> 			goto unlock_out;
> 		}
> 
> 		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
> 	}
> 
> Ying, do you feel more satisfied with the version above
> compared to the code in mm-unstable?
> 
> Baolin, I'd also appreciate it if you could re-test your
> shmem case if Ying is okay with the enhancement above.

Sure. I tested it with my shmem swap patches, and it still works as 
expected. Thanks.

