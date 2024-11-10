Return-Path: <linux-kernel+bounces-403358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6309C348E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 21:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792602813C4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 20:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A2613C9C7;
	Sun, 10 Nov 2024 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEFT96Q5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599485956
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731270524; cv=none; b=b4bZucWoQu8mEfsDiuMOB90FSwxmMbBhDlAEnmVBOEm0LK40w3+khjJOXJc3bDgV/Lvy7CVT3PMIR6Y9lkCTpqSr0UmTRdqnsCu7YAy3aRG3hlX2mFA63aQyVeEKqDGzULs9RVX+dY5dXCSyHtw3qhm+u1mk0ifpSXq/WyA57DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731270524; c=relaxed/simple;
	bh=Vu6Wvi8Bl5qCK22fkhXVns86v6ZHhSFm5xGPqMVziT0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e1BhBeO8YSiwMVU321+KoK9o7yPFVbxw3GxC/K3zYv1NhR+V6IkF8vqBJ1+NXD6nLIfzs+Grai+8oyaHdZS3ABLJVw7DSAgYaNeIz9F/u/Wlf7lBTDTLHYWjiLTQIiVU1ZONOoTl9qAGtUnVimOgNWELIOJ83CkDzuTUo4dX43A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEFT96Q5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731270522; x=1762806522;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vu6Wvi8Bl5qCK22fkhXVns86v6ZHhSFm5xGPqMVziT0=;
  b=FEFT96Q55POsf5JkTPloqE5yHvNC5Z7b30wxuepmEJs+6tPrJxU3ckUE
   y5GIoClaikSmjmkztZiIKkIz1X6kSenTbpO4mKcx5mip493A0M4ErCkrj
   I6L+Uls4hjIM0pmNPQsd2SWJvBa7BIBKMms6yc7DIiiiaMFKhJ3ydccP3
   9xTB7u1SNHnU1tLla5DjfTJrUJrRZBIu2tBjrcA1E7L6cFI4+Zu+Le4G+
   1Xr1r+kjxKfRiZapigOTz7Q9R9uLo9ANUXZwlg+g4IVjbUaEl12g7o54G
   5+nvS0GQ1AXChYbZwBSYENuT0LyzBZb1vYP86tg84ENLA0+NF+UdCH/Ff
   w==;
X-CSE-ConnectionGUID: nm955ustTEqEmDUYQrE0cA==
X-CSE-MsgGUID: sTd4z7v6QYiqkyOYPRVr+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="30480861"
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; 
   d="scan'208";a="30480861"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2024 12:28:41 -0800
X-CSE-ConnectionGUID: 14NnQA2ATCyciL+iuDb+bg==
X-CSE-MsgGUID: UWSp8lbZReOuqLwwgI3ikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,143,1728975600"; 
   d="scan'208";a="87012008"
Received: from lkp-server01.sh.intel.com (HELO 7b17a4138caf) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 10 Nov 2024 12:28:40 -0800
Received: from kbuild by 7b17a4138caf with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAEY2-0000Nb-11;
	Sun, 10 Nov 2024 20:28:38 +0000
Date: Mon, 11 Nov 2024 04:27:59 +0800
From: kernel test robot <lkp@intel.com>
To: Tejun Heo <tj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/sched/ext.c:3538:31: warning: bitwise operation between
 different enumeration types ('enum scx_enq_flags' and 'enum scx_deq_flags')
Message-ID: <202411110405.iwIkOMKq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   de2f378f2b771b39594c04695feee86476743a69
commit: f0e1a0643a59bf1f922fa209cec86a170b784f3f sched_ext: Implement BPF extensible scheduler class
date:   5 months ago
config: powerpc-randconfig-r054-20241110 (https://download.01.org/0day-ci/archive/20241111/202411110405.iwIkOMKq-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241111/202411110405.iwIkOMKq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411110405.iwIkOMKq-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:25:
   In file included from include/linux/livepatch.h:13:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/powerpc/include/asm/hardirq.h:6:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/powerpc/include/asm/io.h:24:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/sched/build_policy.c:61:
   kernel/sched/ext.c:3322:35: warning: bitwise operation between different enumeration types ('enum bpf_type_flag' and 'enum bpf_reg_type') [-Wenum-enum-conversion]
    3322 |                 info->reg_type = PTR_MAYBE_NULL | PTR_TO_BTF_ID | PTR_TRUSTED;
         |                                  ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>> kernel/sched/ext.c:3538:31: warning: bitwise operation between different enumeration types ('enum scx_enq_flags' and 'enum scx_deq_flags') [-Wenum-enum-conversion]
    3538 |         WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
         |                       ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:61:18: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |                         ^~~
   include/asm-generic/rwonce.h:55:33: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |                                        ^~~
   3 warnings generated.


vim +3538 kernel/sched/ext.c

  3523	
  3524	
  3525	/********************************************************************************
  3526	 * System integration and init.
  3527	 */
  3528	
  3529	void __init init_sched_ext_class(void)
  3530	{
  3531		s32 cpu, v;
  3532	
  3533		/*
  3534		 * The following is to prevent the compiler from optimizing out the enum
  3535		 * definitions so that BPF scheduler implementations can use them
  3536		 * through the generated vmlinux.h.
  3537		 */
> 3538		WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP);
  3539	
  3540		BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
  3541		init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
  3542	#ifdef CONFIG_SMP
  3543		BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
  3544		BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
  3545	#endif
  3546		for_each_possible_cpu(cpu) {
  3547			struct rq *rq = cpu_rq(cpu);
  3548	
  3549			init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
  3550			INIT_LIST_HEAD(&rq->scx.runnable_list);
  3551		}
  3552	}
  3553	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

