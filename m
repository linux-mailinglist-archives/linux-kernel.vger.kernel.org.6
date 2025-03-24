Return-Path: <linux-kernel+bounces-574266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56697A6E2D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B2F17032D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8945E266F1A;
	Mon, 24 Mar 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="FyaYr9nE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752C266F12
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842690; cv=none; b=tZLQgRaaTnaiw9N23+OsIHn0reahlEIxs7J/bYdolPOcIiADaLrJkQal9+MXJagp5aMu+K1I01eoivRRBtQ3nWFZsJZmQN37gNRD3g79n6yEAYsb9QSfzcoDNo/uLSl2CJ8hRZNk97mSqLG4T/gnk8uX1QGLRsAwu5L/XaGxOtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842690; c=relaxed/simple;
	bh=JtCj9yaYLLnbWrZGwWO77vDysRJOjp9RTmqAEhYmjTM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWbOlGV/H8xQIhusIDhZQK8G/bcacIZkhyErUK/Y4VpEb+VgJzFkRR7JPH5BWngU9E5RKrQc2+wocb57y/PqA7YLmpBuFXo+viOoqbQ9ccJYLVa7es/LWvxUcue86a/l2fXykL2DI/gEo8SpElzFRScLz5ByvxKKzZ0L1jZqBmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=FyaYr9nE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso52155835e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1742842687; x=1743447487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9PuYVarMebmU2p+Nlydwxr1Lr80Vi57j8nI2AO9zgc=;
        b=FyaYr9nEpH05qGNR+I0h0Pguc3NHzfikDKuPwLvwvfFJhO+ds6WJTb/IKmPBcWptUf
         SssIpcSGjplPYjarV4bnddOge475Jm8iKfC5cjU8U1EEaCvClNeWouZ87A3tqGrlxd+f
         zdppviVKKQ38y8YljQ7GcSzvuu0pKHQZ/TmPeW8/5Jx+TkwqLfbLkxUPfq8pAKnJYzVO
         ESvqX7tYwdHe4B6R42JLqSixz7h0hGV3+jVTGGZdqU/DgL0fMEGKIxl3f8es0N1w3SLc
         jMhJSlZOJ2JOGU+ZrBVxrWSLdjuiBHhg0DEYUcY3kkCQum5raX/fwKaydk21DgNmtLdp
         jX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742842687; x=1743447487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G9PuYVarMebmU2p+Nlydwxr1Lr80Vi57j8nI2AO9zgc=;
        b=BqFl83fOD6AtnTzJNjmbh45Ra25Cok8duPzzjBFGlUdYYH/7K0MO2lJ9AQQNXXZVcD
         WqKKA81M/ORQurxUf8i1LDJfVr2rLDQApZgvFRx1xgnF8gK83NFAOZas4cZl/kitRsCo
         TB8m1J7Pt3qjA7IYgJ4GedjVVy7E+bkYGci4bZOOD8Lxfm2deF6W3FEhJiagT50BrHbr
         HSt08aV1ObmZxiHeWJ09hHn5y2Vn2wQ/HLdrTPVrTopCfJ70gKq0co6CPz0vo1KOwVY6
         ybqpNH1EdjqCsKFyCY9ztZmP3LdOckxRpb/Ra0mMqlTKrW1hGP6KHuiuahV3uVwUDfVA
         tNSw==
X-Forwarded-Encrypted: i=1; AJvYcCXGxG+GagjSNu8fAu0V9FcwiwWUQOT90eSHzJdxV0+gyD4EIbuueaz2dw1UjyQIkp51r+TVxvOXoz26n/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcEzperTOgF1DrqCEaOPqKM9JWiHHS24e8+aYj5fEMTgbcIRGm
	No4pF8w44r1wUQPpH6m/5301U1/Hk5U0/ujaEpcV2y9GrVHYAn82kg0XmkN0tO/yHSNLdBbOYtM
	Q
X-Gm-Gg: ASbGncv63r8N2n61Ph1+taoJQG/yJB9pbptLpDh41CEIdD1HbtuzqUE7uK82Q2doCi6
	Z4WQHnXPyiU2Xn8p1pF7loomIyzyfW68yNsa+KKtft+BCbv4jOl5f+KJzRT+45SRMIFnWSbYrVq
	T6kXnux9DdyBHDc7LRQFWmX+m6GT+dKWtpmkfsMnpRy513p7fCcSK4cBl0KL5L6xoR9Yi8qHhsI
	0kd2Tdf9ZwQbUMB8LgdPutMnmsm/4NvC4CQ0NCKDHixDJ9fZuJEhFGtz6jFkjxp1+bqAC/clBRU
	2ahrQW/oxq3ApIE79aqtp8UxopuPuYI1SUd511PqAPRByY4sehvv8vbpU+z+DsG+zDnIr7ayPG4
	A2uqvvNdy1pYttwgf9k08oOQ=
X-Google-Smtp-Source: AGHT+IF1prRGm/Bf5jF5cqB1ZVz5ARRbqEYu2aNlBhCbEo50tZLCWap2fGA+duSbPS2otwQmiAJ+Og==
X-Received: by 2002:a05:6000:178b:b0:391:4c0c:c807 with SMTP id ffacd0b85a97d-3997f942453mr13583965f8f.53.1742842686783;
        Mon, 24 Mar 2025 11:58:06 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d3bb2b2ffsm156670915e9.1.2025.03.24.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:58:06 -0700 (PDT)
From: Your Name <naresh.solanki@9elements.com>
X-Google-Original-From: Your Name <you@example.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH] hwmon: (max6639) : Allow setting target RPM
Date: Tue, 25 Mar 2025 00:27:44 +0530
Message-ID: <20250324185744.2421462-1-you@example.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Naresh Solanki <naresh.solanki@9elements.com>

Currently, during startup, the fan is set to its maximum RPM by default,
which may not be suitable for all use cases.
This patch introduces support for specifying a target RPM via the Device
Tree property "target-rpm".

Changes:
- Added `target_rpm` field to `max6639_data` structure to store the
  target RPM for each fan channel.
- Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
  property from the Device Tree and set `target_rpm` accordingly.
- Updated `max6639_init_client()` to use `target_rpm` to compute the
  initial PWM duty cycle instead of defaulting to full speed (120/120).

Behavior:
- If `"target-rpm"` is specified, the fan speed is set accordingly.
- If `"target-rpm"` is not specified, the previous behavior (full speed
  at startup) is retained.

This allows better control over fan speed during system initialization.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/max6639.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 32b4d54b2076..ca8a8f58d133 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -80,6 +80,7 @@ struct max6639_data {
 	/* Register values initialized only once */
 	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
 	u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
+	u32 target_rpm[MAX6639_NUM_CHANNELS];
 
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
@@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 	}
 
 	err = of_property_read_u32(child, "max-rpm", &val);
-	if (!err)
+	if (!err) {
 		data->rpm_range[i] = rpm_range_to_reg(val);
+		data->target_rpm[i] = val;
+	}
+
+	err = of_property_read_u32(child, "target-rpm", &val);
+	if (!err)
+		data->target_rpm[i] = val;
 
 	return 0;
 }
@@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
 	const struct device_node *np = dev->of_node;
 	struct device_node *child;
 	int i, err;
+	u8 target_duty;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
@@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
 		if (err)
 			return err;
 
-		/* PWM 120/120 (i.e. 100%) */
-		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
+		/* Set PWM based on target RPM if specified */
+		target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), target_duty);
 		if (err)
 			return err;
 	}

base-commit: 2115cbeec8a3ccc69e3b7ecdf97b4472b0829cfc
-- 
2.42.0


