Return-Path: <linux-kernel+bounces-173727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735BB8C04A1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE175B25945
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9F1130A45;
	Wed,  8 May 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IH6mNELB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08012D75D
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194159; cv=none; b=PQi1FBjHmbXBxq55QGgzAQWPy3hyXilf5Mq0wnX/v5E0mcrLxZhd2o70abPZSlfbAs/MB7GShUpuZOyJbrNVGETxUZaIjE8SEs2hyVyXtbIe8zH6uWfqJtXIhZWHKIpAdW8nxbo9WmBN5/Fq8trounSHf29IqBTBDGcQLC0E9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194159; c=relaxed/simple;
	bh=a/7cuaQpvG4lE7netr1STOaAFyfnPDR41TiglDVDB10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiofzB6WF5TYIg7WeayeeDNe1Uy155/K/CSL6q2m+bbOLYIrf3KO6oTCVWD4BvqerrgY3jw0Bxw7Q9lKYY7qub0oRa5Ymq6P6GwhheqRJsgpjbl5Q/e9u2UckGgOB484gSwbDl5qJNs7UTTdkDcu7ItgN3EmfyeW/39aFNyuLZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IH6mNELB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194158; x=1746730158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a/7cuaQpvG4lE7netr1STOaAFyfnPDR41TiglDVDB10=;
  b=IH6mNELB52lhcEdGQ6kk7dcVUq2JlJUgmDZKCtD88koIPxycKq2jOd9N
   tRzv+gMjYeQOimqcvIfzf/Ri0C0jnaW315Il+UWMei6Dfi+mEujCzi2Kz
   aena03D5qNqphdgENVwOyAr1e35opVJJa+ldLIgFx4j3K46vUuG5j99NK
   RqzydzJB9TG27Ah2YDQU7Xq2/XHSUknLz41I86z8iBf/csQ+YyOXbyJKo
   H3nZNoAgbFAvLRO1gJS4Kz0w01IIGJs6Em+pvJtx/v2SyWqinD50os8YK
   JrpQR9UpHHG9pX+Q5EiIoEoRwDX0o5FxGM5a14AyEh0REsKs1wjxJgR8Q
   w==;
X-CSE-ConnectionGUID: +GEzqJsFRMqTz7E1EDjNOA==
X-CSE-MsgGUID: DHPhdL3pR6+uE6zWE3pKDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591021"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591021"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:15 -0700
X-CSE-ConnectionGUID: +oTLIxEcS8+8RyFfki96sw==
X-CSE-MsgGUID: TpZH2DhoQBmmvEyUwJFilw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024951"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 7DCF986; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 01/10] misc: eeprom_93xx46: Make use of device properties
Date: Wed,  8 May 2024 21:46:54 +0300
Message-ID: <20240508184905.2102633-2-andriy.shevchenko@linux.intel.com>
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

Convert the module to be property provider agnostic and allow
it to be used on non-OF platforms.

Include mod_devicetable.h explicitly to replace the dropped of.h
which included mod_devicetable.h indirectly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 41 ++++++++++++++---------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 45c8ae0db8f9..bbcc9412bb4e 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -10,13 +10,15 @@
 #include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/log2.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+
 #include <linux/nvmem-provider.h>
+
 #include <linux/eeprom_93xx46.h>
 
 #define OP_START	0x4
@@ -422,22 +424,20 @@ static const struct spi_device_id eeprom_93xx46_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, eeprom_93xx46_spi_ids);
 
-static int eeprom_93xx46_probe_dt(struct spi_device *spi)
+static int eeprom_93xx46_probe_fw(struct device *dev)
 {
-	const struct of_device_id *of_id =
-		of_match_device(eeprom_93xx46_of_table, &spi->dev);
-	struct device_node *np = spi->dev.of_node;
+	const struct eeprom_93xx46_devtype_data *data;
 	struct eeprom_93xx46_platform_data *pd;
 	u32 tmp;
 	int ret;
 
-	pd = devm_kzalloc(&spi->dev, sizeof(*pd), GFP_KERNEL);
+	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
 		return -ENOMEM;
 
-	ret = of_property_read_u32(np, "data-size", &tmp);
+	ret = device_property_read_u32(dev, "data-size", &tmp);
 	if (ret < 0) {
-		dev_err(&spi->dev, "data-size property not found\n");
+		dev_err(dev, "data-size property not found\n");
 		return ret;
 	}
 
@@ -446,30 +446,28 @@ static int eeprom_93xx46_probe_dt(struct spi_device *spi)
 	} else if (tmp == 16) {
 		pd->flags |= EE_ADDR16;
 	} else {
-		dev_err(&spi->dev, "invalid data-size (%d)\n", tmp);
+		dev_err(dev, "invalid data-size (%d)\n", tmp);
 		return -EINVAL;
 	}
 
-	if (of_property_read_bool(np, "read-only"))
+	if (device_property_read_bool(dev, "read-only"))
 		pd->flags |= EE_READONLY;
 
-	pd->select = devm_gpiod_get_optional(&spi->dev, "select",
-					     GPIOD_OUT_LOW);
+	pd->select = devm_gpiod_get_optional(dev, "select", GPIOD_OUT_LOW);
 	if (IS_ERR(pd->select))
 		return PTR_ERR(pd->select);
+	gpiod_set_consumer_name(pd->select, "93xx46 EEPROMs OE");
 
 	pd->prepare = select_assert;
 	pd->finish = select_deassert;
-	gpiod_direction_output(pd->select, 0);
-
-	if (of_id->data) {
-		const struct eeprom_93xx46_devtype_data *data = of_id->data;
 
+	data = spi_get_device_match_data(to_spi_device(dev));
+	if (data) {
 		pd->quirks = data->quirks;
 		pd->flags |= data->flags;
 	}
 
-	spi->dev.platform_data = pd;
+	dev->platform_data = pd;
 
 	return 0;
 }
@@ -478,10 +476,11 @@ static int eeprom_93xx46_probe(struct spi_device *spi)
 {
 	struct eeprom_93xx46_platform_data *pd;
 	struct eeprom_93xx46_dev *edev;
+	struct device *dev = &spi->dev;
 	int err;
 
-	if (spi->dev.of_node) {
-		err = eeprom_93xx46_probe_dt(spi);
+	if (dev_fwnode(dev)) {
+		err = eeprom_93xx46_probe_fw(dev);
 		if (err < 0)
 			return err;
 	}
@@ -565,7 +564,7 @@ static void eeprom_93xx46_remove(struct spi_device *spi)
 static struct spi_driver eeprom_93xx46_driver = {
 	.driver = {
 		.name	= "93xx46",
-		.of_match_table = of_match_ptr(eeprom_93xx46_of_table),
+		.of_match_table = eeprom_93xx46_of_table,
 	},
 	.probe		= eeprom_93xx46_probe,
 	.remove		= eeprom_93xx46_remove,
-- 
2.43.0.rc1.1336.g36b5255a03ac


