Return-Path: <linux-kernel+bounces-367831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB99A074B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8290C287DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4E212D0A;
	Wed, 16 Oct 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPGGpjc0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B01212635;
	Wed, 16 Oct 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074262; cv=none; b=rV3mHhR5F0t7SxzhMbBX13JJ/Kr9gxAiNsawVLgcHMiWITEyyvKGsqctdXKgwoicRRtT4RVnruKmuvP6VEFNGEijJRGYt156oA7hKZ6sEgnoCeacAfeNgNwrqa58fOIeCe8fTH3RKBpWy2cVHIOo8OAW8b6IAcRRymjhbiiUeeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074262; c=relaxed/simple;
	bh=cB4F2W2GBylk0CZbCVAfMq5n7DHvGFpx/u2Yn4ZBHKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQcu5XmV6bJ57pK47wpT/ulXCRp2wAdJ+oG+2UUfiCPXUZijU0FBTta2q0/gFu/4EN6y+L56lwPqQli8NpLNGHGHBe0TAxuxc+/QQdDamofLi+GoWbKlh6thvjeKIZnImwEArtEnne568KKTpPnw1x5MJBIMXXOEDGY59x6jGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPGGpjc0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074261; x=1760610261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cB4F2W2GBylk0CZbCVAfMq5n7DHvGFpx/u2Yn4ZBHKU=;
  b=PPGGpjc0+y5NP4UcLWVjepNQmspXcHgJqxIDfT7AEjhqzZ23jBCf2ZqG
   Crgp4svkivFxxSKkJFFGjzkql0rrX0aEA2GlkyQrQjrBFfyfFeExjWyRS
   kfXJgOgsFS5s4ENh3cvsfrpXU8kD7Sx+JDK66nTGlPqCQsZBjq0TBp2/e
   5NMOfxmAgaO6SMhIdfCWGdax6JGl9MWsAU15+1FDEo0Z1otOr5K91l0ou
   PM8Rm6xGyJ0OT++njAV5cyJT6w5ucmq06s0pQM3qq/UpK0BxaEa+ArJIx
   6IiTv1t3JXdEmvfm21tZ0M6LNObdUa/ddpUNrD7TU3PTG1e9sEfExSgcF
   g==;
X-CSE-ConnectionGUID: dbkvJ6gwScyMl8vnZveP8Q==
X-CSE-MsgGUID: QiXBzi1NRvC8LgYlczek8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985937"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985937"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:21 -0700
X-CSE-ConnectionGUID: dPr/AaH0QGSL9aXsQRq8iw==
X-CSE-MsgGUID: 3gAkUUDsTbyN2cq40ekdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82961030"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:18 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 10/11] ASoC: Intel: soc-acpi: add is_device_rt712_vb() helper
Date: Wed, 16 Oct 2024 18:23:32 +0800
Message-ID: <20241016102333.294448-11-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add a filter to skip the RT172 VB configuration if a SmartMic Function
is not found in the SDCA descriptors.

If the ACPI information is incorrect this can only be quirked further
with DMI information.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/Kconfig                       |  5 ++
 sound/soc/intel/common/Makefile               |  3 ++
 .../intel/common/soc-acpi-intel-mtl-match.c   | 51 +++++++++++++++++++
 .../intel/common/soc-acpi-intel-sdca-quirks.c | 42 +++++++++++++++
 .../intel/common/soc-acpi-intel-sdca-quirks.h | 14 +++++
 5 files changed, 115 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdca-quirks.c
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-sdca-quirks.h

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 5bb7047c170f..14461dee3e52 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -71,9 +71,14 @@ if SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
 	select SND_SOC_ACPI if ACPI
+	select SND_SOC_ACPI_INTEL_SDCA_QUIRKS
 	# this option controls the compilation of ACPI matching tables and
 	# helpers and is not meant to be selected by the user.
 
+config SND_SOC_ACPI_INTEL_SDCA_QUIRKS
+	tristate
+	imply SND_SOC_SDCA
+
 endif ## SND_SOC_INTEL_SST_TOPLEVEL || SND_SOC_SOF_INTEL_TOPLEVEL
 
 config SND_SOC_INTEL_KEEMBAY
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index da551144ec0f..0afd114be9e5 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -16,4 +16,7 @@ snd-soc-acpi-intel-match-y := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-matc
 
 snd-soc-acpi-intel-match-y += soc-acpi-intel-ssp-common.o
 
+snd-soc-acpi-intel-sdca-quirks-y += soc-acpi-intel-sdca-quirks.o
+
 obj-$(CONFIG_SND_SOC_ACPI_INTEL_MATCH) += snd-soc-acpi-intel-match.o
+obj-$(CONFIG_SND_SOC_ACPI_INTEL_SDCA_QUIRKS) += snd-soc-acpi-intel-sdca-quirks.o
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index fd02c864e25e..0b37465b6c53 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -6,9 +6,12 @@
  *
  */
 
+#include <linux/soundwire/sdw_intel.h>
+#include <sound/sdca.h>
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 #include <sound/soc-acpi-intel-ssp-common.h>
+#include "soc-acpi-intel-sdca-quirks.h"
 #include "soc-acpi-intel-sdw-mockup-match.h"
 
 static const struct snd_soc_acpi_codecs mtl_rt5682_rt5682s_hp = {
@@ -133,6 +136,27 @@ static const struct snd_soc_acpi_endpoint rt712_endpoints[] = {
 	},
 };
 
+static const struct snd_soc_acpi_endpoint rt712_vb_endpoints[] = {
+	{
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
 /*
  * RT722 is a multi-function codec, three endpoints are created for
  * its headset, amp and dmic functions.
@@ -190,6 +214,15 @@ static const struct snd_soc_acpi_adr_device rt712_0_single_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt712_vb_0_single_adr[] = {
+	{
+		.adr = 0x000030025D071201ull,
+		.num_endpoints = ARRAY_SIZE(rt712_vb_endpoints),
+		.endpoints = rt712_vb_endpoints,
+		.name_prefix = "rt712"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt1712_3_single_adr[] = {
 	{
 		.adr = 0x000330025D171201ull,
@@ -363,6 +396,15 @@ static const struct snd_soc_acpi_link_adr mtl_712_l0[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr mtl_712_vb_l0[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt712_vb_0_single_adr),
+		.adr_d = rt712_vb_0_single_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_endpoint cs42l43_endpoints[] = {
 	{ /* Jack Playback Endpoint */
 		.num = 0,
@@ -774,6 +816,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-mtl-rt712-l0-rt1712-l3.tplg",
 	},
+	{
+		.link_mask = BIT(0),
+		.links = mtl_712_vb_l0,
+		.drv_name = "sof_sdw",
+		.machine_check = snd_soc_acpi_intel_sdca_is_device_rt712_vb,
+		.sof_tplg_filename = "sof-mtl-rt712-vb-l0.tplg",
+	},
 	{
 		.link_mask = BIT(0),
 		.links = mtl_712_l0,
@@ -843,3 +892,5 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[] = {
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_mtl_sdw_machines);
+
+MODULE_IMPORT_NS(SND_SOC_ACPI_INTEL_SDCA_QUIRKS);
diff --git a/sound/soc/intel/common/soc-acpi-intel-sdca-quirks.c b/sound/soc/intel/common/soc-acpi-intel-sdca-quirks.c
new file mode 100644
index 000000000000..0b7076606d66
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-sdca-quirks.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * soc-acpi-intel-sdca-quirks.c - tables and support for SDCA quirks
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ *
+ */
+
+#include <linux/soundwire/sdw_intel.h>
+#include <sound/sdca.h>
+#include <sound/soc-acpi.h>
+#include "soc-acpi-intel-sdca-quirks.h"
+
+/*
+ * Pretend machine quirk. The argument type is not the traditional
+ * 'struct snd_soc_acpi_mach' pointer but instead the sdw_intel_ctx
+ * which contains the peripheral information required for the
+ * SoundWire/SDCA filter on the SMART_MIC setup and interface
+ * revision. When the return value is false, the entry in the
+ * 'snd_soc_acpi_mach' table needs to be skipped.
+ */
+bool snd_soc_acpi_intel_sdca_is_device_rt712_vb(void *arg)
+{
+	struct sdw_intel_ctx *ctx = arg;
+	int i;
+
+	if (!ctx)
+		return false;
+
+	for (i = 0; i < ctx->peripherals->num_peripherals; i++) {
+		if (sdca_device_quirk_match(ctx->peripherals->array[i],
+					    SDCA_QUIRKS_RT712_VB))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS(snd_soc_acpi_intel_sdca_is_device_rt712_vb, SND_SOC_ACPI_INTEL_SDCA_QUIRKS);
+
+MODULE_DESCRIPTION("ASoC ACPI Intel SDCA quirks");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(SND_SOC_SDCA);
diff --git a/sound/soc/intel/common/soc-acpi-intel-sdca-quirks.h b/sound/soc/intel/common/soc-acpi-intel-sdca-quirks.h
new file mode 100644
index 000000000000..bead5ec6243f
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-sdca-quirks.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * soc-acpi-intel-sdca-quirks.h - tables and support for SDCA quirks
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ *
+ */
+
+#ifndef _SND_SOC_ACPI_INTEL_SDCA_QUIRKS
+#define _SND_SOC_ACPI_INTEL_SDCA_QUIRKS
+
+bool snd_soc_acpi_intel_sdca_is_device_rt712_vb(void *arg);
+
+#endif
-- 
2.43.0


