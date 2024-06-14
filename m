Return-Path: <linux-kernel+bounces-214379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C590836F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF58128371F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283091482E6;
	Fri, 14 Jun 2024 05:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BBu7Aado"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AA1474BA
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344545; cv=none; b=ngSExhhU8DW1OV3pxzKkCT2IC/glTfi+RcBcMjtXy5s2rs0wwQ92Wl9ZMbVwIqiXtR/SN4Fih7R11cdreiD+B3XNVP45NLhW2KslsccqjtOTdQJ6VF87cABGbQjuJSZc97EaulG//KFxc0gNAteKk8lmJEsVCldfhoocuEeOix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344545; c=relaxed/simple;
	bh=Pa6jI99d+sC+RqKa/RilQaFsQvQoyIuPVKJo4RrDMVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ip7K49/dTCdk79Bkr8KRCaUo7byf/Hl9jSQRJkS58Fo0egZfjJTw0rga8tqDUeFzfRoCFGo2x/+GMyjhdz8TV/HZQ6x+5/+2BkoIRrzPFMSSzHWdjS30To2QR8upaRaGZmp/8EQR+xPZ0btpF0YDuFU/lDgM5lewk3wyH9h51xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BBu7Aado; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421eab59723so14468415e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1718344541; x=1718949341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atieE0lcxb/9U93M0barRDrZi7dMCPkgBP2Rd6ay3bE=;
        b=BBu7AadoYh2kXZHZfnre/B4XRO9Kcg4c3TJQIcSp8JLrw4XKAUyKEpYBi0zQfnDe8R
         XTWZDKmC/n5xhq7ku63JZv2p1AmylvM8cox+HtgBooVEa9Dgd1vqGACQHjG3hjR2GYtF
         K8OaV7NV1n3vnFyemP69eg6kfA1OyIcxuBfQveLl+SHduIwBeq4iFslsBD6Ob3E+QM2L
         vCZOQ7q1Hhpo1QutwUZoPmuGc4iXmM5ci4gPEELSKJ8c0KPuvG0onqbLVasJzyncvTGH
         bEFyk7+TD6OruIG94lgQDaUk8hojrIIeoN2m8cWd6Ga2nFTgyb4272iR458i4aVKFmF6
         TOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718344541; x=1718949341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atieE0lcxb/9U93M0barRDrZi7dMCPkgBP2Rd6ay3bE=;
        b=Na0aeFwPPzKRW63fiJXLQVHVfbVOTIBJ3sau96J5Rb5YbDNqIp6Y51eAg2JoIomrY8
         3CkvvAHraCbD8/kG36GGEWHfmXUZRlo/QcSXuffxNbiPnT8YdNNDP0imWWx7ZoIvwy23
         RJaKRKDXB5qFqrS3qvVZ9QU9tlnNV48s8X82aJZ7LLTOmJuSGw696umKjrvAXCswXwMp
         //WV3z+7vn3QOii7Iy218c+QqE4FTCIfOAb7pnAP/3nn6xdl4i1ENwcQKoapa2xlCIiN
         fOHAkRB1pxZPs5+KiTFZAm1TMoKI3hqCOe7HtSLjuFZEIq60kPJjCSWUmnzAoimi8UtW
         RQqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4H+RlXQgWE/3ZWjkn9rwTir9ifCIwGJ6VCQ7vjG0qVEXqsRr2GyZLe104bLdg1bC69SvOPxLSIjkuqGfVI+A495E6DGwbT2wIYvZS
X-Gm-Message-State: AOJu0Yw8DbHQ93NpECPlwnbJzEHm9tMgv7zWhQG5xdEzLHM7xy/nWgGy
	PMqUWMFhEMlPCAEbTob7VqXWQUUWK6H/nCp89jAw7UkE0x+Grbd/GEBJKnsck/Q=
X-Google-Smtp-Source: AGHT+IHRj4bq/LBSzth+tkBe/3uo7sudhZhCr/LdWnF6gTghRo1IW7OIjDzA2oKro9sLg4cY2HguzA==
X-Received: by 2002:a05:600c:3516:b0:421:de31:8b with SMTP id 5b1f17b1804b1-423048440d8mr15042905e9.27.1718344541629;
        Thu, 13 Jun 2024 22:55:41 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423072c21dbsm5190605e9.4.2024.06.13.22.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 22:55:41 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] hwmon: (max6639) : Add hwmon attributes for fan and pwm
Date: Fri, 14 Jun 2024 11:25:31 +0530
Message-ID: <20240614055533.2735210-2-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240614055533.2735210-1-naresh.solanki@9elements.com>
References: <20240614055533.2735210-1-naresh.solanki@9elements.com>
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
Changes in V5:
- Remove unnecessary IS_ERR check.
- Add mutex
---
 drivers/hwmon/max6639.c | 90 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 45ed629c6af9..091a4a0abd27 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -76,6 +76,7 @@ static const unsigned int freq_table[] = { 20, 33, 50, 100, 5000, 8333, 12500,
  */
 struct max6639_data {
 	struct regmap *regmap;
+	struct mutex update_lock;
 
 	/* Register values initialized only once */
 	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
@@ -232,6 +233,9 @@ static int max6639_read_fan(struct device *dev, u32 attr, int channel,
 			return res;
 		*fan_val = !!(val & BIT(1 - channel));
 		return 0;
+	case hwmon_fan_pulses:
+		*fan_val = data->ppr[channel];
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -243,6 +247,33 @@ static int max6639_set_ppr(struct max6639_data *data, int channel, u8 ppr)
 	return regmap_write(data->regmap, MAX6639_REG_FAN_PPR(channel), ppr-- << 6);
 }
 
+static int max6639_write_fan(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct max6639_data *data = dev_get_drvdata(dev);
+	int err;
+
+	switch (attr) {
+	case hwmon_fan_pulses:
+		if (val <= 0 || val > 5)
+			return -EINVAL;
+
+		mutex_lock(&data->update_lock);
+		/* Set Fan pulse per revolution */
+		err = max6639_set_ppr(data, channel, val);
+		if (err < 0) {
+			mutex_unlock(&data->update_lock);
+			return err;
+		}
+		data->ppr[channel] = val;
+
+		mutex_unlock(&data->update_lock);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static umode_t max6639_fan_is_visible(const void *_data, u32 attr, int channel)
 {
 	switch (attr) {
@@ -262,6 +293,7 @@ static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
 	struct max6639_data *data = dev_get_drvdata(dev);
 	unsigned int val;
 	int res;
+	u8 i;
 
 	switch (attr) {
 	case hwmon_pwm_input:
@@ -270,6 +302,28 @@ static int max6639_read_pwm(struct device *dev, u32 attr, int channel,
 			return res;
 		*pwm_val = val * 255 / 120;
 		return 0;
+	case hwmon_pwm_freq:
+		mutex_lock(&data->update_lock);
+		res = regmap_read(data->regmap, MAX6639_REG_FAN_CONFIG3(channel), &val);
+		if (res < 0) {
+			mutex_unlock(&data->update_lock);
+			return res;
+		}
+		i = val & MAX6639_FAN_CONFIG3_FREQ_MASK;
+
+		res = regmap_read(data->regmap, MAX6639_REG_GCONFIG, &val);
+		if (res < 0) {
+			mutex_unlock(&data->update_lock);
+			return res;
+		}
+
+		if (val & MAX6639_GCONFIG_PWM_FREQ_HI)
+			i |= 0x4;
+		i &= 0x7;
+		*pwm_val = freq_table[i];
+
+		mutex_unlock(&data->update_lock);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -280,6 +334,7 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
 {
 	struct max6639_data *data = dev_get_drvdata(dev);
 	int err;
+	u8 i;
 
 	switch (attr) {
 	case hwmon_pwm_input:
@@ -287,6 +342,28 @@ static int max6639_write_pwm(struct device *dev, u32 attr, int channel,
 		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(channel),
 				   val * 120 / 255);
 		return err;
+	case hwmon_pwm_freq:
+		val = clamp_val(val, 0, 25000);
+
+		i = find_closest(val, freq_table, ARRAY_SIZE(freq_table));
+
+		mutex_lock(&data->update_lock);
+		err = regmap_update_bits(data->regmap, MAX6639_REG_FAN_CONFIG3(channel),
+					 MAX6639_FAN_CONFIG3_FREQ_MASK, i);
+		if (err < 0) {
+			mutex_unlock(&data->update_lock);
+			return err;
+		}
+
+		if (i >> 2)
+			err = regmap_set_bits(data->regmap, MAX6639_REG_GCONFIG,
+					      MAX6639_GCONFIG_PWM_FREQ_HI);
+		else
+			err = regmap_clear_bits(data->regmap, MAX6639_REG_GCONFIG,
+						MAX6639_GCONFIG_PWM_FREQ_HI);
+
+		mutex_unlock(&data->update_lock);
+		return err;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -296,6 +373,7 @@ static umode_t max6639_pwm_is_visible(const void *_data, u32 attr, int channel)
 {
 	switch (attr) {
 	case hwmon_pwm_input:
+	case hwmon_pwm_freq:
 		return 0644;
 	default:
 		return 0;
@@ -401,6 +479,8 @@ static int max6639_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
 	switch (type) {
+	case hwmon_fan:
+		return max6639_write_fan(dev, attr, channel, val);
 	case hwmon_pwm:
 		return max6639_write_pwm(dev, attr, channel, val);
 	case hwmon_temp:
@@ -428,11 +508,11 @@ static umode_t max6639_is_visible(const void *data,
 
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
@@ -643,6 +723,8 @@ static int max6639_probe(struct i2c_client *client)
 		}
 	}
 
+	mutex_init(&data->update_lock);
+
 	/* Initialize the max6639 chip */
 	err = max6639_init_client(client, data);
 	if (err < 0)
-- 
2.42.0


