Return-Path: <linux-kernel+bounces-365873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD66C99ECD2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC031C236B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740D1C4A3F;
	Tue, 15 Oct 2024 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ekH2g6OG"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE751C4A1F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998320; cv=none; b=CUKn0+i6tIMyNcC1DGI1xFmwycoHq/er2EW5l20NTnBzJyKB62nh+5jRHEhyAizJD+ZC0psXPp/vuAx3nmqeq0//6bts6eRW7AwzV026+C76txvhfcCzi8bh+QogTgVbC97gL26DBcXYfQCIcAvs1iPQ5Hxf4h/0VKGBt7j2ORY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998320; c=relaxed/simple;
	bh=CjTrMsEwMR8QUk9UFcx/R0AQZNgypq1nAm9lVIPDiXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsp6Z+7BVcUO+meEepKzsuwJW/LQe6xzLxP9P0QzcmFORgPeKoUs9WMbdy17MhVPWJg2yFvfcebHzZHL5iHmOvdk8dbP+99VuL2F89TXFksuQ1gjtManhZtxF1ZocL6JTBvYZNAT0EKYBoe2aPJEIyK8u7g/mlULJjkiYTLqoIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ekH2g6OG; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-430558cddbeso36616965e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728998315; x=1729603115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxiEcvm80AfMlwlCZyDwYfRsCJV3jVXg02TjVFfp6ps=;
        b=ekH2g6OGoEkXdS0ZgLDXOJLcJ6amCpcjVslNBkRBCpvigP9KBaemtGW38PYyumQOen
         UMoMUlchw/Xq9l+49NdG9MmU9GviH+86JCqkFr+JfuAz7+KyFpYZa0k05LGeYmnyowiz
         20CIW3z1zxJ5vMlNrXNJHsTa1eH155V/BHlu22PMQGTMgLRzrE07gSRXCLWYT0VRRkVa
         kZNXz2fIc6bV+sqvQu/UY0tFRIRVYk33jTvS7RhVbcaSg5IySko3niTubQmDIGBTdfTi
         KT0pZq6qHaOGmb5AuIfP1vy4DcQ0xbpZhG7rERVFsLFksT7YTfBX0AchCGLLedf2V/+y
         ZLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728998315; x=1729603115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OxiEcvm80AfMlwlCZyDwYfRsCJV3jVXg02TjVFfp6ps=;
        b=gFOSWf1s8OJHvoY2/pcky4YywgKPCSoa34itj1IBzusF+P63iaAl95GfWKh+CHvRZS
         ee4vfS7eeNmTHgL4mhXLXmaldS+uYxdzYvVfBAdve2voqbHVXZPAontAq7fg2yOue8mC
         /AqAy7H7HpTG2D+xCUrAmLEQVsAm9TvQrHUWInYi+iAKc7nEwFGGesV7T7R9CF71Mn5r
         kreBP0OvUtpI8n7SY6/H1/c2hLLKnp9o5OzRxz7vDZK1L/HvCScj/tuSAP1ARai5ZLBI
         pO2D3hh26D0/AVmUWtXY5OUFnk7yz6K5S8syviGD6QGjFRErTfZMpRpn7yCkjPUOdO6t
         ZWvw==
X-Forwarded-Encrypted: i=1; AJvYcCW2oERrnLPIlua3JqMe//jmhvUtecaIkRUSDQqFD74TQDYrK7M09Bse6fSoHFLsLrZs/sKi0tIKiu6Wxlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJ5E2wbQjbHawQc8JGQqiTRG6SMim+4cSIIRpsrVWe6FmP29o
	npeJVf/vbcVEP1YWPH3d6/X/3Mrc3362b2lJbEGx0fF6kMkn+hD1eM/pSjvScKI=
X-Google-Smtp-Source: AGHT+IHg5MGJaDBbw3k6d7DovAj3mck54mh917oO5XzPsUEmkG6Td3u0dfP7w/+c9ZWDYTkIhB2lUA==
X-Received: by 2002:a05:600c:1d99:b0:42c:b68f:38fb with SMTP id 5b1f17b1804b1-4311d89150cmr125357865e9.7.1728998315434;
        Tue, 15 Oct 2024 06:18:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:d382:b11b:c441:d747])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5524sm17676405e9.44.2024.10.15.06.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:18:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 2/4] gpio: grgpio: order headers alphabetically
Date: Tue, 15 Oct 2024 15:18:30 +0200
Message-ID: <20241015131832.44678-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015131832.44678-1-brgl@bgdev.pl>
References: <20241015131832.44678-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For easier maintenance: order all included headers alphabetically.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-grgpio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 017c7170eb57..4b53a932a186 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -16,20 +16,20 @@
  * Contributors: Andreas Larsson <andreas@gaisler.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
-#include <linux/io.h>
-#include <linux/of.h>
-#include <linux/gpio/driver.h>
-#include <linux/slab.h>
+#include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define GRGPIO_MAX_NGPIO 32
 
-- 
2.43.0


