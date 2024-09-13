Return-Path: <linux-kernel+bounces-327803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3829977B68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDA901C20C13
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF71D6C6D;
	Fri, 13 Sep 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nF/+XLzk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C61185925;
	Fri, 13 Sep 2024 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217056; cv=none; b=qrKN6Pdqy6VYm0ljoJHAKQEBke338BJDqJvz7TRrmE/TGz4wh81ASIbw9xpqQadnZpNx9JAkEmQhCcw1+eFeiHy0xULRGuMyeuiw/pyV5PsnZgBHl4NucaKaPPBQKBq3Tu6gekKWR76m9u16Z68PmUsIY7vI92erZ29vV4EJH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217056; c=relaxed/simple;
	bh=+jAaPwab1GS9UNp1Ia34ZEvBHBb4SGKdmT76WYDP7yI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNpuPXbllylJSTLuIVa5rBfmVbEAo1nA3aM1z17kXrxmUmOqqbdaK5EPWyWbnQrstORq3ILAk+aOEOtaR5+GpL5xv8yPEh68q4JGtff2olbdbVNsmkqjodvUzVYVx9cjrAgAhtqegTmfUSq1PS40Ktr2GMJbsTGNS5aYkEQ2X70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nF/+XLzk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726217054; x=1757753054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+jAaPwab1GS9UNp1Ia34ZEvBHBb4SGKdmT76WYDP7yI=;
  b=nF/+XLzk6KYEv+SOHXfO6jZULebXLo4A1X4CVBUElUcOsa1p6m+V1HED
   7OJOKUYeIGTAyyJTMzIUlq+kEuUj+VhCOxod+IxWD8mhKs+TE7C4TLpNd
   K4myE10XuKnisPjml7dULBciTlKMD1uz3lKr4bJySZg9vxur6/mlcgFaR
   2a4pEi65qJRu7Sg4bIR8owfynYJwauwaERpe+GBBgRqoByd/63RZvTyFh
   jHUxg/RXm29ymiCZHVHQ/0gUzv9zMlbTSA5sn7XrysVxWGLaY4a7+9kAK
   +jNAWvqXOs0r8YxC5XxzfTj+SnTWev/oExgf9lCx6OaT02O0rl4qy9/4D
   A==;
X-CSE-ConnectionGUID: JXh1i9OPSiKSGsx1yCWpEw==
X-CSE-MsgGUID: ZMQa5VS/R2eKJmkYYg4y0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="42618546"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="42618546"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:44:14 -0700
X-CSE-ConnectionGUID: oTZRt37oTtG3dIvdw9O9SQ==
X-CSE-MsgGUID: 5HwujQJVRoSO+7CnT+ZHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="67953667"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 13 Sep 2024 01:44:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 89A20387; Fri, 13 Sep 2024 11:44:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] xhci: pci: Fix indentation in the PCI device ID definitions
Date: Fri, 13 Sep 2024 11:43:38 +0300
Message-ID: <20240913084411.3309911-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
References: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
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
index 6d9eb2b031e2..cbbee5175547 100644
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


