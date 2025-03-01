Return-Path: <linux-kernel+bounces-540063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D6A4AD23
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA73C3B878B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E559F1E7C25;
	Sat,  1 Mar 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Q84TEPT3"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CFD1E5B75
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740850591; cv=none; b=p4cKMmCH06YPJMCM9itNTqObetMoVy9Xkou5VZMMb7+5N4HAd1lBypJxXaJEt3kNs4WiJM9RdITKYPfcTpvlkckxzHYF3ZqsKO4KdxWAJCjOuiMv1ntSIvAjV6hbLffzlfPWEr8cl+M9iGMrg2OzbbKEF/TLX7cFOet2BYzu53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740850591; c=relaxed/simple;
	bh=3cSeg5GwvnCo+tre/YDJWXX0o42C0vQkWcKow0a5Nfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1DdXQsFck8a8jpJvccmACAfiqDOXXW3Ex/xeZ5iDWpWWxU8bBo+/JBuBMZ6p5u/LA9/RAEX23fxaQcQLyBQ/ndR9XNTfz9QBsQVIu3J9o/Mwv7tlr1hCf6xE57RG6k3/0252Z2F32q9a0Od0HOX9SkVXY82QM6R/fEgcfnuobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Q84TEPT3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bqrftD8D/m+VwtB6WWXkN3nmmoijpnDNS2a+SxSawOE=; b=Q84TEPT3RY1a94rODGKy4I7/6n
	PaTb7Gps1jGksrOAo6BX7GVFVYAXxJnubNBE3pCAjaQNkMHxlQUV5M/Y5ZY9tdSxa9aFZHOq5QngB
	frgnj28N7/HPMYrNM1xVznRncR7+eqtfVnO5MF/JYpqcSswE8Emseal5/5vHBvArhgkn8W5gSl462
	EKty6xleSqI5ka2S+OtEsdV+igKi+u57v8m6+KKF2A0XOfGJVJjmxXj9V40tRnYWkwNgNQqO78cPI
	+RVkEDJ3cCzjptIX6ExspG9LgewNdQKC465C+JWY9w/38t81x008HX3IFkIGqKRMxbMPgIGJRbjaj
	1RVzaImg==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1toQko-0001Tm-83; Sat, 01 Mar 2025 18:35:58 +0100
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
Subject: [PATCH v2 2/2] drm/rockchip: lvds: Hide scary error messages on probe deferral
Date: Sat,  1 Mar 2025 18:35:47 +0100
Message-ID: <20250301173547.710245-3-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301173547.710245-1-heiko@sntech.de>
References: <20250301173547.710245-1-heiko@sntech.de>
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

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 61 ++++++++++--------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index ecfae8d5da89..d8b2007123fa 100644
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
 
@@ -593,7 +589,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		lvds->format = rockchip_lvds_name_to_format(name);
 
 	if (lvds->format < 0) {
-		DRM_DEV_ERROR(dev, "invalid data-mapping format [%s]\n", name);
+		dev_err(dev, "invalid data-mapping format [%s]\n", name);
 		ret = lvds->format;
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


