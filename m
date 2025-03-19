Return-Path: <linux-kernel+bounces-568027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A84A68D21
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0963B5BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AB825525D;
	Wed, 19 Mar 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjO/mCES"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92972134BD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388334; cv=none; b=s2btkz5dnD659An6kLMhR5dMqb7EFmNGl3vWwI3jAlcrUWZSdH5FaAA4tm7P8vWqVMxWLCXfLVsUNEV1iAdirgUpCu97DP9o6Fh6VMoQwAogDTdmLD+UcCeuM66Rl2dykpM5rcKmbgtZwMjLApI77g/4hBKJIyWhJCd/1J8Z7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388334; c=relaxed/simple;
	bh=XvuniB+iVUzkCbMLm7ghu8hnqhsPWvb2plB8VFGVLY8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rUQCj7flLRz4shADUhhtHhaAQmcuE7uDgKAn4XzNBRxnE0la/JjwseJg8JLcdBuVE0x1Yxuqh8POM2sUAxgeUL5YuaH2NIr15sVDqQhSDXyKTjODrq2wWEB5/X7Mvs/wST2bi4vdMmD0nXZbL4TIWQNw39MYMk6VLV+2+TiVzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjO/mCES; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742388332; x=1773924332;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XvuniB+iVUzkCbMLm7ghu8hnqhsPWvb2plB8VFGVLY8=;
  b=AjO/mCES/9VwwXMZNclLdYu1w+gE/u2rK/fZuaR+uhBLytI4o+gsXYg+
   ElZB8UPCDfIUcfTzQpi00NkOVvkBYg/dU7/InQ1r0egtqRAksAkiMoo2w
   e3pyAcKBMIBel6XO+iFBlDFUwbrtIQUqhhB48pYrh7pS6PPI5jyeWyPvO
   5V5fYWOYviK8/0dbNThIUlbGSORkcQhzZpnhXfqQ6wFWCdyhHwNSXzqAI
   a+sTjP3PrvceTHiP5z0tcf42D5EcaEklA6W5BBS6aGzaK4aANkD7WcEci
   V4guNlEmqclxvoqldpMtWDEHDUBS62rLkPRVR/CAYEIVMaUb3aIa1vfKT
   w==;
X-CSE-ConnectionGUID: qmYdEdMoRrmehyUKP23Wsw==
X-CSE-MsgGUID: L/4WNgoNRAO9mokvv5iYMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43744164"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43744164"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:45:32 -0700
X-CSE-ConnectionGUID: rK39OvyZT16gMlowZLicyw==
X-CSE-MsgGUID: bnTSMVFlSwCSeMMV6ZNdyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="127680582"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 19 Mar 2025 05:45:31 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tusnY-000Efu-03;
	Wed, 19 Mar 2025 12:45:28 +0000
Date: Wed, 19 Mar 2025 20:45:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [tip:WIP.x86/core 1/1]
 arch/riscv/include/asm/vdso/gettimeofday.h:24:43: error: meaningless
 'inline' on asm outside function
Message-ID: <202503192004.mvMWNurt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/core
head:   9262ee6499954dd387e4507e03b84512ab100706
commit: 9262ee6499954dd387e4507e03b84512ab100706 [1/1] compiler/gcc: Make asm() templates asm __inline__() by default
config: riscv-randconfig-001-20250319 (https://download.01.org/0day-ci/archive/20250319/202503192004.mvMWNurt-lkp@intel.com/config)
compiler: clang version 20.1.0 (https://github.com/llvm/llvm-project 24a30daaa559829ad079f2ff7f73eb4e18095f88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192004.mvMWNurt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192004.mvMWNurt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
>> arch/riscv/include/asm/vdso/gettimeofday.h:24:43: error: meaningless 'inline' on asm outside function
      24 |         register struct __kernel_old_timeval *tv asm("a0") = _tv;
         |                                                  ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:25:31: error: meaningless 'inline' on asm outside function
      25 |         register struct timezone *tz asm("a1") = _tz;
         |                                      ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:26:20: error: meaningless 'inline' on asm outside function
      26 |         register long ret asm("a0");
         |                           ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:27:19: error: meaningless 'inline' on asm outside function
      27 |         register long nr asm("a7") = __NR_gettimeofday;
         |                          ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:40:27: error: meaningless 'inline' on asm outside function
      40 |         register clockid_t clkid asm("a0") = _clkid;
         |                                  ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:41:40: error: meaningless 'inline' on asm outside function
      41 |         register struct __kernel_timespec *ts asm("a1") = _ts;
         |                                               ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:42:20: error: meaningless 'inline' on asm outside function
      42 |         register long ret asm("a0");
         |                           ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:43:19: error: meaningless 'inline' on asm outside function
      43 |         register long nr asm("a7") = __NR_clock_gettime;
         |                          ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:56:27: error: meaningless 'inline' on asm outside function
      56 |         register clockid_t clkid asm("a0") = _clkid;
         |                                  ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:57:40: error: meaningless 'inline' on asm outside function
      57 |         register struct __kernel_timespec *ts asm("a1") = _ts;
         |                                               ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:58:20: error: meaningless 'inline' on asm outside function
      58 |         register long ret asm("a0");
         |                           ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from <built-in>:4:
   In file included from lib/vdso/gettimeofday.c:5:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:59:19: error: meaningless 'inline' on asm outside function
      59 |         register long nr asm("a7") = __NR_clock_getres;
         |                          ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   12 errors generated.
   make[3]: *** [scripts/Makefile.build:207: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1 shuffle=889927436
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
>> arch/riscv/include/asm/vdso/gettimeofday.h:24:43: error: meaningless 'inline' on asm outside function
      24 |         register struct __kernel_old_timeval *tv asm("a0") = _tv;
         |                                                  ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:25:31: error: meaningless 'inline' on asm outside function
      25 |         register struct timezone *tz asm("a1") = _tz;
         |                                      ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:26:20: error: meaningless 'inline' on asm outside function
      26 |         register long ret asm("a0");
         |                           ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:27:19: error: meaningless 'inline' on asm outside function
      27 |         register long nr asm("a7") = __NR_gettimeofday;
         |                          ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:40:27: error: meaningless 'inline' on asm outside function
      40 |         register clockid_t clkid asm("a0") = _clkid;
         |                                  ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:41:40: error: meaningless 'inline' on asm outside function
      41 |         register struct __kernel_timespec *ts asm("a1") = _ts;
         |                                               ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:42:20: error: meaningless 'inline' on asm outside function
      42 |         register long ret asm("a0");
         |                           ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:43:19: error: meaningless 'inline' on asm outside function
      43 |         register long nr asm("a7") = __NR_clock_gettime;
         |                          ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:56:27: error: meaningless 'inline' on asm outside function
      56 |         register clockid_t clkid asm("a0") = _clkid;
         |                                  ^
   include/linux/compiler_types.h:480:19: note: expanded from macro 'asm'
     480 | # define asm(...) asm_inline(__VA_ARGS__)
         |                   ^
   include/linux/compiler_types.h:479:29: note: expanded from macro 'asm_inline'
     479 | # define asm_inline __asm__ __inline
         |                             ^
   In file included from arch/riscv/kernel/vdso/hwprobe.c:8:
   In file included from include/vdso/datapage.h:164:
   arch/riscv/include/asm/vdso/gettimeofday.h:57:40: error: meaningless 'inline' on asm outside function
      57 |         register struct __kernel_timespec *ts asm("a1") = _ts;


vim +/inline +24 arch/riscv/include/asm/vdso/gettimeofday.h

ad5d1122b82fbd6 Vincent Chen 2020-06-09  19  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  20  static __always_inline
ad5d1122b82fbd6 Vincent Chen 2020-06-09  21  int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
ad5d1122b82fbd6 Vincent Chen 2020-06-09  22  			  struct timezone *_tz)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  23  {
ad5d1122b82fbd6 Vincent Chen 2020-06-09 @24  	register struct __kernel_old_timeval *tv asm("a0") = _tv;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  25  	register struct timezone *tz asm("a1") = _tz;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  26  	register long ret asm("a0");
ad5d1122b82fbd6 Vincent Chen 2020-06-09  27  	register long nr asm("a7") = __NR_gettimeofday;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  28  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  29  	asm volatile ("ecall\n"
ad5d1122b82fbd6 Vincent Chen 2020-06-09  30  		      : "=r" (ret)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  31  		      : "r"(tv), "r"(tz), "r"(nr)
ad5d1122b82fbd6 Vincent Chen 2020-06-09  32  		      : "memory");
ad5d1122b82fbd6 Vincent Chen 2020-06-09  33  
ad5d1122b82fbd6 Vincent Chen 2020-06-09  34  	return ret;
ad5d1122b82fbd6 Vincent Chen 2020-06-09  35  }
ad5d1122b82fbd6 Vincent Chen 2020-06-09  36  

:::::: The code at line 24 was first introduced by commit
:::::: ad5d1122b82fbd6a816d1b9d26ee01a6dbc2d757 riscv: use vDSO common flow to reduce the latency of the time-related functions

:::::: TO: Vincent Chen <vincent.chen@sifive.com>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

