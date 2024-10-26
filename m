Return-Path: <linux-kernel+bounces-383065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF19B16FB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948A9283898
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF71D1F57;
	Sat, 26 Oct 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDr6824Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B913B294
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938123; cv=none; b=L0S0myu9HwoRhC+A1Yjr3kSkGnihJAgGVqIyOv6GseyNL3wpc1nsi+dVfRr9UXH39lBC1KH+2x9VqjTDZcm/e5FtKDZdqzZRsZimP47KZqJs3mGaOHkmiN6ISPwhsG9qJbTjFo/hjVu8/sAG7rLqrorGH4DtqeiPPshXIAnwEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938123; c=relaxed/simple;
	bh=OPKuXPHv05CbANj4GSwIspH+ZPJUtxzHe4p1mP5dGuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfKU9zaeAsWeFsDyYNC0tK0tYK4tbmbybSt2Gc8RlD05P+O4GABsaA/5HxxHgziYealu2GP1vSaEB9vpgqJNGsFJa3xQM1mhc61uOZMNAwJoFpyByEHmp4cP0PK0daHDzRqCDhOgbaCmfEI+fXXWfMil8O0tpqSkvdkht6TF6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDr6824Z; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729938121; x=1761474121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OPKuXPHv05CbANj4GSwIspH+ZPJUtxzHe4p1mP5dGuY=;
  b=GDr6824Zjo+Fu88XEdDmti4+Swutopqx+9KkHZk4THT/TevHcMnioFy6
   z4CGsB0ERF4MUuys8aGxNEA4KI0yeOcoI3x6eKY96HsOEVQGzDKR36tPK
   06JHAA+S+s6VmPrgZM1iwi9mcbTa9HI5dFR9whoZ2ZE5tVcEZOSMLuTki
   t1HJ2VcnDJ1lpMCHZYBEY9Gfb/FrT7vmi1PI9adEE63EucLv2y635+fD1
   vNyqJyzGwR9cO7UHRhTdSbq50jyLLLPDQkf0ju9SROeq66wPV5O1SHf9R
   QxPkGornebSSqp0aRcWKl6QfXPH8rBZ+4tdG18ovMc1YJnvx/j2lHcPZl
   A==;
X-CSE-ConnectionGUID: jpbxWtOZQMG/lZSW0V69KQ==
X-CSE-MsgGUID: zVE7225vRymQh2lp2nTllQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29557740"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29557740"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 03:22:01 -0700
X-CSE-ConnectionGUID: SK9Ub1PSSvaVlfptiHZJig==
X-CSE-MsgGUID: ciyX6KyqRYagVEcBlNXZWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,234,1725346800"; 
   d="scan'208";a="85720390"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 26 Oct 2024 03:21:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4dve-000ZVW-1T;
	Sat, 26 Oct 2024 10:21:54 +0000
Date: Sat, 26 Oct 2024 18:21:14 +0800
From: kernel test robot <lkp@intel.com>
To: Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v4 10/18] KVM: arm64: nv: Describe trap behaviour of
 MDCR_EL2.HPMN
Message-ID: <202410261855.fvLOtls9-lkp@intel.com>
References: <20241025182354.3364124-11-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025182354.3364124-11-oliver.upton@linux.dev>

Hi Oliver,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8e929cb546ee42c9a61d24fae60605e9e3192354]

url:    https://github.com/intel-lab-lkp/linux/commits/Oliver-Upton/KVM-arm64-Extend-masking-facility-to-arbitrary-registers/20241026-023055
base:   8e929cb546ee42c9a61d24fae60605e9e3192354
patch link:    https://lore.kernel.org/r/20241025182354.3364124-11-oliver.upton%40linux.dev
patch subject: [PATCH v4 10/18] KVM: arm64: nv: Describe trap behaviour of MDCR_EL2.HPMN
config: arm64-randconfig-003-20241026 (https://download.01.org/0day-ci/archive/20241026/202410261855.fvLOtls9-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5886454669c3c9026f7f27eab13509dd0241f2d6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410261855.fvLOtls9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410261855.fvLOtls9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kvm/emulate-nested.c:8:
   In file included from include/linux/kvm_host.h:16:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/arm64/kvm/emulate-nested.c:532:35: error: too many arguments to function call, expected single argument 'vcpu', have 2 arguments
     532 |         if (kvm_pmu_counter_is_hyp(vcpu, idx))
         |             ~~~~~~~~~~~~~~~~~~~~~~       ^~~
   include/kvm/arm_pmu.h:191:20: note: 'kvm_pmu_counter_is_hyp' declared here
     191 | static inline bool kvm_pmu_counter_is_hyp(struct kvm_vcpu *vcpu)
         |                    ^                      ~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +/vcpu +532 arch/arm64/kvm/emulate-nested.c

   509	
   510	static enum trap_behaviour check_mdcr_hpmn(struct kvm_vcpu *vcpu)
   511	{
   512		u32 sysreg = esr_sys64_to_sysreg(kvm_vcpu_get_esr(vcpu));
   513		unsigned int idx;
   514	
   515	
   516		switch (sysreg) {
   517		case SYS_PMEVTYPERn_EL0(0) ... SYS_PMEVTYPERn_EL0(30):
   518		case SYS_PMEVCNTRn_EL0(0) ... SYS_PMEVCNTRn_EL0(30):
   519			idx = (sys_reg_CRm(sysreg) & 0x3) << 3 | sys_reg_Op2(sysreg);
   520			break;
   521		case SYS_PMXEVTYPER_EL0:
   522		case SYS_PMXEVCNTR_EL0:
   523			idx = SYS_FIELD_GET(PMSELR_EL0, SEL,
   524					    __vcpu_sys_reg(vcpu, PMSELR_EL0));
   525			break;
   526		default:
   527			/* Someone used this trap helper for something else... */
   528			KVM_BUG_ON(1, vcpu->kvm);
   529			return BEHAVE_HANDLE_LOCALLY;
   530		}
   531	
 > 532		if (kvm_pmu_counter_is_hyp(vcpu, idx))
   533			return BEHAVE_FORWARD_RW | BEHAVE_IN_HOST_EL0;
   534	
   535		return BEHAVE_HANDLE_LOCALLY;
   536	}
   537	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

