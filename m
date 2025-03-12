Return-Path: <linux-kernel+bounces-557222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13BAA5D54F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6A21898A38
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5B013D539;
	Wed, 12 Mar 2025 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy2GdMqM"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F381DE3BC;
	Wed, 12 Mar 2025 05:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756326; cv=none; b=P4ynXaeUTh/Nk8CjNgj2P8EYYA/ImssP+1WWS34e77hffoO126dexDoUzFVuF7l9uUI05J+qegGWkgGluGU5AewGf/3beA5xaz4vwGCsf3fnJEiJIkf3UbHQyV593HtdqpKAhc1mhMEiImHR5ickx0rQgDMvd5b6tDN1t4fzwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756326; c=relaxed/simple;
	bh=W3245L2StKIvemIozL1BX/WJzgLB3uNjsg77Bwf+aQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFSa96OljaUWlj6ycEF25fzChjlQCdBHsxKKDMXSEqokqNSVGq25ZqpJaRVeLFA1ck+BfY+XxAFcjeY6p4+U+Gz3fdY7HVDJjMEpbczr27rxgUKkTTf8phcOHaKckWkJi2CIJ/4ixD4GQpKisJJdhsZUAYS6HLVAggYZhAfk9E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uy2GdMqM; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fd8be1e534so59513687b3.3;
        Tue, 11 Mar 2025 22:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756323; x=1742361123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Iwv9GoGUQi5x68b8OratsnyLt/cCmcP1mUBYKH22PI=;
        b=Uy2GdMqMDyc8lKwTkzlqpgq2OH4rLkES+YtpNJz4meX4oqnUPVHwRQ4sbiUah+0k91
         azREs/YJpbPxMM5xKsjTV41dVHOOCsZwbooXrQhUZ+5EUlaXls8kZFk5NKFQl5760HAb
         EedAdUtprxZL9jsBDLuNsXBkG+CfgHIHP2tiAKKn2KgK/JEdF22tkEaxZk5bFfJso+D+
         0Iv8QFOTa+kQVhrRvn94hgb4ovnb18ImpJ9t73AJzCXkUq6XqZUSHY65mJtkbE4nlsaj
         LLRmQrhlsmjEVhP1td8s5aL/V7N/OhHQ5xi5CJDy21uGTkNSknpwQBYw5rCi0rwUgqLZ
         AXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756323; x=1742361123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Iwv9GoGUQi5x68b8OratsnyLt/cCmcP1mUBYKH22PI=;
        b=Fa0k8hPHu1wm2SYlKtrGd6UjuXqRhWk8Jxm+6X/mlIlHzpNhyHhBYQGM+5ubt8DsUu
         /tQm3LZQofPslUxe4De3r9WmSLAyYCEVo4/pVsCbaaO9Y3nT219sDjkVN2y/Tudehr36
         oLcKIbAo+J4xRxTakudnpfNGPHDjtBblMkcDiZxuJvvhmARpktTftFCKv1b4Was588OC
         E1ekmV1Uj9VI1rikxBD6D2uFEKwuNXCqwHSIBR3jkplLZgcY6sp5L+tbeiCojv5EhQEN
         4GqZwd3KUA1MTfiGttq8sSx/ypeBBUowScwiR4UK84BxdMAiUw1nBne/KISQrzHIaMbT
         1c0g==
X-Forwarded-Encrypted: i=1; AJvYcCU9h2aNKWR0FuDOoXsutquADtUg+971PPDnmrLY/UNiNRBhuDHYHJL78UWDqVWQoacGV0SQpYVVRBO13D6K6EZddZYCVg==@vger.kernel.org, AJvYcCW2LtB5+40rnCJhr2i+GWVU8qmkDPH3HwB5SfKd+PWK9Oe6FVSWb9J/v9W/VbbqoMW2yG59IoLGvJRfpwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YypH40o3e7fX8LbnbxMTpEMBq+R/k4Js8ru67nCehnC4TrPpfV2
	RCXiuiPzQU+1gNTIS63kDmOQv05HKBBUjUuTcG7gfcSoueiHxZSiCdShqF1q
X-Gm-Gg: ASbGncspcBHZtyNNnF5ShSVW5MqGgcARb45Cr4fiBn9kyhrgqHsLzmtUTHDkMugxy+I
	uF7r2/z7lkq105LyOGPvYe57zeMPMieU9NaH+eiiSCHFn2n4z3QEuTyp1f6jWyXWEami5ungP6W
	8CX6y7oHqEr7ZbPg6WrpyMubM9kGbh+xFrVQBJP0OC+aarTb5ZoQb46FjpUY9UB2K8TS3d2lMW0
	XqYY2XUi/ncIuN7tTJ+zP6fqvR8YXlX03pTk/RdT4Q1VEtGkfuqrZZYQYYu9M+faIGZdgAReAfF
	Gs4tO0dKJ5+7KQXQEUcUyhP008HkrGhnL9gLbSUowrnLFQ==
X-Google-Smtp-Source: AGHT+IGcKYSMvPEnkV+H4cSFV7qZJ/l7bsDkT9xJqLQM1mj1gZm/xF2CCmyiJyjMxAA3P+qU80Pp2A==
X-Received: by 2002:a05:690c:48c2:b0:6fd:47a7:3fb2 with SMTP id 00721157ae682-6febf39bfecmr283042657b3.24.1741756322646;
        Tue, 11 Mar 2025 22:12:02 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:01 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:14 -0500
Subject: [PATCH v5 01/12] platform/x86: alienware-wmi-wmax: Rename thermal
 related symbols
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-1-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The "thermal" features of the WMAX WMI device are only present on the
host device if the ACPI _UID is "AWCC". Replace WMAX prefixes with
"AWCC" to reflect this relationship.

Thermal profiles with WMAX_PROFILE_BASIC prefix are also renamed to
WMAX_PROFILE_LEGACY because they are only supported in older versions
of this WMI device.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 173 +++++++++++++------------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3d3014b5adf046c94c1ebf39a0e28a92622b40d6..ed70e12d73d7fe5d89f3364c5367820bf47e3c1e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -24,16 +24,17 @@
 #define WMAX_METHOD_DEEP_SLEEP_STATUS		0x0C
 #define WMAX_METHOD_BRIGHTNESS			0x3
 #define WMAX_METHOD_ZONE_CONTROL		0x4
-#define WMAX_METHOD_THERMAL_INFORMATION		0x14
-#define WMAX_METHOD_THERMAL_CONTROL		0x15
-#define WMAX_METHOD_GAME_SHIFT_STATUS		0x25
 
-#define WMAX_THERMAL_MODE_GMODE			0xAB
+#define AWCC_METHOD_THERMAL_INFORMATION		0x14
+#define AWCC_METHOD_THERMAL_CONTROL		0x15
+#define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
 
-#define WMAX_FAILURE_CODE			0xFFFFFFFF
-#define WMAX_THERMAL_TABLE_MASK			GENMASK(7, 4)
-#define WMAX_THERMAL_MODE_MASK			GENMASK(3, 0)
-#define WMAX_SENSOR_ID_MASK			BIT(8)
+#define AWCC_THERMAL_MODE_GMODE			0xAB
+
+#define AWCC_FAILURE_CODE			0xFFFFFFFF
+#define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
+#define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
+#define AWCC_SENSOR_ID_MASK			BIT(8)
 
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
@@ -151,38 +152,38 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 	},
 };
 
-enum WMAX_THERMAL_INFORMATION_OPERATIONS {
-	WMAX_OPERATION_SYS_DESCRIPTION		= 0x02,
-	WMAX_OPERATION_LIST_IDS			= 0x03,
-	WMAX_OPERATION_CURRENT_PROFILE		= 0x0B,
+enum AWCC_THERMAL_INFORMATION_OPERATIONS {
+	AWCC_OP_GET_SYSTEM_DESCRIPTION		= 0x02,
+	AWCC_OP_GET_RESOURCE_ID			= 0x03,
+	AWCC_OP_GET_CURRENT_PROFILE		= 0x0B,
 };
 
-enum WMAX_THERMAL_CONTROL_OPERATIONS {
-	WMAX_OPERATION_ACTIVATE_PROFILE		= 0x01,
+enum AWCC_THERMAL_CONTROL_OPERATIONS {
+	AWCC_OP_ACTIVATE_PROFILE		= 0x01,
 };
 
-enum WMAX_GAME_SHIFT_STATUS_OPERATIONS {
-	WMAX_OPERATION_TOGGLE_GAME_SHIFT	= 0x01,
-	WMAX_OPERATION_GET_GAME_SHIFT_STATUS	= 0x02,
+enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
+	AWCC_OP_TOGGLE_GAME_SHIFT		= 0x01,
+	AWCC_OP_GET_GAME_SHIFT_STATUS		= 0x02,
 };
 
-enum WMAX_THERMAL_TABLES {
-	WMAX_THERMAL_TABLE_BASIC		= 0x90,
-	WMAX_THERMAL_TABLE_USTT			= 0xA0,
+enum AWCC_THERMAL_TABLES {
+	AWCC_THERMAL_TABLE_LEGACY		= 0x90,
+	AWCC_THERMAL_TABLE_USTT			= 0xA0,
 };
 
-enum wmax_thermal_mode {
-	THERMAL_MODE_USTT_BALANCED,
-	THERMAL_MODE_USTT_BALANCED_PERFORMANCE,
-	THERMAL_MODE_USTT_COOL,
-	THERMAL_MODE_USTT_QUIET,
-	THERMAL_MODE_USTT_PERFORMANCE,
-	THERMAL_MODE_USTT_LOW_POWER,
-	THERMAL_MODE_BASIC_QUIET,
-	THERMAL_MODE_BASIC_BALANCED,
-	THERMAL_MODE_BASIC_BALANCED_PERFORMANCE,
-	THERMAL_MODE_BASIC_PERFORMANCE,
-	THERMAL_MODE_LAST,
+enum awcc_thermal_profile {
+	AWCC_PROFILE_USTT_BALANCED,
+	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
+	AWCC_PROFILE_USTT_COOL,
+	AWCC_PROFILE_USTT_QUIET,
+	AWCC_PROFILE_USTT_PERFORMANCE,
+	AWCC_PROFILE_USTT_LOW_POWER,
+	AWCC_PROFILE_LEGACY_QUIET,
+	AWCC_PROFILE_LEGACY_BALANCED,
+	AWCC_PROFILE_LEGACY_BALANCED_PERFORMANCE,
+	AWCC_PROFILE_LEGACY_PERFORMANCE,
+	AWCC_PROFILE_LAST,
 };
 
 struct wmax_led_args {
@@ -210,20 +211,20 @@ struct wmax_u32_args {
 struct awcc_priv {
 	struct wmi_device *wdev;
 	struct device *ppdev;
-	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+	enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 };
 
-static const enum platform_profile_option wmax_mode_to_platform_profile[THERMAL_MODE_LAST] = {
-	[THERMAL_MODE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
-	[THERMAL_MODE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
-	[THERMAL_MODE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
-	[THERMAL_MODE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
-	[THERMAL_MODE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
-	[THERMAL_MODE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
-	[THERMAL_MODE_BASIC_QUIET]			= PLATFORM_PROFILE_QUIET,
-	[THERMAL_MODE_BASIC_BALANCED]			= PLATFORM_PROFILE_BALANCED,
-	[THERMAL_MODE_BASIC_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
-	[THERMAL_MODE_BASIC_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
+static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
+	[AWCC_PROFILE_USTT_BALANCED]			= PLATFORM_PROFILE_BALANCED,
+	[AWCC_PROFILE_USTT_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[AWCC_PROFILE_USTT_COOL]			= PLATFORM_PROFILE_COOL,
+	[AWCC_PROFILE_USTT_QUIET]			= PLATFORM_PROFILE_QUIET,
+	[AWCC_PROFILE_USTT_PERFORMANCE]			= PLATFORM_PROFILE_PERFORMANCE,
+	[AWCC_PROFILE_USTT_LOW_POWER]			= PLATFORM_PROFILE_LOW_POWER,
+	[AWCC_PROFILE_LEGACY_QUIET]			= PLATFORM_PROFILE_QUIET,
+	[AWCC_PROFILE_LEGACY_BALANCED]			= PLATFORM_PROFILE_BALANCED,
+	[AWCC_PROFILE_LEGACY_BALANCED_PERFORMANCE]	= PLATFORM_PROFILE_BALANCED_PERFORMANCE,
+	[AWCC_PROFILE_LEGACY_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
 };
 
 static struct awcc_quirks *awcc;
@@ -444,26 +445,26 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
  */
-static bool is_wmax_thermal_code(u32 code)
+static bool is_awcc_thermal_mode(u32 code)
 {
-	if (code & WMAX_SENSOR_ID_MASK)
+	if (code & AWCC_SENSOR_ID_MASK)
 		return false;
 
-	if ((code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_LAST)
+	if ((code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LAST)
 		return false;
 
-	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_BASIC &&
-	    (code & WMAX_THERMAL_MODE_MASK) >= THERMAL_MODE_BASIC_QUIET)
+	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_LEGACY &&
+	    (code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LEGACY_QUIET)
 		return true;
 
-	if ((code & WMAX_THERMAL_TABLE_MASK) == WMAX_THERMAL_TABLE_USTT &&
-	    (code & WMAX_THERMAL_MODE_MASK) <= THERMAL_MODE_USTT_LOW_POWER)
+	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_USTT &&
+	    (code & AWCC_THERMAL_MODE_MASK) <= AWCC_PROFILE_USTT_LOW_POWER)
 		return true;
 
 	return false;
 }
 
-static int wmax_thermal_information(struct wmi_device *wdev, u8 operation,
+static int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
 				    u8 arg, u32 *out_data)
 {
 	struct wmax_u32_args in_args = {
@@ -474,21 +475,21 @@ static int wmax_thermal_information(struct wmi_device *wdev, u8 operation,
 	};
 	int ret;
 
-	ret = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_INFORMATION,
+	ret = alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION,
 				    &in_args, sizeof(in_args), out_data);
 	if (ret < 0)
 		return ret;
 
-	if (*out_data == WMAX_FAILURE_CODE)
+	if (*out_data == AWCC_FAILURE_CODE)
 		return -EBADRQC;
 
 	return 0;
 }
 
-static int wmax_thermal_control(struct wmi_device *wdev, u8 profile)
+static int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
 {
 	struct wmax_u32_args in_args = {
-		.operation = WMAX_OPERATION_ACTIVATE_PROFILE,
+		.operation = AWCC_OP_ACTIVATE_PROFILE,
 		.arg1 = profile,
 		.arg2 = 0,
 		.arg3 = 0,
@@ -496,18 +497,18 @@ static int wmax_thermal_control(struct wmi_device *wdev, u8 profile)
 	u32 out_data;
 	int ret;
 
-	ret = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_CONTROL,
+	ret = alienware_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL,
 				    &in_args, sizeof(in_args), &out_data);
 	if (ret)
 		return ret;
 
-	if (out_data == WMAX_FAILURE_CODE)
+	if (out_data == AWCC_FAILURE_CODE)
 		return -EBADRQC;
 
 	return 0;
 }
 
-static int wmax_game_shift_status(struct wmi_device *wdev, u8 operation,
+static int awcc_game_shift_status(struct wmi_device *wdev, u8 operation,
 				  u32 *out_data)
 {
 	struct wmax_u32_args in_args = {
@@ -518,46 +519,46 @@ static int wmax_game_shift_status(struct wmi_device *wdev, u8 operation,
 	};
 	int ret;
 
-	ret = alienware_wmi_command(wdev, WMAX_METHOD_GAME_SHIFT_STATUS,
+	ret = alienware_wmi_command(wdev, AWCC_METHOD_GAME_SHIFT_STATUS,
 				    &in_args, sizeof(in_args), out_data);
 	if (ret < 0)
 		return ret;
 
-	if (*out_data == WMAX_FAILURE_CODE)
+	if (*out_data == AWCC_FAILURE_CODE)
 		return -EOPNOTSUPP;
 
 	return 0;
 }
 
-static int thermal_profile_get(struct device *dev,
-			       enum platform_profile_option *profile)
+static int awcc_platform_profile_get(struct device *dev,
+				     enum platform_profile_option *profile)
 {
 	struct awcc_priv *priv = dev_get_drvdata(dev);
 	u32 out_data;
 	int ret;
 
-	ret = wmax_thermal_information(priv->wdev, WMAX_OPERATION_CURRENT_PROFILE,
+	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_CURRENT_PROFILE,
 				       0, &out_data);
 
 	if (ret < 0)
 		return ret;
 
-	if (out_data == WMAX_THERMAL_MODE_GMODE) {
+	if (out_data == AWCC_THERMAL_MODE_GMODE) {
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		return 0;
 	}
 
-	if (!is_wmax_thermal_code(out_data))
+	if (!is_awcc_thermal_mode(out_data))
 		return -ENODATA;
 
-	out_data &= WMAX_THERMAL_MODE_MASK;
-	*profile = wmax_mode_to_platform_profile[out_data];
+	out_data &= AWCC_THERMAL_MODE_MASK;
+	*profile = awcc_mode_to_platform_profile[out_data];
 
 	return 0;
 }
 
-static int thermal_profile_set(struct device *dev,
-			       enum platform_profile_option profile)
+static int awcc_platform_profile_set(struct device *dev,
+				     enum platform_profile_option profile)
 {
 	struct awcc_priv *priv = dev_get_drvdata(dev);
 
@@ -565,8 +566,8 @@ static int thermal_profile_set(struct device *dev,
 		u32 gmode_status;
 		int ret;
 
-		ret = wmax_game_shift_status(priv->wdev,
-					     WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+		ret = awcc_game_shift_status(priv->wdev,
+					     AWCC_OP_GET_GAME_SHIFT_STATUS,
 					     &gmode_status);
 
 		if (ret < 0)
@@ -574,8 +575,8 @@ static int thermal_profile_set(struct device *dev,
 
 		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
 		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
-			ret = wmax_game_shift_status(priv->wdev,
-						     WMAX_OPERATION_TOGGLE_GAME_SHIFT,
+			ret = awcc_game_shift_status(priv->wdev,
+						     AWCC_OP_TOGGLE_GAME_SHIFT,
 						     &gmode_status);
 
 			if (ret < 0)
@@ -583,21 +584,21 @@ static int thermal_profile_set(struct device *dev,
 		}
 	}
 
-	return wmax_thermal_control(priv->wdev,
+	return awcc_thermal_control(priv->wdev,
 				    priv->supported_thermal_profiles[profile]);
 }
 
-static int thermal_profile_probe(void *drvdata, unsigned long *choices)
+static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 {
 	enum platform_profile_option profile;
 	struct awcc_priv *priv = drvdata;
-	enum wmax_thermal_mode mode;
+	enum awcc_thermal_profile mode;
 	u8 sys_desc[4];
 	u32 first_mode;
 	u32 out_data;
 	int ret;
 
-	ret = wmax_thermal_information(priv->wdev, WMAX_OPERATION_SYS_DESCRIPTION,
+	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
 				       0, (u32 *) &sys_desc);
 	if (ret < 0)
 		return ret;
@@ -605,7 +606,7 @@ static int thermal_profile_probe(void *drvdata, unsigned long *choices)
 	first_mode = sys_desc[0] + sys_desc[1];
 
 	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = wmax_thermal_information(priv->wdev, WMAX_OPERATION_LIST_IDS,
+		ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_RESOURCE_ID,
 					       i + first_mode, &out_data);
 
 		if (ret == -EIO)
@@ -614,11 +615,11 @@ static int thermal_profile_probe(void *drvdata, unsigned long *choices)
 		if (ret == -EBADRQC)
 			break;
 
-		if (!is_wmax_thermal_code(out_data))
+		if (!is_awcc_thermal_mode(out_data))
 			continue;
 
-		mode = out_data & WMAX_THERMAL_MODE_MASK;
-		profile = wmax_mode_to_platform_profile[mode];
+		mode = out_data & AWCC_THERMAL_MODE_MASK;
+		profile = awcc_mode_to_platform_profile[mode];
 		priv->supported_thermal_profiles[profile] = out_data;
 
 		set_bit(profile, choices);
@@ -629,7 +630,7 @@ static int thermal_profile_probe(void *drvdata, unsigned long *choices)
 
 	if (awcc->gmode) {
 		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
-			WMAX_THERMAL_MODE_GMODE;
+			AWCC_THERMAL_MODE_GMODE;
 
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
@@ -638,9 +639,9 @@ static int thermal_profile_probe(void *drvdata, unsigned long *choices)
 }
 
 static const struct platform_profile_ops awcc_platform_profile_ops = {
-	.probe = thermal_profile_probe,
-	.profile_get = thermal_profile_get,
-	.profile_set = thermal_profile_set,
+	.probe = awcc_platform_profile_probe,
+	.profile_get = awcc_platform_profile_get,
+	.profile_set = awcc_platform_profile_set,
 };
 
 static int awcc_platform_profile_init(struct wmi_device *wdev)

-- 
2.48.1


