Return-Path: <linux-kernel+bounces-336537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963F7983C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B9D1C2251E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80B2941B;
	Tue, 24 Sep 2024 04:25:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2981B85F3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 04:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727151939; cv=none; b=LHQtwBbojOf2QlCWtQv9HaJMPJXhu+uV6db/4Proa4vdOfWuWIiVRba08WXqXp+Qwfyfxcv++aT0+/TncYDDk6aHURgy5IeUSORwCokVnNGCS0ryOf4+F32ZAQe4P4cHxeFmC+Uj57JfTDsuPReChWbKrUhlHKO5mM2RV3PqHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727151939; c=relaxed/simple;
	bh=jm/S5yBrco1Lc14UFVlSLyQId+iyOtIauVtBH6muxOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsj1qtrXER/W/tGepFQ5E7CiuKt0KNtpGGpzLHsPOi9PdPriDTHNrEt1LjAf2yn1lE/c4FUmu5Dxkwm/MWLGo7ovQGKGwAmAmbPz3z+xGI7fSt7AHVhItezicDS+QV4orye6jZMjy2ByPWIKM/Aaak+pbbTy7XsovmsbYm9TFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CF9DA7;
	Mon, 23 Sep 2024 21:26:05 -0700 (PDT)
Received: from [10.162.43.15] (e116581.arm.com [10.162.43.15])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D75B3F6A8;
	Mon, 23 Sep 2024 21:25:27 -0700 (PDT)
Message-ID: <2200396e-9f70-41ac-b8cb-c207501a7770@arm.com>
Date: Tue, 24 Sep 2024 09:55:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] mm: Abstract THP allocation
To: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240916094309.1226908-1-dev.jain@arm.com>
 <20240916094309.1226908-2-dev.jain@arm.com>
 <74089a2f-8918-4c01-8374-494bb8da906a@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <74089a2f-8918-4c01-8374-494bb8da906a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/17/24 17:17, David Hildenbrand wrote:
> On 16.09.24 11:43, Dev Jain wrote:
>> In preparation for the second patch, abstract away the THP allocation
>> logic present in the create_huge_pmd() path, which corresponds to the
>> faulting case when no page is present.
>>
>> There should be no functional change as a result of applying this patch,
>> except that, as David notes at [1], a PMD-aligned address should
>> be passed to update_mmu_cache_pmd().
>>
>> [1]: 
>> https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/huge_memory.c | 108 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 66 insertions(+), 42 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2a73efea02d7..cdc632b8dc9c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1146,47 +1146,88 @@ unsigned long thp_get_unmapped_area(struct 
>> file *filp, unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>   -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>> -            struct page *page, gfp_t gfp)
>> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct 
>> *vma,
>> +                          unsigned long addr)
>>   {
>> -    struct vm_area_struct *vma = vmf->vma;
>> -    struct folio *folio = page_folio(page);
>> -    pgtable_t pgtable;
>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> -    vm_fault_t ret = 0;
>> +    unsigned long haddr = addr & HPAGE_PMD_MASK;
>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
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
>> +        return NULL;
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
> just inline that into map_anon_folio_pmd(), please. map_anon_folio_pmd 
> is perfectly readable ;)

If you are asking me to open code it in map_anon_folio_pmd(), I'll do that.
>
>> +
>> +static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
>> +                   struct vm_area_struct *vma, unsigned long haddr)
>
>
>> +{
>> +    pmd_t entry;
>> +
>> +    entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>> +    entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>> +    folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>> +    folio_add_lru_vma(folio, vma);
>> +    set_pmd_at(vma->vm_mm, haddr, pmd, entry);
>> +    update_mmu_cache_pmd(vma, haddr, pmd);
>> +    add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>> +    __pmd_thp_fault_success_stats(vma);
>> +}
>> +
>> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>> +{
>> +    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    pgtable_t pgtable = NULL;
>> +    struct folio *folio;
>> +    vm_fault_t ret = 0;
>> +
>> +    folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
>> +    if (unlikely(!folio)) {
>> +        ret = VM_FAULT_FALLBACK;
>> +        goto release;
>
> Why not simply "return VM_FAULT_FALLBACK;" ? There is nothing to 
> release. Then you can avoid the
>
> "if (folio)" below and even stop initializing pgtable to NULL.

Makes sense.
>
>
> With these things take care of
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

