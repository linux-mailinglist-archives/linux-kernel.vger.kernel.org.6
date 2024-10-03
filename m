Return-Path: <linux-kernel+bounces-348987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E698EEF6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D885228494D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7A3184118;
	Thu,  3 Oct 2024 12:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDyX5NFA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560D176AD0;
	Thu,  3 Oct 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957863; cv=none; b=hXrjtkQR4dHqk23f7spdx7QjCaTSx8jnm+66us1yXLaouFsKgAKba0fjok1o5x4Vf7wMeCp2J8jvJXjSvFSfM7pjl5oFexF68MLXw5urx2hRrW5o9mtH+tF0185jZywos+r8wYecxyF7lN/Qqkp9KMKMf2WK87zrKzBMpY3lANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957863; c=relaxed/simple;
	bh=0GfcwRhMqlrIWD0p/2ugXnoonC3s6GLJ5qcjY8YjoUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xzt66btDqobRIvBdSMRTgeaT008JbKU91Moyc6fRHKu7KLgL/epTZyDsDcPqTWmSfjkP3u7vwWNplL7VDx5z41LPAEt4FZidChyv7jn1ZqsNj20ZedriW7PSBS1dLc4n+yCBeQHTzmmGlLj+UrVdf3W5feHUZfuvk2vVjI3+/98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDyX5NFA; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727957861; x=1759493861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0GfcwRhMqlrIWD0p/2ugXnoonC3s6GLJ5qcjY8YjoUY=;
  b=iDyX5NFAr77NUVwpXKUp217nhUZwDdAxRLmIcIoMGaaPOqu2hR4wNb3q
   TNhkYYiUcu3sEXWMAPL3U6tiLPUu6xQQVuSGutx8WvtGWfytE05M9hbjg
   r7qAhKC6wAYZC+TsRbGj3Hjn3aV3neQMlEz/yt4f4l2sPx0pNxbbHh0AG
   n81dBtulaCmUP6C85FR3iAWFQ5I/LjJiIlrgq1CESJeDUV+TmWh58IznE
   D5O5UWr8JfwvEMIZgksJhQH37f9GdqwxW1gGa2EdSLtroLc3OOy/2MZ9E
   29UdL61Lqa/oT/WBU7lMBNxNGSxGmymN9ENplYUM6Eb97KfKhy51lb56I
   A==;
X-CSE-ConnectionGUID: NFKvb0AKRQGtL7pgZvPh3Q==
X-CSE-MsgGUID: SNgGsx76SNaLNHyU51Sfgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31029807"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="31029807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:17:41 -0700
X-CSE-ConnectionGUID: a7zNg4YlTVCopRkzt8urbw==
X-CSE-MsgGUID: xyL84KhgSKe/ANM7eSycIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="111786207"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2024 05:17:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B86D91E5; Thu, 03 Oct 2024 15:17:38 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] xhci: pci: Aling the naming for Cadence PCI ID 0x0200
Date: Thu,  3 Oct 2024 15:14:44 +0300
Message-ID: <20241003121729.3867216-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241003121729.3867216-1-andriy.shevchenko@linux.intel.com>
References: <20241003121729.3867216-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the PCI device ID to match what's used in another driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 295d3297ca3d..2c148b143c54 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -81,7 +81,7 @@
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI			0x3242
 
-#define PCI_DEVICE_ID_CDNS_SSP				0x0200
+#define PCI_DEVICE_ID_CDNS_UDC				0x0200
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -475,8 +475,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		if (pdev->device == 0x9203)
 			xhci->quirks |= XHCI_ZHAOXIN_TRB_FETCH;
 	}
+
 	if (pdev->vendor == PCI_VENDOR_ID_CDNS &&
-	    pdev->device == PCI_DEVICE_ID_CDNS_SSP)
+	    pdev->device == PCI_DEVICE_ID_CDNS_UDC)
 		xhci->quirks |= XHCI_CDNS_SCTX_QUIRK;
 
 	/* xHC spec requires PCI devices to support D3hot and D3cold */
-- 
2.43.0.rc1.1336.g36b5255a03ac


