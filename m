Return-Path: <linux-kernel+bounces-386631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A3F9B4628
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A20EDB221DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19169204935;
	Tue, 29 Oct 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U1WnoWYN"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D6D17C60;
	Tue, 29 Oct 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195759; cv=none; b=sFCXou99Yy9Lq7tLbKBpsltIChglswBJSD0NAMx5WRX4afB9Lbn9eOXIDfdtn5qq+6Yi7DaIXn6zkBPge7TX6jaIrXLf2Tg8kevbrzfNMhJjNf9pFEHILQV+4nMHVl9tlq8IhmxuDumgRLkkS53n2+jcax+Qqfu7hgH1VTNBQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195759; c=relaxed/simple;
	bh=Lle8AndgoTKZHZDS0nOloWn2h04yZE/z8wtVR7+u+nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYLXbfozXXiSZWgCVmhRoJOFwOeBlclIpTrUNd8MSyY3Z5Gf7DWJiW6rsFI2IzYAAEtLysXSUzWvwL9fQf5tnNczHy8pTkFxkN2/Bj8JxoFawDciT/sduIwHncrfdQ6ycs27sTKQG9MFFZHhdqZt9yc0Bse5mHYmXv38U7RAqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U1WnoWYN; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=qsh1K
	mKsTwRgUaxttwXK875+A+NkuqnK07Vadhw2lcw=; b=U1WnoWYNsZNtS6yR2zcRY
	Gou9TXEAt8m+F1c85pGEQR22Xq53OL0FGikXDtMiVRT0aDmamfIGr//EFGAhZgON
	L79ladvNjLBr6oLrDbfnf44vzhd2PkZkNrXlneoe5+hD/5UV9bwJYMKID7ShFyXs
	ZUdbF/lKgLg7oJcquyG848=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nxoCsSBn8+3dEA--.3291S4;
	Tue, 29 Oct 2024 17:55:21 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	krzk+dt@kernel.org,
	s.hauer@pengutronix.de,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	derek.foreman@collabora.com,
	minhuadotchen@gmail.com,
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v4 02/14] drm/rockchip: vop2: Fix cluster windows alpha ctrl registers offset
Date: Tue, 29 Oct 2024 17:54:55 +0800
Message-ID: <20241029095513.391006-3-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029095513.391006-1-andyshrk@163.com>
References: <20241029095513.391006-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3nxoCsSBn8+3dEA--.3291S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AryUWryUZF1fKr1xWr4xtFb_yoW8tFyxpF
	n7Ar90qr47JFs0gw1xJF4DuryfKws2kFW7JF97K3Wagry3Kr9rC3Wq93WDCry5JFyUCr12
	ka9xGrW7uF4jkr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI5l8UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwqHXmcgqJmjwgAAs3

From: Andy Yan <andy.yan@rock-chips.com>

The phy_id of cluster windws are not increase one for each window.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Derek Foreman <derek.foreman@collabora.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>

---

Changes in v4:
- Fix some typo

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index cd861c022a66c..bff190151ae8c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2193,7 +2193,6 @@ static int vop2_find_start_mixer_id_for_vp(struct vop2 *vop2, u8 port_id)
 
 static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_win)
 {
-	u32 offset = (main_win->data->phys_id * 0x10);
 	struct vop2_alpha_config alpha_config;
 	struct vop2_alpha alpha;
 	struct drm_plane_state *bottom_win_pstate;
@@ -2201,6 +2200,7 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	u16 src_glb_alpha_val, dst_glb_alpha_val;
 	bool premulti_en = false;
 	bool swap = false;
+	u32 offset = 0;
 
 	/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/top win */
 	bottom_win_pstate = main_win->base.state;
@@ -2219,6 +2219,22 @@ static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_win *main_wi
 	vop2_parse_alpha(&alpha_config, &alpha);
 
 	alpha.src_color_ctrl.bits.src_dst_swap = swap;
+
+	switch (main_win->data->phys_id) {
+	case ROCKCHIP_VOP2_CLUSTER0:
+		offset = 0x0;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER1:
+		offset = 0x10;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER2:
+		offset = 0x20;
+		break;
+	case ROCKCHIP_VOP2_CLUSTER3:
+		offset = 0x30;
+		break;
+	}
+
 	vop2_writel(vop2, RK3568_CLUSTER0_MIX_SRC_COLOR_CTRL + offset,
 		    alpha.src_color_ctrl.val);
 	vop2_writel(vop2, RK3568_CLUSTER0_MIX_DST_COLOR_CTRL + offset,
-- 
2.34.1


