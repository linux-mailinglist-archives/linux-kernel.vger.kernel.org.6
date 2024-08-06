Return-Path: <linux-kernel+bounces-276273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B4E9491AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1169CB2B63C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311531D47A6;
	Tue,  6 Aug 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ghrpg4DT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603931D4177
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950957; cv=none; b=R/hIPlqvs+74D4wyNi1lC7TxBcA39jjs3SsiSODHSdHeegrGLtnuRvk2ItGqv2n2iqx4mdtc0i7BSSp/IdjkNtm3IPS6l4twuLT3GAVMPCI5UgbLkNs9nWH0vNL/URi7ld0im9AGucnkJcnmgjM82yNUmAOHh1lEeD0Xcs8gqIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950957; c=relaxed/simple;
	bh=egsT4tWrawJLMgUHsvGMd/FliqOc2xoH9BVEdCJCgqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6DGBQbljN+UtEKtk7PtDP19/EiaSffI2agbiMaOM0T7ABPyl6a0PQSub7/bsdfD97mVwsWSKLjHX6wKjqwu7TdDijBb/wHg3HCxWFvgs8hkopgnCiqJndyIM3GVqS6hioI7tGNzDbkriAx6fQ9haz+XkiC/YrjoWeoj9vjRiU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ghrpg4DT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722950954; x=1754486954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=egsT4tWrawJLMgUHsvGMd/FliqOc2xoH9BVEdCJCgqk=;
  b=Ghrpg4DTs78tckBoSV937Br3U9SvaVCz90Q+yFsAI65b9jDiNKnYJ26j
   R37QaF3u4DQBrKs6ReMnIu32jQ/pFo85ulft5j+XP5sK/V5QA8vMRjCRK
   nCCUMbbOXidn3li49rE4j8gEYDnak9FSUiyMIJsU7E0A72/PLtRJOo35S
   TyQ4QzsiCLLnPpK4mrBvNFZUEU4RRiU57uaMWHsi/aR5PwNO6e+I4CTFw
   mzaUC6V5SLG1ZOwhDNZgGYf5unQl7kbfN04QyVodGJ1Z9Q0Xf8UCs4536
   Sj8GzY0GljQ4DTe98vpWNnFn7UShVizIKVlSjuJk+Z/vTJPhrb1NlkUrr
   A==;
X-CSE-ConnectionGUID: D7kGNIjiT+Os9hRAQqcJGg==
X-CSE-MsgGUID: 1u3FKPT/TGuoGF+Ct5EPXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="32118565"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="32118565"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:29:14 -0700
X-CSE-ConnectionGUID: vnjnF0C5SC6xxcCUqrBqSA==
X-CSE-MsgGUID: GlRW3A2dTOmik1gO+pE4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="87149171"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Aug 2024 06:29:10 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbKFQ-0004Vc-0j;
	Tue, 06 Aug 2024 13:29:08 +0000
Date: Tue, 6 Aug 2024 21:28:22 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Song Liu <song@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Revert "perf: Add a counter for number of user access
 events in context"
Message-ID: <202408062155.HzTfUKBa-lkp@intel.com>
References: <20240805231031.1760371-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805231031.1760371-1-song@kernel.org>

Hi Song,

kernel test robot noticed the following build errors:

[auto build test ERROR on perf-tools-next/perf-tools-next]
[also build test ERROR on tip/perf/core perf-tools/perf-tools acme/perf/core linus/master v6.11-rc2 next-20240806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/Revert-perf-Add-a-counter-for-number-of-user-access-events-in-context/20240806-071159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240805231031.1760371-1-song%40kernel.org
patch subject: [PATCH] Revert "perf: Add a counter for number of user access events in context"
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20240806/202408062155.HzTfUKBa-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408062155.HzTfUKBa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408062155.HzTfUKBa-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/perf/arm_pmuv3.c:143:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD'
     143 |         [C(L1D)][C(OP_READ)][C(RESULT_MISS)]    = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:122:65: warning: initialized field overwritten [-Woverride-init]
     122 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR                       0x0041
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:144:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR'
     144 |         [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:122:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[0][1][0]')
     122 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR                       0x0041
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:144:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR'
     144 |         [C(L1D)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:124:65: warning: initialized field overwritten [-Woverride-init]
     124 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR                0x0043
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:145:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR'
     145 |         [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:124:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[0][1][1]')
     124 | #define ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR                0x0043
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:145:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR'
     145 |         [C(L1D)][C(OP_WRITE)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_CACHE_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:65: warning: initialized field overwritten [-Woverride-init]
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD                         0x004E
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:147:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     147 |         [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][0][0]')
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD                         0x004E
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:147:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     147 |         [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:65: warning: initialized field overwritten [-Woverride-init]
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR                         0x004F
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:148:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     148 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][1][0]')
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR                         0x004F
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:148:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     148 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:131:65: warning: initialized field overwritten [-Woverride-init]
     131 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD                  0x004C
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:149:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     149 |         [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:131:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][0][1]')
     131 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD                  0x004C
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:149:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     149 |         [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:65: warning: initialized field overwritten [-Woverride-init]
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR                  0x004D
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:150:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     150 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[3][1][1]')
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR                  0x004D
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:150:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     150 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:148:65: warning: initialized field overwritten [-Woverride-init]
     148 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD                      0x0060
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:152:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     152 |         [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:148:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[6][0][0]')
     148 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD                      0x0060
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:152:51: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     152 |         [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:65: warning: initialized field overwritten [-Woverride-init]
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR                      0x0061
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:153:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     153 |         [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:65: note: (near initialization for 'armv8_vulcan_perf_cache_map[6][1][0]')
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR                      0x0061
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:153:52: note: in expansion of macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     153 |         [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/perf/arm_pmuv3.c: In function 'armv8pmu_start':
>> drivers/perf/arm_pmuv3.c:824:30: error: 'struct perf_event_context' has no member named 'nr_user'
     824 |                 nr_user = ctx->nr_user;
         |                              ^~


vim +824 drivers/perf/arm_pmuv3.c

030896885ade0a arch/arm64/kernel/perf_event.c Will Deacon      2012-03-05  816  
3cce50dfec4a5b arch/arm64/kernel/perf_event.c Suzuki K Poulose 2018-07-10  817  static void armv8pmu_start(struct arm_pmu *cpu_pmu)
3cce50dfec4a5b arch/arm64/kernel/perf_event.c Suzuki K Poulose 2018-07-10  818  {
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08  819  	struct perf_event_context *ctx;
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08  820  	int nr_user = 0;
83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring      2021-12-08  821  
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08  822  	ctx = perf_cpu_task_ctx();
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08  823  	if (ctx)
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08 @824  		nr_user = ctx->nr_user;
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08  825  
bd27568117664b arch/arm64/kernel/perf_event.c Peter Zijlstra   2022-10-08  826  	if (sysctl_perf_user_access && nr_user)
83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring      2021-12-08  827  		armv8pmu_enable_user_access(cpu_pmu);
83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring      2021-12-08  828  	else
83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring      2021-12-08  829  		armv8pmu_disable_user_access();
83a7a4d643d33a arch/arm64/kernel/perf_event.c Rob Herring      2021-12-08  830  
3cce50dfec4a5b arch/arm64/kernel/perf_event.c Suzuki K Poulose 2018-07-10  831  	/* Enable all counters */
3cce50dfec4a5b arch/arm64/kernel/perf_event.c Suzuki K Poulose 2018-07-10  832  	armv8pmu_pmcr_write(armv8pmu_pmcr_read() | ARMV8_PMU_PMCR_E);
b1f778a223a2a8 drivers/perf/arm_pmuv3.c       Marc Zyngier     2023-08-20  833  
b1f778a223a2a8 drivers/perf/arm_pmuv3.c       Marc Zyngier     2023-08-20  834  	kvm_vcpu_pmu_resync_el0();
3cce50dfec4a5b arch/arm64/kernel/perf_event.c Suzuki K Poulose 2018-07-10  835  }
3cce50dfec4a5b arch/arm64/kernel/perf_event.c Suzuki K Poulose 2018-07-10  836  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

