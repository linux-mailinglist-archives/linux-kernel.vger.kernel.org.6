Return-Path: <linux-kernel+bounces-525694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E91A3F343
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 12:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A8FA3B7CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2A82080F5;
	Fri, 21 Feb 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcGRL9uT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E54A205ADA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138437; cv=none; b=RFiUQTPb+PmF38lfdjFAG7+bbV9A4oDP9D0kNNMtEkHbSm81t0W/IKNCylNzKwWw7fEglrVQaI9npdTkhWTuNvhrX23xJKvgWSh1bE8D0vaOKpTn0+pIs8tc7S5MgC5U9H6U8NfhyLyyf/czkHWK01zGC8opdVlbcerUOBHJthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138437; c=relaxed/simple;
	bh=ABY1TCmlToByq1IOLk66sUQr0qnecw/tSow9TAlG5as=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IplmOEDT3I7so/5bsNPNV5dQ/2ptqTWoUdMGJcMArEkL9wDpAcUv8AmT48MMN0Q/MnvBKZtCUnQ4jNCxF7rE9FUdY8FKqKBZyY5qRZPXHiZqMLRcoC7D1TPyY0Arb/r6irqz9uvOK80+WEhm4URIruy9Du3PnexmTgLRGlyWp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcGRL9uT; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740138435; x=1771674435;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ABY1TCmlToByq1IOLk66sUQr0qnecw/tSow9TAlG5as=;
  b=QcGRL9uTUuzgcAQweGHGe23ShRXDHRT10R1b8s5+ylroFi3VF9YFX4Wn
   5R58N6InvdpIus6sJiidplb6ZwR9MSNrnlMVTIfqW7o/x6nTKVVAviIzW
   BUs9XKI4iDCRgm8OZwrm/hm0EIGQ2IGAIIYYJWsMpcZG2Xegnu5NCe6JZ
   eJ7UKsvP7OmK8cv9ePuT7sAS04SIZVr4aDwvTjoaBsPzSZR8pDINO+/y3
   9Hq2AP7Zrvp671RNLr2SgNvWEfN6Jt3ynnZE8YpKCSJXo+Mmy/Rp8MDm0
   FUdC/2kTQeH0f9/IvOs88UMRx6ya32rnCSnOHmyQgyDipeK4kvYHuURb3
   g==;
X-CSE-ConnectionGUID: G/jqdx/jTcGH/sH6TkqzsQ==
X-CSE-MsgGUID: Zp2mUwBlRZ2zRvfONMC1Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51580128"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51580128"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 03:47:14 -0800
X-CSE-ConnectionGUID: 0jil1O78QlqN01HRD7PX2g==
X-CSE-MsgGUID: aC+Sewv9QTCpGGKr1vsmFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="138567660"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2025 03:47:12 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tlRUs-0005Sh-1o;
	Fri, 21 Feb 2025 11:47:10 +0000
Date: Fri, 21 Feb 2025 19:46:11 +0800
From: kernel test robot <lkp@intel.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c:134
 core_dcn4_initialize() warn: inconsistent indenting
Message-ID: <202502211920.txUfwtSj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   334426094588f8179fe175a09ecc887ff0c75758
commit: 00c391102abc13763e2bfc90e05503109b19f074 drm/amd/display: Add misc DC changes for DCN401
date:   10 months ago
config: loongarch-randconfig-r072-20250221 (https://download.01.org/0day-ci/archive/20250221/202502211920.txUfwtSj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502211920.txUfwtSj-lkp@intel.com/

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c:134 core_dcn4_initialize() warn: inconsistent indenting

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c:553 core_dcn4_mode_programming() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c:568 core_dcn4_mode_programming() warn: curly braces intended?

vim +134 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c

70839da6360500 Aurabindo Pillai 2024-04-19  112  
70839da6360500 Aurabindo Pillai 2024-04-19  113  bool core_dcn4_initialize(struct dml2_core_initialize_in_out *in_out)
70839da6360500 Aurabindo Pillai 2024-04-19  114  {
70839da6360500 Aurabindo Pillai 2024-04-19  115  	struct dml2_core_instance *core = in_out->instance;
70839da6360500 Aurabindo Pillai 2024-04-19  116  
70839da6360500 Aurabindo Pillai 2024-04-19  117  	if (!in_out->minimum_clock_table)
70839da6360500 Aurabindo Pillai 2024-04-19  118  		return false;
70839da6360500 Aurabindo Pillai 2024-04-19  119  	else
70839da6360500 Aurabindo Pillai 2024-04-19  120  		core->minimum_clock_table = in_out->minimum_clock_table;
70839da6360500 Aurabindo Pillai 2024-04-19  121  
70839da6360500 Aurabindo Pillai 2024-04-19  122  	if (in_out->explicit_ip_bb && in_out->explicit_ip_bb_size > 0) {
70839da6360500 Aurabindo Pillai 2024-04-19  123  		memcpy(&core->clean_me_up.mode_lib.ip, in_out->explicit_ip_bb, in_out->explicit_ip_bb_size);
70839da6360500 Aurabindo Pillai 2024-04-19  124  
70839da6360500 Aurabindo Pillai 2024-04-19  125  		// FIXME_STAGE2:
70839da6360500 Aurabindo Pillai 2024-04-19  126  		// DV still uses stage1 ip_param_st for each variant, need to patch the ip_caps with ip_param info
70839da6360500 Aurabindo Pillai 2024-04-19  127  		// Should move DV to use ip_caps but need move more overrides to ip_caps
70839da6360500 Aurabindo Pillai 2024-04-19  128  		patch_ip_caps_with_explicit_ip_params(in_out->ip_caps, in_out->explicit_ip_bb);
70839da6360500 Aurabindo Pillai 2024-04-19  129  		core->clean_me_up.mode_lib.ip.subvp_pstate_allow_width_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
70839da6360500 Aurabindo Pillai 2024-04-19  130  		core->clean_me_up.mode_lib.ip.subvp_fw_processing_delay_us = core_dcn4_ip_caps_base.subvp_pstate_allow_width_us;
70839da6360500 Aurabindo Pillai 2024-04-19  131  		core->clean_me_up.mode_lib.ip.subvp_swath_height_margin_lines = core_dcn4_ip_caps_base.subvp_swath_height_margin_lines;
70839da6360500 Aurabindo Pillai 2024-04-19  132  	} else {
70839da6360500 Aurabindo Pillai 2024-04-19  133  			memcpy(&core->clean_me_up.mode_lib.ip, &core_dcn4_ip_caps_base, sizeof(struct dml2_core_ip_params));
70839da6360500 Aurabindo Pillai 2024-04-19 @134  		patch_ip_params_with_ip_caps(&core->clean_me_up.mode_lib.ip, in_out->ip_caps);
70839da6360500 Aurabindo Pillai 2024-04-19  135  
70839da6360500 Aurabindo Pillai 2024-04-19  136  		core->clean_me_up.mode_lib.ip.imall_supported = false;
70839da6360500 Aurabindo Pillai 2024-04-19  137  	}
70839da6360500 Aurabindo Pillai 2024-04-19  138  
70839da6360500 Aurabindo Pillai 2024-04-19  139  	memcpy(&core->clean_me_up.mode_lib.soc, in_out->soc_bb, sizeof(struct dml2_soc_bb));
70839da6360500 Aurabindo Pillai 2024-04-19  140  
70839da6360500 Aurabindo Pillai 2024-04-19  141  	return true;
70839da6360500 Aurabindo Pillai 2024-04-19  142  }
70839da6360500 Aurabindo Pillai 2024-04-19  143  

:::::: The code at line 134 was first introduced by commit
:::::: 70839da6360500a82e4d5f78499284474cbed7c1 drm/amd/display: Add new DCN401 sources

:::::: TO: Aurabindo Pillai <aurabindo.pillai@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

