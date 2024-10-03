Return-Path: <linux-kernel+bounces-348989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF8998EEFB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 141AE284C11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408FF19939D;
	Thu,  3 Oct 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXjcTk/3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8718593E;
	Thu,  3 Oct 2024 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957867; cv=none; b=Lvx7sOFFzQoKZk6wQzeWQS5qn86G1rqAb3VwNT/ys9OW/dM+1Fgcs8muzSmtf8h7q81Q2G0C0t96CtgGWoSrKI0ouHoMhHoC7K7reiJ7y5DKydDCOM3ThqWS42G20fZvcO94zlE6C6qkzWFwWojCQPmZU5xD25SVr8M7fQ4aI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957867; c=relaxed/simple;
	bh=aGQ7+SR9U7HF7iLueB7DH4Z3T9tvu3SmVEYNeNRliE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOy5znc8KfBmtIT07i+uqXPavB9OZPFOWX6mCHpUP+mbpe42K42Al8dbRLuo9wEQSgPU3GFrXaHHAXbSFxbYha2Us/BTY0gAVk8Q9r9mdpbthdbkyYzequu6nRyWjf+B5yjuN+/7mAP4fJlhRi+D05UZJ1i6Rt5Fe0gB5bnkaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXjcTk/3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727957866; x=1759493866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aGQ7+SR9U7HF7iLueB7DH4Z3T9tvu3SmVEYNeNRliE4=;
  b=NXjcTk/3FmrIJ+UcoDTCJZcbiOCQQ2+Oza3I5r0WjuuPAwYEDZWvnpp4
   jRMPsMrjT/v1Fyt5U8DeStknrt0250MPAqyPl+DpgjEMkOYeXD8QVPiOG
   WE075lyy930uxy2w9VTby4pRzqR26GC/Xmit+li6YYjRy0hY9BZiJLwJR
   hM4ZlhHWe3vHF3ldBQFxkrqjc3JN6xKERhpT1VHWGpF5PhgMVXZS948Pd
   UzRpJ4/xCY7o4oRgmnpGFEVPaf2sn5ZSue3BJ7pgeZL0nvYOXsohtdmHI
   4rYPE2EHOcffgbUzwLaWAH1L0L3HjbOPfRdYGRIb6/mjiUHu0NC+tNrfV
   w==;
X-CSE-ConnectionGUID: iP+0WW/wQH6BsJ9GiJqzVg==
X-CSE-MsgGUID: w01VOoNESHmYg6JJLAW69g==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37705720"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="37705720"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:17:43 -0700
X-CSE-ConnectionGUID: qrFFcryMQVS07sLTy0Alsw==
X-CSE-MsgGUID: Ikt77AB3RLusenKZkhVhtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="78746177"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 03 Oct 2024 05:17:41 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 350A337D; Thu, 03 Oct 2024 15:17:40 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] xhci: pci: Fix indentation in the PCI device ID definitions
Date: Thu,  3 Oct 2024 15:14:46 +0300
Message-ID: <20241003121729.3867216-4-andriy.shevchenko@linux.intel.com>
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

Some of the definitions are missing the one TAB, add it to them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci-pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 1f7333a5e9a9..4b0378a9b584 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -28,8 +28,8 @@
 #define SPARSE_CNTL_ENABLE	0xC12C
 
 /* Device for a quirk */
-#define PCI_VENDOR_ID_FRESCO_LOGIC	0x1b73
-#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK	0x1000
+#define PCI_VENDOR_ID_FRESCO_LOGIC		0x1b73
+#define PCI_DEVICE_ID_FRESCO_LOGIC_PDK		0x1000
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1009	0x1009
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1100	0x1100
 #define PCI_DEVICE_ID_FRESCO_LOGIC_FL1400	0x1400
@@ -38,8 +38,8 @@
 #define PCI_DEVICE_ID_ETRON_EJ168		0x7023
 #define PCI_DEVICE_ID_ETRON_EJ188		0x7052
 
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI	0x8c31
-#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI		0x8c31
+#define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI		0x9c31
 #define PCI_DEVICE_ID_INTEL_WILDCATPOINT_LP_XHCI	0x9cb1
 #define PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI		0x22b5
 #define PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI		0xa12f
-- 
2.43.0.rc1.1336.g36b5255a03ac


