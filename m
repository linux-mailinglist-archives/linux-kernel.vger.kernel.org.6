Return-Path: <linux-kernel+bounces-380863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AE09AF710
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA11C20DBC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C88502BE;
	Fri, 25 Oct 2024 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFnhG94+"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550613A3EC;
	Fri, 25 Oct 2024 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820480; cv=none; b=lPoDrgReRhr76bOdJqZENhEly6j6xZFPz3QNRhyTusAVgVy6knZl6xXZ7WtCx84grxToPE6i4Y3R/msJkbc5GOi7DmCE3l1YUBPFKu13RhzC1iaO9sLjd/qjV9VkF+wgRHW+u8WStgTBHL/yWBflOCg9Dag0MHkCpIkPa0sStWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820480; c=relaxed/simple;
	bh=2NjVl0XTSFMWTU8HgT+h5TweN3th16CM3SWhlvaBZ5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B188CE2dKCi82kKPbnMqEQHPWsTHnZ0heSEYu7FfJ3/tCfxNTCgmYqBTxtqLj8+ZWchIJ3jjK3fcq75RfEUVSqGO2uImqwkGBlfzOvDSKn3OWL+g+VoRgXogN6FoJQYWzWJEXfyxFJtzqVco+PU93POMoYeDEYAG3Zfd672/l44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SFnhG94+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso1140135a91.2;
        Thu, 24 Oct 2024 18:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729820478; x=1730425278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8R83AuELhgmOfwBYreExIfQMqgFPxT1JN23tSNvjJc=;
        b=SFnhG94+zF46rAxStpM8I/C5UirA/Wt3qinvcNTV0U+aGBKY/wpdGDD3Sp28apEUEr
         qtuVGaO5xyEiBvgRwgPbP0r4tEXrPzosKvTgDdIPmmZY9yIxa/cl/x1WIM2yCxpUQti/
         idGepCYEM/bdhMR2IsG64A3M/nu+/g4UcmGvzVXBbk2yg8PX2G7uScR+AYOjtEnf0peP
         rSVz5hX4f+za+2KqQZjuizFR34fGJhAcpbLg7KFj0tbV1iTbgRvdMYxkVtyxq1K3qHHh
         fmvJGmp6B4h6cIA4quUfVxfM6cmHEfepkyAUcCPKTN+9vEO/8Ro2SoSR17JRXRp4sH6e
         nYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729820478; x=1730425278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z8R83AuELhgmOfwBYreExIfQMqgFPxT1JN23tSNvjJc=;
        b=TX8RhpBtl09I9QoD/7xZOvx+DYhLRIaqbU3TZJEGl85a4rItIUBy7xYih30jvPPmI8
         3vfBQVrG7uS1rLecqgkXvIz/RVPfVqN7b30S5zAzpn0GqPpSSnBGgFQqTfsqtwwOBJsF
         kqzeLrMw7H4GdzBsgWxRSPZ4dzx73lQI7/lIywJY1OYRqxfHekEAbna5iSKVIx7DTsvF
         bMcW9xlfSlNQdv9Vntf1CVlbfmUXjuDAFMPUVxuWJXGNEG9W64FhVSyZTeL2zsP2GreR
         oWDhXUa3SdVvV+s0dQCRaOMbO2pkARRbQmySnV67jLVJ1xvDPhy1dPMAkqhtUjOsGgxt
         CyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa62mOsgVR0NxcN9aB7HjKf3PJpMbIPFvupHF7sMTViMiesXXSQyMq3nVANBDcRRHAaS8xanW3unEon4hZsbQ1ENGIYg==@vger.kernel.org, AJvYcCVeEgvzkGFD/Tmx7uXridtCF2NmE7uVRy3aYkFRWZ7FQb86Pw+uPGrKWLpGb+yXJl/1s8NMfiuJFz1fOM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5OTGQxvC2p9huVssQZ05TrTXlcGT3IZ70IR3NgLrqA2n5bj7I
	XhYPhhac5pshoVDB89Hd3uBq6kl0YKcoioSwrbSNXwDPVNl02gGq
X-Google-Smtp-Source: AGHT+IEc96X8kBrNmpErC+pIg1j8o4LwGRYBjs828Q4mQsCqNzq7NMRwUWQKspIxYjtyTrNJ7FLEUg==
X-Received: by 2002:a17:90b:3b50:b0:2e2:a96c:f009 with SMTP id 98e67ed59e1d1-2e76b5dde45mr8659845a91.9.1729820477503;
        Thu, 24 Oct 2024 18:41:17 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48e4a2sm2230820a91.2.2024.10.24.18.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 18:41:17 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 2/4] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Thu, 24 Oct 2024 22:41:09 -0300
Message-ID: <20241025014108.5096-2-kuurtb@gmail.com>
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

alienware_wmax_command() now takes void * and size_t instead of struct
wmax_basic_args to extend support to new WMAX methods. Also int *out_data
was changed to u32 *out_data, because new interface specifies u32 as output
parameter and all previous callers would pass u32 * regardless.

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


