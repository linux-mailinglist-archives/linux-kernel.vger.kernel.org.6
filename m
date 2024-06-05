Return-Path: <linux-kernel+bounces-203090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A1E8FD64F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A8F1F254CD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907BC13D625;
	Wed,  5 Jun 2024 19:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvAwMi6W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EC313AD04
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 19:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614907; cv=none; b=aWGbLy1Pn8y0ZilU7ApAWvRg/o0uL/82LOUK3vW9skvS0PbqFzrV7jMSv8ign8Q3STQzoQ3MeAtqv1cZlnzojC27rdEPkbMzEPR19uMuJPONdm2VOFY2yTJpKNkTzc+gx7gzhXDVfMkqQv5lT/mO8gWXpZi+ethAPb8gslxFPcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614907; c=relaxed/simple;
	bh=aEsUdQzPwEZ17Ss2txs55EBZNgRHbpJF1uSlRsNUc2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bOBXnfHH2XaAJ2SxThfA+DywJl0f6DX9wGwxU1Zbnhv2HFCvm4c8Sw0eB2OvvNp6DDHpg1n+M7nShcpmlRVJZL3Sg8GEdmNudorhh/XnQykYVjz063B2IffsFq4R3w3XIUrx2rgfy471KK/enayN2scnShiZVwXdk2JuuVIoRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvAwMi6W; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717614907; x=1749150907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aEsUdQzPwEZ17Ss2txs55EBZNgRHbpJF1uSlRsNUc2c=;
  b=TvAwMi6Wq0BPJsPs2adAoqutm/hP5JSZ1mMLgwC0QGYkX11Ec09qCUZo
   /0tNjdH0PJQR11S5nea+akVvJbW7x6aWxY7oBGIYhEoL14WgoL9ZYcwrX
   J13BsAyT5o0tTtvEZztf6hcFEY/jClhYjqUqVvqlS+PeYsl2/ceM562G9
   z8d74lqKqSSufyE1+uJ/gM9OJqi928jEK8ia8CUucysQjpd5TusmbkmwD
   jbhs5ur8sMIwdva/L2pCBPGijvcGK1/pWvLoZ/VmSLb6P3aNI0myl2P3X
   +L341Y/q3hyOD7tQKDOGInpyT3QCgon7Yi6kqXuVsjKRsbNzBLe9PaGxu
   w==;
X-CSE-ConnectionGUID: BbU3amUsSjSy1Nf1s15xzA==
X-CSE-MsgGUID: DqNvF6rhSPudKpELdpjGbA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="36779182"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="36779182"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 12:15:05 -0700
X-CSE-ConnectionGUID: N30nrDZkQfa+pGtpKNOhwQ==
X-CSE-MsgGUID: gtkv9wKMQemIOOKc1RREDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="38261128"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 05 Jun 2024 12:15:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 12B371B6; Wed, 05 Jun 2024 22:15:01 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 1/1] mfd: lm3533: Move to new GPIO descriptor-based APIs
Date: Wed,  5 Jun 2024 22:14:16 +0300
Message-ID: <20240605191458.2536819-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
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
v2: left platform data in place (Johan), and rebased this patch
 drivers/mfd/lm3533-core.c  | 24 +++++++-----------------
 include/linux/mfd/lm3533.h |  5 ++---
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index c1219e608c5f..0a2409d00b2e 100644
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
@@ -225,14 +225,12 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 
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
@@ -483,18 +481,10 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		return -EINVAL;
 	}
 
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
index 77092f6363ad..69059a7a2ce5 100644
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
@@ -69,8 +70,6 @@ enum lm3533_boost_ovp {
 };
 
 struct lm3533_platform_data {
-	int gpio_hwen;
-
 	enum lm3533_boost_ovp boost_ovp;
 	enum lm3533_boost_freq boost_freq;
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


