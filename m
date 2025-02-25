Return-Path: <linux-kernel+bounces-532624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFEFA45006
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CB518978EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476E21883C;
	Tue, 25 Feb 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E13IlmFL"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF25216382;
	Tue, 25 Feb 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522321; cv=none; b=I9jT7dtXeG7Ail4Qn6lx4zBmR11ZOpxYtGnlm23S6qZh4fEzdfigPWr+E4O65S5YmY/5em/R9O2lf1EaRucKNX3bOHryoavUe0Z6FlCfVgx5rotwNvucnEoGVxCmG2rt9WNKPYz9sj7yiK+mbq75oME25OCDbHn9penEmbXDcNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522321; c=relaxed/simple;
	bh=jUEBuq/ABjACMYB0EbZrp/JVKsSoCpVcXgjiFTHWjCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDkwsUBzOSMKfwxNFf/AjGYv8MKAl/DazDquQJ1O7uIq3g0XwhT3zPds1o9MZxfTcif3ZtgssQiZQ5lKWF1eYQ5FYU/cR9SKKCQFdOTubIgIsnU3TZlmiiEuwHdmX2Tpcjc0y1x8m3olUh2oINtXqEYJDBvHL1lctkZQRQPhRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E13IlmFL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5dd164f03fso5652565276.0;
        Tue, 25 Feb 2025 14:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522318; x=1741127118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHxqtl0uXjCD0uT10CA/yTLNuWfuWE7jjsFFOib6WVE=;
        b=E13IlmFLQJd0XoqS2N3BZzJ/B7ZI64PsISgro3RnwtrfrEKPf+LebO0SQh6IGnwWdM
         C4HtU/PJsiOIjRd1tSRBMwHlY6sJTEHlEui8ZPHn41acpxbYi/ldkP2gszk3Bv1Yav7/
         5gaUl/RB4o7aYO2WXblxTXXQgjCW8qD+YftaOfDbn/RBGgrop1mwS3BOwkbMOByMQGZZ
         uOaRclgzJObtMHNdCZzCgBqifUnsM6xTGmu5VcQ0UXpdgH5opyVJDVq2Bc14gdQHQNrN
         3AU29HbHtlzTmCzaqdzZKPJ5NYpbI4jf5BwM3spKKcBKvD9/l7PDgKuE1pkl4/y6+oJt
         NNvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522318; x=1741127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHxqtl0uXjCD0uT10CA/yTLNuWfuWE7jjsFFOib6WVE=;
        b=Rtjp+3TEVewm5WsUfOn/zBEq5E8NOWRjMUggk1cg1SKDB4sBCXr7CgakLNb1dKq4Zr
         lWpOEazn5PIJv0GidYqkyj5a4Fs/09f7vyJ1L+M1SZY0FBo5lYizAyyYbKkfDyKRKQ47
         MC+IBRI+OdV9syXePs23WtPFjexBBoewRc7oePfxcvCZEhTpR1Swg2QdJMFBdN+plhkd
         r3tq2Vz7nGfiLaWYcdNIZC+BvWWZWPjgu5kvtYaCOgeApRgRxaVqHfdTNj3AI9H7mU7a
         2DcqyKft8jrYsjCEk+rtiahqU9/UWs99ibHeESPOIh4TAkScLzQ/4zLZG7b8S7eCh52D
         DtPw==
X-Forwarded-Encrypted: i=1; AJvYcCWxNxrr3W6hUAtiUmOCMOjzhv5LpWVPYOKCcNQT+DfOH7RK3S4Pxhtq5CnN39EeBCNrnFIikKF8ul26wF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0GjEadMvVeBvUehGZdZCRdBWPZ5X1M5sYC/9xHZBlSA0MKJ4G
	P195cGnqaV7lisHCfVJ7lOzj9d7OIF40Ud+PWtiEN8eb13D6DqZx1Kiq6LoF
X-Gm-Gg: ASbGncvmgdEDqngHZS9LnkX7Kcxf9dplIfwA8AoyEx3Rb70D9olqkOcrlsUNVVTIo+v
	AFaIXH9t8OR0PqO9yuK97SONtKFmZMnefRXjCXisEErSD1iqtm+Cq5vHGhFe8CT0Xo2OENGCA+r
	nuQLi6psWgN6BQWAtYgKO8i2LGmJmC6pQOFYMAIjiDJv9HOs8UYNUSqw4ubqOcnrTR5oBxM+lIt
	W/99qM0HXGYB2dTPD6TNoc6xlC4a2FfYeBAKHqPVVj+f9+cyiL04rnEPcVYZxG8STVve65vr7Nn
	gtNEfEYI4+qn/y5woC9iyfhUMVV/g0xTtQ==
X-Google-Smtp-Source: AGHT+IFHzN1SaZ8F5oklGOTlIRNpFs2VPMYXbDDwrKRe0SdyNDUY4QNIhTz5mFeFzrbE7d4l8CZCkg==
X-Received: by 2002:a05:6902:e0b:b0:e5d:ba24:7dd3 with SMTP id 3f1490d57ef6-e607a4c4007mr4268717276.5.1740522318351;
        Tue, 25 Feb 2025 14:25:18 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:18 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH v2 04/10] platform/x86: alienware-wmi-wmax: Modify supported_thermal_profiles[]
Date: Tue, 25 Feb 2025 17:24:54 -0500
Message-ID: <20250225222500.23535-5-kuurtb@gmail.com>
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

Rename supported_thermal_profiles[] -> supported_profiles[] and change
it's type to u8 because it stores AWCC thermal IDs.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 57897a0f4296..4a8335d90b5d 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -212,7 +212,7 @@ struct wmax_u32_args {
 struct awcc_priv {
 	struct wmi_device *wdev;
 	struct device *ppdev;
-	enum awcc_thermal_profile supported_thermal_profiles[PLATFORM_PROFILE_LAST];
+	u8 supported_profiles[PLATFORM_PROFILE_LAST];
 };
 
 static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
@@ -606,7 +606,7 @@ static int awcc_platform_profile_set(struct device *dev,
 	}
 
 	return awcc_thermal_control(priv->wdev,
-				    priv->supported_thermal_profiles[profile]);
+				    priv->supported_profiles[profile]);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -643,7 +643,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 
 		mode = FIELD_GET(AWCC_THERMAL_MODE_MASK, id);
 		profile = awcc_mode_to_platform_profile[mode];
-		priv->supported_thermal_profiles[profile] = id;
+		priv->supported_profiles[profile] = id;
 
 		set_bit(profile, choices);
 	}
@@ -652,7 +652,7 @@ static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
 		return -ENODEV;
 
 	if (awcc->gmode) {
-		priv->supported_thermal_profiles[PLATFORM_PROFILE_PERFORMANCE] =
+		priv->supported_profiles[PLATFORM_PROFILE_PERFORMANCE] =
 			AWCC_THERMAL_MODE_GMODE;
 
 		set_bit(PLATFORM_PROFILE_PERFORMANCE, choices);
-- 
2.48.1


