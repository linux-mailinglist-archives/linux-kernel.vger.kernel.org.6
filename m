Return-Path: <linux-kernel+bounces-278871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804B94B5DC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C494B218A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9E81751;
	Thu,  8 Aug 2024 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALNBGK0K"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADBE9479
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090685; cv=none; b=iSRzU9JgAVOJz/ao2sQvt1m0qakfEHDoj09gUhvUH0GZSjVKnCHue99JNYUZ+M9tZpRjQGqzKUEDOlGCvf+FkH3BxUXq/6trUa+3eu0iHZTnEkjKamS+qHdFnoaESb8DSXmC+9W2aO3JJBiRxUJUbVYhxqhcYCEQnLLAA6/3tvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090685; c=relaxed/simple;
	bh=XYNrI5AxGmpy2tc0T5LkPYR58qkpzGzLjLnZoKn6tuE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YVBIVWFC2kNzi/X3qhpgNJyJxVW2S3rT1d8rHBdZdrDbv6Ycdiy0OyTjwktKDtldrhL/CvVXETxzM7skx/v/YkXUxuv6qe8bTOwYzMBmYaVGShrRmKG/b+FryG8oCaGu5EaOlbMObT7q4gFZws5wwG76JHjbTUQjxeUl58ANBNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALNBGK0K; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723090684; x=1754626684;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=XYNrI5AxGmpy2tc0T5LkPYR58qkpzGzLjLnZoKn6tuE=;
  b=ALNBGK0KfChFpY1EHFo8ip1S5kfEJMmVHBoCNAIS9zoeDnwE9hwKjwjU
   wUcZBPxBQbI3jvfpgpZkH8IEWyXIs1I1YOl2XLxjjfUa/6OW75i4gObXR
   0JJwEVWylicEsTzU2hdSYPghn6zBNOfXXA+oDXKTPEhDFaH357fCFtgMl
   RroaHEPMh8lnPJsL7tUwXr69rZG06Y9OdmKBbObVe6YpHWi77Oc/WQMoO
   TVHI54yNdbbIBLBhICkDCe7EeXoQX0ihNuL/Y9PToDXdLYUwv21mxwzYL
   E6xLvbOpEU66qdnWP1y+j27c4g/aYKCVJtiegCdNx4qx1tC/FabpVvy17
   w==;
X-CSE-ConnectionGUID: zER2KlRsRkuPxZvvWV6X3g==
X-CSE-MsgGUID: +yZBAweJTw22nkmTCvwsMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21317476"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21317476"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 21:18:03 -0700
X-CSE-ConnectionGUID: svmWSV4MTXKm0371l3vpvQ==
X-CSE-MsgGUID: Ercb4+sWRtSGlK6gpZ6qtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="87741073"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 21:18:00 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <ziy@nvidia.com>
Cc: <linux-mm@kvack.org>,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mm/migrate: move common code to numa_migrate_check
 (was numa_migrate_prep)
In-Reply-To: <20240807184730.1266736-2-ziy@nvidia.com> (Zi Yan's message of
	"Wed, 7 Aug 2024 14:47:30 -0400")
References: <20240807184730.1266736-1-ziy@nvidia.com>
	<20240807184730.1266736-2-ziy@nvidia.com>
Date: Thu, 08 Aug 2024 12:14:26 +0800
Message-ID: <8734nf1wil.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <ziy@nvidia.com> writes:

> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
> reduce redundancy, move common code to numa_migrate_prep() and rename
> the function to numa_migrate_check() to reflect its functionality.
>
> Now do_huge_pmd_numa_page() also checks shared folios to set TNF_SHARED
> flag.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 14 ++-------
>  mm/internal.h    |  5 ++--
>  mm/memory.c      | 76 ++++++++++++++++++++++++------------------------
>  3 files changed, 44 insertions(+), 51 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a3c018f2b554..9b312cae6775 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1699,18 +1699,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	if (!folio)
>  		goto out_map;
>  
> -	/* See similar comment in do_numa_page for explanation */
> -	if (!writable)
> -		flags |= TNF_NO_GROUP;
> -
>  	nid = folio_nid(folio);

NITPICK: It appears that we can remove "nid" local variable.

> -	/*
> -	 * For memory tiering mode, cpupid of slow memory page is used
> -	 * to record page access time.  So use default value.
> -	 */
> -	if (!folio_use_access_time(folio))
> -		last_cpupid = folio_last_cpupid(folio);
> -	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> +
> +	target_nid = numa_migrate_check(folio, vmf, haddr, &flags, writable,
> +					&last_cpupid);
>  	if (target_nid == NUMA_NO_NODE)
>  		goto out_map;
>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> diff --git a/mm/internal.h b/mm/internal.h
> index 52f7fc4e8ac3..fb16e18c9761 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1191,8 +1191,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>  
>  void __vunmap_range_noflush(unsigned long start, unsigned long end);
>  
> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
> -		      unsigned long addr, int page_nid, int *flags);
> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
> +		      unsigned long addr, int *flags, bool writable,
> +		      int *last_cpupid);
>  
>  void free_zone_device_folio(struct folio *folio);
>  int migrate_device_coherent_page(struct page *page);
> diff --git a/mm/memory.c b/mm/memory.c
> index 503d493263df..b093df652c11 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5368,16 +5368,43 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
> -		      unsigned long addr, int page_nid, int *flags)
> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
> +		      unsigned long addr, int *flags,
> +		      bool writable, int *last_cpupid)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  
> +	/*
> +	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
> +	 * much anyway since they can be in shared cache state. This misses
> +	 * the case where a mapping is writable but the process never writes
> +	 * to it but pte_write gets cleared during protection updates and
> +	 * pte_dirty has unpredictable behaviour between PTE scan updates,
> +	 * background writeback, dirty balancing and application behaviour.
> +	 */
> +	if (!writable)
> +		*flags |= TNF_NO_GROUP;
> +
> +	/*
> +	 * Flag if the folio is shared between multiple address spaces. This
> +	 * is later used when determining whether to group tasks together
> +	 */
> +	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
> +		*flags |= TNF_SHARED;
> +	/*
> +	 * For memory tiering mode, cpupid of slow memory page is used
> +	 * to record page access time.  So use default value.
> +	 */
> +	if (folio_use_access_time(folio))
> +		*last_cpupid = (-1 & LAST_CPUPID_MASK);
> +	else
> +		*last_cpupid = folio_last_cpupid(folio);
> +
>  	/* Record the current PID acceesing VMA */
>  	vma_set_access_pid_bit(vma);
>  
>  	count_vm_numa_event(NUMA_HINT_FAULTS);
> -	if (page_nid == numa_node_id()) {
> +	if (folio_nid(folio) == numa_node_id()) {
>  		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
>  		*flags |= TNF_FAULT_LOCAL;
>  	}
> @@ -5442,13 +5469,13 @@ static void numa_rebuild_large_mapping(struct vm_fault *vmf, struct vm_area_stru
>  static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	pte_t old_pte = vmf->orig_pte;

The usage of old_pte is different from other use cases.  Where,

old_pte = *pte;
check old_pte and orig_pte
generate new_pte from old_pte
set new_pte

We have used this before in do_numa_page(), but not do that now.  But I
still think that it's better to follow the convention partly if
possible.  This makes code easier to be read.  I notices that we don't
follow it in do_huge_pmd_numa_page(), we may change that?

> +	pte_t pte;
>  	struct folio *folio = NULL;
>  	int nid = NUMA_NO_NODE;
>  	bool writable = false, ignore_writable = false;
>  	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
> -	int last_cpupid;
> -	int target_nid;
> -	pte_t pte, old_pte;
> +	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);

Because we will initialize last_cpupid in numa_migrate_check(), we don't
need to initialize it here?

>  	int flags = 0, nr_pages;
>  
>  	/*
> @@ -5456,10 +5483,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	 * table lock, that its contents have not changed during fault handling.
>  	 */
>  	spin_lock(vmf->ptl);
> -	/* Read the live PTE from the page tables: */
> -	old_pte = ptep_get(vmf->pte);
> -
> -	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
> +	if (unlikely(!pte_same(old_pte, ptep_get(vmf->pte)))) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  		goto out;
>  	}

[snip]

--
Best Regards,
Huang, Ying

