Return-Path: <linux-kernel+bounces-423172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEF79DA3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBDE164638
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF1188014;
	Wed, 27 Nov 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fJ3zPtqZ"
Received: from mail-m10146.netease.com (mail-m10146.netease.com [154.81.10.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731A13C816;
	Wed, 27 Nov 2024 08:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732696112; cv=none; b=j0HlggYBwIRGUznh4ktlJujGChtzDThdDmWoa/G/+RPD9jcowc6jt+z6Z4LgF0YbsfymMhmV1bE0ddYXO2ObRafh49/gSfzHaaW6D7K9FFJXW40CNbLNeT0++wcDJsl+LvFaLumgmbP6cjlPHie8nPS5GIwtUMHyZKnij/0OMXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732696112; c=relaxed/simple;
	bh=zc3L22NK7G+2cJEJhvmVPUh7hb0qrtSDzUnnvgfNeFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hRV8PLlyBF99TxVbeg7RkFXGuFFoXmDLDCRhA5+I2ROhvaqqO8M25em3I2G9fctL7tUd0pT0z4tSD7oUkSUBLiVZ4Sy19fySt+/pSsxwFD4hY/NN5ELXzSlDJF6jAj6SZBH8PhWgruU213DHS2yKLdIUMPLGCc5sCfMKwPk6GB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fJ3zPtqZ; arc=none smtp.client-ip=154.81.10.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3f86cd8e;
	Wed, 27 Nov 2024 15:52:59 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rfoss@kernel.org,
	vkoul@kernel.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	l.stach@pengutronix.de,
	andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	algea.cao@rock-chips.com,
	kever.yang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 03/10] drm/rockchip: analogix_dp: Add support for RK3588
Date: Wed, 27 Nov 2024 15:51:50 +0800
Message-Id: <20241127075157.856029-4-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127075157.856029-1-damon.ding@rock-chips.com>
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkoeSVZLSRhLHUgfShpKGExWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a936c9bf11003a3kunm3f86cd8e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46Hyo4EDIvIy8hAQxCTRM1
	CQkaChJVSlVKTEhJTUJIQkNKSENPVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUpJNwY+
DKIM-Signature:a=rsa-sha256;
	b=fJ3zPtqZmoqzg6peZMgvxdKvjnwiDibrzpe/EIPL/D2xNq7cqkO86dU6K1ci/50pawJq2oE/f4+ZL49JAqRMquYwFZybCfvdgzWIpryB9WkkNNHuh7GqfiLO7gGtrU7dc3A6c5iRfj2m1N3eTqPBFvl+hMrvlEQvuo3NeAZ1AMA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=WLNiq88ANBJPy615q4N0GWBZC6nUNXYDktxPXr3xPC8=;
	h=date:mime-version:subject:message-id:from;

RK3588 integrates the analogix eDP 1.3 TX controller IP and the HDMI/eDP
TX Combo PHY based on a Samsung IP block.

Add just the basic support for now, i.e. RGB output up to 4K@60Hz, without
the tests of audio, PSR and other eDP 1.3 specific features.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 41 +++++++++++++++++--
 include/drm/bridge/analogix_dp.h              |  3 +-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index edb08a816c3f..e5792deb7885 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -51,10 +51,12 @@ struct rockchip_grf_reg_field {
 /**
  * struct rockchip_dp_chip_data - splite the grf setting of kind of chips
  * @lcdc_sel: grf register field of lcdc_sel
+ * @edp_mode: grf register field of edp_mode
  * @chip_type: specific chip type
  */
 struct rockchip_dp_chip_data {
 	const struct rockchip_grf_reg_field lcdc_sel;
+	const struct rockchip_grf_reg_field edp_mode;
 	u32	chip_type;
 };
 
@@ -134,12 +136,21 @@ static int rockchip_dp_poweron(struct analogix_dp_plat_data *plat_data)
 		return ret;
 	}
 
+	ret = rockchip_grf_field_write(dp->grf, &dp->data->edp_mode, 1);
+	if (ret != 0)
+		DRM_DEV_ERROR(dp->dev, "failed to set edp mode %d\n", ret);
+
 	return ret;
 }
 
 static int rockchip_dp_powerdown(struct analogix_dp_plat_data *plat_data)
 {
 	struct rockchip_dp_device *dp = pdata_encoder_to_dp(plat_data);
+	int ret;
+
+	ret = rockchip_grf_field_write(dp->grf, &dp->data->edp_mode, 0);
+	if (ret != 0)
+		DRM_DEV_ERROR(dp->dev, "failed to set edp mode %d\n", ret);
 
 	clk_disable_unprepare(dp->pclk);
 
@@ -203,6 +214,10 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
 	struct rockchip_dp_device *dp = encoder_to_dp(encoder);
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
+	struct of_endpoint endpoint;
+	struct device_node *remote_port, *remote_port_parent;
+	char name[32];
+	u32 port_id;
 	int ret;
 
 	crtc = rockchip_dp_drm_get_new_crtc(encoder, state);
@@ -220,13 +235,27 @@ static void rockchip_dp_drm_encoder_enable(struct drm_encoder *encoder,
 		return;
 	}
 
-	ret = drm_of_encoder_active_endpoint_id(dp->dev->of_node, encoder);
+	ret = drm_of_encoder_active_endpoint(dp->dev->of_node, encoder, &endpoint);
 	if (ret < 0)
 		return;
 
-	DRM_DEV_DEBUG(dp->dev, "vop %s output to dp\n", (ret) ? "LIT" : "BIG");
+	remote_port_parent = of_graph_get_remote_port_parent(endpoint.local_node);
+	if (remote_port_parent) {
+		if (of_get_child_by_name(remote_port_parent, "ports")) {
+			remote_port = of_graph_get_remote_port(endpoint.local_node);
+			of_property_read_u32(remote_port, "reg", &port_id);
+			of_node_put(remote_port);
+			sprintf(name, "%s vp%d", remote_port_parent->full_name, port_id);
+		} else {
+			sprintf(name, "%s %s",
+				remote_port_parent->full_name, endpoint.id ? "vopl" : "vopb");
+		}
+		of_node_put(remote_port_parent);
+
+		DRM_DEV_DEBUG(dp->dev, "%s output to edp\n", name);
+	}
 
-	ret = rockchip_grf_field_write(dp->grf, &dp->data->lcdc_sel, ret);
+	ret = rockchip_grf_field_write(dp->grf, &dp->data->lcdc_sel, endpoint.id);
 	if (ret != 0)
 		DRM_DEV_ERROR(dp->dev, "Could not write to GRF: %d\n", ret);
 
@@ -474,9 +503,15 @@ static const struct rockchip_dp_chip_data rk3288_dp = {
 	.lcdc_sel = GRF_REG_FIELD(0x025c, 5, 5),
 };
 
+static const struct rockchip_dp_chip_data rk3588_edp = {
+	.edp_mode = GRF_REG_FIELD(0x0000, 0, 0),
+	.chip_type = RK3588_EDP,
+};
+
 static const struct of_device_id rockchip_dp_dt_ids[] = {
 	{.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
 	{.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
+	{.compatible = "rockchip,rk3588-edp", .data = &rk3588_edp },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
index 6002c5666031..54086cb2d97d 100644
--- a/include/drm/bridge/analogix_dp.h
+++ b/include/drm/bridge/analogix_dp.h
@@ -15,11 +15,12 @@ enum analogix_dp_devtype {
 	EXYNOS_DP,
 	RK3288_DP,
 	RK3399_EDP,
+	RK3588_EDP,
 };
 
 static inline bool is_rockchip(enum analogix_dp_devtype type)
 {
-	return type == RK3288_DP || type == RK3399_EDP;
+	return type == RK3288_DP || type == RK3399_EDP || type == RK3588_EDP;
 }
 
 struct analogix_dp_plat_data {
-- 
2.34.1


