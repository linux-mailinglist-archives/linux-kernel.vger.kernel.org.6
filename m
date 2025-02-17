Return-Path: <linux-kernel+bounces-517977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42F8A38861
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45140189B08F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B76225A31;
	Mon, 17 Feb 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZYF8rMv6"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57554224B1C;
	Mon, 17 Feb 2025 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807372; cv=none; b=CYb9qAMQ31SOUHyLTHqDW6Jd+PRRu4oIQ7UpNkN4ehtuvu9fucGS4CU9HF94Ash5trXQIhZGhAbiJYOJUzbNJpfoZy8QPDxOZ687Y2vIH3pmkDZyVG2w4QTfjy0jbCXTFfX3qLLtlKgCVUQCNyxgOXkTOcd2y1sjp2U6ZuiO7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807372; c=relaxed/simple;
	bh=VBT30cW01k0fcjrm29mhLfNmM99zJpEKPCw+voBVrmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVc5nTg/Voi9OJIsEb6+jfzOPci3guuqbWRq/X7IsIQFLTLbAycgLVLOSjRO8WWb9XB7HM0c/Nu6qPOQnVlfJ3YNfsM2ktKJiKJe78L2Rq12zb+Bvb5CtJM7ZzLtyoLpwpD0WMEWOil2qcCmxmG6fsj4Ms+diCg1eCDJKgMF0Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZYF8rMv6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739807368;
	bh=VBT30cW01k0fcjrm29mhLfNmM99zJpEKPCw+voBVrmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYF8rMv6W7LGbxb88NpCThdHxx4GOWr4mPC0jPK+PZxuDtcOP0BJii/gllWl1uJf0
	 e7YsfEJWMWeQQeOlRJOKlOD7ETsaM8OLeSpugQWKKpzrvfSm+hLljEc3PIpg0IEOxx
	 tTWLCjPL5PtWohnCExhUZKa0j1V41zJ3kV+4AtNSyLRQW/woNjX1IP0iLS/scgq6wt
	 2oqbtrC/e5t+k1xyGZlrLVbBwXnl0EeZsWrxnbpWzmSEFFcTPVZqZoD06Z90Df/wcz
	 tljynvfYBl4E5ZysCV5in78RjZMIN8+O9mFZizvWaaCJWyXfxPLA71xXPdpRZ0FaeN
	 +ZZU84vuKZguQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D53217E156A;
	Mon, 17 Feb 2025 16:49:27 +0100 (CET)
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
Subject: [PATCH v7 08/43] drm/mediatek: mtk_dpi: Support AFIFO 1T1P output and conversion
Date: Mon, 17 Feb 2025 16:48:01 +0100
Message-ID: <20250217154836.108895-9-angelogioacchino.delregno@collabora.com>
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

On some SoCs, like MT8195 and MT8188, the DPI's FIFO controller
(afifo) supports outputting either one or two pixels per round
regardless of the input being 1T1P or 1T2P.

Add a `output_1pixel` member to struct mtk_dpi_conf which, if
set, will enable outputting one pixel per clock.

In case the input is two pixel per clock (1T2P), the AFIFO HW
will automatically (and internally) convert it to 1T1P.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 9f83e82437dd..e12dc73ed79c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -147,6 +147,8 @@ struct mtk_dpi_factor {
  * @edge_cfg_in_mmsys: If the edge configuration for DPI's output needs to be set in MMSYS.
  * @clocked_by_hdmi: HDMI IP outputs clock to dpi_pixel_clk input clock, needed
  *		     for DPI registers access.
+ * @output_1pixel: Enable outputting one pixel per round; if the input is two pixel per
+ *                 round, the DPI hardware will internally transform it to 1T1P.
  */
 struct mtk_dpi_conf {
 	const struct mtk_dpi_factor *dpi_factor;
@@ -168,6 +170,7 @@ struct mtk_dpi_conf {
 	u32 pixels_per_iter;
 	bool edge_cfg_in_mmsys;
 	bool clocked_by_hdmi;
+	bool output_1pixel;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -653,7 +656,13 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	if (dpi->conf->support_direct_pin) {
 		mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 		mtk_dpi_config_2n_h_fre(dpi);
-		mtk_dpi_dual_edge(dpi);
+
+		/* DPI can connect to either an external bridge or the internal HDMI encoder */
+		if (dpi->conf->output_1pixel)
+			mtk_dpi_mask(dpi, DPI_CON, DPI_OUTPUT_1T1P_EN, DPI_OUTPUT_1T1P_EN);
+		else
+			mtk_dpi_dual_edge(dpi);
+
 		mtk_dpi_config_disable_edge(dpi);
 	}
 	if (dpi->conf->input_2p_en_bit) {
-- 
2.48.1


