Return-Path: <linux-kernel+bounces-263978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4016393DD75
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 07:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC60F1F23BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129711A286;
	Sat, 27 Jul 2024 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OD1Ng6im"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0222940F
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722059904; cv=none; b=g6ZFTQ/3i0xTOR3eRJCYqMmAlpPrFYHFYgE4Jyc/aPbbMzIyO0tc4YphDqdTAaT936zdkL40QsyScpB257S/lik3hhqdjIiJDT0B318VhJ97v9vUHbFU5oYtLJn3IdVPKnUtnG+pieN8OGJ5+W3lJIhnfpCbnzRxUPf9QrYrS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722059904; c=relaxed/simple;
	bh=KtfQAzM1qX6n3C8qYrHD8Uyj3nlGOT0SIvPz8lY3/Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1Rmv9Dx/N54AviyhU8/V9nPlvMLXeXPs0scsunQxU0SqmfYaSNhFHRr5+C08FFRqsfI/eUxlqzYNizuUfzsrX2fW8CV94tpBbeY8sd3fZB75c0Zi0KVVqMoaz2kyqVHCf5SsbPY+/9v/CkFj9PhCafzntPMIIwunryOd5vFadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OD1Ng6im; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722059902; x=1753595902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtfQAzM1qX6n3C8qYrHD8Uyj3nlGOT0SIvPz8lY3/Yc=;
  b=OD1Ng6imJGF6OW6kwxQI1ttI83qqTlk1ATU6WGHEKk081Hi8QC5r6/pn
   osV3vCBrr9tpwP+m7qOpASVH9jCuCrKaPCauGzXkK+KfXOsanMiXTSOto
   IZ9uFo6gYiBk4mtNCjjRXMsSPjXoT/JoWZQGnlwgDaXUee7UZ++/GvBIU
   q37xHvZ9PSVZbBEvpwn+3qyJm6aZjvizzxmwMB31EHvV1z0F1xS15TMYn
   Ag4ZfxJzPOKtKWf/GctVav7U9qrepWjrjjhxm+wdC8FNt35zKm98LR9tB
   RwrGcUE7zMmcfddSqutZfdXGDpa2DTx2B2QebbkMYGwnauZ1pwSmRXP9S
   Q==;
X-CSE-ConnectionGUID: wwup+MmVQqKFMRKjDiMgEQ==
X-CSE-MsgGUID: 62OwPHzWS6GVOztTDhOmKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11145"; a="19996465"
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="19996465"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2024 22:58:21 -0700
X-CSE-ConnectionGUID: JdxGPiyyQ3yw9rO7ADkNQg==
X-CSE-MsgGUID: O9wa2+aWRKCX9UiF3O5TqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,240,1716274800"; 
   d="scan'208";a="57758100"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Jul 2024 22:58:16 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sXaRZ-000pf2-2r;
	Sat, 27 Jul 2024 05:58:13 +0000
Date: Sat, 27 Jul 2024 13:58:04 +0800
From: kernel test robot <lkp@intel.com>
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: oe-kbuild-all@lists.linux.dev, ying.huang@intel.com,
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com,
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com,
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com,
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com,
	senozhatsky@chromium.org, shakeel.butt@linux.dev,
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com,
	willy@infradead.org, xiang@kernel.org, yosryahmed@google.com
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
Message-ID: <202407271351.ffZPMT6W-lkp@intel.com>
References: <20240726094618.401593-5-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726094618.401593-5-21cnbao@gmail.com>

Hi Barry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Barry-Song/mm-swap-introduce-swapcache_prepare_nr-and-swapcache_clear_nr-for-large-folios-swap-in/20240726-181412
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240726094618.401593-5-21cnbao%40gmail.com
patch subject: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
config: x86_64-randconfig-121-20240727 (https://download.01.org/0day-ci/archive/20240727/202407271351.ffZPMT6W-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240727/202407271351.ffZPMT6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407271351.ffZPMT6W-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/huge_memory.c:83:15: sparse: sparse: symbol 'huge_anon_orders_swapin_always' was not declared. Should it be static?
   mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   mm/huge_memory.c:1867:20: sparse: sparse: context imbalance in 'madvise_free_huge_pmd' - unexpected unlock
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   mm/huge_memory.c:1905:28: sparse: sparse: context imbalance in 'zap_huge_pmd' - unexpected unlock
   mm/huge_memory.c:2016:28: sparse: sparse: context imbalance in 'move_huge_pmd' - unexpected unlock
   mm/huge_memory.c:2156:20: sparse: sparse: context imbalance in 'change_huge_pmd' - unexpected unlock
   mm/huge_memory.c:2306:12: sparse: sparse: context imbalance in '__pmd_trans_huge_lock' - wrong count at exit
   mm/huge_memory.c:2323:12: sparse: sparse: context imbalance in '__pud_trans_huge_lock' - wrong count at exit
   mm/huge_memory.c:2347:28: sparse: sparse: context imbalance in 'zap_huge_pud' - unexpected unlock
   mm/huge_memory.c:2426:18: sparse: sparse: context imbalance in '__split_huge_zero_page_pmd' - unexpected unlock
   mm/huge_memory.c:2640:18: sparse: sparse: context imbalance in '__split_huge_pmd_locked' - unexpected unlock
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   mm/huge_memory.c:3031:30: sparse: sparse: context imbalance in '__split_huge_page' - unexpected unlock
   mm/huge_memory.c:3306:17: sparse: sparse: context imbalance in 'split_huge_page_to_list_to_order' - different lock contexts for basic block
   mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   mm/huge_memory.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   mm/huge_memory.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false

vim +/huge_anon_orders_swapin_always +83 mm/huge_memory.c

    51	
    52	/*
    53	 * By default, transparent hugepage support is disabled in order to avoid
    54	 * risking an increased memory footprint for applications that are not
    55	 * guaranteed to benefit from it. When transparent hugepage support is
    56	 * enabled, it is for all mappings, and khugepaged scans all mappings.
    57	 * Defrag is invoked by khugepaged hugepage allocations and by page faults
    58	 * for all hugepage allocations.
    59	 */
    60	unsigned long transparent_hugepage_flags __read_mostly =
    61	#ifdef CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS
    62		(1<<TRANSPARENT_HUGEPAGE_FLAG)|
    63	#endif
    64	#ifdef CONFIG_TRANSPARENT_HUGEPAGE_MADVISE
    65		(1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)|
    66	#endif
    67		(1<<TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG)|
    68		(1<<TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG)|
    69		(1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
    70	
    71	static struct shrinker *deferred_split_shrinker;
    72	static unsigned long deferred_split_count(struct shrinker *shrink,
    73						  struct shrink_control *sc);
    74	static unsigned long deferred_split_scan(struct shrinker *shrink,
    75						 struct shrink_control *sc);
    76	
    77	static atomic_t huge_zero_refcount;
    78	struct folio *huge_zero_folio __read_mostly;
    79	unsigned long huge_zero_pfn __read_mostly = ~0UL;
    80	unsigned long huge_anon_orders_always __read_mostly;
    81	unsigned long huge_anon_orders_madvise __read_mostly;
    82	unsigned long huge_anon_orders_inherit __read_mostly;
  > 83	unsigned long huge_anon_orders_swapin_always __read_mostly;
    84	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

