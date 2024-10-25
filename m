Return-Path: <linux-kernel+bounces-382007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA09B07B7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3181F27E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E5B188014;
	Fri, 25 Oct 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDQ1aeoT"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2843018595F;
	Fri, 25 Oct 2024 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869183; cv=none; b=isKo/atveW0PctbrpxkVo30MKxfMXYAqTCocnXhubEyfMihi2j79v5vpz9WVpQLyJr1NG8FYGR4VmyoJCnK+nWdFUqOamen8KQR1sf1bT8/TK+J77moAyUTitlTwAjDModPM+cicOHXItI+amTowXWu2lUmnlysUzsfDO9psW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869183; c=relaxed/simple;
	bh=qRWSvKmenmz42IseU/feu9tOVf6xukNKdTayhfkgVYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ANbfy3rF2jM1rU5cdjZiESpstqvWUA+lzb5aOEBz+H2c5ZbW//vW3//nFGYJ1nLMiPUdua4PdKZiEVQgf00RqShCBH7piouSViJH4jC4x73eWfn0XMJDgHRL+zNjkjyDFhfpxAikSFLrtR5BhTLeUrAq3dQfQ6JMpMqOgGx993U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDQ1aeoT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2dc61bc41so1556230a91.1;
        Fri, 25 Oct 2024 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729869180; x=1730473980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h43nwd6JUrCeVS9WnWe9JnWDzLOtb5c2GQzu8fYBe1Y=;
        b=QDQ1aeoT6IIdeYgSpvJ93DpqUSGqHufKtm38CXpAgAF/Hg0QtLKsGdg2uTf4raFA6m
         g2OjBlm4txDul0hAHC82xBqmXuVvd6Rsvy93uvZiyW8KLiA5pBuKfmta9UVKtQpNIhHb
         EP9zstavBfG1Jscu2KEsA62LhxnYq97N5ZULwn/NNldwn6ge+3IpTFHOACfeFVIEAup7
         8RctQfMjqwAxygCfo3RLHeUzS5uKjYwld3DQyubfLTgjcdcOLN9+XQJx35aMBKJzNAJy
         LBENK2Gsm6W6ew0TXFV69AN0fTfkCWs4FGSxVHIlrjDcjiftTtGQp+aft8TARLW99esc
         YNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869180; x=1730473980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h43nwd6JUrCeVS9WnWe9JnWDzLOtb5c2GQzu8fYBe1Y=;
        b=Grq3FzQskYIybBQTeNPad488mRwfWJNPi5tr3PWtkHdqZEUupgcK333p3njxlnsCHk
         loalOlS8DEpd1TL/2U6aHek8nuX3gro3X7BXVINE5rZM7/vee87eYwN4eMeDOB1VeAnx
         PRdkvLiJsHbxpb0VVeXdH86Hf7lKWD8TKh1dRdAPjgDLOutL87up31Lskj/gBWv/TOgR
         4fP7GOnufomkWUHzqjFqAmAu2PXRmvz58zsj6NSo9cOJFeLUrXLM2qDejIHLcdDKiJ5z
         hjdCcHFa7ez29C+joKvDUgq8fRt3rrtfiMb3ssjiq4PSJh32E9Y3mTGwMR/c1B4sfxAm
         7dYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBOrqHWIJexkWon6EOookvyGZl8VuzBB+EUqEjw2Q7MoJGBfOmzP35BCgAo0T3EsNgkXaw6rF8OWDzHX4=@vger.kernel.org, AJvYcCWpG0FThalxkpjYlwVp/IGxb3tyuQrGzFwvzlyrM82useXBm+fheUykMOi1g/6bFBkta7+2sPowoutJ71RlE0sk91Pw+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYneppffNdLZXi1X7kDAfGqhd4+3OiyB2/Rlbvyw7jQDU9pep/
	CRKpRccUzLAy5gJbS6gUYdLhlDtK4Hxan9fCMwqk5PIU1AY7CRaroucONjHB
X-Google-Smtp-Source: AGHT+IF/MJjgNGXbBKeyK3+AmvPp/4PR/7Kh7nmA9cy5tDslFk2BZdBiWQSJd4LfTzEiC7c3nNRARA==
X-Received: by 2002:a17:90a:5145:b0:2e2:ffb0:8a5c with SMTP id 98e67ed59e1d1-2e76b6d5410mr10194960a91.27.1729869180195;
        Fri, 25 Oct 2024 08:13:00 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3748c9esm1555244a91.41.2024.10.25.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:12:59 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v9 1/4] alienware-wmi: fixed indentation and clean up
Date: Fri, 25 Oct 2024 12:12:02 -0300
Message-ID: <20241025151202.3901-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241025150916.3618-2-kuurtb@gmail.com>
References: <20241025150916.3618-2-kuurtb@gmail.com>
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


