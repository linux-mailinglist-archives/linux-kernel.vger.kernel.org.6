Return-Path: <linux-kernel+bounces-435720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E41269E7B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF29188798F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580D9213E77;
	Fri,  6 Dec 2024 22:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mdyMa7vK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B2206281
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522642; cv=none; b=Wm08J0MOHY62a2N+hXU10iqFkH2X0QFTo502jKl1SKYLAJB+2hZq1V7xkbKaTn4Shk5ksnXxwyVzTsCRei2W35vfMrTC7cceAji/S14PCLJvrGC0+RTnqmQ79xujtc52roCYfpgEAG+xH02jmkVKLrhClVOwjq+7KlfSBVJ9ig0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522642; c=relaxed/simple;
	bh=BtZlCg7zrnpqKFSnMbzeaKu5nXKTQv2xjkndYTOjR+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCZRfImsgbES0AzMTsBZwheZLUD2rMHHhhIKyrFnOTVHf8qjmQPXTr7PFHbH4TclR5tpstqjC83lvVE73t9uHuQx4XeRAdOiarHgb8rrP1XK1gzNzMEROQYnkM/hvYjbQHRPO3zqeT32C27rcXras6hEaOeEO8NhxIwSTvJdFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mdyMa7vK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733522639;
	bh=BtZlCg7zrnpqKFSnMbzeaKu5nXKTQv2xjkndYTOjR+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mdyMa7vKYn4H1ynchfOGmmeWUN0Qiylma9FHLI1kmvthIqklX9UqmkctFQYWvXkwg
	 bgj9MYg9s+TBvmpedEL9FUXLZny7p1hOkdytDkOy0gbnkb02cPtX78nFO/DF8B0Vkf
	 PdkzNFQaVrgnOAv7B7CC9/U+kHbuHutVs+8gxrJOsCMbVzAZlQkr98/x4OdtlcXpPP
	 OfpD6CG7UboyXk/0WEQ7/3Dt3Wj2jpcPUsyX37SL0xrk0N4y27SMyj6cN2KyEKVUhJ
	 zEfnAW36dpbb2ihKd3+mMkHTruTumi4CXC79ycBDV4GrrXyG8QJosvAtXcriN3jCQ1
	 Q8V3g9bB95aZw==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA7B817E380B;
	Fri,  6 Dec 2024 23:03:58 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 07 Dec 2024 00:03:43 +0200
Subject: [PATCH 3/4] phy: rockchip: samsung-hdptx: Setup TMDS char rate via
 phy_configure_opts_hdmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-phy-sam-hdptx-bpc-v1-3-03c2e4d6d797@collabora.com>
References: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
In-Reply-To: <20241207-phy-sam-hdptx-bpc-v1-0-03c2e4d6d797@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The current workaround to setup the TMDS character rate relies on the
unconventional usage of phy_set_bus_width().

Make use of the recently introduced HDMI PHY configuration API for this
purpose.  The workaround will be dropped as soon as the switch has been
completed on both ends.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 42 ++++++++++++++++++-----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index ceab9c71d3b53ae0b746a10c081fcfaa7d5c5ae7..eeadebdc476caa87aebbbd82f7102b62b22a0ea6 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -273,6 +273,7 @@ struct rk_hdptx_phy {
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];
+	unsigned long tmds_char_rate;
 
 	/* clk provider */
 	struct clk_hw hw;
@@ -902,18 +903,20 @@ static int rk_hdptx_phy_consumer_put(struct rk_hdptx_phy *hdptx, bool force)
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	int bus_width = phy_get_bus_width(hdptx->phy);
+	unsigned int rate = hdptx->tmds_char_rate / 100;
 	int ret;
 
-	/*
-	 * FIXME: Temporary workaround to pass pixel_clk_rate
-	 * from the HDMI bridge driver until phy_configure_opts_hdmi
-	 * becomes available in the PHY API.
-	 */
-	unsigned int rate = bus_width & 0xfffffff;
+	if (rate == 0) {
+		/*
+		 * FIXME: Temporary workaround to setup TMDS char rate
+		 * from the RK HDMI bridge driver.
+		 * Will be removed as soon the switch to the HDMI PHY
+		 * configuration API has been completed on both ends.
+		 */
+		rate = phy_get_bus_width(hdptx->phy) & 0xfffffff;
+	}
 
-	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
-		__func__, bus_width, rate);
+	dev_dbg(hdptx->dev, "%s rate=%u\n", __func__, rate);
 
 	ret = rk_hdptx_phy_consumer_get(hdptx, rate);
 	if (ret)
@@ -933,9 +936,20 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 	return rk_hdptx_phy_consumer_put(hdptx, false);
 }
 
+static int rk_hdptx_phy_configure(struct phy *phy,
+				  union phy_configure_opts *opts)
+{
+	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
+
+	hdptx->tmds_char_rate = opts->hdmi.tmds_char_rate;
+
+	return 0;
+}
+
 static const struct phy_ops rk_hdptx_phy_ops = {
 	.power_on  = rk_hdptx_phy_power_on,
 	.power_off = rk_hdptx_phy_power_off,
+	.configure = rk_hdptx_phy_configure,
 	.owner	   = THIS_MODULE,
 };
 
@@ -991,6 +1005,16 @@ static int rk_hdptx_phy_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
+	/*
+	 * The TMDS char rate set via phy_configure(), if any, has
+	 * precedence over the rate provided via clk_set_rate().
+	 */
+	if (hdptx->tmds_char_rate && hdptx->tmds_char_rate != rate) {
+		dev_dbg(hdptx->dev, "Replaced clk_set_rate=%lu with tmds_char_rate=%lu\n",
+			rate, hdptx->tmds_char_rate);
+		rate = hdptx->tmds_char_rate;
+	}
+
 	return rk_hdptx_ropll_tmds_cmn_config(hdptx, rate / 100);
 }
 

-- 
2.47.0


