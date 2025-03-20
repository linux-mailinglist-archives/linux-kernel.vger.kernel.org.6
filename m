Return-Path: <linux-kernel+bounces-569646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24831A6A59E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6EC1882F49
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2684223311;
	Thu, 20 Mar 2025 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R5GlhjY+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B282222D7;
	Thu, 20 Mar 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471588; cv=none; b=t+/ufxmGNc0sBgZW6F2w0rfgvPTqIoja8Xs56PuA2f0P90uPSsYQ+gChOh/qwwI+uN85QU74GdyovH02SxoebDWJtyeAjm9uZ1rvFBQ3SHOSBB+PZD7XTFqmPkh17dNN9xdkqWchAYgbGMdEcFzoch4INu14S5cPhZZTwwJ6OwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471588; c=relaxed/simple;
	bh=DFmnp1QXbp1zbNyOMComr+3s6U/bXRD/s4yTBs1ypYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l65fUjXVWXYIZ4DvA3/+txBAcEUbu/dcJcUJqq4HvodCTVzFEwa7iGIshR7OUzQfuDrWyg9F7KiIwn5Wpfxcj762quyc9kmYQoEw+oGJZwX5dkrORr2LHVhz0YHJdrc7uI+oKL7ba1+gcu6AgyNsWQO66nIgykvyihM72ISy9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R5GlhjY+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742471584;
	bh=DFmnp1QXbp1zbNyOMComr+3s6U/bXRD/s4yTBs1ypYc=;
	h=From:To:Cc:Subject:Date:From;
	b=R5GlhjY+u51qyjEOA6bkO0AHVE5C3U61OEgOqFcm8Dsf/4GLoP+DdkoICRcu7dese
	 N40VkYjRidSNb/DYxkRXDPnRaIvhKzLH7/hD2Vui+SVqSoelC7n5L9pQBoPJ7UlJ0/
	 GVz1ZjPfn3x/FcrIg9aC8PSNCFT69meE2YHWhUErSh4VRzXKdVGfqvE0NwchbXpqAL
	 5xmxlK5Y37C5tCDjZKccNoIndYvqj2Loih9kFhiUD/PHq6Ak/0ZTEaGKKFUHugrrrj
	 tg0D5PJM6Er2ogsxcJj60gkaOTqwJJ23cLj+qZiwd+l3+Ldfog8zOtsdOpkaJQkitB
	 1C2NUEiUOAPfg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BBC6D17E017D;
	Thu, 20 Mar 2025 12:53:02 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: lgirdwood@gmail.com
Cc: peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	daniel.baluta@nxp.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	christophe.jaillet@wanadoo.fr,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	krzk@kernel.org,
	lee.lockhey@gmail.com,
	u.kleine-koenig@baylibre.com,
	cujomalainey@chromium.org,
	jakiela@google.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] ASoC: SOF: mediatek: Commonize duplicated functions
Date: Thu, 20 Mar 2025 12:53:00 +0100
Message-ID: <20250320115300.137410-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to reduce duplication, move the ADSP mailbox callbacks
handle_reply(), handle_request(), and other common SOF callbacks
send_msg(), get_bar_index(), pcm_hw_params() and pcm_pointer()
to the mtk-adsp-common.c file.

This cleanup brings no functional differences.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 sound/soc/sof/mediatek/mt8186/mt8186.c   | 105 ++----------------
 sound/soc/sof/mediatek/mt8195/mt8195.c   | 105 ++----------------
 sound/soc/sof/mediatek/mtk-adsp-common.c | 130 +++++++++++++++++++++++
 sound/soc/sof/mediatek/mtk-adsp-common.h |  10 ++
 4 files changed, 152 insertions(+), 198 deletions(-)

diff --git a/sound/soc/sof/mediatek/mt8186/mt8186.c b/sound/soc/sof/mediatek/mt8186/mt8186.c
index 31437fdd4e92..a5291099493e 100644
--- a/sound/soc/sof/mediatek/mt8186/mt8186.c
+++ b/sound/soc/sof/mediatek/mt8186/mt8186.c
@@ -22,7 +22,6 @@
 #include <sound/sof/xtensa.h>
 #include "../../ops.h"
 #include "../../sof-of-dev.h"
-#include "../../sof-audio.h"
 #include "../adsp_helper.h"
 #include "../mtk-adsp-common.h"
 #include "mt8186.h"
@@ -38,53 +37,9 @@ static int mt8186_get_window_offset(struct snd_sof_dev *sdev, u32 id)
 	return MBOX_OFFSET;
 }
 
-static int mt8186_send_msg(struct snd_sof_dev *sdev,
-			   struct snd_sof_ipc_msg *msg)
-{
-	struct adsp_priv *priv = sdev->pdata->hw_pdata;
-
-	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
-			  msg->msg_size);
-
-	return mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_REQ, MTK_ADSP_IPC_OP_REQ);
-}
-
-static void mt8186_dsp_handle_reply(struct mtk_adsp_ipc *ipc)
-{
-	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
-	unsigned long flags;
-
-	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
-	snd_sof_ipc_process_reply(priv->sdev, 0);
-	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
-}
-
-static void mt8186_dsp_handle_request(struct mtk_adsp_ipc *ipc)
-{
-	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
-	u32 p; /* panic code */
-	int ret;
-
-	/* Read the message from the debug box. */
-	sof_mailbox_read(priv->sdev, priv->sdev->debug_box.offset + 4,
-			 &p, sizeof(p));
-
-	/* Check to see if the message is a panic code 0x0dead*** */
-	if ((p & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
-		snd_sof_dsp_panic(priv->sdev, p, true);
-	} else {
-		snd_sof_ipc_msgs_rx(priv->sdev);
-
-		/* tell DSP cmd is done */
-		ret = mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_RSP, MTK_ADSP_IPC_OP_RSP);
-		if (ret)
-			dev_err(priv->dev, "request send ipc failed");
-	}
-}
-
 static const struct mtk_adsp_ipc_ops dsp_ops = {
-	.handle_reply		= mt8186_dsp_handle_reply,
-	.handle_request		= mt8186_dsp_handle_request,
+	.handle_reply		= mtk_adsp_handle_reply,
+	.handle_request		= mtk_adsp_handle_request,
 };
 
 static int platform_parse_resource(struct platform_device *pdev, void *data)
@@ -381,54 +336,6 @@ static int mt8186_dsp_resume(struct snd_sof_dev *sdev)
 	return ret;
 }
 
-/* on mt8186 there is 1 to 1 match between type and BAR idx */
-static int mt8186_get_bar_index(struct snd_sof_dev *sdev, u32 type)
-{
-	return type;
-}
-
-static int mt8186_pcm_hw_params(struct snd_sof_dev *sdev,
-				struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params,
-				struct snd_sof_platform_stream_params *platform_params)
-{
-	platform_params->cont_update_posn = 1;
-
-	return 0;
-}
-
-static snd_pcm_uframes_t mt8186_pcm_pointer(struct snd_sof_dev *sdev,
-					    struct snd_pcm_substream *substream)
-{
-	int ret;
-	snd_pcm_uframes_t pos;
-	struct snd_sof_pcm *spcm;
-	struct sof_ipc_stream_posn posn;
-	struct snd_sof_pcm_stream *stream;
-	struct snd_soc_component *scomp = sdev->component;
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-
-	spcm = snd_sof_find_spcm_dai(scomp, rtd);
-	if (!spcm) {
-		dev_warn_ratelimited(sdev->dev, "warn: can't find PCM with DAI ID %d\n",
-				     rtd->dai_link->id);
-		return 0;
-	}
-
-	stream = &spcm->stream[substream->stream];
-	ret = snd_sof_ipc_msg_data(sdev, stream, &posn, sizeof(posn));
-	if (ret < 0) {
-		dev_warn(sdev->dev, "failed to read stream position: %d\n", ret);
-		return 0;
-	}
-
-	memcpy(&stream->posn, &posn, sizeof(posn));
-	pos = spcm->stream[substream->stream].posn.host_posn;
-	pos = bytes_to_frames(substream->runtime, pos);
-
-	return pos;
-}
-
 static void mt8186_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	u32 dbg_pc, dbg_data, dbg_inst, dbg_ls0stat, dbg_status, faultinfo;
@@ -505,19 +412,19 @@ static const struct snd_sof_dsp_ops sof_mt8186_ops = {
 	.read64		= sof_io_read64,
 
 	/* ipc */
-	.send_msg		= mt8186_send_msg,
+	.send_msg		= mtk_adsp_send_msg,
 	.get_mailbox_offset	= mt8186_get_mailbox_offset,
 	.get_window_offset	= mt8186_get_window_offset,
 	.ipc_msg_data		= sof_ipc_msg_data,
 	.set_stream_data_offset = sof_set_stream_data_offset,
 
 	/* misc */
-	.get_bar_index	= mt8186_get_bar_index,
+	.get_bar_index	= mtk_adsp_get_bar_index,
 
 	/* stream callbacks */
 	.pcm_open	= sof_stream_pcm_open,
-	.pcm_hw_params	= mt8186_pcm_hw_params,
-	.pcm_pointer	= mt8186_pcm_pointer,
+	.pcm_hw_params	= mtk_adsp_stream_pcm_hw_params,
+	.pcm_pointer	= mtk_adsp_stream_pcm_pointer,
 	.pcm_close	= sof_stream_pcm_close,
 
 	/* firmware loading */
diff --git a/sound/soc/sof/mediatek/mt8195/mt8195.c b/sound/soc/sof/mediatek/mt8195/mt8195.c
index 371563d7ce79..498d417e2829 100644
--- a/sound/soc/sof/mediatek/mt8195/mt8195.c
+++ b/sound/soc/sof/mediatek/mt8195/mt8195.c
@@ -22,7 +22,6 @@
 #include <sound/sof/xtensa.h>
 #include "../../ops.h"
 #include "../../sof-of-dev.h"
-#include "../../sof-audio.h"
 #include "../adsp_helper.h"
 #include "../mtk-adsp-common.h"
 #include "mt8195.h"
@@ -38,53 +37,9 @@ static int mt8195_get_window_offset(struct snd_sof_dev *sdev, u32 id)
 	return MBOX_OFFSET;
 }
 
-static int mt8195_send_msg(struct snd_sof_dev *sdev,
-			   struct snd_sof_ipc_msg *msg)
-{
-	struct adsp_priv *priv = sdev->pdata->hw_pdata;
-
-	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
-			  msg->msg_size);
-
-	return mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_REQ, MTK_ADSP_IPC_OP_REQ);
-}
-
-static void mt8195_dsp_handle_reply(struct mtk_adsp_ipc *ipc)
-{
-	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
-	unsigned long flags;
-
-	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
-	snd_sof_ipc_process_reply(priv->sdev, 0);
-	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
-}
-
-static void mt8195_dsp_handle_request(struct mtk_adsp_ipc *ipc)
-{
-	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
-	u32 p; /* panic code */
-	int ret;
-
-	/* Read the message from the debug box. */
-	sof_mailbox_read(priv->sdev, priv->sdev->debug_box.offset + 4,
-			 &p, sizeof(p));
-
-	/* Check to see if the message is a panic code 0x0dead*** */
-	if ((p & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
-		snd_sof_dsp_panic(priv->sdev, p, true);
-	} else {
-		snd_sof_ipc_msgs_rx(priv->sdev);
-
-		/* tell DSP cmd is done */
-		ret = mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_RSP, MTK_ADSP_IPC_OP_RSP);
-		if (ret)
-			dev_err(priv->dev, "request send ipc failed");
-	}
-}
-
 static const struct mtk_adsp_ipc_ops dsp_ops = {
-	.handle_reply		= mt8195_dsp_handle_reply,
-	.handle_request		= mt8195_dsp_handle_request,
+	.handle_reply		= mtk_adsp_handle_reply,
+	.handle_request		= mtk_adsp_handle_request,
 };
 
 static int platform_parse_resource(struct platform_device *pdev, void *data)
@@ -400,54 +355,6 @@ static int mt8195_dsp_resume(struct snd_sof_dev *sdev)
 	return ret;
 }
 
-/* on mt8195 there is 1 to 1 match between type and BAR idx */
-static int mt8195_get_bar_index(struct snd_sof_dev *sdev, u32 type)
-{
-	return type;
-}
-
-static int mt8195_pcm_hw_params(struct snd_sof_dev *sdev,
-				struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params,
-				struct snd_sof_platform_stream_params *platform_params)
-{
-	platform_params->cont_update_posn = 1;
-
-	return 0;
-}
-
-static snd_pcm_uframes_t mt8195_pcm_pointer(struct snd_sof_dev *sdev,
-					    struct snd_pcm_substream *substream)
-{
-	int ret;
-	snd_pcm_uframes_t pos;
-	struct snd_sof_pcm *spcm;
-	struct sof_ipc_stream_posn posn;
-	struct snd_sof_pcm_stream *stream;
-	struct snd_soc_component *scomp = sdev->component;
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-
-	spcm = snd_sof_find_spcm_dai(scomp, rtd);
-	if (!spcm) {
-		dev_warn_ratelimited(sdev->dev, "warn: can't find PCM with DAI ID %d\n",
-				     rtd->dai_link->id);
-		return 0;
-	}
-
-	stream = &spcm->stream[substream->stream];
-	ret = snd_sof_ipc_msg_data(sdev, stream, &posn, sizeof(posn));
-	if (ret < 0) {
-		dev_warn(sdev->dev, "failed to read stream position: %d\n", ret);
-		return 0;
-	}
-
-	memcpy(&stream->posn, &posn, sizeof(posn));
-	pos = spcm->stream[substream->stream].posn.host_posn;
-	pos = bytes_to_frames(substream->runtime, pos);
-
-	return pos;
-}
-
 static void mt8195_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 {
 	u32 dbg_pc, dbg_data, dbg_bus0, dbg_bus1, dbg_inst;
@@ -529,19 +436,19 @@ static const struct snd_sof_dsp_ops sof_mt8195_ops = {
 	.read64		= sof_io_read64,
 
 	/* ipc */
-	.send_msg		= mt8195_send_msg,
+	.send_msg		= mtk_adsp_send_msg,
 	.get_mailbox_offset	= mt8195_get_mailbox_offset,
 	.get_window_offset	= mt8195_get_window_offset,
 	.ipc_msg_data		= sof_ipc_msg_data,
 	.set_stream_data_offset = sof_set_stream_data_offset,
 
 	/* misc */
-	.get_bar_index	= mt8195_get_bar_index,
+	.get_bar_index	= mtk_adsp_get_bar_index,
 
 	/* stream callbacks */
 	.pcm_open	= sof_stream_pcm_open,
-	.pcm_hw_params	= mt8195_pcm_hw_params,
-	.pcm_pointer	= mt8195_pcm_pointer,
+	.pcm_hw_params	= mtk_adsp_stream_pcm_hw_params,
+	.pcm_pointer	= mtk_adsp_stream_pcm_pointer,
 	.pcm_close	= sof_stream_pcm_close,
 
 	/* firmware loading */
diff --git a/sound/soc/sof/mediatek/mtk-adsp-common.c b/sound/soc/sof/mediatek/mtk-adsp-common.c
index 20bcf5590eb8..01bbadb160ff 100644
--- a/sound/soc/sof/mediatek/mtk-adsp-common.c
+++ b/sound/soc/sof/mediatek/mtk-adsp-common.c
@@ -12,8 +12,11 @@
  */
 
 #include <linux/module.h>
+#include <sound/asound.h>
 #include <sound/sof/xtensa.h>
 #include "../ops.h"
+#include "../sof-audio.h"
+#include "adsp_helper.h"
 #include "mtk-adsp-common.h"
 
 /**
@@ -81,5 +84,132 @@ void mtk_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
 }
 EXPORT_SYMBOL(mtk_adsp_dump);
 
+/**
+ * mtk_adsp_send_msg - Send message to Audio DSP
+ * @sdev: SOF device
+ * @msg: SOF IPC Message to send
+ */
+int mtk_adsp_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
+			  msg->msg_size);
+
+	return mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_REQ, MTK_ADSP_IPC_OP_REQ);
+}
+EXPORT_SYMBOL(mtk_adsp_send_msg);
+
+/**
+ * mtk_adsp_handle_reply - Handle reply from the Audio DSP through Mailbox
+ * @ipc: ADSP IPC handle
+ */
+void mtk_adsp_handle_reply(struct mtk_adsp_ipc *ipc)
+{
+	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
+	snd_sof_ipc_process_reply(priv->sdev, 0);
+	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
+}
+EXPORT_SYMBOL(mtk_adsp_handle_reply);
+
+/**
+ * mtk_adsp_handle_request - Handle request from the Audio DSP through Mailbox
+ * @ipc: ADSP IPC handle
+ */
+void mtk_adsp_handle_request(struct mtk_adsp_ipc *ipc)
+{
+	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
+	u32 panic_code;
+	int ret;
+
+	/* Read the message from the debug box. */
+	sof_mailbox_read(priv->sdev, priv->sdev->debug_box.offset + 4,
+			 &panic_code, sizeof(panic_code));
+
+	/* Check to see if the message is a panic code 0x0dead*** */
+	if ((panic_code & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
+		snd_sof_dsp_panic(priv->sdev, panic_code, true);
+	} else {
+		snd_sof_ipc_msgs_rx(priv->sdev);
+
+		/* Tell DSP cmd is done */
+		ret = mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_RSP, MTK_ADSP_IPC_OP_RSP);
+		if (ret)
+			dev_err(priv->dev, "request send ipc failed");
+	}
+}
+EXPORT_SYMBOL(mtk_adsp_handle_request);
+
+/**
+ * mtk_adsp_get_bar_index - Map section type with BAR idx
+ * @sdev: SOF device
+ * @type: Section type as described by snd_sof_fw_blk_type
+ *
+ * MediaTek Audio DSPs have a 1:1 match between type and BAR idx
+ */
+int mtk_adsp_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+{
+	return type;
+}
+EXPORT_SYMBOL(mtk_adsp_get_bar_index);
+
+/**
+ * mtk_adsp_stream_pcm_hw_params - Platform specific host stream hw params
+ * @sdev: SOF device
+ * @substream: PCM Substream
+ * @params: hw params
+ * @platform_params: Platform specific SOF stream parameters
+ */
+int mtk_adsp_stream_pcm_hw_params(struct snd_sof_dev *sdev,
+				  struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_sof_platform_stream_params *platform_params)
+{
+	platform_params->cont_update_posn = 1;
+	return 0;
+}
+EXPORT_SYMBOL(mtk_adsp_stream_pcm_hw_params);
+
+/**
+ * mtk_adsp_stream_pcm_pointer - Get host stream pointer
+ * @sdev: SOF device
+ * @substream: PCM substream
+ */
+snd_pcm_uframes_t mtk_adsp_stream_pcm_pointer(struct snd_sof_dev *sdev,
+					      struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_component *scomp = sdev->component;
+	struct snd_sof_pcm_stream *stream;
+	struct sof_ipc_stream_posn posn;
+	struct snd_sof_pcm *spcm;
+	snd_pcm_uframes_t pos;
+	int ret;
+
+	spcm = snd_sof_find_spcm_dai(scomp, rtd);
+	if (!spcm) {
+		dev_warn_ratelimited(sdev->dev, "warn: can't find PCM with DAI ID %d\n",
+				     rtd->dai_link->id);
+		return 0;
+	}
+
+	stream = &spcm->stream[substream->stream];
+	ret = snd_sof_ipc_msg_data(sdev, stream, &posn, sizeof(posn));
+	if (ret < 0) {
+		dev_warn(sdev->dev, "failed to read stream position: %d\n", ret);
+		return 0;
+	}
+
+	memcpy(&stream->posn, &posn, sizeof(posn));
+	pos = spcm->stream[substream->stream].posn.host_posn;
+	pos = bytes_to_frames(substream->runtime, pos);
+
+	return pos;
+}
+EXPORT_SYMBOL(mtk_adsp_stream_pcm_pointer);
+
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("SOF helpers for MTK ADSP platforms");
diff --git a/sound/soc/sof/mediatek/mtk-adsp-common.h b/sound/soc/sof/mediatek/mtk-adsp-common.h
index 612cff1f38f7..dc36b91d6779 100644
--- a/sound/soc/sof/mediatek/mtk-adsp-common.h
+++ b/sound/soc/sof/mediatek/mtk-adsp-common.h
@@ -7,4 +7,14 @@
 #define MTK_ADSP_STACK_DUMP_SIZE 32
 
 void mtk_adsp_dump(struct snd_sof_dev *sdev, u32 flags);
+int mtk_adsp_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg);
+void mtk_adsp_handle_reply(struct mtk_adsp_ipc *ipc);
+void mtk_adsp_handle_request(struct mtk_adsp_ipc *ipc);
+int mtk_adsp_get_bar_index(struct snd_sof_dev *sdev, u32 type);
+int mtk_adsp_stream_pcm_hw_params(struct snd_sof_dev *sdev,
+				  struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_sof_platform_stream_params *platform_params);
+snd_pcm_uframes_t mtk_adsp_stream_pcm_pointer(struct snd_sof_dev *sdev,
+					      struct snd_pcm_substream *substream);
 #endif
-- 
2.48.1


