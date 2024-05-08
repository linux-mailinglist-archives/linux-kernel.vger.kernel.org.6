Return-Path: <linux-kernel+bounces-172956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D48BF94E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B001F22BD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DA17317D;
	Wed,  8 May 2024 09:10:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76F31757D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 09:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159450; cv=none; b=fbv5UYcuw4q2yimpPDalA6g93wAQ5CPq07mJCEdBVOKtN9igIXUiqFJZKLnzbYeDtq3yjbSsNzdr9W8ySm0EplgOloZwf+nCLxWhL40stWZVbmU8fWYVfT0XDpxqhbG6P2jB2DYcriOyW/+mDQhCG8/PTD9mWtCJAT166QyzzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159450; c=relaxed/simple;
	bh=TIKXuxkFbajXHU0DbcNWi0KX4ac7q9dNl79cnrpfvz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tSKsjd0DRNa7DvP/fs+Abkm6bj+44E1LdApgW9AlDrARiiKp82dC3/+XH33KJzGp51OJIqCK7iq+RS+fypegj43A8jsCtlimv3rvBbwPMtjUCIR0cDuzD4ylFwsbIUn/CbsbWcJkG7XZ9f5+wDNRAOByecPjSynY9i7v5tCv0q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9F111063;
	Wed,  8 May 2024 02:11:13 -0700 (PDT)
Received: from [10.57.67.194] (unknown [10.57.67.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D6DE3F6A8;
	Wed,  8 May 2024 02:10:45 -0700 (PDT)
Message-ID: <b8a23754-61cd-4d3f-9fec-a92e68c9f972@arm.com>
Date: Wed, 8 May 2024 10:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] mm: remove swap_free() and always use
 swap_free_nr()
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, "Huang, Ying" <ying.huang@intel.com>,
 Christoph Hellwig <hch@infradead.org>, chrisl@kernel.org
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, david@redhat.com, hanchuanhua@oppo.com,
 hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com,
 willy@infradead.org, xiang@kernel.org, yosryahmed@google.com,
 yuzhao@google.com, ziy@nvidia.com, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-3-21cnbao@gmail.com>
 <e0c1cbb2-da06-4658-a23a-962496e83557@arm.com>
 <87y18kivny.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wnS8-vjVx4uuKwQ_=Y4g8EN58QJZ=cXR=cmuX1ZE84RA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wnS8-vjVx4uuKwQ_=Y4g8EN58QJZ=cXR=cmuX1ZE84RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/05/2024 09:30, Barry Song wrote:
> On Wed, May 8, 2024 at 7:58 PM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>
>>> On 03/05/2024 01:50, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> To streamline maintenance efforts, we propose discontinuing the use of
>>>> swap_free(). Instead, we can simply invoke swap_free_nr() with nr set
>>>> to 1. This adjustment offers the advantage of enabling batch processing
>>>> within kernel/power/swap.c. Furthermore, swap_free_nr() is designed with
>>>> a bitmap consisting of only one long, resulting in overhead that can be
>>>> ignored for cases where nr equals 1.
>>>>
>>>> Suggested-by: "Huang, Ying" <ying.huang@intel.com>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>>> Cc: Pavel Machek <pavel@ucw.cz>
>>>> Cc: Len Brown <len.brown@intel.com>
>>>> Cc: Hugh Dickins <hughd@google.com>
>>>> ---
>>>>  include/linux/swap.h |  5 -----
>>>>  kernel/power/swap.c  |  7 +++----
>>>>  mm/memory.c          |  2 +-
>>>>  mm/rmap.c            |  4 ++--
>>>>  mm/shmem.c           |  4 ++--
>>>>  mm/swapfile.c        | 19 +++++--------------
>>>>  6 files changed, 13 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>> index d1d35e92d7e9..f03cb446124e 100644
>>>> --- a/include/linux/swap.h
>>>> +++ b/include/linux/swap.h
>>>> @@ -482,7 +482,6 @@ extern int add_swap_count_continuation(swp_entry_t, gfp_t);
>>>>  extern void swap_shmem_alloc(swp_entry_t);
>>>>  extern int swap_duplicate(swp_entry_t);
>>>>  extern int swapcache_prepare(swp_entry_t);
>>>> -extern void swap_free(swp_entry_t);
>>>
>>> I wonder if it would be cleaner to:
>>>
>>> #define swap_free(entry) swap_free_nr((entry), 1)
>>>
>>> To save all the churn for the callsites that just want to pass a single entry?
>>
>> I prefer this way.  Although I prefer inline functions.

Yes, I agree inline function is the better approach.

> 
> Yes, using static inline is preferable. I've recently submitted
> a checkpatch/codestyle for this, which can be found at:
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything&id=39c58d5ed036
> https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-everything&id=8379bf0b0e1f5
> 
> Using static inline aligns with the established rule.
> 
>>
>> Otherwise, LGTM.  Feel free to add
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Thanks!
> 
>>
>> in the future version.
> 
> I believe Christoph's vote leans towards simply removing swap_free_nr
> and renaming it to swap_free, while adding a new parameter as follows.
> 
> void swap_free(swp_entry_t entry, int nr);
> {
> }
> 
> now I see Ryan and you prefer
> 
> static inline swap_free()
> {
>         swap_free_nr(...., 1)
> }
> 
> Chris slightly favors discouraging the use of swap_free() without the
> new parameter. Removing swap_free() can address this concern.
> 
> It seems that maintaining swap_free() and having it call swap_free_nr() with
> a default value of 1 received the most support.
> 
> To align with free_swap_and_cache() and free_swap_and_cache_nr(),
> I'll proceed with the "static inline" approach in the new version. Please
> voice any objections you may have, Christoph, Chris.

I'm happy with either route. If you end up adding a nr param to swap_free() then
it would also be good to give free_swap_and_cache_nr() the same treatment.

> 
>>
>>>>  extern void swap_free_nr(swp_entry_t entry, int nr_pages);
>>>>  extern void swapcache_free_entries(swp_entry_t *entries, int n);
>>>>  extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
>>>> @@ -561,10 +560,6 @@ static inline int swapcache_prepare(swp_entry_t swp)
>>>>      return 0;
>>>>  }
>>>>
>>>> -static inline void swap_free(swp_entry_t swp)
>>>> -{
>>>> -}
>>>> -
>>>>  static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
>>>>  {
>>>>  }
>>>> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
>>>> index 5bc04bfe2db1..6befaa88a342 100644
>>>> --- a/kernel/power/swap.c
>>>> +++ b/kernel/power/swap.c
>>>> @@ -181,7 +181,7 @@ sector_t alloc_swapdev_block(int swap)
>>>>      offset = swp_offset(get_swap_page_of_type(swap));
>>>>      if (offset) {
>>>>              if (swsusp_extents_insert(offset))
>>>> -                    swap_free(swp_entry(swap, offset));
>>>> +                    swap_free_nr(swp_entry(swap, offset), 1);
>>>>              else
>>>>                      return swapdev_block(swap, offset);
>>>>      }
>>>> @@ -200,12 +200,11 @@ void free_all_swap_pages(int swap)
>>>>
>>>>      while ((node = swsusp_extents.rb_node)) {
>>>>              struct swsusp_extent *ext;
>>>> -            unsigned long offset;
>>>>
>>>>              ext = rb_entry(node, struct swsusp_extent, node);
>>>>              rb_erase(node, &swsusp_extents);
>>>> -            for (offset = ext->start; offset <= ext->end; offset++)
>>>> -                    swap_free(swp_entry(swap, offset));
>>>> +            swap_free_nr(swp_entry(swap, ext->start),
>>>> +                         ext->end - ext->start + 1);
>>>>
>>>>              kfree(ext);
>>>>      }
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index eea6e4984eae..f033eb3528ba 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -4225,7 +4225,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>       * We're already holding a reference on the page but haven't mapped it
>>>>       * yet.
>>>>       */
>>>> -    swap_free(entry);
>>>> +    swap_free_nr(entry, 1);
>>>>      if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>>              folio_free_swap(folio);
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 087a79f1f611..39ec7742acec 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1865,7 +1865,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>                              goto walk_done_err;
>>>>                      }
>>>>                      if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>>>> -                            swap_free(entry);
>>>> +                            swap_free_nr(entry, 1);
>>>>                              set_pte_at(mm, address, pvmw.pte, pteval);
>>>>                              goto walk_done_err;
>>>>                      }
>>>> @@ -1873,7 +1873,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>>>                      /* See folio_try_share_anon_rmap(): clear PTE first. */
>>>>                      if (anon_exclusive &&
>>>>                          folio_try_share_anon_rmap_pte(folio, subpage)) {
>>>> -                            swap_free(entry);
>>>> +                            swap_free_nr(entry, 1);
>>>>                              set_pte_at(mm, address, pvmw.pte, pteval);
>>>>                              goto walk_done_err;
>>>>                      }
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index fa2a0ed97507..bfc8a2beb24f 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -1836,7 +1836,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>>>>       * in shmem_evict_inode().
>>>>       */
>>>>      shmem_recalc_inode(inode, -1, -1);
>>>> -    swap_free(swap);
>>>> +    swap_free_nr(swap, 1);
>>>>  }
>>>>
>>>>  /*
>>>> @@ -1927,7 +1927,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>>>>
>>>>      delete_from_swap_cache(folio);
>>>>      folio_mark_dirty(folio);
>>>> -    swap_free(swap);
>>>> +    swap_free_nr(swap, 1);
>>>>      put_swap_device(si);
>>>>
>>>>      *foliop = folio;
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index ec12f2b9d229..ddcd0f24b9a1 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -1343,19 +1343,6 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
>>>>      swap_range_free(p, offset, 1);
>>>>  }
>>>>
>>>> -/*
>>>> - * Caller has made sure that the swap device corresponding to entry
>>>> - * is still around or has not been recycled.
>>>> - */
>>>> -void swap_free(swp_entry_t entry)
>>>> -{
>>>> -    struct swap_info_struct *p;
>>>> -
>>>> -    p = _swap_info_get(entry);
>>>> -    if (p)
>>>> -            __swap_entry_free(p, entry);
>>>> -}
>>>> -
>>>>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>>>              unsigned long offset, int nr_pages)
>>>>  {
>>>> @@ -1385,6 +1372,10 @@ static void cluster_swap_free_nr(struct swap_info_struct *sis,
>>>>      unlock_cluster_or_swap_info(sis, ci);
>>>>  }
>>>>
>>>> +/*
>>>> + * Caller has made sure that the swap device corresponding to entry
>>>> + * is still around or has not been recycled.
>>>> + */
>>>>  void swap_free_nr(swp_entry_t entry, int nr_pages)
>>>>  {
>>>>      int nr;
>>>> @@ -1930,7 +1921,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>>>>              new_pte = pte_mkuffd_wp(new_pte);
>>>>  setpte:
>>>>      set_pte_at(vma->vm_mm, addr, pte, new_pte);
>>>> -    swap_free(entry);
>>>> +    swap_free_nr(entry, 1);
>>>>  out:
>>>>      if (pte)
>>>>              pte_unmap_unlock(pte, ptl);
>>
>> --
>> Best Regards,
>> Huang, Ying
> 
> Thanks
> Barry


