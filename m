Return-Path: <linux-kernel+bounces-337030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC1C984465
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAD71C22FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DF91A3AB6;
	Tue, 24 Sep 2024 11:20:13 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A8B1A270
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176813; cv=none; b=PtcZadhVC9h/Kj6YslyVwtvq/2sZuhZCY4DBiiiy64fw7wdd6iqzadkSLkhbVHJTrTftlgKweIbXYk33CfOgs2ZGjGA+ymBi71UzlW8pQ10GrAgecZHh3WIkiOmoRiFmKtY2qCxIhW4zEZt9PyTH4fBRp2Uff2Wp0qjUDBkqv1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176813; c=relaxed/simple;
	bh=/a0iPIlke0+jNVeuO7mM4SbTZ41CbTBfOI2HSMLU/Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nacHPe4ZOjjFZP5QW41XvOW9RAwluk56p0lVo3us4BOXA7RsJXeGfv3AF2qqM9vawd18xEauW0RfuJs+p7z3u9YxNv0BWbue7LLwH5us8VnyAPFEInpyN/K6N7xKRUWkEfu1qMHi3BTpTzTxrZvsFVMMIs86MCplWkFaa5J/im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XCcp875KLz20pLy;
	Tue, 24 Sep 2024 19:19:44 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 32DF6140119;
	Tue, 24 Sep 2024 19:20:05 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 19:20:04 +0800
Message-ID: <61b16640-49e0-4f84-8587-ae9b90a78887@huawei.com>
Date: Tue, 24 Sep 2024 19:20:03 +0800
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
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20240924101654.1777697-2-dev.jain@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2024/9/24 18:16, Dev Jain wrote:
> In preparation for the second patch, abstract away the THP allocation
> logic present in the create_huge_pmd() path, which corresponds to the
> faulting case when no page is present.
> 
> There should be no functional change as a result of applying this patch,
> except that, as David notes at [1], a PMD-aligned address should
> be passed to update_mmu_cache_pmd().
> 
> [1]: https://lore.kernel.org/all/ddd3fcd2-48b3-4170-bcaa-2fe66e093f43@redhat.com/
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   mm/huge_memory.c | 98 ++++++++++++++++++++++++++++--------------------
>   1 file changed, 57 insertions(+), 41 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4e34b7f89daf..bdbf67c18f6c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1148,47 +1148,81 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>   }
>   EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>   
> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> -			struct page *page, gfp_t gfp)
> +static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
> +					      unsigned long addr)
>   {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct folio *folio = page_folio(page);
> -	pgtable_t pgtable;
> -	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -	vm_fault_t ret = 0;
> +	unsigned long haddr = addr & HPAGE_PMD_MASK;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	const int order = HPAGE_PMD_ORDER;
> +	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);

There is a warning without NUMA,

../mm/huge_memory.c: In function ‘vma_alloc_anon_folio_pmd’:
../mm/huge_memory.c:1154:16: warning: unused variable ‘haddr’ 
[-Wunused-variable]
  1154 |  unsigned long haddr = addr & HPAGE_PMD_MASK;
       |                ^~~~~


diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c584e77efe10..147a6e069c71 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1151,11 +1151,11 @@ EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
  static struct folio *vma_alloc_anon_folio_pmd(struct vm_area_struct *vma,
                                               unsigned long addr)
  {
-       unsigned long haddr = addr & HPAGE_PMD_MASK;
         gfp_t gfp = vma_thp_gfp_mask(vma);
         const int order = HPAGE_PMD_ORDER;
-       struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
+       struct folio *folio;

+       folio = vma_alloc_folio(gfp, order, vma, addr & HPAGE_PMD_MASK, 
true);
         if (unlikely(!folio)) {
                 count_vm_event(THP_FAULT_FALLBACK);
                 count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);

>   
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	if (unlikely(!folio)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		goto out;

Maybe return NULL to omit the out?


Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>


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
> +		return NULL;
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
> +static void map_anon_folio_pmd(struct folio *folio, pmd_t *pmd,
> +			       struct vm_area_struct *vma, unsigned long haddr)
> +{
> +	pmd_t entry;
> +
> +	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
> +	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> +	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
> +	folio_add_lru_vma(folio, vma);
> +	set_pmd_at(vma->vm_mm, haddr, pmd, entry);
> +	update_mmu_cache_pmd(vma, haddr, pmd);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +	count_vm_event(THP_FAULT_ALLOC);
> +	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +}
> +
> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> +{
> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct folio *folio;
> +	pgtable_t pgtable;
> +	vm_fault_t ret = 0;
> +
> +	folio = vma_alloc_anon_folio_pmd(vma, vmf->address);
> +	if (unlikely(!folio))
> +		return VM_FAULT_FALLBACK;
> +
> +	pgtable = pte_alloc_one(vma->vm_mm);
> +	if (unlikely(!pgtable)) {
> +		ret = VM_FAULT_OOM;
> +		goto release;
> +	}
>   
>   	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>   	if (unlikely(!pmd_none(*vmf->pmd))) {
>   		goto unlock_release;
>   	} else {
> -		pmd_t entry;
> -
>   		ret = check_stable_address_space(vma->vm_mm);
>   		if (ret)
>   			goto unlock_release;
> @@ -1202,21 +1236,11 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>   			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
>   			return ret;
>   		}
> -
> -		entry = mk_huge_pmd(page, vma->vm_page_prot);
> -		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> -		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
> -		folio_add_lru_vma(folio, vma);
>   		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> -		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
> -		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> -		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +		map_anon_folio_pmd(folio, vmf->pmd, vma, haddr);
>   		mm_inc_nr_ptes(vma->vm_mm);
>   		deferred_split_folio(folio, false);
>   		spin_unlock(vmf->ptl);
> -		count_vm_event(THP_FAULT_ALLOC);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
> -		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>   	}
>   
>   	return 0;
> @@ -1283,8 +1307,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
>   vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> -	gfp_t gfp;
> -	struct folio *folio;
>   	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>   	vm_fault_t ret;
>   
> @@ -1335,14 +1357,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>   		}
>   		return ret;
>   	}
> -	gfp = vma_thp_gfp_mask(vma);
> -	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
> -	if (unlikely(!folio)) {
> -		count_vm_event(THP_FAULT_FALLBACK);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
> -		return VM_FAULT_FALLBACK;
> -	}
> -	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
> +
> +	return __do_huge_pmd_anonymous_page(vmf);
>   }
>   
>   static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,


