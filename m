Return-Path: <linux-kernel+bounces-316624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907C96D20F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94B8EB221F7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF301925BB;
	Thu,  5 Sep 2024 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjgIlVHQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49B17BEC3
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524826; cv=none; b=sChucwuWFJ/7V+B1qnkNjor6sdwmtmUAM45CfmEwlCdHWypRQN6mfCpKnjxA+ELkBs6v2zIywHqZGzR/1UIpj4T30EYiDI4PwnbRF6f47VsvP1CzEe6row3d+s1/yKkEUmlBMK+jBHprnurX9XbV7H9BD1zHQ095lw4uDwJmyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524826; c=relaxed/simple;
	bh=cWqX3P2HgWhytDM9e9SLDbRtnf5sTKbiTntuLnerQXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Keu8lpBuB9BqYIFrLMXEH1cHWWIBwSJJyL2IxJB5uAvnY7MqtLj/9DmkTnIJb4o9RrH8GfJ/x41EcuhMW7PfTgSbdLVXufDUbqxmJdGfCIiY+AQZOvSXlrxnfzaQKMJtIGAPEaBLi38rYp9ENhobZJTflcQmhrrl16JLqwwUTEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjgIlVHQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725524825; x=1757060825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cWqX3P2HgWhytDM9e9SLDbRtnf5sTKbiTntuLnerQXo=;
  b=gjgIlVHQvpr76+T/IfQoZmkzqWf7nB/Wen3/XpIgAqRLyuGVB4nry0O4
   4DKCWLZdK61CDeU8yVKXQJy42efSauvhv9IX0/GsSv2A98i6SOgrBZb7U
   IDfqk0HBlL9n4tO64mQcMvMe65QLKKQzjdu+65lvjb5UZbaVlyzueFkMk
   YKaUmWikVJSycCuLU6tZnKj6ugdSeI1cKugEPIBGpChHKft5eEXVwID7e
   +ZebSoNMmOcVYLshNSbGgatpyb+59c/v3NKVYlJICwuF3rfouiPEO9qt9
   3Tv5YxsgsmRLmvBbhyVO1uGmw1YkKpTwLjUtvAstz/TfaTtFPMeAb4U1n
   g==;
X-CSE-ConnectionGUID: 7w6QaYfATO6edfnd6llyJQ==
X-CSE-MsgGUID: l4hyQjnoQPKOorRh8QLnug==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34892181"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34892181"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 01:27:04 -0700
X-CSE-ConnectionGUID: H1JBgFeRTautrJ7WXgGTsQ==
X-CSE-MsgGUID: uYqtI4AMS0Wu1KGWS/QiXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="96294676"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 05 Sep 2024 01:26:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 541B4179; Thu, 05 Sep 2024 11:26:56 +0300 (EEST)
Date: Thu, 5 Sep 2024 11:26:56 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, willy@infradead.org, 
	ryan.roberts@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	cl@gentwo.org, vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com, 
	dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org, jack@suse.cz, 
	mark.rutland@arm.com, hughd@google.com, aneesh.kumar@kernel.org, 
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com, jglisse@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/2] mm: Allocate THP on hugezeropage wp-fault
Message-ID: <xs7lw544kk6ftxlg6lbjicxnu5mdn666ivld5kzznm7fkoaf2x@4jowgzwfzcof>
References: <20240904100923.290042-1-dev.jain@arm.com>
 <20240904100923.290042-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904100923.290042-3-dev.jain@arm.com>

On Wed, Sep 04, 2024 at 03:39:23PM +0530, Dev Jain wrote:
> Introduce do_huge_zero_wp_pmd() to handle wp-fault on a hugezeropage and
> replace it with a PMD-mapped THP. Change the helpers introduced in the
> previous patch to flush TLB entry corresponding to the hugezeropage,
> and preserve PMD uffd-wp marker. In case of failure, fallback to
> splitting the PMD.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  include/linux/huge_mm.h |  6 ++++
>  mm/huge_memory.c        | 79 +++++++++++++++++++++++++++++++++++------
>  mm/memory.c             |  5 +--
>  3 files changed, 78 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index e25d9ebfdf89..fdd2cf473a3c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -9,6 +9,12 @@
>  #include <linux/kobject.h>
>  
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
> +vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
> +			   unsigned long haddr, struct folio **foliop,
> +			   unsigned long addr);
> +void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
> +		 struct vm_area_struct *vma, unsigned long haddr,
> +		 pgtable_t pgtable);

Why? I don't see users outside huge_memory.c.

>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
>  		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 58125fbcc532..150163ad77d3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -943,9 +943,9 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
>  
> -static vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
> -				  unsigned long haddr, struct folio **foliop,
> -				  unsigned long addr)
> +vm_fault_t thp_fault_alloc(gfp_t gfp, int order, struct vm_area_struct *vma,
> +			   unsigned long haddr, struct folio **foliop,
> +			   unsigned long addr)
>  {
>  	struct folio *folio = vma_alloc_folio(gfp, order, vma, haddr, true);
>  
> @@ -984,21 +984,29 @@ static void __thp_fault_success_stats(struct vm_area_struct *vma, int order)
>  	count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
>  }
>  
> -static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
> -			struct vm_area_struct *vma, unsigned long haddr,
> -			pgtable_t pgtable)
> +void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
> +		 struct vm_area_struct *vma, unsigned long haddr,
> +		 pgtable_t pgtable)
>  {
> -	pmd_t entry;
> +	pmd_t entry, old_pmd;
> +	bool is_pmd_none = pmd_none(*vmf->pmd);
>  
>  	entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
>  	entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
>  	folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
>  	folio_add_lru_vma(folio, vma);
> -	pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
> +	if (!is_pmd_none) {
> +		old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
> +		if (pmd_uffd_wp(old_pmd))
> +			entry = pmd_mkuffd_wp(entry);
> +	}
> +	if (pgtable)
> +		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
>  	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
>  	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
>  	add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
> -	mm_inc_nr_ptes(vma->vm_mm);
> +	if (is_pmd_none)
> +		mm_inc_nr_ptes(vma->vm_mm);
>  }
>  
>  static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf)
> @@ -1576,6 +1584,50 @@ void huge_pmd_set_accessed(struct vm_fault *vmf)
>  	spin_unlock(vmf->ptl);
>  }
>  
> +static vm_fault_t do_huge_zero_wp_pmd_locked(struct vm_fault *vmf,
> +					     unsigned long haddr,
> +					     struct folio *folio)

Why the helper is needed? Cannot it be just opencodded in
do_huge_zero_wp_pmd()?

> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +
> +	ret = check_stable_address_space(vma->vm_mm);
> +	if (ret)
> +		goto out;
> +	map_pmd_thp(folio, vmf, vma, haddr, NULL);
> +out:
> +	return ret;
> +}
> +
> +static vm_fault_t do_huge_zero_wp_pmd(struct vm_fault *vmf, unsigned long haddr)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	gfp_t gfp = vma_thp_gfp_mask(vma);
> +	struct mmu_notifier_range range;
> +	struct folio *folio = NULL;
> +	vm_fault_t ret = 0;
> +
> +	ret = thp_fault_alloc(gfp, HPAGE_PMD_ORDER, vma, haddr, &folio,
> +			      vmf->address);
> +	if (ret)
> +		goto out;
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm, haddr,
> +				haddr + HPAGE_PMD_SIZE);
> +	mmu_notifier_invalidate_range_start(&range);
> +	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
> +	if (unlikely(!pmd_same(pmdp_get(vmf->pmd), vmf->orig_pmd)))
> +		goto unlock;
> +	ret = do_huge_zero_wp_pmd_locked(vmf, haddr, folio);
> +	if (!ret)
> +		__thp_fault_success_stats(vma, HPAGE_PMD_ORDER);
> +unlock:
> +	spin_unlock(vmf->ptl);
> +	mmu_notifier_invalidate_range_end(&range);
> +out:
> +	return ret;
> +}
> +
>  vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>  {
>  	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
> @@ -1588,8 +1640,15 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>  	vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>  	VM_BUG_ON_VMA(!vma->anon_vma, vma);
>  
> -	if (is_huge_zero_pmd(orig_pmd))
> +	if (is_huge_zero_pmd(orig_pmd)) {
> +		vm_fault_t ret = do_huge_zero_wp_pmd(vmf, haddr);
> +
> +		if (!(ret & VM_FAULT_FALLBACK))
> +			return ret;
> +
> +		/* Fallback to splitting PMD if THP cannot be allocated */
>  		goto fallback;
> +	}
>  
>  	spin_lock(vmf->ptl);
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 3c01d68065be..c081a25f5173 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5409,9 +5409,10 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>  	if (vma_is_anonymous(vma)) {
>  		if (likely(!unshare) &&
>  		    userfaultfd_huge_pmd_wp(vma, vmf->orig_pmd)) {
> -			if (userfaultfd_wp_async(vmf->vma))
> +			if (!userfaultfd_wp_async(vmf->vma))
> +				return handle_userfault(vmf, VM_UFFD_WP);
> +			if (!is_huge_zero_pmd(vmf->orig_pmd))
>  				goto split;
> -			return handle_userfault(vmf, VM_UFFD_WP);
>  		}
>  		return do_huge_pmd_wp_page(vmf);
>  	}
> -- 
> 2.30.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

