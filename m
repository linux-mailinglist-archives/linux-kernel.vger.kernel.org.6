Return-Path: <linux-kernel+bounces-318491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E61296EEAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12AB1F25760
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6377F1A7AEE;
	Fri,  6 Sep 2024 09:00:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6CC1A071E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613221; cv=none; b=qYglr7QPkd6LHeDTZu3HvX0aPRyoSrPYe0Qof64eHJWx32JA/ge0CKVAnTbfwvwac2k3MwxRjd3bbIeaid71FfrTbGPG0P9LMvbZJVzcfHSxI7BjCu0m8VP2S5BqA9j7s3Te94PyCf4tre+ZaYPe7HZGrd1CPytcKH5R0JGrSWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613221; c=relaxed/simple;
	bh=vLQfZNLJakpxnqz8nYxY9AMetP6YtB/IuS6Enlsyn+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xh+NZolmArFOAV9WB56DpD4bxPwMHP8rdAgAlbFYEGYLsgCZc+KC+M7JehFYzSjqPTd7kI2/Xl/Zf2KnOLNeUcWEo4Koeo1VLNTt4AfKP3q6AGkxJV560JZqsOScgZb2Y0PQLIXHtHWpZMSFftF9Kgrd2BN3rX1J/EV/JFTg5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD180FEC;
	Fri,  6 Sep 2024 02:00:45 -0700 (PDT)
Received: from [10.162.41.22] (e116581.arm.com [10.162.41.22])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA92A3F73F;
	Fri,  6 Sep 2024 02:00:10 -0700 (PDT)
Message-ID: <709c0648-c9c5-4197-83f2-64d36293b99e@arm.com>
Date: Fri, 6 Sep 2024 14:30:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: Allocate THP on hugezeropage wp-fault
To: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240904100923.290042-1-dev.jain@arm.com>
 <20240904100923.290042-3-dev.jain@arm.com>
 <542b8267-39de-4593-82ef-a586bb372824@arm.com>
 <7b7c5dc8-933b-405f-be27-907624f7f8ce@arm.com>
 <ce7bb8c0-7b3d-4755-a64e-0327bf009536@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ce7bb8c0-7b3d-4755-a64e-0327bf009536@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/6/24 14:13, Ryan Roberts wrote:
> On 06/09/2024 08:05, Dev Jain wrote:
>> On 9/5/24 18:44, Ryan Roberts wrote:
>>> On 04/09/2024 11:09, Dev Jain wrote:
>>>> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
>>>> replace it with a PMD-mapped THP. Change the helpers introduced in the
>>>> previous patch to flush TLB entry corresponding to the hugezeropage,
>>>> and preserve PMD uffd-wp marker. In case of failure, fallback to
>>>> splitting the PMD.
>>>>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>    include/linux/huge_mm.h |  6 ++++
>>>>    mm/huge_memory.c        | 79 +++++++++++++++++++++++++++++++++++------
>>>>    mm/memory.c             |  5 +--
>>>>    3 files changed, 78 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>> index e25d9ebfdf89..fdd2cf473a3c 100644
>>>> --- a/include/linux/huge_mm.h
>>>> +++ b/include/linux/huge_mm.h
>>>> @@ -9,6 +9,12 @@
>>>>    #include <linux/kobject.h>
>>>>      vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>>>> +vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
>>>> +               unsigned long haddr, struct folio **foliop,
>>>> +               unsigned long addr);
>>>> +void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>>> +         struct vm_area_struct *vma, unsigned long haddr,
>>>> +         pgtable_t pgtable);
>>> I don't think you are using either of these outside of huge_memory.c, so not
>>> sure you need to declare them here or make them non-static?
>> As pointed out by Kirill, you are right, I forgot to drop these from my previous
>> approach.
>>
>>>>    int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>>              pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
>>>>              struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 58125fbcc532..150163ad77d3 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -943,9 +943,9 @@ unsigned long thp_get_unmapped_area(struct file *filp,
>>>> unsigned long addr,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>>>    -static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct
>>>> vm_area_struct *vma,
>>>> -                  unsigned long haddr, struct folio **foliop,
>>>> -                  unsigned long addr)
>>>> +vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
>>>> +               unsigned long haddr, struct folio **foliop,
>>>> +               unsigned long addr)
>>>>    {
>>>>        struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>>>>    @@ -984,21 +984,29 @@ static void __thp_fault_success_stats(struct
>>>> vm_area_struct *vma, int order)
>>>>        count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>>>    }
>>>>    -static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>>> -            struct vm_area_struct *vma, unsigned long haddr,
>>>> -            pgtable_t pgtable)
>>>> +void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>>> +         struct vm_area_struct *vma, unsigned long haddr,
>>>> +         pgtable_t pgtable)
>>>>    {
>>>> -    pmd_t entry;
>>>> +    pmd_t entry, old_pmd;
>>>> +    bool is_pmd_none = pmd_none(*vmf->pmd);
>>>>          entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>>>        entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>>>        folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>>>        folio_add_lru_vma(folio, vma);
>>>> -    pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>>> +    if (!is_pmd_none) {
>>>> +        old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
>>>> +        if (pmd_uffd_wp(old_pmd))
>>>> +            entry = pmd_mkuffd_wp(entry);
>>> I don't really get this; entry is writable, so I wouldn't expect to also be
>>> setting uffd-wp here? That combination is not allowed and is checked for in
>>> page_table_check_pte_flags().
>>>
>>> It looks like you expect to get here in the uffd-wp-async case, which used to
>>> cause the pmd to be split to ptes. I'm guessing (but don't know for sure) that
>>> would cause the uffd-wp bit to be set in each of the new ptes, then during
>>> fallback to handling the wp fault on the pte, uffd would handle it?
>> I guess you are correct; I missed the WARN_ON() in page_table_check_pmd_flags(),
>> but I did see, if I read the uffd code correctly, that mfill_atomic() will just
>> return in case of pmd_trans_huge(*dst_pmd) while doing a uffd_copy to the
>> destination
>> location. So preserving pmd_uffd_wp is useless in case a THP is mapped, but I
>> did not
>> know that in fact it is supposed to be an invalid combination. So, I will drop it,
>> unless someone has some other objection.
> So what's the correct way to handle uffd-wp-async in wp_huge_pmd()? Just split
> it? If so, you can revert your changes in memory.c.

I think so.

>
>>>> +    }
>>>> +    if (pgtable)
>>>> +        pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>> Should this call be moved outside of here? It doesn't really feel like it
>>> belongs. Could it be called before calling map_pmd_thp() for the site that has a
>>> pgtable?
>> Every other place I checked, they are doing this: make the entry -> deposit
>> pgtable ->
>> set_pmd_at(). I guess the general flow is to do the deposit based on the old
>> pmd, before
>> setting the new one. Which implies: I should at least move this check before I call
>> pmdp_huge_clear_flush(). And, since vmf->pmd and creating the new entry has no
>> relation,
>> I am inclined to do what you are saying.
> pgtable_trans_huge_deposit() is just adding the pgtable to a list so that if the
> THP needs to be split in future, then we have preallocated the pte pgtable so
> the operation can't fail.

Yes.

> And enqueing it is just under the protection of the
> PTL as far as I can tell. So I think the only ordering requirement is that you
> both set the pmd and deposit the pgtable under the lock (without dropping it in
> between). So you can deposit either before or after map_pmd_thp().

Yes I'll do that before.

> And
> pmdp_huge_clear_flush() is irrelavent, I think?

You mean, in this context? Everywhere, pgtable deposit uses the old pmd
value to be replaced as its input, that is, it is called before set_pmd_at().
So calling pgtable deposit after clear_flush() will violate this ordering.
I do not think this ordering is really required but I'd rather be safe :)

>
>>>>        set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>>>        update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>>>        add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>>> -    mm_inc_nr_ptes(vma->vm_mm);
>>>> +    if (is_pmd_none)
>>>> +        mm_inc_nr_ptes(vma->vm_mm);
>>>>    }
>>>>      static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>>> @@ -1576,6 +1584,50 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>>>>        spin_unlock(vmf->ptl);
>>>>    }
>>>>    +static vm_fault_t do_huge_zero_wp_pmd_locked(struct vm_fault *vmf,
>>>> +                         unsigned long haddr,
>>>> +                         struct folio *folio)
>>>> +{
>>>> +    struct vm_area_struct *vma = vmf->vma;
>>>> +    vm_fault_t ret = 0;
>>>> +
>>>> +    ret = check_stable_address_space(vma->vm_mm);
>>>> +    if (ret)
>>>> +        goto out;
>>>> +    map_pmd_thp(folio, vmf, vma, haddr, NULL);
>>>> +out:
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, unsigned long
>>>> haddr)
>>>> +{
>>>> +    struct vm_area_struct *vma = vmf->vma;
>>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>>> +    struct mmu_notifier_range range;
>>>> +    struct folio *folio = NULL;
>>>> +    vm_fault_t ret = 0;
>>>> +
>>>> +    ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
>>>> +                  vmf->address);
>>> Just checking: the PTE table was already allocated during the read fault, right?
>>> So we don't have to allocate it here.
>> Correct, that happens in set_huge_zero_folio(). Thanks for checking.
>>
>>>> +    if (ret)
>>>> +        goto out;
>>>> +
>>>> +    mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, haddr,
>>>> +                haddr + HPAGE_PMD_SIZE);
>>>> +    mmu_notifier_invalidate_range_start(&range);
>>>> +    vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>>> +    if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
>>>> +        goto unlock;
>>>> +    ret = do_huge_zero_wp_pmd_locked(vmf, haddr, folio);
>>>> +    if (!ret)
>>>> +        __thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
>>>> +unlock:
>>>> +    spin_unlock(vmf->ptl);
>>>> +    mmu_notifier_invalidate_range_end(&range);
>>> I'll confess I don't understand all the mmu notifier rules.
>> I confess the same :)
>>
>>> But the doc at
>>> Documentation/mm/mmu_notifier.rst implies that the notification must be done
>>> while holding the PTL. Although that's not how wp_page_copy(). Are you confident
>>> what you have done is correct?
>> Everywhere else, invalidate_range_end() is getting called after dropping the lock,
>> one reason is that it has a might_sleep(), and therefore we cannot call it while
>> holding a spinlock. I still don't know what exactly these calls mean...but I think
>> what I have done is correct.
> High level; they are notifying secondary MMUs (e.g. IOMMU) of a change so the
> tables of those secondary MMUs can be kept in sync. I don't understand all the
> ordering requirement details though.
>
> I think what you have is probably correct, would be good for someone that knows
> what they are talking about to confirm though :)

Exactly.

>
>>> Thanks,
>>> Ryan
>>>
>>>> +out:
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>>>>    {
>>>>        const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>>>> @@ -1588,8 +1640,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>>>>        vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>>>>        VM_BUG_ON_VMA(!vma->anon_vma, vma);
>>>>    -    if (is_huge_zero_pmd(orig_pmd))
>>>> +    if (is_huge_zero_pmd(orig_pmd)) {
>>>> +        vm_fault_t ret = do_huge_zero_wp_pmd(vmf, haddr);
>>>> +
>>>> +        if (!(ret & VM_FAULT_FALLBACK))
>>>> +            return ret;
>>>> +
>>>> +        /* Fallback to splitting PMD if THP cannot be allocated */
>>>>            goto fallback;
>>>> +    }
>>>>          spin_lock(vmf->ptl);
>>>>    diff --git a/mm/memory.c b/mm/memory.c
>>>> index 3c01d68065be..c081a25f5173 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -5409,9 +5409,10 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault
>>>> *vmf)
>>>>        if (vma_is_anonymous(vma)) {
>>>>            if (likely(!unshare) &&
>>>>                userfaultfd_huge_pmd_wp(vma, vmf->orig_pmd)) {
>>>> -            if (userfaultfd_wp_async(vmf->vma))
>>>> +            if (!userfaultfd_wp_async(vmf->vma))
>>>> +                return handle_userfault(vmf, VM_UFFD_WP);
>>>> +            if (!is_huge_zero_pmd(vmf->orig_pmd))
>>>>                    goto split;
>>>> -            return handle_userfault(vmf, VM_UFFD_WP);
>>>>            }
>>>>            return do_huge_pmd_wp_page(vmf);
>>>>        }

