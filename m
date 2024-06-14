Return-Path: <linux-kernel+bounces-214667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA59087ED
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7854B1C216E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E881946AE;
	Fri, 14 Jun 2024 09:45:45 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4CA192B76
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358344; cv=none; b=kIPpfVmVu5SjUIUbCe954iipTtZMsa+095Qo3FItvkuGg/RFUBUgauRuZLcTzjC+p49XJyTfQKct+4Vp314OnYVkGnvtYzNoJEXxuNHCzEQ0HQutn4jsvAJeTGv0ye2Nd/AhQUTAZtIZ7WXmXBdchv/I8ETE9TT6Qx2E9lNAXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358344; c=relaxed/simple;
	bh=L+BkJHJ93ZoZnAv3yF+VnHGw4NT9HnFM5BeOcKm1xfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCjcBFOpYI1lX/aF8TjeaZk0I6L3tvrEtDGOtVRz4eaEgAb25JvrjMgAYid94cNTpxMC+BsuAn4awk6D6o/Wu0KMS9xZT7PvF8fDr4pCKR1jsr6xD3rPGpAyEva39cmqGrH28rJM4RWKKzHgj4Lf/5M3zH4xUN2qnFNEdW+b3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sI3Ul-0000Sv-E2; Fri, 14 Jun 2024 11:45:19 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sI3Uj-002Elv-Pu; Fri, 14 Jun 2024 11:45:17 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sI3Uj-006DOY-24;
	Fri, 14 Jun 2024 11:45:17 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net v2 1/2] net: phy: dp83tg720: wake up PHYs in managed mode
Date: Fri, 14 Jun 2024 11:45:15 +0200
Message-Id: <20240614094516.1481231-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

In case this PHY is bootstrapped for managed mode, we need to manually
wake it. Otherwise no link will be detected.

Cc: stable@vger.kernel.org
Fixes: cb80ee2f9bee1 ("net: phy: Add support for the DP83TG720S Ethernet PHY")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83tg720.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
index 326c9770a6dcc..1186dfc70fb3c 100644
--- a/drivers/net/phy/dp83tg720.c
+++ b/drivers/net/phy/dp83tg720.c
@@ -17,6 +17,11 @@
 #define DP83TG720S_PHY_RESET			0x1f
 #define DP83TG720S_HW_RESET			BIT(15)
 
+#define DP83TG720S_LPS_CFG3			0x18c
+/* Power modes are documented as bit fields but used as values */
+/* Power Mode 0 is Normal mode */
+#define DP83TG720S_LPS_CFG3_PWR_MODE_0		BIT(0)
+
 #define DP83TG720S_RGMII_DELAY_CTRL		0x602
 /* In RGMII mode, Enable or disable the internal delay for RXD */
 #define DP83TG720S_RGMII_RX_CLK_SEL		BIT(1)
@@ -154,10 +159,17 @@ static int dp83tg720_config_init(struct phy_device *phydev)
 	 */
 	usleep_range(1000, 2000);
 
-	if (phy_interface_is_rgmii(phydev))
-		return dp83tg720_config_rgmii_delay(phydev);
+	if (phy_interface_is_rgmii(phydev)) {
+		ret = dp83tg720_config_rgmii_delay(phydev);
+		if (ret)
+			return ret;
+	}
 
-	return 0;
+	/* In case the PHY is bootstrapped in managed mode, we need to
+	 * wake it.
+	 */
+	return phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TG720S_LPS_CFG3,
+			     DP83TG720S_LPS_CFG3_PWR_MODE_0);
 }
 
 static struct phy_driver dp83tg720_driver[] = {
-- 
2.39.2


