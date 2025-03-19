Return-Path: <linux-kernel+bounces-568362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EEDA69475
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559351899B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 16:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084E91DE2B9;
	Wed, 19 Mar 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBPr9yfT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5855D16F8F5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742400624; cv=none; b=baYfiEhn0YI2FDdr/CJveCfvi2yoTTAlUpts8zeJu2xfN0r4NHfNNACUtjbeQWinfq4gqqL+7QcjkNP7YB7DTHL5F2/41bPap9UPcCsGq6K5iXqS9RxbMv0bT7mE78OqSqe4MidPhA7vLDR+s5mm0OJnJKr4+ny/dDcnTZpibK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742400624; c=relaxed/simple;
	bh=jg3rCi27HrTlcWKg2iMpmQQtqbNRe5V3UYWUafsF1y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyPn4aSDjDUFVapIGHd/82/lJHam1F8DUD0Rq0xercRBy9692cg/oWLR0QGnpvqmmbB+P8+k45v4Xlxm92NuTiInbmFnETsEQPp6hpVe5wITlIu5zz23XqcSYWjearDqYfFmE2XMfZMSXHDSnwS9z0NZBzc4NGAXFEbDhDCIrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBPr9yfT; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742400622; x=1773936622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jg3rCi27HrTlcWKg2iMpmQQtqbNRe5V3UYWUafsF1y4=;
  b=JBPr9yfTdHJHcXeobo5u8vI/26XPlQYc+Vpk2jTg7V7sa5aigix2sdVG
   XLfZ0eDXVBYCJJo3mvDMU63VmzC3eHf5qG2328JZZ56bjl/4z0+AS3q6T
   PJ/DnjDLnA7LN/V2b/LH9jcBqsqUspJ7OkwFHPHUgkvshaUX9S1wGbYC1
   IhPtzDqsRvxrsE6MOQQUw1xel7lLmsiu9AAQveo20NUFS3H6IzkwZppNE
   RlYKTOPlCBhO5zIGnrIn4A8wZkKrMy6jSYoVmuNSY/f7kXYYFMPVZL2Wl
   JvN0nzSgGVo426eFmxwzVnIvREHjoJkVD4NqnKdyt6hjBvd8rGqlEkzE1
   Q==;
X-CSE-ConnectionGUID: mDhOKeKWTQyWOO96gqlSdA==
X-CSE-MsgGUID: JI6ERgUuS+2Fh7TuRkQLIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="53814872"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="53814872"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:10:22 -0700
X-CSE-ConnectionGUID: vhMfy1PSR9K0bIrRFBPqBw==
X-CSE-MsgGUID: cWTIyUxySXC+Mq11h3EkKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="159873225"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 19 Mar 2025 09:10:19 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuvzk-000FUM-1e;
	Wed, 19 Mar 2025 16:10:16 +0000
Date: Thu, 20 Mar 2025 00:09:36 +0800
From: kernel test robot <lkp@intel.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: oe-kbuild-all@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
	x86-cpuid@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: Re: [PATCH v2 19/29] x86/cpu: Use enums for TLB descriptor types
Message-ID: <202503192339.PuCOnZaa-lkp@intel.com>
References: <20250317164745.4754-20-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164745.4754-20-darwi@linutronix.de>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6d536cad0d55e71442b6d65500f74eb85544269e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-S-Darwish/x86-treewide-Introduce-x86_vendor_amd_or_hygon/20250318-011153
base:   6d536cad0d55e71442b6d65500f74eb85544269e
patch link:    https://lore.kernel.org/r/20250317164745.4754-20-darwi%40linutronix.de
patch subject: [PATCH v2 19/29] x86/cpu: Use enums for TLB descriptor types
config: i386-randconfig-061-20250319 (https://download.01.org/0day-ci/archive/20250319/202503192339.PuCOnZaa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192339.PuCOnZaa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192339.PuCOnZaa-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cpuidle/poll_state.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/governor.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/cpuidle-haltpoll.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/driver.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/sysfs.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/cpuidle.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/governors/menu.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"
--
   drivers/cpuidle/governors/haltpoll.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
   arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
>> arch/x86/include/asm/cpuid/types.h:85:1: sparse: sparse: static assertion failed: "sizeof(enum _tlb_table_type) == 1"

vim +85 arch/x86/include/asm/cpuid/types.h

    45	
    46	/*
    47	 * Leaf 0x2 1-byte descriptors' cache types
    48	 * To be used for their mappings at cache_table[]
    49	 */
    50	enum _cache_table_type {
    51		CACHE_L1_INST,
    52		CACHE_L1_DATA,
    53		CACHE_L2,
    54		CACHE_L3
    55	} __packed;
  > 56	static_assert(sizeof(enum _cache_table_type) == 1);
    57	
    58	/*
    59	 * Leaf 0x2 1-byte descriptors' TLB types
    60	 * To be used for their mappings at intel_tlb_table[]
    61	 *
    62	 * Start at 1 since type 0 is reserved for HW byte descriptors which are
    63	 * not recognized by the kernel; i.e., those without an explicit mapping.
    64	 */
    65	enum _tlb_table_type {
    66		TLB_INST_4K		= 1,
    67		TLB_INST_4M,
    68		TLB_INST_2M_4M,
    69		TLB_INST_ALL,
    70	
    71		TLB_DATA_4K,
    72		TLB_DATA_4M,
    73		TLB_DATA_2M_4M,
    74		TLB_DATA_4K_4M,
    75		TLB_DATA_1G,
    76		TLB_DATA_1G_2M_4M,
    77	
    78		TLB_DATA0_4K,
    79		TLB_DATA0_4M,
    80		TLB_DATA0_2M_4M,
    81	
    82		STLB_4K,
    83		STLB_4K_2M,
    84	} __packed;
  > 85	static_assert(sizeof(enum _tlb_table_type) == 1);
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

