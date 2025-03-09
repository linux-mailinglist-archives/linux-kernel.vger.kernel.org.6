Return-Path: <linux-kernel+bounces-553421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB255A58944
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161D016A6DE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104B0222572;
	Sun,  9 Mar 2025 23:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AzPHzvRg"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE962222C3
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741562813; cv=none; b=USZXHhR/NHyHaOpbA+YXPV52Gw6Pukhn0I8eX/0GSOzvOt09OxjpWH7qSyiU/x8FVL3B6gK0aPkPi5ptI5jalUkXDMDmK6B5WiMd51yIvn7PjNmNT7eEaAQUB/KvI8rcwA2nIcx4JITAwkUAcsaGmdBLZ4BEdQVSugx6ViBAGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741562813; c=relaxed/simple;
	bh=/nqMLnlOa/JgA+uEvYviBVxxUhEhlOBTBRNf0tSGvI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZFFjE34mPwT6hwt3VCPhCrWsvyBb1Ob0rs0Pku1lCfNgtpvF+H1ZJHnFJsR5hDf2TjTCQmmXV1akbFFqmE/mZKbqW7lFd1jVFp0XT1RPTVV5fzGmfIqUomYBQqW3I9bPbOfv2sFohJUnooq37HSFUFWyYk/p6a97lwbIcivwSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AzPHzvRg; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741562810; bh=g1vzbhos5OwaddvUHip/yFVK9gBZxHa1+o/ob3Y9bs8=;
 b=AzPHzvRgM/T+yIWLuTrvlPljI7sCwom5F+CD646XsZW6L5xSYCX+LWmyTSaF3MlMl4+8uZmAp
 bCEi6Rknudhi8ibaMNe7wLN4HuhT4XLhen/S3E+HQUItzcSek62n6TCgIwTNVI5tiLfHzv6Llin
 uVUpFjPC6/jba/MgtCha45Ck8GijJfnMVTNyZRqamE1Y9Ptld9xNkbFs1fHLVwfej7h4l5Uuwap
 X2fNk/jrR3PGiIjfNHDMsONw48pV+9ZORdCXoKqEw+TY49YXlxkrLsFSgDFmSxmFRLKAdQuDFxL
 FOeJmpzhubpxH9fkzMHbu7rPg6V4UZuY5DEbC9f8DpWA==
X-Forward-Email-ID: 67ce23b85209992d7c670ead
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wu <david.wu@rock-chips.com>,
	Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 4/5] net: stmmac: dwmac-rk: Add integrated_phy_powerdown operation
Date: Sun,  9 Mar 2025 23:26:14 +0000
Message-ID: <20250309232622.1498084-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309232622.1498084-1-jonas@kwiboo.se>
References: <20250309232622.1498084-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 (and RV1106) has a different integrated PHY compared to
the integrated PHY on RK3228/RK3328. Current powerup/down operation is
not compatible with the integrated PHY found in these newer SoCs.

Add a new integrated_phy_powerdown operation and change the call chain
for integrated_phy_powerup to prepare support for the integrated PHY
found in these newer SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- New patch
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 31f4b7eb3718..3f096b3ccee8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -33,6 +33,7 @@ struct rk_gmac_ops {
 	void (*set_clock_selection)(struct rk_priv_data *bsp_priv, bool input,
 				    bool enable);
 	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
+	void (*integrated_phy_powerdown)(struct rk_priv_data *bsp_priv);
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -104,11 +105,8 @@ struct rk_priv_data {
 #define RK_GRF_CON2_MACPHY_ID		HIWORD_UPDATE(0x1234, 0xffff, 0)
 #define RK_GRF_CON3_MACPHY_ID		HIWORD_UPDATE(0x35, 0x3f, 0)
 
-static void rk_gmac_integrated_phy_powerup(struct rk_priv_data *priv)
+static void rk_gmac_integrated_ephy_powerup(struct rk_priv_data *priv)
 {
-	if (priv->ops->integrated_phy_powerup)
-		priv->ops->integrated_phy_powerup(priv);
-
 	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_CFG_CLK_50M);
 	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_GMAC2PHY_RMII_MODE);
 
@@ -129,7 +127,7 @@ static void rk_gmac_integrated_phy_powerup(struct rk_priv_data *priv)
 	}
 }
 
-static void rk_gmac_integrated_phy_powerdown(struct rk_priv_data *priv)
+static void rk_gmac_integrated_ephy_powerdown(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_DISABLE);
 	if (priv->phy_reset)
@@ -368,6 +366,8 @@ static void rk3228_integrated_phy_powerup(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK3228_GRF_CON_MUX,
 		     RK3228_GRF_CON_MUX_GMAC_INTEGRATED_PHY);
+
+	rk_gmac_integrated_ephy_powerup(priv);
 }
 
 static const struct rk_gmac_ops rk3228_ops = {
@@ -375,7 +375,8 @@ static const struct rk_gmac_ops rk3228_ops = {
 	.set_to_rmii = rk3228_set_to_rmii,
 	.set_rgmii_speed = rk3228_set_rgmii_speed,
 	.set_rmii_speed = rk3228_set_rmii_speed,
-	.integrated_phy_powerup =  rk3228_integrated_phy_powerup,
+	.integrated_phy_powerup = rk3228_integrated_phy_powerup,
+	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 };
 
 #define RK3288_GRF_SOC_CON1	0x0248
@@ -601,6 +602,8 @@ static void rk3328_integrated_phy_powerup(struct rk_priv_data *priv)
 {
 	regmap_write(priv->grf, RK3328_GRF_MACPHY_CON1,
 		     RK3328_MACPHY_RMII_MODE);
+
+	rk_gmac_integrated_ephy_powerup(priv);
 }
 
 static const struct rk_gmac_ops rk3328_ops = {
@@ -608,7 +611,8 @@ static const struct rk_gmac_ops rk3328_ops = {
 	.set_to_rmii = rk3328_set_to_rmii,
 	.set_rgmii_speed = rk3328_set_rgmii_speed,
 	.set_rmii_speed = rk3328_set_rmii_speed,
-	.integrated_phy_powerup =  rk3328_integrated_phy_powerup,
+	.integrated_phy_powerup = rk3328_integrated_phy_powerup,
+	.integrated_phy_powerdown = rk_gmac_integrated_ephy_powerdown,
 };
 
 #define RK3366_GRF_SOC_CON6	0x0418
@@ -1802,16 +1806,16 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 
 	pm_runtime_get_sync(dev);
 
-	if (bsp_priv->integrated_phy)
-		rk_gmac_integrated_phy_powerup(bsp_priv);
+	if (bsp_priv->integrated_phy && bsp_priv->ops->integrated_phy_powerup)
+		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
 
 	return 0;
 }
 
 static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 {
-	if (gmac->integrated_phy)
-		rk_gmac_integrated_phy_powerdown(gmac);
+	if (gmac->integrated_phy && gmac->ops->integrated_phy_powerdown)
+		gmac->ops->integrated_phy_powerdown(gmac);
 
 	pm_runtime_put_sync(&gmac->pdev->dev);
 
-- 
2.48.1


