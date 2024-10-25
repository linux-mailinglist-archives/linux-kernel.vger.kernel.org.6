Return-Path: <linux-kernel+bounces-382754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A330C9B12F9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB80283116
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7D11D4615;
	Fri, 25 Oct 2024 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1gR1jU8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565D442AA4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729896638; cv=none; b=DBhgEYIM/3UuCYjIC6DYALkA0uvpaih2TuomfmEKluZN1RRjBXU0Qci5DpXWJsKqCwbCe6EhBi9w1VyJGlFOu70HPBNNCkdVVYvHsg2iftfueQDqkUSFFMFrVNJQ2uDuno1zZwGHg2OJErkBTqKuVKHN0xTzKUvqkSBdEdXae64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729896638; c=relaxed/simple;
	bh=v1Nr7Ui+gunxcmzUPBoFZjrzUsWZqQC8r449d8LfYb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nsyAafvdmCvYc1BeL75wEy8CeGMf/6XXS1koS2gck+QxuAghjGUdSjQb62nmRLYTDkL7O4qEFa80j+a3NRcymCTUfMM8bSoqVH4T736ecF9FM9q3Iu2ZgbTvj71B7ooCDRhPo4JicNu28u/B+DOXcS8GYIs2op/x3zeKgHtI70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1gR1jU8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729896636; x=1761432636;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v1Nr7Ui+gunxcmzUPBoFZjrzUsWZqQC8r449d8LfYb0=;
  b=H1gR1jU86bMgUPODDxZZ5wMHX6dqsIBSZ0MdPI8It6WfFPUHKwsEgcnp
   F009Uf63HY21xHsdi+HTvP+B145XUpBiSkmimR9D5aKNA5h3Ka0SbZZS1
   WEP7ZbUvVOq4jVOu520gc1OmGjDeCdXDpXjCZyzXmEtj1WAEV8Ptl1NwW
   jZFP6KcPVafUwmhXNa8Kccufab6CJu01Zt+kFFM1oTa4rxz4i0LqHFx+9
   acOQ7JGJGKMNtrQrjGKtWeXegUjnjMh2nqCHITaZOtWewcP6HyVnS2y8L
   +cSsBOLxitmbPdScUpKnzsV4eyIOQJGlDngA2fxMiAlSbQqmg+052XpQV
   g==;
X-CSE-ConnectionGUID: lVHsuceFTiW3wn79nj2Dfg==
X-CSE-MsgGUID: 6WDPde8xR0WMAvPPHNoBlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29443338"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29443338"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:50:36 -0700
X-CSE-ConnectionGUID: UkY/r7ulSx2/VHPDrBnC6Q==
X-CSE-MsgGUID: ufl3Z9iLSF+KjSbKXzn4PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="80957509"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 25 Oct 2024 15:50:34 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4T8a-000Z0A-0A;
	Fri, 25 Oct 2024 22:50:32 +0000
Date: Sat, 26 Oct 2024 06:50:06 +0800
From: kernel test robot <lkp@intel.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6953:13:
 warning: stack frame size (3160) exceeds limit (3072) in
 'dml_core_mode_support'
Message-ID: <202410260648.Dnwzz67Y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c71f8fb4dc911022748a378b16aad1cc9b43aad8
commit: a00e85713c372f19a81432e44f0bd5cb5102c644 drm/amd/display: Update DML2.1 generated code
date:   5 months ago
config: x86_64-randconfig-071-20241024 (https://download.01.org/0day-ci/archive/20241026/202410260648.Dnwzz67Y-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241026/202410260648.Dnwzz67Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410260648.Dnwzz67Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/inc/dml2_internal_shared_types.h:9:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/inc/dml2_external_lib_deps.h:8:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:6953:13: warning: stack frame size (3160) exceeds limit (3072) in 'dml_core_mode_support' [-Wframe-larger-than]
    6953 | static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
         |             ^
   2 warnings generated.


vim +/dml_core_mode_support +6953 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c

a00e85713c372f Rodrigo Siqueira 2024-04-29  6952  
70839da6360500 Aurabindo Pillai 2024-04-19 @6953  static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
70839da6360500 Aurabindo Pillai 2024-04-19  6954  {
70839da6360500 Aurabindo Pillai 2024-04-19  6955  	struct dml2_core_internal_display_mode_lib *mode_lib = in_out_params->mode_lib;
70839da6360500 Aurabindo Pillai 2024-04-19  6956  	const struct dml2_display_cfg *display_cfg = in_out_params->in_display_cfg;
70839da6360500 Aurabindo Pillai 2024-04-19  6957  	const struct dml2_mcg_min_clock_table *min_clk_table = in_out_params->min_clk_table;
70839da6360500 Aurabindo Pillai 2024-04-19  6958  

:::::: The code at line 6953 was first introduced by commit
:::::: 70839da6360500a82e4d5f78499284474cbed7c1 drm/amd/display: Add new DCN401 sources

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

