Return-Path: <linux-kernel+bounces-392660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAEE9B96C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5961C21935
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428661CF282;
	Fri,  1 Nov 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxOP4Tsm"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4414C1CEAA6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483274; cv=none; b=C3OI7496pioWDGqH3Rzj2EJodAgA4uXpbLjBdZh0RGYcFKAEzJlwlPcxcMPbK8yHg7OV+uKQ2dZSJozErsPANV0ak9DKp5yr9Mep+CxKpiRhmI9X3iyEeMcWuTIWGXCegktM4aELCn3/r7SSvnnVi4JRtQX38oTkZwtini0SYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483274; c=relaxed/simple;
	bh=E8GpDid0z0L+scbV3cTbbzBQ8cibWDg9h1nXglwEYuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCIFSjkcCcxznH60SB1+tFazXthnGKAJ2Xg3Ujy9kLO41vzrKukVdMXeiKouc2E88K0qvZED5XwKQMZA6TjGxjA+UbS9TJ9OlyxWbkMyPthLBiXev4z1l6ssHyD+1PE+zk9whGI+UKRw9oQzLX9I94BGYuWxp6Q5Az5MGa1vReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxOP4Tsm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431481433bdso19405475e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483270; x=1731088070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c+vWdnejyhzbmDbcfsvQBCmeK/se4a+fgFkV5D6jqQ=;
        b=MxOP4TsmHv5ub1TbxtWiZawsJ/sPVbiGYuNVnTSJ8pl19ADruUxlrb3X7dDuxPnyWh
         eZYGZ+3WGKySmyo4wQ/mHdWAbLVnXd7e/DSDVsM0RBqYG/UI3RlDo9lhazwgCQhe2Ldt
         ojbA6PobM1o2xv7UOrCB36OpKQ8xrxvkjT18g9/MTd3rW0NNgaN5JI1sbYYTODCbA99K
         Xenzszk02B0mTlJZwyjulONLSK1GUPAYlCi1+ECQOEMvpcB5hzEPfp+eElidU0IU0kQF
         p8bWp84jR8bKRtaD15HYpwkeZwgoR1poNfSlQ0cOYCwlHnZUQsxLL5LKKmmIwz8cE02q
         A8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483270; x=1731088070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c+vWdnejyhzbmDbcfsvQBCmeK/se4a+fgFkV5D6jqQ=;
        b=MUfpQ9Nxz5/8YuVROS2Zxku1Dmg/L6RPmAwRwQEfm9FYh/GogTMVH4piIGE/wc/xHk
         RoT1rllKuauMdtA5yVMAzZcFQlsEiFOjv2ydXbbgMe1V0tC+nroRabz3UbJTKKx+D+FN
         n1g6lMmqx3ym/t1DaoyTBYg4m1KI487P7cZUCT2EqAOVbGK57WxXQEg8xrDO/TBaU3yE
         JQhk6LWIlVuuDc9U/MUT4xlQZEVOvE1dmwFp2M6Sx3CVoTklWfoeE7FvG3zGkyR1RWvu
         kP+ywGrJTJ3zGmYEoUMZPEycBsueLXAow6Q22oohWtWG1mXwLBqlxYY6fMLl+7PQrLL+
         +lcg==
X-Forwarded-Encrypted: i=1; AJvYcCXYcodr8La7tkgIYaTcv6+g1zCz8i6l3mfIqqhL1UqNK/UWmjfiPCDs3+TMd8f+CHAL2Gnm5Jqj1IQJGBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDEwJMIsEYzixJT/iN40AMIy0B8PvzNdWManDMqhdBIgB9lYO
	Xp4pumCPxa2eYP7mbMoHw/r5wHId3Zm9l+SAJxBaXNYruGB+0q2e
X-Google-Smtp-Source: AGHT+IG8JrW9cZ5ghpR/F8uKmVF8GGUEafLV+lott5rbv8LEwgWvK92GtmiULMRy+tMKkTaaHRtv7A==
X-Received: by 2002:a05:600c:1c93:b0:42c:b9c7:f54b with SMTP id 5b1f17b1804b1-4327b70150fmr64121935e9.16.1730483270482;
        Fri, 01 Nov 2024 10:47:50 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:49 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 8/9] Rationalize lookup tables
Date: Fri,  1 Nov 2024 18:47:04 +0100
Message-ID: <20241101174705.12682-9-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

   Remove bcm2837 table as the only difference is GPIO14 and GPIO15
   which are not used with the current pin maps.
   Remove GPIO14 and GPIO15 lines from the two other tables.
   Re-order the tables so that the bcm27xx table is used first
   as these devices are more popular and numerous than the older ones.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 85 +++++++-----------------
 1 file changed, 24 insertions(+), 61 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 8c03e91c01dc..e7a5248ee80d 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -203,41 +203,39 @@ int gpios_vector[] = {
 /* Lookup table for general GPIOs */
 
 static struct gpiod_lookup_table gpib_gpio_table_0 = {
-	// for bcm2835/6
 	.dev_id = "",	 // device id of board device
 	.table = {
-		GPIO_LOOKUP_IDX("GPIO_GCLK",  U16_MAX, NULL,  4, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO5",	  U16_MAX, NULL,  5, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO6",	  U16_MAX, NULL,  6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_CE1_N",  U16_MAX, NULL,  7, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_CE0_N",  U16_MAX, NULL,  8, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_MISO",	  U16_MAX, NULL,  9, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_MOSI",	  U16_MAX, NULL, 10, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("SPI_SCLK",	  U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO12",	  U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO13",	  U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("TXD0",	  U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("RXD0",	  U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO16",	  U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO17",	  U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO18",	  U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO19",	  U16_MAX, NULL, 19, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO20",	  U16_MAX, NULL, 20, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO21",	  U16_MAX, NULL, 21, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO22",	  U16_MAX, NULL, 22, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO23",	  U16_MAX, NULL, 23, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO24",	  U16_MAX, NULL, 24, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO25",	  U16_MAX, NULL, 25, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO26",	  U16_MAX, NULL, 26, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO27",	  U16_MAX, NULL, 27, GPIO_ACTIVE_HIGH),
+		// for bcm27xx based pis (b b+ 2b 3b 3b+ 4 5)
+		GPIO_LOOKUP_IDX("GPIO4",  U16_MAX, NULL,  4, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO5",  U16_MAX, NULL,  5, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO6",  U16_MAX, NULL,  6, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO7",  U16_MAX, NULL,  7, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO8",  U16_MAX, NULL,  8, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO9",  U16_MAX, NULL,  9, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO10", U16_MAX, NULL, 10, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO11", U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO12", U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO13", U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO16", U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO17", U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO18", U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO19", U16_MAX, NULL, 19, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO20", U16_MAX, NULL, 20, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO21", U16_MAX, NULL, 21, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO22", U16_MAX, NULL, 22, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO23", U16_MAX, NULL, 23, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO24", U16_MAX, NULL, 24, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO25", U16_MAX, NULL, 25, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO26", U16_MAX, NULL, 26, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("GPIO27", U16_MAX, NULL, 27, GPIO_ACTIVE_HIGH),
 		{ }
 	},
 };
 
 static struct gpiod_lookup_table gpib_gpio_table_1 = {
+	// for bcm2835/6
 	.dev_id = "",	 // device id of board device
 	.table = {
-		// for bcm2837 based pis (3a+ 3b 3b+ )
 		GPIO_LOOKUP_IDX("GPIO_GCLK",  U16_MAX, NULL,  4, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO5",	  U16_MAX, NULL,  5, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO6",	  U16_MAX, NULL,  6, GPIO_ACTIVE_HIGH),
@@ -248,8 +246,6 @@ static struct gpiod_lookup_table gpib_gpio_table_1 = {
 		GPIO_LOOKUP_IDX("SPI_SCLK",	  U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO12",	  U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO13",	  U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("TXD1",	  U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("RXD1",	  U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO16",	  U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO17",	  U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
 		GPIO_LOOKUP_IDX("GPIO18",	  U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
@@ -266,42 +262,9 @@ static struct gpiod_lookup_table gpib_gpio_table_1 = {
 	},
 };
 
-static struct gpiod_lookup_table gpib_gpio_table_2 = {
-	.dev_id = "",	 // device id of board device
-	.table = {
-		// for bcm27xx based pis (b b+ 2b 3b 3b+ 4 5)
-		GPIO_LOOKUP_IDX("GPIO4",  U16_MAX, NULL,  4, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO5",  U16_MAX, NULL,  5, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO6",  U16_MAX, NULL,  6, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO7",  U16_MAX, NULL,  7, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO8",  U16_MAX, NULL,  8, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO9",  U16_MAX, NULL,  9, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO10", U16_MAX, NULL, 10, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO11", U16_MAX, NULL, 11, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO12", U16_MAX, NULL, 12, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO13", U16_MAX, NULL, 13, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO14", U16_MAX, NULL, 14, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO15", U16_MAX, NULL, 15, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO16", U16_MAX, NULL, 16, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO17", U16_MAX, NULL, 17, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO18", U16_MAX, NULL, 18, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO19", U16_MAX, NULL, 19, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO20", U16_MAX, NULL, 20, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO21", U16_MAX, NULL, 21, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO22", U16_MAX, NULL, 22, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO23", U16_MAX, NULL, 23, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO24", U16_MAX, NULL, 24, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO25", U16_MAX, NULL, 25, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO26", U16_MAX, NULL, 26, GPIO_ACTIVE_HIGH),
-		GPIO_LOOKUP_IDX("GPIO27", U16_MAX, NULL, 27, GPIO_ACTIVE_HIGH),
-		{ }
-	},
-};
-
 static struct gpiod_lookup_table *lookup_tables[] = {
 	&gpib_gpio_table_0,
 	&gpib_gpio_table_1,
-	&gpib_gpio_table_2,
 	0
 };
 
-- 
2.46.2


