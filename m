Return-Path: <linux-kernel+bounces-437646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 925289E9661
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AC3A282892
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FFB1C5CAA;
	Mon,  9 Dec 2024 13:08:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C01C5CB3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749686; cv=none; b=BKKV7m8gyU30U8OMK5MRjsuRRSMbjUahTt+LPo44bW3laUHzPXVMR7J5q9LjCnJPrLvqXuinqJb1Rpn2E92SJsTJp/fwyPga4jvrTwkkladzHPRLivGXSqkeQFlSA9vsULhhPy8fmr/p1NxREUnvHILDkSpgNvKM+yhl7qVkEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749686; c=relaxed/simple;
	bh=GYRH3OO6qC3Ffui5fJ/M7pAjCmNdhEieICbOAvKK978=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jlcO9Fgzklm+D79U3IqGxsi0IiiPBhshvDX2spw85ASb1n4mhTqaFwjkhm34nJGgCAk+H/UMX5BAkF+N6bkNpcoGCTuiC5mJMn9i0zowRJBvCJhhwFLgCpItb9NA9YPeQ9gyBPIM5FZAu1dlLvctVosv9AkCEO0tpxTSiTlhnj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUP-0004RC-PK; Mon, 09 Dec 2024 14:07:53 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUN-002W7L-1i;
	Mon, 09 Dec 2024 14:07:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUO-002wxQ-0h;
	Mon, 09 Dec 2024 14:07:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v1 04/11] net: usb: lan78xx: Add error handling to lan78xx_get_regs
Date: Mon,  9 Dec 2024 14:07:44 +0100
Message-Id: <20241209130751.703182-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209130751.703182-1-o.rempel@pengutronix.de>
References: <20241209130751.703182-1-o.rempel@pengutronix.de>
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

Update `lan78xx_get_regs` to handle errors during register and PHY
reads.  Log warnings for failed reads and exit the function early if an
error occurs.  This ensures that invalid data is not returned to users.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5d318ff8b33d..62445aced7c6 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2112,20 +2112,35 @@ static void
 lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 		 void *buf)
 {
-	u32 *data = buf;
-	int i, j;
 	struct lan78xx_net *dev = netdev_priv(netdev);
+	u32 *data = buf;
+	int i, j, ret;
 
 	/* Read Device/MAC registers */
-	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++)
-		lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
+	for (i = 0; i < ARRAY_SIZE(lan78xx_regs); i++) {
+		ret = lan78xx_read_reg(dev, lan78xx_regs[i], &data[i]);
+		if (ret < 0) {
+			netdev_warn(dev->net,
+				    "failed to read register 0x%08x\n",
+				    lan78xx_regs[i]);
+			return;
+		}
+	}
 
 	if (!netdev->phydev)
 		return;
 
 	/* Read PHY registers */
-	for (j = 0; j < 32; i++, j++)
-		data[i] = phy_read(netdev->phydev, j);
+	for (j = 0; j < 32; i++, j++) {
+		ret = phy_read(netdev->phydev, j);
+		if (ret < 0) {
+			netdev_warn(dev->net,
+				    "failed to read PHY register 0x%02x\n", j);
+			return;
+		}
+
+		data[i] = ret;
+	}
 }
 
 static const struct ethtool_ops lan78xx_ethtool_ops = {
-- 
2.39.5


