Return-Path: <linux-kernel+bounces-369409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE799A1CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402031C2550B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E891D0DF7;
	Thu, 17 Oct 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhyulja4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F01C3F1C;
	Thu, 17 Oct 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729153011; cv=none; b=LOdmjWfa20elUf4S3IyR3qt6EnVYZuuqkMoMmHMokqH76/aTbQeNAkFoCGJMfVYxEktq2tdhs7N3HJr/8DE8+tIpKSEV1JBMcNYEds1+Ga8ivJYBZjXSfy+FElWHtMBqVBjbpxNml9uMHUF3ogwgReXXHeevCxUjNdeua2rk4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729153011; c=relaxed/simple;
	bh=d90PHQSeAh3+rIYCUoOl/q337T76O+cbg+e6ybgRxeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTU4uD2gQD4xvN0RFMb5YyziurdJTRpMwoenPfcYCbv+DNW1uqsBB/vgAG4JamPt3uFF7PeB84LxKvcfHzNqfOe2KZdwPyCO5kadLS/4+IKLTj/dKoWK1ShbBb7zB87KVRj8hI4jPhlBbFv5YokFtgsyREIsU6NgMsCCXLsR1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhyulja4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cbca51687so7246275ad.1;
        Thu, 17 Oct 2024 01:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729153009; x=1729757809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Bm4jnKa4F9F0RZdsYRUP1p+4Ch47WjbmZE4eaTvz4k=;
        b=Lhyulja42kpwNY0aREKYAttQmUN57/R94AyeAq+QxhPc14lZkskI8Rv6Lp8vHevlB7
         STnSVX/Ntx4T13QRlEQMe8PljUsv5gsi78S7Z51Zmwc8hzgVu1LzC+nJF1G66sSro0ZH
         tfpvYTe9rP4+tKZc3+JBDyfRtN7EL+d67vSoJUzcAKcfTGlQMPDlEUTEnDoOVQowu0C1
         d2+sBgdUQaTJ7uX3TqJ9iWPFs3gB3Yot8UTQeUnT9HXUoYNg7MBK2SWhenqNEXlWRcI7
         n4YRfd7MI1FTObl3+yI87TPHKR+/WYB9QKK2F5jfmrVJoFlQbWcyh4Vza+RNdA6wz8qq
         8L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729153009; x=1729757809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Bm4jnKa4F9F0RZdsYRUP1p+4Ch47WjbmZE4eaTvz4k=;
        b=n+CL8DZ8zbPm6xESDFWpUnIAqwVlA4yCKeat/CeAIBFW6/hW9lwUuuFyn2BjUE5JYq
         ypXHxXOR9RCWnuE2pUJduUFgZqB6P/s5RViw3zKX7G3NzpuFGKmaZIXkswdyGVqgeadc
         KGgHPNpSH3gFBrS4HremJFms8JcA9JDZp+u6pSjYTmUo0zdxA4yn2qT06id2yGp6VT6C
         ek8eyM1AIz3u4CyAqhdLDX0GtlmeLmXdzAnwpGJQc9YhI6co20NqXr7XIu7g2zAO+7r9
         lVszu/ILXD8z97Qfw3RTO8z1B11qrxBql+HRw7NORiGwhCyXl2WE7E99hY73ebKWJItN
         CgsA==
X-Forwarded-Encrypted: i=1; AJvYcCWHRuqZFFxoc5rRn6YDBShCl2i8MQX2DSrAi+Fw6Q1E0pd6+vUjAYjTpAlWhj+oH0jc3pVOl51qg2COB5o=@vger.kernel.org, AJvYcCWUawUzD0uZ9f38T/z5OsFxq3vuFTSmhZRm/i2X59bV29vEHLuOlTN3l+atwxTT/asNCmF0/WT7Q8stO/UsDN5AEFbNyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7gHxFmMSkJqlsXZYCEmJ3WWEEiP4hbWZnQokkoeG+g+HA89C
	QCG+3iTgyaNFVLZQeaNOxj0KrOFoZAmG0BkiY+CWKAHf19Rcaedt
X-Google-Smtp-Source: AGHT+IHhRobSHaH53eJJuZZCL2A+Cv/16jd21ueCB3B5xPAkX1wy2enBiGkK5Ap/kB0Tf/GbqoMeog==
X-Received: by 2002:a17:902:ce87:b0:20c:8b10:9660 with SMTP id d9443c01a7336-20cbb2845dcmr299010205ad.44.1729153008847;
        Thu, 17 Oct 2024 01:16:48 -0700 (PDT)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm39816725ad.93.2024.10.17.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:16:48 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: W_Armin@gmx.de,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH v6 4/5] alienware-wmi: added autodetect_thermal_profile for devices with quirk_unknown
Date: Thu, 17 Oct 2024 05:16:33 -0300
Message-ID: <20241017081631.127333-3-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017081211.126214-2-kuurtb@gmail.com>
References: <20241017081211.126214-2-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added autodetect_thermal_profile for devices with quirk_unknown.
Autodetection is done through basic conditions most devices with WMAX's
thermal interface meet. Function exits returning 0 in case of errors.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>

---
I apologize for the late inclusion. This feature can extend support to
many devices without having to list them in alienware_quirks.

The conditions for selecting the automatic thermal profile are based on
observations on a lot of *issues* in AWCC open source alternatives. 

I observed only Dell's G-Series laptops have WMAX_THERMAL_BALANCED
avaliable and when it's present none of the other profiles are
avaliable, except for GMODE. When a model has USTT profiles avaliable
usually they have all USTT profiles avaliable, except for cool on mostly
Alienware devices.

I made another implementation of this function, brute-forcing operation
0x03 of Thermal_Information, which is the operation that varies the most
across models. I found the implementation too cumbersome to include in
this series, but it could potentially extend support of this driver to
all posible devices with this interface automatically.

Another possibility is just including every device I observed into
alienware_quirks, which I can do but I want to know your opinion first.
---
 drivers/platform/x86/dell/alienware-wmi.c | 42 +++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 37a898273..a11ff4851 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -30,8 +30,11 @@
 #define WMAX_METHOD_DEEP_SLEEP_STATUS	0x0C
 #define WMAX_METHOD_THERMAL_INFORMATION	0x14
 #define WMAX_METHOD_THERMAL_CONTROL	0x15
+#define WMAX_METHOD_GMODE_STATUS	0x25
 
+#define WMAX_ARG_GET_DEFAULT_PROF	0x0A
 #define WMAX_ARG_GET_CURRENT_PROF	0x0B
+#define WMAX_ARG_GET_GMODE_STATUS	0x02
 
 #define WMAX_FAILURE_CODE		0xFFFFFFFF
 
@@ -968,6 +971,42 @@ static int thermal_profile_set_ustt(struct platform_profile_handler *pprof,
 	return 0;
 }
 
+static int autodetect_thermal_profile(void)
+{
+	acpi_status status;
+	u32 in_args;
+	u32 default_profile;
+	u32 gmode;
+
+	in_args = WMAX_ARG_GET_DEFAULT_PROF;
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_THERMAL_INFORMATION, &default_profile);
+
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	in_args = WMAX_ARG_GET_GMODE_STATUS;
+	status = alienware_wmax_command(&in_args, sizeof(in_args),
+					WMAX_METHOD_GMODE_STATUS, &gmode);
+
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	if (default_profile == WMAX_THERMAL_BALANCED && gmode == 1) {
+		quirks->thermal = WMAX_THERMAL_TABLE_SIMPLE;
+		quirks->gmode = 1;
+		return 0;
+	}
+
+	if (default_profile == WMAX_THERMAL_USTT_BALANCED)
+		quirks->thermal = WMAX_THERMAL_TABLE_USTT;
+
+	if (gmode == 0 || gmode == 1)
+		quirks->gmode = 1;
+
+	return 0;
+}
+
 static int create_thermal_profile(void)
 {
 	pp_handler.profile_get = thermal_profile_get;
@@ -1050,6 +1089,9 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_deepsleep;
 	}
 
+	if (interface == WMAX && quirks == &quirk_unknown)
+		autodetect_thermal_profile();
+
 	if (quirks->thermal > 0) {
 		ret = create_thermal_profile();
 		if (ret)
-- 
2.47.0


