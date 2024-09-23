Return-Path: <linux-kernel+bounces-336025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA197EE3B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5509E28168A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48472C2C6;
	Mon, 23 Sep 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qtlb+AMW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5A6FB0;
	Mon, 23 Sep 2024 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105506; cv=none; b=B/7RPLF3J1x6TYYmifLwp6LzVQ/v63omNJ0kdeJ6yFJfPkC4EXvLCQOFDM3Rzx/6S/tjsiirUpYsXmtQNXZYRUI/sr0SG82s05OeKVxQs5FJ9dqAl4b9+pfnZfxEFHjYvWHHfzDZt2cfrlFyfAmB/z1+23fGJJmEFfaonUibq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105506; c=relaxed/simple;
	bh=+LvQdCy3NWZsFks6BqjodIPKgk8H+PvYTnXOhTexFFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HiB/boOJU96oz90D1XPd061+FQg3D06c0eNXThjCy3Fka/s2MOk2aNd+s+9Eo6uf1TFjbbyDs7weC9QSTpAS39sDH1DeSlHY6NyC8dP7NfAOVjm4+J9M1A5M7pxEiwE+mxuIxJ1R/Mu5JeV/r86ECmIwNOxNnUWLMsKujshuiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qtlb+AMW; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727105505; x=1758641505;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+LvQdCy3NWZsFks6BqjodIPKgk8H+PvYTnXOhTexFFM=;
  b=Qtlb+AMWmjx8M0UkIjfps5IIonIIBiIvoOSZBwd+w57ucdM11mA41HG6
   8trf/Md2LdfjKavSmJMbnbmXk9IAtJk5+zMUrreAnOmF4isxMMaZCiuEA
   LLIlWE1/qEiFTum6sD1QpGlOedO73AZMvpRD3gyLGytjYpqvkwfGh3UHR
   YpIcE0Lk6DUBhbC21TWe2CICHu/xLf1Yt3jMZNRqoWkOFDUBIt7F3iCME
   BgG1J24QnrITU707xdEE8rUu0ld/6V/QqDJMFFHjIqIHGSvMtDFjr819I
   4lg/spSC3y+OaYTpyxef/paRK9RsntXQPgzv40VDJpQqREafjkgnHjQfc
   g==;
X-CSE-ConnectionGUID: 1DEm89VjS6u6laa7OjONSw==
X-CSE-MsgGUID: c+GqONRXSnWeOzRx5MT2Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28952925"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="28952925"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:31:44 -0700
X-CSE-ConnectionGUID: Llq5G3CXT6+fF0hQGM8Fhg==
X-CSE-MsgGUID: 1bMUUrTKSOaWlbfsUUUd8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71242158"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa008.fm.intel.com with ESMTP; 23 Sep 2024 08:31:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 3D1092CC; Mon, 23 Sep 2024 18:31:41 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Niklas Neronin <niklas.neronin@linux.intel.com>
Subject: [PATCH v1 1/1] xhci: Don't use "proxy" headers
Date: Mon, 23 Sep 2024 18:31:31 +0300
Message-ID: <20240923153139.3701266-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/xhci.h       | 22 +++++++++++++++++++---
 include/linux/usb/xhci-dbgp.h |  3 +++
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 620502de971a..b617de4d4c76 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -12,15 +12,31 @@
 #ifndef __LINUX_XHCI_HCD_H
 #define __LINUX_XHCI_HCD_H
 
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/dev_printk.h>
+#include <linux/irqreturn.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/spinlock.h>
+#include <linux/sprintf.h>
+#include <linux/timer_types.h>
+#include <linux/types.h>
 #include <linux/usb.h>
-#include <linux/timer.h>
-#include <linux/kernel.h>
 #include <linux/usb/hcd.h>
+#include <linux/workqueue.h>
+
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
 
+struct clk;
+struct dentry;
+struct dma_pool;
+struct radix_tree_root;
+struct reset_control;
+
 /* Code sharing between pci-quirks and xhci hcd */
-#include	"xhci-ext-caps.h"
+#include "xhci-ext-caps.h"
 #include "pci-quirks.h"
 
 #include "xhci-port.h"
diff --git a/include/linux/usb/xhci-dbgp.h b/include/linux/usb/xhci-dbgp.h
index 171fd74b1cfc..880d1421df4b 100644
--- a/include/linux/usb/xhci-dbgp.h
+++ b/include/linux/usb/xhci-dbgp.h
@@ -10,6 +10,9 @@
 #ifndef __LINUX_XHCI_DBGP_H
 #define __LINUX_XHCI_DBGP_H
 
+#include <linux/errno.h>
+#include <linux/init.h>
+
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
 int __init early_xdbc_parse_parameter(char *s, int keep_early);
 int __init early_xdbc_setup_hardware(void);
-- 
2.43.0.rc1.1336.g36b5255a03ac


