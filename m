Return-Path: <linux-kernel+bounces-324935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77459752EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85D30283E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0101C18EFC6;
	Wed, 11 Sep 2024 12:54:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A7EC4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059241; cv=none; b=Oeid1gKxnbUTcVgcVikRliFIOABuzDCHfD8V/p6dV9w4Jq9LYIgYaKYsm180eKLSTkTqhVvHEZ5NtrRXPIu4qH9mOiHrRfsrPTJVXG3yiptxCvA8QVAI2E5cZAOPd/9RHTdmr/NlJ1YToq5WwrL7WqU7pJelOkX/7RkI+Fugawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059241; c=relaxed/simple;
	bh=14D//i72PG0G7UWjz8E2+D9dNoF5n7L+kd8QQ9Lwrms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llAn/HCcpeMGE/n6MUdpRcCFtMD01HnXJkMBllTV47BAXDabsXqursQaJmaAB1UmpY2ZSrHPjiC4JEcwvA0HjqCtDAOSNX93Du4x1sQdCwOM642lo4RpvCFuF2/sY0seUExkqMbhFtHOA0EZSm9m8FaWOdgDrW4h33OdU3qBkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 560CF1007;
	Wed, 11 Sep 2024 05:54:28 -0700 (PDT)
Received: from [10.162.40.31] (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777F43F66E;
	Wed, 11 Sep 2024 05:53:50 -0700 (PDT)
Message-ID: <8bc0e51b-0e9b-4eeb-997f-e2a0b1a0c0f8@arm.com>
Date: Wed, 11 Sep 2024 18:23:47 +0530
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
> [...]
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

If I am reading correctly, arch/arc/mm/tlb.c: update_mmu_cache_pmd() 
calls update_mmu_cache_range() which is already expecting an unaligned 
address? But...
>
>
> Staring at some other update_mmu_cache_pmd() users, it's quite 
> inconsistent. Primarily only do_huge_pmd_numa_page() and 
> __do_huge_pmd_anonymous_page() use the unaligned address. The others 
> seem to use the aligned address ... as one would expect when modifying 
> a PMD.

Looking at riscv: 
update_mmu_cache_pmd()->update_mmu_cache()->update_mmu_cache_range(). 
The argument getting passed to local_flush_tlb_page() seems like, should 
expect an aligned address.
>
>
> I suggest to change this function to *not* pass in the vmf, and rename 
> it to something like:
>
> static void folio_map_anon_pmd(struct folio *folio, struct 
> vm_area_struct *vma, pmd_t *pmd, unsigned long haddr)
>
> Then use haddr also to do the update_mmu_cache_pmd().
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
>
>>       if (unlikely(!pmd_none(*vmf->pmd))) {
>>           goto unlock_release;
>
>

