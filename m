Return-Path: <linux-kernel+bounces-411731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB989CFEFA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9D821F229F9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A1C19ABB6;
	Sat, 16 Nov 2024 13:06:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725AC19004D
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762375; cv=none; b=FNLmelXxrfmuVmztr4yqOuqZ7/PDAy3bhMMXzmfKiChFd7G+oc1L5IqMYcir6gFMD4xy0Ngap8X8PcrWEuYfW9Qa9+DIi9iw/PwOEVlcOZ5CPq6u5Gt1QGlU8ZPwNnA7+0RKOuKE+2MrIQGE/UdjpmX/ToQQuHefdzoQTRsDHVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762375; c=relaxed/simple;
	bh=YLrGfnBrRa0yqmk8dr2a3xT23UMBPc9plM5f7KRBMxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mTcCm08kY+0ICfmQKtI1AuFCJIf3UgU+honwADkQGojFrZZLSlrXx2zdLDB28jssUSWa0L0PoxGP2uKM20VsbP05687SbE2FisEXjyyGiGlS3btCLrhqfsVzpiYANyTfskCe+eGhmmVtaDaswuO431Uum65xUXxceMuNkyJiLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tCIUy-0000ZS-Rv; Sat, 16 Nov 2024 14:06:00 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tCIUx-0014fQ-1K;
	Sat, 16 Nov 2024 14:05:59 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tCIUx-005fmg-17;
	Sat, 16 Nov 2024 14:05:59 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Raghuram Chary J <raghuramchary.jallipalli@microchip.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net v1 2/2] net: usb: lan78xx: Fix memory leak on device unplug by freeing PHY device
Date: Sat, 16 Nov 2024 14:05:58 +0100
Message-Id: <20241116130558.1352230-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241116130558.1352230-1-o.rempel@pengutronix.de>
References: <20241116130558.1352230-1-o.rempel@pengutronix.de>
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

Add calls to `phy_device_free` after `fixed_phy_unregister` to fix a
memory leak that occurs when the device is unplugged. This ensures
proper cleanup of pseudo fixed-link PHYs.

Fixes: 89b36fb5e532 ("lan78xx: Lan7801 Support for Fixed PHY")
Cc: Raghuram Chary J <raghuramchary.jallipalli@microchip.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 094a47b8b97e..9f191b6ce821 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2380,6 +2380,7 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 		if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 			if (phy_is_pseudo_fixed_link(phydev)) {
 				fixed_phy_unregister(phydev);
+				phy_device_free(phydev);
 			} else {
 				phy_unregister_fixup_for_uid(PHY_KSZ9031RNX,
 							     0xfffffff0);
@@ -4246,8 +4247,10 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	phy_disconnect(net->phydev);
 
-	if (phy_is_pseudo_fixed_link(phydev))
+	if (phy_is_pseudo_fixed_link(phydev)) {
 		fixed_phy_unregister(phydev);
+		phy_device_free(phydev);
+	}
 
 	usb_scuttle_anchored_urbs(&dev->deferred);
 
-- 
2.39.5


