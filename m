Return-Path: <linux-kernel+bounces-523926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDEEA3DCEA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 195B17A7BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043BC1F1531;
	Thu, 20 Feb 2025 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EHJJAMrn"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B1D1D5AD4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062034; cv=none; b=IBe9KEruU+oG3mbsr5LOHGmdxGZ7WdxhrFnk6jvm763PaajjmDdtWcmiMNgxVd2jg4S0+093QEobta0OxVl5feekCiSaidCUdOY3QcA8Skvwi+/Q4jc8tafK4kIMeA5GIdYzMGQ7DbOzDRtzuMScTyvs8Z+6vZh34/eOfWTLNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062034; c=relaxed/simple;
	bh=eTRXOyYuqjmG3yKs/7WGPhoCMWejYfNznEcj29Z1f58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hYC+9kDtUceZ4fhE8quVX4uaQq4VQRhJ5fe9U6Yu090bE7uJ2Xi/S9PTkxjCcHYMug29ooRN8TudjTZ2kzqzYvzRkHYE+9hlCSc4t3aCIB6S9yDazzk7l1e/geQI1VgwkVlhkyb7WUhk5vV3X03kNOxqBx3o7PhzQDKQM09pC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EHJJAMrn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so9895815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740062029; x=1740666829; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0fLRneimGmzwm0JI2oa5ZakvVZkjPjyCGSlHEGhhfCo=;
        b=EHJJAMrn58gUhmaqYC9dtxb7k/YeKpEnITI+xWFxwEhrMzfD+64c77WZAZCubm8PeC
         q/c5v15JWnUhQIBYmt2kvida3gqX4loJGBrdIpV7yF9EfrpZVnJ5an6npVZIzAx83QQj
         Ip/er16C7Q8sYjT+jsjtCyzV3pgHJhSAW8ztmyZfvjLDY38btIDLbWySNoRM9aoYSaev
         wi90otYCPUriN7+/t460EPZxCmJUjIoGMQ8DHK9tTVw8lh2Rrb9+Y3QKJitvsQtxWfhZ
         Snu1gbFgxHLHzYVYMQu9oubPXWvARnlgNUS+nBmbWo/W7x800AVHCwtlPUHv7Aymg0XE
         +1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740062029; x=1740666829;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fLRneimGmzwm0JI2oa5ZakvVZkjPjyCGSlHEGhhfCo=;
        b=sST/JbpI/NSIClWjwecoNmNjsiFSnhGEx39QN5aSSNfnN8MV/hIkJgUhGrh9i8d4k0
         ECmyNDy7c2wVmCi3oIhy39o0TmDxY1F1RDcmSim8VAF/TE27zMKhqW6k+kt3vS+Ny9NU
         ANzTix+x/KbffXB5FeMDTlFsu1g91MgsnFQv8EINDj5LxHx/dhGNq2QOcsFNvfxN6Idu
         Jctx+ZquLzJm4XPiteRnIqADMKfbeFu7PdB69BUAs8hA5HFRqsXVa90yXJ2UaQqODoaj
         JcwWaUdCTwed0mINDQLNSEjH9/zrkHUqQ3eN3u/L+SLA1OBQ4r9b5B4xTj8e9kk1czBd
         +9ww==
X-Forwarded-Encrypted: i=1; AJvYcCV97S6NxctGouS2vgJhR9yzBoZlyCQsyPdCapAgJ8SbmhyuRl2Q7rgVs00SwQgZvvyaJtEVo1ZoXx7oeDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZCMdM11pa66Rgodhz78V1lcvSjxMUgP0sDNVVTfXln5Jc3lQ
	FcSmxAHIetET3B9Jt+o2AGsZe7PAL91Bl8Fm59o4hQWgwP1wfG/Z4RxX9f2qk74=
X-Gm-Gg: ASbGnctenMFp/D8tYD2K7bzQALumn1q5jiqFawx7Lmzrb1F5kynPHjTxu/lt5fyJcm5
	fSDDeiupsEyGBFMv7rFr3Vd8nIWUqjLZqdkUJVE1NCRWOa5apyNv52UrEvVuPA9OsXYwhClW7W1
	vjdQ9BQY97pTudOcS0YaICmO36hD45VnaXH1H/1Ona8iT/eVl6Ke3EqpRXj8srKdDuDSfc+6QjT
	84uytndTpfiMQn4ChMe7Wd7miDo7dEnDygr/W22H0M9Hhj51PWJDX2duRuLQWuE9mf+9CaRftx0
	Q8P9xto8BjLrYyBRwS4=
X-Google-Smtp-Source: AGHT+IGdl0++UlqTXUNR7gACpqCzd7MyieY3ey31m1e1WuRTW8wkYR95TKzvB0Cs2B7FjnJEVDg5eQ==
X-Received: by 2002:a05:600c:1e11:b0:439:86fb:7326 with SMTP id 5b1f17b1804b1-43986fb7498mr136680405e9.22.1740062029245;
        Thu, 20 Feb 2025 06:33:49 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:4c32:9600:f4cc:3400])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm21194136f8f.34.2025.02.20.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:33:48 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Date: Thu, 20 Feb 2025 15:31:55 +0100
Subject: [PATCH] clocksource/drivers/timer-ti-dm: add module build support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-timer-dm-v1-1-64b6dab5f4a5@baylibre.com>
X-B4-Tracking: v=1; b=H4sIANo8t2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3ZLM3NQi3ZRcXctUc8NEyyTTxKQUcyWg8oKi1LTMCrBR0bG1tQA
 Yb24NWgAAAA==
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Andrew Davis <afd@ti.com>, 
 mkorpershoek@baylibre.com, linux-kernel@vger.kernel.org, 
 Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1

Add missing MODULE_LICENSE variable and convert bool to tristate in
Kconfig to be able to build driver in module.

By default this driver was set at y when ARCH_K3=y.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Enable possibility to build in module timer-ti-dm driver needed in
Android context and Android Generic Kernel Image support.

I know any other clicksource driver support module build but i do test on AM62X and
AM62P EVM board and i able to use this driver and test it with PWM.

By default this driver will be always enable in bultin when ARCH_K3=y so
no impact for other TI SoC.
---
 drivers/clocksource/Kconfig       | 4 ++--
 drivers/clocksource/timer-ti-dm.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 487c85259967..6ba4b2c48a76 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -57,8 +57,8 @@ config DIGICOLOR_TIMER
 	  Enables the support for the digicolor timer driver.
 
 config OMAP_DM_TIMER
-	bool "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
-	default y if ARCH_K3
+	tristate "OMAP dual-mode timer driver" if ARCH_K3 || COMPILE_TEST
+	default ARCH_K3
 	select TIMER_OF
 	help
 	  Enables the support for the TI dual-mode timer driver.
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index e9e32df6b566..c6183e1fdb5c 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -1307,3 +1307,4 @@ module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_AUTHOR("Texas Instruments Inc");
+MODULE_LICENSE("GPL");

---
base-commit: 87a132e73910e8689902aed7f2fc229d6908383b
change-id: 20250220-timer-dm-9e71a9b5abd7

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


