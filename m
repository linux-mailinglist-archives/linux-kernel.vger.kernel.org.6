Return-Path: <linux-kernel+bounces-328248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AA97810A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03B01C216C0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C691DB93D;
	Fri, 13 Sep 2024 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="epLnpAXS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266401DB55E;
	Fri, 13 Sep 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233692; cv=none; b=Aq55pDL7fguvmarb4h1Q7mRXHXnY4ez2gUz7PuyxF0JlwUsuGFM08Q0dRXligIrChJ7GthhoPgvfmJWJ2ROBPKgOo9RsXVWFSH4a1hOIyep2l5iirftAfNWxpeFa/H3AJy4+bxvN3QKesJBEXM+84/hMr0XI1ReKmCyejw86vBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233692; c=relaxed/simple;
	bh=mia+xUTvFMRfYLyU8IqRV/oKPzsms8mLPQ0ZR+xMAL4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxwkH2RRLS4Hgrbfq2XRefEduxAxGzx74A+sEJLzixqNy/FXLXjtSirXda5xbWVvo1dVaFx6OgESgzQTrTFy9woDuGMrdyh7CB97b6xWkYNwTpPqu6WhmeNZPyIoqmingATclOWZE6lY9RdlcsqOxobtvAAtz8KSpg7qi/YFfl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=epLnpAXS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726233690; x=1757769690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mia+xUTvFMRfYLyU8IqRV/oKPzsms8mLPQ0ZR+xMAL4=;
  b=epLnpAXSQzDtB66DL7u+Sr7e8K5EmcHuG813QhqjKBJLH6Arcj0vDD5M
   CNsYerRlR4f2YEs4c6nySug0yJICnD7dH5ZHHLQ4MMN9x6H26VHM1G8N5
   Q0LOZYIxks7Fkj8m6QLUFwER+h14eIzZw2Iwvs0I8AYpPHdX1C6f8KC3h
   y4uN8LMosntgBTUtR9CbGRFZX5kxROPIPU++Vy9QYYqKqHmy1/SR5kWyR
   3g9OwEnH90kx08Is/z6JYVfnROaNeKNcAaOIRyEhm02qIL5jRXMUs1zBU
   kC9AhOpYkxmDrboLcUcpI+ZnlNJCYyvP92v3e6WyXVb+nf3DRFGjK3HKz
   A==;
X-CSE-ConnectionGUID: qErX7ou3T1aR2FX5EBlVMQ==
X-CSE-MsgGUID: Exw+8nhBTXqX7iPah0QWSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="24621326"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="24621326"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 06:21:29 -0700
X-CSE-ConnectionGUID: 57iOqf/FSqmfbkS7Dtk5Ng==
X-CSE-MsgGUID: UCuaNriNQ2GfqOA/LYpPLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="67992724"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 13 Sep 2024 06:21:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 44334334; Fri, 13 Sep 2024 16:21:26 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] sub: cdns2: Use predefined PCI vendor ID constant
Date: Fri, 13 Sep 2024 16:21:25 +0300
Message-ID: <20240913132125.3630860-1-andriy.shevchenko@linux.intel.com>
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
 drivers/usb/gadget/udc/cdns2/cdns2-pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
index 50c3d0974d9b..b1a8f772467c 100644
--- a/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
+++ b/drivers/usb/gadget/udc/cdns2/cdns2-pci.c
@@ -15,8 +15,7 @@
 #include "cdns2-gadget.h"
 
 #define PCI_DRIVER_NAME		"cdns-pci-usbhs"
-#define CDNS_VENDOR_ID		0x17cd
-#define CDNS_DEVICE_ID		0x0120
+#define PCI_DEVICE_ID_CDNS_USB2	0x0120
 #define PCI_BAR_DEV		0
 #define PCI_DEV_FN_DEVICE	0
 
@@ -114,8 +113,8 @@ static const struct dev_pm_ops cdns2_pci_pm_ops = {
 };
 
 static const struct pci_device_id cdns2_pci_ids[] = {
-	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  PCI_CLASS_SERIAL_USB_DEVICE, PCI_ANY_ID },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USB2),
+	  .class = PCI_CLASS_SERIAL_USB_DEVICE },
 	{ 0, }
 };
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


