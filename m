Return-Path: <linux-kernel+bounces-298973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D795CE7C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9C01C22F33
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9E188598;
	Fri, 23 Aug 2024 13:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fenniak.net header.i=@fenniak.net header.b="N+a0pMmj"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359EB46556
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421432; cv=none; b=ujLcq6l+LC6cogtUO6pe7tUzi+w+AvY85smEc6na/a6tNARToAbJSdtGhfterJqY6har5h/m/wFVa4kK+7qyq76t+W8wdgHclLdoLdVqnhIMjjiLoSbpSGeBuXxbzSTeFUOVoOT1DTa4fP9Idf+kxQQKuR3mr3iAmobd6O4HqMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421432; c=relaxed/simple;
	bh=Hct+fFSW9c9vUbZKkWYHlkYkWzjV+myTSNDEd8GyNZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gyw+w3jCbkPBbv0XrDaSJ1GPkIbhzCiWcj2aCpLkgQSj57OHW74WrdtrbjMJOIoQvyWfAS53nbaRiil6NJQc24ePHVQuKc9BFk9wJUB8FfYClTNNx6C0W9X2Jqxv+PybSGY4R/0xQ8ZwK5dXWWkXYBe/AudGxYZtd+Dwbj7J7KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fenniak.net; spf=pass smtp.mailfrom=fenniak.net; dkim=pass (2048-bit key) header.d=fenniak.net header.i=@fenniak.net header.b=N+a0pMmj; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fenniak.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fenniak.net
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3bae081efso1569840a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fenniak.net; s=google; t=1724421429; x=1725026229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35XQX7bIYPMcCPaB6P3F7Jnu4KwL6KW54O+hnKmNXUc=;
        b=N+a0pMmjj/BxypeU+scxrfL54OLRS1wdzmJx7uUnULDz+n7L2WvHHPyCRjIK4v8/f/
         P2veucSxhknoADw/hxuHt/5bpYpjePpMLfGWKnPRRPqhmL3i2Yk5W63kkTeztQ9Of7Mx
         lAi3A1XilbBJJPxoLg71hWmW2vOhME5zpUd+QHOfEuEISiERP1ZEljEY5J0pNRc7kjnA
         XUkRb1gWyfgAb0U41ixQ3bN7Q7Rz3wrr27vZ1vOvNc6JINq5lklAeMkCcxhR9o0VgJ4f
         7Aq0bFy+d2fJNjk5Unos45vfvA6rrAqFeVKcnGaESz6tUQrfYObQv81mfg28Wtrb1J7+
         RbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724421429; x=1725026229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35XQX7bIYPMcCPaB6P3F7Jnu4KwL6KW54O+hnKmNXUc=;
        b=Ibc2LnAsBG9FTGVKC9c0FYu8Jcws0y7YOb/1hZz4qpUjchUXZVvaV3pnofiGsWNGeR
         bHjii+jnDhKeaxC4sQTC5Jmy4rRS5KPrGMSTLicrxBMjunNPL4JIN7w75G8GG41/LUCE
         ATYW5PHbffpqDxL0orqOfhDAr0e8ePFYfeNSax2mbcB4k04xq1jP5Ob8fOb6cyCIRAzY
         kegFiJcAqeta0zOcgL2+2U95pIc4DfEL+/3+GNQyoBkr2CiQ06qo7bW9fJarUhQYDUJU
         8UIoW+kbVwx9reuQNEknWDUK3v7QhXgMRRFHnLqeh753gSloN6LDyZbW3v3E3pPZW1SY
         eZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXJkBwpIsQZphYBRS9okGfgVKRW7sqs0SFUK4nEA6rA2dILsBk7/O+IvAYU/WjTfbCXJ1ueYHd8Gf6UwwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6f6jZ+t0ndJuNbAErDIV5y82/rg8ekcvUMMlF5X6rJuklpw2
	lavTPEoMWU3hPHJYctvik6+EhlrbojI4WgiiSargOcSlXPmYlEZ/g2crNPGy+Fw=
X-Google-Smtp-Source: AGHT+IGiBAWiVmuhaMRuDYBJY9TDgplLBlPfGGbZIGjwQ+hUM0XWf5CO11KnFeBGhUQCjD46P9Y3Yw==
X-Received: by 2002:a17:90a:4cc2:b0:2d3:b93d:ba48 with SMTP id 98e67ed59e1d1-2d646bd1a27mr2594098a91.8.1724421429460;
        Fri, 23 Aug 2024 06:57:09 -0700 (PDT)
Received: from zenbook-nixos.tail73afb.ts.net (d104-205-214-17.abhsia.telus.net. [104.205.214.17])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d613a5c550sm4126103a91.30.2024.08.23.06.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 06:57:09 -0700 (PDT)
From: Mathieu Fenniak <mathieu@fenniak.net>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mathieu Fenniak <mathieu@fenniak.net>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA
Date: Fri, 23 Aug 2024 15:56:28 +0200
Message-ID: <20240823135630.128447-1-mathieu@fenniak.net>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <45764fd3-f715-c461-1f6f-071bad742460@linux.intel.com>
References: <45764fd3-f715-c461-1f6f-071bad742460@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Asus Zenbook Duo (UX8406MA) has a keyboard which can be
placed on the laptop to connect it via USB, or can be removed from the
laptop to reveal a hidden secondary display in which case the keyboard
operates via Bluetooth.

When it is placed on the secondary display to connect via USB, it emits
a keypress for a wireless disable. This causes the rfkill system to be
activated disconnecting the current wifi connection, which doesn't
reflect the user's true intention.

Detect this hardware and suppress any wireless switches from the
keyboard; this keyboard does not have a wireless toggle capability so
these presses are always spurious.

Signed-off-by: Mathieu Fenniak <mathieu@fenniak.net>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/asus-nb-wmi.c | 20 +++++++++++++++++++-
 drivers/platform/x86/asus-wmi.h    |  1 +
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index fceffe2082ec..ed3633c5955d 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -145,6 +145,10 @@ static struct quirk_entry quirk_asus_ignore_fan = {
 	.wmi_ignore_fan = true,
 };
 
+static struct quirk_entry quirk_asus_zenbook_duo_kbd = {
+	.ignore_key_wlan = true,
+};
+
 static int dmi_matched(const struct dmi_system_id *dmi)
 {
 	pr_info("Identified laptop model '%s'\n", dmi->ident);
@@ -516,6 +520,15 @@ static const struct dmi_system_id asus_quirks[] = {
 		},
 		.driver_data = &quirk_asus_ignore_fan,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "ASUS Zenbook Duo UX8406MA",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX8406MA"),
+		},
+		.driver_data = &quirk_asus_zenbook_duo_kbd,
+	},
 	{},
 };
 
@@ -630,7 +643,12 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 	case 0x32: /* Volume Mute */
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
-
+		break;
+	case 0x5D: /* Wireless console Toggle */
+	case 0x5E: /* Wireless console Enable */
+	case 0x5F: /* Wireless console Disable */
+		if (quirks->ignore_key_wlan)
+			*code = ASUS_WMI_KEY_IGNORE;
 		break;
 	}
 }
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index cc30f1853847..d02f15fd3482 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -40,6 +40,7 @@ struct quirk_entry {
 	bool wmi_force_als_set;
 	bool wmi_ignore_fan;
 	bool filter_i8042_e1_extended_codes;
+	bool ignore_key_wlan;
 	enum asus_wmi_tablet_switch_mode tablet_switch_mode;
 	int wapf;
 	/*
-- 
2.44.1


