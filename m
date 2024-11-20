Return-Path: <linux-kernel+bounces-415756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C29D3B03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCF21F249E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39CC1B3B28;
	Wed, 20 Nov 2024 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WARy+Nyz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2B1AB513;
	Wed, 20 Nov 2024 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106690; cv=none; b=ZPXu8ll6xHBH0Fy75QJLCbZZ5x4hLtB76htkp/byoxT+U0jWLQyNgA+/ICwYv9GdKUZVegENsRssvAU6MzxGL2YL79I+YDy00c0IL7+p9aut4M6z4Vs3rDH/CKj88pOZMO0Sm0yStnC+/27M30QaWqnCOx9Of80FunDhYqZow7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106690; c=relaxed/simple;
	bh=XU/wnJn5rOOj2tXtFjGY4xnpNA41CEbrrt3Wds1VGMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxOZfxCxh0Fv6D5q+VXXD9lJr6mi4Qw3/MxMo2Ko59LrTj08Ezk22bfMhkuUc8bXnDM9MY5W5zJlS+nKc11hHTpkjHxlsVg4r/s8U3xN5ALAqrzCLtj/Mbm+anpmFWZWTfkeNPoq567POf10T7T5sYD5P2SNkplliqmulSnRvDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WARy+Nyz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732106686;
	bh=XU/wnJn5rOOj2tXtFjGY4xnpNA41CEbrrt3Wds1VGMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WARy+Nyz2MTu6GsOwZc/hxARodF4gIhdoDaNG88IIj9EpfJH8TifDjNlx29rb49E2
	 YUNhGOofHLtWip3MYydC9leeSM1HlcTZbqXn3JOq6VUD58Emez4rPETpsR8td53Ux2
	 kpJwXuk7hK6YhH1r2ffYT9ihLGjhprBNjsmLrc4T7iL6rOCMrQ4GYrqaU9KRMpI9oJ
	 OZY5pqy5L949ib02G+amTBPiIgBx0BJK3dM9Xmw9OCnUlggEGY5pse8KStG3j3B500
	 915EUTDlvLhaK5YQ1pJ6Jo3YOPk4Dj5eWEppW1confVgKy5XFl7t9i9HiF0OIpUNWU
	 Z0fOGIghwafAw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AEBF717E3663;
	Wed, 20 Nov 2024 13:44:45 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital Parallel Interface
Date: Wed, 20 Nov 2024 13:44:20 +0100
Message-ID: <20241120124420.133914-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the DPI block found in the MT8195 and MT8188 SoCs.
Inside of the SoC, this block is directly connected to the HDMI IP.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 55 ++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  6 +++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 +
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 79923d1bfbc9..f76d1c5b68bd 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -144,6 +144,7 @@ struct mtk_dpi_factor {
  * @csc_enable_bit: Enable bit of CSC.
  * @pixels_per_iter: Quantity of transferred pixels per iteration.
  * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs to be set in MMSYS.
+ * @is_internal_hdmi: Specifies whether the DPI is internally connected to the HDMI block
  */
 struct mtk_dpi_conf {
 	const struct mtk_dpi_factor *dpi_factor;
@@ -164,6 +165,7 @@ struct mtk_dpi_conf {
 	u32 csc_enable_bit;
 	u32 pixels_per_iter;
 	bool edge_cfg_in_mmsys;
+	bool is_internal_hdmi;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -492,6 +494,7 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 
 	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
+	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
 }
 
@@ -508,6 +511,12 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 		goto err_refcount;
 	}
 
+	ret = clk_prepare_enable(dpi->tvd_clk);
+	if (ret) {
+		dev_err(dpi->dev, "Failed to enable tvd pll: %d\n", ret);
+		goto err_engine;
+	}
+
 	ret = clk_prepare_enable(dpi->pixel_clk);
 	if (ret) {
 		dev_err(dpi->dev, "Failed to enable pixel clock: %d\n", ret);
@@ -517,6 +526,8 @@ static int mtk_dpi_power_on(struct mtk_dpi *dpi)
 	return 0;
 
 err_pixel:
+	clk_disable_unprepare(dpi->tvd_clk);
+err_engine:
 	clk_disable_unprepare(dpi->engine_clk);
 err_refcount:
 	dpi->refcount--;
@@ -584,7 +595,9 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	struct videomode vm = { 0 };
 
 	drm_display_mode_to_videomode(mode, &vm);
-	mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
+
+	if (!dpi->conf->is_internal_hdmi)
+		mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
 
 	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
 	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
@@ -647,10 +660,18 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	if (dpi->conf->support_direct_pin) {
 		mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 		mtk_dpi_config_2n_h_fre(dpi);
-		mtk_dpi_dual_edge(dpi);
+		/* DPI can connect to either an external bridge or the internal HDMI encoder */
+		if (dpi->conf->is_internal_hdmi) {
+			mtk_dpi_mask(dpi, DPI_CON, DPI_OUTPUT_1T1P_EN, DPI_OUTPUT_1T1P_EN);
+			mtk_dpi_mask(dpi, DPI_CON,
+				     dpi->conf->input_2pixel ? DPI_INPUT_2P_EN : 0,
+				     DPI_INPUT_2P_EN);
+		} else {
+			mtk_dpi_dual_edge(dpi);
+		}
 		mtk_dpi_config_disable_edge(dpi);
 	}
-	if (dpi->conf->input_2pixel) {
+	if (dpi->conf->input_2pixel && !dpi->conf->is_internal_hdmi) {
 		mtk_dpi_mask(dpi, DPI_CON, DPINTF_INPUT_2P_EN,
 			     DPINTF_INPUT_2P_EN);
 	}
@@ -919,14 +940,16 @@ void mtk_dpi_start(struct device *dev)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 
-	mtk_dpi_power_on(dpi);
+	if (!dpi->conf->is_internal_hdmi)
+		mtk_dpi_power_on(dpi);
 }
 
 void mtk_dpi_stop(struct device *dev)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 
-	mtk_dpi_power_off(dpi);
+	if (!dpi->conf->is_internal_hdmi)
+		mtk_dpi_power_off(dpi);
 }
 
 unsigned int mtk_dpi_encoder_index(struct device *dev)
@@ -1021,6 +1044,8 @@ static const struct mtk_dpi_factor dpi_factor_mt8195_dp_intf[] = {
 	{ 70000 - 1, 4 }, { 200000 - 1, 2 }, { U32_MAX, 1 }
 };
 
+static const struct mtk_dpi_factor dpi_factor_mt8195_dpi = { U32_MAX, 1 };
+
 static const struct mtk_dpi_conf mt8173_conf = {
 	.dpi_factor = dpi_factor_mt8173,
 	.num_dpi_factor = ARRAY_SIZE(dpi_factor_mt8173),
@@ -1113,6 +1138,25 @@ static const struct mtk_dpi_conf mt8192_conf = {
 	.csc_enable_bit = CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8195_conf = {
+	.dpi_factor = &dpi_factor_mt8195_dpi,
+	.num_dpi_factor = 1,
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
+	.is_internal_hdmi = true,
+	.input_2pixel = true,
+};
+
 static const struct mtk_dpi_conf mt8195_dpintf_conf = {
 	.dpi_factor = dpi_factor_mt8195_dp_intf,
 	.num_dpi_factor = ARRAY_SIZE(dpi_factor_mt8195_dp_intf),
@@ -1216,6 +1260,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
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
index 85be035a209a..a5974ce04359 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -808,6 +808,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8195-dp-intf",
 	  .data = (void *)MTK_DP_INTF },
+	{ .compatible = "mediatek,mt8195-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
-- 
2.47.0


