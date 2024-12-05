Return-Path: <linux-kernel+bounces-432453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E1F9E4B63
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04F218812E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6727D11185;
	Thu,  5 Dec 2024 00:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG5ocpy5"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAB23918B;
	Thu,  5 Dec 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359495; cv=none; b=nIZWoX6BWKkR93EhkywKQRbc7A8FWv7DNKzpVeoL1RF/LIGdQCe5DMgaeC1K9XM3l35IOVxgg8y2+WFqLE2sTV2nWLXV6gSZtHCcMl5q6/erHjeDjCh/EQmv3tkEtxF1EYnntRFYTVMSdHi740sBbvjsXb8NzegoLYdz0ArrE5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359495; c=relaxed/simple;
	bh=Vu9p3/BPrlvA/czYm0nopk3pGggPQZcyOIIwYImq2L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNUHfgcFJf/vYWpCIExS7Jxir+3fXjmKpK2lzvmC23ZY6PEHPC8G/hDd/uAOiJsHtiil4YNpFTfi32GlzdYL54Mt5G+RmlvynIDIJh6dX2zlpYns6w3atTj6JQ3y5mQ/oqJj7bey3pq7GENv2GStDcZKH1EcfU1nIH9q0e+PEG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG5ocpy5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7fd17f231a7so39271a12.0;
        Wed, 04 Dec 2024 16:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359493; x=1733964293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSMpWEuhlvJtsZ2OsswG9SVVUl4Sf57QbNL9YVukIAU=;
        b=RG5ocpy59bvONbGZmS2SHRYxcpmKqeHTL4Io3KAvgFSrBXDDY5nr9rSHgM/11fPZXy
         ypG8qmdx1lPpNl7p9/b4dbohjMacW+4tKWHtJ1OM0hD8vsHcg2pNiALE6S3n2l+eu0a+
         ON+hidVqCM1xR+1nzJAE8K2x9GkNpn03/hcRVMbahGqjb/e6QZ0jZEBKVFhs/jNDbYn8
         6F24yUZ6QtyzSjvsubKXgHZvPQ8P6pRIOSCPLhbTvL0VA4XSt7l7YU7MJ8XcKivLalS8
         gUkQU7MEyjir8gSeav8+C/7Wy361kvARpMGR7tj2aLOGGprqEK8DE7i0tgfIbcvCPEm/
         Eeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359493; x=1733964293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSMpWEuhlvJtsZ2OsswG9SVVUl4Sf57QbNL9YVukIAU=;
        b=jhLaW3q/7frMomssCkZKzJ2NSRFni934AgJlPvxDSKtVlaSkvU1F8QdZbIrTggbr3U
         ADVnXk+c7BkAsa0bTtF9LkKvcRqAeiSaPTABjiDDtcc3x1FFTxJu6HZVUiCdspYyObFK
         31c/ojSi9WjIiD87TCysy7R23Zx/3pV9siduqRYXQBsSbxMrbXIQGkq+upOTMBFsxzRh
         FcxYqgKnd0qK3abcG0AqFIhYinxMlQY5tX35PZhQp7DszaBKzDXr/+UgZYzpz3HLcJfV
         DHtiN19LclO+ADutVHkoz2RhiPJfwFPDbVxHx3ad9MAR1yXoTct96KjpHzB57g6gw6es
         slBw==
X-Forwarded-Encrypted: i=1; AJvYcCUnovg/jv/WsV4lbVv6C9bxbYKTyh/iCeGKRvEv4JE1v0Ey8iDnYkHu10Z3w+1a9f5KlMbXD66Gl2G45c1khZmcsn76kQ==@vger.kernel.org, AJvYcCWn2b6OEeGCDbGuvW6ckNeYXG6j5k3xIgUMwHO63rE+gMTvNKfUxmj358wqK8wTaeMdpy8SnARNab76RHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFKtcImoV9DTn0Ziee8oclySNoST+hgygj2ZsQD7L/1AJCoyT
	0lJLMojUxgUUFlD7VvmfKezFaGoDPmPs+xHD7j96txjEfI62L1Zh
X-Gm-Gg: ASbGncvpjpD/tglpf/wReatvBaTiFNoIUCiRkgPRCz66v9Y+EVTThRvKpS4vHuX8+Wh
	UDgpteXHcdiOLxFcYXNXTQKn7hRZv1C2J+tvxyarVFzc/eeyfDGIQ/N7PEU9O/eoSL0lQKMTp1w
	zbkxzlPNoaUc6cV0FOKaeKPYGqLu7pm0+puMTRchNeU0A4CLX2VSc5tMZqyT4inxv+xLuLYDkOR
	c9K36x5YiG4WA2tUH7YGs+HVsTy6fSLH7bg1MTf3bQIkpL6bv/wmIoDDN0yCd52zK0isx8GKcDf
	AZwO8DyrlLZZJr3KnEU=
X-Google-Smtp-Source: AGHT+IGQTYZR9YXRPUqE23JqxoqcQQpKYmopkW/habi83Kq9SkmHrBi1SFy8oR6FrWqltSeX6ikmPg==
X-Received: by 2002:a05:6a20:6a1b:b0:1e0:d9ab:27f with SMTP id adf61e73a8af0-1e16541336cmr13990803637.37.1733359493289;
        Wed, 04 Dec 2024 16:44:53 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156994c3sm154251a12.16.2024.12.04.16.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:44:53 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 14/21] alienware-wmi: Migrate thermal methods to wmidev
Date: Wed,  4 Dec 2024 21:44:29 -0300
Message-ID: <20241205004428.2186244-2-kuurtb@gmail.com>
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

Drop alienware_wmax_command() and refactor "platform_profile" methods to
use alienware_wmi_command() instead.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 71 ++++++++---------------
 1 file changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 01414c2d9565..18a15dcf90a3 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -650,34 +650,6 @@ static enum led_brightness global_led_get(struct led_classdev *led_cdev)
 	return priv->global_brightness;
 }
 
-static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
-					  u32 command, u32 *out_data)
-{
-	acpi_status status;
-	union acpi_object *obj;
-	struct acpi_buffer input;
-	struct acpi_buffer output;
-
-	input.length = in_size;
-	input.pointer = in_args;
-	if (out_data) {
-		output.length = ACPI_ALLOCATE_BUFFER;
-		output.pointer = NULL;
-		status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
-					     command, &input, &output);
-		if (ACPI_SUCCESS(status)) {
-			obj = (union acpi_object *)output.pointer;
-			if (obj && obj->type == ACPI_TYPE_INTEGER)
-				*out_data = (u32)obj->integer.value;
-		}
-		kfree(output.pointer);
-	} else {
-		status = wmi_evaluate_method(WMAX_CONTROL_GUID, 0,
-					     command, &input, NULL);
-	}
-	return status;
-}
-
 /*
  *	The HDMI mux sysfs node indicates the status of the HDMI input mux.
  *	It can toggle between standard system GPU output and HDMI input.
@@ -932,7 +904,8 @@ static bool is_wmax_thermal_code(u32 code)
 	return false;
 }
 
-static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
+static int wmax_thermal_information(struct wmi_device *wdev, u8 operation,
+				    u8 arg, u32 *out_data)
 {
 	acpi_status status;
 	struct wmax_u32_args in_args = {
@@ -942,9 +915,8 @@ static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
 		.arg3 = 0,
 	};
 
-	status = alienware_wmax_command(&in_args, sizeof(in_args),
-					WMAX_METHOD_THERMAL_INFORMATION,
-					out_data);
+	status = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_INFORMATION,
+				       &in_args, sizeof(in_args), out_data);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -955,7 +927,7 @@ static int wmax_thermal_information(u8 operation, u8 arg, u32 *out_data)
 	return 0;
 }
 
-static int wmax_thermal_control(u8 profile)
+static int wmax_thermal_control(struct wmi_device *wdev, u8 profile)
 {
 	acpi_status status;
 	struct wmax_u32_args in_args = {
@@ -966,9 +938,8 @@ static int wmax_thermal_control(u8 profile)
 	};
 	u32 out_data;
 
-	status = alienware_wmax_command(&in_args, sizeof(in_args),
-					WMAX_METHOD_THERMAL_CONTROL,
-					&out_data);
+	status = alienware_wmi_command(wdev, WMAX_METHOD_THERMAL_CONTROL,
+				       &in_args, sizeof(in_args), &out_data);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -979,7 +950,8 @@ static int wmax_thermal_control(u8 profile)
 	return 0;
 }
 
-static int wmax_game_shift_status(u8 operation, u32 *out_data)
+static int wmax_game_shift_status(struct wmi_device *wdev, u8 operation,
+				  u32 *out_data)
 {
 	acpi_status status;
 	struct wmax_u32_args in_args = {
@@ -989,9 +961,8 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
 		.arg3 = 0,
 	};
 
-	status = alienware_wmax_command(&in_args, sizeof(in_args),
-					WMAX_METHOD_GAME_SHIFT_STATUS,
-					out_data);
+	status = alienware_wmi_command(wdev, WMAX_METHOD_GAME_SHIFT_STATUS,
+				       &in_args, sizeof(in_args), out_data);
 
 	if (ACPI_FAILURE(status))
 		return -EIO;
@@ -1005,10 +976,13 @@ static int wmax_game_shift_status(u8 operation, u32 *out_data)
 static int thermal_profile_get(struct platform_profile_handler *pprof,
 			       enum platform_profile_option *profile)
 {
+	struct awcc_priv *priv;
 	u32 out_data;
 	int ret;
 
-	ret = wmax_thermal_information(WMAX_OPERATION_CURRENT_PROFILE,
+	priv = container_of(pprof, struct awcc_priv, pp_handler);
+
+	ret = wmax_thermal_information(priv->wdev, WMAX_OPERATION_CURRENT_PROFILE,
 				       0, &out_data);
 
 	if (ret < 0)
@@ -1039,7 +1013,8 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 		u32 gmode_status;
 		int ret;
 
-		ret = wmax_game_shift_status(WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
+		ret = wmax_game_shift_status(priv->wdev,
+					     WMAX_OPERATION_GET_GAME_SHIFT_STATUS,
 					     &gmode_status);
 
 		if (ret < 0)
@@ -1047,7 +1022,8 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 
 		if ((profile == PLATFORM_PROFILE_PERFORMANCE && !gmode_status) ||
 		    (profile != PLATFORM_PROFILE_PERFORMANCE && gmode_status)) {
-			ret = wmax_game_shift_status(WMAX_OPERATION_TOGGLE_GAME_SHIFT,
+			ret = wmax_game_shift_status(priv->wdev,
+						     WMAX_OPERATION_TOGGLE_GAME_SHIFT,
 						     &gmode_status);
 
 			if (ret < 0)
@@ -1055,7 +1031,8 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 		}
 	}
 
-	return wmax_thermal_control(priv->supported_thermal_profiles[profile]);
+	return wmax_thermal_control(priv->wdev,
+				    priv->supported_thermal_profiles[profile]);
 }
 
 static int create_thermal_profile(struct wmi_device *wdev)
@@ -1071,7 +1048,9 @@ static int create_thermal_profile(struct wmi_device *wdev)
 	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
 	dev_set_drvdata(&wdev->dev, priv);
 
-	ret = wmax_thermal_information(WMAX_OPERATION_SYS_DESCRIPTION,
+	priv->wdev = wdev;
+
+	ret = wmax_thermal_information(wdev, WMAX_OPERATION_SYS_DESCRIPTION,
 				       0, (u32 *) &sys_desc);
 	if (ret < 0)
 		return ret;
@@ -1079,7 +1058,7 @@ static int create_thermal_profile(struct wmi_device *wdev)
 	first_mode = sys_desc[0] + sys_desc[1];
 
 	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = wmax_thermal_information(WMAX_OPERATION_LIST_IDS,
+		ret = wmax_thermal_information(wdev, WMAX_OPERATION_LIST_IDS,
 					       i + first_mode, &out_data);
 
 		if (ret == -EIO)
-- 
2.47.1


