Return-Path: <linux-kernel+bounces-254686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9D933660
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797ACB220AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215513ACC;
	Wed, 17 Jul 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKukNrcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB07FBEA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193886; cv=none; b=KnOQAztd+w06BSV7R/Lr0WMW0VbpaFKcnxPn/YpqcC74G6lMOYLeLOM2MtHz9akIZJOw6AYtWOosTjvA68NxZTo0jvx5UpxnQ75kuj7iYcS2V9qweG4yp32a8OjZMbbHlnZUu7nYPIDlUTpUNh8GUNaSOoDSzKH+Ze/Ofb3IUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193886; c=relaxed/simple;
	bh=tfabwBvvONPi6G1imBOAg7bICWXSe8zF8QtpBuR5L0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QfWjKQkoRNxFg6Ja5Jcw6skHvt9i1tbmTyHPoN7hjXTgBrzdJvC1h5tYX2IWVpgKcGg91JQ0ITc9xBx2m/b9cR5RIrwXwZdn4M4HtY17obZFZNFx9SiyTHUJJVzI8p3NKZo9g8enW/rAXt7pfwV2dRGKnczdSbZvg4u16zrBlNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKukNrcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D7BBC4AF0C;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721193886;
	bh=tfabwBvvONPi6G1imBOAg7bICWXSe8zF8QtpBuR5L0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oKukNrcwSDXrJfaioEr6rzZWSNIufWoJNGBvkR3N9+LArG3s2zEYYQRrkujzK5zGm
	 t94GMjd5lxRPiQCHYHE5vfIDT9Es4cxYnDuI82gOB+AtYTdRwJ+hOj4FpwmvsokfzQ
	 /13i1iNYUG4HovFqUB2KzP6A2iVhRN1ptyGryfAIPYofQRNCW/c8MpKQjmKi+cBqwe
	 gjNAZ59P4npPQci/FLIoKLCHx6KLlyic8FFPWhF5w1NgF3wzJCf1RX1/x2yvCknNlL
	 9e35kv4pVAvTvtnrmAQZhGqjp4EUMswDSDt3WqEcMKbwLemzoLVVj7QN85yHDxWv1Z
	 UkVJMoq9muGxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A231C3DA42;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 17 Jul 2024 13:24:41 +0800
Subject: [PATCH v4 1/5] drm/mediatek: Support "None" blending in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-alpha-blending-v4-1-4b1c806c0749@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
In-Reply-To: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 CK Hu <ck.hu@mediatek.com>, Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721193884; l=1452;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=XPDvZ7xzyMMnOIwBspXj+lmld62ksCxAgrZn9GTIqIg=;
 b=Wy9P+FVTGGbiW8DLQqinrUGhy4tek0KY1cjIauc/PX5eCpPsBFzUkqfUB0/w5gKKXXs7pEK33
 u4iJbnYii6OCcFP5B+sCDyImznSS+DZVc5UtLSlMO9l5AKEG6OX1weL
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



