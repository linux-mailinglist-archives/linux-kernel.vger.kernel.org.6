Return-Path: <linux-kernel+bounces-432448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3B99E4B57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD3016768B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A8B10A1E;
	Thu,  5 Dec 2024 00:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBapqeZm"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B4A23918B;
	Thu,  5 Dec 2024 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359383; cv=none; b=FFRNFloJM5btb+WxkYhulf/pzO5wH+Tjzm4DZHAeNZ83/PGvYpAy4I/RES9IKRmYIhewwebQVZp5CCdEE99EA12adVIzRvNYqj5dVlhlphelgud5zu4HfUImtSRlDs3SBOSeBYcYGzhRk+eCaHFj9cL9gj+FchtFzJL/PSH5ye8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359383; c=relaxed/simple;
	bh=T7YFnhgQjwgrCGMuOIZRf0mzmBxx8Fd6DoqhSTbzmiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYpZcgVjYh3seXceYjCScX0yfflz/RC8ap7dLFjJ/ecPMdBACRqiBDiz/RxM/K4LSZYe0AD3YJ4BcyHDkrgeWaC0myxHtQoAgnloIdJTV+OtdcYaTfURlUE8J3uuefOETzQiZT3ySJaMRCFTufFyeTR2p27k4MtJ6Zd8tl7XN94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBapqeZm; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3ea3bf79a03so239415b6e.2;
        Wed, 04 Dec 2024 16:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359381; x=1733964181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBCwu6aCAop1tfbiNIVVgMDCpe9BHwFkdJAFHw9D46c=;
        b=CBapqeZmWheIWvg9nB9E+QWY1pO8kvGobmAzMiKdddRKR3m0J8+465ZevzAdlxpRRl
         oXlwSQPPHdAKtwciwIXGI8Y9XEBNbsWSsg+VxOvwxANTQD+lfvaaMlKmNsyq0GKvZIOu
         MqgZ5FJJQZZLz2THYbnH63HwRQzK9Ny4sA/ai8M+SaecY0Up43PO6Bz9CxrAkT04BYy2
         5tyel3qyxwNrDxAwJ1z3D0YBRmjM9EpOMjuTHabWRDtW5N83jWPQkHhxBuvJVf/hTmd0
         R+MmI64LXvEJIb5AePBNpPMdBScm8cqG+XvOxWd2Y1C7qmnY+SV7DoHMwvSZVVHNbiqr
         39Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359381; x=1733964181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBCwu6aCAop1tfbiNIVVgMDCpe9BHwFkdJAFHw9D46c=;
        b=fGGzSGZEGeGYzA8cX3rjmhSs7tMY4zGJ+lhbL+jHrYRw9RIyazck1juUl8ACnReF/i
         QaONvRcZLyZCCJstwvgmjIgXEiHIz6V6tWMw14xKf8gWVeAoByK7MKafoHe2PHMkdpEl
         9loupdUl0XzgBgrZLF/YWY0Rq1yDAM+uSSp1JexUMperlNmHnjU3DVbOnSVqudnpyuap
         XoQrDgUERDV077zKdDs3DGeTmvlyopo8TWM46LwDIXyEUJ3J13oe3+JfdejSkvGBp4Ao
         M8RUhtIOijR+18jBizwk9Ue380B954v0xzaqve/6aZC0VbyMrGhl5NsOOV5DMpA1qgaT
         S8tw==
X-Forwarded-Encrypted: i=1; AJvYcCWnY0GoorGjCILD0pMicq/GuD3qyh4pJfL/Ov/+xaDrReSiM7h1gvRnxD/FiyWt2319CTBTZoVvfa78TymAzBAxvpiizA==@vger.kernel.org, AJvYcCXi6Cmejiaj0XJM7y9PhQgl7buZS+w4eIxbmUGSSxwdAudG/J7gZY6neqQ6tzY1g0P0As5gQT6dfBJvUcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lpYQLYdQe3xDG0pfRYx6YwMHXddKGWUORHWSZjSVH5HJD4Jh
	MOkz0r5zW+mzccNCXoAJfpH0ZvnMBgQaSG3u19eZ8AI8tzUujqFQ
X-Gm-Gg: ASbGncsDQ0Yh238xPsZ8vc2fcVWTzdfq//WCNTERn7Q5ax0A4z5fQQCm80HlhGuEjxm
	dI7DGMbAuEoxu1n98YyTwkERz0fDJUSzJgc3WUfGGaMcV7dRyQKFpHuBz0D0gm4Arwgs/I2EtGd
	LLfqYuKCGJCjwMHnTyRKfgSfVR4J+4HnZAAEjWIlR02NFnEU6K7W7CYbBbLGLzG2+8EtOf4wiUs
	mnq0xRWfw7F02lAKAtlzmPE5VYZSHFmBUGzy+8t43EVvEgUA3atVy1P43Thj8lGMR7MPn2OMBYk
	tC1PeE3Ur/T37Lc4vcA=
X-Google-Smtp-Source: AGHT+IHz10DeYPTkfCm6InqB1Hena4Ho2vbA6A1SxSiVN+rhvIVOhRx7IZbEwof5fL+mDM3iSFtvNw==
X-Received: by 2002:a05:6808:f8c:b0:3ea:61e5:90a9 with SMTP id 5614622812f47-3eae4c7d03cmr9515253b6e.0.1733359380902;
        Wed, 04 Dec 2024 16:43:00 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1569aa56sm122530a12.13.2024.12.04.16.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:43:00 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 10/21] alienware-wmi: Add alienfx OPs to platdata
Date: Wed,  4 Dec 2024 21:42:26 -0300
Message-ID: <20241205004225.2185672-2-kuurtb@gmail.com>
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

Both WMI devices handled by this module specify a distinct interface for
LED control. Previously this module handled this by dynamically adapting
arguments passed to wmi_evaluate_method() based on the `interface`
global variable.

To avoid the use of global variables, and enable the migration to
wmidev_* methods, let the WMI drivers present a single interface through
this "alienfx operations".

Also define alienware_wmi_command(), which serves as a wrapper for
wmidev_evaluate_method(). This new method is very similar to
alienware_wmax_command() but is WMI device agnostic and makes use of
non-deprecated WMI methods.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 110 ++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 34fb59a14bc0..043cde40de9a 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -411,8 +411,16 @@ struct alienfx_priv {
 	u8 lighting_control_state;
 };
 
+struct alienfx_ops {
+	int (*upd_led)(struct alienfx_priv *priv, struct wmi_device *wdev,
+		       u8 location);
+	int (*upd_brightness)(struct alienfx_priv *priv, struct wmi_device *wdev,
+			      u8 brightness);
+};
+
 struct alienfx_platdata {
 	struct wmi_device *wdev;
+	struct alienfx_ops ops;
 };
 
 static struct platform_profile_handler pp_handler;
@@ -421,6 +429,32 @@ static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 static u8 interface;
 static struct wmi_driver *preferred_wmi_driver;
 
+static acpi_status alienware_wmi_command(struct wmi_device *wdev, u32 method_id,
+					 void *in_args, size_t in_size, u32 *out_data)
+{
+	acpi_status ret;
+	union acpi_object *obj;
+	struct acpi_buffer in = { in_size,  in_args };
+	struct acpi_buffer out = {  ACPI_ALLOCATE_BUFFER, NULL };
+
+	if (out_data) {
+		ret = wmidev_evaluate_method(wdev, 0, method_id, &in, &out);
+		if (ACPI_FAILURE(ret))
+			goto out_free_ptr;
+
+		obj = (union acpi_object *) out.pointer;
+
+		if (obj && obj->type == ACPI_TYPE_INTEGER)
+			*out_data = (u32) obj->integer.value;
+	} else {
+		ret = wmidev_evaluate_method(wdev, 0, method_id, &in, NULL);
+	}
+
+out_free_ptr:
+	kfree(out.pointer);
+	return ret;
+}
+
 /*
  * Helpers used for zone control
  */
@@ -1178,11 +1212,48 @@ static void alienfx_wmi_exit(struct wmi_device *wdev)
 /*
  * Legacy WMI device
  */
+static int legacy_wmi_update_led(struct alienfx_priv *priv,
+				 struct wmi_device *wdev, u8 location)
+{
+	acpi_status status;
+	struct acpi_buffer input;
+	struct legacy_led_args legacy_args;
+
+	legacy_args.colors = priv->colors[location];
+	legacy_args.brightness = priv->global_brightness;
+	legacy_args.state = priv->lighting_control_state;
+
+	input.length = sizeof(legacy_args);
+	input.pointer = &legacy_args;
+
+	if (legacy_args.state == LEGACY_RUNNING)
+		status = alienware_wmi_command(wdev, location + 1, &legacy_args,
+					       sizeof(legacy_args), NULL);
+	else
+		status = wmi_evaluate_method(LEGACY_POWER_CONTROL_GUID, 0,
+					     location + 1, &input, NULL);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
+static int legacy_wmi_update_brightness(struct alienfx_priv *priv,
+					struct wmi_device *wdev, u8 brightness)
+{
+	return legacy_wmi_update_led(priv, wdev, 0);
+}
+
 static int legacy_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	int ret = 0;
 	struct alienfx_platdata pdata = {
 		.wdev = wdev,
+		.ops = {
+			.upd_led = legacy_wmi_update_led,
+			.upd_brightness = legacy_wmi_update_brightness,
+		},
 	};
 
 	if (quirks->num_zones > 0)
@@ -1219,11 +1290,50 @@ static struct wmi_driver alienware_legacy_wmi_driver = {
 /*
  * WMAX WMI device
  */
+static int wmax_wmi_update_led(struct alienfx_priv *priv,
+			       struct wmi_device *wdev, u8 location)
+{
+	acpi_status status;
+	struct wmax_led_args in_args = {
+		.led_mask = 1 << location,
+		.colors = priv->colors[location],
+		.state = priv->lighting_control_state,
+	};
+
+	status = alienware_wmi_command(wdev, WMAX_METHOD_ZONE_CONTROL,
+				       &in_args, sizeof(in_args), NULL);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
+static int wmax_wmi_update_brightness(struct alienfx_priv *priv,
+				      struct wmi_device *wdev, u8 brightness)
+{
+	acpi_status status;
+	struct wmax_brightness_args in_args = {
+		.led_mask = 0xFF,
+		.percentage = brightness,
+	};
+
+	status = alienware_wmi_command(wdev, WMAX_METHOD_BRIGHTNESS, &in_args,
+				       sizeof(in_args), NULL);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return 0;
+}
+
 static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	int ret = 0;
 	struct alienfx_platdata pdata = {
 		.wdev = wdev,
+		.ops = {
+			.upd_led = wmax_wmi_update_led,
+			.upd_brightness = wmax_wmi_update_brightness,
+		},
 	};
 
 	if (quirks->thermal)
-- 
2.47.1


