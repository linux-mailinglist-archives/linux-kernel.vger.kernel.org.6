Return-Path: <linux-kernel+bounces-557224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35DCA5D553
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833AF1898B19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD361E376C;
	Wed, 12 Mar 2025 05:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1ibsmXV"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46181DF73B;
	Wed, 12 Mar 2025 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756329; cv=none; b=EQwIEZtX54gAz0TYH+FzrCICkgHQbywUN8E3FAXdgQ2YV6xEMa0HM88HE5Us0/GCJSyAa5P5DxYuHDrHU2qrPJf81Qa1MK/MLZXetDjagJyvYpvXlKrnao5I+lbuTiDZVee9766zP4RLeXVDuWvaHTKJ0fRFA+NU8xCDIR78xT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756329; c=relaxed/simple;
	bh=kh4XOux5fLnMpuGqL85jz0yoPfb6XXn59lqRIp0pM/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAHqOWh6QUmwikagUEoPC4yUpNUu4ZNKOsPliVnNnepaBArPkBDs7OFjcSOLpk2h/fGcRcWZU8f0PPB4CkmZylwMZNJ95FdylX/HkDXjliYL7AA5XzG5efa579dE9eWf03nFxt0yupC606jt8Ekx3+DjbXN4M9Kxxa6KC/V6T4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1ibsmXV; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6f768e9be1aso5304097b3.0;
        Tue, 11 Mar 2025 22:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756326; x=1742361126; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOGDcRRC34nNPALoyT1dHPnr4hN67cRU6zIR5rs0fSA=;
        b=P1ibsmXV7DcuMxt8XNhH+8CTx3hYKX1TwGO2s1Io1EsxunltYOti3yE4A471bWIMiJ
         PC2wodhEL7VSgD9uSz3eu1FsLxaudp7V6ufSGwzhRtwZK/wC1CeOZ+4ZvsqlC/x/GmNS
         XCKkC4gyu0quPhrrUg8CXk1VrC8AvGpnOczD4CJBHqsK6wTNfWlYppqZynCMNumzo0II
         JpER1bYDQ/ogvlAVw88nvzrWHOeYiWuWl0cTUjnocijvYTQO5faFgzpBx87mvDlITUK6
         6uVs7xjdG6dk0erFyRDkMQoGVutFV4SFrF+4Oy+SQxrYowK40ttpm5/WoRVVG8c04ojq
         K4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756326; x=1742361126;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOGDcRRC34nNPALoyT1dHPnr4hN67cRU6zIR5rs0fSA=;
        b=Kzu27Z0x+JGacoyk/UBJEY8wexXtjAXGa0abEB7E+ZjZV050IXmDs1O32685VFntEc
         VAwjgkFvnmTwjK52gbLvEZ5FRn58SQvHKghlhlhgRVwp73FP51xMk2XKwIKtBonAwDmY
         sIt41Z5wJMTL5XMJexJxapdPvmYJ90TIgbHXwqb/73gWcFbPAxs3R6jGu1AGvjzx+5B6
         BG9kI1F5F8a5OowNwPxGCbCjpPAA50cc7iw4Swr96FFRrLSSe61+iMAT3jwWPwCI+S4n
         JsGFeXmb6fkY9inaM58BoKJTG95omSkEC0SUi7La/IJ0+PAyWGiy3qT6tDCaVAfTD/qo
         nS7A==
X-Forwarded-Encrypted: i=1; AJvYcCViR+kfkqKmjgRjCKfU5Qjv4IkKYHgSCzQHchIsT2Frlp1CavruWbc8Q7+aKaRFVvZUNEAp7JxnqA/LhMXyOMoTUFzmww==@vger.kernel.org, AJvYcCXknxdmzlDTR2sDigVOFA0sJGslA9naQnlDSNrvbRDgghg5bYfqpYbQCkh6Pu6M1/w4xiQ57wNKRN3pCf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqO+/7TeiVdaLDyiHeOUFR4udg8bEPFFKDrxkaG4NyQ0KqTmE
	NiNqbiG1rWCp85KbPW62iAN58vdPrxiIO2EKDuhnwoY7q+6r7RcLuzSjh2p9
X-Gm-Gg: ASbGnctQdT1vgXLWTCrE82JGFCE2NxD6x4SuDS5HcKrd/6DKXESCJQRqLYBmtkmhqGK
	fRpnW6FX9jdqdkJLQ+dIHyI7bj2RlqjLmIMN3voZysNDzcMD42fyxULVNefaMUbYuc4BD8Hh5HZ
	/w10olhugTET5D2ZoS4f5+NiH2IZn/2gpuz8eevbrAZl+Yo917qaXVQsE6uT/LsNBIiPXCaftXT
	40tFkR3HpdH/i4gD5Nm+6TtmoZsI+BQbIak82Y4/ebMLNYJIKOm7lHuOXRFtiuusxvPAU675YK5
	FGKr/0oe1cFZMUmcMpGx0/HAQkTTZWY9ICY8XmANEkt0nQ==
X-Google-Smtp-Source: AGHT+IFvl7g0TncjtZHVHax1//KyFcxJEkACBceMcBPa+nO1L94YpF3zhirWTx/SlHRm4I3meveghw==
X-Received: by 2002:a05:690c:2e0a:b0:6fe:8fe:f5c2 with SMTP id 00721157ae682-6ff0a2ab572mr64328837b3.8.1741756326436;
        Tue, 11 Mar 2025 22:12:06 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:06 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:16 -0500
Subject: [PATCH v5 03/12] platform/x86: alienware-wmi-wmax: Improve
 internal AWCC API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-3-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Inline all AWCC WMI helper methods and directly return the newly
introduced __awcc_wmi_command() helper to simplify implementation.

Drop awcc_thermal_control() in favor of awcc_op_activate_profile().

Add awcc_op_get_resource_id(), awcc_op_get_current_profile() and a new
failure code.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 150 +++++++++++++++----------
 1 file changed, 91 insertions(+), 59 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 80aefba5b22d6b4ac18aeb2ca356f8c911150abd..b9dbfdc8096c571722b3c7ac3e73989e235e2eb9 100644
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
@@ -463,72 +463,107 @@ static bool is_awcc_thermal_profile_id(u8 code)
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
-
-	if (*out_data == AWCC_FAILURE_CODE)
-		return -EOPNOTSUPP;
-
-	return 0;
+	return __awcc_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS, &args, out);
 }
 
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
+/*
+ * Thermal Profile control
+ *  - Provides thermal profile control through the Platform Profile API
+ */
 static int awcc_platform_profile_get(struct device *dev,
 				     enum platform_profile_option *profile)
 {
@@ -536,10 +571,8 @@ static int awcc_platform_profile_get(struct device *dev,
 	u32 out_data;
 	int ret;
 
-	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_CURRENT_PROFILE,
-				       0, &out_data);
-
-	if (ret < 0)
+	ret = awcc_op_get_current_profile(priv->wdev, &out_data);
+	if (ret)
 		return ret;
 
 	if (out_data == AWCC_THERMAL_MODE_GMODE) {
@@ -550,7 +583,7 @@ static int awcc_platform_profile_get(struct device *dev,
 	if (!is_awcc_thermal_profile_id(out_data))
 		return -ENODATA;
 
-	out_data &= AWCC_THERMAL_MODE_MASK;
+	out_data = FIELD_GET(AWCC_THERMAL_MODE_MASK, out_data);
 	*profile = awcc_mode_to_platform_profile[out_data];
 
 	return 0;
@@ -583,8 +616,8 @@ static int awcc_platform_profile_set(struct device *dev,
 		}
 	}
 
-	return awcc_thermal_control(priv->wdev,
-				    priv->supported_thermal_profiles[profile]);
+	return awcc_op_activate_profile(priv->wdev,
+					priv->supported_thermal_profiles[profile]);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -606,8 +639,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	first_mode = sys_desc[0] + sys_desc[1];
 
 	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_RESOURCE_ID,
-					       i + first_mode, &out_data);
+		ret = awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data);
 
 		if (ret == -EIO)
 			return ret;

-- 
2.48.1


