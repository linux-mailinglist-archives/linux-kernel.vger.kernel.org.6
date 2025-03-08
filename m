Return-Path: <linux-kernel+bounces-552786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8602A57E15
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4046816E415
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A4B214208;
	Sat,  8 Mar 2025 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eoNIqtVZ"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C652135BB;
	Sat,  8 Mar 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465438; cv=none; b=XLAtWVtd0blRdD/MBjnTlmWCOZ/X+JDLMn8684B/PX8zNSTBHL0F/udtBkDWbkfuEpZRL9qhS9HAwjgQ2MdvsOzKkcD2mEiwEegEHl8+r9hSzHwVIgvWLZl+eASSXdGHyuOvQiGuQHMmSfbkNrb9KYa09bnmM8Un7ClYn53xoIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465438; c=relaxed/simple;
	bh=cPKPG5Vxh6Z/Se8zjhuifeo9I8dN5wM+mN+9d222mtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=av4FtE7CTxZK85Iq2EYl90MF8nE1bG1M9L+BKJjlEDsw1vHrnA/2wrwuENANnBh/ECCnzDzMHKxZMghFcYDNXBcucw0iHyEOn5D78f7ifVinj0Q4RVFnsU++dA1z+DL5ZwLJyR2PFWthlZ0d3fl+QZ1vuOW1y+cPcyJmHZKQ5zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eoNIqtVZ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8671d8a9c3eso2312473241.3;
        Sat, 08 Mar 2025 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465435; x=1742070235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJz42pw5OoHFXvVMA6liTx4M4GaMhFeDvsfN2Iym2Zk=;
        b=eoNIqtVZ9w5w4LY3gyEjOqfGvRfXhvj91CDmLGW1t82vf0uyqYeHgBLcxuQxhVuxze
         4LGyFSmgPuWa+M9G3nbboSjhLebf1dgz3Xt2EiBa0nKOUM/YGToweeKvhNK96cPBcNcZ
         58XedQd11UAGzOEQNRZ5h1Z5FHlsiXF4hcYHWQ9djPlQg7FcRuAC+1wYLSIr9GggpaK4
         12me1+Vh/Wpq6dBc/EYJ+72O4VlNG49vJQw6p68ZcsyDDnZGvKr22bkhblrziWgxz2MF
         qH7oB/ifumKvSRX8ohQmxEeRqYy3cZSR3eVR5IjcdNzbhbW9bJKG4KJHy1J+GfM0YaIC
         SQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465435; x=1742070235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJz42pw5OoHFXvVMA6liTx4M4GaMhFeDvsfN2Iym2Zk=;
        b=SKMNkPQHiW9sVVd3yFIcKEEPwJomFH5TyQ4PHKaYo+rYsIOiw3yv7s9cSsGUJHqkxQ
         JD4QXfNW/wl0JQ/vpAaKEyPDP9YgMn9xkKP1NZqcAJloQanpKsljtKkO2CiuZ+SegvUt
         ggkg5QOiCLSDgsPPPxEeEPTV4XzU4cFX2CAZNlaaqA+6P3lJNwECvodEYQUrWZKtWFq+
         uW4Sg/l54p9obqBKZJjDx5q6hulzPSQFjsk2lsHhqLj0KZ+NEJOrrJxfnD7sW7ylr3PC
         SXVYM+BqbHrkhth0pfHWBjs9iJIA+Wv9c9xvcWQh+iGxX0OtJCMKWaFoeIhDb4xFACCL
         jfew==
X-Forwarded-Encrypted: i=1; AJvYcCUVwrrhVadUfBrJVEM/0WnM5drvX9jqtm1aVrXMHEvQQuQdy6mpXYxfVjPIiEGJuOUgMllB3ukkn0qFv/o=@vger.kernel.org, AJvYcCXMVTQNEu0NQtawo+sPmbEAiFmu2dxCY0lJS/GxjdXuOfLz3SGPWaB0l3aefRePPRKlKi4kvPPvmzonLbxIvvoOST95/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhlo5B8jVivtFaIXFldxuYRVjXdKk7nJamecezOeCbfU5dAcJ
	fUuNSEBXAWVnHgcOEPlOf4bm0ylL6/s+mYj1vO/JEL/y+iqWdWQhYffB17QP
X-Gm-Gg: ASbGncu8A2mivDZNnVIZBIFpZiGBIWp4ML9cc3YkC82VoDAAqqv4Y3xCJ9KXn229+2B
	n6jv/DZ7YCTqmYEmsUufpIOyjnxw+VK9RbXOX7/wzd5N7lYdm5o8Ll4Vr9qjJtOu7YPW4U6h3UX
	ucTfLw83Xuei8cOzVzpiuGeNDkPLYw3FRLsxJotZ45V22BdMOjqby5u/ASQsZ4kgMXnLf/HEbYl
	WDKfWY3hOpIgMpqv/8hycpm3syHtoc3tc1XZB1GJWGEacqyp9tCEQNtSen+tB3I9MQ5YX8NIrfT
	SWn8tnCpGCr8q7apLz+XIgGz0DXpw1RtMvC0fBKZyvzMHw==
X-Google-Smtp-Source: AGHT+IHZuh0N2XkhCgZMU1UGiMB84tDZK0ElCpb1rVEIzVIXgCs3xyzgH2LpYHaBdEDSKocxNgncjw==
X-Received: by 2002:a05:6102:cd3:b0:4c1:7c38:135 with SMTP id ada2fe7eead31-4c30a367a82mr6117823137.0.1741465435055;
        Sat, 08 Mar 2025 12:23:55 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:23:54 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:17 -0500
Subject: [PATCH v4 05/12] platform/x86: alienware-wmi-wmax: Improve
 platform profile probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-5-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
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
index a8a13779793abbcc8d1263474cac6227d524a6f5..0530f25b956f73f47c0354f40dac2910448c894e 100644
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
@@ -624,37 +638,40 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
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
@@ -664,7 +681,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
-		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
+		__set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
 	}
 
 	return 0;
@@ -695,6 +712,20 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
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


