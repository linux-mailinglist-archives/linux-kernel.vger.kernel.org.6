Return-Path: <linux-kernel+bounces-195975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF28D558F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21DE1F22CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8672017C22B;
	Thu, 30 May 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGr8rYHP"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EAD184135;
	Thu, 30 May 2024 22:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108788; cv=none; b=aqQn0MNKcsP7Hd8AF0fFITpxYDNYTnaridjuBlrW3A/jXF9jcqOKC3R1MTCadCftk8uhdrV4Ini2y80SLuZAGmPu6W6WXAW2AjQCrt7FUVGv8eSUkLK1wtP5XC8Ixxc79Br9gsJ0HM25Pm2q6bWauxu+kbwpYQ2f5PAZ7Lb4Bho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108788; c=relaxed/simple;
	bh=ObfyRu7oiPBL1J7xJbM/pHFssCtum2gBV4H+0RGWvNw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JhFDSzKfK0DODNPtL7yTWX90PyVez/jXjQyFkk5G8AZZVt+J9RYI96a4ANvXZQPcsufyIfDFZckHj92U5vkfSlG4TQbi+BoquyxzfoblyVrEwgfVjRe2AISNF82le1LTemScHAmYT/CeEsYniyZsCKvLfWPeT8UmUjJ7TFlQhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGr8rYHP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7024426c75dso206594b3a.1;
        Thu, 30 May 2024 15:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717108786; x=1717713586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RATLX8vwG5qFLWJv5e+WyDP7UKBpMbaga/mz8MYejto=;
        b=nGr8rYHPAGJeG5NFK3wWdsisEj9FFzmssIwUu6rCHXot9GW+0tSbSytwGnELjbC8Wq
         pEgZA63/muyMoQ0+4Al2pFX2+fXRiuz5A3J95+xR8TLBI3EwbNz6rT/cBZ0tlS4LIduN
         dlHnNzFCHfASEEKkpDsNF4VUPoetxYerAFX7n7M0sSzkvcx4SZD4xyFQwg0osEUC58Fd
         +upRhrTTUDwodXnTFxrwOeCbpg0NRWts/7w06t/6ya6ChVGQSUMJ6cJgES30MckrnJPS
         rP4L3tV1Bp+o0buEK+CmBDcoaxB6zHOrwbWhr5FZHYbKd7ngYYsKbue77IhnuO9/ohIX
         agEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717108786; x=1717713586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RATLX8vwG5qFLWJv5e+WyDP7UKBpMbaga/mz8MYejto=;
        b=DpGKaBdVohRu1+NnnHca+RWQ1P9g5F8Cyal2tUJpIlJRfCaSgvSnHX4c9qteHkwyE2
         E64MXCYYVz+2OA3Fd89Grn+5AwXc0zzhE70uCeYwxMf+ImgBymv3EFEULT07GBsQJsi6
         4DJ/Tv9KR87Y1vOIMle8pcyHJCRy3XgMGc/4tGIiZIyMci4uSZMoVRzw7UnaC3kvfOu9
         giq5p4F45QAby75kESwGcNTOWGsdkPLHM9EedxT1cSMMMVaZD3b+9uZCDxOJnipfCNUZ
         b4+ED42D6wedGHc5Dh/HNfBHkeB7pFeYo6y8UgOqa/4c+cxvyTBHfQJaWR+kuNUHPwgA
         i1ww==
X-Forwarded-Encrypted: i=1; AJvYcCUIeFaHhZDQAB6qOW1+gXCE+PWE9DPbenmBf87TlX3X/eqQbk8xeDIbmkoLc8/GynaHTGFBeP9HpTHACdQMQjABRHnHHPLBO+TV9gKr
X-Gm-Message-State: AOJu0YzTYcACUfYrdkpqG8/XeM+9vvTdyP/dFRs3WFbxvi7mCeVFJ9Rl
	llsIOXAPJAR3gRWv12o3P+/g28bCWty+bg2iDE3/jcmbZ09yzfAu9Cw/dg==
X-Google-Smtp-Source: AGHT+IHQl1iqObMs93tbh8ZmfFVhjQn1Q3y0D9ccbNyXE3ce9knFzqcgyPscYR3hQ4UIiXhKiCMP9g==
X-Received: by 2002:a05:6a00:18a9:b0:6ea:b48a:f971 with SMTP id d2e1a72fcca58-702477bd92fmr255317b3a.2.1717108786156;
        Thu, 30 May 2024 15:39:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702423cce7asm227776b3a.40.2024.05.30.15.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 15:39:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/3] hwmon: (spd5118) Add suspend/resume support
Date: Thu, 30 May 2024 15:39:39 -0700
Message-Id: <20240530223939.1027659-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530223939.1027659-1-linux@roeck-us.net>
References: <20240530223939.1027659-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add suspend/resume support to ensure that limit and configuration
registers are updated and synchronized after a suspend/resume cycle.

Cc: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: New patch

RFT: I tested the patch through a suspend/resume cycle, and it seems
     to work, but I am not sure if that had any effect because,
     after all, the memory is still active during suspend/resume.
     I was unable to test a hibernation cycle with my system.

 drivers/hwmon/spd5118.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index 3c75964a0fba..ea807a77a4ee 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
 
@@ -432,6 +433,8 @@ static int spd5118_probe(struct i2c_client *client)
 	if (!spd5118_vendor_valid(bank, vendor))
 		return -ENODEV;
 
+	dev_set_drvdata(dev, regmap);
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "spd5118",
 							 regmap, &spd5118_chip_info,
 							 NULL);
@@ -449,6 +452,31 @@ static int spd5118_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int spd5118_suspend(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	regcache_cache_bypass(regmap, true);
+	regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG, SPD5118_TS_DISABLE,
+			   SPD5118_TS_DISABLE);
+	regcache_cache_bypass(regmap, false);
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	return 0;
+}
+
+static int spd5118_resume(struct device *dev)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	regcache_cache_only(regmap, false);
+	return regcache_sync(regmap);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(spd5118_pm_ops, spd5118_suspend, spd5118_resume);
+
 static const struct i2c_device_id spd5118_id[] = {
 	{ "spd5118", 0 },
 	{ }
@@ -466,6 +494,7 @@ static struct i2c_driver spd5118_driver = {
 	.driver = {
 		.name	= "spd5118",
 		.of_match_table = spd5118_of_ids,
+		.pm = pm_sleep_ptr(&spd5118_pm_ops),
 	},
 	.probe		= spd5118_probe,
 	.id_table	= spd5118_id,
-- 
2.39.2


