Return-Path: <linux-kernel+bounces-427097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880D9DFC77
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15E51162E80
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF431F9F6C;
	Mon,  2 Dec 2024 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XuPrKg3H"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD51F9EA6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129675; cv=none; b=c+wM5K9pMqkdkbrITPXWDTMKnDhQImpjn0dPp0+WhY/voxfQCFbN1A7l4Tojr/dFhg+KqEfRhfKvfn4JYGD1r5NND+AcuqwyzaOde9BgNsyg1cukSNYlUI9wBt3+sNP2rsOvJ5xggIbT3kMzCDh5s/oRFHpFQtxC5c9nCRSbjMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129675; c=relaxed/simple;
	bh=NAQKNheLp8Pq2cuIY4ecjY4cNZFemhlMXIKHV+gyS6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAIDocq4Nl9NF8I9lo6KdyxUNcPoSpyZFYdLcOVPf0gACpoYzJDnDpAMkknck3ylaePOrD04Kjp9q3DnAksOx1lEQWoqI9UOVgJX6F2ekF57beZg00kjE+6S1ZYHssEwbge+wmNgip42O0TCPFtNAqEmswiKzftGO8MDbK+IrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XuPrKg3H; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733129672; x=1764665672;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NAQKNheLp8Pq2cuIY4ecjY4cNZFemhlMXIKHV+gyS6M=;
  b=XuPrKg3Hkacwi5sPorfnepu+SC0YDGuubynVtQUurwdL3XRNSZr7LJ/u
   C/cmR7AdH73LmNN72ooMYwjAmgBLsrBAd4n52JmnTR/UqWSTPvG+uIbKe
   Y1M3PwX4F1boSXP+/s7hiJWfnWHi6dyy9fpnnB+YjUGc0jld8AgPh45zp
   c6ghMhoTPAB0h75IW+n4B18QMIIuQuaPpUwhaY2RA1bLmNNPahnaJFtHM
   dlBcUY4zKJd25uQjO0pmmElTZd5WE8i6m4qJwRC+F9SBNaLMZvch7Ak82
   ZT5DHL4fcpRTjdu1rxXaeMoo2/Bx0BDe4YkOHx4uLrKWLQhLeiF/vEnMo
   A==;
X-CSE-ConnectionGUID: 5a8EPM5yRymhHILkR/W91Q==
X-CSE-MsgGUID: 2KthT0exTXqwBWzPFUqFDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="50700472"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="50700472"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 00:54:32 -0800
X-CSE-ConnectionGUID: KjHH4GJ+Rg+92Up0hvSvWA==
X-CSE-MsgGUID: i5GAyG5pTomcfwDol2ouxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="123902061"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Dec 2024 00:54:29 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI2CI-0002Dh-0u;
	Mon, 02 Dec 2024 08:54:26 +0000
Date: Mon, 2 Dec 2024 16:54:09 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"(maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"(open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))" <linux-kernel@vger.kernel.org>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on
 systems with AMD preferred cores
Message-ID: <202412021625.Q3QQhOi8-lkp@intel.com>
References: <20241202043724.3929062-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202043724.3929062-1-superm1@kernel.org>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 40384c840ea1944d7c5a392e8975ed088ecf0b37]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/x86-cpu-Enable-SD_ASYM_PACKING-for-PKG-domain-on-systems-with-AMD-preferred-cores/20241202-124012
base:   40384c840ea1944d7c5a392e8975ed088ecf0b37
patch link:    https://lore.kernel.org/r/20241202043724.3929062-1-superm1%40kernel.org
patch subject: [PATCH] x86/cpu: Enable SD_ASYM_PACKING for PKG domain on systems with AMD preferred cores
config: i386-buildonly-randconfig-005-20241202 (https://download.01.org/0day-ci/archive/20241202/202412021625.Q3QQhOi8-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412021625.Q3QQhOi8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412021625.Q3QQhOi8-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/smpboot.c:50:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/x86/kernel/smpboot.c:508:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
     508 |                 bool prefcore = false;
         |                 ^
   2 warnings generated.


vim +508 arch/x86/kernel/smpboot.c

   499	
   500	static int x86_die_flags(void)
   501	{
   502		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
   503			return x86_sched_itmt_flags();
   504	
   505		switch (boot_cpu_data.x86_vendor) {
   506		case X86_VENDOR_AMD:
   507		case X86_VENDOR_HYGON:
 > 508			bool prefcore = false;
   509	
   510			amd_detect_prefcore(&prefcore);
   511			if (prefcore || cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
   512				return x86_sched_itmt_flags();
   513		};
   514	
   515		return 0;
   516	}
   517	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

