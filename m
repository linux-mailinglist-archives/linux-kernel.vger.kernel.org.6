Return-Path: <linux-kernel+bounces-316611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F94596D1E4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCE91F2C7BF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E892AE96;
	Thu,  5 Sep 2024 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoSNUD9D"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2579B27735
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524471; cv=none; b=Vj45yCP+Kf9zgpkBtfvRPlpS/HVTy/wSqLO/ZvCV1iyFaCrEhKBTVq1fymajYbFEW3jfZj6usHu8TdIwoIg4oqBCTZvhAmjJXrhv8YG3YMNpiav07mCZmQf5kSbEhkcRlAXPzvBcb8SaELrNyAHl7BQ0hj6cQ+Vx9ywQrKYlM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524471; c=relaxed/simple;
	bh=E2HxPBlqoipLkldSMcrE8bBtkv5H3xufdrJHsldotmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8wludPMT3PkL1oJiapgHRj8yAn3wVDZJ24sTh3zMsAkwUjySTNNIcs0iaO79c8nY1H0PwVm/ukZv3+pXU53W6MlEISCNBVhoPeFxTp3sKBXvVEVosBmx5nfPdfe7qUY8unRgM8YshStUMeNje72GkV3EL/aWJmvnJbmuaKI8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoSNUD9D; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725524470; x=1757060470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E2HxPBlqoipLkldSMcrE8bBtkv5H3xufdrJHsldotmA=;
  b=aoSNUD9DflF+NVGbFsxmhRrxjIpF2b8LGV9rwrs7CwqG8mOvbTTp2EFd
   qwrHVmmRH4gFFPMdCR1ZVFpcJ1s0exKqDC6TRMa9q1c5ny1XQyJV4u0rN
   VppcjCR2be2PraLCa0Q49MUB75L/cEJGUEghf3iaJ+dSCf9Qlp4BWWwMM
   OhX9WFGHhpyTowopi8VKB+Qzm5wFSzyyFfI6FsvndDsUlMKYdhRmdBssZ
   sk1vstoIOHaZq8ijdpnCUPoKmqcqncZcyINULzL2f9Jk99zzfi1z+Hb+2
   Z4jmYAuw3iJPs8Tf7aQ7l4trYGadPbQsD/ivVDMvM2PI+0KN/XCrScuF4
   Q==;
X-CSE-ConnectionGUID: iiHyxzx/SAmz6l3Ue2l02Q==
X-CSE-MsgGUID: PpL+BqXiT5q17zsBwtFtLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="35582902"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="35582902"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:20:50 -0700
X-CSE-ConnectionGUID: f7LIfq40TeKiMGOc9S6uXg==
X-CSE-MsgGUID: 78q4W+MXTHS610/Oc2lwyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="88790593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 05 Sep 2024 01:20:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id DD3D6179; Thu, 05 Sep 2024 11:20:42 +0300 (EEST)
Date: Thu, 5 Sep 2024 11:20:42 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	mark.rutland@arm.com, hughd@google.com, aneesh.kumar@kernel.org, 
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com, jglisse@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm: Abstract THP allocation
Message-ID: <spkiynphi76p7bybswvxypro6pkbm7h4jtt2niwg6laqhrwamx@bojwcg3wkviq>
References: <20240904100923.290042-1-dev.jain@arm.com>
 <20240904100923.290042-2-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904100923.290042-2-dev.jain@arm.com>

On Wed, Sep 04, 2024 at 03:39:22PM +0530, Dev Jain wrote:
> In preparation for the second patch, abstract away the THP allocation
> logic present in the create_huge_pmd() path, which corresponds to the
> faulting case when no page is present.
> 
> There should be no functional change as a result of applying
> this patch.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/huge_memory.c | 110 +++++++++++++++++++++++++++++------------------
>  1 file changed, 67 insertions(+), 43 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 67c86a5d64a6..58125fbcc532 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -943,47 +943,89 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>  
> -static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
> -			struct page *page, gfp_t gfp)
> +static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
> +				  unsigned long haddr, struct folio **foliop,
> +				  unsigned long addr)

foliop is awkward.

Why not return folio? NULL would indicate to the caller to fallback.

>  {
> -	struct vm_area_struct *vma = vmf->vma;
> -	struct folio *folio = page_folio(page);
> -	pgtable_t pgtable;
> -	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -	vm_fault_t ret = 0;
> +	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>  
> -	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
> +	*foliop = folio;
> +	if (unlikely(!folio)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		return VM_FAULT_FALLBACK;
> +	}
>  
> +	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>  	if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
>  		folio_put(folio);
>  		count_vm_event(THP_FAULT_FALLBACK);
>  		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
>  		return VM_FAULT_FALLBACK;
>  	}
>  	folio_throttle_swaprate(folio, gfp);
>  
> -	pgtable = pte_alloc_one(vma->vm_mm);
> -	if (unlikely(!pgtable)) {
> -		ret = VM_FAULT_OOM;
> -		goto release;
> -	}
> -
> -	folio_zero_user(folio, vmf->address);
> +	folio_zero_user(folio, addr);
>  	/*
>  	 * The memory barrier inside __folio_mark_uptodate makes sure that
>  	 * folio_zero_user writes become visible before the set_pmd_at()
>  	 * write.
>  	 */
>  	__folio_mark_uptodate(folio);
> +	return 0;
> +}
> +
> +static void __thp_fault_success_stats(struct vm_area_struct *vma, int order)
> +{
> +	count_vm_event(THP_FAULT_ALLOC);
> +	count_mthp_stat(order, MTHP_STAT_ANON_FAULT_ALLOC);
> +	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +}
> +
> +static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
> +			struct vm_area_struct *vma, unsigned long haddr,
> +			pgtable_t pgtable)
> +{
> +	pmd_t entry;
> +
> +	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
> +	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> +	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
> +	folio_add_lru_vma(folio, vma);
> +	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> +	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
> +	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> +	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> +	mm_inc_nr_ptes(vma->vm_mm);
> +}
> +
> +static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct folio *folio = NULL;
> +	pgtable_t pgtable;
> +	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> +	vm_fault_t ret = 0;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +
> +	pgtable = pte_alloc_one(vma->vm_mm);
> +	if (unlikely(!pgtable)) {
> +		ret = VM_FAULT_OOM;
> +		goto release;
> +	}
> +
> +	ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
> +			      vmf->address);
> +	if (ret)
> +		goto release;

THP page allocation has higher probability to fail than pgtable allocation. It
is better to allocate it first, before pgtable and do less work on error
path.

>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +
>  	if (unlikely(!pmd_none(*vmf->pmd))) {
>  		goto unlock_release;
>  	} else {
> -		pmd_t entry;
> -
>  		ret = check_stable_address_space(vma->vm_mm);
>  		if (ret)
>  			goto unlock_release;
> @@ -997,20 +1039,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  			VM_BUG_ON(ret & VM_FAULT_FALLBACK);
>  			return ret;
>  		}
> -
> -		entry = mk_huge_pmd(page, vma->vm_page_prot);
> -		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
> -		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
> -		folio_add_lru_vma(folio, vma);
> -		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> -		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
> -		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
> -		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> -		mm_inc_nr_ptes(vma->vm_mm);
> +		map_pmd_thp(folio, vmf, vma, haddr, pgtable);
>  		spin_unlock(vmf->ptl);
> -		count_vm_event(THP_FAULT_ALLOC);
> -		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
> -		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
> +		__thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
>  	}
>  
>  	return 0;
> @@ -1019,7 +1050,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
>  release:
>  	if (pgtable)
>  		pte_free(vma->vm_mm, pgtable);
> -	folio_put(folio);
> +	if (folio)
> +		folio_put(folio);
>  	return ret;
>  
>  }
> @@ -1077,8 +1109,6 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> -	gfp_t gfp;
> -	struct folio *folio;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  	vm_fault_t ret;
>  
> @@ -1129,14 +1159,8 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  		}
>  		return ret;
>  	}
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
>  }
>  
>  static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
> -- 
> 2.30.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

