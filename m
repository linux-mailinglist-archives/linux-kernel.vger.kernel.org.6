Return-Path: <linux-kernel+bounces-343783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D03989F6A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D58FB23833
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC818A922;
	Mon, 30 Sep 2024 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sJ/9H8JP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A88117D358
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727692325; cv=none; b=Jfcwfqz+zkr5Qr0XBW87ujevx9hhkRXG4TftutKF5qrb84Vc0PKCVTxadaxcNqYJqOzQJYJ1ejgfkzzkW4C5gttW3v0nAnmRce68g5fpz5hsZYtTrEtPDvjJlMPs5axY+FMqqKYJIeKJmijFBsYhsV0ATB4wSn0xCZPjuj8XLMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727692325; c=relaxed/simple;
	bh=CQBiquwPJYNslu/+jeo9tvNeIusUOgAyH92OuMpD8uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nY2lP+Uybpe+38w+yq8CLDwj3QA7EjKSrlPp9glljTxR2pGEiR+6EQhh18nLrB/g/k3zotVvHlUTEswHHK6aD7fX9VZ2rLWeZ5XrQJpvzAoLku3dHNm++6pzl3Wsz7L12T1WqLulIwW7VUK/dzMJi5KEGAwquiXOTND47FfnNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sJ/9H8JP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso1848351f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727692322; x=1728297122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3A1gwsFCiikEDi0rY6BdG2On460nhwk+2mLer0OuSQ=;
        b=sJ/9H8JP9EuKrJ44ioHa2iOxE6DjwvXonV6pNBU1pG7mYzI69I5K82QHtClUhM1KIo
         VQT+hgz1m2eBqU31dGTRe8cVx+VMmBhweKFjrBwxPEf+8YmzDQtqv3dY//eMaVjjpB68
         qqBsLEgOskuPcfmBCiwg/a2cdX7cwe/n7w+1cIQu8KNvYOZLCyDI+fdqJCx+lOP7r3fk
         HkglLVbsAYhSJk3UDxlCSWtKzCBfeRHKHja5l4MpE6T2Kr6Ko3Gmg6N6X7mffHMku4uF
         VwuIomjHn4SdiLG17YCRrYEWL4+APlzDDnRRiXQzBfbdrPsLANCf0tv4Zwk/qe5ei/7i
         aqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727692322; x=1728297122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3A1gwsFCiikEDi0rY6BdG2On460nhwk+2mLer0OuSQ=;
        b=v3IlQ7Ab+YgqOIGki7mZqJwWSOR8FQCDZNf0tttr807Eb7TEvt4jQ5BuFsLwuf+Zyn
         8Vbu5KMhR/kYNvE2puqieUgoL9bDz39V/MNaDRmCTYrZc3kPswJCg9+Ehmcqv6mGfGvy
         yyNgANN4N8QsSXCKwqKqyxCJPmtamOUJaOgsyQNR0++fszSJW8CsABnAJ4nI7rT3qe4q
         Idy+rzuY8KAhBZ0GP5MBIDRt4PClpxb2jH4s2wiB5x17HU8j26KzOy0btw9DwbxFskeY
         4aZLju52QF1e3gAIYZpPlr+l2ad8KyftF2994sZhFJpQYGnJvfp+1xrtaUDYCFirb5oB
         qLbA==
X-Forwarded-Encrypted: i=1; AJvYcCXixwMSj4Uimirl6K5UPW/f3av6DPfbtKCeCs7CEBbjLGmKyLlmSe6JDpJ7uOGqDolUN7t2lozCiqCOw0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOm96UhKzaN/6Jdxr/b/Cxh7QwZrZujzC/v4aTANdncNIhXFX
	gfztVCi9U07OJpbbhPJkjr+Ny1kjdwKl3kGqeu288IjoPX8OkqYilC5jn2cVbfo=
X-Google-Smtp-Source: AGHT+IFZbYwugRIqIG5RKdS3sy4SuxyJuRmJH18Mpd9Sbm2l5OpKu+eySXRb2iMevWzzBBW1WU2MsQ==
X-Received: by 2002:adf:f4c8:0:b0:37c:cf0b:e9e6 with SMTP id ffacd0b85a97d-37cd5ad142emr6600408f8f.42.1727692321979;
        Mon, 30 Sep 2024 03:32:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:8791:e3e5:a9ca:31a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5745696sm8633491f8f.106.2024.09.30.03.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:32:00 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] gpio: syscon: order includes alphabetically
Date: Mon, 30 Sep 2024 12:31:55 +0200
Message-ID: <20240930103157.49259-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Put includes in alphabetical order in gpio-syscon.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-syscon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-syscon.c b/drivers/gpio/gpio-syscon.c
index 5ab394ec81e6..638095d5f459 100644
--- a/drivers/gpio/gpio-syscon.c
+++ b/drivers/gpio/gpio-syscon.c
@@ -7,11 +7,11 @@
 
 #include <linux/err.h>
 #include <linux/gpio/driver.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <linux/mfd/syscon.h>
 
 #define GPIO_SYSCON_FEAT_IN	BIT(0)
 #define GPIO_SYSCON_FEAT_OUT	BIT(1)
-- 
2.43.0


