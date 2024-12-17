Return-Path: <linux-kernel+bounces-449502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97F39F4FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A44188E4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DF31FA8D6;
	Tue, 17 Dec 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ii8i4j5J"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AF1FA260;
	Tue, 17 Dec 2024 15:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450260; cv=none; b=uG1vszQAryqNfbbBNs0TuVTAaan/zBdO2EorcuFamXpgT1eaEayjAAMoFbQcQ4tDEgF3SMYMyAyi60DUcgwsVjLbil/t9Gj/3Akf1hlnDSqw12K25CxF872w+h7hTVPQ5VxjV+nve+MH9RXKBBNZCPx/YSNNkR2ZlawLIdA9fC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450260; c=relaxed/simple;
	bh=94puYrsXUdw6bQ8q7fXiSdHQew11p0Xwb/HnvveUwvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBpeqaYtIJMTwrAuTPBwvjfUpT46ZXSwXNLCGqpnOJzXJuS6k/mqQygnYF+uhtSmci9f1+ICFKNxfFj9W/R4A11wDOimT6PrX31mVKMlJbaQVPL09kktRFHsFiQxxnU79MJKX8YzXDcdJYNDQtk9xBVMFhPk67c1YaQpysjIX2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ii8i4j5J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450256;
	bh=94puYrsXUdw6bQ8q7fXiSdHQew11p0Xwb/HnvveUwvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ii8i4j5JdahH86IoruDxhETLLDFVvQERrI9x3doYjv8j2cK8nJOpaiQ7a8xlF85D+
	 WcgHvOE+AOge9wjtmzKBVXVkqE/YpDsAO64H8IASmlzlKsuR3hQr0gehIXsvnSLz4A
	 //6eREqwaw8ybY7s7QqLuM2i7Jt/fZmsXyvcK01ZpWfrrA/UMeyF1MwFGP6X7zuyUv
	 HkOZkEQWY4r1k9+nztZs4jRTCz2TIR8IV6iXtnE31GU1PFRaQues71lYLztDq/+rF7
	 3TeLJHPolwhj0e/Z0q4uW+wDnBGlMEyIUif3vdASt5Uvlqzbs9yKBgO6IF7/wv5jC3
	 muznxkvIu0YOg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 558E817E37C2;
	Tue, 17 Dec 2024 16:44:15 +0100 (CET)
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
Subject: [PATCH v3 18/33] drm/mediatek: mtk_hdmi: Move vendor/product strings to drm_bridge
Date: Tue, 17 Dec 2024 16:43:30 +0100
Message-ID: <20241217154345.276919-19-angelogioacchino.delregno@collabora.com>
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

Move the vendor and product strings to the appropriate entries
of struct drm_bridge and use that in mtk_hdmi_setup_spd_infoframe
instead of having the same as function parameters.

While at it, also beautify the strings, setting them to read
"MediaTek On-Chip HDMI".

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index ef8dfcb77318..eb38f4b7674e 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -952,15 +952,14 @@ static int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi,
 	return 0;
 }
 
-static int mtk_hdmi_setup_spd_infoframe(struct mtk_hdmi *hdmi,
-					const char *vendor,
-					const char *product)
+static int mtk_hdmi_setup_spd_infoframe(struct mtk_hdmi *hdmi)
 {
+	struct drm_bridge *bridge = &hdmi->bridge;
 	struct hdmi_spd_infoframe frame;
 	u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_SPD_INFOFRAME_SIZE];
 	ssize_t err;
 
-	err = hdmi_spd_infoframe_init(&frame, vendor, product);
+	err = hdmi_spd_infoframe_init(&frame, bridge->vendor, bridge->product);
 	if (err < 0) {
 		dev_err(hdmi->dev, "Failed to initialize SPD infoframe: %zd\n",
 			err);
@@ -1328,7 +1327,7 @@ static void mtk_hdmi_send_infoframe(struct mtk_hdmi *hdmi,
 {
 	mtk_hdmi_setup_audio_infoframe(hdmi);
 	mtk_hdmi_setup_avi_infoframe(hdmi, mode);
-	mtk_hdmi_setup_spd_infoframe(hdmi, "mediatek", "On-chip HDMI");
+	mtk_hdmi_setup_spd_infoframe(hdmi);
 	if (mode->flags & DRM_MODE_FLAG_3D_MASK)
 		mtk_hdmi_setup_vendor_specific_infoframe(hdmi, mode);
 }
@@ -1709,6 +1708,8 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 			 | DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	hdmi->bridge.vendor = "MediaTek";
+	hdmi->bridge.product = "On-Chip HDMI";
 	drm_bridge_add(&hdmi->bridge);
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-- 
2.47.0


