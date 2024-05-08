Return-Path: <linux-kernel+bounces-173085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C678BFB49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0741F230D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B028174F;
	Wed,  8 May 2024 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYMtVnFB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A77E7D07F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165335; cv=none; b=e+yeTfDFJDtkMytUYZxJnKvkYYIFesee869DyTRw7TZY7Tn/fEisfc3gnQeqsbyb7FjkiwHv3C7eLkPny7u2tLEqEvmGFR90n/SNXZhtYYNbxaPrD/KYh62lK5yIO80KP25Skv2cmnO77lW8GVaoo8wXxb1aIM/lNnXVdwR/HN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165335; c=relaxed/simple;
	bh=ZNNfLZfasRSKVK4SelseF0rAKOZZC/2hFdQtZg5lS5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEKIvhHX7GDXCExMczWQC76j26IcC+NFcVuyF3wqhGLJtiTY+Y95l5PohDt6Kf8dVyhScFTnOq5JVo3ycbzPKjTUgdLZWeRKl+vlt5HlRHj/PiQFlLmco3oKJRc/uufxpk04Nuai4N6OwzHyFsjF8FKAaez6/yhnuAdwsQAV9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYMtVnFB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715165334; x=1746701334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZNNfLZfasRSKVK4SelseF0rAKOZZC/2hFdQtZg5lS5w=;
  b=MYMtVnFBxDYmu8Dz6bJHNslJmyLQvqO4675h6oCVFChBBQXypWdPiaNw
   YmSI8+kev4c6xRiuxcClbFamOn00+GD9EV3sRsRE8t9cbEIGOQsSL68Yj
   vacfKWqQyoMVWlKOlywh1xJRj7fFQsSSbkIRWFm6GNw9xfvlX7iDD3lL5
   RDjf7usmE4Qkhs0/mL7YMvIkHnPvkOHVWGDYlcIDc1Yg/pXxIXBeM72Rq
   o885Vi1BRI5lAPZOelxtKQVwRLyplhTSZMLslOsiqUSDhylmk9NE/hDcp
   wUMJjCm3iDboKvXpKifEFvSdP9or2QUojg5qqXznEDVLkwytLATE1vcas
   Q==;
X-CSE-ConnectionGUID: hieqyiXeQ6GqdnosLjvd3w==
X-CSE-MsgGUID: THvaFgpXToi22OQgHdZprQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="21615952"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="21615952"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:48:53 -0700
X-CSE-ConnectionGUID: 3eJGVDsIRTqFgZqAAkFitw==
X-CSE-MsgGUID: 739vXvwdS9S5BGhy/VwOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="59705173"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa002.jf.intel.com with ESMTP; 08 May 2024 03:48:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 366C1656; Wed, 08 May 2024 13:48:50 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 2/2] mfd: lm3533: Move to new GPIO descriptor-based APIs
Date: Wed,  8 May 2024 13:46:49 +0300
Message-ID: <20240508104848.846580-3-andriy.shevchenko@linux.intel.com>
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

Legacy GPIO APIs are subject to remove. Convert the driver to new APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/lm3533-core.c  | 26 +++++++-------------------
 include/linux/mfd/lm3533.h |  3 ++-
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 515a6c3b3244..e135142a158d 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -11,7 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/err.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/mfd/core.h>
 #include <linux/regmap.h>
@@ -22,8 +22,6 @@
 #include <linux/mfd/lm3533.h>
 
 struct lm3533_platform_data {
-	int gpio_hwen;
-
 	enum lm3533_boost_ovp boost_ovp;
 	enum lm3533_boost_freq boost_freq;
 
@@ -239,14 +237,12 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 
 static void lm3533_enable(struct lm3533 *lm3533)
 {
-	if (gpio_is_valid(lm3533->gpio_hwen))
-		gpio_set_value(lm3533->gpio_hwen, 1);
+	gpiod_set_value(lm3533->hwen, 1);
 }
 
 static void lm3533_disable(struct lm3533 *lm3533)
 {
-	if (gpio_is_valid(lm3533->gpio_hwen))
-		gpio_set_value(lm3533->gpio_hwen, 0);
+	gpiod_set_value(lm3533->hwen, 0);
 }
 
 enum lm3533_attribute_type {
@@ -496,18 +492,10 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	if (!pdata)
 		return -ENOMEM;
 
-	lm3533->gpio_hwen = pdata->gpio_hwen;
-
-	if (gpio_is_valid(lm3533->gpio_hwen)) {
-		ret = devm_gpio_request_one(lm3533->dev, lm3533->gpio_hwen,
-					GPIOF_OUT_INIT_LOW, "lm3533-hwen");
-		if (ret < 0) {
-			dev_err(lm3533->dev,
-				"failed to request HWEN GPIO %d\n",
-				lm3533->gpio_hwen);
-			return ret;
-		}
-	}
+	lm3533->hwen = devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW);
+	if (IS_ERR(lm3533->hwen))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), "failed to request HWEN GPIO\n");
+	gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
 
 	lm3533_enable(lm3533);
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index ce42f0737768..d30c70c2a5f6 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -16,6 +16,7 @@
 	DEVICE_ATTR(_name, S_IRUGO | S_IWUSR , show_##_name, store_##_name)
 
 struct device;
+struct gpio_desc;
 struct regmap;
 
 struct lm3533 {
@@ -23,7 +24,7 @@ struct lm3533 {
 
 	struct regmap *regmap;
 
-	int gpio_hwen;
+	struct gpio_desc *hwen;
 	int irq;
 
 	unsigned have_als:1;
-- 
2.43.0.rc1.1336.g36b5255a03ac


