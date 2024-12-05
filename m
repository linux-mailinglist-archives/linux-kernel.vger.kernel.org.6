Return-Path: <linux-kernel+bounces-432451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0409E4B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571951689D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF36C11187;
	Thu,  5 Dec 2024 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVt/MF9u"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E99711185;
	Thu,  5 Dec 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359466; cv=none; b=ZlGEnaQnant5sihcd5tItHXMI9S8dsdxznfRjaVmVAeklTOnttfRYQNCbqM/OG51xNRV0DD0wKJEfblW0RSLXVTHfF8ocWV9ezurD0q5h6rBIT9cg4b85JUufjcvF7GjDtJ17icgYhYiyoS/lUu8AOWoLCI+FOkffhytIyz4GqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359466; c=relaxed/simple;
	bh=TMdDfvotuWy8ztjZRhCc9vjkb3GaxxY3SXmu94y4A0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqcxd5TCasrcW/Ab27rH2j41dRGkkPqC5eRU3Fk8KRm5vZQGSLDmZCRezBdeMx9y6L+OvFVeAS/lJEmfzRAusWQNu4jehkDj8Dx9k2kPQ8NQviKtMoutMicxTIMyhWWaijl+m83dTrXyN88JoeTJXEv62NtEyUm/qLvrcjfBZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVt/MF9u; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-215d92702feso2600095ad.1;
        Wed, 04 Dec 2024 16:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359464; x=1733964264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QceCrdCI5hwUmHx2YQ+2LUKETfIfBTL6QEYbC41NrFE=;
        b=lVt/MF9u02S3Hmws0a8KFv0l+avM9EG3g09JZEVHrWaWcG0xnAs9+uNfl5Y3D4+VGq
         QZmXt9tM/9gHBi/bGAp7auvkRvcX7RcvoRXmoyW+85ap14lJZw74Xa/Cm1kcxTq+Xx99
         0fGJfqGcniAd+91KNn91Z4t4oeEE2esEMxoRMwA94rtSoHuqX4yKkVWeQcA+xju1pKRJ
         jAEFIe6dYGLQDicv6wobMJFaXHGl4mv94/EEpVc+059OUl9IhL8Azpc0JZA2djViDyuV
         YUphpFOKtaqf7KO6kDv4mYnAjS2aa4onM1asitxUTWq0U2cp1Ojz0H0ASDBUtZoYKyFd
         6rJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359464; x=1733964264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QceCrdCI5hwUmHx2YQ+2LUKETfIfBTL6QEYbC41NrFE=;
        b=QRbxIGUMD0UxDc1YDfQEBeN7HLQ6xrkeZDHwRnO4iktuqfPPKRSrkiYG0ifw+Iavhv
         qVyhrZP9aUwDfc2aDO1+mNKb7Qbp7UTtsvu1IlYWeX0OXNT5qvJl4u1uOmghfDGcHZb0
         lyGstHj5M+2HceoACyIDdQ7rzjwD1Jzj42C9rLuj8WycyacjixnlAEMiyHvAA5+ahl9H
         hW/1DucxCv5GLzRD3ZC41RX2xJzztzYdYj2byXAYmb5tr6rMk36BmnPSfxu78mwqPdAU
         oKbZLUNEOr4zES/3XwFJ8G4QcC18wSULsaSUxaIubIGFgOVIyNh9MqZ4coNCIvinRalG
         3pPA==
X-Forwarded-Encrypted: i=1; AJvYcCVr02dy3JKg/0gsvb9V+rcD1YVxC5wSA+qywRGBWeG44S88gMvp/TONS8H6F3UTBBd3Leur3uhAeeNgguVPQ1lWeYiDWw==@vger.kernel.org, AJvYcCW+0SHt1LZl830PM2+TC0PHKrpOYBYyjAUfhsgs87TeakRdBpZ/9sMyW23KM5jaLychG9+C2yI2ixpWQcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf1szkLNZ4cwe2l8Q2d5gDjUI9apYmhwksDNom4ij2F/X/kpXd
	dDQSlfR2s0GrG+o5dHIM737QJIa65niTSKblOphZFUGKC73cEWri3oNRmsU0
X-Gm-Gg: ASbGncvMUbF3Ijsvil6RrnUyaGFaFqDrXpZP/kX/rUPWesZgui0Sg27+WqOLpDNM6Ab
	MbjElN3r8FJCfrhN//bIoJXLjxX9F6J/UFI5Jon1r+ITEHRi5ViUwV1+nrYQJoShm4fWVjAJPY1
	RMD+2/5vh9lvMGJ6k3X9I61DbZ7FgRmmQbrQxj7ANb4cLxW8kKg7wGk22OaSDdVeTVQFTi4D7xd
	mCXJ4aDtwh32d7FAR5sXCgy0/Ab7L22xCMm1J4tAOQUm+wuREwAHe2+qbVjORSwptx+XcYZ6AIb
	aIXnS7tSG7cGKlkxbLk=
X-Google-Smtp-Source: AGHT+IE6THraoxlNHyq4DOS8D9vMe2OGZvT1wkzcWNkyAUKKq6UW3LlBjwnHqIVCXfzkNfFv2HCizg==
X-Received: by 2002:a17:903:1c9:b0:215:6211:693 with SMTP id d9443c01a7336-215bd18ed72mr78970665ad.57.1733359463996;
        Wed, 04 Dec 2024 16:44:23 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f09344sm1348095ad.186.2024.12.04.16.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:44:23 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 13/21] alienware-wmi: Add a state container for AWCC
Date: Wed,  4 Dec 2024 21:44:12 -0300
Message-ID: <20241205004411.2186107-2-kuurtb@gmail.com>
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

Refactor all "platform_profile" methods to use the newly defined
awcc_priv state container instead of global variables.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 39 +++++++++++++++--------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 8a21342cabd6..01414c2d9565 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -403,6 +403,12 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
+struct awcc_priv {
+	struct wmi_device *wdev;
+	struct platform_profile_handler pp_handler;
+	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+};
+
 struct alienfx_priv {
 	struct platform_device *pdev;
 	struct led_classdev global_led;
@@ -423,9 +429,6 @@ struct alienfx_platdata {
 	struct alienfx_ops ops;
 };
 
-static struct platform_profile_handler pp_handler;
-static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
-
 static u8 interface;
 static struct wmi_driver *preferred_wmi_driver;
 
@@ -1028,6 +1031,10 @@ static int thermal_profile_get(struct platform_profile_handler *pprof,
 static int thermal_profile_set(struct platform_profile_handler *pprof,
 			       enum platform_profile_option profile)
 {
+	struct awcc_priv *priv;
+
+	priv = container_of(pprof, struct awcc_priv, pp_handler);
+
 	if (quirks->gmode) {
 		u32 gmode_status;
 		int ret;
@@ -1048,11 +1055,12 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 		}
 	}
 
-	return wmax_thermal_control(supported_thermal_profiles[profile]);
+	return wmax_thermal_control(priv->supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(void)
+static int create_thermal_profile(struct wmi_device *wdev)
 {
+	struct awcc_priv *priv;
 	u32 out_data;
 	u8 sys_desc[4];
 	u32 first_mode;
@@ -1060,6 +1068,9 @@ static int create_thermal_profile(void)
 	enum platform_profile_option profile;
 	int ret;
 
+	priv = devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
+	dev_set_drvdata(&wdev->dev, priv);
+
 	ret = wmax_thermal_information(WMAX_OPERATION_SYS_DESCRIPTION,
 				       0, (u32 *) &sys_desc);
 	if (ret < 0)
@@ -1082,25 +1093,25 @@ static int create_thermal_profile(void)
 
 		mode = out_data & WMAX_THERMAL_MODE_MASK;
 		profile = wmax_mode_to_platform_profile[mode];
-		supported_thermal_profiles[profile] = out_data;
+		priv->supported_thermal_profiles[profile] = out_data;
 
-		set_bit(profile, pp_handler.choices);
+		set_bit(profile, priv->pp_handler.choices);
 	}
 
-	if (bitmap_empty(pp_handler.choices, PLATFORM_PROFILE_LAST))
+	if (bitmap_empty(priv->pp_handler.choices, PLATFORM_PROFILE_LAST))
 		return -ENODEV;
 
 	if (quirks->gmode) {
-		supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			WMAX_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, pp_handler.choices);
+		set_bit(PLATFORM_PROFILE_PERFORMANCE, priv->pp_handler.choices);
 	}
 
-	pp_handler.profile_get = thermal_profile_get;
-	pp_handler.profile_set = thermal_profile_set;
+	priv->pp_handler.profile_get = thermal_profile_get;
+	priv->pp_handler.profile_set = thermal_profile_set;
 
-	return platform_profile_register(&pp_handler);
+	return platform_profile_register(&priv->pp_handler);
 }
 
 static void remove_thermal_profile(void)
@@ -1304,7 +1315,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 	};
 
 	if (quirks->thermal)
-		ret = create_thermal_profile();
+		ret = create_thermal_profile(wdev);
 	else if (quirks->num_zones > 0)
 		ret = alienfx_wmi_init(&pdata);
 
-- 
2.47.1


