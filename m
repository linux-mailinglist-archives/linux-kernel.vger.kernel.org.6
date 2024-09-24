Return-Path: <linux-kernel+bounces-336817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328EF98413C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8BB1281D9B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3C1547D8;
	Tue, 24 Sep 2024 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mU6gTTAT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF891547CD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727168233; cv=none; b=FxuXbclEjMTUxIfcVFf+K+64qiaKy/z0Ik0Gt/HrmKHqdRiHv9Lb3qCiHjpsaM64fI4is7EqKV4SOncpdipG3TZtXTFF5XQlC3HzLATl1MpTIBzpnJsGhPqI79/TMejvb+hTAHAEr4NNJ+Pgsu8dQpm95SePfcbKw0Sd/mT6lyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727168233; c=relaxed/simple;
	bh=Zoo4hXHwobsLpl/av9oaSghSk/UvsUMiDANLOb9NI1c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LbNoNoJs/wXcZ9A6YrkWTCbSErFgN+AmAcigNCnQGVuYDr/aen1RaX8XVRaDuHMsWUmDCTGd0g2MkEYXFccSGlOm8kjJBX2ki+NH1gQK3Wa3ql9zJy5ZADZ5AfqyVa7TF/SWDRWx4Alou4WyKMvHHbcQz38r4IzZm1MMandY2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mU6gTTAT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727168232; x=1758704232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Zoo4hXHwobsLpl/av9oaSghSk/UvsUMiDANLOb9NI1c=;
  b=mU6gTTATQgyXoDMso+o4KEF+ht3NX0iHh6qONjQiAhBGI3o72IfeG1fu
   +cRQTSs4o7+j5OT+0Id2F9c2EnM5wltLFd7T6uYFUT1vUxgCQ6C5FEGTq
   Antc28vsqiT2Q41nAtSvNrVwazoXvg3YUQA2Oi++NPwDHiZjdnskOm6hR
   Df7W13ixqc7oWhzr1e7xm3MKY2chOMkGbCLV3MbyBabOkTjIFnnl0UqkV
   hVJZ1O42AjUw11gUN21reg7UwWXCXOWytXFbhlwTK9ALGqTPa6UaLewoP
   aGQOab2mPg5WVUGjocFlF/Glk7mhPse1VeYp04qaJm+5BiUiEOdmOmOfo
   A==;
X-CSE-ConnectionGUID: S+CnN4CuRYaZeZiIEqlx7Q==
X-CSE-MsgGUID: F5x++WA6SfmeXk/6M4xuww==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="51566555"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="51566555"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 01:57:11 -0700
X-CSE-ConnectionGUID: 03OkPSR+Tt+gj2GAPWqy5Q==
X-CSE-MsgGUID: z4rYH2G2TzmSThdKUyFJPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="102093903"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 24 Sep 2024 01:57:10 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1st1M3-000I8o-0U;
	Tue, 24 Sep 2024 08:57:07 +0000
Date: Tue, 24 Sep 2024 16:57:00 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT'
 undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
Message-ID: <202409241653.3t6CAPNB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   abf2050f51fdca0fd146388f83cddd95a57a008d
commit: 5394f1e9b687bcf26595cabf83483e568676128d arch: define CONFIG_PAGE_SIZE_*KB on all architectures
date:   7 months ago
config: m68k-randconfig-r036-20220718 (https://download.01.org/0day-ci/archive/20240924/202409241653.3t6CAPNB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409241653.3t6CAPNB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409241653.3t6CAPNB-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/m68k/include/asm/thread_info.h:13:5: note: in expansion of macro 'PAGE_SHIFT'
      13 | #if PAGE_SHIFT < 13
         |     ^~~~~~~~~~
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   include/linux/mm_types_task.h:40:30: note: in expansion of macro 'PAGE_SIZE'
      40 | #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
         |                              ^~~~~~~~~
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   include/linux/mm_types.h:502:6: note: in expansion of macro 'PAGE_SIZE'
     502 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
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
   include/linux/mm_types.h:479:41: note: in expansion of macro '__ALIGN_MASK'
     479 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
      12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
         |                            ^~~~~~~~~
   include/linux/mm_types.h:479:62: note: in expansion of macro 'PAGE_MASK'
     479 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:502:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     502 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:32:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/mm_types.h:479:41: note: in expansion of macro '__ALIGN_MASK'
     479 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   arch/m68k/include/asm/page.h:12:28: note: in expansion of macro 'PAGE_SIZE'
      12 | #define PAGE_MASK       (~(PAGE_SIZE-1))
         |                            ^~~~~~~~~
   include/linux/mm_types.h:479:62: note: in expansion of macro 'PAGE_MASK'
     479 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:502:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     502 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmalloc.h: In function 'arch_vmap_pte_range_map_size':
   arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   include/linux/vmalloc.h:109:16: note: in expansion of macro 'PAGE_SIZE'
     109 |         return PAGE_SIZE;
         |                ^~~~~~~~~
   include/linux/vmalloc.h: In function 'arch_vmap_pte_supported_shift':
   arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/vmalloc.h:116:16: note: in expansion of macro 'PAGE_SHIFT'
     116 |         return PAGE_SHIFT;
         |                ^~~~~~~~~~
   include/linux/vmalloc.h: In function 'get_vm_area_size':
   arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   include/linux/vmalloc.h:200:37: note: in expansion of macro 'PAGE_SIZE'
     200 |                 return area->size - PAGE_SIZE;
         |                                     ^~~~~~~~~
   include/linux/slab.h: At top level:
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/slab.h:309:34: note: in expansion of macro 'PAGE_SHIFT'
     309 | #define KMALLOC_SHIFT_HIGH      (PAGE_SHIFT + 1)
         |                                  ^~~~~~~~~~
   include/linux/slab.h:379:34: note: in expansion of macro 'KMALLOC_SHIFT_HIGH'
     379 | kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
         |                                  ^~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6:
   arch/m68k/include/asm/page.h:10:25: error: expression in static assertion is not an integer
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/slab.h:475:1: note: in expansion of macro 'static_assert'
     475 | static_assert(PAGE_SHIFT <= 20);
         | ^~~~~~~~~~~~~
   include/linux/slab.h:475:15: note: in expansion of macro 'PAGE_SHIFT'
     475 | static_assert(PAGE_SHIFT <= 20);
         |               ^~~~~~~~~~
   In file included from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from arch/m68k/kernel/asm-offsets.c:16:
   include/linux/slab.h:522:47: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     522 |                                               __alloc_size(1);
         |                                               ^~~~~~~~~~~~
   include/linux/slab.h:525:62: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     525 |                                                              __alloc_size(1);
         |                                                              ^~~~~~~~~~~~
   include/linux/slab.h: In function 'kmalloc':
   include/linux/slab.h:584:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     584 |                 unsigned int index;
         |                              ^~~~~
   include/linux/slab.h: In function 'kmalloc_node':
   include/linux/slab.h:600:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     600 |                 unsigned int index;
         |                              ^~~~~
   make[3]: *** [scripts/Makefile.build:116: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1199: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +10 arch/m68k/include/asm/page.h

     8	
     9	/* PAGE_SHIFT determines the page size */
  > 10	#define PAGE_SHIFT	CONFIG_PAGE_SHIFT
    11	#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
    12	#define PAGE_MASK	(~(PAGE_SIZE-1))
    13	#define PAGE_OFFSET	(PAGE_OFFSET_RAW)
    14	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

