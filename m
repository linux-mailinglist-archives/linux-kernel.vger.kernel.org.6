Return-Path: <linux-kernel+bounces-558757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A2A5EAC7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A831898896
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915ED1F4265;
	Thu, 13 Mar 2025 04:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l8XLIkHa"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E41F4170
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741841288; cv=none; b=gC6hVtqPm4E4CN/7Tk5W6XHqS0rTwBFnor+JAOA7C0VBYbJ/KPbGB+HmCysVepGThxRfB9agomBNzqfi5cPiBdm9zJjklaIfu2TymFC5XgR7oJSQJd9oF7EU9XrCHtswSQNloNJmBl/QaF9r/RM7RoTIVyUs9xPN4n3ozkslQoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741841288; c=relaxed/simple;
	bh=WgOaRD1/gBWqutG9Z8BbW44fhl6Jh8r0vqcFCFsRRH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLM/3dyxnWNZ3tqgHBP1PXW/M2Q21x2wwlXpeJsRMF25PrDLETpDOgJALTzelRhbsmVvG7V+DXDqjLOXupM+C4KMoX6R59PGS+yfun1WFJMDIE0bVsF4n8vjoDtZhwqPbiKGRoc2I5iSah0q2RVHhSdB+I1xZwfByyWZUB5N7ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l8XLIkHa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3011737dda0so1054002a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741841286; x=1742446086; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkgK5jX+FCEI8nouFKdll/aGvpUK/LQlAxZ+HobmESs=;
        b=l8XLIkHaRr+3rrGTL3T8k5pDti77vEL1zhTp590boh/NrsMqKTJRNAfygvgkLSAjXE
         oi9Q8+mPIGUCBIKJgZHq+f13mrRf6jGKW/z/OGyPm60IW2xWeGCvO+mi3GG0YLh0BD7b
         CcSLzbAnGe6mDQL6A0Jq0tabKimMsovEDFfJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741841286; x=1742446086;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkgK5jX+FCEI8nouFKdll/aGvpUK/LQlAxZ+HobmESs=;
        b=tOUB21oV3af8y6RmbeN93Pk73hHQHFI9TagD52xHhkwWc64RFQXsSta+W6rCcRyq53
         RVnVDUhcL5rWXEHLcNsDZRPMoetwd5nOuNfZqAaGdG4Mqi33tOy97s7rO1AGyKsHBWaV
         4/LXqGLJrPs4YU/VMqMRMdSC4vZYFPUWljM0qBnG8RuIyPQLB0zIVb6Mi6KlbzxaZYuh
         fWeyz94lwTp9Kpngqb/RXaKsmDOPLFP/RnG8STItE5k2LhQb8yQvD9Z3Ch0gZNrDwpyj
         X16+6C9E9PK2C28SiUbum6ivOJteB/A+GnVf08b4c8j82ebN2IcrHReADdGX73OBI7Pi
         vcPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD+6ESimChQZq7I+GDa8oo7mpPRdWTBeRTvNNpou/DeJWBRyvB6m7hAH6Y2K22FtvO4kbtfrWf8+bxvvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4rPOP8G+8dU4MRfyb2R4th/p3/JFihD2Flt6ab9vMEksIy/f9
	+7VeAeiYcuumjrn337f9wzj+JOhMkFrMljhu5Odmj1E4CvcpjgzfhS3jSSZhzQ==
X-Gm-Gg: ASbGncugomwBZInitGMmZGO9jVYg35et4TpP53a3RbeN4DOtKRGpiH7UeqK5kO99NIu
	4ghNSnU4f8/QlxknqS55/KNRkyMV2xG4aYLXj/fAzSbav/f1XKYl/eoO1Tx9rwRjqcYob82iILu
	csluBuQTY4f5lOOLLBrFEi5xvrNaw/aUvHlEq4fNre4uK4eaXg+tTffmczlOpLyEC2scWAECnx8
	ubGWJWtKEkwhKZlXpWRbsdWsxkdehedIsZNdtVMyelw1KRr/j+DqzgwQyqP4RbLOZWtFhtUaI5P
	QMaB0OX52Tap63/8MNWOdvE8Y0tHClJlLSnihpwzw8b7HUcE9zAzoRm63WSenzr+R8s=
X-Google-Smtp-Source: AGHT+IEPWtvXkbZGs7O7/HumRDnQlpIfoYAFZcrr04/lKSaRzbzOgD2nzpzxAWXqpA6A8LJHsLZDTA==
X-Received: by 2002:a17:90b:3884:b0:2ea:37b4:5373 with SMTP id 98e67ed59e1d1-2ff7ce6d7ffmr35825012a91.10.1741841286433;
        Wed, 12 Mar 2025 21:48:06 -0700 (PDT)
Received: from lschyi-p920.tpe.corp.google.com ([2401:fa00:1:10:1872:6051:5c24:509e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5c03sm4188025ad.249.2025.03.12.21.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 21:48:06 -0700 (PDT)
From: Sung-Chi Li <lschyi@chromium.org>
Date: Thu, 13 Mar 2025 12:47:42 +0800
Subject: [PATCH 1/3] hwmon: (cros_ec) Add setting target fan RPM function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-extend_ec_hwmon_fan-v1-1-5c566776f2c4@chromium.org>
References: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
In-Reply-To: <20250313-extend_ec_hwmon_fan-v1-0-5c566776f2c4@chromium.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, 
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sung-Chi Li <lschyi@chromium.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741841282; l=2304;
 i=lschyi@chromium.org; s=20241113; h=from:subject:message-id;
 bh=WgOaRD1/gBWqutG9Z8BbW44fhl6Jh8r0vqcFCFsRRH4=;
 b=YYMOG4nN0QlC1W81qjF0ONgWNPNT9Xzvf6BHYEGPaJQUnSOwDM6fb6gAJ00Myf30pvq2ikkCa
 ackrFedOqFOAay02Dxg0OYzR57cAdXfXkpD6f40bhyf9h11LpOeevBO
X-Developer-Key: i=lschyi@chromium.org; a=ed25519;
 pk=nE3PJlqSK35GdWfB4oVLOwi4njfaUZRhM66HGos9P6o=

Implement the functionality of setting the target fan RPM to ChromeOS
embedded controller under hwmon framework.

Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
---
 drivers/hwmon/cros_ec_hwmon.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
index 9991c3fa020ac859cbbff29dfb669e53248df885..b2fec0768301f116f49c57b8dbfb042b98a573e1 100644
--- a/drivers/hwmon/cros_ec_hwmon.c
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -52,6 +52,26 @@ static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8
 	return 0;
 }
 
+static int cros_ec_hwmon_set_fan_rpm(struct cros_ec_device *cros_ec, u8 index, u16 val)
+{
+	struct ec_params_pwm_set_fan_target_rpm_v1 p_v1 = {
+		.rpm = val,
+		.fan_idx = index,
+	};
+
+	return cros_ec_cmd(cros_ec, 1, EC_CMD_PWM_SET_FAN_TARGET_RPM, &p_v1, sizeof(p_v1), NULL, 0);
+}
+
+static int cros_ec_hwmon_write_fan(struct cros_ec_device *cros_ec, u32 attr, int channel, long rpm)
+{
+	switch (attr) {
+	case hwmon_fan_target:
+		return cros_ec_hwmon_set_fan_rpm(cros_ec, channel, rpm);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static bool cros_ec_hwmon_is_error_fan(u16 speed)
 {
 	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
@@ -140,6 +160,19 @@ static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_type
 	return 0;
 }
 
+static int cros_ec_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_fan:
+		return cros_ec_hwmon_write_fan(priv->cros_ec, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(fan,
@@ -179,6 +212,7 @@ static const struct hwmon_ops cros_ec_hwmon_ops = {
 	.read = cros_ec_hwmon_read,
 	.read_string = cros_ec_hwmon_read_string,
 	.is_visible = cros_ec_hwmon_is_visible,
+	.write = cros_ec_hwmon_write,
 };
 
 static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {

-- 
2.49.0.rc0.332.g42c0ae87b1-goog


