Return-Path: <linux-kernel+bounces-242135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D02592841D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7671C22AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F58145FEA;
	Fri,  5 Jul 2024 08:50:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A0D143C67
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169413; cv=none; b=TVCsZdr0Tiero2HRemOIwoq/EVjF9rXj4QlcQLBev491JiEMupi/uYIjMhwc4niM+ZnqH6lAwEL7dLsf43KoPgfrZzjO6NfyL/4Igeq1NzWYcXEARPT1zy+dmHeHfNJ6FkhR+SlGzUa8of9CNbq/HIGSAOdn5Acn62LASkvnqak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169413; c=relaxed/simple;
	bh=sHYfbCuq8SPanDuwXpeA1bZ2iDfcszHqoWHCl9HxScg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AT1L2qXAHQwtu/x+WadbBgxkhzZ4N61c9kVBMprm1FU2Tdtpth3f7Syyw6Ym27/p/ghy9tsb0ZBgQJNQtZZ5whsiSLDVch8sE8CLWzLgxAzjXDfgUyp24HyVdqkCgqC9kFMsjUc/7bpcVXhxiR4ENBabGjnQBbZoj5zfdRy1RYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sPedi-0004Cu-AC; Fri, 05 Jul 2024 10:49:58 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sPedg-007HqW-HM; Fri, 05 Jul 2024 10:49:56 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sPedg-000Lbn-1U;
	Fri, 05 Jul 2024 10:49:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v3 1/1] net: phy: microchip: lan87xx: reinit PHY after cable test
Date: Fri,  5 Jul 2024 10:49:54 +0200
Message-Id: <20240705084954.83048-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
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

Reinit PHY after cable test, otherwise link can't be established on
tested port. This issue is reproducible on LAN9372 switches with
integrated 100BaseT1 PHYs.

Fixes: 788050256c411 ("net: phy: microchip_t1: add cable test support for lan87xx phy")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
changes v3:
- add Reviewed-by: Michal Kubiak  and Florian Fainelli from v1 patch
changes v2:
- add Reviewed-by: Andrew Lunn <andrew@lunn.ch>
- drop microchip specific SQI fix
---
 drivers/net/phy/microchip_t1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a838b61cd844b..a35528497a576 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -748,7 +748,7 @@ static int lan87xx_cable_test_report(struct phy_device *phydev)
 	ethnl_cable_test_result(phydev, ETHTOOL_A_CABLE_PAIR_A,
 				lan87xx_cable_test_report_trans(detect));
 
-	return 0;
+	return phy_init_hw(phydev);
 }
 
 static int lan87xx_cable_test_get_status(struct phy_device *phydev,
-- 
2.39.2


