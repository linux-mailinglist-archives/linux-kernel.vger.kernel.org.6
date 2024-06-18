Return-Path: <linux-kernel+bounces-220121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADCB90DCE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 301482846B7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DFE16DC3B;
	Tue, 18 Jun 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3YKNQAq"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79B716D4DF;
	Tue, 18 Jun 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740436; cv=none; b=em/2FsuhWVLKMpyRARQlqvn/7MmgvLkhGEu6l/7eDqPxmdk0kHWfYx6wCopCE5ll5/A90BfTM1wF2y2y3TF76qo1XZXsS+mb4EWMaMQpSrUAYd1i/QOfwbYtQenSzNPvAmd+WterGqfPEGI8os1oUfhj2Y79ueyTX5nl1pKZYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740436; c=relaxed/simple;
	bh=QCWiy8S2iBkH0R0SO+YmV+SSyy1AmkG+MWl4tYbfKik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKevoaHO1KDTlFW5IibQzUgQdyQCNG2QgldNHEJmGxwP2w+SdXTh826Tp9n3YA0CxMXsLQZ7xIqqygIOVkvDr1zS74ZyMbtD0Aww7ZLRJQxJFLTxosH1u668QPiALdku5Wh2ztcrjRkVWNi6fzW+O0uOHa31wFADk7GVZULqFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3YKNQAq; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2c7a6da20f2so615063a91.0;
        Tue, 18 Jun 2024 12:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740433; x=1719345233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TutLNJ37uRVCH3BzXMcNA2MKiY+pMX5ozT8SeedjlP8=;
        b=B3YKNQAqJGNvQF3t+JxG/3Uk9c2Fn4F5RNvGTzkXCNUFGYsB1nXTjJvnmDPyVZwMJ2
         DcKqvf08+LWLS27SnhdNO8a1NIVp6a2EDE+l2rIUkmAsAhfnjzaQbEA8BWHeU1V+YjvW
         r3B4jkJUdCBko+dFeA2GbcdydguP+HvV3FaOYtToExI8iU264+rC/AGwd0owOxnL9x8/
         Zvv7HLHcl/zfP7Vs34pdYbwLf+esAT8tO+ZD8KDD5i1aAKYfLDZDgGkWsD5tcW2V4Y0o
         pQ0hNdTqEFmrV/Hsqu1Wks5teLp5yrEdE7Nu4OWG/AQdAqzoWf121lQVroC+KJXnicqG
         4S/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740433; x=1719345233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TutLNJ37uRVCH3BzXMcNA2MKiY+pMX5ozT8SeedjlP8=;
        b=MJlKfqIUQ9/59O8Ig2VjsS1FrPRNnu+F3d2zwmB/HXC59RJ3G4O7Cf747DObCzT5ip
         +fbhDUP7WCh+zHaLu35oZocQIeBuaBZcoC0wLCLbVRhy2guHD3ob9/PbQtMHggRSWeN6
         HHgnTJnC3UKYzh1oxSsvxxCwu8Embgth54XuD4X0LLNEP33xt8RXruba4/FdW3QMRfqn
         GMaa5RsH9L0rOzo/Shzc5s5JKLD4uxK3Kkw3Z9nBOrKg6jXapsHDyvNV8xThqBrqFwMu
         t85qlEFLjTSuM16j/4C3CppOZyd8eNa0jsUjqyGXXgmHoZW2t0MCRHzh0HsxlRQj1+0z
         Q1tw==
X-Gm-Message-State: AOJu0YzVynYvwpgU4GjNnJ5uv/nekHhWXbH2v7Mx65ZZ2P4RR+k0YUdy
	HQS7zGxcB9wCLS18uxSIHbv6nqM/GKsWicE0t8qG4n/e2SQBmgkdeKBqtA==
X-Google-Smtp-Source: AGHT+IGopO9q2SH+xzHUoaChE+56XCp/6NqPcQmOwVlMrCtlRrv+f+adCZSLWpEVe4Yqqf4HqzKjcA==
X-Received: by 2002:a17:90a:df06:b0:2c3:1d61:ca41 with SMTP id 98e67ed59e1d1-2c7b5b7e2c5mr733499a91.17.1718740433547;
        Tue, 18 Jun 2024 12:53:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c50c911c92sm6130224a91.49.2024.06.18.12.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:53:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Armin Wolf <W_Armin@gmx.de>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Kozachuk <skozachuk@google.com>,
	John Hamrick <johnham@google.com>,
	Chris Sarra <chrissarra@google.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH v2 1/3] hwmon: (spd5118) Use regmap to implement paging
Date: Tue, 18 Jun 2024 12:53:46 -0700
Message-Id: <20240618195348.1670547-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618195348.1670547-1-linux@roeck-us.net>
References: <20240618195348.1670547-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using regmap for paging significantly improves caching since the regmap
cache no longer needs to be cleared after changing the page, so let's
use it.

Suggested-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/hwmon/spd5118.c | 47 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index ac94a6779360..d405c5ef755d 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -382,45 +382,19 @@ static const struct hwmon_chip_info spd5118_chip_info = {
 
 /* nvmem */
 
-static int spd5118_nvmem_set_page(struct regmap *regmap, int page)
-{
-	unsigned int old_page;
-	int err;
-
-	err = regmap_read(regmap, SPD5118_REG_I2C_LEGACY_MODE, &old_page);
-	if (err)
-		return err;
-
-	if (page != (old_page & SPD5118_LEGACY_MODE_MASK)) {
-		/* Update page and explicitly select 1-byte addressing */
-		err = regmap_update_bits(regmap, SPD5118_REG_I2C_LEGACY_MODE,
-					 SPD5118_LEGACY_MODE_MASK, page);
-		if (err)
-			return err;
-
-		/* Selected new NVMEM page, drop cached data */
-		regcache_drop_region(regmap, SPD5118_EEPROM_BASE, 0xff);
-	}
-
-	return 0;
-}
-
 static ssize_t spd5118_nvmem_read_page(struct regmap *regmap, char *buf,
 				       unsigned int offset, size_t count)
 {
+	int addr = (offset >> SPD5118_PAGE_SHIFT) * 0x100 + SPD5118_EEPROM_BASE;
 	int err;
 
-	err = spd5118_nvmem_set_page(regmap, offset >> SPD5118_PAGE_SHIFT);
-	if (err)
-		return err;
-
 	offset &= SPD5118_PAGE_MASK;
 
 	/* Can't cross page boundaries */
 	if (offset + count > SPD5118_PAGE_SIZE)
 		count = SPD5118_PAGE_SIZE - offset;
 
-	err = regmap_bulk_read(regmap, SPD5118_EEPROM_BASE + offset, buf, count);
+	err = regmap_bulk_read(regmap, addr + offset, buf, count);
 	if (err)
 		return err;
 
@@ -515,13 +489,28 @@ static bool spd5118_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct regmap_range_cfg spd5118_regmap_range_cfg[] = {
+	{
+	.selector_reg   = SPD5118_REG_I2C_LEGACY_MODE,
+	.selector_mask  = SPD5118_LEGACY_PAGE_MASK,
+	.selector_shift = 0,
+	.window_start   = 0,
+	.window_len     = 0x100,
+	.range_min      = 0,
+	.range_max      = 0x7ff,
+	},
+};
+
 static const struct regmap_config spd5118_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = 0xff,
+	.max_register = 0x7ff,
 	.writeable_reg = spd5118_writeable_reg,
 	.volatile_reg = spd5118_volatile_reg,
 	.cache_type = REGCACHE_MAPLE,
+
+	.ranges = spd5118_regmap_range_cfg,
+	.num_ranges = ARRAY_SIZE(spd5118_regmap_range_cfg),
 };
 
 static int spd5118_probe(struct i2c_client *client)
-- 
2.39.2


