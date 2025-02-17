Return-Path: <linux-kernel+bounces-517991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7100A3886E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239B3174194
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889D822A4CC;
	Mon, 17 Feb 2025 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p7hWSwiW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15362229B01;
	Mon, 17 Feb 2025 15:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807391; cv=none; b=hLBro4CgFt8+iXorBnkTo68oN4HtqhIzxaF4fpgQn1SSvLtRXewbFTDis3aO2oJhZv8EDGsORs7yRqC6FHVb72J8BtV68VIPRo/8OtsQPgTsPEaC2qnQRj6Ini1yfWuZh5oBvMWvWcncpqNg4/liyT5wD0KD/bV91YcsE9MOiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807391; c=relaxed/simple;
	bh=2dasbND+rrNLp+jVYyPAywHrwL3gyHBhQ4dsr0a+LKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4Dr+W8l20/080LdqgXtM3Hn+WstxdCwnyKdli7D/eWQpf1cdktRW5MNokLckx8htu3rcYecs6GbkCNkEttigYD9VrVO1BR8VL/Z7tKiuGd8f4XOCIJvt74rbBLyClFVK4yn+LEVfL7sq6+i1b6Dh1nPb0ykMmdKDtdR/uTqeI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p7hWSwiW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807388;
	bh=2dasbND+rrNLp+jVYyPAywHrwL3gyHBhQ4dsr0a+LKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7hWSwiWHAb9dcg6B8ot+2LntnLq3kmJl/IomHpchFmvDeRN2vStSZLt4IPH4mgS1
	 OI/nzj1AI4/LpR/rCy9cHnxYIhHWpkjK2ogBjJzRUB/NIrKeFj/WtU/7GB8NVC9Fqx
	 bkXhyIQAJB1VGZ7bk2M5HNYgXEcshYMABIOUiCV00kbjxbYCspqaaJJB8fOTXSoEas
	 a1uC5hsIXC8zE5KXnRG6hnIuxy5pR0RPWiQvn4xMChHIPFRFKRg61hW4FXD4Xi/nnC
	 nhdseUx8ugrxghM7xuITlZrw8UcouQLBS8d0oQeTTOBjA6RmSTBIF0gpcFb7ztvpNl
	 is805tzkJgBuA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1DD0017E1564;
	Mon, 17 Feb 2025 16:49:47 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org,
	lewis.liao@mediatek.com,
	ives.chenjh@mediatek.com,
	tommyyl.chen@mediatek.com,
	jason-jh.lin@mediatek.com
Subject: [PATCH v7 21/43] drm/mediatek: mtk_hdmi: Move audio params selection to new function
Date: Mon, 17 Feb 2025 16:48:14 +0100
Message-ID: <20250217154836.108895-22-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
References: <20250217154836.108895-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for splitting common bits of this driver, move the
audio params (codec, sample rate/size, input type, i2s format, etc)
selection to a new function called mtk_hdmi_audio_params().

While at it, also rename "hdmi_params" to "aud_params" both to match
the mtk_hdmi struct member name and to clarify that those parameters
are for HDMI Audio and not for HDMI Video configuration.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 63 ++++++++++++++++-------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 1f90cac112e2..25ea3f3d982b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1465,19 +1465,13 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi,
  * HDMI audio codec callbacks
  */
 
-static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
-				    struct hdmi_codec_daifmt *daifmt,
-				    struct hdmi_codec_params *params)
+static int mtk_hdmi_audio_params(struct mtk_hdmi *hdmi,
+				 struct hdmi_codec_daifmt *daifmt,
+				 struct hdmi_codec_params *params)
 {
-	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
-	struct hdmi_audio_param hdmi_params;
+	struct hdmi_audio_param aud_params = { 0 };
 	unsigned int chan = params->cea.channels;
 
-	if (!hdmi->audio_enable) {
-		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
-		return -EINVAL;
-	}
-
 	dev_dbg(hdmi->dev, "%s: %u Hz, %d bit, %d channels\n", __func__,
 		params->sample_rate, params->sample_width, chan);
 
@@ -1486,16 +1480,16 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 
 	switch (chan) {
 	case 2:
-		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
+		aud_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_2_0;
 		break;
 	case 4:
-		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_4_0;
+		aud_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_4_0;
 		break;
 	case 6:
-		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_5_1;
+		aud_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_5_1;
 		break;
 	case 8:
-		hdmi_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_7_1;
+		aud_params.aud_input_chan_type = HDMI_AUD_CHAN_TYPE_7_1;
 		break;
 	default:
 		dev_err(hdmi->dev, "channel[%d] not supported!\n", chan);
@@ -1519,31 +1513,44 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 
 	switch (daifmt->fmt) {
 	case HDMI_I2S:
-		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
-		hdmi_params.aud_input_type = HDMI_AUD_INPUT_I2S;
-		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
-		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
+		aud_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
+		aud_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		aud_params.aud_input_type = HDMI_AUD_INPUT_I2S;
+		aud_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
+		aud_params.aud_mclk = HDMI_AUD_MCLK_128FS;
 		break;
 	case HDMI_SPDIF:
-		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
-		hdmi_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
-		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
+		aud_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
+		aud_params.aud_sample_size = HDMI_AUDIO_SAMPLE_SIZE_16;
+		aud_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
 		break;
 	default:
 		dev_err(hdmi->dev, "%s: Invalid DAI format %d\n", __func__,
 			daifmt->fmt);
 		return -EINVAL;
 	}
-
-	memcpy(&hdmi_params.codec_params, params,
-	       sizeof(hdmi_params.codec_params));
-	memcpy(&hdmi->aud_param, &hdmi_params, sizeof(hdmi_params));
+	memcpy(&aud_params.codec_params, params, sizeof(aud_params.codec_params));
+	memcpy(&hdmi->aud_param, &aud_params, sizeof(aud_params));
 
 	dev_dbg(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
-		hdmi_params.aud_codec, hdmi_params.aud_input_type,
-		hdmi_params.aud_input_chan_type, hdmi_params.codec_params.sample_rate);
+		aud_params.aud_codec, aud_params.aud_input_type,
+		aud_params.aud_input_chan_type, aud_params.codec_params.sample_rate);
+
+	return 0;
+}
+
+static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
+				    struct hdmi_codec_daifmt *daifmt,
+				    struct hdmi_codec_params *params)
+{
+	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
+
+	if (!hdmi->audio_enable) {
+		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
+		return -EINVAL;
+	}
 
+	mtk_hdmi_audio_params(hdmi, daifmt, params);
 	mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
 
 	return 0;
-- 
2.48.1


