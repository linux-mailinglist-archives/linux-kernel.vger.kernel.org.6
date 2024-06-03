Return-Path: <linux-kernel+bounces-198979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B00D8D8004
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD721C2375B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2221A82D72;
	Mon,  3 Jun 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Cr9Nt6Pe"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F0107A8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717410688; cv=none; b=iqWeLLtHzk9aJnvMRfP8zBiQMm6uLYBMY5R4pEuKpOaZJTpuKP7ws8USrpp1OtVYoUdm9a6QrEFr8V6kqZ6CtWqBmo9BCGNA9S/CWPiM0JeZaINd+B2u71vuwI9WmnHKL3Cvf6xy/RPCJDCOD9fmnc3n1rhOMr8kPr2Lvza9onk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717410688; c=relaxed/simple;
	bh=jschtwg1oUPywVWq3uuJVgwTsrIfn7Hnd/x/JMZnxxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4urSGhCEn5kDrEBWGc6VfCqpZjR/Rw/oK219CZoZuEz9DRgz/ROjxEel7CzMm+fnhpGAMikYeyzduL351jDQFX1p4bKOGK0EQiwAfbLwW3KOzvifZL//1EFyV6Lqi5nX9rTB+viKrEbiSScrQAKGOuSXaoIxwtiLbnahKX59Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Cr9Nt6Pe; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4212a3e82b6so19003635e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 03:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1717410684; x=1718015484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdKJy8/Q1hhiwzSia9kCnDlHx7ANWWXeJd2ZmaVjc7Q=;
        b=Cr9Nt6PeOIvwJN2KYHl/fKdQ/+xisRjr/enl6A71+9yf3192KWs6UpN0AU6QjAxxUv
         fPYHv+QQjs82TEg3/+ni2PoezXbBdQEGFhgRElNbNyMfYvY1QpfSPw2OnDHpjMuq7oYp
         27IZovI0Ok2n2ZOzGfHljwmdhjvATjjyLF4g7fWOY/vOvvl7Mp1j+Or5dhmmk+PyvrW8
         oZsVi2ogDojDBreFstGdfpt6e2UjtGaeLNN/tIBetRAVmgv2z/GEcK3q149pZu8l+bOW
         61c+OI2JVOiMkpZZ2ko1rCDC0i3Z32K6xZAjQe1Q8YFTIg1NwfyO+ZiW4NQ37l2LDweB
         AXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717410684; x=1718015484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdKJy8/Q1hhiwzSia9kCnDlHx7ANWWXeJd2ZmaVjc7Q=;
        b=YnxOkJaWjoOMA/gcgDp1JjwDZTNu3vs+gzG052SoDQ/4rOuq8Q12Bh2+WP0Tk7JBim
         7cTJ679gDbJSt5G84RCzPWyRhu5sQGp2FMK+XOOrsN+1ba7jdwu8Sz1h+MkkWIAEJWvA
         AxoEZg9uz8++tWGTHBKO3KKBQNKMzEnfqlQ6dT742NBJMn/if+CZxQjbaZGylOWxRtuy
         Q1Ym2SM7vNB9m3UD/ov7bYTcoVrtQp8dZ7swUR7DCyu/yY26ohYxXiqUesaVb3Qx2cJj
         sIDLPTAp+2864efx73snyFLMEb0HEr12QgZout0gp0y/sdwjOGuvxtybD3Z2cHypE0sr
         h3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCX84mc2XX12khCL62rF2HIhvK0ASwFGHPGyeLazijKpdPB7mFvY8DLtA0IxLsgsj3MyKArXxlGUxU6AQ/cbP0mZUzwnhpYqSmJpK6Ef
X-Gm-Message-State: AOJu0YysWamdSSrsNHzCrY5EfM11qFQ3lZsWh/rr+dT22UfG+vHHK5eq
	rJs2et8szvT/KP5atmy4U0w4r0wGFcni5KpZuK2WQd56ECYweSGizRLHyZ3OyZY=
X-Google-Smtp-Source: AGHT+IGj3jtcWp3TZCEN6P22PHIyTYpsnId9SpPI58C6BWA+HuWeruCqNwtCYr7o9BTbk3VSktdaIg==
X-Received: by 2002:a05:600c:1907:b0:421:20df:c6d7 with SMTP id 5b1f17b1804b1-4212dd3247fmr82903575e9.4.1717410684075;
        Mon, 03 Jun 2024 03:31:24 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213bfce44fsm40051505e9.16.2024.06.03.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 03:31:23 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] hwmon: (max6639) : Add hwmon attributes for fan and pwm
Date: Mon,  3 Jun 2024 16:01:10 +0530
Message-ID: <20240603103114.3263060-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240603103114.3263060-1-naresh.solanki@9elements.com>
References: <20240603103114.3263060-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add attribute for fan & pwm i.e.,
fanY_pulse
pwmY_freq

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/max6639.c | 74 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 7fa41442165e..ea412dd44f8b 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -234,6 +234,9 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
 			return res;
 		*fan_val = !!(val & BIT(1 - channel));
 		return 0;
+	case hwmon_fan_pulses:
+		*fan_val = data->ppr[channel];
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -245,6 +248,32 @@ static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
 	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
 }
 
+static int max6639_write_fan(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct max6639_data *data = dev_get_drvdata(dev);
+	int err;
+
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	switch (attr) {
+	case hwmon_fan_pulses:
+		if (val <= 0 || val > 5)
+			return -EINVAL;
+
+		/* Set Fan pulse per revolution */
+		err = max6639_set_ppr(data, channel, val);
+		if (err < 0)
+			return err;
+
+		data->ppr[channel] = val;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
 {
 	struct max6639_data *data = (struct max6639_data *)_data;
@@ -268,6 +297,7 @@ static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
 	unsigned int val, res;
+	u8 i;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -279,6 +309,21 @@ static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
 			return res;
 		*pwm_val = val * 255 / 120;
 		return 0;
+	case hwmon_pwm_freq:
+		res = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(channel), &val);
+		if (res < 0)
+			return res;
+		i = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
+
+		res = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &val);
+		if (res < 0)
+			return res;
+
+		if (val & MAX6639_GCONFIG_PWM_FREQ_HI)
+			i |= 0x4;
+		i &= 0x7;
+		*pwm_val = freq_table[i];
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -289,6 +334,7 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
 	int err;
+	u8 i;
 
 	if (IS_ERR(data))
 		return PTR_ERR(data);
@@ -299,6 +345,23 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
 		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(channel),
 				   val * 120 / 255);
 		return err;
+	case hwmon_pwm_freq:
+		val = clamp_val(val, 0, 25000);
+
+		i = find_closest(val, freq_table, ARRAY_SIZE(freq_table));
+
+		err = regmap_update_bits(data->regmap, MAX6639_REG_FAN_CONFIG3(channel),
+					 MAX6639_FAN_CONFIG3_FREQ_MASK, i);
+		if (err < 0)
+			return err;
+
+		if (i >> 2)
+			err = regmap_set_bits(data->regmap, MAX6639_REG_GCONFIG,
+					      MAX6639_GCONFIG_PWM_FREQ_HI);
+		else
+			err = regmap_clear_bits(data->regmap, MAX6639_REG_GCONFIG,
+						MAX6639_GCONFIG_PWM_FREQ_HI);
+		return err;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -308,6 +371,7 @@ static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
 {
 	switch (attr) {
 	case hwmon_pwm_input:
+	case hwmon_pwm_freq:
 		return 0644;
 	default:
 		return 0;
@@ -413,6 +477,8 @@ static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
 	switch (type) {
+	case hwmon_fan:
+		return max6639_write_fan(dev, attr, channel, val);
 	case hwmon_pwm:
 		return max6639_write_pwm(dev, attr, channel, val);
 	case hwmon_temp:
@@ -440,11 +506,11 @@ static umode_t max6639_is_visible(const void *data,
 
 static const struct hwmon_channel_info * const max6639_info[] = {
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_FAULT,
-			   HWMON_F_INPUT | HWMON_F_FAULT),
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES,
+			   HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_PULSES),
 	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_INPUT,
-			   HWMON_PWM_INPUT),
+			   HWMON_PWM_INPUT | HWMON_PWM_FREQ,
+			   HWMON_PWM_INPUT | HWMON_PWM_FREQ),
 	HWMON_CHANNEL_INFO(temp,
 			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_MAX | HWMON_T_MAX_ALARM |
 			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM | HWMON_T_EMERGENCY |
-- 
2.42.0


