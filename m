Return-Path: <linux-kernel+bounces-221530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587290F50A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AFD1C22D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CF0156C5B;
	Wed, 19 Jun 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ins7qqBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C52155C8B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818032; cv=none; b=c9l1As9E4SB+BXEqTFahuPzqsMI/t2ftrWQBx9k/yyIbgu16zPjuhWog6xDo/xK21eFoh4gEYbEbQKQI2ANy/plEpe6N7Ltqyq/jHlq952IbZlejX5bOqEH3rsl5gXPawV3OebrUMqIVGezfRyvjT63u3GLT3G0O5k2sv4O77V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818032; c=relaxed/simple;
	bh=T183k9By1cvXGXNo8Ecq6kS7PKcoWpDlkYqloTYrQ3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gy3B5u8pTQjr1Uc6596YhPXm+vhXAjO2IXyMe6lXkI3z5KNIaBjA6t4j0whtKO9ajq93NHOie9NdBBivqAhO0aazDFoAzsaK2PXc7OzvQkW3QwmNpI7DsOh6XgN4iZwOPFG1pWlMRA+L3Q5HafrxrseIHb5EVBlkUbECs3RkC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ins7qqBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 446FEC4AF09;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818032;
	bh=T183k9By1cvXGXNo8Ecq6kS7PKcoWpDlkYqloTYrQ3w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ins7qqBt/DF7pMus+7lz95yNRa9Nm7P93w9+CbiItBQGGzokNtqy3edzb4jv6fWod
	 /n3sv0Dc8ShZTypIwOrdbkIkWPlxCIr06WbB375XSPoDwcjIuLDxBYjLPBPBXzPVpo
	 HwWLjDSCVRUwQlsphYsA/9QK+uhgJW3Omfwo15Rf9fsu47QzNd/WngzRREi6EPH6AQ
	 KOq/AN4pTiYefvnTD4DNT/TpQawqy7aHHoU3LuWw49S/3/ibh4KfL+PUa+L1gW8pvN
	 hOn/XqMgRklWWbtVcgM0sLYqU2A9XB0eT+8Kw3GuDMocn3qajH77nQf0+Pt4aEj7GY
	 OULTfRadlLwvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED40C2BD05;
	Wed, 19 Jun 2024 17:27:12 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 01:27:07 +0800
Subject: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-blend-v1-2-72670072ca20@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
In-Reply-To: <20240620-blend-v1-0-72670072ca20@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718818030; l=2177;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=Qozngh9H3WmkloftvXdtunQipRtPsqe5newy6O92Wn0=;
 b=onITXPFDRbXvFOUQC6q/s0ZYmrTMNr/VTBfUMFTM8PVjvt3LEXLMJVJ1tQvXAYnnrP614Ft2U
 SW7HRNJeZHSBskThxsR8JQiuhTvHA/Oib/BjprnnG6EPZq3+7D8XJlz
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "None" alpha blending mode on MediaTek's chips.

Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 36021cb8df62..48b714994492 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <drm/drm_blend.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <linux/clk.h>
@@ -35,6 +36,7 @@
 #define MIX_SRC_L0_EN				BIT(0)
 #define MIX_L_SRC_CON(n)		(0x28 + 0x18 * (n))
 #define NON_PREMULTI_SOURCE			(2 << 12)
+#define PREMULTI_SOURCE				(3 << 12)
 #define MIX_L_SRC_SIZE(n)		(0x30 + 0x18 * (n))
 #define MIX_L_SRC_OFFSET(n)		(0x34 + 0x18 * (n))
 #define MIX_FUNC_DCM0			0x120
@@ -175,7 +177,13 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		alpha_con |= state->base.alpha & MIXER_ALPHA;
 	}
 
-	if (state->base.fb && !state->base.fb->format->has_alpha) {
+	if (state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE)
+		alpha_con |= PREMULTI_SOURCE;
+	else
+		alpha_con |= NON_PREMULTI_SOURCE;
+
+	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
+	    state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE) {
 		/*
 		 * Mixer doesn't support CONST_BLD mode,
 		 * use a trick to make the output equivalent
@@ -191,8 +199,7 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
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
Git-146)



