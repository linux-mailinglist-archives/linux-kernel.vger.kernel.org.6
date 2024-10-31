Return-Path: <linux-kernel+bounces-390363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D25849B78E7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6863EB22FF5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A23E19993C;
	Thu, 31 Oct 2024 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gqCyoXXd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA3199937
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730371449; cv=none; b=sjvmDJL5EP3SFygE6asgalbzFZ64wXtMw9XQhPVQfgdjU2+KGBSy/+UOWFAFE6O1fEmNwvdWdPUytYyjvecJXA4fLNIclKHs/jnLuyi5sXvOdUuj88hPt3j9s7bnuxgzRgb6NYUHgUiapmmrsek3kSheS87EcmVqEztpqRlzhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730371449; c=relaxed/simple;
	bh=6jafkym8hwm2gs6Wy4PAFuWVy2CuiroeKnaHE9SQcVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RJhkvct2wpk3xktKlGzf/16BtHAKr7V9tZRAV9+dWRnc+d/Ycj2dKLLO1I+f6uL89EW7u2XQu53PYl8Gpz1/PJKbzqiYs/QBUqaiUKSzIQol7NhWBPkiYOJlZn2s9DP/8eMnGO6H/LYGXCTlEvaMRhlO1a/p2nEvXrFIT8aK4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gqCyoXXd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730371448; x=1761907448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6jafkym8hwm2gs6Wy4PAFuWVy2CuiroeKnaHE9SQcVM=;
  b=gqCyoXXdnODJSDgj8+KUYdVi94c6YzRWRVmUHBYK/gcDUBUCV67KdMC0
   a6VgTBKi+Aw8qIObfkq+g0He9/tYcg9J7Miotr+n/gZ+nrEEpEkFJSEry
   mZLoc3lOPKEozmbc5UhBgOrAnTZCBi0m722q+Tezfg3m4JIPnxaL7uKc8
   X80WF6PFs0gOXpY+1UiTKGSq4mRfTMYcbabbmWrQixmvGoI7k0tyySR4K
   zBt7xs/dIhZMGLzuDNwx1SD4PBf3sGE7s4y8t18ITgKmEiSBy/9OiwdXL
   oq+FQBcR7Htmcvi3zHRPE5jci7Vie+qiBKBlDXWHknPUkgThKB8bfn1H8
   g==;
X-CSE-ConnectionGUID: T0p9E3VWSB6zrzjpbe+H6w==
X-CSE-MsgGUID: GVWy6U1sR8WA0xXDDS5w9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30056963"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30056963"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 03:44:07 -0700
X-CSE-ConnectionGUID: YcB9MRHFRG+DoyYG0BRcCw==
X-CSE-MsgGUID: wLzs5UcLTziR1k9FCt2y6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82746439"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 31 Oct 2024 03:44:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2B17A17D; Thu, 31 Oct 2024 12:44:02 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [PATCH v1 1/1] phy: HiSilicon: Don't use "proxy" headers
Date: Thu, 31 Oct 2024 12:44:01 +0200
Message-ID: <20241031104401.2454179-1-andriy.shevchenko@linux.intel.com>
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
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index 0ac9634b398d..dbc7dcce682b 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -16,15 +16,20 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
-#include <linux/gpio.h>
-#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 #define AXI_CLK_FREQ				207500000
 #define REF_CLK_FREQ				100000000
-- 
2.43.0.rc1.1336.g36b5255a03ac


