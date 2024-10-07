Return-Path: <linux-kernel+bounces-353440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA43992DD8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE11F21534
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637FA1D54F7;
	Mon,  7 Oct 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmzDC9Vr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B041D54D0;
	Mon,  7 Oct 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309189; cv=none; b=CDbRms4jzeWRjCiEIiU8a4VkED+C/vU7JMLZmRn2/tEKQW78ra7Y+sI2DKg7WqqxnK6dWUErwG+lLuw1/jda3Zb+ULxO3BqNwJaDCIEoBvBDnyLcOrMvh7adbk2TRtw5s2CJAPkn2NLY+wnhvGNGQPSyOonXHHoCYBBfkG65PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309189; c=relaxed/simple;
	bh=v++KU7i/DtRPXrf4Vh0ub5uX7ZRf76DIoVRA0JdD+JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmaE1KwqjUQVtE1LeN4R+mTDcL55Nb+hP62L0GouGl7hH2N9qPkFKYifNwFhlFhHawiCf/sqsRBcScK0PS/iB5oHtevIWxNHKnSjyRCowtjFwnAfJLkY4bAUPaoOgo+PBlHCqYavVZJTTzpLcGo9lXYR5sH7sTzvg13vqbEfa14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmzDC9Vr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728309188; x=1759845188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v++KU7i/DtRPXrf4Vh0ub5uX7ZRf76DIoVRA0JdD+JU=;
  b=DmzDC9Vrz9Z30HDwwn0uU746QCGVivUEScQ3J2IzZkLd0GhTyhR+WiPj
   BV2Dfl2zSbGi4CVzLHhsUFC5r3HjZB1qnGzF4jvctJ1Re1BoVF+QsjsoP
   9FYTKWAZBe6J/wBFTsoSlKPMIxffvjAWT8Uc2d7lolW+ESHuqVhZB+9Bn
   okSbalklG1JYlNHfQmrqT3PpXPQ90l/3HwhDyHkFP3nGt0zYl+PnbnDbk
   YOKPzRuv2sX0v9U1B2Ebl98vzMaTVCfTNUcmaelzKUCOY3wPttKVxe6NU
   bk8GgmcxNUl/tOStOP7kW65yq4o40SxUClhJRHAQKmAA0L481FzTyz1nu
   Q==;
X-CSE-ConnectionGUID: 4bWdh7B0SHmIDRFJPiYiyg==
X-CSE-MsgGUID: uz3I6vOEQ0W139KQKN1Icw==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27397779"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27397779"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:08 -0700
X-CSE-ConnectionGUID: ZdGab24nR+WIrBXmpxQ+GA==
X-CSE-MsgGUID: k5UQ9+BHSUC0CZEx2bR+ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75156319"
Received: from spc-west-001.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.83])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:53:05 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 2/3] ASoC: intel/sdw_utils: refactor RT multifunction sdca speaker codecs
Date: Mon,  7 Oct 2024 21:52:50 +0800
Message-ID: <20241007135251.9099-3-yung-chuan.liao@linux.intel.com>
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

Merge spk_rtd_init for multifunction sdca codecs:rt712/rt722

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/soc_sdw_utils.h                 |  3 +-
 .../intel/common/soc-acpi-intel-ptl-match.c   | 18 ++--
 sound/soc/sdw_utils/Makefile                  |  3 +-
 sound/soc/sdw_utils/soc_sdw_rt712_sdca.c      | 48 -----------
 sound/soc/sdw_utils/soc_sdw_rt722_sdca.c      | 41 ---------
 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c      | 85 +++++++++++++++++++
 sound/soc/sdw_utils/soc_sdw_utils.c           |  4 +-
 7 files changed, 98 insertions(+), 104 deletions(-)
 delete mode 100644 sound/soc/sdw_utils/soc_sdw_rt712_sdca.c
 delete mode 100644 sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
 create mode 100644 sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c

diff --git a/include/sound/soc_sdw_utils.h b/include/sound/soc_sdw_utils.h
index f68c1f193b3b..2374e6df4e58 100644
--- a/include/sound/soc_sdw_utils.h
+++ b/include/sound/soc_sdw_utils.h
@@ -234,8 +234,7 @@ int asoc_sdw_rt_sdca_jack_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_s
 int asoc_sdw_rt_amp_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt700_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt711_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_rt712_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
-int asoc_sdw_rt722_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
+int asoc_sdw_rt_mf_sdca_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_rt5682_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_cs42l42_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
 int asoc_sdw_cs42l43_hs_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai);
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index 7107f0151030..5ed905440e9d 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -36,10 +36,10 @@ static const struct snd_soc_acpi_endpoint single_endpoint = {
 };
 
 /*
- * RT722 is a multi-function codec, three endpoints are created for
- * its headset, amp and dmic functions.
+ * Multi-function codecs with three endpoints created for
+ * headset, amp and dmic functions.
  */
-static const struct snd_soc_acpi_endpoint rt722_endpoints[] = {
+static const struct snd_soc_acpi_endpoint rt_mf_endpoints[] = {
 	{
 		.num = 0,
 		.aggregated = 0,
@@ -72,8 +72,8 @@ static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
 	{
 		.adr = 0x000030025d072201ull,
-		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
-		.endpoints = rt722_endpoints,
+		.num_endpoints = ARRAY_SIZE(rt_mf_endpoints),
+		.endpoints = rt_mf_endpoints,
 		.name_prefix = "rt722"
 	}
 };
@@ -81,8 +81,8 @@ static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
 static const struct snd_soc_acpi_adr_device rt722_1_single_adr[] = {
 	{
 		.adr = 0x000130025d072201ull,
-		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
-		.endpoints = rt722_endpoints,
+		.num_endpoints = ARRAY_SIZE(rt_mf_endpoints),
+		.endpoints = rt_mf_endpoints,
 		.name_prefix = "rt722"
 	}
 };
@@ -90,8 +90,8 @@ static const struct snd_soc_acpi_adr_device rt722_1_single_adr[] = {
 static const struct snd_soc_acpi_adr_device rt722_3_single_adr[] = {
 	{
 		.adr = 0x000330025d072201ull,
-		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
-		.endpoints = rt722_endpoints,
+		.num_endpoints = ARRAY_SIZE(rt_mf_endpoints),
+		.endpoints = rt_mf_endpoints,
 		.name_prefix = "rt722"
 	}
 };
diff --git a/sound/soc/sdw_utils/Makefile b/sound/soc/sdw_utils/Makefile
index 28229ed96ffb..daf019113553 100644
--- a/sound/soc/sdw_utils/Makefile
+++ b/sound/soc/sdw_utils/Makefile
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 snd-soc-sdw-utils-y := soc_sdw_utils.o soc_sdw_dmic.o soc_sdw_rt_dmic.o \
 		       soc_sdw_rt700.o soc_sdw_rt711.o 			\
-		       soc_sdw_rt712_sdca.o soc_sdw_rt722_sdca.o	\
 		       soc_sdw_rt5682.o soc_sdw_rt_sdca_jack_common.o	\
-		       soc_sdw_rt_amp.o					\
+		       soc_sdw_rt_amp.o soc_sdw_rt_mf_sdca.o		\
 		       soc_sdw_bridge_cs35l56.o 			\
 		       soc_sdw_cs42l42.o soc_sdw_cs42l43.o 		\
 		       soc_sdw_cs_amp.o					\
diff --git a/sound/soc/sdw_utils/soc_sdw_rt712_sdca.c b/sound/soc/sdw_utils/soc_sdw_rt712_sdca.c
deleted file mode 100644
index 5127210b9a03..000000000000
--- a/sound/soc/sdw_utils/soc_sdw_rt712_sdca.c
+++ /dev/null
@@ -1,48 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// This file incorporates work covered by the following copyright notice:
-// Copyright (c) 2023 Intel Corporation
-// Copyright (c) 2024 Advanced Micro Devices, Inc.
-
-/*
- *  soc_sdw_rt712_sdca - Helpers to handle RT712-SDCA from generic machine driver
- */
-
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/soundwire/sdw.h>
-#include <linux/soundwire/sdw_type.h>
-#include <sound/control.h>
-#include <sound/soc.h>
-#include <sound/soc-acpi.h>
-#include <sound/soc-dapm.h>
-#include <sound/soc_sdw_utils.h>
-
-/*
- * dapm routes for rt712 spk will be registered dynamically according
- * to the number of rt712 spk used. The first two entries will be registered
- * for one codec case, and the last two entries are also registered
- * if two rt712s are used.
- */
-static const struct snd_soc_dapm_route rt712_spk_map[] = {
-	{ "Speaker", NULL, "rt712 SPOL" },
-	{ "Speaker", NULL, "rt712 SPOR" },
-};
-
-int asoc_sdw_rt712_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai)
-{
-	struct snd_soc_card *card = rtd->card;
-	int ret;
-
-	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
-					  "%s spk:rt712",
-					  card->components);
-	if (!card->components)
-		return -ENOMEM;
-
-	ret = snd_soc_dapm_add_routes(&card->dapm, rt712_spk_map, ARRAY_SIZE(rt712_spk_map));
-	if (ret)
-		dev_err(rtd->dev, "failed to add SPK map: %d\n", ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS(asoc_sdw_rt712_spk_rtd_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/sdw_utils/soc_sdw_rt722_sdca.c b/sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
deleted file mode 100644
index 6a402172289f..000000000000
--- a/sound/soc/sdw_utils/soc_sdw_rt722_sdca.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// This file incorporates work covered by the following copyright notice:
-// Copyright (c) 2023 Intel Corporation
-// Copyright (c) 2024 Advanced Micro Devices, Inc.
-
-/*
- *  soc_sdw_rt722_sdca - Helpers to handle RT722-SDCA from generic machine driver
- */
-
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/soundwire/sdw.h>
-#include <linux/soundwire/sdw_type.h>
-#include <sound/control.h>
-#include <sound/soc.h>
-#include <sound/soc-acpi.h>
-#include <sound/soc-dapm.h>
-#include <sound/soc_sdw_utils.h>
-
-static const struct snd_soc_dapm_route rt722_spk_map[] = {
-	{ "Speaker", NULL, "rt722 SPK" },
-};
-
-int asoc_sdw_rt722_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai)
-{
-	struct snd_soc_card *card = rtd->card;
-	int ret;
-
-	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
-					  "%s spk:rt722",
-					  card->components);
-	if (!card->components)
-		return -ENOMEM;
-
-	ret = snd_soc_dapm_add_routes(&card->dapm, rt722_spk_map, ARRAY_SIZE(rt722_spk_map));
-	if (ret)
-		dev_err(rtd->dev, "failed to add rt722 spk map: %d\n", ret);
-
-	return ret;
-}
-EXPORT_SYMBOL_NS(asoc_sdw_rt722_spk_rtd_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c b/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c
new file mode 100644
index 000000000000..8143d59ad10f
--- /dev/null
+++ b/sound/soc/sdw_utils/soc_sdw_rt_mf_sdca.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// This file incorporates work covered by the following copyright notice:
+// Copyright (c) 2024 Intel Corporation.
+
+/*
+ *  soc_sdw_rt_mf_sdca
+ *  - Helpers to handle RT Multifunction Codec from generic machine driver
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_type.h>
+#include <sound/control.h>
+#include <sound/soc.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-dapm.h>
+#include <sound/soc_sdw_utils.h>
+
+#define CODEC_NAME_SIZE	6
+
+/* dapm routes for RT-SPK will be registered dynamically */
+static const struct snd_soc_dapm_route rt712_spk_map[] = {
+	{ "Speaker", NULL, "rt712 SPOL" },
+	{ "Speaker", NULL, "rt712 SPOR" },
+};
+
+static const struct snd_soc_dapm_route rt722_spk_map[] = {
+	{ "Speaker", NULL, "rt722 SPK" },
+};
+
+/* Structure to map codec names to respective route arrays and sizes */
+struct codec_route_map {
+	const char *codec_name;
+	const struct snd_soc_dapm_route *route_map;
+	size_t route_size;
+};
+
+/* Codec route maps array */
+static const struct codec_route_map codec_routes[] = {
+	{ "rt712", rt712_spk_map, ARRAY_SIZE(rt712_spk_map) },
+	{ "rt722", rt722_spk_map, ARRAY_SIZE(rt722_spk_map) },
+};
+
+static const struct codec_route_map *get_codec_route_map(const char *codec_name)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(codec_routes); i++) {
+		if (strcmp(codec_routes[i].codec_name, codec_name) == 0)
+			return &codec_routes[i];
+	}
+	return NULL;
+}
+
+int asoc_sdw_rt_mf_sdca_spk_rtd_init(struct snd_soc_pcm_runtime *rtd, struct snd_soc_dai *dai)
+{
+	struct snd_soc_card *card = rtd->card;
+	char codec_name[CODEC_NAME_SIZE];
+	int ret;
+
+	/* acquire codec name */
+	snprintf(codec_name, CODEC_NAME_SIZE, "%s", dai->name);
+
+	/* acquire corresponding route map and size */
+	const struct codec_route_map *route_map = get_codec_route_map(codec_name);
+
+	if (!route_map) {
+		dev_err(rtd->dev, "failed to get codec name and route map\n");
+		return -EINVAL;
+	}
+
+	/* Update card components */
+	card->components = devm_kasprintf(card->dev, GFP_KERNEL,
+					  "%s spk:%s",
+					  card->components, codec_name);
+	if (!card->components)
+		return -ENOMEM;
+
+	/* Add routes */
+	ret = snd_soc_dapm_add_routes(&card->dapm, route_map->route_map, route_map->route_size);
+	if (ret)
+		dev_err(rtd->dev, "failed to add rt sdca spk map: %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(asoc_sdw_rt_mf_sdca_spk_rtd_init, SND_SOC_SDW_UTILS);
diff --git a/sound/soc/sdw_utils/soc_sdw_utils.c b/sound/soc/sdw_utils/soc_sdw_utils.c
index a6070f822eb9..3b1af6c81e83 100644
--- a/sound/soc/sdw_utils/soc_sdw_utils.c
+++ b/sound/soc/sdw_utils/soc_sdw_utils.c
@@ -138,7 +138,7 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.dailink = {SOC_SDW_AMP_OUT_DAI_ID, SOC_SDW_UNUSED_DAI_ID},
 				.init = asoc_sdw_rt_amp_init,
 				.exit = asoc_sdw_rt_amp_exit,
-				.rtd_init = asoc_sdw_rt712_spk_rtd_init,
+				.rtd_init = asoc_sdw_rt_mf_sdca_spk_rtd_init,
 				.controls = generic_spk_controls,
 				.num_controls = ARRAY_SIZE(generic_spk_controls),
 				.widgets = generic_spk_widgets,
@@ -358,7 +358,7 @@ struct asoc_sdw_codec_info codec_info_list[] = {
 				.dailink = {SOC_SDW_AMP_OUT_DAI_ID, SOC_SDW_UNUSED_DAI_ID},
 				.init = asoc_sdw_rt_amp_init,
 				.exit = asoc_sdw_rt_amp_exit,
-				.rtd_init = asoc_sdw_rt722_spk_rtd_init,
+				.rtd_init = asoc_sdw_rt_mf_sdca_spk_rtd_init,
 				.controls = generic_spk_controls,
 				.num_controls = ARRAY_SIZE(generic_spk_controls),
 				.widgets = generic_spk_widgets,
-- 
2.43.0


