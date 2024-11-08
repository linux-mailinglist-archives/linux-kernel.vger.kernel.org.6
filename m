Return-Path: <linux-kernel+bounces-402372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F49C26D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD761F22FBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9A1DB346;
	Fri,  8 Nov 2024 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAPomj4c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52295233D85
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099086; cv=none; b=i07YW16Sxb9g8z9sbO7GQHaZNNuncoW7Lnf7dZNhpbcCEX9vwcqoLahCsX2HEh62nztb0jQtyhkQwviIADV64XNcfWOgbDGVMSmdKS+NG1G7lGEup/kYESqXQsi/Iydj00//uBhkG49PEtjMdQjs1+OA9Cb1RFgHjku1Ac2s+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099086; c=relaxed/simple;
	bh=dOVIx5TcyX42BPBZj2a+etO5eUjZ45VMOao/Q70JuWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nib8sYb9x/Smzogk4kujA+xgL1wnsiwIz4TcJJHrjV6JMeKWXAMUUijsXAm3F8Vx5KXDBlqcGxHRBTq6Y9ZQA+3GH8zex8uyU++K9a6ORydlw90w/lCr9trDk+s3mAFjNB03RiFE7lyIWd6Lwx6C/yzhpZ4/nNlon51C24zHnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAPomj4c; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731099083; x=1762635083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dOVIx5TcyX42BPBZj2a+etO5eUjZ45VMOao/Q70JuWw=;
  b=eAPomj4cPs15qd6c8of0EE9OGEoYUx5aeUp0iWqEAbWR5omnbCARS5JY
   gXMYEx9RSQU7KFuLb+3UNaPKY325MdWtPbuDPSOPUmV6yKm+NWyjMDUN5
   uUuoJ9SJB63QmnzMp1hQePyAigzuW8UyY4qjTaTkthf7yvc6LY7/HHJUf
   RRqz5GN9W6CYOdPClpyQkFlKsm0FmCuEOva0gaUhnCNOge8Bi7Sl44SSq
   06G1VclQ818ZJS770nf+ySMr8XOPuZME42ByFBiZgmsDpEdayLPhezxrQ
   c5r4AMl7XsIrBlr5y5tDtZUu9UC4fMR2QJo6lWWNiRPosCVqyKQrPXUWC
   w==;
X-CSE-ConnectionGUID: 6HMpIHuATquXKkQ1J/gM5w==
X-CSE-MsgGUID: OtodeibrQUCRUu5Ja5+59Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="31097597"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="31097597"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 12:51:22 -0800
X-CSE-ConnectionGUID: jpUrmjM4QDmg7pGLtvzH+Q==
X-CSE-MsgGUID: FMqk57uaRay2ZoFslIfbCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="85636572"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 08 Nov 2024 12:51:18 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9Vwq-000rnO-14;
	Fri, 08 Nov 2024 20:51:16 +0000
Date: Sat, 9 Nov 2024 04:50:27 +0800
From: kernel test robot <lkp@intel.com>
To: Adrian Huang <adrianhuang0701@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Jiwei Sun <sunjw10@lenovo.com>
Subject: Re: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten
 vma->numab_state
Message-ID: <202411090453.EFAEFpnv-lkp@intel.com>
References: <20241108133139.25326-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108133139.25326-1-ahuang12@lenovo.com>

Hi Adrian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on tip/master tip/sched/core peterz-queue/sched/core linus/master v6.12-rc6 next-20241108]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Adrian-Huang/sched-numa-Fix-memory-leak-due-to-the-overwritten-vma-numab_state/20241108-213420
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241108133139.25326-1-ahuang12%40lenovo.com
patch subject: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten vma->numab_state
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241109/202411090453.EFAEFpnv-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241109/202411090453.EFAEFpnv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411090453.EFAEFpnv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/damon/vaddr.c:736:
   mm/damon/tests/vaddr-kunit.h: In function 'damon_test_three_regions_in_vmas':
>> mm/damon/tests/vaddr-kunit.h:92:1: warning: the frame size of 2168 bytes is larger than 2048 bytes [-Wframe-larger-than=]
      92 | }
         | ^


vim +92 mm/damon/tests/vaddr-kunit.h

17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  38  
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  39  /*
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  40   * Test __damon_va_three_regions() function
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  41   *
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  42   * In case of virtual memory address spaces monitoring, DAMON converts the
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  43   * complex and dynamic memory mappings of each target task to three
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  44   * discontiguous regions which cover every mapped areas.  However, the three
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  45   * regions should not include the two biggest unmapped areas in the original
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  46   * mapping, because the two biggest areas are normally the areas between 1)
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  47   * heap and the mmap()-ed regions, and 2) the mmap()-ed regions and stack.
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  48   * Because these two unmapped areas are very huge but obviously never accessed,
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  49   * covering the region is just a waste.
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  50   *
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  51   * '__damon_va_three_regions() receives an address space of a process.  It
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  52   * first identifies the start of mappings, end of mappings, and the two biggest
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  53   * unmapped areas.  After that, based on the information, it constructs the
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  54   * three regions and returns.  For more detail, refer to the comment of
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  55   * 'damon_init_regions_of()' function definition in 'mm/damon.c' file.
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  56   *
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  57   * For example, suppose virtual address ranges of 10-20, 20-25, 200-210,
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  58   * 210-220, 300-305, and 307-330 (Other comments represent this mappings in
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  59   * more short form: 10-20-25, 200-210-220, 300-305, 307-330) of a process are
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  60   * mapped.  To cover every mappings, the three regions should start with 10,
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  61   * and end with 305.  The process also has three unmapped areas, 25-200,
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  62   * 220-300, and 305-307.  Among those, 25-200 and 220-300 are the biggest two
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  63   * unmapped areas, and thus it should be converted to three regions of 10-25,
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  64   * 200-220, and 300-330.
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  65   */
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  66  static void damon_test_three_regions_in_vmas(struct kunit *test)
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  67  {
d0cf3dd47f0d5d mm/damon/vaddr-test.h        Liam R. Howlett 2022-09-06  68  	static struct mm_struct mm;
ba7196e566516f mm/damon/tests/vaddr-kunit.h Leo Stone       2024-09-22  69  	struct damon_addr_range regions[3] = {0};
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  70  	/* 10-20-25, 200-210-220, 300-305, 307-330 */
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  71  	struct vm_area_struct vmas[] = {
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  72  		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  73  		(struct vm_area_struct) {.vm_start = 20, .vm_end = 25},
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  74  		(struct vm_area_struct) {.vm_start = 200, .vm_end = 210},
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  75  		(struct vm_area_struct) {.vm_start = 210, .vm_end = 220},
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  76  		(struct vm_area_struct) {.vm_start = 300, .vm_end = 305},
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  77  		(struct vm_area_struct) {.vm_start = 307, .vm_end = 330},
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  78  	};
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  79  
f0679f9e6d88ae mm/damon/tests/vaddr-kunit.h SeongJae Park   2024-09-04  80  	mt_init_flags(&mm.mm_mt, MT_FLAGS_ALLOC_RANGE | MT_FLAGS_USE_RCU);
34403fa579514a mm/damon/vaddr-test.h        Liam R. Howlett 2023-01-20  81  	if (__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas)))
34403fa579514a mm/damon/vaddr-test.h        Liam R. Howlett 2023-01-20  82  		kunit_skip(test, "Failed to create VMA tree");
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  83  
d0cf3dd47f0d5d mm/damon/vaddr-test.h        Liam R. Howlett 2022-09-06  84  	__damon_va_three_regions(&mm, regions);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  85  
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  86  	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  87  	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  88  	KUNIT_EXPECT_EQ(test, 200ul, regions[1].start);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  89  	KUNIT_EXPECT_EQ(test, 220ul, regions[1].end);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  90  	KUNIT_EXPECT_EQ(test, 300ul, regions[2].start);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  91  	KUNIT_EXPECT_EQ(test, 330ul, regions[2].end);
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07 @92  }
17ccae8bb5c928 mm/damon/vaddr-test.h        SeongJae Park   2021-09-07  93  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

