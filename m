Return-Path: <linux-kernel+bounces-328236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAD89780E6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38C828831F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6361DB94A;
	Fri, 13 Sep 2024 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8FcLT/3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188AB1DA60D;
	Fri, 13 Sep 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233436; cv=none; b=jun/XRvBMXsWuLKSBngUAUwXo0K/gREGXH+PogfIDalVC30IRj/f1y3WBqIqFhPgPq8FUQFQRjVlBohRjWJxY/+8xsnVfk9DsYqROGJFXT3fpH9sNK1BdWjMlvgchM4Q7oSPsCkx5tjM39+3NoH7XbYDUKy+WFUMuw3U2SV76WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233436; c=relaxed/simple;
	bh=WAXVpK+7sxIxdcJ9yg+Y2jjMtTYNd/8zv3dZlHJG9GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MBCUIoZ1Lc96Wf9hNxTpb2o3Toxb+idN85RtoUnTHuqcFHGeeXazIjIspJXCokqEGnPfmQ2KuEOm0b/maZoIrLhxKc4S8SonSBtKVpl+NpGsPUkq90Ym46eY29Vdjofd3YPdzgeaSKD6e9ohW1Dn89ycCsrisz83ahHdN8tdv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8FcLT/3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726233435; x=1757769435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WAXVpK+7sxIxdcJ9yg+Y2jjMtTYNd/8zv3dZlHJG9GM=;
  b=n8FcLT/3nJ6V23gEFVS412Lg6gvWZI9Cqb9iPRz3AEeo+81ANZMIO+Q+
   zMgJDqQzmUZm3AvhuMpKNmNXkCk0sqrKHyqguPQr709mcTGpQozkp0LlH
   7qqzOSjtqO6DyxvEARlFXXYb8SWU4JkFu0302T0xc+bNI/yxjcYL7aReJ
   bYKMzwM6kECmrZIWaiIo8vHfJEBXpsxNd/B07RtaLfiY0fpKzXdvecM7Q
   8NTnpQHy4MsW2oxzLtlhK5hDjfFrvOCjU0O7PAoa3oRdTG4eonzgCVlEy
   jPcbl4x8cgyTAEASbV8Ekdp0UR9U0/FN59Df+t83wZxpaz+iclLEIRzYD
   Q==;
X-CSE-ConnectionGUID: DUo6gbYXS06Gc1XPu7oHfA==
X-CSE-MsgGUID: cPTYc//RSwOzGOq3n1ZcmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="42641504"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="42641504"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 06:17:14 -0700
X-CSE-ConnectionGUID: dziZXulpSlSU7ExhoiFwqg==
X-CSE-MsgGUID: LmyxrNs0RiegilQU+Dlb2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="73054158"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 13 Sep 2024 06:17:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 21483334; Fri, 13 Sep 2024 16:17:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] sub: cdns3: Use predefined PCI vendor ID constant
Date: Fri, 13 Sep 2024 16:17:10 +0300
Message-ID: <20240913131710.3630560-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI vendor ID for Cadence is defined in pci_ids.h. Use it.
While at it, move to PCI_DEVICE() macro and usual pattern for
PCI class and device IDs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/cdns3/cdns3-pci-wrap.c |  5 ++---
 drivers/usb/cdns3/cdnsp-pci.c      | 29 +++++++++++++++--------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-pci-wrap.c b/drivers/usb/cdns3/cdns3-pci-wrap.c
index 1f6320d98a76..591d149de8f3 100644
--- a/drivers/usb/cdns3/cdns3-pci-wrap.c
+++ b/drivers/usb/cdns3/cdns3-pci-wrap.c
@@ -37,8 +37,7 @@ struct cdns3_wrap {
 #define PCI_DRIVER_NAME		"cdns3-pci-usbss"
 #define PLAT_DRIVER_NAME	"cdns-usb3"
 
-#define CDNS_VENDOR_ID		0x17cd
-#define CDNS_DEVICE_ID		0x0100
+#define PCI_DEVICE_ID_CDNS_USB3	0x0100
 
 static struct pci_dev *cdns3_get_second_fun(struct pci_dev *pdev)
 {
@@ -190,7 +189,7 @@ static void cdns3_pci_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id cdns3_pci_ids[] = {
-	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
+	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USB3) },
 	{ 0, }
 };
 
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 225540fc81ba..2d05368a6745 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -28,10 +28,11 @@
 #define PCI_DRIVER_NAME		"cdns-pci-usbssp"
 #define PLAT_DRIVER_NAME	"cdns-usbssp"
 
-#define CDNS_VENDOR_ID		0x17cd
-#define CDNS_DEVICE_ID		0x0200
-#define CDNS_DRD_ID		0x0100
-#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
+#define PCI_DEVICE_ID_CDNS_USB3		0x0100
+#define PCI_DEVICE_ID_CDNS_UDC		0x0200
+
+#define PCI_CLASS_SERIAL_USB_CDNS_USB3	(PCI_CLASS_SERIAL_USB << 8 | 0x80)
+#define PCI_CLASS_SERIAL_USB_CDNS_UDC	PCI_CLASS_SERIAL_USB_DEVICE
 
 static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 {
@@ -40,10 +41,10 @@ static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
 	 * Platform has two function. The fist keeps resources for
 	 * Host/Device while the secon keeps resources for DRD/OTG.
 	 */
-	if (pdev->device == CDNS_DEVICE_ID)
-		return  pci_get_device(pdev->vendor, CDNS_DRD_ID, NULL);
-	else if (pdev->device == CDNS_DRD_ID)
-		return pci_get_device(pdev->vendor, CDNS_DEVICE_ID, NULL);
+	if (pdev->device == PCI_DEVICE_ID_CDNS_UDC)
+		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_USB3, NULL);
+	if (pdev->device == PCI_DEVICE_ID_CDNS_USB3)
+		return pci_get_device(pdev->vendor, PCI_DEVICE_ID_CDNS_UDC, NULL);
 
 	return NULL;
 }
@@ -220,12 +221,12 @@ static const struct dev_pm_ops cdnsp_pci_pm_ops = {
 };
 
 static const struct pci_device_id cdnsp_pci_ids[] = {
-	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_SERIAL_USB_DEVICE, PCI_ANY_ID },
-	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  CDNS_DRD_IF, PCI_ANY_ID },
-	{ PCI_VENDOR_ID_CDNS, CDNS_DRD_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  CDNS_DRD_IF, PCI_ANY_ID },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
+	  .class = PCI_CLASS_SERIAL_USB_CDNS_UDC },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_UDC),
+	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB3),
+	  .class = PCI_CLASS_SERIAL_USB_CDNS_USB3 },
 	{ 0, }
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


