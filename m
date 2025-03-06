Return-Path: <linux-kernel+bounces-548066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36287A53F73
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5970218936E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE492E40B;
	Thu,  6 Mar 2025 00:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jghDMRvF"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28D078F5F;
	Thu,  6 Mar 2025 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222689; cv=none; b=r1IBQdLOAov4kGL+ISUvHSp0cEw1sMOmJl6JEk8HZF0jbRbrFhdGTuNEJeYYYNpU9VGYeRpcOaLqvvCLWGZ50dAjL1DkrX3ZvVftteF8Fr/5PSEu84dxiXAiUwypNcH+NH9Iuw+1Qcv1yg8Y/Gp+q7ceoeEuE3IyiRkIgkkCso8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222689; c=relaxed/simple;
	bh=b6I4LW2lXRr4zSKyCgVo5hQkgsNPWVdZQx2aOlTduKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFhfzqnhmSAcVJgCeMqeB6ikp81uoYsOw2hBxnA81K9seCu3RQxHZYwNTCBjyu10P5kCqczxwbaWR5HWKUsy1Gp+C7ip1uhW0HwP9S76csX3n8yl7ufAPWsmog4gaRocnb1QZFrYobV8sKSh6bkQtrWa94lYCOJmZCbVnwOPPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jghDMRvF; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-866e8ca2e07so26286241.2;
        Wed, 05 Mar 2025 16:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222686; x=1741827486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki8JJlqvtQ1DWozBXa70s7Vleuhvzvt2Tgc/aHkAO4s=;
        b=jghDMRvFyL2uJC1VyJWvIyAhKDNh1aNd1WcJWEgFWXryOCwxBfMaP1T0ILiClNk2f6
         MxAICMJmWrGtyzuuPu7JjM/cAKhZzX2uXqEGq1v4TVwJd5GsnadlmXjUnV8+PQ2wnUJd
         YJ0vesUd3VOk6rFvrMJAAhkmOkDHEz8IgCNXJn/jjBX+XoFqkatrSZNgXJphpvQM7FlO
         Ec4zyMLbegUZgqtGmyOKuY1tX3MeIaG1Dnr/9C2uEGCf9UpeR25KWZBRZdk7m8CJNuFs
         uhcQ1ax7aaPYhphLy0DcfK0MgO4qSiyiUGoJuy4H23/uGLSBlEXh7LyAFitjPluYTLG9
         25hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222686; x=1741827486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki8JJlqvtQ1DWozBXa70s7Vleuhvzvt2Tgc/aHkAO4s=;
        b=aHTw3kdz1mGVscIk9QplOCriR/LkXO0jbidyMXLUmmzsATv/GbGtnkzaksSbpK0+kk
         0nJhoc9EZqiFCMjdafESEK6+5jzAjPr5cG7eftwC+M9CF45aR2uQBcPWrWluYBOBop9X
         m8QqN/vkIjjGPv1nFp1FjY1hITaB3oYtrrXkzSkWifmbxVsibfNCbgg5DMrdpeYFiv0o
         Qp5fL6MEqXskW090vHCp6WUsUHiK/8c3dtmlbECEzpL/gLyXTAZFHXvrSHRznE83X+Kc
         1wqs0qk/d7jcPt40M6OPmfy0ohTWg+zHKtUIrM8+NBBZS9oGb3Nc6/V2YDNehHZFboZV
         hrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5WTyzDvxJ729fFiqKYP60LrBm5UzFpuUNDClEFzPh7TpmavXT0o81n0MdeXOIO/SNgvESWdihqUs5qsc=@vger.kernel.org, AJvYcCWWDLfSiPafYxh7hpsWjHKq8agyHV+3xpRnOEpmlVZgE4QuLBn2f4B7GAC3SnZ7tMXClW3EBhhgaps2VS5VqglNd00yGA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9rJdde5SxNCI/nnpmFJr4g3O5iAngWNNlGNpso2wcavwfekYZ
	yjzRvD5YonhfBHZJoL4TTL/l2QBiSjIogpyQutT4eiPJJrVzY8kv
X-Gm-Gg: ASbGnctbtzyCHYC81/RPFVrIldrLZ1EmX1vREPdKxB8FcImx07d2kTcCTLWTw8XpeaU
	h/PzJtRf2ySCBEqEy2Ivwtg+2pU6ZdCEC002q0otxd5V3f1P7nSGivLeDwek7ccgHFAG2Nf9DTv
	ZY8IMnfQyd/jGeOyhpvfjPRYzH72n7gtBC3yUvnsDu36dUlTP+IZs/m1uflKv5REQRuuL+vplNm
	0t1D9GAQRSkbu5rBp0NzhZyaNhQ2Fa663GZtwWcLdfgAwBqSpdtaO1nG1yOtrOVTFuftOoSu29e
	lUY6g7lbemiAOvKDcixa9/OFPYpOENz3Dl9uzDKPiFEX0Q==
X-Google-Smtp-Source: AGHT+IGYJ2Kwm94NxvxLE3z8rOGG4vI0Idfd8cmaBbsHi4SYa421/zLC3APTGFGjeMZkyPoZcoO/Eg==
X-Received: by 2002:a05:6102:808f:b0:4bd:3924:44c3 with SMTP id ada2fe7eead31-4c2e276730bmr3270170137.6.1741222686492;
        Wed, 05 Mar 2025 16:58:06 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:05 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:53 -0500
Subject: [PATCH v3 02/10] platform/x86: alienware-wmi-wmax: Refactor
 is_awcc_thermal_mode()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-2-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
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


