Return-Path: <linux-kernel+bounces-247286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E392CD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4562428A3D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663A17B4F3;
	Wed, 10 Jul 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0GX4PX7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC93176FD8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601575; cv=none; b=p/cco9aDbxwIR2qcGNwGTH4dL9ndxS78TeokNFhlGnAteUGL6tSk0wUYJPia08xnQBwXKUY2iuhRtSThDwb4CsyJbiy7Wox8wmvUP2bpE4YYHqgzUAwJiZub56JiRDF+RoDwHYSoQfJjkEGW2YdaYebe4SBwZv1+pJK+ePhddfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601575; c=relaxed/simple;
	bh=FrXpXFM8hU8nJEtAJsJHGV8jQY/M8JZ5BXMOtazVLvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9AmJm6mENKwV7w2gHZeu7yRwKNJt/CiP2e7bGKQgR/A8iysVjaQdqcZpHx39RdjS09g4r4GHPk2doJ13Exq5fXg8yJb0bzLvItqQp0Pl7/qws0SizsVlmYrWDYAtffsJZY9qi98oD7lWH7Ly1U2B0Mm68i3Q+QmwdD5JwZn500=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0GX4PX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2B2BC4AF0E;
	Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720601574;
	bh=FrXpXFM8hU8nJEtAJsJHGV8jQY/M8JZ5BXMOtazVLvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l0GX4PX7znoPepBB/eqfX0FErtG/Km5pzGj2aimvq14iAYS8M7JLt8k1B13TPD8ST
	 aWf1MJ25RYQPblXbZPepj6loGWiKQq39JnRKPvGsC68Mf9GC6EZIMagRl98jys/esd
	 xHSZbLLHNvNTQG/6BT/e+R2itwZW5ytEkKI7WH3FhCHirkdLGYBIz6upavSWiZisVW
	 lJaSgcxD/k20aO4ng9w/i9lktrYpSEKCigQCTtsUMYmfENmMgJXFVcdrmcb2Crpz7m
	 g+ESU2m7SOqA7nmkN1RXLiTv9z6aJ1M0hGz/Yu0W1zuOu/H2SRSWMP3kAD2Pl7X/4b
	 nBGHem6IxXDfA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA77EC3DA42;
	Wed, 10 Jul 2024 08:52:54 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 10 Jul 2024 16:52:54 +0800
Subject: [PATCH v3 4/5] drm/mediatek: Support "Pre-multiplied" blending in
 Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240710-alpha-blending-v3-4-289c187f9c6f@mediatek.com>
References: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
In-Reply-To: <20240710-alpha-blending-v3-0-289c187f9c6f@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720601573; l=2211;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=L3aSZMNI/5e4YMPf4nqEmkejhrP0vtCut0YLE0pQ+qs=;
 b=GBrebECj+Bdc0Q3tzu4OcJAT8LCNRrNQcNpkvIuERupd7hPn8Tp7Ac47/Hr3MZXSkC8n9BFH6
 O723/oqqfuuB3px3lxb9nHhgz3fuVpcxdRhbJu84VXRrc/GZazok6uY
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



