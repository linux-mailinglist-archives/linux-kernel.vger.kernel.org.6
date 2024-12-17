Return-Path: <linux-kernel+bounces-449499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223A9F4FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40708188EAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA421F76A1;
	Tue, 17 Dec 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LYCSsHDs"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C251F9F67;
	Tue, 17 Dec 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450256; cv=none; b=FZPSdhDXTnJ0dC5kQb9PsFt108nkccmM8NfRE6vmjSai+UoXY89i7CUwzdTTA/qqDSjawiqdnS/V9rbhLrEsH+LLDKxbhRhgJ83sMeO62j9gftxW9m3K7vSDnrPCxpzpO1SWRfgKDH6oQTo69EaSAUXtHUrRef9gAljkzml/a3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450256; c=relaxed/simple;
	bh=eGH7M3rcGs9Lf31CwwdH6KTqEaV8ZXyuGZoV79M4nZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+TXaSmP+EtcXVbxnCtpWw4I7WxBb/35nPkXsI9rcFoJe6hfzdpnLnAtN+ILb4j+50g0OLMoloMWvUZQd/9WFuB202rYMR5xzvVMCSIqgjd+2ArsR3dtQZ067LFg62f3ivqnK+dw5/tW3fjrGe3l43hix37/v3M64KjJ4R4hNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LYCSsHDs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450252;
	bh=eGH7M3rcGs9Lf31CwwdH6KTqEaV8ZXyuGZoV79M4nZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYCSsHDsf/G6D1VF6NX7VX/+AJ+Kq7k1DGDDQ/Y7mqgeHYdLS8iqsJhuS1NTb3JCu
	 pmGivBuVr3d7t3QODA4loU7RPouiIelqfthKoopYx4yN+PpwQ2g2J4wVOVmXxAU7WU
	 ThhVjYubcp2toTc6xiFCf6LkExonzW/y0dKmleF5DIu7lPP26PRozkf1GE2rtHD3zj
	 KqhPNVwdgsoXpfuTou7at4N23mX8ZdK2Ex0jssLmSrKrUPBB5sYQzK5KTBAs/pNBi4
	 EBiQVjaGzZACQvY+heq11mZvhfU3K3IvriRcwcFb/7ptTT7KySjWdUqpnP3gm4YPOu
	 9O62XeOsJEUPw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0A3F617E37A7;
	Tue, 17 Dec 2024 16:44:10 +0100 (CET)
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
	dmitry.baryshkov@linaro.org
Subject: [PATCH v3 15/33] drm/mediatek: mtk_hdmi: Disgregate function mtk_hdmi_audio_set_param()
Date: Tue, 17 Dec 2024 16:43:27 +0100
Message-ID: <20241217154345.276919-16-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
References: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a cleanup, and in preparation for splitting common bits of this
driver, disgregate the code in function mtk_hdmi_audio_set_param()
between mtk_hdmi_audio_params() and mtk_hdmi_audio_hw_params().

The generic hdmi_audio_param copy now gets performed in the former,
and the IP specific mtk_hdmi_aud_output_config() gets called in the
latter, allowing all of the non IP version specific code to get
moved in a common file later.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 8f5ab97a0261..a927d9889818 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1054,20 +1054,6 @@ static void mtk_hdmi_audio_disable(struct mtk_hdmi *hdmi)
 	hdmi->audio_enable = false;
 }
 
-static int mtk_hdmi_audio_set_param(struct mtk_hdmi *hdmi,
-				    struct hdmi_audio_param *param)
-{
-	if (!hdmi->audio_enable) {
-		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
-		return -EINVAL;
-	}
-	dev_dbg(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
-		param->aud_codec, param->aud_input_type,
-		param->aud_input_chan_type, param->codec_params.sample_rate);
-	memcpy(&hdmi->aud_param, param, sizeof(*param));
-	return mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
-}
-
 static int mtk_hdmi_output_set_display_mode(struct mtk_hdmi *hdmi,
 					    struct drm_display_mode *mode)
 {
@@ -1544,6 +1530,11 @@ static int mtk_hdmi_audio_params(struct mtk_hdmi *hdmi,
 		return -EINVAL;
 	}
 	memcpy(&aud_params.codec_params, params, sizeof(aud_params.codec_params));
+	memcpy(&hdmi->aud_param, &aud_params, sizeof(aud_params));
+
+	dev_dbg(hdmi->dev, "codec:%d, input:%d, channel:%d, fs:%d\n",
+		aud_params.aud_codec, aud_params.aud_input_type,
+		aud_params.aud_input_chan_type, aud_params.codec_params.sample_rate);
 
 	return 0;
 }
@@ -1553,10 +1544,14 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
 				    struct hdmi_codec_params *params)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
-	struct hdmi_audio_param hdmi_params;
+
+	if (!hdmi->audio_enable) {
+		dev_err(hdmi->dev, "hdmi audio is in disable state!\n");
+		return -EINVAL;
+	}
 
 	mtk_hdmi_audio_params(hdmi, daifmt, params);
-	mtk_hdmi_audio_set_param(hdmi, &hdmi_params);
+	mtk_hdmi_aud_output_config(hdmi, &hdmi->mode);
 
 	return 0;
 }
-- 
2.47.0


