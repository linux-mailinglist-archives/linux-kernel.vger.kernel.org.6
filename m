Return-Path: <linux-kernel+bounces-346567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 541E598C5FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B15CFB20CC8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69551CDA02;
	Tue,  1 Oct 2024 19:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AZmIqY5H"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018D1CCB41
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810562; cv=none; b=mwmv7bz7YIjY84IDIykd4L6Alw+I/2gTrU3JHs+dlzB0VgX3MeW/6LWcH/hfClJkA4PlXL0hFN8RrV9EwQZs+iafSnXTL6iRN7Sp1WrJI+MQvktkAmLR2NitEGu7E1s4QXcGDSwZXALfoWBYECmTQhWLtrHSAp/GojIn+e9QQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810562; c=relaxed/simple;
	bh=DricLM2ygkSWo3hV30ycjqDMyZSIoAiZTCXn+0kvZrg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I8ekU11yLbpp/hlTTMhHUsyfGn6m6A0uOfIUQAjYHUR6OvJCp/qfEw0w2z5C3D28gvIo7MnpmktNmEI1mKQw2TYq/tPkgA/osa/4xPIVXwxb0eoM9S64swtNi5DVkBKlk8J41bJDVEUHSQBIlcK1ntp6hInEJa8QPhdvDlMs5RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AZmIqY5H; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727810560; x=1759346560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DricLM2ygkSWo3hV30ycjqDMyZSIoAiZTCXn+0kvZrg=;
  b=AZmIqY5HAM0101xtl6DgIO0TrxWYPYR0p0J6O/IjIbe9U0nBkqfEZGdA
   dZ5oz/uYQEopc/DiNx03955uzrerToQT1jA0juRITl7kq6Kjr6G5/PcgE
   izLLqVl2xzZeFR+6Jtg/IiyEKc9AnNbadxOzmc8awKqJ7a5Xk0D91qwck
   sFCM+I3i1CN8L/819eG7JrLw5Z1rLhf7II/moDP111Pi+merI3BYrmnlZ
   kMyK6H8/sll6iOiPCZS3fg4ae1rs3mXEsSH5ZBnuTk8oKcVi2ksz9EipZ
   AHx4B9iAv+mgDBw5G1hfVPqB6sjAmrYuPQiYgusMcsBkBjsxtblQpHj0y
   g==;
X-CSE-ConnectionGUID: +pmqSPlxRua9Ui/8LYSp4Q==
X-CSE-MsgGUID: sRfodMl1QkWwdGvjlUOrkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="14586673"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="14586673"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 12:22:39 -0700
X-CSE-ConnectionGUID: k0e5H/L/Rm6hU16qu4EbJA==
X-CSE-MsgGUID: /JKSwUziQOGX4rvAdc32+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="74078473"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Oct 2024 12:22:37 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sviSB-000R5n-1Z;
	Tue, 01 Oct 2024 19:22:35 +0000
Date: Wed, 2 Oct 2024 03:21:49 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: arch/arc/include/uapi/asm/page.h:17:20: error: 'CONFIG_PAGE_SHIFT'
 undeclared; did you mean 'CONFIG_HAVE_PCI'?
Message-ID: <202410020340.RDSG1ej8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: d3e5bab923d35f73c74f6dbbb761988d4f58f878 arch: simplify architecture specific page size configuration
date:   7 months ago
config: arc-axs103_smp_defconfig (https://download.01.org/0day-ci/archive/20241002/202410020340.RDSG1ej8-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020340.RDSG1ej8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020340.RDSG1ej8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arc/include/asm/atomic.h:31,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/current.h:6,
                    from arch/arc/include/asm/current.h:20,
                    from <command-line>:
   arch/arc/include/asm/atomic64-arcv2.h:13:3: error: conflicting types for 'atomic64_t'; have 'struct <anonymous>'
      13 | } atomic64_t;
         |   ^~~~~~~~~~
   In file included from include/linux/thread_info.h:11:
   include/linux/types.h:184:3: note: previous declaration of 'atomic64_t' with type 'atomic64_t'
     184 | } atomic64_t;
         |   ^~~~~~~~~~
   In file included from arch/arc/include/asm/atomic.h:31,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/arc/include/asm/bitops.h:188,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/current.h:6,
                    from arch/arc/include/asm/current.h:20,
                    from <command-line>:
   arch/arc/include/asm/atomic64-arcv2.h:13:3: error: conflicting types for 'atomic64_t'; have 'struct <anonymous>'
      13 | } atomic64_t;
         |   ^~~~~~~~~~
   In file included from include/linux/thread_info.h:11:
   include/linux/types.h:184:3: note: previous declaration of 'atomic64_t' with type 'atomic64_t'
     184 | } atomic64_t;
         |   ^~~~~~~~~~
   In file included from arch/arc/include/asm/page.h:8,
                    from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60:
   arch/arc/include/asm/page.h: In function 'virt_to_pfn':
>> arch/arc/include/uapi/asm/page.h:17:20: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
      17 | #define PAGE_SHIFT CONFIG_PAGE_SHIFT
         |                    ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/page.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   arch/arc/include/uapi/asm/page.h:17:20: note: each undeclared identifier is reported only once for each function it appears in
      17 | #define PAGE_SHIFT CONFIG_PAGE_SHIFT
         |                    ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/page.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   In file included from arch/arc/include/asm/page.h:8,
                    from arch/arc/include/asm/thread_info.h:16,
                    from include/linux/thread_info.h:60:
   arch/arc/include/asm/page.h: In function 'virt_to_pfn':
>> arch/arc/include/uapi/asm/page.h:17:20: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
      17 | #define PAGE_SHIFT CONFIG_PAGE_SHIFT
         |                    ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/page.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   arch/arc/include/uapi/asm/page.h:17:20: note: each undeclared identifier is reported only once for each function it appears in
      17 | #define PAGE_SHIFT CONFIG_PAGE_SHIFT
         |                    ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/page.h:125:31: note: in expansion of macro 'PAGE_SHIFT'
     125 |         return __pa(kaddr) >> PAGE_SHIFT;
         |                               ^~~~~~~~~~
   include/asm-generic/getorder.h: In function 'get_order':
>> arch/arc/include/uapi/asm/page.h:17:20: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
      17 | #define PAGE_SHIFT CONFIG_PAGE_SHIFT
         |                    ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/arc/include/asm/thread_info.h: At top level:
   arch/arc/include/asm/thread_info.h:59:79: error: macro "current_thread_info" passed 1 arguments, but takes just 0
      59 | static inline __attribute_const__ struct thread_info *current_thread_info(void)
         |                                                                               ^
   include/linux/thread_info.h:24: note: macro "current_thread_info" defined here
      24 | #define current_thread_info() ((struct thread_info *)current)
         | 
   arch/arc/include/asm/thread_info.h:60:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      60 | {
         | ^
   include/asm-generic/getorder.h: In function 'get_order':
>> arch/arc/include/uapi/asm/page.h:17:20: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
      17 | #define PAGE_SHIFT CONFIG_PAGE_SHIFT
         |                    ^~~~~~~~~~~~~~~~~
   include/asm-generic/getorder.h:33:48: note: in expansion of macro 'PAGE_SHIFT'
      33 |                         return BITS_PER_LONG - PAGE_SHIFT;
         |                                                ^~~~~~~~~~
   arch/arc/include/asm/thread_info.h: At top level:
   arch/arc/include/asm/thread_info.h:59:79: error: macro "current_thread_info" passed 1 arguments, but takes just 0
      59 | static inline __attribute_const__ struct thread_info *current_thread_info(void)
         |                                                                               ^
   include/linux/thread_info.h:24: note: macro "current_thread_info" defined here
      24 | #define current_thread_info() ((struct thread_info *)current)
         | 
   arch/arc/include/asm/thread_info.h:60:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      60 | {
         | ^
   include/linux/thread_info.h: In function 'tif_need_resched':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/thread_info.h:192:16: note: in expansion of macro 'test_bit'
     192 |         return test_bit(TIF_NEED_RESCHED,
         |                ^~~~~~~~
   include/linux/thread_info.h:193:44: note: in expansion of macro 'current_thread_info'
     193 |                         (unsigned long *)(&current_thread_info()->flags));
         |                                            ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h: In function 'tif_need_resched':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/bitops.h:50:44: note: in definition of macro 'bitop'
      50 |           __builtin_constant_p((uintptr_t)(addr) != (uintptr_t)NULL) && \
         |                                            ^~~~
   include/linux/thread_info.h:192:16: note: in expansion of macro 'test_bit'
     192 |         return test_bit(TIF_NEED_RESCHED,
         |                ^~~~~~~~
   include/linux/thread_info.h:193:44: note: in expansion of macro 'current_thread_info'
     193 |                         (unsigned long *)(&current_thread_info()->flags));
         |                                            ^~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:243: scripts/mod/empty.o] Error 1
   make[3]: *** [scripts/Makefile.build:116: scripts/mod/devicetable-offsets.s] Error 1
   make[3]: Target 'scripts/mod/' not remade because of errors.
   make[2]: *** [Makefile:1198: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +17 arch/arc/include/uapi/asm/page.h

    14	
    15	/* PAGE_SHIFT determines the page size */
    16	#ifdef __KERNEL__
  > 17	#define PAGE_SHIFT CONFIG_PAGE_SHIFT
    18	#else
    19	/*
    20	 * Default 8k
    21	 * done this way (instead of under CONFIG_ARC_PAGE_SIZE_8K) because adhoc
    22	 * user code (busybox appletlib.h) expects PAGE_SHIFT to be defined w/o
    23	 * using the correct uClibc header and in their build our autoconf.h is
    24	 * not available
    25	 */
    26	#define PAGE_SHIFT 13
    27	#endif
    28	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

