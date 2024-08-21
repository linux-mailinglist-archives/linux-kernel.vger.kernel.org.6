Return-Path: <linux-kernel+bounces-295475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813D5959B71
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993DF1C22552
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377B188A3E;
	Wed, 21 Aug 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Qu13vSEb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27628158D8F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242506; cv=none; b=O7mjIR1pXfDKzDstaXaHtKwr12sOHhcBiq1GhiVH5VhbQxLQrT89kkyN818uw6NgZHTbBSB8yZijer7vZtjaabOzbL5fHGWy+hFAadNNMWSlyEC13lTEMxBwKnFlEmFh1fon/l+Oqp9qw31xIZnF6Ygc5a0R4P9JsjbWn9rVRdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242506; c=relaxed/simple;
	bh=/0VUObltFI36YwzvQUOf07lA1enaqqy/ADCqR56tepE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6RWxhsDSITFiO/rdQ9wVLG3792ISB1bFVtzHG8j/aQQ/SjLrvy1hUorjC9pRUa/0rlk07GHebPKpZQ/vuBbJjCH7QpyMqSqDjdaWBgs5DDubxVPswt2hx30WH9Xb47UBtBqgezF8EjNpkilR/zkbSktUvkH6MUIx/AOGDf/ycI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Qu13vSEb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e0d18666so52699895e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1724242503; x=1724847303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNEYv5X2eaQvG8N/4e9judfOPIHJ3R5WVAeQVepl5OU=;
        b=Qu13vSEbHq3fytHJ+gtPGd5SNOeFcu417KeCSh9+i/mm75eG3X0/rEpd9WS823dUQ6
         +5rwADpGrmOWzDzdWqPQQiFS37GK2Yef08D1zz4klRpMEfNsJ3GJrbqbUeRZCO18r2HR
         3OXZLSBPhm7qldjLvbuqgJswC1hA+TkVOTr12S2uQtBxJNiwMcx4jRMs4J2LCbj4R1eh
         TThqSxX3GJg3sFQTJpF2K6hpoTIby95dRIiKfOMrRKJB3TvYnSIXSBmjP79u3JQHwVho
         8cDU+5Qaqzt1ntKN4C3+hoZKJkKx/Ilo3tD2kxV4n04qwMFR9YxOncPIvL2jxOj78ACH
         JWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724242503; x=1724847303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNEYv5X2eaQvG8N/4e9judfOPIHJ3R5WVAeQVepl5OU=;
        b=eGYmr/ZVMvdqMghVJY6fYcNXm/AMTxrE94wmVWhZlzUyyxh2cBrdtYrDQTTsMF+FGV
         deCr52e63I4ikt1gHgamN4GZzv2SuOM5dJNrKE1xqRTzkD3wMCpWbrkQNvEJP+8+fHJX
         UeLt6ZUywLNaTpzRfRLifEetlWQxhEL2PYE+PEXvi+4DD6NDypmIh5sGCK6Ru9mEHkVS
         cTFPSeKFxuXeyNUGVd4kSNetsbL60kRVc85Z1U5BmYjoRhDjH8oOcM3p3UKrLWVC7IDk
         eKzmUXXjD+EMsmPx4phwBrC6BXTzEnZSRz6IdZth23iAM63XuBcRbhemEIt8HLL1l7eE
         vzTg==
X-Gm-Message-State: AOJu0YwzC2py1pBrmQgGfrGzVl2jNkzRRUAbiAafg6RANXqv3rG17/PX
	qNN3JWlHy4qRhFhgHtkjP7l8x9rmdCB3wDibgSG7rWYZYCx3RiJYrKNB5b5WHxU=
X-Google-Smtp-Source: AGHT+IESkq5T2JFkI+DO8A4yBDzS+8in4n0X7cqNUYMPHMjQFQFHAT6eBufSmUam01sj30Xhz3cNcg==
X-Received: by 2002:a05:6000:196b:b0:371:8bc9:1682 with SMTP id ffacd0b85a97d-372fd6f1402mr1455433f8f.33.1724242502824;
        Wed, 21 Aug 2024 05:15:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:42a6:b34f:6c18:3851])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abee8b43fsm23056595e9.12.2024.08.21.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:15:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Alban Bedel <albeu@free.fr>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/4] gpio: ath79: order headers alphabetically
Date: Wed, 21 Aug 2024 14:14:53 +0200
Message-ID: <20240821121456.19553-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Put all headers in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-ath79.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
index 6211d99a5770..be2952fdae3b 100644
--- a/drivers/gpio/gpio-ath79.c
+++ b/drivers/gpio/gpio-ath79.c
@@ -9,12 +9,12 @@
  */
 
 #include <linux/gpio/driver.h>
-#include <linux/platform_device.h>
-#include <linux/platform_data/gpio-ath79.h>
-#include <linux/of.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_data/gpio-ath79.h>
+#include <linux/platform_device.h>
 
 #define AR71XX_GPIO_REG_OE		0x00
 #define AR71XX_GPIO_REG_IN		0x04
-- 
2.43.0


