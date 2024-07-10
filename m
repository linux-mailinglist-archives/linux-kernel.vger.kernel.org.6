Return-Path: <linux-kernel+bounces-247259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FDD92CD38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E9A1F24B18
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D4145B38;
	Wed, 10 Jul 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxofKbwx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263EE13D53A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600643; cv=none; b=C/JV7iPjQDtQNGVN/UE+6h8UTGfA1FseGjp8Y4Bu75hNm+qlASqPh4fLr3MQQPt2rToq061zvlETGfbKOUwSDyQ0wcb4QDCfU0wwzNKful5S2+nqX3H6tPcNOexMgkEe8kp1XTxMnFIt+0V3HuDI5ApfYlohlM5Tx2HkQUswdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600643; c=relaxed/simple;
	bh=tfabwBvvONPi6G1imBOAg7bICWXSe8zF8QtpBuR5L0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p5dG3cV84p+NSh6E1O4RZutaeVJU4kvy10AODiuOcSYyKwzdnd40RFhCseCrLZsvahthmqneBnyWh5uXxwfAQnTjTFVLAH76hPP+/h/poDIRkF8RxKywVKvaSGlaqFaRQ19mZnGodqExqX7F+6dBEWaaFrCFoGLTCc87XJ9y7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxofKbwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B85ADC32786;
	Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720600642;
	bh=tfabwBvvONPi6G1imBOAg7bICWXSe8zF8QtpBuR5L0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sxofKbwxJrcZPRM3OnpVr7hAH1vyRhNrYVD65gNKcDv9gSyh0+BN1+o6iLdgF17pm
	 xneZcFH8HF2Nf6v+W0nK/nMA0+MlBDWs5WhkDuPtk196DgHcQWZj6MkoXZvD95RJZd
	 gmqJsFuF1Wl8hpVkZJl6oUcA8/gGg6VRHSOEzEifgHYEaMkHxWgeTnoN2wxaj37/K+
	 88/97uiA8k3oDdw+QelNaVKw94Q2SUkxBWOLe9amJHhY5tOhnj1F948mCtNyGKmrMC
	 pUinrv1Rsj+rP8fFFUdl3q32UintvGzl5rWLnjHZFY57FAHy4AiXyY10JkNhIoLikA
	 xiScfTC5ZJeew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E5C3DA42;
	Wed, 10 Jul 2024 08:37:22 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 10 Jul 2024 16:37:19 +0800
Subject: [PATCH v2 1/5] drm/mediatek: Support "None" blending in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-alpha-blending-v2-1-d4b505e6980a@mediatek.com>
References: <20240710-alpha-blending-v2-0-d4b505e6980a@mediatek.com>
In-Reply-To: <20240710-alpha-blending-v2-0-d4b505e6980a@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 CK Hu <ck.hu@mediatek.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720600641; l=1452;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=XPDvZ7xzyMMnOIwBspXj+lmld62ksCxAgrZn9GTIqIg=;
 b=GqcT87r4rRyr78YQwa4jrGqrbCdQkmHOav67BxTW5YqCT+5auldhvgktksMw2qCOf9cwLvSYQ
 nDSQsai+RpUB63G9x2WlWi9G7wZnlBUt3Yii8x5RGVzu7tZkp1ItpQT
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "None" alpha blending mode on MediaTek's chips.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 9d6d9fd8342e..add671c38613 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -434,6 +434,7 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	unsigned int fmt = pending->format;
 	unsigned int offset = (pending->y << 16) | pending->x;
 	unsigned int src_size = (pending->height << 16) | pending->width;
+	unsigned int blend_mode = state->base.pixel_blend_mode;
 	unsigned int ignore_pixel_alpha = 0;
 	unsigned int con;
 	bool is_afbc = pending->modifier != DRM_FORMAT_MOD_LINEAR;
@@ -463,7 +464,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
 	 * affect the result. Therefore we use !has_alpha as the condition.
 	 */
-	if (state->base.fb && !state->base.fb->format->has_alpha)
+	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
+	    blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
 		ignore_pixel_alpha = OVL_CONST_BLEND;
 
 	if (pending->rotation & DRM_MODE_REFLECT_Y) {

-- 
2.43.0



