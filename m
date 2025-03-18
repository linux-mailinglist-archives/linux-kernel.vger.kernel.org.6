Return-Path: <linux-kernel+bounces-565834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A07ACA66FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F72819A3737
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD29C1FC7D2;
	Tue, 18 Mar 2025 09:34:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F120766A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290461; cv=none; b=fzl0M0CzmGpJxBlsgKK5WcF7oO0HIoAu84tW///q4wJ3blfHni4p1TnYqH4go7DsUFjPpdHXNeueyJn5okEJWi+fydtILVkcEv0K5GRrnyeFBGpVsAHP8NdhhZklkjIMqOldqdaVx7TdiZj6L720vU4IOmmHfaRcPwMfGAsSlQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290461; c=relaxed/simple;
	bh=L0sPs3TF+5cPjtBfdNIxBBrsxI6S/48gBgo9LG/xxbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bdbCOFa+rwesYYJW9iWMq6RNNCal5OO9Q/Mq8A49GIqnqmqxiNCR8USuJ6jaZobU/vHVIPwqPAKISGsYgLr4ETLIEmEt2WlWUxNcIpQkZT71mgUiTT018+JvZPrSzIw4L1tL7Oa7/+D4YbfkZms3BYxqo1J2gY+fQM/dis+9uy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKu-0005yI-LY; Tue, 18 Mar 2025 10:34:12 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-000OyU-0B;
	Tue, 18 Mar 2025 10:34:11 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuTKt-00Cmv4-13;
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v4 06/10] net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
Date: Tue, 18 Mar 2025 10:34:06 +0100
Message-Id: <20250318093410.3047828-7-o.rempel@pengutronix.de>
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

Replace the custom lan78xx_get_link implementation with the standard
ethtool_op_get_link helper, which uses netif_carrier_ok to reflect
the current link status accurately.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/usb/lan78xx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 190c063f8eb9..18fd90dd9916 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1835,18 +1835,6 @@ static int lan78xx_set_eee(struct net_device *net, struct ethtool_keee *edata)
 	return ret;
 }
 
-static u32 lan78xx_get_link(struct net_device *net)
-{
-	u32 link;
-
-	mutex_lock(&net->phydev->lock);
-	phy_read_status(net->phydev);
-	link = net->phydev->link;
-	mutex_unlock(&net->phydev->lock);
-
-	return link;
-}
-
 static void lan78xx_get_drvinfo(struct net_device *net,
 				struct ethtool_drvinfo *info)
 {
@@ -2013,7 +2001,7 @@ lan78xx_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 }
 
 static const struct ethtool_ops lan78xx_ethtool_ops = {
-	.get_link	= lan78xx_get_link,
+	.get_link	= ethtool_op_get_link,
 	.nway_reset	= phy_ethtool_nway_reset,
 	.get_drvinfo	= lan78xx_get_drvinfo,
 	.get_msglevel	= lan78xx_get_msglevel,
-- 
2.39.5


