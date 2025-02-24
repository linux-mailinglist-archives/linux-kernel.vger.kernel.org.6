Return-Path: <linux-kernel+bounces-529350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAABA42333
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97F5C7A8D68
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A366E2505B8;
	Mon, 24 Feb 2025 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TFPa3352"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4C18A95E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407518; cv=none; b=REuagIGYaYGN+6gGvnx11CAgw4tbLH35cBwX4wxZykS6bKnoNLyU+rG/wsm/e5jl/VeU5jwORDvrkOVw22rY/X8E/YNUHP73Vjp6LAmg32+H1b9NZkdN/stVhy7b8xC1rjIZEWe3evbJYMfaLXvB3ULP2+wnEZqrT4osFpQdFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407518; c=relaxed/simple;
	bh=aLA3ZVDhrDy3RNwYW++kaJn2SQ84AkvFmu6stXF9mto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFCXz8D1b11yoT85vnYNgMBY0MhenENHG1OkYFXz4a4nZaRWljKhfGiOQ+UPBVIpcJJV2HjG8LYAEvCesBXrb4lnDbmf1myNzt4gTcJUoAf6D0r+1geVXH/IQXvAEHmB224XquJBzBWFSCgEyJ4vsflZGrZaV4tf26iKvKnTbpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TFPa3352; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02BC341972
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740407512;
	bh=gXHg3uCoBKmQSJJ70+DeTAJMIxaEY0B5wJevniOwqIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=TFPa3352Beils+vU8/s62hp7Cs/ocmbndUBewyoi7asMI+9EhFSMCOumcpEedLLDF
	 X49fohYaCd0w5VreFTwXgGiljS7Q4Zuexq82YZx/KyeNnhdHkq682liyryDlZOxRsc
	 UPHjQJyNqpBUjbCvqn56Btwovxo5cLbiiy/bVTd27bd04bc8SNzrhtaUfxUbSSaHtE
	 2iSPTFHf5ytlDtpj/S9kLjKQvYQU1mhZ/7LJWM9cpkz9bW0NeRih7UxPDwuyzW9oqZ
	 bDtRjGgCHae/r8i+wK4mwpMRHAgJWcMjdR/LafEcWakiEc1+cxjMmWgjQqjA1K/i1o
	 MvkSoMzKFe/PQ==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220fff23644so15082125ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407510; x=1741012310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXHg3uCoBKmQSJJ70+DeTAJMIxaEY0B5wJevniOwqIM=;
        b=wIf72TWjbV3vNvkeKYdoGkcpdiD+cKYz9nPGGWxBbFQdq+1LW/wm8fIJ4/ZACE2jfA
         25k46u8dz/UHeM0GBsPUHFYC60YkI/Crg99xBGwQbuJXGUthC3tnYLYAzXnPNDnMIPIh
         CZXlI0kFEwQc86pB3iQaf7232LMzEv8/3Uys3dgty89XI8LqZ4yaolxN3FxpHenpeTDu
         yxFKEPirIe15vumpJDCQTjaEc6Xnj0nbq68SLORM9LrWJwa6jxQ04YBLpbJDHLOkTSw6
         H391E2aub3WCOWR2PxqHgJQkVYoYnCxo5wap2Q+d5vfg44I/5kCWilsL0ZWbVBzpvQQM
         FE7g==
X-Forwarded-Encrypted: i=1; AJvYcCW8AmriDrR9tS7MRHyiDvDebko4SnGIRLbfd9xkK7IJOx7dr1nnFSyTeqv2Gj0sM54ne8mFdI4ngSh/59Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyTYUaAsGvyTYhFDYGLpQNbbxEqjc8udMArtIilIuWMZcQOSVj
	MlfgksT+xcmcZgoywRjdKsKWkYIGTZWiqs3y8UFoens1zKVahspNRckeawsR+nPHWmACO9A9jZX
	ogO7XVTS96FL+wE+/0dc5OKOd8WGg53LYFLJXAQGiKrwmUKEseLe3jdIGIODnWdo8aCoAH9O4bQ
	jz7w==
X-Gm-Gg: ASbGncu3iTmO+Ky1jl01QGV0RQ/USWq53x42/kQI6Sj1md5QDLodPoDhPAjplxCwoCc
	ROG3VYtYAy6ILkywE+kcVxCyKGFgPnzj8OO0q2MFFHESKg2Msiqdsoi8Lda96IVF8ZEajikzH2I
	wiWGmKK8w00RS3Y5n+VkjqIqrvu7HTUICmdtRmTnUTS179G1NfCwf+XN/z5/Ieiyd4FJJtdejx7
	tl45/mo143dvwKfLPQxkd6Q5dIJ+Fmr9DNI/8sEp6slceNplm+9QUuEW0HIC9ipQiAt/RpSPdPd
	3pWMOy31oU/8KzkL
X-Received: by 2002:a17:902:f548:b0:20c:6399:d637 with SMTP id d9443c01a7336-2219ffb5ccdmr233011365ad.40.1740407510334;
        Mon, 24 Feb 2025 06:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1Jc0Yqwa4HwDO+K5r64/4KHjkg5DCcC3jCiIDfEPZrnBsn9cR2KGuGUfwAomXtnQycccupA==
X-Received: by 2002:a17:902:f548:b0:20c:6399:d637 with SMTP id d9443c01a7336-2219ffb5ccdmr233011105ad.40.1740407510064;
        Mon, 24 Feb 2025 06:31:50 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:de7b:58db:ab85:24ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d067sm177613895ad.109.2025.02.24.06.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:31:49 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/9] gpio: aggregator: add aggr_alloc()/aggr_free()
Date: Mon, 24 Feb 2025 23:31:28 +0900
Message-ID: <20250224143134.3024598-4-koichiro.den@canonical.com>
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

Prepare for the upcoming configfs interface. These functions will be
used by both the existing sysfs interface and the new configfs
interface, reducing code duplication.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 58 +++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 893cd56de867..a93b7d3de929 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -36,12 +36,41 @@
 struct gpio_aggregator {
 	struct gpiod_lookup_table *lookups;
 	struct platform_device *pdev;
+	int id;
 	char args[];
 };
 
 static DEFINE_MUTEX(gpio_aggregator_lock);	/* protects idr */
 static DEFINE_IDR(gpio_aggregator_idr);
 
+static int aggr_alloc(struct gpio_aggregator **aggr, size_t arg_size)
+{
+	struct gpio_aggregator *new __free(kfree) = NULL;
+	int ret;
+
+	new = kzalloc(sizeof(*new) + arg_size, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	mutex_lock(&gpio_aggregator_lock);
+	ret = idr_alloc(&gpio_aggregator_idr, new, 0, 0, GFP_KERNEL);
+	mutex_unlock(&gpio_aggregator_lock);
+	if (ret < 0)
+		return ret;
+
+	new->id = ret;
+	*aggr = no_free_ptr(new);
+	return 0;
+}
+
+static void aggr_free(struct gpio_aggregator *aggr)
+{
+	mutex_lock(&gpio_aggregator_lock);
+	idr_remove(&gpio_aggregator_idr, aggr->id);
+	mutex_unlock(&gpio_aggregator_lock);
+	kfree(aggr);
+}
+
 static int aggr_add_gpio(struct gpio_aggregator *aggr, const char *key,
 			 int hwnum, unsigned int *n)
 {
@@ -444,17 +473,15 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 {
 	struct gpio_aggregator *aggr;
 	struct platform_device *pdev;
-	int res, id;
+	int res;
 
 	if (!try_module_get(THIS_MODULE))
 		return -ENOENT;
 
 	/* kernfs guarantees string termination, so count + 1 is safe */
-	aggr = kzalloc(sizeof(*aggr) + count + 1, GFP_KERNEL);
-	if (!aggr) {
-		res = -ENOMEM;
+	res = aggr_alloc(&aggr, count + 1);
+	if (res)
 		goto put_module;
-	}
 
 	memcpy(aggr->args, buf, count + 1);
 
@@ -465,19 +492,10 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 		goto free_ga;
 	}
 
-	mutex_lock(&gpio_aggregator_lock);
-	id = idr_alloc(&gpio_aggregator_idr, aggr, 0, 0, GFP_KERNEL);
-	mutex_unlock(&gpio_aggregator_lock);
-
-	if (id < 0) {
-		res = id;
-		goto free_table;
-	}
-
-	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, id);
+	aggr->lookups->dev_id = kasprintf(GFP_KERNEL, "%s.%d", DRV_NAME, aggr->id);
 	if (!aggr->lookups->dev_id) {
 		res = -ENOMEM;
-		goto remove_idr;
+		goto free_table;
 	}
 
 	res = aggr_parse(aggr);
@@ -486,7 +504,7 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 
 	gpiod_add_lookup_table(aggr->lookups);
 
-	pdev = platform_device_register_simple(DRV_NAME, id, NULL, 0);
+	pdev = platform_device_register_simple(DRV_NAME, aggr->id, NULL, 0);
 	if (IS_ERR(pdev)) {
 		res = PTR_ERR(pdev);
 		goto remove_table;
@@ -500,14 +518,10 @@ static ssize_t new_device_store(struct device_driver *driver, const char *buf,
 	gpiod_remove_lookup_table(aggr->lookups);
 free_dev_id:
 	kfree(aggr->lookups->dev_id);
-remove_idr:
-	mutex_lock(&gpio_aggregator_lock);
-	idr_remove(&gpio_aggregator_idr, id);
-	mutex_unlock(&gpio_aggregator_lock);
 free_table:
 	kfree(aggr->lookups);
 free_ga:
-	kfree(aggr);
+	aggr_free(aggr);
 put_module:
 	module_put(THIS_MODULE);
 	return res;
-- 
2.45.2


