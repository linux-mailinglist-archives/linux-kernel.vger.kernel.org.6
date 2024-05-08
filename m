Return-Path: <linux-kernel+bounces-173724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7098C049E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302741C2147B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810EB12CD8E;
	Wed,  8 May 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SsphHgJu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7F285626
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194157; cv=none; b=Oblbn1ENIavCP+FwrqQEbUyfVYgwKRnThL+NQ5+vVDmhq+UltQ65AIlQ7vaNyiO+RLSUeqv7ws79pF24bumK8owm/kV7hlSQvLL32tw1XYSvwnQpjhpodqAV0jqhUwMEZL38WWTKqfcw5+Noae3fC3v4INcID8gx0JHtlJOha5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194157; c=relaxed/simple;
	bh=BEXgD02hAqqj04mvEO4yWk35RrwOCmhx/VQbR1WjueI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4u583UTNuZOHYm1zHA1Y4fYy3NfgC921eg1xuyYTx+ABqvaV/iKakqC2t+0n+wYIZJnbSq1cs56GaE5EXuJb8zBFylVFpHq0VhSiQE4fO/SB8tmUDweWYmRNNoEHxdgUpqTn6H0bwMBcbSE0a6tfOpBdAiHDnn1++3lWYtNvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SsphHgJu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194156; x=1746730156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BEXgD02hAqqj04mvEO4yWk35RrwOCmhx/VQbR1WjueI=;
  b=SsphHgJuG+k/og9M61nuovO3f/FqECXNeACuF3NkeTnmd4HuQQFWbChd
   H7Sq3EIffUJhT0j5U0T8GbLEe77nGfo9dZOw0clKpVgwieiCw0499PvQZ
   Efq+4GcCd7yk3csLA1qG7Y2K4LcY6Ooo38UXsN9uKd/l0990tToOVJ2zj
   F4+UnEaWzpL4BPHoQrLg0d2nBto85ImRq3uWoxlfdk+t9KWKzBFS59x4p
   lbtscz6g4NUncnLX+8hb/GTrd2ZHlkzRjB2eGEmlFPs4JqBC9ydyTbnNH
   I9CYLtLlZwaH4hftppwYzXYf8wDZmfsePgCGkodDsHCoM8uAzFUGEHzjv
   g==;
X-CSE-ConnectionGUID: 4ovc+EvhTNKh3QboDhi6pQ==
X-CSE-MsgGUID: NwvD1bDlQZ6lp+Bi0zOdqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591017"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:15 -0700
X-CSE-ConnectionGUID: o8yt8q5bTJikLQ3KWHNeJg==
X-CSE-MsgGUID: 1f9U0mIHS/6wu4QDgVcC7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024947"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 9EFFD743; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 04/10] misc: eeprom_93xx46: Hide legacy platform data in the driver
Date: Wed,  8 May 2024 21:46:57 +0300
Message-ID: <20240508184905.2102633-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com>
References: <20240508184905.2102633-1-andriy.shevchenko@linux.intel.com>
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
 drivers/misc/eeprom/eeprom_93xx46.c | 35 ++++++++++++++++++++++++-----
 include/linux/eeprom_93xx46.h       | 32 --------------------------
 2 files changed, 29 insertions(+), 38 deletions(-)
 delete mode 100644 include/linux/eeprom_93xx46.h

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index bbcc9412bb4e..a5a043ddedbb 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -5,6 +5,7 @@
  * (C) 2011 DENX Software Engineering, Anatolij Gustschin <agust@denx.de>
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
@@ -19,7 +20,31 @@
 
 #include <linux/nvmem-provider.h>
 
-#include <linux/eeprom_93xx46.h>
+struct eeprom_93xx46_platform_data {
+	unsigned char	flags;
+#define EE_ADDR8	0x01		/*  8 bit addr. cfg */
+#define EE_ADDR16	0x02		/* 16 bit addr. cfg */
+#define EE_READONLY	0x08		/* forbid writing */
+#define EE_SIZE1K	0x10		/* 1 kb of data, that is a 93xx46 */
+#define EE_SIZE2K	0x20		/* 2 kb of data, that is a 93xx56 */
+#define EE_SIZE4K	0x40		/* 4 kb of data, that is a 93xx66 */
+
+	unsigned int	quirks;
+/* Single word read transfers only; no sequential read. */
+#define EEPROM_93XX46_QUIRK_SINGLE_WORD_READ		(1 << 0)
+/* Instructions such as EWEN are (addrlen + 2) in length. */
+#define EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH		(1 << 1)
+/* Add extra cycle after address during a read */
+#define EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE		BIT(2)
+
+	/*
+	 * optional hooks to control additional logic
+	 * before and after spi transfer.
+	 */
+	void (*prepare)(void *);
+	void (*finish)(void *);
+	struct gpio_desc *select;
+};
 
 #define OP_START	0x4
 #define OP_WRITE	(OP_START | 0x1)
@@ -479,11 +504,9 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	int err;
 
-	if (dev_fwnode(dev)) {
-		err = eeprom_93xx46_probe_fw(dev);
-		if (err < 0)
-			return err;
-	}
+	err = eeprom_93xx46_probe_fw(dev);
+	if (err < 0)
+		return err;
 
 	pd = spi->dev.platform_data;
 	if (!pd) {
diff --git a/include/linux/eeprom_93xx46.h b/include/linux/eeprom_93xx46.h
deleted file mode 100644
index 34c2175e6a1e..000000000000
--- a/include/linux/eeprom_93xx46.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Module: eeprom_93xx46
- * platform description for 93xx46 EEPROMs.
- */
-#include <linux/gpio/consumer.h>
-
-struct eeprom_93xx46_platform_data {
-	unsigned char	flags;
-#define EE_ADDR8	0x01		/*  8 bit addr. cfg */
-#define EE_ADDR16	0x02		/* 16 bit addr. cfg */
-#define EE_READONLY	0x08		/* forbid writing */
-#define EE_SIZE1K	0x10		/* 1 kb of data, that is a 93xx46 */
-#define EE_SIZE2K	0x20		/* 2 kb of data, that is a 93xx56 */
-#define EE_SIZE4K	0x40		/* 4 kb of data, that is a 93xx66 */
-
-	unsigned int	quirks;
-/* Single word read transfers only; no sequential read. */
-#define EEPROM_93XX46_QUIRK_SINGLE_WORD_READ		(1 << 0)
-/* Instructions such as EWEN are (addrlen + 2) in length. */
-#define EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH		(1 << 1)
-/* Add extra cycle after address during a read */
-#define EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE		BIT(2)
-
-	/*
-	 * optional hooks to control additional logic
-	 * before and after spi transfer.
-	 */
-	void (*prepare)(void *);
-	void (*finish)(void *);
-	struct gpio_desc *select;
-};
-- 
2.43.0.rc1.1336.g36b5255a03ac


