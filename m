Return-Path: <linux-kernel+bounces-357815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D348D997675
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 158252816B9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4671E22FF;
	Wed,  9 Oct 2024 20:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="bvUNqKAH"
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F741714A4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728505814; cv=none; b=ZsCdc7BH0UdFd875ww3tvGUsnmFpbxcNKo2pe+9RqdnRRAHgSdZczqKKvKtTtgbrc7c1lhd0H/ozAsLoCoay5Rl4DEnmJajP6rL4u1dEI8Y25dL6AZ7HAcOdxMH6rhAUpBTVxZremRF2ouNB0HNVBorO9Mk967/hB6qir+gJ0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728505814; c=relaxed/simple;
	bh=9d627FDTOIkVX66beegSDFYO5t9zTrTs4nuv5e8i32s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k5k/aunI21UQ1wkr2mbKHn6TGWvLCMdrhwYeK5cAwDOFGbyh1wYWRT6KegvbDRau7NAVH25eFp6lblJ4Cq7W1Z++cbNtvNnbBV/tbDuUzhwgroXs8lfrBqIs1s1U0JfBiYq8FaY3EF74jobHQvehlNGRl0hJVJ48+JuCqDVgyl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=bvUNqKAH; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lfm5KoQta1gf45olzsRtGjm8PknulBKLLAsOuXP43tM=; b=bvUNqKAHk+2LS2tfMdawjo+fFU
	e8VVtEM0KzhlfDaCqlauFUWWHxrDfrQy3ReBh8QpQ8c32/yOKwkvWDyrkDLC+2odD45yOj+y89n6O
	PiFJ5MIXbDVBkv4oTlpLlVa4picu9tBsbBmw4Hy865CQv9qxw4tCBe4miFijaXgnLrzQ=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1sydJv-000000002pc-0wci;
	Wed, 09 Oct 2024 22:30:07 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH 5/6] misc: keba: Add battery device
Date: Wed,  9 Oct 2024 22:29:48 +0200
Message-Id: <20241009202949.20164-6-gerhard@engleder-embedded.com>
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

Add support for the battery auxiliary device. This enables monitoring of
the battery.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 59 +++++++++++++++++++++++++++++++++++++++
 include/linux/misc/keba.h | 10 +++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index ae3ed1cece32..afd4d7c06cee 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -82,6 +82,7 @@ struct cp500_devs {
 	struct cp500_dev_info spi;
 	struct cp500_dev_info i2c;
 	struct cp500_dev_info fan;
+	struct cp500_dev_info batt;
 };
 
 /* list of devices within FPGA of CP035 family (CP035, CP056, CP057) */
@@ -90,6 +91,7 @@ static struct cp500_devs cp035_devices = {
 	.spi       = { 0x1000, SZ_4K },
 	.i2c       = { 0x4000, SZ_4K },
 	.fan       = { 0x9000, SZ_4K },
+	.batt      = { 0xA000, SZ_4K },
 };
 
 /* list of devices within FPGA of CP505 family (CP503, CP505, CP507) */
@@ -98,6 +100,7 @@ static struct cp500_devs cp505_devices = {
 	.spi       = { 0x4000, SZ_4K },
 	.i2c       = { 0x5000, SZ_4K },
 	.fan       = { 0x9000, SZ_4K },
+	.batt      = { 0xA000, SZ_4K },
 };
 
 /* list of devices within FPGA of CP520 family (CP520, CP530) */
@@ -106,6 +109,7 @@ static struct cp500_devs cp520_devices = {
 	.spi       = { 0x4000, SZ_4K },
 	.i2c       = { 0x5000, SZ_4K },
 	.fan       = { 0x8000, SZ_4K },
+	.batt      = { 0x9000, SZ_4K },
 };
 
 struct cp500_nvmem {
@@ -130,6 +134,7 @@ struct cp500 {
 	struct keba_spi_auxdev *spi;
 	struct keba_i2c_auxdev *i2c;
 	struct keba_fan_auxdev *fan;
+	struct keba_batt_auxdev *batt;
 
 	/* ECM EtherCAT BAR */
 	resource_size_t ecm_hwbase;
@@ -457,6 +462,54 @@ static int cp500_register_fan(struct cp500 *cp500)
 	return 0;
 }
 
+static void cp500_batt_release(struct device *dev)
+{
+	struct keba_batt_auxdev *fan =
+		container_of(dev, struct keba_batt_auxdev, auxdev.dev);
+
+	kfree(fan);
+}
+
+static int cp500_register_batt(struct cp500 *cp500)
+{
+	int ret;
+
+	cp500->batt = kzalloc(sizeof(*cp500->batt), GFP_KERNEL);
+	if (!cp500->batt)
+		return -ENOMEM;
+
+	cp500->batt->auxdev.name = "batt";
+	cp500->batt->auxdev.id = 0;
+	cp500->batt->auxdev.dev.release = cp500_batt_release;
+	cp500->batt->auxdev.dev.parent = &cp500->pci_dev->dev;
+	cp500->batt->io = (struct resource) {
+		 /* battery register area */
+		 .start = (resource_size_t) cp500->sys_hwbase +
+			  cp500->devs->batt.offset,
+		 .end   = (resource_size_t) cp500->sys_hwbase +
+			  cp500->devs->batt.offset +
+			  cp500->devs->batt.size - 1,
+		 .flags = IORESOURCE_MEM,
+	};
+
+	ret = auxiliary_device_init(&cp500->batt->auxdev);
+	if (ret) {
+		kfree(cp500->batt);
+		cp500->batt = NULL;
+
+		return ret;
+	}
+	ret = __auxiliary_device_add(&cp500->batt->auxdev, "keba");
+	if (ret) {
+		auxiliary_device_uninit(&cp500->batt->auxdev);
+		cp500->batt = NULL;
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
@@ -613,6 +666,8 @@ static void cp500_register_auxiliary_devs(struct cp500 *cp500)
 	if (present & CP500_PRESENT_FAN0)
 		if (cp500_register_fan(cp500))
 			dev_warn(dev, "Failed to register fan!\n");
+	if (cp500_register_batt(cp500))
+		dev_warn(dev, "Failed to register battery!\n");
 }
 
 static void cp500_unregister_dev(struct auxiliary_device *auxdev)
@@ -635,6 +690,10 @@ static void cp500_unregister_auxiliary_devs(struct cp500 *cp500)
 		cp500_unregister_dev(&cp500->fan->auxdev);
 		cp500->fan = NULL;
 	}
+	if (cp500->batt) {
+		cp500_unregister_dev(&cp500->batt->auxdev);
+		cp500->batt = NULL;
+	}
 }
 
 static irqreturn_t cp500_axi_handler(int irq, void *dev)
diff --git a/include/linux/misc/keba.h b/include/linux/misc/keba.h
index 451777acc262..ca52716f8437 100644
--- a/include/linux/misc/keba.h
+++ b/include/linux/misc/keba.h
@@ -47,4 +47,14 @@ struct keba_fan_auxdev {
 	struct resource io;
 };
 
+/**
+ * struct keba_batt_auxdev - KEBA battery auxiliary device
+ * @auxdev: auxiliary device object
+ * @io: address range of battery controller IO memory
+ */
+struct keba_batt_auxdev {
+	struct auxiliary_device auxdev;
+	struct resource io;
+};
+
 #endif /* _LINUX_MISC_KEBA_H */
-- 
2.39.2


