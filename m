Return-Path: <linux-kernel+bounces-273522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FEF946A3C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 17:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0734281727
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43274153837;
	Sat,  3 Aug 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrKvFwys"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E615381A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697521; cv=none; b=Q73EVmG004o0+qdxKTQmOZ2ylmAoYSLIHpNQr4l8ewm9SwmB2+lVdjTQfc1dzzZKE/dRV/XScFIVErVH1qW+ImsYPkg73cdE3eppx4Nj4BCabDR/73wU/cKphZWronSE7c2sZINX8W8Hk3QQ6KQ7vxcutYCFHtybhbrP660Rw0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697521; c=relaxed/simple;
	bh=B2G9VUjynzGwhswRGHy8keJMaMBW9U5ltbKe7u7WpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GTbi5SD2JlHLvw2ksW+Gikdjq+4qH41zlTze1MH9zkvIplU9E7kJWvcKmbyt7xMPxDSsRNFsE2iqVobDtV/yRh/pcXC9LqlJ4M8UyTLcpgoaJCrrGaIkOOc+N+EZq7QbRCSRnYldWtZWz6nwT2CrCT0cVoj2zs35EQGv5vyTBTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrKvFwys; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722697519; x=1754233519;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B2G9VUjynzGwhswRGHy8keJMaMBW9U5ltbKe7u7WpmQ=;
  b=jrKvFwysZo15yN6ehLhxTig5spzb/EeGkBTQfBc+H/nkEoRqqyhCE1Ac
   o2fkxOOjihU5YlWm4hbDRklS+HXisOMTguxOF1PznOiX9srIeluaj8DhJ
   59dNRI0eYz1jlYJjxv9T8PpyKpzqj+nml+S/bb2a+Z8Vw1X8RnOPHmhU7
   f6udGPJjzr3SuxCxAKt6Li9MaqEaUuYgpqaxX/t8D019ESHknaMe6TETH
   tajPAuY0klv3+/GlE9PFL5ETAWfjs26HNf0UoRGF+sbBSWTVtQmwUsYS3
   0fOGnt89bqQhtnM7UQrBvrdwSj6XX27f3YTyV2Dsd1DxGHnxibrQIPoHA
   g==;
X-CSE-ConnectionGUID: 1udzwov/TSWU+RL935mfEg==
X-CSE-MsgGUID: 34Y+JUSzT+GIdECHLDh1lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11153"; a="20377697"
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="20377697"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2024 08:05:18 -0700
X-CSE-ConnectionGUID: 0rgdGemzRGW92wbwmTCY7A==
X-CSE-MsgGUID: +euASzISQI6xdTgeO6OWiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,260,1716274800"; 
   d="scan'208";a="55935424"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2024 08:05:17 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saGJg-0000b4-0D;
	Sat, 03 Aug 2024 15:05:09 +0000
Date: Sat, 3 Aug 2024 23:04:32 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: include/linux/slab.h:663:78: error: subscripted value is neither
 array nor pointer nor vector
Message-ID: <202408032258.ShUXX4qU-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   17712b7ea0756799635ba159cc773082230ed028
commit: 72e0fe2241ce113cbba339ca8c2450b167774530 mm/slab: Introduce kmem_buckets typedef
date:   4 weeks ago
config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/20240803/202408032258.ShUXX4qU-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240803/202408032258.ShUXX4qU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408032258.ShUXX4qU-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   arch/m68k/include/asm/thread_info.h:23:26: note: in expansion of macro 'PAGE_SIZE'
      23 | #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                          ^~~~~~~~~
   include/linux/sched.h:1851:29: note: in expansion of macro 'THREAD_SIZE'
    1851 |         unsigned long stack[THREAD_SIZE/sizeof(long)];
         |                             ^~~~~~~~~~~
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   include/linux/mm_types.h:531:6: note: in expansion of macro 'PAGE_SIZE'
     531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |      ^~~~~~~~~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/linux/bits.h:5,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13:
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
      12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
         |                            ^~~~~~~~~
   include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:32:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
      12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
         |                            ^~~~~~~~~
   include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6:
   arch/m68k/include/asm/page.h:10:25: error: expression in static assertion is not an integer
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/slab.h:527:1: note: in expansion of macro 'static_assert'
     527 | static_assert(PAGE_SHIFT <= 20);
         | ^~~~~~~~~~~~~
   include/linux/slab.h:527:15: note: in expansion of macro 'PAGE_SHIFT'
     527 | static_assert(PAGE_SHIFT <= 20);
         |               ^~~~~~~~~~
   In file included from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/m68k/kernel/asm-offsets.c:16:
   include/linux/slab.h:593:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     593 |                                 __assume_page_alignment __alloc_size(1);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:596:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     596 |                                 __assume_page_alignment __alloc_size(1);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h: In function 'kmalloc_noprof':
>> include/linux/slab.h:663:78: error: subscripted value is neither array nor pointer nor vector
     663 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                                                              ^
   include/linux/slab.h:656:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     656 |                 unsigned int index;
         |                              ^~~~~
   include/linux/slab.h: In function 'kmalloc_node_noprof':
   include/linux/slab.h:680:78: error: subscripted value is neither array nor pointer nor vector
     680 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                                                              ^
   include/linux/slab.h:673:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     673 |                 unsigned int index;
         |                              ^~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +663 include/linux/slab.h

f1b6eb6e6be149 Christoph Lameter     2013-09-04  572  
a0a44d9175b349 Vlastimil Babka       2024-05-27  573  /*
a0a44d9175b349 Vlastimil Babka       2024-05-27  574   * The following functions are not to be used directly and are intended only
a0a44d9175b349 Vlastimil Babka       2024-05-27  575   * for internal use from kmalloc() and kmalloc_node()
a0a44d9175b349 Vlastimil Babka       2024-05-27  576   * with the exception of kunit tests
a0a44d9175b349 Vlastimil Babka       2024-05-27  577   */
a0a44d9175b349 Vlastimil Babka       2024-05-27  578  
a0a44d9175b349 Vlastimil Babka       2024-05-27  579  void *__kmalloc_noprof(size_t size, gfp_t flags)
a0a44d9175b349 Vlastimil Babka       2024-05-27  580  				__assume_kmalloc_alignment __alloc_size(1);
f1b6eb6e6be149 Christoph Lameter     2013-09-04  581  
a0a44d9175b349 Vlastimil Babka       2024-05-27  582  void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
a0a44d9175b349 Vlastimil Babka       2024-05-27  583  				__assume_kmalloc_alignment __alloc_size(1);
a0a44d9175b349 Vlastimil Babka       2024-05-27  584  
a0a44d9175b349 Vlastimil Babka       2024-05-27  585  void *__kmalloc_cache_noprof(struct kmem_cache *s, gfp_t flags, size_t size)
a0a44d9175b349 Vlastimil Babka       2024-05-27  586  				__assume_kmalloc_alignment __alloc_size(3);
7bd230a26648ac Suren Baghdasaryan    2024-03-21  587  
a0a44d9175b349 Vlastimil Babka       2024-05-27  588  void *__kmalloc_cache_node_noprof(struct kmem_cache *s, gfp_t gfpflags,
a0a44d9175b349 Vlastimil Babka       2024-05-27  589  				  int node, size_t size)
a0a44d9175b349 Vlastimil Babka       2024-05-27  590  				__assume_kmalloc_alignment __alloc_size(4);
7bd230a26648ac Suren Baghdasaryan    2024-03-21  591  
a0a44d9175b349 Vlastimil Babka       2024-05-27  592  void *__kmalloc_large_noprof(size_t size, gfp_t flags)
a0a44d9175b349 Vlastimil Babka       2024-05-27 @593  				__assume_page_alignment __alloc_size(1);
a0c3b940023eef Hyeonggon Yoo         2022-08-17  594  
a0a44d9175b349 Vlastimil Babka       2024-05-27  595  void *__kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
a0a44d9175b349 Vlastimil Babka       2024-05-27  596  				__assume_page_alignment __alloc_size(1);
a0c3b940023eef Hyeonggon Yoo         2022-08-17  597  
f1b6eb6e6be149 Christoph Lameter     2013-09-04  598  /**
838de63b101147 Vlastimil Babka       2022-11-10  599   * kmalloc - allocate kernel memory
f1b6eb6e6be149 Christoph Lameter     2013-09-04  600   * @size: how many bytes of memory are required.
838de63b101147 Vlastimil Babka       2022-11-10  601   * @flags: describe the allocation context
f1b6eb6e6be149 Christoph Lameter     2013-09-04  602   *
f1b6eb6e6be149 Christoph Lameter     2013-09-04  603   * kmalloc is the normal method of allocating memory
f1b6eb6e6be149 Christoph Lameter     2013-09-04  604   * for objects smaller than page size in the kernel.
7e3528c3660a2e Randy Dunlap          2013-11-22  605   *
59bb47985c1db2 Vlastimil Babka       2019-10-06  606   * The allocated object address is aligned to at least ARCH_KMALLOC_MINALIGN
59bb47985c1db2 Vlastimil Babka       2019-10-06  607   * bytes. For @size of power of two bytes, the alignment is also guaranteed
ad59baa3169591 Vlastimil Babka       2024-07-03  608   * to be at least to the size. For other sizes, the alignment is guaranteed to
ad59baa3169591 Vlastimil Babka       2024-07-03  609   * be at least the largest power-of-two divisor of @size.
59bb47985c1db2 Vlastimil Babka       2019-10-06  610   *
01598ba6b1a863 Mike Rapoport         2018-11-11  611   * The @flags argument may be one of the GFP flags defined at
e9d198f2be851f Thorsten Scherer      2023-03-12  612   * include/linux/gfp_types.h and described at
01598ba6b1a863 Mike Rapoport         2018-11-11  613   * :ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>`
7e3528c3660a2e Randy Dunlap          2013-11-22  614   *
01598ba6b1a863 Mike Rapoport         2018-11-11  615   * The recommended usage of the @flags is described at
2370ae4b1d5aa7 Mauro Carvalho Chehab 2020-04-10  616   * :ref:`Documentation/core-api/memory-allocation.rst <memory_allocation>`
7e3528c3660a2e Randy Dunlap          2013-11-22  617   *
01598ba6b1a863 Mike Rapoport         2018-11-11  618   * Below is a brief outline of the most useful GFP flags
7e3528c3660a2e Randy Dunlap          2013-11-22  619   *
01598ba6b1a863 Mike Rapoport         2018-11-11  620   * %GFP_KERNEL
01598ba6b1a863 Mike Rapoport         2018-11-11  621   *	Allocate normal kernel ram. May sleep.
7e3528c3660a2e Randy Dunlap          2013-11-22  622   *
01598ba6b1a863 Mike Rapoport         2018-11-11  623   * %GFP_NOWAIT
01598ba6b1a863 Mike Rapoport         2018-11-11  624   *	Allocation will not sleep.
7e3528c3660a2e Randy Dunlap          2013-11-22  625   *
01598ba6b1a863 Mike Rapoport         2018-11-11  626   * %GFP_ATOMIC
01598ba6b1a863 Mike Rapoport         2018-11-11  627   *	Allocation will not sleep.  May use emergency pools.
7e3528c3660a2e Randy Dunlap          2013-11-22  628   *
7e3528c3660a2e Randy Dunlap          2013-11-22  629   * Also it is possible to set different flags by OR'ing
7e3528c3660a2e Randy Dunlap          2013-11-22  630   * in one or more of the following additional @flags:
7e3528c3660a2e Randy Dunlap          2013-11-22  631   *
838de63b101147 Vlastimil Babka       2022-11-10  632   * %__GFP_ZERO
838de63b101147 Vlastimil Babka       2022-11-10  633   *	Zero the allocated memory before returning. Also see kzalloc().
838de63b101147 Vlastimil Babka       2022-11-10  634   *
01598ba6b1a863 Mike Rapoport         2018-11-11  635   * %__GFP_HIGH
01598ba6b1a863 Mike Rapoport         2018-11-11  636   *	This allocation has high priority and may use emergency pools.
7e3528c3660a2e Randy Dunlap          2013-11-22  637   *
01598ba6b1a863 Mike Rapoport         2018-11-11  638   * %__GFP_NOFAIL
01598ba6b1a863 Mike Rapoport         2018-11-11  639   *	Indicate that this allocation is in no way allowed to fail
7e3528c3660a2e Randy Dunlap          2013-11-22  640   *	(think twice before using).
7e3528c3660a2e Randy Dunlap          2013-11-22  641   *
01598ba6b1a863 Mike Rapoport         2018-11-11  642   * %__GFP_NORETRY
01598ba6b1a863 Mike Rapoport         2018-11-11  643   *	If memory is not immediately available,
7e3528c3660a2e Randy Dunlap          2013-11-22  644   *	then give up at once.
7e3528c3660a2e Randy Dunlap          2013-11-22  645   *
01598ba6b1a863 Mike Rapoport         2018-11-11  646   * %__GFP_NOWARN
01598ba6b1a863 Mike Rapoport         2018-11-11  647   *	If allocation fails, don't issue any warnings.
7e3528c3660a2e Randy Dunlap          2013-11-22  648   *
01598ba6b1a863 Mike Rapoport         2018-11-11  649   * %__GFP_RETRY_MAYFAIL
01598ba6b1a863 Mike Rapoport         2018-11-11  650   *	Try really hard to succeed the allocation but fail
dcda9b04713c3f Michal Hocko          2017-07-12  651   *	eventually.
f1b6eb6e6be149 Christoph Lameter     2013-09-04  652   */
7bd230a26648ac Suren Baghdasaryan    2024-03-21  653  static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t flags)
f1b6eb6e6be149 Christoph Lameter     2013-09-04  654  {
6fa57d78aa7f21 Kees Cook             2022-11-17  655  	if (__builtin_constant_p(size) && size) {
cc252eae85e095 Vlastimil Babka       2018-10-26  656  		unsigned int index;
3bf019334fbbb5 Kees Cook             2022-11-17  657  
f1b6eb6e6be149 Christoph Lameter     2013-09-04  658  		if (size > KMALLOC_MAX_CACHE_SIZE)
a0a44d9175b349 Vlastimil Babka       2024-05-27  659  			return __kmalloc_large_noprof(size, flags);
f1b6eb6e6be149 Christoph Lameter     2013-09-04  660  
cc252eae85e095 Vlastimil Babka       2018-10-26  661  		index = kmalloc_index(size);
a0a44d9175b349 Vlastimil Babka       2024-05-27  662  		return __kmalloc_cache_noprof(
3c615294058429 GONG, Ruiqi           2023-07-14 @663  				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
f1b6eb6e6be149 Christoph Lameter     2013-09-04  664  				flags, size);
f1b6eb6e6be149 Christoph Lameter     2013-09-04  665  	}
7bd230a26648ac Suren Baghdasaryan    2024-03-21  666  	return __kmalloc_noprof(size, flags);
f1b6eb6e6be149 Christoph Lameter     2013-09-04  667  }
7bd230a26648ac Suren Baghdasaryan    2024-03-21  668  #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
ce6a50263d4dde Christoph Lameter     2013-01-10  669  

:::::: The code at line 663 was first introduced by commit
:::::: 3c6152940584290668b35fa0800026f6a1ae05fe Randomized slab caches for kmalloc()

:::::: TO: GONG, Ruiqi <gongruiqi@huaweicloud.com>
:::::: CC: Vlastimil Babka <vbabka@suse.cz>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

