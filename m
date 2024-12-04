Return-Path: <linux-kernel+bounces-430797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46439E35B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DB8281FB2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604651AB501;
	Wed,  4 Dec 2024 08:41:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416601990C4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301716; cv=none; b=gdRm7fH4JAJgTff1SRmQG6I1+bkUqlLX2uZP9xhZKD0FrqOCMMRfdMxNmh9bWANs8DWl6D5jGNEtzDCHN+A72cow56Ed2ta+tig1kHOcikWjlSZbDlakgtt0XuNFXyi/kmsvDxfBC0NEj/TTJTy1d23ItRaiU+Dji6dtusLf7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301716; c=relaxed/simple;
	bh=g7W6HaNHfZK9DJ4BMFiE+Tt3WIyDpSTET1kWhUBSNY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/TcBu1FWmOsYUVEtL0ipJc+DtAZeRwXXEQ6F08mJFgrDRvXY9ZMmJGFX+R3FGlK6FJzqYt0RzogBdJpF8fDsIIltdWmK27Do1yUQ5bfa6i3+ts6d16VETewgB8YLFUzrOzFTv7ivRY6tBngNjG4VExl5jZOJzifPjWdoKxCvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx7-0001I3-49; Wed, 04 Dec 2024 09:41:45 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-001cUB-0b;
	Wed, 04 Dec 2024 09:41:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tIkx5-004pt9-2r;
	Wed, 04 Dec 2024 09:41:43 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH net-next v2 04/10] net: usb: lan78xx: Improve error reporting with %pe specifier
Date: Wed,  4 Dec 2024 09:41:36 +0100
Message-Id: <20241204084142.1152696-5-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
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

Replace integer error codes with the `%pe` format specifier in register
read and write error messages. This change provides human-readable error
strings, making logs more informative and debugging easier.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/lan78xx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index dd9b5d3abcb3..94320deaaeea 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -621,8 +621,8 @@ static int lan78xx_read_reg(struct lan78xx_net *dev, u32 index, u32 *data)
 		*data = *buf;
 	} else if (net_ratelimit()) {
 		netdev_warn(dev->net,
-			    "Failed to read register index 0x%08x. ret = %d",
-			    index, ret);
+			    "Failed to read register index 0x%08x. ret = %pe",
+			    index, ERR_PTR(ret));
 	}
 
 	kfree(buf);
@@ -652,8 +652,8 @@ static int lan78xx_write_reg(struct lan78xx_net *dev, u32 index, u32 data)
 	if (unlikely(ret < 0) &&
 	    net_ratelimit()) {
 		netdev_warn(dev->net,
-			    "Failed to write register index 0x%08x. ret = %d",
-			    index, ret);
+			    "Failed to write register index 0x%08x. ret = %pe",
+			    index, ERR_PTR(ret));
 	}
 
 	kfree(buf);
-- 
2.39.5


