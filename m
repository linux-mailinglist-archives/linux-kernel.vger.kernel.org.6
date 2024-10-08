Return-Path: <linux-kernel+bounces-354420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF70F993D42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A6F281B39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF2C2E3EE;
	Tue,  8 Oct 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxbpMF2s"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F942A9F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356675; cv=none; b=O1P996ETfNwxZPahy9DEAVV1BsUTerg2UUDxvQ65bKfHpFMeRSiqikBM6V6dBCf2xPDU7XpVvjFqAKLdo8cDR5Ga0+PAVrRcJKOEGn8eADHkqSvcW5FEV25XoYaVAlkDpLsNNHPYtUNBHHl0GzHsmYLtZkmjAV50CI85p+pgEvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356675; c=relaxed/simple;
	bh=BIbF3kT//qtNaasvOrobz7YlamNt7LLmHnWgXgCBR8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YWkqcdDX6c6yQDCcnxg7QiWT0g4edGUy6lqYDf6l9+lN4L6ii4XUFVzcZL7PYiK+HBHdPSMvkaUvISOZjSUwHWZ+wj70WmsAGfZFEFKsHWsAOPsL+roytgS/1DIxqE1xLYX8hDn83kR7N0iJVup/gqx+yu/WVLXUBgFciMP2RE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxbpMF2s; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728356673; x=1759892673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BIbF3kT//qtNaasvOrobz7YlamNt7LLmHnWgXgCBR8k=;
  b=AxbpMF2sdCWBSOEh7ekdvyt0hfm+6IcRL5uwPSH/N90tko3P3qlrjMnf
   CKVRcO/llZuvBPsQdl+QL78ZSJyKqEuSiK+4eILICGukaAOzmPYNQKQOj
   HjxteK+3S/Tb/4/9UcjVib6fXNNeH4l46cjEkjZxRxBGRkG970mVa67Wv
   W+ETjOdVhzjt9PW9E3jrWewvcaUZOG//RSppLWySJThQkl/49GeMpV8qD
   +WqUZYPvZPwbPvjvO7habUqtNgK/qhpmD/fIE802ocb8/rnCeVjB5bDwn
   jGHg8arZCMQPjlyulB2qnwnaEMCQdSBZ1VtOIxyK3nmAaM3eep4Rs8Idz
   Q==;
X-CSE-ConnectionGUID: r8nbCL2+T/eyPwEvFqVz/Q==
X-CSE-MsgGUID: H5hPyrtGQuSSfNqeetTKkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="52931663"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="52931663"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 20:04:33 -0700
X-CSE-ConnectionGUID: JkJUTfxwQ4qCGHaJpvQG0A==
X-CSE-MsgGUID: IBFURObNRN6bq6GGPnVirA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="76122057"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Oct 2024 20:04:31 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy0WT-0005q8-0J;
	Tue, 08 Oct 2024 03:04:29 +0000
Date: Tue, 8 Oct 2024 11:03:30 +0800
From: kernel test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: arch/arm64/include/asm/cmpxchg.h:171:1: sparse: sparse: cast
 truncates bits from constant value (ffffffff becomes ff)
Message-ID: <202410081000.M2qAN7W7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
commit: 0e34600ac9317dbe5f0a7bfaa3d7187d757572ed sched: Misc cleanups
date:   1 year, 1 month ago
config: arm64-randconfig-r133-20241007 (https://download.01.org/0day-ci/archive/20241008/202410081000.M2qAN7W7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241008/202410081000.M2qAN7W7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081000.M2qAN7W7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
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
   kernel/sched/core.c:558:17: sparse: sparse: context imbalance in 'raw_spin_rq_lock_nested' - wrong count at exit
   kernel/sched/sched.h:1340:17: sparse: sparse: self-comparison always evaluates to true
   kernel/sched/core.c:584:23: sparse: sparse: context imbalance in 'raw_spin_rq_trylock' - wrong count at exit
   kernel/sched/core.c:600:6: sparse: sparse: context imbalance in 'raw_spin_rq_unlock' - unexpected unlock
   kernel/sched/core.c:638:36: sparse: sparse: context imbalance in '__task_rq_lock' - wrong count at exit
   kernel/sched/core.c:679:36: sparse: sparse: context imbalance in 'task_rq_lock' - wrong count at exit
   kernel/sched/core.c: note: in included file:
   kernel/sched/pelt.h:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct const *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/pelt.h:97:13: sparse:     expected struct task_struct const *p
   kernel/sched/pelt.h:97:13: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/core.c:796:11: sparse: sparse: dereference of noderef expression
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
   kernel/sched/core.c:8345:44: sparse: sparse: context imbalance in 'sched_setaffinity' - different lock contexts for basic block
   kernel/sched/core.c:8407:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit
   kernel/sched/core.c:8570:28: sparse: sparse: context imbalance in '__cond_resched_lock' - unexpected unlock
   kernel/sched/core.c:8588:17: sparse: sparse: context imbalance in '__cond_resched_rwlock_read' - unexpected unlock
   kernel/sched/core.c:8606:17: sparse: sparse: context imbalance in '__cond_resched_rwlock_write' - unexpected unlock
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
   kernel/sched/core.c:11600:5: sparse: sparse: context imbalance in '__sched_mm_cid_migrate_from_fetch_cid' - different lock contexts for basic block
   kernel/sched/core.c: note: in included file (through arch/arm64/include/asm/atomic.h, include/linux/atomic.h, include/linux/jump_label.h, ...):
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

