Return-Path: <linux-kernel+bounces-298817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC595CBD2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 13:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD17A284D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86893187847;
	Fri, 23 Aug 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fenniak.net header.i=@fenniak.net header.b="eX6b/epw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC0D181B88
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414317; cv=none; b=m7nWLLxJlTUYpN4/gbiiJE6CQ7BGu/TMPigMklMjrWNEX7x3+gG3uCy5LREyWkML7LKYQaCVQbj4xOb3QIB5ujeiy+A29NIgdm7vPuHZY+ddP0UqskR5oBfR16mxQRAqHfS9zbT+FjMbVZ9ozhsPJBle8u8AdYFWjpoys1tsSt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414317; c=relaxed/simple;
	bh=M0X62fZgR660OqYh/QaAI/DnGfsKl4Acfw7CnaUDR3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lmLt3xRHpxV/H8zTV23cUUT3riSqObsfZIoN/xpo9NQIjHlzsa9k3zNJWoRBWGuEe1eMzGU0oQ6seYnBk1GZlv1D4nGrj9XdvbnvgnwWeoj5OHenMKKLR7Coq95RpWlfF1rjVKpC17pf7SVg008IAc46Ei0M/ASLRLLFzoWOMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fenniak.net; spf=pass smtp.mailfrom=fenniak.net; dkim=pass (2048-bit key) header.d=fenniak.net header.i=@fenniak.net header.b=eX6b/epw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fenniak.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fenniak.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201f2b7fe0dso17603635ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fenniak.net; s=google; t=1724414315; x=1725019115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ753okLVrPQcSQx8laXwTZrkgm8wYxxXnj3EKQwJYg=;
        b=eX6b/epwR/s7UsviFrOxHPM0HkZe1CkmrBGdBZdOHxIaTh/uwCvBX2gQQ6tgU0rqee
         TL+eX7xqMYM5Dg9kKleYmDFyLfWcYMZg7lFQpsX/3sA1/1l/V2AusJwuKGdPNhzhIwxr
         Iy0jo/Umsnqnmydnwx6yh2qVCm+8aaESPO4jjKwYfn+ZN6xPKCmHmN1In5zuar5KV0ls
         uTSyBqPz8XlDaKhl2wF+S/OpPG3o4B0Ybov+RogvUgd10wMGwLCC09J7aaJbHPZ+cVX6
         +hN/vpKnRrrS1yG8/4l1o9B5Afr3vum++DTEu/oJHthprkY/mO4zmtBvd1vt88gmVezJ
         BkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414315; x=1725019115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qQ753okLVrPQcSQx8laXwTZrkgm8wYxxXnj3EKQwJYg=;
        b=HXtaPMY2q6YgiVLvEdP1900xaqujgZgJqeDTZcI5JjIpw2x8avQ7cv9RXW3Uh64Yuf
         ONMjkMzeqTF20GH1C3svKAtz6Qa+H0lK+Mn4zvAjzQFpiByaLv4mO4OAlPoA9xk3YAA5
         OGa1z26TZQDWjKnG4ZwI6ZbDalDJgCIFZRCvqmxZ5I6M3ksDvag9UEwGkiMb68tfTVRJ
         vubHuqfT6Bv6SmdYg4PtrJpRwlhJKKn1pqBJzGjuiPEZ7rYpnS/BeHpIiUTpAC9YoXtR
         B8Fca/sPVGvConDL9NUqYIO5c21lhMpYTuRDck+rWScuOqK+O0cEwxXujLvkoq+W8kEI
         0JTw==
X-Forwarded-Encrypted: i=1; AJvYcCVLALFG4fUQAUhE4FdLG1jdApB6Z4dcAX7vxt7EcUlLWDf2OQOo7nSbkr0Tb4FqD3+VqxbGwn8QIA8Qy0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nrD5Mf6HlzVbbdHf/abTcUmRwJJ5Ywr6CWG6c3QQ+fjnyZ9J
	ouiYslFawGufEufxbgUObPwdvCWxkkuW55mQYLzT7LutKq7qibvGmqsFPzwtcpI=
X-Google-Smtp-Source: AGHT+IGcagSKVRrqeqKYGELWF9o3/fwwXcnyAKNgYw86VSVELRo7EyAacgDpv5h9FUqtl5EZyJE24g==
X-Received: by 2002:a17:902:eccb:b0:1fb:93d6:9fef with SMTP id d9443c01a7336-2039e4cd9c9mr22997035ad.38.1724414315445;
        Fri, 23 Aug 2024 04:58:35 -0700 (PDT)
Received: from zenbook-nixos.tail73afb.ts.net (d104-205-214-17.abhsia.telus.net. [104.205.214.17])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20385581393sm27056685ad.102.2024.08.23.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:58:35 -0700 (PDT)
From: Mathieu Fenniak <mathieu@fenniak.net>
To: 
Cc: Mathieu Fenniak <mathieu@fenniak.net>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: Fix spurious rfkill on UX8406MA
Date: Fri, 23 Aug 2024 13:56:45 +0200
Message-ID: <20240823115657.69053-1-mathieu@fenniak.net>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Asus Zenbook Duo (UX8406MA) has a keyboard which can be
placed on the laptop to connect it via USB, or can be removed from the
laptop to reveal a hidden secondary display in which case the keyboard
operates via Bluetooth.

When it is placed on the secondary display to connect via USB, it emits
a keypress for a wireless disable.  This causes the rfkill system to be
activated disconnecting the current wifi connection, which doesn't
reflect the user's true intention.

Detect this hardware and suppress any wireless switches from the
keyboard; this keyboard does not have a wireless toggle capability so
these presses are always suprious.

Signed-off-by: Mathieu Fenniak <mathieu@fenniak.net>
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
index cc30f1853847..a6ee9440d932 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -50,6 +50,7 @@ struct quirk_entry {
 	 */
 	int no_display_toggle;
 	u32 xusb2pr;
+	bool ignore_key_wlan;
 };
 
 struct asus_wmi_driver {
-- 
2.44.1


