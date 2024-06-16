Return-Path: <linux-kernel+bounces-216195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D19B909C92
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6730B281C27
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1205187569;
	Sun, 16 Jun 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JakAQWgl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C617F39C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718526555; cv=none; b=kK1SmWNxvHC81Smdcx7/rrkDJL7kriiS0v0lNsaa3rvFWDcx9Kx4jYvrBFF5KzrlZmwLmmlWFZ/ygaorla1ynNvBIxxnTAlZr4iFC18c3EchVN6IDlZNV/hdQ9nwCKCPRH1N57IVSPy9KAFOMxEhDrIiG2HVm/dtBrjqsbRWZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718526555; c=relaxed/simple;
	bh=kifDOgJ1iwtB4OTqi6lKcrfIWMyq+in5namqaL7qf14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLdHtB4mFexNmt9rbRCXKEOrhhALc3K+ktS6tGl310xfysEUAtx1M+tjvGbtPO7hyM0IwT5cGnfJzvZpq1TQv/A4XsJfAtHC1ECl/uzxAEPfv8/wiWAvR++F65IqT4WBNBswggbXo3FiVF38N9iyYuF0qt3mpV1VQqPmTJ4x9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JakAQWgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32F3BC4AF55;
	Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718526555;
	bh=kifDOgJ1iwtB4OTqi6lKcrfIWMyq+in5namqaL7qf14=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JakAQWgl2gRNXv+//Kk8IkQHJBTfjTg4vPJK3CXJLbl6AyjPttiu+MKo66DYsuyya
	 VyQr3YQSWiODEUUIpko3O1PGYkVnNDBU0IWAtCwV9hZVb3UHYKD7vrwvZ4AezEX4Qc
	 ydoqmk9/1qARbF9knfOPBeYwEV8UD9PJZBNGkh9nVGjg/iXKihGbkgMwtvNP4DrBkF
	 iazkriUeTZ3NYtpZ4yyIkKXiJI1DpXKnMKZf4cl934fOVs7TwW7ihmBAxANkduwSAK
	 +CUp1lhhrzZykRXEcPKAm/AJxsgQy+w7/0DRFIDzpVQJgLJlrWixF8ufWa/SvRGL+O
	 zjDwHjG24frVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B8CC27C77;
	Sun, 16 Jun 2024 08:29:15 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Sun, 16 Jun 2024 16:29:17 +0800
Subject: [PATCH 07/13] drm/mediatek: Support more 10bit formats in OVL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240616-mediatek-drm-next-v1-7-7e8f9cf785d8@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718526553; l=3047;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=0F3dL7Hk+/JpF+cj2ZIa5qK/8av3/IUZtyCgaJlJ8KQ=;
 b=FUqaJrmj6lkySmFvxKaKCE6fXMSboJr8o/XVh2za02gVuo8S8oPd7q8zz5LoOhBTxMTx1U88M
 ZwLQEFkA7hmBoGKzWamTs+rRa44xpQfvExfxVjt2R8WCL4JQlXrexPB
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Support more 10bit formats in OVL.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 862ab683ed1b..d970cdce06bc 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -71,6 +71,22 @@
 #define	OVL_CON_VIRT_FLIP	BIT(9)
 #define	OVL_CON_HORZ_FLIP	BIT(10)
 
+static inline bool is_10bit_rgb(u32 fmt)
+{
+	switch (fmt) {
+	case DRM_FORMAT_XRGB2101010:
+	case DRM_FORMAT_ARGB2101010:
+	case DRM_FORMAT_RGBX1010102:
+	case DRM_FORMAT_RGBA1010102:
+	case DRM_FORMAT_XBGR2101010:
+	case DRM_FORMAT_ABGR2101010:
+	case DRM_FORMAT_BGRX1010102:
+	case DRM_FORMAT_BGRA1010102:
+		return true;
+	}
+	return false;
+}
+
 static const u32 mt8173_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
@@ -88,12 +104,18 @@ static const u32 mt8173_formats[] = {
 static const u32 mt8195_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_XRGB2101010,
 	DRM_FORMAT_ARGB2101010,
 	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_BGRX1010102,
 	DRM_FORMAT_BGRA1010102,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_XBGR2101010,
+	DRM_FORMAT_ABGR2101010,
+	DRM_FORMAT_RGBX1010102,
+	DRM_FORMAT_RGBA1010102,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_BGR888,
 	DRM_FORMAT_RGB565,
@@ -253,9 +275,7 @@ static void mtk_ovl_set_bit_depth(struct device *dev, int idx, u32 format,
 	reg = readl(ovl->regs + DISP_REG_OVL_CLRFMT_EXT);
 	reg &= ~OVL_CON_CLRFMT_BIT_DEPTH_MASK(idx);
 
-	if (format == DRM_FORMAT_RGBA1010102 ||
-	    format == DRM_FORMAT_BGRA1010102 ||
-	    format == DRM_FORMAT_ARGB2101010)
+	if (is_10bit_rgb(format))
 		bit_depth = OVL_CON_CLRFMT_10_BIT;
 
 	reg |= OVL_CON_CLRFMT_BIT_DEPTH(bit_depth, idx);
@@ -368,17 +388,23 @@ static unsigned int ovl_fmt_convert(struct mtk_disp_ovl *ovl, unsigned int fmt)
 		return OVL_CON_CLRFMT_RGB888(ovl) | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_RGBX8888:
 	case DRM_FORMAT_RGBA8888:
+	case DRM_FORMAT_RGBX1010102:
+	case DRM_FORMAT_RGBA1010102:
 		return OVL_CON_CLRFMT_ARGB8888;
 	case DRM_FORMAT_BGRX8888:
 	case DRM_FORMAT_BGRA8888:
+	case DRM_FORMAT_BGRX1010102:
 	case DRM_FORMAT_BGRA1010102:
 		return OVL_CON_CLRFMT_ARGB8888 | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_XRGB2101010:
 	case DRM_FORMAT_ARGB2101010:
 		return OVL_CON_CLRFMT_RGBA8888;
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
+	case DRM_FORMAT_XBGR2101010:
+	case DRM_FORMAT_ABGR2101010:
 		return OVL_CON_CLRFMT_RGBA8888 | OVL_CON_BYTE_SWAP;
 	case DRM_FORMAT_UYVY:
 		return OVL_CON_CLRFMT_UYVY | OVL_CON_MTX_YUV_TO_RGB;

-- 
Git-146)



