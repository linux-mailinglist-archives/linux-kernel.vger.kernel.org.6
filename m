Return-Path: <linux-kernel+bounces-562666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68EA6302D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE197A3C2C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9F6205ABE;
	Sat, 15 Mar 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jPqaJHDs"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B76204F8B
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056910; cv=none; b=AV9C+mOFzoyhIhYr3j4xs/MRU6zaJQnP1iERGjxD4D1FqdI78ZeYGLCW5oW19P3AJ29Fp7KB6kBx5PQqqwBQ8AG6qlHW8zoJlJpAeDUAlAAjSVrzqePB2lPqkVLpROl0AQ+M/TDb+waSZoJE8JQ2gh1+fAjJVwusLGbFGaiL3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056910; c=relaxed/simple;
	bh=hcT6Pkv849JRDuuXpPNqMLlmqrx2ytCXKRtqnB9DgRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4civf4miskopIN0W8YXoB2hiJVEBu06yN5UiuSA4awSdGf4oloRknNpON1MnMiR9MxSbltPMi4o6a3AQjMQG6bVnV975sUlgI/HhZC4r1UkeqbHlnxjMnsB4FcjlfdldoJoV+EwFbXcprKKwJeUsFuzq7jAgljJ8Fp2ZV+vvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jPqaJHDs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E248D3F2B1
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742056905;
	bh=6y2HDbZhaY8Idh2slBQTtYTVvrytnAsA4PhON2tVLMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=jPqaJHDsXozzuKhog9ZiQrFwFHjwvQu8k+1ZYjKMSlX+sihSciq1GiMm17No4rufv
	 hxampk4Lt1WV78y+ZC93CUGrmnGVQOu3tRBCLdhkdfxqORhPps1W/Bpy3D0PwGY4G0
	 HIDg6RBomnXO24wn9zMvM999pwvauIl879CdR2O4GzKjGDU6jebHGnREvIgbOR4bMC
	 M5OLeMz2pdBsS+40tBnXgOipSONHVtwQdq3cCSMs4djst72iC0A2GXUzUUAb51Gkkm
	 87PDpuWplz7VaB4/MGpRQZ585WGTvAdB2Q4vQqteh7Ghoky0cak3eLU3kFxWex3b0r
	 gL1KXIDWqONhw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2240c997059so68918585ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056904; x=1742661704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y2HDbZhaY8Idh2slBQTtYTVvrytnAsA4PhON2tVLMA=;
        b=MDvMdzl5z6Vizx7cpGXECibOhJ8+TeraN4TAo/3nNKIXs5+Mg47MpgmZMbF/To+D0H
         ePmW31ME39H7vrFfUgpCZHxmoekFOCXYwu8z0EZPIh7boXPVdQst4XNK9CER1GsvYYlQ
         qn2RCvt4uItGyXtEhcYV52oThwJY+VvUn04O9ouv8CA7OzeiUuYBNKvxMGRTmWUOhoLz
         V3DosDzIl0UHn9W4rx2/+jQpg4IZCbALzzYmzV/GNMtlGGKeQb+wKzWk2dkjccgWRZ2H
         wgkMkUyJCvCUuJUhtNE7VGzny8xn+nt2lJyJJ0eyyiDbR6iOTCi9T5+q5/NsPPkm1kfp
         crrg==
X-Forwarded-Encrypted: i=1; AJvYcCULkAGxAQywLuBnsPQFfcT4121khjvHq3U8qMrFJtF1NKiU5sXwhVHvR4mFHk8caJey/hexa+A4h1WR3q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXtvar5FEcXjLlQNXWGus8O3zlv3/IZBjj5a3ilr2EC3xDMb2h
	DdEHLlZyiXzHuaV5V4hgdmKNQNwzmFfOPl705MZeWiiD92BJ5yEHKaxxXM1EgCeGEKpdVfMrVqf
	iI9zTNApeKrW3wiAJHk8izRGJ154pESwknxwCWR1YSbNcmnbycmokjt2fsPs2XA0G3BSGXtfJ6W
	1Jyg==
X-Gm-Gg: ASbGncsNVEWFb4HzG/kjBuP57xs2Kh1qwZdOxy+vOG+yNzl2RU4vA9RohLh471Y8yrh
	rf0T3SarxD0mb5NrF96Eeo8F6AllnjebI6cpY1juY4rF//qaEypd2PFSQpasRF8RlocoaBkcnyB
	KXcC204pHyhsUdz/3ObSpJV0tZDjCtgC+h5o5w1+NIoGhZzctLjQOAMrP+8u8jENw871PVQDKTl
	wUJLdwVEnSGn3+kTvMclGHrrhn7S/j2bF0K7FtqcqtV+VACxJ7NmDC062oI3cAoxcNp150IugYh
	WLyZiCD6sw3TZne5
X-Received: by 2002:a17:902:c411:b0:220:ff3f:6cba with SMTP id d9443c01a7336-225e0ae70b8mr74365865ad.38.1742056904600;
        Sat, 15 Mar 2025 09:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMXBdPfzXEyy/Oz7vzl5WYmItCelN4wOI+AARmFHRLdkSNEbkkAQGzuJPH0K7+rDBLiTC1sg==
X-Received: by 2002:a17:902:c411:b0:220:ff3f:6cba with SMTP id d9443c01a7336-225e0ae70b8mr74365755ad.38.1742056904249;
        Sat, 15 Mar 2025 09:41:44 -0700 (PDT)
Received: from z790sl.. ([240f:74:7be:1:83e6:3590:3498:db44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155e3a9sm4637104b3a.71.2025.03.15.09.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:41:43 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/9] gpio: aggregator: rename 'name' to 'key' in aggr_parse()
Date: Sun, 16 Mar 2025 01:41:19 +0900
Message-ID: <20250315164123.1855142-6-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250315164123.1855142-1-koichiro.den@canonical.com>
References: <20250315164123.1855142-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the local variable 'name' in aggr_parse() to 'key' because struct
gpio_aggregator_line now uses the 'name' field for the custom line name
and the local variable actually represents a 'key'. This change prepares
for the next but one commit.

No functional change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 0afd5d43812b..7087ac599ace 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -996,7 +996,7 @@ static struct configfs_subsystem gpio_aggr_subsys = {
 static int aggr_parse(struct gpio_aggregator *aggr)
 {
 	char *args = skip_spaces(aggr->args);
-	char *name, *offsets, *p;
+	char *key, *offsets, *p;
 	unsigned int i, n = 0;
 	int error = 0;
 
@@ -1005,18 +1005,18 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 	if (!bitmap)
 		return -ENOMEM;
 
-	args = next_arg(args, &name, &p);
+	args = next_arg(args, &key, &p);
 	while (*args) {
 		args = next_arg(args, &offsets, &p);
 
 		p = get_options(offsets, 0, &error);
 		if (error == 0 || *p) {
 			/* Named GPIO line */
-			error = aggr_add_gpio(aggr, name, U16_MAX, &n);
+			error = aggr_add_gpio(aggr, key, U16_MAX, &n);
 			if (error)
 				return error;
 
-			name = offsets;
+			key = offsets;
 			continue;
 		}
 
@@ -1028,12 +1028,12 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		}
 
 		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
-			error = aggr_add_gpio(aggr, name, i, &n);
+			error = aggr_add_gpio(aggr, key, i, &n);
 			if (error)
 				return error;
 		}
 
-		args = next_arg(args, &name, &p);
+		args = next_arg(args, &key, &p);
 	}
 
 	if (!n) {
-- 
2.45.2


