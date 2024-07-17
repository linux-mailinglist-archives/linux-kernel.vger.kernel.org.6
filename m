Return-Path: <linux-kernel+bounces-254684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301D93365C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0401D283E36
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E612E7F;
	Wed, 17 Jul 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL9SnksI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8094FD51A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193886; cv=none; b=cOjXFp6oW2icCy0GidWMHaarSnpqaqXZfgkIxXbQyEcxW/1N5En4cBEuA8uYaKDDpB4QD0Kmd+97Esbqv2VVdc2QwNxeh3pQzTztm3wopXvso2puEukvb/vrqO+8HED6zkjZuQ9WA9zWaOeht7Bsv+J01o+tPjabdLecZvtSiZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193886; c=relaxed/simple;
	bh=2NcjMrvwfe1/v2FtKU3wRpvD6ZLIx8HGvtlmvTktZss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y2O2xt3v7CvXSzUaUrDkq9v6+d5Y/YZKTVl3IlqNk/TNKQ0mbDVWSM2592mTb5pPAIxcpUjX62j0CKY3vcW4k+tE3qxmWbVRJ46JAJi48CI+Wx1zKVeOF8u++pabdQv1wVpFGor8fGMdSxFjjIhTl5sKD7f6jBcoxRI9ojPPeew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL9SnksI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 445D3C4AF0F;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721193886;
	bh=2NcjMrvwfe1/v2FtKU3wRpvD6ZLIx8HGvtlmvTktZss=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oL9SnksIU07HqB0yz//l1Ae8jsfWsTtmwIEpMjP9LbvGlcAHYuAyxoAj5VQ6PoW7H
	 TMtmZ/5aLBp0J/z4HA8Q/VcrzzJ96UbSvPygbQ6sloEJAfwkpAHg9EL/1R0eh7OK5q
	 cedeUdh5QTS23yJInAG8s8vhUgE2L3k+MO6wKEFZyaACUW9TnD0C5kY5VVrWB4PebF
	 8miR9ssO/N80D5b50Q9Dulc+8tXbJj73RtYBZHMWbfWQG//Msz0Yc5LDpPMxlc1nUD
	 QVffz2qFspHOcEUAHP4Vn7SFIuJez8w9U8Qcdu8+ZPf8481B0i8kQhoyGXcNgtTQpE
	 c5c9GvYtQrudA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA0C3DA4B;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 17 Jul 2024 13:24:44 +0800
Subject: [PATCH v4 4/5] drm/mediatek: Support "Pre-multiplied" blending in
 Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-alpha-blending-v4-4-4b1c806c0749@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
In-Reply-To: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721193884; l=2294;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=DojSZu5PuBzMfoL3foGMBjfvPTLtxxAtfP7xNgOj/lE=;
 b=veMbyMxGW1pG/bwLlWCL/J7zOro6Lxh+WYADC8HkzM+jy+2dPQFP48yTp06NIWcN2alaKOP2y
 gzMwVmdLzrYAnLAxZOI6ycJMbMMChepi3e4sVm3YG7J6YBZJNGEwqwD
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "Pre-multiplied" alpha blending mode in Mixer.
Before this patch, only the coverage mode is supported.

To replace the default setting that is set in mtk_ethdr_config(),
we change mtk_ddp_write_mask() to mtk_ddp_write(), and this change will
also reset the NON_PREMULTI_SOURCE bit that was assigned in
mtk_ethdr_config(). Therefore, we must still set NON_PREMULTI_SOURCE bit
if the blend mode is not DRM_MODE_BLEND_PREMULTI.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 80ccdad3741b..d1d9cf8b10e1 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -36,6 +36,7 @@
 #define MIX_SRC_L0_EN				BIT(0)
 #define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
 #define NON_PREMULTI_SOURCE			(2 << 12)
+#define PREMULTI_SOURCE				(3 << 12)
 #define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
 #define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
 #define MIX_FUNC_DCM0			0x120
@@ -176,6 +177,11 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		alpha_con |= state->base.alpha & MIXER_ALPHA;
 	}
 
+	if (state->base.pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
+		alpha_con |= PREMULTI_SOURCE;
+	else
+		alpha_con |= NON_PREMULTI_SOURCE;
+
 	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
 	    state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE) {
 		/*
@@ -193,8 +199,7 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 	mtk_ddp_write(cmdq_pkt, pending->height << 16 | align_width, &mixer->cmdq_base,
 		      mixer->regs, MIX_L_SRC_SIZE(idx));
 	mtk_ddp_write(cmdq_pkt, offset, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_OFFSET(idx));
-	mtk_ddp_write_mask(cmdq_pkt, alpha_con, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_CON(idx),
-			   0x1ff);
+	mtk_ddp_write(cmdq_pkt, alpha_con, &mixer->cmdq_base, mixer->regs, MIX_L_SRC_CON(idx));
 	mtk_ddp_write_mask(cmdq_pkt, BIT(idx), &mixer->cmdq_base, mixer->regs, MIX_SRC_CON,
 			   BIT(idx));
 }

-- 
2.43.0



