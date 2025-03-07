Return-Path: <linux-kernel+bounces-551761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342E6A5706E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137493B1785
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350BC2459EC;
	Fri,  7 Mar 2025 18:24:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7DE23F434
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371887; cv=none; b=BzGpSIDQYnB7aLa9r1qmaUQuJwuHVfD9x7INAq9QzMfrsVTFpnwALRzxnqKqBXelw5V1TF3GirKzgkdKeP9AKwaM0gp+DrTe8ZKsUc8cdi5LhB6vtuX3JGAmLto6dDVybIs2veUg6yzhdCpjtotdYhZTk6wyU+LjD/YqC3H4+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371887; c=relaxed/simple;
	bh=vGDSlh9ZY+40JvXkJEt8xx3jlYVo3VcvOYyL7OPzKVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYhxNSmx/sLADkQkxkHpN43soNV2/ZzYzjarMXj9/X6zvCR1Y6V8eSimqw3OAFpeWz/+0vW25wfch9sAtLwl0TTv1lthW/GQ379Q+w7qjnrHgVEb4/IOEF0y89oJzIRA3G8QknOPjIh7yC+wnhYASJBggqA9TDSuLq5RbLLcZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN9-0005mb-4w; Fri, 07 Mar 2025 19:24:35 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-004X2T-1g;
	Fri, 07 Mar 2025 19:24:33 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tqcN7-008I8S-1R;
	Fri, 07 Mar 2025 19:24:33 +0100
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
Subject: [PATCH net-next v2 2/7] net: usb: lan78xx: Move fixed PHY cleanup to lan78xx_unbind()
Date: Fri,  7 Mar 2025 19:24:27 +0100
Message-Id: <20250307182432.1976273-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307182432.1976273-1-o.rempel@pengutronix.de>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
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

Move the cleanup of the fixed PHY to the lan78xx_unbind() function,
which is invoked during both the probe and disconnect paths.  This
change eliminates duplicate cleanup code in the disconnect routine and
ensures that the fixed PHY is properly freed during other probe steps.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 01967138bc8c..4efe7a956667 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2688,8 +2688,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 
 	ret = phylink_connect_phy(dev->phylink, phydev);
 	if (ret) {
-		netdev_err(dev->net, "can't attach PHY to %s\n",
-			   dev->mdiobus->id);
+		netdev_err(dev->net, "can't attach PHY to %s, error %pe\n",
+			   dev->mdiobus->id, ERR_PTR(ret));
 		return -EIO;
 	}
 
-- 
2.39.5


