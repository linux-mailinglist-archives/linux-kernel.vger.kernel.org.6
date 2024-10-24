Return-Path: <linux-kernel+bounces-379242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27399ADBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAD5283F54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563A17A586;
	Thu, 24 Oct 2024 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IP28OAsj"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6956817107F;
	Thu, 24 Oct 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750693; cv=none; b=MPQHbSXii6MLqc9GD/0rnwjCrkzhQ6aZ3VsFadYFv0WHSuUnpAfomavRBqDbUoSDLnSSgGTcBX2cDiak+4jEhG7aQrTWbG/1G69/mYK5NaBg+oZgTIIt34GJM9MPmxaj0cVzFpTxqWOwtLIhYxURtLYtV+T7SNMOvSb3aWOA0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750693; c=relaxed/simple;
	bh=xqkLn4wp5FJAgI3ZJp8gPyrrez1eKyHN/pZIqNWTBJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OOJUeI85Xi6WzuVFjqpGCLd/rewpsphBINUM/SbhFJOXlxzhQcdghx+bLqT/5mP4a4PQKigH/tSvJhSHbQGtr04ndY1xTwbH2mm7bQaxykXkFa+7cgW4A1SW2HgOMfsJzi5vTJbskhO1x2CuNIc2exuiD0H1AHbPlAKIKf+mhms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IP28OAsj; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e606cba08eso371909b6e.0;
        Wed, 23 Oct 2024 23:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729750690; x=1730355490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOSMv2IweW/F9SHld4KmOpVAWzlvL/o64OHcLtuXZN4=;
        b=IP28OAsjv0KTDkZiJ+uWsaZsKGB+lwBzaGEpflYhJ+eXcxUrrhuRZm2+Q4x3oR5dJl
         BOa7Q+nlz1yvpAInNqGdKgpxz/nufkukH9McsNFtsKroSWVIeXBqIuiYEkuM06IkA2IN
         UrlNX8D8E5RUsixwbzSjetxTBmv/WXWnLsgGrM6DlsftFFqsLlVrFwzjDNKc16tZvIdW
         rJMOUtvHN/EloYpDA4+t0Wh5VCTT8scinm5hfNi70PVya0WEDGc3LM/08VSetKQeg70r
         GAKWOI9EPpZV9Mi71ElGERZrG+/RyRB1JvEk+rRpRqysvgUTW00J37AZ+kM9wgkXImwk
         HEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750690; x=1730355490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOSMv2IweW/F9SHld4KmOpVAWzlvL/o64OHcLtuXZN4=;
        b=wUYyT5vnOeE3LDpibsJobe7VoFcbvmlfr7EODRPFdIAD59fuSYWaCo4RNGZKb1HEGG
         G2/Zhkz+OK5BLcSTxLVArD0T9AVfwmB5cQGA5P0bZZv2ZembXlS/ga6sRY2oOo7gKycD
         za/aA4KPBSBex0F6nygpVssx9P+MLQ6hEljx8cCusZixrmQu0gOHEoY5QQbD5ClFQIIB
         emwqCHqFriMKS3lYVTqscNzbaBRIBU1qxjgi52ZWqDZWQSpgvddZtlvWKwlbD5ApkuXM
         NLd0kmEHHuLKp2jKGJsODi9V6Zgh/kI/UNEobHskA2fd+aLPztzFhauON0K4fr2PDoXA
         um4g==
X-Forwarded-Encrypted: i=1; AJvYcCW+hmIwluCZFmNjoMvQG+HK9zv5J77kfiHtBz4NtjKXNIdJ2O9nFv+W3+nqbeyPqBxpMiww/Pes4BQpWzU=@vger.kernel.org, AJvYcCWZ3kGkaaVqyKMN4Mdx95j/+IViVVHV6eBuG944gcKajG7lQ0qDijVVVxS7UG7PFhDF1BW069heH1UbntDyKdDQbqRXKw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4mb7d3ve+NBPWlFHOoMENL/Zb8lHeHEQspQqFeNTtJS75WRH
	FgNZBvb/Z8pX4wK+Lb3avgIYzKtRTThZBqFmLxpI77g92t+X/9N266J862sn
X-Google-Smtp-Source: AGHT+IFlxTBiCWzWj9n+HzD6/dO9s3nrRpg86kuZlkrCcHRcvKREqUOlBc7Xec47CYcIGiyQtjO3mQ==
X-Received: by 2002:a05:6808:2f05:b0:3e6:2d97:cb62 with SMTP id 5614622812f47-3e62d97cdd8mr416720b6e.6.1729750690268;
        Wed, 23 Oct 2024 23:18:10 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabde7d5sm7750676a12.93.2024.10.23.23.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 23:18:09 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 1/4] alienware-wmi: fixed indentation and clean up
Date: Thu, 24 Oct 2024 03:17:59 -0300
Message-ID: <20241024061758.34330-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024061547.33918-2-kuurtb@gmail.com>
References: <20241024061547.33918-2-kuurtb@gmail.com>
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
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
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


