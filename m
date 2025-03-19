Return-Path: <linux-kernel+bounces-568145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795FA68F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26D01B67374
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748961B0F1E;
	Wed, 19 Mar 2025 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwAiX1tf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A885250F8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393627; cv=none; b=qCh0SqRm2wttiPvVtmJ4c4RpU2oTtRVdTg7MEfwoE7CdSRTd+QKTwdNBhlv11fy4XovPH7JC+lrlRSnIet6oX1pgxAkQFEa3B0IrV3AMJi/0P6ReyRKmmYeujGgFWZmwcAg+l1U5j0gO1+eNH1fsCG5AyD12nMLhdCEDRalGPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393627; c=relaxed/simple;
	bh=d1MWREdtzbaCDovZLjkEXWp+HndwpoCRn1SJTnJ/uMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeUAr+AynVxKa3gLBtqdN5sU2OSTVEcBS5nHxlYMD5n4Wn9po/XYpnLXSYJzuZ2qMjTFr3hQ7NewoOJan4mzBZZ7DzIsCdN0+tGKsU+HVZdbreZoEZIWh0PeRFLzhH2sYBAVxETC/4BSHdFGtOndDE1IbLPEE+MgJ8wjHK6K4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwAiX1tf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742393625; x=1773929625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d1MWREdtzbaCDovZLjkEXWp+HndwpoCRn1SJTnJ/uMo=;
  b=GwAiX1tfoCpl7KfbVOSiMwKfbBoZpbRTLEhciHjKvipBTn9MHvGv62Bn
   yUEPaF4WfYdzLiRt4X5wvjoYsHeZPwrHYIB5HDLzZywq5NjJsSPPLgJt8
   aGT7OCCAtxcoUUaBGvBchTP/pxSKPvjavDbkzIwRV+4xHUb+O+y99HBnZ
   1eUG+wsm4L7zx8XrjeFdATUhw9bMs+3jSrLFoXveSmMSF8X4JG0KThuU1
   6HicDCbZz/xpnIgUdfqGLW1AcivMSljCOYq0vGESMy8fWGd/DUwJ6zCHR
   n7pxyBl0nG87Vuyxk294h2PB8uuTbLV4sUWaEki8CDx6u/8ATGO/fL7b5
   Q==;
X-CSE-ConnectionGUID: YqgTDnRjR7O00ZIZJ6TTYw==
X-CSE-MsgGUID: GYOrEypFREaJy1v5F+uk9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43601132"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43601132"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 07:13:45 -0700
X-CSE-ConnectionGUID: GNLzpN9bRTqY6QzqszugxQ==
X-CSE-MsgGUID: SlLQD+qyR1C3JCVaRA2HlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123126308"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Mar 2025 07:13:41 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuuA0-000Eis-2c;
	Wed, 19 Mar 2025 14:13:33 +0000
Date: Wed, 19 Mar 2025 22:11:44 +0800
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
Subject: Re: [PATCH v2 18/29] x86/cacheinfo: Use enums for cache descriptor
 types
Message-ID: <202503192150.Vhannmnp-lkp@intel.com>
References: <20250317164745.4754-19-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317164745.4754-19-darwi@linutronix.de>

Hi Ahmed,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6d536cad0d55e71442b6d65500f74eb85544269e]

url:    https://github.com/intel-lab-lkp/linux/commits/Ahmed-S-Darwish/x86-treewide-Introduce-x86_vendor_amd_or_hygon/20250318-011153
base:   6d536cad0d55e71442b6d65500f74eb85544269e
patch link:    https://lore.kernel.org/r/20250317164745.4754-19-darwi%40linutronix.de
patch subject: [PATCH v2 18/29] x86/cacheinfo: Use enums for cache descriptor types
config: i386-randconfig-061-20250319 (https://download.01.org/0day-ci/archive/20250319/202503192150.Vhannmnp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192150.Vhannmnp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192150.Vhannmnp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cpuidle/poll_state.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/cpuidle-haltpoll.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/sysfs.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/governor.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/driver.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/cpuidle.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/governors/menu.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"
--
   drivers/cpuidle/governors/haltpoll.c: note: in included file (through arch/x86/include/asm/cpuid/api.h, arch/x86/include/asm/cpuid.h, arch/x86/include/asm/processor.h, ...):
>> arch/x86/include/asm/cpuid/types.h:56:1: sparse: sparse: static assertion failed: "sizeof(enum _cache_table_type) == 1"

vim +56 arch/x86/include/asm/cpuid/types.h

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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

