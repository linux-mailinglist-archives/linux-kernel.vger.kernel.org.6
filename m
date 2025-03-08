Return-Path: <linux-kernel+bounces-552785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E43A57E13
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE493B2AF6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793C1FF618;
	Sat,  8 Mar 2025 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlMq3bRY"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF2212B3E;
	Sat,  8 Mar 2025 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465436; cv=none; b=PeTDB2/YqxDJbf429iPr6zonT805YIcG29KorJkOw1NRetXBT6odnQPz36VBhCUGemxqLo7f6/yhthBvZ55c3ys3z1VAJwIyJiYJs8Sxxa8Tyc+9Eu4ljxC3dY/UbXQCBRS1jLgvsi+GpF1EQOysKDeKw7cWu8ShciCoubYq0M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465436; c=relaxed/simple;
	bh=0/cs7k9NEYKOzfKSWrMqL/b8KZs7Y/LPsKkPsOmnrDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fbwCCczIpw/kxNsgdSTj2glzmGVkx/85w/+4JXOini21A1Lf2Pb5bwl6+aYHDKuwRAjo3b4jlmz4fi09lN/V1Oircw5ImyagTCpViXJRuj4xcCdOqoI5ohy1bl4BFLXXAN+tmHliVCexc/ICX06Yi7pODOqEuNfdttuWMKZqPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlMq3bRY; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86718c2c3b9so1119568241.2;
        Sat, 08 Mar 2025 12:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465433; x=1742070233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfPNOoHpP1FsVmbeiwOjL1eZebItbrovfjcUpFcyo94=;
        b=AlMq3bRYCOI7MCzSDLUZ0Rh9yOxwfW0yTZz8qREM76avvwqDa7b2+nA7pqx0BY6X/Z
         XeRQFF6sEq7wjGt6xaS3xHE9a/fN3alyNgzjF+GOjoay+SJNAG47OR1YmneGHskk3d7+
         qIvalJU409fyu4KyrLj+oDg/4sVXqX5mF1zzoJrAdbXCh2atFfbASs0oZF0V3MjpVYeQ
         vtY0Gw/iAJjApJfOY2UfgYAoxAbEJGa5pmgRnwJoY3SvFcgmFmB8bcNF5ffUEYPw4OqH
         N/gxPkwIVaGY4L7HqTzikk80Oy/hKV2NdFivgcTLQkRQQVIO5HH0nwPl+zt64+/JZ8Vy
         gzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465433; x=1742070233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfPNOoHpP1FsVmbeiwOjL1eZebItbrovfjcUpFcyo94=;
        b=Dul6hsu+jOHhM/maJPRQcue+149B4dfTwx+J6TboE6OGXQAkn4WLT+Ect4YhCuwxuZ
         WlpcvCYnapz3lOBGOJcBvEWEzq/CBQ4mKbTQ5yTt5jFcex1eCLhMmWZWqQ6/RT3I7hvH
         SMQCG+ob98Q1UYgpncdiJY2FEXlcR0x8uTWivh5fh1aB+lC4FJZyLWAFNm++TKWmBqdN
         FmjacG/bsRjyCGrMcC4dpmJCxAUEK/W07zNv/kscPm6BC3oCxnSsMT9FIYSXbKcnahUn
         N85q7ugIrGqQLuVD9VO+GxvFo/nMdbs6QANiPlL34Kra1V1QU8PDzff0WTtyXPoaIu7c
         outw==
X-Forwarded-Encrypted: i=1; AJvYcCV4OX99XkK0kqD99E/wgwWKDBfJk1+vv3HvDgmQ/dOMv6jP2XKMyuOx6HTMpF1ha8toKoCx7P1ZIwIBjjA=@vger.kernel.org, AJvYcCVLwY8Iv0a0oJhcb977t/VhLTmE5nzZvu4byWSbnlSa8jR/C94/mY+uDPfSGMaL8lph/NgoQgXkHqnt1WXEc3N8pQg6Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCX57Hb6iwREhvvYaZ5G9Py+DI0aAJUxeWw87hheBVPmKY6NTD
	5m1n/byQv9cPjPQAgMnkgKwSAxtQP1B6Vj4E7ZOQRxAtO8LlIAmQkFuvZuJf
X-Gm-Gg: ASbGncvcQPWrtgOkbmrXm3Y0mtlBTL0Gfja8hZF7x3QJ4VKq8cHizCXU88Eizry86/8
	X4McvemdauUWjeWPYy6vXLeF2zDztunPMvfoa9CksWA+Z/w10ES9dYIgiDKrI0qIrBiNsiyiPBb
	wMwfh2VRpHSU/om3Bbg1fnUgQZ/59mTtaWOUU6YNY4GTxB15Ms66U+jpS0YoS4Gcpe5RmaTC/03
	vwx3dJBA+snMOfJ1+uHZ4SGYOmpU6DweDVtZn1PTveEQdeBTrSMK7L3kJ4Fwjo7B0EDh6cAvnnv
	YTbRmR/87SeJLf7mXeX77lixIoyPvSmyCQOYb5nVLXnRQtNM2AzX2PCR
X-Google-Smtp-Source: AGHT+IFvz1GBQVyXY22TzEYtkoZD39hy6FwWQLBVOeyoym8O3yzr6yN4p/uZqY+wicUK8tqNIIjc1Q==
X-Received: by 2002:a05:6102:578f:b0:4bb:c24b:b623 with SMTP id ada2fe7eead31-4c30a6624famr6409449137.19.1741465433206;
        Sat, 08 Mar 2025 12:23:53 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:23:52 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:16 -0500
Subject: [PATCH v4 04/12] platform/x86: alienware-wmi-wmax: Modify
 supported_thermal_profiles[]
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250308-hwm-v4-4-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
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


