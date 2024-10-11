Return-Path: <linux-kernel+bounces-361818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 352E299AD5A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D29FB2708E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210051D14E1;
	Fri, 11 Oct 2024 20:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="DF9YIywj"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D71D1300
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676981; cv=none; b=R42uFUEnIhJvS/V6gedL3kpwcKSsEzdz3EheP1PeMKUwBYqFLx/C0WiQac5bWw7+MtpOpE00s2s93kCMJOaNRnI1eTZceaFAslECsBL0BxaqWbRE+bkFPwmt8Cy8wVLgjSWbUAyxWnN7Y2jlEP93paqXlZbuoNEG2iaKCPsPQd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676981; c=relaxed/simple;
	bh=fXr42gKXes1KmAoKmx/JlkMJFZGlzs6bR1Nefux2S7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVmIKpLPb1ro4B7zT72PjCDKpwanPVS36Eb0zua2BHitOGWmf7D29UDkzyZXSnB8tAoojxp9qwImRi2ieApts20z6Ewn4GqwXVIp3wMZdoys5q7Hp/lbEO5N7CsyWscjYA44p3CXUYxPKL3hqGKr/2CSan33ET5ETqrhrb/nhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=DF9YIywj; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jfPO5c43H2tWIIBxZfAMbiDUrWRQQsXA86hvuylfUek=; b=DF9YIywjgawTHYwn7ynzr0DfpM
	xYyN/oA+5uUKxu6fytHacaUYfanJ00HYrgxuCETXAk7EQyA3ieCKuoXjhN21YQOfndHEW2Q8TDYey
	kIgJj0fUAVj7GjuTeNwLhgqXYnjlnrRrmMmqtY64kJPcI/mXAd7cS8vD6CbmZbWFTlSw=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4R-0000000039T-3rww;
	Fri, 11 Oct 2024 21:13:04 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v2 3/8] misc: keba: Add SPI controller device
Date: Fri, 11 Oct 2024 21:12:52 +0200
Message-Id: <20241011191257.19702-4-gerhard@engleder-embedded.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241011191257.19702-1-gerhard@engleder-embedded.com>
References: <20241011191257.19702-1-gerhard@engleder-embedded.com>
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

Add support for the SPI controller auxiliary device. This enables access
to the SPI flash of the FPGA and some other SPI devices.

The actual list of SPI devices is detected by reading some bits out of
the previously registered I2C EEPROM.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 219 +++++++++++++++++++++++++++++++++++---
 include/linux/misc/keba.h |  15 +++
 2 files changed, 219 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index 1eee130c3a7f..7cebf2929390 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -12,7 +12,11 @@
 #include <linux/i2c.h>
 #include <linux/misc/keba.h>
 #include <linux/module.h>
+#include <linux/mtd/partitions.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/pci.h>
+#include <linux/spi/flash.h>
+#include <linux/spi/spi.h>
 
 #define CP500 "cp500"
 
@@ -43,6 +47,16 @@
 
 /* EEPROM */
 #define CP500_HW_CPU_EEPROM_NAME	"cp500_cpu_eeprom"
+#define CP500_EEPROM_DA_OFFSET		0x016F
+#define CP500_EEPROM_DA_ESC_TYPE_MASK	0x01
+#define CP500_EEPROM_ESC_LAN9252	0x00
+#define CP500_EEPROM_ESC_ET1100		0x01
+
+/* SPI flash running at full speed */
+#define CP500_FLASH_HZ		(33 * 1000 * 1000)
+
+/* LAN9252 */
+#define CP500_LAN9252_HZ	(10 * 1000 * 1000)
 
 #define CP500_IS_CP035(dev)	((dev)->pci_dev->device == PCI_DEVICE_ID_KEBA_CP035)
 #define CP500_IS_CP505(dev)	((dev)->pci_dev->device == PCI_DEVICE_ID_KEBA_CP505)
@@ -55,25 +69,29 @@ struct cp500_dev_info {
 
 struct cp500_devs {
 	struct cp500_dev_info startup;
+	struct cp500_dev_info spi;
 	struct cp500_dev_info i2c;
 };
 
 /* list of devices within FPGA of CP035 family (CP035, CP056, CP057) */
 static struct cp500_devs cp035_devices = {
-	.startup   = { 0x0000, SZ_4K },
-	.i2c       = { 0x4000, SZ_4K },
+	.startup = { 0x0000, SZ_4K },
+	.spi	 = { 0x1000, SZ_4K },
+	.i2c     = { 0x4000, SZ_4K },
 };
 
 /* list of devices within FPGA of CP505 family (CP503, CP505, CP507) */
 static struct cp500_devs cp505_devices = {
-	.startup   = { 0x0000, SZ_4K },
-	.i2c       = { 0x5000, SZ_4K },
+	.startup = { 0x0000, SZ_4K },
+	.spi     = { 0x4000, SZ_4K },
+	.i2c     = { 0x5000, SZ_4K },
 };
 
 /* list of devices within FPGA of CP520 family (CP520, CP530) */
 static struct cp500_devs cp520_devices = {
-	.startup     = { 0x0000, SZ_4K },
-	.i2c         = { 0x5000, SZ_4K },
+	.startup = { 0x0000, SZ_4K },
+	.spi     = { 0x4000, SZ_4K },
+	.i2c     = { 0x5000, SZ_4K },
 };
 
 struct cp500 {
@@ -85,9 +103,12 @@ struct cp500 {
 		int minor;
 		int build;
 	} version;
+	struct notifier_block nvmem_notifier;
+	atomic_t nvmem_notified;
 
 	/* system FPGA BAR */
 	resource_size_t sys_hwbase;
+	struct keba_spi_auxdev *spi;
 	struct keba_i2c_auxdev *i2c;
 
 	/* ECM EtherCAT BAR */
@@ -97,6 +118,7 @@ struct cp500 {
 };
 
 /* I2C devices */
+#define CP500_EEPROM_ADDR	0x50
 static struct i2c_board_info cp500_i2c_info[] = {
 	{	/* temperature sensor */
 		I2C_BOARD_INFO("emc1403", 0x4c),
@@ -107,30 +129,67 @@ static struct i2c_board_info cp500_i2c_info[] = {
 		 * CP505 family: bridge board
 		 * CP520 family: carrier board
 		 */
-		I2C_BOARD_INFO("24c32", 0x50),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR),
 		.dev_name = CP500_HW_CPU_EEPROM_NAME,
 	},
 	{	/* interface board EEPROM */
-		I2C_BOARD_INFO("24c32", 0x51),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 1),
 	},
 	{	/*
 		 * EEPROM (optional)
 		 * CP505 family: CPU board
 		 * CP520 family: MMI board
 		 */
-		I2C_BOARD_INFO("24c32", 0x52),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 2),
 	},
 	{	/* extension module 0 EEPROM (optional) */
-		I2C_BOARD_INFO("24c32", 0x53),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 3),
 	},
 	{	/* extension module 1 EEPROM (optional) */
-		I2C_BOARD_INFO("24c32", 0x54),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 4),
 	},
 	{	/* extension module 2 EEPROM (optional) */
-		I2C_BOARD_INFO("24c32", 0x55),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 5),
 	},
 	{	/* extension module 3 EEPROM (optional) */
-		I2C_BOARD_INFO("24c32", 0x56),
+		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 6),
+	}
+};
+
+/* SPI devices */
+static struct mtd_partition cp500_partitions[] = {
+	{
+		.name       = "system-flash-parts",
+		.size       = MTDPART_SIZ_FULL,
+		.offset     = 0,
+		.mask_flags = 0
+	}
+};
+static const struct flash_platform_data cp500_w25q32 = {
+	.type     = "w25q32",
+	.name     = "system-flash",
+	.parts    = cp500_partitions,
+	.nr_parts = ARRAY_SIZE(cp500_partitions),
+};
+static const struct flash_platform_data cp500_m25p16 = {
+	.type     = "m25p16",
+	.name     = "system-flash",
+	.parts    = cp500_partitions,
+	.nr_parts = ARRAY_SIZE(cp500_partitions),
+};
+static struct spi_board_info cp500_spi_info[] = {
+	{       /* system FPGA configuration bitstream flash */
+		.modalias      = "m25p80",
+		.platform_data = &cp500_m25p16,
+		.max_speed_hz  = CP500_FLASH_HZ,
+		.chip_select   = 0,
+		.mode          = SPI_MODE_3,
+	}, {    /* LAN9252 EtherCAT slave controller */
+		.modalias      = "lan9252",
+		.platform_data = NULL,
+		.max_speed_hz  = CP500_LAN9252_HZ,
+		.chip_select   = 1,
+		.mode          = SPI_MODE_3,
 	}
 };
 
@@ -269,6 +328,125 @@ static int cp500_register_i2c(struct cp500 *cp500)
 	return 0;
 }
 
+static void cp500_spi_release(struct device *dev)
+{
+	struct keba_spi_auxdev *spi =
+		container_of(dev, struct keba_spi_auxdev, auxdev.dev);
+
+	kfree(spi);
+}
+
+static int cp500_register_spi(struct cp500 *cp500, u8 esc_type)
+{
+	int info_size;
+	int ret;
+
+	cp500->spi = kzalloc(sizeof(*cp500->spi), GFP_KERNEL);
+	if (!cp500->spi)
+		return -ENOMEM;
+
+	if (CP500_IS_CP035(cp500))
+		cp500_spi_info[0].platform_data = &cp500_w25q32;
+	if (esc_type == CP500_EEPROM_ESC_LAN9252)
+		info_size = ARRAY_SIZE(cp500_spi_info);
+	else
+		info_size = ARRAY_SIZE(cp500_spi_info) - 1;
+
+	cp500->spi->auxdev.name = "spi";
+	cp500->spi->auxdev.id = 0;
+	cp500->spi->auxdev.dev.release = cp500_spi_release;
+	cp500->spi->auxdev.dev.parent = &cp500->pci_dev->dev;
+	cp500->spi->io = (struct resource) {
+		 /* SPI register area */
+		 .start = (resource_size_t) cp500->sys_hwbase +
+			  cp500->devs->spi.offset,
+		 .end   = (resource_size_t) cp500->sys_hwbase +
+			  cp500->devs->spi.offset +
+			  cp500->devs->spi.size - 1,
+		 .flags = IORESOURCE_MEM,
+	};
+	cp500->spi->info_size = info_size;
+	cp500->spi->info = cp500_spi_info;
+
+	ret = auxiliary_device_init(&cp500->spi->auxdev);
+	if (ret) {
+		kfree(cp500->spi);
+		cp500->spi = NULL;
+
+		return ret;
+	}
+	ret = __auxiliary_device_add(&cp500->spi->auxdev, "keba");
+	if (ret) {
+		auxiliary_device_uninit(&cp500->spi->auxdev);
+		cp500->spi = NULL;
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cp500_nvmem_match(struct device *dev, const void *data)
+{
+	const struct cp500 *cp500 = data;
+	struct i2c_client *client;
+
+	/* match only CPU EEPROM below the cp500 device */
+	dev = dev->parent;
+	client = i2c_verify_client(dev);
+	if (!client || client->addr != CP500_EEPROM_ADDR)
+		return 0;
+	while ((dev = dev->parent))
+		if (dev == &cp500->pci_dev->dev)
+			return 1;
+
+	return 0;
+}
+
+static int cp500_nvmem(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	struct nvmem_device *nvmem;
+	struct cp500 *cp500;
+	struct device *dev;
+	int notified;
+	u8 esc_type;
+	int ret;
+
+	if (action != NVMEM_ADD)
+		return NOTIFY_DONE;
+	cp500 = container_of(nb, struct cp500, nvmem_notifier);
+	dev = &cp500->pci_dev->dev;
+
+	/* process CPU EEPROM content only once */
+	notified = atomic_read(&cp500->nvmem_notified);
+	if (notified)
+		return NOTIFY_DONE;
+	nvmem = nvmem_device_find(cp500, cp500_nvmem_match);
+	if (IS_ERR_OR_NULL(nvmem))
+		return NOTIFY_DONE;
+	if (!atomic_try_cmpxchg_relaxed(&cp500->nvmem_notified, &notified, 1)) {
+		nvmem_device_put(nvmem);
+
+		return NOTIFY_DONE;
+	}
+
+	ret = nvmem_device_read(nvmem, CP500_EEPROM_DA_OFFSET, sizeof(esc_type),
+				(void *)&esc_type);
+	nvmem_device_put(nvmem);
+	if (ret != sizeof(esc_type)) {
+		dev_warn(dev, "Failed to read device assembly!\n");
+
+		return NOTIFY_DONE;
+	}
+	esc_type &= CP500_EEPROM_DA_ESC_TYPE_MASK;
+
+	if (cp500_register_spi(cp500, esc_type))
+		dev_warn(dev, "Failed to register SPI!\n");
+
+	return NOTIFY_OK;
+}
+
 static void cp500_register_auxiliary_devs(struct cp500 *cp500)
 {
 	struct device *dev = &cp500->pci_dev->dev;
@@ -285,7 +463,10 @@ static void cp500_unregister_dev(struct auxiliary_device *auxdev)
 
 static void cp500_unregister_auxiliary_devs(struct cp500 *cp500)
 {
-
+	if (cp500->spi) {
+		cp500_unregister_dev(&cp500->spi->auxdev);
+		cp500->spi = NULL;
+	}
 	if (cp500->i2c) {
 		cp500_unregister_dev(&cp500->i2c->auxdev);
 		cp500->i2c = NULL;
@@ -396,15 +577,21 @@ static int cp500_probe(struct pci_dev *pci_dev, const struct pci_device_id *id)
 
 	pci_set_drvdata(pci_dev, cp500);
 
+	cp500->nvmem_notifier.notifier_call = cp500_nvmem;
+	ret = nvmem_register_notifier(&cp500->nvmem_notifier);
+	if (ret != 0)
+		goto out_free_irq;
 
 	ret = cp500_enable(cp500);
 	if (ret != 0)
-		goto out_free_irq;
+		goto out_unregister_nvmem;
 
 	cp500_register_auxiliary_devs(cp500);
 
 	return 0;
 
+out_unregister_nvmem:
+	nvmem_unregister_notifier(&cp500->nvmem_notifier);
 out_free_irq:
 	pci_free_irq_vectors(pci_dev);
 out_disable:
@@ -422,6 +609,8 @@ static void cp500_remove(struct pci_dev *pci_dev)
 
 	cp500_disable(cp500);
 
+	nvmem_unregister_notifier(&cp500->nvmem_notifier);
+
 	pci_set_drvdata(pci_dev, 0);
 
 	pci_free_irq_vectors(pci_dev);
diff --git a/include/linux/misc/keba.h b/include/linux/misc/keba.h
index 323b31a847c5..1bd5409c6f6f 100644
--- a/include/linux/misc/keba.h
+++ b/include/linux/misc/keba.h
@@ -7,6 +7,7 @@
 #include <linux/auxiliary_bus.h>
 
 struct i2c_board_info;
+struct spi_board_info;
 
 /**
  * struct keba_i2c_auxdev - KEBA I2C auxiliary device
@@ -22,4 +23,18 @@ struct keba_i2c_auxdev {
 	struct i2c_board_info *info;
 };
 
+/**
+ * struct keba_spi_auxdev - KEBA SPI auxiliary device
+ * @auxdev: auxiliary device object
+ * @io: address range of SPI controller IO memory
+ * @info_size: number of SPI devices to be probed
+ * @info: SPI devices to be probed
+ */
+struct keba_spi_auxdev {
+	struct auxiliary_device auxdev;
+	struct resource io;
+	int info_size;
+	struct spi_board_info *info;
+};
+
 #endif /* _LINUX_MISC_KEBA_H */
-- 
2.39.2


