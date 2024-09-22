Return-Path: <linux-kernel+bounces-335336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9994597E43F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00112811FF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 23:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C64D80BF7;
	Sun, 22 Sep 2024 23:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKqqwVih"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE238FC12
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727048118; cv=none; b=PQDXC9vVuB7U46fDZbl5fWSAV99KLg2Q9nF4ulvh3p3NUe5urkVuUIWXO5nQBULXBbwM/f6K/x/qpuyTArkjgofUy5d15Jsefw+dKjQV0XJHXFiEXrGMGGHAr4vrKb1ZmMaoKlsbDjxBo1/7htYhq3fAM6GR9b66KFU/z+00DCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727048118; c=relaxed/simple;
	bh=nQ5I3uy+Wm2X5CETfU5dty7+4o29kC4F2qCeuzyK5G8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cIQW7qvLukQcYiDAnFOMzLWq1QscQ6pY03w+7WMJwe+ktKHbnNXQMehX6ddadiPnXAoExikvVtNJzLp+bDA/xJ9JlVQDZlpE6ZHiT+enpq06PG0yPflCN8ZLhmlAdVVUXaLIoYLvGPgIzXGAbj2DKK+jZFgVO/UyH3IiAAIj60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKqqwVih; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727048117; x=1758584117;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nQ5I3uy+Wm2X5CETfU5dty7+4o29kC4F2qCeuzyK5G8=;
  b=FKqqwVih0XKPJzUM0IiemAtd+sY63FGK3hBPwReOMjqfl12NA/WwtT5d
   /MJnJ+vezvZcmdrXBIldoPAh0l8iiKsEbZujTWcRgTUE2ICSG1N+4w4uO
   kQk44N/Y/du9qowKbGI4kt+u6WwQ4VebBC0vUOgt+He1N2BMtfBDss+/L
   PSJQqprjmllXxbrZX+socKRMf9il8qFb4Y+//9JoW5k5pFsrPUEk2UCKS
   ZzLoGz9ORiByyII+M+iW9jknjNGPaWnfOeVUGO5syAspr/Yi3gQ+FwcaV
   jc53Frt219c2RWWOCqDBYlNAZ63rCWv7zC01iqRnJ6WtnreoLpYd+G3pU
   Q==;
X-CSE-ConnectionGUID: Z9Dke8aHSKyABh469txh5g==
X-CSE-MsgGUID: UXbV7MrkSuSMB9nPxx7U9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26139217"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26139217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2024 16:35:16 -0700
X-CSE-ConnectionGUID: J5YEviEZQQSvK0LeClKd8A==
X-CSE-MsgGUID: vvBEIjJATT6o0ZsU9lQEvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="71168794"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Sep 2024 16:35:15 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssW6i-000Gjy-2L;
	Sun, 22 Sep 2024 23:35:12 +0000
Date: Mon, 23 Sep 2024 07:34:48 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: arch/powerpc/include/asm/switch_to.h:53:2: error: call to
 '__compiletime_assert_256' declared with 'error' attribute: BUILD_BUG failed
Message-ID: <202409230705.hFpB3jMt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de5cb0dcb74c294ec527eddfe5094acfdb21ff21
commit: c2e5d70cf05b48bfbd5b6625bbd0ec3052cecd5d powerpc/83xx: Fix build failure with FPU=n
date:   7 months ago
config: powerpc-randconfig-001-20240923 (https://download.01.org/0day-ci/archive/20240923/202409230705.hFpB3jMt-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409230705.hFpB3jMt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409230705.hFpB3jMt-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/cpufreq/pmac32-cpufreq.c:21:
   In file included from include/linux/pmu.h:12:
   In file included from include/linux/rtc.h:17:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2188:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/cpufreq/pmac32-cpufreq.c:38:
>> arch/powerpc/include/asm/switch_to.h:53:2: error: call to '__compiletime_assert_256' declared with 'error' attribute: BUILD_BUG failed
      53 |         BUILD_BUG();
         |         ^
   include/linux/build_bug.h:59:21: note: expanded from macro 'BUILD_BUG'
      59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
         |                     ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:435:2: note: expanded from macro 'compiletime_assert'
     435 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:106:1: note: expanded from here
     106 | __compiletime_assert_256
         | ^
   1 warning and 1 error generated.


vim +53 arch/powerpc/include/asm/switch_to.h

    38	
    39	#ifdef CONFIG_PPC_FPU
    40	extern void enable_kernel_fp(void);
    41	extern void flush_fp_to_thread(struct task_struct *);
    42	extern void giveup_fpu(struct task_struct *);
    43	extern void save_fpu(struct task_struct *);
    44	static inline void disable_kernel_fp(void)
    45	{
    46		msr_check_and_clear(MSR_FP);
    47	}
    48	#else
    49	static inline void save_fpu(struct task_struct *t) { }
    50	static inline void flush_fp_to_thread(struct task_struct *t) { }
    51	static inline void enable_kernel_fp(void)
    52	{
  > 53		BUILD_BUG();
    54	}
    55	#endif
    56	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

