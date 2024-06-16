Return-Path: <linux-kernel+bounces-216197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E925B909C93
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550551F217B1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3B3188CA3;
	Sun, 16 Jun 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yjh/KDEX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48AC186E49
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526555; cv=none; b=nsWknWE2hI6JiQ7NPpE33f+K4b2K8BLBshRJdg/FE8nYJx17JZR9xmVJRmM9ZJyTVaYgJmJrGZaZ28xJh5LRC0f7eglPRznMvKCsjLhKXMU/VQaxLOCSAxZAG2Cs9EkKzqUS1OLQ+NdVTdOEnAxMuJ2B4tk0U4rzzTGcvRWZdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526555; c=relaxed/simple;
	bh=yne2/aaB3faVebbBmbsIqfhYaOPrauuP52omRC1Y+Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iw/Gr4R2JBUWsKCHR/vSWvivbLPmJmOWQntMSB6dnVQfa3bh+Zi9vk7tauvge0ic49IXVR4QWUkjngWzk4uyZ1whqj6iG4jX7T8C2dWrKScYyiG0ThvFEAD+kzkRbR8rqyf7KM76VUZ92f8Zcv8MF+1Ywhjdfh//PfoRvHMv/Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yjh/KDEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B60FC4AF67;
	Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526555;
	bh=yne2/aaB3faVebbBmbsIqfhYaOPrauuP52omRC1Y+Io=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yjh/KDEXnvQ6hj6k0pjzGZb2zxFF6iQpClrwMsRyspUBlaDqBYhnfSEqyWHBzukiK
	 TTseUNYDLNnYCCtoflbEYe56QB2ROeRkZemAiOvqbFy7/T9upcxGVrB7u9AYwNyARq
	 eNoaT2IqfjTbtWyTGcoLRIESTYDIplL/BVzbJdYZt6BPbQtJEr/hEfDFr4iD4obnBp
	 2nH8K1V/uYEI5hqQbQEYSwtOHoq7Q+Ae6yLxn4wu9EZ/aAJd9763B2Lv6IKM9hrlN1
	 qAwxjOioSS9/gpdJwIzTacygIUhuyjxwk+Vgj49FjB5rKefdE9h35hjklFPUc+bbXt
	 O2aMLriucEZ4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54215C2BA16;
	Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Sun, 16 Jun 2024 16:29:20 +0800
Subject: [PATCH 10/13] drm/mediatek: Fix XRGB setting error in Mixer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240616-mediatek-drm-next-v1-10-7e8f9cf785d8@mediatek.com>
References: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
In-Reply-To: <20240616-mediatek-drm-next-v1-0-7e8f9cf785d8@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, YT Shen <yt.shen@mediatek.com>, 
 Mao Huang <littlecvr@chromium.org>, "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718526553; l=1741;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=bei5ueFJptA1ljKKIIOgwM3dwE+BvlsqMVvH9AZqfZQ=;
 b=5S1/9HBuMooxzvxMIzc7wYMGIbaJRlwdOqUH/E47s5q/auxCzzN+JqjCk79W6ybMuaKvDqajc
 34dWaT4vuAZDwLuVk1P4baXDUoWffmNZBOcKoSDPkt9vqj36IHsykr8
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Although the alpha channel in XRGB formats can be ignored, ALPHA_CON
must be configured accordingly when using XRGB formats or it will still
affects CRC generation.

Fixes: d886c0009bd0 ("drm/mediatek: Add ETHDR support for MT8195")
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index b5484a286060..a302b12aae3f 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -153,6 +153,7 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 	unsigned int offset = (pending->x & 1) << 31 | pending->y << 16 | pending->x;
 	unsigned int align_width = ALIGN_DOWN(pending->width, 2);
 	unsigned int alpha_con = 0;
+	bool replace_src_a = false;
 
 	dev_dbg(dev, "%s+ idx:%d", __func__, idx);
 
@@ -172,8 +173,15 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 	if (state->base.fb && state->base.fb->format->has_alpha)
 		alpha_con = MIXER_ALPHA_AEN | MIXER_ALPHA;
 
-	mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, alpha_con ? false : true,
-				  MIXER_ALPHA,
+	if (state->base.fb && !state->base.fb->format->has_alpha) {
+		/*
+		 * Mixer doesn't support CONST_BLD mode,
+		 * use a trick to make the output equivalent
+		 */
+		replace_src_a = true;
+	}
+
+	mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, replace_src_a, MIXER_ALPHA,
 				  pending->x & 1 ? MIXER_INX_MODE_EVEN_EXTEND :
 				  MIXER_INX_MODE_BYPASS, align_width / 2 - 1, cmdq_pkt);
 

-- 
Git-146)



