Return-Path: <linux-kernel+bounces-532623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20702A4500D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3733A88AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDCA21858F;
	Tue, 25 Feb 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW8oW54N"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F202153C8;
	Tue, 25 Feb 2025 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522320; cv=none; b=tcp88ompObxdnSf+dM8FmSro3l3UHYeuNsb/Rz4puqhXnjWn2PmxAbvDYWCj7T5C4PZkCi+eBJYe6qMsgOO8i/6qrZ4aKTxPm3zzoueSQKykIbQylG3jLaxU7HsjpkD3dLl0uz1BzFiCa4juZ0YP9xr9w/POaOdoSZxRXIPm5qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522320; c=relaxed/simple;
	bh=LPAp9Dj0xFCha514lj3YAN7CuaDKEE+8JYAsRHGitM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP/hfd3nL74+6dkLy4toMD3mzPoi4hLA7BS+BQA+lGijC3QneMOt1uq9Mf/KiKSZ0oHuojAOYRobkc3Siz4Ca27AKAYarZsTUEIZ9lDTmGcH+DUrkjvp9Z2PrmAXlUAFKEg3ztUsAkdfr5KXfYhRka9mpdXskiIlp9VWMpr93rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HW8oW54N; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5dbdbdaeedso5736517276.2;
        Tue, 25 Feb 2025 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522317; x=1741127117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+CxeW/yy2vlrb9FwJu8UijsvUZYgdUhzYozNLc8xMI=;
        b=HW8oW54NAFsi3NGSHN+l69ZgHrv0bJp10jsjWgfyRnV9xeyU/FLVT2zp03dPlplzTt
         JVa5Xqcp9b/mkJEmLK2M+PgVloeotrJCkuoq+Hqb+29GvvFykWcp6QOD6OF2e5hvG9j+
         5+z/85tJplhqVz2Cd+7N+eJwu4VKAqEQDCaaPzDban0edurcSw/66F21E8k+wkofRrYT
         fEqZZThxQnjy7d1otFb7509g7TYJWjj34SARxzYEdlbZqQ9JCte2GflPd3hdbAdVVCl5
         nawoAAydYjcwP5vXrpnipi5OOL5P19bjzCagEajHPfJCDDEPO41t2wVJ2z+9aobZTiJT
         0GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522317; x=1741127117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+CxeW/yy2vlrb9FwJu8UijsvUZYgdUhzYozNLc8xMI=;
        b=IrZrwqYr4i+2X4tR9rNlu9A8t9k43YnWh/xD/RTnJ0MajqBonGHk7QwGirQ81/tEeJ
         TqXoQD9xxP0CZXkT5VilycRw0X7ofsEG3b4soyd3lEsQGXnxVhOEUmB1A5ivVvmVW267
         OyXY7BTmUrdShCu9n4Jaj+qX1/dGRrmMQkdPv+RzRJow494elnYCMB/GPJy3R6/IrWpL
         6i4WiPIesa70ZmLVQIflxYDIoZYDOxjQM4MeqK2c3dBv4Mvqj4+4J2ccN6+etRTxHcnn
         CQLCfqrRG4aPQddJLt4FE0Q5Xzc8UgHS7rJ162V3XBU2O6mFhIQwz2VQmKo5j8aMnRT/
         XQeA==
X-Forwarded-Encrypted: i=1; AJvYcCVozjGvT4nHPkOfBIz8B81eJ/mh//52P8oUk3rHRY1eGP2yaO0CqXyplVmTk5spfSoT8EOgDrk7yAntCR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbxuOb8JQK7m1QYSFHtvrCBMw/v/9Fb+IEV9su6iWc5GTZBQk
	XN1tYcA2fHavY0WVBdncCapycjHx5HZPUp5OhOkdQAH8/m49vPuj
X-Gm-Gg: ASbGncvxvJodg+VIyckrXNwuH50rTN/0u1SSUdjdP1Me3yXmmfIutnxj3pe1ESxeySZ
	LGedtxgQbpsV+8zSNb2rfGgap5k3wVYJj3FYfBeuxqE+hNicQYEeQ4wQYzpTUhcr9hDmhTIihSk
	fj1iFlc/C+vqc+mNLUkLT/nyr5Ot9fcRUD7Qfp8qQr4Bra2+wfLVqQbGaOFPMU6PcHN8i8WzlWm
	5MZ3Iqf8aHJDE60PFxo7+RMr9B0blxt4VXxZxj6XitU4zuoFrAMbmgd005+GZG/bJp2Aw7Qv8Ro
	oOeP9R+8aMds2IKGKILr5jqM0cwDpf15rw==
X-Google-Smtp-Source: AGHT+IHLQr1NbE4fqFz2HyjnHiHOGcU+4XkjBz2cKonMToeEV37hkmgpxFIK1T/NpAm0BJf94ACQTg==
X-Received: by 2002:a05:6902:26c9:b0:e5d:aeb7:6e62 with SMTP id 3f1490d57ef6-e5e245ad516mr11818339276.7.1740522316874;
        Tue, 25 Feb 2025 14:25:16 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:16 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 03/10] platform/x86: alienware-wmi-wmax: Improve internal AWCC API
Date: Tue, 25 Feb 2025 17:24:53 -0500
Message-ID: <20250225222500.23535-4-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225222500.23535-1-kuurtb@gmail.com>
References: <20250225222500.23535-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline all AWCC WMI helper methods and directly return the newly
introduced __awcc_wmi_command() to simplify implementation. Additionally
make wmax_u32_args __packed, add an additional failure code and add a
helper with documentation for AWCC_OP_GET_RESOURCE_ID.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 104 +++++++++++-------
 1 file changed, 63 insertions(+), 41 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 7f0aa88221d6..57897a0f4296 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -32,6 +32,7 @@
 #define AWCC_THERMAL_MODE_GMODE			0xAB
 
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
+#define AWCC_FAILURE_CODE_2			0xFFFFFFFE
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
 #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
 #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
@@ -206,7 +207,7 @@ struct wmax_u32_args {
 	u8 arg1;
 	u8 arg2;
 	u8 arg3;
-};
+} __packed;
 
 struct awcc_priv {
 	struct wmi_device *wdev;
@@ -442,8 +443,7 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
 };
 
 /*
- * Thermal Profile control
- *  - Provides thermal profile control through the Platform Profile API
+ * AWCC Helpers
  */
 static bool is_awcc_thermal_profile_id(u8 code)
 {
@@ -462,72 +462,95 @@ static bool is_awcc_thermal_profile_id(u8 code)
 	return false;
 }
 
-static int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
-				    u8 arg, u32 *out_data)
+static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
+			      struct wmax_u32_args *args, u32 *out)
 {
-	struct wmax_u32_args in_args = {
-		.operation = operation,
-		.arg1 = arg,
-		.arg2 = 0,
-		.arg3 = 0,
-	};
 	int ret;
 
-	ret = alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION,
-				    &in_args, sizeof(in_args), out_data);
-	if (ret < 0)
+	ret = alienware_wmi_command(wdev, method_id, args, sizeof(*args), out);
+	if (ret)
 		return ret;
 
-	if (*out_data == AWCC_FAILURE_CODE)
+	if (*out == AWCC_FAILURE_CODE || *out == AWCC_FAILURE_CODE_2)
 		return -EBADRQC;
 
 	return 0;
 }
 
-static int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
+static inline int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
+					   u8 arg, u32 *out)
 {
-	struct wmax_u32_args in_args = {
-		.operation = AWCC_OP_ACTIVATE_PROFILE,
-		.arg1 = profile,
+	struct wmax_u32_args args = {
+		.operation = operation,
+		.arg1 = arg,
 		.arg2 = 0,
 		.arg3 = 0,
 	};
-	u32 out_data;
-	int ret;
 
-	ret = alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL,
-				    &in_args, sizeof(in_args), &out_data);
-	if (ret)
-		return ret;
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
 
-	if (out_data == AWCC_FAILURE_CODE)
-		return -EBADRQC;
+static inline int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_ACTIVATE_PROFILE,
+		.arg1 = profile,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+	u32 out;
 
-	return 0;
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
 }
 
-static int awcc_game_shift_status(struct wmi_device *wdev, u8 operation,
-				  u32 *out_data)
+static inline int awcc_game_shift_status(struct wmi_device *wdev, u8 operation,
+					 u32 *out)
 {
-	struct wmax_u32_args in_args = {
+	struct wmax_u32_args args = {
 		.operation = operation,
 		.arg1 = 0,
 		.arg2 = 0,
 		.arg3 = 0,
 	};
-	int ret;
 
-	ret = alienware_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS,
-				    &in_args, sizeof(in_args), out_data);
-	if (ret < 0)
-		return ret;
+	return __awcc_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS, &args, out);
+}
 
-	if (*out_data == AWCC_FAILURE_CODE)
-		return -EOPNOTSUPP;
+/**
+ * awcc_op_get_resource_id - Get the resource ID at a given index
+ * @wdev: AWCC WMI device
+ * @index: Index
+ * @out: Value returned by the WMI call
+ *
+ * Get the resource ID at a given index. Resource IDs are listed in the
+ * following order:
+ *
+ *	- Fan IDs
+ *	- Sensor IDs
+ *	- Unknown IDs
+ *	- Thermal Profile IDs
+ *
+ * The total number of IDs of a given type can be obtained with
+ * AWCC_OP_GET_SYSTEM_DESCRIPTION.
+ *
+ * Return: 0 on success, -errno on failure
+ */
+static inline int awcc_op_get_resource_id(struct wmi_device *wdev, u8 index, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_GET_RESOURCE_ID,
+		.arg1 = index,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
 
-	return 0;
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
 static int awcc_platform_profile_get(struct device *dev,
 				     enum platform_profile_option *profile)
 {
@@ -605,8 +628,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	first_mode = sys_desc[0] + sys_desc[1];
 
 	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_RESOURCE_ID,
-					       i + first_mode, &out_data);
+		ret = awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data);
 
 		if (ret == -EIO)
 			return ret;
-- 
2.48.1


