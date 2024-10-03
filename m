Return-Path: <linux-kernel+bounces-348988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD8098EEF8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B3E283929
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21D7194ACD;
	Thu,  3 Oct 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jctzv4rA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FAB17CA1F;
	Thu,  3 Oct 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957864; cv=none; b=LyKPIowVOQhDJSGa61b9b1s53yBAx6LcjTrZAJ+atVhbx9LK5vNkH6IE8hJrWgYQFMPSieJzWUmp5xoOahQRligZTHD7h0YrILMSvRQKEJCh7F/36L1dfE/Dq5yau5SCNo0Rs2t2eYKNucayzaQWgxx2Bg9wI+SW6xgkOifuxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957864; c=relaxed/simple;
	bh=t5gymWfJKU1ixqiZWXX3m/YNB2DjHWDovue9DofdyiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8JcRiDmPDusgikymytaoAXD0Z4LEs0b7OOhZNTkZsdF/E79WB5K6x70/Gl/B6ZnqZQda1SM3ILLrtRzAB+8mJCZFllFgHPl1XrQaXA9Ee04lQ0xOg1aNaVPQ7yvOutJ9Umo6i+5NC2JyTzs65TlT+ZOXi+RrnaSUKzuErDT0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jctzv4rA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727957862; x=1759493862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t5gymWfJKU1ixqiZWXX3m/YNB2DjHWDovue9DofdyiI=;
  b=Jctzv4rAUDTs0mCfah2ZyCpsOUSrD3r0AjzajoiBDo6HfWOEk5LQMQMM
   i4viUuskWwlMWSc7d+GwkWbj8dvN77XSYQxxhUtVjARsLjPGOZCFfgvpR
   MAsIrbZzKj0BaHSZUs3loa1XGd+HVKvT3wBNzKRoBEX6T6Dei0Stwi4ez
   aXcGr9fhN1+B6Mm82tBVaIKziJIvhE6mZqt2lERH3IyekBVd4awTSZRFC
   Jt7H3S+nanE85QDy+3PXIVfa82VeRiOYVEMVCP6DSHZxphJycucw8QlCR
   6SYyNEV2ANHrYzethJoEPiMZlHR2qVG9teFbw657vFtd+1KGSFBcDNSkf
   g==;
X-CSE-ConnectionGUID: 6v+xZDeFT9icJ2a7/IU/AA==
X-CSE-MsgGUID: WIrCXB9lRjOz67tlaEJfag==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31029810"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="31029810"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:17:42 -0700
X-CSE-ConnectionGUID: LJ5cHVhVTn22SQgKYZZKPA==
X-CSE-MsgGUID: foUKneg+RGK6bKrOOKW+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="111786210"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2024 05:17:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7AC06373; Thu, 03 Oct 2024 15:17:39 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] xhci: pci: Use standard pattern for device IDs
Date: Thu,  3 Oct 2024 15:14:45 +0300
Message-ID: <20241003121729.3867216-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241003121729.3867216-1-andriy.shevchenko@linux.intel.com>
References: <20241003121729.3867216-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The definitions of vendor IDs follow the pattern PCI_VENDOR_ID_#vendor,
while device IDs — PCI_DEVICE_ID_#vendor_#device.

Update the ETRON device IDs to follow the above mentioned pattern.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 2c148b143c54..1f7333a5e9a9 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -34,9 +34,9 @@
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
 
-#define PCI_VENDOR_ID_ETRON		0x1b6f
-#define PCI_DEVICE_ID_EJ168		0x7023
-#define PCI_DEVICE_ID_EJ188		0x7052
+#define PCI_VENDOR_ID_ETRON			0x1b6f
+#define PCI_DEVICE_ID_ETRON_EJ168		0x7023
+#define PCI_DEVICE_ID_ETRON_EJ188		0x7052
 
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
 #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
@@ -393,12 +393,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ168) {
+	    pdev->device == PCI_DEVICE_ID_ETRON_EJ168) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188) {
+	    pdev->device == PCI_DEVICE_ID_ETRON_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


