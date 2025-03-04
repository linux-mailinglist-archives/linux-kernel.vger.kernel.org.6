Return-Path: <linux-kernel+bounces-543073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9382A4D128
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B54171678
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647321DBB2E;
	Tue,  4 Mar 2025 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fm+JHYug"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A400E156C76
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052671; cv=none; b=L3HXiyqbi9DlLrW00+4v0ud27oX8y+yV5SL2hMxQnPqCquLS2kGwv86L1yQREPUSZXz/7QuK9KupxxPCELjtdJ1guLY/zOAcPbhRnRHnP4maZxP/UadcHWClzy4fzjNQZxU8hxuQsZBXXBJx+VE+0WzVJSVF3HnJjeGcx6Ol7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052671; c=relaxed/simple;
	bh=LKBWZilk673ctxQEeILgPIQ3LqxLckDuXu63lTUoX4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4wM0Ql/Lqxy2Rn1BzuN3x/dPjqF5Ooy+coonIdVbMhP1PA4ImwjhsSVQzwNsn7eaV8oSu3fSeyFbReWDXiDRD9jK/1XOjxZHMmN97OuADwqBTW7Avp09KVAIuYvAOSc7YCrgEr1R55FCgRo7zxHAaWXqdj2bNGaUd05kxdjkks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fm+JHYug; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052663;
	bh=LKBWZilk673ctxQEeILgPIQ3LqxLckDuXu63lTUoX4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fm+JHYugMrJH5URrrPFG+WukT55qsfr7vqZVRzZfiDL+hXHiptEdtw5dbwwcHvtHl
	 NRCCIVwl9e1gZ0yA0b5tmKPKU1ZSilon4jD3zhEhjKibTvmq0Tbz3MV9h3aJRoCbBR
	 BejUtWufVcI2INnURcl+Mxs4vA9sCfWBT3PMP9ZMZSuVjHeNN1kAeXWrdX7O/2MY0g
	 5cZIZyH7ryFuHhxM+NVY7NjeSECueg8K+mfDnnrr0Q+0Ak8OGA0rA8Jj6yPGgoQsvi
	 WWPIMfcOF3+ikHlWXMUcXzyubbGBuuWueVRRWF83KJdIVL894GB+I5Z3g1B/MUWuzO
	 uDAGKnUO8sDjw==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 69A7C17E1022;
	Tue,  4 Mar 2025 02:44:23 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:06 +0200
Subject: [PATCH v4 07/12] phy: rockchip: samsung-hdptx: Setup TMDS char
 rate via phy_configure_opts_hdmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-7-8657847c13f7@collabora.com>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The current workaround to setup the TMDS character rate relies on the
unconventional usage of phy_set_bus_width().

Make use of the recently introduced HDMI PHY configuration API to
properly handle the setup.  The workaround will be dropped as soon as
the switch has been completed on both ends.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 54 ++++++++++++++++-------
 1 file changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 2bf525514c1991a1299265d12e1e85f66333c604..7e1d1c10758249aa5bbddbdaae0108bba04f30df 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -394,6 +394,7 @@ struct rk_hdptx_phy {
 
 	int phy_id;
 	struct phy *phy;
+	struct phy_configure_opts_hdmi hdmi_cfg;
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
@@ -1409,19 +1410,25 @@ static int rk_hdptx_dp_aux_init(struct rk_hdptx_phy *hdptx)
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	int bus_width = phy_get_bus_width(hdptx->phy);
 	enum phy_mode mode = phy_get_mode(phy);
+	unsigned int rate = 0;
 	int ret, lane;
 
-	/*
-	 * FIXME: Temporary workaround to pass pixel_clk_rate
-	 * from the HDMI bridge driver until phy_configure_opts_hdmi
-	 * becomes available in the PHY API.
-	 */
-	unsigned int rate = bus_width & 0xfffffff;
-
-	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
-		__func__, bus_width, rate);
+	if (mode != PHY_MODE_DP) {
+		if (!hdptx->hdmi_cfg.tmds_char_rate) {
+			/*
+			 * FIXME: Temporary workaround to setup TMDS char rate
+			 * from the RK DW HDMI QP bridge driver.
+			 * Will be removed as soon the switch to the HDMI PHY
+			 * configuration API has been completed on both ends.
+			 */
+			rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+			hdptx->hdmi_cfg.tmds_char_rate = rate * 100;
+		} else {
+			rate = hdptx->hdmi_cfg.tmds_char_rate / 100;
+		}
+		dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
+	}
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -1469,8 +1476,17 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 	return rk_hdptx_phy_consumer_put(hdptx, false);
 }
 
-static int rk_hdptx_phy_verify_config(struct rk_hdptx_phy *hdptx,
-				      struct phy_configure_opts_dp *dp)
+static int rk_hdptx_phy_verify_hdmi_config(struct rk_hdptx_phy *hdptx,
+					   struct phy_configure_opts_hdmi *hdmi)
+{
+	if (!hdmi->tmds_char_rate || hdmi->tmds_char_rate > HDMI20_MAX_RATE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int rk_hdptx_phy_verify_dp_config(struct rk_hdptx_phy *hdptx,
+					 struct phy_configure_opts_dp *dp)
 {
 	int i;
 
@@ -1730,12 +1746,18 @@ static int rk_hdptx_phy_configure(struct phy *phy, union phy_configure_opts *opt
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


