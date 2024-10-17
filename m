Return-Path: <linux-kernel+bounces-369405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6939A1CE1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D4D11F278C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BD1D47A2;
	Thu, 17 Oct 2024 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUNcro5t"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A1C1CACF7;
	Thu, 17 Oct 2024 08:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729152908; cv=none; b=lCQuoslFB4Zn3Vz+MqqklmF+U28Q4XRcsYeMIftPlUJQ7AevN/o63oiwpjUoOZUWnMhDaNcATee3VQBINsfC76/KpCkGHS5UlKl+muNXYZetD7lU+/Lqq9zSqat/eNS725or02jqArI2IWbsl3H9zcXlfiQEZzbeEx6g2EowuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729152908; c=relaxed/simple;
	bh=mYMb+Dc1qChnZr0nDmHM4chsYqQB6NpUd6IUpmlG7II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quhI2L1giGLBjU25sC4B2ZUDsN2FhLJTlLH0u+gyfHw5X3jBZQCvVgotSnSC3Cve7viMPUtaq+dZ7ol0oYxWzG4b/72GxTwIrPAc+/DP9oLPmlCnDJUefD7Rt7ZZY9Rr9SMvWeNbp/psJCLx/wy5GWGqkVTtVSBKJHIs/g5tul8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUNcro5t; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c714cd9c8so6939025ad.0;
        Thu, 17 Oct 2024 01:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729152906; x=1729757706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLs1+OzWOMNuwsLpxLLXfGBTRAT71kxhFdirRPYIdb0=;
        b=DUNcro5twnlTiTUOhKnId+Hlaa0VD9m7mDKeEf2QamIQODkStPnSNWLZNHCdRybIlF
         5IT3+v5cTe+ZzPDe5oAC+x0gkH6BJJD8fIa/xstv/TBhXxWS5tmWkps5l4n5IIFOjVez
         Wg4Mr5RExdODDdZjUNPhb2tuHScovl+w+jNG0Ix2g/+7GzE5RgEdTwO7/2CvAD/uDg0v
         JeFahAqY/up9kIIrbykrHZf5UNEyevMJIXB/UqFB85X98JVJAqXhd95otrPl9q/nQg0c
         q9AeOM3vl+cXehXefuzd0yu+VhV5VBMhA6GqqF8E/ifAWlNomltdyYS6uj0sDCRtiETr
         w1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729152906; x=1729757706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLs1+OzWOMNuwsLpxLLXfGBTRAT71kxhFdirRPYIdb0=;
        b=a0PCWfubtwXpboOS8CvKAN3wbadZHnXa6buqU4L0MNUBxE5Yq/QRcxh1lKAt5t7SMR
         lvyl/s1B2/nq5af/7zneFicgAywU99qly9/3pkN4XEmnqDh0Rk97Hw2lCaqMxCN4ymkB
         yH4KIE09L+Idy6CD3edytt3O+oCm3NQHWmqNRrDkRL/MO6CiifWFPDb3vR5oupMmnTcG
         grLGgNhwQcC+7s8xFOAg5LM5luV9bssSybMWo+c9FU+WA5VQ+w1XH10A4J/DWr72usoV
         6va9NmxTpmQ5CWewrWfC5MyLIJQwyQrvVwvt7u2h2wqu2NdM0ezzsbaVnYTvN4r5LCMO
         f3Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUH4MFe2PeLWbAUmhvVjgT6dCPI/EriLcgZD2cpDtZVR9m2E3lfuGVMDBD05T0eCwDCG+Qih8M1sCd4RNs=@vger.kernel.org, AJvYcCVWECt9FIuSkiiN8CvlL/yG2Y1MY6kMXM+xgDvb3Bf/kHMUdOvGGNAL6EFHelAyNqgwNjxnOrNctctmO1I51Pp3Nhv3mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hR1WyWgxfEkj8KdsXyzN/WPWdTn0JtZe9zsf3RAzbMkd4i+Q
	gigS4Hy87bFquEhdp78puXME5gjfEtogHSqjN13aFvw/b+uiFarb
X-Google-Smtp-Source: AGHT+IE/tHURsU2I/Al5EytdiTI0MnRM3s6JI87zcZbi/y6ntxfyYEaEBYuUyS/mmYi7cEh2soP10A==
X-Received: by 2002:a17:902:e80d:b0:20c:7d7d:7ba8 with SMTP id d9443c01a7336-20cbb22f1e8mr259098335ad.46.1729152906298;
        Thu, 17 Oct 2024 01:15:06 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b2e4sm39871665ad.182.2024.10.17.01.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:15:06 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 2/5] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Thu, 17 Oct 2024 05:14:56 -0300
Message-ID: <20241017081455.126851-2-kuurtb@gmail.com>
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

alienware_wmax_command() now takes void * and size_t instead of struct
wmax_basic_args to extend support to new WMAX methods. Also int *out_data
was changed to u32 *out_data, because new interface specifies u32 as output
parameter and all previous callers would pass u32 * regardless.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>

---
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


