Return-Path: <linux-kernel+bounces-553419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E7A58941
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 00:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6539C3A343B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80572222A7;
	Sun,  9 Mar 2025 23:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="FFbjU5gY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B061CAA6C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 23:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741562809; cv=none; b=UJ5Nd8Xxv5vOsv7n74jaa8LNy+DtbvjxIJAgIB630mGLW6khluC/2ybuX0eX74c+TZV+Ir8RzkJh+6gwrKSgi1lGpQBaWEvmNRVMGkBgr04zfMYda36ryI5O9/mB6viYCxTDTMCcJuuRcMzeK6XWNmX4vdLVmrGeEi0HLf43h28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741562809; c=relaxed/simple;
	bh=1KwXe9PoxEReMydTX2qSnybaHlsL4TT8cuxNZbn6vKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0oh2jkY5UzrHTvOLKHOD91DfX+N3pmRHl62XQ9L51rD3m21UYxlN05D9GaZVDdXgHF4xYRaPjIVO1CcPXLwIbdV4k8mqsaQ3bxRJG6dlMVY7RAPJ8cZ5mL0APWFh1FRopeu7bAD64XdnZNj1SiEKfOXsXZpTH3LqT1kokLms44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=FFbjU5gY; arc=none smtp.client-ip=121.127.44.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741562806; bh=L3Wm/7k4UnB9TXY856GOytFcdaOKPaHZ6TKBq1pbNtA=;
 b=FFbjU5gYETSaZjPXHkV5/mQP3a3rkAmFOjT6FsJi2mBasdF5mdnCdsd3P9r54+2kbTK5ktQ9a
 zdHdUAIFNYp/XtEtkg2rg878zi4yMUmwExd1Ka4srbCFam7ZcnAfM+aaUi6kwSXQdV+MeV50GXA
 VgEND9Euv7uq32/m8xUYU95t9bKqxPKqtM+ITYNS62Bp2d4uSRrG/81Eu2TQllqesW0bWW64sL0
 3SWPjOsAWzF0xEvFn8CynPJyCbm6LfZNZDcVVy82j8bi1Bsyn5CwxwwKTe/Q8l50d0P0sJ7R6Tm
 CW4tpR3Mt/frt4OFw29Fc82eW/0WGM/Do1CNe5L6TERg==
X-Forward-Email-ID: 67ce23b35209992d7c670e98
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
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
Subject: [PATCH v2 3/5] net: stmmac: dwmac-rk: Move integrated_phy_powerup/down functions
Date: Sun,  9 Mar 2025 23:26:13 +0000
Message-ID: <20250309232622.1498084-4-jonas@kwiboo.se>
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
not compatible with the integrated PHY found in these SoCs.

Move the rk_gmac_integrated_phy_powerup/down functions to top of the
file to prepare for them to be called directly by a GMAC variant
specific powerup/down operation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- New patch
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 88 +++++++++----------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 03ea9368ffbb..31f4b7eb3718 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -92,6 +92,50 @@ struct rk_priv_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define RK_GRF_MACPHY_CON0		0xb00
+#define RK_GRF_MACPHY_CON1		0xb04
+#define RK_GRF_MACPHY_CON2		0xb08
+#define RK_GRF_MACPHY_CON3		0xb0c
+
+#define RK_MACPHY_ENABLE		GRF_BIT(0)
+#define RK_MACPHY_DISABLE		GRF_CLR_BIT(0)
+#define RK_MACPHY_CFG_CLK_50M		GRF_BIT(14)
+#define RK_GMAC2PHY_RMII_MODE		(GRF_BIT(6) | GRF_CLR_BIT(7))
+#define RK_GRF_CON2_MACPHY_ID		HIWORD_UPDATE(0x1234, 0xffff, 0)
+#define RK_GRF_CON3_MACPHY_ID		HIWORD_UPDATE(0x35, 0x3f, 0)
+
+static void rk_gmac_integrated_phy_powerup(struct rk_priv_data *priv)
+{
+	if (priv->ops->integrated_phy_powerup)
+		priv->ops->integrated_phy_powerup(priv);
+
+	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_CFG_CLK_50M);
+	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_GMAC2PHY_RMII_MODE);
+
+	regmap_write(priv->grf, RK_GRF_MACPHY_CON2, RK_GRF_CON2_MACPHY_ID);
+	regmap_write(priv->grf, RK_GRF_MACPHY_CON3, RK_GRF_CON3_MACPHY_ID);
+
+	if (priv->phy_reset) {
+		/* PHY needs to be disabled before trying to reset it */
+		regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_DISABLE);
+		if (priv->phy_reset)
+			reset_control_assert(priv->phy_reset);
+		usleep_range(10, 20);
+		if (priv->phy_reset)
+			reset_control_deassert(priv->phy_reset);
+		usleep_range(10, 20);
+		regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_ENABLE);
+		msleep(30);
+	}
+}
+
+static void rk_gmac_integrated_phy_powerdown(struct rk_priv_data *priv)
+{
+	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_DISABLE);
+	if (priv->phy_reset)
+		reset_control_assert(priv->phy_reset);
+}
+
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
@@ -1463,50 +1507,6 @@ static const struct rk_gmac_ops rv1126_ops = {
 	.set_rmii_speed = rv1126_set_rmii_speed,
 };
 
-#define RK_GRF_MACPHY_CON0		0xb00
-#define RK_GRF_MACPHY_CON1		0xb04
-#define RK_GRF_MACPHY_CON2		0xb08
-#define RK_GRF_MACPHY_CON3		0xb0c
-
-#define RK_MACPHY_ENABLE		GRF_BIT(0)
-#define RK_MACPHY_DISABLE		GRF_CLR_BIT(0)
-#define RK_MACPHY_CFG_CLK_50M		GRF_BIT(14)
-#define RK_GMAC2PHY_RMII_MODE		(GRF_BIT(6) | GRF_CLR_BIT(7))
-#define RK_GRF_CON2_MACPHY_ID		HIWORD_UPDATE(0x1234, 0xffff, 0)
-#define RK_GRF_CON3_MACPHY_ID		HIWORD_UPDATE(0x35, 0x3f, 0)
-
-static void rk_gmac_integrated_phy_powerup(struct rk_priv_data *priv)
-{
-	if (priv->ops->integrated_phy_powerup)
-		priv->ops->integrated_phy_powerup(priv);
-
-	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_CFG_CLK_50M);
-	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_GMAC2PHY_RMII_MODE);
-
-	regmap_write(priv->grf, RK_GRF_MACPHY_CON2, RK_GRF_CON2_MACPHY_ID);
-	regmap_write(priv->grf, RK_GRF_MACPHY_CON3, RK_GRF_CON3_MACPHY_ID);
-
-	if (priv->phy_reset) {
-		/* PHY needs to be disabled before trying to reset it */
-		regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_DISABLE);
-		if (priv->phy_reset)
-			reset_control_assert(priv->phy_reset);
-		usleep_range(10, 20);
-		if (priv->phy_reset)
-			reset_control_deassert(priv->phy_reset);
-		usleep_range(10, 20);
-		regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_ENABLE);
-		msleep(30);
-	}
-}
-
-static void rk_gmac_integrated_phy_powerdown(struct rk_priv_data *priv)
-{
-	regmap_write(priv->grf, RK_GRF_MACPHY_CON0, RK_MACPHY_DISABLE);
-	if (priv->phy_reset)
-		reset_control_assert(priv->phy_reset);
-}
-
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 {
 	struct rk_priv_data *bsp_priv = plat->bsp_priv;
-- 
2.48.1


