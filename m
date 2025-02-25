Return-Path: <linux-kernel+bounces-532620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201BA45001
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DA8D19C4771
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61B215076;
	Tue, 25 Feb 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUzGW7an"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13821505D;
	Tue, 25 Feb 2025 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522317; cv=none; b=VyVtVe6UzsDinAcyQFAw/RcUVx0qgO57Qd6mXmUWhtQ7IVE3DakqmqmV+LZyWf0pYnjQskHDYktF0Q8fn7w2hxfZsHm1EKVIjxGe5Yleh9/gyMmNtkUcfyWU4csCuKBfTFSDpfyLo65W2OWrsWIiN0FhnmlbPgDqlzCc4XAvBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522317; c=relaxed/simple;
	bh=H024Neyf5Xe/vd4mr+qHN5B+S/vJwhPB36J1Wj99T+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUFgC7OCFT+WcZgAB7i0adoKmk/Cipu1kBnsr3UGtQB3HR9YVJH7CPrRi8xNSm6dAfvCbF+FTwwBdPPO+XQRTggcuwkLrfmJ4LNljo1I21vgflOOX+8HmNGy++XK1AFe6h9Jc5OlCM9m8BK7qE2P2rf5fc0tbmqjHyefbLqkK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUzGW7an; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e545c1e8a15so7088203276.1;
        Tue, 25 Feb 2025 14:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522314; x=1741127114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJhCSut6ZCRl9I4VYdMdhRGbsfDQIUyMiZFhX1wO1sw=;
        b=FUzGW7an3i6Ql9plx5tfLoaCiia7maSh/58mCdl6/4iNUQvYQEWOJQNnqckE7nGqk4
         SG+vUFOsf+Rwxi76ivBOT4m3+MlajfEuvOlB7heMPnCxmYUSmKPE4ODI856MWGv3R1qk
         XSRhD14OCBgCSgy5rxtl3Xz7Yye9BGtt2ePEMkmivn9sxSRrEBsJxHYuU0yiZS8eqkQM
         R4sGKACH6KbOY1Gsx+5jvRdb3efCaH5mBPgw3mnbCVgjePMnnLmyA7HWYGV3sTghtJuZ
         4ASNkp4maWq83znMSq4TRAW2jmDHa/dNJzxL7smyO74GA3lo0WYC85+3PtT1UCgmHIf+
         BAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522314; x=1741127114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJhCSut6ZCRl9I4VYdMdhRGbsfDQIUyMiZFhX1wO1sw=;
        b=XNJusuoPU88nkrekzGfHVWnQHLF64oZHfdMCR1/MHRXGSeUGQRBgHkhexItYE+eBi9
         z2DE7DRQpKa58SmY2CJfE3WuaF2cWfR0KEqwImCQCTz/Es4YKNyRa3w1tqqD0ORYbLjF
         d8m6N2Vbt+DVXTQwXyujvkgqyJf1OdEFfgUK/N0aNDGRIXl8i6PUZnysGYH7/hjzmXKX
         EjA8ReZqR4y22VsmdDiYr4heU209Yr7kJnIK0tl+vyWadEnAZqtHVTJvedjG+MOrDPQn
         6w+n6sodLxKeN1J+fCKMla0NUjSelxlUm1+/4CgEmx4g95MORtiG0NEhF7LY82P0HQj2
         XBag==
X-Forwarded-Encrypted: i=1; AJvYcCXJKqIgDw0kMizNx9+v1lZxANvS/1maCpk4x8yrAKGOWFXhUA2kXb/3CKsG4dQ/phVt+1PoJoKpEKBWCNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx6BN2vCKIPcmBUDshhjaYSDosPFpIUOiTKDsNVh+Y8FuBDRXS
	JMiZeTCDRaSxX3WFRrTyBvMwIBKLS3oH/eb5NLUAvA92WfhMT7wQ
X-Gm-Gg: ASbGncttiO24W7WJwLtrjmeqgjaPgDCVY8byWSny2lOj3pAQDucwYYLN+5Llj6Aien9
	nGuswSM4SciIV5enMTe/OPvXmtu4YugwDl2TYErKQ9MNNa0GUrvgi40sNhUxHz2uBGfaNNYvpRa
	xtpNBb9TyB8YM1BUmHXuQa7+7TyGcTndaR3UTS75RXBqDPoKAVJXGsijryuJchBu4PGzJKhM8Sv
	GHwze9zNQsgKpYPP0TXI4eB5SGrSr6FV2FNd5FNW3PvPjoXKsdqUYM0dsVDuFWhqPNgZmZv6ixZ
	0XvlDn4Xp2QRROswJ0+g3pDBrG6TX5gwRg==
X-Google-Smtp-Source: AGHT+IEXmex1v8WKPnv6Xi5guFbn5TqVxs6eHIe51akHMcq/7I/RcMsbj+PhcGPyy+TQOVWM0b/4JA==
X-Received: by 2002:a05:6902:703:b0:e5d:b2c4:7cbf with SMTP id 3f1490d57ef6-e607a4db612mr4288843276.7.1740522313898;
        Tue, 25 Feb 2025 14:25:13 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:13 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 01/10] platform/x86: alienware-wmi-wmax: Rename thermal related symbols
Date: Tue, 25 Feb 2025 17:24:51 -0500
Message-ID: <20250225222500.23535-2-kuurtb@gmail.com>
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

The "thermal" features of the WMAX WMI device are only present on the
host device if the ACPI _UID is "AWCC". Replace WMAX prefixes with
"AWCC" to reflect this relationship.

Thermal profiles with WMAX_PROFILE_BASIC prefix are also renamed to
WMAX_PROFILE_LEGACY because they are only supported in older versions
of this WMI device.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 173 +++++++++---------
 1 file changed, 87 insertions(+), 86 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3d3014b5adf0..ed70e12d73d7 100644
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


