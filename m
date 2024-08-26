Return-Path: <linux-kernel+bounces-302196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8295FB03
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD92B2358F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E919AD48;
	Mon, 26 Aug 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SapzPU3a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502877115
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705675; cv=none; b=ooOnMf4rQxGTqmmGmUqbvKTfxOEMXtbh9Enl39a8eFSERp4Xnbozha8wkBN3k6Q8nKgy26zooDbf2Z1f8N+4GIbXl1gk0hDUNB1skOgSQ38oBRxjsB+rS8DyshRPAHMxiU0xlYzyui42DIVIiLEx1AgW9ZetxpLUA9ShyhBPAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705675; c=relaxed/simple;
	bh=k8mNDXc9hGR4inrEHobCM8WxZs+5jiR0ZCTF1MKljAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8l7NUc4653Zb/VaPKGSvVR4Av8hsMYdEYBzCkoJ4HCs5O70nNpIXeZ01HM8dP/wrg+y8Hdca5BQY98++Hwoe1s1W9uFv5Fqjb80AQ9BhxJ9aJk3krh9cb5mqxxR+ECyrCPy7PRK62wOIqdNnpWTzEPVSnMaQH00zQpTIGkYJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SapzPU3a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724705674; x=1756241674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8mNDXc9hGR4inrEHobCM8WxZs+5jiR0ZCTF1MKljAs=;
  b=SapzPU3aK3fyKUMogFS8nRHsFPMDYqMzxbiUY6lCnMnhF5jC7S/lo4wY
   1p9DHPzYg9VjcLlM1xpWXWRp43oG4FlMWrX/bixvETTdLHjJYSqUIubkF
   51ZDPez6OaVo/eSfdqqibzv0Hx8SAfYiC46WCqS8GLEfPTptEzdK1pk2W
   ffuh3Dsk32YSXWB3WNMSc9W6iLR+1qYT0S6cpCqHf3s8VHYeNf4xh8MXr
   ek4qTXOfGRLatm+4ZLQ5V1kG+SMDZ96BE0AjTeQS5L/9bQIWTmwF0GE1A
   Q4mwg8yeQfFYiI+RVdEZa4X7N8m2kQcEjYN4jZ6B0teOENvEfQcORrXaU
   A==;
X-CSE-ConnectionGUID: d5nAl8xuSiaAZw4/qHIBsw==
X-CSE-MsgGUID: wD813NTmQbuUFTUN7P1sTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23316489"
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="23316489"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2024 13:54:33 -0700
X-CSE-ConnectionGUID: rMHbSxDmQSaT0vo36GTR1Q==
X-CSE-MsgGUID: xxLRM9N0QDCGDGVQ3KiQFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,178,1719903600"; 
   d="scan'208";a="66789376"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 26 Aug 2024 13:54:29 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sigjL-000Hag-0H;
	Mon, 26 Aug 2024 20:54:27 +0000
Date: Tue, 27 Aug 2024 04:53:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ahmed Ehab <bottaawesome633@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] Refactor switch_mm_cid() to avoid unnecessary checks
Message-ID: <202408270315.58WsW5Fq-lkp@intel.com>
References: <20240824223132.11925-1-bottaawesome633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824223132.11925-1-bottaawesome633@gmail.com>

Hi Ahmed,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v6.11-rc5 next-20240826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-Ehab/Refactor-switch_mm_cid-to-avoid-unnecessary-checks/20240826-153216
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240824223132.11925-1-bottaawesome633%40gmail.com
patch subject: [PATCH] Refactor switch_mm_cid() to avoid unnecessary checks
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240827/202408270315.58WsW5Fq-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 08e5a1de8227512d4774a534b91cb2353cef6284)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408270315.58WsW5Fq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408270315.58WsW5Fq-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:10:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
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
>> kernel/sched/core.c:5232:4: error: call to undeclared function 'switch_mm_cid_from_user_to_kernel'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5232 |                         switch_mm_cid_from_user_to_kernel(rq, prev, next);
         |                         ^
>> kernel/sched/core.c:5257:4: error: call to undeclared function 'switch_mm_cid_from_kernel_to_user'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5257 |                         switch_mm_cid_from_kernel_to_user(rq, prev, next);
         |                         ^
>> kernel/sched/core.c:5259:4: error: call to undeclared function 'switch_mm_cid_from_user_to_user'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    5259 |                         switch_mm_cid_from_user_to_user(rq, prev, next);
         |                         ^
   13 warnings and 3 errors generated.


vim +/switch_mm_cid_from_user_to_kernel +5232 kernel/sched/core.c

  5199	
  5200	/*
  5201	 * context_switch - switch to the new MM and the new thread's register state.
  5202	 */
  5203	static __always_inline struct rq *
  5204	context_switch(struct rq *rq, struct task_struct *prev,
  5205		       struct task_struct *next, struct rq_flags *rf)
  5206	{
  5207		prepare_task_switch(rq, prev, next);
  5208	
  5209		/*
  5210		 * For paravirt, this is coupled with an exit in switch_to to
  5211		 * combine the page table reload and the switch backend into
  5212		 * one hypercall.
  5213		 */
  5214		arch_start_context_switch(prev);
  5215	
  5216		/*
  5217		 * kernel -> kernel   lazy + transfer active
  5218		 *   user -> kernel   lazy + mmgrab_lazy_tlb() active
  5219		 *
  5220		 * kernel ->   user   switch + mmdrop_lazy_tlb() active
  5221		 *   user ->   user   switch
  5222		 *
  5223		 * switch_mm_cid() needs to be updated if the barriers provided
  5224		 * by context_switch() are modified.
  5225		 */
  5226		if (!next->mm) {                                // to kernel
  5227			enter_lazy_tlb(prev->active_mm, next);
  5228	
  5229			next->active_mm = prev->active_mm;
  5230			if (prev->mm) {                           // from user
  5231				mmgrab_lazy_tlb(prev->active_mm);
> 5232				switch_mm_cid_from_user_to_kernel(rq, prev, next);
  5233			}
  5234			else
  5235				/*
  5236				 * kernel -> kernel transition does not change rq->curr->mm
  5237				 * state. It stays NULL.
  5238				 */
  5239				prev->active_mm = NULL;
  5240		} else {                                        // to user
  5241			membarrier_switch_mm(rq, prev->active_mm, next->mm);
  5242			/*
  5243			 * sys_membarrier() requires an smp_mb() between setting
  5244			 * rq->curr / membarrier_switch_mm() and returning to userspace.
  5245			 *
  5246			 * The below provides this either through switch_mm(), or in
  5247			 * case 'prev->active_mm == next->mm' through
  5248			 * finish_task_switch()'s mmdrop().
  5249			 */
  5250			switch_mm_irqs_off(prev->active_mm, next->mm, next);
  5251			lru_gen_use_mm(next->mm);
  5252	
  5253			if (!prev->mm) {                        // from kernel
  5254				/* will mmdrop_lazy_tlb() in finish_task_switch(). */
  5255				rq->prev_mm = prev->active_mm;
  5256				prev->active_mm = NULL;
> 5257				switch_mm_cid_from_kernel_to_user(rq, prev, next);
  5258			} else
> 5259				switch_mm_cid_from_user_to_user(rq, prev, next);
  5260		}
  5261	
  5262		prepare_lock_switch(rq, next, rf);
  5263	
  5264		/* Here we just switch the register state and the stack. */
  5265		switch_to(prev, next, prev);
  5266		barrier();
  5267	
  5268		return finish_task_switch(prev);
  5269	}
  5270	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

