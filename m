Return-Path: <linux-kernel+bounces-334093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AB497D289
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2FD1F256CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7233D13A86C;
	Fri, 20 Sep 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aCLjwB4V"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7338882876;
	Fri, 20 Sep 2024 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820504; cv=none; b=ZvISJtVqbNFw15FN/jDSYvGy0dtsM10FEYO4M5b9Tz3brdCCusAaLVRzvjGlUJmJ8PvxL9ZWGujYZ0kDwqVpE37FudE3BuLD5dbHkT+pFEhSd4Yb/fjcqXdleh8RTOqfcohqfW9GZ/L3850AJoVtncbiE+QQUfVpOHpBN3iFX/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820504; c=relaxed/simple;
	bh=NkJZMKGNeBL80jNOVq4j9ciirDMAEdlUiDgcdlD0BZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNeJ6jQaMNABRZyxZc8XPdKn1/op8jMa8EogutekHrfQYAB6v88KJxfihvPupxDR/e7bdqC4r3rRGYnPMrQNo2Wz9Gxe8HLOkTAXpPpMqssyxskFsUAzWfS/xuEBDzRPxjd7l1mNloSxLv+2rcLprm5LX6p/Adxvgz00wVKizLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aCLjwB4V; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=SU0ce
	PcU3UeiZAFIZupQ6VPwSqSkMbhiZUCKiN2xRRc=; b=aCLjwB4VlDI1eEKQcJFTM
	VpLSfIx7+mp95MaETbeYJ6QQ5IjKrFPNz/vW0FNF2X6Ty1wm/Y8vnoODylmIR52X
	H04a28qrP8Rx9F43UlSCPH+9DRWeqqcyY4rJgaev3rtff3QqsThdjyd+FLDcJLhu
	fdVasNVM9hnWvd+aojXMjY=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp2 (Coremail) with SMTP id sSgvCgBnY9R4MO1mbdlnBg--.49799S2;
	Fri, 20 Sep 2024 16:21:16 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v3 05/15] drm/rockchip: vop2: Fix the windows switch between different layers
Date: Fri, 20 Sep 2024 16:21:10 +0800
Message-ID: <20240920082111.6712-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920081626.6433-1-andyshrk@163.com>
References: <20240920081626.6433-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sSgvCgBnY9R4MO1mbdlnBg--.49799S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw4fWF4DAFW7Gw15ur4fAFb_yoW5CF13pF
	15WrWjgw4UKFsIqr9rtr48uF4ay397Kay7W3Z7tw1rGFy8tr1DJan8Cr9ayryUGFn3uryj
	yr1Uur909FWjyF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFSoJUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRxgXmVODBHcAgAAsj

From: Andy Yan <andy.yan@rock-chips.com>

Every layer of vop2 should bind a window, and we also need to make
sure that this window is not used by other layer.

0x5 is a reserved layer sel value on rk3568, but it will select
Cluster3 on rk3588, configure unused layers to 0x5  will lead
alpha blending error on rk3588.

When we bind a window from layerM to layerN, we move the old window
on layerN to layerM.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Derek Foreman <derek.foreman@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 38 +++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index c50d93df8404..4776a227e62c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2364,7 +2364,9 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	struct drm_plane *plane;
 	u32 layer_sel = 0;
 	u32 port_sel;
-	unsigned int nlayer, ofs;
+	u8 old_layer_id;
+	u8 layer_sel_id;
+	unsigned int ofs;
 	u32 ovl_ctrl;
 	int i;
 	struct vop2_video_port *vp0 = &vop2->vps[0];
@@ -2408,9 +2410,28 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 	for (i = 0; i < vp->id; i++)
 		ofs += vop2->vps[i].nlayers;
 
-	nlayer = 0;
 	drm_atomic_crtc_for_each_plane(plane, &vp->crtc) {
 		struct vop2_win *win = to_vop2_win(plane);
+		struct vop2_win *old_win;
+
+		/*
+		 * Find the layer this win bind in old state.
+		 */
+		for (old_layer_id = 0; old_layer_id < vop2->data->win_size; old_layer_id++) {
+			layer_sel_id = (layer_sel >> (4 * old_layer_id)) & 0xf;
+			if (layer_sel_id == win->data->layer_sel_id)
+				break;
+		}
+
+		/*
+		 * Find the win bind to this layer in old state
+		 */
+		for (i = 0; i < vop2->data->win_size; i++) {
+			old_win = &vop2->win[i];
+			layer_sel_id = (layer_sel >> (4 * (plane->state->normalized_zpos + ofs))) & 0xf;
+			if (layer_sel_id == old_win->data->layer_sel_id)
+				break;
+		}
 
 		switch (win->data->phys_id) {
 		case ROCKCHIP_VOP2_CLUSTER0:
@@ -2459,13 +2480,12 @@ static void vop2_setup_layer_mixer(struct vop2_video_port *vp)
 							  0x7);
 		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(plane->state->normalized_zpos + ofs,
 							 win->data->layer_sel_id);
-		nlayer++;
-	}
-
-	/* configure unused layers to 0x5 (reserved) */
-	for (; nlayer < vp->nlayers; nlayer++) {
-		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(nlayer + ofs, 0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(nlayer + ofs, 5);
+		/*
+		 * When we bind a window from layerM to layerN, we also need to move the old
+		 * window on layerN to layerM to avoid one window selected by two or more layers.
+		 */
+		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, 0x7);
+		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, old_win->data->layer_sel_id);
 	}
 
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
-- 
2.34.1


