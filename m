Return-Path: <linux-kernel+bounces-192133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B194F8D18E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660962860A1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393E716B75E;
	Tue, 28 May 2024 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUoSGQ9B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0AE16B737
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893397; cv=none; b=nffZA6Epns+pVa4/pALjzR3vrVrChf1oBd0k/69KqQY+4MU46hJ3ZOQtvMat9PhJjP8fhB0QuIs9UTylDJD2YPHudiNIcCPOkgaMktnvsAIWM1z0J493Qs7HoLa0qRj4U873wcnhx8hMpn0l2jAIkTQrd1IJvw21hex5erNZb0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893397; c=relaxed/simple;
	bh=NQVyfvT3+xs9K7aV7Kae69b9wNOZIjylKNJp7S42FZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8RbFj3auOit+3wIi/sRbHfzWhFnIkAtuCO/Y78RzzJjt3FmGq+HNv7s3wAfnnyD+lkTyRRWBO/FPHaox1GdDOn4gT7iNE24Iy60kfGafGdYAhOS4agRxAdPRKFbvcVkgRJK4zraln7gsJWBjxiDBTQnNcAQqY6jX9Dmdf+Ya1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUoSGQ9B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716893395; x=1748429395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NQVyfvT3+xs9K7aV7Kae69b9wNOZIjylKNJp7S42FZI=;
  b=nUoSGQ9BXqkSSwcRIogsydBjm98evyoFuh2p+Lel9saaFuSyZUJ1fbSg
   10GxeHkaK2crnu7NVv7Y82vbMQabklmVe9W0ZC0R8BSGGRpgO4b+I8E5G
   DPmXc8cxFkkhZmd3pJ+VzC/84giEzoQlrpdDhTobfqycwebkvG0fuH/Ky
   z5RxKI/q5PpPBsSnhKnvzx5qvd6P9IAzNxlCnNjUcDSWIY1OelpBm/RV9
   hKdWo/Pb2vtbRlhUfLQcS+d242a1hjcQXmeZ2rTuljGBcCHfa+ewqdRL2
   Z3XJgT7jMomC14Z/Ci+2EVPG7qvORfmAbHbOvz9Gb8v/OqkAP6z0v73Zj
   Q==;
X-CSE-ConnectionGUID: Gky2+p1/QkWd72zlzRT41g==
X-CSE-MsgGUID: yiUxvu/KRNiwMpawqOWmHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="11725378"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="11725378"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 03:49:53 -0700
X-CSE-ConnectionGUID: 14RiTfsJTm+8sEamLaprsg==
X-CSE-MsgGUID: FXrMOLJTSli166LS5KVPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="39999188"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 28 May 2024 03:49:49 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sBuOo-000C4Z-0d;
	Tue, 28 May 2024 10:49:46 +0000
Date: Tue, 28 May 2024 18:49:20 +0800
From: kernel test robot <lkp@intel.com>
To: Li zeming <zeming@nfschina.com>, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: Re: [PATCH] sched: core: =?utf-8?Q?Remove_?=
 =?utf-8?B?dW5uZWNlc3Nhcnkg4oCYTlVMTOKAmQ==?= values from core_rq
Message-ID: <202405281844.8oxr5i5s-lkp@intel.com>
References: <20240528071446.59197-1-zeming@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528071446.59197-1-zeming@nfschina.com>

Hi Li,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on peterz-queue/sched/core linus/master v6.10-rc1 next-20240528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-zeming/sched-core-Remove-unnecessary-NULL-values-from-core_rq/20240528-152109
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240528071446.59197-1-zeming%40nfschina.com
patch subject: [PATCH] sched: core: Remove unnecessary ‘NULL’ values from core_rq
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240528/202405281844.8oxr5i5s-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240528/202405281844.8oxr5i5s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405281844.8oxr5i5s-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from kernel/sched/core.c:34:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from kernel/sched/core.c:34:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from kernel/sched/core.c:34:
   In file included from include/linux/sched/isolation.h:7:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/sched/core.c:6288:2: warning: variable 'core_rq' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
    6288 |         for_each_cpu(t, smt_mask) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:300:2: note: expanded from macro 'for_each_cpu'
     300 |         for_each_set_bit(cpu, cpumask_bits(mask), small_cpumask_bits)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/find.h:586:18: note: expanded from macro 'for_each_set_bit'
     586 |         for ((bit) = 0; (bit) = find_next_bit((addr), (size), (bit)), (bit) < (size); (bit)++)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:6295:20: note: uninitialized use occurs here
    6295 |         if (WARN_ON_ONCE(!core_rq)) /* impossible */
         |                           ^~~~~~~
   include/asm-generic/bug.h:111:25: note: expanded from macro 'WARN_ON_ONCE'
     111 |         int __ret_warn_on = !!(condition);                      \
         |                                ^~~~~~~~~
   kernel/sched/core.c:6288:2: note: remove the condition if it is always true
    6288 |         for_each_cpu(t, smt_mask) {
         |         ^
   include/linux/cpumask.h:300:2: note: expanded from macro 'for_each_cpu'
     300 |         for_each_set_bit(cpu, cpumask_bits(mask), small_cpumask_bits)
         |         ^
   include/linux/find.h:586:18: note: expanded from macro 'for_each_set_bit'
     586 |         for ((bit) = 0; (bit) = find_next_bit((addr), (size), (bit)), (bit) < (size); (bit)++)
         |                         ^
   kernel/sched/core.c:6272:39: note: initialize the variable 'core_rq' to silence this warning
    6272 |         struct rq *rq = cpu_rq(cpu), *core_rq;
         |                                              ^
         |                                               = NULL
   kernel/sched/core.c:6225:1: warning: unused function 'class_core_lock_lock_ptr' [-Wunused-function]
    6225 | DEFINE_LOCK_GUARD_1(core_lock, int,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6226 |                     sched_core_lock(*_T->lock, &_T->flags),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6227 |                     sched_core_unlock(*_T->lock, &_T->flags),
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    6228 |                     unsigned long flags)
         |                     ~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:232:65: note: expanded from macro 'DEFINE_LOCK_GUARD_1'
     232 | #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)          \
         |                                                                         ^
     233 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
         | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:209:21: note: expanded from macro '\
   __DEFINE_UNLOCK_GUARD'
     209 | static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)     \
         |                     ^~~~~~~~~~~~~~~~~~~~~~~~
   <scratch space>:76:1: note: expanded from here
      76 | class_core_lock_lock_ptr
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   19 warnings generated.


vim +6288 kernel/sched/core.c

3c474b3239f12f Peter Zijlstra 2021-08-19  6268  
3c474b3239f12f Peter Zijlstra 2021-08-19  6269  static void sched_core_cpu_deactivate(unsigned int cpu)
3c474b3239f12f Peter Zijlstra 2021-08-19  6270  {
3c474b3239f12f Peter Zijlstra 2021-08-19  6271  	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
ca27ccef75e13e Li zeming      2024-05-28  6272  	struct rq *rq = cpu_rq(cpu), *core_rq;
3c474b3239f12f Peter Zijlstra 2021-08-19  6273  	int t;
3c474b3239f12f Peter Zijlstra 2021-08-19  6274  
7170509cadbb76 Peter Zijlstra 2023-08-01  6275  	guard(core_lock)(&cpu);
3c474b3239f12f Peter Zijlstra 2021-08-19  6276  
3c474b3239f12f Peter Zijlstra 2021-08-19  6277  	/* if we're the last man standing, nothing to do */
3c474b3239f12f Peter Zijlstra 2021-08-19  6278  	if (cpumask_weight(smt_mask) == 1) {
3c474b3239f12f Peter Zijlstra 2021-08-19  6279  		WARN_ON_ONCE(rq->core != rq);
7170509cadbb76 Peter Zijlstra 2023-08-01  6280  		return;
9edeaea1bc4523 Peter Zijlstra 2020-11-17  6281  	}
3c474b3239f12f Peter Zijlstra 2021-08-19  6282  
3c474b3239f12f Peter Zijlstra 2021-08-19  6283  	/* if we're not the leader, nothing to do */
3c474b3239f12f Peter Zijlstra 2021-08-19  6284  	if (rq->core != rq)
7170509cadbb76 Peter Zijlstra 2023-08-01  6285  		return;
3c474b3239f12f Peter Zijlstra 2021-08-19  6286  
3c474b3239f12f Peter Zijlstra 2021-08-19  6287  	/* find a new leader */
3c474b3239f12f Peter Zijlstra 2021-08-19 @6288  	for_each_cpu(t, smt_mask) {
3c474b3239f12f Peter Zijlstra 2021-08-19  6289  		if (t == cpu)
3c474b3239f12f Peter Zijlstra 2021-08-19  6290  			continue;
3c474b3239f12f Peter Zijlstra 2021-08-19  6291  		core_rq = cpu_rq(t);
3c474b3239f12f Peter Zijlstra 2021-08-19  6292  		break;
9edeaea1bc4523 Peter Zijlstra 2020-11-17  6293  	}
3c474b3239f12f Peter Zijlstra 2021-08-19  6294  
3c474b3239f12f Peter Zijlstra 2021-08-19  6295  	if (WARN_ON_ONCE(!core_rq)) /* impossible */
7170509cadbb76 Peter Zijlstra 2023-08-01  6296  		return;
3c474b3239f12f Peter Zijlstra 2021-08-19  6297  
3c474b3239f12f Peter Zijlstra 2021-08-19  6298  	/* copy the shared state to the new leader */
3c474b3239f12f Peter Zijlstra 2021-08-19  6299  	core_rq->core_task_seq             = rq->core_task_seq;
3c474b3239f12f Peter Zijlstra 2021-08-19  6300  	core_rq->core_pick_seq             = rq->core_pick_seq;
3c474b3239f12f Peter Zijlstra 2021-08-19  6301  	core_rq->core_cookie               = rq->core_cookie;
4feee7d12603de Josh Don       2021-10-18  6302  	core_rq->core_forceidle_count      = rq->core_forceidle_count;
3c474b3239f12f Peter Zijlstra 2021-08-19  6303  	core_rq->core_forceidle_seq        = rq->core_forceidle_seq;
4feee7d12603de Josh Don       2021-10-18  6304  	core_rq->core_forceidle_occupation = rq->core_forceidle_occupation;
4feee7d12603de Josh Don       2021-10-18  6305  
4feee7d12603de Josh Don       2021-10-18  6306  	/*
4feee7d12603de Josh Don       2021-10-18  6307  	 * Accounting edge for forced idle is handled in pick_next_task().
4feee7d12603de Josh Don       2021-10-18  6308  	 * Don't need another one here, since the hotplug thread shouldn't
4feee7d12603de Josh Don       2021-10-18  6309  	 * have a cookie.
4feee7d12603de Josh Don       2021-10-18  6310  	 */
4feee7d12603de Josh Don       2021-10-18  6311  	core_rq->core_forceidle_start = 0;
3c474b3239f12f Peter Zijlstra 2021-08-19  6312  
3c474b3239f12f Peter Zijlstra 2021-08-19  6313  	/* install new leader */
3c474b3239f12f Peter Zijlstra 2021-08-19  6314  	for_each_cpu(t, smt_mask) {
3c474b3239f12f Peter Zijlstra 2021-08-19  6315  		rq = cpu_rq(t);
3c474b3239f12f Peter Zijlstra 2021-08-19  6316  		rq->core = core_rq;
3c474b3239f12f Peter Zijlstra 2021-08-19  6317  	}
3c474b3239f12f Peter Zijlstra 2021-08-19  6318  }
3c474b3239f12f Peter Zijlstra 2021-08-19  6319  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

