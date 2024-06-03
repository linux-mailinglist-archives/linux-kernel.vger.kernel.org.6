Return-Path: <linux-kernel+bounces-198657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867ED8D7BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D411C215E9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BC2C1AC;
	Mon,  3 Jun 2024 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8knMSnV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE005BACF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396771; cv=none; b=VhD+1PFgPUgZL20S8rU6R83gAFnLxPIFLWJfmJGH5bBi1KRBunYfjjucwKov4hLCPJc9pTD0cWooAic48iCk/TFIxesCfrMWwENpA81lCsAXsvhOYuCD+/e8kCx4EU08ruK1uT03pfWrjPo3G51KL9NZgdtPt7y6Axw2la17c7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396771; c=relaxed/simple;
	bh=1BZZMsPFwPpGXIX87G1hn2zFFzt5yAvYEmZSxoqHeTY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qxRUzstZmK953IU9IA1ZlyKcK69BHIiRenjaeSmkpH9OHWpABTJLam3YWecDQLCdWR7Akbi/PVDj7T2D8QSvAjeUlWsZerU/ugLsoRDZvw/tew6gqdVzCkP6NYRGc5cfb6ycZez7R23oOozNs0gdzMfjD+8CcKNXbvH9eJ31yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8knMSnV; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717396769; x=1748932769;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1BZZMsPFwPpGXIX87G1hn2zFFzt5yAvYEmZSxoqHeTY=;
  b=Q8knMSnVetlThnqiYaWV3F49036J00hOWopd26+VQkgXcHKDwwLXTvRB
   ZcbjIwIb9SYA7PbqBiO9U00VeYIwAz5ALKBZgk5+jHAxAyK3gKz7sc2Cf
   VOjTAyunMwakTsYVbgiBGBvZCcEvQk9Tt6SMy4NTBdzNKFPXXJSKirhtB
   /moTQhc7b2WuEnQdfv4tNNUUjgxEemHUYh1abJNlSgwNZoF1PbnokmaZV
   sDjUwamQISL/sHtDYeKib4jQIB9rPLjwcpLxO/ZRqGotFgXQy05knzOC9
   Fj2VVl89fWnrBdpf6glh9zem12aTtfweEMJFVPrSLBOnCUqfDKcniXatw
   w==;
X-CSE-ConnectionGUID: 8Af6wzbVRiennJ1AsZmS6Q==
X-CSE-MsgGUID: pcltKiBYS+q+vrf/pTQR7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="13688998"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="13688998"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:39:28 -0700
X-CSE-ConnectionGUID: erGpIcptQAe/GvypGlxCfw==
X-CSE-MsgGUID: PAgDW9EuQvaGNOEDNgbZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36704400"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 02 Jun 2024 23:39:27 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE1Lp-000L7C-07;
	Mon, 03 Jun 2024 06:39:25 +0000
Date: Mon, 3 Jun 2024 14:38:04 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.05.30a 5/50]
 arch/arm/include/asm/cmpxchg.h:167:12: error: call to undeclared function
 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202406031410.LcIbbCfd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.05.30a
head:   3d08b2c4a149fdf966e1b0768c14bbf4048e4070
commit: 6ba3d5014d24a46ed329fc567e554c218eb62cfa [5/50] ARM: Emulate one-byte cmpxchg
config: arm-randconfig-r052-20240603 (https://download.01.org/0day-ci/archive/20240603/202406031410.LcIbbCfd-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406031410.LcIbbCfd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406031410.LcIbbCfd-lkp@intel.com/

Note: the paulmck-rcu/dev.2024.05.30a HEAD 3d08b2c4a149fdf966e1b0768c14bbf4048e4070 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from kernel/bounds.c:13:
   In file included from include/linux/log2.h:12:
   In file included from include/linux/bitops.h:63:
   In file included from arch/arm/include/asm/bitops.h:245:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:7:
   In file included from arch/arm/include/asm/atomic.h:16:
>> arch/arm/include/asm/cmpxchg.h:167:12: error: call to undeclared function 'cmpxchg_emu_u8'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
                   oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
                            ^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/cmpxchg_emu_u8 +167 arch/arm/include/asm/cmpxchg.h

   152	
   153	/*
   154	 * cmpxchg only support 32-bits operands on ARMv6.
   155	 */
   156	
   157	static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
   158					      unsigned long new, int size)
   159	{
   160		unsigned long oldval, res;
   161	
   162		prefetchw((const void *)ptr);
   163	
   164		switch (size) {
   165	#ifdef CONFIG_CPU_V6	/* min ARCH >= ARMv6K */
   166		case 1:
 > 167			oldval = cmpxchg_emu_u8((volatile u8 *)ptr, old, new);
   168			break;
   169	#else
   170		case 1:
   171			do {
   172				asm volatile("@ __cmpxchg1\n"
   173				"	ldrexb	%1, [%2]\n"
   174				"	mov	%0, #0\n"
   175				"	teq	%1, %3\n"
   176				"	strexbeq %0, %4, [%2]\n"
   177					: "=&r" (res), "=&r" (oldval)
   178					: "r" (ptr), "Ir" (old), "r" (new)
   179					: "memory", "cc");
   180			} while (res);
   181			break;
   182		case 2:
   183			do {
   184				asm volatile("@ __cmpxchg1\n"
   185				"	ldrexh	%1, [%2]\n"
   186				"	mov	%0, #0\n"
   187				"	teq	%1, %3\n"
   188				"	strexheq %0, %4, [%2]\n"
   189					: "=&r" (res), "=&r" (oldval)
   190					: "r" (ptr), "Ir" (old), "r" (new)
   191					: "memory", "cc");
   192			} while (res);
   193			break;
   194	#endif
   195		case 4:
   196			do {
   197				asm volatile("@ __cmpxchg4\n"
   198				"	ldrex	%1, [%2]\n"
   199				"	mov	%0, #0\n"
   200				"	teq	%1, %3\n"
   201				"	strexeq %0, %4, [%2]\n"
   202					: "=&r" (res), "=&r" (oldval)
   203					: "r" (ptr), "Ir" (old), "r" (new)
   204					: "memory", "cc");
   205			} while (res);
   206			break;
   207		default:
   208			__bad_cmpxchg(ptr, size);
   209			oldval = 0;
   210		}
   211	
   212		return oldval;
   213	}
   214	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

