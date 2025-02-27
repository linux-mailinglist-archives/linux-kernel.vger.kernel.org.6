Return-Path: <linux-kernel+bounces-535842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2E2A477FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A13416A076
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8BA227EA4;
	Thu, 27 Feb 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qREKVhqc"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488D2225797
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645477; cv=none; b=G5j5gZfgrhshyFdXs11pKkEPSNZ0S01iemsEtlYreL2upLX/7qt+49Ruxm24LfFt3vuR1YUTndNsn/bC9znAY5IxpQUAonrEB3i6UJVedY45AFi73sDLWeU1uCkMyj0xB7WAUMzAE1gAtX7VQSKp6dpshqVU1kuc5wx5OOEyWVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645477; c=relaxed/simple;
	bh=u8vigGjAaMQvBBuQ8bp/AyqnsxKM4sSkXDlgfvFZCMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X98wSPYPurg4amEspUNh9jc6YIws+UUiXVOAWzmy381ZyPFkd+oxPFsSeNKaUbfCC+As8uH/PFLGoFIDHs28YSwGBFcEFMHnPx/qBykqsLeMX5Mny+Iy/FOG4IhKo4DB9xgKfo6PIvHnlaVI6NA8BnyVwzIlDgFP49m5952ZjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qREKVhqc; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f31f7731fso306208f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740645472; x=1741250272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqVMnD1+GtMM5zFymro1Aj7xaYR0IcOz2yMl4sCZCxo=;
        b=qREKVhqcD0plaZPrNlwx9Uo14UGTFgFpaq8ZGwOecoTJYkQQKGbuicWyGpYgYwn99J
         AL3cM/VIXdXJP6e/LT3Bx27oyAd1bXj6lwXQ65PoGu3/lGVJME8MJZ+9cPnr+/hcwHNC
         U6MHw3y3nNH1ehjOL/zJxMijcq9QiJ+hL009uUxR2+a+jvMsZfuvzvTTJ9P8jUnza7U/
         +V9V6KXdIetCurPAAeL8SnP0ytOLsknkZ/Hb+DBsjeUBxu7+X5VZYG1DVshRy7XE8qED
         yP2/ALmlpC+AbArV1Aq3T1mhtlJjdwqMmCj+8F1BLhp4bdpZ28e9xiuf8yuKu90s0k03
         Ij8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645472; x=1741250272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqVMnD1+GtMM5zFymro1Aj7xaYR0IcOz2yMl4sCZCxo=;
        b=D4U47f08dOqUfTZh2QeGWIdd6wfcAEm0aOAlosbLFSvwDJOIgxpaJJYBylPLLiwgd6
         p5F9an1/dPaol6/e5MidSF32rOPjLjU3ySJ5LTAZib3xi0JWjqDa5B7JK5vW05FKlCA9
         cFLycfzVmumwEc3ErxaoeOHrDEOpsBr7HNMeP+l+yBJisBa7sYLgG2aJ4NTqcU44D4Wv
         0vfrT442CGKd7GTjSwMChnVmzVs6yDIFPr21NaEKxO3l28W4aAxHMKfdudMJba+J5w0q
         W5Fcme0/R1aqN0foqxK1aVayn7nJyP76L+ldhDgT4Qlx9fmRT7bCDP/RIDbRrlPwO53b
         5BKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSjGocymfzf2itAic9KTL6zrtCplj+ZSCCeIw68r7YDfy2JPRKMlncEUS6BoJRIg5ti2MZT0UyaA8Q3jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvWbDCPPmCfZgwPj1dm65sbWYWKCZJc+Vfuk/rQd6QK2MaSTON
	PJzhI9fhnO/Rpfm5Beb6r1iyYgMLomPjaKtiwfuHE+947+O3tnQHBPPuYUAUTG8=
X-Gm-Gg: ASbGnct0iMryketXQ30N44iRkEWNJ+48ii0M0wXhsKygJOYhyM/sEuhg3RveTvcH2bZ
	66vgN42bWEGWCZVradyVMTbHpf70xWUJrg60m03q8rvLI4+u3BgFbKQ33PzYMZuiDD/REhOBHoO
	ibXnYv1H1iSNqH6NEdHUiK0vbYf9Q/A7yGgWZj3O9/0rGsnNd9szlle23pucmv9H9apMy23Hp5k
	PDa5cPUzNsfr3tMTvqCP1RBF+WULPs8nEsmdXn6X+bMQwab/wu8xzQYlUPJPrMEtnyPQLwM0dJN
	xFdcHkvdQ2RXdb+y8LuICt+BTQ==
X-Google-Smtp-Source: AGHT+IGFl1KxTGfaLHV9H7+brnJu5tqMqU/6gqiVfNJ3Es6J5KBHCTaUKEPrjOIrFWK26pSGozrvIg==
X-Received: by 2002:a5d:5f93:0:b0:390:e195:33f3 with SMTP id ffacd0b85a97d-390e1953549mr1566963f8f.49.1740645472610;
        Thu, 27 Feb 2025 00:37:52 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b50f:c403:bf52:2dbb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479608fsm1313765f8f.14.2025.02.27.00.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 00:37:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/2] gpiolib: update kerneldocs for value setters
Date: Thu, 27 Feb 2025 09:37:48 +0100
Message-ID: <20250227083748.22400-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250227083748.22400-1-brgl@bgdev.pl>
References: <20250227083748.22400-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Value setters now return int and can indicate failure. Update the
kerneldocs.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d0108cf2ee0b..4671a66f5672 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3764,6 +3764,9 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
  *
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
  */
 int gpiod_set_raw_value(struct gpio_desc *desc, int value)
 {
@@ -3782,6 +3785,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value);
  * This sets the value of a GPIO line backing a descriptor, applying
  * different semantic quirks like active low and open drain/source
  * handling.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
  */
 static int gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
 {
@@ -3806,6 +3812,9 @@ static int gpiod_set_value_nocheck(struct gpio_desc *desc, int value)
  *
  * This function can be called from contexts where we cannot sleep, and will
  * complain if the GPIO chip functions potentially sleep.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
  */
 int gpiod_set_value(struct gpio_desc *desc, int value)
 {
@@ -4230,6 +4239,9 @@ EXPORT_SYMBOL_GPL(gpiod_get_array_value_cansleep);
  * regard for its ACTIVE_LOW status.
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
  */
 int gpiod_set_raw_value_cansleep(struct gpio_desc *desc, int value)
 {
@@ -4248,6 +4260,9 @@ EXPORT_SYMBOL_GPL(gpiod_set_raw_value_cansleep);
  * account
  *
  * This function is to be called from contexts that can sleep.
+ *
+ * Returns:
+ * 0 on success, negative error number on failure.
  */
 int gpiod_set_value_cansleep(struct gpio_desc *desc, int value)
 {
-- 
2.45.2


