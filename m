Return-Path: <linux-kernel+bounces-560759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1240A6092F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC7E517FA82
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E41547C5;
	Fri, 14 Mar 2025 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVJ2Pgw0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C413D8B2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741933608; cv=none; b=FU5l7bqubd2B9L98tD/zBQphC6nFGPCkrcUsTHmH5g5pWu/rtBPZt77eCsw6VLMkUVyvPa19PMm7W6AwN6pMfC+2c2a8KZPNKyptLQbWPTbL44jy8ym6c87S5Q6miMqHvv8HoW+fO9uRypcJR5YMNRdFUoHfRpqb9Gv9dYwuvso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741933608; c=relaxed/simple;
	bh=xtDmUpOhUGdsKu/dDtCQocF38vOZK8ZuTVa2vDYkYyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM7Bx55cMZr13IJ8agBu3tBIf+tWpeMQvD7DS6rm2l4fesSNwHSf3zlna5IPCRLtcRFwSvfqLGxdRy+QceGwDoEx/lZsHUgGqOEXsvpr4xVZ/hPvFKNL80y/hUJBX0dbti0b4kilm6Ee3dvjSC0LLByVGITq7wTpP8aR7Idmb8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVJ2Pgw0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741933607; x=1773469607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtDmUpOhUGdsKu/dDtCQocF38vOZK8ZuTVa2vDYkYyw=;
  b=VVJ2Pgw0vy02R5/ic+Jo+Dz5HkX5zv4Q37Va/NuY7xYnorOW+LDP6RHy
   up5cUQreu2oepqM8+5u7JdCkXfyYwfozOBQD4fX3heAcGhgq80gxxnRsS
   o7saxdROTY7f5+Ccbui96y9YJBDISKAlbh/BWiNW59S+HakKsaeEnWzF1
   TMslLGm/CGn/Z5nl0ek7LfvK4482x8VszvfECaWZFIN6ho3sAb2PO84w1
   a0cQ9TZQbWppUtRYzA7GpQW8xH0JUvkZgEcdv6UdJIYIZKZ+UmzVM4UZb
   ruoqZvqMpm1EdZz7Q9sM5DU0Zy69mbdi3hsBC4ruuBd9Bry0HiwX5YtaH
   g==;
X-CSE-ConnectionGUID: pXtB15dVSVecyeln7bRkPw==
X-CSE-MsgGUID: f+K/zet7RAiKfRKmqQ8w8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="46864450"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="46864450"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 23:26:46 -0700
X-CSE-ConnectionGUID: E+gooA7VTPG0Le0F9GWE8w==
X-CSE-MsgGUID: RAap+ChgSfCkmHnI2VjlxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="144368273"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 13 Mar 2025 23:26:43 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsyVF-000A9s-0g;
	Fri, 14 Mar 2025 06:26:41 +0000
Date: Fri, 14 Mar 2025 14:26:12 +0800
From: kernel test robot <lkp@intel.com>
To: Akihiro Suda <suda.gitsendemail@gmail.com>,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, x86@kernel.org,
	suda.kyoto@gmail.com, regressions@lists.linux.dev,
	aruna.ramakrishna@oracle.com, tglx@linutronix.de,
	Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Subject: Re: [PATCH v2] x86: disable PKU when running on Apple Virtualization
Message-ID: <202503141349.bpi8pvc4-lkp@intel.com>
References: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312100926.34954-1-akihiro.suda.cz@hco.ntt.co.jp>

Hi Akihiro,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master v6.14-rc6 next-20250313]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Akihiro-Suda/x86-disable-PKU-when-running-on-Apple-Virtualization/20250312-181106
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250312100926.34954-1-akihiro.suda.cz%40hco.ntt.co.jp
patch subject: [PATCH v2] x86: disable PKU when running on Apple Virtualization
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250314/202503141349.bpi8pvc4-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141349.bpi8pvc4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141349.bpi8pvc4-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/common.c:530:14: error: use of undeclared identifier 'acpi_gbl_FADT'
     530 |         if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
         |                     ^
   1 error generated.


vim +/acpi_gbl_FADT +530 arch/x86/kernel/cpu/common.c

   517	
   518	static __always_inline void setup_pku(struct cpuinfo_x86 *c)
   519	{
   520		/*
   521		 * OSPKE seems broken on Apple Virtualization.
   522		 * https://lore.kernel.org/regressions/CAG8fp8QvH71Wi_y7b7tgFp7knK38rfrF7rRHh-gFKqeS0gxY6Q@mail.gmail.com/T/#u
   523		 *
   524		 * TODO: conditionally enable pku depending on the DMI BIOS version when Apple
   525		 * fixes the issue.
   526		 *
   527		 * However, this would be still not enough because DMI is missing when vmlinuz
   528		 * is directly loaded into VM.
   529		 */
 > 530		if (!memcmp(acpi_gbl_FADT.header.oem_table_id, "Apple Vz", 8)) {
   531			pr_info("pku: disabled on Apple Virtualization platform (Intel) due to a bug\n");
   532			pku_disabled = true;
   533		}
   534	
   535		if (c == &boot_cpu_data) {
   536			if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
   537				return;
   538			/*
   539			 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
   540			 * bit to be set.  Enforce it.
   541			 */
   542			setup_force_cpu_cap(X86_FEATURE_OSPKE);
   543	
   544		} else if (!cpu_feature_enabled(X86_FEATURE_OSPKE)) {
   545			return;
   546		}
   547	
   548		cr4_set_bits(X86_CR4_PKE);
   549		/* Load the default PKRU value */
   550		pkru_write_default();
   551	}
   552	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

