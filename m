Return-Path: <linux-kernel+bounces-316656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 556B896D267
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93A5287304
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4D194A60;
	Thu,  5 Sep 2024 08:45:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5297F14F9E9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525926; cv=none; b=RNWmS1Hi3WwQh9kxsImEpFQHiJ/k2ij+eBSKGMOLmY/BqQcdgOtpIDZKvRY6sy6P/ZcUN4IBrvOEUMPQ0V+z2y0kGUdUlLrGrZQUUyHQz14HBA9Vqh9nWkyTeRQHMu92JQ7acnyfcgGXA1aBKpErOcU9bDTzq7U5r7U085gsPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525926; c=relaxed/simple;
	bh=MkDuBR6hbgfpXsBzK9CMwzjKAgPYgPG+h6BYk/5j4S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q4v3N9LzycpRdeIWmZFLPYBcLPXKjd+RYVXYym1i+sbjkCfXNOdyZaOdxrqhSrbs+TwRLOVYWb5UIA14JYJWbVgYyifT5zefrmOb0LVBfZd9FWbXLPNMC7edqJ9MMahwoP2Af7DXAnrhpU8QGnZaaetGq6S6thHMY266Ll1hsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC1D0FEC;
	Thu,  5 Sep 2024 01:45:49 -0700 (PDT)
Received: from [10.162.43.13] (e116581.arm.com [10.162.43.13])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1EB3F66E;
	Thu,  5 Sep 2024 01:45:14 -0700 (PDT)
Message-ID: <0c417434-94a8-4b1c-b798-47da6ccf964f@arm.com>
Date: Thu, 5 Sep 2024 14:15:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm: Abstract THP allocation
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
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
 <20240904100923.290042-2-dev.jain@arm.com>
 <spkiynphi76p7bybswvxypro6pkbm7h4jtt2niwg6laqhrwamx@bojwcg3wkviq>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <spkiynphi76p7bybswvxypro6pkbm7h4jtt2niwg6laqhrwamx@bojwcg3wkviq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/5/24 13:50, Kirill A. Shutemov wrote:
> On Wed, Sep 04, 2024 at 03:39:22PM +0530, Dev Jain wrote:
>> In preparation for the second patch, abstract away the THP allocation
>> logic present in the create_huge_pmd() path, which corresponds to the
>> faulting case when no page is present.
>>
>> There should be no functional change as a result of applying
>> this patch.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/huge_memory.c | 110 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 67 insertions(+), 43 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 67c86a5d64a6..58125fbcc532 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -943,47 +943,89 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>>   }
>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>   
>> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>> -			struct page *page, gfp_t gfp)
>> +static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
>> +				  unsigned long haddr, struct folio **foliop,
>> +				  unsigned long addr)
> foliop is awkward.
>
> Why not return folio? NULL would indicate to the caller to fallback.

I took inspiration from other call sites like mfill_atomic_pte_copy() which
have a double pointer to the folio. If we do as you say, then in thp_fault_alloc(),
we will have to do all the fallback stat computation, and return the folio, then
check in the caller whether that is NULL, then set ret = VM_FAULT_FALLBACK, then
goto out/release. Basically, stat computation for fallback, and the actual setting
of return value to fallback would get separated. Currently, I can simultaneously
set the folio pointer and the return value.

>
>>   {
>> -	struct vm_area_struct *vma = vmf->vma;
>> -	struct folio *folio = page_folio(page);
>> -	pgtable_t pgtable;
>> -	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> -	vm_fault_t ret = 0;
>> +	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>>   
>> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>> +	*foliop = folio;
>> +	if (unlikely(!folio)) {
>> +		count_vm_event(THP_FAULT_FALLBACK);
>> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>> +		return VM_FAULT_FALLBACK;
>> +	}
>>   
>> +	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>   	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>>   		folio_put(folio);
>>   		count_vm_event(THP_FAULT_FALLBACK);
>>   		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
>> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
>> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
>> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>>   		return VM_FAULT_FALLBACK;
>>   	}
>>   	folio_throttle_swaprate(folio, gfp);
>>   
>> -	pgtable = pte_alloc_one(vma->vm_mm);
>> -	if (unlikely(!pgtable)) {
>> -		ret = VM_FAULT_OOM;
>> -		goto release;
>> -	}
>> -
>> -	folio_zero_user(folio, vmf->address);
>> +	folio_zero_user(folio, addr);
>>   	/*
>>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
>>   	 * folio_zero_user writes become visible before the set_pmd_at()
>>   	 * write.
>>   	 */
>>   	__folio_mark_uptodate(folio);
>> +	return 0;
>> +}
>> +
>> +static void __thp_fault_success_stats(struct vm_area_struct *vma, int order)
>> +{
>> +	count_vm_event(THP_FAULT_ALLOC);
>> +	count_mthp_stat(order, MTHP_STAT_ANON_FAULT_ALLOC);
>> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>> +}
>> +
>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>> +			struct vm_area_struct *vma, unsigned long haddr,
>> +			pgtable_t pgtable)
>> +{
>> +	pmd_t entry;
>> +
>> +	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>> +	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>> +	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>> +	folio_add_lru_vma(folio, vma);
>> +	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>> +	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>> +	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>> +	mm_inc_nr_ptes(vma->vm_mm);
>> +}
>> +
>> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	struct folio *folio = NULL;
>> +	pgtable_t pgtable;
>> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> +	vm_fault_t ret = 0;
>> +	gfp_t gfp = vma_thp_gfp_mask(vma);
>> +
>> +	pgtable = pte_alloc_one(vma->vm_mm);
>> +	if (unlikely(!pgtable)) {
>> +		ret = VM_FAULT_OOM;
>> +		goto release;
>> +	}
>> +
>> +	ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
>> +			      vmf->address);
>> +	if (ret)
>> +		goto release;
> THP page allocation has higher probability to fail than pgtable allocation. It
> is better to allocate it first, before pgtable and do less work on error
> path.

Thanks, makes sense.


