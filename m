Return-Path: <linux-kernel+bounces-173731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82B8C04A6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F8EB2648E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73447130E47;
	Wed,  8 May 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwT2gHw2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884912FF73
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194161; cv=none; b=BNY+AW49zMlUJyw+BHaU6Se28ou+jZYCaseNd9QYKA3HdOQBIKLynNrQO3bQMaOB86Qw8fhsNHcWvAw1EaAcwNN1U8VM/su+UUiRY3BKauAIBMPFFMp2zMogurzSp3S+qoEn93mNof1hq8hikVDJLHq6JPCIafYu0eCvaE4VfJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194161; c=relaxed/simple;
	bh=gd7PMl27AoVAQ2ia5Bgo3BitWkSsgq61mZW0eRFY/TM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6UtF5FCMnN13Jwf2O5ARjjVOqUdzb+4bgse3lx9soihMOqm+7Rf5K457y5hrdobXeo7FIWevVB1XtwX3JlcZCoNN071L2RQBZgGhg+vMgxTuaNh/ael5l3mZNJYwEMg1GBcOqb97ESkTXRdxhleGOcdlT9xev9u+4tLbhf2u/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwT2gHw2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194160; x=1746730160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gd7PMl27AoVAQ2ia5Bgo3BitWkSsgq61mZW0eRFY/TM=;
  b=BwT2gHw2IpJP14SwhSnVD+GFCAPVmimoqQe6UlcEXkqiXTOP29hP744y
   z6ZcrBYk72B7mmP1iPpF2ZTEdnOzF8oTBbhZRb2GckeqKj5sBdqWZ/Tk0
   gBRUkIzGgrUcmpQ98QSDuf28ovIW2o8kjIPadgC72X/Txw9vYQ6S68Ejp
   ZKyj4qd8sv+PZ8P2buBHViLkOIjT+G0iVkuQzJEOJ3LdnBlZcWtK3Wd0U
   b4i2U/iNjncEP+9/SXsiFcgnRW5Q23RAvtzzqJ/Pi9FyD7JEVH0afdmhF
   zb++CWQl7iz0GFxLbe52SoOwpH5Y+rNDloQGFKjgSO+XB4dH+g/DT88eD
   g==;
X-CSE-ConnectionGUID: Bndd3cpNQzWMUkmP792+HA==
X-CSE-MsgGUID: oQcu8kSyQK2Q2PO8jcFqyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591030"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591030"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:17 -0700
X-CSE-ConnectionGUID: yUhMmsEfSPeoIoDAIhI8Bg==
X-CSE-MsgGUID: 4LUFf3YBRBKx5D2fS5IBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024974"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BC1A3D5A; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 07/10] misc: eeprom_93xx46: Convert to use kstrtox()
Date: Wed,  8 May 2024 21:47:00 +0300
Message-ID: <20240508184905.2102633-8-andriy.shevchenko@linux.intel.com>
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

sscanf() is a heavy one and moreover requires additional boundary checks.
Convert driver to use kstrtobool() in eeprom_93xx46_store_erase().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 3f885bac72c2..18a3b534ea73 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -10,7 +10,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
 #include <linux/log2.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -366,9 +366,13 @@ static ssize_t eeprom_93xx46_store_erase(struct device *dev,
 					 const char *buf, size_t count)
 {
 	struct eeprom_93xx46_dev *edev = dev_get_drvdata(dev);
-	int erase = 0, ret;
+	bool erase;
+	int ret;
+
+	ret = kstrtobool(buf, &erase);
+	if (ret)
+		return ret;
 
-	sscanf(buf, "%d", &erase);
 	if (erase) {
 		ret = eeprom_93xx46_ew(edev, 1);
 		if (ret)
-- 
2.43.0.rc1.1336.g36b5255a03ac


