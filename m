Return-Path: <linux-kernel+bounces-235877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA991DAB4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8411F22FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A8C86AEE;
	Mon,  1 Jul 2024 08:53:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3D82D69
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719824034; cv=none; b=ZWO48ZSB9pLzPMKEv9fx/TUdcL5kxuEx0M3/6aeZhWoqlYZuf/DXFv2wekDnoHXqIfeazRDByl8qJOSSxqR0flUqzhAsP34+Yny6jZf1Y5j7ImKfbl7hvXUxP71ao3HI5fwE2L8FmqoEeJGv//GunETeGTCVkDY9eBv4HVzaLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719824034; c=relaxed/simple;
	bh=yJv2lcMEVjKb92g/50GWfPdl0XxhueWIqPtDJJ/xLG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JaXJxajHCejd2DBa3GMlvkj825vkYQs6dRVfXOS17UG9ALJKirMJGwFBZtry7hj3hR5u3RDJmTSYQPqMYO/E0DP6zc1vkMa2WSJFri3tuSNHH3q4PzXSC5lARFZECDdeHGMJk+xzwK1Mf7DLjaI6TnQM8mrc464kmC1vKR0WijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnB-0006bD-91; Mon, 01 Jul 2024 10:53:45 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-006Kdo-JL; Mon, 01 Jul 2024 10:53:44 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sOCnA-00ClWE-1i;
	Mon, 01 Jul 2024 10:53:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next v2 2/3] net: dsa: microchip: lan937x: disable in-band status support for RGMII interfaces
Date: Mon,  1 Jul 2024 10:53:42 +0200
Message-Id: <20240701085343.3042567-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701085343.3042567-1-o.rempel@pengutronix.de>
References: <20240701085343.3042567-1-o.rempel@pengutronix.de>
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

From: Lucas Stach <l.stach@pengutronix.de>

This driver do not support in-band mode and in case of CPU<->Switch
link, this mode is not working any way. So, disable it otherwise ingress
path of the switch MAC will stay disabled.

Note: lan9372 manual do not document 0xN301 BIT(2) for the RGMII mode
and recommend[1] to disable in-band link status update for the RGMII RX
path by clearing 0xN302 BIT(0). But, 0xN301 BIT(2) seems to work too, so
keep it unified with other KSZ switches.

[1] https://microchip.my.site.com/s/article/LAN937X-The-required-configuration-for-the-external-MAC-port-to-operate-at-RGMII-to-RGMII-1Gbps-link-speed

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- use ksz_set_xmii() instead of LAN937X specific code
---
 drivers/net/dsa/microchip/ksz_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index baa1eeb9a1b04..b074b4bb06296 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3116,7 +3116,8 @@ static void ksz_set_xmii(struct ksz_device *dev, int port,
 		/* On KSZ9893, disable RGMII in-band status support */
 		if (dev->chip_id == KSZ9893_CHIP_ID ||
 		    dev->chip_id == KSZ8563_CHIP_ID ||
-		    dev->chip_id == KSZ9563_CHIP_ID)
+		    dev->chip_id == KSZ9563_CHIP_ID ||
+		    is_lan937x(dev))
 			data8 &= ~P_MII_MAC_MODE;
 		break;
 	default:
-- 
2.39.2


