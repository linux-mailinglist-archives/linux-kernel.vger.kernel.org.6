Return-Path: <linux-kernel+bounces-426296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C769DF15B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 15:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6701162B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5C019C57C;
	Sat, 30 Nov 2024 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I/LXIHdL"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B0146A68
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978663; cv=none; b=hSntRyAOFFWoiQOlq/OyphTW+LPpF4F21gbSvLRrk5nMcxCjIfJzPTM1B4lhKh4WVEqJkpL+0V/nKX7smDFRXI0wBqU7kvqMdYr8QfN617Roi6S346IS+40wE09VUohJwfkG47ufOzqzkPuTf+VvmrRO1kGsVewZamZi4raZc8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978663; c=relaxed/simple;
	bh=QPy9R6U/ZGwM7zCobvnycx0uhgbjXZKJpWo3pI5a2wc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1aaGftkzoVa51LnYyEubOh0liCVLWdsARYasp6dJLp7R5EIimB4VzJCA3cWp7ohLqQJv44r/YHa03q6tHleWZ1lty/rGNAsjpo/VyIW6hlNMw0N50EoObjrBEfJHKJL4smbGpKFvf+iors7EkswQHEPZRMKJHZVLm697Vbnyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I/LXIHdL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so25032305e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 06:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732978659; x=1733583459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a0fyEAOE0jO76pqaUwrR6CdaRsVoTj8N7qDbmkHzYuA=;
        b=I/LXIHdLP2mA8G2jajQ2YTcJ/sXRITGe9EiYsQWpFXlq824tmY2etbx/ytA5Wk1sme
         UHC5wQY0wKELHVpzRLoF+VZ+SFCbWN2QAkEAkXcLTB/DzJF40NN3cAHXF6g89SvGWC5P
         y1AbwxOEqpy7DBHuYKoUKnFoWfW6G9stm9Ew/8c03QUiA8+simqEHTV7Sl2BZtVYd3sO
         3MuvL3ZpK6xatgoUdEqqlsG4KCfXjv0w3OBnhzXOnOAszQ7hhf/4WSk+y9QlOkAjEyne
         gprA5iTZzYb9hyKiWFzBFznda7+UzdmLKyEDwqj+W9Fh3rD2ySOKxedEjJsOduBSukPE
         q3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978659; x=1733583459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0fyEAOE0jO76pqaUwrR6CdaRsVoTj8N7qDbmkHzYuA=;
        b=jg4eA1LqeqrX9ZJ3B4QNUKIKKsQw8WK1CwRULFzLkwmZeFQSyfewlHcXPQNNWmSLAq
         ZxL0Ja+S787d91MkWA1gIiJfzywEQiUw1f9qRmCOBtX89Iy15WGmBIt+kLWeeUEAhrwk
         2+dbz/C6BuI3VaFHV84P4KYdS98uOO0a08mDHCrQbusptmqxdyYSKivUX3Wx4Mqn4nkN
         He55wKDqG6BNoYuhi6i0GaZwj/2QgJdkavToxIinxXdXGsZf+N3U5ACZV5Bw9HPZzv0t
         uN5rFNlecVES2pTg7GU2Diwgz1HYU599bcXfebdx0CO2PVidc3a6Qgua6kx6a/y8nhBT
         hcQg==
X-Forwarded-Encrypted: i=1; AJvYcCUjfIt0lHSH5C6HvsSIAxyjLA3BmqX4eF4YslgWFbRhZ9Ptx44ywt64/oT+iwoKGhg9YrCNZf+dMki5heE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQcTFifxy7ozRUGHcOMuLfYc2TCzsWdkNgMrK2TKYaZe06XI8
	04eU4tIXSbNII3caad41rBFgAjGJbnRQReT5hYeKIqT01ofd+FqdM/LxPjA361U=
X-Gm-Gg: ASbGncvkj6z7bhBzGC4h3hK0SItbsazjB+T75TCi9npf4l7NCndzlk1dGic8zcyask4
	nDOQnaSnKsqNhfvATvScxHbGnnIZkBQJ6+IARH4g0RF7BYXNSp4mP+5PtTXmJEICLLZbM30rdRM
	xzUIkp1i9aMxm2cbaJ8jA4fxbC1UPIBjdhDQaWDQIvINrReZQQqmxHP6bjLzXburkFro/gtocFM
	3pIVQcuJ+9cmDLRNCHzB/z4Nzsjtn5AvVjqrljUOVtsLvWpzw==
X-Google-Smtp-Source: AGHT+IGYVxJ7aqYLAf3AhiYPeay9ff+XBH4Jlv0ovdKhdRX0QOJ4ExSxSEPz//Ru/8O/XqqV8nhp3A==
X-Received: by 2002:a05:600c:5490:b0:42c:c28c:e477 with SMTP id 5b1f17b1804b1-434a9de55ebmr131732505e9.23.1732978659168;
        Sat, 30 Nov 2024 06:57:39 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:7ca4:5604:f5:65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e30c54bfsm2263755f8f.110.2024.11.30.06.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 06:57:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Burton <paulburton@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: Switch back to struct platform_driver::remove()
Date: Sat, 30 Nov 2024 15:57:27 +0100
Message-ID: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3495; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=QPy9R6U/ZGwM7zCobvnycx0uhgbjXZKJpWo3pI5a2wc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnSyfXJ1dM7IQP9oFCtpJutajSwaTt4+1A3YC5W R9BPuB0rwuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ0sn1wAKCRCPgPtYfRL+ TtHKB/wKCi0MHVWGq+J5UApHmpRfdSUcy13HQzBL19/VOF2hwmw1k0fkxwT+ueK5604lThdhzBR 4m5BuSDnh74xG9XYtIfuMHTypfSlskPmy2K1oFOuK6ch2YQy0fs5g6GuZnWMXqr09NVyIizCwyx 3fYKSOORhfSyC4yt7EUIzIuwGyTMlMIEY335uvklZT/+vgmKpdsBoV5+VmFv6FaF+oT9P3raGfH zzFDJ4HBQdGA7m6zmYAVg2+GcLQXETUY9ySeAd1gj6LNqhIi0qd5+SE9DnL5EeNLDjXcdFEPF5R XYpcFm43EdHbXhujNGSKoeRDegfPtacDS7WEI2JX+NwFUbTZ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/auxdisplay to use .remove(),
with the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

While touching these drivers, make the alignment of the touched
initializers consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this is based on Friday's next, feel free to drop changes that result in
a conflict when you come around to apply this. I'll care for the fallout
at a later time then. (Having said that, if you use b4 am -3 and git am
-3, there should be hardly any conflict.)

This is merge window material.

Best regards
Uwe

 drivers/auxdisplay/cfag12864bfb.c  | 6 +++---
 drivers/auxdisplay/hd44780.c       | 6 +++---
 drivers/auxdisplay/img-ascii-lcd.c | 4 ++--
 drivers/auxdisplay/seg-led-gpio.c  | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 2b74dabe7e17..471ec6c7d459 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -107,10 +107,10 @@ static void cfag12864bfb_remove(struct platform_device *device)
 }
 
 static struct platform_driver cfag12864bfb_driver = {
-	.probe	= cfag12864bfb_probe,
-	.remove_new = cfag12864bfb_remove,
+	.probe = cfag12864bfb_probe,
+	.remove = cfag12864bfb_remove,
 	.driver = {
-		.name	= CFAG12864BFB_NAME,
+		.name = CFAG12864BFB_NAME,
 	},
 };
 
diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index 025dc6855cb2..edbb4bcfb6c3 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -339,9 +339,9 @@ MODULE_DEVICE_TABLE(of, hd44780_of_match);
 
 static struct platform_driver hd44780_driver = {
 	.probe = hd44780_probe,
-	.remove_new = hd44780_remove,
-	.driver		= {
-		.name	= "hd44780",
+	.remove = hd44780_remove,
+	.driver = {
+		.name = "hd44780",
 		.of_match_table = hd44780_of_match,
 	},
 };
diff --git a/drivers/auxdisplay/img-ascii-lcd.c b/drivers/auxdisplay/img-ascii-lcd.c
index 9ba132dc6143..71bd834b83c7 100644
--- a/drivers/auxdisplay/img-ascii-lcd.c
+++ b/drivers/auxdisplay/img-ascii-lcd.c
@@ -286,12 +286,12 @@ static void img_ascii_lcd_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver img_ascii_lcd_driver = {
-	.driver = {
+	.driver	= {
 		.name		= "img-ascii-lcd",
 		.of_match_table	= img_ascii_lcd_matches,
 	},
 	.probe	= img_ascii_lcd_probe,
-	.remove_new = img_ascii_lcd_remove,
+	.remove	= img_ascii_lcd_remove,
 };
 module_platform_driver(img_ascii_lcd_driver);
 
diff --git a/drivers/auxdisplay/seg-led-gpio.c b/drivers/auxdisplay/seg-led-gpio.c
index 183ab3011cbb..d839fe803606 100644
--- a/drivers/auxdisplay/seg-led-gpio.c
+++ b/drivers/auxdisplay/seg-led-gpio.c
@@ -97,7 +97,7 @@ MODULE_DEVICE_TABLE(of, seg_led_of_match);
 
 static struct platform_driver seg_led_driver = {
 	.probe = seg_led_probe,
-	.remove_new = seg_led_remove,
+	.remove = seg_led_remove,
 	.driver = {
 		.name = "seg-led-gpio",
 		.of_match_table = seg_led_of_match,

base-commit: f486c8aa16b8172f63bddc70116a0c897a7f3f02
-- 
2.45.2


