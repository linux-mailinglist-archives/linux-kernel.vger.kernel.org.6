Return-Path: <linux-kernel+bounces-276477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15D949451
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489FB1F22F95
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537CC8F6C;
	Tue,  6 Aug 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4zxx7M5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC5EC2E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957370; cv=none; b=R3uvbhVBZzMYBBmoVCTBPeSMQvsKExzBqDJWsljxa9dEgO5gIT4yn6UWCDlBon5yAwghAdReSlGD7tw2sH+LPZbdFuLO0xZi8sPywcjchb7IR3RCjOA9Ibu7m6RF1klwDV7txyQKym2KEwkjECy5sHJRr+2hVKw8/sso5XOcWd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957370; c=relaxed/simple;
	bh=3MlkYy6g36sLgZpc3PWyAkbXfVEleD3+rQVgjcMz2Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rROcXSJS5rjSZMPNLrhz8TVUyaJSewXqTjc4jF+jJuSd0pF2uu/NXw2PNtKXWhK76OlGz349e4FoQeuFubLykIdzQO9teX9xrSSNmXr2K84gS1W6HzPmwaomGTXjkVH9WOxkViHOuH49XwknkRyi2IGA+rWVMFAACy+l5dHXUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4zxx7M5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722957368; x=1754493368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3MlkYy6g36sLgZpc3PWyAkbXfVEleD3+rQVgjcMz2Co=;
  b=J4zxx7M55RQu3O52RYmcv6ROgfcpNksgCIn38KTnAozxyo7wYCRMWAqP
   J9hyUEaGOCg5Hd7qe4kCT8DGg9S0t2894Ov5q51M8/ZpkTMrq1Qu/9Z9u
   zzDGVRdEHCIioT+cmKoHlT7knPWImG3YCiS39X+ixcpc/+WIYCtNXMX97
   W3bt7KIRens3bVi1Td7vht/wxRsuc3yyRqtYL74LQrkZLrXhpLbE/Ps79
   o4z0mQek82cRsJgWXML8x2JdI3mLChgGS2tziz2Jf3TxK4qV0zXECbrB1
   FfgGTHxp+jv58pOlJlrGjrLipfFPmt2qeR9yVnkgU/3Wr6pwCfh+FHPoY
   g==;
X-CSE-ConnectionGUID: 92fLZJ0PSN2xEwtIgfJ+rg==
X-CSE-MsgGUID: 3KPNnTtmRDKcF3+ktM04cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20858430"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="20858430"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 08:16:07 -0700
X-CSE-ConnectionGUID: chAZ4jaIRXW3tiOcmWle4g==
X-CSE-MsgGUID: cTr0BnKSQXuSMG/bQ9gFsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56481914"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 06 Aug 2024 08:16:04 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbLus-0004bS-00;
	Tue, 06 Aug 2024 15:16:02 +0000
Date: Tue, 6 Aug 2024 23:15:16 +0800
From: kernel test robot <lkp@intel.com>
To: Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Song Liu <song@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Revert "perf: Add a counter for number of user access
 events in context"
Message-ID: <202408062245.C5TeYWiV-lkp@intel.com>
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
[also build test ERROR on tip/perf/core perf-tools/perf-tools linus/master v6.11-rc2 next-20240806]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Song-Liu/Revert-perf-Add-a-counter-for-number-of-user-access-events-in-context/20240806-071159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-tools-next
patch link:    https://lore.kernel.org/r/20240805231031.1760371-1-song%40kernel.org
patch subject: [PATCH] Revert "perf: Add a counter for number of user access events in context"
config: arm64-randconfig-001-20240806 (https://download.01.org/0day-ci/archive/20240806/202408062245.C5TeYWiV-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408062245.C5TeYWiV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408062245.C5TeYWiV-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:147:44: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     147 |         [C(DTLB)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:133:44: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD'
     133 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_RD                         0x004E
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:148:45: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     148 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:134:44: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR'
     134 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_WR                         0x004F
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:149:42: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     149 |         [C(DTLB)][C(OP_READ)][C(RESULT_MISS)]   = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:131:50: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD'
     131 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_RD                  0x004C
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:150:43: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     150 |         [C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]  = ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:132:50: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR'
     132 | #define ARMV8_IMPDEF_PERFCTR_L1D_TLB_REFILL_WR                  0x004D
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:152:44: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     152 |         [C(NODE)][C(OP_READ)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD,
         |                                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:148:46: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD'
     148 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_RD                      0x0060
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
   drivers/perf/arm_pmuv3.c:153:45: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     153 |         [C(NODE)][C(OP_WRITE)][C(RESULT_ACCESS)] = ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR,
         |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmuv3.h:149:46: note: expanded from macro 'ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR'
     149 | #define ARMV8_IMPDEF_PERFCTR_BUS_ACCESS_WR                      0x0061
         |                                                                 ^~~~~~
   drivers/perf/arm_pmuv3.c:140:2: note: previous initialization is here
     140 |         PERF_CACHE_MAP_ALL_UNSUPPORTED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:45:31: note: expanded from macro 'PERF_CACHE_MAP_ALL_UNSUPPORTED'
      45 |                 [0 ... C(RESULT_MAX) - 1] = CACHE_OP_UNSUPPORTED,       \
         |                                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/perf/arm_pmu.h:37:31: note: expanded from macro 'CACHE_OP_UNSUPPORTED'
      37 | #define CACHE_OP_UNSUPPORTED            0xFFFF
         |                                         ^~~~~~
>> drivers/perf/arm_pmuv3.c:824:18: error: no member named 'nr_user' in 'struct perf_event_context'
     824 |                 nr_user = ctx->nr_user;
         |                           ~~~  ^
   60 warnings and 1 error generated.


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

