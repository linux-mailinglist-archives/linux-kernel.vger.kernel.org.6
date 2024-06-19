Return-Path: <linux-kernel+bounces-221240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B990790F0BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E1B25D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAA11527AA;
	Wed, 19 Jun 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txRLZHMw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCC147779
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807535; cv=none; b=CmyFzcUC0r5wV4H3AAyPLynuVWX3pSl9xTvBqXpGd37gqNonllaxEGxCDvqwWwrxPtZ0NtGZqVHh1UOnHB3nBJo0mb3s9BldBDwRAMcXoK4nwS1bLvlK/TnzQS5M7V1P2GNyqlPaWwgOaO60tzpUk7n+X+WRNdFlZjPFGjk55UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807535; c=relaxed/simple;
	bh=683XBBTcCjvNlqsnqsvC5qU2ha2+uSLRYzWNbExOTr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YTq8AS0nQXU/2aFiX92HvJnw/8LysLpUg64n04aC071wzG4rW/NRZQIU/jEZIMV2PsKZvrzq2kAE3mpUMyFgftS1ekRlY94+j+Q4KNadZ8z+hGhI6C3UvR/+Ip/RmqlLP3kinNBqUAM7prcU3o4dZ1RI0KpTQ9kPN5IWCmq74xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txRLZHMw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E9F4C4AF61;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807535;
	bh=683XBBTcCjvNlqsnqsvC5qU2ha2+uSLRYzWNbExOTr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=txRLZHMwbTzif/kI0RBsVhAlpzzjw9EWMOsJ9pKS338xPVGTcpoHA9P92VGa1x8pe
	 edXEu1CoLeViLtW9T21Wpt5qvUz0HiFNnsWx7wUV2ZD8knp6Dce+ndPKqpw7mL3DP4
	 Q82EvBG/TZJ0OPYK+ilzq2ltYFU3jD/mNXFNTA1r/AWG09f4kiwiCBqowERGpsJ6A2
	 ZxN7jNjBpuCt8Doq9GFQGyYaitABO7OH8pujajqz+aV++tlNEV6YmGXBPRIHuU1/WK
	 KiTq8jlqyML52lKrIXYFW/bJVv5mA+gRmF0YqoF7n6GlQZN6e2e2y1NPooMLZjFxV0
	 l4uDZkimFW3eQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2743AC27C53;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:55 +0800
Subject: [PATCH v2 14/14] drm/mediatek: Fix XRGB setting error in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-14-abf68f46f8d2@mediatek.com>
References: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
In-Reply-To: <20240619-mediatek-drm-next-v2-0-abf68f46f8d2@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=1547;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=N+q+J8F01q3+w5AJm23nX2Ta3bBWa72KPt0JkxnFDyM=;
 b=UGkb80MLoatE4rhTH91SKYMfduSoEsuHwJOGEjgG5YhEsMiyJ77CyrZu85rwXyMZq3lSE0pKP
 BuGab+SbGDVCkdRv1qaDjrNhTvABHv31tqQubuZZIXknz7+ZNzsYWPw
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

CONST_BLD must be enabled for XRGB formats although the alpha channel
can be ignored, or OVL will still read the value from memory.
This error only affects CRC generation.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index f358dbfed5e3..6abefc338045 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -455,6 +455,14 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 		con |= state->base.alpha & OVL_CON_ALPHA;
 	}
 
+	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
+	 * can be ignored, or OVL will still read the value from memory.
+	 * For RGB888 related formats, whether CONST_BLD is enabled or not won't
+	 * affect the result. Therefore we use !has_alpha as the condition.
+	 */
+	if (state->base.fb && !state->base.fb->format->has_alpha)
+		ignore_pixel_alpha = OVL_CONST_BLEND;
+
 	/* CONST_BLD must be enabled for XRGB formats although the alpha channel
 	 * can be ignored, or OVL will still read the value from memory.
 	 * For RGB888 related formats, whether CONST_BLD is enabled or not won't

-- 
Git-146)



