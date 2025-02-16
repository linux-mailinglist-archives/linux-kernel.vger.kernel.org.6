Return-Path: <linux-kernel+bounces-516594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC84A37462
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A293B0611
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F4195962;
	Sun, 16 Feb 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VUi3ECL5"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A019F116
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710745; cv=none; b=OcfiyXspDUQRqrVXwn15oYycCjPUsuLJfY5/D9ICSnMEwMkNTKuowl46OgWucuB0Svcw593DnmDO6CZnXQ30bBiEeS8mCZJdrXvhBFGSGGH004xj4gd86mJbNwIvNFT3q2A8oD4fDUzX4BLAYMe3gjbuaigOSAy8NLigs2UKj/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710745; c=relaxed/simple;
	bh=uvDPPe/zh18N6hlSUI3RGzfNlPtrpvVYWv/tx+FGhgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcPuwxfNPuplFBfBepMJ8w2RspaTy6G0DemR6Hw/ZwPxuw01yvlXYfgjlGKNuxP5xMfLLC6fyU+1b47R67eByNBM16Wp0qk9Uo9NWM0iSaw8gHAc9VlHSkZ1hkqBOUN9BVUgcA56ebruyy2yHmGC+J+XWO35nVrUDMf8Jslqkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VUi3ECL5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A052D3F516
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710742;
	bh=dSs/jDBsvmuiaXfkwHoPbsWqaGsAOzbJ2wNat8FrzKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=VUi3ECL5RJL2iHSdHSL/9moVCCZh3flOun25gV+qalvZITCWO3vU36hWJOIBuSN6n
	 PWOqc3ByP7cjdZhPPdUW2KDDdNnhrywyPDNHmJeO7TETlMs+PBGBO7TMz8C8/xeaAv
	 GXYAW/qJS7uLQos1pHVOhMAv70VizHyJ8tYiqFl8e8VeLWMlPBQo/SQtLqCptalc6T
	 fP60t8R/qsQ+NZmuXHJLW4kAbCnRHtoOewQaNdzyszKBsxKJtgUQNe0u6g0svZ22GB
	 t6C57Fq5egcAKOiBLC/yK6hsckHlRvkg8nTS71f82ekcigusQwTgFIzOtXRt+bBN6u
	 cdYrU7u8EpgkQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-220fff23644so39218515ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710741; x=1740315541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSs/jDBsvmuiaXfkwHoPbsWqaGsAOzbJ2wNat8FrzKA=;
        b=UKj0tdAu1hTXhx/eH9osOSZRljkghOLTZ8a0J35agHbuZoFsOlXljqUOza8cZssa7V
         JM6PHoWndqlpjywWmkY+hJMfiAWu4ESollgea5kQod05iS+0NGvhsaoRivMs8A+dWOjK
         7/SzkmpB5u4/y4yRfP4Xb1Tb6UoAPiat2mVTYHqWn04MaY5RQbpLJWzCKwOEtw6j8rUx
         OEA1b58DpjH8uG0G7OKsTxq0y0ug+P1L70j1z1YKLUi+BVaYmYRV0pCZDiYjUhN4Tauw
         CfcU2BnqS+bzI+u0GCYhzdtNh0etO3SZKwLquF69nD/W7qSTRj022oA5uASz//kFvd+U
         66og==
X-Forwarded-Encrypted: i=1; AJvYcCVBqx1Sdqf4mP2B5u2ZPmy84a7wI0WqwBfP3j++23o43n8OMnIl686+pOyR9sgIgBDqmgNjnhtuXFhHyH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGV2T0/P3TBrfp0jDy6/W2rfab+fJAqd0shKqZ5L507ClsJDuh
	A0yS4A2tFgggF1qZhi/3ysrQ7P5WTVqLTnDnFyVFyRE+RKNWa9iDQ9Ua90xlPDkQBYDRLWmY5dI
	d6F4JUau8g9zIweNrOhxDPhW9AnB8p+zpIfJj6pr42AI2zNdIDuDcgTEo0B+CCIHVrB7bsWIWq4
	Lq9Q==
X-Gm-Gg: ASbGncsGzI18E1ofzeLfPLGWAs+2BBP1GhzcCzmlTAAdm/pE/OOWTCsGA79p8P9nkZ1
	I7W9k+GzKT5pXIyG9ed6NcGJt4NLDxDGTkyAZVAh8RFy6VHV5LcGZ1r+TSb2n5N7J/Kn7l2M2Gb
	Peg10EeZLaLrcfHqzq314NbbWLWeUUTt/aYhi1A09bXRBE9ibyryae6Pag/KExqNUuemIllFfkv
	1P6QqCFmsKjxNwt4bt8IZLap6P4IW7GiOqcL60OMXhix504IMmVL1qFZLerKpJOg+IkxGSmhiau
	CQiahQ==
X-Received: by 2002:a05:6a21:483:b0:1db:ff9d:1560 with SMTP id adf61e73a8af0-1ee8cb83e07mr11012680637.18.1739710740990;
        Sun, 16 Feb 2025 04:59:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEX2DoXZH2gdxB4GWkakyck9S/MVDzRPWAT4rIheXRziUt7feS9YZINV7LVPXBklwt62cw7UA==
X-Received: by 2002:a05:6a21:483:b0:1db:ff9d:1560 with SMTP id adf61e73a8af0-1ee8cb83e07mr11012654637.18.1739710740669;
        Sun, 16 Feb 2025 04:59:00 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:59:00 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] gpio: aggregator: cancel deferred probe for devices created via configfs
Date: Sun, 16 Feb 2025 21:58:15 +0900
Message-ID: <20250216125816.14430-13-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216125816.14430-1-koichiro.den@canonical.com>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
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
index 8f8793f27211..f6beb9f41b9a 100644
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


