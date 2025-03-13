Return-Path: <linux-kernel+bounces-559697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC13EA5F83D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B749420B67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7838268FFA;
	Thu, 13 Mar 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRUPa2mn"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA29268C77;
	Thu, 13 Mar 2025 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876223; cv=none; b=pewAWcR9JMK40ohBceZd+1SDJUV7ldO0KEVBE7sM5Z2E//Clbrku7ow1GEWQKzy0wxQIT81ix60OZfr3g8aN6oOcP22v/aKmiuN33oZL48aFsYfbWajwPlX9QBj864GHMNDzChjOzVjGJKP1UP9iiHfWk6cMJuDB78t2KvaB5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876223; c=relaxed/simple;
	bh=0/cs7k9NEYKOzfKSWrMqL/b8KZs7Y/LPsKkPsOmnrDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mMfKSr+bl6jr762UZ07J5NHBnmBHiR0Gt1qXfaeAkIT32g/KVt2py8b+N9GheHm4RwxUHr5trAAEEobC/NdhtK0TumWgeHepuGnuwFraW95Rpg0kGxw4wZwwDb/a/5eTmPoiLGVKEVmJJQV8AZ7gqNYiAr3hyLY4eLTJpLGHoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRUPa2mn; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e62d132a6a7so779117276.3;
        Thu, 13 Mar 2025 07:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876220; x=1742481020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfPNOoHpP1FsVmbeiwOjL1eZebItbrovfjcUpFcyo94=;
        b=nRUPa2mnhb5VbRO4JSvteFZeeBGbeT+CaNnZngbwVVYoQZDCGsAdpdcw6kg3zyWFmL
         tcyTszpssplRoOksR5Qv5mNtsj09MrcCvx8ezIX9jnJaBUTVXrlxtPTYlPGCsgVRwNpG
         t6cdS31fZaCEynY5Xuo6fMbXthKCYrCU4ZIIPeZxOd4EBMyZiCiOKciKj3aIBUH7LzfO
         fr9H9brPpxNK077WUz7EoiIf7/xZHGSdD0rb1kMF4ETS3ahY48YuJA6owmWZcypNRsET
         swOXGXr3vud0VLjmQVIIaPcJFGKuyIZ8wLIty3Uw4+UZluQrqZtQ0+aQ/X1Xfa/OcqiC
         fJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876220; x=1742481020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfPNOoHpP1FsVmbeiwOjL1eZebItbrovfjcUpFcyo94=;
        b=KIz2jKOm5dwYDvI7f4dslYWIahHfy1Z0yl0eXszBRIjWHFilCMmmO2QCrJc8nDyWO/
         mXIYMvbkcJC9SSSTpOBOj35jV4oRbGBtZeG7350W4+VdUgaSdOEI1aKmdwDFPNHYxW7D
         Wk4maZu2hSqOiRs/b3dbTwfXYr8jwIwUMGG2eR5k1oX/xxAlt4ec+MikvvetMMQZHFfB
         oXW4SNrIzVXcn/4Qi4OpvCtqtrdeHXNFE0qTGeUZ0TgDyVSEDEtPLkHeG1YVk9F4BZIS
         jOlqRKvb8vnrnRdfIIbRJA/tZlC67HKWRon4ncgkB5p6b9gAB+8DFPR37SqXurN0q935
         Kj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX13O2U8oqczpFQzWNp0s94LuPR+aGd/7qDsEu3vzcgOOFTZLeGPA8zokSKd69pqI1FY5cbFksK0meCkEsg4rowCgP+qA==@vger.kernel.org, AJvYcCXSKARYEP88jEs7DA2DAxtTYY7LAnqR/qKB8mu7iTscE6dE9VhPg4+S8QfO1Nn0gWaCV48f916LMdKtH7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6KKWk1p1fZDFEOC/4RN2Z02W7t4t1he3q7KWZy8JpHNJd6TPu
	icQsPnryob3+k68bD0j8JnbCKn+y6QBdDcmXn11ZUfl/4XeFZ59PCzWCAnCY
X-Gm-Gg: ASbGncuM74oe4rBtVD5Y8ihghOCqgGdOWzM8XMgGcBxsedmZ5BXPalu1wfJ6PpDK5fZ
	XpfZGjv7PTHZQQDeV2WlU255AFesxHhZK8txH3dGh/Dc/W5mS3sUwjxsKXr5Szic5XBdoTpPUKm
	NgAn8VIJwt1uJkNQDNce0gezq0lU1Xa8OwzXBsC83amMZ1MDul9s7DanjF0WE/YCwUPmfniQihA
	0tmxLNU/HytqopXLjxs6z2eAMd7MhAleCX08F047Yc/DzxUsYtCP+1JkHrXBYFYIWzrS7jddh+h
	qbRkgUswbQ5yNsTZq6vX5MzGCLgFG1Z6ddUQUow9xbVzFZplaMv5C8A+
X-Google-Smtp-Source: AGHT+IENTVSpftQ6ym0myu0zktCZdQxBR6LNLBh2QvQfY+cxi8GE9QR0PUGo1JYGvGNUWo6F8uyFoA==
X-Received: by 2002:a05:6902:102c:b0:e60:8734:64df with SMTP id 3f1490d57ef6-e63b52114a6mr13104121276.36.1741876219070;
        Thu, 13 Mar 2025 07:30:19 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:18 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:29:59 -0500
Subject: [PATCH v6 04/12] platform/x86: alienware-wmi-wmax: Modify
 supported_thermal_profiles[]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-hwm-v6-4-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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
index b9dbfdc8096c571722b3c7ac3e73989e235e2eb9..a8a13779793abbcc8d1263474cac6227d524a6f5 100644
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
@@ -616,8 +616,7 @@ static int awcc_platform_profile_set(struct device *dev,
 		}
 	}
 
-	return awcc_op_activate_profile(priv->wdev,
-					priv->supported_thermal_profiles[profile]);
+	return awcc_op_activate_profile(priv->wdev, priv->supported_profiles[profile]);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -653,7 +652,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = id;
+		priv->supported_profiles[profile] = id;
 
 		set_bit(profile, choices);
 	}
@@ -662,7 +661,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		return -ENODEV;
 
 	if (awcc->gmode) {
-		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);

-- 
2.48.1


