Return-Path: <linux-kernel+bounces-559699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11119A5F84E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D874119C4A97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0161B269832;
	Thu, 13 Mar 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW/GS4lf"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC48A268691;
	Thu, 13 Mar 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876228; cv=none; b=dnjKSDF+HObZV4S1CMmUea0S2Y+yTsu2IrmSEMM/Fp3wXDaIoTZuP3NoALgEvAKz7WPlUgDnp9WLtRQ3wtrgEA4PxVCNUjFpcYPHBCmHTLq3UoMouVMPVxQMvT6T4D8a/l/XsdCEWxmXsZD0FywDZ96qZCcMtxEMf3vZV8blb00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876228; c=relaxed/simple;
	bh=/RVTDk95xTdgwIURpxctNMV56eIngqQ4/eX5yRQzsK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAsxzlwTywIUIGfwuuZoq6mzJ3Og4LKpOjtDk7yvPEPhiQugQ45DoF63j49oQgmwxGL1HjBeQiAdNRjNqDmbsotaZwWtnP+n4i03MP5RJbIAKi6j21N3yzMhmPCIRJd3M6piPJ7MR3kIHhG171Su6sKXvYIUj4FZxVcIcA5pYs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NW/GS4lf; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e6341e4d0b4so1881761276.0;
        Thu, 13 Mar 2025 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876225; x=1742481025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H43dqBGhipBxPHVP+jwxsicROhpGVr1mHnd5dBnGOsU=;
        b=NW/GS4lfcZP7Eg5sEGsr5yLs7yxLd7AKBrIsjg/tbZ/giC33FJhOAHe6qmc8VB5nd3
         s/jj+KR0jyXfj7ugaRWnl1kfnI5U8NVHYudEG2CFBHa6GhuwYbBhrrYrBLlfn6mu2pEK
         wanEprj3469xtr5TiPS9CBjhFGEmQKTqj+QqANurGNd+CJi3QHcAPQdL5uWT9zuDnor2
         FerKyh8exXiPfNp7PebRPmsm3MOGRBt5i1/xUlWkh6Kt0WYBzzj9+AyQ0dMnBtLq1fmX
         WeV6et5792RggpWIb0dzmHlsQFnGa35MjzwGrpjthoLAWoCUtmGXtKucMUCSpYxz6Vb1
         Riiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876225; x=1742481025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H43dqBGhipBxPHVP+jwxsicROhpGVr1mHnd5dBnGOsU=;
        b=iz8uFlS9XgiDwWO9BsvjrF8LRcNw15d23PBSU7GW0e7TdEYKiL760wTRoUQwHJFcRF
         UKK/PI0D+mSW9SVfgTDLkba5Odyt/ifloUvSLEKkkmdsp7jpRrpFEXzIbL+qrHYxjASu
         R6ceaDz5Elpo5i2xbf+C4gqHZa3sQuj8Eg3W4+rv+HDYfg26IoKbMXEwuhap+dDFEBSt
         4gyOhrr+fsOkCQeFJnrGdbOzUcQ0yKgCqccietZt5EtyOBtxrGMJFcKNGpftnWa+U6/C
         +jVTWNC/OqlPfEqxcqkYHzRbetG/wj7+MTjd59R/wJXIBq+5LkGQp55XsZ/LKZgE4ujR
         cQUw==
X-Forwarded-Encrypted: i=1; AJvYcCWkYeE4yDeECsKGKcMRRlATzBE6Vm+tsLiuxehYkdWgg5wcH/FT14jRTAv6/YoOGY3mbgG1Q0/5nKRurak=@vger.kernel.org, AJvYcCXMibftNIRKBBFG6xhcIoC8c5TIQvHYn6QPS/yABnSQQsSNMCVaqufIk3nng2ZcmAIQ5zzMpboMvQBhc02m2UShM3keFw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOLZtrtaX/b/vPwLtdqnUuEEtHmFmAtdICf+4tY6fFioUk70z
	uWnpu1Rq4FKAZuMUgY1qFVE1DK1gGBnYLWAl6f2h2BNpEK0yEiuHCFZe1chD
X-Gm-Gg: ASbGncsUUluYorihifHWzS8vkxbgdnuJ9fHAmMqpT7M7NoaaOjqDHaN43fiEo8DEl3g
	D+ARFYeAoqGnWx5mkGBy2aUy0Y/waHTH+cD38ob+Vo69LP2D6Y1hSQ0DNX0x1IrWk+Zg/ZfHkyv
	KA4BkLg0zPCQ4AhlIYXEpf5w9O9rUcPUNMY7nY223kFkI/C2nSjg9Aielvyo2HyZRChfVZoM9db
	Jb5/XHew2298ZnKOK+W/IlQb84CVu7l+Q2lp5gex51p7HFfcROyyVn+w55e9O2RCwRdMhvMRpVo
	47NpFNqp3IIxrRI+ADg9UMRbK/lCN06v6TDE2ec3UK5q3A==
X-Google-Smtp-Source: AGHT+IE9jUrYk/s6U/kpCNubFDXo6NtG8uIjFtuEh+Os6nK3lcMjXqwsXN/pO1r/XmwpzYCtLFnFhg==
X-Received: by 2002:a05:6902:2289:b0:e63:cfb7:5da5 with SMTP id 3f1490d57ef6-e63e3be255fmr3521660276.9.1741876223341;
        Thu, 13 Mar 2025 07:30:23 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:22 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:01 -0500
Subject: [PATCH v6 06/12] platform/x86: alienware-wmi-wmax: Add support for
 the "custom" thermal profile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-6-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

All models with the "AWCC" WMAX device support a "custom" thermal
profile. In some models this profile signals user-space that the user
wants to manually control the fans, which are always unlocked. In other
models it actually unlocks manual fan control.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 0530f25b956f73f47c0354f40dac2910448c894e..3b37e4456482bc284b8e867c1c5b6255fc6c8ef2 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -29,8 +29,6 @@
 #define AWCC_METHOD_THERMAL_CONTROL		0x15
 #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
 
-#define AWCC_THERMAL_MODE_GMODE			0xAB
-
 #define AWCC_FAILURE_CODE			0xFFFFFFFF
 #define AWCC_FAILURE_CODE_2			0xFFFFFFFE
 #define AWCC_THERMAL_TABLE_MASK			GENMASK(7, 4)
@@ -177,6 +175,11 @@ enum AWCC_THERMAL_TABLES {
 	AWCC_THERMAL_TABLE_USTT			= 0xA,
 };
 
+enum AWCC_SPECIAL_THERMAL_CODES {
+	AWCC_SPECIAL_PROFILE_CUSTOM		= 0x00,
+	AWCC_SPECIAL_PROFILE_GMODE		= 0xAB,
+};
+
 enum awcc_thermal_profile {
 	AWCC_PROFILE_USTT_BALANCED,
 	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
@@ -589,9 +592,15 @@ static int awcc_platform_profile_get(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (out_data == AWCC_THERMAL_MODE_GMODE) {
+	switch (out_data) {
+	case AWCC_SPECIAL_PROFILE_CUSTOM:
+		*profile = PLATFORM_PROFILE_CUSTOM;
+		return 0;
+	case AWCC_SPECIAL_PROFILE_GMODE:
 		*profile = PLATFORM_PROFILE_PERFORMANCE;
 		return 0;
+	default:
+		break;
 	}
 
 	if (!is_awcc_thermal_profile_id(out_data))
@@ -679,11 +688,17 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 	if (awcc->gmode) {
 		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
-			AWCC_THERMAL_MODE_GMODE;
+			AWCC_SPECIAL_PROFILE_GMODE;
 
 		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
+	/* Every model supports the "custom" profile */
+	priv->supported_profiles[PLATFORM_PROFILE_CUSTOM] =
+		AWCC_SPECIAL_PROFILE_CUSTOM;
+
+	__set_bit(PLATFORM_PROFILE_CUSTOM, choices);
+
 	return 0;
 }
 

-- 
2.48.1


