Return-Path: <linux-kernel+bounces-449495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8488E9F4FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FCD7A4EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80C1F9ED0;
	Tue, 17 Dec 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TA12z7Ut"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F571F9A91;
	Tue, 17 Dec 2024 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450251; cv=none; b=EcZ/JBr46r4NKjXT8QbBzWoBfRTommYwEm2vmdjJO3w6P7A7Cerz5oMJITEV3Nz6mWmYb9wu0nfgAGZrZZBoBxCpL+G0iP7SXUDF0vBCqADx4AmQk57jDE0YJd/OAOe4kdIocd/Eh1eThbtPX6+tIckV0LTRv9vd+GMjNVbhAt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450251; c=relaxed/simple;
	bh=Z+9XCQXqww8E1v5WxQ3JEwgLLVJQhwLlXiI1sp1XKxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRxtS+n/55IRw/xjUvlI27YB7qqpKUVgcA69BGZaiN7Klk1f1NBuj4iu1Zwg2a6bp7OCBkRW+zvQBRT8nVcCjuWpVxi46pN5RMm7W517l+8geJgOiMWg8c1sakMG7KbKFxyEEO2/A6GUgLSOvZBeMjHZrDzB2wCsFLJhnVQKIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TA12z7Ut; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450246;
	bh=Z+9XCQXqww8E1v5WxQ3JEwgLLVJQhwLlXiI1sp1XKxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TA12z7Ut8AGv+aFs7jVhad//ZmUzxDGR+XmS01p/eOVne4pz68np3uEYsOgnIgtb2
	 nY/5FdQKuvtdZLrHaZ2xQBmRXE4fZdvmL3sO9Jmh9lPKrF3w8lKVILuvmuJHeNvJw6
	 bAb+QbpAV0bCJb3ifJ8VwVyQhEZ9EN8mBlQoz9wNTHtyR7kuoAyllrIkd4jxDurXwI
	 gafi0T4yLKaLJoTbCSLc0BvrCW/l9k6GKGNf4MRtoCr+XMVsdtRMMUygVRsFXd0zN2
	 qKxfZN7uQXCChjYe91MOkbfLF6nueh7BSCqfEucH+BsT3CHJ5UXsEjBPl5FuPPb39T
	 lklPksnSCZlkA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 42AF717E37C1;
	Tue, 17 Dec 2024 16:44:05 +0100 (CET)
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
Subject: [PATCH v3 11/33] drm/mediatek: mtk_hdmi: Unregister audio platform device on failure
Date: Tue, 17 Dec 2024 16:43:23 +0100
Message-ID: <20241217154345.276919-12-angelogioacchino.delregno@collabora.com>
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

The probe function of this driver may fail after registering the
audio platform device: in that case, the state is not getting
cleaned up, leaving this device registered.

Adding up to the mix, should the probe function of this driver
return a probe deferral for N times, we're registering up to N
audio platform devices and, again, never freeing them up.

To fix this, add a pointer to the audio platform device in the
mtk_hdmi structure, and add a devm action to unregister it upon
driver removal or probe failure.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 59a8a81fa0ec..9131c2fdfba8 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -172,6 +172,7 @@ struct mtk_hdmi {
 	unsigned int sys_offset;
 	void __iomem *regs;
 	enum hdmi_colorspace csp;
+	struct platform_device *audio_pdev;
 	struct hdmi_audio_param aud_param;
 	bool audio_enable;
 	bool powered;
@@ -1662,6 +1663,11 @@ static const struct hdmi_codec_ops mtk_hdmi_audio_codec_ops = {
 	.no_capture_mute = 1,
 };
 
+static void mtk_hdmi_unregister_audio_driver(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int mtk_hdmi_register_audio_driver(struct device *dev)
 {
 	struct mtk_hdmi *hdmi = dev_get_drvdata(dev);
@@ -1671,13 +1677,22 @@ static int mtk_hdmi_register_audio_driver(struct device *dev)
 		.i2s = 1,
 		.data = hdmi,
 	};
-	struct platform_device *pdev;
+	int ret;
 
-	pdev = platform_device_register_data(dev, HDMI_CODEC_DRV_NAME,
-					     PLATFORM_DEVID_AUTO, &codec_data,
-					     sizeof(codec_data));
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
+	hdmi->audio_pdev = platform_device_register_data(dev,
+							 HDMI_CODEC_DRV_NAME,
+							 PLATFORM_DEVID_AUTO,
+							 &codec_data,
+							 sizeof(codec_data));
+	if (IS_ERR(hdmi->audio_pdev))
+		return PTR_ERR(hdmi->audio_pdev);
+
+	ret = devm_add_action_or_reset(dev, mtk_hdmi_unregister_audio_driver,
+				       hdmi->audio_pdev);
+	if (ret) {
+		platform_device_unregister(hdmi->audio_pdev);
+		return ret;
+	}
 
 	DRM_INFO("%s driver bound to HDMI\n", HDMI_CODEC_DRV_NAME);
 	return 0;
-- 
2.47.0


