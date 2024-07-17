Return-Path: <linux-kernel+bounces-254687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5189C93365F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8BA1F23DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 05:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552B313AF2;
	Wed, 17 Jul 2024 05:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ufq6kxXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E1EFC0E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721193886; cv=none; b=CRu2Xn+5QgrS9n25uxIN1OxQ6L1QWNQfQ6B72WX7MJwYxRyxk9LS7StkVO0xDnHon1si0X7nzyMPYYlcxAMVZ6w1iTY1btQYAl4/pdQEWJFnSoPp7F/tMAkRV1AsiHa/TFC1M6GS3tineWbyMyiDWrhjHmFTxM1flphhORJih4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721193886; c=relaxed/simple;
	bh=k+m/j/ZZUAf19tVJ68uEgaeMiuJbGDy2Tlswzrloros=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5ELq1+AjDtImLVHh2gs7JWPLMUbPW2n80SmFWUKNR2iPTLJdOlKpFZRCzg+6oGgY0VA27kWvl4IDSUuOmxV/cXJCejx6i1qjMS+GkhcEba2qM9TK7lwEU8ANBQkKE+S9KYD7ebnq6RFxDhoz0cxIH15xrDA81PeS89rXcjOi24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ufq6kxXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FFE7C4AF09;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721193886;
	bh=k+m/j/ZZUAf19tVJ68uEgaeMiuJbGDy2Tlswzrloros=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ufq6kxXW0VOHP10v4bw7ec3Vedm/wbB8ObnCM/O12eHEcBqBkoXpz8YwhlcA14gzO
	 aLMOVy5Ra4Y8ecRONg6WVsr+EzRQ8iC8Fjsr6PeP6UDLV491KXzTVMmnn+pwoOiaRR
	 G+YX4ZZMGxZ3YGgw261BldeNotcuR0qGboURcssAt5XqsDtY5qSumiUxaWAMqZrOR3
	 5yzSnmm8myskoBp4QflzhS7NAvJNx9A6aM6X/oB9hZLmy2/KaI6ZXEiT2bbv+Qveko
	 FdbGCvzmslmSQUDrNxqFkbpDumt02jWI9kLSNTJ9pcDNGu9cLQKUjmMKCNbiQXhNTF
	 K2PEvr1Csfx1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185C3C3DA61;
	Wed, 17 Jul 2024 05:24:46 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 17 Jul 2024 13:24:42 +0800
Subject: [PATCH v4 2/5] drm/mediatek: Support "None" blending in Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240717-alpha-blending-v4-2-4b1c806c0749@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721193884; l=1164;
 i=shawn.sung@mediatek.com; s=20240710; h=from:subject:message-id;
 bh=UnuJItDahJeCC5tgEfQnqRNWpQwYQbCGuIsN6s/jhSQ=;
 b=YwJtfVG+IrzyvVX0K/tSkhi9+eVqQWIX79akZkka6VlXm0pJ1//CgmZinvv49UCjjB+6lm3X2
 xxFJnXo0pRyAlKuarorwaY6Og/totKcaGBIBY3qaO4GBOyKYk1FsTYs
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=VRlGZ3diQkQtpDd8fCL9/mx+TpZStm08pg8UPaG1NGc=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240710 with
 auth_id=184
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support "None" alpha blending mode on MediaTek's chips.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 9dfd13d32dfa..80ccdad3741b 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <drm/drm_blend.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <linux/clk.h>
@@ -175,7 +176,8 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		alpha_con |= state->base.alpha & MIXER_ALPHA;
 	}
 
-	if (state->base.fb && !state->base.fb->format->has_alpha) {
+	if ((state->base.fb && !state->base.fb->format->has_alpha) ||
+	    state->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE) {
 		/*
 		 * Mixer doesn't support CONST_BLD mode,
 		 * use a trick to make the output equivalent

-- 
2.43.0



