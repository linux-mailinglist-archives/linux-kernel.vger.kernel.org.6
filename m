Return-Path: <linux-kernel+bounces-324962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC559975332
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C8B27B62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8162199FB1;
	Wed, 11 Sep 2024 13:05:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70E199926
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059949; cv=none; b=d+y+SFrMMbCSzCmazFHarym4TJ94tr9O8xDK7beEbbbWB8mS1YiUYFeOTaspsLGeRjHGI65vrB4IvpCiy4jO/OtzELM52Gwm6vW1jpSzLfSgnRYAA1k8de+gvgNMTehLMOo94cV/CYfW0Hq3nu2PDikGU2s95H6okYyYyZH7bWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059949; c=relaxed/simple;
	bh=EoT//HMMLf4ZtjU0y9nGFFQRNneXm5Do5hepCVHxsJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP/2ZePEcwUoIz5eQfHW4Y9TfBysfFrmtf3zm+kEzgH4TOvw12R9uj1y7zdNnuUieYkIuBvSvCioEBEm++V+mBysFftXSalrRfBhCjG/0o3xyn8HILOjE+4rDB5i/IB9/IrhxDtvx522z7siou1N80GPsXvR11WyVZTOM6PL5cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F30541007;
	Wed, 11 Sep 2024 06:06:15 -0700 (PDT)
Received: from [10.162.40.31] (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E3463F66E;
	Wed, 11 Sep 2024 06:05:37 -0700 (PDT)
Message-ID: <62df853c-98fb-4900-9cc6-04208e9611c6@arm.com>
Date: Wed, 11 Sep 2024 18:35:35 +0530
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
 <8bc0e51b-0e9b-4eeb-997f-e2a0b1a0c0f8@arm.com>
 <ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/24 18:30, David Hildenbrand wrote:
> On 11.09.24 14:53, Dev Jain wrote:
>>
>> On 9/11/24 14:57, David Hildenbrand wrote:
>>> On 11.09.24 08:55, Dev Jain wrote:
>>>> In preparation for the second patch, abstract away the THP allocation
>>>> logic present in the create_huge_pmd() path, which corresponds to the
>>>> faulting case when no page is present.
>>>>
>>>> There should be no functional change as a result of applying
>>>> this patch.
>>>>
>>>
>>> [...]
>>>
>>>> +
>>>> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
>>>> +            struct vm_area_struct *vma, unsigned long haddr)
>>>> +{
>>>> +    pmd_t entry;
>>>> +
>>>> +    entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>>>> +    entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>>>> +    folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>>>> +    folio_add_lru_vma(folio, vma);
>>>> +    set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>>>> +    update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>>>
>>> It's quite weird to see a mixture of haddr and vmf->address, and
>>> likely this mixture is wrong or not not required.
>>>
>>> Looking at arc's update_mmu_cache_pmd() implementation, I cannot see
>>> how passing in the unaligned address would do the right thing. But
>>> maybe arc also doesn't trigger that code path ... who knows :)
>>
>> If I am reading correctly, arch/arc/mm/tlb.c: update_mmu_cache_pmd()
>> calls update_mmu_cache_range() which is already expecting an unaligned
>> address? But...
>
> So update_mmu_cache_pmd() calls
>
>     update_mmu_cache_range(NULL, vma, addr, &pte, HPAGE_PMD_NR);
>
> But update_mmu_cache_range() only aligns it *to page boundary*:
>
>     unsigned long vaddr = vaddr_unaligned & PAGE_MASK;

Ah, totally missed that it was PAGE_MASK. Thanks.
>
> We obtain the correct hugepage-aligned physical address from the PTE
>
>     phys_addr_t paddr = pte_val(*ptep) & PAGE_MASK_PHYS;
>
> Then, we look at the offset in our folio
>
>     unsigned long offset = offset_in_folio(folio, paddr);
>
> And adjust both vaddr and paddr
>
>     paddr -= offset;
>     vaddr -= offset;
>
> To then use that combination with
>
>     __inv_icache_pages(paddr, vaddr, nr);
>
> If I am not wrong, getting a non-hugepage aligned vaddr messes up 
> things here. But only regarding the icache I think.

Looks like it...
>
>

