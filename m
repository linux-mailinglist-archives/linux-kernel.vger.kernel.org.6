Return-Path: <linux-kernel+bounces-173729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC6D8C04A3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6889828B440
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C7F130ADF;
	Wed,  8 May 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXHcMZ0f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAAA12F582
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194161; cv=none; b=OFR5HIelhP0TKdv/oxPrZ4nNERtuqfqAslyHr2k7yEThqIf5fYo3ZWvPal2lTPOJXKVoRXyjprxZGOaXReb6WObfHoFVjQttLV8V1OXyqk3Fg1r4hgSG9uzOwrNRSNWdMABTV/y339pAqNu8K4oaxfeSyr4ABBHgYz231EWIYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194161; c=relaxed/simple;
	bh=hd+FSPktwPD2NcYKRreZq3cQ1ikz55qeFiAASrNEG50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0yEBkODtMsJZmuGgbtrziIScbcB4iBzPHoSVSbcnLLDzQGT2ibSLCMKnope3LaXEg+yvpxsh4u39omJcJHpCGgt50gMlFb6IouX5vjhilPFDfnCL9RpADZo2KfMOVJ/+K6wIuWGaSn0QfQYWZudDMkyzAAbS7/y4z4qgLzpI7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXHcMZ0f; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194160; x=1746730160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hd+FSPktwPD2NcYKRreZq3cQ1ikz55qeFiAASrNEG50=;
  b=lXHcMZ0fQM61GHqNmfhwxoRHDuljVJlHeRUMADKckSUP/J3w+A0jHeuL
   QL69VOPpiursSKuL6gFQ/NdWVHM6VEhhEte6jz+wakV6YV6T+k3kvM8r3
   CMpVvQQe4QfrVzZ/KCX4RpQlBcMVKFch1GqLTHWtStQL0RCoPk91UuQpP
   ivXaiWWJ8fYaaVbRNgC5nP31EGXuGkHkMxhG+9CwsJ3JXY7cNxZfn5fE3
   AQ1qPJoDPx/iMck8dOOBa4fIUlVB3dcKAwBxFtwyfuTFprf0udsgc7cnC
   rCRJUrnZvVIqh4qNIfAGnk7/vq6ulA6Co05fNqeQS+aK7suK/IkqD8q1i
   w==;
X-CSE-ConnectionGUID: xS1D0IvYSSyWZaB+i7GxoA==
X-CSE-MsgGUID: ELvcE6P7RsGkeDxf7kZ6VA==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="36457776"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="36457776"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:18 -0700
X-CSE-ConnectionGUID: kq6I8R3mT5CiJjCYFvDp+w==
X-CSE-MsgGUID: iOck02fWSHSZQUgxLuhOAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28957220"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP; 08 May 2024 11:49:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C58CE11F; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 08/10] misc: eeprom_93xx46: Replace explicit castings with proper specifiers
Date: Wed,  8 May 2024 21:47:01 +0300
Message-ID: <20240508184905.2102633-9-andriy.shevchenko@linux.intel.com>
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

There is no need to have an explicit casting when we can simply use
the correct printf() specifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 18a3b534ea73..ac485b2827db 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -162,8 +162,8 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 		ndelay(250);
 
 		if (err) {
-			dev_err(&edev->spi->dev, "read %zu bytes at %d: err. %d\n",
-				nbytes, (int)off, err);
+			dev_err(&edev->spi->dev, "read %zu bytes at %u: err. %d\n",
+				nbytes, off, err);
 			break;
 		}
 
@@ -274,7 +274,8 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 {
 	struct eeprom_93xx46_dev *edev = priv;
 	char *buf = val;
-	int i, ret, step = 1;
+	int ret, step = 1;
+	unsigned int i;
 
 	if (unlikely(off >= edev->size))
 		return -EFBIG;
@@ -301,8 +302,7 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 	for (i = 0; i < count; i += step) {
 		ret = eeprom_93xx46_write_word(edev, &buf[i], off + i);
 		if (ret) {
-			dev_err(&edev->spi->dev, "write failed at %d: %d\n",
-				(int)off + i, ret);
+			dev_err(&edev->spi->dev, "write failed at %u: %d\n", off + i, ret);
 			break;
 		}
 	}
-- 
2.43.0.rc1.1336.g36b5255a03ac


