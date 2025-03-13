Return-Path: <linux-kernel+bounces-559696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A923A5F838
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D8B19C48A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76767267F77;
	Thu, 13 Mar 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbaCd4+z"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAAE268C40;
	Thu, 13 Mar 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876221; cv=none; b=oGdHwpBgJ7d8hAZqZE06rcTmdMETArpzxwhzCQ7icKnHNt+npy9t3HWCiFU0AxdINKgotlYSUF97TC2+iTGebEmKljajaBdx/aR/YnOPt+q3mm88WUogcbUk6d7x0Ef+HGhh3n1svrBwGVHAgVXpTlQxR5zZw4pkieKJE+p9dck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876221; c=relaxed/simple;
	bh=kh4XOux5fLnMpuGqL85jz0yoPfb6XXn59lqRIp0pM/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntiXfwfy8cJlW/Ju6Jm2WQNLHEvAe9A/dQk3SNc3pxO5ICL0WIpOKm8gcQrVDIrWGb/b7djJQNuOq6KA7RFCqcmh1Uo5ATvfMo9Wnqa1XkeT/72pTCsJpdlWcI3xzDY8UUjLBNunB969/ODeR6DdFF0wy+Ft4L7Hd6oSkvKwP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbaCd4+z; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso851175276.3;
        Thu, 13 Mar 2025 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876217; x=1742481017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOGDcRRC34nNPALoyT1dHPnr4hN67cRU6zIR5rs0fSA=;
        b=hbaCd4+zN7ef9EYR4/XNlOT9gpecaqGavwpqL/J0k1siZ3+hc6xiW3VVlI16oMywqr
         GHSCXiRaa4HpjeCjPOK1lWhrtPMxtDGT/TWgqesoVXJW10kosXoyTYnWK58WYfmU6BUk
         n6eAqum1iXfY6c/9gxANxdDCqXGHZDmNVuYdtJOMilpOKs8yXA7ClS2rsEUY2tq1dRA4
         v0rMqnL0lpZ573zT+6YwsfeKmWFwGCAyF4e27ClnTDOMW3bl2qZDZSMEkTA54tU1Uiee
         wU2Ypr7Niuw+7TkdZXG9PsGwIUA/cRFSug6DKxL23LjVRrUEosioU+PDbN2+tO6I2vx5
         Lj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876217; x=1742481017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOGDcRRC34nNPALoyT1dHPnr4hN67cRU6zIR5rs0fSA=;
        b=FxIJs+rC4laSWvCfLlPREq9lqkVGpb+ZHW+cAvs5j1mFjIPg0Csn+oYMXiS7mjgp/L
         hd3so9Ik7c16GSGlLnaCIuhRm4+ECw08CMKy6SL3ycWIBqaK2GTFBdQNwM2S9gGtJp57
         XSnyUBRGloZ8I6E9Xq03qNPx7ceegcIPE7BjKOavf9k2oXovYlLtc9wVo1Xfk6CbKrNh
         Pnp9vAmRW33qRXpRfi9VjHanXcflBZtHFcNwZ39xnY+DO+VDIiwE0D5xWK//thX73e06
         9yuHJk+dcWRhcDAuQnD9OL18VsfGTKvw3bv09Cxkd9kCLAi7lgowXs2Ux4ZmuxxbmGmW
         aJlg==
X-Forwarded-Encrypted: i=1; AJvYcCUtPpgg+16lvkLovOMsHey3P5lmV5FSgwsqnQ/FrZNrXQETwrb75myCw6e+IqUv9Bymqf/PPqc2i7SrEQ+HITuAg8us9g==@vger.kernel.org, AJvYcCWMDu0BRw1RBTh1Ia1e8G9ZjbVJCxBa/V98PUndS/tjvav5BWfMNFXmETH90FZsbukl4Q5H6YRfEE7XkI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXjygfYpHStytX2ZMe7MKg3vVwV0KrEw4CzS0nENoLuBJ+4r5y
	87LnggV2otbwg8FXsl+jmINKFAJnzrLBMFwWs1Kluug0SDrIyGKKXAN/jJoh
X-Gm-Gg: ASbGnctKjzK8vL2fl0Pb+7O/Jds91Y4xzzhe6QBr+OLf+vhHjmn1h2PNQ1xEMC0Ik3c
	b6G8qLmAHJ8SGq6WZb5hNj/oE4Hqbt5LFK8afhViPBU3lcqrympgzwP3Yl6XJGEMDj3bjIe+pZp
	ybuLIXW8e5dWy8j33kDYPMrTpJ4C4HM0Re8rVZeO76ATOepicjfBmMJblfxQMzwfQnsZqQOgtg+
	cowuT3LcjtLJ18Jmgj4UpwZyyD7fBxXWDoQDgGFsdVS6fgCHvxedZVgo5NIx5wKA+WsI988A0rU
	bdgWwfoMAqMYoPFvHRyeSo81ZnH8tlk3umjH5lbK/JHN+QinV6ydWonf
X-Google-Smtp-Source: AGHT+IFwPFOoK+DbMLYrOWTULL9K9QqyK/6Sl4SAReMr1rxpRT2Ku8wYjhd418oQjC412y7xvwk1MA==
X-Received: by 2002:a05:6902:72c:b0:e5e:1034:db93 with SMTP id 3f1490d57ef6-e635c1d8d0emr29439003276.34.1741876217319;
        Thu, 13 Mar 2025 07:30:17 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:16 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:29:58 -0500
Subject: [PATCH v6 03/12] platform/x86: alienware-wmi-wmax: Improve
 internal AWCC API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-3-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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


