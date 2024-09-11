Return-Path: <linux-kernel+bounces-324845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F3975178
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9131A1F22708
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED47187355;
	Wed, 11 Sep 2024 12:10:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102C073477
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056635; cv=none; b=TVJmeFRnokkxRhf2G6M2jZgfo2sBdo/V9gbD3xgm1fy1F+0T2ZhAnSHqc9rEX9viA7NygBFvMmOGXjxpytHypPUQ2DRcpaVwbcgwi/oliQLjVGbarDfvrUnmaJ2dVNxZmm0PwWqLPng5CnaCYxoRA63sMwqM2H3B76raDccHOvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056635; c=relaxed/simple;
	bh=XI5tV5mH/TPoSHCNERB+6K+91rheC8sGH1tDtczbpoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OG6ANYeTPj9Oh49du3TRH9szuPrbdW+5zq0V979DP9EvWst4hkw2Vl1M3xZuA4AB0arjkHI0XmSTvPGNhqsGzH99pAzwdhnwIDDFXfC3+xFTdxefz42IMZ/pq25dq9MPVBm+ZKBIOfrjjRSYc6gp8jUmI8EEg0KEy4XyyjxpNHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB9491007;
	Wed, 11 Sep 2024 05:11:01 -0700 (PDT)
Received: from [10.162.40.31] (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F27653F66E;
	Wed, 11 Sep 2024 05:10:23 -0700 (PDT)
Message-ID: <e160b45b-7220-47d0-83a3-9403ffb85bbe@arm.com>
Date: Wed, 11 Sep 2024 17:40:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm: Allocate THP on hugezeropage wp-fault
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
 <20240911065600.1002644-3-dev.jain@arm.com>
 <783a0d91-2910-4446-a979-c681dde402ec@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <783a0d91-2910-4446-a979-c681dde402ec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/24 15:06, David Hildenbrand wrote:
> On 11.09.24 08:56, Dev Jain wrote:
>> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
>> replace it with a PMD-mapped THP. Change the helper introduced in the
>> previous patch to flush TLB entry corresponding to the hugezeropage.
>> In case of failure, fallback to splitting the PMD.
>>
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>> ---
>>   mm/huge_memory.c | 52 +++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index b96a1ff2bf40..3e28946a805f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -987,16 +987,20 @@ static void 
>> __pmd_thp_fault_success_stats(struct vm_area_struct *vma)
>>   static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>               struct vm_area_struct *vma, unsigned long haddr)
>>   {
>> -    pmd_t entry;
>> +    pmd_t entry, old_pmd;
>> +    bool is_pmd_none = pmd_none(*vmf->pmd);
>>         entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>       entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>       folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>       folio_add_lru_vma(folio, vma);
>> +    if (!is_pmd_none)
>> +        old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
>
> This should likely be done in the caller.
>
>>       set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>       update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>       add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>> -    mm_inc_nr_ptes(vma->vm_mm);
>> +    if (is_pmd_none)
>> +        mm_inc_nr_ptes(vma->vm_mm);
>
> And this as well.
>
> No need to make this function deal with this if the callers exactly 
> know what they are doing.

Sure, thanks.


>
>>   }
>>     static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>> @@ -1576,6 +1580,41 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>>       spin_unlock(vmf->ptl);
>>   }
>>   +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, 
>> unsigned long haddr)
>
> Is there a need to pass in "haddr" if we have the vmf?

Was passing it because it was getting used many times. But nowhere do vmf
and haddr get both passed in the codebase, so I'll drop it for 
cleanliness and
consistency.

>
>> +{
>> +    struct vm_area_struct *vma = vmf->vma;
>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>> +    struct mmu_notifier_range range;
>> +    struct folio *folio;
>> +    vm_fault_t ret = 0;
>> +
>> +    folio = pmd_thp_fault_alloc(gfp, vma, haddr, vmf->address);
>> +    if (unlikely(!folio)) {
>> +        ret = VM_FAULT_FALLBACK;
>> +        goto out;
>> +    }
>> +
>> +    mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, 
>> haddr,
>> +                haddr + HPAGE_PMD_SIZE);
>> +    mmu_notifier_invalidate_range_start(&range);
>> +    vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>> +    if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
>> +        goto release;
>> +    ret = check_stable_address_space(vma->vm_mm);
>> +    if (ret)
>> +        goto release;
>
> The clear+flush really belongs here.
>
>> +    map_pmd_thp(folio, vmf, vma, haddr);
>> +    __pmd_thp_fault_success_stats(vma);
>> +    goto unlock;
>> +release:
>> +    folio_put(folio);
>> +unlock:
>> +    spin_unlock(vmf->ptl);
>> +    mmu_notifier_invalidate_range_end(&range);
>> +out:
>> +    return ret;
>> +}
>> +
>

