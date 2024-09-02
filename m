Return-Path: <linux-kernel+bounces-310914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467709682CF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12541F22069
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A9F187330;
	Mon,  2 Sep 2024 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AaBSK86u"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E292D7B8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268315; cv=none; b=d/M0bcYDd77dUbOOKoFDGBb7HNbncwU9vSNauPd1lVV3MLCgfd4O475sp5SScvATpWkCDeiHzQv0HygQczXf1ZBhmwA010NGbzuVzhmN6CErDHziJoEjsZWs6QNMxmwxf7oaU0lwXlxi5M7mdYUZ7BMLIUL3Qiqarkz4X1xS2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268315; c=relaxed/simple;
	bh=hXtNIQkp9EPJtABA4D2nCiS6fBp7NbjHoI0F5+bVc+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0n0zAtuI7vjX3TrOSBPD9omiPkahDDZIDUy2oUImUIhdSANA1aHAhjIgod+wYNYFPTKc1K063+PijZexDt5YCxdF1q7wAr1E9rNcCuFmrSs4BdDCyz1qxr8NpmmvTxMOGke0cdaICJezt9K5pnauRf7U1ubd/EI+uzvXgDPtzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AaBSK86u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725268314; x=1756804314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXtNIQkp9EPJtABA4D2nCiS6fBp7NbjHoI0F5+bVc+s=;
  b=AaBSK86u+bW5jgYmKL+aE0GrpSIRsIY3Us8nX0iIrwvtIDKdBqoxOrLw
   GqT4w4GJeoW2iVXANJxcPTPdmuFyaF1W7tcC86+FFrB/lPoS/ObMVbhC3
   RYyO8SKFAzwivAE0CIO5T8pRqlewj0EdTG3f0AFV7T0Q5FndsjL4WQQ8u
   muj5z5LOJI70SMykjD45S6BkzrbPKnemExjZa3f5q8iFJF4uaqH3INa1K
   3DeuVYOJ2OjYtsnLg3IEhbpWASZME05h4Sm9W3EYeV2oiPduPnBbMPIEE
   rVUAJEEP5Gz1G2fwlv9nG2y4V3qZ6ZPv5MbC5knlcErglHXsZiTMV1yVZ
   w==;
X-CSE-ConnectionGUID: gXnyG7qpS8S/7rG1z05qYw==
X-CSE-MsgGUID: 1s+jkkBSTWOg1ITvEgcwkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="34499525"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="34499525"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 02:11:53 -0700
X-CSE-ConnectionGUID: xPH1cRnbQriwEbTgd2nBNg==
X-CSE-MsgGUID: 9ibfL99PRiqpRMnFXOniUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="68688389"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 02 Sep 2024 02:11:49 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sl36B-0005JW-0b;
	Mon, 02 Sep 2024 09:11:47 +0000
Date: Mon, 2 Sep 2024 17:11:32 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	qyousef@layalina.io, hongyan.xia2@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
Message-ID: <202409021606.CwIU0HB8-lkp@intel.com>
References: <20240830130309.2141697-4-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830130309.2141697-4-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.11-rc6 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-fair-Filter-false-overloaded_group-case-for-EAS/20240830-210826
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20240830130309.2141697-4-vincent.guittot%40linaro.org
patch subject: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of spare capacity
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240902/202409021606.CwIU0HB8-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 6f682c26b04f0b349c4c473756cb8625b4f37c6d)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240902/202409021606.CwIU0HB8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409021606.CwIU0HB8-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/fair.c:23:
   In file included from include/linux/energy_model.h:5:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/sched/fair.c:38:
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
   In file included from kernel/sched/fair.c:38:
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
   In file included from kernel/sched/fair.c:38:
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
>> kernel/sched/fair.c:8183:6: error: call to undeclared function 'em_pd_get_efficient_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    8183 |         i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
         |             ^
>> kernel/sched/fair.c:8190:6: error: call to undeclared function 'em_pd_get_previous_state'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    8190 |         i = em_pd_get_previous_state(em_table->state, pd->nr_perf_states,
         |             ^
   13 warnings and 2 errors generated.


vim +/em_pd_get_efficient_state +8183 kernel/sched/fair.c

  8168	
  8169	/* Find the cost of a performance domain for the estimated utilization */
  8170	static inline void find_pd_cost(struct em_perf_domain *pd,
  8171					unsigned long max_util,
  8172					struct energy_cpu_stat *stat)
  8173	{
  8174		struct em_perf_table *em_table;
  8175		struct em_perf_state *ps;
  8176		int i;
  8177	
  8178		/*
  8179		 * Find the lowest performance state of the Energy Model above the
  8180		 * requested performance.
  8181		 */
  8182		em_table = rcu_dereference(pd->em_table);
> 8183		i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
  8184					      max_util, pd->flags);
  8185		ps = &em_table->state[i];
  8186	
  8187		/* Save the cost and performance range of the OPP */
  8188		stat->max_perf = ps->performance;
  8189		stat->cost = ps->cost;
> 8190		i = em_pd_get_previous_state(em_table->state, pd->nr_perf_states,
  8191					      i, pd->flags);
  8192		if (i < 0)
  8193			stat->min_perf = 0;
  8194		else {
  8195			ps = &em_table->state[i];
  8196			stat->min_perf = ps->performance;
  8197		}
  8198	}
  8199	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

