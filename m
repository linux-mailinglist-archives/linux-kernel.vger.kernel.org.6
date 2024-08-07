Return-Path: <linux-kernel+bounces-278324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E29694AEC3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B89B26CAD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EE01A269;
	Wed,  7 Aug 2024 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXJfc71E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749A12C475
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050928; cv=none; b=Urh3m5HAOBQCFGfHvwSh0TfWp33ItWcK757UV7RJuiT0ogkQg5odLmeQSNsRXdvWQIAv3EKEj2RdL/sBtPoAwWRew9xzuOmzEOLSa6LoSdMj62umzItvzMEqL/5l8QAzuR/YqDDfkn0oShqCBfuprryZwFT6DILTmVuSSxAJLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050928; c=relaxed/simple;
	bh=fszI7QlepLjFNPIgYHFreWQ7b6Io6yQMNhn5Ot41fDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EenLioYxQj/TRScnqO7mYvxhegwfXhDYZbo25S50DIV9Xy9QbO+fb1sw2uNuahnZyA+otUlg9KOm/tTzHqJxZgI7CxMiMaqH/0iro7EtqqYuePiifv9IDPf0YqNzacaLSOhEx3Ypspo8DBuMawpCsOysn8llqcdrzgTuik3SBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXJfc71E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723050926; x=1754586926;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fszI7QlepLjFNPIgYHFreWQ7b6Io6yQMNhn5Ot41fDQ=;
  b=YXJfc71E0lDfLqa/vBMNk8Dim99KnqKMonsaj/3IkhOOMZXJaEtqVmMm
   jBQ1M/oDuZad6Wq96GOb4H7Jx+5i0olciOhy+nPSJazYXeTpphzQECp1e
   BLGNabBcjwRxVLHuBKrAKlvIc8aQq5db6T+iW/iVpZYnsqDX6dimSXKJm
   lttsIoApUVcAJ0l0cVfw//PgpHBzss9Uz5eBc7YOJ6K0V5QiBKr330dwV
   ZOolIVSfRYXKYXe7sYBAVSLMyYQj7GsyKYji2f4nI+z/OJ+h7e7AKDgFK
   pghlZYr252hTfUxiWDQIo6qFxWqNP/ij9x7x6iNosJLBn9LFEcaa+fUFt
   Q==;
X-CSE-ConnectionGUID: TyUfBgG3TEih7Aw3CK090w==
X-CSE-MsgGUID: DOZxhMyKQ1CmEDEx+SaLNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21016437"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="21016437"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 10:12:08 -0700
X-CSE-ConnectionGUID: kbnkBJCJQqq3NsK0MoCekg==
X-CSE-MsgGUID: C0PFM1jUSGy8/z4nUgK1Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="61034732"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2024 10:12:05 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbkCh-0005as-0H;
	Wed, 07 Aug 2024 17:12:03 +0000
Date: Thu, 8 Aug 2024 01:11:33 +0800
From: kernel test robot <lkp@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>, peterz@infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Bin Lai <laib2@chinatelecom.cn>
Subject: Re: [PATCH next] sched: make printk safe when rq lock is held
Message-ID: <202408080033.hGD8Z1m1-lkp@intel.com>
References: <20240806074131.36007-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806074131.36007-1-dongml2@chinatelecom.cn>

Hi Menglong,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240806]

url:    https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/sched-make-printk-safe-when-rq-lock-is-held/20240806-155153
base:   next-20240806
patch link:    https://lore.kernel.org/r/20240806074131.36007-1-dongml2%40chinatelecom.cn
patch subject: [PATCH next] sched: make printk safe when rq lock is held
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20240808/202408080033.hGD8Z1m1-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240808/202408080033.hGD8Z1m1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080033.hGD8Z1m1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from kernel/sched/core.c:10:
   In file included from include/linux/highmem.h:12:
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
   In file included from kernel/sched/core.c:88:
>> kernel/sched/sched.h:1705:2: error: call to undeclared function '__printk_safe_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1705 |         __printk_safe_enter();
         |         ^
   kernel/sched/sched.h:1705:2: note: did you mean '__printk_deferred_enter'?
   include/linux/printk.h:166:13: note: '__printk_deferred_enter' declared here
     166 | extern void __printk_deferred_enter(void);
         |             ^
   In file included from kernel/sched/core.c:88:
>> kernel/sched/sched.h:1722:2: error: call to undeclared function '__printk_safe_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1722 |         __printk_safe_exit();
         |         ^
   kernel/sched/sched.h:1722:2: note: did you mean '__printk_ratelimit'?
   include/linux/printk.h:182:12: note: '__printk_ratelimit' declared here
     182 | extern int __printk_ratelimit(const char *func);
         |            ^
   12 warnings and 2 errors generated.


vim +/__printk_safe_enter +1705 kernel/sched/sched.h

  1690	
  1691	/*
  1692	 * Lockdep annotation that avoids accidental unlocks; it's like a
  1693	 * sticky/continuous lockdep_assert_held().
  1694	 *
  1695	 * This avoids code that has access to 'struct rq *rq' (basically everything in
  1696	 * the scheduler) from accidentally unlocking the rq if they do not also have a
  1697	 * copy of the (on-stack) 'struct rq_flags rf'.
  1698	 *
  1699	 * Also see Documentation/locking/lockdep-design.rst.
  1700	 */
  1701	static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
  1702	{
  1703		rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
  1704	
> 1705		__printk_safe_enter();
  1706	#ifdef CONFIG_SCHED_DEBUG
  1707		rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
  1708		rf->clock_update_flags = 0;
  1709	# ifdef CONFIG_SMP
  1710		SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
  1711	# endif
  1712	#endif
  1713	}
  1714	
  1715	static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
  1716	{
  1717	#ifdef CONFIG_SCHED_DEBUG
  1718		if (rq->clock_update_flags > RQCF_ACT_SKIP)
  1719			rf->clock_update_flags = RQCF_UPDATED;
  1720	#endif
  1721	
> 1722		__printk_safe_exit();
  1723		lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
  1724	}
  1725	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

