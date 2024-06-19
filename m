Return-Path: <linux-kernel+bounces-221476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1832D90F43F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1871F233AC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096DF156644;
	Wed, 19 Jun 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4aGWKHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B666153820
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815125; cv=none; b=c0NskhdZ+iv0M59jDV3EaGaEQgoA8U6xuzupIUqB+o2YtgFKbLt3Hg8HmxfZ+kwvvDxH5Bnmv3sH3SnzBr33+9ignj6n4hBBMzSpsDhHdjE0TSMm9yz8a4SdzlGOOIBwYvHLXIMTE9qMHgzz/B3I9cU3nO4YSAbC+CXjvKGtVv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815125; c=relaxed/simple;
	bh=ZJmYvkWyDQXkVIDz4EYMvvkEgoGgO/o3I8+tANsq22s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FGI9wCWTElodbtMxYm2EbRhlhTraX69bnGMKnrkCRc7IQ2dnhAqlLaTPw2wpuc+2tJUyDVm4VGsDWFwZn4bEUsBpsyalCRIiM47gkmcxW1jqYZzK9HTISf4uda7v9vopfHIAYF2O9KMbwssZKZhKI89LzPFppL3c/Q4wZC8U8II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4aGWKHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECCC9C32786;
	Wed, 19 Jun 2024 16:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815125;
	bh=ZJmYvkWyDQXkVIDz4EYMvvkEgoGgO/o3I8+tANsq22s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h4aGWKHG9lNs8tPkSgbQhaVtmHWxRIY+548H6PRQugZTomVEvRjznLDA3+F4pgshr
	 K+wBMQ4nqE46ZyZ11rDKK3bUSaZmuOeKk+ajaR25cR9/Yz9mnDZcYtlgttrgxYNA0A
	 Yzw6YRvShjDJdFtcm+rCVOOJiOkv+H+6iUh2U/kV1PbGCX/fndVpoDoKdNgAdDRMcI
	 PUTZ4hqEw3vg3NkgaZdG8jkiEEff3UyyOURr5PC7W/zLPKDuPza85IJKGOLCKTMaVq
	 C/PM+DgJ6NesgK+VlEehAMyJq87OcpthdR4x/he2ynZVwkpK8e0CIugtZ6yIfZAkjH
	 Q29oO6zU9hyUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A38C2BB85;
	Wed, 19 Jun 2024 16:38:44 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 00:38:42 +0800
Subject: [PATCH v3 02/14] drm/mediatek: Use 8-bit alpha in ETHDR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-igt-v3-2-a9d62d2e2c7e@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
In-Reply-To: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>, Bibby Hsieh <bibby.hsieh@mediatek.com>, 
 Daniel Kurtz <djkurtz@chromium.org>, Mao Huang <littlecvr@chromium.org>, 
 "Nancy.Lin" <nancy.lin@mediatek.com>
Cc: YT Shen <yt.shen@mediatek.com>, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Hsiao Chien Sung <shawn.sung@mediatek.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815123; l=1391;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=7umBnacXHY95A+TiUODUrNhd3bD2WRNrF+DOB/ds4t8=;
 b=BMG77zft9eH3Te3rgMGiWvej9yoe0q1+9thWcfprzf6tjSNlo1Ze6n2dxH1SlPwrT5Ds80vNk
 7dZANunCC3LDuyQwcnlkz8iM7TznwAYRWuGA01zflm7nBwNyx7NYg/4
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

9-bit alpha (max=0x100) is designed for special HDR related
calculation, which should be disabled by default.
Change the alpha value from 0x100 to 0xff in 8-bit form.

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



