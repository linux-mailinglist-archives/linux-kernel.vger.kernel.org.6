Return-Path: <linux-kernel+bounces-390655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDA59B7CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D532823FE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA721A0718;
	Thu, 31 Oct 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjVlcBXA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AED519FA8D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730384895; cv=none; b=Y4qikFKW/JptmIk/Uad8Qbg424qzgK+gaKOeYOGvSC3RAQ4VI5947czCaP/gefWWwZmrPGIYc/W5F2kZ9fQvySIM/QL+xgj1lhBhChWi7VJ7M9qIqFVEgdgYfvSDL7ldOG0Gp1StuXmcWSO3D5yeb4n248KWNe2yYjjou+JJ4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730384895; c=relaxed/simple;
	bh=ytB9c0BlsFwuRzDm4GXO90VCf/39d1DD8MX9rkGQmuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VoYTxLgBi27IwQbtw+sZU8NY6QIFa3m/QWPRmRrK3GMsTNW6vVntdyJg90+oZucFZIEFq776LTy7pdqZ6oo2efAynUxgxe1M5KozvfILfxFD/lmn0kpMJ+Sh003r9qI1dgXWR7C6uMHWDCelcoYVeiV/ENPcxRMe8aqUBKO5qF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjVlcBXA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730384892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t7mctBwJJJPRkiO4SNlUV4iOdni5CGZau6d/JO9gTeE=;
	b=gjVlcBXA1DXF+J6TeyKan4gFUD05+VLyu9j9EbhqwVGA1NmTAX1q93X8gjmZ7xf6Ewfm5a
	b28dwLUX+QKZqWdUsbvTryYsO2bCh8c+G1/R86aMRu3uRmm14/CylG+ve8JWUb76f5DmAS
	o9bOys25FndMUsa4XxvF/e6O6UHre0w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-qymh99sIPmevSD4hpz6XGw-1; Thu,
 31 Oct 2024 10:28:09 -0400
X-MC-Unique: qymh99sIPmevSD4hpz6XGw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E88631955F33;
	Thu, 31 Oct 2024 14:28:07 +0000 (UTC)
Received: from desnesn-thinkpadp16vgen1.rmtbr.csb (unknown [10.96.134.178])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCA621956052;
	Thu, 31 Oct 2024 14:28:05 +0000 (UTC)
From: Desnes Nunes <desnesn@redhat.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: kai.heng.feng@canonical.com,
	ulf.hansson@linaro.org,
	linux-kernel@vger.kernel.org,
	Desnes Nunes <desnesn@redhat.com>
Subject: [PATCH] misc: rtsx: Cleanup on DRV_NAME cardreader variables
Date: Thu, 31 Oct 2024 11:28:00 -0300
Message-ID: <20241031142801.1141680-1-desnesn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The rtsx_pci_ms memstick driver has been dropped, thus there is no more
need for DRV_NAME_RTSX_PCI_MS variable. Additionally, this also stand-
arizes DRV_NAME variables on alcor_pci and rtsx_usb drivers.

Fixes: d0f459259c13 ("memstick: rtsx_pci_ms: Remove Realtek PCI memstick driver")
Signed-off-by: Desnes Nunes <desnesn@redhat.com>
---
 drivers/misc/cardreader/alcor_pci.c | 2 --
 drivers/misc/cardreader/rtsx_usb.c  | 6 +++---
 include/linux/alcor_pci.h           | 1 +
 include/linux/rtsx_common.h         | 1 -
 include/linux/rtsx_usb.h            | 4 ++++
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/cardreader/alcor_pci.c b/drivers/misc/cardreader/alcor_pci.c
index 0142c4bf4f42..a5549eaf52d0 100644
--- a/drivers/misc/cardreader/alcor_pci.c
+++ b/drivers/misc/cardreader/alcor_pci.c
@@ -17,8 +17,6 @@
 
 #include <linux/alcor_pci.h>
 
-#define DRV_NAME_ALCOR_PCI			"alcor_pci"
-
 static DEFINE_IDA(alcor_pci_idr);
 
 static struct mfd_cell alcor_pci_cells[] = {
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index f150d8769f19..77b0490a1b38 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -20,11 +20,11 @@ MODULE_PARM_DESC(polling_pipe, "polling pipe (0: ctl, 1: bulk)");
 
 static const struct mfd_cell rtsx_usb_cells[] = {
 	[RTSX_USB_SD_CARD] = {
-		.name = "rtsx_usb_sdmmc",
+		.name = DRV_NAME_RTSX_USB_SDMMC,
 		.pdata_size = 0,
 	},
 	[RTSX_USB_MS_CARD] = {
-		.name = "rtsx_usb_ms",
+		.name = DRV_NAME_RTSX_USB_MS,
 		.pdata_size = 0,
 	},
 };
@@ -780,7 +780,7 @@ static const struct usb_device_id rtsx_usb_usb_ids[] = {
 MODULE_DEVICE_TABLE(usb, rtsx_usb_usb_ids);
 
 static struct usb_driver rtsx_usb_driver = {
-	.name			= "rtsx_usb",
+	.name			= DRV_NAME_RTSX_USB,
 	.probe			= rtsx_usb_probe,
 	.disconnect		= rtsx_usb_disconnect,
 	.suspend		= rtsx_usb_suspend,
diff --git a/include/linux/alcor_pci.h b/include/linux/alcor_pci.h
index c4a0b23846d8..dcb1d37dabc2 100644
--- a/include/linux/alcor_pci.h
+++ b/include/linux/alcor_pci.h
@@ -11,6 +11,7 @@
 #define ALCOR_SD_CARD 0
 #define ALCOR_MS_CARD 1
 
+#define DRV_NAME_ALCOR_PCI			"alcor_pci"
 #define DRV_NAME_ALCOR_PCI_SDMMC		"alcor_sdmmc"
 #define DRV_NAME_ALCOR_PCI_MS			"alcor_ms"
 
diff --git a/include/linux/rtsx_common.h b/include/linux/rtsx_common.h
index bf290ad14c57..da9c8c6b5d50 100644
--- a/include/linux/rtsx_common.h
+++ b/include/linux/rtsx_common.h
@@ -12,7 +12,6 @@
 
 #define DRV_NAME_RTSX_PCI		"rtsx_pci"
 #define DRV_NAME_RTSX_PCI_SDMMC		"rtsx_pci_sdmmc"
-#define DRV_NAME_RTSX_PCI_MS		"rtsx_pci_ms"
 
 #define RTSX_REG_PAIR(addr, val)	(((u32)(addr) << 16) | (u8)(val))
 
diff --git a/include/linux/rtsx_usb.h b/include/linux/rtsx_usb.h
index 3247ed8e9ff0..f267a06c6b1e 100644
--- a/include/linux/rtsx_usb.h
+++ b/include/linux/rtsx_usb.h
@@ -12,6 +12,10 @@
 
 #include <linux/usb.h>
 
+#define DRV_NAME_RTSX_USB		"rtsx_usb"
+#define DRV_NAME_RTSX_USB_SDMMC		"rtsx_usb_sdmmc"
+#define DRV_NAME_RTSX_USB_MS		"rtsx_usb_ms"
+
 /* related module names */
 #define RTSX_USB_SD_CARD	0
 #define RTSX_USB_MS_CARD	1
-- 
2.46.2


