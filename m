Return-Path: <linux-kernel+bounces-324940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E237F9752F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFFE1C22954
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F037E18EFC6;
	Wed, 11 Sep 2024 12:55:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6032186E24
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059350; cv=none; b=tCiuUUcglHBs7O0jSb01vJUHjs2GP3ZmcyAOBf5eO5z4zJNZNV0wlkjlYyEuG6yEbZZoX71xJFIp4LfeMWjUKTbrZ3oE814KA19Z468GjU5P9KlmOPrXTUkXqKv6CLXw8tOrLM3r0+vn64+O4kOxWIMZQ4Rue4VrHUT4BWyeqgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059350; c=relaxed/simple;
	bh=CVbBSshLzANXCgTPqq0L+TtE6iP2AsyUqYxsji9HqiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFokb1BYKIVrvoRMho51rHI8nuOjpK11Y9Bzm5LDr0HmCKE9KEFDelAvx2JP1mDorpFSrhMGgmrOutXYIPjhXNc9Kx9KW0252nE9WKU9KzsSpYI+UDz923QW/55vEFV87oKN4wNkkQjuaWOlyOOHmvZ2DfTfRxCCH4ORqmjgNZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E3A91007;
	Wed, 11 Sep 2024 05:56:17 -0700 (PDT)
Received: from [10.162.40.31] (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD6BF3F66E;
	Wed, 11 Sep 2024 05:55:39 -0700 (PDT)
Message-ID: <4b981fae-0f40-4338-990f-839a39c3c190@arm.com>
Date: Wed, 11 Sep 2024 18:25:36 +0530
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
 <552e9b77-c1ea-4a60-8434-e360ca692f1f@arm.com>
 <18271c5b-d190-448a-b513-34c20de1dcd2@redhat.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <18271c5b-d190-448a-b513-34c20de1dcd2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/24 18:05, David Hildenbrand wrote:
> [...]
>
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
>>>
>>>
>>> Staring at some other update_mmu_cache_pmd() users, it's quite
>>> inconsistent. Primarily only do_huge_pmd_numa_page() and
>>> __do_huge_pmd_anonymous_page() use the unaligned address. The others
>>> seem to use the aligned address ... as one would expect when modifying
>>> a PMD.
>>>
>>>
>>> I suggest to change this function to *not* pass in the vmf, and rename
>>> it to something like:
>>>
>>> static void folio_map_anon_pmd(struct folio *folio, struct
>>> vm_area_struct *vma, pmd_t *pmd, unsigned long haddr)
>>>
>>> Then use haddr also to do the update_mmu_cache_pmd().
>>
>> The code I changed, already was passing vmf->address to
>> update_mmu_cache_pmd().
>> I did not change any of the haddr and vmf->address semantics, so really
>> can't comment
>> on this.
>
> I'm not saying that you changed it. I say, "we touch it we fix it" :). 
> We could do that in a separate cleanup patch upfront.

Sure.
>
>> I agree with the name change; vmf will be required for
>> set_pmd_at(vmf->pmd), so I should
>> just pass pmd?
>>>
>>>> +    add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
>>>> +    mm_inc_nr_ptes(vma->vm_mm);
>>>> +}
>>>> +
>>>> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>>>> +{
>>>> +    struct vm_area_struct *vma = vmf->vma;
>>>> +    struct folio *folio;
>>>> +    pgtable_t pgtable;
>>>> +    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>>> +    vm_fault_t ret = 0;
>>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>>
>>> Nit: While at it, try to use reverse christmas-tree where possible,
>>> makes things more reasible. You could make haddr const.
>>>
>>> struct vm_area_struct *vma = vmf->vma;
>>> unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> gfp_t gfp = vma_thp_gfp_mask(vma);
>>> struct folio *folio;
>>> vm_fault_t ret = 0;
>>
>> Okay.
>>> ...
>>>
>>>> +
>>>> +    folio = pmd_thp_fault_alloc(gfp, vma, haddr, vmf->address);
>>>> +    if (unlikely(!folio)) {
>>>> +        ret = VM_FAULT_FALLBACK;
>>>> +        goto release;
>>>> +    }
>>>> +
>>>> +    pgtable = pte_alloc_one(vma->vm_mm);
>>>> +    if (unlikely(!pgtable)) {
>>>> +        ret = VM_FAULT_OOM;
>>>> +        goto release;
>>>> +    }
>>>>          vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>>>> +
>>>
>>> Nit Unrelated change.
>>
>> Are you asking me to align this line with the below line?
>
> No, just pointing out that you add a newline in a code section you 
> don't really touch. Sometimes that's deliberate, sometimes not (e.g., 
> going back and forth while reworking the code and accidentally leaving 
> that in). We try to avoid such unrelated changes because it adds noise 
> to the patches.
>
> If it was deliberate, feel free to leave it in.

Ah, I accidentally inserted that new line. Will revert that.

