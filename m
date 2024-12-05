Return-Path: <linux-kernel+bounces-432459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4199E4B74
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AE71880680
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C964C10940;
	Thu,  5 Dec 2024 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSTVPd8u"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1610A1E;
	Thu,  5 Dec 2024 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359606; cv=none; b=uphK+CZ0yMAM3l+XywrchFaPfd5TdAvkJNh+E6O0W1pWXQKouwwNFNvPCktD4Q1fmxjA/vztZv0+nEBB5Ts9y3EvTpYo6Lt0Zb/pHR8noV+w+qewjmkBEbNy52aT+HyyP9xs4NwlPEF8iFmFd+wHGB5PougtY5AF13fhTnpIlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359606; c=relaxed/simple;
	bh=NJBgxwX6kHzsleaKix8Xk7k7cQDHK5DP84r6FYtxM8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvbAYZzcsWlbxKNcMJs8Ef110qZjTpA336YWEVrH7RmB4tZX9KH5KeukIrjIm5l/o8mG48WKRaMs8lgENHEcU6/OWAaYDlbuwbdH0nYdu9ilfPsxwDnTUamNybTMDxlR6Y6voGJUJ1NUETsv4y1i34i2RpfU7Lej0GlCOzEBCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSTVPd8u; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215909152c5so3597865ad.3;
        Wed, 04 Dec 2024 16:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359602; x=1733964402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUNeDm7WDpiz0NiIzWMQfhnjPASdA8TVm4SvvGDMhRo=;
        b=mSTVPd8uhBY0LBa974fpibslk41Cqo8I4xaJjgq4li/YdabJlLFNuP/x89z8MSyerE
         iu8io8De/ELN3KKJBtEJZndhaeHbdf8XF3rB4UVTAyK4pLbzWD8P2vRJkXgIEuA6CqYB
         dkSnEi3GIOju5MdBdB89vjw5NBJ1LJ+YkoPmmJZHvu/YnWRS7Xz7+8KF5oixsmjHvwVz
         0GwxKhV+evF4i3TxsGI19ySMq6Igt0LB5LLmLaT1lqswPfgMPlvB31q1HNPzg/vEkh0c
         gPTWtZWNzgBV5ImtOz2Y0y2Smv/3a19hDVjcUyxWaeBWfjRBdOg5eo2SXNB5WoCfhqXz
         uy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359602; x=1733964402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PUNeDm7WDpiz0NiIzWMQfhnjPASdA8TVm4SvvGDMhRo=;
        b=oyfWeTo3Hs51VYH2JmwFtWGaTEJpk1OhZhGKVRPoT7dt6kdaOMKYHoZIwCoTfBvDmQ
         89xVT26NKBQ2NDusFg4vklzt1UjNn6nS3zflpfrq5Wk2mKVmaBXzMbrKn/t+IEm9jtoJ
         qvZh5KVBEy4JTejc/Z3BL/dtdys2eoDW4K9sdAmB23xdLomSwzsGdxEn2jqY93jwnIAR
         PlETitd3ijj9WeIk/oqDDgn6Q4TqWecxzDef9tDo8O7yPG9QOX1iutlK16DdRKxbXX1D
         g+z1Xcdf5aNXlghbVVikr3qbdCk7RPgPN6ax8wNUTgtZ50XcF1Qv+B0ecRj1KJ19ENZI
         jLTA==
X-Forwarded-Encrypted: i=1; AJvYcCWFCqdaaJxwqYy33Cnz4ZAx0+qnRT2E3a+9tnrlBGtqbuad5uIy0xiG54selg/H6iwh/Rhw9PuxGszs1m01GjPMobf/yA==@vger.kernel.org, AJvYcCX2RcEdgiiwFOVXoEChaa3tdp+ugUc4UrPzY4KqXdiv1jNezopkTDkAdDhxZ8mUFpgtMD6m+WPzW5jZdWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4debB6SZOB71u5/nihi2OI18K6fxuVrtjx35NwO9VpEZO7mQe
	B+vaKnhXA12hq8+U1xMYDJtyBBvdU3kjiy6Ymqo6vG0FSeouGrpU
X-Gm-Gg: ASbGncurpVgPQL9WpEutbIIXjR4r6mLMz723JOB0R65mEGOZqTksMvHY/TIfwOH6tJn
	Nz4DUPrT1ww0QfSxudjSwHiPXUuKRIKpG0CwDLsOP9r4kqz2FHQZ9SukNZKyRQ/9KyZpsw4u/12
	9maOceSiY0nZmqgLhkcLM1ARFX14H2HwK3VrAVsiAza3uUIuESRlF7/nWcATuzqoOrAbDZt+Nsv
	VkUbMnMsAslc4ysTrynngnUR/Xc+U0DvGHmZrgHS4F4FGuT9M2UH79uDtmsDKq6/UGNmBtf85cx
	lydw2WG4i0Xi7Yei/I0=
X-Google-Smtp-Source: AGHT+IEtT6UDe6/SqOR1bfFKvAPs0m37cDfQxQSKzmH3C9x+u23vBfm6F8+GP4olzH2uT+UJfpSiug==
X-Received: by 2002:a17:902:c943:b0:215:8d29:af2d with SMTP id d9443c01a7336-215bd24b8e9mr139025605ad.38.1733359602633;
        Wed, 04 Dec 2024 16:46:42 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0a72bsm1368935ad.214.2024.12.04.16.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:46:42 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 17/21] alienware-wmi: Drop thermal methods dependency on quirks
Date: Wed,  4 Dec 2024 21:46:10 -0300
Message-ID: <20241205004609.2186681-2-kuurtb@gmail.com>
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

Make the `gmode` condition on AWCC WMI devices part of the device's
state container, and refactor "platform_profile" methods accordingly.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index fa21a50d66bd..7137995d5983 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -407,6 +407,7 @@ struct awcc_priv {
 	struct wmi_device *wdev;
 	struct platform_profile_handler pp_handler;
 	enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+	bool has_gmode;
 };
 
 struct alienfx_priv {
@@ -1044,7 +1045,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 
 	priv = container_of(pprof, struct awcc_priv, pp_handler);
 
-	if (quirks->gmode) {
+	if (priv->has_gmode) {
 		u32 gmode_status;
 		int ret;
 
@@ -1070,7 +1071,7 @@ static int thermal_profile_set(struct platform_profile_handler *pprof,
 				    priv->supported_thermal_profiles[profile]);
 }
 
-static int create_thermal_profile(struct wmi_device *wdev)
+static int create_thermal_profile(struct wmi_device *wdev, bool has_gmode)
 {
 	struct awcc_priv *priv;
 	u32 out_data;
@@ -1115,7 +1116,8 @@ static int create_thermal_profile(struct wmi_device *wdev)
 	if (bitmap_empty(priv->pp_handler.choices, PLATFORM_PROFILE_LAST))
 		return -ENODEV;
 
-	if (quirks->gmode) {
+	if (has_gmode) {
+		priv->has_gmode = true;
 		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			WMAX_THERMAL_MODE_GMODE;
 
@@ -1130,8 +1132,7 @@ static int create_thermal_profile(struct wmi_device *wdev)
 
 static void remove_thermal_profile(void)
 {
-	if (quirks->thermal)
-		platform_profile_remove();
+	platform_profile_remove();
 }
 
 /*
@@ -1339,7 +1340,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 	};
 
 	if (quirks->thermal)
-		ret = create_thermal_profile(wdev);
+		ret = create_thermal_profile(wdev, quirks->gmode);
 	else if (quirks->num_zones > 0)
 		ret = alienfx_wmi_init(&pdata);
 
-- 
2.47.1


