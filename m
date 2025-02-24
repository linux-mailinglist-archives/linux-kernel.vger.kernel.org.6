Return-Path: <linux-kernel+bounces-529685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1660A429DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331C83B93A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08D6265CB1;
	Mon, 24 Feb 2025 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjYK+8y1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AE264F94
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418257; cv=none; b=jWRhc7nZKqOcrtI8APqRq05JXp7rwYgHULZpTLunMi8+4RKj5BxTM+Bk6Rczktz0cBoTo6hKd+IzgZaJ/UyhSjZZZPPs0OeTHq+N3jRUEeNrwzeP4y8MODsTK7+E5nr9t7sYahja0F86ICYXmJDWRGhhtVsf+qFHa9VvteI713A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418257; c=relaxed/simple;
	bh=DNwyL6xiGSyVGfSbFsxEePnHML6Gdi3CH6tU/PODeFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yhf4/eJCvfaoYmU6lYIo3Vr8YRUArTP+CBp3hprP9BnQNANGlzz4GH3YGDCPc8+yJCFgEuq4sEKvXCOx/bMvCi394WFDZ/3nNcL4k2kNHHfZd+20VSFsPVwsXp0qT32pogQpFWjzcsVJqVtCGqsXQccMcYzTa8CE956Zi6FGDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjYK+8y1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740418256; x=1771954256;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNwyL6xiGSyVGfSbFsxEePnHML6Gdi3CH6tU/PODeFg=;
  b=mjYK+8y1ii2zrNTZbkxdL/gLavYAsx+f/45RlAVau5uTrpR7KgfO5xqW
   zNtBYlh15/5KtXLvDmSpx5pyf/zo4E53sAWTI6vn49xaRbqh7VuSQj0xj
   7TEucvVeW2/nLndHgtQMDU4O0SeChkC8HxxgjjklqiioiUJgp1xmMuP0q
   ESgUSi1YQnHIYsGLfDZv0Ls9crRguLtAEaVEywPQOVMMKOliJlwGMRssD
   FhF0bxDoKK/+VYh3Dxymk8WSRBKjWlqXgu4Yo4bxwGr2w2cdtQwbp8hBI
   /I4FrlJVfwC9B//MtZRCwrvRhNRvdFT53JkAqj1/TwiQkG6eVYOTxDj6h
   w==;
X-CSE-ConnectionGUID: eTMC/hHOSLe10OgfX1iT+A==
X-CSE-MsgGUID: akwE2oYMTQCJy+aCkXhZmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="66555702"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="66555702"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 09:30:42 -0800
X-CSE-ConnectionGUID: URbx4UYASkiithyAk3BetA==
X-CSE-MsgGUID: CxIey2w5SDCoRHT4zxnJng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115875688"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 24 Feb 2025 09:30:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2687B529; Mon, 24 Feb 2025 19:30:20 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Willy Tarreau <willy@haproxy.com>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v1 6/7] auxdisplay: hd44780: Call charlcd_alloc() from hd44780_common_alloc()
Date: Mon, 24 Feb 2025 19:27:43 +0200
Message-ID: <20250224173010.219024-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
In-Reply-To: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HD44780 APIs are operate on struct charlcd object. Moreover, the current users
always call charlcd_alloc() and hd44780_common_alloc(). Make the latter call
the former, so eliminate the additional allocation, make it consistent with
the rest of API and avoid duplication.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/auxdisplay/hd44780.c        | 18 ++++++------------
 drivers/auxdisplay/hd44780_common.c | 14 ++++++++------
 drivers/auxdisplay/hd44780_common.h |  4 ++--
 drivers/auxdisplay/panel.c          | 17 +++++------------
 4 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index ef38cb7bf13d..cef42656c4b0 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -222,20 +222,17 @@ static int hd44780_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	hdc = hd44780_common_alloc();
-	if (!hdc)
-		return -ENOMEM;
-
-	lcd = charlcd_alloc(0);
+	lcd = hd44780_common_alloc();
 	if (!lcd)
-		goto fail1;
+		return -ENOMEM;
 
 	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
 	if (!hd)
 		goto fail2;
 
+	hdc = lcd->drvdata;
 	hdc->hd44780 = hd;
-	lcd->drvdata = hdc;
+
 	for (i = 0; i < ifwidth; i++) {
 		hd->pins[base + i] = devm_gpiod_get_index(dev, "data", i,
 							  GPIOD_OUT_LOW);
@@ -313,9 +310,7 @@ static int hd44780_probe(struct platform_device *pdev)
 fail3:
 	kfree(hd);
 fail2:
-	charlcd_free(lcd);
-fail1:
-	hd44780_common_free(hdc);
+	hd44780_common_free(lcd);
 	return ret;
 }
 
@@ -326,8 +321,7 @@ static void hd44780_remove(struct platform_device *pdev)
 
 	charlcd_unregister(lcd);
 	kfree(hdc->hd44780);
-	hd44780_common_free(hdc);
-	charlcd_free(lcd);
+	hd44780_common_free(lcd);
 }
 
 static const struct of_device_id hd44780_of_match[] = {
diff --git a/drivers/auxdisplay/hd44780_common.c b/drivers/auxdisplay/hd44780_common.c
index 3f8a496ccb8e..fb340d18fcad 100644
--- a/drivers/auxdisplay/hd44780_common.c
+++ b/drivers/auxdisplay/hd44780_common.c
@@ -351,24 +351,26 @@ int hd44780_common_redefine_char(struct charlcd *lcd, char *esc)
 }
 EXPORT_SYMBOL_GPL(hd44780_common_redefine_char);
 
-struct hd44780_common *hd44780_common_alloc(void)
+struct charlcd *hd44780_common_alloc(void)
 {
 	struct hd44780_common *hd;
+	struct charlcd *lcd;
 
-	hd = kzalloc(sizeof(*hd), GFP_KERNEL);
-	if (!hd)
+	lcd = charlcd_alloc(sizeof(*hd));
+	if (!lcd)
 		return NULL;
 
+	hd = lcd->drvdata;
 	hd->ifwidth = 8;
 	hd->bwidth = DEFAULT_LCD_BWIDTH;
 	hd->hwidth = DEFAULT_LCD_HWIDTH;
-	return hd;
+	return lcd;
 }
 EXPORT_SYMBOL_GPL(hd44780_common_alloc);
 
-void hd44780_common_free(struct hd44780_common *hd)
+void hd44780_common_free(struct charlcd *lcd)
 {
-	kfree(hd);
+	charlcd_free(lcd);
 }
 EXPORT_SYMBOL_GPL(hd44780_common_free);
 
diff --git a/drivers/auxdisplay/hd44780_common.h b/drivers/auxdisplay/hd44780_common.h
index fe1386e3cf79..4c87f55722b6 100644
--- a/drivers/auxdisplay/hd44780_common.h
+++ b/drivers/auxdisplay/hd44780_common.h
@@ -31,5 +31,5 @@ int hd44780_common_fontsize(struct charlcd *lcd, enum charlcd_fontsize size);
 int hd44780_common_lines(struct charlcd *lcd, enum charlcd_lines lines);
 int hd44780_common_redefine_char(struct charlcd *lcd, char *esc);
 
-struct hd44780_common *hd44780_common_alloc(void);
-void hd44780_common_free(struct hd44780_common *hd);
+struct charlcd *hd44780_common_alloc(void);
+void hd44780_common_free(struct charlcd *lcd);
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index aa1d03fef22e..91ccb9789d43 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -831,18 +831,12 @@ static void lcd_init(void)
 	struct charlcd *charlcd;
 	struct hd44780_common *hdc;
 
-	hdc = hd44780_common_alloc();
-	if (!hdc)
+	charlcd = hd44780_common_alloc();
+	if (!charlcd)
 		return;
 
-	charlcd = charlcd_alloc(0);
-	if (!charlcd) {
-		hd44780_common_free(hdc);
-		return;
-	}
-
+	hdc = charlcd->drvdata;
 	hdc->hd44780 = &lcd;
-	charlcd->drvdata = hdc;
 
 	/*
 	 * Init lcd struct with load-time values to preserve exact
@@ -1664,7 +1658,7 @@ static void panel_attach(struct parport *port)
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-	charlcd_free(lcd.charlcd);
+	hd44780_common_free(lcd.charlcd);
 	lcd.charlcd = NULL;
 	parport_unregister_device(pprt);
 	pprt = NULL;
@@ -1691,8 +1685,7 @@ static void panel_detach(struct parport *port)
 	if (lcd.enabled) {
 		charlcd_unregister(lcd.charlcd);
 		lcd.initialized = false;
-		hd44780_common_free(lcd.charlcd->drvdata);
-		charlcd_free(lcd.charlcd);
+		hd44780_common_free(lcd.charlcd);
 		lcd.charlcd = NULL;
 	}
 
-- 
2.45.1.3035.g276e886db78b


