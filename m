Return-Path: <linux-kernel+bounces-173732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E38C04A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B853728B589
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F3B130E4F;
	Wed,  8 May 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Of4ME6Vz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03512FF92
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194161; cv=none; b=f54AEA0oxxrgZ53dzfjLWtOemc38ZEvRv15AvApUUNh4DwKAI4M5RB9WtiNBRQonwLd8XAqOfP+7gfux/XcHNCzPLGOr0Hvl1SlTp44faTsJRv5v073u6auo+ge+Cc9SF7ZF7GYkeCJ+R9B5uOsKFYmsadHFk1hKF48DU6EpLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194161; c=relaxed/simple;
	bh=0f/yTpdDLdJ89hKtfdhDwCA8ZKZ27aJDEXdaL+qXlGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEsarmgfMXN/j9jZnoJvLXdU/r97dlUlJEvCBBSHkTYBXjWMSv0fk2DzTw2nzfcNzBR/UpiokJ55Er/etF0uqxgXOT84/B6FNOMPbE8RlLhtzSd1GUhrcsiw4wkgVuxylAu1lHzmdKOTjNLWJVdOxvaPZNmeCAurwMZHubf5TB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Of4ME6Vz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194160; x=1746730160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0f/yTpdDLdJ89hKtfdhDwCA8ZKZ27aJDEXdaL+qXlGY=;
  b=Of4ME6Vz85UvRXwxNo4TBqgUhXAFsNHttHIK/5CVSx/LsRWhyFEDbMa/
   3A/OaoK2FmZYIGZqzFr1xYorFQaAsYccfLr2c9XL6udzuON7Bz1GugPRX
   pDpdNQu2IPFRxBx3sh7zRKDJuBMxg4gV/zb3hoMykrL9qcHqF5dwodkmD
   18OyCqyA2gCb4PfuEmLab37Myoy+FlypH9dH4qy6D0+VAfMivTmuejezE
   uvlBhp4JgP9QluDAa8l4YVwqKQ23JTh7yTnRKW42FqqLCrMu2pCWgMgK6
   FsRX7KbdvwwUXrZdjg5/pMlK1uAiqCcxLphfReAZA/wC1oRupCrNvUfXK
   w==;
X-CSE-ConnectionGUID: wqKJG/yNQaOn3x2aOUmD8Q==
X-CSE-MsgGUID: gvIb/F8xQlmTlMrr39/SpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591034"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591034"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:18 -0700
X-CSE-ConnectionGUID: KSwh+shwTyaTyw1ml005ug==
X-CSE-MsgGUID: aMib/VTzSGOR8EELSOUWng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024975"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DD3FEE81; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 10/10] misc: eeprom_93xx46: Convert to DEVICE_ATTR_WO()
Date: Wed,  8 May 2024 21:47:03 +0300
Message-ID: <20240508184905.2102633-11-andriy.shevchenko@linux.intel.com>
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

Use DEVICE_ATTR_WO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index ad3b3bc054da..e2221be88445 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -362,9 +362,8 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 	return ret;
 }
 
-static ssize_t eeprom_93xx46_store_erase(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
+static ssize_t erase_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct eeprom_93xx46_dev *edev = dev_get_drvdata(dev);
 	bool erase;
@@ -387,7 +386,7 @@ static ssize_t eeprom_93xx46_store_erase(struct device *dev,
 	}
 	return count;
 }
-static DEVICE_ATTR(erase, S_IWUSR, NULL, eeprom_93xx46_store_erase);
+static DEVICE_ATTR_WO(erase);
 
 static const struct of_device_id eeprom_93xx46_of_table[] = {
 	{ .compatible = "eeprom-93xx46", .data = &at93c46_data, },
-- 
2.43.0.rc1.1336.g36b5255a03ac


