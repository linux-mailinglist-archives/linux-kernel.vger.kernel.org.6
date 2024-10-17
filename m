Return-Path: <linux-kernel+bounces-369393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686F19A1CC5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D11B21FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C491D223C;
	Thu, 17 Oct 2024 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F49xVmPr"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B503398B;
	Thu, 17 Oct 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152846; cv=none; b=DBK+i7IW1IgrIpMpReI0/XOeg7q5n06leH9wYEqSscs6xtEut8rejmrEfNEkpSisr4Ojb22ydaOPfXjIjRJtPARIA+nAEgJUFoWOU7OzgjzWo+r3HeViAqpUTiKX1MBUWmGl1TbOdtwO8BIAcmqjq+7Y1nFt59NAZXa0oN4Rad0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152846; c=relaxed/simple;
	bh=RCLv3UmOizm1HJ533JdgCThpkT4GNta9AOVOkmRtWaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Im31izjd0Q1BtDhAOPbfGKx5KCJ+Kv+XlCoCWQwXWDS5JCqpvg5nevWLo8lv6ncawEacF4Qxx+QMHF4OhyQ53qrI2T0NKdStGF4avV1DAyUfYc2qzOysaXC/8dV+4mYdPVmmjZqmkI8noLZG5TEz7WOeCL98LbXVCMFFZgaEwEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F49xVmPr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso518497b3a.2;
        Thu, 17 Oct 2024 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152844; x=1729757644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQibhE7QBP9jlCZ6sIBHC05kDEf4eayahDhz5af+WFc=;
        b=F49xVmPrHeGJhQOA8NoUeTeLqmOpL6isInF1WOfwtv88V2k4x/BEAnbp1GX9FRMoWv
         1YD6bspNyKp9mPrehytfeuyRGTGfr1lJR2xwgRAKo6UzF5WGdSymTz1aIuQ4BmgP8Pwg
         a97aqiC+wwCOgZrCJk40/yge2x2qS+4V8aq5vTessy9Xv2/whNnlWy9qFc0UJc3rI4vV
         II/wE6ud1Y78bLh+t38MSsKPIJlhyptgcgpyhqy+O5E3lpdlzzuf8LLwnMtrJltdljLU
         wl5y5eew5xPaQnwcy2yfnbCm0IZl5zSjF3evcNC+ASaSWblYBZvJjewyRfBIcemV2GLS
         NJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152844; x=1729757644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQibhE7QBP9jlCZ6sIBHC05kDEf4eayahDhz5af+WFc=;
        b=ZQyWqp5p24pOqGx/HJRYQTfJp8N9EZbyNaJtRdOugVgW9UQzPejnoLuhHBYxlacUlT
         eu7hR7r0xBWs8BQAPdCFiS/xo+Y5BiDpfz2LgSp+meMh9dbFcEedUb1wW9RL7Pz6Y1Tw
         PWKzBDn104ndOPmwW7JOOjeGx3KBpr4UqBMlkKSKweMaqOqBKAxi1SRtBcIP+kv2ij+D
         5PqOxMbCdVU7hHMcGni/4k6I8KMqEDYk1ZUKhikrC1MuAr3K0eIdRlFeGWYNV2yQ+Eoy
         XRrfYqdrXoEJNLzVxmQmJFQghZRShzPPFr5QqtlrA64zsXd2zN/VZKvx5rTIKBRg/brb
         +vHg==
X-Forwarded-Encrypted: i=1; AJvYcCUG8dDzsXY+xKr8BEdiRi8WC17idSIJquNj8GEBNq2XvIay7hhCVxr50rPhhky0Z7IaTrxSQgjQwwTjtHM=@vger.kernel.org, AJvYcCUckqaXr4iOY/r1+Dg40U2rmKC0+C/qjioKFPPH9pu+lbx8dqmxJNJPUfViCh41K3w1KfpFNrkk/QANZ1H5co0q92UVtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7E0sR9nAULTxhxsfSaahFfss+FJmbHSnZlfHzdWoC1P33eET2
	dYQkbXIsqEWUBh32mKHe5BACJfIz278a0pYIq/qDphY26Gq1UeCF
X-Google-Smtp-Source: AGHT+IGJC2DK5BGTNxPLOqec1CmdazQVkSOplEYGpPaYwdjG7ag3iwzwDmAzi1LcWE7JJfwm5Rr3UQ==
X-Received: by 2002:a05:6a00:929e:b0:71e:768b:700a with SMTP id d2e1a72fcca58-71e7db05c3amr11586062b3a.23.1729152843685;
        Thu, 17 Oct 2024 01:14:03 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774a41e0sm4227842b3a.134.2024.10.17.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:14:03 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 1/5] alienware-wmi: fixed indentation and clean up
Date: Thu, 17 Oct 2024 05:13:40 -0300
Message-ID: <20241017081339.126564-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017081211.126214-2-kuurtb@gmail.com>
References: <20241017081211.126214-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed inconsistent indentation and removed unnecessary (acpi_size) and
(u32 *) casts.


Signed-off-by: Kurt Borja <kuurtb@gmail.com>

---
v6:
 - Unchanged
---
 drivers/platform/x86/dell/alienware-wmi.c | 134 +++++++++++-----------
 1 file changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index f5ee62ce1..16a3fe9ac 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -116,68 +116,68 @@ static int __init dmi_matched(const struct dmi_system_id *dmi)
 
 static const struct dmi_system_id alienware_quirks[] __initconst = {
 	{
-	 .callback = dmi_matched,
-	 .ident = "Alienware X51 R3",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
-		     },
-	 .driver_data = &quirk_x51_r3,
-	 },
+		.callback = dmi_matched,
+		.ident = "Alienware X51 R3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R3"),
+		},
+		.driver_data = &quirk_x51_r3,
+	},
 	{
-	 .callback = dmi_matched,
-	 .ident = "Alienware X51 R2",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
-		     },
-	 .driver_data = &quirk_x51_r1_r2,
-	 },
+		.callback = dmi_matched,
+		.ident = "Alienware X51 R2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51 R2"),
+		},
+		.driver_data = &quirk_x51_r1_r2,
+	},
 	{
-	 .callback = dmi_matched,
-	 .ident = "Alienware X51 R1",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
-		     },
-	 .driver_data = &quirk_x51_r1_r2,
-	 },
+		.callback = dmi_matched,
+		.ident = "Alienware X51 R1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware X51"),
+		},
+		.driver_data = &quirk_x51_r1_r2,
+	},
 	{
-	 .callback = dmi_matched,
-	 .ident = "Alienware ASM100",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
-		     },
-	 .driver_data = &quirk_asm100,
-	 },
+		.callback = dmi_matched,
+		.ident = "Alienware ASM100",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASM100"),
+		},
+		.driver_data = &quirk_asm100,
+	},
 	{
-	 .callback = dmi_matched,
-	 .ident = "Alienware ASM200",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
-		     },
-	 .driver_data = &quirk_asm200,
-	 },
+		.callback = dmi_matched,
+		.ident = "Alienware ASM200",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASM200"),
+		},
+		.driver_data = &quirk_asm200,
+	},
 	{
-	 .callback = dmi_matched,
-	 .ident = "Alienware ASM201",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
-		     },
-	 .driver_data = &quirk_asm201,
-	 },
-	 {
-	 .callback = dmi_matched,
-	 .ident = "Dell Inc. Inspiron 5675",
-	 .matches = {
-		     DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		     DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
-		     },
-	 .driver_data = &quirk_inspiron5675,
-	 },
+		.callback = dmi_matched,
+		.ident = "Alienware ASM201",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ASM201"),
+		},
+		.driver_data = &quirk_asm201,
+	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inc. Inspiron 5675",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 5675"),
+		},
+		.driver_data = &quirk_inspiron5675,
+	},
 	{}
 };
 
@@ -221,8 +221,8 @@ static struct platform_zone *zone_data;
 
 static struct platform_driver platform_driver = {
 	.driver = {
-		   .name = "alienware-wmi",
-		   }
+		.name = "alienware-wmi",
+	}
 };
 
 static struct attribute_group zone_attribute_group = {
@@ -292,7 +292,7 @@ static int alienware_update_led(struct platform_zone *zone)
 		guid = WMAX_CONTROL_GUID;
 		method_id = WMAX_METHOD_ZONE_CONTROL;
 
-		input.length = (acpi_size) sizeof(wmax_basic_args);
+		input.length = sizeof(wmax_basic_args);
 		input.pointer = &wmax_basic_args;
 	} else {
 		legacy_args.colors = zone->colors;
@@ -306,7 +306,7 @@ static int alienware_update_led(struct platform_zone *zone)
 			guid = LEGACY_CONTROL_GUID;
 		method_id = zone->location + 1;
 
-		input.length = (acpi_size) sizeof(legacy_args);
+		input.length = sizeof(legacy_args);
 		input.pointer = &legacy_args;
 	}
 	pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
@@ -358,7 +358,7 @@ static int wmax_brightness(int brightness)
 		.led_mask = 0xFF,
 		.percentage = brightness,
 	};
-	input.length = (acpi_size) sizeof(args);
+	input.length = sizeof(args);
 	input.pointer = &args;
 	status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
 				     WMAX_METHOD_BRIGHTNESS, &input, NULL);
@@ -508,7 +508,7 @@ static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
 	struct acpi_buffer input;
 	struct acpi_buffer output;
 
-	input.length = (acpi_size) sizeof(*in_args);
+	input.length = sizeof(*in_args);
 	input.pointer = in_args;
 	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
@@ -542,7 +542,7 @@ static ssize_t show_hdmi_cable(struct device *dev,
 	};
 	status =
 	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
-				   (u32 *) &out_data);
+				   &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -563,7 +563,7 @@ static ssize_t show_hdmi_source(struct device *dev,
 	};
 	status =
 	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
-				   (u32 *) &out_data);
+				   &out_data);
 
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
@@ -643,7 +643,7 @@ static ssize_t show_amplifier_status(struct device *dev,
 	};
 	status =
 	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
-				   (u32 *) &out_data);
+				   &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -695,7 +695,7 @@ static ssize_t show_deepsleep_status(struct device *dev,
 		.arg = 0,
 	};
 	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
-					(u32 *) &out_data);
+					&out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
-- 
2.47.0


