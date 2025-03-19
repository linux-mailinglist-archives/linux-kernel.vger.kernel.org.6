Return-Path: <linux-kernel+bounces-568147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87295A68EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D179C3B997F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9B192B6D;
	Wed, 19 Mar 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbIMh3U0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28C16D32A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393652; cv=none; b=JrojECO6+deMrFRHWl6Rm9z/xRL6Ee7jGcVhv16bXrkcnwRWZX015/i8p1IBN55VB4si3G/Uz3UQNEOn4p7MlIRWhDyXp93eBxgeJNj0hOWFEEQne9iVkHwSb8gOgHSqfp7FEBfNcioWCpxD0mCaAPIumuImHd+wtma8oamySuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393652; c=relaxed/simple;
	bh=SoDGrJooR6MkodkzBFRC161TT1L6N41L7gOL5NH1DWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aWe98EOUN6wp+LXsvfrK1yXq42SDhG6SkQICjdMVM2hqgsjPG/YjjXb8Q3BFwVtGDkaU2SgwQp8oQ6gDXJCGZPlEqN9VEkw1qaPbUy1jpNzKxYtPJ/cqBgy5BHVp6evpfZJDSvvKn6rEzkPRUktirnE/g58CvYCdoqoXEicYHHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbIMh3U0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742393651; x=1773929651;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SoDGrJooR6MkodkzBFRC161TT1L6N41L7gOL5NH1DWw=;
  b=VbIMh3U0vvvGZlvSAD8lA5AxHfpFudivqJzevq/zybfTGYuKQuv7iHy0
   NUw29DJafQZmbUheB1ODxuMaWOFE3U3SLMc2rspE4xcsXaYZh8kp4S3zv
   SgQTqQeinOcbgfQRF2xbL2I2s52EHjxfkmDzwgIlOhkRgc6J2NcFwqUrb
   zIt9jT9Q3RIxgbky1wcpTlYIBhwMl8/lVUM8xSDIdskSMRtNwBO5GekVy
   kMRklUNzrd15UlsGSbDhA2B2KQ+Vsgp/Aur3tjzE6zmdDe8E53y/55F/G
   FIP46SytepdKMcBgO8XMEmo23IJCBjtyiY143HFkJcH+9Ht/tfD58pTKa
   g==;
X-CSE-ConnectionGUID: rFNrnU9uR0CvckJg9/08gA==
X-CSE-MsgGUID: YcUUT6BmR0m90H7N/mPiKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43601191"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43601191"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:14:05 -0700
X-CSE-ConnectionGUID: U6Wph3A/SlepM7oWEafbZg==
X-CSE-MsgGUID: f2ffIY6dQ6e5jrDeas/vWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123126376"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Mar 2025 07:14:04 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuuBA-000Ej1-1B;
	Wed, 19 Mar 2025 14:13:58 +0000
Date: Wed, 19 Mar 2025 22:11:47 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:WIP.x86/core 1/1] arch/arm64/include/asm/atomic_lse.h:289:11:
 warning: unused variable 'n'
Message-ID: <202503200011.p3NCuhkb-lkp@intel.com>
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
config: arm64-randconfig-002-20250319 (https://download.01.org/0day-ci/archive/20250320/202503200011.p3NCuhkb-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250320/202503200011.p3NCuhkb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200011.p3NCuhkb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from <command-line>:0:0:
   arch/arm64/include/asm/atomic_lse.h: In function '__lse__cmpxchg128':
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:290:28: note: in expansion of macro 'asm'
     register unsigned long x0 asm ("x0") = o.low;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:310:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(   ,   )
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:291:28: note: in expansion of macro 'asm'
     register unsigned long x1 asm ("x1") = o.high;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:310:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(   ,   )
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:292:28: note: in expansion of macro 'asm'
     register unsigned long x2 asm ("x2") = n.low;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:310:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(   ,   )
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:293:28: note: in expansion of macro 'asm'
     register unsigned long x3 asm ("x3") = n.high;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:310:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(   ,   )
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:294:28: note: in expansion of macro 'asm'
     register unsigned long x4 asm ("x4") = (unsigned long)ptr; \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:310:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(   ,   )
    ^~~~~~~~~~~~
   In file included from arch/arm64/include/asm/lse.h:16:0,
                    from arch/arm64/include/asm/cmpxchg.h:14,
                    from arch/arm64/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/arm64/include/asm/bitops.h:25,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/arm64/include/asm/atomic_lse.h:289:11: warning: unused variable 'n' [-Wunused-variable]
              n = { .full = (new) };   \
              ^
   arch/arm64/include/asm/atomic_lse.h:310:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(   ,   )
    ^~~~~~~~~~~~
   In file included from <command-line>:0:0:
   arch/arm64/include/asm/atomic_lse.h: In function '__lse__cmpxchg128_mb':
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:290:28: note: in expansion of macro 'asm'
     register unsigned long x0 asm ("x0") = o.low;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:311:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(_mb, al, "memory")
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:291:28: note: in expansion of macro 'asm'
     register unsigned long x1 asm ("x1") = o.high;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:311:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(_mb, al, "memory")
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:292:28: note: in expansion of macro 'asm'
     register unsigned long x2 asm ("x2") = n.low;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:311:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(_mb, al, "memory")
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:293:28: note: in expansion of macro 'asm'
     register unsigned long x3 asm ("x3") = n.high;   \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:311:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(_mb, al, "memory")
    ^~~~~~~~~~~~
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/arm64/include/asm/atomic_lse.h:294:28: note: in expansion of macro 'asm'
     register unsigned long x4 asm ("x4") = (unsigned long)ptr; \
                               ^~~
   arch/arm64/include/asm/atomic_lse.h:311:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(_mb, al, "memory")
    ^~~~~~~~~~~~
   In file included from arch/arm64/include/asm/lse.h:16:0,
                    from arch/arm64/include/asm/cmpxchg.h:14,
                    from arch/arm64/include/asm/atomic.h:16,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/arm64/include/asm/bitops.h:25,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/arm64/include/asm/atomic_lse.h:289:11: warning: unused variable 'n' [-Wunused-variable]
              n = { .full = (new) };   \
              ^
   arch/arm64/include/asm/atomic_lse.h:311:1: note: in expansion of macro '__CMPXCHG128'
    __CMPXCHG128(_mb, al, "memory")
    ^~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: kernel/bounds.s] Error 1 shuffle=804208462
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1269: prepare0] Error 2 shuffle=804208462
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=804208462
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=804208462
   make: Target 'prepare' not remade because of errors.


vim +/n +289 arch/arm64/include/asm/atomic_lse.h

c342f78217e822d Will Deacon    2015-04-23  283  
b23e139d0b66c02 Peter Zijlstra 2023-05-31  284  #define __CMPXCHG128(name, mb, cl...)					\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  285  static __always_inline u128						\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  286  __lse__cmpxchg128##name(volatile u128 *ptr, u128 old, u128 new)		\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  287  {									\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  288  	union __u128_halves r, o = { .full = (old) },			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31 @289  			       n = { .full = (new) };			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  290  	register unsigned long x0 asm ("x0") = o.low;			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  291  	register unsigned long x1 asm ("x1") = o.high;			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  292  	register unsigned long x2 asm ("x2") = n.low;			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  293  	register unsigned long x3 asm ("x3") = n.high;			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  294  	register unsigned long x4 asm ("x4") = (unsigned long)ptr;	\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  295  									\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  296  	asm volatile(							\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  297  	__LSE_PREAMBLE							\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  298  	"	casp" #mb "\t%[old1], %[old2], %[new1], %[new2], %[v]\n"\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  299  	: [old1] "+&r" (x0), [old2] "+&r" (x1),				\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  300  	  [v] "+Q" (*(u128 *)ptr)					\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  301  	: [new1] "r" (x2), [new2] "r" (x3), [ptr] "r" (x4),		\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  302  	  [oldval1] "r" (o.low), [oldval2] "r" (o.high)			\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  303  	: cl);								\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  304  									\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  305  	r.low = x0; r.high = x1;					\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  306  									\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  307  	return r.full;							\
b23e139d0b66c02 Peter Zijlstra 2023-05-31  308  }
b23e139d0b66c02 Peter Zijlstra 2023-05-31  309  

:::::: The code at line 289 was first introduced by commit
:::::: b23e139d0b66c0216e7e9361a5021290395f504c arch: Introduce arch_{,try_}_cmpxchg128{,_local}()

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

