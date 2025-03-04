Return-Path: <linux-kernel+bounces-544171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E600FA4DE35
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A8E1889B7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB5202C5B;
	Tue,  4 Mar 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rhSblchB"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F96202976
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092290; cv=none; b=rB/24ixYOWBWKlnGjlHgGiM2nG1MGxHvHALefWRteEMEkWfQVSrZLJ3SnSjSqyyt+GThcFioJouCF1u8iRn/cwhXtJaWXiP1VjRYjUq39syWPnA0keYH9ud7uyxAT29GlVy9rfMmXlbKLkzMdiYBA+BLTF2ZhIv+S4FDJK1VbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092290; c=relaxed/simple;
	bh=LwSDTfavClgN/bacthFNA3VF+EdVPotSd67SqfOs3k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sg4nYOIAckW7YhYcFYsNE4rvUCcKTrBGujJZ01OUE59iskzv47eRi6OkWa8RStN9YaY6S2nAnZYRN+bREY5OFnl4zFhKw2czAJwGLZ8WYQhSMZZyNN5ySnj5y+VK49RAosxDXSm7dvm6CazCaKoRE8qaj05P4XxlrxBLpvOGewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rhSblchB; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BNXu9SGYwkJe3Al89DP+Rf+f7f7pVObYeYxswqYidC4=; b=rhSblchBl1zPBJJa5dwE36nBgC
	e9cxTOt47I2YgQBwW5o07XmIfD0oER1SPURbqVWzzVKVcH43L2GXaEdHEhy23UvGncw1zibXhZqzT
	DfvVVRILEeONjqjYu/utHhlJ1uBT70I3sXp0aRtN7LhqTNilEQxNCzOJwfKtO/YZ7vqkapiC/4940
	RnX//YP1pAIQisXEQu/idUZJGOJLhNhe5wHzZgfsZSD/+12Mga9cQ035Wc2vaaqYEfnI7h6oSc3Oi
	4vzXuM/R32sOz04boiyzzPXYUctmEbKlroNQB+x20m0m5AoS+dzJEV+q2uPHQqohcAyptY0IjtN34
	0sGw3uRg==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpRdS-0003B0-6W; Tue, 04 Mar 2025 13:44:34 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v3 2/3] drm/rockchip: lvds: Hide scary error messages on probe deferral
Date: Tue,  4 Mar 2025 13:44:17 +0100
Message-ID: <20250304124418.111061-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304124418.111061-1-heiko@sntech.de>
References: <20250304124418.111061-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Commit 52d11c863ac9 ("drm/rockchip: lvds: do not print scary message when
probing defer") already started hiding scary messages that are not relevant
if the requested supply just returned EPROBE_DEFER, but there are more
possible sources - like the phy.

So modernize the whole logging in the probe path by replacing the
remaining deprecated DRM_DEV_ERROR with appropriate dev_err(_probe)
and drm_err calls.

The distinction here is that all messages talking about mishaps of the
lvds element use dev_err(_probe) while messages caused by interaction
with the main Rockchip drm-device use drm_err.

Reviewed-by: Andy Yan <andy.yan@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 63 ++++++++++--------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index ecfae8d5da89..bfebe42a0331 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -453,10 +453,9 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 		return PTR_ERR(lvds->regs);
 
 	lvds->pclk = devm_clk_get_prepared(lvds->dev, "pclk_lvds");
-	if (IS_ERR(lvds->pclk)) {
-		DRM_DEV_ERROR(lvds->dev, "could not get or prepare pclk_lvds\n");
-		return PTR_ERR(lvds->pclk);
-	}
+	if (IS_ERR(lvds->pclk))
+		return dev_err_probe(lvds->dev, PTR_ERR(lvds->pclk),
+				     "could not get or prepare pclk_lvds\n");
 
 	lvds->pins = devm_kzalloc(lvds->dev, sizeof(*lvds->pins),
 				  GFP_KERNEL);
@@ -465,14 +464,14 @@ static int rk3288_lvds_probe(struct platform_device *pdev,
 
 	lvds->pins->p = devm_pinctrl_get(lvds->dev);
 	if (IS_ERR(lvds->pins->p)) {
-		DRM_DEV_ERROR(lvds->dev, "no pinctrl handle\n");
+		dev_err(lvds->dev, "no pinctrl handle\n");
 		devm_kfree(lvds->dev, lvds->pins);
 		lvds->pins = NULL;
 	} else {
 		lvds->pins->default_state =
 			pinctrl_lookup_state(lvds->pins->p, "lcdc");
 		if (IS_ERR(lvds->pins->default_state)) {
-			DRM_DEV_ERROR(lvds->dev, "no default pinctrl state\n");
+			dev_err(lvds->dev, "no default pinctrl state\n");
 			devm_kfree(lvds->dev, lvds->pins);
 			lvds->pins = NULL;
 		}
@@ -547,11 +546,10 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	lvds->drm_dev = drm_dev;
 	port = of_graph_get_port_by_id(dev->of_node, 1);
-	if (!port) {
-		DRM_DEV_ERROR(dev,
-			      "can't found port point, please init lvds panel port!\n");
-		return -EINVAL;
-	}
+	if (!port)
+		return dev_err_probe(dev, -EINVAL,
+				     "can't found port point, please init lvds panel port!\n");
+
 	for_each_child_of_node(port, endpoint) {
 		child_count++;
 		of_property_read_u32(endpoint, "reg", &endpoint_id);
@@ -563,8 +561,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		}
 	}
 	if (!child_count) {
-		DRM_DEV_ERROR(dev, "lvds port does not have any children\n");
-		ret = -EINVAL;
+		ret = dev_err_probe(dev, -EINVAL, "lvds port does not have any children\n");
 		goto err_put_port;
 	} else if (ret) {
 		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
@@ -581,8 +578,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		lvds->output = rockchip_lvds_name_to_output(name);
 
 	if (lvds->output < 0) {
-		DRM_DEV_ERROR(dev, "invalid output type [%s]\n", name);
-		ret = lvds->output;
+		ret = dev_err_probe(dev, lvds->output, "invalid output type [%s]\n", name);
 		goto err_put_remote;
 	}
 
@@ -593,8 +589,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		lvds->format = rockchip_lvds_name_to_format(name);
 
 	if (lvds->format < 0) {
-		DRM_DEV_ERROR(dev, "invalid data-mapping format [%s]\n", name);
-		ret = lvds->format;
+		ret = dev_err_probe(dev, lvds->format,
+				    "invalid data-mapping format [%s]\n", name);
 		goto err_put_remote;
 	}
 
@@ -604,8 +600,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
 	if (ret < 0) {
-		DRM_DEV_ERROR(drm_dev->dev,
-			      "failed to initialize encoder: %d\n", ret);
+		drm_err(drm_dev,
+			"failed to initialize encoder: %d\n", ret);
 		goto err_put_remote;
 	}
 
@@ -618,8 +614,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 					 &rockchip_lvds_connector_funcs,
 					 DRM_MODE_CONNECTOR_LVDS);
 		if (ret < 0) {
-			DRM_DEV_ERROR(drm_dev->dev,
-				      "failed to initialize connector: %d\n", ret);
+			drm_err(drm_dev,
+				"failed to initialize connector: %d\n", ret);
 			goto err_free_encoder;
 		}
 
@@ -633,9 +629,9 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 		connector = drm_bridge_connector_init(lvds->drm_dev, encoder);
 		if (IS_ERR(connector)) {
-			DRM_DEV_ERROR(drm_dev->dev,
-				      "failed to initialize bridge connector: %pe\n",
-				      connector);
+			drm_err(drm_dev,
+				"failed to initialize bridge connector: %pe\n",
+				connector);
 			ret = PTR_ERR(connector);
 			goto err_free_encoder;
 		}
@@ -643,8 +639,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret < 0) {
-		DRM_DEV_ERROR(drm_dev->dev,
-			      "failed to attach encoder: %d\n", ret);
+		drm_err(drm_dev, "failed to attach encoder: %d\n", ret);
 		goto err_free_connector;
 	}
 
@@ -706,24 +701,20 @@ static int rockchip_lvds_probe(struct platform_device *pdev)
 
 	lvds->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
 						    "rockchip,grf");
-	if (IS_ERR(lvds->grf)) {
-		DRM_DEV_ERROR(dev, "missing rockchip,grf property\n");
-		return PTR_ERR(lvds->grf);
-	}
+	if (IS_ERR(lvds->grf))
+		return dev_err_probe(dev, PTR_ERR(lvds->grf), "missing rockchip,grf property\n");
 
 	ret = lvds->soc_data->probe(pdev, lvds);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "Platform initialization failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Platform initialization failed\n");
 
 	dev_set_drvdata(dev, lvds);
 
 	ret = component_add(&pdev->dev, &rockchip_lvds_component_ops);
 	if (ret < 0)
-		DRM_DEV_ERROR(dev, "failed to add component\n");
+		return dev_err_probe(dev, ret, "failed to add component\n");
 
-	return ret;
+	return 0;
 }
 
 static void rockchip_lvds_remove(struct platform_device *pdev)
-- 
2.47.2


