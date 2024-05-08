Return-Path: <linux-kernel+bounces-173728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D918C04A2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2755DB26204
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282F130AC1;
	Wed,  8 May 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AjYg4F9Y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E695312E1FF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194160; cv=none; b=SL1W8lllUYsnFEkW2iIcURz2LZ/zN51aa1OxgQ7eJP4QvlP5PkKBEgaYdfzGMSRkSr08OERoM1yHuFTCK3aey4NSBtI90eew/9PpvANjC866qA0+wdlZxTOLqs2DtZPEmNO7TJFTlUTP6s32AHkm5OR4cmwiJ5B0+CZQU0n68rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194160; c=relaxed/simple;
	bh=XHHtXSHKttwhznEXOospov8JgLdUaQ19JoW77OK0grI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZPR8TlHwf6i7O2XUiqVNuowMiF8/QX7wJpOUqWTZEoc1pYHPpKhArNIgtgpbgDm2YTQFEPIXnaoD2gCSKb2fRaAeRMyk33/m+1lTVxOnh+hxq2Ree1gV10WK7ARU5FUt3ogFjQEBs8axyxNXNmcIPYgF5NOqmgRH1vtMcpnf6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AjYg4F9Y; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194159; x=1746730159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHHtXSHKttwhznEXOospov8JgLdUaQ19JoW77OK0grI=;
  b=AjYg4F9Y20FMU4ha92agNrZ9dZmjk7SYJOEcym0aRp6lUNLJwFgUBeeA
   cEtrEYKt/fQzToNqZeDlbvyHpNxxTMD58T3YX9PD6ZIDNk+WI2BbSiR27
   +GtOmsOWqpjOj8Qu2Un+N0pnTTHHPcSJlmecTx85Gq0W2fmoybNmCNyXJ
   2BYUiD73OHsOnzTLSTcXX+rrONh9LDTWa7Zhj6Nn+Ex6kGqDaqsps2rRq
   BK1pxzce0t401zuvKko55issBumPPhl0X8Dl4qsUN4ECMHbrrSIX3lQXW
   LUlqKXXyEgg+ZGnz2ksQhVeNxKCKlfReDw6QR8cinlWH0e6GdnRNFg2eT
   A==;
X-CSE-ConnectionGUID: zqjFRHJcRvuOsIhAPSeuJQ==
X-CSE-MsgGUID: z72ECz8VSMivdqTe4I/8Fw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36457772"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36457772"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:18 -0700
X-CSE-ConnectionGUID: JFtiCinyRbelhm2ndi5ecA==
X-CSE-MsgGUID: YuFuB+kfTZ6l4B8OQS387w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28957218"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2024 11:49:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id AB84D83F; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 05/10] misc: eeprom_93xx46: Remove ->prepare() and ->finish() customisation
Date: Wed,  8 May 2024 21:46:58 +0300
Message-ID: <20240508184905.2102633-6-andriy.shevchenko@linux.intel.com>
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

Currently there is only one way how chip is prepared and unprepared
for an operation. Drop unnecessary customisation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 48 +++++------------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index a5a043ddedbb..b6d699c1cd39 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -37,12 +37,6 @@ struct eeprom_93xx46_platform_data {
 /* Add extra cycle after address during a read */
 #define EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE		BIT(2)
 
-	/*
-	 * optional hooks to control additional logic
-	 * before and after spi transfer.
-	 */
-	void (*prepare)(void *);
-	void (*finish)(void *);
 	struct gpio_desc *select;
 };
 
@@ -123,8 +117,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 
 	mutex_lock(&edev->lock);
 
-	if (edev->pdata->prepare)
-		edev->pdata->prepare(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 1);
 
 	/* The opcode in front of the address is three bits. */
 	bits = edev->addrlen + 3;
@@ -180,8 +173,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 		count -= nbytes;
 	}
 
-	if (edev->pdata->finish)
-		edev->pdata->finish(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 0);
 
 	mutex_unlock(&edev->lock);
 
@@ -222,8 +214,7 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 
 	mutex_lock(&edev->lock);
 
-	if (edev->pdata->prepare)
-		edev->pdata->prepare(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 1);
 
 	ret = spi_sync(edev->spi, &m);
 	/* have to wait at least Tcsl ns */
@@ -232,8 +223,7 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 		dev_err(&edev->spi->dev, "erase/write %sable error %d\n",
 			is_on ? "en" : "dis", ret);
 
-	if (edev->pdata->finish)
-		edev->pdata->finish(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 0);
 
 	mutex_unlock(&edev->lock);
 	return ret;
@@ -312,8 +302,7 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 
 	mutex_lock(&edev->lock);
 
-	if (edev->pdata->prepare)
-		edev->pdata->prepare(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 1);
 
 	for (i = 0; i < count; i += step) {
 		ret = eeprom_93xx46_write_word(edev, &buf[i], off + i);
@@ -324,8 +313,7 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 		}
 	}
 
-	if (edev->pdata->finish)
-		edev->pdata->finish(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 0);
 
 	mutex_unlock(&edev->lock);
 
@@ -336,7 +324,6 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 
 static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 {
-	struct eeprom_93xx46_platform_data *pd = edev->pdata;
 	struct spi_message m;
 	struct spi_transfer t;
 	int bits, ret;
@@ -368,8 +355,7 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 
 	mutex_lock(&edev->lock);
 
-	if (edev->pdata->prepare)
-		edev->pdata->prepare(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 1);
 
 	ret = spi_sync(edev->spi, &m);
 	if (ret)
@@ -377,8 +363,7 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 	/* have to wait erase cycle time Tec ms */
 	mdelay(6);
 
-	if (pd->finish)
-		pd->finish(edev);
+	gpiod_set_value_cansleep(edev->pdata->select, 0);
 
 	mutex_unlock(&edev->lock);
 	return ret;
@@ -407,20 +392,6 @@ static ssize_t eeprom_93xx46_store_erase(struct device *dev,
 }
 static DEVICE_ATTR(erase, S_IWUSR, NULL, eeprom_93xx46_store_erase);
 
-static void select_assert(void *context)
-{
-	struct eeprom_93xx46_dev *edev = context;
-
-	gpiod_set_value_cansleep(edev->pdata->select, 1);
-}
-
-static void select_deassert(void *context)
-{
-	struct eeprom_93xx46_dev *edev = context;
-
-	gpiod_set_value_cansleep(edev->pdata->select, 0);
-}
-
 static const struct of_device_id eeprom_93xx46_of_table[] = {
 	{ .compatible = "eeprom-93xx46", .data = &at93c46_data, },
 	{ .compatible = "atmel,at93c46", .data = &at93c46_data, },
@@ -483,9 +454,6 @@ static int eeprom_93xx46_probe_fw(struct device *dev)
 		return PTR_ERR(pd->select);
 	gpiod_set_consumer_name(pd->select, "93xx46 EEPROMs OE");
 
-	pd->prepare = select_assert;
-	pd->finish = select_deassert;
-
 	data = spi_get_device_match_data(to_spi_device(dev));
 	if (data) {
 		pd->quirks = data->quirks;
-- 
2.43.0.rc1.1336.g36b5255a03ac


