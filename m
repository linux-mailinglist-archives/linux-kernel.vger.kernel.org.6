Return-Path: <linux-kernel+bounces-428840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 623A29E1411
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0020AB22C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A201E2303;
	Tue,  3 Dec 2024 07:22:15 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E11DDC24
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210533; cv=none; b=ThpPGiamryEWlF6IYEuh8bWprzgfYzZFrnXDZ/JFNCTtg6YpXEnwPUCbrrfFGtZCKlUXiBzW6BeVGMHCdSRkOm0B+hUkCXHyAK6innmKzqdDKA1+MdgkdKhM11f1QRQCn4ag/jCu3YIQlRlxORgJTbtcFXPrjUCLt8M8WbAYi9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210533; c=relaxed/simple;
	bh=R4/0zDSvXQ7j2t6w8Tqa4xvfeIvEbrVq6ZRm2VJWwpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ho3qYENPosCCCP3enhrxa5b5GIRHq5GAHqY8MANeDX4g/qhYOfxS/TbTB8WNf209+gGlSPqcCrAAPsTegGo33E8R0iR+g4OQKOAu5gFYMktS1VtEvASk9Uh9/zHeT6gFnZ3orjUwbrSO4VhvZZD9Qaa1UcTf+6zZRbeRLhdUwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEP-0004sE-MC; Tue, 03 Dec 2024 08:22:01 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-001QzH-1K;
	Tue, 03 Dec 2024 08:21:56 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tINEJ-00AEpS-3B;
	Tue, 03 Dec 2024 08:21:55 +0100
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
Subject: [PATCH net-next v1 18/21] net: usb: lan78xx: Use function-specific label in lan78xx_mac_reset
Date: Tue,  3 Dec 2024 08:21:51 +0100
Message-Id: <20241203072154.2440034-19-o.rempel@pengutronix.de>
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

Rename the generic `done` label to the function-specific
`mac_reset_done` label in `lan78xx_mac_reset`. This improves clarity and
aligns with best practices for error handling and cleanup labels.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/usb/lan78xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index c66e404f51ac..fdeb95db529b 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1604,16 +1604,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	 */
 	ret = lan78xx_phy_wait_not_busy(dev);
 	if (ret < 0)
-		goto done;
+		goto mac_reset_done;
 
 	ret = lan78xx_read_reg(dev, MAC_CR, &val);
 	if (ret < 0)
-		goto done;
+		goto mac_reset_done;
 
 	val |= MAC_CR_RST_;
 	ret = lan78xx_write_reg(dev, MAC_CR, val);
 	if (ret < 0)
-		goto done;
+		goto mac_reset_done;
 
 	/* Wait for the reset to complete before allowing any further
 	 * MAC register accesses otherwise the MAC may lock up.
@@ -1621,16 +1621,16 @@ static int lan78xx_mac_reset(struct lan78xx_net *dev)
 	do {
 		ret = lan78xx_read_reg(dev, MAC_CR, &val);
 		if (ret < 0)
-			goto done;
+			goto mac_reset_done;
 
 		if (!(val & MAC_CR_RST_)) {
 			ret = 0;
-			goto done;
+			goto mac_reset_done;
 		}
 	} while (!time_after(jiffies, start_time + HZ));
 
 	ret = -ETIMEDOUT;
-done:
+mac_reset_done:
 	mutex_unlock(&dev->phy_mutex);
 
 	return ret;
-- 
2.39.5


