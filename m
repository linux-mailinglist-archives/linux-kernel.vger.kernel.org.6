Return-Path: <linux-kernel+bounces-318443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD596EDF9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A651C23DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A08156C5E;
	Fri,  6 Sep 2024 08:28:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74FE14D282
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611314; cv=none; b=PvsxUJyzy9PmgVVKZhohlEAu8HSstthaQkNgTGGK6v+EpOy3ilevdEjuFSA8IA8Rkc5bCHitfqTIyspk1No6i6bMpUzz79iXzObuj15kDlX631w5C50ENzyoFl6FTUq7/wnMYWYDf2v3Uclj9DcT5sfkOVl/MElJgBnok6biwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611314; c=relaxed/simple;
	bh=xcnLroYc+qi7dy8BpB3eLjBPyxP8NioFL7BJ1hbcy2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MeqacqOdjEMH1FzT+ySl38ziEDatMoHbQT1w/8DuPUE5Ca6+27MQ2bXmCRlsvQrH43a0Il0Rj1cKO1jurD5jfRzrlP4Yy48udQUGwB6lQ77Yr7YBjHcuJamVw8VPi+/UD+zorFemwqyaC1XKFwNt45ZOiJrOfJgMnQ9Unslfv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19DEDFEC;
	Fri,  6 Sep 2024 01:28:56 -0700 (PDT)
Received: from [10.57.86.132] (unknown [10.57.86.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DD0C3F66E;
	Fri,  6 Sep 2024 01:28:25 -0700 (PDT)
Message-ID: <60f1577f-314d-4ac9-85b3-068111594845@arm.com>
Date: Fri, 6 Sep 2024 09:28:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: Abstract THP allocation
Content-Language: en-GB
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, david@redhat.com,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240904100923.290042-1-dev.jain@arm.com>
 <20240904100923.290042-2-dev.jain@arm.com>
 <336ce914-43dc-4613-a339-1a33f16f71ad@arm.com>
 <10aea3c3-42be-4f82-8961-75d5142a9653@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <10aea3c3-42be-4f82-8961-75d5142a9653@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/09/2024 06:42, Dev Jain wrote:
> 
> On 9/5/24 16:38, Ryan Roberts wrote:
>> On 04/09/2024 11:09, Dev Jain wrote:
>>> In preparation for the second patch, abstract away the THP allocation
>>> logic present in the create_huge_pmd() path, which corresponds to the
>>> faulting case when no page is present.
>>>
>>> There should be no functional change as a result of applying
>>> this patch.
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   mm/huge_memory.c | 110 +++++++++++++++++++++++++++++------------------
>>>   1 file changed, 67 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 67c86a5d64a6..58125fbcc532 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -943,47 +943,89 @@ unsigned long thp_get_unmapped_area(struct file *filp,
>>> unsigned long addr,
>>>   }
>>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>>   -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>>> -            struct page *page, gfp_t gfp)
>>> +static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct
>>> vm_area_struct *vma,
>> Is there a reason for specifying order as a parameter? Previously it was
>> hardcoded to HPAGE_PMD_ORDER. But now, thp_fault_alloc() and
>> __thp_fault_success_stats() both take order and map_pmd_thp() is still
>> implicitly mapping a PMD-sized block. Unless there is a reason you need this
>> parameter in the next patch (I don't think there is?) I suggest simplifying.
> 
> If I am not wrong, thp_fault_alloc() and __thp_fault_success_stats()
> will remain the same in case of mTHP? 

No, its a bit different for smaller-than-pmd THP - that's handled in
alloc_anon_folio() in memory.c. It deals with fallback to smaller orders (inc
order-0. Potentially alloc_anon_folio() could be refactored to use your new
functions in future but I'm sure there would be a number of subtlties to
consider and in any case you would want to make that a separate change. The
order param would be added as part of that future change.

> I chose to pass order so that these
> functions can be used by others in the future. 

It's not valuable to have an internal interface with no users. My advice is to
keep it simple and only extend it when a user pops up.

> Therefore, these two functions
> can be generically used in the future while map_pmd_thp() (as the name suggests)
> maps only a PMD-mappable THP.
> 
>>
>>> +                  unsigned long haddr, struct folio **foliop,
>> FWIW, I agree with Kirill's suggestion to just return folio* and drop the output
>> param.
> 
> As I replied to Kirill, I do not think that is a good idea. If you do a git grep on
> the tree for "foliop", you will find several places where that is being used, for
> example, check out alloc_charge_folio() in mm/khugepaged.c. The author intends to
> do the stat computation and setting *foliop in the function itself, so that the
> caller is only concerned with the return value.

By having 2 return params, you open up the possibility of returning an invalid
combination (e.g. ret==FALLBACK, folio!=NULL). You avoid that by having a single
return param, which is either NULL (failure) or a valid pointer.

> Also, if we return the folio instead of VM_FAULT_FALLBACK from thp_fault_alloc(),
> then you will have two "if (unlikely(!folio))" branches, the first to do the stat
> computation in the function, and the second branch in the caller to set ret =
> VM_FAULT_FALLBACK
> and then goto out/release.

There are already 2 conditionals, that doesn't change.

> And, it is already inconsistent to break away the stat computation and the
> return value
> setting, when the stat computation name is of the form
> "count_vm_event(THP_FAULT_FALLBACK)"
> and friends, at which point it would just be better to open code the function.

I don't understand this.

> 
> If I am missing something and your suggestion can be implemented neatly, please
> guide.

This looks cleaner/simpler to my eye (also removing the order parameter):

static folio *thp_fault_alloc(gfp_t gfp, struct vm_area_struct *vma,
			      unsigned long haddr, unsigned long addr)
{
	const int order = HPAGE_PMD_ORDER;
	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);

	if (unlikely(!folio)) {
		count_vm_event(THP_FAULT_FALLBACK);
		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
		goto out;
	}

	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
		folio_put(folio);
		count_vm_event(THP_FAULT_FALLBACK);
		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
		goto out;
	}
	folio_throttle_swaprate(folio, gfp);

	folio_zero_user(folio, addr);
	/*
	 * The memory barrier inside __folio_mark_uptodate makes sure that
	 * folio_zero_user writes become visible before the set_pmd_at()
	 * write.
	 */
	__folio_mark_uptodate(folio);
out:
	return folio;
}


static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
{
	vm_fault_t ret = VM_FAULT_FALLBACK;
	...

	folio = thp_fault_alloc(gfp, vma, haddr, vmf->address);
	if (unlikely(!folio))
		goto release;
	...
}

Thanks,
Ryan

> 
>>
>> Thanks,
>> Ryan
>>
>>> +                  unsigned long addr)
>>>   {
>>> -    struct vm_area_struct *vma = vmf->vma;
>>> -    struct folio *folio = page_folio(page);
>>> -    pgtable_t pgtable;
>>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> -    vm_fault_t ret = 0;
>>> +    struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>>>   -    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>> +    *foliop = folio;
>>> +    if (unlikely(!folio)) {
>>> +        count_vm_event(THP_FAULT_FALLBACK);
>>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>>> +        return VM_FAULT_FALLBACK;
>>> +    }
>>>   +    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>       if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>>>           folio_put(folio);
>>>           count_vm_event(THP_FAULT_FALLBACK);
>>>           count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>>> -        count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
>>> -        count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>>           return VM_FAULT_FALLBACK;
>>>       }
>>>       folio_throttle_swaprate(folio, gfp);
>>>   -    pgtable = pte_alloc_one(vma->vm_mm);
>>> -    if (unlikely(!pgtable)) {
>>> -        ret = VM_FAULT_OOM;
>>> -        goto release;
>>> -    }
>>> -
>>> -    folio_zero_user(folio, vmf->address);
>>> +    folio_zero_user(folio, addr);
>>>       /*
>>>        * The memory barrier inside __folio_mark_uptodate makes sure that
>>>        * folio_zero_user writes become visible before the set_pmd_at()
>>>        * write.
>>>        */
>>>       __folio_mark_uptodate(folio);
>>> +    return 0;
>>> +}
>>> +
>>> +static void __thp_fault_success_stats(struct vm_area_struct *vma, int order)
>>> +{
>>> +    count_vm_event(THP_FAULT_ALLOC);
>>> +    count_mthp_stat(order, MTHP_STAT_ANON_FAULT_ALLOC);
>>> +    count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>> +}
>>> +
>>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>> +            struct vm_area_struct *vma, unsigned long haddr,
>>> +            pgtable_t pgtable)
>>> +{
>>> +    pmd_t entry;
>>> +
>>> +    entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>> +    entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>> +    folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>> +    folio_add_lru_vma(folio, vma);
>>> +    pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>> +    set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>> +    update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>> +    add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>> +    mm_inc_nr_ptes(vma->vm_mm);
>>> +}
>>> +
>>> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>> +{
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    struct folio *folio = NULL;
>>> +    pgtable_t pgtable;
>>> +    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> +    vm_fault_t ret = 0;
>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>> +
>>> +    pgtable = pte_alloc_one(vma->vm_mm);
>>> +    if (unlikely(!pgtable)) {
>>> +        ret = VM_FAULT_OOM;
>>> +        goto release;
>>> +    }
>>> +
>>> +    ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
>>> +                  vmf->address);
>>> +    if (ret)
>>> +        goto release;
>>>         vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>> +
>>>       if (unlikely(!pmd_none(*vmf->pmd))) {
>>>           goto unlock_release;
>>>       } else {
>>> -        pmd_t entry;
>>> -
>>>           ret = check_stable_address_space(vma->vm_mm);
>>>           if (ret)
>>>               goto unlock_release;
>>> @@ -997,20 +1039,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct
>>> vm_fault *vmf,
>>>               VM_BUG_ON(ret & VM_FAULT_FALLBACK);
>>>               return ret;
>>>           }
>>> -
>>> -        entry = mk_huge_pmd(page, vma->vm_page_prot);
>>> -        entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>> -        folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>> -        folio_add_lru_vma(folio, vma);
>>> -        pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>> -        set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>> -        update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>> -        add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>> -        mm_inc_nr_ptes(vma->vm_mm);
>>> +        map_pmd_thp(folio, vmf, vma, haddr, pgtable);
>>>           spin_unlock(vmf->ptl);
>>> -        count_vm_event(THP_FAULT_ALLOC);
>>> -        count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>>> -        count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>> +        __thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
>>>       }
>>>         return 0;
>>> @@ -1019,7 +1050,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct
>>> vm_fault *vmf,
>>>   release:
>>>       if (pgtable)
>>>           pte_free(vma->vm_mm, pgtable);
>>> -    folio_put(folio);
>>> +    if (folio)
>>> +        folio_put(folio);
>>>       return ret;
>>>     }
>>> @@ -1077,8 +1109,6 @@ static void set_huge_zero_folio(pgtable_t pgtable,
>>> struct mm_struct *mm,
>>>   vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>>   {
>>>       struct vm_area_struct *vma = vmf->vma;
>>> -    gfp_t gfp;
>>> -    struct folio *folio;
>>>       unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>>       vm_fault_t ret;
>>>   @@ -1129,14 +1159,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct
>>> vm_fault *vmf)
>>>           }
>>>           return ret;
>>>       }
>>> -    gfp = vma_thp_gfp_mask(vma);
>>> -    folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
>>> -    if (unlikely(!folio)) {
>>> -        count_vm_event(THP_FAULT_FALLBACK);
>>> -        count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
>>> -        return VM_FAULT_FALLBACK;
>>> -    }
>>> -    return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
>>> +
>>> +    return __do_huge_pmd_anonymous_page(vmf);
>>>   }
>>>     static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,


