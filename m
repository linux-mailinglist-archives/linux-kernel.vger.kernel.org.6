Return-Path: <linux-kernel+bounces-337170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CC398463E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2198AB22B78
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07141A7254;
	Tue, 24 Sep 2024 12:54:47 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A5D1A7040
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182487; cv=none; b=Xbtn8ZQxXi+HJsEyFNSWu+/p4+n2Ea2oAY53x26j/YW3sn4NjBnffgOUkhqwD3ocMVHz7xx+G18CKczfMjENzJ7RfiScxAYJyTQ1N8WlBjc3RrwWY69M4Rwr6SNqCSOTJp9v1SlEpS3Fd/t4UjOI9zfwRAzVXced6cxoKFwzLyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182487; c=relaxed/simple;
	bh=wBPNhIJMjBI8zt+bPVXJLTq2IqX/Rg/8B4IaEX7XwVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V4Jrh+5EIs7glcwPwIuKC8mLBixl8SdzaaDhQY+EVMCSL4txNIUOBwhbvcrIjYb2Id36NkgLoqYZFm14qZtGM9tg0sfVNmX7mZRQuEcIpEpHL8E3WslbHMY2th/tGD3bPK7Z6Q3v+YAL2tUeiAVVcABBKmigDKtQ2WlrJrb1dIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XCftq6vcJz2QTtw;
	Tue, 24 Sep 2024 20:53:55 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id EF060140119;
	Tue, 24 Sep 2024 20:54:41 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 20:54:40 +0800
Message-ID: <d9aff21a-7f37-470d-b798-abd1e354f2da@huawei.com>
Date: Tue, 24 Sep 2024 20:54:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] mm: Abstract THP allocation
To: Dev Jain <dev.jain@arm.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <willy@infradead.org>, <kirill.shutemov@linux.intel.com>
CC: <ryan.roberts@arm.com>, <anshuman.khandual@arm.com>,
	<catalin.marinas@arm.com>, <cl@gentwo.org>, <vbabka@suse.cz>,
	<mhocko@suse.com>, <apopple@nvidia.com>, <dave.hansen@linux.intel.com>,
	<will@kernel.org>, <baohua@kernel.org>, <jack@suse.cz>,
	<mark.rutland@arm.com>, <hughd@google.com>, <aneesh.kumar@kernel.org>,
	<yang@os.amperecomputing.com>, <peterx@redhat.com>, <ioworker0@gmail.com>,
	<jglisse@google.com>, <ziy@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
References: <20240924101654.1777697-1-dev.jain@arm.com>
 <20240924101654.1777697-2-dev.jain@arm.com>
 <61b16640-49e0-4f84-8587-ae9b90a78887@huawei.com>
 <91892582-1063-4757-9cc6-664d57b9d828@arm.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <91892582-1063-4757-9cc6-664d57b9d828@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/24 20:17, Dev Jain wrote:
> 
> On 9/24/24 16:50, Kefeng Wang wrote:
>>
>>
>> On 2024/9/24 18:16, Dev Jain wrote:
>>> In preparation for the second patch, abstract away the THP allocation
>>> logic present in the create_huge_pmd() path, which corresponds to the
>>> faulting case when no page is present.
>>>
>>> There should be no functional change as a result of applying this patch,
>>> except that, as David notes at [1], a PMD-aligned address should
>>> be passed to update_mmu_cache_pmd().
>>>
>>> [1]: https://lore.kernel.org/all/ddd3fcd2-48b3-4170- 
>>> bcaa-2fe66e093f43@redhat.com/
>>>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> ---
>>>   mm/huge_memory.c | 98 ++++++++++++++++++++++++++++--------------------
>>>   1 file changed, 57 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 4e34b7f89daf..bdbf67c18f6c 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -1148,47 +1148,81 @@ unsigned long thp_get_unmapped_area(struct 
>>> file *filp, unsigned long addr,
>>>   }
>>>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>>>   -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>>> -            struct page *page, gfp_t gfp)
>>> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct 
>>> *vma,
>>> +                          unsigned long addr)
>>>   {
>>> -    struct vm_area_struct *vma = vmf->vma;
>>> -    struct folio *folio = page_folio(page);
>>> -    pgtable_t pgtable;
>>> -    unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>> -    vm_fault_t ret = 0;
>>> +    unsigned long haddr = addr & HPAGE_PMD_MASK;
>>> +    gfp_t gfp = vma_thp_gfp_mask(vma);
>>> +    const int order = HPAGE_PMD_ORDER;
>>> +    struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, 
>>> true);
>>
>> There is a warning without NUMA,
>>
>> ../mm/huge_memory.c: In function ‘vma_alloc_anon_folio_pmd’:
>> ../mm/huge_memory.c:1154:16: warning: unused variable ‘haddr’ [- 
>> Wunused-variable]
>>  1154 |  unsigned long haddr = addr & HPAGE_PMD_MASK;
>>       |                ^~~~~
>>
> 
> But why is this happening?

If no CONFIG_NUMA, vma_alloc_folio(...) = folio_alloc_noprof(gfp, order),
it won't use haddr.



