Return-Path: <linux-kernel+bounces-287990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 076D2952F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC371F22568
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7924A19EEBD;
	Thu, 15 Aug 2024 13:28:03 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FA1DFFB
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728482; cv=none; b=WNqP4HTMxY4bx5ePhPTDYlzkRDimP5xKJ59oXGAL05Jhtq/dcFVfphAqgFTaZ7EfMtDw3hEer/7Cx+50vTYK9JTx9o5EKtK2zJn55UVavH4HWfPcnmoxJmQ1ly0R6xQbDTc6SLMtpGhYmJgRDG6afOPp4x9NOdoWhbOY4yprMrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728482; c=relaxed/simple;
	bh=ADV4rihW5uVJ57eOUx6PugYD2/A5cMZ277u6XDxwQYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H5hXXlig4zOYKBFEQBdVJ+8ONaMovsN/4mqv3jkG36q8g1ObDmnlFAOgiorS8Z+VoifklCp7XIZS+YWna1TOYPpb6sBzCZhyOjcAT4whYkDTFIi0TowQ/KpO2Z8cv4/FreTpsLjAUt4Zkf7EgTwwXpDkSIzoo03ZlDFR4VzOZ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wl5Ww0tQNzyQ4v;
	Thu, 15 Aug 2024 21:27:24 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 98F13180100;
	Thu, 15 Aug 2024 21:27:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 15 Aug 2024 21:27:54 +0800
Message-ID: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
Date: Thu, 15 Aug 2024 21:27:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like
 devices
Content-Language: en-US
To: Kairui Song <ryncsn@gmail.com>, Chuanhua Han <hanchuanhua@oppo.com>, Barry
 Song <21cnbao@gmail.com>
CC: <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<baolin.wang@linux.alibaba.com>, <chrisl@kernel.org>, <david@redhat.com>,
	<hannes@cmpxchg.org>, <hughd@google.com>, <kaleshsingh@google.com>,
	<linux-kernel@vger.kernel.org>, <mhocko@suse.com>, <minchan@kernel.org>,
	<nphamcs@gmail.com>, <ryan.roberts@arm.com>, <senozhatsky@chromium.org>,
	<shakeel.butt@linux.dev>, <shy828301@gmail.com>, <surenb@google.com>,
	<v-songbaohua@oppo.com>, <willy@infradead.org>, <xiang@kernel.org>,
	<ying.huang@intel.com>, <yosryahmed@google.com>, <hch@infradead.org>
References: <20240726094618.401593-1-21cnbao@gmail.com>
 <20240802122031.117548-1-21cnbao@gmail.com>
 <20240802122031.117548-3-21cnbao@gmail.com>
 <CAMgjq7DmSok3YYd6dqyyYxkK_wZg7-c2bW8BFfxhs1V86h=niw@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAMgjq7DmSok3YYd6dqyyYxkK_wZg7-c2bW8BFfxhs1V86h=niw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/8/15 17:47, Kairui Song wrote:
> On Fri, Aug 2, 2024 at 8:21 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> From: Chuanhua Han <hanchuanhua@oppo.com>
> 
> Hi Chuanhua,
> 
>>
...

>> +
>> +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>> +{
>> +       struct vm_area_struct *vma = vmf->vma;
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +       unsigned long orders;
>> +       struct folio *folio;
>> +       unsigned long addr;
>> +       swp_entry_t entry;
>> +       spinlock_t *ptl;
>> +       pte_t *pte;
>> +       gfp_t gfp;
>> +       int order;
>> +
>> +       /*
>> +        * If uffd is active for the vma we need per-page fault fidelity to
>> +        * maintain the uffd semantics.
>> +        */
>> +       if (unlikely(userfaultfd_armed(vma)))
>> +               goto fallback;
>> +
>> +       /*
>> +        * A large swapped out folio could be partially or fully in zswap. We
>> +        * lack handling for such cases, so fallback to swapping in order-0
>> +        * folio.
>> +        */
>> +       if (!zswap_never_enabled())
>> +               goto fallback;
>> +
>> +       entry = pte_to_swp_entry(vmf->orig_pte);
>> +       /*
>> +        * Get a list of all the (large) orders below PMD_ORDER that are enabled
>> +        * and suitable for swapping THP.
>> +        */
>> +       orders = thp_vma_allowable_orders(vma, vma->vm_flags,
>> +                       TVA_IN_PF | TVA_ENFORCE_SYSFS, BIT(PMD_ORDER) - 1);
>> +       orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>> +       orders = thp_swap_suitable_orders(swp_offset(entry), vmf->address, orders);
>> +
>> +       if (!orders)
>> +               goto fallback;
>> +
>> +       pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd, vmf->address & PMD_MASK, &ptl);
>> +       if (unlikely(!pte))
>> +               goto fallback;
>> +
>> +       /*
>> +        * For do_swap_page, find the highest order where the aligned range is
>> +        * completely swap entries with contiguous swap offsets.
>> +        */
>> +       order = highest_order(orders);
>> +       while (orders) {
>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> +               if (can_swapin_thp(vmf, pte + pte_index(addr), 1 << order))
>> +                       break;
>> +               order = next_order(&orders, order);
>> +       }
>> +
>> +       pte_unmap_unlock(pte, ptl);
>> +
>> +       /* Try allocating the highest of the remaining orders. */
>> +       gfp = vma_thp_gfp_mask(vma);
>> +       while (orders) {
>> +               addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
>> +               folio = vma_alloc_folio(gfp, order, vma, addr, true);
>> +               if (folio)
>> +                       return folio;
>> +               order = next_order(&orders, order);
>> +       }
>> +
>> +fallback:
>> +#endif
>> +       return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address, false);
>> +}
>> +
>> +
>>   /*
>>    * We enter with non-exclusive mmap_lock (to exclude vma changes,
>>    * but allow concurrent faults), and pte mapped but not yet locked.
>> @@ -4074,35 +4220,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>          if (!folio) {
>>                  if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>                      __swap_count(entry) == 1) {
>> -                       /*
>> -                        * Prevent parallel swapin from proceeding with
>> -                        * the cache flag. Otherwise, another thread may
>> -                        * finish swapin first, free the entry, and swapout
>> -                        * reusing the same entry. It's undetectable as
>> -                        * pte_same() returns true due to entry reuse.
>> -                        */
>> -                       if (swapcache_prepare(entry, 1)) {
>> -                               /* Relax a bit to prevent rapid repeated page faults */
>> -                               schedule_timeout_uninterruptible(1);
>> -                               goto out;
>> -                       }
>> -                       need_clear_cache = true;
>> -
>>                          /* skip swapcache */
>> -                       folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>> -                                               vma, vmf->address, false);
>> +                       folio = alloc_swap_folio(vmf);
>>                          page = &folio->page;
>>                          if (folio) {
>>                                  __folio_set_locked(folio);
>>                                  __folio_set_swapbacked(folio);
>>
>> +                               nr_pages = folio_nr_pages(folio);
>> +                               if (folio_test_large(folio))
>> +                                       entry.val = ALIGN_DOWN(entry.val, nr_pages);
>> +                               /*
>> +                                * Prevent parallel swapin from proceeding with
>> +                                * the cache flag. Otherwise, another thread may
>> +                                * finish swapin first, free the entry, and swapout
>> +                                * reusing the same entry. It's undetectable as
>> +                                * pte_same() returns true due to entry reuse.
>> +                                */
>> +                               if (swapcache_prepare(entry, nr_pages)) {
>> +                                       /* Relax a bit to prevent rapid repeated page faults */
>> +                                       schedule_timeout_uninterruptible(1);
>> +                                       goto out_page;
>> +                               }
>> +                               need_clear_cache = true;
>> +
>>                                  if (mem_cgroup_swapin_charge_folio(folio,
>>                                                          vma->vm_mm, GFP_KERNEL,
>>                                                          entry)) {
>>                                          ret = VM_FAULT_OOM;
>>                                          goto out_page;
>>                                  }
> 
> After your patch, with build kernel test, I'm seeing kernel log
> spamming like this:
> [  101.048594] pagefault_out_of_memory: 95 callbacks suppressed
> [  101.048599] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.059416] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.118575] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.125585] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.182501] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.215351] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.272822] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> [  101.403195] Huh VM_FAULT_OOM leaked out to the #PF handler. Retrying PF
> ............
> 
> And heavy performance loss with workloads limited by memcg, mTHP enabled.
> 
> After some debugging, the problematic part is the
> mem_cgroup_swapin_charge_folio call above.
> When under pressure, cgroup charge fails easily for mTHP. One 64k
> swapin will require a much more aggressive reclaim to success.
> 
> If I change MAX_RECLAIM_RETRIES from 16 to 512, the spamming log is
> gone and mTHP swapin should have a much higher swapin success rate.
> But this might not be the right way.
> 
> For this particular issue, maybe you can change the charge order, try
> charging first, if successful, use mTHP. if failed, fallback to 4k?

This is what we did in alloc_anon_folio(), see 085ff35e7636
("mm: memory: move mem_cgroup_charge() into alloc_anon_folio()"),
1) fallback earlier
2) using same GFP flags for allocation and charge

but it seems that there is a little complicated for swapin charge


> 
>> -                               mem_cgroup_swapin_uncharge_swap(entry, 1);
>> +                               mem_cgroup_swapin_uncharge_swap(entry, nr_pages);
>>
>>                                  shadow = get_shadow_from_swap_cache(entry);
>>                                  if (shadow)
>> @@ -4209,6 +4357,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>                  goto out_nomap;
>>          }
>>
>> +       /* allocated large folios for SWP_SYNCHRONOUS_IO */
>> +       if (folio_test_large(folio) && !folio_test_swapcache(folio)) {
>> +               unsigned long nr = folio_nr_pages(folio);
>> +               unsigned long folio_start = ALIGN_DOWN(vmf->address, nr * PAGE_SIZE);
>> +               unsigned long idx = (vmf->address - folio_start) / PAGE_SIZE;
>> +               pte_t *folio_ptep = vmf->pte - idx;
>> +
>> +               if (!can_swapin_thp(vmf, folio_ptep, nr))
>> +                       goto out_nomap;
>> +
>> +               page_idx = idx;
>> +               address = folio_start;
>> +               ptep = folio_ptep;
>> +               goto check_folio;
>> +       }
>> +
>>          nr_pages = 1;
>>          page_idx = 0;
>>          address = vmf->address;
>> @@ -4340,11 +4504,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>                  folio_add_lru_vma(folio, vma);
>>          } else if (!folio_test_anon(folio)) {
>>                  /*
>> -                * We currently only expect small !anon folios, which are either
>> -                * fully exclusive or fully shared. If we ever get large folios
>> -                * here, we have to be careful.
>> +                * We currently only expect small !anon folios which are either
>> +                * fully exclusive or fully shared, or new allocated large folios
>> +                * which are fully exclusive. If we ever get large folios within
>> +                * swapcache here, we have to be careful.
>>                   */
>> -               VM_WARN_ON_ONCE(folio_test_large(folio));
>> +               VM_WARN_ON_ONCE(folio_test_large(folio) && folio_test_swapcache(folio));
>>                  VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
>>                  folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
>>          } else {
>> @@ -4387,7 +4552,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>   out:
>>          /* Clear the swap cache pin for direct swapin after PTL unlock */
>>          if (need_clear_cache)
>> -               swapcache_clear(si, entry, 1);
>> +               swapcache_clear(si, entry, nr_pages);
>>          if (si)
>>                  put_swap_device(si);
>>          return ret;
>> @@ -4403,7 +4568,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>                  folio_put(swapcache);
>>          }
>>          if (need_clear_cache)
>> -               swapcache_clear(si, entry, 1);
>> +               swapcache_clear(si, entry, nr_pages);
>>          if (si)
>>                  put_swap_device(si);
>>          return ret;
>> --
>> 2.34.1
>>
>>
> 

