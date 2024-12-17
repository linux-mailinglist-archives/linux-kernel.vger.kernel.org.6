Return-Path: <linux-kernel+bounces-448423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1619F9F3FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 02:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D559A188FBE2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693642837A;
	Tue, 17 Dec 2024 01:18:24 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116D78F77
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 01:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734398304; cv=none; b=eIrb58tMm7/AYw0qWH17xB1NLMxPZ30mJiV7UJ6EVeu9MGQ3U8STc+vz4HRU5J0k8TW9jBwKELLCGwSloKjp3Elf1MIk6n2ptuiOQi8tmW9GkkKPml8otY+ZXfl7v73Tf7u6aGrTQrAN/wp6RreAE4LbU5xT5IOQRxpPZYQvPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734398304; c=relaxed/simple;
	bh=1fssTMV0OBBwwLuFnG66rrOEzAxXvJA/Co1BOUZc90s=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yd6eluv8FcKD7B4pIw394fi0JiplhFjhjFjLCmxMX3DEFezjC1n+BuOuJZFlBB7UrDuhyfvFpIKNRJzY3eTqSyrCl2QLkkaJkx0BknbpUPt1iRgzWg5aDCISLyWvnPLtik2dF1I6qHWrddPFUhWPC2f/YXsq6sMtkYIkoCpS3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tNMDs-000000004YP-4BIn;
	Tue, 17 Dec 2024 01:18:05 +0000
Date: Tue, 17 Dec 2024 01:18:01 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Justin Green <greenjustin@chromium.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>, dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] drm/mediatek: only touch DISP_REG_OVL_PITCH_MSB if AFBC
 is supported
Message-ID: <c7fbd3c3e633c0b7dd6d1cd78ccbdded31e1ca0f.1734397800.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Touching DISP_REG_OVL_PITCH_MSB leads to video overlay on MT2701, MT7623N
and probably other older SoCs being broken.

Move setting up AFBC layer configuration into a separate function only
being called on hardware which actually supports AFBC which restores the
behavior as it was before commit c410fa9b07c3 ("drm/mediatek: Add AFBC
support to Mediatek DRM driver") on non-AFBC hardware.

Fixes: c410fa9b07c3 ("drm/mediatek: Add AFBC support to Mediatek DRM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: move AFBC layer config into a new function

 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 57 +++++++++++++------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index f731d4fbe8b6..e0e24f0a6edd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -460,6 +460,29 @@ static unsigned int mtk_ovl_fmt_convert(struct mtk_disp_ovl *ovl,
 	}
 }
 
+static void mtk_ovl_afbc_layer_config(struct mtk_disp_ovl *ovl,
+				      unsigned int idx,
+				      struct mtk_plane_pending_state *pending,
+				      struct cmdq_pkt *cmdq_pkt)
+{
+	unsigned int pitch_msb = pending->pitch >> 16;
+	unsigned int hdr_pitch = pending->hdr_pitch;
+	unsigned int hdr_addr = pending->hdr_addr;
+
+	if (pending->modifier != DRM_FORMAT_MOD_LINEAR) {
+		mtk_ddp_write_relaxed(cmdq_pkt, hdr_addr, &ovl->cmdq_reg, ovl->regs,
+				      DISP_REG_OVL_HDR_ADDR(ovl, idx));
+		mtk_ddp_write_relaxed(cmdq_pkt,
+				      OVL_PITCH_MSB_2ND_SUBBUF | pitch_msb,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
+		mtk_ddp_write_relaxed(cmdq_pkt, hdr_pitch, &ovl->cmdq_reg, ovl->regs,
+				      DISP_REG_OVL_HDR_PITCH(ovl, idx));
+	} else {
+		mtk_ddp_write_relaxed(cmdq_pkt, pitch_msb,
+				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
+	}
+}
+
 void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 			  struct mtk_plane_state *state,
 			  struct cmdq_pkt *cmdq_pkt)
@@ -467,25 +490,13 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 	struct mtk_plane_pending_state *pending = &state->pending;
 	unsigned int addr = pending->addr;
-	unsigned int hdr_addr = pending->hdr_addr;
-	unsigned int pitch = pending->pitch;
-	unsigned int hdr_pitch = pending->hdr_pitch;
+	unsigned int pitch_lsb = pending->pitch & GENMASK(15, 0);
 	unsigned int fmt = pending->format;
 	unsigned int offset = (pending->y << 16) | pending->x;
 	unsigned int src_size = (pending->height << 16) | pending->width;
 	unsigned int blend_mode = state->base.pixel_blend_mode;
 	unsigned int ignore_pixel_alpha = 0;
 	unsigned int con;
-	bool is_afbc = pending->modifier != DRM_FORMAT_MOD_LINEAR;
-	union overlay_pitch {
-		struct split_pitch {
-			u16 lsb;
-			u16 msb;
-		} split_pitch;
-		u32 pitch;
-	} overlay_pitch;
-
-	overlay_pitch.pitch = pitch;
 
 	if (!pending->enable) {
 		mtk_ovl_layer_off(dev, idx, cmdq_pkt);
@@ -524,11 +535,12 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	}
 
 	if (ovl->data->supports_afbc)
-		mtk_ovl_set_afbc(ovl, cmdq_pkt, idx, is_afbc);
+		mtk_ovl_set_afbc(ovl, cmdq_pkt, idx,
+				 pending->modifier != DRM_FORMAT_MOD_LINEAR);
 
 	mtk_ddp_write_relaxed(cmdq_pkt, con, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_CON(idx));
-	mtk_ddp_write_relaxed(cmdq_pkt, overlay_pitch.split_pitch.lsb | ignore_pixel_alpha,
+	mtk_ddp_write_relaxed(cmdq_pkt, pitch_lsb | ignore_pixel_alpha,
 			      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH(idx));
 	mtk_ddp_write_relaxed(cmdq_pkt, src_size, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_SRC_SIZE(idx));
@@ -537,19 +549,8 @@ void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 	mtk_ddp_write_relaxed(cmdq_pkt, addr, &ovl->cmdq_reg, ovl->regs,
 			      DISP_REG_OVL_ADDR(ovl, idx));
 
-	if (is_afbc) {
-		mtk_ddp_write_relaxed(cmdq_pkt, hdr_addr, &ovl->cmdq_reg, ovl->regs,
-				      DISP_REG_OVL_HDR_ADDR(ovl, idx));
-		mtk_ddp_write_relaxed(cmdq_pkt,
-				      OVL_PITCH_MSB_2ND_SUBBUF | overlay_pitch.split_pitch.msb,
-				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
-		mtk_ddp_write_relaxed(cmdq_pkt, hdr_pitch, &ovl->cmdq_reg, ovl->regs,
-				      DISP_REG_OVL_HDR_PITCH(ovl, idx));
-	} else {
-		mtk_ddp_write_relaxed(cmdq_pkt,
-				      overlay_pitch.split_pitch.msb,
-				      &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_PITCH_MSB(idx));
-	}
+	if (ovl->data->supports_afbc)
+		mtk_ovl_afbc_layer_config(ovl, idx, pending, cmdq_pkt);
 
 	mtk_ovl_set_bit_depth(dev, idx, fmt, cmdq_pkt);
 	mtk_ovl_layer_on(dev, idx, cmdq_pkt);
-- 
2.47.1

