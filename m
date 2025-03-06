Return-Path: <linux-kernel+bounces-548065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B634A53F71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A0E3A9B33
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BD7E0FF;
	Thu,  6 Mar 2025 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZrahYaR"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204A241C69;
	Thu,  6 Mar 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222687; cv=none; b=Cjf+LVKrI5cyjEh0urhIt4SxsWJEucTrFOXugUP6ZsVhm0cCmYGXQZYJnwsQlHBenOLNmlqax5u+zHOYckZ16zuPJO1Mj1ICaRhNBVfMt5Mn1j+LGW4QCSKh2SLx2ztH9ISGqLOW61cZDuYkgFE3utxqHxIaClZku9ZgkEALNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222687; c=relaxed/simple;
	bh=W3245L2StKIvemIozL1BX/WJzgLB3uNjsg77Bwf+aQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YA3TCb0RRYs17c3wkDp6CfghTHRpwxMYQtEBNLGVedgK5qIOV/MbWUwYG9lLw3eyAOBQqlHzSEZMvVxLkXag3xWcdxqHJ3dvnZU4N+iuVKP2917oaHP9CXOwB77QDpKw/w77Yo3ToBAR/7eJB4fluufOL9hF5Xbh7vwaa6XUaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZrahYaR; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so28896241.2;
        Wed, 05 Mar 2025 16:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222684; x=1741827484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Iwv9GoGUQi5x68b8OratsnyLt/cCmcP1mUBYKH22PI=;
        b=LZrahYaR6uNjEYY4ySWDDL4jRTV/zGEibdtOOH7wdJIBNfut1XLtBOJlh8hod8Wzyv
         kOfO/N5IWAuNHeesUf6suYliVTnEStuF5utmVTKDf3WBHu5ZcyzXNMRFHTAAjCJk32fF
         IZ2/VZkxYsBu8Mr/EaKdiybEDpe92bqT1o6eY62mVRJ04E4mVowZMUH2XH0gWWyFW/SV
         PhohwhW5N9Lzffz7wczBgBfH7+3u8z47z/3vXjbmLgoPWRf4uMSyoepbW4e+ZytovMuD
         GC+kvXpL/M8kE+DN0zjFpMPgcDKbh/74tsyw4GEOS9gP3lKK/eq30OAnVEAMlNkv43hO
         IHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222684; x=1741827484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Iwv9GoGUQi5x68b8OratsnyLt/cCmcP1mUBYKH22PI=;
        b=rAkuBGIigPCqtxJWeje4jHf+SOFbwls3mcZLqvRcVnC/FGRtJYjUE12lXruKY/YA3W
         BvmSNaTOoqyPZluf/GYE39BlCaygA3r77YI/HaFOXaXiEggkgdhR0pmk0WTPv6UDOb6Z
         ErOSyvQdFuDz/yL0r92Lo/l9bAeyxtAlafsH3THcOdvY/IZgYuXCKvvylGIb05uCwsOe
         yQui0Oygf5oOuHHQmHW/lFvIispx2Mbs8O01A7uSj+k92ugu+Edyh/mn/qHgj7p2sIop
         rk9c/OguPsrHryHvIMcdO0mj2qHf8McaNzTjY1pibDSQ12BqiVkfxjAvNy3DynFuaiRe
         ufaw==
X-Forwarded-Encrypted: i=1; AJvYcCWdG5rI884lKjRNkrDJv0vFY25fB6iFyR+MAycSASV9m06R/sq3VYVlKahXFij6E6c94oEzGOmk/cZxZG9oP2kP1RBDqg==@vger.kernel.org, AJvYcCWkPizDIRRlg2ANDrultSxyvvZE2RpcHEfQ2tQqT/aOtFb+khTNunTrUJzuvvq/sc66ZcygAUDPXakXzwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfI7rR5JCdY4rCwWK+ma9T2Uf8jTkQTMeKFAi+QsQ+zb0945JT
	xNDq1tgre1nZCc+Rg3Il+ghtpV88b0QRBkFdbe3IyMI2DpqQHiZs
X-Gm-Gg: ASbGncuvkWgWNz4UMnwB+EqO7H1O/7yIqCTnsOKmE9reWZsA6jJagPqj6xYSzXwpkvM
	iQiW2YMCfYAkjWpM23XvM+OjSeJUAzBdUV7Ol9EaFb+FJ+Yjc5JDs+b0XQM6pu8/TDi6QOfiCBu
	eaKGgmLWfegOLCeZVUTZWatI2nMvfg94bBeQKrDdjMuqeaAV3nC5A5rfuhY3yWx5H8zaiuSNDq3
	sqVNaUAV/Wy2tvHRn+d1f+u3CPJSqqTEF0tyBWEuzdR3HhCFyAbURTR09E4Fok9KmMR5pOLX/DP
	C4jGcyow8j2kLUT3HQJZpyn8XiqlsH7tiUtDVVs3CsHqXA==
X-Google-Smtp-Source: AGHT+IHjLxyT9JcOEoiYFp2yKEZD2idSw44lvceEsAmLNiS6GDBP8w+FPMek6FcVSgTh6nDbrdgJAg==
X-Received: by 2002:a05:6102:1607:b0:4ba:eb24:fb28 with SMTP id ada2fe7eead31-4c2e274c502mr3900924137.3.1741222683866;
        Wed, 05 Mar 2025 16:58:03 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:03 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:52 -0500
Subject: [PATCH v3 01/10] platform/x86: alienware-wmi-wmax: Rename thermal
 related symbols
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-1-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
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


