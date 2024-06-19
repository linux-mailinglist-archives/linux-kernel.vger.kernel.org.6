Return-Path: <linux-kernel+bounces-221487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B838090F44E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22DEB2837B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F6158DB1;
	Wed, 19 Jun 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFSRExqe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A86155C83
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815125; cv=none; b=M6OUPz7Pvw7+JT+dw3eDcSNkswM+ULCOYA3D25s2+ck78mITGEKdHqgmGwXFCJSZhxm/4KAHcKwpoAfl2TD90CoHCJX/M+dm5z4lTdQUvEv1coCL2lq3lU2dO3zqQTY2PfmGdVUeLCCQqx4bZfTASRrHdSEO0Zn6rimHHXz1gZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815125; c=relaxed/simple;
	bh=Eu9A0/ITfQbhuHN1wINLeIGnV+BDBlF/kN0wOMMPbDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A78gih/bEki2dug5/MyWHCYJiBiJmz5mwkUSRngnewNPMcJWNnNegEEebNfn6uZaHg6fQYY2/VbbZVw/3G/EJvxd170Cxcgc7eUsr/sKo9/KqjzzfYJUVJ9ovHaO9vfxkQ0NOWrLtjZbrjBMGJ4O1Anyb+kehgqq5aWPKKjg5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFSRExqe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 572D0C4AF09;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815125;
	bh=Eu9A0/ITfQbhuHN1wINLeIGnV+BDBlF/kN0wOMMPbDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KFSRExqewZrkbfvLAWKo3FSLV4qUKonryLq88DjSbAvNjP1Av5EfjYpW9a4GwD9qz
	 5RrOtNIGRGyW5xuYhJGCG6madtqt3ndm+AD5qvFkpWHo0AsynlnaVX2syvoM96vbL4
	 4AcDYNy9y/V9nGb4pEVDef/yEFTcD/EwxfL7dv1U0Ym+O6s/wOsgNeiH9NARVWasrh
	 wFFEz4WJE0Hdv4ME22ALANOnCDxRQXH4L/Z2Ol0XtxYaxJFN914gkp3MTe2tkLJyZu
	 QEBI6vl1798n9u/icoYH3IBLt/7eSrc4KLof4pwFygcUxhQV6d49dOa9cl/VieBH9C
	 uekXWfRi2IRnQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBDAC2BC81;
	Wed, 19 Jun 2024 16:38:45 +0000 (UTC)
From: Hsiao Chien Sung via B4 Relay <devnull+shawn.sung.mediatek.com@kernel.org>
Date: Thu, 20 Jun 2024 00:38:50 +0800
Subject: [PATCH v3 10/14] drm/mediatek: Set DRM mode configs accordingly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-igt-v3-10-a9d62d2e2c7e@mediatek.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718815123; l=3617;
 i=shawn.sung@mediatek.com; s=20240616; h=from:subject:message-id;
 bh=m0EG3CktaVu4W67UszRONTV4/7xw5TYqkuXRJdICaFc=;
 b=TMj8/v0fTr1m458crp3qdNkIRDjZE/hOgBhE1U4mPkyPWXfnTsF/rjbzDR+3fY+xHx26Jv5PZ
 E/Jj6LV9LfqD9A2eNCX8HH3snv4DnANhqhcN6cUx+WKAwVFL1tUpaAn
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
Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
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



