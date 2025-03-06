Return-Path: <linux-kernel+bounces-548067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE10A53F75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9B11892F68
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCEF13D531;
	Thu,  6 Mar 2025 00:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMQrKQwt"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947CB12DD8A;
	Thu,  6 Mar 2025 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222691; cv=none; b=uTb2uCKlUsg4+if4iDd7GB51sWuK97VzJxizhFkQY+5s1IUvrgY11Ne8uMyKA+LhvSRoTsot/mvIN8xQbA92iraiZLRFATTNWMmz/93Og8ZcERAohxpxfoPEHiG6dMS67jn0PpYSA4Kh0riqCzzv5Jmj6lZ448O/SIIPlGtgOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222691; c=relaxed/simple;
	bh=6pz4VhrhIGqny7cbRCTOhDTaZOjL/S2VzUcxV3dliOw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He3EUdx9u6NmHh5CBjRRJi3uB7bMkQ4e/1aE1BDGchnFW2wbI1vb9PmZNxIthdNnTizxbiyo0bbMWJM4smWQEZgpOS9dtAKItEM16OL+kkNTaTBS4UgcWJTdrmiQLAx0Rmrqd3VNpTnI1odF80DrY7AyNo9unAA4sX3E7vbZ3Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMQrKQwt; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-866de72bb82so26320241.1;
        Wed, 05 Mar 2025 16:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222688; x=1741827488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLcOSdpVynHXpxSTVSEYzflauiFisNmhaYmXFaXmnXU=;
        b=QMQrKQwtLWfrhfE18nuMRVX7/TbMJ0h4guDC/vENwX7gIsKKD/LIJBcheIor/tj4fX
         ykzhGIG7beLPHhhMp9V/6uoLSl5n6XfWCyZuwiObrEkCY/wVzwA0FsJCsNMoqYmmcu1B
         DJ5UY4IrKlwmGZZLGrtDVEIAZwkAW8qgGpsh+1mPNhDmpcGCPywWG1JLgpBA23MsVrFV
         khBFj0rhKnahKmtj8CdQ0XLJ9Z4zNQRp9f7sNSdbqWxGCaB/hGCwHPLyuq14e7jdP7Pt
         XXs46xZmjYR5Lkyc+M4rUpoIukkTIzIV06qGCvZq4maTp4lKBp5X+xbf/rY2ey1QPkdz
         i0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222688; x=1741827488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLcOSdpVynHXpxSTVSEYzflauiFisNmhaYmXFaXmnXU=;
        b=qDQLVyUaw5gx0/y4O8FokSBqCNr3EoOplKBbfvfj0OvyGP0P6IxjGOK8k5HAQ10RHn
         LYl69of13bIfv0AjjXH9X5KYTUfbvf4ZufJP9tyOo2kgv/9qMoeFJEe7IEAxFSw1dL0b
         Tq6xxD4ZnBTymxE8oKoJS/7kenMZJv1PH4ttQ/tDkJMnuecQd6TO9ZaMrafWAE4V4QkR
         SoVUReOZmIHuGj+GSeEDRD+FILw6tf2l2B50uib0FdJrjvZiDIs3s7A8EJZ7pbDUoreP
         weNjE/IaZZnsRhThGUN141yhzvHvDlL/BpgzicYOsPt6+P28/wQc/yd06ltyaNldr/Bh
         IM0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlDQQ0Qru6IOlvNIF88DMuZ4Bw16tIixvhPKO7Lia5JmJQnrgtcWGCOv6x/2/3zYnqr6wUtpE+NiwJJoElp7U8Gi5xiQ==@vger.kernel.org, AJvYcCWxTKRTjw1JDOi6AEkLLWetY2+8x6sMqTGHUj0U7ceJRgo2R+QAtrnCWJ9lReYjtaUoY43kkkBU/3fOyXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmM9pcB/6ZWdLJg8y1UEhOHJvLcEmDMNIizTk7r6cBR4PsfvJu
	75vYDwSXwaXdHXmma9zCq3iL+TBXDUnRcIpHDHOVbxe5/tGfcvDo/8FWZ4ISWQk=
X-Gm-Gg: ASbGncuknF1/vk4A4wfCVeFPGCRA9SWj2WivKGM/s+7DtAGZJqsayuT+3PSiSfwRjND
	PPImT5lE16BD+peRYgvEG6/EKYHWyZnNSliaBE7c506jGHVoBi2nMq5fg/+22n+ap5qNsAbJBEv
	Zh0ZlFtXwcjGVek1Qc6qOjHxkM03fLjhBmlV5Ta7rSo9LQqDvrFrcL4xsMsUm+rX+j9H08H07+9
	5fqO1/G78s7k7BejWp9ixVtuCC3yjKpMR87M7jEcUfK46SA1InZ8m/tz7pVqYeBoOl/+thDwnuw
	ADsVgAB1OiqvHqAm9e8DSBAsYqWSEXDAEqNEEx0sqIsVag==
X-Google-Smtp-Source: AGHT+IEA4CvVgbhSSn/nzSb6KKTYeXTB3ZzLUC5fM2np95GjGLaAwbjmHoFBcpUSL1ACRK3BegyDPg==
X-Received: by 2002:a05:6102:a49:b0:4b1:14f3:5d6d with SMTP id ada2fe7eead31-4c2e27b9483mr3186041137.6.1741222688389;
        Wed, 05 Mar 2025 16:58:08 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:08 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:54 -0500
Subject: [PATCH v3 03/10] platform/x86: alienware-wmi-wmax: Improve
 internal AWCC API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-3-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Inline all AWCC WMI helper methods and directly return the newly
introduced __awcc_wmi_command() helper to simplify implementation.

Drop awcc_thermal_control() in favor of awcc_op_activate_profile().

Add awcc_op_get_resource_id() and awcc_profile_id_to_pprof() helpers to
support upcoming changes, as well as a new failure code.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 176 +++++++++++++++----------
 1 file changed, 110 insertions(+), 66 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 80aefba5b22d6b4ac18aeb2ca356f8c911150abd..a43373717bd4580e8f62a7263e67664630165e28 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -32,6 +32,7 @@
 #define AWCC_THERMAL_MODE_GMODE			0xAB
 
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
+#define AWCC_FAILURE_CODE_2			0xFFFFFFFE
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
 #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
 /* Some IDs have a BIT(8) flag that we ignore */
@@ -443,8 +444,7 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
 };
 
 /*
- * Thermal Profile control
- *  - Provides thermal profile control through the Platform Profile API
+ * AWCC Helpers
  */
 static bool is_awcc_thermal_profile_id(u8 code)
 {
@@ -463,95 +463,140 @@ static bool is_awcc_thermal_profile_id(u8 code)
 	return false;
 }
 
-static int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
-				    u8 arg, u32 *out_data)
+static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
+			      struct wmax_u32_args *args, u32 *out)
 {
-	struct wmax_u32_args in_args = {
+	int ret;
+
+	ret = alienware_wmi_command(wdev, method_id, args, sizeof(*args), out);
+	if (ret)
+		return ret;
+
+	if (*out == AWCC_FAILURE_CODE || *out == AWCC_FAILURE_CODE_2)
+		return -EBADRQC;
+
+	return 0;
+}
+
+static inline int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
+					   u8 arg, u32 *out)
+{
+	struct wmax_u32_args args = {
 		.operation = operation,
 		.arg1 = arg,
 		.arg2 = 0,
 		.arg3 = 0,
 	};
-	int ret;
 
-	ret = alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION,
-				    &in_args, sizeof(in_args), out_data);
-	if (ret < 0)
-		return ret;
-
-	if (*out_data == AWCC_FAILURE_CODE)
-		return -EBADRQC;
-
-	return 0;
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
 }
 
-static int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
+static inline int awcc_game_shift_status(struct wmi_device *wdev, u8 operation,
+					 u32 *out)
 {
-	struct wmax_u32_args in_args = {
-		.operation = AWCC_OP_ACTIVATE_PROFILE,
-		.arg1 = profile,
-		.arg2 = 0,
-		.arg3 = 0,
-	};
-	u32 out_data;
-	int ret;
-
-	ret = alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL,
-				    &in_args, sizeof(in_args), &out_data);
-	if (ret)
-		return ret;
-
-	if (out_data == AWCC_FAILURE_CODE)
-		return -EBADRQC;
-
-	return 0;
-}
-
-static int awcc_game_shift_status(struct wmi_device *wdev, u8 operation,
-				  u32 *out_data)
-{
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
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
+
+static inline int awcc_op_get_current_profile(struct wmi_device *wdev, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_GET_CURRENT_PROFILE,
+		.arg1 = 0,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
+
+static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 profile)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_ACTIVATE_PROFILE,
+		.arg1 = profile,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+	u32 out;
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
+}
+
+static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_option *profile)
+{
+	switch (id) {
+	case AWCC_THERMAL_MODE_GMODE:
+		*profile = PLATFORM_PROFILE_PERFORMANCE;
+		return 0;
+	default:
+		break;
+	}
+
+	if (!is_awcc_thermal_profile_id(id))
+		return -ENODATA;
+
+	id = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
+	*profile = awcc_mode_to_platform_profile[id];
 
 	return 0;
 }
 
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
 static int awcc_platform_profile_get(struct device *dev,
 				     enum platform_profile_option *profile)
 {
 	struct awcc_priv *priv = dev_get_drvdata(dev);
-	u32 out_data;
+	u32 profile_id;
 	int ret;
 
-	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_CURRENT_PROFILE,
-				       0, &out_data);
-
-	if (ret < 0)
+	ret = awcc_op_get_current_profile(priv->wdev, &profile_id);
+	if (ret)
 		return ret;
 
-	if (out_data == AWCC_THERMAL_MODE_GMODE) {
-		*profile = PLATFORM_PROFILE_PERFORMANCE;
-		return 0;
-	}
-
-	if (!is_awcc_thermal_profile_id(out_data))
-		return -ENODATA;
-
-	out_data &= AWCC_THERMAL_MODE_MASK;
-	*profile = awcc_mode_to_platform_profile[out_data];
+	ret = awcc_profile_id_to_pprof(profile_id, profile);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -583,8 +628,8 @@ static int awcc_platform_profile_set(struct device *dev,
 		}
 	}
 
-	return awcc_thermal_control(priv->wdev,
-				    priv->supported_thermal_profiles[profile]);
+	return awcc_op_activate_profile(priv->wdev,
+					priv->supported_thermal_profiles[profile]);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -606,8 +651,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	first_mode = sys_desc[0] + sys_desc[1];
 
 	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_RESOURCE_ID,
-					       i + first_mode, &out_data);
+		ret = awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data);
 
 		if (ret == -EIO)
 			return ret;

-- 
2.48.1


