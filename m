Return-Path: <linux-kernel+bounces-566167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A93A67409
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3309D1781A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586F520E702;
	Tue, 18 Mar 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UJ8d5T1U"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28220DD75
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301434; cv=none; b=m1gRgsPx/hUcY6J5cn4JCib9nHQNKRPPlOE9AWiXZxCuGH6Sx3og33rEIAVx0/RCuYZvOC0iA7zoqabtI0DQi2aAZjur3+Z2pdstyf4WilNhSpZrA4wC2qE0gGnECn2tC961KVJiW51pNf+1iC09i08nGR0lGCPw5Tyx4KTIQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301434; c=relaxed/simple;
	bh=rKHlZ3Q5SBhBTVFtf1UDit2e4W4lBQxRIW9tsumG98M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pJYiiQr5dLa2TnMcVAdujJ7YuNvj/dXqFAVor39k1/0vnbkRaHP2P2RKYe0nkv9ytxQnwRLEO/fY0C+P5IF2fbWabGtgOZeTwYfX9VzGspSYoeNpk604+cL8YZWDeTyT7QHflMnFbaj8tk4PffvLpO3DnQG5s7RJ1o7SJmXhen0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UJ8d5T1U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301427;
	bh=rKHlZ3Q5SBhBTVFtf1UDit2e4W4lBQxRIW9tsumG98M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UJ8d5T1UJ2HoTg1OB14s4o19oKwNq9H4dcFPsKkwQ1z1KLr0YmfvOMfqk12N+8Vay
	 +AkjZ8uDU6/uEFMekbv4uhSG89kpE69HK3fK9zkYjZNsbITFJlQY5vl/XO2mufNCs2
	 OpFUAH4Rt9F5bKNuaNLe5cQa3HcFkUB2Hbn+39efDQg3BHdM49lGXS/CYHTFoNBrcF
	 eotj8XKGmtUHYj9TqZyswH0v9VnCITMOhkA6H0rCcWLO82dsv/zMBKdAWQTCJtHxn2
	 DPtGxBOiZbggL6gLpKIfGR+UCWXBa+ZbPH35SnSQX+EhDZedt4W1xDmaEzVc+2rX4N
	 eohjI/XQLeQPQ==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 7AF1B17E152F;
	Tue, 18 Mar 2025 13:37:07 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:43 +0200
Subject: [PATCH v6 09/14] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-9-8cb1678e7663@collabora.com>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

The current workaround to setup the TMDS character rate relies on the
unconventional usage of phy_set_bus_width().

Make use of the recently introduced HDMI PHY configuration API to
properly handle the setup.  The workaround will be dropped as soon as
the switch has been completed on both ends.

Rename rk_hdptx_phy_verify_config() to rk_hdptx_phy_verify_dp_config()
and introduce the rk_hdptx_phy_verify_hdmi_config() helper to check the
HDMI parameters during phy_configure().

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 64 +++++++++++++++++------
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index e4f6b1d6d999ae01eb7a9a35ea1748b8a2da339c..62de40515338730a56a83972ad57a7e71c3ca5cb 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -394,6 +394,7 @@ struct rk_hdptx_phy {
 
 	int phy_id;
 	struct phy *phy;
+	struct phy_configure_opts_hdmi hdmi_cfg;
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
@@ -1412,20 +1413,24 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
 	enum phy_mode mode = phy_get_mode(phy);
-	unsigned long long rate;
 	int ret, lane;
 
-	/*
-	 * FIXME: Temporary workaround to pass pixel_clk_rate
-	 * from the HDMI bridge driver until phy_configure_opts_hdmi
-	 * becomes available in the PHY API.
-	 */
-	rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
-	rate *= 100;
+	if (mode != PHY_MODE_DP) {
+		if (!hdptx->hdmi_cfg.tmds_char_rate) {
+			/*
+			 * FIXME: Temporary workaround to setup TMDS char rate
+			 * from the RK DW HDMI QP bridge driver.
+			 * Will be removed as soon the switch to the HDMI PHY
+			 * configuration API has been completed on both ends.
+			 */
+			hdptx->hdmi_cfg.tmds_char_rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+			hdptx->hdmi_cfg.tmds_char_rate *= 100;
+		}
 
-	dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, rate);
+		dev_dbg(hdptx->dev, "%s rate=%llu\n", __func__, hdptx->hdmi_cfg.tmds_char_rate);
+	}
 
-	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
+	ret = rk_hdptx_phy_consumer_get(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
 	if (ret)
 		return ret;
 
@@ -1456,7 +1461,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 		regmap_write(hdptx->grf, GRF_HDPTX_CON0,
 			     HDPTX_MODE_SEL << 16 | FIELD_PREP(HDPTX_MODE_SEL, 0x0));
 
-		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
+		ret = rk_hdptx_ropll_tmds_mode_config(hdptx, hdptx->hdmi_cfg.tmds_char_rate);
 		if (ret)
 			rk_hdptx_phy_consumer_put(hdptx, true);
 	}
@@ -1471,8 +1476,27 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 	return rk_hdptx_phy_consumer_put(hdptx, false);
 }
 
-static int rk_hdptx_phy_verify_config(struct rk_hdptx_phy *hdptx,
-				      struct phy_configure_opts_dp *dp)
+static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
+					   struct phy_configure_opts_hdmi *hdmi)
+{
+	int i;
+
+	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(ropll_tmds_cfg); i++)
+		if (hdmi->tmds_char_rate == ropll_tmds_cfg[i].rate)
+			break;
+
+	if (i == ARRAY_SIZE(ropll_tmds_cfg) &&
+	    !rk_hdptx_phy_clk_pll_calc(hdmi->tmds_char_rate, NULL))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rk_hdptx_phy_verify_dp_config(struct rk_hdptx_phy *hdptx,
+					 struct phy_configure_opts_dp *dp)
 {
 	int i;
 
@@ -1732,12 +1756,18 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
 	enum phy_mode mode = phy_get_mode(phy);
 	int ret;
 
-	if (mode != PHY_MODE_DP)
-		return 0;
+	if (mode != PHY_MODE_DP) {
+		ret = rk_hdptx_phy_verify_hdmi_config(hdptx, &opts->hdmi);
+		if (ret)
+			dev_err(hdptx->dev, "invalid hdmi params for phy configure\n");
+		else
+			hdptx->hdmi_cfg = opts->hdmi;
+		return ret;
+	}
 
-	ret = rk_hdptx_phy_verify_config(hdptx, &opts->dp);
+	ret = rk_hdptx_phy_verify_dp_config(hdptx, &opts->dp);
 	if (ret) {
-		dev_err(hdptx->dev, "invalid params for phy configure\n");
+		dev_err(hdptx->dev, "invalid dp params for phy configure\n");
 		return ret;
 	}
 

-- 
2.48.1


