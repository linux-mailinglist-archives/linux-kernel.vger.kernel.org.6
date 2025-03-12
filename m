Return-Path: <linux-kernel+bounces-557223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E351A5D551
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A14B3B1A23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FCF1E0087;
	Wed, 12 Mar 2025 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1BdrBAQ"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C171DED56;
	Wed, 12 Mar 2025 05:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756327; cv=none; b=E3ARHnSyY8sp7Cz7pN2WQaypyOiFfQRk5kEWbVdDRhw5Y7f9oDLThHO12pNKva21cQTuaJAtc+Jjq6Vt6h+DwKmdpI1Ku76W5BJDUEeYMcjH0o/+1pcwyl0wZ/OVMw8XkSxeb7bDBat93REQiDezXp2QTaX228Ou2Ctv5mt7mlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756327; c=relaxed/simple;
	bh=b6I4LW2lXRr4zSKyCgVo5hQkgsNPWVdZQx2aOlTduKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fv9O/wn5NZdThK8NuwrF3ZdIcX94WhO3Z1uNCjIJfRgVtNh68DgEAsQc3PosSiLnmdANDoh3oANXkhdar0gEK2a44/Q9LlxxkYr8s1P7zsCdfCbF87DpNb5fe7voJG6yywCGbFH2B2pYtZXo/ZT614LhPew5DajTu307rwrgztE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1BdrBAQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6fda22908d9so47232317b3.1;
        Tue, 11 Mar 2025 22:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756324; x=1742361124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki8JJlqvtQ1DWozBXa70s7Vleuhvzvt2Tgc/aHkAO4s=;
        b=A1BdrBAQgIZ6QpY0Rd+nFMmIIqUn9DYVDnR45FxDC3Lp9daTafcWktjl21Kz0QmDo7
         yk6KHQvGc4XlAPwf6xLGCpObotiieeYnw4Gk/wq/r/A4TT4h0J1U/sbKssOPHSrFLXYm
         Hm735Az9UXT39fcmPaBnd8f+IIld4w8fGDNBFFO+cIQl1IGgyDHVbMT/UkNS864Qmkcd
         wFaXNpQjLAUKSDB2qurBrethqc4g/jjhKItaHKYy8pVRh5lRP8uMOjxrjmAMBdDBmLcD
         JbEHd4kbmXjMV3ispHIgyKhM0Q7newvNA/zk/Sk4UO8HqwzOaoeaO4Nc+B5+15RdDXtF
         SZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756324; x=1742361124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki8JJlqvtQ1DWozBXa70s7Vleuhvzvt2Tgc/aHkAO4s=;
        b=n88O2ECTlxKWukwu5QePkXwcjmxSOO97kAFYVe96x8B2pmdFngylBo9CZEINedy4T+
         LV88wdbNNgBmXlluhiq224orxO/1fOjz8FyTqeZQAowcrJ4f4mIjnT9UeJE35oWSQcrr
         FPE3CdMXNekm2PoGWl52JWcCR1pYFb9vH4chmBNlZKEJIgamb8V6x35gu0xjRnuFzs2Z
         aAmSh4Vhp6bBltqnHaBrf6nx6EQcMf9drMGDHsmO/ZktHe38GWumByl8lEDzSJxtt48K
         Vyq8/PeGduoK/oJQguBelzo0ZWavc/llQcHysK+uUQ6tvin5RrFm2WXzNJenzwAskwAY
         30jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsZ1aMYvjHydBngktMQ2hxopRYMo5E1JxYNtySx2qpF1gwC2okMK0WSYOm4j6ly1l6IehStf6CPRD9kS4=@vger.kernel.org, AJvYcCXKFAzlMZd1rXqRRYGQR4rshG6mk+R1yICMeLt5WaHYSaKNUARq3DoFFNameklr9YQlBEh+AiuPHRFxeaDmo0yyMOhrzw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXI/f5KkBJNDPg7bSP0eGK210dUpdWjK1vDOI0iWkDdZC/XGP
	2RYrr2gHbzvrH8Jy4PKCxpV4J3lWtdQinn6LwjFtGLmQPfkjZLascMjV5KGe
X-Gm-Gg: ASbGnctvuRDCHdpq+fVgMX2QzQRDIjs7JR7eksvsFfxuFLMfY2zoBpE2advUaTR6ucA
	qPJK2+8kyeMwA8c84elGcxud4DyBPi2UstT2ubb0/p6h1sQr6IMSSJdif3pVrLZHC48jjYQRL+4
	HRtRVCCT5w/QsXl33c7YhwtC+RYHB6wj3vFsWqP7RlokR3WjEQrGVu44YsGFGL2ZAcjtVfj5W7z
	jl/HMJGND2pfQRvgdOEDcibUVjYZaLurhrWmybSyzCGOXt+UlMWNDTagiPQJG6/pRCgJiyCSk8S
	wRvCpIIp3QBx8WfB2EbSciEL8yexDRtzPvvE46SQTIAhPg==
X-Google-Smtp-Source: AGHT+IFgYfileD4GR5Pw70b8L8MNE/qxLqxjGU/YaNhXoncddJtkguB6Xq98DKE8z6IwX6zLEIIMWg==
X-Received: by 2002:a05:690c:48c2:b0:6f7:409c:f659 with SMTP id 00721157ae682-6febf292e17mr256428367b3.8.1741756324551;
        Tue, 11 Mar 2025 22:12:04 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:04 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:15 -0500
Subject: [PATCH v5 02/12] platform/x86: alienware-wmi-wmax: Refactor
 is_awcc_thermal_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-2-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Refactor is_awcc_thermal_mode() to use FIELD_GET() instead of bitwise
operations. Drop the check for BIT(8) sensor flag and rename it to
is_awcc_thermal_profile_id().

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 33 +++++++++++++-------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index ed70e12d73d7fe5d89f3364c5367820bf47e3c1e..80aefba5b22d6b4ac18aeb2ca356f8c911150abd 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -34,7 +34,8 @@
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
 #define AWCC_THERMAL_MODE_MASK			GENMASK(3, 0)
-#define AWCC_SENSOR_ID_MASK			BIT(8)
+/* Some IDs have a BIT(8) flag that we ignore */
+#define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
 
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
@@ -168,8 +169,8 @@ enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
 };
 
 enum AWCC_THERMAL_TABLES {
-	AWCC_THERMAL_TABLE_LEGACY		= 0x90,
-	AWCC_THERMAL_TABLE_USTT			= 0xA0,
+	AWCC_THERMAL_TABLE_LEGACY		= 0x9,
+	AWCC_THERMAL_TABLE_USTT			= 0xA,
 };
 
 enum awcc_thermal_profile {
@@ -445,20 +446,18 @@ const struct attribute_group wmax_deepsleep_attribute_group = {
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
  */
-static bool is_awcc_thermal_mode(u32 code)
+static bool is_awcc_thermal_profile_id(u8 code)
 {
-	if (code & AWCC_SENSOR_ID_MASK)
+	u8 table = FIELD_GET(AWCC_THERMAL_TABLE_MASK, code);
+	u8 mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, code);
+
+	if (mode >= AWCC_PROFILE_LAST)
 		return false;
 
-	if ((code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LAST)
-		return false;
-
-	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_LEGACY &&
-	    (code & AWCC_THERMAL_MODE_MASK) >= AWCC_PROFILE_LEGACY_QUIET)
+	if (table == AWCC_THERMAL_TABLE_LEGACY && mode >= AWCC_PROFILE_LEGACY_QUIET)
 		return true;
 
-	if ((code & AWCC_THERMAL_TABLE_MASK) == AWCC_THERMAL_TABLE_USTT &&
-	    (code & AWCC_THERMAL_MODE_MASK) <= AWCC_PROFILE_USTT_LOW_POWER)
+	if (table == AWCC_THERMAL_TABLE_USTT && mode <= AWCC_PROFILE_USTT_LOW_POWER)
 		return true;
 
 	return false;
@@ -548,7 +547,7 @@ static int awcc_platform_profile_get(struct device *dev,
 		return 0;
 	}
 
-	if (!is_awcc_thermal_mode(out_data))
+	if (!is_awcc_thermal_profile_id(out_data))
 		return -ENODATA;
 
 	out_data &= AWCC_THERMAL_MODE_MASK;
@@ -597,6 +596,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	u32 first_mode;
 	u32 out_data;
 	int ret;
+	u8 id;
 
 	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
 				       0, (u32 *) &sys_desc);
@@ -615,12 +615,13 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		if (ret == -EBADRQC)
 			break;
 
-		if (!is_awcc_thermal_mode(out_data))
+		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
+		if (!is_awcc_thermal_profile_id(id))
 			continue;
 
-		mode = out_data & AWCC_THERMAL_MODE_MASK;
+		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = out_data;
+		priv->supported_thermal_profiles[profile] = id;
 
 		set_bit(profile, choices);
 	}

-- 
2.48.1


