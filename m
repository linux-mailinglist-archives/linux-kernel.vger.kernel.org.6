Return-Path: <linux-kernel+bounces-384444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC0F9B2A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3AB21F21DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F8E1922F0;
	Mon, 28 Oct 2024 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0DNgqjC7"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD319006F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103995; cv=none; b=EgQd2tPE8DIwmgp5UvgcjkV6BI5+EVPTXAc0GbKaUby77PT/pSh3Oztvex4f75xEAH56Mo6mVfWb897c0bwDxv3wrewbM6xzPk9WNBjMJ/Odit7WCJgx1Ytd5WG7Pjh6ShwmX8ZRxgdo/AUlEA0BphL0k/tWND4NAuMCpAnjGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103995; c=relaxed/simple;
	bh=2RROZOcH+oga+LkTQCQ3HKoR/p0c6zp5n24zcxYyRyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UKiKGPcw31xdQeNZvzIRuQci99IkazCI7/WJKXvC9bcmiZWZxieiCUfQqPt5iWcpisQxdfkvZSeTF6nt+A0u/NcJCDWXe5xUB19w6oQHmwRyglVQGdl21Oq5dZnPIUYR9XEJC9eiEd2+CS1VH1Lo+/zLpRC8yxpdasOplGpPyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0DNgqjC7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f72c8fc1so4749260e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730103990; x=1730708790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4lUb1leR//RH9HeSKC0++QvL2bwzenRxNlIlRUSSGA=;
        b=0DNgqjC7+ceSq1UL0G5B2QRA5jcvCI0THpzm822Bmxcz3jwKmq3Dh5mSr/FgNAlB5t
         sH2H3lxy4QpwGheQ20v4w/TSRtTJ966XOszGzz7Tuvc4470Bd2egw3QoHWCLIx9zI/oR
         U7n0CcvQo573OQOSgRksi5o/DcEwiqmWqhSzVoYGiYHcukwISSnNnzzmDOu9oyMha1QJ
         t3v36dFNhTrzaupvNOr7C3lnXeYzh3JaR+/Mg+ZbuYOWQ0tyy8960Idk3luS4AHGmyL9
         3iNDrVyhnxdWqAfmV/4yEAWORIpA0gkDZRO9uLZZ1jpUAwo4IADY9XoCzwaJjOcA2l+5
         JXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730103990; x=1730708790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4lUb1leR//RH9HeSKC0++QvL2bwzenRxNlIlRUSSGA=;
        b=AstvSQw6Jc1hAIHUCb+KOhI5MzTMiurVtwOI2iWrn9Aybud5R8wwJ+wcCbeXGdNlsX
         1S+GCcDbx/6mY3z+9+SKG1m7CpoFuhiEppm49iUMgbxAGyQ5CK/QRXFw/jIhKoyCJlVV
         ayxhYCRt3ZJeI/j/QywWSJAsSq3R1flgPyGuJrz4twN1cggeTESHs+Q8TxXFANrx8tV0
         wUKBVMlyffbo1u/y58+XpFgjYkYkCXYJyf2QdNBwTjK6exLZE1KBbJ0GY7z5UcOreJMO
         n08bmleXVjBB0OxgxxbodIVbUMQ/bKRPDshs6YnkBqwSggPDTmzrie0K3V51JeM81Wa7
         JOrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCxsZhTElDpYPyDa5BbU4WPQuEB7xBum+oE1KE9Lkbb3Kerk6zQUtRL/h7aiMUdyMBC5UIdEAWRhhhxrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rhAOZA64uIJnLH7ZZCsHap1EjKMoZEIQ2UcQE1NcMqA4aJOj
	PtXi+FSTJo94rPFD6wSdSiQlzW0oY9qWtjsrFyDfug/DNVdNq+c2WWltS8rGGoE=
X-Google-Smtp-Source: AGHT+IGsx6b7R19/shmolSABawjSU1DLfRoeRAdMYcjKqH8zZId/xh3T0FxtiqljvTjayLaCaauwtQ==
X-Received: by 2002:a05:6512:1386:b0:539:f699:4954 with SMTP id 2adb3069b0e04-53b34c36247mr2181986e87.58.1730103990357;
        Mon, 28 Oct 2024 01:26:30 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317d03ea4asm108693965e9.0.2024.10.28.01.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:26:29 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: Switch back to struct platform_driver::remove()
Date: Mon, 28 Oct 2024 09:26:11 +0100
Message-ID: <20241028082611.431723-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8955; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=2RROZOcH+oga+LkTQCQ3HKoR/p0c6zp5n24zcxYyRyw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnH0qkMUSO5Fz/R5dHF7h+xrROdaiCMDlI4oIHX iBN8ITSMPmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZx9KpAAKCRCPgPtYfRL+ Tk02B/0U9Xz9cdoNPwJj9Ib7XsJIZzjlVD353ChiFsftx4MXJon3RyGSzG7OKOGNrIFnhRAucqJ kjFgam2FdKYpLZEATWXOYH6lpYsF6xMJCK9ZQI38I0ryrhfMmEoS4v5e0Svi133F5FDm2iBMtWU mOoPPv26PjtOl4UEzCLpi+X9VYE6qcknKt9L3gZU1hQDc9qr20AAw+bLFgVdTtmLAlb7cb0Vd0r bTTD0oXoZSXYcbQwxrz2cSwn/HvbMRr0ZuIuHQA9l1UHiqmZB/YpUCnrg2xMkxkhAvdVMm1KKag AF1rQm1rdMFuwCbeatcrXFIAVv+5cnIQTslnUWcvyJEQk3mi
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/platform/chrome to use
.remove(), with the eventual goal to drop struct
platform_driver::remove_new(). As .remove() and .remove_new() have the
same prototypes, conversion is done by just changing the structure
member name in the driver initializer.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/platform/chrome. While I usually
prefer to do one logical change per patch, this seems to be
overengineering here as the individual changes are really trivial and
shouldn't be much in the way for stable backports. But I'll happily
split the patch if you prefer it split.

This is based on Friday's next, if conflicts arise when you apply it at
some later time and don't want to resolve them, feel free to just drop
the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend.

Best regards
Uwe
 drivers/platform/chrome/cros_ec_chardev.c    | 2 +-
 drivers/platform/chrome/cros_ec_debugfs.c    | 2 +-
 drivers/platform/chrome/cros_ec_lightbar.c   | 2 +-
 drivers/platform/chrome/cros_ec_lpc.c        | 2 +-
 drivers/platform/chrome/cros_ec_sysfs.c      | 2 +-
 drivers/platform/chrome/cros_ec_typec.c      | 2 +-
 drivers/platform/chrome/cros_ec_vbc.c        | 2 +-
 drivers/platform/chrome/cros_typec_switch.c  | 2 +-
 drivers/platform/chrome/cros_usbpd_logger.c  | 2 +-
 drivers/platform/chrome/cros_usbpd_notify.c  | 4 ++--
 drivers/platform/chrome/wilco_ec/core.c      | 2 +-
 drivers/platform/chrome/wilco_ec/debugfs.c   | 2 +-
 drivers/platform/chrome/wilco_ec/telemetry.c | 2 +-
 13 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
index 7f034ead7ae4..21a484385fc5 100644
--- a/drivers/platform/chrome/cros_ec_chardev.c
+++ b/drivers/platform/chrome/cros_ec_chardev.c
@@ -415,7 +415,7 @@ static struct platform_driver cros_ec_chardev_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_chardev_probe,
-	.remove_new = cros_ec_chardev_remove,
+	.remove = cros_ec_chardev_remove,
 	.id_table = cros_ec_chardev_id,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 839154c46e46..92ac9a2f9c88 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -582,7 +582,7 @@ static struct platform_driver cros_ec_debugfs_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_debugfs_probe,
-	.remove_new = cros_ec_debugfs_remove,
+	.remove = cros_ec_debugfs_remove,
 	.id_table = cros_ec_debugfs_id,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index 1e69f61115a4..87634f6921b7 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -608,7 +608,7 @@ static struct platform_driver cros_ec_lightbar_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe = cros_ec_lightbar_probe,
-	.remove_new = cros_ec_lightbar_remove,
+	.remove = cros_ec_lightbar_remove,
 	.id_table = cros_ec_lightbar_id,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index c784119ab5dc..924bf4d3cc77 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -783,7 +783,7 @@ static struct platform_driver cros_ec_lpc_driver = {
 		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 	},
 	.probe = cros_ec_lpc_probe,
-	.remove_new = cros_ec_lpc_remove,
+	.remove = cros_ec_lpc_remove,
 };
 
 static struct platform_device cros_ec_lpc_device = {
diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 9c944146ee50..bc1a5ba09528 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -359,7 +359,7 @@ static struct platform_driver cros_ec_sysfs_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_sysfs_probe,
-	.remove_new = cros_ec_sysfs_remove,
+	.remove = cros_ec_sysfs_remove,
 	.id_table = cros_ec_sysfs_id,
 };
 
diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f1324466efac..ae2f86296954 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1326,7 +1326,7 @@ static struct platform_driver cros_typec_driver = {
 		.pm = &cros_typec_pm_ops,
 	},
 	.probe = cros_typec_probe,
-	.remove_new = cros_typec_remove,
+	.remove = cros_typec_remove,
 };
 
 module_platform_driver(cros_typec_driver);
diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
index 787a19db4911..7bdb489354c5 100644
--- a/drivers/platform/chrome/cros_ec_vbc.c
+++ b/drivers/platform/chrome/cros_ec_vbc.c
@@ -145,7 +145,7 @@ static struct platform_driver cros_ec_vbc_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_ec_vbc_probe,
-	.remove_new = cros_ec_vbc_remove,
+	.remove = cros_ec_vbc_remove,
 	.id_table = cros_ec_vbc_id,
 };
 
diff --git a/drivers/platform/chrome/cros_typec_switch.c b/drivers/platform/chrome/cros_typec_switch.c
index 07a19386dc4e..8d7c34abb0a1 100644
--- a/drivers/platform/chrome/cros_typec_switch.c
+++ b/drivers/platform/chrome/cros_typec_switch.c
@@ -318,7 +318,7 @@ static struct platform_driver cros_typec_switch_driver = {
 		.acpi_match_table = ACPI_PTR(cros_typec_switch_acpi_id),
 	},
 	.probe = cros_typec_switch_probe,
-	.remove_new = cros_typec_switch_remove,
+	.remove = cros_typec_switch_remove,
 };
 
 module_platform_driver(cros_typec_switch_driver);
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 930c2f47269f..cd71f1caea81 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -262,7 +262,7 @@ static struct platform_driver cros_usbpd_logger_driver = {
 		.pm = &cros_usbpd_logger_pm_ops,
 	},
 	.probe = cros_usbpd_logger_probe,
-	.remove_new = cros_usbpd_logger_remove,
+	.remove = cros_usbpd_logger_remove,
 	.id_table = cros_usbpd_logger_id,
 };
 
diff --git a/drivers/platform/chrome/cros_usbpd_notify.c b/drivers/platform/chrome/cros_usbpd_notify.c
index c83f81d86483..313d2bcd577b 100644
--- a/drivers/platform/chrome/cros_usbpd_notify.c
+++ b/drivers/platform/chrome/cros_usbpd_notify.c
@@ -156,7 +156,7 @@ static struct platform_driver cros_usbpd_notify_acpi_driver = {
 		.acpi_match_table = cros_usbpd_notify_acpi_device_ids,
 	},
 	.probe = cros_usbpd_notify_probe_acpi,
-	.remove_new = cros_usbpd_notify_remove_acpi,
+	.remove = cros_usbpd_notify_remove_acpi,
 };
 
 #endif /* CONFIG_ACPI */
@@ -230,7 +230,7 @@ static struct platform_driver cros_usbpd_notify_plat_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = cros_usbpd_notify_probe_plat,
-	.remove_new = cros_usbpd_notify_remove_plat,
+	.remove = cros_usbpd_notify_remove_plat,
 	.id_table = cros_usbpd_notify_id,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
index 3e6b6cd81a9b..9f978e531e1f 100644
--- a/drivers/platform/chrome/wilco_ec/core.c
+++ b/drivers/platform/chrome/wilco_ec/core.c
@@ -163,7 +163,7 @@ static struct platform_driver wilco_ec_driver = {
 		.acpi_match_table = wilco_ec_acpi_device_ids,
 	},
 	.probe = wilco_ec_probe,
-	.remove_new = wilco_ec_remove,
+	.remove = wilco_ec_remove,
 	.id_table = wilco_ec_id,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
index 99486086af6a..0617292b5cd7 100644
--- a/drivers/platform/chrome/wilco_ec/debugfs.c
+++ b/drivers/platform/chrome/wilco_ec/debugfs.c
@@ -276,7 +276,7 @@ static struct platform_driver wilco_ec_debugfs_driver = {
 		.name = DRV_NAME,
 	},
 	.probe = wilco_ec_debugfs_probe,
-	.remove_new = wilco_ec_debugfs_remove,
+	.remove = wilco_ec_debugfs_remove,
 	.id_table = wilco_ec_debugfs_id,
 };
 
diff --git a/drivers/platform/chrome/wilco_ec/telemetry.c b/drivers/platform/chrome/wilco_ec/telemetry.c
index a87877e4300a..7d8ae2cbf72f 100644
--- a/drivers/platform/chrome/wilco_ec/telemetry.c
+++ b/drivers/platform/chrome/wilco_ec/telemetry.c
@@ -417,7 +417,7 @@ MODULE_DEVICE_TABLE(platform, telem_id);
 
 static struct platform_driver telem_driver = {
 	.probe = telem_device_probe,
-	.remove_new = telem_device_remove,
+	.remove = telem_device_remove,
 	.driver = {
 		.name = DRV_NAME,
 	},

base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
-- 
2.45.2


