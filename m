Return-Path: <linux-kernel+bounces-379995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D29AE6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B2F288083
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC41E202D;
	Thu, 24 Oct 2024 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Ce6xcWvZ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EA1E0DC7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777127; cv=none; b=LUiY5Ly0Y/5xIlIoPVcWxt9Ab5BoWmC3ZUOsJq7aZuc22fW+NCFjIm9VKp+pkNMr/EXS0k1JTesWoA66FoAeIIhH5RtG6rL1oEI0lDKfRrrmopuvSD4BcsULDUD+5D/uOPBPLYVX0gSbSny3A26mqHWpImJTxoUrd8qiyCSMlnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777127; c=relaxed/simple;
	bh=SW1fi0zPzsrX7wBn7XqIVLiCaXQT0Ie9gmaWh01Q8KY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLyRe3V79lD9bSQyfEuBFnMhYXpEdyvuj015nvTcJifQvWcM/qj8n4Yfw6UkQVjpxcRZc03XDyIuCsqBq87y9yU5oQzQUfTOVCoZIfTVOZJ2hfcK8JW42JzIdXnD8tPE2f0UgYtgrXifDKKHWr96LLy0BOFBxP88TfS3Q/pRlHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Ce6xcWvZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so9654665e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729777123; x=1730381923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=auaN7esoCNV7hPW26ChTvANi+7IUZrlI0bB99Qwk3fQ=;
        b=Ce6xcWvZi/eEUn6uqWO+Nx24oSQDGzK0deHVuLZ5XyThSd1IPDBwK+wWY5HMu+ARc9
         HIdbod1TGQfa+Dv+EI1ggPNnA1rB0zcB67ixFyLvg7WlAf2o2ZCG/wSvpOpqm+tsObsx
         nvzfUFQiCcIcEGh/64LwwR8yUjCP92ip3fAYyky1klNvUXo1BL2PpBMgoPMCjnY7kFUz
         BPbgg1Bxdxppc9qyl8nUas9aJCtv3M0Uj2Ra5O74ED2l9I65iCyUvCkAddDM9/Q1Mjd1
         5ur5DrCN86gIDm8U+DZSIUs66vt8JPSTcptRFccCewznTnbHHQwsz/EuvuZ0TWrfNfVZ
         gvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729777123; x=1730381923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auaN7esoCNV7hPW26ChTvANi+7IUZrlI0bB99Qwk3fQ=;
        b=jxoesrKkKeqcIZRk87ln/dycbYo81UwrkZNAeCk9CfTi9yJWt5pjSlgTEuf4MxxYPP
         Htb9j0gLVlJU4Dm/FA4ZLAhs34UAXLF8EJYr/ZykBSfaROPdby0O1NatxFEmVbObjtFz
         Bka36rQkPfOypgWc0iR/mwwHdLmPE1WNLch7lhiDP7ABqbbWAJBadM7NpN1yZ3dMg5n/
         6EFKPn0iTrMyX4VtoIAMvmsL68JaqOeztrXT1wksTU4iNdaHJLrLVCEgkReBorBaw1zu
         vwUlsDx3PK8jx71+DbUg7GQcXxNbKw1Qg4qadc05G6HdyjKJMURvjWKukMXSIvoRRvte
         emwg==
X-Forwarded-Encrypted: i=1; AJvYcCU7VajN7q5J8Sp5yDm52i3Rq+5NQ3afD+5EWfPd7rfggTc0T2LIU5kiQaKeSHfTDoN+EOolPCwnxOZj0U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykjHLcdpQgQVfq1gtPgwAzf//eSOHoFtV89x7c+Mf8uXktyIGU
	akwjBD5xb867iuc8Lpdfb/ByEHBwf3qIgay7xZY5lMFfZRKzUjxnR+cqcaRotr4=
X-Google-Smtp-Source: AGHT+IHA4JS23b4eGAVOFWQtM+YFE3KGH+FrzTUSVDLqZq0gB8XnlQPMK1Tn+LtXgceofq8NkA0fpg==
X-Received: by 2002:a05:600c:3b13:b0:431:1575:2e83 with SMTP id 5b1f17b1804b1-4318a918061mr23931035e9.10.1729777123382;
        Thu, 24 Oct 2024 06:38:43 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:17a2:e679:56a4:a25a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b54308bsm18609645e9.4.2024.10.24.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:38:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Klara Modin <klarasmodin@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] gpiolib: fix a NULL-pointer dereference when setting direction
Date: Thu, 24 Oct 2024 15:38:34 +0200
Message-ID: <20241024133834.47395-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For optional GPIOs we may pass NULL to gpiod_direction_(input|output)().
With the call to the notifier chain added by commit 07c61d4da43f
("gpiolib: notify user-space about in-kernel line state changes") we
will now dereference a NULL pointer in this case. The reason for that is
the fact that the expansion of the VALIDATE_DESC() macro (which returns
0 for NULL descriptors) was moved into the nonotify variants of the
direction setters.

Move them back to the top-level interfaces as the nonotify ones are only
ever called from inside the GPIO core and are always passed valid GPIO
descriptors. This way we'll never call the line_state notifier chain
with non-valid descs.

Fixes: 07c61d4da43f ("gpiolib: notify user-space about in-kernel line state changes")
Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/d6601a31-7685-4b21-9271-1b76116cc483@sirena.org.uk/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ae758ba6dc3d1..6001ec96693c5 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2695,6 +2695,8 @@ int gpiod_direction_input(struct gpio_desc *desc)
 {
 	int ret;
 
+	VALIDATE_DESC(desc);
+
 	ret = gpiod_direction_input_nonotify(desc);
 	if (ret == 0)
 		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
@@ -2707,8 +2709,6 @@ int gpiod_direction_input_nonotify(struct gpio_desc *desc)
 {
 	int ret = 0;
 
-	VALIDATE_DESC(desc);
-
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
 		return -ENODEV;
@@ -2841,6 +2841,8 @@ int gpiod_direction_output(struct gpio_desc *desc, int value)
 {
 	int ret;
 
+	VALIDATE_DESC(desc);
+
 	ret = gpiod_direction_output_nonotify(desc, value);
 	if (ret == 0)
 		gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_CONFIG);
@@ -2854,8 +2856,6 @@ int gpiod_direction_output_nonotify(struct gpio_desc *desc, int value)
 	unsigned long flags;
 	int ret;
 
-	VALIDATE_DESC(desc);
-
 	flags = READ_ONCE(desc->flags);
 
 	if (test_bit(FLAG_ACTIVE_LOW, &flags))
-- 
2.30.2


