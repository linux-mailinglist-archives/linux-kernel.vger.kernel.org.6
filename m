Return-Path: <linux-kernel+bounces-200909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5018FB663
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7958928627C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344213C8FF;
	Tue,  4 Jun 2024 14:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpLdlIbm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2313BB24
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513167; cv=none; b=BPb2nGb9D0EcdxBlPMdoU/8Hicc3pEiG1qAU7RR12+fYwQZpscj/pexTgndewMbrB93cu0pxAfS4R/OSwPD80wkR5J4HSv+TTjSQV7kOeOwwqkdbLHDwmbMJaP7qPP5g9S3k+l8fXATlTj7ZojIPGvNw+nmzUyV3e1CaKIaCbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513167; c=relaxed/simple;
	bh=i1Mw6KgpcsjR+lCb2lbnWjfFdwskGTmzn+yGj18OkOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nuu+p4PR2qWYbBlHyn631DgiEOWYGnXnHTNXoqJR6t/ovUfJewpF+IVTXIawm1D5UBMzv3VGbII1CTrJ3smuzty8xEcrsAQkUmPsKY18K67Kol2miNJW30iXmVcBn2HbcZpR5SlWu1MOGJsi/kDZAwgbQR1QukskKO5gKVD9pPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpLdlIbm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717513165; x=1749049165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1Mw6KgpcsjR+lCb2lbnWjfFdwskGTmzn+yGj18OkOE=;
  b=TpLdlIbm97WN+R4ghDESMPmKgBRi8qZt9TyTkLaMqzgSVHQmDksB2h6J
   U8LFax8FJiSBUfB+U5MMIGRBk06906AAdDS7rNPUQNQi9sxnBIkHqqGFt
   RSlKcOLc7fu3h3bX69xatQ+cTKFSB499QgNicOruAqWJcUQJVwvsNFKBU
   DOHB4AIdSuJJ5HHSp1bOFg+oOKxh+TkHoGaJcTW5xj8huA3NNX4yKE2wB
   OcP7Mlu+uBP2kmo4aJeGsMlIx0BdVX3JPojkTJ9qZ6Tt9OVjLCRi2pBhl
   r665BT4RHt/6BPTiRZsCtxQicvpyjhpNuDhpDnM6/K89PLAyFZEgea6NS
   Q==;
X-CSE-ConnectionGUID: I88ighxEQA+zIHjkVUIv+g==
X-CSE-MsgGUID: pJFAKciATFmznQTIvsP0Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36584960"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="36584960"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 07:59:25 -0700
X-CSE-ConnectionGUID: HEI6MhllQf2dJHfdcSaHQQ==
X-CSE-MsgGUID: UnPHK4ksSv+ICmkEhfAVLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; 
   d="scan'208";a="37341622"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2024 07:59:20 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEVd8-000NOD-1T;
	Tue, 04 Jun 2024 14:59:18 +0000
Date: Tue, 4 Jun 2024 22:58:46 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: oe-kbuild-all@lists.linux.dev, willy@infradead.org, david@redhat.com,
	wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
	ioworker0@gmail.com, da.gomez@samsung.com, p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] mm: memory: extend finish_fault() to support
 large folio
Message-ID: <202406042210.20LfqwNd-lkp@intel.com>
References: <bee11bfd9157e60aaea6db033a4af7c13c982c82.1717495894.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee11bfd9157e60aaea6db033a4af7c13c982c82.1717495894.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.10-rc2 next-20240604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-memory-extend-finish_fault-to-support-large-folio/20240604-182028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/bee11bfd9157e60aaea6db033a4af7c13c982c82.1717495894.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH v4 1/6] mm: memory: extend finish_fault() to support large folio
config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20240604/202406042210.20LfqwNd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240604/202406042210.20LfqwNd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406042210.20LfqwNd-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/memory.c: In function 'finish_fault':
>> mm/memory.c:4838:29: warning: unused variable 'i' [-Wunused-variable]
    4838 |         int type, nr_pages, i;
         |                             ^


vim +/i +4838 mm/memory.c

  4814	
  4815	/**
  4816	 * finish_fault - finish page fault once we have prepared the page to fault
  4817	 *
  4818	 * @vmf: structure describing the fault
  4819	 *
  4820	 * This function handles all that is needed to finish a page fault once the
  4821	 * page to fault in is prepared. It handles locking of PTEs, inserts PTE for
  4822	 * given page, adds reverse page mapping, handles memcg charges and LRU
  4823	 * addition.
  4824	 *
  4825	 * The function expects the page to be locked and on success it consumes a
  4826	 * reference of a page being mapped (for the PTE which maps it).
  4827	 *
  4828	 * Return: %0 on success, %VM_FAULT_ code in case of error.
  4829	 */
  4830	vm_fault_t finish_fault(struct vm_fault *vmf)
  4831	{
  4832		struct vm_area_struct *vma = vmf->vma;
  4833		struct page *page;
  4834		struct folio *folio;
  4835		vm_fault_t ret;
  4836		bool is_cow = (vmf->flags & FAULT_FLAG_WRITE) &&
  4837			      !(vma->vm_flags & VM_SHARED);
> 4838		int type, nr_pages, i;
  4839		unsigned long addr = vmf->address;
  4840	
  4841		/* Did we COW the page? */
  4842		if (is_cow)
  4843			page = vmf->cow_page;
  4844		else
  4845			page = vmf->page;
  4846	
  4847		/*
  4848		 * check even for read faults because we might have lost our CoWed
  4849		 * page
  4850		 */
  4851		if (!(vma->vm_flags & VM_SHARED)) {
  4852			ret = check_stable_address_space(vma->vm_mm);
  4853			if (ret)
  4854				return ret;
  4855		}
  4856	
  4857		if (pmd_none(*vmf->pmd)) {
  4858			if (PageTransCompound(page)) {
  4859				ret = do_set_pmd(vmf, page);
  4860				if (ret != VM_FAULT_FALLBACK)
  4861					return ret;
  4862			}
  4863	
  4864			if (vmf->prealloc_pte)
  4865				pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
  4866			else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
  4867				return VM_FAULT_OOM;
  4868		}
  4869	
  4870		folio = page_folio(page);
  4871		nr_pages = folio_nr_pages(folio);
  4872	
  4873		/*
  4874		 * Using per-page fault to maintain the uffd semantics, and same
  4875		 * approach also applies to non-anonymous-shmem faults to avoid
  4876		 * inflating the RSS of the process.
  4877		 */
  4878		if (!vma_is_anon_shmem(vma) || unlikely(userfaultfd_armed(vma))) {
  4879			nr_pages = 1;
  4880		} else if (nr_pages > 1) {
  4881			pgoff_t idx = folio_page_idx(folio, page);
  4882			/* The page offset of vmf->address within the VMA. */
  4883			pgoff_t vma_off = vmf->pgoff - vmf->vma->vm_pgoff;
  4884	
  4885			/*
  4886			 * Fallback to per-page fault in case the folio size in page
  4887			 * cache beyond the VMA limits.
  4888			 */
  4889			if (unlikely(vma_off < idx ||
  4890				     vma_off + (nr_pages - idx) > vma_pages(vma))) {
  4891				nr_pages = 1;
  4892			} else {
  4893				/* Now we can set mappings for the whole large folio. */
  4894				addr = vmf->address - idx * PAGE_SIZE;
  4895				page = &folio->page;
  4896			}
  4897		}
  4898	
  4899		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
  4900					       addr, &vmf->ptl);
  4901		if (!vmf->pte)
  4902			return VM_FAULT_NOPAGE;
  4903	
  4904		/* Re-check under ptl */
  4905		if (nr_pages == 1 && unlikely(vmf_pte_changed(vmf))) {
  4906			update_mmu_tlb(vma, addr, vmf->pte);
  4907			ret = VM_FAULT_NOPAGE;
  4908			goto unlock;
  4909		} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
  4910			update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
  4911			ret = VM_FAULT_NOPAGE;
  4912			goto unlock;
  4913		}
  4914	
  4915		folio_ref_add(folio, nr_pages - 1);
  4916		set_pte_range(vmf, folio, page, nr_pages, addr);
  4917		type = is_cow ? MM_ANONPAGES : mm_counter_file(folio);
  4918		add_mm_counter(vma->vm_mm, type, nr_pages);
  4919		ret = 0;
  4920	
  4921	unlock:
  4922		pte_unmap_unlock(vmf->pte, vmf->ptl);
  4923		return ret;
  4924	}
  4925	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

