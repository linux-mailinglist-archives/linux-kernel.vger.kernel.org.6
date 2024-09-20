Return-Path: <linux-kernel+bounces-334103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F3497D2A6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C211F217F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D07E139D0A;
	Fri, 20 Sep 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Pencszbb"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416BC13A3F7;
	Fri, 20 Sep 2024 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820578; cv=none; b=eUKLEgsAvUD1Iu9RSuzfxOjRMvC8MoIYxuhqI4Be0sgBmaRB39uktYPglqnNNBINRmphPLy75wZ3U4sgPk4JDUiCZ0x4No8xJDOUtbjZRtCvgn/c5KtUP13NVvR8HkOR1RjOwTVCw3RSpNDgQc48Bb+fhusJR6F74CK3A4P02I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820578; c=relaxed/simple;
	bh=1J3Ib/7AKZhWTIigKdPyi62sC5Wr/oH9QxVfgptQxw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gecpO5ndPmkWKTi+Le4YnFX0o2SSPm2LqCxYvDpWS6+xosqKx2rol80euQnVx3to915w4A71DR5+IbnKucSr4AXeN/bmr3+teXmvehJJNzqYGh9q4OSOUt8rZQrzyn3oVW2Fr7MDZBEmiJdfidw6Q8GDezGzPUzY+UMDuatwz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Pencszbb; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=ADJCW
	UsgZCd8r/Ij0sNjbTndczhdweGSv1hZH8aR7jI=; b=Pencszbb69Yf7rKdEMjq8
	9WH3LLD1/VMdFwUKj9jAIathNl739mflh6TGV78yBsHAfEmvxVXLQkh3peYqdOvP
	BU2wv3xaLEp3zthF7nkLTMQWPHopfIfoVPtiOddebHRG1tSgPlKCxo9SkAIP6FRG
	oKfRMsd9ODNiqiUzuytWFU=
Received: from ProDesk.. (unknown [58.22.7.114])
	by gzsmtp2 (Coremail) with SMTP id sSgvCgA3VcXGMO1ml_VnBg--.49853S2;
	Fri, 20 Sep 2024 16:22:34 +0800 (CST)
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
Subject: [PATCH v3 12/15] drm/rockchip: vop2: Set plane possible crtcs by possible vp mask
Date: Fri, 20 Sep 2024 16:22:27 +0800
Message-ID: <20240920082230.6922-1-andyshrk@163.com>
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
X-CM-TRANSID:sSgvCgA3VcXGMO1ml_VnBg--.49853S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrW8JFWkXF43Zr17tw45GFg_yoWxtr45pa
	yxZr9xWF43Cr4agry7Ja98uFyak3sxAw4a93ZrKFsxKr13Kry7Wr1UK3Z8CFyDWFy8Zr1j
	vw43tryDur17tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jF7KsUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQpgXmVODBHlSAAAsG

From: Andy Yan <andy.yan@rock-chips.com>

In the upcoming VOP of rk3576, a window cannot attach to all Video
Ports, we introduce a possible_vp_mask for every window to indicate
which Video Ports this window can attach to.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 18 +++++++++++++++++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 14 ++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index e293310b3042..9603bd8491bc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2112,6 +2112,10 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			if (win->base.type == DRM_PLANE_TYPE_PRIMARY)
 				continue;
 
+			/* If this win can not attached to this VP */
+			if (!(win->data->possible_vp_mask & BIT(vp->id)))
+				continue;
+
 			if (vop2_is_mirror_win(win))
 				continue;
 
@@ -2143,7 +2147,19 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 
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
index 871d9bcd1d80..064167afebf4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -164,6 +164,7 @@ struct vop2_win_data {
 	unsigned int phys_id;
 
 	u32 base;
+	u32 possible_vp_mask;
 	enum drm_plane_type type;
 
 	u32 nformats;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index efd704464fab..95e31ee84f4f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -339,6 +339,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.name = "Smart0-win0",
 		.phys_id = ROCKCHIP_VOP2_SMART0,
 		.base = 0x1c00,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_smart,
 		.nformats = ARRAY_SIZE(formats_smart),
 		.format_modifiers = format_modifiers,
@@ -352,6 +353,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 	}, {
 		.name = "Smart1-win0",
 		.phys_id = ROCKCHIP_VOP2_SMART1,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_smart,
 		.nformats = ARRAY_SIZE(formats_smart),
 		.format_modifiers = format_modifiers,
@@ -365,6 +367,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 	}, {
 		.name = "Esmart1-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART1,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_rk356x_esmart,
 		.nformats = ARRAY_SIZE(formats_rk356x_esmart),
 		.format_modifiers = format_modifiers,
@@ -378,6 +381,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 	}, {
 		.name = "Esmart0-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART0,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_rk356x_esmart,
 		.nformats = ARRAY_SIZE(formats_rk356x_esmart),
 		.format_modifiers = format_modifiers,
@@ -392,6 +396,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.name = "Cluster0-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER0,
 		.base = 0x1000,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -407,6 +412,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.name = "Cluster1-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER1,
 		.base = 0x1200,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -572,6 +578,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster0-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER0,
 		.base = 0x1000,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -587,6 +594,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster1-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER1,
 		.base = 0x1200,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -602,6 +610,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster2-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER2,
 		.base = 0x1400,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -617,6 +626,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Cluster3-win0",
 		.phys_id = ROCKCHIP_VOP2_CLUSTER3,
 		.base = 0x1600,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
@@ -631,6 +641,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart0-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART0,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
@@ -644,6 +655,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart1-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART1,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
@@ -658,6 +670,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.name = "Esmart2-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART2,
 		.base = 0x1c00,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
@@ -670,6 +683,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 	}, {
 		.name = "Esmart3-win0",
 		.phys_id = ROCKCHIP_VOP2_ESMART3,
+		.possible_vp_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3),
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
-- 
2.34.1


