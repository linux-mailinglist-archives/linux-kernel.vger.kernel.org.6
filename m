Return-Path: <linux-kernel+bounces-256160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA81934A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEB911F23E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F17D075;
	Thu, 18 Jul 2024 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HeDKXTp5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18B3B784
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292017; cv=none; b=a52dPtYAn7NLsawGRAeS1d6Kk1R8Cs8xdGZmy8CY0v2DKcTUSCLTXpGk6hVYm5ZKuyCghNDlf9kKB6kXaDauYQoScyuTNRmWpvD83J1GjOGf5QB+A1SMOIIMPs2Be6yHF3itGaaHREtEzVYQeX6kl9XOh9rTv8zY4Vnu+PN4y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292017; c=relaxed/simple;
	bh=pmVR/peiXH3BQKZbh/1kDwjsp5ffJ3UEojs7kWLo3kI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=klT8GoyLY2l6EfTdTM7D+dQXgVahCDJvm1WbCkwZIR5j3oaZJT67QUODoG6Ka84S88DJ3C7iKplhZ60HVx7NEtxqlRRUE8kMsI9yqrQ/SQZATWRCoLA79USGNindq1F4DW18C/aQ48e8E8LmIbAe2KHCtY9zmi1vF7D0Teny94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HeDKXTp5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721292016; x=1752828016;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=pmVR/peiXH3BQKZbh/1kDwjsp5ffJ3UEojs7kWLo3kI=;
  b=HeDKXTp5faQnzOWf4wRmZNqayGUv0SIBmRyqESO0aReUwALS4m9tOWI5
   HKhco0adEcDugKeFRnjXIWS4uieRU+vG6lgSyqxgzWVi+/WvZg+jWQyEw
   NZCvD3qi3iC5sHVafiTOu2kFe4mKS7FK1n1poHUnBV3jhqOJx/Nj6xToY
   WrYE6rXWtUdlop7viznfqGbG+vw0urYOOTgALFVw426nauEYIz0iKohCF
   h7qSQZQ9smMrrQjvBnjAe24gKh6YUA4d9Dk8c8wBv3i5Wp0MQgCzl2OeO
   cdkrb/D2gjGlraIXGkSatBdXTmUVrSx04Bp1YB38lvUnMnF1ykk9DDjs4
   A==;
X-CSE-ConnectionGUID: tkIP+r+aSJmMdq85hDsc4A==
X-CSE-MsgGUID: BduicV+2TZWwHARcUOJh9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18709409"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="18709409"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:40:15 -0700
X-CSE-ConnectionGUID: c/SEOOoUSAKKvsOX1zTkjQ==
X-CSE-MsgGUID: 2VlH7bIdTCmGAPNG0WD6Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="51405001"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 01:40:12 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Zi Yan <zi.yan@sent.com>
Cc: David Hildenbrand <david@redhat.com>,  linux-mm@kvack.org,  Zi Yan
 <ziy@nvidia.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mm/migrate: move common code to
 numa_migrate_check (was numa_migrate_prep)
In-Reply-To: <20240712024455.163543-4-zi.yan@sent.com> (Zi Yan's message of
	"Thu, 11 Jul 2024 22:44:55 -0400")
References: <20240712024455.163543-1-zi.yan@sent.com>
	<20240712024455.163543-4-zi.yan@sent.com>
Date: Thu, 18 Jul 2024 16:36:39 +0800
Message-ID: <87zfqfw0yw.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Zi Yan <zi.yan@sent.com> writes:

> From: Zi Yan <ziy@nvidia.com>
>
> do_numa_page() and do_huge_pmd_numa_page() share a lot of common code. To
> reduce redundancy, move common code to numa_migrate_prep() and rename
> the function to numa_migrate_check() to reflect its functionality.
>
> There is some code difference between do_numa_page() and
> do_huge_pmd_numa_page() before the code move:
>
> 1. do_huge_pmd_numa_page() did not check shared folios to set TNF_SHARED.
> 2. do_huge_pmd_numa_page() did not check and skip zone device folios.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/huge_memory.c | 28 ++++++-----------
>  mm/internal.h    |  5 +--
>  mm/memory.c      | 81 +++++++++++++++++++++++-------------------------
>  3 files changed, 52 insertions(+), 62 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8c11d6da4b36..66d67d13e0dc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1670,10 +1670,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	pmd_t pmd;
>  	struct folio *folio;
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
> -	int nid = NUMA_NO_NODE;
> -	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
> +	int target_nid = NUMA_NO_NODE;
> +	int last_cpupid = (-1 & LAST_CPUPID_MASK);
>  	bool writable = false;
> -	int flags = 0;
> +	int flags = 0, nr_pages;
>  
>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> @@ -1693,21 +1693,13 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  		writable = true;
>  
>  	folio = vm_normal_folio_pmd(vma, haddr, pmd);
> -	if (!folio)
> +	if (!folio || folio_is_zone_device(folio))

This change appears unrelated.  Can we put it in a separate patch?

IIUC, this isn't necessary even in do_numa_page()?  Because in
change_pte_range(), folio_is_zone_device() has been checked already.
But It doesn't hurt too.

>  		goto out_map;
>  
> -	/* See similar comment in do_numa_page for explanation */
> -	if (!writable)
> -		flags |= TNF_NO_GROUP;
> +	nr_pages = folio_nr_pages(folio);
>  
> -	nid = folio_nid(folio);
> -	/*
> -	 * For memory tiering mode, cpupid of slow memory page is used
> -	 * to record page access time.  So use default value.
> -	 */
> -	if (folio_has_cpupid(folio))
> -		last_cpupid = folio_last_cpupid(folio);
> -	target_nid = numa_migrate_prep(folio, vmf, haddr, nid, &flags);
> +	target_nid = numa_migrate_check(folio, vmf, haddr, writable,
> +			&flags, &last_cpupid);
>  	if (target_nid == NUMA_NO_NODE)
>  		goto out_map;
>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> @@ -1720,8 +1712,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  
>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
>  		flags |= TNF_MIGRATED;
> -		nid = target_nid;
>  	} else {
> +		target_nid = NUMA_NO_NODE;
>  		flags |= TNF_MIGRATE_FAIL;
>  		vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>  		if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> @@ -1732,8 +1724,8 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	}
>  
>  out:
> -	if (nid != NUMA_NO_NODE)
> -		task_numa_fault(last_cpupid, nid, HPAGE_PMD_NR, flags);
> +	if (target_nid != NUMA_NO_NODE)
> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);

This appears a behavior change.  IIUC, there are 2 possible issues.

1) if migrate_misplaced_folio() fails, folio_nid() should be used as
nid.  "target_nid" as variable name here is confusing, because
folio_nid() is needed in fact.

2) if !pmd_same(), task_numa_fault() should be skipped.  The original
code is buggy.

Similar issues for do_numa_page().

If my understanding were correct, we should implement a separate patch
to fix 2) above.  And that may need to be backported.

>  
>  	return 0;
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index b4d86436565b..7782b7bb3383 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1217,8 +1217,9 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>  
>  void __vunmap_range_noflush(unsigned long start, unsigned long end);
>  
> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
> -		      unsigned long addr, int page_nid, int *flags);
> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
> +		      unsigned long addr, bool writable,
> +		      int *flags, int *last_cpupid);
>  
>  void free_zone_device_folio(struct folio *folio);
>  int migrate_device_coherent_page(struct page *page);
> diff --git a/mm/memory.c b/mm/memory.c
> index 96c2f5b3d796..a252c0f13755 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5209,16 +5209,42 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>  	return ret;
>  }
>  
> -int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
> -		      unsigned long addr, int page_nid, int *flags)
> +int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
> +		      unsigned long addr, bool writable,
> +		      int *flags, int *last_cpupid)
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
> +
> +	/*
> +	 * For memory tiering mode, cpupid of slow memory page is used
> +	 * to record page access time.
> +	 */
> +	if (folio_has_cpupid(folio))
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
> @@ -5284,12 +5310,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct folio *folio = NULL;
> -	int nid = NUMA_NO_NODE;
> +	int target_nid = NUMA_NO_NODE;
>  	bool writable = false, ignore_writable = false;
>  	bool pte_write_upgrade = vma_wants_manual_pte_write_upgrade(vma);
> -	int last_cpupid;
> -	int target_nid;
> -	pte_t pte, old_pte;
> +	int last_cpupid = (-1 & LAST_CPUPID_MASK);
> +	pte_t pte, old_pte = vmf->orig_pte;
>  	int flags = 0, nr_pages;
>  
>  	/*
> @@ -5297,10 +5322,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	 * table lock, that its contents have not changed during fault handling.
>  	 */
>  	spin_lock(vmf->ptl);
> -	/* Read the live PTE from the page tables: */
> -	old_pte = ptep_get(vmf->pte);
> -
> -	if (unlikely(!pte_same(old_pte, vmf->orig_pte))) {
> +	if (unlikely(!pte_same(old_pte, *vmf->pte))) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  		goto out;
>  	}
> @@ -5320,35 +5342,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	if (!folio || folio_is_zone_device(folio))
>  		goto out_map;
>  
> -	/*
> -	 * Avoid grouping on RO pages in general. RO pages shouldn't hurt as
> -	 * much anyway since they can be in shared cache state. This misses
> -	 * the case where a mapping is writable but the process never writes
> -	 * to it but pte_write gets cleared during protection updates and
> -	 * pte_dirty has unpredictable behaviour between PTE scan updates,
> -	 * background writeback, dirty balancing and application behaviour.
> -	 */
> -	if (!writable)
> -		flags |= TNF_NO_GROUP;
> -
> -	/*
> -	 * Flag if the folio is shared between multiple address spaces. This
> -	 * is later used when determining whether to group tasks together
> -	 */
> -	if (folio_likely_mapped_shared(folio) && (vma->vm_flags & VM_SHARED))
> -		flags |= TNF_SHARED;
> -
> -	nid = folio_nid(folio);
>  	nr_pages = folio_nr_pages(folio);
> -	/*
> -	 * For memory tiering mode, cpupid of slow memory page is used
> -	 * to record page access time.  So use default value.
> -	 */
> -	if (!folio_has_cpupid(folio))
> -		last_cpupid = (-1 & LAST_CPUPID_MASK);
> -	else
> -		last_cpupid = folio_last_cpupid(folio);
> -	target_nid = numa_migrate_prep(folio, vmf, vmf->address, nid, &flags);
> +
> +	target_nid = numa_migrate_check(folio, vmf, vmf->address, writable,
> +			&flags, &last_cpupid);
>  	if (target_nid == NUMA_NO_NODE)
>  		goto out_map;
>  	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
> @@ -5362,9 +5359,9 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  
>  	/* Migrate to the requested node */
>  	if (!migrate_misplaced_folio(folio, vma, target_nid)) {
> -		nid = target_nid;
>  		flags |= TNF_MIGRATED;
>  	} else {
> +		target_nid = NUMA_NO_NODE;
>  		flags |= TNF_MIGRATE_FAIL;
>  		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
>  					       vmf->address, &vmf->ptl);
> @@ -5378,8 +5375,8 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	}
>  
>  out:
> -	if (nid != NUMA_NO_NODE)
> -		task_numa_fault(last_cpupid, nid, nr_pages, flags);
> +	if (target_nid != NUMA_NO_NODE)
> +		task_numa_fault(last_cpupid, target_nid, nr_pages, flags);
>  	return 0;
>  out_map:
>  	/*

--
Best Regards,
Huang, Ying

