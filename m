Return-Path: <linux-kernel+bounces-316778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A35EE96D493
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EDD1F267A6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8C119885E;
	Thu,  5 Sep 2024 09:53:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4A714A08E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530019; cv=none; b=WX0CWjUIn8xFwlfbRt0whPr1OJCP7o+JnhxKRg3JT2Ks1jj1GeSU6jn4FkM5pJnuDiZtyvfGY29vZtZ6VZHlO1Ro2MRRXwtLMiBA8po4tgUM+Z1eyCtu9cLduZSy08qJppDdNg3Cldiy2zoyXNcVR7t9IJ5OV6LTfEf4fpm6n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530019; c=relaxed/simple;
	bh=0ZT5WqZZKMDdFHpSnLPDdZichFbYrgF4/HfCPaPGVF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmhsZBs8h1OpyaJk5REuBnxQ80HhDizx/EoAA3RoRpnoawhgy0pszdj8wR1ieV3bHcyJ0B6uQAFdSmyS8fGOInBXL7mJthZIyDE+/gbuP9R2PpQ5YjKrqI1W/bMq3cDj1vAgcsRH0YLRRYeBP5d5OQ6Q5iFusuMlT8nm5EzCp9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 258ABFEC;
	Thu,  5 Sep 2024 02:54:03 -0700 (PDT)
Received: from [10.162.43.13] (e116581.arm.com [10.162.43.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DFED3F73F;
	Thu,  5 Sep 2024 02:53:27 -0700 (PDT)
Message-ID: <fe8f9d0e-3c79-449c-98ae-7134ffbb7ffd@arm.com>
Date: Thu, 5 Sep 2024 15:23:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm: Allocate THP on hugezeropage wp-fault
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
 ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240904100923.290042-1-dev.jain@arm.com>
 <20240904100923.290042-3-dev.jain@arm.com>
 <xs7lw544kk6ftxlg6lbjicxnu5mdn666ivld5kzznm7fkoaf2x@4jowgzwfzcof>
 <ec6a60e5-1b8a-477a-a2d6-7c89c2f68ac2@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ec6a60e5-1b8a-477a-a2d6-7c89c2f68ac2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/24 15:11, Kefeng Wang wrote:
>
>
> On 2024/9/5 16:26, Kirill A. Shutemov wrote:
>> On Wed, Sep 04, 2024 at 03:39:23PM +0530, Dev Jain wrote:
>>> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage 
>>> and
>>> replace it with a PMD-mapped THP. Change the helpers introduced in the
>>> previous patch to flush TLB entry corresponding to the hugezeropage,
>>> and preserve PMD uffd-wp marker. In case of failure, fallback to
>>> splitting the PMD.
>
> We met same issue, and a very similar function in our kernel,
>>>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   include/linux/huge_mm.h |  6 ++++
>>>   mm/huge_memory.c        | 79 
>>> +++++++++++++++++++++++++++++++++++------
>>>   mm/memory.c             |  5 +--
>>>   3 files changed, 78 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index e25d9ebfdf89..fdd2cf473a3c 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -9,6 +9,12 @@
>>>   #include <linux/kobject.h>
>>>     vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>>> +vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct 
>>> vm_area_struct *vma,
>>> +               unsigned long haddr, struct folio **foliop,
>>> +               unsigned long addr);
>>> +void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>> +         struct vm_area_struct *vma, unsigned long haddr,
>>> +         pgtable_t pgtable);
>>
>> Why? I don't see users outside huge_memory.c.
>>
>>>   int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>>             pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
>>>             struct vm_area_struct *dst_vma, struct vm_area_struct 
>>> *src_vma);
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 58125fbcc532..150163ad77d3 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -943,9 +943,9 @@ unsigned long thp_get_unmapped_area(struct file 
>>> *filp, unsigned long addr,
>>>   }
>>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>>   -static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct 
>>> vm_area_struct *vma,
>>> -                  unsigned long haddr, struct folio **foliop,
>>> -                  unsigned long addr)
>>> +vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct 
>>> vm_area_struct *vma,
>>> +               unsigned long haddr, struct folio **foliop,
>>> +               unsigned long addr)
>>>   {
>>>       struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, 
>>> true);
>>>   @@ -984,21 +984,29 @@ static void __thp_fault_success_stats(struct 
>>> vm_area_struct *vma, int order)
>>>       count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>>>   }
>>>   -static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>> -            struct vm_area_struct *vma, unsigned long haddr,
>>> -            pgtable_t pgtable)
>>> +void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>> +         struct vm_area_struct *vma, unsigned long haddr,
>>> +         pgtable_t pgtable)
>>>   {
>>> -    pmd_t entry;
>>> +    pmd_t entry, old_pmd;
>>> +    bool is_pmd_none = pmd_none(*vmf->pmd);
>>>         entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>>       entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>>       folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>>       folio_add_lru_vma(folio, vma);
>>> -    pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>> +    if (!is_pmd_none) {
>>> +        old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
>>> +        if (pmd_uffd_wp(old_pmd))
>>> +            entry = pmd_mkuffd_wp(entry);
>>> +    }
>>> +    if (pgtable)
>>> +        pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>>>       set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>>       update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>>       add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>> -    mm_inc_nr_ptes(vma->vm_mm);
>>> +    if (is_pmd_none)
>>> +        mm_inc_nr_ptes(vma->vm_mm);
>>>   }
>>>     static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault 
>>> *vmf)
>>> @@ -1576,6 +1584,50 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>>>       spin_unlock(vmf->ptl);
>>>   }
>>>   +static vm_fault_t do_huge_zero_wp_pmd_locked(struct vm_fault *vmf,
>>> +                         unsigned long haddr,
>>> +                         struct folio *folio)
>>
>> Why the helper is needed? Cannot it be just opencodded in
>> do_huge_zero_wp_pmd()?
>>
>>> +{
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    vm_fault_t ret = 0;
>>> +
>>> +    ret = check_stable_address_space(vma->vm_mm);
>>> +    if (ret)
>>> +        goto out;
>>> +    map_pmd_thp(folio, vmf, vma, haddr, NULL);
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>> +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, 
>>> unsigned long haddr)
>>> +{
>>> +    struct vm_area_struct *vma = vmf->vma;
>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>> +    struct mmu_notifier_range range;
>>> +    struct folio *folio = NULL;
>>> +    vm_fault_t ret = 0;
>>> +
>>> +    ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
>>> +                  vmf->address);
>>> +    if (ret)
>>> +        goto out;
>>> +
>>> +    mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, 
>>> vma->vm_mm, haddr,
>>> +                haddr + HPAGE_PMD_SIZE);
>>> +    mmu_notifier_invalidate_range_start(&range);
>>> +    vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>> +    if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
>>> +        goto unlock;
>>> +    ret = do_huge_zero_wp_pmd_locked(vmf, haddr, folio);
>>> +    if (!ret)
>>> +        __thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
>>> +unlock:
>>> +    spin_unlock(vmf->ptl);
>>> +    mmu_notifier_invalidate_range_end(&range);
>
> the folio need to released when !pmd_same() and 
> check_stable_address_space() return VM_FAULT_SIGBUS.

Yes, thanks.
>
>>> +out:
>>> +    return ret;
>>> +}
>>> +
>>>
>>

