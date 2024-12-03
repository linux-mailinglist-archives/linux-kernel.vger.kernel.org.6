Return-Path: <linux-kernel+bounces-428710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826039E126A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 05:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44766163F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 04:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA75F166F29;
	Tue,  3 Dec 2024 04:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SufiJ7Cp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC7C2BD1D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 04:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733200173; cv=none; b=uwvqYz5lX/UfKjahC6/VRstg09DuWTAIpJlj3bCQLGQDrVE2Qi2oWoFxoevKSD/fOHARuUXMC63znZzNh8YPrLtbyjl3/yPuH+HFoXTGBs/th643QY1NLkYAnniUD/AS5JnVc4tTqP3kJBsqem+diAR37s1cI/NIcM5vzGh7+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733200173; c=relaxed/simple;
	bh=8LzHyHyK1YsCDvMTV40SWfCyPPZFDPlb7TwyCAzoT80=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PAcehLa8t0XpcuhFIQQk02L1iGxYuGgPRNtpOvDHllHW3qOR4sOy9SDSKtak6pqzotlRVrDNU8vdedA7VLvNT6asxFW0EkIB2s6T5gVWQ8+a6uXyst5CzAAq8n3YFz6pXryTtAayKz90mgHQkcBmJskiyfLG3XDJTARt6KmSpg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SufiJ7Cp; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733200171; x=1764736171;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8LzHyHyK1YsCDvMTV40SWfCyPPZFDPlb7TwyCAzoT80=;
  b=SufiJ7CpVP+NaXM8X3dP006hWGtGJtpEzjSq/PXNnkBMnNuRhXHftFSB
   Qvctk+VI1luEAQGk8rWo6CorFv4oxl4k/uz07ecPwelA4cbII7vvkRWlT
   BAxqxM2zWWRw9um+zDTKkfXjBa/u7+6tCYgZOPt5VD07l4oTKaTdej+57
   WGCyYu17of0QzjMGQY+OJWz+6biVwrHUbVgSFzfcui5eKGYXV0cn5yrF5
   mDxPsqZrO/g8lpU/h+a2tQ3KqsylSKXhTdtKGjov1xfnG0D4xUoqOAgLy
   aABTL6gRlpRrph2Ow05ZtDtzuqDn6u0eo5Vmkh+kPbMYfksaCXMNCsqgd
   w==;
X-CSE-ConnectionGUID: Gk+65hgsTcmHfjqvUmeeRg==
X-CSE-MsgGUID: RJGDL1dhRCCRYiIQyHEmVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33453881"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33453881"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 20:29:30 -0800
X-CSE-ConnectionGUID: uN/eLNXCRRKIFpBMHZ+4xg==
X-CSE-MsgGUID: T612cGxhQ2iPKGYXdoeILA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="92976031"
Received: from lkp-server01.sh.intel.com (HELO 388c121a226b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 02 Dec 2024 20:29:28 -0800
Received: from kbuild by 388c121a226b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIKXO-00006B-0H;
	Tue, 03 Dec 2024 04:29:26 +0000
Date: Tue, 3 Dec 2024 12:28:47 +0800
From: kernel test robot <lkp@intel.com>
To: Amadeusz =?unknown-8bit?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: kernel/power/snapshot.c:982: warning: Function parameter or member
 'start_pfn' not described in 'register_nosave_region'
Message-ID: <202412031251.dBfdJbQp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Amadeusz,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cdd30ebb1b9f36159d66f088b61aee264e649d7a
commit: 33569ef3c754a82010f266b7b938a66a3ccf90a4 PM: hibernate: Remove register_nosave_region_late()
date:   2 years, 10 months ago
config: i386-buildonly-randconfig-001-20240107 (https://download.01.org/0day-ci/archive/20241203/202412031251.dBfdJbQp-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031251.dBfdJbQp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031251.dBfdJbQp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/power/snapshot.c:330: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Data types related to memory bitmaps.
   kernel/power/snapshot.c:438: warning: Function parameter or member 'gfp_mask' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:438: warning: Function parameter or member 'safe_needed' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:438: warning: Function parameter or member 'ca' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:438: warning: Function parameter or member 'list' not described in 'alloc_rtree_node'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'zone' not described in 'add_rtree_block'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'gfp_mask' not described in 'add_rtree_block'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'safe_needed' not described in 'add_rtree_block'
   kernel/power/snapshot.c:463: warning: Function parameter or member 'ca' not described in 'add_rtree_block'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'gfp_mask' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'safe_needed' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'ca' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'start' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:536: warning: Function parameter or member 'end' not described in 'create_zone_bm_rtree'
   kernel/power/snapshot.c:571: warning: Function parameter or member 'zone' not described in 'free_zone_bm_rtree'
   kernel/power/snapshot.c:571: warning: Function parameter or member 'clear_nosave_free' not described in 'free_zone_bm_rtree'
   kernel/power/snapshot.c:678: warning: Function parameter or member 'bm' not described in 'memory_bm_create'
   kernel/power/snapshot.c:678: warning: Function parameter or member 'gfp_mask' not described in 'memory_bm_create'
   kernel/power/snapshot.c:678: warning: Function parameter or member 'safe_needed' not described in 'memory_bm_create'
   kernel/power/snapshot.c:720: warning: Function parameter or member 'clear_nosave_free' not described in 'memory_bm_free'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'bm' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'pfn' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'addr' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:742: warning: Function parameter or member 'bit_nr' not described in 'memory_bm_find_bit'
   kernel/power/snapshot.c:916: warning: expecting prototype for memory_bm_rtree_next_pfn(). Prototype was for memory_bm_next_pfn() instead
>> kernel/power/snapshot.c:982: warning: Function parameter or member 'start_pfn' not described in 'register_nosave_region'
>> kernel/power/snapshot.c:982: warning: Function parameter or member 'end_pfn' not described in 'register_nosave_region'
   kernel/power/snapshot.c:1254: warning: Function parameter or member 'zone' not described in 'saveable_highmem_page'
   kernel/power/snapshot.c:1254: warning: Function parameter or member 'pfn' not described in 'saveable_highmem_page'
   kernel/power/snapshot.c:1318: warning: Function parameter or member 'zone' not described in 'saveable_page'
   kernel/power/snapshot.c:1318: warning: Function parameter or member 'pfn' not described in 'saveable_page'
   kernel/power/snapshot.c:1389: warning: Function parameter or member 'dst' not described in 'safe_copy_page'
   kernel/power/snapshot.c:1389: warning: Function parameter or member 's_page' not described in 'safe_copy_page'
   kernel/power/snapshot.c:1602: warning: Function parameter or member 'x' not described in '__fraction'
   kernel/power/snapshot.c:1602: warning: Function parameter or member 'multiplier' not described in '__fraction'
   kernel/power/snapshot.c:1602: warning: Function parameter or member 'base' not described in '__fraction'
   kernel/power/snapshot.c:1893: warning: Function parameter or member 'nr_highmem' not described in 'count_pages_for_highmem'
   kernel/power/snapshot.c:1911: warning: Function parameter or member 'nr_pages' not described in 'enough_free_mem'
   kernel/power/snapshot.c:1911: warning: Function parameter or member 'nr_highmem' not described in 'enough_free_mem'
   kernel/power/snapshot.c:1934: warning: Function parameter or member 'safe_needed' not described in 'get_highmem_buffer'
   kernel/power/snapshot.c:1947: warning: Function parameter or member 'bm' not described in 'alloc_highmem_pages'
   kernel/power/snapshot.c:1947: warning: Function parameter or member 'nr_highmem' not described in 'alloc_highmem_pages'
   kernel/power/snapshot.c:1947: warning: expecting prototype for alloc_highmem_image_pages(). Prototype was for alloc_highmem_pages() instead
   kernel/power/snapshot.c:1982: warning: Function parameter or member 'copy_bm' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:1982: warning: Function parameter or member 'nr_pages' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:1982: warning: Function parameter or member 'nr_highmem' not described in 'swsusp_alloc'
   kernel/power/snapshot.c:2195: warning: Function parameter or member 'bm' not described in 'mark_unsafe_pages'
   kernel/power/snapshot.c:2230: warning: Function parameter or member 'info' not described in 'load_header'
   kernel/power/snapshot.c:2230: warning: expecting prototype for load header(). Prototype was for load_header() instead
   kernel/power/snapshot.c:2384: warning: Function parameter or member 'page' not described in 'get_highmem_page_buffer'
   kernel/power/snapshot.c:2384: warning: Function parameter or member 'ca' not described in 'get_highmem_page_buffer'
   kernel/power/snapshot.c:2569: warning: Function parameter or member 'bm' not described in 'get_buffer'
   kernel/power/snapshot.c:2569: warning: Function parameter or member 'ca' not described in 'get_buffer'
   kernel/power/snapshot.c:2693: warning: Function parameter or member 'handle' not described in 'snapshot_write_finalize'


vim +982 kernel/power/snapshot.c

307c5971c972ef Rafael J. Wysocki  2016-06-29   974  
74dfd666de861c Rafael J. Wysocki  2007-05-06   975  /**
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   976   * register_nosave_region - Register a region of unsaveable memory.
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   977   *
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   978   * Register a range of page frames the contents of which should not be saved
ef96f639ea6634 Rafael J. Wysocki  2016-07-06   979   * during hibernation (to be used in the early initialization code).
74dfd666de861c Rafael J. Wysocki  2007-05-06   980   */
33569ef3c754a8 Amadeusz Sławiński 2022-01-19   981  void __init register_nosave_region(unsigned long start_pfn, unsigned long end_pfn)
74dfd666de861c Rafael J. Wysocki  2007-05-06  @982  {
74dfd666de861c Rafael J. Wysocki  2007-05-06   983  	struct nosave_region *region;
74dfd666de861c Rafael J. Wysocki  2007-05-06   984  
74dfd666de861c Rafael J. Wysocki  2007-05-06   985  	if (start_pfn >= end_pfn)
74dfd666de861c Rafael J. Wysocki  2007-05-06   986  		return;
74dfd666de861c Rafael J. Wysocki  2007-05-06   987  
74dfd666de861c Rafael J. Wysocki  2007-05-06   988  	if (!list_empty(&nosave_regions)) {
74dfd666de861c Rafael J. Wysocki  2007-05-06   989  		/* Try to extend the previous region (they should be sorted) */
74dfd666de861c Rafael J. Wysocki  2007-05-06   990  		region = list_entry(nosave_regions.prev,
74dfd666de861c Rafael J. Wysocki  2007-05-06   991  					struct nosave_region, list);
74dfd666de861c Rafael J. Wysocki  2007-05-06   992  		if (region->end_pfn == start_pfn) {
74dfd666de861c Rafael J. Wysocki  2007-05-06   993  			region->end_pfn = end_pfn;
74dfd666de861c Rafael J. Wysocki  2007-05-06   994  			goto Report;
74dfd666de861c Rafael J. Wysocki  2007-05-06   995  		}
74dfd666de861c Rafael J. Wysocki  2007-05-06   996  	}
74dfd666de861c Rafael J. Wysocki  2007-05-06   997  	/* This allocation cannot fail */
7e1c4e27928e5f Mike Rapoport      2018-10-30   998  	region = memblock_alloc(sizeof(struct nosave_region),
7e1c4e27928e5f Mike Rapoport      2018-10-30   999  				SMP_CACHE_BYTES);
8a7f97b902f4fb Mike Rapoport      2019-03-11  1000  	if (!region)
8a7f97b902f4fb Mike Rapoport      2019-03-11  1001  		panic("%s: Failed to allocate %zu bytes\n", __func__,
8a7f97b902f4fb Mike Rapoport      2019-03-11  1002  		      sizeof(struct nosave_region));
74dfd666de861c Rafael J. Wysocki  2007-05-06  1003  	region->start_pfn = start_pfn;
74dfd666de861c Rafael J. Wysocki  2007-05-06  1004  	region->end_pfn = end_pfn;
74dfd666de861c Rafael J. Wysocki  2007-05-06  1005  	list_add_tail(&region->list, &nosave_regions);
74dfd666de861c Rafael J. Wysocki  2007-05-06  1006   Report:
64ec72a1ece37d Joe Perches        2017-09-27  1007  	pr_info("Registered nosave memory: [mem %#010llx-%#010llx]\n",
cd38ca854de15b Bjorn Helgaas      2013-06-03  1008  		(unsigned long long) start_pfn << PAGE_SHIFT,
cd38ca854de15b Bjorn Helgaas      2013-06-03  1009  		((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
74dfd666de861c Rafael J. Wysocki  2007-05-06  1010  }
74dfd666de861c Rafael J. Wysocki  2007-05-06  1011  

:::::: The code at line 982 was first introduced by commit
:::::: 74dfd666de861c97d47bdbd892f6d21b801d0247 swsusp: do not use page flags

:::::: TO: Rafael J. Wysocki <rjw@sisk.pl>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

