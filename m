Return-Path: <linux-kernel+bounces-340308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEB987169
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444E21F21817
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3B61AE840;
	Thu, 26 Sep 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n8818H+Q"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B831AD413
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346167; cv=none; b=jLp9b4VecET8LscuQK4jAmYYS4S/gm8jbrpBNdSDCW9CtQA0+QG7EsA5TiG9PIjWvblexg+XC8Cx4HmZ/qz6ad5VgLnTIVhPFv/VcpL8DWFl+BXTpR4AWLr/VxxQ/i2stpWEiL6ZKj4kYXIrnosgWmF7bvEda7clN9gHC68xILo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346167; c=relaxed/simple;
	bh=X4g3Yfgd6fxE7tVpH/YjGki2FIy24nZuNNLwvl3SccE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZcO7F27xBB76nvEUmlYxWYK4iDFNg1s892O67NC6sJIhli1AOo09bdNUj4QA7f35oD8883b0GSVrn3OM3MQBVdhbei37MiRiQSS0rWOCHPZ9ziLOzAFIkG/04zxKOdYJFc7JhRLbNcZZjWZ/q+ZWS0bVt1fbYWp1lxt7p/LFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n8818H+Q; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 429e721c7bf111efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SBLgazKKu5NNUnfSeMimzYpwU2tCfmGxSFJ9nTX9DwI=;
	b=n8818H+QyRS/ogfLSsFgELPmkiYbx1xy1hgb62yDVL0jB3QHd54oOLBRBeJvyCvFuJZUjTWNzUGrTxsOD6Sqx91YR9MxER0sY3mHB3C8HNblgV1kbh29P2N1yF84t0SAzwZ0YVIk5XDz7y88gFQSLBVRUjexXLtw1Ww28i+WO1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:dd3daae8-0d61-4b88-b282-beb90b728be7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:28719a9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 429e721c7bf111efb66947d174671e26-20240926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 214483084; Thu, 26 Sep 2024 18:22:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 18:22:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 18:22:39 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Shawn Sung <shawn.sung@mediatek.com>, <dri-devel@lists.freedesktop.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Jason-JH . Lin"
	<jason-jh.lin@mediatek.com>, Singo Chang <singo.chang@mediatek.com>, Nancy
 Lin <nancy.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v7 2/3] drm/mediatek: ovl: Add blend_modes to driver data
Date: Thu, 26 Sep 2024 18:22:37 +0800
Message-ID: <20240926102238.24303-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240926102238.24303-1-jason-jh.lin@mediatek.com>
References: <20240926102238.24303-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

OVL_CON_CLRFMT_MAN is a configuration for extending color format
settings of DISP_REG_OVL_CON(n).
It will change some of the original color format settings.

Take the settings of (3 << 12) for example.
- If OVL_CON_CLRFMT_MAN = 0 means OVL_CON_CLRFMT_RGBA8888.
- If OVL_CON_CLRFMT_MAN = 1 means OVL_CON_CLRFMT_PARGB8888.

Since previous SoCs did not support OVL_CON_CLRFMT_MAN, this means
that the SoC does not support the premultiplied color format.
It will break the original color format setting of MT8173.

Therefore, the blend_modes is added to the driver data and then
mtk_ovl_fmt_convert() will check the blend_modes to see if
premultiplied supported in current platform.
If it is not supported, use coverage mode to set it to the supported
color formats to solve the degradation problem.

Fixes: a3f7f7ef4bfe ("drm/mediatek: Support "Pre-multiplied" blending in OVL")
Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 38 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 4a4bc27a67f0..0cf7b80f612e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -146,6 +146,7 @@ struct mtk_disp_ovl_data {
 	bool fmt_rgb565_is_0;
 	bool smi_id_en;
 	bool supports_afbc;
+	const u32 blend_modes;
 	const u32 *formats;
 	size_t num_formats;
 	bool supports_clrfmt_ext;
@@ -386,9 +387,23 @@ void mtk_ovl_layer_off(struct device *dev, unsigned int idx,
 		      DISP_REG_OVL_RDMA_CTRL(idx));
 }
 
-static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt,
-				    unsigned int blend_mode)
+static unsigned int mtk_ovl_fmt_convert(struct mtk_disp_ovl *ovl,
+					struct mtk_plane_state *state)
 {
+	unsigned int fmt = state->pending.format;
+	unsigned int blend_mode = state->base.pixel_blend_mode;
+
+	/*
+	 * For the platforms where OVL_CON_CLRFMT_MAN is defined in the hardware data sheet
+	 * and supports premultiplied color formats, such as OVL_CON_CLRFMT_PARGB8888.
+	 *
+	 * Check blend_modes in the driver data to see if premultiplied mode is supported.
+	 * If not, use coverage mode instead to set it to the supported color formats.
+	 */
+	if (!(ovl->data->blend_modes & BIT(DRM_MODE_BLEND_PREMULTI)) &&
+	    blend_mode == DRM_MODE_BLEND_PREMULTI)
+		blend_mode = DRM_MODE_BLEND_COVERAGE;
+
 	switch (fmt) {
 	default:
 	case DRM_FORMAT_RGB565:
@@ -466,7 +481,7 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 		return;
 	}
 
-	con = ovl_fmt_convert(ovl, fmt, blend_mode);
+	con = mtk_ovl_fmt_convert(ovl, state);
 	if (state->base.fb) {
 		con |= OVL_CON_AEN;
 		con |= state->base.alpha & OVL_CON_ALPHA;
@@ -621,6 +636,8 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
 	.gmc_bits = 8,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = false,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -630,6 +647,8 @@ static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
 	.gmc_bits = 8,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -639,6 +658,8 @@ static const struct mtk_disp_ovl_data mt8183_ovl_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -648,6 +669,8 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
 	.gmc_bits = 10,
 	.layer_nr = 2,
 	.fmt_rgb565_is_0 = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -658,6 +681,9 @@ static const struct mtk_disp_ovl_data mt8192_ovl_driver_data = {
 	.layer_nr = 4,
 	.fmt_rgb565_is_0 = true,
 	.smi_id_en = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_PREMULTI) |
+		       BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -668,6 +694,9 @@ static const struct mtk_disp_ovl_data mt8192_ovl_2l_driver_data = {
 	.layer_nr = 2,
 	.fmt_rgb565_is_0 = true,
 	.smi_id_en = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_PREMULTI) |
+		       BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8173_formats,
 	.num_formats = ARRAY_SIZE(mt8173_formats),
 };
@@ -679,6 +708,9 @@ static const struct mtk_disp_ovl_data mt8195_ovl_driver_data = {
 	.fmt_rgb565_is_0 = true,
 	.smi_id_en = true,
 	.supports_afbc = true,
+	.blend_modes = BIT(DRM_MODE_BLEND_PREMULTI) |
+		       BIT(DRM_MODE_BLEND_COVERAGE) |
+		       BIT(DRM_MODE_BLEND_PIXEL_NONE),
 	.formats = mt8195_formats,
 	.num_formats = ARRAY_SIZE(mt8195_formats),
 	.supports_clrfmt_ext = true,
-- 
2.43.0


