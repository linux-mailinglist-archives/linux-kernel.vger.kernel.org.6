Return-Path: <linux-kernel+bounces-565829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FE8A66FD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADDE87A7CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030ED207A00;
	Tue, 18 Mar 2025 09:34:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51E1422AB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290460; cv=none; b=gKh7XS6XBCYpBI5vvu0hq+HSFVK+vbNvl+6HuFho8qLB9k0NpY0NK/2lswAy8IrEr6z/dvTJmpY57NinWRUbz7p2qB0tvgr0NmTA6cVA6hcb26egv4qgiji7WI9Oih7O5mC4lGI4fTqZLqBbwmuxzeOZu+N56qWokmPj2/lXULk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290460; c=relaxed/simple;
	bh=M9N7m3ZaAo+MKlCO9E6tI0sBqiWY4D4olmBzim77PUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hglF7ZScXJwoSlV++/4xMqmAG6EKqI+tif7/51HYuTlHT3zbv5HZjqJHpWHMU9i23J3d1UnwVKV3of4nYLmV6iJvDVMs3RHV2p+AqtaIqN5NVzO/Nmwj2pdn3gWY+wkYYmuJB1ZxWZXxg6t/eTu81n92pOUluJOd9+pq/AoSB4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKu-0005yG-LX; Tue, 18 Mar 2025 10:34:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKs-000OyS-3D;
	Tue, 18 Mar 2025 10:34:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-00Cmuu-10;
	Tue, 18 Mar 2025 10:34:11 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 05/10] net: usb: lan78xx: Improve error handling in PHY initialization
Date: Tue, 18 Mar 2025 10:34:05 +0100
Message-Id: <20250318093410.3047828-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318093410.3047828-1-o.rempel@pengutronix.de>
References: <20250318093410.3047828-1-o.rempel@pengutronix.de>
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

Ensure that return values from `lan78xx_write_reg()`,
`lan78xx_read_reg()`, and `phy_find_first()` are properly checked and
propagated. Use `ERR_PTR(ret)` for error reporting in
`lan7801_phy_init()` and replace `-EIO` with `-ENODEV` where appropriate
to provide more accurate error codes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v4:
- split the patch and move part of it before PHYlink migration
---
 drivers/net/usb/lan78xx.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index d2bc6cbdbb66..190c063f8eb9 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2569,7 +2569,6 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 {
 	struct phy_device *phydev;
 	int ret;
-	u32 buf;
 
 	phydev = phy_find_first(dev->mdiobus);
 	if (!phydev) {
@@ -2583,28 +2582,27 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 		if (ret < 0)
 			return ERR_PTR(ret);
 
-		ret = lan78xx_read_reg(dev, HW_CFG, &buf);
-		if (ret < 0)
-			return ERR_PTR(ret);
-
-		buf |= HW_CFG_CLK125_EN_;
-		buf |= HW_CFG_REFCLK25_EN_;
-		ret = lan78xx_write_reg(dev, HW_CFG, buf);
+		ret = lan78xx_update_reg(dev, HW_CFG, HW_CFG_CLK125_EN_ |
+					 HW_CFG_REFCLK25_EN_,
+					 HW_CFG_CLK125_EN_ | HW_CFG_REFCLK25_EN_);
 		if (ret < 0)
 			return ERR_PTR(ret);
 	} else {
 		if (!phydev->drv) {
 			netdev_err(dev->net, "no PHY driver found\n");
-			return NULL;
+			return ERR_PTR(-ENODEV);
 		}
 		phydev->interface = PHY_INTERFACE_MODE_RGMII_ID;
 		/* The PHY driver is responsible to configure proper RGMII
 		 * interface delays. Disable RGMII delays on MAC side.
 		 */
-		lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
+		ret = lan78xx_write_reg(dev, MAC_RGMII_ID, 0);
+		if (ret < 0)
+			return ERR_PTR(ret);
 
 		phydev->is_internal = false;
 	}
+
 	return phydev;
 }
 
@@ -2673,7 +2671,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		phydev = phy_find_first(dev->mdiobus);
 		if (!phydev) {
 			netdev_err(dev->net, "no PHY found\n");
-			return -EIO;
+			return -ENODEV;
 		}
 		phydev->is_internal = true;
 		phydev->interface = PHY_INTERFACE_MODE_GMII;
@@ -2681,7 +2679,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	default:
 		netdev_err(dev->net, "Unknown CHIP ID found\n");
-		return -EIO;
+		return -ENODEV;
 	}
 
 	/* if phyirq is not set, use polling mode in phylib */
@@ -2695,7 +2693,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 	if (ret) {
 		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
 			   dev->mdiobus->id, ERR_PTR(ret));
-		return -EIO;
+		return ret;
 	}
 
 	phy_support_eee(phydev);
-- 
2.39.5


