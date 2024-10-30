Return-Path: <linux-kernel+bounces-387949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49A9B5858
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3C281F23B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 00:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874B4D517;
	Wed, 30 Oct 2024 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHXXnJv0"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E277746B5;
	Wed, 30 Oct 2024 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730247072; cv=none; b=AFp2+BPmzPV3IMzkDvOLDKI+1NCeOA6SKz6TTGWS3m1aqteglRK5AuqvJgcjnmCkA7NK+P+WfcA9F4cHNgNs1EdwQQmkWnvcgigURsPk56eJHzaz3JkWk1KxIiwtrTcCC53CCDfSowonTEk/pk3fnMJgcngt7FDfv6qsDMd0xe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730247072; c=relaxed/simple;
	bh=7u/OFN1yXsp4cJJlZm3f5UlsirPjmdUjNWNg0AeoDJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlzBCOzsyUjZ504/pfSTIVe5AFCNaafaclaaKLPOqFE5Aj/aPdo9R8zaMIv5tzcSeo0N6n3RKngYOFmmGUoJjGAjZWHDa3g8Ot4bGrA8a/XHxaD5zhpWCm5XWAYRvU5SUe9PHXDnVo5icNZmq1tdZ0+jG0eyQbKcjP6HmVr98iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHXXnJv0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb47387ceso56580325ad.1;
        Tue, 29 Oct 2024 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730247070; x=1730851870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G58WRMncaeRsV0bfmq4FxysQ28GG1wpQqetEZqN0dmo=;
        b=OHXXnJv0SdQAamRurC3Ub4d2zMNK7xGFaMMzQ/KGUaSacjT7NTOt3xKQQdVA5bjbm3
         huGy1NGo1asIEov9bAQwA8rsNrqYTnKv5lLd/DrVZiQu2MY4yoff0tbH/PqMLuQCnjCI
         5poUvwINLZDytSh9RfpN1dvaLIgYVEGIIAqoOMztj1T5bGp/OoDDzd2DEaYWxHDnX5/k
         QBFcTfOMwZ+u+eqi2ZcA40kFwQqMe7aXZa0cYfqLsk5/2ojvG4HGteJ3tYZBEeVp373C
         D0pp5xa3fyHnIE1xmldjIYnCBrB6X/PSTSEPuI4/j97Rtg/UAikDtyXhEdMEpBeyC7uf
         /QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730247070; x=1730851870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G58WRMncaeRsV0bfmq4FxysQ28GG1wpQqetEZqN0dmo=;
        b=MwPyYByp/y8ifzHcVyhvJQh8eF2qPhSeLgj7RWu0PGoqo0H0aM7AQ9pK8wvQDOvT2l
         7d4FTvilGHREipTL8UEVYLTIa+snxVFUFQgzkKN7OQfun0OIFbnhjz6MAnwhbfH7wCU2
         kLpdspN/+g480sF4njVIezbAf8HsO/GcrOBTgM6E2b0gylPvBAgNJ/QMdk+DZ5f298sU
         CyKFVgnYO98Joj+2igjva4lo29BKXiKmj5XpQW04p6eTzmITJwc2ueEyEuSXPUMJU069
         VdKUnvsFMny8PCcRICpgGoy9EKr1MQbFhco4DsazBnQUilt6hKbG7vygWTIG/ZmQVDdd
         6CoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWq73vIMa5a9+Lm9nfFr7X2bfzvU8P/yQHoWsfHoGbqswvbb5P5mJOnKzbTtyG1nNphvdQan7m263r67w=@vger.kernel.org, AJvYcCWGtqJaIZzXizsVvthwkSUh4IyilAjT/Kq8Yrb5F0GRNBzcwLESUtnDLPcppdPpkZDbWLYKfodPD9Et7J5D0M7WVKphLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZkbOHuNpNle1WCPy9WvBhDXjfUCZ8JeCVqYraVD40LQFrJaJY
	6lqorrtD+K9/NKfupi/YZ90fyjzns1kMbwFVDLN7KegM8ak5prmH
X-Google-Smtp-Source: AGHT+IEgdxmQmW2bofQSGJNEPcEK+AzOSzSBDLnMLlHw3WcT13wc5SQkHjmZngNg7U9OimYv2kyhtg==
X-Received: by 2002:a17:902:e745:b0:20b:c1e4:2d6c with SMTP id d9443c01a7336-210c6cdde01mr168552145ad.57.1730247070202;
        Tue, 29 Oct 2024 17:11:10 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d3cfsm71965055ad.82.2024.10.29.17.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 17:11:09 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v11 2/5] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Tue, 29 Oct 2024 21:10:56 -0300
Message-ID: <20241030001057.7562-1-kuurtb@gmail.com>
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

alienware_wmax_command() now takes void * and size_t instead of struct
wmax_basic_args to extend support to new WMAX methods. Also int *out_data
was changed to u32 *out_data, because new interface specifies u32 as output
parameter and all previous callers would pass u32 * regardless.

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


