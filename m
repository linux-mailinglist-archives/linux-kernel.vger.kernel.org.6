Return-Path: <linux-kernel+bounces-360587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710FD999CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748531C229F9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60222209662;
	Fri, 11 Oct 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7/7Cua7"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60990635;
	Fri, 11 Oct 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629250; cv=none; b=eQYyMpLhE8pd1/FokW2lpT39NRgh42Q4JTbCClZ/cg7dBDKkJQmE3uh3cSU7pEKwitQRcKzA+3snyYa9pxZCatVz2w+vTzK982VIwCfGLE7w21k5tPCT3ebU2ASasH2BHT72TaoUGzIpvzv8mNNQFztkrUhRL3592cWZVErB7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629250; c=relaxed/simple;
	bh=0GZoGZhJO9JhbDKRLHpdltUb4yxs6o3eeKOIN9Qp9V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItpcovKeyNDvbwEp2ohQkTOO+J1Ye2sTmBbVxwOnrPfPOjwkjvQcdVUJnbaUyLLgxL5diy25J7Q1A7h+x4lMTIV1LUgSq8AiZtthlhjlXNyCKm6zMTSFATSKBCZ2IaTWISHGp8dFmQDm4+2COAv+vjyzJCBcIZjQGHqUosrMZUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7/7Cua7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so1394667a91.2;
        Thu, 10 Oct 2024 23:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728629249; x=1729234049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1xLA2ZdOD5akuMksJfTrwXkXi5lDx/hKNx9gA7Toxw=;
        b=X7/7Cua7CNgQd5zcCCOEhvkSWTtxwNZQioxXe4agqSJOeToW+uFrLxfpgj8oZNlWF5
         X427iksKJsD2nmDUZg9WLdN/Pt5N6oiUBtLcb/lTriP2hDHdRFWg//ZGGbLOCIcGGygS
         W+g1Kpr8JFbEli1b29NUPDb22eEPjqaHi/4UkVOayTkkXGbrxc8vqYKGDdrJ/PTYa2ju
         x26Ws9QMU3rAbuCukb2MqpwKLXgzFUO5ZlcZtsReknzk4Pb5mQnfcQPeSf0pDztsFfWh
         rHD8icreEJUsMmsdul4tVMZJocz8C5KLvnZkXZAOAuQA00jzoIvsprzze9haj4D/F3D1
         /09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728629249; x=1729234049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1xLA2ZdOD5akuMksJfTrwXkXi5lDx/hKNx9gA7Toxw=;
        b=vszH33xprzmzuRT4V3PkhghLCdRjf+HTn3+pE0glRDbSWazElzmWA0IG31M39bstiw
         pDvTucdJy3k50/80fvVlLzh1XQ8tLy2w1uSqsiq1F3dXl17Sa0F6ZTkZMy4sBvBxiWo9
         Awz8LD7Q+/p7Gsh5pqtxt3p6eV/hOI+SjOE8k95kil1L/rFebs0O8/jGqhAyn/zKN5xr
         6GSoRf2VNZVgyu0tISosXSAy/Km82PM+ZgLDyUKLtIV+HhqMetpMnHe8IufWwzkqJrYO
         35Ae6CxrB7VkMCtWEciQKmyKVaWxO0p7uTNX1IpF8viFdrZmuHF//lk9SuvYlnK4Pb1v
         6vgg==
X-Forwarded-Encrypted: i=1; AJvYcCV+KJrAsVjn61vD2adm1Bg+qI2cOpljs+ddpL+TnxTrzkSCc7banhk9LkuqmkalfOQ25oqDOO7tYrN9r0Y=@vger.kernel.org, AJvYcCWN8/Y0qx/qR7c6TIx2gwXjoE/z8gehsDegVNkX/K1ehE257/DmQ5oSD366IgAHwiHSbMegP/19SjDzks336Hwm/8vDTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHAfEVH/Mdt+Co8KKkNzfIUoTqpokn3jdHKApJDUlFYJmvfsGs
	qdJT61TZ8xbPsE1XdIC7XhPIj0BJfN5HiC48O8fC9B7OUQi/TZ1R
X-Google-Smtp-Source: AGHT+IGrXWkRQduWbJleB3oXVLkgVLVtXn/df1aMkVMMc1T7gacUba8m7Sh85k8jyc5FiFHgs86/vg==
X-Received: by 2002:a17:90b:1056:b0:2e0:db81:4f79 with SMTP id 98e67ed59e1d1-2e2f0a2fb2cmr1983969a91.2.1728629248723;
        Thu, 10 Oct 2024 23:47:28 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f0a476sm2503903a91.30.2024.10.10.23.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 23:47:28 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	W_Armin@gmx.de,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 2/4] alienware-wmi: alienware_wmax_command() is now input size agnostic
Date: Fri, 11 Oct 2024 03:47:13 -0300
Message-ID: <20241011064712.306484-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011064336.305795-2-kuurtb@gmail.com>
References: <20241011064336.305795-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 29 ++++++++++++-----------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 16a3fe9ac..8f7a8bfef 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -500,15 +500,15 @@ static void alienware_zone_exit(struct platform_device *dev)
 	kfree(zone_attrs);
 }
 
-static acpi_status alienware_wmax_command(struct wmax_basic_args *in_args,
-					  u32 command, int *out_data)
+static acpi_status alienware_wmax_command(void *in_args, size_t insize,
+					  u32 command, u32 *out_data)
 {
 	acpi_status status;
 	union acpi_object *obj;
 	struct acpi_buffer input;
 	struct acpi_buffer output;
 
-	input.length = sizeof(*in_args);
+	input.length = insize;
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


