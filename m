Return-Path: <linux-kernel+bounces-280919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00AF94D0E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B441F21EF8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7A194AF0;
	Fri,  9 Aug 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3U2gxwvz"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255718E04E
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209232; cv=none; b=HnGP1F+6QAQyJNIkDvOt74BBdHR1XoUno5fETG7s5Jpdoa0ACuykHGNqeY0TNY0Izazt/ucgPErFCaozp4CoI8uh8EEQpKyJ+5k78p3dMx/CsT6YlC+o7/1Z0Fxbhh5TyjimEo+Zu1RLUEkOPkfugauVVDCifpH8OlhHl0bfYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209232; c=relaxed/simple;
	bh=98Z/diLKNDBsST+GyskNA46yYAnNS1EgmuzelcgBkGU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJV2/YHjTjleVVc5TLaPNsV9u5O3BS+hT4hvGDiOw+/XORLJjAgKVTKsR0g7Sd0J3ydGc9iNjUd57Jzi56ON/SgSwRDKGnIE1q0OY1Otv/QpTlhfr8JdbgQ6k0qCJ9JOIsN3oapnWT55wh1HsqbYhSEyDLzHmw/x2AxynhH5n+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3U2gxwvz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6902dc6d3ffso51108087b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723209230; x=1723814030; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfk55jXbMJ+9XW8lw7BFbqVnIJpApyghmdPVYouiRvE=;
        b=3U2gxwvzxhp+p7WyFOS7vl6kVG5g4BRxj2cYPKMnIpBXD/LQQpa0cSp7phIHciDUoB
         UxohIqI9llqldjkQ2yj9wpLVY6oUdNi2v5MUrNQMrC5EfLkTqCknGJwHLn5aUOLHsG2H
         Rv30gBFILfWQ76TFu16ZV0qOlHKFwHS5hU59LmaRj74L3AXGceHanyh0qB76prJ++TIE
         9D2C8tLn6Zn5e3TPO+OL8S/gzvqPMI3YA5nt+8AYYb1AQz/2FrsnHCosI6I/eH0t1pjk
         0tSEETmvOSliVL1J9R83pT3qiOx1a3hBIq34L6z2Tas9l3HwPScBe5tDPj2s27rhpEKV
         J/zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209230; x=1723814030;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfk55jXbMJ+9XW8lw7BFbqVnIJpApyghmdPVYouiRvE=;
        b=Jda0W+S+KyzuaAvgFthljCYzngoZU4WBdPx/1roCEZ4SW/lXLfpbKLZQYLrVKg8DjF
         JRHt5v5dJtdoOLE5C5ywH0rP3zcqvld9CWi0lHsmlxW3U1q4ghaAG/gdRBmeuESIa7og
         018RP5iXu9G6KTvW5LyHuQ4S5Rcan2FsntLDI4som3pojHjsGnCnGT0qGNGXr6BSc4l7
         GpesyqXiJcVYKygvajJqLszo7q2iZZ0YkdRnryvOch1wT6j+IFe++Got+HdBLLRa5XAy
         DR7QEmfOFE/5MrToj9v+eWffKEh4l+3M4qtrM6fOq3avmG5ZECfkaEbrD4tvSXYQknOt
         iJhg==
X-Gm-Message-State: AOJu0YweCMylSKhVBE0PHucOv610A0WhoXBdn0HwhzF/JBdZnWjAcG2p
	Dkyr1tYs16Z9PsheYI2syPIfeEmkSLcuPh+No8iAoeVEUCY/wM1Xzc4aBdMpDmzQjw1QiyZjUOr
	OmGXuNSsD8K4y5fFpzwOStgx7NU3+u6/bggCLeNoN8UV9aIVrHmv3wvfpcb3N+p8tUR3B+QCHWn
	1EA9e9Dg7V2cHquy6Q2+wDOA5SRZPkWhz2ug2PBrQKOcQHHox1uFnaTVtz
X-Google-Smtp-Source: AGHT+IH4kJBCxiOiei21ZZPcfcqwWZSWG5cinBXlbnJTFOwf/ORgOJMo9yMLleQC22aHWj0qjIMdzl6ROAG0znA=
X-Received: from mmaslanka2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:b8d])
 (user=mmaslanka job=sendgmr) by 2002:a05:690c:711:b0:691:2f66:4b1c with SMTP
 id 00721157ae682-69ec8c8e4camr110527b3.6.1723209229629; Fri, 09 Aug 2024
 06:13:49 -0700 (PDT)
Date: Fri,  9 Aug 2024 13:13:32 +0000
In-Reply-To: <28567169-4588-002d-85b8-906d22f12f05@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <28567169-4588-002d-85b8-906d22f12f05@linux.intel.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809131343.1173369-1-mmaslanka@google.com>
Subject: [PATCH v4 1/2] clocksource: acpi_pm: Add external callback for suspend/resume
From: Marek Maslanka <mmaslanka@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marek Maslanka <mmaslanka@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>, 
	David E Box <david.e.box@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Provides the capability to register an external callback for the ACPI PM
timer, which is called during the suspend and resume processes.

Signed-off-by: Marek Maslanka <mmaslanka@google.com>

---
Changes in v4:
- No changes as this was introduced as a separated patch after the v3
  review.
- Link to v3: https://lore.kernel.org/lkml/20240730120546.1042515-1-mmaslanka@google.com/
---
---
 drivers/clocksource/acpi_pm.c | 27 +++++++++++++++++++++++++++
 drivers/clocksource/acpi_pm.h | 16 ++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 drivers/clocksource/acpi_pm.h

diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 82338773602ca..c629f5462bc0f 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -25,6 +25,12 @@
 #include <asm/io.h>
 #include <asm/time.h>
 
+#include "acpi_pm.h"
+
+static void *suspend_resume_cb_data;
+
+static void (*suspend_resume_callback)(void *data, bool suspend);
+
 /*
  * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -58,6 +64,25 @@ u32 acpi_pm_read_verified(void)
 	return v2;
 }
 
+void acpi_pm_register_suspend_resume_callback(void (*cb)(void *data, bool suspend),
+					      void *data)
+{
+	suspend_resume_callback = cb;
+	suspend_resume_cb_data = data;
+}
+
+static void acpi_pm_suspend(struct clocksource *cs)
+{
+	if (suspend_resume_callback)
+		suspend_resume_callback(suspend_resume_cb_data, true);
+}
+
+static void acpi_pm_resume(struct clocksource *cs)
+{
+	if (suspend_resume_callback)
+		suspend_resume_callback(suspend_resume_cb_data, false);
+}
+
 static u64 acpi_pm_read(struct clocksource *cs)
 {
 	return (u64)read_pmtmr();
@@ -69,6 +94,8 @@ static struct clocksource clocksource_acpi_pm = {
 	.read		= acpi_pm_read,
 	.mask		= (u64)ACPI_PM_MASK,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	= acpi_pm_suspend,
+	.resume		= acpi_pm_resume,
 };
 
 
diff --git a/drivers/clocksource/acpi_pm.h b/drivers/clocksource/acpi_pm.h
new file mode 100644
index 0000000000000..c932899f04282
--- /dev/null
+++ b/drivers/clocksource/acpi_pm.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ACPI_PM_H__
+#define __ACPI_PM_H__
+
+#include <linux/types.h>
+
+/**
+ * Register callback for suspend and resume event
+ *
+ * @cb Callback triggered on suspend and resume
+ * @data Data passed with the callback
+ */
+void acpi_pm_register_suspend_resume_callback(void (*cb)(void *data, bool suspend),
+					      void *data);
+
+#endif
-- 
2.46.0.76.ge559c4bf1a-goog


