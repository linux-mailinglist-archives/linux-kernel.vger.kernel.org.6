Return-Path: <linux-kernel+bounces-528277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD69A415AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 07:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D47518961BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 06:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C6724BBE0;
	Mon, 24 Feb 2025 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Td6FMKyr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EED23A982;
	Mon, 24 Feb 2025 06:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740379542; cv=none; b=Ame6JWLrnKF0l1XYGtFMZrAXh3Y+RzRCT4DX5Dhh6Ka4KLW16B8Tb4QfGmH5zgjEelHU2CHqIKCVkc+Iotd8oUVvi+HmZo75JI/V3Rhahq6KsSie0RB2PUu1Tbz9pBFmM6K5nIBnso1C5U1PsArfk95FSyQyqMGcBk/k9HWqOSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740379542; c=relaxed/simple;
	bh=TGuUZVS7SscqOlzBcbztveVW0OX4wG4ywXQ1UOsGYO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfIhTUKp4+UKFmEElIA+Z1dwxfW2r2cFuki3Oz0tLt1GAbBh+ETIPMe2BKn8yUYsz+8w5uSPcIfB7po5C/ih2WyqSoL6DTuWPTeDpJ9Bs87U/R0XrZAiC6hygO+nWqdcw+TRb8HhYwstu9yHfiskXFai+7CdwareMxC6bwDfwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Td6FMKyr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740379540; x=1771915540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGuUZVS7SscqOlzBcbztveVW0OX4wG4ywXQ1UOsGYO4=;
  b=Td6FMKyrLopcKwfZc14Po5ivA2so7dSGNqEQwNFei51wYPJ5fO4NBtee
   vJNhx7yrqVWA75z8uqZXSXfD0M7g6i5X+xkamH9MPs+IPcj3zhZND/8RK
   lZWIWSMPE/LsZE1q6kR7wi2IBg3aus1rkVp7wnofFWDsAcmCS2mxlAQO1
   5daAFeFWcfe/0KiTQqcKx2j5tqWIi81eGNFRjdxiea1jWtr247a+sSUGV
   Xj9qmfAxmihhnQLwwxCjlJjHVQa/XzOWRQnaHuGQYzZLM4WW3crLvWw9s
   qwP7jcThzmiLMNZ0nUipmPimXwiz8ynvtOnKCSnc3wpr/Nn6+cba8jec/
   g==;
X-CSE-ConnectionGUID: CDKNkaSLRA2OBHlDJn4GJg==
X-CSE-MsgGUID: GVsewtDBTsSHkcT0AJDoGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="58538977"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="58538977"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:36 -0800
X-CSE-ConnectionGUID: j4jxxo0qSCKtjYqlM7gBAw==
X-CSE-MsgGUID: 2Zm3wIS7SJSlumjfaOZgaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120597735"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.222.232])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 22:45:34 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v2 11/16] ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA
Date: Mon, 24 Feb 2025 14:44:45 +0800
Message-ID: <20250224064451.33772-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
References: <20250224064451.33772-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

Add SoundWire BPT DMA helpers as a separate module to avoid circular
dependencies.

For now this assumes no link DMA, only coupled mode.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/hda-sdw-bpt.h       |  69 +++++++
 sound/soc/sof/intel/Kconfig       |   7 +
 sound/soc/sof/intel/Makefile      |   4 +
 sound/soc/sof/intel/hda-sdw-bpt.c | 319 ++++++++++++++++++++++++++++++
 4 files changed, 399 insertions(+)
 create mode 100644 include/sound/hda-sdw-bpt.h
 create mode 100644 sound/soc/sof/intel/hda-sdw-bpt.c

diff --git a/include/sound/hda-sdw-bpt.h b/include/sound/hda-sdw-bpt.h
new file mode 100644
index 000000000000..f649549b75d5
--- /dev/null
+++ b/include/sound/hda-sdw-bpt.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2025 Intel Corporation.
+ */
+
+#ifndef __HDA_SDW_BPT_H
+#define __HDA_SDW_BPT_H
+
+#include <linux/device.h>
+
+struct hdac_ext_stream;
+struct snd_dma_buffer;
+
+#if IS_ENABLED(CONFIG_SND_SOF_SOF_HDA_SDW_BPT)
+int hda_sdw_bpt_open(struct device *dev, int link_id, struct hdac_ext_stream **bpt_tx_stream,
+		     struct snd_dma_buffer *dmab_tx_bdl, u32 bpt_tx_num_bytes,
+		     u32 tx_dma_bandwidth, struct hdac_ext_stream **bpt_rx_stream,
+		     struct snd_dma_buffer *dmab_rx_bdl, u32 bpt_rx_num_bytes,
+		     u32 rx_dma_bandwidth);
+
+int hda_sdw_bpt_send_async(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+			   struct hdac_ext_stream *bpt_rx_stream);
+
+int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+		     struct hdac_ext_stream *bpt_rx_stream);
+
+int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+		      struct snd_dma_buffer *dmab_tx_bdl, struct hdac_ext_stream *bpt_rx_stream,
+		      struct snd_dma_buffer *dmab_rx_bdl);
+#else
+static inline int hda_sdw_bpt_open(struct device *dev, int link_id,
+				   struct hdac_ext_stream **bpt_tx_stream,
+				   struct snd_dma_buffer *dmab_tx_bdl, u32 bpt_tx_num_bytes,
+				   u32 tx_dma_bandwidth, struct hdac_ext_stream **bpt_rx_stream,
+				   struct snd_dma_buffer *dmab_rx_bdl, u32 bpt_rx_num_bytes,
+				   u32 rx_dma_bandwidth)
+{
+	WARN_ONCE(1, "SoundWire BPT is disabled");
+	return -EOPNOTSUPP;
+}
+
+static inline int hda_sdw_bpt_send_async(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+					 struct hdac_ext_stream *bpt_rx_stream)
+{
+	WARN_ONCE(1, "SoundWire BPT is disabled");
+	return -EOPNOTSUPP;
+}
+
+static inline int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+				   struct hdac_ext_stream *bpt_rx_stream)
+{
+	WARN_ONCE(1, "SoundWire BPT is disabled");
+	return -EOPNOTSUPP;
+}
+
+static inline int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+				    struct snd_dma_buffer *dmab_tx_bdl,
+				    struct hdac_ext_stream *bpt_rx_stream,
+				    struct snd_dma_buffer *dmab_rx_bdl)
+{
+	WARN_ONCE(1, "SoundWire BPT is disabled");
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif /* __HDA_SDW_BPT_H */
diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 2c43558d96b9..fae3598fd601 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -268,6 +268,7 @@ config SND_SOC_SOF_INTEL_LNL
 	tristate
 	select SND_SOC_SOF_HDA_GENERIC
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE
 	select SND_SOC_SOF_IPC4
 	select SND_SOC_SOF_INTEL_MTL
 
@@ -342,6 +343,12 @@ config SND_SOC_SOF_HDA_AUDIO_CODEC
 
 endif ## SND_SOC_SOF_HDA_GENERIC
 
+config SND_SOF_SOF_HDA_SDW_BPT
+	tristate
+	help
+	  This option is not user-selectable but automagically handled by
+	  'select' statements at a higher level.
+
 config SND_SOC_SOF_HDA_LINK_BASELINE
 	tristate
 	select SND_SOC_SOF_HDA if SND_SOC_SOF_HDA_LINK
diff --git a/sound/soc/sof/intel/Makefile b/sound/soc/sof/intel/Makefile
index f40daa616803..af30af92f21e 100644
--- a/sound/soc/sof/intel/Makefile
+++ b/sound/soc/sof/intel/Makefile
@@ -12,6 +12,8 @@ snd-sof-intel-hda-generic-y := hda.o hda-common-ops.o
 
 snd-sof-intel-hda-mlink-y := hda-mlink.o
 
+snd-sof-intel-hda-sdw-bpt-objs := hda-sdw-bpt.o
+
 snd-sof-intel-hda-common-$(CONFIG_SND_SOC_SOF_HDA_PROBES) += hda-probes.o
 
 snd-sof-intel-hda-y := hda-codec.o
@@ -26,6 +28,8 @@ obj-$(CONFIG_SND_SOC_SOF_HDA_GENERIC) += snd-sof-intel-hda-generic.o
 obj-$(CONFIG_SND_SOC_SOF_HDA_MLINK) += snd-sof-intel-hda-mlink.o
 obj-$(CONFIG_SND_SOC_SOF_HDA) += snd-sof-intel-hda.o
 
+obj-$(CONFIG_SND_SOF_SOF_HDA_SDW_BPT) += snd-sof-intel-hda-sdw-bpt.o
+
 snd-sof-pci-intel-tng-y := pci-tng.o
 snd-sof-pci-intel-skl-y := pci-skl.o skl.o hda-loader-skl.o
 snd-sof-pci-intel-apl-y := pci-apl.o apl.o
diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
new file mode 100644
index 000000000000..bc7a3172656f
--- /dev/null
+++ b/sound/soc/sof/intel/hda-sdw-bpt.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2025 Intel Corporation.
+//
+
+/*
+ * Hardware interface for SoundWire BPT support with HDA DMA
+ */
+
+#include <sound/hdaudio_ext.h>
+#include <sound/hda-mlink.h>
+#include <sound/hda-sdw-bpt.h>
+#include <sound/sof.h>
+#include "../ops.h"
+#include "../sof-priv.h"
+#include "hda.h"
+
+#define BPT_FREQUENCY		192000 /* The max rate defined in rate_bits[] hdac_device.c */
+#define BPT_MULTIPLIER		((BPT_FREQUENCY / 48000) - 1)
+
+static int hda_sdw_bpt_dma_prepare(struct device *dev, struct hdac_ext_stream **sdw_bpt_stream,
+				   struct snd_dma_buffer *dmab_bdl, u32 bpt_num_bytes,
+				   unsigned int num_channels, int direction)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	struct hdac_ext_stream *bpt_stream;
+	unsigned int format = HDA_CL_STREAM_FORMAT;
+
+	/*
+	 * the baseline format needs to be adjusted to
+	 * bandwidth requirements
+	 */
+	format |= (num_channels - 1);
+	format |= BPT_MULTIPLIER << AC_FMT_MULT_SHIFT;
+
+	dev_dbg(dev, "direction %d format_val %#x\n", direction, format);
+
+	bpt_stream = hda_cl_prepare(dev, format, bpt_num_bytes, dmab_bdl, false, direction, false);
+	if (IS_ERR(bpt_stream)) {
+		dev_err(sdev->dev, "%s: SDW BPT DMA prepare failed: dir %d\n",
+			__func__, direction);
+		return PTR_ERR(bpt_stream);
+	}
+	*sdw_bpt_stream = bpt_stream;
+
+	if (hdac_stream(bpt_stream)->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		struct hdac_bus *bus = sof_to_bus(sdev);
+		struct hdac_ext_link *hlink;
+		int stream_tag;
+
+		stream_tag = hdac_stream(bpt_stream)->stream_tag;
+		hlink = hdac_bus_eml_sdw_get_hlink(bus);
+
+		snd_hdac_ext_bus_link_set_stream_id(hlink, stream_tag);
+	}
+	return 0;
+}
+
+static int hda_sdw_bpt_dma_deprepare(struct device *dev, struct hdac_ext_stream *sdw_bpt_stream,
+				     struct snd_dma_buffer *dmab_bdl)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = hda_cl_cleanup(sdev->dev, dmab_bdl, true, sdw_bpt_stream);
+	if (ret < 0) {
+		dev_err(sdev->dev, "%s: SDW BPT DMA cleanup failed\n",
+			__func__);
+		return ret;
+	}
+
+	if (hdac_stream(sdw_bpt_stream)->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		struct hdac_bus *bus = sof_to_bus(sdev);
+		struct hdac_ext_link *hlink;
+		int stream_tag;
+
+		stream_tag = hdac_stream(sdw_bpt_stream)->stream_tag;
+		hlink = hdac_bus_eml_sdw_get_hlink(bus);
+
+		snd_hdac_ext_bus_link_clear_stream_id(hlink, stream_tag);
+	}
+
+	return 0;
+}
+
+static int hda_sdw_bpt_dma_enable(struct device *dev, struct hdac_ext_stream *sdw_bpt_stream)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = hda_cl_trigger(sdev->dev, sdw_bpt_stream, SNDRV_PCM_TRIGGER_START);
+	if (ret < 0)
+		dev_err(sdev->dev, "%s: SDW BPT DMA trigger start failed\n", __func__);
+
+	return ret;
+}
+
+static int hda_sdw_bpt_dma_disable(struct device *dev, struct hdac_ext_stream *sdw_bpt_stream)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = hda_cl_trigger(sdev->dev, sdw_bpt_stream, SNDRV_PCM_TRIGGER_STOP);
+	if (ret < 0)
+		dev_err(sdev->dev, "%s: SDW BPT DMA trigger stop failed\n", __func__);
+
+	return ret;
+}
+
+int hda_sdw_bpt_open(struct device *dev, int link_id, struct hdac_ext_stream **bpt_tx_stream,
+		     struct snd_dma_buffer *dmab_tx_bdl, u32 bpt_tx_num_bytes,
+		     u32 tx_dma_bandwidth, struct hdac_ext_stream **bpt_rx_stream,
+		     struct snd_dma_buffer *dmab_rx_bdl, u32 bpt_rx_num_bytes,
+		     u32 rx_dma_bandwidth)
+{
+	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
+	unsigned int num_channels_tx;
+	unsigned int num_channels_rx;
+	int ret1;
+	int ret;
+
+	num_channels_tx = DIV_ROUND_UP(tx_dma_bandwidth, BPT_FREQUENCY * 32);
+
+	ret = hda_sdw_bpt_dma_prepare(dev, bpt_tx_stream, dmab_tx_bdl, bpt_tx_num_bytes,
+				      num_channels_tx, SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret < 0) {
+		dev_err(dev, "%s: hda_sdw_bpt_dma_prepare failed for TX: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	num_channels_rx = DIV_ROUND_UP(rx_dma_bandwidth, BPT_FREQUENCY * 32);
+
+	ret = hda_sdw_bpt_dma_prepare(dev, bpt_rx_stream, dmab_rx_bdl, bpt_rx_num_bytes,
+				      num_channels_rx, SNDRV_PCM_STREAM_CAPTURE);
+	if (ret < 0) {
+		dev_err(dev, "%s: hda_sdw_bpt_dma_prepare failed for RX: %d\n",
+			__func__, ret);
+
+		ret1 = hda_sdw_bpt_dma_deprepare(dev, *bpt_tx_stream, dmab_tx_bdl);
+		if (ret1 < 0)
+			dev_err(dev, "%s: hda_sdw_bpt_dma_deprepare failed for TX: %d\n",
+				__func__, ret1);
+		return ret;
+	}
+
+	/* we need to map the channels in PCMSyCM registers */
+	ret = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id,
+					     0, /* cpu_dai->id -> PDI0 */
+					     GENMASK(num_channels_tx - 1, 0),
+					     hdac_stream(*bpt_tx_stream)->stream_tag,
+					     SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret < 0) {
+		dev_err(dev, "%s: hdac_bus_eml_sdw_map_stream_ch failed for TX: %d\n",
+			__func__, ret);
+		goto close;
+	}
+
+	ret = hdac_bus_eml_sdw_map_stream_ch(sof_to_bus(sdev), link_id,
+					     1, /* cpu_dai->id -> PDI1 */
+					     GENMASK(num_channels_rx - 1, 0),
+					     hdac_stream(*bpt_rx_stream)->stream_tag,
+					     SNDRV_PCM_STREAM_CAPTURE);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "%s: hdac_bus_eml_sdw_map_stream_ch failed for RX: %d\n",
+		__func__, ret);
+
+close:
+	ret1 = hda_sdw_bpt_close(dev, *bpt_tx_stream, dmab_tx_bdl, *bpt_rx_stream, dmab_rx_bdl);
+	if (ret1 < 0)
+		dev_err(dev, "%s: hda_sdw_bpt_close failed: %d\n",
+			__func__, ret1);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(hda_sdw_bpt_open, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
+
+int hda_sdw_bpt_send_async(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+			   struct hdac_ext_stream *bpt_rx_stream)
+{
+	int ret1;
+	int ret;
+
+	ret = hda_sdw_bpt_dma_enable(dev, bpt_tx_stream);
+	if (ret < 0) {
+		dev_err(dev, "%s: hda_sdw_bpt_dma_enable failed for TX: %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	ret = hda_sdw_bpt_dma_enable(dev, bpt_rx_stream);
+	if (ret < 0) {
+		dev_err(dev, "%s: hda_sdw_bpt_dma_enable failed for RX: %d\n",
+			__func__, ret);
+
+		ret1 = hda_sdw_bpt_dma_disable(dev, bpt_tx_stream);
+		if (ret1 < 0)
+			dev_err(dev, "%s: hda_sdw_bpt_dma_disable failed for TX: %d\n",
+				__func__, ret1);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(hda_sdw_bpt_send_async, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
+
+/*
+ * 3s is several orders of magnitude larger than what is needed for a
+ * typical firmware download.
+ */
+#define HDA_BPT_IOC_TIMEOUT_MS 3000
+
+int hda_sdw_bpt_wait(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+		     struct hdac_ext_stream *bpt_rx_stream)
+{
+	struct sof_intel_hda_stream *hda_tx_stream;
+	struct sof_intel_hda_stream *hda_rx_stream;
+	snd_pcm_uframes_t tx_position;
+	snd_pcm_uframes_t rx_position;
+	unsigned long time_tx_left;
+	unsigned long time_rx_left;
+	int ret = 0;
+	int ret1;
+	int i;
+
+	hda_tx_stream = container_of(bpt_tx_stream, struct sof_intel_hda_stream, hext_stream);
+	hda_rx_stream = container_of(bpt_rx_stream, struct sof_intel_hda_stream, hext_stream);
+
+	time_tx_left = wait_for_completion_timeout(&hda_tx_stream->ioc,
+						   msecs_to_jiffies(HDA_BPT_IOC_TIMEOUT_MS));
+	if (!time_tx_left) {
+		tx_position = hda_dsp_stream_get_position(hdac_stream(bpt_tx_stream),
+							  SNDRV_PCM_STREAM_PLAYBACK, false);
+		dev_err(dev, "%s: SDW BPT TX DMA did not complete: %ld\n",
+			__func__, tx_position);
+		ret = -ETIMEDOUT;
+		goto dma_disable;
+	}
+
+	/* Make sure the DMA is flushed */
+	i = 0;
+	do {
+		tx_position = hda_dsp_stream_get_position(hdac_stream(bpt_tx_stream),
+							  SNDRV_PCM_STREAM_PLAYBACK, false);
+		usleep_range(1000, 1010);
+		i++;
+	} while (tx_position && i < HDA_BPT_IOC_TIMEOUT_MS);
+	if (tx_position) {
+		dev_err(dev, "%s: SDW BPT TX DMA position %ld was not cleared\n",
+			__func__, tx_position);
+		ret = -ETIMEDOUT;
+		goto dma_disable;
+	}
+
+	/* the wait should be minimal here */
+	time_rx_left = wait_for_completion_timeout(&hda_rx_stream->ioc,
+						   msecs_to_jiffies(HDA_BPT_IOC_TIMEOUT_MS));
+	if (!time_rx_left) {
+		rx_position = hda_dsp_stream_get_position(hdac_stream(bpt_rx_stream),
+							  SNDRV_PCM_STREAM_CAPTURE, false);
+		dev_err(dev, "%s: SDW BPT RX DMA did not complete: %ld\n",
+			__func__, rx_position);
+		ret = -ETIMEDOUT;
+		goto dma_disable;
+	}
+
+	/* Make sure the DMA is flushed */
+	i = 0;
+	do {
+		rx_position = hda_dsp_stream_get_position(hdac_stream(bpt_rx_stream),
+							  SNDRV_PCM_STREAM_CAPTURE, false);
+		usleep_range(1000, 1010);
+		i++;
+	} while (rx_position && i < HDA_BPT_IOC_TIMEOUT_MS);
+	if (rx_position) {
+		dev_err(dev, "%s: SDW BPT RX DMA position %ld was not cleared\n",
+			__func__, rx_position);
+		ret = -ETIMEDOUT;
+		goto dma_disable;
+	}
+
+dma_disable:
+	ret1 = hda_sdw_bpt_dma_disable(dev, bpt_rx_stream);
+	if (!ret)
+		ret = ret1;
+
+	ret1 = hda_sdw_bpt_dma_disable(dev, bpt_tx_stream);
+	if (!ret)
+		ret = ret1;
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(hda_sdw_bpt_wait, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
+
+int hda_sdw_bpt_close(struct device *dev, struct hdac_ext_stream *bpt_tx_stream,
+		      struct snd_dma_buffer *dmab_tx_bdl, struct hdac_ext_stream *bpt_rx_stream,
+		      struct snd_dma_buffer *dmab_rx_bdl)
+{
+	int ret;
+	int ret1;
+
+	ret = hda_sdw_bpt_dma_deprepare(dev, bpt_rx_stream, dmab_rx_bdl);
+
+	ret1 = hda_sdw_bpt_dma_deprepare(dev, bpt_tx_stream, dmab_tx_bdl);
+	if (!ret)
+		ret = ret1;
+
+	return ret;
+}
+EXPORT_SYMBOL_NS(hda_sdw_bpt_close, "SND_SOC_SOF_INTEL_HDA_SDW_BPT");
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("SOF helpers for HDaudio SoundWire BPT");
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_HDA_COMMON");
+MODULE_IMPORT_NS("SND_SOC_SOF_HDA_MLINK");
-- 
2.43.0


