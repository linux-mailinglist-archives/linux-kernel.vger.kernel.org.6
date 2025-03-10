Return-Path: <linux-kernel+bounces-554124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14462A59341
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D297A58CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1C5228CB0;
	Mon, 10 Mar 2025 11:57:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3822577C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607871; cv=none; b=CAi62M/itOjl5S5t4w0EHl5yjyQrV6jSpdDWlj4fvSI8dkkIoCGz/Z+GHaohSwjeWQurEPM1k7lJk0LAbALGLX6mmbaCudz/RaoRiecjkoM+6OFGS8BOrVM0e51Uh3p/QKPf6I3ePnlboc2QEq5BEeUGTJWEexjmSmgcIF+nCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607871; c=relaxed/simple;
	bh=R0D1y60vC+uBdp+6wIBczzW2cfEHCDuM5HyP0V9xITU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVbachSjnNRJbEPBdOp261ClX3BrsWgt0VLsbYAT0ryQNtEHBIx5JdySEhhaJxG7CxVoqfrbgPTYxL0WJQ9uutqBA6o92/O6hSy9SE4ZTSTHmfuqUBzQdDN2bItmw9BnZHSCClCQDNl++MiERbXNhEtPkfY6qoB/7hYA2duEndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1trblL-0000S7-Co; Mon, 10 Mar 2025 12:57:39 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1trblK-004za2-0R;
	Mon, 10 Mar 2025 12:57:38 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1trblK-003I1v-0A;
	Mon, 10 Mar 2025 12:57:38 +0100
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
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v3 4/7] net: usb: lan78xx: Use ethtool_op_get_link to reflect current link status
Date: Mon, 10 Mar 2025 12:57:34 +0100
Message-Id: <20250310115737.784047-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250310115737.784047-1-o.rempel@pengutronix.de>
References: <20250310115737.784047-1-o.rempel@pengutronix.de>
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
---
 drivers/net/usb/lan78xx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 465762c3efcf..73f62c3e5c58 100644
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


