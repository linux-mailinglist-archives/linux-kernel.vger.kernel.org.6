Return-Path: <linux-kernel+bounces-170861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC28BDD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67A2286076
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80E13B78A;
	Tue,  7 May 2024 08:17:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9A4087C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069850; cv=none; b=tjnVmigasHbv8H/4qwEFkYa6S5USnDY2fXRnFkDGb3IUtpX9rSQAm+PZUZQXDG9CEeBjWbaRMkl7iSF+nEAFzOC82g0RZYfTk4FNh55TyaqmOxGqmRDye5TRaPtFXSJHtxvUh8HJ4bB9ckGmhCCUuiOHWBtZ0R+D5DN67Xx8g3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069850; c=relaxed/simple;
	bh=5G5mB7Go7gG5UO0i1DQbUIhTOpuhiZRhZ+bJDgQC7Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXvN1T8GfRsVzcyI/p5bgigsqoAutCSvq6yb/eCS45ScozuGSooLjLag4PvWX5uAW4orYXfe9/k0aQNxUSf/YKoczWO1mhLwlzAd+7l4dQ+5TVekMHl+5aNAZX6wgJOCa877KXfBmwX6V4GH/xU9KAmBwm03059KYHMWxdPobZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EACC106F;
	Tue,  7 May 2024 01:17:53 -0700 (PDT)
Received: from [10.57.67.145] (unknown [10.57.67.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A37FB3F793;
	Tue,  7 May 2024 01:17:24 -0700 (PDT)
Message-ID: <7889a57a-9c26-4292-b0ce-20b85854634d@arm.com>
Date: Tue, 7 May 2024 09:17:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in
 swapcache
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
 hanchuanhua@oppo.com, hannes@cmpxchg.org, hughd@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, surenb@google.com,
 v-songbaohua@oppo.com, willy@infradead.org, xiang@kernel.org,
 ying.huang@intel.com, yosryahmed@google.com, yuzhao@google.com,
 ziy@nvidia.com
References: <20240503005023.174597-1-21cnbao@gmail.com>
 <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com>
 <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/05/2024 00:23, Barry Song wrote:
> On Fri, May 3, 2024 at 6:50 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 03/05/2024 01:50, Barry Song wrote:
>>> From: Chuanhua Han <hanchuanhua@oppo.com>
>>>
>>> When a large folio is found in the swapcache, the current implementation
>>> requires calling do_swap_page() nr_pages times, resulting in nr_pages
>>> page faults. This patch opts to map the entire large folio at once to
>>> minimize page faults. Additionally, redundant checks and early exits
>>> for ARM64 MTE restoring are removed.
>>>
>>> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
>>> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>
>> With the suggested changes below:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>>> ---
>>>  mm/memory.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----------
>>>  1 file changed, 48 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 22e7c33cc747..940fdbe69fa1 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>       pte_t pte;
>>>       vm_fault_t ret = 0;
>>>       void *shadow = NULL;
>>> +     int nr_pages = 1;
>>> +     unsigned long page_idx = 0;
>>> +     unsigned long address = vmf->address;
>>> +     pte_t *ptep;
>>
>> nit: Personally I'd prefer all these to get initialised just before the "if
>> (folio_test_large()..." block below. That way it is clear they are fresh (incase
>> any logic between here and there makes an adjustment) and its clear that they
>> are only to be used after that block (the compiler will warn if using an
>> uninitialized value).
> 
> right. I agree this will make the code more readable.
> 
>>
>>>
>>>       if (!pte_unmap_same(vmf))
>>>               goto out;
>>> @@ -4166,6 +4170,36 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>               goto out_nomap;
>>>       }
>>>
>>> +     ptep = vmf->pte;
>>> +     if (folio_test_large(folio) && folio_test_swapcache(folio)) {
>>> +             int nr = folio_nr_pages(folio);
>>> +             unsigned long idx = folio_page_idx(folio, page);
>>> +             unsigned long folio_start = vmf->address - idx * PAGE_SIZE;
>>> +             unsigned long folio_end = folio_start + nr * PAGE_SIZE;
>>> +             pte_t *folio_ptep;
>>> +             pte_t folio_pte;
>>> +
>>> +             if (unlikely(folio_start < max(vmf->address & PMD_MASK, vma->vm_start)))
>>> +                     goto check_folio;
>>> +             if (unlikely(folio_end > pmd_addr_end(vmf->address, vma->vm_end)))
>>> +                     goto check_folio;
>>> +
>>> +             folio_ptep = vmf->pte - idx;
>>> +             folio_pte = ptep_get(folio_ptep);
>>> +             if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
>>> +                 swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>>> +                     goto check_folio;
>>> +
>>> +             page_idx = idx;
>>> +             address = folio_start;
>>> +             ptep = folio_ptep;
>>> +             nr_pages = nr;
>>> +             entry = folio->swap;
>>> +             page = &folio->page;
>>> +     }
>>> +
>>> +check_folio:
>>
>> Is this still the correct label name, given the checks are now above the new
>> block? Perhaps "one_page" or something like that?
> 
> not quite sure about this, as the code after one_page can be multiple_pages.
> On the other hand, it seems we are really checking folio after "check_folio"
> :-)

Yeah fair enough. Ignore my comment.

> 
> 
> BUG_ON(!folio_test_anon(folio) && folio_test_mappedtodisk(folio));
> BUG_ON(folio_test_anon(folio) && PageAnonExclusive(page));
> 
> /*
> * Check under PT lock (to protect against concurrent fork() sharing
> * the swap entry concurrently) for certainly exclusive pages.
> */
> if (!folio_test_ksm(folio)) {
> 
> 
>>
>>> +
>>>       /*
>>>        * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>>>        * must never point at an anonymous page in the swapcache that is
>>> @@ -4225,12 +4259,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>        * We're already holding a reference on the page but haven't mapped it
>>>        * yet.
>>>        */
>>> -     swap_free_nr(entry, 1);
>>> +     swap_free_nr(entry, nr_pages);
>>>       if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>               folio_free_swap(folio);
>>>
>>> -     inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -     dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>> +     folio_ref_add(folio, nr_pages - 1);
>>> +     add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
>>> +     add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>>>       pte = mk_pte(page, vma->vm_page_prot);
>>>
>>>       /*
>>> @@ -4240,34 +4275,35 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>        * exclusivity.
>>>        */
>>>       if (!folio_test_ksm(folio) &&
>>> -         (exclusive || folio_ref_count(folio) == 1)) {
>>> +         (exclusive || (folio_ref_count(folio) == nr_pages &&
>>> +                        folio_nr_pages(folio) == nr_pages))) {
>>
>> I think in practice there is no change here? If nr_pages > 1 then the folio is
>> in the swapcache, so there is an extra ref on it? I agree with the change for
>> robustness sake. Just checking my understanding.
> 
> This is the code showing we are reusing/(mkwrite) a folio either
> 1. we meet a small folio and we are the only one hitting the small folio
> 2. we meet a large folio and we are the only one hitting the large folio
> 
> any corner cases besides the above two seems difficult. for example,
> 
> while we hit a large folio in swapcache but if we can't entirely map it
> (nr_pages==1) due to partial unmap, we will have folio_ref_count(folio)
> == nr_pages == 1, in this case, lacking  folio_nr_pages(folio) == nr_pages
> might lead to mkwrite() on a single pte within a partially unmapped large
> folio. not quite sure this is wrong, but seems buggy and arduous.
> 
>>
>>>               if (vmf->flags & FAULT_FLAG_WRITE) {
>>>                       pte = maybe_mkwrite(pte_mkdirty(pte), vma);
>>>                       vmf->flags &= ~FAULT_FLAG_WRITE;
>>>               }
>>>               rmap_flags |= RMAP_EXCLUSIVE;
>>>       }
>>> -     flush_icache_page(vma, page);
>>> +     flush_icache_pages(vma, page, nr_pages);
>>>       if (pte_swp_soft_dirty(vmf->orig_pte))
>>>               pte = pte_mksoft_dirty(pte);
>>>       if (pte_swp_uffd_wp(vmf->orig_pte))
>>>               pte = pte_mkuffd_wp(pte);
>>> -     vmf->orig_pte = pte;
>>> +     vmf->orig_pte = pte_advance_pfn(pte, page_idx);
>>>
>>>       /* ksm created a completely new copy */
>>>       if (unlikely(folio != swapcache && swapcache)) {
>>> -             folio_add_new_anon_rmap(folio, vma, vmf->address);
>>> +             folio_add_new_anon_rmap(folio, vma, address);
>>>               folio_add_lru_vma(folio, vma);
>>>       } else {
>>> -             folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
>>> +             folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
>>>                                       rmap_flags);
>>>       }
>>>
>>>       VM_BUG_ON(!folio_test_anon(folio) ||
>>>                       (pte_write(pte) && !PageAnonExclusive(page)));
>>> -     set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>>> -     arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
>>> -                     pte, vmf->orig_pte, 1);
>>> +     set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
>>> +     arch_do_swap_page_nr(vma->vm_mm, vma, address,
>>> +                     pte, pte, nr_pages);
>>>
>>>       folio_unlock(folio);
>>>       if (folio != swapcache && swapcache) {
>>> @@ -4291,7 +4327,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>       }
>>>
>>>       /* No need to invalidate - it was non-present before */
>>> -     update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
>>> +     update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
>>>  unlock:
>>>       if (vmf->pte)
>>>               pte_unmap_unlock(vmf->pte, vmf->ptl);
>>
> 
> Thanks
> Barry


