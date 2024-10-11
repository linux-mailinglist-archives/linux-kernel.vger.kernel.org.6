Return-Path: <linux-kernel+bounces-361813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1797799AD4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E9C1C21B67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795241D0F74;
	Fri, 11 Oct 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="T2/hR7PW"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C341D0F46
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676849; cv=none; b=qLqBMqpgHjZkJi2U4t6kSU1+/wOb2vzxMxZw7bkUrt11I4DTKNE+mGjhR2B41P3mZcT07AQTD9ol7T8EbMIn2K30Xg2H1MQ/ZiZ4z6iw/qGBrOEGCjwYBBLDTbrhwS++RwSztWkRsKqyV8LInXuDkq7FCeH8RhUMriHOS7Wc9rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676849; c=relaxed/simple;
	bh=d2sNCfav+nTxuA6wt8xfOE24xC0xQX6o4T+3lnRBK+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TWGNXiJfBnEar5/zUIrrDaHIPEHBwH8Hsq41WENS/gSXyPVYHKhnWM5ofUx9p0dUQJgNZAz1uBGlupH/11ONzBozn7CGcd/poILp4G5s2dQdve5l5Jyepc0i9RfBbA5oFrTThjy2yC0sDPh0YI0VCQhhtuF4oLuXLwOd/Q/Ujws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=T2/hR7PW; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u4yjrgdQaJF97lO8xIY17x9JYCnO6tJwOpp0Opp/mJo=; b=T2/hR7PWwk0IP8js+EugzMbclO
	ZomCC6Z8ZoZRGbWtrMFYw7B/ihALu46G5rHI1gEn1SoTOMf9RG97facI/fHUATxAjUZFLITKOX3SJ
	i5I2Bw4Q7+mvXYxnEP0TtgkKoicinVh49Uz4Iqo1hD/AtsjT5zOwplKzo0MJ8/KSlEOs=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4U-0000000039T-07JL;
	Fri, 11 Oct 2024 21:13:07 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v2 5/8] misc: keba: Support EEPROM sections as separate devices
Date: Fri, 11 Oct 2024 21:12:54 +0200
Message-Id: <20241011191257.19702-6-gerhard@engleder-embedded.com>
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

The main EEPROM of KEBA CP500 devices is divided into two sections. One
section for type label data like device name, order number, serial
number and so on. The second section is reserved for arbitrary data
stored by the user.

The two sections have a defined range. The first 3 kB for the type label
and the remaining 1 kB for user data. The type label is written during
production and can fill up the whole 3 kB. Thus, the range is fixed and
cannot be changed dynamically.

The two sections cannot be presented as NVMEM cells. A NVMEM cell is
always read and written at once, because the data presented to the user
can differ from the data stored in the physical NVMEM cell. Thus, NVMEM
cells would lead to reading 3 kB for every type label access, even if
only the device name is read. So performance would suffer. But it is
also an indication that NVMEM cells are designed for small data cells
within NVMEM devices.

Register separate NVMEM devices for every section. This enables safe
access to every section. Also different access rights are then possible.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 105 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index 7cebf2929390..3cf99eaf45c4 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/mtd/partitions.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
 #include <linux/pci.h>
 #include <linux/spi/flash.h>
 #include <linux/spi/spi.h>
@@ -46,11 +47,16 @@
 #define CP500_NUM_MSIX_NO_AXI	3
 
 /* EEPROM */
-#define CP500_HW_CPU_EEPROM_NAME	"cp500_cpu_eeprom"
 #define CP500_EEPROM_DA_OFFSET		0x016F
 #define CP500_EEPROM_DA_ESC_TYPE_MASK	0x01
 #define CP500_EEPROM_ESC_LAN9252	0x00
 #define CP500_EEPROM_ESC_ET1100		0x01
+#define CP500_EEPROM_CPU_NAME		"cpu_eeprom"
+#define CP500_EEPROM_CPU_OFFSET		0
+#define CP500_EEPROM_CPU_SIZE		3072
+#define CP500_EEPROM_USER_NAME		"user_eeprom"
+#define CP500_EEPROM_USER_OFFSET	3072
+#define CP500_EEPROM_USER_SIZE		1024
 
 /* SPI flash running at full speed */
 #define CP500_FLASH_HZ		(33 * 1000 * 1000)
@@ -94,6 +100,11 @@ static struct cp500_devs cp520_devices = {
 	.i2c     = { 0x5000, SZ_4K },
 };
 
+struct cp500_nvmem {
+	struct nvmem_device *nvmem;
+	unsigned int offset;
+};
+
 struct cp500 {
 	struct pci_dev *pci_dev;
 	struct cp500_devs *devs;
@@ -114,6 +125,10 @@ struct cp500 {
 	/* ECM EtherCAT BAR */
 	resource_size_t ecm_hwbase;
 
+	/* NVMEM devices */
+	struct cp500_nvmem nvmem_cpu;
+	struct cp500_nvmem nvmem_user;
+
 	void __iomem *system_startup_addr;
 };
 
@@ -130,7 +145,6 @@ static struct i2c_board_info cp500_i2c_info[] = {
 		 * CP520 family: carrier board
 		 */
 		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR),
-		.dev_name = CP500_HW_CPU_EEPROM_NAME,
 	},
 	{	/* interface board EEPROM */
 		I2C_BOARD_INFO("24c32", CP500_EEPROM_ADDR + 1),
@@ -386,6 +400,77 @@ static int cp500_register_spi(struct cp500 *cp500, u8 esc_type)
 	return 0;
 }
 
+static int cp500_nvmem_read(void *priv, unsigned int offset, void *val,
+			    size_t bytes)
+{
+	struct cp500_nvmem *nvmem = priv;
+	int ret;
+
+	ret = nvmem_device_read(nvmem->nvmem, nvmem->offset + offset, bytes,
+				val);
+	if (ret != bytes)
+		return ret;
+
+	return 0;
+}
+
+static int cp500_nvmem_write(void *priv, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct cp500_nvmem *nvmem = priv;
+	int ret;
+
+	ret = nvmem_device_write(nvmem->nvmem, nvmem->offset + offset, bytes,
+				 val);
+	if (ret != bytes)
+		return ret;
+
+	return 0;
+}
+
+static int cp500_nvmem_register(struct cp500 *cp500, struct nvmem_device *nvmem)
+{
+	struct device *dev = &cp500->pci_dev->dev;
+	struct nvmem_config nvmem_config = {};
+	struct nvmem_device *tmp;
+
+	/*
+	 * The main EEPROM of CP500 devices is logically split into two EEPROMs.
+	 * The first logical EEPROM with 3 kB contains the type label which is
+	 * programmed during production of the device. The second logical EEPROM
+	 * with 1 kB is not programmed during production and can be used for
+	 * arbitrary user data.
+	 */
+
+	nvmem_config.dev = dev;
+	nvmem_config.owner = THIS_MODULE;
+	nvmem_config.id = NVMEM_DEVID_NONE;
+	nvmem_config.type = NVMEM_TYPE_EEPROM;
+	nvmem_config.root_only = true;
+	nvmem_config.reg_read = cp500_nvmem_read;
+	nvmem_config.reg_write = cp500_nvmem_write;
+
+	cp500->nvmem_cpu.nvmem = nvmem;
+	cp500->nvmem_cpu.offset = CP500_EEPROM_CPU_OFFSET;
+	nvmem_config.name = CP500_EEPROM_CPU_NAME;
+	nvmem_config.size = CP500_EEPROM_CPU_SIZE;
+	nvmem_config.priv = &cp500->nvmem_cpu;
+	tmp = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	cp500->nvmem_user.nvmem = nvmem;
+	cp500->nvmem_user.offset = CP500_EEPROM_USER_OFFSET;
+	nvmem_config.name = CP500_EEPROM_USER_NAME;
+	nvmem_config.size = CP500_EEPROM_USER_SIZE;
+	nvmem_config.priv = &cp500->nvmem_user;
+	tmp = devm_nvmem_register(dev, &nvmem_config);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+
+	return 0;
+}
+
 static int cp500_nvmem_match(struct device *dev, const void *data)
 {
 	const struct cp500 *cp500 = data;
@@ -403,6 +488,13 @@ static int cp500_nvmem_match(struct device *dev, const void *data)
 	return 0;
 }
 
+static void cp500_devm_nvmem_put(void *data)
+{
+	struct nvmem_device *nvmem = data;
+
+	nvmem_device_put(nvmem);
+}
+
 static int cp500_nvmem(struct notifier_block *nb, unsigned long action,
 		       void *data)
 {
@@ -431,9 +523,16 @@ static int cp500_nvmem(struct notifier_block *nb, unsigned long action,
 		return NOTIFY_DONE;
 	}
 
+	ret = devm_add_action_or_reset(dev, cp500_devm_nvmem_put, nvmem);
+	if (ret)
+		return ret;
+
+	ret = cp500_nvmem_register(cp500, nvmem);
+	if (ret)
+		return ret;
+
 	ret = nvmem_device_read(nvmem, CP500_EEPROM_DA_OFFSET, sizeof(esc_type),
 				(void *)&esc_type);
-	nvmem_device_put(nvmem);
 	if (ret != sizeof(esc_type)) {
 		dev_warn(dev, "Failed to read device assembly!\n");
 
-- 
2.39.2


