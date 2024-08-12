Return-Path: <linux-kernel+bounces-282559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6694E5CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3741C214F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 04:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D050149DFD;
	Mon, 12 Aug 2024 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuwKuT5C"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405346F06B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723437516; cv=none; b=B1s1sLi66iU7ZHgbYxKkroS05mcrEkQZNPG8D5Wi8FrKWIvHhzeBwHUtnNtnQYcT5NKkk6Vp2lm5/2dzkX81nfC4EGgqEuo+gt5cTKXztloWTn85USPuOdcaKoGTZuOPWvpZV5P2iMN/cTEpKGE16adybondPiWp0P7CqBkShWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723437516; c=relaxed/simple;
	bh=HcV6yMjA3LIpdLj4nCBEbMLGMaLfRAF+zNo/BAPONvc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hriWqQ3wNKC9PEbErc6rRyze7hMCg2OEFAwod6K53GoVBUG4/VUUQZSdKQkZccq0sC/AGgKzO0e0LPOSM7KLg7IOnc5SF0/l9zS6NPwd6kGuChaoJtscpCgqQjANm876OcjMz4ybxTsaOy7gZc1aCyHK9bX6ySdkobSgdd8ewmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuwKuT5C; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaslanka.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5b58f321a2dso2888412a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 21:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723437513; x=1724042313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MNZQ1+HS+QlepxqeqJkqDCRKCGow2ML07u/WS6GSwCk=;
        b=HuwKuT5CtEbpjwn6C33rxjXycqojdRYwNUU6Y6W3IuAj4yZWzDHdKPF9rnpSPYCZh1
         WXbRi2Oa7wemhMvlfnyoiw/cGWZrR6Thw7iwvuHuPiXCP9pZzeSJ/mjRL3EdRJlJhkeF
         075rViHaCPznAwWZThePYrImgofxZKY136nWKb0idlYJDEazjeBQBamsMHWw0X8ylJML
         cUs/nZ7439A/X0QYxwZzkYcOL3oRd1t4x3vC1NPsMhOOFJmYWjibuJQzaFv+p3x5JJ6K
         f4y5xKBmUc2ot8udtSD+G7AvMbDCZc7Ii3qn7r3iceFfKIFRGKHPU7e/oepgsVB5X3su
         iEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723437513; x=1724042313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNZQ1+HS+QlepxqeqJkqDCRKCGow2ML07u/WS6GSwCk=;
        b=uwBYjIhDsMN+tdO27mLvmKWcwVCsYHkyEQrnjkChO97EwLWX13bfmaw/uJyKPdXVEd
         A2hVh4+R6XPHgZ3X/J7MfcQDuX69I41SdqPz/oB7g3b6ZCpr8CXQ8LljzzotmVNt/HFR
         SR1P00WDrw//jaXJBGxBWm/20d1CU5aBqC9kTIhVgLVvhjgHy/OgkvexnAnPnLX4ymsy
         b8lNF/nbDbdnWSiDWdw6Ey5AAAg5OdiVrRbGhX4wG7uKkK4nZbphOcU5SX8m40bFfb/S
         4ydT+gKGBjqQ0gelecimDY0OeHFAWjC+hQ0PF2NLlrSpFSmR0PToq2x1ZlFt5MFFlCnG
         z84A==
X-Gm-Message-State: AOJu0YwjVIFGUOYW3POndWY6ZIKr7v+0CFvHF9TA2s8BYNrljBi85of1
	YM2UaJES4ZskUvOorftjxiquqHWAduecDwGTePMCRglJThwhu9x7wb0yfVfrAwa/vM/hHISUUu1
	qLBO8kpvlf8vpPfWlCeimOBJUJhGxbdu/EaPeKfrOO/LSsimrGsHqZySlR1olucjtHfgBlq/lLz
	+jY4xGo/m75IwM1yafu/A27f0UmYmSuh81pdC/7lcPOQDqYsLQv1bkEbrR
X-Google-Smtp-Source: AGHT+IFG10XM2VqmASA64zEFoO/A1KC5Y4D/ZSvGHcinG6yML5646Do+2sFLpiEjUt8fQYz9XPbq/gPN5G53z7I=
X-Received: from mmaslanka2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:b8d])
 (user=mmaslanka job=sendgmr) by 2002:a05:6402:234b:b0:57d:5506:5adb with SMTP
 id 4fb4d7f45d1cf-5bd0a510356mr10913a12.2.1723437513252; Sun, 11 Aug 2024
 21:38:33 -0700 (PDT)
Date: Mon, 12 Aug 2024 04:37:34 +0000
In-Reply-To: <87ed6xtsms.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <87ed6xtsms.ffs@tglx>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812043741.3434744-1-mmaslanka@google.com>
Subject: [PATCH v5 1/2] clocksource: acpi_pm: Add external callback for suspend/resume
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
Changes in v5:
- Rename acpi_pm_register_suspend_resume_callback to
  acpi_pmtmr_register_suspend_resume_callback and move prototype to
  include/linux/acpi_pmtmr.h
- Remove the acpi_pm.h header added in the previous patch.
- Link to v4: https://lore.kernel.org/lkml/20240809131343.1173369-1-mmaslanka@google.com/
---
---
 drivers/clocksource/acpi_pm.c | 24 ++++++++++++++++++++++++
 include/linux/acpi_pmtmr.h    |  8 ++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/clocksource/acpi_pm.c b/drivers/clocksource/acpi_pm.c
index 82338773602ca..fab19b7de55c1 100644
--- a/drivers/clocksource/acpi_pm.c
+++ b/drivers/clocksource/acpi_pm.c
@@ -25,6 +25,10 @@
 #include <asm/io.h>
 #include <asm/time.h>
 
+static void *suspend_resume_cb_data;
+
+static void (*suspend_resume_callback)(void *data, bool suspend);
+
 /*
  * The I/O port the PMTMR resides at.
  * The location is detected during setup_arch(),
@@ -58,6 +62,24 @@ u32 acpi_pm_read_verified(void)
 	return v2;
 }
 
+void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data)
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
@@ -69,6 +91,8 @@ static struct clocksource clocksource_acpi_pm = {
 	.read		= acpi_pm_read,
 	.mask		= (u64)ACPI_PM_MASK,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend	= acpi_pm_suspend,
+	.resume		= acpi_pm_resume,
 };
 
 
diff --git a/include/linux/acpi_pmtmr.h b/include/linux/acpi_pmtmr.h
index 50d88bf1498d7..a5262d28b97e0 100644
--- a/include/linux/acpi_pmtmr.h
+++ b/include/linux/acpi_pmtmr.h
@@ -26,6 +26,14 @@ static inline u32 acpi_pm_read_early(void)
 	return acpi_pm_read_verified() & ACPI_PM_MASK;
 }
 
+/**
+ * Register callback for suspend and resume event
+ *
+ * @cb Callback triggered on suspend and resume
+ * @data Data passed with the callback
+ */
+void acpi_pmtmr_register_suspend_resume_callback(void (*cb)(void *data, bool suspend), void *data);
+
 #else
 
 static inline u32 acpi_pm_read_early(void)
-- 
2.46.0.76.ge559c4bf1a-goog


