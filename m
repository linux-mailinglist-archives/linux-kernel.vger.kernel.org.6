Return-Path: <linux-kernel+bounces-361744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA01399AC75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703C1289849
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905C1CF5DF;
	Fri, 11 Oct 2024 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="ehH/FlS1"
Received: from mx01lb.world4you.com (mx01lb.world4you.com [81.19.149.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC2E1C9DFD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673994; cv=none; b=P1Inu3FGgqS2i7AhIj86hm6COXQFBKE6VDT7RD/m8o5zUelmnM1MN5FPYtwJ26E4Vo816gc816Wx0da6CL8FnAtlp+A1xsuX0P7JdBTpqdSI3t4DKTfBXWMAYjZWgHa7yYzISaAnLu4LOc2Ii2wmKqbCwNCmGO7lD53x66Mup3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673994; c=relaxed/simple;
	bh=oBVp6xCJ46lhFLoKzzje44//wjdEV2iRH1V8pvZ1rV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnE9N3GoEh1KPzkxQT3FVbKTnrf6K5gEoN88E6HmIz9h0IaDziYb3ZuZt9Bt3ZKrtS+9p5wOdgJ38ubJOOJ5EqaJHJ6xVZwKbhn395bIbr+RrcJCRWVULT8KwJcDMtSYffJcW5zwAzY40lTciwLAvKE29bjNdeZcajT8CYywUUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=ehH/FlS1; arc=none smtp.client-ip=81.19.149.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z5YHM9D01vA222n9g5hi9rEul/bQJQMaAl6cSatx4Xo=; b=ehH/FlS1/61iZMaNxU+ajnO5It
	knD6N6gATbZt0KpHAvtupmLBghzyubFYYwoKkTCjeYUOH3LRi07hWFh2w6gyBWhnst2bxp/9VU5hZ
	uvpFAnroErqqblCAOz93yQWKuRzEGjQUycrfdbv/ts8dATcIi4iNVVJnPq6dG/h2By5U=;
Received: from 88-117-56-173.adsl.highway.telekom.at ([88.117.56.173] helo=hornet.engleder.at)
	by mx01lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1szL4Y-0000000039T-3KtU;
	Fri, 11 Oct 2024 21:13:11 +0200
From: Gerhard Engleder <gerhard@engleder-embedded.com>
To: linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Gerhard Engleder <eg@keba.com>
Subject: [PATCH v2 8/8] misc: keba: Add UART devices
Date: Fri, 11 Oct 2024 21:12:57 +0200
Message-Id: <20241011191257.19702-9-gerhard@engleder-embedded.com>
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

Add support for the UART auxiliary devices. This enables access to up to
3 different UARTs, which are implemented in the FPGA.

Signed-off-by: Gerhard Engleder <eg@keba.com>
---
 drivers/misc/keba/cp500.c | 104 ++++++++++++++++++++++++++++++++++++++
 include/linux/misc/keba.h |  12 +++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/misc/keba/cp500.c b/drivers/misc/keba/cp500.c
index afd4d7c06cee..255d3022dae8 100644
--- a/drivers/misc/keba/cp500.c
+++ b/drivers/misc/keba/cp500.c
@@ -46,6 +46,9 @@
 
 /* MSIX */
 #define CP500_AXI_MSIX		3
+#define CP500_RFB_UART_MSIX	4
+#define CP500_DEBUG_UART_MSIX	5
+#define CP500_SI1_UART_MSIX	6
 #define CP500_NUM_MSIX		8
 #define CP500_NUM_MSIX_NO_MMI	2
 #define CP500_NUM_MSIX_NO_AXI	3
@@ -75,6 +78,7 @@
 struct cp500_dev_info {
 	off_t offset;
 	size_t size;
+	unsigned int msix;
 };
 
 struct cp500_devs {
@@ -83,6 +87,9 @@ struct cp500_devs {
 	struct cp500_dev_info i2c;
 	struct cp500_dev_info fan;
 	struct cp500_dev_info batt;
+	struct cp500_dev_info uart0_rfb;
+	struct cp500_dev_info uart1_dbg;
+	struct cp500_dev_info uart2_si1;
 };
 
 /* list of devices within FPGA of CP035 family (CP035, CP056, CP057) */
@@ -92,6 +99,8 @@ static struct cp500_devs cp035_devices = {
 	.i2c       = { 0x4000, SZ_4K },
 	.fan       = { 0x9000, SZ_4K },
 	.batt      = { 0xA000, SZ_4K },
+	.uart0_rfb = { 0xB000, SZ_4K, CP500_RFB_UART_MSIX },
+	.uart2_si1 = { 0xD000, SZ_4K, CP500_SI1_UART_MSIX },
 };
 
 /* list of devices within FPGA of CP505 family (CP503, CP505, CP507) */
@@ -101,6 +110,8 @@ static struct cp500_devs cp505_devices = {
 	.i2c       = { 0x5000, SZ_4K },
 	.fan       = { 0x9000, SZ_4K },
 	.batt      = { 0xA000, SZ_4K },
+	.uart0_rfb = { 0xB000, SZ_4K, CP500_RFB_UART_MSIX },
+	.uart2_si1 = { 0xD000, SZ_4K, CP500_SI1_UART_MSIX },
 };
 
 /* list of devices within FPGA of CP520 family (CP520, CP530) */
@@ -110,6 +121,8 @@ static struct cp500_devs cp520_devices = {
 	.i2c       = { 0x5000, SZ_4K },
 	.fan       = { 0x8000, SZ_4K },
 	.batt      = { 0x9000, SZ_4K },
+	.uart0_rfb = { 0xC000, SZ_4K, CP500_RFB_UART_MSIX },
+	.uart1_dbg = { 0xD000, SZ_4K, CP500_DEBUG_UART_MSIX },
 };
 
 struct cp500_nvmem {
@@ -135,6 +148,9 @@ struct cp500 {
 	struct keba_i2c_auxdev *i2c;
 	struct keba_fan_auxdev *fan;
 	struct keba_batt_auxdev *batt;
+	struct keba_uart_auxdev *uart0_rfb;
+	struct keba_uart_auxdev *uart1_dbg;
+	struct keba_uart_auxdev *uart2_si1;
 
 	/* ECM EtherCAT BAR */
 	resource_size_t ecm_hwbase;
@@ -510,6 +526,55 @@ static int cp500_register_batt(struct cp500 *cp500)
 	return 0;
 }
 
+static void cp500_uart_release(struct device *dev)
+{
+	struct keba_uart_auxdev *uart =
+		container_of(dev, struct keba_uart_auxdev, auxdev.dev);
+
+	kfree(uart);
+}
+
+static int cp500_register_uart(struct cp500 *cp500,
+			       struct keba_uart_auxdev **uart, const char *name,
+			       struct cp500_dev_info *info, unsigned int irq)
+{
+	int ret;
+
+	*uart = kzalloc(sizeof(**uart), GFP_KERNEL);
+	if (!*uart)
+		return -ENOMEM;
+
+	(*uart)->auxdev.name = name;
+	(*uart)->auxdev.id = 0;
+	(*uart)->auxdev.dev.release = cp500_uart_release;
+	(*uart)->auxdev.dev.parent = &cp500->pci_dev->dev;
+	(*uart)->io = (struct resource) {
+		 /* UART register area */
+		 .start = (resource_size_t) cp500->sys_hwbase + info->offset,
+		 .end   = (resource_size_t) cp500->sys_hwbase + info->offset +
+			  info->size - 1,
+		 .flags = IORESOURCE_MEM,
+	};
+	(*uart)->irq = irq;
+
+	ret = auxiliary_device_init(&(*uart)->auxdev);
+	if (ret) {
+		kfree(*uart);
+		*uart = NULL;
+
+		return ret;
+	}
+	ret = __auxiliary_device_add(&(*uart)->auxdev, "keba");
+	if (ret) {
+		auxiliary_device_uninit(&(*uart)->auxdev);
+		*uart = NULL;
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
@@ -668,6 +733,33 @@ static void cp500_register_auxiliary_devs(struct cp500 *cp500)
 			dev_warn(dev, "Failed to register fan!\n");
 	if (cp500_register_batt(cp500))
 		dev_warn(dev, "Failed to register battery!\n");
+	if (cp500->devs->uart0_rfb.size &&
+	    cp500->devs->uart0_rfb.msix < cp500->msix_num) {
+		int irq = pci_irq_vector(cp500->pci_dev,
+					 cp500->devs->uart0_rfb.msix);
+
+		if (cp500_register_uart(cp500, &cp500->uart0_rfb, "rs485-uart",
+					&cp500->devs->uart0_rfb, irq))
+			dev_warn(dev, "Failed to register RFB UART!\n");
+	}
+	if (cp500->devs->uart1_dbg.size &&
+	    cp500->devs->uart1_dbg.msix < cp500->msix_num) {
+		int irq = pci_irq_vector(cp500->pci_dev,
+					 cp500->devs->uart1_dbg.msix);
+
+		if (cp500_register_uart(cp500, &cp500->uart1_dbg, "rs232-uart",
+					&cp500->devs->uart1_dbg, irq))
+			dev_warn(dev, "Failed to register debug UART!\n");
+	}
+	if (cp500->devs->uart2_si1.size &&
+	    cp500->devs->uart2_si1.msix < cp500->msix_num) {
+		int irq = pci_irq_vector(cp500->pci_dev,
+					 cp500->devs->uart2_si1.msix);
+
+		if (cp500_register_uart(cp500, &cp500->uart2_si1, "uart",
+					&cp500->devs->uart2_si1, irq))
+			dev_warn(dev, "Failed to register SI1 UART!\n");
+	}
 }
 
 static void cp500_unregister_dev(struct auxiliary_device *auxdev)
@@ -694,6 +786,18 @@ static void cp500_unregister_auxiliary_devs(struct cp500 *cp500)
 		cp500_unregister_dev(&cp500->batt->auxdev);
 		cp500->batt = NULL;
 	}
+	if (cp500->uart0_rfb) {
+		cp500_unregister_dev(&cp500->uart0_rfb->auxdev);
+		cp500->uart0_rfb = NULL;
+	}
+	if (cp500->uart1_dbg) {
+		cp500_unregister_dev(&cp500->uart1_dbg->auxdev);
+		cp500->uart1_dbg = NULL;
+	}
+	if (cp500->uart2_si1) {
+		cp500_unregister_dev(&cp500->uart2_si1->auxdev);
+		cp500->uart2_si1 = NULL;
+	}
 }
 
 static irqreturn_t cp500_axi_handler(int irq, void *dev)
diff --git a/include/linux/misc/keba.h b/include/linux/misc/keba.h
index ca52716f8437..a81d6fa70851 100644
--- a/include/linux/misc/keba.h
+++ b/include/linux/misc/keba.h
@@ -57,4 +57,16 @@ struct keba_batt_auxdev {
 	struct resource io;
 };
 
+/**
+ * struct keba_uart_auxdev - KEBA UART auxiliary device
+ * @auxdev: auxiliary device object
+ * @io: address range of UART controller IO memory
+ * @irq: number of UART controller interrupt
+ */
+struct keba_uart_auxdev {
+	struct auxiliary_device auxdev;
+	struct resource io;
+	unsigned int irq;
+};
+
 #endif /* _LINUX_MISC_KEBA_H */
-- 
2.39.2


