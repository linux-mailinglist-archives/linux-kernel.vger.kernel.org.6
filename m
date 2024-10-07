Return-Path: <linux-kernel+bounces-353439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD17992DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D24A28163F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D01D47D9;
	Mon,  7 Oct 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViK+Uy3h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3011D45FF;
	Mon,  7 Oct 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309186; cv=none; b=sJIciXXJY7/xKfR7E7JgyfTyf9wdn3/4zF6EDBWLkQ9ysWUwag012mq/DUT0ZbI7qIPC2sz7ht07ly1N7kftDOKKfyljoi70mRyV6YRDzBG4OkhuzA6o+lqbLFhVF66/jeXX9hKT+tCa6tw0bkP3+qXqwO143PHFTD+KJ63gNGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309186; c=relaxed/simple;
	bh=sjFerIkSmPoG9Jl8i/4JlAunP2Z/GvzSWn19G04KXS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N7ZVWtSgjvqYi6KLdiRIGqrltoajbPJ70jIIyWJVC0vgk078ZertSDtrhLQ1mJTVlcEgtRieQAeHLVLJS4U3DGU/Y/+HDJyevKcE0wgksVsEu25bgG0+di26HlKg9lWwzA9oUc7g5Z05ZYjtdb74XJxrZJIwINEUI8azv/i+cNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViK+Uy3h; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728309185; x=1759845185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjFerIkSmPoG9Jl8i/4JlAunP2Z/GvzSWn19G04KXS4=;
  b=ViK+Uy3h3/BnbaDdG/peae38PsbD9N4gbu6bGaprWVyUuYjre5vK/znq
   XMDunhyf5f6P9U7wcMDSUj/Wo1ynqF5BBcDcgVL+g2UOdbgF1T80bYLta
   hxaEzg8esvkUC+DmYtCKqdbw6mrT8E5ONok0h3qTpB2iXx12uMMt6uHYP
   ih8ITtUc7+u6OnmO18EsTz0blZVabeQydU+F1Yzt7gCbetgP44avKuYKf
   fhOPHEufzYrOcKFT2MFXeL7a7lRJCQOwX3QadzU6mThorCPAu+RqhWoDQ
   x/uIgCY9oss3cmU1GiFlPgGsxUQxTGPFOcR0PvhTbMtzFKgPt/b5pylMz
   w==;
X-CSE-ConnectionGUID: YXdhxtJ9TGm0UrJNxp+WFg==
X-CSE-MsgGUID: j4vBXMkoS8Saa4rWM3OvDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27397774"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27397774"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:05 -0700
X-CSE-ConnectionGUID: Rm/L1iKuT22HAgkD1OcriQ==
X-CSE-MsgGUID: fAlif2+yRoCK4zdizTopQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75156315"
Received: from spc-west-001.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:03 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 1/3] ASoC: intel: sof_sdw: add RT722 SDCA card for PTL platform
Date: Mon,  7 Oct 2024 21:52:49 +0800
Message-ID: <20241007135251.9099-2-yung-chuan.liao@linux.intel.com>
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

From: Dharageswari R <dharageswari.r@intel.com>

Enable on-board rt722 based sound card for PTL RVP.

Signed-off-by: Dharageswari R <dharageswari.r@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c              |  8 +++++++
 .../intel/common/soc-acpi-intel-ptl-match.c   | 24 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 35d707d3ae9c..0a87aa9347ef 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -598,6 +598,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
 	},
+	/* Pantherlake devices*/
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Intel_ptlrvp"),
+		},
+		.driver_data = (void *)(SOC_SDW_PCH_DMIC),
+	},
 	{}
 };
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index 61b16bc1ba8c..7107f0151030 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -78,6 +78,15 @@ static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt722_1_single_adr[] = {
+	{
+		.adr = 0x000130025d072201ull,
+		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
+		.endpoints = rt722_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt722_3_single_adr[] = {
 	{
 		.adr = 0x000330025d072201ull,
@@ -96,6 +105,15 @@ static const struct snd_soc_acpi_link_adr ptl_rt722_only[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr ptl_rt722_l1[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt722_1_single_adr),
+		.adr_d = rt722_1_single_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr ptl_rt722_l3[] = {
 	{
 		.mask = BIT(3),
@@ -147,6 +165,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt722.tplg",
 	},
+	{
+		.link_mask = BIT(1),
+		.links = ptl_rt722_l1,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt722.tplg",
+	},
 	{
 		.link_mask = BIT(3),
 		.links = ptl_rt722_l3,
-- 
2.43.0


