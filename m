Return-Path: <linux-kernel+bounces-174248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36BE8C0C16
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599BD282B63
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37A2149C4E;
	Thu,  9 May 2024 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TmJFEynq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783AC148307
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240785; cv=none; b=MtV5IGv0A4BmBwTYrZSdFvKOMGg5zwhBmetGaLPSWOYFuCQ/fUvCt1H1Kt/WClmjTrivTiz84pc8YXvmrlWXDjkn3QwMZEjCY+JEKQCwV1QksLH9T+ZrURZ6xPH1OveBzmUcrktMwcidymXvJ1zL6p1SMFKtoRsCLQ6cuoe5qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240785; c=relaxed/simple;
	bh=/VBJ95M2e7DnAFoUQlLHIXvBcw30/0yt8Gc1O0n40a0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z2cgkOR6YM4+FrlPzAX/eDlB+aa36crA/ox7sENsvkoGVMhGiPL80aPkyIAD2e7KUznMa9M7a5KXSs9pwzl+2cS+04zhuEXmv2vPM6iTrllyF/BzFFufsIP0rWiGr1czx191AKD55ML6aEDehU0j/d1/Gw7fMCNV1ce3QjWTF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TmJFEynq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715240784; x=1746776784;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/VBJ95M2e7DnAFoUQlLHIXvBcw30/0yt8Gc1O0n40a0=;
  b=TmJFEynqLbh20RGYakH+GDEWWuQb3ew5/nT1avkGmrfZuDTalOucRVkT
   UqGhGj/6XaQuL9uefWGLG5wl+heHe3An1o3yyBi/hvk0uRae51o1QLrVA
   KpeZCqbG4ZW2/uHkNaHB2noPgR7nRgl96WlnvDzNXGJeiDIXps6Go8Do7
   GYFDfq3g+K5IFGojVhxnuwAFezyDq+ns/8mfebTLEayYfChrx4pIXbOCK
   jDppYTNVoE+2tW4gvOdEhbTzGt4OS1/WOXwQul7n2tVZZ6GpQ3Z9kA/SD
   N2NqB28kYstf82TcOS+o8hDUnrq29R70q4FQWT1i6IEstplnB91SyVnvM
   Q==;
X-CSE-ConnectionGUID: Y2b6x/rYS2yYFySI/xHoLA==
X-CSE-MsgGUID: OmT04jjWSmidOYL5hh1PUw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="14954302"
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="14954302"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 00:46:23 -0700
X-CSE-ConnectionGUID: UkjHkjEBRiueIdo9SYg/Dw==
X-CSE-MsgGUID: ZwqJDB7NROywee5DOBY9xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,147,1712646000"; 
   d="scan'208";a="29720793"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 00:46:18 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  linux-mm@kvack.org,
  baolin.wang@linux.alibaba.com,  chrisl@kernel.org,  david@redhat.com,
  hanchuanhua@oppo.com,  hannes@cmpxchg.org,  hughd@google.com,
  kasong@tencent.com,  linux-kernel@vger.kernel.org,  ryan.roberts@arm.com,
  surenb@google.com,  v-songbaohua@oppo.com,  willy@infradead.org,
  xiang@kernel.org,  yosryahmed@google.com,  yuzhao@google.com,
  ziy@nvidia.com
Subject: Re: [PATCH v4 6/6] mm: swap: entirely map large folios found in
 swapcache
In-Reply-To: <20240508224040.190469-7-21cnbao@gmail.com> (Barry Song's message
	of "Thu, 9 May 2024 10:40:40 +1200")
References: <20240508224040.190469-1-21cnbao@gmail.com>
	<20240508224040.190469-7-21cnbao@gmail.com>
Date: Thu, 09 May 2024 15:44:25 +0800
Message-ID: <875xvnig4m.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> When a large folio is found in the swapcache, the current implementation
> requires calling do_swap_page() nr_pages times, resulting in nr_pages
> page faults. This patch opts to map the entire large folio at once to
> minimize page faults. Additionally, redundant checks and early exits
> for ARM64 MTE restoring are removed.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM, Thanks!  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future version.

> ---
>  mm/memory.c | 59 +++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 48 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d9434df24d62..8b9e4cab93ed 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3968,6 +3968,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	pte_t pte;
>  	vm_fault_t ret = 0;
>  	void *shadow = NULL;
> +	int nr_pages;
> +	unsigned long page_idx;
> +	unsigned long address;
> +	pte_t *ptep;
>  
>  	if (!pte_unmap_same(vmf))
>  		goto out;
> @@ -4166,6 +4170,38 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		goto out_nomap;
>  	}
>  
> +	nr_pages = 1;
> +	page_idx = 0;
> +	address = vmf->address;
> +	ptep = vmf->pte;
> +	if (folio_test_large(folio) && folio_test_swapcache(folio)) {
> +		int nr = folio_nr_pages(folio);
> +		unsigned long idx = folio_page_idx(folio, page);
> +		unsigned long folio_start = address - idx * PAGE_SIZE;
> +		unsigned long folio_end = folio_start + nr * PAGE_SIZE;
> +		pte_t *folio_ptep;
> +		pte_t folio_pte;
> +
> +		if (unlikely(folio_start < max(address & PMD_MASK, vma->vm_start)))
> +			goto check_folio;
> +		if (unlikely(folio_end > pmd_addr_end(address, vma->vm_end)))
> +			goto check_folio;
> +
> +		folio_ptep = vmf->pte - idx;
> +		folio_pte = ptep_get(folio_ptep);
> +		if (!pte_same(folio_pte, pte_move_swp_offset(vmf->orig_pte, -idx)) ||
> +		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
> +			goto check_folio;
> +
> +		page_idx = idx;
> +		address = folio_start;
> +		ptep = folio_ptep;
> +		nr_pages = nr;
> +		entry = folio->swap;
> +		page = &folio->page;
> +	}
> +
> +check_folio:
>  	/*
>  	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
>  	 * must never point at an anonymous page in the swapcache that is
> @@ -4225,12 +4261,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	 * We're already holding a reference on the page but haven't mapped it
>  	 * yet.
>  	 */
> -	swap_free(entry);
> +	swap_free_nr(entry, nr_pages);
>  	if (should_try_to_free_swap(folio, vma, vmf->flags))
>  		folio_free_swap(folio);
>  
> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> +	add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
>  	pte = mk_pte(page, vma->vm_page_prot);
>  
>  	/*
> @@ -4247,27 +4283,28 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		}
>  		rmap_flags |= RMAP_EXCLUSIVE;
>  	}
> -	flush_icache_page(vma, page);
> +	folio_ref_add(folio, nr_pages - 1);
> +	flush_icache_pages(vma, page, nr_pages);
>  	if (pte_swp_soft_dirty(vmf->orig_pte))
>  		pte = pte_mksoft_dirty(pte);
>  	if (pte_swp_uffd_wp(vmf->orig_pte))
>  		pte = pte_mkuffd_wp(pte);
> -	vmf->orig_pte = pte;
> +	vmf->orig_pte = pte_advance_pfn(pte, page_idx);
>  
>  	/* ksm created a completely new copy */
>  	if (unlikely(folio != swapcache && swapcache)) {
> -		folio_add_new_anon_rmap(folio, vma, vmf->address);
> +		folio_add_new_anon_rmap(folio, vma, address);
>  		folio_add_lru_vma(folio, vma);
>  	} else {
> -		folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> +		folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, address,
>  					rmap_flags);
>  	}
>  
>  	VM_BUG_ON(!folio_test_anon(folio) ||
>  			(pte_write(pte) && !PageAnonExclusive(page)));
> -	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> -	arch_do_swap_page_nr(vma->vm_mm, vma, vmf->address,
> -			pte, vmf->orig_pte, 1);
> +	set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
> +	arch_do_swap_page_nr(vma->vm_mm, vma, address,
> +			pte, pte, nr_pages);
>  
>  	folio_unlock(folio);
>  	if (folio != swapcache && swapcache) {
> @@ -4291,7 +4328,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  	/* No need to invalidate - it was non-present before */
> -	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> +	update_mmu_cache_range(vmf, vma, address, ptep, nr_pages);
>  unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);

--
Best Regards,
Huang, Ying

