Return-Path: <linux-kernel+bounces-559698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF31FA5F847
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289F219C4949
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B499269803;
	Thu, 13 Mar 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBI8Yxpk"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C9268FDC;
	Thu, 13 Mar 2025 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876224; cv=none; b=Jk0lwG2+2Un69XAlaPGt+UoEkkyBA/AVCz9B6UapfWHRr+eMHhOkC1oXfeVv4UCdj5ZmJO/7Gih7OmGRSBLZE2noomcx9zsIYEW4SD/skDp5b2kBZMk7M94scvANp1bLocb3oZ0SVI1kDkqNWz/ZRBIFZFiZlauF5WmRIfTx9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876224; c=relaxed/simple;
	bh=cPKPG5Vxh6Z/Se8zjhuifeo9I8dN5wM+mN+9d222mtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBD7zbkAXKMMeS5sKaptpHop1p5GDEIRNLoI8zhwGRFQ48J3wIqFy59CU74bJepkoATFA0m51khFvBF4t/TtdmMFVP5wR13ogJomkDabARLRL6L+fcFCUdpjOtfbqoe+1DzubG5pZTYR1wMCQYTJeHTerTNKzecTA4Sw/E44rFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBI8Yxpk; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e549b0f8d57so1016117276.3;
        Thu, 13 Mar 2025 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876222; x=1742481022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJz42pw5OoHFXvVMA6liTx4M4GaMhFeDvsfN2Iym2Zk=;
        b=EBI8YxpkiO+azdMa9AadVVaoaNY7myGXO1ffSbcHPEnnAXk4yBJbK5gg6OIIDXJMVv
         mjasIlQSNxpJnctZifYy9B6hL52lmBoQHMsNxcv7s/tordGbYAks1ibzKcCvmPPtvJ8T
         YlSal4Y9I71JCa3dmH+yvT9oKLzrpl/BOh/FqG84Y37QaoN7zcPR0c4tSBogT9jAlJLG
         AJcRSmxqZOWU2ZUhzft4xYj5t7MnAZeZ9PfjogQkmf+HniTWOgBFfoX2xfTV020O5bWb
         H7H0eFzcPaGCkCQmbaJdCmm9AkPr0dCesbfo2u9W9P2FfoSxaOYYyV3+AbRFnlLHux61
         JdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876222; x=1742481022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJz42pw5OoHFXvVMA6liTx4M4GaMhFeDvsfN2Iym2Zk=;
        b=wCv8FEZoQahcpCkqkmB/zVx8BJIiIWXfETxPQ1lcOTXbvjJy7cpSqa9e5QgdkH2p93
         WU6D11k56nuEXCnhOQyUBNly2DnN6iM988SV1k2I7G/4jG071kLQ4SzxwQxnnXA0YOzf
         NLIehUKIrOgC7S5e1+FzcsB+eZfDaXr/AYrI+e2UvIRcPYNNeGFZuexgPcOVUUZwcJR5
         ioHeSbmfQPsxqjAyb+t2NTsgRayaUEz5/bnLUdxGXd0ZNQ70baeu2KmPtNOpBCmQ+Hh/
         5z3ria/TpMeRPpMnLjl7h2eDXvcBzTkUckzlpKYQzo90f99mp3Wh8t3SMZ4uVvXjooJq
         YK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNamyxyQ+hT1eHqzlXIMmX6STYeHtG01Ri7s24xVZ7GObbn2JMo2y5BQPX56/jXEyrRFZiNpyW75lNbsS9SaVAJvCFWA==@vger.kernel.org, AJvYcCXL2Oks6Dfnf2u7tvh2WO12Wp4MlZ8nnoPkrd+3+MrSCwaSDGqh3i3OzmZyiW4Pq4C4vlIrRw/CZXqLtpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2Il0asT54R0DM3zWPgCLwuj1eQf8W9RlysnGh5BKQKa4E25U
	QB4CWGjo4Pk61RaECYb7LWD10wNxHOXt4P+yZD7L4oo4i4UVOfeNSJ/Th8MX
X-Gm-Gg: ASbGnctEWqWnKL5PkWZk/nMKilmEc7ZAU1kwgzjfqKPNpRUFTQe3vTG661Btvzl1yCU
	06cpPK9ZkFzBAPKm69lLmocRFgPKsxikGCiPzBCUvkwvqHaC5hUBnSn2LzhkpXHhqG5TzsEYtXi
	gmSAVAie4rU+WQwddGUkFzs2hkfgIgGdpkbMD+aXhPaQDDr8kEpD5oDZRcx2puE2n5CxLzOK5Gg
	VtbqgoIhIzqi6dfNSoewPSj2zT0QnpgcsNi+X5s+JFOgCKD8rgwGDc4un5j09PRwWlAy8kOHEBs
	L3p0tWmYIPv8N7VZ0dXonPYF5pHLKaLlTkESFo3pFVGSwA==
X-Google-Smtp-Source: AGHT+IFdD7/NASvI+q+boLup6Uv9f/S3WpBzZOueGmFiLHw3B1Uf/oDFB2V/GQdA5nFYhRfEEzbItw==
X-Received: by 2002:a05:6902:2192:b0:e63:f0ac:4801 with SMTP id 3f1490d57ef6-e63f0ac4b9cmr1024421276.38.1741876221660;
        Thu, 13 Mar 2025 07:30:21 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:21 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:00 -0500
Subject: [PATCH v6 05/12] platform/x86: alienware-wmi-wmax: Improve
 platform profile probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-5-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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


