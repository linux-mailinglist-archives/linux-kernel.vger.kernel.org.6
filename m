Return-Path: <linux-kernel+bounces-353441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 511B4992DD9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64ED71C22861
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D2C1D4605;
	Mon,  7 Oct 2024 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZACUtPi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2341D45EA;
	Mon,  7 Oct 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309191; cv=none; b=D+yverDqBq/3zu+42D05rVHfI31xLRK/Rvj9Xw8UOmZdFGNcT0NzGGjI0S7Iv9buv9ONxW1SXDzG5ql18AgdVRaXLA+Y4Y0TRs/6HvL/pQPTfB+pccURcK+qTCJsWiJ3bo+yBnWUdTAN6nc1baZdCvt+h+br8Uaqq7hov+ACk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309191; c=relaxed/simple;
	bh=SlLUk0Q7ErAYA7ZmxVxtW/Rs883QZ+PhuwBlm1PtfPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqDNyWvvPThAjybrk3uvqy1FvkRxnN8vuRW8BIdh/o1wgP3BrfaGPZXVWxQasAZRNRXYTPKGirvpn9IpFJAyTlPHqrtyGhCGYjuS/gGYAolwL+bGHwlH3MZvAkn5O5FmODJe0oMv5vcSWVfNKw+a3M6OBih5/VQuAjkf+MM4+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZACUtPi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728309190; x=1759845190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlLUk0Q7ErAYA7ZmxVxtW/Rs883QZ+PhuwBlm1PtfPQ=;
  b=kZACUtPi7INcdjYnCiMCDIn9tfxrLp75XiAKUU9Bqqss7Oszb9br0ZzI
   rQMISTfyke2ghyTb1VltvAXVTV+xrUQY1k4XAWgjLnXaGUcasqOcg2brd
   tOIrtM9B/8XVCq+tbDWi2MDc57WeEhm+8nMzC3Dup4SnE20KoK8OWSlPF
   aDxTJkT0G0pAYY6kaorB9IQA6rYEQJ/TPXXvaYYNd5LOBOoDLbFFECG6m
   Z74+N0cnaOYIYziJws/GFKbB4K0MHS7Gtk2BGs61zkC42G1Bss/T1d4Dd
   WfMesd/6VgEu36lXCi3Efijx5M++9+hw5xM5q5qPO9LiXRS/kmWNrvpZu
   A==;
X-CSE-ConnectionGUID: cWelBgx5THGnmyD/eIOhhg==
X-CSE-MsgGUID: +iM42nisTXW4ttVjmNF8EA==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27397791"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27397791"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:10 -0700
X-CSE-ConnectionGUID: EaQk/GEXRk+cjPioZtLCXw==
X-CSE-MsgGUID: /v1C7zvTQMGDQyQIN6+IXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75156322"
Received: from spc-west-001.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:08 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 3/3] ASoC: Intel: soc-acpi-intel-ptl-match: Add rt721 support
Date: Mon,  7 Oct 2024 21:52:51 +0800
Message-ID: <20241007135251.9099-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241007135251.9099-1-yung-chuan.liao@linux.intel.com>
References: <20241007135251.9099-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Naveen Manohar <naveen.m@intel.com>

Patch adds driver data & match table for rt721
multi-function codec on PTL-RVP at sdw link3.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig                |  1 +
 .../intel/common/soc-acpi-intel-ptl-match.c   | 24 +++++++++++
 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c      |  5 +++
 .../sdw_utils/soc_sdw_rt_sdca_jack_common.c   |  8 ++++
 sound/soc/sdw_utils/soc_sdw_utils.c           | 41 +++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index cc10ae58b0c7..9b80b19bb8d0 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -519,6 +519,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_RT712_SDCA_DMIC_SDW
 	select SND_SOC_RT715_SDW
 	select SND_SOC_RT715_SDCA_SDW
+	select SND_SOC_RT721_SDCA_SDW
 	select SND_SOC_RT722_SDCA_SDW
 	select SND_SOC_RT1308_SDW
 	select SND_SOC_RT1308
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index 5ed905440e9d..f1c0d7a02cda 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -69,6 +69,24 @@ static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt721_3_single_adr[] = {
+	{
+		.adr = 0x000330025d072101ull,
+		.num_endpoints = ARRAY_SIZE(rt_mf_endpoints),
+		.endpoints = rt_mf_endpoints,
+		.name_prefix = "rt721"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr ptl_rt721_l3[] = {
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt721_3_single_adr),
+		.adr_d = rt721_3_single_adr,
+	},
+	{},
+};
+
 static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
 	{
 		.adr = 0x000030025d072201ull,
@@ -159,6 +177,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt711.tplg",
 	},
+	{
+		.link_mask = BIT(3),
+		.links = ptl_rt721_l3,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt721.tplg",
+	},
 	{
 		.link_mask = BIT(0),
 		.links = ptl_rt722_only,
diff --git a/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c b/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c
index 8143d59ad10f..81e43319876e 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c
@@ -25,6 +25,10 @@ static const struct snd_soc_dapm_route rt712_spk_map[] = {
 	{ "Speaker", NULL, "rt712 SPOR" },
 };
 
+static const struct snd_soc_dapm_route rt721_spk_map[] = {
+	{ "Speaker", NULL, "rt721 SPK" },
+};
+
 static const struct snd_soc_dapm_route rt722_spk_map[] = {
 	{ "Speaker", NULL, "rt722 SPK" },
 };
@@ -39,6 +43,7 @@ struct codec_route_map {
 /* Codec route maps array */
 static const struct codec_route_map codec_routes[] = {
 	{ "rt712", rt712_spk_map, ARRAY_SIZE(rt712_spk_map) },
+	{ "rt721", rt721_spk_map, ARRAY_SIZE(rt721_spk_map) },
 	{ "rt722", rt722_spk_map, ARRAY_SIZE(rt722_spk_map) },
 };
 
diff --git a/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c b/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
index 3e6211dc1599..af43efbb8f79 100644
--- a/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
+++ b/sound/soc/sdw_utils/soc_sdw_rt_sdca_jack_common.c
@@ -60,6 +60,11 @@ static const struct snd_soc_dapm_route rt713_sdca_map[] = {
 	{ "rt713 MIC2", NULL, "Headset Mic" },
 };
 
+static const struct snd_soc_dapm_route rt721_sdca_map[] = {
+	{ "Headphone", NULL, "rt721 HP" },
+	{ "rt721 MIC2", NULL, "Headset Mic" },
+};
+
 static const struct snd_soc_dapm_route rt722_sdca_map[] = {
 	{ "Headphone", NULL, "rt722 HP" },
 	{ "rt722 MIC2", NULL, "Headset Mic" },
@@ -121,6 +126,9 @@ int asoc_sdw_rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_s
 	} else if (strstr(component->name_prefix, "rt713")) {
 		ret = snd_soc_dapm_add_routes(&card->dapm, rt713_sdca_map,
 					      ARRAY_SIZE(rt713_sdca_map));
+	} else if (strstr(component->name_prefix, "rt721")) {
+		ret = snd_soc_dapm_add_routes(&card->dapm, rt721_sdca_map,
+					      ARRAY_SIZE(rt721_sdca_map));
 	} else if (strstr(component->name_prefix, "rt722")) {
 		ret = snd_soc_dapm_add_routes(&card->dapm, rt722_sdca_map,
 					      ARRAY_SIZE(rt722_sdca_map));
diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index 3b1af6c81e83..a9323cb444d0 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -333,6 +333,47 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 		},
 		.dai_num = 1,
 	},
+	{
+		.part_id = 0x721,
+		.version_id = 3,
+		.dais = {
+			{
+				.direction = {true, true},
+				.dai_name = "rt721-sdca-aif1",
+				.dai_type = SOC_SDW_DAI_TYPE_JACK,
+				.dailink = {SOC_SDW_JACK_OUT_DAI_ID, SOC_SDW_JACK_IN_DAI_ID},
+				.init = asoc_sdw_rt_sdca_jack_init,
+				.exit = asoc_sdw_rt_sdca_jack_exit,
+				.rtd_init = asoc_sdw_rt_sdca_jack_rtd_init,
+				.controls = generic_jack_controls,
+				.num_controls = ARRAY_SIZE(generic_jack_controls),
+				.widgets = generic_jack_widgets,
+				.num_widgets = ARRAY_SIZE(generic_jack_widgets),
+			},
+			{
+				.direction = {true, false},
+				.dai_name = "rt721-sdca-aif2",
+				.dai_type = SOC_SDW_DAI_TYPE_AMP,
+				/* No feedback capability is provided by rt721-sdca codec driver*/
+				.dailink = {SOC_SDW_AMP_OUT_DAI_ID, SOC_SDW_UNUSED_DAI_ID},
+				.init = asoc_sdw_rt_amp_init,
+				.exit = asoc_sdw_rt_amp_exit,
+				.rtd_init = asoc_sdw_rt_mf_sdca_spk_rtd_init,
+				.controls = generic_spk_controls,
+				.num_controls = ARRAY_SIZE(generic_spk_controls),
+				.widgets = generic_spk_widgets,
+				.num_widgets = ARRAY_SIZE(generic_spk_widgets),
+			},
+			{
+				.direction = {false, true},
+				.dai_name = "rt721-sdca-aif3",
+				.dai_type = SOC_SDW_DAI_TYPE_MIC,
+				.dailink = {SOC_SDW_UNUSED_DAI_ID, SOC_SDW_DMIC_DAI_ID},
+				.rtd_init = asoc_sdw_rt_dmic_rtd_init,
+			},
+		},
+		.dai_num = 3,
+	},
 	{
 		.part_id = 0x722,
 		.version_id = 3,
-- 
2.43.0


