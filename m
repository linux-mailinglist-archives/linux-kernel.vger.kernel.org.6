Return-Path: <linux-kernel+bounces-510821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B68A32285
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F743A8BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC17120B1F2;
	Wed, 12 Feb 2025 09:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j05U+FMj"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9B4206F3F;
	Wed, 12 Feb 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353006; cv=none; b=hpM9P2XJXokX3EkyOSHIDUaGEmiuyvPXz9dVdB3Wv5qA3z/mZ7RJoAbT6m5c6ous6GKG0uFR+xqCO2dSCx7WNEUHu1eHdLchQNJaaLO4rKi2NcRlxZb0hZFpn+jWQJLSuUsAqhth6An9HwkUCaUWSQJs2AZ9OSJvnMlURykPQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353006; c=relaxed/simple;
	bh=sRftGElrF6c3C08wQ5ath1LdlHK2N+pyY6TDGNXNF7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baz0JyRCgCq+SCMChpH4MhBI9+LviQ2rw0B3J3YAlW6/5YJgfgS0uLjTbYTnsV2QQ5WsH4Ot0KlI4nFT4pyvWPhecC6JEcgZOEMA8JeLXxh6eVrlw7ndykXy6SolnU8muz/mDfJTEFLDDk9U4d7UnzNp+KeijK5GZ7YXNHNjkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j05U+FMj; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=B+2D+
	j5/r7swNWHTHahxPbClGVc2AFfDHnl7wLwAR1c=; b=j05U+FMjCi0ZZKnJBfDIR
	wqgACpxPvsylBpVRBOvPl3TwC3cgp/iwHRBQPyC3VZ2Bi3+3wguLKAKl2L77v9fC
	rBRIAnGDw5ep2p5Ibfq/CyKJ9r3Ws/qGcV5Ogy8rZT9K2m9jgGHL0Mw3Upxj0nf3
	tv+7xvjwkIrjYvwoI9+wpo=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wBnG9Fja6xn14FuLQ--.33700S9;
	Wed, 12 Feb 2025 17:35:42 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	detlev.casanova@collabora.com,
	daniel@fooishbar.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v14 07/13] drm/rockchip: vop2: Register the primary plane and overlay plane separately
Date: Wed, 12 Feb 2025 17:35:02 +0800
Message-ID: <20250212093530.52961-8-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212093530.52961-1-andyshrk@163.com>
References: <20250212093530.52961-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnG9Fja6xn14FuLQ--.33700S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFWxtw4ktFWktrWkZr4DCFg_yoWrZrW3pa
	13ta98tr47WF42gry8JF4UAFWYyan2kay7Crn8Gw1a934fKr93ur48KF1DAF1ruFnrWFya
	kFW3K39Y9FWj9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jFFALUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hHxXmesX27yJQAAsB

From: Andy Yan <andy.yan@rock-chips.com>

In the upcoming VOP of rk3576, a Window cannot attach to all Video Ports,
so make sure all VP find it's suitable primary plane, then register the
remain windows as overlay plane will make code easier.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>

---

(no changes since v3)

Changes in v3:
- Add comments for why we should treat rk3566 with special care.

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 100 +++++++++++--------
 1 file changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index a7c26ef18b85..d6f22c17b0f9 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2248,22 +2248,29 @@ static int vop2_plane_init(struct vop2 *vop2, struct vop2_win *win,
 	return 0;
 }
 
-static struct vop2_video_port *find_vp_without_primary(struct vop2 *vop2)
+/*
+ * On RK3566 these windows don't have an independent
+ * framebuffer. They can only share/mirror the framebuffer
+ * with smart0, esmart0 and cluster0 respectively.
+ * And RK3566 share the same vop version with Rk3568, so we
+ * need to use soc_id for identification here.
+ */
+static bool vop2_is_mirror_win(struct vop2_win *win)
 {
-	int i;
-
-	for (i = 0; i < vop2->data->nr_vps; i++) {
-		struct vop2_video_port *vp = &vop2->vps[i];
-
-		if (!vp->crtc.port)
-			continue;
-		if (vp->primary_plane)
-			continue;
+	struct vop2 *vop2 = win->vop2;
 
-		return vp;
+	if (vop2->data->soc_id == 3566) {
+		switch (win->data->phys_id) {
+		case ROCKCHIP_VOP2_SMART1:
+		case ROCKCHIP_VOP2_ESMART1:
+		case ROCKCHIP_VOP2_CLUSTER1:
+			return true;
+		default:
+			return false;
+		}
+	} else {
+		return false;
 	}
-
-	return NULL;
 }
 
 static int vop2_create_crtcs(struct vop2 *vop2)
@@ -2274,7 +2281,9 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 	struct drm_plane *plane;
 	struct device_node *port;
 	struct vop2_video_port *vp;
-	int i, nvp, nvps = 0;
+	struct vop2_win *win;
+	u32 possible_crtcs;
+	int i, j, nvp, nvps = 0;
 	int ret;
 
 	for (i = 0; i < vop2_data->nr_vps; i++) {
@@ -2313,42 +2322,55 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 	}
 
 	nvp = 0;
-	for (i = 0; i < vop2->registered_num_wins; i++) {
-		struct vop2_win *win = &vop2->win[i];
-		u32 possible_crtcs = 0;
-
-		if (vop2->data->soc_id == 3566) {
-			/*
-			 * On RK3566 these windows don't have an independent
-			 * framebuffer. They share the framebuffer with smart0,
-			 * esmart0 and cluster0 respectively.
-			 */
-			switch (win->data->phys_id) {
-			case ROCKCHIP_VOP2_SMART1:
-			case ROCKCHIP_VOP2_ESMART1:
-			case ROCKCHIP_VOP2_CLUSTER1:
+	/* Register a primary plane for every crtc */
+	for (i = 0; i < vop2_data->nr_vps; i++) {
+		vp = &vop2->vps[i];
+
+		if (!vp->crtc.port)
+			continue;
+
+		for (j = 0; j < vop2->registered_num_wins; j++) {
+			win = &vop2->win[j];
+
+			/* Aready registered as primary plane */
+			if (win->base.type == DRM_PLANE_TYPE_PRIMARY)
 				continue;
-			}
-		}
 
-		if (win->type == DRM_PLANE_TYPE_PRIMARY) {
-			vp = find_vp_without_primary(vop2);
-			if (vp) {
+			if (vop2_is_mirror_win(win))
+				continue;
+
+			if (win->type == DRM_PLANE_TYPE_PRIMARY) {
 				possible_crtcs = BIT(nvp);
 				vp->primary_plane = win;
+				ret = vop2_plane_init(vop2, win, possible_crtcs);
+				if (ret) {
+					drm_err(vop2->drm, "failed to init primary plane %s: %d\n",
+						win->data->name, ret);
+					return ret;
+				}
 				nvp++;
-			} else {
-				/* change the unused primary window to overlay window */
-				win->type = DRM_PLANE_TYPE_OVERLAY;
+				break;
 			}
 		}
+	}
+
+	/* Register all unused window as overlay plane */
+	for (i = 0; i < vop2->registered_num_wins; i++) {
+		win = &vop2->win[i];
+
+		/* Aready registered as primary plane */
+		if (win->base.type == DRM_PLANE_TYPE_PRIMARY)
+			continue;
+
+		if (vop2_is_mirror_win(win))
+			continue;
 
-		if (win->type == DRM_PLANE_TYPE_OVERLAY)
-			possible_crtcs = (1 << nvps) - 1;
+		win->type = DRM_PLANE_TYPE_OVERLAY;
 
+		possible_crtcs = (1 << nvps) - 1;
 		ret = vop2_plane_init(vop2, win, possible_crtcs);
 		if (ret) {
-			drm_err(vop2->drm, "failed to init plane %s: %d\n",
+			drm_err(vop2->drm, "failed to init overlay plane %s: %d\n",
 				win->data->name, ret);
 			return ret;
 		}
-- 
2.34.1


