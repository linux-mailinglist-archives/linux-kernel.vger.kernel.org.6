Return-Path: <linux-kernel+bounces-529355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59115A42381
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2B63ADDBB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7525B69A;
	Mon, 24 Feb 2025 14:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aTQ8DUha"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EF2561D9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407530; cv=none; b=V2qbFpSPqRGmDHacOxI/d2iIg6M5biKpSzkE3rK9bepz1uRJ1Z0bzsIjzgarKkqXjlbYqnG3WC5P8trX+achxjpE1wiHacaHKwQmC5DCrnP/hUKj56d416Q6zkBImpmWU3a0rWhU9cyRWbl526lCBYtYwlv5OrukF+Q1F3wiXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407530; c=relaxed/simple;
	bh=I9lP76yFPs8lG+vM/++5W8TxmjrOGCD202JeuHQOcIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhiIt89UH4po0BvXj4rIhcg1KLt+XKQeBTT4TwzMRKo0FlZ29H4z6iIQWXzxsodZEG5BmRUtaIP92CUNleN4H25Lv40dXNWrsbayB3tMRpeynK7lfxUYTPwvWI/XT2xo81mqXiUHDCOxLvA7f3bM7+P4dhrVf3F7tls0wziJA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aTQ8DUha; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A3883F18A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740407526;
	bh=EeWm4eF7hu13oz72eC95zGuOMvWxCgDdPfM+4c66iwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=aTQ8DUha0yYo7YqSQlfvtFF1mKQh4mJoscLnn6HOGy+nafhpm0f6IUrxj2oSigeLP
	 25yiAGBVhfwg1ipYtl8GrJz6x/2sO/AjtLN3tJWHRsHmwpUB0XwA03ohPT4CE1hEgf
	 IybE0rXM0Hv/jlHpsYKaZqmw8WoM/Nw0S6FMsX5yEPyhPWgecuB3LCIHnEajRW70bt
	 fB5jU0VOUiZamJA+0YULW01sZyx7aCZH51Q5BBTu5rNNGfpJuFg3QegKixHSSd16oL
	 PQq69nY5UtF/hbvvhuelAbAFPoqR2i7NpDb84Yk2Lroyh4ioynmnZlZCVC4EAyZHcH
	 KlxBDqbP8wmUw==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-220bf94cb40so66428505ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407523; x=1741012323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EeWm4eF7hu13oz72eC95zGuOMvWxCgDdPfM+4c66iwM=;
        b=lkMyfQ0aN3/kahp3rIUp1x5BvKF6crg78KIYl7JotZNNbmV1kxzL1Z/lrMncQM6ZP5
         WcahjIhdRUPcZK/AEuxhoMpNbY+2YNdwXSge/HWMJAAh1MQsQx2631nXRbGUajubtrej
         7NpopIOifsTwjOjTlKP0wdjrK3p5203qLAbsh/lFiR0CYByE2ciNh9Zaj6fXSIxWr4b5
         YdlsjOjokQeF7IrkZ/k/8mHj5ydUcvqNFKnvqZTY3OyM5UrOHaGxE3DwTu2fN9TFMwXR
         +WaeEpwoGI4RMqucUTUI/K0D8P0sYuQ2RWr+zoI8zNaqAroVxHljQ8c1qq77JKon3CId
         vKjw==
X-Forwarded-Encrypted: i=1; AJvYcCWZKlzORAVdhqMxMm7qvoAogkfD5KBDfdmi6K2C97opCn/YNpSCO/0VFFPdu8V5JLQq5IqfB9fkY+mG2hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzISRePLyNIvvhAQ8udiV3QpeL0ITczCbrCELXhNeZM4r9LaWne
	xkUJIhf7lTMNLlx6JGADpW1tKHANqqDyCPSyt9gCy38zPtEbl2HykDA/IwiE+TdomJOkbvUapND
	6jRwXtNWlHVOJe5Cqt4ir6tAcaHPzKBBkaqlvioNbgF0v/rIgBVIe8deMglOL/cr58KoTJjNC2B
	v/dQ==
X-Gm-Gg: ASbGncs1RN4ElS5mqee2fNIGXMX+yVrQBmu9iKHdnrow/dd9RGQIFr9PzXKbsGwZrqt
	qksJqP2QsOvWYeNvf+yKDb2DppX93SGXvGzk9v146//F9jJZpD/mYiThptTFUJqhQkXJcJryUTY
	poW20axsli6mYnnh7norkgfPXVZ6fQsla/VFOObQKMX4Vw3cKucm5sjLtXjNUzRRJFYKqGkfcwT
	TRg9o+Kmt1+oIM1RPRnblQapEVRh7WHLLX/ndSX9WdRKpT+okBq++z3yCFJZKdIEjA+RGAtCIgI
	tLyKbd0Nl/uqAxuQ
X-Received: by 2002:a17:902:ea06:b0:215:acb3:3786 with SMTP id d9443c01a7336-2219ff4eccbmr218819765ad.19.1740407523616;
        Mon, 24 Feb 2025 06:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYBdUZGjKrDW9Lsq6u2A2A+A32rloyxDv3flD3BcouC0SJNqzemHrcMLYanlXTC9x3Jnqqdg==
X-Received: by 2002:a17:902:ea06:b0:215:acb3:3786 with SMTP id d9443c01a7336-2219ff4eccbmr218819425ad.19.1740407523301;
        Mon, 24 Feb 2025 06:32:03 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:de7b:58db:ab85:24ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d067sm177613895ad.109.2025.02.24.06.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:32:03 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/9] gpio: aggregator: cancel deferred probe for devices created via configfs
Date: Mon, 24 Feb 2025 23:31:33 +0900
Message-ID: <20250224143134.3024598-9-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224143134.3024598-1-koichiro.den@canonical.com>
References: <20250224143134.3024598-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For aggregators initialized via configfs, write 1 to 'live' waits for
probe completion and returns an error if the probe fails, unlike the
legacy sysfs interface, which is asynchronous.

Since users control the liveness of the aggregator device and might be
editing configurations while 'live' is 0, deferred probing is both
unnatural and unsafe.

Cancel deferred probe for purely configfs-based aggregators when probe
fails.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 6b0e42774b86..137b5d032427 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -72,6 +72,10 @@ struct gpio_aggregator_line {
 	enum gpio_lookup_flags flags;
 };
 
+struct gpio_aggregator_pdev_meta {
+	bool init_via_sysfs;
+};
+
 static DEFINE_MUTEX(gpio_aggregator_lock);	/* protects idr */
 static DEFINE_IDR(gpio_aggregator_idr);
 
@@ -1112,6 +1116,7 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 				size_t count)
 {
+	struct gpio_aggregator_pdev_meta meta = { .init_via_sysfs = true };
 	char name[CONFIGFS_ITEM_NAME_LEN];
 	struct gpio_aggregator *aggr;
 	struct platform_device *pdev;
@@ -1161,7 +1166,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 	gpiod_add_lookup_table(aggr->lookups);
 
-	pdev = platform_device_register_simple(DRV_NAME, aggr->id, NULL, 0);
+	pdev = platform_device_register_data(NULL, DRV_NAME, aggr->id, &meta, sizeof(meta));
 	if (IS_ERR(pdev)) {
 		res = PTR_ERR(pdev);
 		goto remove_table;
@@ -1242,14 +1247,15 @@ static struct attribute *gpio_aggregator_attrs[] = {
 };
 ATTRIBUTE_GROUPS(gpio_aggregator);
 
-
 /*
  *  GPIO Aggregator platform device
  */
 
 static int gpio_aggregator_probe(struct platform_device *pdev)
 {
+	struct gpio_aggregator_pdev_meta *meta;
 	struct device *dev = &pdev->dev;
+	bool init_via_sysfs = false;
 	struct gpio_desc **descs;
 	struct gpiochip_fwd *fwd;
 	unsigned long features;
@@ -1263,10 +1269,28 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
 	if (!descs)
 		return -ENOMEM;
 
+	meta = dev_get_platdata(&pdev->dev);
+	if (meta && meta->init_via_sysfs)
+		init_via_sysfs = true;
+
 	for (i = 0; i < n; i++) {
 		descs[i] = devm_gpiod_get_index(dev, NULL, i, GPIOD_ASIS);
-		if (IS_ERR(descs[i]))
+		if (IS_ERR(descs[i])) {
+			/*
+			 * Deferred probing is not suitable when the aggregator
+			 * is created via configfs. They should just retry later
+			 * whenever they like. For device creation via sysfs,
+			 * error is propagated without overriding for backward
+			 * compatibility. .prevent_deferred_probe is kept unset
+			 * for other cases.
+			 */
+			if (!init_via_sysfs && !dev_of_node(dev) &&
+			    descs[i] == ERR_PTR(-EPROBE_DEFER)) {
+				pr_warn("Deferred probe canceled for creation via configfs.\n");
+				return -ENODEV;
+			}
 			return PTR_ERR(descs[i]);
+		}
 	}
 
 	features = (uintptr_t)device_get_match_data(dev);
-- 
2.45.2


