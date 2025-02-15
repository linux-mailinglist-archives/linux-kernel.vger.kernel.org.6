Return-Path: <linux-kernel+bounces-515809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF786A3694E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EBA188D8C3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B08433CB;
	Sat, 15 Feb 2025 00:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgzHoSrT"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C8C2B9C6;
	Sat, 15 Feb 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739577797; cv=none; b=CrRlVuOU3/jWNgwH08S+QGD23W/uBT4dsESgvkTkv6lLmIYeZYKrOVPjmyq72BSa6LQEPsj+/dM2SYTW7/jJsYdACZi1Rdg2EnbXqAikzeG+MjCXQnBIIP2QKqNL6vnhTlRVixvfdS/Fn7F9mgTdia+Xph3TeGbupp0+KmSPMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739577797; c=relaxed/simple;
	bh=UZt3Sx5BqortNKMQ/4+d7A6bnmyYPHqSwK6q2bElWv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOiH0yi3IAdeNPHeGwasqbKg4jzPlCW1a+nrBZzifVrzSXOiWcSF8xqt+1ZOt1lqo1CdB30T5x+FX9zndZaySnjWha0lS+zjLDuEhHAs4J6wYrGSlAFKWAZTqRw9s/B1KcdEKY9bUxcq5HZ+AjcKwdKrb+nRV7oMF88UndWMQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgzHoSrT; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6fb3a611afdso17626837b3.0;
        Fri, 14 Feb 2025 16:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739577794; x=1740182594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7degOyP+5HxIUK+nkGc+HV6cv18/eI0UzCJ3KUecVYU=;
        b=hgzHoSrTUzgmJbMS8i4+bRkgLCKBkzwpj3Oq4ztRAWGV1n8Qi1/dIP7DLMrFlxVjrp
         VT59Pn+pzKwhRnVuGTfGU0oeTO9rCrFiojHOHJ+UMJdSIFF7i1yNU+2qYfJ3Wh8TkPI7
         +y1UC4vSV2C4eHj+9AiYkMO2JjABNLYJLVH3Sn7BhFJr/rT/JJocKX6ItbXrRKNzG+qR
         ONtMaMRJavZaij46TM7Uhes5k9+eQbTMzKfKM0jF3o/lX44XsSDXM7hb2LYdDtEgfLCw
         HuVU8L23lY/yT64LgX74wz4QOq+crSL+OW60zqvJ4AWqOp0lm59eeYXKYd9BoJXwvmCo
         pz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739577794; x=1740182594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7degOyP+5HxIUK+nkGc+HV6cv18/eI0UzCJ3KUecVYU=;
        b=cvqaj5YUT6i0FjUx8wlP2kYCDWYQJH8a7f2V/95zCZ75dP4sQ51Lkyad9NUYmJth60
         lA/i3k/onPRpj/7IqsOnSHvdPntEvIxRNHa1+pm7TLZGwcGjT03Y1lyFM0541p6jLe7Y
         MdKUiXHhv9ejjdgCssBBqDD9x+/eofXLpVO5sCLgB5Z7rp/dx7c9NOJ+q+ZiFZ7l4mPU
         hVkOy8cqqKJbNBGLoPJBYwJOfBO7fROOS1LyoY4+4iBo0GgFhDZK3he6B1aqHnAL4rJl
         6xIhuRFv3xn3dHwyRGqwKejkFeoOb8frZlkR+8YgMYPOEFJWxHs6atmazKIaQs8B+LdX
         37eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPlGXXoB7sx+SG66r2HrMJmQVawrXqsdpoa1wdE+utyiaUtMqBECY5vWfngqXE0oZCW/1ocgjiuH87F/Y=@vger.kernel.org, AJvYcCVvS/dAL6kFnL0GJfC/U6FnnT92BkW6W1bpR/S24/0ymV5hn5jDKJLQuFI2sZBgu6U5fTObHx10igepi58M8WjswxU0BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YypKXJqbcGA/pahAvV1ADGYRDdh1NE1JwwBIyyzpJhAFiNLu8j6
	LFTuo596p76BnKVxt298oU3uaU1dzXVzrHptCxLBKly1ta/GyLdf
X-Gm-Gg: ASbGncsKL4IiaAJzAz/d7ZMSm2ClZ+oCJC/uj9x9/2H54pFRhS+TjzeH2KiTWhVi5fj
	ZLAEpu4HrCkfjmRVe7uHAJv2bpI8A+0URrVCPBxebxI33RV9WzgVpSEBPEqhRbFi5h52qIGft+f
	OnSUq88uKShgZZyEQMmzbvMS6tS//hHJpPe8m97j7xwUs7NAg8XjxR98oDnOlz83TEznYr8jEAY
	FAJVm3UPJDehht2aWLQRgKW7r9Ivenq0atEKGVxNfIUeqVJTqSt2JtkR7zN5KvGB0x8qO1cjbKt
	CM4LKvueGaF2PsvWjXWStaM=
X-Google-Smtp-Source: AGHT+IGF82wIiXajjjsnCjQpmX9L/21cH1U7GHhNpZZYOWpxlPHY2CkxftG5WiXmNCzCI5UcjpMspg==
X-Received: by 2002:a05:690c:640f:b0:6f9:983f:4365 with SMTP id 00721157ae682-6fb58390c8cmr12268617b3.36.1739577794594;
        Fri, 14 Feb 2025 16:03:14 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fb35d586e5sm9844207b3.17.2025.02.14.16.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 16:03:14 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Hans de Goede" <hdegoede@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 2/2] platform/x86: thinkpad_acpi: Move HWMON initialization to tpacpi_hwmon_pdriver's probe
Date: Fri, 14 Feb 2025 19:03:02 -0500
Message-ID: <20250215000302.19753-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215000302.19753-1-kuurtb@gmail.com>
References: <20250215000302.19753-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let the driver core manage the lifetime of the HWMON device, by
registering it inside tpacpi_hwmon_pdriver's probe and using
devm_hwmon_device_register_with_groups().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 44 +++++++++++-----------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ad9de48cc122..a7e82157bd67 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -367,7 +367,6 @@ static struct {
 	u32 beep_needs_two_args:1;
 	u32 mixer_no_level_control:1;
 	u32 battery_force_primary:1;
-	u32 sensors_pdrv_registered:1;
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
@@ -11815,12 +11814,10 @@ static void thinkpad_acpi_module_exit(void)
 {
 	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
 
-	if (tpacpi_hwmon)
-		hwmon_device_unregister(tpacpi_hwmon);
-	if (tp_features.sensors_pdrv_registered)
+	if (tpacpi_sensors_pdev) {
 		platform_driver_unregister(&tpacpi_hwmon_pdriver);
-	if (tpacpi_sensors_pdev)
 		platform_device_unregister(tpacpi_sensors_pdev);
+	}
 
 	if (tpacpi_pdev) {
 		platform_driver_unregister(&tpacpi_pdriver);
@@ -11891,6 +11888,17 @@ static int __init tpacpi_pdriver_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __init tpacpi_hwmon_pdriver_probe(struct platform_device *pdev)
+{
+	tpacpi_hwmon = devm_hwmon_device_register_with_groups(
+		&tpacpi_sensors_pdev->dev, TPACPI_NAME, NULL, tpacpi_hwmon_groups);
+
+	if (IS_ERR(tpacpi_hwmon))
+		pr_err("unable to register hwmon device\n");
+
+	return PTR_ERR_OR_ZERO(tpacpi_hwmon);
+}
+
 static int __init thinkpad_acpi_module_init(void)
 {
 	const struct dmi_system_id *dmi_id;
@@ -11964,37 +11972,19 @@ static int __init thinkpad_acpi_module_init(void)
 		return ret;
 	}
 
-	tpacpi_sensors_pdev = platform_device_register_simple(
-						TPACPI_HWMON_DRVR_NAME,
-						PLATFORM_DEVID_NONE, NULL, 0);
+	tpacpi_sensors_pdev = platform_create_bundle(&tpacpi_hwmon_pdriver,
+						     tpacpi_hwmon_pdriver_probe,
+						     NULL, 0, NULL, 0);
 	if (IS_ERR(tpacpi_sensors_pdev)) {
 		ret = PTR_ERR(tpacpi_sensors_pdev);
 		tpacpi_sensors_pdev = NULL;
-		pr_err("unable to register hwmon platform device\n");
+		pr_err("unable to register hwmon platform device/driver bundle\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
 
 	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
 
-	ret = platform_driver_register(&tpacpi_hwmon_pdriver);
-	if (ret) {
-		pr_err("unable to register hwmon platform driver\n");
-		thinkpad_acpi_module_exit();
-		return ret;
-	}
-	tp_features.sensors_pdrv_registered = 1;
-
-	tpacpi_hwmon = hwmon_device_register_with_groups(
-		&tpacpi_sensors_pdev->dev, TPACPI_NAME, NULL, tpacpi_hwmon_groups);
-	if (IS_ERR(tpacpi_hwmon)) {
-		ret = PTR_ERR(tpacpi_hwmon);
-		tpacpi_hwmon = NULL;
-		pr_err("unable to register hwmon device\n");
-		thinkpad_acpi_module_exit();
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.48.1


