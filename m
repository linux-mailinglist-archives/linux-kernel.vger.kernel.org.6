Return-Path: <linux-kernel+bounces-382952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39519B1570
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 08:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779E21F229DB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB2B18C90D;
	Sat, 26 Oct 2024 06:36:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234814D2B1
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 06:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924562; cv=none; b=E1AeoP7X4npIVCoWp0MPcrH9pa5Xiu6pgYvEw6458kuVWNG8Y5GEzZTEG7DgjEJJKJZSchMD6QOOVIIwY+KA3hbmjB2cQ3eX1/GzMNlVqwEecqn1Rd85Xbq5ZxS7NDlwlWhK4XugNYVu/rURDVzeG5QEJvRxZpy6575+lNM2SC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924562; c=relaxed/simple;
	bh=f+V8MPT6QmFLdLw9T1LU0D9qdTas18Y6uUgw6VeBuI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QcsdD/pncAJm6/Bo+3ouE7HozX7XKkGRKQV0r6iV1qwCqgsH3A/xvfTDIeXG27dT2HKezg8W+peCVuqWAKdm5FlErPcK8Yomqyy5UStBp4/0Y/o9xUPrgVlCnUy2Uv028qBZvdCOVu9JkqanmQdCTAwxoZqS+jRNQpkNe1F5Juw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOj-0006kE-1m; Sat, 26 Oct 2024 08:35:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOh-000UfQ-0Y;
	Sat, 26 Oct 2024 08:35:39 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOh-00AVyx-0H;
	Sat, 26 Oct 2024 08:35:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 5/5] net: dsa: microchip: add support for side MDIO interface in LAN937x
Date: Sat, 26 Oct 2024 08:35:38 +0200
Message-Id: <20241026063538.2506143-6-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026063538.2506143-1-o.rempel@pengutronix.de>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
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

Implement side MDIO channel support for LAN937x switches, providing an
alternative to SPI for PHY management alongside existing SPI-based
switch configuration. This is needed to reduce SPI load, as SPI can be
relatively expensive for small packets compared to MDIO support.

Also, implemented static mappings for PHY addresses for various LAN937x
models to support different internal PHY configurations. Since the PHY
address mappings are not equal to the port indexes, this patch also
provides PHY address calculation based on hardware strapping
configuration.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c   |   7 ++
 drivers/net/dsa/microchip/lan937x.h      |   2 +
 drivers/net/dsa/microchip/lan937x_main.c | 139 ++++++++++++++++++++---
 drivers/net/dsa/microchip/lan937x_reg.h  |   4 +
 4 files changed, 136 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f08fa52dd1387..303f1342e6cc2 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -411,6 +411,8 @@ static const struct ksz_dev_ops lan937x_dev_ops = {
 	.flush_dyn_mac_table = ksz9477_flush_dyn_mac_table,
 	.port_setup = lan937x_port_setup,
 	.set_ageing_time = lan937x_set_ageing_time,
+	.mdio_bus_preinit = lan937x_mdio_bus_preinit,
+	.create_phy_addr_map = lan937x_create_phy_addr_map,
 	.r_phy = lan937x_r_phy,
 	.w_phy = lan937x_w_phy,
 	.r_mib_cnt = ksz9477_r_mib_cnt,
@@ -1762,6 +1764,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
+		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1790,6 +1793,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
+		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1818,6 +1822,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
+		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1850,6 +1855,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
+		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
@@ -1882,6 +1888,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.num_tx_queues = 8,
 		.num_ipms = 8,
 		.tc_cbs_supported = true,
+		.phy_side_mdio_supported = true,
 		.ops = &lan937x_dev_ops,
 		.phylink_mac_ops = &lan937x_phylink_mac_ops,
 		.mib_names = ksz9477_mib_names,
diff --git a/drivers/net/dsa/microchip/lan937x.h b/drivers/net/dsa/microchip/lan937x.h
index 3388d91dbc44e..df13ebbd356f9 100644
--- a/drivers/net/dsa/microchip/lan937x.h
+++ b/drivers/net/dsa/microchip/lan937x.h
@@ -13,6 +13,8 @@ void lan937x_port_setup(struct ksz_device *dev, int port, bool cpu_port);
 void lan937x_config_cpu_port(struct dsa_switch *ds);
 int lan937x_switch_init(struct ksz_device *dev);
 void lan937x_switch_exit(struct ksz_device *dev);
+int lan937x_mdio_bus_preinit(struct ksz_device *dev, bool side_mdio);
+int lan937x_create_phy_addr_map(struct ksz_device *dev, bool side_mdio);
 int lan937x_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data);
 int lan937x_w_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 val);
 int lan937x_change_mtu(struct ksz_device *dev, int port, int new_mtu);
diff --git a/drivers/net/dsa/microchip/lan937x_main.c b/drivers/net/dsa/microchip/lan937x_main.c
index 824d9309a3d35..7dfd21d0d2843 100644
--- a/drivers/net/dsa/microchip/lan937x_main.c
+++ b/drivers/net/dsa/microchip/lan937x_main.c
@@ -18,6 +18,47 @@
 #include "ksz9477.h"
 #include "lan937x.h"
 
+static const u8 lan9370_phy_addr[] = {
+	[0] = 2, /* Port 1, T1 AFE0 */
+	[1] = 3, /* Port 2, T1 AFE1 */
+	[2] = 5, /* Port 3, T1 AFE3 */
+	[3] = 6, /* Port 4, T1 AFE4 */
+	[4] = U8_MAX, /* Port 5, RGMII 2 */
+};
+
+static const u8 lan9372_phy_addr[] = {
+	[0] = 2, /* Port 1, T1 AFE0 */
+	[1] = 3, /* Port 2, T1 AFE1 */
+	[2] = 5, /* Port 3, T1 AFE3 */
+	[3] = 8, /* Port 4, TX PHY */
+	[4] = U8_MAX, /* Port 5, RGMII 2 */
+	[5] = U8_MAX, /* Port 6, RGMII 1 */
+	[6] = 6, /* Port 7, T1 AFE4 */
+	[7] = 4, /* Port 8, T1 AFE2 */
+};
+
+static const u8 lan9373_phy_addr[] = {
+	[0] = 2, /* Port 1, T1 AFE0 */
+	[1] = 3, /* Port 2, T1 AFE1 */
+	[2] = 5, /* Port 3, T1 AFE3 */
+	[3] = U8_MAX, /* Port 4, SGMII */
+	[4] = U8_MAX, /* Port 5, RGMII 2 */
+	[5] = U8_MAX, /* Port 6, RGMII 1 */
+	[6] = 6, /* Port 7, T1 AFE4 */
+	[7] = 4, /* Port 8, T1 AFE2 */
+};
+
+static const u8 lan9374_phy_addr[] = {
+	[0] = 2, /* Port 1, T1 AFE0 */
+	[1] = 3, /* Port 2, T1 AFE1 */
+	[2] = 5, /* Port 3, T1 AFE3 */
+	[3] = 7, /* Port 4, T1 AFE5 */
+	[4] = U8_MAX, /* Port 5, RGMII 2 */
+	[5] = U8_MAX, /* Port 6, RGMII 1 */
+	[6] = 6, /* Port 7, T1 AFE4 */
+	[7] = 4, /* Port 8, T1 AFE2 */
+};
+
 static int lan937x_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
 	return regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
@@ -30,24 +71,97 @@ static int lan937x_port_cfg(struct ksz_device *dev, int port, int offset,
 				  bits, set ? bits : 0);
 }
 
-static int lan937x_enable_spi_indirect_access(struct ksz_device *dev)
+int lan937x_create_phy_addr_map(struct ksz_device *dev, bool side_mdio)
+{
+	static const u8 *phy_addr_map;
+	u32 strap_val;
+	u8 offset = 0;
+	size_t size;
+	int ret, i;
+
+	if (!side_mdio) {
+		/* simple direct mapping */
+		for (i = 0; i < dev->info->port_cnt; i++)
+			dev->phy_addr_map[i] = i;
+
+		return 0;
+	}
+
+	ret = ksz_read32(dev, REG_SW_CFG_STRAP_VAL, &strap_val);
+	if (ret < 0)
+		return ret;
+
+	if (!(strap_val & SW_CASCADE_ID_CFG) && !(strap_val & SW_VPHY_ADD_CFG))
+		offset = 0;
+	else if (!(strap_val & SW_CASCADE_ID_CFG) && (strap_val & SW_VPHY_ADD_CFG))
+		offset = 7;
+	else if ((strap_val & SW_CASCADE_ID_CFG) && !(strap_val & SW_VPHY_ADD_CFG))
+		offset = 15;
+	else
+		offset = 22;
+
+	switch (dev->info->chip_id) {
+	case LAN9370_CHIP_ID:
+		phy_addr_map = lan9370_phy_addr;
+		size = ARRAY_SIZE(lan9370_phy_addr);
+		break;
+	case LAN9372_CHIP_ID:
+		phy_addr_map = lan9372_phy_addr;
+		size = ARRAY_SIZE(lan9372_phy_addr);
+		break;
+	case LAN9373_CHIP_ID:
+		phy_addr_map = lan9373_phy_addr;
+		size = ARRAY_SIZE(lan9373_phy_addr);
+		break;
+	case LAN9374_CHIP_ID:
+		phy_addr_map = lan9374_phy_addr;
+		size = ARRAY_SIZE(lan9374_phy_addr);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (size < dev->info->port_cnt)
+		return -EINVAL;
+
+	for (i = 0; i < dev->info->port_cnt; i++) {
+		if (phy_addr_map[i] == U8_MAX)
+			dev->phy_addr_map[i] = phy_addr_map[i];
+		else
+			dev->phy_addr_map[i] = phy_addr_map[i] + offset;
+	}
+
+	return 0;
+}
+
+int lan937x_mdio_bus_preinit(struct ksz_device *dev, bool side_mdio)
 {
 	u16 data16;
 	int ret;
 
-	/* Enable Phy access through SPI */
+	/* Unlock access to the PHYs, needed for SPI and side MDIO access */
 	ret = lan937x_cfg(dev, REG_GLOBAL_CTRL_0, SW_PHY_REG_BLOCK, false);
 	if (ret < 0)
-		return ret;
+		goto print_error;
 
-	ret = ksz_read16(dev, REG_VPHY_SPECIAL_CTRL__2, &data16);
-	if (ret < 0)
-		return ret;
+	if (side_mdio)
+		/* Allow access to internal PHYs over MDIO bus */
+		data16 = VPHY_MDIO_INTERNAL_ENABLE;
+	else
+		/* Enable SPI indirect access to address clock domain crossing
+		 * issue
+		 */
+		data16 = VPHY_SPI_INDIRECT_ENABLE;
+
+	ret = ksz_rmw16(dev, REG_VPHY_SPECIAL_CTRL__2,
+			VPHY_SPI_INDIRECT_ENABLE | VPHY_MDIO_INTERNAL_ENABLE,
+			data16);
 
-	/* Allow SPI access */
-	data16 |= VPHY_SPI_INDIRECT_ENABLE;
+print_error:
+	if (ret < 0)
+		dev_err(dev->dev, "failed to enable spi indirect access");
 
-	return ksz_write16(dev, REG_VPHY_SPECIAL_CTRL__2, data16);
+	return ret;
 }
 
 static int lan937x_vphy_ind_addr_wr(struct ksz_device *dev, int addr, int reg)
@@ -363,13 +477,6 @@ int lan937x_setup(struct dsa_switch *ds)
 	struct ksz_device *dev = ds->priv;
 	int ret;
 
-	/* enable Indirect Access from SPI to the VPHY registers */
-	ret = lan937x_enable_spi_indirect_access(dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "failed to enable spi indirect access");
-		return ret;
-	}
-
 	/* The VLAN aware is a global setting. Mixed vlan
 	 * filterings are not supported.
 	 */
diff --git a/drivers/net/dsa/microchip/lan937x_reg.h b/drivers/net/dsa/microchip/lan937x_reg.h
index 2f22a9d01de36..4ec93e421da45 100644
--- a/drivers/net/dsa/microchip/lan937x_reg.h
+++ b/drivers/net/dsa/microchip/lan937x_reg.h
@@ -37,6 +37,10 @@
 #define SW_CLK125_ENB			BIT(1)
 #define SW_CLK25_ENB			BIT(0)
 
+#define REG_SW_CFG_STRAP_VAL		0x0200
+#define SW_CASCADE_ID_CFG		BIT(15)
+#define SW_VPHY_ADD_CFG			BIT(0)
+
 /* 2 - PHY Control */
 #define REG_SW_CFG_STRAP_OVR		0x0214
 #define SW_VPHY_DISABLE			BIT(31)
-- 
2.39.5


