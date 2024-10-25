Return-Path: <linux-kernel+bounces-382017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E239B07DA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1AE1F24BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA415665D;
	Fri, 25 Oct 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5yNLLdz"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2621386D1;
	Fri, 25 Oct 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869352; cv=none; b=FpcmUquKHyMNA2XHULT8FCTvYmgqn13EpqqUjA2hhWDdUChPsAjWIqOIrk/82B9NzB8aOAIXEKmCq5M3VWrJtZNtKDAPC4cpzhEJP+ofIXNkRHHULrCNG0+N9WseL46tM0wVlVmh3gmtVIaA3FntJXZwpzWXJw8IqPxAo0DSXGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869352; c=relaxed/simple;
	bh=ahrs/3kTg48p/1YcTh3iALzX3pmlHFPihBBlpi5Gjn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yt2ljfnJAlWIyvGzmJwa5tLbEq3t49ON9snOyWzi2M95IaABb0VyM8V0uzM5SgVa7lqSNtPmHqv4w/ngXlaX8QlSAzgHm6tim05j/PX50PDoAdAX/4lYrCjLeO6zVv9grSc9tqcawidftzPqVGnHJ4+tkmnIg1hkL7Sc5e02PoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5yNLLdz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cb89a4e4cso16055905ad.3;
        Fri, 25 Oct 2024 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729869349; x=1730474149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHizGO1nzYx2rl0X0OLf84t2MiN5+IfpTWmMKFLMubk=;
        b=g5yNLLdz7s9xKcH/zR4GrL+W3vt7jIBhLqxTXZ/yDfdaxXfT38vdO+1eNbiQ/8RbEy
         ascEWdKuf2HizL5Kcc3xgSP8SN7aoE3yxiS0TLIH14zPCXibACUkTkCZzp8HN5dawtsH
         Q3e7qlyID8qSrgUuhCN4MV6buDUOjun0OkSd6am/QIZww9N1eC2E0K+GhEzWDudFiq+n
         0sNOJdFFHPMagBKxH6dSx9Swdmc+DHRRhLdQjuJJeplSt9zh8Pg1bopumGeuCAib3673
         EZfdmhRAKpB7YsunbtuFXbSnYw6Srnale7T+g0Y4majnzITG2W0g6SMy7C9uYFI/D57A
         OFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729869349; x=1730474149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHizGO1nzYx2rl0X0OLf84t2MiN5+IfpTWmMKFLMubk=;
        b=kABWCFatVOGSWxANqkbRQUpwzYaFMnfFetO0GJ5Oy1LFaejDdfyGlkBDmBAVmt7t7Y
         JnQJ1hQmpMcofTFkq+zylGo263S6amCxHuSw8k5JmVPk8rCOxgPxLs8KE7ZpscNEs2gY
         SKfTtS2xrUVTcIybpmn82a3YPAHb7AzJ6xnSyeBhKh/3I4gzTcmHC0PkFFOaosST7Axv
         Zu0edMsM3XjZJ5Y9lZevixJ79MXsLWmv+Na8mlg9Rj9ZypFzZeqIpNL96Fpx30SFXhyL
         xMmJVlwFJlTYVDsIRRq0lrOQeYIjqxPwxnhrUzWE2SxfldIcjhrqAbLgRTH6stCTMVvE
         7h1w==
X-Forwarded-Encrypted: i=1; AJvYcCUj+gycm02CUWcDrbCcpiK16UmiBj8cDnZO5EbNsfPkriUil2KLTRUzJPiu0krG5Lvgx1H5PeHIgHkevYk=@vger.kernel.org, AJvYcCWjFcb2683yNLyLlbpyQ3VL/yapKmc2t0UusmsYfajh7VuUhtK0bH6z6UOoFcxUOmOhKyNv3fNiQg98A/lygRW5jBQTdA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq3kT0VxOBPfvtnEBELWQkA8mNx20I21hM3Au9rxz2WFx0C3Zo
	yIVRWEvyo1RPgwv9+hL7cJ8/dyTETaTTINBuVnLfdXIYWwpV4Sam
X-Google-Smtp-Source: AGHT+IGweDyyGKr1T1lwPKZ0ZIp5ZqC2IzpdX9I7cRzCo8A4G3oYMlBH5GcTiDHFlkagXR+gxKFmBA==
X-Received: by 2002:a17:902:ea09:b0:20c:94f6:3e03 with SMTP id d9443c01a7336-20fb9a972a8mr82399995ad.47.1729869348004;
        Fri, 25 Oct 2024 08:15:48 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf44321sm10497165ad.30.2024.10.25.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 08:15:47 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v9 2/4] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Fri, 25 Oct 2024 12:13:47 -0300
Message-ID: <20241025151357.4071-2-kuurtb@gmail.com>
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

alienware_wmax_command() now takes void * and size_t instead of struct
wmax_basic_args to extend support to new WMAX methods. Also int *out_data
was changed to u32 *out_data, because new interface specifies u32 as output
parameter and all previous callers would pass u32 * regardless.

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
 drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 16a3fe9ac..b27f3b64c 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_device *dev)
 	kfree(zone_attrs);
 }
 
-static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
-					  u32 command, int *out_data)
+static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
+					  u32 command, u32 *out_data)
 {
 	acpi_status status;
 	union acpi_object *obj;
 	struct acpi_buffer input;
 	struct acpi_buffer output;
 
-	input.length = sizeof(*in_args);
+	input.length = in_size;
 	input.pointer = in_args;
 	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
@@ -541,8 +541,8 @@ static ssize_t show_hdmi_cable(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_CABLE,
-				   &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_CABLE, &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -562,8 +562,8 @@ static ssize_t show_hdmi_source(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_HDMI_STATUS,
-				   &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_HDMI_STATUS, &out_data);
 
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
@@ -589,7 +589,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 		args.arg = 3;
 	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_HDMI_SOURCE, NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_HDMI_SOURCE, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
@@ -642,8 +643,8 @@ static ssize_t show_amplifier_status(struct device *dev,
 		.arg = 0,
 	};
 	status =
-	    alienware_wmax_command(&in_args, WMAX_METHOD_AMPLIFIER_CABLE,
-				   &out_data);
+	    alienware_wmax_command(&in_args, sizeof(in_args),
+				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -694,8 +695,8 @@ static ssize_t show_deepsleep_status(struct device *dev,
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status = alienware_wmax_command(&in_args, WMAX_METHOD_DEEP_SLEEP_STATUS,
-					&out_data);
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
@@ -723,8 +724,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
 		args.arg = 2;
 	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, WMAX_METHOD_DEEP_SLEEP_CONTROL,
-					NULL);
+	status = alienware_wmax_command(&args, sizeof(args),
+					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
-- 
2.47.0


