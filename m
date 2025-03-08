Return-Path: <linux-kernel+bounces-552784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D85A57E11
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794F53B2AE6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CE212FB5;
	Sat,  8 Mar 2025 20:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N33q/1EO"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD220F06D;
	Sat,  8 Mar 2025 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465434; cv=none; b=HE8AT7+m8RjcAlQyu3s9Wcy2WOKJoFEPOKU5A+T/IbjzJgAzAou7PUzoP4JTHpmujN5iA2JkmmJ14cMVxsdqFuP6gEGuHULaaqX5vbwM8LP5u/IxO7A4/LP9gWhjK2Uegd8YsU3vN73+95buW4q3Ob9gcPgQuuVimSXxxjLvRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465434; c=relaxed/simple;
	bh=kh4XOux5fLnMpuGqL85jz0yoPfb6XXn59lqRIp0pM/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhuG8Kr3BJ5Rh/gtN7zkwOkcXherS0XeQxR96Y22SNzLKys5hZFAlzxNzRwvUGAnkvCSNqtKj4NK4B4DKTndY2aJ4VTmgRIM78ZW7JTZPiAplcFZypfUkGH4lQA73YBxd+Jrx9fp/ILuwifkdeV4Rv+iXfPm5uWCA3K/xDjzbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N33q/1EO; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523fa0df55dso424378e0c.1;
        Sat, 08 Mar 2025 12:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465431; x=1742070231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOGDcRRC34nNPALoyT1dHPnr4hN67cRU6zIR5rs0fSA=;
        b=N33q/1EOjxh4SE44vy3h8gwzVvGbrKK8CmnQnPG5EmIsGfZPWptH8ARgvVdTZh+aXL
         AhlSP85fLO+iMDK3hbjnQ6j7z8VsnAHKYU8zHZbcQrAVdsq2B0U4glthpswNEErmYjaR
         OatyBdawJ7sek5xtFS2RxPDLgGr4rLqvmqpJHPfqKtVlSVtYk4TvsSpBr1ddlF6EK1Dm
         xKbgimTc+rtBfiLiEX+vUCG3KmZMqNCGjM9Iay9J/+QShJH8L3PBLP5msAJW01aOz3ni
         AFObJCSJKIN4uJZpynghPw85bEJmO2WYyDEvfLSeErDAclYojmux7xFSv2j+JJw3Lfp7
         cNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465431; x=1742070231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOGDcRRC34nNPALoyT1dHPnr4hN67cRU6zIR5rs0fSA=;
        b=shTyyUplXC+dcxvBhKaCxp3m8v6QqcesAJvX6AgGTJ4xG0fS2VRUm/Wzkj+drrL++o
         My98g15PYaPTXMRhnhNX/V7SpPhG9rGK34lxrZkiAhnuEOf3O7gIWYjLDgYbNpJGGYwc
         /4DZC946SR+vONk4mWz3P9RqQCVob2PU0e23OBeOU5yUZXY/LjS8QomOuy2yHqk8gZ91
         lSOI/hSvWyf/NxLZE4q/i0tBtXu82kORGsOC2HXY+n8eywovUj9TX1sS9JjIAZzfjhmL
         QliV7JB9QHEYxj9Egry9SiliJ1ceErPcnz0KkqdgexrQFswvP1zAwO5pTLY0Gt7cpEAB
         bbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhrZicqntsJNIXXIPOGMZIbNeu4o/PKCcuHdCJrMyfLcOvQjOQS/7jIpHcsRXqmAiipA9XKd5hfR9OSp4=@vger.kernel.org, AJvYcCWoHxqD3olMecYNgybGV7FgBBq5Lc2jFwhnr7veB878LfsV4Lcj6qNo2EkJhyxWeCy4bqbRmeOz7AYjfJ3cCdQYWJsNSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtAsbjFiYaPhUp0ovMVEYfAC+BgeWY/5K1jIG2YM3N7q/pP3jV
	ZF4+8L8FBiqWVdJfTxXp03wD4wzGkXcjhKtG7+AfqaoCDHFa9p62g1Kb/M9o
X-Gm-Gg: ASbGncsH70PYr37OsK8YBHYWmz7T6om/VUKBS2x3ttdB3r4lNbnSgFR1ywg7Ea+WKU3
	AxDe5C0HU+VfZfvKUhibvgC+GyEHllsufqBVNI6zLbq9CIse+FUebEOYG0Knkm7bnBQJMlS+2wz
	IJcFbXy9PKJHgaZ77wz4LQSrBuhJMFW1Qgx3FlwO/gER0y3qXfKr8HPhKJa6gS7UNrwW8AsWDiI
	m+P+9KGjl0SAq6o6sopGTOEirPyN+oF9ZNDM/JjXO+LFx5Teg/K0B5wklvokklsiyCU7LTaUY3T
	Elo90O/bWVuJfYjbxKDGdaNd1aodaoVBUWwyBCYcaurpYg==
X-Google-Smtp-Source: AGHT+IFudrsBaeHYLLtm3SA3s0OnGsIm5/X30EUEXC/3VBDmY8bx9/EPrATd9/ca6tsOj3+EeJg9sg==
X-Received: by 2002:a67:fa49:0:b0:4c2:ff6c:6043 with SMTP id ada2fe7eead31-4c31b2cfbcamr2267685137.0.1741465430935;
        Sat, 08 Mar 2025 12:23:50 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:23:50 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:15 -0500
Subject: [PATCH v4 03/12] platform/x86: alienware-wmi-wmax: Improve
 internal AWCC API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-3-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
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


