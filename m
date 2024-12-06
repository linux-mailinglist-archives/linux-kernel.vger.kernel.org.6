Return-Path: <linux-kernel+bounces-434892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 158339E6C62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421BC1673B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D43E1FC7D8;
	Fri,  6 Dec 2024 10:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="mzzy5mD5"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2893B1F943B
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481282; cv=none; b=PL/4x1FgUNql2nygxXpRPTEBkNehLw8g6pIUUkTLISrBu5zhJ7MwFI6QU7k3Clb4ot5Xxg2AcJN31oKkC8efwVTCJjygZzV9FQdMMYUfTt27ZplEKdKm5ogcMapYhyefAyIy8SZBwxVvwvA02f086X10s7/f+dBK6UVsJntHeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481282; c=relaxed/simple;
	bh=LSXmZqQoa6PS2I6aKr58W1CdIfYIBWRHOO34Oms5WAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1TQdjUF8jeIc/WszlFhNfA3KA04aMNJ8uLM1IMybh0baJgaP3OpEbdkzmYsBZDaMLpQ8G/Tgg1AjZtK+3W73MDwMWCaldXMkn4iQlZtXhfLOMaFlkO9caEJb4pcSoUTflUISVVkANksBywWt8ekOH0qJPWlJttNN6TWQr8wcws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=mzzy5mD5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1UN1KsYoShLP+jnqNIAIPC6ZRY2mrO3AN1No45ThK+A=; b=mzzy5mD5NWF6ZSh19e3QQ5MydT
	S5w2G+L96caWc7NlxMc1pxfCni2jc1+nhvTDAOp0652BZqOQOn7zpvMrBMZNef69oIJ8S2EjbrAkz
	pSB5htNJrn9KGuTcM/t9QQyr/2NbBPKZF0MBsTvKVTmfeohLMeGyP2UpgSW9IIyGX4gefdeKl0mjz
	5jWZQ1+1tuZwfuZ23ntF+1ZJkS4G9UMXzL8HxOyFXux6580OnWhyI03SRtOPJNdkQT6LznCuP0YxA
	JREvhPDW2uI5gKotYB4zCR2T1paeX8zLjB/un6zWB9f7sh0rXMxuHQtBI+J+ZGF+0WIchelknuohz
	Vd9/2/ow==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tJVfI-0007XU-FB; Fri, 06 Dec 2024 11:34:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: vkoul@kernel.org,
	kishon@kernel.org
Cc: heiko@sntech.de,
	cristian.ciocaltea@collabora.com,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 2/2] phy: phy-rockchip-samsung-hdptx: Don't use dt aliases to determine phy-id
Date: Fri,  6 Dec 2024 11:34:01 +0100
Message-ID: <20241206103401.1780416-3-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206103401.1780416-1-heiko@sntech.de>
References: <20241206103401.1780416-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The phy needs to know its identity in the system (phy0 or phy1 on rk3588)
for some actions and the driver currently contains code abusing of_alias
for that.

Devicetree aliases are always optional and should not be used for core
device functionality, so instead keep a list of phys on a soc in the
of_device_data and find the phy-id by comparing against the mapped
register-base.

Fixes: c4b09c562086 ("phy: phy-rockchip-samsung-hdptx: Add clock provider support")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 50 ++++++++++++++++---
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index c5c64c209e96..b137f8c4d157 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -385,11 +385,22 @@ enum rk_hdptx_reset {
 	RST_MAX
 };
 
+#define MAX_HDPTX_PHY_NUM	2
+
+struct rk_hdptx_phy_cfg {
+	unsigned int num_phys;
+	unsigned int phy_ids[MAX_HDPTX_PHY_NUM];
+};
+
 struct rk_hdptx_phy {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regmap *grf;
 
+	/* PHY const config */
+	const struct rk_hdptx_phy_cfg *cfgs;
+	int phy_id;
+
 	struct phy *phy;
 	struct phy_config *phy_cfg;
 	struct clk_bulk_data *clks;
@@ -1857,15 +1868,14 @@ static int rk_hdptx_phy_clk_register(struct rk_hdptx_phy *hdptx)
 	struct device *dev = hdptx->dev;
 	const char *name, *pname;
 	struct clk *refclk;
-	int ret, id;
+	int ret;
 
 	refclk = devm_clk_get(dev, "ref");
 	if (IS_ERR(refclk))
 		return dev_err_probe(dev, PTR_ERR(refclk),
 				     "Failed to get ref clock\n");
 
-	id = of_alias_get_id(dev->of_node, "hdptxphy");
-	name = id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
+	name = hdptx->phy_id > 0 ? "clk_hdmiphy_pixel1" : "clk_hdmiphy_pixel0";
 	pname = __clk_get_name(refclk);
 
 	hdptx->hw.init = CLK_HW_INIT(name, pname, &hdptx_phy_clk_ops,
@@ -1908,8 +1918,9 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	struct rk_hdptx_phy *hdptx;
+	struct resource *res;
 	void __iomem *regs;
-	int ret;
+	int ret, id;
 
 	hdptx = devm_kzalloc(dev, sizeof(*hdptx), GFP_KERNEL);
 	if (!hdptx)
@@ -1917,11 +1928,27 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 
 	hdptx->dev = dev;
 
-	regs = devm_platform_ioremap_resource(pdev, 0);
+	regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(regs))
 		return dev_err_probe(dev, PTR_ERR(regs),
 				     "Failed to ioremap resource\n");
 
+	hdptx->cfgs = device_get_match_data(dev);
+	if (!hdptx->cfgs)
+		return dev_err_probe(dev, -EINVAL, "missing match data\n");
+
+	/* find the phy-id from the io address */
+	hdptx->phy_id = -ENODEV;
+	for (id = 0; id < hdptx->cfgs->num_phys; id++) {
+		if (res->start == hdptx->cfgs->phy_ids[id]) {
+			hdptx->phy_id = id;
+			break;
+		}
+	}
+
+	if (hdptx->phy_id < 0)
+		return dev_err_probe(dev, -ENODEV, "no matching device found\n");
+
 	ret = devm_clk_bulk_get_all(dev, &hdptx->clks);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
@@ -1981,8 +2008,19 @@ static const struct dev_pm_ops rk_hdptx_phy_pm_ops = {
 		       rk_hdptx_phy_runtime_resume, NULL)
 };
 
+static const struct rk_hdptx_phy_cfg rk3588_hdptx_phy_cfgs = {
+	.num_phys = 2,
+	.phy_ids = {
+		0xfed60000,
+		0xfed70000,
+	},
+};
+
 static const struct of_device_id rk_hdptx_phy_of_match[] = {
-	{ .compatible = "rockchip,rk3588-hdptx-phy", },
+	{
+		.compatible = "rockchip,rk3588-hdptx-phy",
+		.data = &rk3588_hdptx_phy_cfgs
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, rk_hdptx_phy_of_match);
-- 
2.45.2


