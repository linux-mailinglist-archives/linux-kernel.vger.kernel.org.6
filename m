Return-Path: <linux-kernel+bounces-239536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0329261E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4065FB29AE5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D32C17B519;
	Wed,  3 Jul 2024 13:28:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7DF17B432
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720013299; cv=none; b=G4EQW4kQeF/6O9V8tpgeV3Sl0rAw4IIS2MrbwAHWHurdC8OpRjYOI3d5ulwyKbOL1RElqptwFKZ0cXKidLW4/5MCni6Vcurch7yAr6WWqcJOMq+inJCvqsWkNKH4oHhfLuGyHeMLygBsKEFaTthk64fJ1fn6RKqUeVzESugzaj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720013299; c=relaxed/simple;
	bh=xl9E7mdmU2QSEhuoiWZFWr/Cz68F3jKLgGkRANW/65g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjHtlEKDWhMT0fi+ZnU4woofD2Dlcb4j9GkyXkTdtG9oa3V3ksjvcU/aZR7YnC0tasbjOtmbsSsD0D6yCjPQ/5zjPUyMaEzvCMeh55Cvz7Yq7+kCNzwHkkxznlx1qvTAU2gNFOQJsRASfGZMZNT7xIYljT2LTo8+iuLxY6lx9Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sP01k-0005Vy-HF; Wed, 03 Jul 2024 15:28:04 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sP01i-006rQg-Sc; Wed, 03 Jul 2024 15:28:02 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sP01i-002c8U-2d;
	Wed, 03 Jul 2024 15:28:02 +0200
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
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net v1 2/2] net: phy: microchip: lan87xx: do not report SQI if no link
Date: Wed,  3 Jul 2024 15:28:01 +0200
Message-Id: <20240703132801.623218-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240703132801.623218-1-o.rempel@pengutronix.de>
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
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

Do not report SQI if no link is detected. Otherwise ethtool will show
non zero value even if no cable is attached.

Fixes: b649695248b15 ("net: phy: LAN87xx: add ethtool SQI support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/microchip_t1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a35528497a576..22530a5b76365 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -840,6 +840,9 @@ static int lan87xx_get_sqi(struct phy_device *phydev)
 	u8 sqi_value = 0;
 	int rc;
 
+	if (!phydev->link)
+		return 0;
+
 	rc = access_ereg(phydev, PHYACC_ATTR_MODE_WRITE,
 			 PHYACC_ATTR_BANK_DSP, T1_COEF_RW_CTL_CFG, 0x0301);
 	if (rc < 0)
-- 
2.39.2


