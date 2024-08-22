Return-Path: <linux-kernel+bounces-297200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6095B46C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D4D1C22FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCA1C945E;
	Thu, 22 Aug 2024 11:59:55 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CF11C9450
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327994; cv=none; b=ho31B9Oye/OWx0CccrtHUl3NnsqhdL8mp1I3BdO8pRppoJMqKiPXFh4birqeNxQpc25fhgA9C24uoY94bv2qd45r0fKwkGOzuI7mP8bg/pAYrX8+OqV9/bsOdLswKw8gDVv8qYJx/mkuaMlaNSTomwmHNe/NR+5HRdSF71/HsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327994; c=relaxed/simple;
	bh=XGxCwOjrw82v2fQviP7oY9SlK/N+MuFxgjHPn8QUHFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SFwBoMM6ufZYeVN2a8/m77/QmFGjN7tuH7M378UmGkSTcxG2ZULQrdC3+DJSnlygcS213QXnGNCEJELWZU7pAwXQhnJXQRC5aaG1nnjsBMu+XuUj2VS1lHjqBxzZVMsu2/0XXnQX4QO4XuOtXEobaRQ6SWKt6x3xD5EdU3pNIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Te-0005ox-WD; Thu, 22 Aug 2024 13:59:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-002EyS-5B; Thu, 22 Aug 2024 13:59:41 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sh6Td-005oq1-0I;
	Thu, 22 Aug 2024 13:59:41 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/3] phy: Add defines for standardized PHY generic counters
Date: Thu, 22 Aug 2024 13:59:38 +0200
Message-Id: <20240822115939.1387015-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822115939.1387015-1-o.rempel@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
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

Introduce a set of defines for generic PHY-specific counters.
These defines provide standardized names for commonly
tracked statistics across different PHY drivers, ensuring consistency in
how these metrics are reported:

- `PHY_TX_PKT_COUNT`: Transmit packet count.
- `PHY_RX_PKT_COUNT`: Receive packet count.
- `PHY_TX_ERR_COUNT`: Transmit error count.
- `PHY_RX_ERR_COUNT`: Receive error count.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 include/linux/phy.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 6b7d40d49129d..65fd56ca8cb39 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -2209,4 +2209,10 @@ module_exit(phy_module_exit)
 bool phy_driver_is_genphy(struct phy_device *phydev);
 bool phy_driver_is_genphy_10g(struct phy_device *phydev);
 
+/* Defines for PHY specific counters */
+#define PHY_TX_PKT_COUNT	"tx_pkt_cnt"
+#define PHY_RX_PKT_COUNT	"rx_pkt_cnt"
+#define PHY_TX_ERR_COUNT	"tx_err_cnt"
+#define PHY_RX_ERR_COUNT	"rx_err_cnt"
+
 #endif /* __PHY_H */
-- 
2.39.2


