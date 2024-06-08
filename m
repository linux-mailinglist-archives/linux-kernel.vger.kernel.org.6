Return-Path: <linux-kernel+bounces-207183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED86A90135B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 21:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B77B2143D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A429220B28;
	Sat,  8 Jun 2024 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XBza7czS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E781CA9C;
	Sat,  8 Jun 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717875506; cv=none; b=LkgWUfLyF1aA8Vf6IbL1G+3M2QT5GL9X2dcbE36ipJBHzHMWo4PBX1VIlmCIOcENYuUz13lFtzOnA9JxonVzkOjXjH4k7D0Agptow4gjQrhCds2OGAy8L97McIvJJNWC11prV6LkUauqmllyKro97DUawhkUXw6usg+CBYaUzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717875506; c=relaxed/simple;
	bh=6+5M3l+iYX0rwNLIVbsCYHIKns4BG4FRt49KUQknk+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDZzY7Y16S7+b+7wYmMlqF+M7/ktsDhdBylqpL6RrEE8ZgMsuYmoW9FplUdzLqiDY41pPWeqEgK+D3T7u+WYzu8BXb/KXcwEdJ0WXaOIh8vOnVXkM5y90fmv22ozX65v3OUf+pMtCIX9nYVZOa0QSvFVf0azFVyRJ5kEj1kNioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XBza7czS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717875505; x=1749411505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+5M3l+iYX0rwNLIVbsCYHIKns4BG4FRt49KUQknk+A=;
  b=XBza7czSjzm8EcOhS4oAkjTUfzqQOjWQHHWqOOE9AguehRDLBrPotZdu
   YYKd7T6+pUvDlB8fbAkC7WA+njSLwK35FOfJRocnCBWEpO9bvs9vltH0/
   1gqyYXHthTsmdxU9LvvilwyxCm1WHws7/s7dSrSYd7+0oTeNuREMCjZgD
   TxHi1FyM7O05X0fiw2pP3XnJ+5sT7pIxY9x8MgSlRpF3NGwPOxYjW9evR
   PHuCdM5V8X+sDo/XhNy+909UnShEyVkk49DhXoTQjycMmf6vF0jhqgLFd
   Ord5Ec3Jp2VobScTgL0jzAVJOMenx8ALdnLE8bigg5KQUWyO/Xpqc4DYI
   g==;
X-CSE-ConnectionGUID: G6pQRYflR3aYWvCCqmuL7g==
X-CSE-MsgGUID: QXb1Vd0qRDuvAmEN4Tjhnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14736010"
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="14736010"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 12:38:24 -0700
X-CSE-ConnectionGUID: Lo5lv0UQSBecDo1Ex9t5bQ==
X-CSE-MsgGUID: NpAjYTifTHWNdtdM+slsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,224,1712646000"; 
   d="scan'208";a="43582555"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 08 Jun 2024 12:38:18 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sG1tI-0000OI-0C;
	Sat, 08 Jun 2024 19:38:16 +0000
Date: Sun, 9 Jun 2024 03:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 3/9] perf: arm_pmu: Remove event index to counter
 remapping
Message-ID: <202406090349.DaD1utFD-lkp@intel.com>
References: <20240607-arm-pmu-3-9-icntr-v1-3-c7bd2dceff3b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607-arm-pmu-3-9-icntr-v1-3-c7bd2dceff3b@kernel.org>

Hi Rob,

kernel test robot noticed the following build errors:

[auto build test ERROR on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring-Arm/perf-arm-Move-32-bit-PMU-drivers-to-drivers-perf/20240608-043509
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240607-arm-pmu-3-9-icntr-v1-3-c7bd2dceff3b%40kernel.org
patch subject: [PATCH 3/9] perf: arm_pmu: Remove event index to counter remapping
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240609/202406090349.DaD1utFD-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240609/202406090349.DaD1utFD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406090349.DaD1utFD-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                           ^~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:27:22: note: expanded from macro 'ONLY_2_4_6'
      27 | #define ONLY_2_4_6                      (BIT(2) | BIT(4) | BIT(6))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:99:32: note: previous initialization is here
      99 |         [0 ... M1_PMU_PERFCTR_LAST]     = ANY_BUT_0_1,
         |                                           ^~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:25:23: note: expanded from macro 'ANY_BUT_0_1'
      25 | #define ANY_BUT_0_1                     GENMASK(9, 2)
         |                                         ^~~~~~~~~~~~~
   include/linux/bits.h:35:2: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:128:32: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     128 |         [M1_PMU_PERFCTR_UNKNOWN_f6]     = ONLY_2_4_6,
         |                                           ^~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:27:22: note: expanded from macro 'ONLY_2_4_6'
      27 | #define ONLY_2_4_6                      (BIT(2) | BIT(4) | BIT(6))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:99:32: note: previous initialization is here
      99 |         [0 ... M1_PMU_PERFCTR_LAST]     = ANY_BUT_0_1,
         |                                           ^~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:25:23: note: expanded from macro 'ANY_BUT_0_1'
      25 | #define ANY_BUT_0_1                     GENMASK(9, 2)
         |                                         ^~~~~~~~~~~~~
   include/linux/bits.h:35:2: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:129:32: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     129 |         [M1_PMU_PERFCTR_UNKNOWN_f7]     = ONLY_2_4_6,
         |                                           ^~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:27:22: note: expanded from macro 'ONLY_2_4_6'
      27 | #define ONLY_2_4_6                      (BIT(2) | BIT(4) | BIT(6))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:99:32: note: previous initialization is here
      99 |         [0 ... M1_PMU_PERFCTR_LAST]     = ANY_BUT_0_1,
         |                                           ^~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:25:23: note: expanded from macro 'ANY_BUT_0_1'
      25 | #define ANY_BUT_0_1                     GENMASK(9, 2)
         |                                         ^~~~~~~~~~~~~
   include/linux/bits.h:35:2: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:130:32: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     130 |         [M1_PMU_PERFCTR_UNKNOWN_f8]     = ONLY_2_TO_7,
         |                                           ^~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:26:23: note: expanded from macro 'ONLY_2_TO_7'
      26 | #define ONLY_2_TO_7                     GENMASK(7, 2)
         |                                         ^~~~~~~~~~~~~
   include/linux/bits.h:35:2: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:99:32: note: previous initialization is here
      99 |         [0 ... M1_PMU_PERFCTR_LAST]     = ANY_BUT_0_1,
         |                                           ^~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:25:23: note: expanded from macro 'ANY_BUT_0_1'
      25 | #define ANY_BUT_0_1                     GENMASK(9, 2)
         |                                         ^~~~~~~~~~~~~
   include/linux/bits.h:35:2: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:131:32: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     131 |         [M1_PMU_PERFCTR_UNKNOWN_fd]     = ONLY_2_4_6,
         |                                           ^~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:27:22: note: expanded from macro 'ONLY_2_4_6'
      27 | #define ONLY_2_4_6                      (BIT(2) | BIT(4) | BIT(6))
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:99:32: note: previous initialization is here
      99 |         [0 ... M1_PMU_PERFCTR_LAST]     = ANY_BUT_0_1,
         |                                           ^~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:25:23: note: expanded from macro 'ANY_BUT_0_1'
      25 | #define ANY_BUT_0_1                     GENMASK(9, 2)
         |                                         ^~~~~~~~~~~~~
   include/linux/bits.h:35:2: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:136:31: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     136 |         [PERF_COUNT_HW_CPU_CYCLES]      = M1_PMU_PERFCTR_CPU_CYCLES,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:135:2: note: previous initialization is here
     135 |         PERF_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:40:34: note: expanded from macro 'PERF_MAP_ALL_UNSUPPORTED'
      40 |         [0 ... PERF_COUNT_HW_MAX - 1] = HW_OP_UNSUPPORTED
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:28: note: expanded from macro 'HW_OP_UNSUPPORTED'
      35 | #define HW_OP_UNSUPPORTED               0xFFFF
         |                                         ^~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:137:33: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     137 |         [PERF_COUNT_HW_INSTRUCTIONS]    = M1_PMU_PERFCTR_INSTRUCTIONS,
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/apple_m1_cpu_pmu.c:135:2: note: previous initialization is here
     135 |         PERF_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:40:34: note: expanded from macro 'PERF_MAP_ALL_UNSUPPORTED'
      40 |         [0 ... PERF_COUNT_HW_MAX - 1] = HW_OP_UNSUPPORTED
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:35:28: note: expanded from macro 'HW_OP_UNSUPPORTED'
      35 | #define HW_OP_UNSUPPORTED               0xFFFF
         |                                         ^~~~~~
>> drivers/perf/apple_m1_cpu_pmu.c:403:31: error: no member named 'num_events' in 'struct arm_pmu'; did you mean 'hw_events'?
     403 |         for (idx = 0; idx < cpu_pmu->num_events; idx++) {
         |                                      ^~~~~~~~~~
         |                                      hw_events
   include/linux/perf/arm_pmu.h:106:33: note: 'hw_events' declared here
     106 |         struct pmu_hw_events    __percpu *hw_events;
         |                                           ^
   drivers/perf/apple_m1_cpu_pmu.c:563:11: error: no member named 'num_events' in 'struct arm_pmu'; did you mean 'hw_events'?
     563 |         cpu_pmu->num_events       = M1_PMU_NR_COUNTERS;
         |                  ^~~~~~~~~~
         |                  hw_events
   include/linux/perf/arm_pmu.h:106:33: note: 'hw_events' declared here
     106 |         struct pmu_hw_events    __percpu *hw_events;
         |                                           ^
   39 warnings and 2 errors generated.


vim +403 drivers/perf/apple_m1_cpu_pmu.c

a639027a1be1d6 Marc Zyngier 2022-02-08  381  
a639027a1be1d6 Marc Zyngier 2022-02-08  382  static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
a639027a1be1d6 Marc Zyngier 2022-02-08  383  {
a639027a1be1d6 Marc Zyngier 2022-02-08  384  	struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
a639027a1be1d6 Marc Zyngier 2022-02-08  385  	struct pt_regs *regs;
a639027a1be1d6 Marc Zyngier 2022-02-08  386  	u64 overflow, state;
a639027a1be1d6 Marc Zyngier 2022-02-08  387  	int idx;
a639027a1be1d6 Marc Zyngier 2022-02-08  388  
a639027a1be1d6 Marc Zyngier 2022-02-08  389  	overflow = read_sysreg_s(SYS_IMP_APL_PMSR_EL1);
a639027a1be1d6 Marc Zyngier 2022-02-08  390  	if (!overflow) {
a639027a1be1d6 Marc Zyngier 2022-02-08  391  		/* Spurious interrupt? */
a639027a1be1d6 Marc Zyngier 2022-02-08  392  		state = read_sysreg_s(SYS_IMP_APL_PMCR0_EL1);
a639027a1be1d6 Marc Zyngier 2022-02-08  393  		state &= ~PMCR0_IACT;
a639027a1be1d6 Marc Zyngier 2022-02-08  394  		write_sysreg_s(state, SYS_IMP_APL_PMCR0_EL1);
a639027a1be1d6 Marc Zyngier 2022-02-08  395  		isb();
a639027a1be1d6 Marc Zyngier 2022-02-08  396  		return IRQ_NONE;
a639027a1be1d6 Marc Zyngier 2022-02-08  397  	}
a639027a1be1d6 Marc Zyngier 2022-02-08  398  
a639027a1be1d6 Marc Zyngier 2022-02-08  399  	cpu_pmu->stop(cpu_pmu);
a639027a1be1d6 Marc Zyngier 2022-02-08  400  
a639027a1be1d6 Marc Zyngier 2022-02-08  401  	regs = get_irq_regs();
a639027a1be1d6 Marc Zyngier 2022-02-08  402  
a639027a1be1d6 Marc Zyngier 2022-02-08 @403  	for (idx = 0; idx < cpu_pmu->num_events; idx++) {
a639027a1be1d6 Marc Zyngier 2022-02-08  404  		struct perf_event *event = cpuc->events[idx];
a639027a1be1d6 Marc Zyngier 2022-02-08  405  		struct perf_sample_data data;
a639027a1be1d6 Marc Zyngier 2022-02-08  406  
a639027a1be1d6 Marc Zyngier 2022-02-08  407  		if (!event)
a639027a1be1d6 Marc Zyngier 2022-02-08  408  			continue;
a639027a1be1d6 Marc Zyngier 2022-02-08  409  
a639027a1be1d6 Marc Zyngier 2022-02-08  410  		armpmu_event_update(event);
a639027a1be1d6 Marc Zyngier 2022-02-08  411  		perf_sample_data_init(&data, 0, event->hw.last_period);
a639027a1be1d6 Marc Zyngier 2022-02-08  412  		if (!armpmu_event_set_period(event))
a639027a1be1d6 Marc Zyngier 2022-02-08  413  			continue;
a639027a1be1d6 Marc Zyngier 2022-02-08  414  
a639027a1be1d6 Marc Zyngier 2022-02-08  415  		if (perf_event_overflow(event, &data, regs))
a639027a1be1d6 Marc Zyngier 2022-02-08  416  			m1_pmu_disable_event(event);
a639027a1be1d6 Marc Zyngier 2022-02-08  417  	}
a639027a1be1d6 Marc Zyngier 2022-02-08  418  
a639027a1be1d6 Marc Zyngier 2022-02-08  419  	cpu_pmu->start(cpu_pmu);
a639027a1be1d6 Marc Zyngier 2022-02-08  420  
a639027a1be1d6 Marc Zyngier 2022-02-08  421  	return IRQ_HANDLED;
a639027a1be1d6 Marc Zyngier 2022-02-08  422  }
a639027a1be1d6 Marc Zyngier 2022-02-08  423  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

