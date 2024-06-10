Return-Path: <linux-kernel+bounces-208333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACECA9023A3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E0CA1F2505E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F190142E7B;
	Mon, 10 Jun 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="FCc1mBmV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C544824A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028363; cv=none; b=JmZQSQh7XOPWPaoN+UZ4nKh7ZLRiXPC7l51PPF5vFT3fLOosO7yBP9Ne8L1ez5KTXTbu91SufKsSYhJ0yh4VL+pKR/ii9nFPOlVw3IwYhY+HA5TDz6Vyk5fqVKWy4t4jhNjd25wXmzHRVY3z64dW+8eIpzugsdmbhW8yRvhd57Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028363; c=relaxed/simple;
	bh=kOfJiJzAPqwv+oYlxLi+l9Q00ckfBULXh2ejLluKr9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhW8mjTqXp/YVZrbYA7aKIg6Ojk4YBLUbs73yVzh2pWjgG0mk1KsNOmM9TERxHSGXqg6ywTLyoRaa8SX2Mt5pmxMBtwaRFhxwkO7yPyCj3DO8Tit4y2TNl+mx+Myy+WQ0RJepuhpUUf2vlOWLNxEFQY+zGQa2MiFeUaK8LczEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=FCc1mBmV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42172ed3597so17457725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718028359; x=1718633159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDBlyzU3LCghlnbJD04v7eaIgbQL2VqdEI9XHpUZT+E=;
        b=FCc1mBmVVlBuEjXjCvPmFrOmv+TvvHlyCmW1Ztmo8Gf0mtgf46pOHWbhcQ8Glli6vu
         babbiRCc7VF1OCBF+Ooovvtg4F4spAaYB6ph7VGAy31/mvwWUYhnvEyjzTlbLfP/b/JQ
         PKsIeaaP+ZNDaOeT/8Ms4g99UVr10GYRaEdat2n4DCLS7D91A+jpcywEoBNVz2VrW8l0
         SY8p/OzpS6BC5ta1lg3MEMCYlPFm3FLL/fx65OfyZbphByho6sEYDWqoh1CXssOmNi0m
         erm4CqZs1bgJE0TsErN5ZGUhV5tLun0FQTTVBnearZukcmH4sP3J1GwXDxli/OnAliBx
         qONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028359; x=1718633159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDBlyzU3LCghlnbJD04v7eaIgbQL2VqdEI9XHpUZT+E=;
        b=E+CvPUwlLmICvcudN94bE+vYWiUck6/7OZN1ndWncFdk2mXFsRd2/3uxt42hChsKUV
         WMMK7rPXIUtLDbwgmE7LqXfoGDm/a9fuhn6ccYluzXEWuz54mDWnRxP3V/DBZT+cqkhj
         KXXlvhhMu2cOmLC83G04ZjnlEQJ6FJqFt43am3//Sm8z3+lyumYTLq1X5WjtLS/8UNIm
         AjmXeTr+hPMWz4dkogIzsSGW+Uk1jY0m9aL7BsRS5uq9NqpA4ebs9vrl2uluCDnuFt76
         nkB0mcENjfYCYLmi/KhyeF9DGlA1YY4JmR/BSPQohm+QNX3OsIdZjPplOsuAVtIeIINR
         Wr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqZLK0s/b7MHcyrUTZHCT9cgbsUEw92aTmj2qr33O/ZX0myfSuw+DuqBHeYlkt1QnlFXzZcS72K/fb7FX2fYb+6DhtD7eLR0V1nz22
X-Gm-Message-State: AOJu0YzXBZoKa5VRp5l3i3skL+h832fpuZFCUCxe3eyC7Gwz94AV1958
	Ht9rHuADkN8nwc2LP18tFe6qwZPGoaK+NSNNbe5Q6XP+btmHRYIW4+zlYnPKd02Qj8khlk46vv9
	8
X-Google-Smtp-Source: AGHT+IH498v3qN4pefMCAJ4sGaSW3frxsUeK5QkpDqIebe9cE6y0eeKYz7AcVrvfZkyrqcfS4rQMVQ==
X-Received: by 2002:a05:600c:358f:b0:422:1446:378 with SMTP id 5b1f17b1804b1-422144606f0mr14376975e9.2.1718028359560;
        Mon, 10 Jun 2024 07:05:59 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:75a:e000:b790:b49b:9038:8e99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42217ff4302sm11113845e9.31.2024.06.10.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 07:05:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 3/3] gpio: sim: use devm_mutex_init()
Date: Mon, 10 Jun 2024 16:05:48 +0200
Message-ID: <20240610140548.35358-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610140548.35358-1-brgl@bgdev.pl>
References: <20240610140548.35358-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Drop the hand-coded devres action callback for destroying the mutex in
favor of devm_mutex_init().

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-sim.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index 21ad8d87ef04..4157735ea791 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -308,13 +308,6 @@ static ssize_t gpio_sim_sysfs_pull_store(struct device *dev,
 	return len;
 }
 
-static void gpio_sim_mutex_destroy(void *data)
-{
-	struct mutex *lock = data;
-
-	mutex_destroy(lock);
-}
-
 static void gpio_sim_put_device(void *data)
 {
 	struct device *dev = data;
@@ -458,9 +451,7 @@ static int gpio_sim_add_bank(struct fwnode_handle *swnode, struct device *dev)
 	if (ret)
 		return ret;
 
-	mutex_init(&chip->lock);
-	ret = devm_add_action_or_reset(dev, gpio_sim_mutex_destroy,
-				       &chip->lock);
+	ret = devm_mutex_init(dev, &chip->lock);
 	if (ret)
 		return ret;
 
-- 
2.40.1


