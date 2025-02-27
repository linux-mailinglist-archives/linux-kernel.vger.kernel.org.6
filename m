Return-Path: <linux-kernel+bounces-536529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93975A480E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 171F0171411
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FC241CA0;
	Thu, 27 Feb 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nh6ngp4I"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68823C8BE;
	Thu, 27 Feb 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665228; cv=none; b=gMPd6JsBfmBOSlqJEJwr7iX/+VeZflibFHc+xzHDuAcFl539YvZMgCxOkirWuv28vQuvEIxryJyiX2Z945e5MIeA7suN//0MDt2LDrNewxhr6hDz+n5IBKNX/CHni9jS6LmIY5lyuNu/m28djzKleKL/mpTbxZKWej5Sqxjv9zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665228; c=relaxed/simple;
	bh=ysR+QHqvp71AWsOi8hjkD6DmFGaPhP+g6HFaUTZRV80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3h3k3Ps4GZjcGpGyD2m1evgygFAcrMNHGOw9Rnd9hhXVJph3BJAKOrm3gIMzzwarE+cBmyKBolgqvLioUDAn7Gcl6ifpE4UsOoEFEkk3jlqfrhv2yA1h2D/c99kK784JykeIbZmvYp63P5KmIBkk2xU6vau9bFXTr+EmaF+Xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nh6ngp4I; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740665226; x=1772201226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ysR+QHqvp71AWsOi8hjkD6DmFGaPhP+g6HFaUTZRV80=;
  b=Nh6ngp4IruPcLrg6fdk9UzcAqMqGzFAH1d2c11vSsfdhdMskJfT9uFPx
   webx9ZzE5i6NSwCippDrX1x7ORtLcTUftshdyqY5pI15gL9FiZq/QE6GK
   iwo5lJbAKHwicmJNqGZQdzKCFfEy14kghrIGaLJc8seG62IH7BAJkx/3f
   qTjX3FJtE1OFyAyJfKfR92MaRPRsRltaJ3V5Q5c/lFq2aMYDMZFOnq+d/
   88keUr7MKEOYnwjwM+7639gKXrh+5K4RQAD+JW0j1p1ga9CVkMH9fIhWd
   ewZ8d58NXX2NCX1rmjlp5EbpJ1zfmwNWAQAkJFxQ6f48o/8KVhSGBhzpA
   Q==;
X-CSE-ConnectionGUID: f8VJr1aLT5O3YuiaaFq7hQ==
X-CSE-MsgGUID: S9D1PzF1SOScUPTA3wV9aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41438102"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41438102"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:54 -0800
X-CSE-ConnectionGUID: HFcq4G++SPC2ozDqBsP3kg==
X-CSE-MsgGUID: W0N/9iuxTryvI73UfPaSGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116831737"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO yungchua-desk.intel.com) ([10.124.220.154])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 06:06:52 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH v4 13/16] soundwire: intel_ace2x: add BPT send_async/wait callbacks
Date: Thu, 27 Feb 2025 22:06:12 +0800
Message-ID: <20250227140615.8147-14-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
References: <20250227140615.8147-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>

Add support for BTP API using Cadence and hda-sdw-bpt helpers.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 drivers/soundwire/intel_ace2x.c | 312 ++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/drivers/soundwire/intel_ace2x.c b/drivers/soundwire/intel_ace2x.c
index e305c6258ca9..5b31e1f69591 100644
--- a/drivers/soundwire/intel_ace2x.c
+++ b/drivers/soundwire/intel_ace2x.c
@@ -13,12 +13,320 @@
 #include <linux/soundwire/sdw_intel.h>
 #include <sound/hdaudio.h>
 #include <sound/hda-mlink.h>
+#include <sound/hda-sdw-bpt.h>
 #include <sound/hda_register.h>
 #include <sound/pcm_params.h>
 #include "cadence_master.h"
 #include "bus.h"
 #include "intel.h"
 
+static int sdw_slave_bpt_stream_add(struct sdw_slave *slave, struct sdw_stream_runtime *stream)
+{
+	struct sdw_stream_config sconfig = {0};
+	struct sdw_port_config pconfig = {0};
+	int ret;
+
+	/* arbitrary configuration */
+	sconfig.frame_rate = 16000;
+	sconfig.ch_count = 1;
+	sconfig.bps = 32; /* this is required for BPT/BRA */
+	sconfig.direction = SDW_DATA_DIR_RX;
+	sconfig.type = SDW_STREAM_BPT;
+
+	pconfig.num = 0;
+	pconfig.ch_mask = BIT(0);
+
+	ret = sdw_stream_add_slave(slave, &sconfig, &pconfig, 1, stream);
+	if (ret)
+		dev_err(&slave->dev, "%s: failed: %d\n", __func__, ret);
+
+	return ret;
+}
+
+static int intel_ace2x_bpt_open_stream(struct sdw_intel *sdw, struct sdw_slave *slave,
+				       struct sdw_bpt_msg *msg)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	struct sdw_bus *bus = &cdns->bus;
+	struct sdw_master_prop *prop = &bus->prop;
+	struct sdw_stream_runtime *stream;
+	struct sdw_stream_config sconfig;
+	struct sdw_port_config *pconfig;
+	unsigned int pdi0_buffer_size;
+	unsigned int tx_dma_bandwidth;
+	unsigned int pdi1_buffer_size;
+	unsigned int rx_dma_bandwidth;
+	unsigned int data_per_frame;
+	unsigned int tx_total_bytes;
+	struct sdw_cdns_pdi *pdi0;
+	struct sdw_cdns_pdi *pdi1;
+	unsigned int num_frames;
+	int command;
+	int ret1;
+	int ret;
+	int dir;
+	int i;
+
+	stream = sdw_alloc_stream("BPT", SDW_STREAM_BPT);
+	if (!stream)
+		return -ENOMEM;
+
+	cdns->bus.bpt_stream = stream;
+
+	ret = sdw_slave_bpt_stream_add(slave, stream);
+	if (ret < 0)
+		goto release_stream;
+
+	/* handle PDI0 first */
+	dir = SDW_DATA_DIR_TX;
+
+	pdi0 = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, 1,  dir, 0);
+	if (!pdi0) {
+		dev_err(cdns->dev, "%s: sdw_cdns_alloc_pdi0 failed\n", __func__);
+		ret = -EINVAL;
+		goto remove_slave;
+	}
+
+	sdw_cdns_config_stream(cdns, 1, dir, pdi0);
+
+	/* handle PDI1  */
+	dir = SDW_DATA_DIR_RX;
+
+	pdi1 = sdw_cdns_alloc_pdi(cdns, &cdns->pcm, 1,  dir, 1);
+	if (!pdi1) {
+		dev_err(cdns->dev, "%s: sdw_cdns_alloc_pdi1 failed\n", __func__);
+		ret = -EINVAL;
+		goto remove_slave;
+	}
+
+	sdw_cdns_config_stream(cdns, 1, dir, pdi1);
+
+	/*
+	 * the port config direction, number of channels and frame
+	 * rate is totally arbitrary
+	 */
+	sconfig.direction = dir;
+	sconfig.ch_count = 1;
+	sconfig.frame_rate = 16000;
+	sconfig.type = SDW_STREAM_BPT;
+	sconfig.bps = 32; /* this is required for BPT/BRA */
+
+	/* Port configuration */
+	pconfig = kcalloc(2, sizeof(*pconfig), GFP_KERNEL);
+	if (!pconfig) {
+		ret =  -ENOMEM;
+		goto remove_slave;
+	}
+
+	for (i = 0; i < 2 /* num_pdi */; i++) {
+		pconfig[i].num = i;
+		pconfig[i].ch_mask = 1;
+	}
+
+	ret = sdw_stream_add_master(&cdns->bus, &sconfig, pconfig, 2, stream);
+	kfree(pconfig);
+
+	if (ret < 0) {
+		dev_err(cdns->dev, "add master to stream failed:%d\n", ret);
+		goto remove_slave;
+	}
+
+	ret = sdw_prepare_stream(cdns->bus.bpt_stream);
+	if (ret < 0)
+		goto remove_master;
+
+	command = (msg->flags & SDW_MSG_FLAG_WRITE) ? 0 : 1;
+
+	ret = sdw_cdns_bpt_find_buffer_sizes(command, cdns->bus.params.row, cdns->bus.params.col,
+					     msg->len, SDW_BPT_MSG_MAX_BYTES, &data_per_frame,
+					     &pdi0_buffer_size, &pdi1_buffer_size, &num_frames);
+	if (ret < 0)
+		goto deprepare_stream;
+
+	sdw->bpt_ctx.pdi0_buffer_size = pdi0_buffer_size;
+	sdw->bpt_ctx.pdi1_buffer_size = pdi1_buffer_size;
+	sdw->bpt_ctx.num_frames = num_frames;
+	sdw->bpt_ctx.data_per_frame = data_per_frame;
+	tx_dma_bandwidth = div_u64((u64)pdi0_buffer_size * 8 * (u64)prop->default_frame_rate,
+				   num_frames);
+	rx_dma_bandwidth = div_u64((u64)pdi1_buffer_size * 8 * (u64)prop->default_frame_rate,
+				   num_frames);
+
+	dev_dbg(cdns->dev, "Message len %d transferred in %d frames (%d per frame)\n",
+		msg->len, num_frames, data_per_frame);
+	dev_dbg(cdns->dev, "sizes pdi0 %d pdi1 %d tx_bandwidth %d rx_bandwidth %d\n",
+		pdi0_buffer_size, pdi1_buffer_size, tx_dma_bandwidth, rx_dma_bandwidth);
+
+	ret = hda_sdw_bpt_open(cdns->dev->parent, /* PCI device */
+			       sdw->instance, &sdw->bpt_ctx.bpt_tx_stream,
+			       &sdw->bpt_ctx.dmab_tx_bdl, pdi0_buffer_size, tx_dma_bandwidth,
+			       &sdw->bpt_ctx.bpt_rx_stream, &sdw->bpt_ctx.dmab_rx_bdl,
+			       pdi1_buffer_size, rx_dma_bandwidth);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s: hda_sdw_bpt_open failed %d\n", __func__, ret);
+		goto deprepare_stream;
+	}
+
+	if (!command) {
+		ret = sdw_cdns_prepare_write_dma_buffer(msg->dev_num, msg->addr, msg->buf,
+							msg->len, data_per_frame,
+							sdw->bpt_ctx.dmab_tx_bdl.area,
+							pdi0_buffer_size, &tx_total_bytes);
+	} else {
+		ret = sdw_cdns_prepare_read_dma_buffer(msg->dev_num, msg->addr,	msg->len,
+						       data_per_frame,
+						       sdw->bpt_ctx.dmab_tx_bdl.area,
+						       pdi0_buffer_size, &tx_total_bytes);
+	}
+
+	if (!ret)
+		return 0;
+
+	dev_err(cdns->dev, "%s: sdw_prepare_%s_dma_buffer failed %d\n",
+		__func__, command ? "read" : "write", ret);
+
+	ret1 = hda_sdw_bpt_close(cdns->dev->parent, /* PCI device */
+				 sdw->bpt_ctx.bpt_tx_stream, &sdw->bpt_ctx.dmab_tx_bdl,
+				 sdw->bpt_ctx.bpt_rx_stream, &sdw->bpt_ctx.dmab_rx_bdl);
+	if (ret1 < 0)
+		dev_err(cdns->dev, "%s:  hda_sdw_bpt_close failed: ret %d\n",
+			__func__, ret1);
+
+deprepare_stream:
+	sdw_deprepare_stream(cdns->bus.bpt_stream);
+
+remove_master:
+	ret1 = sdw_stream_remove_master(&cdns->bus, cdns->bus.bpt_stream);
+	if (ret1 < 0)
+		dev_err(cdns->dev, "%s: remove master failed: %d\n",
+			__func__, ret1);
+
+remove_slave:
+	ret1 = sdw_stream_remove_slave(slave, cdns->bus.bpt_stream);
+	if (ret1 < 0)
+		dev_err(cdns->dev, "%s: remove slave failed: %d\n",
+			__func__, ret1);
+
+release_stream:
+	sdw_release_stream(cdns->bus.bpt_stream);
+	cdns->bus.bpt_stream = NULL;
+
+	return ret;
+}
+
+static void intel_ace2x_bpt_close_stream(struct sdw_intel *sdw, struct sdw_slave *slave,
+					 struct sdw_bpt_msg *msg)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	int ret;
+
+	ret = hda_sdw_bpt_close(cdns->dev->parent /* PCI device */, sdw->bpt_ctx.bpt_tx_stream,
+				&sdw->bpt_ctx.dmab_tx_bdl, sdw->bpt_ctx.bpt_rx_stream,
+				&sdw->bpt_ctx.dmab_rx_bdl);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s:  hda_sdw_bpt_close failed: ret %d\n",
+			__func__, ret);
+
+	ret = sdw_deprepare_stream(cdns->bus.bpt_stream);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: sdw_deprepare_stream failed: ret %d\n",
+			__func__, ret);
+
+	ret = sdw_stream_remove_master(&cdns->bus, cdns->bus.bpt_stream);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: remove master failed: %d\n",
+			__func__, ret);
+
+	ret = sdw_stream_remove_slave(slave, cdns->bus.bpt_stream);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: remove slave failed: %d\n",
+			__func__, ret);
+
+	cdns->bus.bpt_stream = NULL;
+}
+
+#define INTEL_BPT_MSG_BYTE_ALIGNMENT 32
+
+static int intel_ace2x_bpt_send_async(struct sdw_intel *sdw, struct sdw_slave *slave,
+				      struct sdw_bpt_msg *msg)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	int ret;
+
+	if (msg->len % INTEL_BPT_MSG_BYTE_ALIGNMENT) {
+		dev_err(cdns->dev, "BPT message length %d is not a multiple of %d bytes\n",
+			msg->len, INTEL_BPT_MSG_BYTE_ALIGNMENT);
+		return -EINVAL;
+	}
+
+	dev_dbg(cdns->dev, "BPT Transfer start\n");
+
+	ret = intel_ace2x_bpt_open_stream(sdw, slave, msg);
+	if (ret < 0)
+		return ret;
+
+	ret = hda_sdw_bpt_send_async(cdns->dev->parent, /* PCI device */
+				     sdw->bpt_ctx.bpt_tx_stream, sdw->bpt_ctx.bpt_rx_stream);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s:   hda_sdw_bpt_send_async failed: %d\n",
+			__func__, ret);
+
+		intel_ace2x_bpt_close_stream(sdw, slave, msg);
+
+		return ret;
+	}
+
+	ret = sdw_enable_stream(cdns->bus.bpt_stream);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s: sdw_stream_enable failed: %d\n",
+			__func__, ret);
+		intel_ace2x_bpt_close_stream(sdw, slave, msg);
+	}
+
+	return ret;
+}
+
+static int intel_ace2x_bpt_wait(struct sdw_intel *sdw, struct sdw_slave *slave,
+				struct sdw_bpt_msg *msg)
+{
+	struct sdw_cdns *cdns = &sdw->cdns;
+	int ret;
+
+	dev_dbg(cdns->dev, "BPT Transfer wait\n");
+
+	ret = hda_sdw_bpt_wait(cdns->dev->parent, /* PCI device */
+			       sdw->bpt_ctx.bpt_tx_stream, sdw->bpt_ctx.bpt_rx_stream);
+	if (ret < 0)
+		dev_err(cdns->dev, "%s: hda_sdw_bpt_wait failed: %d\n", __func__, ret);
+
+	ret = sdw_disable_stream(cdns->bus.bpt_stream);
+	if (ret < 0) {
+		dev_err(cdns->dev, "%s: sdw_stream_enable failed: %d\n",
+			__func__, ret);
+		goto err;
+	}
+
+	if (msg->flags & SDW_MSG_FLAG_WRITE) {
+		ret = sdw_cdns_check_write_response(cdns->dev, sdw->bpt_ctx.dmab_rx_bdl.area,
+						    sdw->bpt_ctx.pdi1_buffer_size,
+						    sdw->bpt_ctx.num_frames);
+		if (ret < 0)
+			dev_err(cdns->dev, "%s: BPT Write failed %d\n", __func__, ret);
+	} else {
+		ret = sdw_cdns_check_read_response(cdns->dev, sdw->bpt_ctx.dmab_rx_bdl.area,
+						   sdw->bpt_ctx.pdi1_buffer_size,
+						   msg->buf, msg->len, sdw->bpt_ctx.num_frames,
+						   sdw->bpt_ctx.data_per_frame);
+		if (ret < 0)
+			dev_err(cdns->dev, "%s: BPT Read failed %d\n", __func__, ret);
+	}
+
+err:
+	intel_ace2x_bpt_close_stream(sdw, slave, msg);
+
+	return ret;
+}
+
 /*
  * shim vendor-specific (vs) ops
  */
@@ -753,7 +1061,11 @@ const struct sdw_intel_hw_ops sdw_intel_lnl_hw_ops = {
 	.sync_check_cmdsync_unlocked = intel_check_cmdsync_unlocked,
 
 	.program_sdi = intel_program_sdi,
+
+	.bpt_send_async = intel_ace2x_bpt_send_async,
+	.bpt_wait = intel_ace2x_bpt_wait,
 };
 EXPORT_SYMBOL_NS(sdw_intel_lnl_hw_ops, "SOUNDWIRE_INTEL");
 
 MODULE_IMPORT_NS("SND_SOC_SOF_HDA_MLINK");
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_HDA_SDW_BPT");
-- 
2.43.0


