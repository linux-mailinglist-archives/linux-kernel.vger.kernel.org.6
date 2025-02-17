Return-Path: <linux-kernel+bounces-517979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BFA38851
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACCD174B13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D6122686F;
	Mon, 17 Feb 2025 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PGVoVI3w"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C622253BB;
	Mon, 17 Feb 2025 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807375; cv=none; b=mqYdclqKGEY9ab5x/tWJvtaolN0Ciich1Lkyio0D9RO7l5bXqTGqKHzPkOq9yZIWxhi5DH5N/9IyZBAD06GgOt1CxQ59z3OBu0MThwIuZd7iE4Ytgrx8OPb8Om3hoQoSoRCDilz+ir5xNnJMabm6QJ5gCsm6a/1KaY1tBwX1jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807375; c=relaxed/simple;
	bh=knRuGa81CVJP9wj5k7dwCwWYzcVeBaPor4o45VZxJc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TT3xEIKu1xknDs5kcO2/UldMlpIUQ0iKFCxs7BW7Ukfhc/1dN+8Q1DCAjUd/Qi1ItRUhPT1JFIB/hLWPtyDEk/t0UCa3N9h6fuVQ6YDg15wdey0ZQspofyHq3XwCkN7piVEYitmQfKiK2E9u4vlpzige3MmbvYAvC6CUNfB3M/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PGVoVI3w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807371;
	bh=knRuGa81CVJP9wj5k7dwCwWYzcVeBaPor4o45VZxJc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGVoVI3w6K2/LCMr/2mhdL8x5YyX3RnQL3K/AOvkd18W1AySZSzf0cJo+Ez+CT4yt
	 M7M5aB14hJEuPipMG3XcPE8n0V2ydJoWY/8sHyceVs1tFgIcOMiVMXCUT+nIE9bPki
	 Qpt10M3ot0s15D9FFSi32uRT16cmimxIttK+RjAVeQosezmgXZDYDX2Q9aMD6cgAXy
	 1budqOOcy3+4srbXerQSsunun3H6aXNaYNHbulWXW12pjD6qO3uz/X+AO8vtQ7wR7c
	 HVqKfCdh+dL68uc0fgpYiqgPGdJAQ0KXBwBYAoRCuaDSgjpPxBF3t5fHsjdP0Cnhy1
	 S6FbgK27/hLNw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D39217E156E;
	Mon, 17 Feb 2025 16:49:30 +0100 (CET)
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
Subject: [PATCH v7 10/43] drm/mediatek: Add support for MT8195 Digital Parallel Interface
Date: Mon, 17 Feb 2025 16:48:03 +0100
Message-ID: <20250217154836.108895-11-angelogioacchino.delregno@collabora.com>
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

Add support for the DPI block found in the MT8195 and MT8188 SoCs.
Inside of the SoC, this block is directly connected to the HDMI IP.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 19 +++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  6 ++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
 3 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index ee952785866c..d066fbd6ffb6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1139,6 +1139,24 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.csc_enable_bit = CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8195_conf = {
+	.max_clock_khz = 594000,
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
+	.pixels_per_iter = 1,
+	.is_ck_de_pol = true,
+	.swap_input_support = true,
+	.support_direct_pin = true,
+	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
+	.input_2p_en_bit = DPI_INPUT_2P_EN,
+	.clocked_by_hdmi = true,
+	.output_1pixel = true,
+};
+
 static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.dpi_factor = dpi_factor_mt8195_dp_intf,
 	.num_dpi_factor = ARRAY_SIZE(dpi_factor_mt8195_dp_intf),
@@ -1242,6 +1260,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-dp-intf", .data = &mt8195_dpintf_conf },
 	{ .compatible = "mediatek,mt8192-dpi", .data = &mt8192_conf },
 	{ .compatible = "mediatek,mt8195-dp-intf", .data = &mt8195_dpintf_conf },
+	{ .compatible = "mediatek,mt8195-dpi", .data = &mt8195_conf },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index a0b1d18bbbf7..3c24d9e9f241 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -40,6 +40,12 @@
 #define FAKE_DE_LEVEN			BIT(21)
 #define FAKE_DE_RODD			BIT(22)
 #define FAKE_DE_REVEN			BIT(23)
+
+/* DPI_CON: DPI instances */
+#define DPI_OUTPUT_1T1P_EN		BIT(24)
+#define DPI_INPUT_2P_EN			BIT(25)
+
+/* DPI_CON: DPINTF instances */
 #define DPINTF_YUV422_EN		BIT(24)
 #define DPINTF_CSC_ENABLE		BIT(26)
 #define DPINTF_INPUT_2P_EN		BIT(29)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index f22ad2882697..772c3d0f5d14 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -810,6 +810,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8195-dp-intf",
 	  .data = (void *)MTK_DP_INTF },
+	{ .compatible = "mediatek,mt8195-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
-- 
2.48.1


