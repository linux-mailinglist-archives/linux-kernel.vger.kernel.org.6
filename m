Return-Path: <linux-kernel+bounces-445920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 481CC9F1D83
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615421606CA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02CB187FFA;
	Sat, 14 Dec 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WJ5Eu/6v"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DEC1865EB;
	Sat, 14 Dec 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164362; cv=none; b=rgOmC9KU7br8VR7W4WUksXKCRM8iKC3A779HLrT6qHG4H+Tsjq2rZ3AOM2sRRNu351g8uLPK+nj1mRwwlSRzChlFrr+Uw2qJtw0H4sowpbMU03BQCyER+J8KkukuoejCR5/LUbMCRi4e6jv4FkxCIGISJmDakwWN6Sx4uEBJ618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164362; c=relaxed/simple;
	bh=ch/V3e8mgEj0SBd4FLMmW75la9OgZBd6r2LGxPatVqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdpvfUwU8rGfq6vZRBbwNyyuBNzFOwQ7FerHAdT0sT8taou5RNDeMXddv8+TNzWBeWe1oDFBHtgr0qlryOrgoStM2tQ+N+9x7Cj6cX10/+I1woDlXVFP8TCiNM7ZfS5JvHAWCGsLNmjCuNwqpF0wJRZPrkGXivGA1RHJyiHwIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WJ5Eu/6v; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=MK6YN
	qwn4ccpezo2REpujfU/o0ioNeh1KcuBZb/oGMM=; b=WJ5Eu/6vrCwYBVbw4JXZf
	uFre404T/BvjeaUlVFiaMcZQNvmnn/6eqm1SaFeJC6uK+CNWGiHfG3v2UM15NOJ4
	BkuFjQELMCaysKKEnhxvW3GpRBikuo/+39rZ7548fKBbgkAYfkNJ9lyQfhvW66Ga
	kdEGKHG5RYBNbHYvTpzw/w=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnr+ZwP11nYmP5AQ--.46394S2;
	Sat, 14 Dec 2024 16:19:00 +0800 (CST)
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
	detlev.casanova@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>,
	Michael Riesch <michael.riesch@wolfvision.net>
Subject: [PATCH v6 13/16] drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
Date: Sat, 14 Dec 2024 16:18:54 +0800
Message-ID: <20241214081855.3330798-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241214081719.3330518-1-andyshrk@163.com>
References: <20241214081719.3330518-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr+ZwP11nYmP5AQ--.46394S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrWUXr1UGF4kGFyxKF17Wrg_yoWxKrWUpa
	yxZry3WF4fCr4agry7Ja98ZFyak39xAw4a93ZrKFsxKr13Kry7Wr1UK3Z8Cr1DWFy8Zr1j
	vw43trWDurnrtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jo_M3UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRC1XmddM6y5mwAAsV

From: Andy Yan <andy.yan@rock-chips.com>

In the upcoming VOP of rk3576, a window cannot attach to all Video
Ports, we introduce a possible_vp_mask for every window to indicate
which Video Ports this window can attach to.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 18 +++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 14 ++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index e588d5d01e0a..0b79f2006836 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2311,6 +2311,10 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			if (win->base.type == DRM_PLANE_TYPE_PRIMARY)
 				continue;
 
+			/* If this win can not attached to this VP */
+			if (!(win->data->possible_vp_mask & BIT(vp->id)))
+				continue;
+
 			if (vop2_is_mirror_win(win))
 				continue;
 
@@ -2342,7 +2346,19 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 
 		win->type = DRM_PLANE_TYPE_OVERLAY;
 
-		possible_crtcs = (1 << nvps) - 1;
+		possible_crtcs = 0;
+		nvp = 0;
+		for (j = 0; j < vop2_data->nr_vps; j++) {
+			vp = &vop2->vps[j];
+
+			if (!vp->crtc.port)
+				continue;
+
+			if (win->data->possible_vp_mask & BIT(vp->id))
+				possible_crtcs |= BIT(nvp);
+			nvp++;
+		}
+
 		ret = vop2_plane_init(vop2, win, possible_crtcs);
 		if (ret) {
 			drm_err(vop2->drm, "failed to init overlay plane %s: %d\n",
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 21464d107bd3..3c9caf13749d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -167,6 +167,7 @@ struct vop2_win_data {
 	unsigned int phys_id;
 
 	u32 base;
+	u32 possible_vp_mask;
 	enum drm_plane_type type;
 
 	u32 nformats;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index e311af7e3a1a..85c15dd396aa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -347,6 +347,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.name = "Smart0-win0",
 		.phys_id = ROCKCHIP_VOP2_SMART0,
 		.base = 0x1c00,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_smart,
 		.nformats = ARRAY_SIZE(formats_smart),
 		.format_modifiers = format_modifiers,
@@ -360,6 +361,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 	}, {
 		.name = "Smart1-win0",
 		.phys_id = ROCKCHIP_VOP2_SMART1,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_smart,
 		.nformats = ARRAY_SIZE(formats_smart),
 		.format_modifiers = format_modifiers,
@@ -373,6 +375,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 	}, {
 		.name = "Esmart1-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART1,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_rk356x_esmart,
 		.nformats = ARRAY_SIZE(formats_rk356x_esmart),
 		.format_modifiers = format_modifiers,
@@ -386,6 +389,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 	}, {
 		.name = "Esmart0-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART0,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_rk356x_esmart,
 		.nformats = ARRAY_SIZE(formats_rk356x_esmart),
 		.format_modifiers = format_modifiers,
@@ -400,6 +404,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.name = "Cluster0-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER0,
 		.base = 0x1000,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -415,6 +420,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.name = "Cluster1-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER1,
 		.base = 0x1200,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -580,6 +586,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster0-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER0,
 		.base = 0x1000,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -598,6 +605,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster1-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER1,
 		.base = 0x1200,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -616,6 +624,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster2-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER2,
 		.base = 0x1400,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -634,6 +643,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster3-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER3,
 		.base = 0x1600,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -651,6 +661,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart0-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART0,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
@@ -667,6 +678,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart1-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART1,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
@@ -684,6 +696,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Esmart2-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART2,
 		.base = 0x1c00,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
@@ -699,6 +712,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart3-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART3,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
-- 
2.34.1


