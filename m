Return-Path: <linux-kernel+bounces-445915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2119F1D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E8E1887EF5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461751ACDF0;
	Sat, 14 Dec 2024 08:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m3p5E2sQ"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A62190462;
	Sat, 14 Dec 2024 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734164277; cv=none; b=M6KhrOlL5z31PFZ2IxaaPv6wB4MbJwdYsfpVDmtcO+5t4GvUdSoyVeRLTC3nNnBtyzSfSerD9ud9UKMtuR0HSSiUKlzxSnI7h+Up8Fi/Y732YfnjWPXb4+8hvE7bnr52Rn4J2AlHYc/RO8e6aq3bQJc3FHjSAT6LsTU1Ktm7blI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734164277; c=relaxed/simple;
	bh=ilQjcqxQUV8Bx3lArneyN5a+BdCeOSGFCz50hLU7DhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb/nk4U9RZb0d1W9C9243niD20JdaG0PBZLxPF64L+0QVHcfUr+wl8Z+Wwvu4FfV/Gj3X6A6s7ZbxJr+wTo3Zm6/FMvjHEJ/W6xLDjR69MR5nBjUdCirysFEkyN2dUVAI8hwaE/6fIp3LQFvC2BJ/GHLtO+zSa87C9XwBBApeUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m3p5E2sQ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=q3F9R
	5g1mI+h2r+pcsr+vPpJmWeRPbUG5Wk4Xk1AFl0=; b=m3p5E2sQZh2Z6HSb1i0b4
	NNRk0Npc58W5rZyi64zVNV+ynr/SOhWa+5c2/t4GD7DrqPcFMkv9sOweWK/G37Mo
	seXrldhKdzTPy6BX5YIbSnewzd9koPFgKlFxl0wDulbyHzicYFxp2q65xejfileU
	uRi1U4rXsmYe+fROvp8liw=
Received: from ProDesk.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3fwEQP11ntNLtAQ--.5686S12;
	Sat, 14 Dec 2024 16:17:33 +0800 (CST)
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
Subject: [PATCH v6 10/16] drm/rockchip: vop2: Support for different layer select configuration between VPs
Date: Sat, 14 Dec 2024 16:17:09 +0800
Message-ID: <20241214081719.3330518-11-andyshrk@163.com>
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
X-CM-TRANSID:_____wD3fwEQP11ntNLtAQ--.5686S12
X-Coremail-Antispam: 1Uf129KBjvJXoWxtrW8JF4UZF47CF4UWFy8Zrb_yoWfJw4Upa
	yUursIg3W5Cr45tryUJayrZr4rGwn8tay3uan3Kw1xGFn5KrWDJF4ktF95A3Z8KF93ZryU
	Xw1YgryDZrW7tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4E__UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0ge1XmddMGzoCgAAs6

From: Andy Yan <andy.yan@rock-chips.com>

In the upcoming VOP for rk3576, every VP has it's own LAYER_SEL
register, and the configuration value of each VP for the same
window maybe different, so extend the layer_sel_id to array,
let it can descption the layer select configuration value for
different VP.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
Tested-by: Detlev Casanova <detlev.casanova@collabora.com>

---

(no changes since v4)

Changes in v4:
- Typo fix: selet->select

 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  4 +--
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 38 ++++++++++----------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
index 265bb5bfa27d..af3cd92e6815 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
@@ -166,9 +166,9 @@ struct vop2_win_data {
 	const unsigned int supported_rotations;
 
 	/**
-	 * @layer_sel_id: defined by register OVERLAY_LAYER_SEL of VOP2
+	 * @layer_sel_id: defined by register OVERLAY_LAYER_SEL or PORTn_LAYER_SEL
 	 */
-	unsigned int layer_sel_id;
+	unsigned int layer_sel_id[ROCKCHIP_MAX_CRTC];
 	uint64_t feature;
 
 	uint8_t axi_bus_id;
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index a2e0126a31a0..01336ef2482a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -350,7 +350,8 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.formats = formats_smart,
 		.nformats = ARRAY_SIZE(formats_smart),
 		.format_modifiers = format_modifiers,
-		.layer_sel_id = 3,
+		/* 0xf means this layer can't attached to this VP */
+		.layer_sel_id = { 3, 3, 3, 0xf },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
 		.max_upscale_factor = 8,
@@ -363,7 +364,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.nformats = ARRAY_SIZE(formats_smart),
 		.format_modifiers = format_modifiers,
 		.base = 0x1e00,
-		.layer_sel_id = 7,
+		.layer_sel_id = { 7, 7, 7, 0xf },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
 		.max_upscale_factor = 8,
@@ -376,7 +377,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.nformats = ARRAY_SIZE(formats_rk356x_esmart),
 		.format_modifiers = format_modifiers,
 		.base = 0x1a00,
-		.layer_sel_id = 6,
+		.layer_sel_id = { 6, 6, 6, 0xf },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
 		.max_upscale_factor = 8,
@@ -389,7 +390,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.nformats = ARRAY_SIZE(formats_rk356x_esmart),
 		.format_modifiers = format_modifiers,
 		.base = 0x1800,
-		.layer_sel_id = 2,
+		.layer_sel_id = { 2, 2, 2, 0xf },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
 		.max_upscale_factor = 8,
@@ -402,7 +403,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
-		.layer_sel_id = 0,
+		.layer_sel_id = { 0, 0, 0, 0xf },
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 					DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.max_upscale_factor = 4,
@@ -417,7 +418,7 @@ static const struct vop2_win_data rk3568_vop_win_data[] = {
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
-		.layer_sel_id = 1,
+		.layer_sel_id = { 1, 1, 1, 0xf },
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 					DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
@@ -582,7 +583,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
-		.layer_sel_id = 0,
+		.layer_sel_id = { 0, 0, 0, 0 },
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.axi_bus_id = 0,
@@ -600,7 +601,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
-		.layer_sel_id = 1,
+		.layer_sel_id = { 1, 1, 1, 1 },
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
@@ -618,7 +619,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
-		.layer_sel_id = 4,
+		.layer_sel_id = { 4, 4, 4, 4 },
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
@@ -636,7 +637,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.formats = formats_cluster,
 		.nformats = ARRAY_SIZE(formats_cluster),
 		.format_modifiers = format_modifiers_afbc,
-		.layer_sel_id = 5,
+		.layer_sel_id =  { 5, 5, 5, 5 },
 		.supported_rotations = DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270 |
 				       DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_PRIMARY,
@@ -654,7 +655,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
 		.base = 0x1800,
-		.layer_sel_id = 2,
+		.layer_sel_id = { 2, 2, 2, 2 },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
 		.axi_bus_id = 0,
@@ -670,7 +671,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
 		.base = 0x1a00,
-		.layer_sel_id = 3,
+		.layer_sel_id = { 3, 3, 3, 3 },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
 		.axi_bus_id = 0,
@@ -686,7 +687,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.formats = formats_esmart,
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
-		.layer_sel_id = 6,
+		.layer_sel_id =  { 6, 6, 6, 6 },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
 		.axi_bus_id = 1,
@@ -702,7 +703,7 @@ static const struct vop2_win_data rk3588_vop_win_data[] = {
 		.nformats = ARRAY_SIZE(formats_esmart),
 		.format_modifiers = format_modifiers,
 		.base = 0x1e00,
-		.layer_sel_id = 7,
+		.layer_sel_id =  { 7, 7, 7, 7 },
 		.supported_rotations = DRM_MODE_REFLECT_Y,
 		.type = DRM_PLANE_TYPE_OVERLAY,
 		.axi_bus_id = 1,
@@ -1454,7 +1455,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		 */
 		for (old_layer_id = 0; old_layer_id < vop2->data->win_size; old_layer_id++) {
 			layer_sel_id = (layer_sel >> (4 * old_layer_id)) & 0xf;
-			if (layer_sel_id == win->data->layer_sel_id)
+			if (layer_sel_id == win->data->layer_sel_id[vp->id])
 				break;
 		}
 
@@ -1464,7 +1465,7 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		for (i = 0; i < vop2->data->win_size; i++) {
 			old_win = &vop2->win[i];
 			layer_sel_id = (layer_sel >> (4 * layer_id)) & 0xf;
-			if (layer_sel_id == old_win->data->layer_sel_id)
+			if (layer_sel_id == old_win->data->layer_sel_id[vp->id])
 				break;
 		}
 
@@ -1512,13 +1513,14 @@ static void rk3568_vop2_setup_layer_mixer(struct vop2_video_port *vp)
 		}
 
 		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(layer_id, 0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(layer_id, win->data->layer_sel_id);
+		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(layer_id, win->data->layer_sel_id[vp->id]);
 		/*
 		 * When we bind a window from layerM to layerN, we also need to move the old
 		 * window on layerN to layerM to avoid one window selected by two or more layers.
 		 */
 		layer_sel &= ~RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, 0x7);
-		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(old_layer_id, old_win->data->layer_sel_id);
+		layer_sel |= RK3568_OVL_LAYER_SEL__LAYER(old_layer_id,
+			     old_win->data->layer_sel_id[vp->id]);
 	}
 
 	vop2_writel(vop2, RK3568_OVL_LAYER_SEL, layer_sel);
-- 
2.34.1


