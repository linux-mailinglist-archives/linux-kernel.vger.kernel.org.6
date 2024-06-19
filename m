Return-Path: <linux-kernel+bounces-221227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B20790F0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026B61F23FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508CD47A48;
	Wed, 19 Jun 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLZP0Nm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E61DA23
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807534; cv=none; b=W3PfMvVtImBLllcmU8Krh6TNYQc5NS4pwvNFDOLWx5Fj3FMJddD5GjKRNSzSCPFHODjMSRuRFK3BxqxRYCJoi/ZR27JEsuTTZbxMqNyJ3qJsT77zhn151gykjeXnqt7XQbnbY3xiGzek9CG6W5adNs2A/lJLyGbnv1DuaLQzQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807534; c=relaxed/simple;
	bh=nDauC53RPLl+Q/BbbOdZCjz+Z3uB4YVnDVwiZtsyjyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZbwJp/tP7KEY/zzhQR9BxD30fbZFpFwNCU3b6JxmaEBXjyHpEyMdhc/BT3Sjku61OYVGYuEkRw/vD8ZHLqjXX842YPv3hYuJL9G4+zrCauiDIu8VwSEfLnaToqCp+crrKI4wAqezNI+ASukfj8tUCHBBjfDK13FIYDbwy0/Xc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLZP0Nm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B557C4AF08;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807534;
	bh=nDauC53RPLl+Q/BbbOdZCjz+Z3uB4YVnDVwiZtsyjyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hLZP0Nm3CCq7u0QNm3dsEW6z2DfRBa4g1HvFboR76ytNF+Lf3bDUBJnEyzTtZSKYX
	 G7z8Hfxcemm9E56oC+CgocLU5ErVpwz+ntcnofBdG2IUz706CfRS8lAvr0jZlsKlWg
	 OxZ7l2ib0vBgis4ziP2aA1fKGFDoio6CwFOyadttTks4UZ4caHJAAhvLPzgKJ2Gq2W
	 0cn0EPe7ke/2rfugJ6Eif+w3Kq2J+N0/5MJs6uSwgn8xrROgpFPhttsSD1Bt9DmMhP
	 1lBaht3NEKN1aUove0+jsCix8WMRqGEUFrp+5RYfp2t9mTnnTRKrnZIOqJHCUoi+w9
	 xjsYcFw+90hSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C325C2BB85;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:43 +0800
Subject: [PATCH v2 02/14] drm/mediatek: Disable 9-bit alpha in ETHDR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-2-abf68f46f8d2@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=1465;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=6fbUX6KRvCRN0DJcJEcVUjxpKT4VpT1Y9qernMaYSKY=;
 b=rAjWRftMXK7ta3qYwsbvYnPDZglASvzGpDwQeQXLRflRp641iLxiTpYr355ls8TTAKEmmQQOi
 HUcBl+QvWPICO6GFX5hgSHOQYglYtF6BCNYAltDFsfJv+eHhahwnzPi
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

When 9-bit alpha is enabled, its value will be converted from 0-255 to
0-256 (255 = not defined). This is designed for special HDR related
calculation, which should be disabled by default, otherwise, alpha
blending will not work correctly.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_ethdr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 156c6ff547e8..d7d16482c947 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -50,7 +50,6 @@
 
 #define MIXER_INX_MODE_BYPASS			0
 #define MIXER_INX_MODE_EVEN_EXTEND		1
-#define DEFAULT_9BIT_ALPHA			0x100
 #define	MIXER_ALPHA_AEN				BIT(8)
 #define	MIXER_ALPHA				0xff
 #define ETHDR_CLK_NUM				13
@@ -169,7 +168,7 @@ void mtk_ethdr_layer_config(struct device *dev, unsigned int idx,
 		alpha_con = MIXER_ALPHA_AEN | MIXER_ALPHA;
 
 	mtk_mmsys_mixer_in_config(priv->mmsys_dev, idx + 1, alpha_con ? false : true,
-				  DEFAULT_9BIT_ALPHA,
+				  MIXER_ALPHA,
 				  pending->x & 1 ? MIXER_INX_MODE_EVEN_EXTEND :
 				  MIXER_INX_MODE_BYPASS, align_width / 2 - 1, cmdq_pkt);
 

-- 
Git-146)



