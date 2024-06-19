Return-Path: <linux-kernel+bounces-221529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E764590F507
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14E41C22CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49752156997;
	Wed, 19 Jun 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2/PTasX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCB155756
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818032; cv=none; b=PFYLCpGL6MuvHdZmSF45RyIZCJMmwEX8e8REimUFmxHDlc5CAW2JLBJqmR+0sUiUEMYh+pLqodaA5bW90/qQOW4ev0kc55mBqbab74gdh0m2wpKa1chlyMWVONRLNgburPNxUy+MJzUBwBicsIrw3d7XXnY5H7iKrVkjROcGtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818032; c=relaxed/simple;
	bh=ETsnlL8B7SX5GDU+JpS9dzXyLldBHM/ahdNPF8Smk6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gidlm+qvZc/fn0YMkdWMMuxbVasyHk1gjLH09X0AiNQylcO9e2MGeZFKSAP02z7QmteOZo895drd8RwKm8TIkVyRQp0lJ3zrIV5XYJe0OwxdawFtkmaCm6X6kQe1BaKkMTp0FsW7tZv4GA9sI55zNBs2O6MFlAy6p94aEjD/M68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2/PTasX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 33453C4AF07;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818032;
	bh=ETsnlL8B7SX5GDU+JpS9dzXyLldBHM/ahdNPF8Smk6o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=E2/PTasXCBWk9IAIfsSs/M2PYBon5dLDwCeslZDAyfVnt+g2aKt9xRS9haB20xnEQ
	 azRyjtdZ5SURnoDWtyVmRgAHKI+bDYVi2IFHLO+EIEi8qYm6towYYnUaztlCDMRB+8
	 GaCNU9luqtNusqMs8bL17hAXsSCjwnOSXgpN26SdjdqD7bNtkLM/tuhty14vszZ7so
	 D3Ukmz8eskxHe2IlJ8568H5JHn8yyDdVHCb7ubzHkeuDjlMZjopM7ISbyqo510rcD2
	 Ps2LN3COcdgy0+L5cyzd6xrlV3I/loDkWxRnmvmWqK1SyjKAUfAYaNiegOXXBVn8W7
	 XiH5M65MIi/Sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E41AC2BB85;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 01:27:06 +0800
Subject: [PATCH 1/5] drm/mediatek: Support "None" blending in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-blend-v1-1-72670072ca20@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
In-Reply-To: <20240620-blend-v1-0-72670072ca20@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>, CK Hu <ck.hu@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718818030; l=1454;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=rtWSUov4PpFb4hd8Tt3oJveJfjjyY029CEOcPjNOX6c=;
 b=KpJUZeS7WEff+MEihA4MdIy0tY9hjb36UjuTGYAVOGH4tGwjeZ7PvX9T2RQh9WvxFAcPEPxOE
 4ztaAk9cHA2AwkAaKKCB54EtlLjv9UUQ3Whapw0cgfuK2rSBXYHc9Bl
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
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
index 4b370bc0746d..ad9228fc4dd9 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -439,6 +439,7 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	unsigned int fmt = pending->format;
 	unsigned int offset = (pending->y << 16) | pending->x;
 	unsigned int src_size = (pending->height << 16) | pending->width;
+	unsigned int blend_mode = state->base.pixel_blend_mode;
 	unsigned int ignore_pixel_alpha = 0;
 	unsigned int con;
 	bool is_afbc = pending->modifier != DRM_FORMAT_MOD_LINEAR;
@@ -468,7 +469,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
 	 * affect the result. Therefore we use !has_alpha as the condition.
 	 */
-	if (state->base.fb && !state->base.fb->format->has_alpha)
+	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
+	    blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
 		ignore_pixel_alpha = OVL_CONST_BLEND;
 
 	if (pending->rotation & DRM_MODE_REFLECT_Y) {

-- 
Git-146)



