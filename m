Return-Path: <linux-kernel+bounces-324833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A37975161
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7385D28A686
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827EB185B4C;
	Wed, 11 Sep 2024 12:00:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EF913AA3E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056047; cv=none; b=QeJt9YxxSDqlrOiD+bpxHzMTF8HuuRgDYkeyTACKUU0lttadeHrthsa1Bd/rDS92chY5DFzY7foo33P6gCl42qSqv+zk1Ie0+QXiyJ+DsHIyFVMI47fwHDvmbzHXirWuP2DZ8g/nlmeBdO0m3IZ/namM6iddTOK+UXYx7M0P0eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056047; c=relaxed/simple;
	bh=hQguWJEfBWPr8JBEnyBpS+c5eZWedehS612Nu7YiuB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hv7sA3PcW8JGvKX9P4mP5XgGLkOqWhZrHRaW73HgqJFFFim7wXILFDiuhL2kNUn4y46NVIoHkmEZVeZpD8grdqrQQgUQGk9rD4jKqE/zfjWPxCt1Rivuk2OqddYQZh3uvlYW45T3J15//2qrm9+NyqDwq++H2+25FeaWL8LR0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2D681007;
	Wed, 11 Sep 2024 05:01:12 -0700 (PDT)
Received: from [10.162.40.31] (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2A13F66E;
	Wed, 11 Sep 2024 05:00:34 -0700 (PDT)
Message-ID: <552e9b77-c1ea-4a60-8434-e360ca692f1f@arm.com>
Date: Wed, 11 Sep 2024 17:30:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Abstract THP allocation
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240911065600.1002644-1-dev.jain@arm.com>
 <20240911065600.1002644-2-dev.jain@arm.com>
 <f610e933-278e-4f95-a363-8f023a5e7aa9@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <f610e933-278e-4f95-a363-8f023a5e7aa9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/24 14:57, David Hildenbrand wrote:
> On 11.09.24 08:55, Dev Jain wrote:
>> In preparation for the second patch, abstract away the THP allocation
>> logic present in the create_huge_pmd() path, which corresponds to the
>> faulting case when no page is present.
>>
>> There should be no functional change as a result of applying
>> this patch.
>>
>
> Hi,
>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/huge_memory.c | 110 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 67 insertions(+), 43 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 67c86a5d64a6..b96a1ff2bf40 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -943,47 +943,88 @@ unsigned long thp_get_unmapped_area(struct file 
>> *filp, unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>   -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>> -            struct page *page, gfp_t gfp)
>> +static struct folio *pmd_thp_fault_alloc(gfp_t gfp, struct 
>> vm_area_struct *vma,
>> +                     unsigned long haddr, unsigned long addr)
>
> I suggest calling this something like "vma_alloc_anon_folio_pmd()"? 
> Then it's more consistent with vma_alloc_folio().
>
> Also, likely we should just only pass in "addr" and calculate "haddr" 
> ourselves, it's cheap and reduces the number of function parameters.

Makes sense, thanks.
>
>>   {
>> -    struct vm_area_struct *vma = vmf->vma;
>> -    struct folio *folio = page_folio(page);
>> -    pgtable_t pgtable;
>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> -    vm_fault_t ret = 0;
>> +    const int order = HPAGE_PMD_ORDER;
>> +    struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, 
>> true);
>>   -    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> +    if (unlikely(!folio)) {
>> +        count_vm_event(THP_FAULT_FALLBACK);
>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>> +        goto out;
>> +    }
>>   +    VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>       if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>>           folio_put(folio);
>>           count_vm_event(THP_FAULT_FALLBACK);
>>           count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>> -        count_mthp_stat(HPAGE_PMD_ORDER, 
>> MTHP_STAT_ANON_FAULT_FALLBACK);
>> -        count_mthp_stat(HPAGE_PMD_ORDER, 
>> MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> -        return VM_FAULT_FALLBACK;
>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>> +        count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> +        goto out;
>>       }
>>       folio_throttle_swaprate(folio, gfp);
>>   -    pgtable = pte_alloc_one(vma->vm_mm);
>> -    if (unlikely(!pgtable)) {
>> -        ret = VM_FAULT_OOM;
>> -        goto release;
>> -    }
>> -
>> -    folio_zero_user(folio, vmf->address);
>> +    folio_zero_user(folio, addr);
>>       /*
>>        * The memory barrier inside __folio_mark_uptodate makes sure that
>>        * folio_zero_user writes become visible before the set_pmd_at()
>>        * write.
>>        */
>>       __folio_mark_uptodate(folio);
>> +out:
>> +    return folio;
>> +}
>> +
>> +static void __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
>> +{
>> +    count_vm_event(THP_FAULT_ALLOC);
>> +    count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
>> +    count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>> +}
>
> Why isn't that moved into map_pmd_thp()
>
> Note that in this patch you do:
>
> map_pmd_thp(folio, vmf, vma, haddr);
> spin_unlock(vmf->ptl);
> __pmd_thp_fault_success_stats(vma);
>
> But in patch #2
>
> map_pmd_thp(folio, vmf, vma, haddr);
> __pmd_thp_fault_success_stats(vma);
> goto unlock;
> release:
>     folio_put(folio);
> unlock:
>     spin_unlock(vmf->ptl);

Yes, while writing it I knew about this inconsistency, but I wanted
to reduce latency by dropping the lock before. But in do_huge_zero_wp_pmd(),
I couldn't figure out a way to call the stat function after dropping the 
lock,
without I guess, introducing too many labels and goto jumps and the 
like. In the
current code, the lock gets dropped first.

>
> Please make that consistent, meaning:
>
> 1) Inline __pmd_thp_fault_success_stats() into map_pmd_thp(). No need 
> to have the separated out.
>
> 2) Either do the PTL unlocking in __pmd_thp_fault_success_stats() or in
>    the caller. In the caller is likely easiest. Adjusting the counters
>    should be cheap, if not we could revisit this later with real data.

I will then call it in map_pmd_thp(), that is cleaner...I did find 
occurrences
of these stat computations after taking the lock, for example, in 
do_swap_page():
count_vm_event(PGMAJFAULT)
so I guess it should be alright.
>
>> +
>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>> +            struct vm_area_struct *vma, unsigned long haddr)
>> +{
>> +    pmd_t entry;
>> +
>> +    entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>> +    entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>> +    folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>> +    folio_add_lru_vma(folio, vma);
>> +    set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>> +    update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>
> It's quite weird to see a mixture of haddr and vmf->address, and 
> likely this mixture is wrong or not not required.
>
> Looking at arc's update_mmu_cache_pmd() implementation, I cannot see 
> how passing in the unaligned address would do the right thing. But 
> maybe arc also doesn't trigger that code path ... who knows :)
>
>
> Staring at some other update_mmu_cache_pmd() users, it's quite 
> inconsistent. Primarily only do_huge_pmd_numa_page() and 
> __do_huge_pmd_anonymous_page() use the unaligned address. The others 
> seem to use the aligned address ... as one would expect when modifying 
> a PMD.
>
>
> I suggest to change this function to *not* pass in the vmf, and rename 
> it to something like:
>
> static void folio_map_anon_pmd(struct folio *folio, struct 
> vm_area_struct *vma, pmd_t *pmd, unsigned long haddr)
>
> Then use haddr also to do the update_mmu_cache_pmd().

The code I changed, already was passing vmf->address to 
update_mmu_cache_pmd().
I did not change any of the haddr and vmf->address semantics, so really 
can't comment
on this.
I agree with the name change; vmf will be required for 
set_pmd_at(vmf->pmd), so I should
just pass pmd?
>
>> +    add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>> +    mm_inc_nr_ptes(vma->vm_mm);
>> +}
>> +
>> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>> +{
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    struct folio *folio;
>> +    pgtable_t pgtable;
>> +    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> +    vm_fault_t ret = 0;
>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>
> Nit: While at it, try to use reverse christmas-tree where possible, 
> makes things more reasible. You could make haddr const.
>
> struct vm_area_struct *vma = vmf->vma;
> unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> gfp_t gfp = vma_thp_gfp_mask(vma);
> struct folio *folio;
> vm_fault_t ret = 0;

Okay.
> ...
>
>> +
>> +    folio = pmd_thp_fault_alloc(gfp, vma, haddr, vmf->address);
>> +    if (unlikely(!folio)) {
>> +        ret = VM_FAULT_FALLBACK;
>> +        goto release;
>> +    }
>> +
>> +    pgtable = pte_alloc_one(vma->vm_mm);
>> +    if (unlikely(!pgtable)) {
>> +        ret = VM_FAULT_OOM;
>> +        goto release;
>> +    }
>>         vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>> +
>
> Nit Unrelated change.

Are you asking me to align this line with the below line?
>
>>       if (unlikely(!pmd_none(*vmf->pmd))) {
>>           goto unlock_release;
>
>

