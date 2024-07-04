Return-Path: <linux-kernel+bounces-241570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F1927CA1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBFB1F226CB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2142143755;
	Thu,  4 Jul 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mP973IBG"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF014375B;
	Thu,  4 Jul 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720115553; cv=none; b=PBU5eNANz8jhS0jD0HlANUixA6eJ6T7tm5qGwryPNzYXIPTNOvRDqZSSb2vdazyK1xYQv6gHJZUKaMyD8JoXB6CFsjq83jhVaviSBVHaTtb2R/uOk58n4z2+jxt0QoewireePMFubX56rcL1i1pHXZtsxR87TXpIISfxMH3FyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720115553; c=relaxed/simple;
	bh=4QpygOocRK2LqW7+Xyw8VJsXulvdR3vL8ghDdx4MPSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VcRmzrm/97ifoNnvXRQ8vyjMnEoUn5ZzzRrkwIxZB4+mkoAlUUrM+7ISv35vnC3/8X1hXqcKc+JCLNjPGlryuzli9OaQ6x7/gZSr9VEryukShNnZfIbDsBWYefo4pK6hvnKVdFzNJ3dOGavy1hOh1zQyqKYgSxORRnaGd5AL++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mP973IBG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-707040e3018so562617a12.1;
        Thu, 04 Jul 2024 10:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720115550; x=1720720350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE0CFBwS9r1Yt3BsXytdSLTpeZXIjIfX1O8WmdyBVdg=;
        b=mP973IBGS1PVoooOcmwkz8X2y3nZP6Vdd5JD6v0RQBzKxMg098NmD4RONNpjmf6W57
         h77ZzSUsHdy8VtNhZqQJYeakCG9ukCr6aXJeVDLoPC0qlUDBGlbpRFh7BVbJKhssxncr
         1NLLV2Vbztwn3SseAC82m5Gr3seo54fcURRROrBI8UNjslnTfW1EkvobjRHl9LXAIVOd
         B/Nq7ZPshNk0/fBfWwmeB9wzH0uH3OSGFGXY9aTKfTalwhAcc0gthDnr3Iluls3tyOlS
         yTsYTUeW8xZ717CjgfiNmLEtcd/QOD/stkLUQLkEgSCcIjvyh6J6WKMO1khFmn3oHONO
         vywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720115550; x=1720720350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XE0CFBwS9r1Yt3BsXytdSLTpeZXIjIfX1O8WmdyBVdg=;
        b=wy9AOiy8Bh6tEpyx6i2oixUKGIc2zzTm/8hLW+lzRNfwZAFsxPAAhVibd1+c5fJAzp
         SWh/cH5rnBMhlNf0Ty3sS4rcZRUvSzPoHzoVHONLs7VuYXNyzA9v1gf51OzAas6UqYnM
         vjUUH3iRHkyH7zuEm1jwIpwplKZ4TkgqfqgLeRLClgscBnGw7xK2Q4jdnfjacCbH/0IJ
         vXAH8g9jhDeNttNfJPLl9mQPuVeAntSB2MWYUWUae651WFCnMeQ1qVqaHTofI5Jxe1+P
         tgJnC8mSQmkJiAIN6PlYLkKLt1O0Fihm7DgbPKORzZAbQfTpMRRDAu0D5JSXqPy1+Nxb
         gzEA==
X-Gm-Message-State: AOJu0Yw0ZNLWMnDzOZqGm75bfKGYFDZZkhjMfORANFHAIRELU/Q/6Ik5
	UXUw/8y1SnNAUK4XptD+18RN6CZQV0s0slGYFXPHgaAe2GpNKeKVgZFH7A==
X-Google-Smtp-Source: AGHT+IHOYem4THy3nmhQhXShXuTH3qpYXHI6Lu4NHf3wcKzR+MF3oWq8GWk0It3yEzEddbP6A5/AHQ==
X-Received: by 2002:a05:6a20:2446:b0:1be:ca24:964c with SMTP id adf61e73a8af0-1c0cc8784e7mr2794600637.16.1720115550480;
        Thu, 04 Jul 2024 10:52:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8ba8sm125941295ad.62.2024.07.04.10.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:52:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 11/11] hwmon: (amc6821) Add support for pwm1_mode attribute
Date: Thu,  4 Jul 2024 10:52:07 -0700
Message-Id: <20240704175207.2684012-12-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704175207.2684012-1-linux@roeck-us.net>
References: <20240704175207.2684012-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMC6821 supports configuring if a fan is DC or PWM controlled.
Add support for the pwm1_mode attribute to make it runtime configurable.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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
index be3e590aba3d..4e3f8a6e8354 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -308,6 +308,12 @@ static int amc6821_pwm_read(struct device *dev, u32 attr, long *val)
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
@@ -363,6 +369,13 @@ static int amc6821_pwm_write(struct device *dev, u32 attr, long val)
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
@@ -741,6 +754,7 @@ static umode_t amc6821_is_visible(const void *data,
 		}
 	case hwmon_pwm:
 		switch (attr) {
+		case hwmon_pwm_mode:
 		case hwmon_pwm_enable:
 		case hwmon_pwm_input:
 			return 0644;
@@ -767,7 +781,7 @@ static const struct hwmon_channel_info * const amc6821_info[] = {
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


