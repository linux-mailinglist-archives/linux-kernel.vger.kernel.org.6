Return-Path: <linux-kernel+bounces-532626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807FBA45008
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F5B18950EE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A314D21D3D2;
	Tue, 25 Feb 2025 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXSZopGw"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABC121B9C8;
	Tue, 25 Feb 2025 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522324; cv=none; b=HfuKMZxk9bmAQ7hUkex0t9dVyHraIZAqAWlr8lG7DaAuwgIVwZ+kyk3c9UtRSlpqVO7gyg7PiUJjksJF77buIzegv9awMj39xydUALuEBpgVjNapZXgv4zp1W+Bmqa5P0OJi1mfVIwmPonhkk9oq/gh1LJWZQ6ALfZWQkKmArLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522324; c=relaxed/simple;
	bh=jY2SGVCgrNBhQUg7x35oBl8V0TTD1k/yXqx1d/A08ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qbt6+CT23Lj0RiIDIh2sfZC1TPrBV26BbsxfsY3oK7YKFUuvASwM2DBnRS6hAPJcf9AJJEjE+CtsoLTPl8Eabkehg7zdPLkAAVENvufAyC3LvNGsoqPYnVMh1J0bNUdtUARMlbb9rYQFiURHvuQ7cfoP6AKiQnOnC0BNTud/dow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXSZopGw; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e5dd164ee34so5654232276.2;
        Tue, 25 Feb 2025 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522321; x=1741127121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ngqJYv9awp2JsLWCM6W7g9eJMrp9NEn4ebDw819xeHE=;
        b=XXSZopGwTfgSPl/mgOzyPOfrM3zfRn0avBE2KgCyGsCsD+scKzAwPEa6InPwLNNtI+
         rAC46WdHkmt0MxLLfT4C4ZDwpH4ecFC7uzIzaiAhLYaruQkw3y1rZjW6D+VNLfOLd8Z3
         8ETjfMFvAjNgBr1XQ7piYfWxKgBzFbAUp7KkI7Q8gsfnz6NlSw97BkIU7txm51ejwHjA
         r5uTA3xA3pBM2AiyW4V+J6taZtvuBbCzlf/ytBGUCgrGu88ljEVA7w8+ympMgHJ0Hsed
         o2r7ezTOOEjO2qTXga6IBCubCLR3sDp+VYMhcJargrIY3Jy17n3Ie6AeWwGj3kv/wqPA
         vibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522321; x=1741127121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngqJYv9awp2JsLWCM6W7g9eJMrp9NEn4ebDw819xeHE=;
        b=MAO8HCxqBuauP/Q+fYG/WwsNixpaToMZTWesMHc3e9vTgYO5iMpvZLnNnIMb8AKLOJ
         +0gFc7qEEOaZi9BW4LW/sN6wlpPXRWUUswpE11Y1y1NAS8hEOqMN5nFDjxTPD1h98msn
         qpz8RffUuJjHJ4/IujYSF+A2q0TRaYQwl/HB+wqVps6YKuxFHC/KD+aWbd1GPxmqk6qi
         knAODkuBCQc4I/fE9qdqLzCBd2INyZ5jOd5DptwhsjaW7XFXvCKxd1YCyzlHpfikBXC8
         c+0U/aWWLzT2Tp92i1VpspyRg+cmqf64W0Ihj2SM2dMnj9qBdo56ci2hliGEnHB2Gboy
         7j+g==
X-Forwarded-Encrypted: i=1; AJvYcCVuoSGhDmzbt0qeAHwvLn8mjnMFecplUjCZ5JvjjvU8lrw8hhFitIJLOnwN4FwjhI+I8PCy6b5J4sooc18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHCCIk5GlcQO5We2A90HLg6Lblhz9atY4651gjQr7+B45qF8+
	XfQJuNVh/dZVD6PxvyItq/qd28lB2HXczK6thKH8+BCUguJDiw7AlsZG3sxE
X-Gm-Gg: ASbGncu2aQYkgU4nXTj1lt1AWZK6SkHU5Ktp/a6q5NnTJCPA3JYCGRjM1xqnt8m8asW
	8ucOWIjyabxzcrFN38tl9RH/CpW7r4A6jMIyDtEJ3MGhpkSEtZy0Iuf28tR6TylySRkDxNibv18
	dFxSY53Wf/yJQby3+koV8Utp+ZhArsIpuLaS37+cUh0PJyS1sFO/QyEJBSO58gq3K14vULwEfs8
	8ztQIsLxTjdnW7CVOGeccKvF0hjwdesLAdfDXkBuay6VzTcS81rcZ/3PHeGrhap3+XWG4g9xaYI
	93lRZL6ca++OC/x1bvulJ5cc1L9woJvNEw==
X-Google-Smtp-Source: AGHT+IGYOij5ZuQoY9KfrwWS0qxEZXFcfmgWdkuM6+jvBTjVH63lAJruoejb5Vqv9Y92DF9MBRXHUA==
X-Received: by 2002:a05:6902:2085:b0:e5b:171c:35ee with SMTP id 3f1490d57ef6-e5e8b0726d8mr14067487276.48.1740522321321;
        Tue, 25 Feb 2025 14:25:21 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:21 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 06/10] platform/x86: alienware-wmi-wmax: Add support for the "custom" thermal profile
Date: Tue, 25 Feb 2025 17:24:56 -0500
Message-ID: <20250225222500.23535-7-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225222500.23535-1-kuurtb@gmail.com>
References: <20250225222500.23535-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All models with the "AWCC" WMAX device support a "custom" thermal
profile. In some models this profile signals user-space that the user
wants to manually control the fans, which are always unlocked. In other
models it actually unlocks manual fan control.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 23 +++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 965b427f8f0a..bbe87f91fcb6 100644
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
@@ -176,6 +174,11 @@ enum AWCC_THERMAL_TABLES {
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
@@ -578,9 +581,15 @@ static int awcc_platform_profile_get(struct device *dev,
 	if (ret < 0)
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
@@ -670,11 +679,17 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
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


