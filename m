Return-Path: <linux-kernel+bounces-357877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B994F997740
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73754283476
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F51DFE2B;
	Wed,  9 Oct 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="Z+L42VEn"
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAEC13A409
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508141; cv=none; b=ZYAOacYMYv283MC+faqbbPxwKsD8A65kGEnYfGUEA/YyA6Eh9VdxRHBOibiI1t0DWWOd6BSUk8ZyFm2WX0KqB7vtFqE2vMLv4/34OjGnr2g9KqsMQfTXtLKzfx1vQhEW5euimHVLcyjDxZaFR9xyoBrqyZgLCTfxhmGDGcIU9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508141; c=relaxed/simple;
	bh=4GAGFNmfPUMbRPPbf3s5liSC0t4/0p0lLBq6/+BH8eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcGVgEvJKph28ozpmV+FmMnH3zOf70WhHkPGtSXvIDoBSiBs1BlJEOF/bkVNzTX+xUy2VXRQQiDQe/pJoBwrIrMbQyIlKhrkZ2P7EhWDE3cGSlYXtCyLKV90KsSMbVb4Rzj56xSZtWEKsW0nGqImuthsw4H+p14XUMz3p02Lx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=Z+L42VEn; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Kz+WQD1c6yjDYCQcqtwueNjgejWZ8hRZEweMwb4+0bY=; b=Z+L42VEn06wPdd4d3uelnNPqWb
	sXlcXsGjglX1Ll888/qV8vpeEZoelh9OEKFbpjjGxRBcjUbflpCPJeCw7VB4SyR9bGjecup5yZxku
	PBsPpfwHXU59gZi3DCuAPKPfKZXoGFHCQKtm7n2xRYtcRv3vjGULcL17yss8nrt3L4+U=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sydJr-000000002pc-1McE;
	Wed, 09 Oct 2024 22:30:03 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH 2/6] misc: keba: Add LAN9252 driver
Date: Wed,  9 Oct 2024 22:29:45 +0200
Message-Id: <20241009202949.20164-3-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241009202949.20164-1-gerhard@engleder-embedded.com>
References: <20241009202949.20164-1-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Do-Run: Yes
X-ACL-Warn: X-W4Y-Internal

From: Gerhard Engleder <eg@keba.com>

KEBA CP500 devices use the LAN9252 controller for EtherCAT
communication. For a stable Ethernet link the PHY registers of the
controller need to be configured correctly. This driver configures these
PHY registers as required.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/Kconfig   |  11 ++
 drivers/misc/keba/Makefile  |   1 +
 drivers/misc/keba/lan9252.c | 359 ++++++++++++++++++++++++++++++++++++
 3 files changed, 371 insertions(+)
 create mode 100644 drivers/misc/keba/lan9252.c

diff --git a/drivers/misc/keba/Kconfig b/drivers/misc/keba/Kconfig
index 5fbcbc2252ac..dc27b902f34e 100644
--- a/drivers/misc/keba/Kconfig
+++ b/drivers/misc/keba/Kconfig
@@ -11,3 +11,14 @@ config KEBA_CP500
 
 	  This driver can also be built as a module. If so, the module will be
 	  called cp500.
+
+config KEBA_LAN9252
+	tristate "KEBA CP500 LAN9252 configuration"
+	depends on SPI
+	depends on KEBA_CP500 || COMPILE_TEST
+	help
+	  This driver is used for updating the configuration of the LAN9252
+	  controller on KEBA CP500 devices.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called lan9252.
diff --git a/drivers/misc/keba/Makefile b/drivers/misc/keba/Makefile
index 0a8b846cda7d..05e9efcad54f 100644
--- a/drivers/misc/keba/Makefile
+++ b/drivers/misc/keba/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_KEBA_CP500)	+= cp500.o
+obj-$(CONFIG_KEBA_LAN9252)	+= lan9252.o
diff --git a/drivers/misc/keba/lan9252.c b/drivers/misc/keba/lan9252.c
new file mode 100644
index 000000000000..d2e734239b70
--- /dev/null
+++ b/drivers/misc/keba/lan9252.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) KEBA Industrial Automation Gmbh 2024
+ *
+ * Driver for LAN9252 on KEBA CP500 devices
+ *
+ * This driver is used for updating the configuration of the LAN9252 controller
+ * on KEBA CP500 devices. The LAN9252 is connected over SPI, which is also named
+ * PDI.
+ */
+
+#include <linux/spi/spi.h>
+#include <linux/mii.h>
+
+/* SPI commands */
+#define LAN9252_SPI_READ	0x3
+#define LAN9252_SPI_WRITE	0x2
+
+struct lan9252_read_cmd {
+	u8 cmd;
+	u8 addr_0;
+	u8 addr_1;
+} __packed;
+
+struct lan9252_write_cmd {
+	u8 cmd;
+	u8 addr_0;
+	u8 addr_1;
+	u32 data;
+} __packed;
+
+/* byte test register */
+#define LAN9252_BYTE_TEST		0x64
+#define   LAN9252_BYTE_TEST_VALUE	0x87654321
+
+/* hardware configuration register */
+#define LAN9252_HW_CFG		0x74
+#define   LAN9252_HW_CFG_READY	0x08000000
+
+/* EtherCAT CSR interface data register */
+#define LAN9252_ECAT_CSR_DATA	0x300
+
+/* EtherCAT CSR interface command register */
+#define LAN9252_ECAT_CSR_CMD	0x304
+#define   LAN9252_ECAT_CSR_BUSY	0x80000000
+#define   LAN9252_ECAT_CSR_READ	0x40000000
+
+/* EtherCAT slave controller MII register */
+#define LAN9252_ESC_MII			0x510
+#define   LAN9252_ESC_MII_BUSY		0x8000
+#define   LAN9252_ESC_MII_CMD_ERR	0x4000
+#define   LAN9252_ESC_MII_READ_ERR	0x2000
+#define   LAN9252_ESC_MII_ERR_MASK	(LAN9252_ESC_MII_CMD_ERR | \
+					 LAN9252_ESC_MII_READ_ERR)
+#define   LAN9252_ESC_MII_WRITE		0x0200
+#define   LAN9252_ESC_MII_READ		0x0100
+
+/* EtherCAT slave controller PHY address register */
+#define LAN9252_ESC_PHY_ADDR		0x512
+
+/* EtherCAT slave controller PHY register address register */
+#define LAN9252_ESC_PHY_REG_ADDR	0x513
+
+/* EtherCAT slave controller PHY data register */
+#define LAN9252_ESC_PHY_DATA		0x514
+
+/* EtherCAT slave controller PDI access state register */
+#define LAN9252_ESC_MII_PDI		0x517
+#define   LAN9252_ESC_MII_ACCESS_PDI	0x01
+#define   LAN9252_ESC_MII_ACCESS_ECAT	0x00
+
+/* PHY address */
+#define PHY_ADDRESS	2
+
+#define SPI_RETRY_COUNT		10
+#define SPI_WAIT_US		100
+#define SPI_CSR_WAIT_US		500
+
+static int lan9252_spi_read(struct spi_device *spi, u16 addr, u32 *data)
+{
+	struct lan9252_read_cmd cmd;
+
+	cmd.cmd = LAN9252_SPI_READ;
+	cmd.addr_0 = (addr >> 8) & 0xFF;
+	cmd.addr_1 = addr & 0xFF;
+
+	return spi_write_then_read(spi, (u8 *)&cmd,
+				   sizeof(struct lan9252_read_cmd),
+				   (u8 *)data, sizeof(u32));
+}
+
+static int lan9252_spi_write(struct spi_device *spi, u16 addr, u32 data)
+{
+	struct lan9252_write_cmd cmd;
+
+	cmd.cmd = LAN9252_SPI_WRITE;
+	cmd.addr_0 = (addr >> 8) & 0xFF;
+	cmd.addr_1 = addr & 0xFF;
+	cmd.data = data;
+
+	return spi_write(spi, (u8 *)&cmd, sizeof(struct lan9252_write_cmd));
+}
+
+static bool lan9252_init(struct spi_device *spi)
+{
+	u32 data;
+	int ret;
+
+	ret = lan9252_spi_read(spi, LAN9252_BYTE_TEST, &data);
+	if (ret || data != LAN9252_BYTE_TEST_VALUE)
+		return false;
+
+	ret = lan9252_spi_read(spi, LAN9252_HW_CFG, &data);
+	if (ret || !(data & LAN9252_HW_CFG_READY))
+		return false;
+
+	return true;
+}
+
+static u8 lan9252_esc_get_size(u16 addr)
+{
+	if (addr == LAN9252_ESC_MII || addr == LAN9252_ESC_PHY_DATA)
+		return 2;
+
+	return 1;
+}
+
+static int lan9252_esc_wait(struct spi_device *spi)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), SPI_WAIT_US);
+	u32 data;
+	int ret;
+
+	/* wait while CSR command is busy */
+	for (;;) {
+		ret = lan9252_spi_read(spi, LAN9252_ECAT_CSR_CMD, &data);
+		if (ret)
+			return ret;
+		if (!(data & LAN9252_ECAT_CSR_BUSY))
+			return 0;
+
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			ret = lan9252_spi_read(spi, LAN9252_ECAT_CSR_CMD, &data);
+			if (ret)
+				return ret;
+			break;
+		}
+	}
+
+	return (!(data & LAN9252_ECAT_CSR_BUSY)) ? 0 : -ETIMEDOUT;
+}
+
+static int lan9252_esc_read(struct spi_device *spi, u16 addr, u32 *data)
+{
+	u32 csr_cmd;
+	u8 size;
+	int ret;
+
+	size = lan9252_esc_get_size(addr);
+	csr_cmd = LAN9252_ECAT_CSR_BUSY | LAN9252_ECAT_CSR_READ;
+	csr_cmd |= (size << 16) | addr;
+	ret = lan9252_spi_write(spi, LAN9252_ECAT_CSR_CMD, csr_cmd);
+	if (ret)
+		return ret;
+
+	ret = lan9252_esc_wait(spi);
+	if (ret)
+		return ret;
+
+	ret = lan9252_spi_read(spi, LAN9252_ECAT_CSR_DATA, data);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int lan9252_esc_write(struct spi_device *spi, u16 addr, u32 data)
+{
+	u32 csr_cmd;
+	u8 size;
+	int ret;
+
+	ret = lan9252_spi_write(spi, LAN9252_ECAT_CSR_DATA, data);
+	if (ret)
+		return ret;
+
+	size = lan9252_esc_get_size(addr);
+	csr_cmd = LAN9252_ECAT_CSR_BUSY;
+	csr_cmd |= (size << 16) | addr;
+	ret = lan9252_spi_write(spi, LAN9252_ECAT_CSR_CMD, csr_cmd);
+	if (ret)
+		return ret;
+
+	ret = lan9252_esc_wait(spi);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int lan9252_access_mii(struct spi_device *spi, bool access)
+{
+	u32 data;
+
+	if (access)
+		data = LAN9252_ESC_MII_ACCESS_PDI;
+	else
+		data = LAN9252_ESC_MII_ACCESS_ECAT;
+
+	return lan9252_esc_write(spi, LAN9252_ESC_MII_PDI, data);
+}
+
+static int lan9252_mii_wait(struct spi_device *spi)
+{
+	ktime_t timeout = ktime_add_us(ktime_get(), SPI_CSR_WAIT_US);
+	u32 data;
+	int ret;
+
+	/* wait while MII control state machine is busy */
+	for (;;) {
+		ret = lan9252_esc_read(spi, LAN9252_ESC_MII, &data);
+		if (ret)
+			return ret;
+		if (data & LAN9252_ESC_MII_ERR_MASK)
+			return -EIO;
+		if (!(data & LAN9252_ESC_MII_BUSY))
+			return 0;
+
+		if (ktime_compare(ktime_get(), timeout) > 0) {
+			ret = lan9252_esc_read(spi, LAN9252_ESC_MII, &data);
+			if (ret)
+				return ret;
+			if (data & LAN9252_ESC_MII_ERR_MASK)
+				return -EIO;
+			break;
+		}
+	}
+
+	return (!(data & LAN9252_ESC_MII_BUSY)) ? 0 : -ETIMEDOUT;
+}
+
+static int lan9252_mii_read(struct spi_device *spi, u8 phy_addr, u8 reg_addr,
+			    u32 *data)
+{
+	int ret;
+
+	ret = lan9252_esc_write(spi, LAN9252_ESC_PHY_ADDR, phy_addr);
+	if (ret)
+		return ret;
+	ret = lan9252_esc_write(spi, LAN9252_ESC_PHY_REG_ADDR, reg_addr);
+	if (ret)
+		return ret;
+
+	ret = lan9252_esc_write(spi, LAN9252_ESC_MII, LAN9252_ESC_MII_READ);
+	if (ret)
+		return ret;
+
+	ret = lan9252_mii_wait(spi);
+	if (ret)
+		return ret;
+
+	return lan9252_esc_read(spi, LAN9252_ESC_PHY_DATA, data);
+}
+
+static int lan9252_mii_write(struct spi_device *spi, u8 phy_addr, u8 reg_addr,
+			     u32 data)
+{
+	int ret;
+
+	ret = lan9252_esc_write(spi, LAN9252_ESC_PHY_ADDR, phy_addr);
+	if (ret)
+		return ret;
+	ret = lan9252_esc_write(spi, LAN9252_ESC_PHY_REG_ADDR, reg_addr);
+	if (ret)
+		return ret;
+	ret = lan9252_esc_write(spi, LAN9252_ESC_PHY_DATA, data);
+	if (ret)
+		return ret;
+
+	ret = lan9252_esc_write(spi, LAN9252_ESC_MII, LAN9252_ESC_MII_WRITE);
+	if (ret)
+		return ret;
+
+	return lan9252_mii_wait(spi);
+}
+
+static int lan9252_probe(struct spi_device *spi)
+{
+	u32 data;
+	int retry = SPI_RETRY_COUNT;
+	int ret;
+
+	/* execute specified initialization sequence */
+	while (retry && !lan9252_init(spi))
+		retry--;
+	if (retry == 0) {
+		dev_err(&spi->dev,
+			"Can't initialize LAN9252 SPI communication!");
+		return ret;
+	}
+
+	/* enable access to MII management for PDI */
+	ret = lan9252_access_mii(spi, true);
+	if (ret) {
+		dev_err(&spi->dev, "Can't enable access to MII management!");
+		return ret;
+	}
+
+	/*
+	 * check PHY configuration and configure if necessary
+	 *	- full duplex
+	 *	- auto negotiation disabled
+	 *	- 100 Mbps
+	 */
+	ret = lan9252_mii_read(spi, PHY_ADDRESS, MII_BMCR, &data);
+	if (ret) {
+		dev_err(&spi->dev, "Can't read LAN9252 configuration!");
+		goto out;
+	}
+	if (!(data & BMCR_FULLDPLX) || (data & BMCR_ANENABLE) ||
+	    !(data & BMCR_SPEED100)) {
+		/*
+		 */
+		data &= ~(BMCR_ANENABLE);
+		data |= (BMCR_FULLDPLX | BMCR_SPEED100);
+		ret = lan9252_mii_write(spi, PHY_ADDRESS, MII_BMCR, data);
+		if (ret)
+			dev_err(&spi->dev,
+				"Can't write LAN9252 configuration!");
+	}
+
+	dev_info(&spi->dev, "LAN9252 PHY configuration");
+
+out:
+	/* disable access to MII management for PDI */
+	lan9252_access_mii(spi, false);
+
+	return ret;
+}
+
+static const struct spi_device_id lan9252_id[] = {
+	{"lan9252"},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, lan9252_id);
+
+static struct spi_driver lan9252_driver = {
+	.driver = {
+		.name	= "lan9252",
+	},
+	.probe		= lan9252_probe,
+	.id_table	= lan9252_id,
+};
+module_spi_driver(lan9252_driver);
+
+MODULE_AUTHOR("Petar Bojanic <boja@keba.com>");
+MODULE_AUTHOR("Gerhard Engleder <eg@keba.com>");
+MODULE_DESCRIPTION("KEBA LAN9252 driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2


