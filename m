Return-Path: <linux-kernel+bounces-554014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFB0A591D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20A73A2BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCC422A4C5;
	Mon, 10 Mar 2025 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SNZrux65"
Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com [220.197.31.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510A227E88
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603760; cv=none; b=qyJC8lzYeF5KMWsh0J/VDgmVpHIhjWEXm3CN3JTDA5sMX/+fqAE3tR4VEOzSz1TTPEpUzLp7XJfT/kt3/eylpHLqKL6HIH816aczVF+Dxpg/6LtlF1oRAY+TeC7g1x3xHjNpQKe7ueC3d0BU2/FlNepiii/r6tH/wws4UXvoRlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603760; c=relaxed/simple;
	bh=R2HqBJbNLoGnDO/WdzUTS+J2NQU1gsqalx+ojF6QZu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s2IRlyDdn48BM8o+RyGVGAlLrLhmDvQu0V2m0JdE7NpPZ8UZi18mCcjdF8KD9IyMJWF5Zr2yq82ottRjv6QPqd/WVi5flRVrpAd5hdLjdVsYzuWrSxLGNuCbUjsIJjRno0cdpRjO5XnRNjpuU8DbASNcLa26ywHi41yVrFpi5vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SNZrux65; arc=none smtp.client-ip=220.197.31.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id dc18828a;
	Mon, 10 Mar 2025 18:42:17 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: heiko@sntech.de
Cc: andy.yan@rock-chips.com,
	hjc@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	dmitry.baryshkov@linaro.org,
	dianders@chromium.org,
	sebastian.reichel@collabora.com,
	cristian.ciocaltea@collabora.com,
	boris.brezillon@collabora.com,
	l.stach@pengutronix.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v8 08/13] drm/rockchip: analogix_dp: Add support to get panel from the DP AUX bus
Date: Mon, 10 Mar 2025 18:41:09 +0800
Message-Id: <20250310104114.2608063-9-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310104114.2608063-1-damon.ding@rock-chips.com>
References: <20250310104114.2608063-1-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkxITlZCSE9OSRpJSEkaTkpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCS0
	NVSktLVUpCWQY+
X-HM-Tid: 0a957fa5f58803a3kunmdc18828a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6CRw5CjJOIiM0Izk2PS8*
	Th1PFAxVSlVKTE9KTUtISEhCTUhIVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSUJMNwY+
DKIM-Signature:a=rsa-sha256;
	b=SNZrux65+2z148itasgWITDP2C9eY8vwJWr1tfFV3Uwq5Mu2RoVjBD/Aq+DwQDmf+XCeT5y/Twn9iVU4TJc5Ze77RUVWt8pw23xnzjBpGm7cPlaD4xPWp34MFHs9VFmq3Z4hIgBnuyd2goMISudWcRh7MJWwaKnTajQV1xTy7YE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=BjjaUkr/z4Q0qZiPadymcyXjqL+DalxJAT81z/wxaYs=;
	h=date:mime-version:subject:message-id:from;

Move drm_of_find_panel_or_bridge() a little later and combine it with
component_add() into a new function rockchip_dp_link_panel(). The function
will serve as done_probing() callback of devm_of_dp_aux_populate_bus(),
aiding to support for obtaining the eDP panel via the DP AUX bus.

If failed to get the panel from the DP AUX bus, it will then try the other
way to get panel information through the platform bus.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Damon Ding <damon.ding@rock-chips.com>

---

Changes in v4:
- Use done_probing() to call drm_of_find_panel_or_bridge() and
  component_add() when getting panel from the DP AUX bus

Changes in v5:
- Use the functions exported by the Analogix side to get the pointers of
  struct analogix_dp_plat_data and struct drm_dp_aux.
- Use dev_err() instead of drm_err() in rockchip_dp_poweron().

Changes in v6:
- Keep drm_err() in rockchip_dp_poweron()
- Pass 'dp' in drm_...() rather than 'dp->drm_dev'

Changes in v7:
- Include the drm_dp_aux_bus.h for devm_of_dp_aux_populate_bus()
- Use dev_err_probe() for the return value check of
  devm_of_dp_aux_populate_bus()
- Select DRM_DISPLAY_DP_AUX_BUS if ROCKCHIP_ANALOGIX_DP
- Restore the error check for drm_of_find_panel_or_bridge() which was
  removed by mistake

Changes in v8:
- Add comments when drm_of_find_panel_or_bridge() returns -ENODEV
- Remove some redundant return cases
- Add comments when devm_of_dp_aux_populate_bus() returns -ENODEV
---
 drivers/gpu/drm/rockchip/Kconfig              |  1 +
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 42 +++++++++++++++----
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
index 26c4410b2407..f9d7776a859a 100644
--- a/drivers/gpu/drm/rockchip/Kconfig
+++ b/drivers/gpu/drm/rockchip/Kconfig
@@ -8,6 +8,7 @@ config DRM_ROCKCHIP
 	select DRM_PANEL
 	select VIDEOMODE_HELPERS
 	select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
+	select DRM_DISPLAY_DP_AUX_BUS if ROCKCHIP_ANALOGIX_DP
 	select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
 	select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
 	select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index a8265a1bf9ff..5632b7e3e122 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -21,6 +21,7 @@
 #include <video/of_videomode.h>
 #include <video/videomode.h>
 
+#include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -392,11 +393,28 @@ static const struct component_ops rockchip_dp_component_ops = {
 	.unbind = rockchip_dp_unbind,
 };
 
+static int rockchip_dp_link_panel(struct drm_dp_aux *aux)
+{
+	struct analogix_dp_plat_data *plat_data = analogix_dp_aux_to_plat_data(aux);
+	struct rockchip_dp_device *dp = pdata_encoder_to_dp(plat_data);
+	int ret;
+
+	/*
+	 * If drm_of_find_panel_or_bridge() returns -ENODEV, there may be no valid panel
+	 * or bridge nodes. The driver should go on for the driver-free bridge or the DP
+	 * mode applications.
+	 */
+	ret = drm_of_find_panel_or_bridge(dp->dev->of_node, 1, 0, &plat_data->panel, NULL);
+	if (ret && ret != -ENODEV)
+		return ret;
+
+	return component_add(dp->dev, &rockchip_dp_component_ops);
+}
+
 static int rockchip_dp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct rockchip_dp_chip_data *dp_data;
-	struct drm_panel *panel = NULL;
 	struct rockchip_dp_device *dp;
 	struct resource *res;
 	int i;
@@ -406,10 +424,6 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 	if (!dp_data)
 		return -ENODEV;
 
-	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
-	if (ret < 0 && ret != -ENODEV)
-		return ret;
-
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
 	if (!dp)
 		return -ENOMEM;
@@ -432,7 +446,6 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 
 	dp->dev = dev;
 	dp->adp = ERR_PTR(-ENODEV);
-	dp->plat_data.panel = panel;
 	dp->plat_data.dev_type = dp->data->chip_type;
 	dp->plat_data.power_on = rockchip_dp_poweron;
 	dp->plat_data.power_off = rockchip_dp_powerdown;
@@ -448,9 +461,20 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 	if (IS_ERR(dp->adp))
 		return PTR_ERR(dp->adp);
 
-	ret = component_add(dev, &rockchip_dp_component_ops);
-	if (ret)
-		return ret;
+	ret = devm_of_dp_aux_populate_bus(analogix_dp_get_aux(dp->adp), rockchip_dp_link_panel);
+	if (ret) {
+		/*
+		 * If devm_of_dp_aux_populate_bus() returns -ENODEV, the done_probing() will not
+		 * be called because there are no EP devices. Then the rockchip_dp_link_panel()
+		 * will be called directly in order to support the other valid DT configurations.
+		 *
+		 * NOTE: The devm_of_dp_aux_populate_bus() is allowed to return -EPROBE_DEFER.
+		 */
+		if (ret != -ENODEV)
+			return dev_err_probe(dp->dev, ret, "failed to populate aux bus\n");
+
+		return rockchip_dp_link_panel(analogix_dp_get_aux(dp->adp));
+	}
 
 	return 0;
 }
-- 
2.34.1


