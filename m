Return-Path: <linux-kernel+bounces-437634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD69E9666
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674EB168450
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E081C5CC7;
	Mon,  9 Dec 2024 13:08:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE41B4224
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749682; cv=none; b=NXuZw5ROWMK541k6EQaDQdaop3cnZZyQ0xGdMSjSfNmiSef0R8E3syvoAtkhHses2lq/J4Cv4mb3N0kiWEOSMy4qomsF0JLM01CdmfdXvscj5PjMVkm6EGJonMOKyQQdz9+MdaARA8Zzr/U7INkwTQf2dEQkCP3A10G2IisWqgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749682; c=relaxed/simple;
	bh=PaxtvrrZrzTt8HJSHJ5IQ4oy/JKItrDoSW/bOnWk72g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JsuctbnY1J3aWJz4xprv1ppUXRKuO4UDUSfaDedEVsK6etm2QesVIMMnxO+jFzpbBT/4W4yE4zMVU1MmN6nIG7M+zvd74Mfkv2trAfZ1Xqvv8KjKWxGkgS68MpfE36I5ATIJHkJ9//366Ui9l9zjw9DaUSh2Yc1JMjFt81ih8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUP-0004RA-PJ; Mon, 09 Dec 2024 14:07:53 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUN-002W7J-1X;
	Mon, 09 Dec 2024 14:07:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUO-002wx6-0b;
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
Subject: [PATCH net-next v1 02/11] net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
Date: Mon,  9 Dec 2024 14:07:42 +0100
Message-Id: <20241209130751.703182-3-o.rempel@pengutronix.de>
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

Convert `lan78xx_init_mac_address` to return error codes and handle
failures in register read and write operations. Update `lan78xx_reset`
to check for errors during MAC address initialization and propagate them
appropriately.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 070b21baffaf..26dc43bac84b 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2153,13 +2153,19 @@ static const struct ethtool_ops lan78xx_ethtool_ops = {
 	.get_regs	= lan78xx_get_regs,
 };
 
-static void lan78xx_init_mac_address(struct lan78xx_net *dev)
+static int lan78xx_init_mac_address(struct lan78xx_net *dev)
 {
 	u32 addr_lo, addr_hi;
 	u8 addr[6];
+	int ret;
+
+	ret = lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
+	if (ret < 0)
+		return ret;
 
-	lan78xx_read_reg(dev, RX_ADDRL, &addr_lo);
-	lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	ret = lan78xx_read_reg(dev, RX_ADDRH, &addr_hi);
+	if (ret < 0)
+		return ret;
 
 	addr[0] = addr_lo & 0xFF;
 	addr[1] = (addr_lo >> 8) & 0xFF;
@@ -2192,14 +2198,26 @@ static void lan78xx_init_mac_address(struct lan78xx_net *dev)
 			  (addr[2] << 16) | (addr[3] << 24);
 		addr_hi = addr[4] | (addr[5] << 8);
 
-		lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-		lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+		if (ret < 0)
+			return ret;
+
+		ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+		if (ret < 0)
+			return ret;
 	}
 
-	lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-	lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	if (ret < 0)
+		return ret;
 
 	eth_hw_addr_set(dev->net, addr);
+
+	return 0;
 }
 
 /* MDIO read and write wrappers for phylib */
@@ -2990,7 +3008,9 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		}
 	} while (buf & HW_CFG_LRST_);
 
-	lan78xx_init_mac_address(dev);
+	ret = lan78xx_init_mac_address(dev);
+	if (ret < 0)
+		return ret;
 
 	/* save DEVID for later usage */
 	ret = lan78xx_read_reg(dev, ID_REV, &buf);
-- 
2.39.5


