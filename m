Return-Path: <linux-kernel+bounces-362818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BBF99B995
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96C71F212AB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2399D1428F3;
	Sun, 13 Oct 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZADXuKEM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A1143871
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728825713; cv=none; b=uayzeHMDn0fZZLv7i95zWnePCeSyiqABZRjB0ZZYa6/280EPACQKk/CtfhU36mCTuL/k0f2Afza97P8EV430awId8qV0SlM5/XQs85307XTwVgtBY2AVhevQDTaJPxkLpC4FEfbkURfMd4sfmGrOeAYCfiAi3ieprod3M+8TSkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728825713; c=relaxed/simple;
	bh=jTz1iT4zLqxudjS4kGT3fsf55UjmbdZ8EOFjPY68l4c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QG5pqd5wN2so/FFc8emaxWUeVWpkG4KiIRbx4j8M4rliA1HEhRjafgX2ep8qik0cExQ/VaBjs9VfVicm8bpUKo/MNQ7vWs+x566CZQ8FrRrhl4bd2mK6zw0sZhj1qsRYgU6/qvp5zXXshktPEC7pxIu5VdxiyTxkJ0kChKA0euQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZADXuKEM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728825711; x=1760361711;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jTz1iT4zLqxudjS4kGT3fsf55UjmbdZ8EOFjPY68l4c=;
  b=ZADXuKEMZOJHa7CnhclIJ2BojSPI6TTjB1Ddf/7bXtZFfYB5f+wqrMqY
   jqqwfp38dA9yDfl5s5JImKKcltdDALuzdqbuk5UUf7CAtL8W15h/QhmxS
   Ki1jr0jypUjKBIWx3osca2CE/WCmVgFn4vGx+Hpysuf4Rpjsow6RbpE6i
   wIyNy/yiJ/HCNC1aKD+aLRrsQxi9NrxFjbOWSohtkFIfJXTjL84/RLhgm
   BwKvfomWWlOw6hINvmRX5CEZGNByiP3lWJ4GrIGxd5XGYViKidK4NrngW
   DJ4FQdrmqonxNGbR/UcaAbSUooMKVqgD829atb6i6sgvG9jCseGl2vPYU
   g==;
X-CSE-ConnectionGUID: Wb8Faf6GSAyWMV2SvKwL6A==
X-CSE-MsgGUID: Au4lhbtoRXubChLZlVcN3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="32087972"
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="32087972"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 06:21:50 -0700
X-CSE-ConnectionGUID: vcyIO/ATTC2YBC8/ZR5K6A==
X-CSE-MsgGUID: nDMz+8tDReaY6/f7NvJbJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="77196108"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Oct 2024 06:21:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szyXa-000EOD-1B;
	Sun, 13 Oct 2024 13:21:46 +0000
Date: Sun, 13 Oct 2024 21:21:37 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT'
 undeclared; did you mean 'CONFIG_LOG_BUF_SHIFT'?
Message-ID: <202410132124.tvD4WAOX-lkp@intel.com>
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
head:   36c254515dc6592c44db77b84908358979dd6b50
commit: 5394f1e9b687bcf26595cabf83483e568676128d arch: define CONFIG_PAGE_SIZE_*KB on all architectures
date:   7 months ago
config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/20241013/202410132124.tvD4WAOX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241013/202410132124.tvD4WAOX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410132124.tvD4WAOX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/processor.h:11,
                    from include/linux/sched.h:13,
                    from arch/m68k/kernel/asm-offsets.c:15:
   arch/m68k/include/asm/page_mm.h: In function 'virt_to_pfn':
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   arch/m68k/include/asm/page.h:10:25: note: each undeclared identifier is reported only once for each function it appears in
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   arch/m68k/include/asm/page_mm.h: In function 'pfn_to_virt':
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:130:28: note: in expansion of macro 'PAGE_SHIFT'
     130 |         return __va(pfn << PAGE_SHIFT);
         |                            ^~~~~~~~~~
   include/asm-generic/getorder.h: In function 'get_order':
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/m68k/include/asm/thread_info.h: At top level:
   arch/m68k/include/asm/page.h:10:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
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
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page.h:11:40: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE       (_AC(1, UL) << PAGE_SHIFT)
         |                                        ^~~~~~~~~~
   include/linux/vmalloc.h:109:16: note: in expansion of macro 'PAGE_SIZE'
     109 |         return PAGE_SIZE;
         |                ^~~~~~~~~
   include/linux/vmalloc.h: In function 'arch_vmap_pte_supported_shift':
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/vmalloc.h:116:16: note: in expansion of macro 'PAGE_SHIFT'
     116 |         return PAGE_SHIFT;
         |                ^~~~~~~~~~
   include/linux/vmalloc.h: In function 'get_vm_area_size':
>> arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
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
>> arch/m68k/include/asm/page.h:10:25: error: expression in static assertion is not an integer
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

