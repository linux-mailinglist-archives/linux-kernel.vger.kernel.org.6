Return-Path: <linux-kernel+bounces-385997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FEB9B3DE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF242B21567
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8AC1E501B;
	Mon, 28 Oct 2024 22:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7PZ2jzN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC07718E05D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155173; cv=none; b=gggh67WKqu9ePJe4jA+8S18OUAHMPJeVSFyRfDYtTVKWmHFMsca6iRcn40YxD2FWI84JZawiH78J2bu7OOOWRLjrg9h8vKZL1i/kRR9VNFXoyUGzVXcJahqXJatyeq89UdxZmy3Zc1VTRdWMSAtCcp6MxCIW9EL9sssd2/GjnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155173; c=relaxed/simple;
	bh=LVBsgicUnLTGSKX73yijwTXtX+6VUw55XXNYHHQk4y0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N4NWyi2jQCudIFFG4qxXEvgB8pT4pkEJ5olSVZURAmFRx1JDlhMvbS0XGs9LiZDmhxR4N/CZleX4FQwyq1xgFa1bXwwxmd+r5IieRVK8qhNnLKbUvSgWwrPXMO76n6/swao30cdk3VmJzwt3pTcsKFWK7H4Xlov9GqslPqHPWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7PZ2jzN; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730155170; x=1761691170;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LVBsgicUnLTGSKX73yijwTXtX+6VUw55XXNYHHQk4y0=;
  b=a7PZ2jzNZebFBTrPAzB2sQU7iJ/Cocx3HtaqXsUYaFf5CU1zejJsvtA8
   2Amr1RHV/7KhIEje8FUYLfJr8902qhmP+grHDEx1YAS8SMI1l4EPmvh3J
   VSuV8CE8REX/koUYc5izpWdFe9Pd7/JL5Jlu7cbo2KXix07xvIUgtQ4Ti
   vlk/b/e80XM+U+bRtWhHCo0p2KkTjzAq9PAnp+elflrrczQNMLSXUhXIa
   MZwd5xEXpS8uHqnX1DTlWQ4gzFSbarHa05KiJKOBDZObMcsJeQtaqq+Fv
   dro2AVXsALZlmP+e5JNqsIW9ypeMEHj7MhYq0JA+2hEMsJCFSoyPM8ohY
   w==;
X-CSE-ConnectionGUID: UhabH12WQ6uJBMy/NIvSLQ==
X-CSE-MsgGUID: osrdK3hyS7yASIHInmcO+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="29982088"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="29982088"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 15:39:29 -0700
X-CSE-ConnectionGUID: xPLhwp16T2qrHEuh7NXr6w==
X-CSE-MsgGUID: PsNZPOAxR9CCyM84CuKk2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="112570204"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Oct 2024 15:39:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5YOT-000cxo-0R;
	Mon, 28 Oct 2024 22:39:25 +0000
Date: Tue, 29 Oct 2024 06:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [tip:timers/vdso 11/13] include/vdso/page.h:15:39: error:
 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean
 'CONFIG_LOG_BUF_SHIFT'?
Message-ID: <202410290639.TBG289SO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
head:   d4a65302dd849fade9e2ca712826c35b8d068ecb
commit: efe8419ae78d65e83edc31aad74b605c12e7d60c [11/13] vdso: Introduce vdso/page.h
config: m68k-alldefconfig (https://download.01.org/0day-ci/archive/20241029/202410290639.TBG289SO-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410290639.TBG289SO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410290639.TBG289SO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/page.h:9,
                    from arch/m68k/include/asm/thread_info.h:6,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from arch/m68k/include/asm/processor.h:11,
                    from include/linux/sched.h:13,
                    from arch/m68k/kernel/asm-offsets.c:15:
   arch/m68k/include/asm/page_mm.h: In function 'virt_to_pfn':
   include/vdso/page.h:13:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   include/vdso/page.h:13:25: note: each undeclared identifier is reported only once for each function it appears in
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   arch/m68k/include/asm/page_mm.h: In function 'pfn_to_virt':
   include/vdso/page.h:13:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/page_mm.h:130:28: note: in expansion of macro 'PAGE_SHIFT'
     130 |         return __va(pfn << PAGE_SHIFT);
         |                            ^~~~~~~~~~
   include/asm-generic/getorder.h: In function 'get_order':
   include/vdso/page.h:13:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/m68k/include/asm/thread_info.h: At top level:
   include/vdso/page.h:13:25: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/thread_info.h:13:5: note: in expansion of macro 'PAGE_SHIFT'
      13 | #if PAGE_SHIFT < 13
         |     ^~~~~~~~~~
   arch/m68k/include/asm/thread_info.h: In function 'current_thread_info':
   include/vdso/page.h:15:39: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                       ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/thread_info.h:23:26: note: in expansion of macro 'PAGE_SIZE'
      23 | #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                          ^~~~~~~~~
   arch/m68k/include/asm/thread_info.h:51:27: note: in expansion of macro 'THREAD_SIZE'
      51 |                 : "di" (~(THREAD_SIZE-1))
         |                           ^~~~~~~~~~~
   include/linux/mm_types_task.h: At top level:
   include/vdso/page.h:15:39: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                       ^~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:37:30: note: in expansion of macro 'PAGE_SIZE'
      37 | #if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
         |                              ^~~~~~~~~
>> include/vdso/page.h:15:39: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                       ^~~~~~~~~~~~~~~~~
   arch/m68k/include/asm/thread_info.h:23:26: note: in expansion of macro 'PAGE_SIZE'
      23 | #define THREAD_SIZE     (PAGE_SIZE << THREAD_SIZE_ORDER)
         |                          ^~~~~~~~~
   include/linux/sched.h:1890:29: note: in expansion of macro 'THREAD_SIZE'
    1890 |         unsigned long stack[THREAD_SIZE/sizeof(long)];
         |                             ^~~~~~~~~~~
   include/vdso/page.h:15:39: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                       ^~~~~~~~~~~~~~~~~
   include/linux/mm_types.h:547:6: note: in expansion of macro 'PAGE_SIZE'
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
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
   include/vdso/page.h:15:39: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                       ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:49:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/mm_types.h:524:41: note: in expansion of macro '__ALIGN_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   include/vdso/page.h:27:28: note: in expansion of macro 'PAGE_SIZE'
      27 | #define PAGE_MASK       (~(PAGE_SIZE - 1))
         |                            ^~~~~~~~~
   include/linux/mm_types.h:524:62: note: in expansion of macro 'PAGE_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:547:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   include/vdso/page.h:15:39: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                                       ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:49:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      49 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/mm_types.h:524:41: note: in expansion of macro '__ALIGN_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   include/vdso/page.h:27:28: note: in expansion of macro 'PAGE_SIZE'
      27 | #define PAGE_MASK       (~(PAGE_SIZE - 1))
         |                            ^~~~~~~~~
   include/linux/mm_types.h:524:62: note: in expansion of macro 'PAGE_MASK'
     524 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:547:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     547 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6:
>> include/vdso/page.h:13:25: error: expression in static assertion is not an integer
      13 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
         |                         ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/slab.h:695:1: note: in expansion of macro 'static_assert'
     695 | static_assert(PAGE_SHIFT <= 20);
         | ^~~~~~~~~~~~~
   include/linux/slab.h:695:15: note: in expansion of macro 'PAGE_SHIFT'
     695 | static_assert(PAGE_SHIFT <= 20);
         |               ^~~~~~~~~~
   In file included from include/linux/irq.h:21,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:8,
                    from arch/m68k/kernel/asm-offsets.c:16:
   include/linux/slab.h:809:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     809 |                                 __assume_page_alignment __alloc_size(1);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:812:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     812 |                                 __assume_page_alignment __alloc_size(1);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h: In function 'kmalloc_noprof':
   include/linux/slab.h:879:78: error: subscripted value is neither array nor pointer nor vector
     879 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                                                              ^
   include/linux/slab.h:872:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     872 |                 unsigned int index;
         |                              ^~~~~
   include/linux/slab.h: In function 'kmalloc_node_noprof':
   include/linux/slab.h:902:78: error: subscripted value is neither array nor pointer nor vector
     902 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                                                              ^
   include/linux/slab.h:895:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     895 |                 unsigned int index;
         |                              ^~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +15 include/vdso/page.h

     6	
     7	/*
     8	 * PAGE_SHIFT determines the page size.
     9	 *
    10	 * Note: This definition is required because PAGE_SHIFT is used
    11	 * in several places throuout the codebase.
    12	 */
  > 13	#define PAGE_SHIFT      CONFIG_PAGE_SHIFT
    14	
  > 15	#define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

