Return-Path: <linux-kernel+bounces-548069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED2A53F78
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEC21885E07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881B014F132;
	Thu,  6 Mar 2025 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJF2KBUZ"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA614831C;
	Thu,  6 Mar 2025 00:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222695; cv=none; b=Ec9kYFJG6O6GRSV+lhtFB3ZgghTuGNVCzWVq4Wc5bCHqQ6LvQg5eJlQAIpKklZTlGLQhzdVc36ARvTTYpoJXOwUUOq0ucJFaczTDSjtLsVcJld4c4Ez9sfLrjvr3tcLV3tTEVPdyBJRKkIxKHagyZTPLc7800hWqux1LZYyS0ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222695; c=relaxed/simple;
	bh=HSddJ4u2EeUmqQkj/4pdfLTCTeH+AqHJpKz+ERkQ4Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ks7RZ3+7LI2MK3zcl5Y2eCzuxrXy7OkgK9HR+wUcxmisqGtPUhS17WWSRfeSRzQ6Oy5pcPPLpsmX7DY/34VBzHGJUOrXDrDV55dWH+pkLBcJxMS/Qc9/6LtWvdZZyiabr95AZqyghe2GsaEQZUIsM3WjHsmMlhz0Uko7XC7qvcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJF2KBUZ; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86b7185d653so27777241.0;
        Wed, 05 Mar 2025 16:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222693; x=1741827493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lYu11Ks2/ykMetK4IPyEkkQITTjZX6WFAwoWnv7cViE=;
        b=VJF2KBUZ50dko1Y0/+wJ5ryFIS9c3V3H3BjbNgmI1AAyfbIXQ+N1DAtea52/iNmqX4
         sMLQDZEFiryeLo39vBSW5OXjfhI0G3edjeLtJPXlcgIYz+BuuD0jK8LcDSguJK5M1jqC
         zTfHE4fVew3AOFzihC5P3rqvvsWXHFy+whNRE6VrUb/tQcKCe/DaujybC/Jlb7C0UGnD
         IzenzzlPoX4j8BoAEhRvQWUQWdvAa2XmFSrhecPW3qM+GWP7sCUfSxfU3S1U6bIwZ/RF
         jOUJzcEfYsFA4a7jihI4jioU9L4JhR/HPrqRxfdqlzwER3lwSEO9PC8lSDhc+cKZTQNk
         bpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222693; x=1741827493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYu11Ks2/ykMetK4IPyEkkQITTjZX6WFAwoWnv7cViE=;
        b=m6pEJLJ7HvTzd9Tgz+YGmqSl0SzGIKmqgA7aS/clahMNfusx5fDoi6z3LXRcN4iQgq
         Q1WRd3RwvWUMWUZfn51gvgnHU+qhUJWjOqm9WCr1pphWazYYXNsYzAVI+6o4vrUyp/Ty
         QR55FSQl5f7aYbxlhUluqxq2iUDN7DjZ4/a+B0a7MzANRH6vMtm5+YQONPZeXzS18t9S
         mu10ziyzRCewW1kNtmGdYEdfKLMCr5APwKrMYldfc6OFPosk614qe9xLF4sHn+gtrkDA
         EfrgF9M5Wljmm7oxU6Tq7LV9ZRyzVgxk2xkOvx7Wzldl8x6oMIgz+qhO/GE1wyLhprny
         oKuw==
X-Forwarded-Encrypted: i=1; AJvYcCWkqCCofWHEKrvpw5UNqoXgG8uwB5rDwMVIcyCyVcF/Otzdnb5yS/403nuuOUWMZ8torjkSDf9J2rOjPFk=@vger.kernel.org, AJvYcCWuEFjBYJEtTpqfTghTEhhF98qzm/Dl9bOaRemrFTePQjO39OE3f5Ri3HCiEpQgE6xDNzL+KwXfg4AcY0lKYqf37b3lLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrKxcpCRhD61Th7Z2+uOgvnalHXHwG91x8/+j0jI8NoaGFmc/e
	JPXOhuinVFVk+2uKwAs10CFTaLL+nIuhj/tlxKG1tIt4pEZ6z6Hr
X-Gm-Gg: ASbGncu5c4NcH9FkPoWw5kV0QCGWpCYCkhePfMlq8BaBMi1st7VpFvf+rRlcYQgGWUf
	BrP7KKOnIkLoXg/NjU3jdTw+LuPaZK06bl+OauJyODC3QPrsu3unRKXoRJICaEyvHXu40Gw1QQD
	K2DUSxBwyqwrSSZEZML2COC8c13Qn8VMua1m6BCKEItFPVz/5AxLYu+LEBpzQ4lClO8fvkmkEr6
	yTz4JxP8DGLx3/g3iSUZEIbya2VRQU09uW044oP2eOQ2qkzyyMnXqcppV2M+nu4L07w+tLDCdl8
	6z5oLbnX+CqED5+YGiLih3cMANLU84ezj1MZPU1o8ypQ1g==
X-Google-Smtp-Source: AGHT+IEbbiQIJwuvicyFa+IN0N2du42kscWhhbufga27C0UdZpyPhCcD3M/cinnOmNG4zLBiETOR9A==
X-Received: by 2002:a05:6102:508f:b0:4bb:c527:aacd with SMTP id ada2fe7eead31-4c2e299a2d3mr3470947137.23.1741222693198;
        Wed, 05 Mar 2025 16:58:13 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:12 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:56 -0500
Subject: [PATCH v3 05/10] platform/x86: alienware-wmi-wmax: Improve
 platform profile probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-5-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Get and store the AWCC system description in alienware_awcc_setup()
instead of awcc_platform_profile_probe() and add a check for integer
overflows to avoid misbehaviors.

While at it, replace set_bit() with it's non-atomic version __set_bit()
because `choices` belong to this thread only.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 61 +++++++++++++++++++-------
 1 file changed, 46 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 8e91fb4b349b7b62b6f914ac68d5eb1cd30a606e..a89fac80fa9e819e042f3807eb69dc8ddd9a4841 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -38,6 +38,9 @@
 /* Some IDs have a BIT(8) flag that we ignore */
 #define AWCC_RESOURCE_ID_MASK			GENMASK(7, 0)
 
+/* Arbitrary limit based on supported models */
+#define AWCC_MAX_RES_COUNT			16
+
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
 MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
@@ -212,6 +215,17 @@ struct wmax_u32_args {
 
 struct awcc_priv {
 	struct wmi_device *wdev;
+	union {
+		u32 system_description;
+		struct {
+			u8 fan_count;
+			u8 temp_count;
+			u8 unknown_count;
+			u8 profile_count;
+		};
+		u8 res_count[4];
+	};
+
 	struct device *ppdev;
 	u8 supported_profiles[PLATFORM_PROFILE_LAST];
 };
@@ -636,37 +650,40 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 	enum platform_profile_option profile;
 	struct awcc_priv *priv = drvdata;
 	enum awcc_thermal_profile mode;
-	u8 sys_desc[4];
-	u32 first_mode;
+	u8 id, offset = 0;
 	u32 out_data;
 	int ret;
-	u8 id;
 
-	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
-				       0, (u32 *) &sys_desc);
-	if (ret < 0)
-		return ret;
-
-	first_mode = sys_desc[0] + sys_desc[1];
-
-	for (u32 i = 0; i < sys_desc[3]; i++) {
-		ret = awcc_op_get_resource_id(priv->wdev, i + first_mode, &out_data);
+	/*
+	 * Thermal profile IDs are listed last at offset
+	 *	fan_count + temp_count + unknown_count
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count) - 1; i++)
+		offset += priv->res_count[i];
 
+	for (unsigned int i = 0; i < priv->profile_count; i++) {
+		ret = awcc_op_get_resource_id(priv->wdev, i + offset, &out_data);
 		if (ret == -EIO)
 			return ret;
 
+		/*
+		 * Some devices report an incorrect number of thermal profiles
+		 * so the resource ID list may end prematurely
+		 */
 		if (ret == -EBADRQC)
 			break;
 
 		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, out_data);
-		if (!is_awcc_thermal_profile_id(id))
+		if (!is_awcc_thermal_profile_id(id)) {
+			dev_dbg(&priv->wdev->dev, "Unmapped thermal profile ID 0x%02x\n", id);
 			continue;
+		}
 
 		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
 		priv->supported_profiles[profile] = id;
 
-		set_bit(profile, choices);
+		__set_bit(profile, choices);
 	}
 
 	if (bitmap_empty(choices, PLATFORM_PROFILE_LAST))
@@ -676,7 +693,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
 	return 0;
@@ -707,6 +724,20 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
 	if (!priv)
 		return -ENOMEM;
 
+	ret = awcc_thermal_information(wdev, AWCC_OP_GET_SYSTEM_DESCRIPTION,
+				       0, &priv->system_description);
+	if (ret < 0)
+		return ret;
+
+	/* Sanity check */
+	for (unsigned int i = 0; i < ARRAY_SIZE(priv->res_count); i++) {
+		if (priv->res_count[i] > AWCC_MAX_RES_COUNT) {
+			dev_err(&wdev->dev, "Malformed system description: 0x%08x\n",
+				priv->system_description);
+			return -ENXIO;
+		}
+	}
+
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 

-- 
2.48.1


