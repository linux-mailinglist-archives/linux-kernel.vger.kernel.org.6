Return-Path: <linux-kernel+bounces-428836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578E39E1416
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2579E164D73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD01E22E0;
	Tue,  3 Dec 2024 07:22:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384671DE3AD
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210531; cv=none; b=V6APyRHOEloT75kY5rroa9NBpAFZ7wKSmrAOYpN1zCB/uT99k4KSG0ELibtxyNZ2F/KRA2+pJWQlwMHUTU70/+8QwEhg77XXfEBB40qnK6XXeYuthOUajgSlGLA9JJp1u7DuU62PjvZZWJHH+taN2HANiY09jdtafdjYJBoHquU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210531; c=relaxed/simple;
	bh=30LU4+4zbasvRm9xbPR0QPujuyYcs3Dswq1ogtdq/vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSGsYO9egA6Gg9UVMfOw+pNH9H3PuQRcScLP5d+MWc2wUK61s0NGWcKG0Zm86qwu94gCwbJUYKKY9OeqBgDaASBq19XZzFJ2PZq1/l+BlKZt06/1mF3MshccxrbaZ3HcjVrGekfN7ElAvErP+ev5aXl246tTWMPrzmnUz8HEfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004sF-M6; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001QzL-1P;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEK-00AEpy-07;
	Tue, 03 Dec 2024 08:21:56 +0100
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
Subject: [PATCH net-next v1 21/21] net: usb: lan78xx: Improve error handling in WoL operations
Date: Tue,  3 Dec 2024 08:21:54 +0100
Message-Id: <20241203072154.2440034-22-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241203072154.2440034-1-o.rempel@pengutronix.de>
References: <20241203072154.2440034-1-o.rempel@pengutronix.de>
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

Enhance error handling in Wake-on-LAN (WoL) operations:
- Log a warning in `lan78xx_get_wol` if `lan78xx_read_reg` fails.
- Check and handle errors from `device_set_wakeup_enable` and
  `phy_ethtool_set_wol` in `lan78xx_set_wol`.
- Ensure proper cleanup with a unified error handling path.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 0403aea1a9fa..99c19ec1cb88 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1857,6 +1857,7 @@ static void lan78xx_get_wol(struct net_device *netdev,
 
 	ret = lan78xx_read_reg(dev, USB_CFG0, &buf);
 	if (unlikely(ret < 0)) {
+		netdev_warn(dev->net, "failed to get WoL %pe", ERR_PTR(ret));
 		wol->supported = 0;
 		wol->wolopts = 0;
 	} else {
@@ -1888,10 +1889,13 @@ static int lan78xx_set_wol(struct net_device *netdev,
 
 	pdata->wol = wol->wolopts;
 
-	device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
+	ret = device_set_wakeup_enable(&dev->udev->dev, (bool)wol->wolopts);
+	if (ret < 0)
+		goto set_wol_done;
 
-	phy_ethtool_set_wol(netdev->phydev, wol);
+	ret = phy_ethtool_set_wol(netdev->phydev, wol);
 
+set_wol_done:
 	usb_autopm_put_interface(dev->intf);
 
 	return ret;
-- 
2.39.5


