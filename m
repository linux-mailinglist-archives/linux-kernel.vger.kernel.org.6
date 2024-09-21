Return-Path: <linux-kernel+bounces-334865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A626397DD82
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91FDB215FC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E5322094;
	Sat, 21 Sep 2024 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avc0KRfN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81CF61FCF
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726931636; cv=none; b=qwAMGanTVLYNZPiSLdUbBWNkTR/0Q6E03ycEkMxZk6rwxDJGYQnVrysN3BQV5HFpug7lZcQwQ1mv+sKeapoyvwNBN/V8gsbrMgnjeLX63/GjvrOsg8UKZnXz9qEibg5NQawg95MzaAD2nFctuTcLvXARyEYLQWoGpD3HLwlGcaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726931636; c=relaxed/simple;
	bh=2mvmAsDhjw94BxGK+je+AWFPlN5hex4sGj1XTE+7CsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8W6Iywl7Wg1DntW7fwgZzbucQR303JpmJfohXB5DTuQKdHO/6m0Yx/N86uyri1/az1PCZZ0IMaPNYbn0Ad+PYRn+T0ZrTxaOugvt26Boa8tX2oK/JGQGvnD5yRQtTDyXm8BcAWttd7YR7nSyi9Ngf0+EDt+MMUYUaN62JFmDeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avc0KRfN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726931635; x=1758467635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2mvmAsDhjw94BxGK+je+AWFPlN5hex4sGj1XTE+7CsQ=;
  b=avc0KRfNOCs8VQVH5pPgne917I7salfPESjYCegtmFA+758FpW4QphBj
   eEPU0c+FJevYb4Yml0HqpWATtMyXBuJ3Wiy1HMkaww343k7+DTpA7VRPB
   4zn0DDa2ZozVkjTHcm1/6C+uSnqxG95IVlPudrYko50VHjhR/G3GgaVwv
   952DSbniIXfU1DCtMsiWjXZHiUHOlWS04053Vtt/7jIwxI4Fx098bqC9a
   hz/NiXHclWOiL3NEAMtL0LIoN/RjYuDCtGbLzM7BaieuIrSVNlrQZ53nw
   dOgHfMz3e87yWoHpsLavlajfYD33ty07+/R3nvn2GfdUL83i2YWmR7GZl
   w==;
X-CSE-ConnectionGUID: Yk/e2Q0WTDm/jYoWlRiy4Q==
X-CSE-MsgGUID: Du0CifHaQxuorHbT5Ma0tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="29822887"
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="29822887"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2024 08:13:54 -0700
X-CSE-ConnectionGUID: 10Di6NRpQ3a+epsLBRcunQ==
X-CSE-MsgGUID: cI3tRGQGSNSEHQvglLd99A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,247,1719903600"; 
   d="scan'208";a="70605739"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 21 Sep 2024 08:13:52 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ss1nx-000FWf-3C;
	Sat, 21 Sep 2024 15:13:49 +0000
Date: Sat, 21 Sep 2024 23:13:11 +0800
From: kernel test robot <lkp@intel.com>
To: Steven Davis <goldside000@outlook.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Steven Davis <goldside000@outlook.com>
Subject: Re: [PATCH] irq_work: Improve CPU Responsiveness in irq_work_sync
 with cond_resched()
Message-ID: <202409212247.nX8LW3Px-lkp@intel.com>
References: <SJ2P223MB10263844181902531B671FB6F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2P223MB10263844181902531B671FB6F7622@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>

Hi Steven,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.11 next-20240920]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Davis/irq_work-Improve-CPU-Responsiveness-in-irq_work_sync-with-cond_resched/20240918-232606
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/SJ2P223MB10263844181902531B671FB6F7622%40SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM
patch subject: [PATCH] irq_work: Improve CPU Responsiveness in irq_work_sync with cond_resched()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240921/202409212247.nX8LW3Px-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409212247.nX8LW3Px-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409212247.nX8LW3Px-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/irq_work.c:14:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/irq_work.c:14:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/irq_work.c:14:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
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
>> kernel/irq_work.c:312:1: error: function definition is not allowed here
     312 | {
         | ^
   kernel/irq_work.c:317:1: error: function definition is not allowed here
     317 | {
         | ^
>> kernel/irq_work.c:323:13: error: use of undeclared identifier 'irq_workd_setup'
     323 |         .setup                  = irq_workd_setup,
         |                                   ^
>> kernel/irq_work.c:325:28: error: use of undeclared identifier 'run_irq_workd'
     325 |         .thread_fn              = run_irq_workd,
         |                                   ^
   kernel/irq_work.c:330:1: error: function definition is not allowed here
     330 | {
         | ^
>> kernel/irq_work.c:335:16: error: use of undeclared identifier 'irq_work_init_threads'; did you mean 'irqwork_threads'?
     335 | early_initcall(irq_work_init_threads);
         |                ^~~~~~~~~~~~~~~~~~~~~
         |                irqwork_threads
   include/linux/init.h:289:47: note: expanded from macro 'early_initcall'
     289 | #define early_initcall(fn)              __define_initcall(fn, early)
         |                                                           ^
   include/linux/init.h:282:54: note: expanded from macro '__define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                                      ^
   include/linux/init.h:280:20: note: expanded from macro '___define_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |                           ^
   include/linux/init.h:274:22: note: expanded from macro '__unique_initcall'
     274 |         ____define_initcall(fn,                                 \
         |                             ^
   include/linux/init.h:270:41: note: expanded from macro '____define_initcall'
     270 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ^
   kernel/irq_work.c:321:34: note: 'irqwork_threads' declared here
     321 | static struct smp_hotplug_thread irqwork_threads = {
         |                                  ^
>> kernel/irq_work.c:335:1: error: initializing 'initcall_t' (aka 'int (*)(void)') with an expression of incompatible type 'struct smp_hotplug_thread'
     335 | early_initcall(irq_work_init_threads);
         | ^              ~~~~~~~~~~~~~~~~~~~~~
   include/linux/init.h:289:29: note: expanded from macro 'early_initcall'
     289 | #define early_initcall(fn)              __define_initcall(fn, early)
         |                                         ^                 ~~
   include/linux/init.h:282:35: note: expanded from macro '__define_initcall'
     282 | #define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
         |                                   ^                  ~~
   include/linux/init.h:280:2: note: expanded from macro '___define_initcall'
     280 |         __unique_initcall(fn, id, __sec, __initcall_id(fn))
         |         ^                 ~~
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:83:23: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                       ^
   <scratch space>:69:1: note: expanded from here
      69 | __initcall__kmod_irq_work__193_335_irq_work_init_threadsearly
         | ^
   include/linux/init.h:269:20: note: expanded from macro '____define_initcall'
     269 |         static initcall_t __name __used                         \
         |                           ^
     270 |                 __attribute__((__section__(__sec))) = fn;
         |                                                       ~~
>> kernel/irq_work.c:335:39: error: expected '}'
     335 | early_initcall(irq_work_init_threads);
         |                                       ^
   kernel/irq_work.c:287:1: note: to match this '{'
     287 | {
         | ^
   12 warnings and 8 errors generated.


vim +312 kernel/irq_work.c

b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  310  
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  311  static void run_irq_workd(unsigned int cpu)
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07 @312  {
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  313  	irq_work_run_list(this_cpu_ptr(&lazy_list));
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  314  }
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  315  
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  316  static void irq_workd_setup(unsigned int cpu)
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  317  {
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  318  	sched_set_fifo_low(current);
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  319  }
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  320  
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07 @321  static struct smp_hotplug_thread irqwork_threads = {
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  322  	.store                  = &irq_workd,
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07 @323  	.setup			= irq_workd_setup,
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  324  	.thread_should_run      = irq_workd_should_run,
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07 @325  	.thread_fn              = run_irq_workd,
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  326  	.thread_comm            = "irq_work/%u",
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  327  };
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  328  
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  329  static __init int irq_work_init_threads(void)
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  330  {
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  331  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  332  		BUG_ON(smpboot_register_percpu_thread(&irqwork_threads));
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  333  	return 0;
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07  334  }
b4c6f86ec2f648 Sebastian Andrzej Siewior 2021-10-07 @335  early_initcall(irq_work_init_threads);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

