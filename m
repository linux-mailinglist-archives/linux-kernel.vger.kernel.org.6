Return-Path: <linux-kernel+bounces-543247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5D8A4D32B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26DC33AE259
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291C1F463B;
	Tue,  4 Mar 2025 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idbZ++H2"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D763D561;
	Tue,  4 Mar 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067719; cv=none; b=H8rc676BD0W4mhnFYxDCdxneUSXh5vO6/7gbZD9JSkkRUs7ludWm+iPt7LShKtwNfokqDulmGh0CBA0yOPrVVwfAvf0F97b0r/3oQXlgfpaq1LXkyKoZrBgDOM9n3m5Y/sNoO/O9qhkr4kY4hkqfve00meQAtCIp4p0bolyL0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067719; c=relaxed/simple;
	bh=HM4DVfNkfrRlI4k3ON1o90sWtnATPXYTdEpU1u1k/S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5rHBLIlfP/r0hcmQPkinIqhaHbc5ApnK6SW0uEfiRcPqc3H6V18PBrNC7lqt0uNWM0ClF+KoEWo694hMzIoQLGHOGWiPolVXGnCS2+mDqWKcLzOnS3k6kcYsSX0ctHucS88KmFbLFwbsvFLU9lUDvGADkccoG426RTXvpT0luc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idbZ++H2; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-52379e9b7d2so923658e0c.1;
        Mon, 03 Mar 2025 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741067716; x=1741672516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3YIX6yetjJBn5MFAQdtHY/u8Ku9kLavFSpuBk7UEr4g=;
        b=idbZ++H25A80Wwv4GpcZrSvFqfNLlrHv6RoQqhiHSKe1HNYXpBJ8hhODkQs/c9rP4S
         B5nhar6ER2M5XUjca75qyqePf8P5udP6r0ROQwvd4morhECobJDhzRmnXwEEg9EKBvP3
         QgN+N+En350yqDlun/3XM93HmsMDbUkB141JguROX5Hc59+huHOYlUXzdanuroE8R73m
         gmY37FwSBTqeaRyoAYUwwGcKjtkrvw9v7XpFTRyEdqnl3lHPX66jotUtlKrmb5RZzji5
         e2ulijblOaDVd9t0t08f0LNH85RvdaXNgjMY6SY1i63kygD1txZDC8JMXefr5OlsjTaL
         oM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741067716; x=1741672516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3YIX6yetjJBn5MFAQdtHY/u8Ku9kLavFSpuBk7UEr4g=;
        b=nW+2VDgAl+OUbAm1RJV5woVejdE3EHfo1z5rmcUWSHfSEGqvhgC4zCxHXxx1e5no/d
         uq4HlY0VJVCrwCvkFlQaSE81g9LtJAwjZBCPjwJLNtNt4dOjOZYhzrWXP6LgoGSMBw2o
         GtMvRWSWnd5PF68oco8uKNQovSzuXuJc0i+qapMJkx0W7gJ4CGR6moORGhuIEgbG8pj2
         aMK20EHJHUstNm7foj7c6foiYGOCQd+W9ZDGLHgxLo8emqyxDc5uLSzXruxBLF1wRXWw
         U02qs+JD7l5AT3dbPvzlstpI29PrjB301MiE20B7ZsgyiupBST0UKqKs7oAlpoP6M+bp
         f5yw==
X-Forwarded-Encrypted: i=1; AJvYcCUKQYlUTkA1WPgs2olw56/IiwOQi7ceniL04jZ/WCy3I8V/gMeknBB4JlYB5igIPz+izX9FnkW/BKHItgw=@vger.kernel.org, AJvYcCVMk4ZLT0bF5UXlPXBCniGqcZPQ08OA0oMEGUAZedHrGKGakH2O5ZQcwj1fm0VkQs98VuTjiVjZEJF4MmC+@vger.kernel.org, AJvYcCWc2YXnyRImbjNqj+oLvVvD3ns5dpkz+nLPoCDDK5/h1Yw/qnG5DDhJifrJivBD2Rkd/ljvF944QiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhiTcq/N12Zb/ZziyP5o31rHYJZCU7JKTHM3aDY1LZF8AFl6bh
	Mbae7U6YMsnZr6Wnc+dN09v8Toy9Jn1HYLh/ppJkWzI1v36V0c/R
X-Gm-Gg: ASbGnctgel0nUG+s42Ak9XMJn6EiNfjBJuNhxduOVqBCKxk73Gx2hVhZjPgp2Q7ZFkj
	HLmYdbSmnEYaYJgIX3EK336oaHxEsVv2+jwO9fsrAoWhAUa2pTfEvrlkOvEYDrbHBzIEyVUIPLQ
	flIO0DD3niP4+4cdcn96n68Ey94dtgv0mHZiG62JEN5NFSDhcKLf2P/p+ytGt1+6RORUO3568h2
	Q9dqSMJ0h0vThTMZJbpiZdWVHBmA6LQQYlXOvf0s9Swv/L5YNnMdQGd0zaiGhDg1taQ/dFHsYJN
	V1kiOT5cUPDIEJzqkal8kuawiH5YCeKQ45fUVxyA3mA1FmtZBNzT
X-Google-Smtp-Source: AGHT+IHAPEz+xNmNjACUxa/zmnzhr7l/KyPzJKeIISYokuv32Jl399bCDKD+k4VEeKmPk2/TXc1P3A==
X-Received: by 2002:a05:6122:2388:b0:50b:e9a5:cd7b with SMTP id 71dfb90a1353d-5235bdaa6aamr9940941e0c.9.1741067715771;
        Mon, 03 Mar 2025 21:55:15 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5237c8951absm1063791e0c.19.2025.03.03.21.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 21:55:14 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v1 1/1] hwmon: (dell-smm) Increment the number of fans
Date: Tue,  4 Mar 2025 00:52:50 -0500
Message-ID: <20250304055249.51940-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Alienware laptops that support the SMM interface, may have up to 4
fans.

Tested on an Alienware x15 r1.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Hi all,

Guenter, if you prefer a different patch for the documentation, let me
know.

~ Kurt

 Documentation/hwmon/dell-smm-hwmon.rst | 14 +++++++-------
 drivers/hwmon/dell-smm-hwmon.c         |  5 ++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/dell-smm-hwmon.rst b/Documentation/hwmon/dell-smm-hwmon.rst
index 74905675d71f..5a4edb6565cf 100644
--- a/Documentation/hwmon/dell-smm-hwmon.rst
+++ b/Documentation/hwmon/dell-smm-hwmon.rst
@@ -32,12 +32,12 @@ Temperature sensors and fans can be queried and set via the standard
 =============================== ======= =======================================
 Name				Perm	Description
 =============================== ======= =======================================
-fan[1-3]_input                  RO      Fan speed in RPM.
-fan[1-3]_label                  RO      Fan label.
-fan[1-3]_min                    RO      Minimal Fan speed in RPM
-fan[1-3]_max                    RO      Maximal Fan speed in RPM
-fan[1-3]_target                 RO      Expected Fan speed in RPM
-pwm[1-3]                        RW      Control the fan PWM duty-cycle.
+fan[1-4]_input                  RO      Fan speed in RPM.
+fan[1-4]_label                  RO      Fan label.
+fan[1-4]_min                    RO      Minimal Fan speed in RPM
+fan[1-4]_max                    RO      Maximal Fan speed in RPM
+fan[1-4]_target                 RO      Expected Fan speed in RPM
+pwm[1-4]                        RW      Control the fan PWM duty-cycle.
 pwm1_enable                     WO      Enable or disable automatic BIOS fan
                                         control (not supported on all laptops,
                                         see below for details).
@@ -93,7 +93,7 @@ Again, when you find new codes, we'd be happy to have your patches!
 ---------------------------
 
 The driver also exports the fans as thermal cooling devices with
-``type`` set to ``dell-smm-fan[1-3]``. This allows for easy fan control
+``type`` set to ``dell-smm-fan[1-4]``. This allows for easy fan control
 using one of the thermal governors.
 
 Module parameters
diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index cd00adaad1b4..79e5606e6d2f 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -73,7 +73,7 @@
 #define DELL_SMM_LEGACY_EXECUTE	0x1
 
 #define DELL_SMM_NO_TEMP	10
-#define DELL_SMM_NO_FANS	3
+#define DELL_SMM_NO_FANS	4
 
 struct smm_regs {
 	unsigned int eax;
@@ -1074,11 +1074,14 @@ static const struct hwmon_channel_info * const dell_smm_info[] = {
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET,
 			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
+			   HWMON_F_TARGET,
+			   HWMON_F_INPUT | HWMON_F_LABEL | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
 			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
 			   HWMON_PWM_INPUT
 			   ),
 	NULL
-- 
2.48.1


