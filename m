Return-Path: <linux-kernel+bounces-437637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE789E964E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EF42283004
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2911216E28;
	Mon,  9 Dec 2024 13:08:04 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4881C5CA9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749683; cv=none; b=rZKQN/N1cOXkzNvj9ktKbJO87B5kqXUSQFVsdcr2sHjiYh9Hxa0WposIVxKixlxxgxvdRDHRBamBfGA36bcmdLtD3BRqhTo5g2EyNzPWKd7wDqW/oOgK1U1shXIto1g6KtkCKy5xN3kzQRn43CON7QlYM27PmR2RoEF9jHXJKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749683; c=relaxed/simple;
	bh=PhXQ00/lGrLiI8+Ecv2+tDmvO0EzcGbWyO3HQgAQ3j8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDHF0njat4QmUkalabs3CJ6XwZXxvshIzkamfJURfMGdQcbx4yBe5yy4ia4MhjAMt/ZYJ3ed0QWjMrG/yHYH8ZuoyWYRZuyabYvrEZwHjQaNHmFm3MPpRIdXmyLMpcPMK4YjPcEn1x7s1D2KV6POyKszn+trNUJCmEWx7rDCBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUP-0004RB-PL; Mon, 09 Dec 2024 14:07:53 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUN-002W7K-1b;
	Mon, 09 Dec 2024 14:07:52 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tKdUO-002wxG-0e;
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
Subject: [PATCH net-next v1 03/11] net: usb: lan78xx: Add error handling to lan78xx_set_mac_addr
Date: Mon,  9 Dec 2024 14:07:43 +0100
Message-Id: <20241209130751.703182-4-o.rempel@pengutronix.de>
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

Update `lan78xx_set_mac_addr` to handle errors during MAC address
register write operations. Ensure that errors are properly propagated to
the caller, improving the robustness of MAC address updates.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 26dc43bac84b..5d318ff8b33d 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2763,6 +2763,7 @@ static int lan78xx_set_mac_addr(struct net_device *netdev, void *p)
 	struct lan78xx_net *dev = netdev_priv(netdev);
 	struct sockaddr *addr = p;
 	u32 addr_lo, addr_hi;
+	int ret;
 
 	if (netif_running(netdev))
 		return -EBUSY;
@@ -2779,14 +2780,20 @@ static int lan78xx_set_mac_addr(struct net_device *netdev, void *p)
 	addr_hi = netdev->dev_addr[4] |
 		  netdev->dev_addr[5] << 8;
 
-	lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
-	lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+	ret = lan78xx_write_reg(dev, RX_ADDRL, addr_lo);
+	if (ret < 0)
+		return ret;
+
+	ret = lan78xx_write_reg(dev, RX_ADDRH, addr_hi);
+	if (ret < 0)
+		return ret;
 
 	/* Added to support MAC address changes */
-	lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
-	lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
+	ret = lan78xx_write_reg(dev, MAF_LO(0), addr_lo);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	return lan78xx_write_reg(dev, MAF_HI(0), addr_hi | MAF_HI_VALID_);
 }
 
 /* Enable or disable Rx checksum offload engine */
-- 
2.39.5


