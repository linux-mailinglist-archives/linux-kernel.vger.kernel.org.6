Return-Path: <linux-kernel+bounces-173086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA38BFB4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C10B24B9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A45823D1;
	Wed,  8 May 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPEy+Je9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252CC81726
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165336; cv=none; b=NslwbV2A1jhzSQkUrLrIwQkyYOa+aPp0W6BZ31hTVydULiYT4wZs4Cc6osedqdZKb/JApveDIj1SEB1GwCHJ6V6NtK5EkFpnrZwt8DSukvyDZyi/LXFZOKReFRiIjnpJgbcq3uC5j1oHV/UtjeP1nShDiUeh47SAYuX9YzHjyhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165336; c=relaxed/simple;
	bh=I7qb+olAYnL2mXPMtiZeYAJSJKv8HID4q3q4py1NbjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doQFwJkREcrWuBL9QQye9p97wLe1hVmfWtSP2SXvDT/Du4JqnLFiW43IVpB2icq0y2WYoTUt1l1qxZ3XQzN4spAfkwk1h8MbMX0gnzc5y6GKMV6UUCy98yQYJDppeAYLs5SqNkZLc+2Dc8WcjGTOvXIVLgPyjsFcm9SCz3UWo4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPEy+Je9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715165336; x=1746701336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I7qb+olAYnL2mXPMtiZeYAJSJKv8HID4q3q4py1NbjE=;
  b=ZPEy+Je9VJ0o+Sp4QrPr+Jh4fgMNunHp+ISd5jq8r4xNf/qmQX2x//l2
   460gRFwRgkW1VZBuJuQ6Jk2QtC245HI/J6H8giRkGhwOYUXYqQ6c6NnDM
   kZsEyJO15ncyIjtbIxiEzOX+XlZ0jeJ8nrGwXlDFAIWb/He4JzSp9RJ6v
   m+ZvFXT+0fYFsO61MBO3S8UF4EcY8/HaYaAlTe44axqxcvUJLnAV3Vfpk
   CVhV4WtY79H2UOxy0tJAqDpD/n9A6dDdyy713qc4hNsGN/5aCyJFBTFJu
   h7jY1ZvnuHfcfd1yTRKadpmIhmwngp2yBGwWZaWO7jKMQwVTz3OdYKGcj
   g==;
X-CSE-ConnectionGUID: KhmsD4DWRgKty93tvq+eEA==
X-CSE-MsgGUID: EOhr/SeVQvuPDnL/Fe/pLw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21615955"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21615955"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:48:53 -0700
X-CSE-ConnectionGUID: guuC1Q2qT5+siDVj2jtGSw==
X-CSE-MsgGUID: FeCPCp61QwmlWAoi74Kzxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59705174"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 08 May 2024 03:48:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 27CB986; Wed, 08 May 2024 13:48:50 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the driver
Date: Wed,  8 May 2024 13:46:48 +0300
Message-ID: <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First of all, there is no user for the platform data in the kernel.
Second, it needs a lot of updates to follow the modern standards
of the kernel, including proper Device Tree bindings and device
property handling.

For now, just hide the legacy platform data in the driver's code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lm3533-core.c  | 23 ++++++++++++++++++-----
 include/linux/mfd/lm3533.h | 15 ---------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index c211183cecb2..515a6c3b3244 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -21,6 +21,20 @@
 
 #include <linux/mfd/lm3533.h>
 
+struct lm3533_platform_data {
+	int gpio_hwen;
+
+	enum lm3533_boost_ovp boost_ovp;
+	enum lm3533_boost_freq boost_freq;
+
+	struct lm3533_als_platform_data *als;
+
+	struct lm3533_bl_platform_data *backlights;
+	int num_backlights;
+
+	struct lm3533_led_platform_data *leds;
+	int num_leds;
+};
 
 #define LM3533_BOOST_OVP_MASK		0x06
 #define LM3533_BOOST_OVP_SHIFT		1
@@ -473,15 +487,14 @@ static int lm3533_device_setup(struct lm3533 *lm3533,
 
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
-	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
+	struct lm3533_platform_data *pdata;
 	int ret;
 
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	if (!pdata) {
-		dev_err(lm3533->dev, "no platform data\n");
-		return -EINVAL;
-	}
+	pdata = devm_kzalloc(lm3533->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
 	lm3533->gpio_hwen = pdata->gpio_hwen;
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 77092f6363ad..ce42f0737768 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -68,21 +68,6 @@ enum lm3533_boost_ovp {
 	LM3533_BOOST_OVP_40V,
 };
 
-struct lm3533_platform_data {
-	int gpio_hwen;
-
-	enum lm3533_boost_ovp boost_ovp;
-	enum lm3533_boost_freq boost_freq;
-
-	struct lm3533_als_platform_data *als;
-
-	struct lm3533_bl_platform_data *backlights;
-	int num_backlights;
-
-	struct lm3533_led_platform_data *leds;
-	int num_leds;
-};
-
 extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
 extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


