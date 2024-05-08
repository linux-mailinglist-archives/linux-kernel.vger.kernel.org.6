Return-Path: <linux-kernel+bounces-173730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1818C04A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2A11F25065
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73E130E32;
	Wed,  8 May 2024 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SXTUH8U0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060212F5B3
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715194161; cv=none; b=DPSUdo0rTQgljoKvk3wqIgoHdpqYGJVYUotwxEhJJ3OIUEO+S7owAOuk79DToDU+ZmUAtQ6pgdPc7eAX2v03aiJ/0r04ob4enBFD3tV9EIxdB02WjyUnzOKeFkma92kZ7Eh7LpelVhGCR/0F28ZR6+5Z8xsjAinSrQq8QKydX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715194161; c=relaxed/simple;
	bh=eokxhcRPfOdt4CQjToH0FzQ/z/QnbnZ6/eXOMoDsJlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8Qw1is+MJ7ya6o8th9iI2lqVT9MdYBUaDHrBrBDS4AEzXNXAInqH3NZW3qeFkm/qAdaJ4+oTfTLKGZPmqGH4PKrGweuqGmsiAokNoK+BDgkfqfWia5TBAyK1qTHQTHkn/qWbdJN69+wm7IwPm4ovL7P9/gHeubfhrObohhlBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SXTUH8U0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715194159; x=1746730159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eokxhcRPfOdt4CQjToH0FzQ/z/QnbnZ6/eXOMoDsJlQ=;
  b=SXTUH8U0tmCmfI5BSl5a2XmuGk/0HUOm9JPGzqrkm5fHeo7AI30IbGJj
   +BdjQCmz9my37MWw2yGmIwObPEKKCU5j3JMN6fcdCWoTsLQvONNwY1Gcb
   BRIHhxxgpdsPBTOVxtdoyQuHLGK6CgVo7VtxLkcnMezU8rRxI8ToIN/0N
   x3h4CYEGV68J5A4Us3OT4nHyd6gSYD4Vom2ObpxwnCLccs4WJuRticnaY
   biGZsTs0b6HojWNm8yLpcWaWPt9UzHPQLhOKmnA07ja7o7cSQKC5hp3Ci
   HNWLdhVaxDH6uVuKNf7e05hvmxFmcpNZL0aTS950H+fm/mRljkzgnr7M7
   g==;
X-CSE-ConnectionGUID: tzvfWUyeRxOb7OlnM46jAQ==
X-CSE-MsgGUID: 8rD9lYFlSMGD8oPF7RIu+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11067"; a="28591026"
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="28591026"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 11:49:17 -0700
X-CSE-ConnectionGUID: HgQzH7tOR3WZ1acLJpuqsQ==
X-CSE-MsgGUID: Sl+E7NX2QjS2++BdTXMHDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,145,1712646000"; 
   d="scan'208";a="29024972"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 08 May 2024 11:49:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B30A9C40; Wed, 08 May 2024 21:49:12 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v1 06/10] misc: eeprom_93xx46: Use spi_message_init_with_transfers()
Date: Wed,  8 May 2024 21:46:59 +0300
Message-ID: <20240508184905.2102633-7-andriy.shevchenko@linux.intel.com>
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

Replace open coded spi_message_init_with_transfers().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 34 +++++++++++------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index b6d699c1cd39..3f885bac72c2 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -5,6 +5,7 @@
  * (C) 2011 DENX Software Engineering, Anatolij Gustschin <agust@denx.de>
  */
 
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -124,7 +125,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 
 	while (count) {
 		struct spi_message m;
-		struct spi_transfer t[2] = { { 0 } };
+		struct spi_transfer t[2] = {};
 		u16 cmd_addr = OP_READ << edev->addrlen;
 		size_t nbytes = count;
 
@@ -146,17 +147,15 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 			bits += 1;
 		}
 
-		spi_message_init(&m);
-
 		t[0].tx_buf = (char *)&cmd_addr;
 		t[0].len = 2;
 		t[0].bits_per_word = bits;
-		spi_message_add_tail(&t[0], &m);
 
 		t[1].rx_buf = buf;
 		t[1].len = count;
 		t[1].bits_per_word = 8;
-		spi_message_add_tail(&t[1], &m);
+
+		spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
 
 		err = spi_sync(edev->spi, &m);
 		/* have to wait at least Tcsl ns */
@@ -183,7 +182,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 {
 	struct spi_message m;
-	struct spi_transfer t;
+	struct spi_transfer t = {};
 	int bits, ret;
 	u16 cmd_addr;
 
@@ -204,13 +203,11 @@ static int eeprom_93xx46_ew(struct eeprom_93xx46_dev *edev, int is_on)
 	dev_dbg(&edev->spi->dev, "ew%s cmd 0x%04x, %d bits\n",
 			is_on ? "en" : "ds", cmd_addr, bits);
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof(t));
-
 	t.tx_buf = &cmd_addr;
 	t.len = 2;
 	t.bits_per_word = bits;
-	spi_message_add_tail(&t, &m);
+
+	spi_message_init_with_transfers(&m, &t, 1);
 
 	mutex_lock(&edev->lock);
 
@@ -234,7 +231,7 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 			 const char *buf, unsigned off)
 {
 	struct spi_message m;
-	struct spi_transfer t[2];
+	struct spi_transfer t[2] = {};
 	int bits, data_len, ret;
 	u16 cmd_addr;
 
@@ -256,18 +253,15 @@ eeprom_93xx46_write_word(struct eeprom_93xx46_dev *edev,
 
 	dev_dbg(&edev->spi->dev, "write cmd 0x%x\n", cmd_addr);
 
-	spi_message_init(&m);
-	memset(t, 0, sizeof(t));
-
 	t[0].tx_buf = (char *)&cmd_addr;
 	t[0].len = 2;
 	t[0].bits_per_word = bits;
-	spi_message_add_tail(&t[0], &m);
 
 	t[1].tx_buf = buf;
 	t[1].len = data_len;
 	t[1].bits_per_word = 8;
-	spi_message_add_tail(&t[1], &m);
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
 
 	ret = spi_sync(edev->spi, &m);
 	/* have to wait program cycle time Twc ms */
@@ -325,7 +319,7 @@ static int eeprom_93xx46_write(void *priv, unsigned int off,
 static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 {
 	struct spi_message m;
-	struct spi_transfer t;
+	struct spi_transfer t = {};
 	int bits, ret;
 	u16 cmd_addr;
 
@@ -345,13 +339,11 @@ static int eeprom_93xx46_eral(struct eeprom_93xx46_dev *edev)
 
 	dev_dbg(&edev->spi->dev, "eral cmd 0x%04x, %d bits\n", cmd_addr, bits);
 
-	spi_message_init(&m);
-	memset(&t, 0, sizeof(t));
-
 	t.tx_buf = &cmd_addr;
 	t.len = 2;
 	t.bits_per_word = bits;
-	spi_message_add_tail(&t, &m);
+
+	spi_message_init_with_transfers(&m, &t, 1);
 
 	mutex_lock(&edev->lock);
 
-- 
2.43.0.rc1.1336.g36b5255a03ac


