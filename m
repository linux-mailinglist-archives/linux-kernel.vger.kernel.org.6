Return-Path: <linux-kernel+bounces-361742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09299AC73
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2113B27E68
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59F1C9EAF;
	Fri, 11 Oct 2024 19:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="mZPe9z7O"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBDF19F49F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673992; cv=none; b=Jab/Gi5+Z/wY50SDipkSBetB/DQGnNfrv+4U11VmOYKGhqfbvUFFwmxVkKT26JhWZafcqn683UB+ZPUE6eBnwAYStMRs6haxJoqZCaRixYZSdtGNh6s0InSokzPG+JUUtZc3xY0yB4Ruhn1j/o/oqa4AXhxwr2SCoCeD8KJDcv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673992; c=relaxed/simple;
	bh=xR4sur8STC0wLQxhuyWYlwsSz4HbVC3KFWZ0Q79HE9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK615+7YAaJv732KHz+1Pws6nyGNmzIBo/A/GPasvHKHk+VDnWAcgCvpgRgA95NV596kNtne4ac17YLB/3o2LhxtXn8OQ2cXE4T+qDKpRlpw2/SX8FKdWkX4uqhHgB5Lrm3PDDuStJP6C3mQfxBn5lYtFFvnsa4XWvFuxbz+vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=mZPe9z7O; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BBjkiwbvKjgDMiC2y9fkDU85s2dm10o08sOLbxl1400=; b=mZPe9z7OHmzaQu3nRZ8EebkMnX
	q8/pKo+cBbDcbxNfTKIR3+83kImtn0RspqBHlmf1AbZ2auphdK4co1uwAO5nfLgVgqKMsY7sIV2sj
	VEIgD00eqn79inw2jYE8XQrmn4Om0CYkj5u3pcEiFrNaZXzTyWZNbDobzNjv61kXYeTE=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4W-0000000039T-1tIy;
	Fri, 11 Oct 2024 21:13:08 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v2 6/8] misc: keba: Add fan device
Date: Fri, 11 Oct 2024 21:12:55 +0200
Message-Id: <20241011191257.19702-7-gerhard@engleder-embedded.com>
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

Add support for the fan auxiliary device. This enables monitoring of the
fan.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 83 ++++++++++++++++++++++++++++++++++-----
 include/linux/misc/keba.h | 10 +++++
 2 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index 3cf99eaf45c4..ae3ed1cece32 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -32,6 +32,7 @@
 /* BAR 0 registers */
 #define CP500_VERSION_REG	0x00
 #define CP500_RECONFIG_REG	0x11	/* upper 8-bits of STARTUP register */
+#define CP500_PRESENT_REG	0x20
 #define CP500_AXI_REG		0x40
 
 /* Bits in BUILD_REG */
@@ -40,6 +41,9 @@
 /* Bits in RECONFIG_REG */
 #define CP500_RECFG_REQ		0x01	/* reconfigure FPGA on next reset */
 
+/* Bits in PRESENT_REG */
+#define CP500_PRESENT_FAN0	0x01
+
 /* MSIX */
 #define CP500_AXI_MSIX		3
 #define CP500_NUM_MSIX		8
@@ -77,27 +81,31 @@ struct cp500_devs {
 	struct cp500_dev_info startup;
 	struct cp500_dev_info spi;
 	struct cp500_dev_info i2c;
+	struct cp500_dev_info fan;
 };
 
 /* list of devices within FPGA of CP035 family (CP035, CP056, CP057) */
 static struct cp500_devs cp035_devices = {
-	.startup = { 0x0000, SZ_4K },
-	.spi	 = { 0x1000, SZ_4K },
-	.i2c     = { 0x4000, SZ_4K },
+	.startup   = { 0x0000, SZ_4K },
+	.spi       = { 0x1000, SZ_4K },
+	.i2c       = { 0x4000, SZ_4K },
+	.fan       = { 0x9000, SZ_4K },
 };
 
 /* list of devices within FPGA of CP505 family (CP503, CP505, CP507) */
 static struct cp500_devs cp505_devices = {
-	.startup = { 0x0000, SZ_4K },
-	.spi     = { 0x4000, SZ_4K },
-	.i2c     = { 0x5000, SZ_4K },
+	.startup   = { 0x0000, SZ_4K },
+	.spi       = { 0x4000, SZ_4K },
+	.i2c       = { 0x5000, SZ_4K },
+	.fan       = { 0x9000, SZ_4K },
 };
 
 /* list of devices within FPGA of CP520 family (CP520, CP530) */
 static struct cp500_devs cp520_devices = {
-	.startup = { 0x0000, SZ_4K },
-	.spi     = { 0x4000, SZ_4K },
-	.i2c     = { 0x5000, SZ_4K },
+	.startup   = { 0x0000, SZ_4K },
+	.spi       = { 0x4000, SZ_4K },
+	.i2c       = { 0x5000, SZ_4K },
+	.fan       = { 0x8000, SZ_4K },
 };
 
 struct cp500_nvmem {
@@ -121,6 +129,7 @@ struct cp500 {
 	resource_size_t sys_hwbase;
 	struct keba_spi_auxdev *spi;
 	struct keba_i2c_auxdev *i2c;
+	struct keba_fan_auxdev *fan;
 
 	/* ECM EtherCAT BAR */
 	resource_size_t ecm_hwbase;
@@ -400,6 +409,54 @@ static int cp500_register_spi(struct cp500 *cp500, u8 esc_type)
 	return 0;
 }
 
+static void cp500_fan_release(struct device *dev)
+{
+	struct keba_fan_auxdev *fan =
+		container_of(dev, struct keba_fan_auxdev, auxdev.dev);
+
+	kfree(fan);
+}
+
+static int cp500_register_fan(struct cp500 *cp500)
+{
+	int ret;
+
+	cp500->fan = kzalloc(sizeof(*cp500->fan), GFP_KERNEL);
+	if (!cp500->fan)
+		return -ENOMEM;
+
+	cp500->fan->auxdev.name = "fan";
+	cp500->fan->auxdev.id = 0;
+	cp500->fan->auxdev.dev.release = cp500_fan_release;
+	cp500->fan->auxdev.dev.parent = &cp500->pci_dev->dev;
+	cp500->fan->io = (struct resource) {
+		 /* fan register area */
+		 .start = (resource_size_t) cp500->sys_hwbase +
+			  cp500->devs->fan.offset,
+		 .end   = (resource_size_t) cp500->sys_hwbase +
+			  cp500->devs->fan.offset +
+			  cp500->devs->fan.size - 1,
+		 .flags = IORESOURCE_MEM,
+	};
+
+	ret = auxiliary_device_init(&cp500->fan->auxdev);
+	if (ret) {
+		kfree(cp500->fan);
+		cp500->fan = NULL;
+
+		return ret;
+	}
+	ret = __auxiliary_device_add(&cp500->fan->auxdev, "keba");
+	if (ret) {
+		auxiliary_device_uninit(&cp500->fan->auxdev);
+		cp500->fan = NULL;
+
+		return ret;
+	}
+
+	return 0;
+}
+
 static int cp500_nvmem_read(void *priv, unsigned int offset, void *val,
 			    size_t bytes)
 {
@@ -549,9 +606,13 @@ static int cp500_nvmem(struct notifier_block *nb, unsigned long action,
 static void cp500_register_auxiliary_devs(struct cp500 *cp500)
 {
 	struct device *dev = &cp500->pci_dev->dev;
+	u8 present = ioread8(cp500->system_startup_addr + CP500_PRESENT_REG);
 
 	if (cp500_register_i2c(cp500))
 		dev_warn(dev, "Failed to register I2C!\n");
+	if (present & CP500_PRESENT_FAN0)
+		if (cp500_register_fan(cp500))
+			dev_warn(dev, "Failed to register fan!\n");
 }
 
 static void cp500_unregister_dev(struct auxiliary_device *auxdev)
@@ -570,6 +631,10 @@ static void cp500_unregister_auxiliary_devs(struct cp500 *cp500)
 		cp500_unregister_dev(&cp500->i2c->auxdev);
 		cp500->i2c = NULL;
 	}
+	if (cp500->fan) {
+		cp500_unregister_dev(&cp500->fan->auxdev);
+		cp500->fan = NULL;
+	}
 }
 
 static irqreturn_t cp500_axi_handler(int irq, void *dev)
diff --git a/include/linux/misc/keba.h b/include/linux/misc/keba.h
index 1bd5409c6f6f..451777acc262 100644
--- a/include/linux/misc/keba.h
+++ b/include/linux/misc/keba.h
@@ -37,4 +37,14 @@ struct keba_spi_auxdev {
 	struct spi_board_info *info;
 };
 
+/**
+ * struct keba_fan_auxdev - KEBA fan auxiliary device
+ * @auxdev: auxiliary device object
+ * @io: address range of fan controller IO memory
+ */
+struct keba_fan_auxdev {
+	struct auxiliary_device auxdev;
+	struct resource io;
+};
+
 #endif /* _LINUX_MISC_KEBA_H */
-- 
2.39.2


