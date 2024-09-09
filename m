Return-Path: <linux-kernel+bounces-321371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F7A9719BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A221F232E1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2057C1B81D6;
	Mon,  9 Sep 2024 12:44:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7D71B78E8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725885840; cv=none; b=d3zgQLeWj/x/ETh6JqSkD2ZSf/oFlFdkTHT1LnRs1g9qVWiOzuuRhFzOZwsl3R5Jmw8ivnn8Zly6TkKqJr9OgIsNyC4Rf4sBSo1JS8ZZpBL/clNCIM5Mf19V/SHx2JAGx10BzoWdyXUED8Wn6WFPSoyXyTNdDA2n42Mqg4s4CIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725885840; c=relaxed/simple;
	bh=6TIlMKWOEczN3Lsa1rteTXtZ5HxrJ9bSPNFperJGaCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKAIdbgPSDaRnzWS4VYbI05YzEdSZU7XfP4X05skacVix81IrUc0dJjV02VwyWBZLh23ehKDLRUrKAGc4nzZ7mnEWOS+6oMgRMb5zosEnvMbuKcQ/XG8LVLLuEgkDdxGTtGn9v1ZidOT6XgAsEr2DCI9LI6tED1iKm81ZAQlOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sndk8-0001rF-Jw; Mon, 09 Sep 2024 14:43:44 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sndk6-006elN-Qm; Mon, 09 Sep 2024 14:43:42 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sndk6-00BuN8-2S;
	Mon, 09 Sep 2024 14:43:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: phy: Add support for master-slave role configuration via device tree
Date: Mon,  9 Sep 2024 14:43:41 +0200
Message-Id: <20240909124342.2838263-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240909124342.2838263-1-o.rempel@pengutronix.de>
References: <20240909124342.2838263-1-o.rempel@pengutronix.de>
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

Introduce support for configuring the master/slave role of PHYs based on
the `master-slave` property in the device tree. While this functionality
is necessary for Single Pair Ethernet (SPE) PHYs (1000/100/10Base-T1)
where hardware strap pins may be unavailable or incorrectly set, it
works for any PHY type. The property supports `forced-master` and
`forced-slave` values, allowing for predefined link role assignment.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/phy-core.c   | 29 +++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  3 +++
 include/linux/phy.h          |  1 +
 3 files changed, 33 insertions(+)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 1f98b6a96c153..296c446037144 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -412,6 +412,35 @@ void of_set_phy_eee_broken(struct phy_device *phydev)
 	phydev->eee_broken_modes = broken;
 }
 
+/**
+ * of_set_phy_master_slave - Set the master/slave mode of the PHY
+ *
+ * @phydev: The phy_device struct
+ *
+ * Set master/slave configuration of the PHY based on the device tree.
+ */
+void of_set_phy_master_slave(struct phy_device *phydev)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+	const char *master;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO))
+		return;
+
+	if (!node)
+		return;
+
+	if (of_property_read_string(node, "master-slave", &master))
+		return;
+
+	if (strcmp(master, "forced-master") == 0)
+		phydev->master_slave_set = MASTER_SLAVE_CFG_MASTER_FORCE;
+	else if (strcmp(master, "forced-slave") == 0)
+		phydev->master_slave_set = MASTER_SLAVE_CFG_SLAVE_FORCE;
+	else
+		phydev_warn(phydev, "Unknown master-slave mode %s\n", master);
+}
+
 /**
  * phy_resolve_aneg_pause - Determine pause autoneg results
  *
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 560e338b307a4..8304f2781d5ae 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3608,6 +3608,9 @@ static int phy_probe(struct device *dev)
 	 */
 	of_set_phy_eee_broken(phydev);
 
+	/* Get master/slave strap overrides */
+	of_set_phy_master_slave(phydev);
+
 	/* The Pause Frame bits indicate that the PHY can support passing
 	 * pause frames. During autonegotiation, the PHYs will determine if
 	 * they should allow pause frames to pass.  The MAC driver should then
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 4a9a11749c554..81701bdac44c1 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1260,6 +1260,7 @@ size_t phy_speeds(unsigned int *speeds, size_t size,
 		  unsigned long *mask);
 void of_set_phy_supported(struct phy_device *phydev);
 void of_set_phy_eee_broken(struct phy_device *phydev);
+void of_set_phy_master_slave(struct phy_device *phydev);
 int phy_speed_down_core(struct phy_device *phydev);
 
 /**
-- 
2.39.2


