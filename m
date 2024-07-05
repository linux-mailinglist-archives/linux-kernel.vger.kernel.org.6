Return-Path: <linux-kernel+bounces-242926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CFB928EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 23:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80EFD1F20F67
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A609B17B413;
	Fri,  5 Jul 2024 21:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDJ3INvY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893E7149DF7;
	Fri,  5 Jul 2024 21:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720215371; cv=none; b=hAbZdREqaCdCHfEmgEj5HALZcwRDwSI88uLAWc7RuEWJBb6QtQ2ShMhBr5uZdSe7QnG+NM+pG1alxcHl0rjITHBJQI5Gd+ZOIH633S27kF/mCl7or89rcTVl79TTWLCXUzQ1U9SAMtoZ0VLL5oEepAE6uuZBaS7TZoLKyVZj0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720215371; c=relaxed/simple;
	bh=XChEHfDAMaccmvZc63NQBt/ndXPSaC3M5QmSdo0ydUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLOQIhkMiRSsgXzpbot8IvlpEH5nvVb3iEGU476DXrFjnz77+IVUSt5yIrWTb2aTKb152YRiV8cRSYyhXOTwC6M20FuhGUrOfQQXfTnJ2fKVu8dNCUQfR+bqL4LvVe91NeFN4gAU7SIPKLbs5VDumqIP3i5qSLsHQx0O/U5Yr9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDJ3INvY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb19ca5273so10956115ad.3;
        Fri, 05 Jul 2024 14:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720215369; x=1720820169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV1/iAdcJfS4YxVzReDVPggA0y+qGIxAaSteDRTh+bg=;
        b=JDJ3INvYQoF83Mj7XAM3PQKpKvP7qWc4xL2BzxCn1uYu5I3cVVMq/Nkzh1Qeoduw02
         T1bt/6GwMPuSVKZpuu7wM/bgWCItolD4pC63oktUn4cYuIDUEM1Am14EDWlpvXlXB8vV
         knPbm52AlzijypbzwNAYCHICFpZYG5bbs1gE47ThTXK57hnsnz4OnBiW6j1ST9j2YKHR
         OZuqOBHoqDrL0AIZmWiL5f0MKHcpJmIFgkrpHapCcelJbxwuOGDDVPeNFP1NkhF7th1S
         qH8ksRyD8aZ1g72bFvNh8xHLU35SewTipPI1rYzHTrwHUiahH+IDKrKy58MjFgZYU6Tq
         QwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720215369; x=1720820169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV1/iAdcJfS4YxVzReDVPggA0y+qGIxAaSteDRTh+bg=;
        b=V5yoDVpd/PzrXiEz+f1oSz9W9bcxw4IvNnqx4pUnbT1FjZnr1rD3DD505dBX6CTgOF
         WacvCtZw6feMEawhpopZz/+ig6W3NyLo0GlcUT7s6GMy9WN1yVb4XCDxL9PqyqSxaDaU
         WPI9bWmw7d6C89Lu16r5HsfAB9dWehgKSKqasldKjT39gmfHZwCMtTBd2llRzqxtLCa1
         Q6ApQDA+PaMqEI3KJHRhfggVFlpvuo78TGUs3Sdp83FBgFT7nYuDtrHESY9e/ref2005
         I3K+sh7qE7DlnLo49KuRnBq6zdajYqSr2k8TVsGPz7FkhKWOb0eNbpgxT2E6ZnkAACqU
         IQ9A==
X-Gm-Message-State: AOJu0Yyy/EkwNVmROQ7oVr1BaZZstwPWHNmSEdyCrSdlxssJSzvTuJyY
	ilAABUmqlTOibuV5rcg9WtqhMRu8tWjnsMCfit38urEsBYmdbOWFfz9ASQ==
X-Google-Smtp-Source: AGHT+IE5cPxcI5TwstRuAETSbvPiLvu4i4Bj3jPglQPY1RUP4GaPpOadh4uo936y43ghDsBQbpobKw==
X-Received: by 2002:a17:902:b201:b0:1fb:2b51:91df with SMTP id d9443c01a7336-1fb33f0a448mr35142525ad.47.1720215369401;
        Fri, 05 Jul 2024 14:36:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535b5fsm144928485ad.174.2024.07.05.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:36:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 11/11] hwmon: (amc6821) Add support for pwm1_mode attribute
Date: Fri,  5 Jul 2024 14:35:47 -0700
Message-Id: <20240705213547.1155690-12-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705213547.1155690-1-linux@roeck-us.net>
References: <20240705213547.1155690-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMC6821 supports configuring if a fan is DC or PWM controlled.
Add support for the pwm1_mode attribute to make it runtime configurable.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Add Quentin's Reviewed-by: tag

v3: Fix wrong register used when writing the attribute

v2: New patch

 Documentation/hwmon/amc6821.rst |  1 +
 drivers/hwmon/amc6821.c         | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/amc6821.rst b/Documentation/hwmon/amc6821.rst
index 96e604c5ea8e..dbd544cd1160 100644
--- a/Documentation/hwmon/amc6821.rst
+++ b/Documentation/hwmon/amc6821.rst
@@ -58,6 +58,7 @@ pwm1_enable		rw	regulator mode, 1=open loop, 2=fan controlled
 				remote-sensor temperature,
 				4=fan controlled by target rpm set with
 				fan1_target attribute.
+pwm1_mode		rw	Fan duty control mode (0=DC, 1=PWM)
 pwm1_auto_channels_temp ro	1 if pwm_enable==2, 3 if pwm_enable==3
 pwm1_auto_point1_pwm	ro	Hardwired to 0, shared for both
 				temperature channels.
diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index d29f8ddd444a..85e27372a117 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -311,6 +311,12 @@ static int amc6821_pwm_read(struct device *dev, u32 attr, long *val)
 			break;
 		}
 		return 0;
+	case hwmon_pwm_mode:
+		err = regmap_read(regmap, AMC6821_REG_CONF2, &regval);
+		if (err)
+			return err;
+		*val = !!(regval & AMC6821_CONF2_TACH_MODE);
+		return 0;
 	case hwmon_pwm_auto_channels_temp:
 		err = regmap_read(regmap, AMC6821_REG_CONF1, &regval);
 		if (err)
@@ -366,6 +372,13 @@ static int amc6821_pwm_write(struct device *dev, u32 attr, long val)
 		return regmap_update_bits(regmap, AMC6821_REG_CONF1,
 					  AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
 					  mode);
+	case hwmon_pwm_mode:
+		if (val < 0 || val > 1)
+			return -EINVAL;
+		return regmap_update_bits(regmap, AMC6821_REG_CONF2,
+					  AMC6821_CONF2_TACH_MODE,
+					  val ? AMC6821_CONF2_TACH_MODE : 0);
+		break;
 	case hwmon_pwm_input:
 		if (val < 0 || val > 255)
 			return -EINVAL;
@@ -747,6 +760,7 @@ static umode_t amc6821_is_visible(const void *data,
 		}
 	case hwmon_pwm:
 		switch (attr) {
+		case hwmon_pwm_mode:
 		case hwmon_pwm_enable:
 		case hwmon_pwm_input:
 			return 0644;
@@ -773,7 +787,7 @@ static const struct hwmon_channel_info * const amc6821_info[] = {
 			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX |
 			   HWMON_F_TARGET | HWMON_F_PULSES | HWMON_F_FAULT),
 	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE |
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE | HWMON_PWM_MODE |
 			   HWMON_PWM_AUTO_CHANNELS_TEMP),
 	NULL
 };
-- 
2.39.2


