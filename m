Return-Path: <linux-kernel+bounces-387948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1ED9B5856
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B31E1F23C2B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FB610D;
	Wed, 30 Oct 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv/ylyDE"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF97E79D2;
	Wed, 30 Oct 2024 00:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247049; cv=none; b=IJLSFrrzu4eZCCaoqhcvBNpHbqMrkjSDpFS2qrZL9ahNkvuFrtjUzvHWIR8dvcPUtz6d1L2l9kua1g94jKU3tbyMPZQ5IQcI4tkI3Y6V62KhiKNAVsXGuSv5o0X78YwS/rH5WaT/SYmMLl/dRtlHeaE8zyctAswnusNRKZpdxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247049; c=relaxed/simple;
	bh=1Pxh1pyMDQnlkEd4p4KsoDm6IGcNHIPrg+dxp3S4+mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMMvWARqmHUk1dr9X2IsbvmzF/lkqDm9Ij8WjCwmijDCdH2ua4tkNSDsYDEAG5LC2+uXUj8LkhsN5v1zoXyaRNfWVJxdJZk2YNRgZ0Ou1UNda2oG/Kl3D4OVYmo8Z2h2o6dSk3R4Wj71d9SfmvxCk1ZQoyxen/hluMMj+IULQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv/ylyDE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cbca51687so56770025ad.1;
        Tue, 29 Oct 2024 17:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247046; x=1730851846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnhrTQhjmp/plopFDNAE0Rx2S5Oi1kD7CR2cs1JiPrw=;
        b=Pv/ylyDEyomHX9gDNzOtaDGRmANWsgqjWxuF6GzqaejW4K2bFEIMITuuMgvNcbqJuB
         OJWhynru7M+rAYqOtCvMUNh/2fTRZ8JG766QSX+1EWyE3jc9p9PQjrcc+DeFfsSlbLIv
         f9c/JiktSj/WdX1sYvJbuSL1MSHRAyzZKRJXklgH374L41MdxUCydaZniRtTuFZYbOlo
         Ixv1Sk8g3OG5uzWhe9ndiaZYi+sIb9FVEzggsMIw07BxpLPjhLAoHcOy73R0sPDtzwxl
         DN+AHt4dLXzzTNTwb1gExqShx5d/EtP3hb0rekYkj0OYsZKHq/d3O7+ms9j6hJoh11PD
         kbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247046; x=1730851846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnhrTQhjmp/plopFDNAE0Rx2S5Oi1kD7CR2cs1JiPrw=;
        b=fHzkVIWADZ2TK9xqx0AZwRUTC+GiPKrMSZyFfkS5bAmCONE8upj5mZDV46SQOOwL5K
         a66LdaZsdxNBegYRIBLjB0rx9ri0hhJu7QYyQ8Ox4eDZTSQiEGGh94TjxqHah21PxVRZ
         d1MChPTk/72Fb66sddUn1XM94fo3+rF1PSQZ5wIdIuu0YMNcvVIEkyUXjA8Dm6nYWBDE
         qZ9/edm7HC02jToiYaGI6tO8SesGNjG7rsAUOBnBEJOw1i0iHVluAyML9r8CYkFc+Mnu
         ySTzT+sOt0lnh/Zps8LfsquDgrIfwmp7kaYLPaRl9tGo8QWsJV4M14NCJvCAOWiDnF1R
         L8Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWDuj2iizGJyhsA2tr+EJWSMk/1seqjGLsJVaI+OgtBvPPBiri1PDsQAKfjy97NmxloPA6JRFsyt6CD8MmrTtAope5JWw==@vger.kernel.org, AJvYcCXR42tkXtt6HaHiI+8WQDYnNzptZ0YhIHPW4YiZqkn5hjG9cFVtujhbrOpteXdp58q7UEG8+ix8Nl6xyD8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9Ic/HxccfEqQpVwp7LGAor8ylCkhPuEUxiUer16kf0r3rEIc
	zZFbR0NqkFkn21sh40V5VCowPhOCOuanW7BzpeXIKGNSq5cCfrV6FSp7Ng==
X-Google-Smtp-Source: AGHT+IGnGw4p6dDOolEQqW1GXjVWCJ1pBA6DNUgdPA78SlfVUEsFyyJxAbLtGaYWPcUYnGdvquC4WQ==
X-Received: by 2002:a17:903:2312:b0:205:8407:6321 with SMTP id d9443c01a7336-210c6879f49mr174544765ad.9.1730247046053;
        Tue, 29 Oct 2024 17:10:46 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf8849bsm71742275ad.117.2024.10.29.17.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:10:45 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v11 1/5] alienware-wmi: fixed indentation and clean up
Date: Tue, 29 Oct 2024 21:10:27 -0300
Message-ID: <20241030001028.7402-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030000904.7205-2-kuurtb@gmail.com>
References: <20241030000904.7205-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed inconsistent indentation and removed unnecessary (acpi_size) and
(u32 *) casts.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v11:
 - Unchanged
v10:
 - Unchanged
v9:
 - Unchanged
v8:
 - Unchanged
v7:
 - Unchanged
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


