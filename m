Return-Path: <linux-kernel+bounces-449488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 736E39F4FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EE697A2004
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE80E1F8938;
	Tue, 17 Dec 2024 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iYiRBAlk"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA31F8698;
	Tue, 17 Dec 2024 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450240; cv=none; b=Atk0+/d4ILSEVa6Ta3cfakjr2BX0zqhRSgesofxGF1fvkmjdVOddjo5xWh6qweLkFIu7cwiLP4LCd/9EDHLWjypcxpRtlbejRqEfAG8+lDqKyxPOg3zx4cT6turKhNXStw9OUV6gSzZjP4q3+iznOAxWWAsKnXWcUeZq3MAB9pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450240; c=relaxed/simple;
	bh=/wkXCQgq780ps7SnGwu3J/11iwt1877SD12VoMHojdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxBWyU5DYnKGiFYb2vYjb2NvsU/aYgB+CsBKHtEnq7FnPzmB4cj52pe2pk5zQZSS9Z+rUHtm2/+UuqZi6Hr+aYbWbTj55r5V8N+Fp6SDveWCAZ0+7uICYqcnNczWeNvssjp3ZuTH9nb8xKnC5WndgzJErVJqvMhB65/aj8NcA8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iYiRBAlk; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450236;
	bh=/wkXCQgq780ps7SnGwu3J/11iwt1877SD12VoMHojdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYiRBAlkoiXdOd0oodHEghe6olE/xiPro8O1c3+NDR8er7nFyCo9yE6guz5+Ngbmn
	 hBWADSQekqbx0Nkm6MGzUnj4imOHX6Zdpah/MtyyOtk/4KaJYtM06n9CZBn91RH7Xv
	 UQ8uSjAmatUqPrjjnKGCroW4oNACgOwDHYA65JaTP0LsaBHQA4HwxtvnKkBsMPiVbn
	 wms0VUy2R6p3G4a97QGRcqI2qMDf6dTaYy4fm5ALGCRPBIEVbqOsqiTzyMXttpMHLm
	 VqF50WNZ24sa31uA3w1uFPRJr+r5ONtMVPUEP6g9HaingSvp46Bx8NuCwX1GnsUAH7
	 WhzFcpfkpikeQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 39F1417E37A7;
	Tue, 17 Dec 2024 16:43:55 +0100 (CET)
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
Subject: [PATCH v3 04/33] drm/mediatek: mtk_dpi: Move pixel clock setting flow to function
Date: Tue, 17 Dec 2024 16:43:16 +0100
Message-ID: <20241217154345.276919-5-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for the DPI IP found in MT8195
and in MT8188 used for HDMI, move the code flow for calculation
and setting of the DPI pixel clock to a separate function called
mtk_dpi_set_pixel_clk().

This was done because, on those platforms, the DPI instance that
is used for HDMI will get its pixel clock from the HDMI clock,
hence it is not necessary, nor desirable, to calculate or set
the pixel clock in DPI.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 43 +++++++++++++++++-------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 3bdce932f910..f931baf9c3fa 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -536,26 +536,17 @@ static unsigned int mtk_dpi_calculate_factor(struct mtk_dpi *dpi, int mode_clk)
 	return dpi_factor[dpi->conf->num_dpi_factor - 1].factor;
 }
 
-static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
-				    struct drm_display_mode *mode)
+static void mtk_dpi_set_pixel_clk(struct mtk_dpi *dpi, struct videomode *vm, int mode_clk)
 {
-	struct mtk_dpi_polarities dpi_pol;
-	struct mtk_dpi_sync_param hsync;
-	struct mtk_dpi_sync_param vsync_lodd = { 0 };
-	struct mtk_dpi_sync_param vsync_leven = { 0 };
-	struct mtk_dpi_sync_param vsync_rodd = { 0 };
-	struct mtk_dpi_sync_param vsync_reven = { 0 };
-	struct videomode vm = { 0 };
 	unsigned long pll_rate;
 	unsigned int factor;
 
 	/* let pll_rate can fix the valid range of tvdpll (1G~2GHz) */
 	factor = mtk_dpi_calculate_factor(dpi, mode_clk);
-	drm_display_mode_to_videomode(mode, &vm);
-	pll_rate = vm.pixelclock * factor;
+	pll_rate = vm->pixelclock * factor;
 
 	dev_dbg(dpi->dev, "Want PLL %lu Hz, pixel clock %lu Hz\n",
-		pll_rate, vm.pixelclock);
+		pll_rate, vm->pixelclock);
 
 	clk_set_rate(dpi->tvd_clk, pll_rate);
 	pll_rate = clk_get_rate(dpi->tvd_clk);
@@ -565,20 +556,34 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	 * pixels for each iteration: divide the clock by this number and
 	 * adjust the display porches accordingly.
 	 */
-	vm.pixelclock = pll_rate / factor;
-	vm.pixelclock /= dpi->conf->pixels_per_iter;
+	vm->pixelclock = pll_rate / factor;
+	vm->pixelclock /= dpi->conf->pixels_per_iter;
 
 	if ((dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_LE) ||
 	    (dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_BE))
-		clk_set_rate(dpi->pixel_clk, vm.pixelclock * 2);
+		clk_set_rate(dpi->pixel_clk, vm->pixelclock * 2);
 	else
-		clk_set_rate(dpi->pixel_clk, vm.pixelclock);
+		clk_set_rate(dpi->pixel_clk, vm->pixelclock);
 
-
-	vm.pixelclock = clk_get_rate(dpi->pixel_clk);
+	vm->pixelclock = clk_get_rate(dpi->pixel_clk);
 
 	dev_dbg(dpi->dev, "Got  PLL %lu Hz, pixel clock %lu Hz\n",
-		pll_rate, vm.pixelclock);
+		pll_rate, vm->pixelclock);
+}
+
+static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
+				    struct drm_display_mode *mode)
+{
+	struct mtk_dpi_polarities dpi_pol;
+	struct mtk_dpi_sync_param hsync;
+	struct mtk_dpi_sync_param vsync_lodd = { 0 };
+	struct mtk_dpi_sync_param vsync_leven = { 0 };
+	struct mtk_dpi_sync_param vsync_rodd = { 0 };
+	struct mtk_dpi_sync_param vsync_reven = { 0 };
+	struct videomode vm = { 0 };
+
+	drm_display_mode_to_videomode(mode, &vm);
+	mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
 
 	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
 	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
-- 
2.47.0


