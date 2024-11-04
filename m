Return-Path: <linux-kernel+bounces-394258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D80E59BAC8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED8F1F22245
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC9818C348;
	Mon,  4 Nov 2024 06:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4ubUC4q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4F13A40C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701850; cv=none; b=VK2zM60VfQOuQRI3Q7yarwJXMkMABuGx102irxjDhRXxKudxjtkG2Apbk9gsxmvBZE3or8YFtArt5OdSIlhyHbIolICfcXtI7ygnGx6aWAm0AjEhH7Ay4acJotYhaLh2+godT2rtZBz3OXStMNF4/RpK/ofuedZZtJjIdsi/WTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701850; c=relaxed/simple;
	bh=RWNQbgmPoKqIVkISIRU27BH4vr+mtiJPQSiDMObJklo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NLg8/PDusbHDFkpEMvblK6H9V4X/Nv7xNgiajunMlJrKabT5FJOxVzeQm7a5OrLFsgAMHv6srPzYF+1PQKFYFg+M0A9rBjL5fX3wQ122oz0mVd6RIhvAU2wjq5O9NPnYECdB2WEsE1tgtpXit89VYqwy+vMY/SHCbydmCCTRSmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4ubUC4q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730701848; x=1762237848;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RWNQbgmPoKqIVkISIRU27BH4vr+mtiJPQSiDMObJklo=;
  b=P4ubUC4qbN1LWSkUpOJXEoW79J9+WHlcWSMEa1XRV3JYMR+JSDH9i0Sl
   oEPRdrK3aRmYvjjbvAzcxT5doXgsnVGRpRuWN00akb7vdfkdslZSPFWKl
   U3ACHvVVLCYrTP4M5nV1ZgaYPcD+CNdwmuej9tS219vr4fJK2RL2fZM7d
   tHhl/Y3EJv3RU9d7KvTQe1vSMA7uTLpWCIlmjeKZ2gD9kh7en1p3KFVCh
   2nfD2stImOTfs44lcmm0Ci1SaYK88mrb99e78u67WYI+7m0hhBNpFwqWh
   n6/g9tPHIFxr0PeXxv0YzbjaGmQIb87Cfp60vFFtVvNgTYxQzJyi5Fd55
   Q==;
X-CSE-ConnectionGUID: zr4/X9ysQhW7xITt6WDA4A==
X-CSE-MsgGUID: 9xd5AheLTaOYweDDF5D3DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="18002515"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="18002515"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 22:30:48 -0800
X-CSE-ConnectionGUID: ojpGDoWAS5u1JqTwFVvdZw==
X-CSE-MsgGUID: dnvtNGnaQye6l9XocoImVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="84002933"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 Nov 2024 22:30:47 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7qbr-000kXd-35;
	Mon, 04 Nov 2024 06:30:43 +0000
Date: Mon, 4 Nov 2024 14:30:33 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast
 truncates bits from constant value (ffffffff becomes ff)
Message-ID: <202411041426.V8jDSyDo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   59b723cd2adbac2a34fc8e12c74ae26ae45bf230
commit: 0e34600ac9317dbe5f0a7bfaa3d7187d757572ed sched: Misc cleanups
date:   1 year, 2 months ago
config: arm64-randconfig-r123-20241104 (https://download.01.org/0day-ci/archive/20241104/202411041426.V8jDSyDo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241104/202411041426.V8jDSyDo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411041426.V8jDSyDo-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/core.c:2226:68: sparse:     expected struct task_struct *tsk
   kernel/sched/core.c:2226:68: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:3721:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/core.c:3721:17: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/core.c:3721:17: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/core.c:3929:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:3929:36: sparse:     expected struct task_struct const *p
   kernel/sched/core.c:3929:36: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:9379:43: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *push_task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:9379:43: sparse:     expected struct task_struct *push_task
   kernel/sched/core.c:9379:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:5625:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:5625:38: sparse:     expected struct task_struct *curr
   kernel/sched/core.c:5625:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:6569:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *prev @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:6569:14: sparse:     expected struct task_struct *prev
   kernel/sched/core.c:6569:14: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:7095:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7095:17: sparse:    struct task_struct *
   kernel/sched/core.c:7095:17: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7310:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:7310:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:7310:22: sparse:    struct task_struct *
   kernel/sched/core.c:11435:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/core.c:11435:25: sparse:     expected struct task_struct *p
   kernel/sched/core.c:11435:25: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:1340:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:551:6: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/sched.h:1340:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:576:6: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:600:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:638:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:679:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:97:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:97:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:796:11: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:1086:5: sparse: sparse: context imbalance in 'get_nohz_timer_target' - wrong count at exit
   kernel/sched/core.c:1481:13: sparse: sparse: context imbalance in 'uclamp_update_util_min_rt_default' - wrong count at exit
   kernel/sched/core.c:1775:13: sparse: sparse: context imbalance in 'uclamp_update_root_tg' - wrong count at exit
   kernel/sched/core.c:1813:9: sparse: sparse: context imbalance in 'uclamp_sync_util_min_rt_default' - wrong count at exit
   kernel/sched/core.c:2217:33: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2218:19: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2219:18: sparse: sparse: dereference of noderef expression
   kernel/sched/core.c:2272:15: sparse: sparse: context imbalance in 'wait_task_inactive' - different lock contexts for basic block
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/core.c:2192:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/core.c:2192:38: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/core.c:2192:38: sparse:    struct task_struct const *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/core.c:8241:5: sparse: sparse: context imbalance in 'dl_task_check_affinity' - wrong count at exit
   kernel/sched/core.c:8345:9: sparse: sparse: context imbalance in 'sched_setaffinity' - different lock contexts for basic block
   kernel/sched/core.c:8407:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit
   kernel/sched/core.c: note: in included file (through include/linux/mmu_context.h, include/linux/cpuset.h):
   arch/arm64/include/asm/mmu_context.h:252:22: sparse: sparse: self-comparison always evaluates to true
   arch/arm64/include/asm/mmu_context.h:221:20: sparse: sparse: self-comparison always evaluates to true
   arch/arm64/include/asm/mmu_context.h:221:20: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c: note: in included file:
   kernel/sched/sched.h:2138:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2138:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2302:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2302:9: sparse:    struct task_struct *
   kernel/sched/core.c:11600:5: sparse: sparse: context imbalance in '__sched_mm_cid_migrate_from_fetch_cid' - different lock contexts for basic block
   kernel/sched/core.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/asm-generic/bitops/atomic.h, ...):
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ff)
>> arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast truncates bits from constant value (ffffffff becomes ffff)

vim +171 arch/arm64/include/asm/cmpxchg.h

10b663aef1c247 Catalin Marinas 2012-03-05  167  
305d454aaa292b Will Deacon     2015-10-08  168  __CMPXCHG_GEN()
305d454aaa292b Will Deacon     2015-10-08  169  __CMPXCHG_GEN(_acq)
305d454aaa292b Will Deacon     2015-10-08  170  __CMPXCHG_GEN(_rel)
305d454aaa292b Will Deacon     2015-10-08 @171  __CMPXCHG_GEN(_mb)
10b663aef1c247 Catalin Marinas 2012-03-05  172  

:::::: The code at line 171 was first introduced by commit
:::::: 305d454aaa292be3a09a9d674e6c35f5b4249a13 arm64: atomics: implement native {relaxed, acquire, release} atomics

:::::: TO: Will Deacon <will.deacon@arm.com>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

