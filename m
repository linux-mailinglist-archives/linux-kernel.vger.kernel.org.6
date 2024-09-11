Return-Path: <linux-kernel+bounces-324734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A70975040
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FAA290211
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F2C186287;
	Wed, 11 Sep 2024 10:52:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664917C7C4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726051971; cv=none; b=liMHKkcx1RGeVM9SP9jofEbDcNtlv1K+W8FkTUmBfCgE3O2C+1p1PEOyolRXY5Ezr4IzYIA1HuLs3NbAiFyysMC0Ur6+4WplBgDAn2qQvIaJ88plnGUG1DBeIPXwDZwT1QIb4MpdfCMxcqkYBWV2CTXnrE6JPRfXcOubvjD8hsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726051971; c=relaxed/simple;
	bh=t+oWOl4YBiTCEHWcFOwzcj7P1DA7i/iyrk8eb2HIakA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J+kllXxKdRm6LH/34JI8kyEhAUPMdXARQih0BdrK7NHrxr0l6wAMYE3kEukvqSebpuoyM2YCvzaOioknkaB+V8nIWqMguWDO0WfQGbYix1ZzVnnffyynLyIE3znawPAeOPtR9Y5ASMi6Lwf/ig21Q33nEa7mdUgOmGKT10QbmyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3cnk1rXkzyRLW;
	Wed, 11 Sep 2024 18:51:38 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 26086140156;
	Wed, 11 Sep 2024 18:52:45 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Sep 2024 18:52:44 +0800
Message-ID: <170988b0-db8a-4612-a70c-b20ea2d4c020@huawei.com>
Date: Wed, 11 Sep 2024 18:52:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mm: Abstract THP allocation
Content-Language: en-US
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
References: <20240911065600.1002644-1-dev.jain@arm.com>
 <20240911065600.1002644-2-dev.jain@arm.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240911065600.1002644-2-dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/11 14:55, Dev Jain wrote:
> In preparation for the second patch, abstract away the THP allocation
> logic present in the create_huge_pmd() path, which corresponds to the
> faulting case when no page is present.
> 
> There should be no functional change as a result of applying
> this patch.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 110 +++++++++++++++++++++++++++++------------------
>   1 file changed, 67 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 67c86a5d64a6..b96a1ff2bf40 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -943,47 +943,88 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>   }
>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>   
> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> -			struct page *page, gfp_t gfp)
> +static struct folio *pmd_thp_fault_alloc(gfp_t gfp, struct vm_area_struct *vma,
> +					 unsigned long haddr, unsigned long addr)
>   {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct folio *folio = page_folio(page);
> -	pgtable_t pgtable;
> -	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -	vm_fault_t ret = 0;
> +	const int order = HPAGE_PMD_ORDER;

Maybe move vma_thp_gfp_mask() into this function too.

> +	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>   
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	if (unlikely(!folio)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		goto out;
> +	}
>   
> +	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>   	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>   		folio_put(folio);
>   		count_vm_event(THP_FAULT_FALLBACK);
>   		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> -		return VM_FAULT_FALLBACK;
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +		goto out;

We need to return NULL here as folio not set to null,

>   	}
>   	folio_throttle_swaprate(folio, gfp);
>   
> -	pgtable = pte_alloc_one(vma->vm_mm);
> -	if (unlikely(!pgtable)) {
> -		ret = VM_FAULT_OOM;
> -		goto release;
> -	}
> -
> -	folio_zero_user(folio, vmf->address);
> +	folio_zero_user(folio, addr);
>   	/*
>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
>   	 * folio_zero_user writes become visible before the set_pmd_at()
>   	 * write.
>   	 */
>   	__folio_mark_uptodate(folio);
> +out:
> +	return folio;
> +}
> +

