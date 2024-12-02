Return-Path: <linux-kernel+bounces-428330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E23029E0D02
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55E1281E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665871DED69;
	Mon,  2 Dec 2024 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PkhjGQyJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24291DE4E6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733171303; cv=none; b=NzSkjo0ruieQ0LPS11urO/BSUapv19Y+OONfyZLCH+BWjtwCZSlfOevQoPG0nvYAE/iAtI23PK3VmtJlf2iAj/GJ2sTLMo41FhyawL/b60UtVg03qoEUCUIPTitUtDqzW9KhaYFIuWh7z6uux6gy0KvFwUeV5c+N040SBNO9iqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733171303; c=relaxed/simple;
	bh=rBKYTLNDOW58j3hrrUdo0WdSxf4pv9UIQrcg23u2TeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L7fvxylcYC97iCrocDVN4+fjkFmhVOAyYcp0s2q95E4VA4cV/78gbkoKXiPGbGi4H8tukgj/mvzW19jnoNeJKXYdEoH4wxAsuMTsOYUcNup10lQj0eV3rYRUFzVI8KZQ5OZrnqHzLm33UwZapGSfdwecqAOUcV193fvmJ9r8hDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PkhjGQyJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733171298;
	bh=rBKYTLNDOW58j3hrrUdo0WdSxf4pv9UIQrcg23u2TeI=;
	h=From:Date:Subject:To:Cc:From;
	b=PkhjGQyJ4/Fevt7ZCrl+pKRnMo03LMwldD/4TjcRFA64a1e+Yanmovbl+JYFnmBEB
	 Kcy403oV5TKa8+BiYZk4GjmpZK+9znodpZku2DRXsy7PCG2GDIhvo1ZOw5R5N8w+oj
	 nzkes2CoQicHSXlYjx7IY+O7WLgaJkLTQzLqXoT66xwhiy7B5rIwMZhKo+0+aaeyW0
	 mLf1wG+dg4PwxWhMCJv3iLBPE8cl2kh3qL+ooG7jwX28NPsHqUCrqJT5L2HLSqHauV
	 VKPBCRpeK7r95320h6FmGV0BT3zgvn/a1xNDHNFPFjfVvpm5IemPeSH1JegTYLUxY/
	 ywJbbG9T/GmEg==
Received: from localhost (unknown [86.120.21.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A3D4D17E37E4;
	Mon,  2 Dec 2024 21:28:18 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 02 Dec 2024 22:27:34 +0200
Subject: [PATCH] drm/rockchip: dw_hdmi_qp: Simplify clock handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dw-hdmi-qp-rk-clk-bulk-v1-1-60a7cc9cd74e@collabora.com>
X-B4-Tracking: v=1; b=H4sIADUYTmcC/x2MSQqAMAwAvyI5G2irgvgV8aBttMG9xQXEvxu8D
 Mxh5oFIgSlClTwQ6OTI6yKi0wSsb5eBkJ04GGVyLUB3oXcz475hGNFOI3aHIHN9q3RhqNQ5SLw
 F6vn+x3Xzvh9C6epiaAAAAA==
X-Change-ID: 20241202-dw-hdmi-qp-rk-clk-bulk-3dfa0152e814
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Make use of the recently introduced devm_clk_bulk_get_all_enabled()
helper to simplify the code a bit.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index c8b362cc2b95fd490029a9c0552ad9fbc5631d17..20ecc0729db9f5e321041ae7b3349bff5246a926 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -214,17 +214,13 @@ MODULE_DEVICE_TABLE(of, dw_hdmi_qp_rockchip_dt_ids);
 static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 				    void *data)
 {
-	static const char * const clk_names[] = {
-		"pclk", "earc", "aud", "hdp", "hclk_vo1",
-		"ref" /* keep "ref" last */
-	};
 	struct platform_device *pdev = to_platform_device(dev);
 	struct dw_hdmi_qp_plat_data plat_data;
 	struct drm_device *drm = data;
 	struct drm_connector *connector;
 	struct drm_encoder *encoder;
 	struct rockchip_hdmi_qp *hdmi;
-	struct clk *clk;
+	struct clk_bulk_data *clks;
 	int ret, irq, i;
 	u32 val;
 
@@ -270,18 +266,22 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return PTR_ERR(hdmi->vo_regmap);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(clk_names); i++) {
-		clk = devm_clk_get_enabled(hdmi->dev, clk_names[i]);
+	ret = devm_clk_bulk_get_all_enabled(hdmi->dev, &clks);
+	if (ret < 0) {
+		drm_err(hdmi, "Failed to get clocks: %d\n", ret);
+		return ret;
+	}
 
-		if (IS_ERR(clk)) {
-			ret = PTR_ERR(clk);
-			if (ret != -EPROBE_DEFER)
-				drm_err(hdmi, "Failed to get %s clock: %d\n",
-					clk_names[i], ret);
-			return ret;
+	for (i = 0; i < ret; i++) {
+		if (!strcmp(clks[i].id, "ref")) {
+			hdmi->ref_clk = clks[1].clk;
+			break;
 		}
 	}
-	hdmi->ref_clk = clk;
+	if (!hdmi->ref_clk) {
+		drm_err(hdmi, "Missing ref clock\n");
+		return -EINVAL;
+	}
 
 	hdmi->enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
 						    GPIOD_OUT_HIGH);

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-dw-hdmi-qp-rk-clk-bulk-3dfa0152e814


