Return-Path: <linux-kernel+bounces-326886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0845976E18
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7DB281546
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E301BA27E;
	Thu, 12 Sep 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHPDD4sl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E8819599C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726155917; cv=none; b=aI3OPpuhgINrd1QgiD7dU6Cf4cvfnBsuXgbrnJpc5EsBx6cJRs7LSPE9aM7jkDAmcBn2NVJ+zAtOUz6HMEM8xCu2BGuy7MxVsXKUPsH7MGccHT57oLBt5fl+5BUqMvgckyjyImHmu2jBCXGfcQMz+IZTh13QQ0iSWg2YqwbNSWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726155917; c=relaxed/simple;
	bh=dtPXSulbykHELgA6KlNOG1jUsqjNTl9c9tSwAa79oUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nhd3AfY7Os0j9ZCysREjSerDa+GF3ddyj0p/TOix1YUPvHyRMB2cBrAmQE25dmpbkG2vKind2UvUvfU+Z0E4044cjj4u/+/l3L+ZajOdmF+m9CXNTPl3EN8YAZ7eFgYUXI/klwdp9Vow2181yOBbK06oXy2Lju8XdhgKO0c0fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHPDD4sl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726155916; x=1757691916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dtPXSulbykHELgA6KlNOG1jUsqjNTl9c9tSwAa79oUw=;
  b=KHPDD4slsjWfI3whVPYwn0IYDMi7G8j0amTxLtMa5Sg+PojpdY+uwoCN
   lxIPyV6MopksA806rM5IH1wKEGnrZFKxX9Fi9oLDjQi4Cq/fKc/JTapry
   dENIvpg4YSKa3P6INtWuK9ExWOBZQ4x+1SvrB8lJtZa7fWIHeL+X9V1cS
   xrv+KjKmafzawLT7RRkaShIpdv8RB3VbopHJ6WvCoVG9kDNmBvj9mQuVE
   4uVabnEMAHrix5uSehoV/otnHUvnK9iJEC29als82tgFNxZbwtvYn0m0E
   DOZRGTArf5aHk/3HwHktApbarKagoQMVZWSPG59Tp5/d9x4kGpp7AzBG6
   A==;
X-CSE-ConnectionGUID: cpPYoUfKRqSDVGjDMsOmWg==
X-CSE-MsgGUID: 7jelQZAgQJatPWECNvAQKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="27936396"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="27936396"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:45:15 -0700
X-CSE-ConnectionGUID: APSUk5wjTKm2ulJ/KFUIuw==
X-CSE-MsgGUID: CzzMDPpXR7yA6cA3hYPWrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="72754341"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 08:45:08 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1som0H-0005P4-1o;
	Thu, 12 Sep 2024 15:45:05 +0000
Date: Thu, 12 Sep 2024 23:44:42 +0800
From: kernel test robot <lkp@intel.com>
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
	david@redhat.com, willy@infradead.org,
	kirill.shutemov@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ryan.roberts@arm.com, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, cl@gentwo.org, vbabka@suse.cz,
	mhocko@suse.com, apopple@nvidia.com, dave.hansen@linux.intel.com,
	will@kernel.org, baohua@kernel.org, jack@suse.cz,
	mark.rutland@arm.com, hughd@google.com, aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com, peterx@redhat.com, ioworker0@gmail.com,
	jglisse@google.com, wangkefeng.wang@huawei.com, ziy@nvidia.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH v3 2/2] mm: Allocate THP on hugezeropage wp-fault
Message-ID: <202409122349.PQp7sq2x-lkp@intel.com>
References: <20240911065600.1002644-3-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911065600.1002644-3-dev.jain@arm.com>

Hi Dev,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.11-rc7]
[also build test WARNING on linus/master]
[cannot apply to akpm-mm/mm-everything next-20240912]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dev-Jain/mm-Abstract-THP-allocation/20240911-145809
base:   v6.11-rc7
patch link:    https://lore.kernel.org/r/20240911065600.1002644-3-dev.jain%40arm.com
patch subject: [PATCH v3 2/2] mm: Allocate THP on hugezeropage wp-fault
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240912/202409122349.PQp7sq2x-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240912/202409122349.PQp7sq2x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409122349.PQp7sq2x-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/huge_memory.c:990:15: warning: variable 'old_pmd' set but not used [-Wunused-but-set-variable]
     990 |         pmd_t entry, old_pmd;
         |                      ^
   mm/huge_memory.c:1016:6: warning: variable 'pgtable' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    1016 |         if (unlikely(!folio)) {
         |             ^~~~~~~~~~~~~~~~
   include/linux/compiler.h:77:22: note: expanded from macro 'unlikely'
      77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/huge_memory.c:1055:6: note: uninitialized use occurs here
    1055 |         if (pgtable)
         |             ^~~~~~~
   mm/huge_memory.c:1016:2: note: remove the 'if' if its condition is always false
    1016 |         if (unlikely(!folio)) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~
    1017 |                 ret = VM_FAULT_FALLBACK;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~
    1018 |                 goto release;
         |                 ~~~~~~~~~~~~~
    1019 |         }
         |         ~
   mm/huge_memory.c:1010:19: note: initialize the variable 'pgtable' to silence this warning
    1010 |         pgtable_t pgtable;
         |                          ^
         |                           = NULL
   2 warnings generated.


vim +/old_pmd +990 mm/huge_memory.c

   986	
   987	static void map_pmd_thp(struct folio *folio, struct vm_fault *vmf,
   988				struct vm_area_struct *vma, unsigned long haddr)
   989	{
 > 990		pmd_t entry, old_pmd;
   991		bool is_pmd_none = pmd_none(*vmf->pmd);
   992	
   993		entry = mk_huge_pmd(&folio->page, vma->vm_page_prot);
   994		entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
   995		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
   996		folio_add_lru_vma(folio, vma);
   997		if (!is_pmd_none)
   998			old_pmd = pmdp_huge_clear_flush(vma, haddr, vmf->pmd);
   999		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
  1000		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
  1001		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
  1002		if (is_pmd_none)
  1003			mm_inc_nr_ptes(vma->vm_mm);
  1004	}
  1005	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

