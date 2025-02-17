Return-Path: <linux-kernel+bounces-517994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D274A38874
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E8D16267B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED222A4F1;
	Mon, 17 Feb 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HAWC3cwW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F322A7E1;
	Mon, 17 Feb 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807396; cv=none; b=kTce9d697worQza13gIxXPDIpM4xEAPIhTX4IcczE/TzMET0xWJDBMfcBJ7nA7XHtayhsZZ3dYLE8wUoTzVxSyYyNtGzoo1iWb2SGAj21YpO1E0CwVMTRV0GgWaLRaAgADr/JTy69Y7DUzmI/T3yneZVadGNH4UJkcDp9sQW92o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807396; c=relaxed/simple;
	bh=f7nQ7pLJjDbvo1SJ8gbLJHmaUJThIa20R8RawK/RJU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpBjcrcoAA92dXxbJHlGiMI9abx1b82Qi+LMnZkk+sqTic0oJYg8nDTbCpPxcFYXJ1FGMs/V1L7dGirOPwLy0ZC6L/PDC1TcS4G1xcRgesmdUf/O2b0ry+/TiLvkziN0AQxktibrF4ZpZBciQQFYshjs67JlvvhrsFXkPJJlEmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HAWC3cwW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807392;
	bh=f7nQ7pLJjDbvo1SJ8gbLJHmaUJThIa20R8RawK/RJU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAWC3cwW535cZFt/gKVDzNIWGVQNwynqXYAnNq8WhDVEAMnXJfIWllZixIHbSFeR0
	 vAeUBY/w1yjBL9Bd1rEZcgulgG5Hh7SXN5659enRT7tkUlGUiy5VUU08IcpeXg2Tce
	 n2GfJrPbZFnpscWtMbeqKoND+WWFo5uYAKcbwEhhOJZ7iAp0AzFDO8B6Ar8BTYJiuv
	 GiHy4/an8k+aah+RuYk27dzKfL0uNuZ3tV10XzzcMIp+v+b7CM/MuMou8f949RP6R5
	 jFhHYGw2MgqX8dJVZU6Bwj5st9G6BiIFbB3phGOTRqfPz/5AIPrisJYDLwk7wlQi4V
	 Vt8YhJXGDrhIg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9AC1F17E1554;
	Mon, 17 Feb 2025 16:49:51 +0100 (CET)
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
Subject: [PATCH v7 24/43] drm/mediatek: mtk_hdmi: Move vendor/product strings to drm_bridge
Date: Mon, 17 Feb 2025 16:48:17 +0100
Message-ID: <20250217154836.108895-25-angelogioacchino.delregno@collabora.com>
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

Move the vendor and product strings to the appropriate entries
of struct drm_bridge and use that in mtk_hdmi_setup_spd_infoframe
instead of having the same as function parameters.

While at it, also beautify the strings, setting them to read
"MediaTek On-Chip HDMI".

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index e9f2f15e98fa..4bf19574463d 100644
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
@@ -1707,6 +1706,8 @@ static int mtk_hdmi_probe(struct platform_device *pdev)
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 			 | DRM_BRIDGE_OP_HPD;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+	hdmi->bridge.vendor = "MediaTek";
+	hdmi->bridge.product = "On-Chip HDMI";
 	drm_bridge_add(&hdmi->bridge);
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-- 
2.48.1


