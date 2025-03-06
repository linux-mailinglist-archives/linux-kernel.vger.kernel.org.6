Return-Path: <linux-kernel+bounces-548068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B3FA53F77
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBC13A9016
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224911474A9;
	Thu,  6 Mar 2025 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEZ+FCtG"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED07113D509;
	Thu,  6 Mar 2025 00:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222693; cv=none; b=MxNn+ooi1Qi9xq+TdfRWo+zXhzBUcR1ZIGJryqDA2Kmfg++VcoH5hFUwOw4F1q0ePPLIJ4VflL8B7fV+E0/HtgGtPCKU8ZgraBF8D36iz/NpsxEMns4YL8TKlwUZCs3VVkxzWV9IbPGowhL3qR3jn0FkL/h7GD3DVNT9Ugn3zOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222693; c=relaxed/simple;
	bh=8U4ihaIIp3NI7j6SGITav4hp8DoUwXulxF0G7jdyFEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qM6at5rmHtD+ZiLpt5CwW5TogdyA90Srvcnc4iBuSlZROqcn41VzNrkJZ3B0LPEbZ++YoxerZVxWUZSTKKeRUCq9Yv0xndiJ5hkO20bsmslDz+XADaFLaiO1XcdvWZh4Xhskq50wc4WJ8bi7nI2YrvSkwjb+Nk2oVRVf4CCuy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEZ+FCtG; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso46685e0c.1;
        Wed, 05 Mar 2025 16:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222691; x=1741827491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqj+xl520LWWbYcDKIbFTGCJcSVK9Yty0PIVI9ICJGo=;
        b=VEZ+FCtG9an3Hz7YPdCFoWrPXnfJPT4Hf16MI59TVPWHYIh8Y2L0Aevtminy0o73Lk
         f+i9iiGVYDjD4q2pvtvdA/YigpjoaAJs3XKx6uuqzjeVMAJzquRgkuIKUlnDjL9ekVCs
         GvQ67TgWF0hFFuGVGR2Y6T/EOl2AREtM0kYyi3vjrSiro3r2bI/5k+VkLA/s6dszcsiQ
         BwiCNCFj3BZt3X/IBCe84G+eQOe5+WhFz8dyLfFWdQl7tDtVjcac8j32izDxOIHRr5U8
         cSlAFl65jZHGtkFfs3gidesWFQ6bvQXRWGbvPqC8PiLlNai1V9uyoiRSE2JKr+IjRrPZ
         na9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222691; x=1741827491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqj+xl520LWWbYcDKIbFTGCJcSVK9Yty0PIVI9ICJGo=;
        b=l1iylzos75f2CoAnq8MPSzJSEndWgBBi4y9E+ICbe1UHuAzCLaaPvwn/BxSAvcAB8e
         Zg0PbxxYIhKbQNtX39xRm2ERrmUYl3vqTa5nGoq+D49yKfhiZgWvV7WGLtTjNMc7e3Lb
         yUduiFJczTnYjUC9eELu6K0CRG4q2ev3P1I4fmFU3X84vgUokYJv5s5yml1SPvBF3Es1
         JsBInoKegiHk2BdGnPqlafpkAgB1OjxlfyeSzL0KJUyEDTkTAmcWLue2hguqTJXS/5Ys
         QA0BEQZtb4TUrFYK+p/sf/URxMofUI6aTb+Fyw6cvmEaOAe7qZw5DjkTyzSkGqaZJEr/
         eahw==
X-Forwarded-Encrypted: i=1; AJvYcCUoNJ3s5kG3IUpYDowx8qAZ9wuFb8Jm9TFwskysuF5BvAC1yHks+pTsyDW4U7PVj1mO063kE/VOgZgnIJE=@vger.kernel.org, AJvYcCVeazOy8xymLAwOE/EZ9SPIMZpDuw9JwAeMRoSwG/9Y63I4GiqDAHfBtG3ebFFEXQ0q2CkGqhXAn76VjsAfLSKFwstV1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLsE1J0ubjVAdWBC8n67/WsvUEX1ESbHmHX43MZxKDziL9Odrs
	3cRSzk8K9Ks6wT9Xlcl/T2Z6bzqiBHh6MFuIeVtcrgV4B5KDkg0YhHG/4f+GG+E=
X-Gm-Gg: ASbGnct2W4tYJC7+gDYGEiUhxwPoOvvf7hqTj3mH506xn1YV8m+WcbzSSuZikWfFqYb
	Cag5mNwwAwfSDm83zYjBQZy9yrPDsLQlsNeUtifIUBEZIRbQd643RNxrkvlAv5HY+xAoBZGX2Qe
	cvf/iH1lwaFCZi1eMCTKgIB7gCiAySWKPkzbyIKTQEjWgSRq0N3v/BdCvlxSwB8UNwLxMpPCBq/
	DTPZBurzg83ZY1J7q0A7+D/2dvqAyjkySZdiWmD6/Gy9dQ0c/Gsl14db+Vj2DIwl4DzDp5MzPS7
	YNmPYsiVfjucMu+imQ3T4J//viNbUYyHaPD/QbA02lpzew==
X-Google-Smtp-Source: AGHT+IHKmZT8j/BZaNfmNR280fp/6acUEQbafFFWYqVE0FwYpqVYB08th8svfdT07cOFjvFKSS2K5Q==
X-Received: by 2002:a05:6102:41a2:b0:4c1:9cb2:8389 with SMTP id ada2fe7eead31-4c2e27661f5mr4328594137.2.1741222690773;
        Wed, 05 Mar 2025 16:58:10 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:09 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:55 -0500
Subject: [PATCH v3 04/10] platform/x86: alienware-wmi-wmax: Modify
 supported_thermal_profiles[]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250305-hwm-v3-4-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Rename supported_thermal_profiles[] -> supported_profiles[] and change
it's type to u8 because it stores AWCC thermal IDs.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index a43373717bd4580e8f62a7263e67664630165e28..8e91fb4b349b7b62b6f914ac68d5eb1cd30a606e 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -213,7 +213,7 @@ struct wmax_u32_args {
 struct awcc_priv {
 	struct wmi_device *wdev;
 	struct device *ppdev;
-	enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+	u8 supported_profiles[PLATFORM_PROFILE_LAST];
 };
 
 static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
@@ -628,8 +628,7 @@ static int awcc_platform_profile_set(struct device *dev,
 		}
 	}
 
-	return awcc_op_activate_profile(priv->wdev,
-					priv->supported_thermal_profiles[profile]);
+	return awcc_op_activate_profile(priv->wdev, priv->supported_profiles[profile]);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -665,7 +664,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = id;
+		priv->supported_profiles[profile] = id;
 
 		set_bit(profile, choices);
 	}
@@ -674,7 +673,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		return -ENODEV;
 
 	if (awcc->gmode) {
-		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);

-- 
2.48.1


