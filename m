Return-Path: <linux-kernel+bounces-338011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DE8985264
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A368AB23136
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD52153573;
	Wed, 25 Sep 2024 05:28:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECA14A62F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242139; cv=none; b=PFVcRs5hScOt4f+fMA7dBIW3REO6xKTmSCjLX47Phy2BhHNCbVdFSf8F2XBWCSf0J2thrHqEUJe85la7ixPtptqGn/KDY9lKR9gxzuVP3iCBfQZHw64kFchTeZdc4gi7mlqB6YRQmrjizKgZ6NT50k/tsrxO7FI6pKBvQpaCJ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242139; c=relaxed/simple;
	bh=fshCpm14lebwQtjLVhyMWAmzBLOuetVcPx7fTFdXYwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2K5qAzwc1y3jMIqIll5NaxFDXNbiAwBCUQGN1AkPVsewv8vjca+WCjGtJifVRmXhK9/g2R8pip3Hqdxq2S7BRU6QCKPeiDsjs8n0GKYqdDaMiDhTbOmgXZwhJ1/8B4kDyaSRLCkF5gvRRE5ldgQouhsajHo5/9MO8PhoXxK/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ABA1DA7;
	Tue, 24 Sep 2024 22:29:25 -0700 (PDT)
Received: from [10.162.43.26] (e116581.arm.com [10.162.43.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3B753F528;
	Tue, 24 Sep 2024 22:28:46 -0700 (PDT)
Message-ID: <59b38cc6-9491-40bf-a254-9c6c5f07c072@arm.com>
Date: Wed, 25 Sep 2024 10:58:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm: Abstract THP allocation
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
References: <20240924101654.1777697-1-dev.jain@arm.com>
 <20240924101654.1777697-2-dev.jain@arm.com>
 <61b16640-49e0-4f84-8587-ae9b90a78887@huawei.com>
 <91892582-1063-4757-9cc6-664d57b9d828@arm.com>
 <d9aff21a-7f37-470d-b798-abd1e354f2da@huawei.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <d9aff21a-7f37-470d-b798-abd1e354f2da@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/24/24 18:24, Kefeng Wang wrote:
>
>
> On 2024/9/24 20:17, Dev Jain wrote:
>>
>> On 9/24/24 16:50, Kefeng Wang wrote:
>>>
>>>
>>> On 2024/9/24 18:16, Dev Jain wrote:
>>>> In preparation for the second patch, abstract away the THP allocation
>>>> logic present in the create_huge_pmd() path, which corresponds to the
>>>> faulting case when no page is present.
>>>>
>>>> There should be no functional change as a result of applying this 
>>>> patch,
>>>> except that, as David notes at [1], a PMD-aligned address should
>>>> be passed to update_mmu_cache_pmd().
>>>>
>>>> [1]: https://lore.kernel.org/all/ddd3fcd2-48b3-4170- 
>>>> bcaa-2fe66e093f43@redhat.com/
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>>> ---
>>>>   mm/huge_memory.c | 98 
>>>> ++++++++++++++++++++++++++++--------------------
>>>>   1 file changed, 57 insertions(+), 41 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 4e34b7f89daf..bdbf67c18f6c 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -1148,47 +1148,81 @@ unsigned long thp_get_unmapped_area(struct 
>>>> file *filp, unsigned long addr,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>>>   -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault 
>>>> *vmf,
>>>> -            struct page *page, gfp_t gfp)
>>>> +static struct folio *vma_alloc_anon_folio_pmd(struct 
>>>> vm_area_struct *vma,
>>>> +                          unsigned long addr)
>>>>   {
>>>> -    struct vm_area_struct *vma = vmf->vma;
>>>> -    struct folio *folio = page_folio(page);
>>>> -    pgtable_t pgtable;
>>>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>>> -    vm_fault_t ret = 0;
>>>> +    unsigned long haddr = addr & HPAGE_PMD_MASK;
>>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>>> +    const int order = HPAGE_PMD_ORDER;
>>>> +    struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, 
>>>> true);
>>>
>>> There is a warning without NUMA,
>>>
>>> ../mm/huge_memory.c: In function ‘vma_alloc_anon_folio_pmd’:
>>> ../mm/huge_memory.c:1154:16: warning: unused variable ‘haddr’ [- 
>>> Wunused-variable]
>>>  1154 |  unsigned long haddr = addr & HPAGE_PMD_MASK;
>>>       |                ^~~~~
>>>
>>
>> But why is this happening?
>
> If no CONFIG_NUMA, vma_alloc_folio(...) = folio_alloc_noprof(gfp, order),
> it won't use haddr.

Ah got it, thanks, I missed the ifdeffery in include/linux/gfp.h.
>
>

