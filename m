Return-Path: <linux-kernel+bounces-432449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B1C9E4B59
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696B318802BB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358210A1E;
	Thu,  5 Dec 2024 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQ5UwNT4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBA014A90;
	Thu,  5 Dec 2024 00:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359410; cv=none; b=q2CbuUmeiivgGzTYzoXwxP05dOUIrd0DxocLAJfaIoXfz9jHJh4oBFuMsj0bsfwv3sTn/9QCfoVP5JSbA4QFFWbKExeck/IgcFv4UMxOX+xWCJz3zO3dQtc6DVY0/i/CiEaOta0doeUeo7S5lN+kIYa2yqQz5lsK15Oib3WSu+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359410; c=relaxed/simple;
	bh=6YBujX9+M6hNotwgwETW9OjkSDYXU3KIuHj2rCyTLho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChtkXiu9dZLYDWpYbu/wxPBtTYXup32khubM+qaSJxHVNZcIzL7NxX/3FmT8AsgLCJJH7CEgX0MIMx7b6pYP+dGv0wII1/TjmQ4XVlrQ+28Z+a4H6FHVbaPdZKze9kZOGDro7fxtznRWJUAIJzuigK+eqXiGbFdkymuH3Janzr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQ5UwNT4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21561af95c3so2436785ad.3;
        Wed, 04 Dec 2024 16:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359408; x=1733964208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gF2Ur1bG2IuQdjBFiLHaOmGOnYHL7AWwqbHCwE+8phs=;
        b=AQ5UwNT4ancYPZyLkUtLWPfJfEkgPfECv8EbQOHKt/oDP+tFcKlwo7YH+PaXXECSI7
         ysJcHGCsZk8ZnMkY8JjsoGxB0klL9xLbmtUi8pLNzofaGGe2Dja0nCm6mzQ4si//3KHC
         jTS2rlcvLwrPaLkl3csOvm1LG3pydPOL3iygxQIO2YFBzRJ5kcExm1hLS3q/SsLPYkoW
         RpHqP4uoBE6fnqgdAKKEb8VeNJbcfWrtJAtxS6/P0F0smjMKxk9MFWWrJRtAnNhZOf7S
         oL4eP3FMrqRngWcmh/eHyNcU4ej/Jpv73uHxtqZSl2L7nGokbBfraK6t70Yn4NDqVDLq
         WF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359408; x=1733964208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gF2Ur1bG2IuQdjBFiLHaOmGOnYHL7AWwqbHCwE+8phs=;
        b=Jr0SSICskMRcpprjrZwvhJeY91pRlY0/eM+h8wDBaXKjxfHjCImpqZJ8g6dFylRuXI
         w/0euYtaddzjxVRidYYvGWuxuE4NGXNpfSIkhCz9UoWgJgj08m9m+s9X3gMZ0+7xnjJv
         tMf8F2xR2U7zdZJdWoN3uISu0dUka9JvecTYujEn/o9b6dr7T1/EMn2GbRWzfBDUcNgZ
         TDBTdlTJLSHYPKWa0SD+TVt7L4klT7JIeHvTQfhnT1pQc//ppAw5gmsGBvKuhpmUJSW8
         YrliosRgyQRg0xELobhwnMAgwDf8BJLy2TWu6J7pAtBJhVVnxU+On5dBpogKiUCtnaDs
         Sa5w==
X-Forwarded-Encrypted: i=1; AJvYcCUxnUKon3mEbd9J9W8oTx0u3lYrD/sSXqXaS0AqCra7Jri4Q2zIqAoN6ueQqKD3h5ecYzOlj1q+BAaH32loUC2vYXqWsg==@vger.kernel.org, AJvYcCUyudkb7wEKPh9yliiVbYKosHAOOZ12MgqFz8kvMAUERXsyj6lsa/FfiN48Lm2gjotDg4YpZm2cxH+T96A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzklhztmzZ2bRA6wq3uIj/x/9/DNSUmTWDetPqFaA48ObJ24T2q
	e+6+DJFPmTRP0mF+t6VCUayK/AD/0x5q6b98ovVx1vLx6N66BmhH
X-Gm-Gg: ASbGncusXaQ4EkZyZXLPcSS7HodG6SZje1U14XOY6bVymeFpPldYJHcgQJf8VZlkU3S
	hchh5P3C4D3xGYmFhVInYM2hAfg35K8smXaSy+sUR57ePeT69b8Aj2vYSgCfGjCnLU6inu9oXPg
	rUWc1toTAQZk9uJ4CPpUipmfXTmB8cmzwVHcp1H0395XW3q8979vLUa51YeeUDw7xWo00y2NE8N
	gldRwtV1Zv60CXR4iSOpVop9KnH+nnnr2zE9E1N+uP6475zp01hWc5pZDrmRDzXmgWnncbPAys4
	Sil2mlPIavSn+d7XuUg=
X-Google-Smtp-Source: AGHT+IEDxgearYVEXy+oMDWIm/dT2iHtb9B4Z2v6xrk6Uwq4EV0ptg1BJa/JLqgGlP0xjepNvvVnSg==
X-Received: by 2002:a17:902:d489:b0:215:77f8:6c12 with SMTP id d9443c01a7336-215bd143a09mr114535715ad.51.1733359408180;
        Wed, 04 Dec 2024 16:43:28 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f3188fsm1331965ad.265.2024.12.04.16.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:43:27 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 11/21] alienware-wmi: Refactor LED control methods
Date: Wed,  4 Dec 2024 21:43:06 -0300
Message-ID: <20241205004305.2185820-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop alienware_update_led() and wmax_brightness() in favor of upd_led()
and upd_brightness() provided by device's platdata.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 70 +++--------------------
 1 file changed, 8 insertions(+), 62 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 043cde40de9a..93287bbffb97 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -485,46 +485,6 @@ static int parse_rgb(const char *buf, struct color_platform *colors)
 /*
  * Individual RGB zone control
  */
-static int alienware_update_led(struct alienfx_priv *priv, u8 location)
-{
-	int method_id;
-	acpi_status status;
-	char *guid;
-	struct acpi_buffer input;
-	struct legacy_led_args legacy_args;
-	struct wmax_led_args wmax_basic_args;
-	if (interface == WMAX) {
-		wmax_basic_args.led_mask = 1 << location;
-		wmax_basic_args.colors = priv->colors[location];
-		wmax_basic_args.state = priv->lighting_control_state;
-		guid = WMAX_CONTROL_GUID;
-		method_id = WMAX_METHOD_ZONE_CONTROL;
-
-		input.length = sizeof(wmax_basic_args);
-		input.pointer = &wmax_basic_args;
-	} else {
-		legacy_args.colors = priv->colors[location];
-		legacy_args.brightness = priv->global_brightness;
-		legacy_args.state = 0;
-		if (priv->lighting_control_state == LEGACY_BOOTING ||
-		    priv->lighting_control_state == LEGACY_SUSPEND) {
-			guid = LEGACY_POWER_CONTROL_GUID;
-			legacy_args.state = priv->lighting_control_state;
-		} else
-			guid = LEGACY_CONTROL_GUID;
-		method_id = location + 1;
-
-		input.length = sizeof(legacy_args);
-		input.pointer = &legacy_args;
-	}
-	pr_debug("alienware-wmi: guid %s method %d\n", guid, method_id);
-
-	status = wmi_evaluate_method(guid, 0, method_id, &input, NULL);
-	if (ACPI_FAILURE(status))
-		pr_err("alienware-wmi: zone set failure: %u\n", status);
-	return ACPI_FAILURE(status);
-}
-
 static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
 			 char *buf, u8 location)
 {
@@ -543,17 +503,19 @@ static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count, u8 location)
 {
 	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
 	struct color_platform *colors;
 	int ret;
 
 	priv = dev_get_drvdata(dev);
+	pdata = dev_get_platdata(dev);
 
 	colors = &priv->colors[location];
 	ret = parse_rgb(buf, colors);
 	if (ret)
 		return ret;
 
-	ret = alienware_update_led(priv, location);
+	ret = pdata->ops.upd_led(priv, pdata->wdev, location);
 
 	return ret ? ret : count;
 }
@@ -659,35 +621,19 @@ static struct attribute_group zone_attribute_group = {
 /*
  * LED Brightness (Global)
  */
-static int wmax_brightness(int brightness)
-{
-	acpi_status status;
-	struct acpi_buffer input;
-	struct wmax_brightness_args args = {
-		.led_mask = 0xFF,
-		.percentage = brightness,
-	};
-	input.length = sizeof(args);
-	input.pointer = &args;
-	status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
-				     WMAX_METHOD_BRIGHTNESS, &input, NULL);
-	if (ACPI_FAILURE(status))
-		pr_err("alienware-wmi: brightness set failure: %u\n", status);
-	return ACPI_FAILURE(status);
-}
-
 static void global_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct alienfx_priv *priv;
+	struct alienfx_platdata *pdata;
 	int ret;
 
 	priv = container_of(led_cdev, struct alienfx_priv, global_led);
+	pdata = dev_get_platdata(&priv->pdev->dev);
+
 	priv->global_brightness = brightness;
-	if (interface == WMAX)
-		ret = wmax_brightness(brightness);
-	else
-		ret = alienware_update_led(priv, 0);
+
+	ret = pdata->ops.upd_brightness(priv, pdata->wdev, brightness);
 	if (ret)
 		pr_err("LED brightness update failed\n");
 }
-- 
2.47.1


