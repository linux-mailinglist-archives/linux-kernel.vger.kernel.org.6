Return-Path: <linux-kernel+bounces-562668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F88DA63030
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77154176D31
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9662063CA;
	Sat, 15 Mar 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DEvMm8Aw"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2400205E0C
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742056914; cv=none; b=BSGwq78W045htyGQXNahenZq0FU4l6mYmaMciOVNkOqR7yV/aDG3BoWBvhzoObcZUfNqd6yCdBB8Rt4aznFPRMu1RqCJ/QJXGvutTqANnk8riqhbrr2/q7nPUE99zpIBDurRFd0/8z32jslMIuGQUl1NQlUEeDIW3dK8A02yRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742056914; c=relaxed/simple;
	bh=/Z2MAli9EXDhOWQJGX/cq3RhlXJKDrxBGFnuUhIEBNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtqeAfJlqAhZ6LrlCFPsfPIg3mKOf9y3EvOlwmeJB66RIhf1X54PMZOZaOfqh+Gho4g0SNWOsJdU9Rf9sEMPDIHOd9Sg37w0Om75DwePFSUrgjOwJ7aT52fFUjzBHG3dSK0UDi3Cj2G61UnnqRJnI/xEgS+fGxgO1YlPKdQSFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DEvMm8Aw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0DC723F2B6
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 16:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742056911;
	bh=tGpODGt9i1CwJG7JFJhQeHtJp8NGC2Si4RhlSW04Hrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=DEvMm8AwBTuqXSo5lbzI4FhW9Z7XvCgFiP6HMwphEPPDOzCHvvqS1Kvjv64ZwGfvW
	 nEU8uSeowcfK5CFWId+XjAm3hr1h0+pvCiMnLJl7QzZteZH24BznyT0mI2CFrx39LT
	 SZJqpx4iOHVoB8Oyb0q3KoafYnDDLmrHjL3lFxjJh3ZIPt1R8kfiCbL3mcEelb2DSA
	 idjiIP6skXGw1NrrqVWgNejASMC4Xi2eo+Xorl70f+yTKBmtehAZfJj7V5ZET2pTdo
	 1mE220NXMUFVO3apI3k6Vk1dgsMTY8QLHdWHd7p9S4vl3zKe+5x56hgsNoT+GTiHoS
	 9st/jniqVP5yQ==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff7f9a0b9bso910478a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742056909; x=1742661709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGpODGt9i1CwJG7JFJhQeHtJp8NGC2Si4RhlSW04Hrg=;
        b=WGrWk5HSFCdVksTCFClPYlxdUwWkVIKHRZkgmM/pt4yWYI0nKQWOXkHNYoLoWBarB/
         I7r2bRsQUP/Qtaz8Duk/3yDV5DM7wLvbbnrPJYgL71vjfWmunpAkiKLBJI6lDxsB54yF
         qTo0pXiWs6we/Bpd5sPERk2nQ6JLPwUFMBSgL+Sl1NLmuuITwYmoPmyg9Cszt0nb0tfI
         iK3+YSRkg7rsbYJ/p3AMDK7qkmZZm4EHNK6a/55yjJU1DbpAtdg157JGJ2ZCXXx/b9Fd
         Q4RiffUXsxz35JKRgUUDqaU8VKhDZ+Ns9cSgwvmOQwtGPV/FrtJ+C4QHFkSyfnj9gtyx
         D6lg==
X-Forwarded-Encrypted: i=1; AJvYcCUN4Qr56GDiVSkbtrlUbkb7u50RHTWaa4pIl23HlYHzLXUEglTHKHw5cHZwvs7u9SCdsn6JUW0SMw/hhrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWDhaI4aoQ8TgGkPdD1glSWtQ6ziDnMFVD86IbB26r9iiCXrDr
	ocf/FQypwx6BMbVQ7NYJogx/R19TfEbPgKEmQRiZIIOz249/6tZpInN0X08Irb3UHKJ+ZPNbdL+
	Y8rYTEI71RudQezoJOiruQy+8vM8RvMNFxewZtWfMRrFa3dxSIweduQrvb4fvtxMx9DMYmXXD2A
	0BFQ==
X-Gm-Gg: ASbGncuh3TX5CNzyzc/DT8VH1EYalrNG8l0J0eXCoOAHJxHMnf9LkZjmzEJNe5/YSbX
	8LUwfeeWoqhyYG2U5qoNeOzjtv5cGn3ZcBfYBk5JL7v/uEvzG06WLlVjRxuiqss9FuvdhZyLpVa
	+YX9kL0oUdowUF57SXP7XcWFC77orkiUDValRbFImf2Y8UaDQRWIKT6X7uUPm3FsTrt2WMpoGLw
	QR+CL+oQbbyo6JXoK3q2UbTyrWf9ucmauW6J2KIk7Am0O9Ql27ahEpNSFUEe4JY4JyrOBmhOXnA
	f8gVahLUYH9q8ysU
X-Received: by 2002:a05:6a20:8c9e:b0:1f5:873b:3d32 with SMTP id adf61e73a8af0-1f5c13227c6mr6406192637.39.1742056909504;
        Sat, 15 Mar 2025 09:41:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZOBLI0X8SyCatv7tcjBCLoHnb+mWe3/KR563fonVBZeCW2KmMW/mdZPHgtvnuvOh9i5z4+Q==
X-Received: by 2002:a05:6a20:8c9e:b0:1f5:873b:3d32 with SMTP id adf61e73a8af0-1f5c13227c6mr6406179637.39.1742056909207;
        Sat, 15 Mar 2025 09:41:49 -0700 (PDT)
Received: from z790sl.. ([240f:74:7be:1:83e6:3590:3498:db44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371155e3a9sm4637104b3a.71.2025.03.15.09.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 09:41:48 -0700 (PDT)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] gpio: aggregator: cancel deferred probe for devices created via configfs
Date: Sun, 16 Mar 2025 01:41:21 +0900
Message-ID: <20250315164123.1855142-8-koichiro.den@canonical.com>
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
index de693182070c..89c78d145cbd 100644
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
 
@@ -1134,6 +1138,7 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 				size_t count)
 {
+	struct gpio_aggregator_pdev_meta meta = { .init_via_sysfs = true };
 	char name[CONFIGFS_ITEM_NAME_LEN];
 	struct gpio_aggregator *aggr;
 	struct platform_device *pdev;
@@ -1183,7 +1188,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 	gpiod_add_lookup_table(aggr->lookups);
 
-	pdev = platform_device_register_simple(DRV_NAME, aggr->id, NULL, 0);
+	pdev = platform_device_register_data(NULL, DRV_NAME, aggr->id, &meta, sizeof(meta));
 	if (IS_ERR(pdev)) {
 		res = PTR_ERR(pdev);
 		goto remove_table;
@@ -1266,14 +1271,15 @@ static struct attribute *gpio_aggregator_attrs[] = {
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
@@ -1287,10 +1293,28 @@ static int gpio_aggregator_probe(struct platform_device *pdev)
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


