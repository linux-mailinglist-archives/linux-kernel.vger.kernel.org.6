Return-Path: <linux-kernel+bounces-552787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B4A57E17
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D045316AFE5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92964214819;
	Sat,  8 Mar 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7NnTdys"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560AC213E8D;
	Sat,  8 Mar 2025 20:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465439; cv=none; b=u7s/3HhbDG+PyF1lpkq5xaKHeC5E1OoirIVt5hw727eu/bU/PbREZlv0vhKojl6tFjnWdoKb8O/c1MRucUhMj1Kwv5YKfOX92GSZtKrJPgnVm3elfekd3EgIUAbBmyRDCsKWwNJPtyO+LNxXe99MJdsHeTOAkVLFVebGkS3cj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465439; c=relaxed/simple;
	bh=/RVTDk95xTdgwIURpxctNMV56eIngqQ4/eX5yRQzsK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZAGx7In4RpYN9ZszKstzHFV3m49E5IxOzfYy/7ue+RwhR+S68ruuRPIS03UQTAzGs34tLKHtXPIlDnGsW7kifvt3pDipszJ3QsuzIU/a02XdbDrCKQs964Pbu2AeC6LEtCTeUgX312l0dyHnr3/DhcfPPwEgfxg5oBXWmpq14nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7NnTdys; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so2768924241.0;
        Sat, 08 Mar 2025 12:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465437; x=1742070237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H43dqBGhipBxPHVP+jwxsicROhpGVr1mHnd5dBnGOsU=;
        b=K7NnTdysudkBMfzkKv6KYC6yNbAxtOj4sEaQYoRYlMBtsjQFleXjHs5G6Lk7R1qIv9
         2tHjN7CgjO/lE+ajr9YHdUykS2Jvy5LHOmeqXc/M9o0K2TRWaP3+sCWxXuH7iCVSfoSG
         BTCZXviI1GJW2PcbKtXbt70WhWj88Mo06iUGGz2fVd8Gz1mCIujpjETKjm702YjKj8Re
         +GfHfIWGGxwls6x4OxqQJDX5KXtROWq2osBENjXcmv94krk3cKiOgjh37a9x2IImra4k
         BimGXkTTLDX7qc/8FP7OGfJS+/239yrxaAv4Le6P7vgd5OvyIfeZUl/Z4Y7CpxR1DHcK
         ZnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465437; x=1742070237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H43dqBGhipBxPHVP+jwxsicROhpGVr1mHnd5dBnGOsU=;
        b=lwGyWDC0iGV1cXa35qviaO9S7oXT5gFd5dStF/sYPQ9LeI3o2/wT7Jj+lb6mOa3fc3
         oXjpWiXiGdpakuK9KrDkqKyUSiGwS46kIKPyqiXDJCaccqvkw4OXUbPeutnGQfugSbcb
         lTBAMUZklPFWFc2wiathb8cGwUdcBRH2p7BGFem3b2Ft59sGRNdrs+t1o8W6Q+8vX9+K
         m1NlZmjC+x0e9aRHKQMZdG8mPZTuPJ/10ClqSxoUhLnfvAYgFHQL6ZZ+Vcs4Cw7xPG7P
         9anzu2FUdRWB0ej2YDAe5Md0XjFM4/iHJg8/rsAi1FKYHbNfIl91BfNJOppWAhY5Qh4T
         shEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUK5yTVznLYgNbH8X9cYNOqj3/TQDr33t+qmbluPsozGUS1OfF4mR+DW7LwklbMaTwCCtg2cwxT+o73yo=@vger.kernel.org, AJvYcCV9emrJG91O9rq2uW5hvoadU/AABpln2RykoOZcN6eUoNcOBEzrpqIqrr7LuB+xJ93zr8nsIrYDQSpDw9Sk409CmDqCag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmmf9G2HxVYl76EdWU7GFdB4bPRdM1meFGlGDnpawXUYr3/dEA
	YT6DCfW5JlFXkiUeA7PO3cB2jfkJ3b96SgYoMv6BJbevdcud4+7RMaOXJEgZ
X-Gm-Gg: ASbGncuIan9k6Bz0tFWVK9marjj4UhsvGAptQgnBIlHPk6AbyoVADzVARCKUy4n5llC
	yMUgxe+LFtKIQNRQfHjmtgpplR949WskUdW8t0aZsgS5g6LMAhos2WSOW+HmAE7qsRvnxIcFLj/
	ZDORdd1mRxLTfhHQ54dhrJSwLlmH5Rifhv2vi0lMWAuTZZbSNy9Ur4TSLaJQNQIA228gomYhWBa
	rtTgaNd/qpbuVReyUkbsY+4VhBDFXUtvxx1Wx3Zzr5TLkoRrU3an+euMmsjpL9MNBypwlTgU/y7
	zg8RC2CznSfMRtpeT8Y1TgJW6aBQqGtoKfCVOO03af8LLA==
X-Google-Smtp-Source: AGHT+IH7mFn2VkfQwVHFZEjGscAWUbvP9g6ea6o2RiF6OGXa73QMG7EZQDFPYmj5IoyvNr+OHQ2OsQ==
X-Received: by 2002:a05:6102:1613:b0:4bb:d062:452 with SMTP id ada2fe7eead31-4c30a537426mr6401588137.3.1741465436847;
        Sat, 08 Mar 2025 12:23:56 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:23:56 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:18 -0500
Subject: [PATCH v4 06/12] platform/x86: alienware-wmi-wmax: Add support for
 the "custom" thermal profile
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-6-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
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


