Return-Path: <linux-kernel+bounces-173723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 221EB8C049D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AC1B252FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D3C12BEAE;
	Wed,  8 May 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cH2vRqYZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BCB84A34
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194157; cv=none; b=dDbE7YiJrAmSOgLlsYi9+2cvolTJuT7Dsz9hn7pVUcNImPDTd15uBg1lOAe84nbrgzUuAP53oAUOtOUJu7x6+MfqCdYFqkSeiw2G7EnBtiAPjgykTKPaaY/UlQtA/d+pdq9bfyFBZE8kXZIc46VN1Y4Neyc9I+r7ENP0q/XexRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194157; c=relaxed/simple;
	bh=lKeEU9se9zdoUztrpsgzAxtBW4Mcm9fhQEu9pW5f9Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=citJSGAftojZYF2jAFhxl50o+iXBTbt3iH0VhGO5DPwZ09WclPDq4XXkx8nxFsXahAzj2FZ0r8enk8NqQVXdwRyksFijAQYaY4GzJ7FyvZpUBXCoZvkm6ujMSUVtqPTcA9PiD0ztiXJp9q/YM5NX46po4j9qlakpB2Mj5QXJWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cH2vRqYZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194156; x=1746730156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKeEU9se9zdoUztrpsgzAxtBW4Mcm9fhQEu9pW5f9Eo=;
  b=cH2vRqYZfTIeJX8eiaNrvghiFU7OLsazGbs14inDCi6WPQSbgpBJNtLz
   yQIHB+A1/9JgTfemTRDu0q4c3LCgNNXcw5t38lD47I31TSQMpRSMim7Hb
   qtil0N7fE+mu4n7P4d6nNdvKqMqP/Yx4RLSq4+sHCVYCNuDkZPEi9RWwP
   Tk6YL+9lXulrTuUUYOJUphjwILhevBxsMKCosi12ELeu0Vc6ATK/j783B
   GHiSzZ5uT0FrfkXmcDwTmrj5PLG3LaYKqcYyQiUHNyfFJTDvIE+JEtakq
   6syohuFjbrqGHVnUfb+ytyvpU88RJaEsrrH014cD7whLdiO1k8kXoAh3O
   A==;
X-CSE-ConnectionGUID: kq2rBQmlR+qL/U1pAwtlfA==
X-CSE-MsgGUID: 0ccMLK3RSOiZZ4hhm7FJOg==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36457763"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36457763"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:15 -0700
X-CSE-ConnectionGUID: q8PySlm9ROODnSbx+KLFcA==
X-CSE-MsgGUID: TWAQ1AMnS8m1Noc53CB3YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28957212"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2024 11:49:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 91EFE6C4; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 03/10] eeprom: digsy_mtc: Convert to use GPIO descriptors
Date: Wed,  8 May 2024 21:46:56 +0300
Message-ID: <20240508184905.2102633-4-andriy.shevchenko@linux.intel.com>
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

This converts the driver to use GPIO descriptors exclusively
to retrieve GPIO lines. Drop the old GPIO handling in favor of
the core managing it exclusively.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/digsy_mtc_eeprom.c | 46 +++++++++++---------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index 4eddc5ba1af9..88888485e6f8 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -14,13 +14,12 @@
  * and delete this driver.
  */
 
-#include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_gpio.h>
-#include <linux/eeprom_93xx46.h>
 
 #define GPIO_EEPROM_CLK		216
 #define GPIO_EEPROM_CS		210
@@ -29,22 +28,13 @@
 #define GPIO_EEPROM_OE		255
 #define EE_SPI_BUS_NUM	1
 
-static void digsy_mtc_op_prepare(void *p)
-{
-	/* enable */
-	gpio_set_value(GPIO_EEPROM_OE, 0);
-}
+static const struct property_entry digsy_mtc_spi_properties[] = {
+	PROPERTY_ENTRY_U32("data-size", 8),
+	{ }
+};
 
-static void digsy_mtc_op_finish(void *p)
-{
-	/* disable */
-	gpio_set_value(GPIO_EEPROM_OE, 1);
-}
-
-struct eeprom_93xx46_platform_data digsy_mtc_eeprom_data = {
-	.flags		= EE_ADDR8 | EE_SIZE1K,
-	.prepare	= digsy_mtc_op_prepare,
-	.finish		= digsy_mtc_op_finish,
+static const struct software_node digsy_mtc_spi_node = {
+	.properties = digsy_mtc_spi_properties,
 };
 
 static struct spi_gpio_platform_data eeprom_spi_gpio_data = {
@@ -70,18 +60,19 @@ static struct gpiod_lookup_table eeprom_spi_gpiod_table = {
 			    "miso", GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_CS,
 			    "cs", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio@b00", GPIO_EEPROM_OE,
+			    "select", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
 
 static struct spi_board_info digsy_mtc_eeprom_info[] __initdata = {
 	{
-		.modalias		= "93xx46",
+		.modalias		= "eeprom-93xx46",
 		.max_speed_hz		= 1000000,
 		.bus_num		= EE_SPI_BUS_NUM,
 		.chip_select		= 0,
 		.mode			= SPI_MODE_0,
-		.platform_data		= &digsy_mtc_eeprom_data,
 	},
 };
 
@@ -89,15 +80,18 @@ static int __init digsy_mtc_eeprom_devices_init(void)
 {
 	int ret;
 
-	ret = gpio_request_one(GPIO_EEPROM_OE, GPIOF_OUT_INIT_HIGH,
-				"93xx46 EEPROMs OE");
-	if (ret) {
-		pr_err("can't request gpio %d\n", GPIO_EEPROM_OE);
-		return ret;
-	}
 	gpiod_add_lookup_table(&eeprom_spi_gpiod_table);
 	spi_register_board_info(digsy_mtc_eeprom_info,
 				ARRAY_SIZE(digsy_mtc_eeprom_info));
-	return platform_device_register(&digsy_mtc_eeprom);
+
+	ret = device_add_software_node(&digsy_mtc_eeprom.dev, &digsy_mtc_spi_node);
+	if (ret)
+		return ret;
+
+	ret = platform_device_register(&digsy_mtc_eeprom);
+	if (ret)
+		device_remove_software_node(&digsy_mtc_eeprom.dev);
+
+	return ret;
 }
 device_initcall(digsy_mtc_eeprom_devices_init);
-- 
2.43.0.rc1.1336.g36b5255a03ac


