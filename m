Return-Path: <linux-kernel+bounces-432450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63799E4B5B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A4C2820F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4623D11185;
	Thu,  5 Dec 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa85VQUH"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C823918B;
	Thu,  5 Dec 2024 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359447; cv=none; b=lazldG44iMBtawkMnQQ63K8HjARw7D2yD6piJkpX1xVKx5UZWXvmlcvVFiaxS4TdYmkb5NhRN5uXkKoayHVZATFklcn9ko7XFis2o2d3jz5UWGSsktq+AT3+hiX6AyJ5KvrEHOvjUu8qEBGHI7B4BA4D4ywyX6583uKG9LIloDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359447; c=relaxed/simple;
	bh=I3EHQlrn6VnjP4YB+DGPP28+tB4YWDH2cmCpHYOeruc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGgHltykS4/+6HgCJYqT/h1nb42tfxhln/UhOnks1ZiV/qFC0K/hOMf0w+QGxtxTK5UvhnSflRwB5qB4jnQlXa15NLE2TblWhNq4SpBdym4FaZi5xSY8qiDxn1ic4guVrXkYhhRwSgY12k71GkGWtQv5I2h0dtzFRrJjH3kvx78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa85VQUH; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7250844b0ecso343350b3a.1;
        Wed, 04 Dec 2024 16:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359445; x=1733964245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3dt0NVYk+ddQcowLnPrT3tl439EMbhxaHZi6VDp8fY=;
        b=Aa85VQUHXoBH+0Bm2Q3wxETEMOoIAXDTsC2WRivnjBIxGge7gRQLehkB7/LW6OHFW4
         oWlL2+gcZx4xQrCEfXNe/d4075O+kVuZR8hksEDnKiUpgHl68gqAT2gOhuGCbz+7LePV
         Anx3NUxEQ5Rw4nkGCDJdvD5szL/cicxIZqdFj/YDIx72BQKBP7lVf8Tr538Wis0Xvcg+
         gUoOOqCht5NNyrxAz8guZw38fHtprJz7HbbMMbmiBw6+OS/XkdJ7FXkiu8wH0pXNtBou
         /8/hKsKL3/hEv5jphFNtdQ2UPPeRf1Xh5SzUMqOWO+da6Ro5jSrscaGDFpw8RM6rD1Y4
         k/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359445; x=1733964245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3dt0NVYk+ddQcowLnPrT3tl439EMbhxaHZi6VDp8fY=;
        b=wAt4gj7k/KeIu23RWSBqg9i+l9USgTZajEUqI0TJnDjKRZUFhUpCYp/i2l2Fw7nmEk
         88bW+pkc8if2nmFw9CIshwwVBY/8iCEFsctZ2Xt6VgSeEM1y/ANDWnDB34dWHvEI9n5n
         KetF61Z50Pja/OIup3sNcpy+jGyBCZc1tMQl53wPCIx3Pnfx6MBq2dymPwIZZjvXmYMU
         L424s+bEsrLotCofbE0UM17F8P6q3+0wSXhXLyTLqlp+g6SkaN1ecMbjC6FZXoMnU3V4
         Ts+0HfchXM1aTiBDZWAM1x9bgHGtGoh43EGoyEWNlwxM/ove0j9GMZpoaSTqj2dfC235
         x0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQr7c3ce3sTLIX3d86YYDiWZG2wqlhRSThBvoyDPaJ/rBmL76gVi2UtEEPN1Hehkhpb4PnlPkK246vBPR+wWxGPvb1LA==@vger.kernel.org, AJvYcCWlsSjhkRt4dKyyrrqrwgY79AEfRyoL0YEDKkhAzGVTJiyepd3DAfHN7M/2Ep9MV5KQ30GtBbMBrlCbvmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFCjeDmkRsLB78257yEfJbWqY90R2/Gmkf5KLKUHTpgruS6W6V
	L4nggoxSX4XCyrT0Rw+JWbfVNeI65DuuWxxN+Yuxhf+PX+kvXe50
X-Gm-Gg: ASbGncvuqOrv7t7BxRUR78dZc+1wwe1P0wNUTxqWqyMIvHmI3q31F4SrjJzGY0bWVkA
	LUThE6aiGv9c3ms9CYYs03RnBzIKJ5Dhb1LF1oLwZ5QDG68xgtw6XY6rVCgNCAcmn1XVt++Rddk
	iYcyaiLG7EXX6lmDcy6Z9QCGjkmsf3YnIkhKSb0Lbt9liiWNSx0IgDAyeo+c9cBE+mwa+RV4tBh
	BgLpAZxwV4IKKErS4wno6Iak2ka0jKng1mopRPZmHbiqZyfoWClEj8QCi4HAePg3Zcv6BKgfIPa
	n3/a4TN7YxgobVd48T4=
X-Google-Smtp-Source: AGHT+IE5vrE2SPwpj5Q4TjYyuTDlYgtwAkYFTpl5/sDiGjadf7LI+QBElHwkNa1hh2a6Ne0TvwZCXg==
X-Received: by 2002:a05:6a00:b4e:b0:725:9e02:aa4e with SMTP id d2e1a72fcca58-7259e02ac6fmr1262679b3a.18.1733359445363;
        Wed, 04 Dec 2024 16:44:05 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c5727sm106732b3a.26.2024.12.04.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:44:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 12/21] alienware-wmi: Refactor hdmi, amplifier, deepslp
Date: Wed,  4 Dec 2024 21:43:35 -0300
Message-ID: <20241205004334.2185959-2-kuurtb@gmail.com>
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

Refactor show/store methods for hdmi, amplifier, deepslp sysfs groups to
use alienware_wmi_command() instead of alienware_wmax_command() which
uses deprecated WMI methods.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 51 ++++++++++++++++-------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 93287bbffb97..8a21342cabd6 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -682,14 +682,18 @@ static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
 static ssize_t show_hdmi_cable(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
+	struct alienfx_platdata *pdata;
 	acpi_status status;
 	u32 out_data;
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status =
-	    alienware_wmax_command(&in_args, sizeof(in_args),
-				   WMAX_METHOD_HDMI_CABLE, &out_data);
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_CABLE,
+				       &in_args, sizeof(in_args), &out_data);
+
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -703,14 +707,17 @@ static ssize_t show_hdmi_cable(struct device *dev,
 static ssize_t show_hdmi_source(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
+	struct alienfx_platdata *pdata;
 	acpi_status status;
 	u32 out_data;
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status =
-	    alienware_wmax_command(&in_args, sizeof(in_args),
-				   WMAX_METHOD_HDMI_STATUS, &out_data);
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_STATUS,
+				       &in_args, sizeof(in_args), &out_data);
 
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 1)
@@ -726,8 +733,12 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
+	struct alienfx_platdata *pdata;
 	acpi_status status;
 	struct wmax_basic_args args;
+
+	pdata = dev_get_platdata(dev);
+
 	if (strcmp(buf, "gpu\n") == 0)
 		args.arg = 1;
 	else if (strcmp(buf, "input\n") == 0)
@@ -736,8 +747,8 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 		args.arg = 3;
 	pr_debug("alienware-wmi: setting hdmi to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, sizeof(args),
-					WMAX_METHOD_HDMI_SOURCE, NULL);
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_HDMI_SOURCE,
+				       &args, sizeof(args), NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: HDMI toggle failed: results: %u\n",
@@ -775,14 +786,17 @@ static const struct attribute_group hdmi_attribute_group = {
 static ssize_t show_amplifier_status(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
+	struct alienfx_platdata *pdata;
 	acpi_status status;
 	u32 out_data;
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status =
-	    alienware_wmax_command(&in_args, sizeof(in_args),
-				   WMAX_METHOD_AMPLIFIER_CABLE, &out_data);
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_AMPLIFIER_CABLE,
+				       &in_args, sizeof(in_args), &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[unconnected] connected unknown\n");
@@ -819,13 +833,17 @@ static const struct attribute_group amplifier_attribute_group = {
 static ssize_t show_deepsleep_status(struct device *dev,
 				     struct device_attribute *attr, char *buf)
 {
+	struct alienfx_platdata *pdata;
 	acpi_status status;
 	u32 out_data;
 	struct wmax_basic_args in_args = {
 		.arg = 0,
 	};
-	status = alienware_wmax_command(&in_args, sizeof(in_args),
-					WMAX_METHOD_DEEP_SLEEP_STATUS, &out_data);
+
+	pdata = dev_get_platdata(dev);
+
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_DEEP_SLEEP_STATUS,
+				       &in_args, sizeof(in_args), &out_data);
 	if (ACPI_SUCCESS(status)) {
 		if (out_data == 0)
 			return sysfs_emit(buf, "[disabled] s5 s5_s4\n");
@@ -842,9 +860,12 @@ static ssize_t toggle_deepsleep(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
+	struct alienfx_platdata *pdata;
 	acpi_status status;
 	struct wmax_basic_args args;
 
+	pdata = dev_get_platdata(dev);
+
 	if (strcmp(buf, "disabled\n") == 0)
 		args.arg = 0;
 	else if (strcmp(buf, "s5\n") == 0)
@@ -853,8 +874,8 @@ static ssize_t toggle_deepsleep(struct device *dev,
 		args.arg = 2;
 	pr_debug("alienware-wmi: setting deep sleep to %d : %s", args.arg, buf);
 
-	status = alienware_wmax_command(&args, sizeof(args),
-					WMAX_METHOD_DEEP_SLEEP_CONTROL, NULL);
+	status = alienware_wmi_command(pdata->wdev, WMAX_METHOD_DEEP_SLEEP_CONTROL,
+				       &args, sizeof(args), NULL);
 
 	if (ACPI_FAILURE(status))
 		pr_err("alienware-wmi: deep sleep control failed: results: %u\n",
-- 
2.47.1


