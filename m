Return-Path: <linux-kernel+bounces-428602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 603119E1128
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 03:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01640164A96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7DA13541B;
	Tue,  3 Dec 2024 02:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/hdNtaI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021517555
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733192101; cv=none; b=gAf3RUXqmEDLBTpOriiSg+J7BQm0q6kqJIrmyXAVRcF11i1erYsHu7Sial3nwcFyz5f6xBiDWm0I5KV/XKWiB/K+dzu95TmQWWzzNAGgHa38ssg1bQ80bJos3pPoxTGmGWCC9XS8kA5BE+V7QEXl1SDoilGpWnu/HUnNzgdabJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733192101; c=relaxed/simple;
	bh=KMl61z9tsvm3GrPnsl3tt1vpi0kGYRETOOyBfgEWcZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqqyNpJpaSzPWZ5SPG5NX7Kvn/JhsW88ULj1acKEn0gfn7cFJxJvRUoahUcDx4bTKLBgaaTFFcFnTlDJCmCDNiG3fvgPKSk0pCpflc5ArcXnohaZsJo28qXueWOmO09oAJ9p+/pKLdVxSIq+AFdLi9N/StgFxR8Y9vJxAzubnGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/hdNtaI; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733192100; x=1764728100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KMl61z9tsvm3GrPnsl3tt1vpi0kGYRETOOyBfgEWcZo=;
  b=j/hdNtaIcReJq7FPrcFo/ADKrlQRP2d8H0nhADMV1FLxTCwhIEZUO0hf
   zdBFQFmRwZSCAVhzciUtcwR86bnML0rLrsIZpmWleXxKOI7m9z1p8ncSd
   uypznVOASuo4kN58TS0XCWsnr/oBHACOq0HhShTv8Q3VpS2e0XkJSNUc8
   /q6zv/o7ZbWhVO8bFnbiWWUIDAsoQdI/wk/Z4JmWVSL5OVmzPaGC7GDaT
   jvJKxOMIqsSqTcc3aCbqbo5g4vS+6uSwCLwdZwCRMXCgiLE9v8p5Y4pnG
   5yzdFvC6wW1QgynFGvwZWQV+7cYNDNoAlU+WzE81bb+xKczRRqg5dREbg
   A==;
X-CSE-ConnectionGUID: xLP2RGa8R2WKj6GvhYP/hA==
X-CSE-MsgGUID: rPPTeThcQzuen2kHE00nqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="36242353"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="36242353"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 18:14:59 -0800
X-CSE-ConnectionGUID: OlUF1z+yR1uiRGntj/TXVQ==
X-CSE-MsgGUID: HH3AAsiUT/yQ8lvZl+QkBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93693481"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 02 Dec 2024 18:14:56 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tIIRB-0003AP-17;
	Tue, 03 Dec 2024 02:14:53 +0000
Date: Tue, 3 Dec 2024 10:14:26 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriele Monaco <gmonaco@redhat.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
Message-ID: <202412031029.B7lLh63F-lkp@intel.com>
References: <20241202140735.56368-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202140735.56368-2-gmonaco@redhat.com>

Hi Gabriele,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e70140ba0d2b1a30467d4af6bcfe761327b9ec95]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Optimise-task_mm_cid_work-duration/20241203-003033
base:   e70140ba0d2b1a30467d4af6bcfe761327b9ec95
patch link:    https://lore.kernel.org/r/20241202140735.56368-2-gmonaco%40redhat.com
patch subject: [PATCH 1/2] sched: Optimise task_mm_cid_work duration
config: arm64-randconfig-004-20241203 (https://download.01.org/0day-ci/archive/20241203/202412031029.B7lLh63F-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412031029.B7lLh63F-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412031029.B7lLh63F-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/arm64/include/asm/cacheflush.h:11:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> kernel/sched/core.c:10552:6: warning: variable 'cpu' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    10552 |         if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:10556:20: note: uninitialized use occurs here
    10556 |         for_each_cpu_from(cpu, cidmask)
          |                           ^~~
   include/linux/cpumask.h:391:24: note: expanded from macro 'for_each_cpu_from'
     391 |         for_each_set_bit_from(cpu, cpumask_bits(mask), small_cpumask_bits)
         |                               ^~~
   include/linux/find.h:605:48: note: expanded from macro 'for_each_set_bit_from'
     605 |         for (; (bit) = find_next_bit((addr), (size), (bit)), (bit) < (size); (bit)++)
         |                                                       ^~~
   kernel/sched/core.c:10552:2: note: remove the 'if' if its condition is always true
    10552 |         if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    10553 |                 return;
   kernel/sched/core.c:10529:17: note: initialize the variable 'cpu' to silence this warning
    10529 |         int weight, cpu;
          |                        ^
          |                         = 0
   kernel/sched/core.c:1809:1: warning: unused function 'uclamp_update_active' [-Wunused-function]
    1809 | uclamp_update_active(struct task_struct *p)
         | ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:6430:1: warning: unused function 'class_core_lock_lock_ptr' [-Wunused-function]
    6430 | DEFINE_LOCK_GUARD_1(core_lock, int,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6431 |                     sched_core_lock(*_T->lock, &_T->flags),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6432 |                     sched_core_unlock(*_T->lock, &_T->flags),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6433 |                     unsigned long flags)
         |                     ~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:416:49: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
     416 | __DEFINE_CLASS_IS_CONDITIONAL(_name, false);                            \
         |                                                                         ^
     417 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:392:21: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     392 | static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)     \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:63:1: note: expanded from here
      63 | class_core_lock_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings generated.


vim +10552 kernel/sched/core.c

223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10522  
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10523  static void task_mm_cid_work(struct callback_head *work)
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10524  {
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10525  	unsigned long now = jiffies, old_scan, next_scan;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10526  	struct task_struct *t = current;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10527  	struct cpumask *cidmask;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10528  	struct mm_struct *mm;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10529  	int weight, cpu;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10530  
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10531  	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10532  
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10533  	work->next = work;	/* Prevent double-add */
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10534  	if (t->flags & PF_EXITING)
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10535  		return;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10536  	mm = t->mm;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10537  	if (!mm)
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10538  		return;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10539  	old_scan = READ_ONCE(mm->mm_cid_next_scan);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10540  	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10541  	if (!old_scan) {
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10542  		unsigned long res;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10543  
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10544  		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10545  		if (res != old_scan)
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10546  			old_scan = res;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10547  		else
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10548  			old_scan = next_scan;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10549  	}
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10550  	if (time_before(now, old_scan))
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10551  		return;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20 @10552  	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10553  		return;
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10554  	cidmask = mm_cidmask(mm);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10555  	/* Clear cids that were not recently used. */
2909dedb7586e2c Gabriele Monaco   2024-12-02  10556  	for_each_cpu_from(cpu, cidmask)
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10557  		sched_mm_cid_remote_clear_old(mm, cpu);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10558  	weight = cpumask_weight(cidmask);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10559  	/*
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10560  	 * Clear cids that are greater or equal to the cidmask weight to
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10561  	 * recompact it.
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10562  	 */
2909dedb7586e2c Gabriele Monaco   2024-12-02  10563  	for_each_cpu_from(cpu, cidmask)
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10564  		sched_mm_cid_remote_clear_weight(mm, cpu, weight);
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10565  }
223baf9d17f25e2 Mathieu Desnoyers 2023-04-20  10566  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

