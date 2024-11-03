Return-Path: <linux-kernel+bounces-394030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAC19BA94B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F29F9B2254D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398DB18E029;
	Sun,  3 Nov 2024 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/lyuKts"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD9E18CBF0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730673537; cv=none; b=EPBQtdNiwFR2SpyMYKLQJ0n/l7b3c0R6Xpbsdlu0HneFsVocVsDVa9s1y/tLDBD1WnQfgxg06GV3Spg4FF7wGLY6NWw+p8oZK+J/4oiYmKHwXFI3aDCfAN5xDY3wCeD+8juqwwuDWOCDYeBZ5NC4AbJlqVjY4sCFOlqJdzmj/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730673537; c=relaxed/simple;
	bh=it8UkeeGYxov80ao0WQ3wAVvVQIFqvTlyZMe1Pwb404=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N7erk06O7EPGwj25Z/N4z6L5PJsG0KRZLj8E6XGuMgYwYvRWampcqhJLbI0cefAvpqd3NX7zYMsivxRXttF3DZd3RWiPuyY2ESxV8jA/XEYMWffTcstyP2Ck+n5LNPiEXecd8eN2fcP5l74bRvtYHuqD0kOITBlZyrBLM/z55Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/lyuKts; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730673535; x=1762209535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=it8UkeeGYxov80ao0WQ3wAVvVQIFqvTlyZMe1Pwb404=;
  b=d/lyuKtsB3ARCc4MJagFVzkgv6lH7eSiY81uppSvv/Bq9W6YN/5kA7UC
   uK/UOpXVXdWcemlT/MlnnN9Eys2G5Y8Z/4Lgm7lMgG4ZlbzUYOMjtr76F
   iazWdx5kK0i9MEOyy6DOX5aITeNuj/jRGkTk2iygN+U0NxQMS/D1odsoQ
   90LCrxfvzhP4wHeTsrGRXhPHmcHokCBHocNExntBK0na4vrCzH4P7K8L0
   gFT1/71uMZ0jqrLnZKNkWAns/Q0NbMYH8ZVIvXF/jQ+r7+412KrdSBOWA
   P5cg4OCgiIGu7sIG8+GuRlm40ZMw4N7j7Jv+sZWwYtlrQjZwX5v7GUlpb
   Q==;
X-CSE-ConnectionGUID: zlTJIpKXSn+/MDXOeudzzA==
X-CSE-MsgGUID: w6QmdYarSEynPu4kvwZa8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47824749"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47824749"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 14:38:54 -0800
X-CSE-ConnectionGUID: AzxyHmoAQJ2RNlpaDUYW9Q==
X-CSE-MsgGUID: mabvL4PLTuaOuF5KpJ9YYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83369401"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 03 Nov 2024 14:38:54 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t7jFC-000kGH-2h;
	Sun, 03 Nov 2024 22:38:50 +0000
Date: Mon, 4 Nov 2024 06:38:18 +0800
From: kernel test robot <lkp@intel.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6211:13:
 warning: stack frame size (3288) exceeds limit (2048) in
 'dml_prefetch_check'
Message-ID: <202411040601.DGJciccG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a8cc7432728d019a10cb412401ebc15ed7504289
commit: b141fa036c901303ca5659cc22e9c08f8b097892 drm/amd/display: Reduce stack size by splitting function
date:   1 year ago
config: x86_64-buildonly-randconfig-002-20241104 (https://download.01.org/0day-ci/archive/20241104/202411040601.DGJciccG-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241104/202411040601.DGJciccG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411040601.DGJciccG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:25:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.h:29:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core_structs.h:28:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_lib_defines.h:43:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/dml_depedencies.h:30:
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:31:
   In file included from include/linux/kgdb.h:19:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2168:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6699:12: warning: stack frame size (2904) exceeds limit (2048) in 'dml_core_mode_support' [-Wframe-larger-than]
    6699 | dml_bool_t dml_core_mode_support(struct display_mode_lib_st *mode_lib)
         |            ^
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:6211:13: warning: stack frame size (3288) exceeds limit (2048) in 'dml_prefetch_check' [-Wframe-larger-than]
    6211 | static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
         |             ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8268:6: warning: stack frame size (2616) exceeds limit (2048) in 'dml_core_mode_programming' [-Wframe-larger-than]
    8268 | void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struct dml_clk_cfg_st *clk_cfg)
         |      ^
   4 warnings generated.


vim +/dml_prefetch_check +6211 drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c

  6210	
> 6211	static void dml_prefetch_check(struct display_mode_lib_st *mode_lib)
  6212	{
  6213		struct dml_core_mode_support_locals_st *s = &mode_lib->scratch.dml_core_mode_support_locals;
  6214		struct CalculatePrefetchSchedule_params_st *CalculatePrefetchSchedule_params = &mode_lib->scratch.CalculatePrefetchSchedule_params;
  6215		struct CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params_st *CalculateWatermarks_params = &mode_lib->scratch.CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params;
  6216		struct DmlPipe *myPipe;
  6217		dml_uint_t j, k;
  6218	
  6219		for (j = 0; j < 2; ++j) {
  6220			mode_lib->ms.TimeCalc = 24 / mode_lib->ms.ProjectedDCFCLKDeepSleep[j];
  6221	
  6222			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
  6223				mode_lib->ms.NoOfDPPThisState[k] = mode_lib->ms.NoOfDPP[j][k];
  6224				mode_lib->ms.swath_width_luma_ub_this_state[k] = mode_lib->ms.swath_width_luma_ub_all_states[j][k];
  6225				mode_lib->ms.swath_width_chroma_ub_this_state[k] = mode_lib->ms.swath_width_chroma_ub_all_states[j][k];
  6226				mode_lib->ms.SwathWidthYThisState[k] = mode_lib->ms.SwathWidthYAllStates[j][k];
  6227				mode_lib->ms.SwathWidthCThisState[k] = mode_lib->ms.SwathWidthCAllStates[j][k];
  6228				mode_lib->ms.SwathHeightYThisState[k] = mode_lib->ms.SwathHeightYAllStates[j][k];
  6229				mode_lib->ms.SwathHeightCThisState[k] = mode_lib->ms.SwathHeightCAllStates[j][k];
  6230				mode_lib->ms.UnboundedRequestEnabledThisState = mode_lib->ms.UnboundedRequestEnabledAllStates[j];
  6231				mode_lib->ms.CompressedBufferSizeInkByteThisState = mode_lib->ms.CompressedBufferSizeInkByteAllStates[j];
  6232				mode_lib->ms.DETBufferSizeInKByteThisState[k] = mode_lib->ms.DETBufferSizeInKByteAllStates[j][k];
  6233				mode_lib->ms.DETBufferSizeYThisState[k] = mode_lib->ms.DETBufferSizeYAllStates[j][k];
  6234				mode_lib->ms.DETBufferSizeCThisState[k] = mode_lib->ms.DETBufferSizeCAllStates[j][k];
  6235			}
  6236	
  6237			mode_lib->ms.support.VActiveBandwithSupport[j] = CalculateVActiveBandwithSupport(
  6238				mode_lib->ms.num_active_planes,
  6239				mode_lib->ms.ReturnBWPerState[j],
  6240				mode_lib->ms.NotUrgentLatencyHiding,
  6241				mode_lib->ms.ReadBandwidthLuma,
  6242				mode_lib->ms.ReadBandwidthChroma,
  6243				mode_lib->ms.cursor_bw,
  6244				mode_lib->ms.meta_row_bandwidth_this_state,
  6245				mode_lib->ms.dpte_row_bandwidth_this_state,
  6246				mode_lib->ms.NoOfDPPThisState,
  6247				mode_lib->ms.UrgentBurstFactorLuma,
  6248				mode_lib->ms.UrgentBurstFactorChroma,
  6249				mode_lib->ms.UrgentBurstFactorCursor);
  6250	
  6251			s->VMDataOnlyReturnBWPerState = dml_get_return_bw_mbps_vm_only(
  6252																		&mode_lib->ms.soc,
  6253																		mode_lib->ms.state.use_ideal_dram_bw_strobe,
  6254																		mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
  6255																		mode_lib->ms.DCFCLKState[j],
  6256																		mode_lib->ms.state.fabricclk_mhz,
  6257																		mode_lib->ms.state.dram_speed_mts);
  6258	
  6259			s->HostVMInefficiencyFactor = 1;
  6260			if (mode_lib->ms.cache_display_cfg.plane.GPUVMEnable && mode_lib->ms.cache_display_cfg.plane.HostVMEnable)
  6261				s->HostVMInefficiencyFactor = mode_lib->ms.ReturnBWPerState[j] / s->VMDataOnlyReturnBWPerState;
  6262	
  6263			mode_lib->ms.ExtraLatency = CalculateExtraLatency(
  6264					mode_lib->ms.soc.round_trip_ping_latency_dcfclk_cycles,
  6265					s->ReorderingBytes,
  6266					mode_lib->ms.DCFCLKState[j],
  6267					mode_lib->ms.TotalNumberOfActiveDPP[j],
  6268					mode_lib->ms.ip.pixel_chunk_size_kbytes,
  6269					mode_lib->ms.TotalNumberOfDCCActiveDPP[j],
  6270					mode_lib->ms.ip.meta_chunk_size_kbytes,
  6271					mode_lib->ms.ReturnBWPerState[j],
  6272					mode_lib->ms.cache_display_cfg.plane.GPUVMEnable,
  6273					mode_lib->ms.cache_display_cfg.plane.HostVMEnable,
  6274					mode_lib->ms.num_active_planes,
  6275					mode_lib->ms.NoOfDPPThisState,
  6276					mode_lib->ms.dpte_group_bytes,
  6277					s->HostVMInefficiencyFactor,
  6278					mode_lib->ms.soc.hostvm_min_page_size_kbytes,
  6279					mode_lib->ms.cache_display_cfg.plane.HostVMMaxPageTableLevels);
  6280	
  6281			s->NextMaxVStartup = s->MaxVStartupAllPlanes[j];
  6282			s->MaxVStartup = 0;
  6283			s->AllPrefetchModeTested = true;
  6284			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6285				CalculatePrefetchMode(mode_lib->ms.policy.AllowForPStateChangeOrStutterInVBlank[k], &s->MinPrefetchMode[k], &s->MaxPrefetchMode[k]);
  6286				s->NextPrefetchMode[k] = s->MinPrefetchMode[k];
  6287			}
  6288	
  6289			do {
  6290				s->MaxVStartup = s->NextMaxVStartup;
  6291				s->AllPrefetchModeTested = true;
  6292	
  6293				for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
  6294					mode_lib->ms.PrefetchMode[k] = s->NextPrefetchMode[k];
  6295					mode_lib->ms.TWait = CalculateTWait(
  6296									mode_lib->ms.PrefetchMode[k],
  6297									mode_lib->ms.cache_display_cfg.plane.UseMALLForPStateChange[k],
  6298									mode_lib->ms.policy.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
  6299									mode_lib->ms.cache_display_cfg.timing.DRRDisplay[k],
  6300									mode_lib->ms.state.dram_clock_change_latency_us,
  6301									mode_lib->ms.state.fclk_change_latency_us,
  6302									mode_lib->ms.UrgLatency,
  6303									mode_lib->ms.state.sr_enter_plus_exit_time_us);
  6304	
  6305					myPipe = &s->myPipe;
  6306					myPipe->Dppclk = mode_lib->ms.RequiredDPPCLKPerSurface[j][k];
  6307					myPipe->Dispclk = mode_lib->ms.RequiredDISPCLK[j];
  6308					myPipe->PixelClock = mode_lib->ms.cache_display_cfg.timing.PixelClock[k];
  6309					myPipe->DCFClkDeepSleep = mode_lib->ms.ProjectedDCFCLKDeepSleep[j];
  6310					myPipe->DPPPerSurface = mode_lib->ms.NoOfDPP[j][k];
  6311					myPipe->ScalerEnabled = mode_lib->ms.cache_display_cfg.plane.ScalerEnabled[k];
  6312					myPipe->SourceScan = mode_lib->ms.cache_display_cfg.plane.SourceScan[k];
  6313					myPipe->BlockWidth256BytesY = mode_lib->ms.Read256BlockWidthY[k];
  6314					myPipe->BlockHeight256BytesY = mode_lib->ms.Read256BlockHeightY[k];
  6315					myPipe->BlockWidth256BytesC = mode_lib->ms.Read256BlockWidthC[k];
  6316					myPipe->BlockHeight256BytesC = mode_lib->ms.Read256BlockHeightC[k];
  6317					myPipe->InterlaceEnable = mode_lib->ms.cache_display_cfg.timing.Interlace[k];
  6318					myPipe->NumberOfCursors = mode_lib->ms.cache_display_cfg.plane.NumberOfCursors[k];
  6319					myPipe->VBlank = mode_lib->ms.cache_display_cfg.timing.VTotal[k] - mode_lib->ms.cache_display_cfg.timing.VActive[k];
  6320					myPipe->HTotal = mode_lib->ms.cache_display_cfg.timing.HTotal[k];
  6321					myPipe->HActive = mode_lib->ms.cache_display_cfg.timing.HActive[k];
  6322					myPipe->DCCEnable = mode_lib->ms.cache_display_cfg.surface.DCCEnable[k];
  6323					myPipe->ODMMode = mode_lib->ms.ODMModePerState[k];
  6324					myPipe->SourcePixelFormat = mode_lib->ms.cache_display_cfg.surface.SourcePixelFormat[k];
  6325					myPipe->BytePerPixelY = mode_lib->ms.BytePerPixelY[k];
  6326					myPipe->BytePerPixelC = mode_lib->ms.BytePerPixelC[k];
  6327					myPipe->ProgressiveToInterlaceUnitInOPP = mode_lib->ms.ip.ptoi_supported;
  6328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

