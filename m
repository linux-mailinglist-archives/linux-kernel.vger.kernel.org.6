Return-Path: <linux-kernel+bounces-324874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB089751EA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0953728247F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AE91885B4;
	Wed, 11 Sep 2024 12:22:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D47176FD2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057347; cv=none; b=M/3k4PWLeEr2iJLAn8LtJ0i85bFb4/Dxkm0hu6wBIQqvWQe17KiC0bU8caMOL0MAJEY9WhqmJI9ddLGjFz1UXhFEzk1kMKDCDbckMDsjfixH/1T0c8GReS5ywjmBPZ9oO97BtywjGSOac4I8aeMBi7iWPhneDea0YfjFkWMVZow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057347; c=relaxed/simple;
	bh=v42Sj9D6OaSFuhsPueUxpnxKAyovlkCpVn2GHtI5AkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8QVgjTdL2xxmpeBiTRuPEtYywtCaoSk3RysBYDDxewIm5mTo+2gCNfSMcUMqXCIZvrqJgnNlb+ijgnO317yyh45M53oD2nALMZ9CAaU2aSdIhVyoQS1yp9r97qxVOiqnqRzVmItSVSoMQbdAenFfbF1fKkIQr3BzKWLgVykmXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3122F1007;
	Wed, 11 Sep 2024 05:22:55 -0700 (PDT)
Received: from [10.162.40.31] (e116581.arm.com [10.162.40.31])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7ABBB3F66E;
	Wed, 11 Sep 2024 05:22:16 -0700 (PDT)
Message-ID: <a068f1b4-8167-4f1d-ac60-9cb9de19a80b@arm.com>
Date: Wed, 11 Sep 2024 17:52:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Abstract THP allocation
To: Kefeng Wang <wangkefeng.wang@huawei.com>, akpm@linux-foundation.org,
 david@redhat.com, willy@infradead.org, kirill.shutemov@linux.intel.com
Cc: ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, mark.rutland@arm.com, hughd@google.com,
 aneesh.kumar@kernel.org, yang@os.amperecomputing.com, peterx@redhat.com,
 ioworker0@gmail.com, jglisse@google.com, ziy@nvidia.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20240911065600.1002644-1-dev.jain@arm.com>
 <20240911065600.1002644-2-dev.jain@arm.com>
 <170988b0-db8a-4612-a70c-b20ea2d4c020@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <170988b0-db8a-4612-a70c-b20ea2d4c020@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/11/24 16:22, Kefeng Wang wrote:
>
>
> On 2024/9/11 14:55, Dev Jain wrote:
>> In preparation for the second patch, abstract away the THP allocation
>> logic present in the create_huge_pmd() path, which corresponds to the
>> faulting case when no page is present.
>>
>> There should be no functional change as a result of applying
>> this patch.
>>
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
>>   {
>> -    struct vm_area_struct *vma = vmf->vma;
>> -    struct folio *folio = page_folio(page);
>> -    pgtable_t pgtable;
>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>> -    vm_fault_t ret = 0;
>> +    const int order = HPAGE_PMD_ORDER;
>
> Maybe move vma_thp_gfp_mask() into this function too.

That's better, thanks.
>
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
>
> We need to return NULL here as folio not set to null,

My bad for assuming that folio_put() also sets folio to NULL. I read
through the code path for that and I guess it does not. Thanks.
>
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

