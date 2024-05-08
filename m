Return-Path: <linux-kernel+bounces-173733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 747468C04A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3007328BB0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CC213173B;
	Wed,  8 May 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFmEDv+B"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91556130A77
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194163; cv=none; b=gBUiPQQvCTG7bb3dK2OjwybdBUxHXS+kJJL/uTnWyuELcYjq/VbMenw0c2QLYBTUuK8MjUwZ40zcWaO8C/lSOrCKPZX+cN2KxkIEgb/CZmRN5XiHV4LavLVay7wR2eQrypLZFi3NU3cFlmGJ+4iewERO8+t41wJ6ihzBKWFt3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194163; c=relaxed/simple;
	bh=uUPUvRQ+1LpkdemUFxvOO+zjWvpA4NDPnZiawXNIjJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1keXJuctJllD5lrtp9yje7qoONeI4lno9xiT5fX7uFRnOiHOuqa9iV+xlgHx5BA9i7llLHvu8w4r0k+rdvx+8jvL6zE+hJb57wBwjRvLO5rGWOTIrCC81M/A0Q8umIrspmQe/eQx6ltCVhPXibWT3HiFmZ1YwdHQyAds78JNvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFmEDv+B; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194161; x=1746730161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uUPUvRQ+1LpkdemUFxvOO+zjWvpA4NDPnZiawXNIjJ8=;
  b=LFmEDv+BxPvy71UhjyOfS9QY/hj9WU1TZxD2A+eSCjHWqlsGMWIV1tbP
   fEMOwfZX1yDmO62cksaWj8O50TFLQANH4nU3rj7hW8BdZcn4A/Uwpv+dX
   CF06MQLdCiVhhlHc3TO2BgNbcyN36whhkDnT8ccSX9lIE4S/rxnOWJhKa
   nzHvNnbQBX/aOPfjRuwMh8xrUOq0EQpyZGTTxVem47jvxV2fkeMaRl3CW
   6q7zRnNmNMbAKa171ro0bcZ88BoJcZvdx9nY765nTdmnXaTcLVShKRMFn
   U1i//o3uRv9JbiB5TjPOhAKzrLN/UywPNxwer79MIizrPKCtYtrY6eHbf
   Q==;
X-CSE-ConnectionGUID: csMqAdzTSNa0+7JTcQUZAA==
X-CSE-MsgGUID: wpdYyVqOTpefDf0kO6TMKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591038"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591038"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:18 -0700
X-CSE-ConnectionGUID: Qmiqg7hKQDaOWCD+NYBmSw==
X-CSE-MsgGUID: +Jb5DI74T7urCoCk0he8mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024976"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D3A0CEF6; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 09/10] misc: eeprom_93xx46: Use string_choices API instead of ternary operator
Date: Wed,  8 May 2024 21:47:02 +0300
Message-ID: <20240508184905.2102633-10-andriy.shevchenko@linux.intel.com>
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

Use modern string_choices API instead of manually determining the
output using ternary operator.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index ac485b2827db..ad3b3bc054da 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -18,6 +18,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/string_choices.h>
 
 #include <linux/nvmem-provider.h>
 
@@ -200,8 +201,8 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 		bits += 2;
 	}
 
-	dev_dbg(&edev->spi->dev, "ew%s cmd 0x%04x, %d bits\n",
-			is_on ? "en" : "ds", cmd_addr, bits);
+	dev_dbg(&edev->spi->dev, "ew %s cmd 0x%04x, %d bits\n",
+		str_enable_disable(is_on), cmd_addr, bits);
 
 	t.tx_buf = &cmd_addr;
 	t.len = 2;
@@ -217,8 +218,8 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 	/* have to wait at least Tcsl ns */
 	ndelay(250);
 	if (ret)
-		dev_err(&edev->spi->dev, "erase/write %sable error %d\n",
-			is_on ? "en" : "dis", ret);
+		dev_err(&edev->spi->dev, "erase/write %s error %d\n",
+			str_enable_disable(is_on), ret);
 
 	gpiod_set_value_cansleep(edev->pdata->select, 0);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


