Return-Path: <linux-kernel+bounces-380858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78C9AF704
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A051C21928
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025582D98;
	Fri, 25 Oct 2024 01:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWqbVM7b"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427135588B;
	Fri, 25 Oct 2024 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820450; cv=none; b=XKlHU5i/9Rb83loRcqG6syGlWPoejWSkr1Uq+eHJe7IVk22sqQenUBbOg4jSgp7Wo3bedOV7GhM/tctS8rwKLKr0BYASzO64f591/ZSg+zi3D9hTd8La9iQCENoYxSnh88WHCc5nm9m85LnMTxMriluTixCPxB8QFjwy7eZDivo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820450; c=relaxed/simple;
	bh=zhL7t3AugMi3pNT9/kNXcL7AgYv2eRMyt5OX/Ks8oTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pPM5bNcCOs44LVbrCzFE6quoSxACOXlmAtKhHjt3+6qK/5KF+tLC9jPoYNogHPjOjsUYy+0g7c+y55cCVBv0Kkqwm5+xL4lv5yTsZehuU3Rf96kCRojeieUNFvBHc9mkUJNp45y3tKf6exeRiBVYBcSjxZ7rsdQnvNTzwixHxBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWqbVM7b; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-718066adb47so930506a34.0;
        Thu, 24 Oct 2024 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729820447; x=1730425247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYCPmx6mUPSspZotT6B7w+SDVO1LigP5ym7s3WSFR30=;
        b=LWqbVM7b4N+Q6W9vNEns0n32QsK5Me9ChnvAM+FgLbRuXh8fzopyN+pVqNsz79GpEG
         DRt7zHz6fQ+o5p5b2Uvu7Ky5zodhTstsDXVDgZOYeApUiRqiSa2GGAECeQfwf04GmCHB
         lkhdzRNA2IA/PmR0Y1mHnLjFYjlt5wQyAA4WubVBWxAiP/cgRQZlBJ5HyGEjT/MDLGb9
         zqjPgWK8wZhLhE3zza15k6IdRESmnNxBz9lE1K8n0wc0Fos8qmBujD1KuvA2r7s0aBKX
         GoJy/r/ugD+japEDFlR02x5ZyX0E3rLhI2aU3MYaIqvqOvMBj81ig+fdyUjN5zEZZK8F
         ZZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820447; x=1730425247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYCPmx6mUPSspZotT6B7w+SDVO1LigP5ym7s3WSFR30=;
        b=Vh4igNtbKpJ5dYyEXM9jlV8atSDZK7xv/QEQGKpIong8eEjqG2wjmi7P/aDrCZ8Lcd
         iSVghFlefDPsu6igMduGaZR4OZ94lk34fFvD4zIukYaG8c9dINvMOR6i3DuJSls/cqJP
         ZqvdOBNMtrMhsE+/SYXxSQrhNMtMcrCkOBqKPU2TWA9cvuiyGtGE5TFEzT5Tr03pPD0t
         fZe5NcU0Pi+LaT7doLyGJXpayH0z3g2qKyNP4IdMz4tm5gxOzKtaGgoPwS09YfbppA5i
         K8KGjyCwBCMK/oHdk2uB+S815pBxo2qMtA2uxi5VQzsGpRAPD+TaY3Hl+lb/1+YHtW1/
         0vrw==
X-Forwarded-Encrypted: i=1; AJvYcCVRDZYL7BN2roCxdSOqBvCYpqA/mVLLAbzvhzkA2rFJ1AaqYepPEb92YcnLC4fKg6E9a2s2la9PKgU3jktAPDKQW3/0iQ==@vger.kernel.org, AJvYcCVSwJwd5uR2hHnXl7q63JantE6s0gofOIDiJocCEiy2HDs+XyQJBt3NwIav1LZYH6GsKCxXc/qS3LmdWhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1u4QR0Duf9qo2l8/bv++6zRLud761Rrmyetnzw598evq0sx2
	0SeqVqZMPXBEDrM6VNaUx9nlcv7ITNxPH+T7w0N2KKKjIieSJP8HC2sIM98F
X-Google-Smtp-Source: AGHT+IGInXuckqVl9bUW1ABsYzlwnOD6uf7WvTA3qIOhbeVjYy1XJqywTUaXo4p5Rjx7RWr9phU0bQ==
X-Received: by 2002:a05:6830:2a05:b0:718:118d:2be8 with SMTP id 46e09a7af769-7184b4479d3mr8222978a34.28.1729820447113;
        Thu, 24 Oct 2024 18:40:47 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a6e5acsm70992a12.90.2024.10.24.18.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:40:46 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 1/4] alienware-wmi: fixed indentation and clean up
Date: Thu, 24 Oct 2024 22:40:17 -0300
Message-ID: <20241025014016.4927-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025013856.4729-2-kuurtb@gmail.com>
References: <20241025013856.4729-2-kuurtb@gmail.com>
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


