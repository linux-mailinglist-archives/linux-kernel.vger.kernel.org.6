Return-Path: <linux-kernel+bounces-221236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9890F0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433C61C225FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE584152796;
	Wed, 19 Jun 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tni5zSU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9022262B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807535; cv=none; b=srzc4ro1FAqiVfxD+DWdzsyqPW0AoKO/lDOvlGzsb/uUjwVifhxh6fQZ3fy9NAjlaZZjdRTMMSfdETnf12CJbV4RS+MFQeUN13FkIzwqUCNcrcVDQZLmKmnSv2xpsBu9Xzz/ToVCIYTA5E1XDJ6k96aCzxp9VJpw76Jk5pzp25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807535; c=relaxed/simple;
	bh=WzX7iZz9NtnoD6KfRAFjbOWCri2OoSCND0g7q5cZSKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PusSI54zGTlaxzL9fZ7XqCWcv21F0pFb/jJ5gIRGkJIWjcbU99GOp0AiQC/OhyBRo6C8jDFWu9OKlUVEOpynCsmR70D0/tGkJ7i9wQxyKjX48uBZCyeJ0G6iUP3aDZ1SqzD//lqLztpgzUaSWR+itcR1q63he40iCLKwpqqhaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tni5zSU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC655C4AF13;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807534;
	bh=WzX7iZz9NtnoD6KfRAFjbOWCri2OoSCND0g7q5cZSKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tni5zSU3Nvq28wRzPX6ZFXNgno1FgHm8SzDCXrB+oLel6X0Z2GNGBtcGNZ2jVYKqZ
	 OlkHEeWMaYumlo5yvYweBo+8m/gZH/299qUgwxMMr1J8sN3zKVkLH7BBB9Nq7feJ8g
	 0iBLbVwrq7ba9cvwxrXoICy7wQe66LyIYgzfZcR6aRjGZnWXDmiGc70juumrAICG+n
	 85t+dL4MeQM3JsdCpdE71r79fBnTEIyOxLoCMoJDJ+5d6tsFRNGgiyERb4GxRYqg6/
	 3yA8zvUNRoQzi2FOWZMT7iBxntf0k2XtHoJR5VnEEO5nfCFe8UyOnYnBDudCjLPXlK
	 qTQPRfUFl33Fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58D1C27C79;
	Wed, 19 Jun 2024 14:32:14 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Wed, 19 Jun 2024 22:30:50 +0800
Subject: [PATCH v2 09/14] drm/mediatek: Set DRM mode configs accordingly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-mediatek-drm-next-v2-9-abf68f46f8d2@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718807531; l=3538;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=rS4Xgj0LEBxL5IBSK6SfigvQYUwjVgXB9N8a+kyhjQ0=;
 b=Fp9AGslx+lI67r6rismPXijrPNV9pFijNLIzOFu3BRWE8mAciFgSXIpAswNVyRzNxbrwPu8AR
 DjN5b5VtzDBAKBc6UGiYaOQxEtfq3GLca1s9p8+AdNY94AONyYSulbh
X-Developer-Key: i=shawn.sung@mediatek.com; a=ed25519;
 pk=lq1w8BuWDINX+4JHjGHhhbAU5ICP+cL9VCj7wn+cEDA=
X-Endpoint-Received: by B4 Relay for shawn.sung@mediatek.com/20240616 with
 auth_id=172
X-Original-From: Hsiao Chien Sung <shawn.sung@mediatek.com>
Reply-To: shawn.sung@mediatek.com

From: Hsiao Chien Sung <shawn.sung@mediatek.com>

Set DRM mode configs limitation according to the hardware capabilities
and pass the IGT checks as below:

- The test "graphics.IgtKms.kms_plane" requires a frame buffer with
  width of 4512 pixels (> 4096).
- The test "graphics.IgtKms.kms_cursor_crc" checks if the cursor size is
  defined, and run the test with cursor size from 1x1 to 512x512.

Please notice that the test conditions may change as IGT is updated.

Reviewed-by: CK Hu <ck.hu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.h |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8e047043202b..c9cad3a82737 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -294,6 +294,9 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
 	.conn_routes = mt8188_mtk_ddp_main_routes,
 	.num_conn_routes = ARRAY_SIZE(mt8188_mtk_ddp_main_routes),
 	.mmsys_dev_num = 2,
+	.max_width = 8191,
+	.min_width = 1,
+	.min_height = 1,
 };
 
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
@@ -308,6 +311,9 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys0_driver_data = {
 	.main_path = mt8195_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt8195_mtk_ddp_main),
 	.mmsys_dev_num = 2,
+	.max_width = 8191,
+	.min_width = 1,
+	.min_height = 1,
 };
 
 static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
@@ -315,6 +321,9 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
 	.ext_len = ARRAY_SIZE(mt8195_mtk_ddp_ext),
 	.mmsys_id = 1,
 	.mmsys_dev_num = 2,
+	.max_width = 8191,
+	.min_width = 2, /* 2-pixel align when ethdr is bypassed */
+	.min_height = 1,
 };
 
 static const struct of_device_id mtk_drm_of_ids[] = {
@@ -493,6 +502,15 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 		for (j = 0; j < private->data->mmsys_dev_num; j++) {
 			priv_n = private->all_drm_private[j];
 
+			if (priv_n->data->max_width)
+				drm->mode_config.max_width = priv_n->data->max_width;
+
+			if (priv_n->data->min_width)
+				drm->mode_config.min_width = priv_n->data->min_width;
+
+			if (priv_n->data->min_height)
+				drm->mode_config.min_height = priv_n->data->min_height;
+
 			if (i == CRTC_MAIN && priv_n->data->main_len) {
 				ret = mtk_crtc_create(drm, priv_n->data->main_path,
 						      priv_n->data->main_len, j,
@@ -520,6 +538,10 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 		}
 	}
 
+	/* IGT will check if the cursor size is configured */
+	drm->mode_config.cursor_width = drm->mode_config.max_width;
+	drm->mode_config.cursor_height = drm->mode_config.max_height;
+
 	/* Use OVL device for all DMA memory allocations */
 	crtc = drm_crtc_from_index(drm, 0);
 	if (crtc)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 78d698ede1bf..ce897984de51 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -46,6 +46,10 @@ struct mtk_mmsys_driver_data {
 	bool shadow_register;
 	unsigned int mmsys_id;
 	unsigned int mmsys_dev_num;
+
+	u16 max_width;
+	u16 min_width;
+	u16 min_height;
 };
 
 struct mtk_drm_private {

-- 
Git-146)



