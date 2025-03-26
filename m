Return-Path: <linux-kernel+bounces-577538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C8A71E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5907A693E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A95254841;
	Wed, 26 Mar 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="URwSCX+i"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B674C253B75
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743013785; cv=none; b=LpqIccs3qEDdNkVpCWRvBvb6UnkW+48eTa3U2mnEttC2QOvtwJWwJdbywedknoxTmOYo/lGIIbqEbwX/aDkHUpMo6cEMJHpjOKuHcOrrgVyzvLMCnBmKVC/PB5eJvRDWjYWnwBI67yYPH23EDzHX+zQRe/2y296pzLTtqgrh02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743013785; c=relaxed/simple;
	bh=PDZ8wopAz0p6dRYwWVh9TziS/j8jc0WTBI7vNoZgTPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PckseQrkfg8g0tG4KiHNYCQ5aM8MjiNHLuhAf9mBoQMpD4l8uVAq9wo6AXOYBgzN93RCBQmUVDqqiSdVqhkHDUzrPvDBntPKikkcyFiCj6UXxCA62Wpk4PdreDP39iaN/xv6yD8vHy167HU/QD981PLgOsPLux/nsO1+J+AdK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=URwSCX+i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso1634065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1743013782; x=1743618582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=doiI8VQYK1ufpJ8YlTdC9R6WZr99FG3ISjHW2FSinYk=;
        b=URwSCX+ihvsJzf7tI0ZSdhBk3QU0qftUzhrloGCAXkfD9Dso5Fufmuo7VVTPqEWrHl
         vIA9TjAltN0BZeEK+sKyJO/XAdQl19NA0Guc1Bi1qwqo9uUyxNaKCCtP1oYN1Ye9xh4S
         1wZ85SpKeokFjGJ+P60UZtRqubpt/m1j705X2o9ldIRltHRALUpj8+terYfkkgCMTPdd
         /D/99CgkWYa6jLTbSGv0BawRNvQJwU7F5N5sHEirVXcZir6te4ySwouZkt8LgJwCXrBu
         O8OFtVy9ks6zqfarjCxaW0Z2ZaC4LkUpLInj7GOxFwKoZroUZxOczLV58vLzaN/s9H1j
         KsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743013782; x=1743618582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=doiI8VQYK1ufpJ8YlTdC9R6WZr99FG3ISjHW2FSinYk=;
        b=vdcSYhi0ut6nqlyxmZ8jWpbw3ZdiXt4sMNzGPNt+UAM4nC6MedeOAtuYOQPTdFwjQl
         ckqIh1OevjvXB2oLR2biBWw++miU/BpBG59Zt8sX3dyYTdg1hQSjOWE1mV4t+wmdK1oQ
         rgju3U1+vyuA7TbERxLJYDCTtYqmk33Me/mkMixIqG7mF0TU6bAOWJyuw2UzLTyLKqRw
         pQZYosriZZW4QVc3FbWhI64MqEMFuo/QeBtpRvzft1sy/F1Kqqmqq8Tg7ufog26yfTxe
         SwsShwO7CsOXV+Aak2GnaMGjRr0IOttuzGVbdbTk9EJhonEamQkOvFzOXdW2XtD/HaCr
         7i2A==
X-Forwarded-Encrypted: i=1; AJvYcCWgYPiSUsi2tn8cAWp28EyR+0P9+EP6TbDhM08a2WPpLnxFEImKV1GMGLlXW1bhoEUpoXoyDa4Za0c3ORc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtKRn9cWo7Sgx4yld6+3WNUGaU4ij4HhZGzkIbg+K1Q7AosAQ
	jzsV2USaPKPx93H2UmvZh457vXHh8wqRTc2lDtfzYH6x1PCKxVLeQDjLmuZIcP8=
X-Gm-Gg: ASbGncvCZF0mpSjXKTp0oFm09u5PF2Rh4AmKtAk/FO5OkPPLzKWNAEm22fjuHfuWV+M
	ijpilf3cvQRTDeF83w3kQJL0NDWFpthUoN7YSCnSbVI1rRC4azvUVPKyY6fCh8LWa29DtybCBhN
	7CMfmEREOGhbsBTL1jBcC1PTphT1z6tvx8WQfcZlxkfLRqdsjhTeElLnY3BLG5UjE/3dtVeC2bi
	quiujCINczfGvvnUNKj5jfj7WqJ8F+8KDZekHbITNBtiWzherHTkj84mYIfGzNqQ4iBh1SZQA1X
	Wg62RkVZBeyp8dehq6rFVsC23kxxS3qU4Ot8+ddTLSse7tVpZTbjRYCMxMQiHVLX62msaHmDNl3
	Y/7MrMd3GV/HPKBUdh916+D8=
X-Google-Smtp-Source: AGHT+IF2MZpiu92yHIU+59dZVRjDDyFa3Tjv0B+1mWBMDC3uJdGqLs5MgcCa4MS7uzSp96Ie82P+Ew==
X-Received: by 2002:a05:600c:154d:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-43d85065ac4mr3922725e9.22.1743013781770;
        Wed, 26 Mar 2025 11:29:41 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82dede2csm10331495e9.5.2025.03.26.11.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 11:29:41 -0700 (PDT)
From: Your Name <naresh.solanki@9elements.com>
X-Google-Original-From: Your Name <you@example.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Subject: [PATCH v2] hwmon: (max6639) : Allow setting target RPM
Date: Wed, 26 Mar 2025 23:59:37 +0530
Message-ID: <20250326182937.513062-1-you@example.com>
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
Changes in v2:
- Pre-init target_rpm[] to 4000 RPM
- Validate if target_rpm[] is within configured range.
---
 drivers/hwmon/max6639.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 32b4d54b2076..a06346496e1d 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -80,6 +80,7 @@ struct max6639_data {
 	/* Register values initialized only once */
 	u8 ppr[MAX6639_NUM_CHANNELS];	/* Pulses per rotation 0..3 for 1..4 ppr */
 	u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
+	u32 target_rpm[MAX6639_NUM_CHANNELS];
 
 	/* Optional regulator for FAN supply */
 	struct regulator *reg;
@@ -563,6 +564,10 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
 	if (!err)
 		data->rpm_range[i] = rpm_range_to_reg(val);
 
+	err = of_property_read_u32(child, "target-rpm", &val);
+	if (!err)
+		data->target_rpm[i] = val;
+
 	return 0;
 }
 
@@ -573,6 +578,7 @@ static int max6639_init_client(struct i2c_client *client,
 	const struct device_node *np = dev->of_node;
 	struct device_node *child;
 	int i, err;
+	u8 target_duty;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
@@ -586,6 +592,8 @@ static int max6639_init_client(struct i2c_client *client,
 	/* default: 4000 RPM */
 	data->rpm_range[0] = 1;
 	data->rpm_range[1] = 1;
+	data->target_rpm[0] = 4000;
+	data->target_rpm[1] = 4000;
 
 	for_each_child_of_node(np, child) {
 		if (strcmp(child->name, "fan"))
@@ -639,8 +647,12 @@ static int max6639_init_client(struct i2c_client *client,
 		if (err)
 			return err;
 
-		/* PWM 120/120 (i.e. 100%) */
-		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
+		/* Set PWM based on target RPM if specified */
+		if (data->target_rpm[i] >  rpm_ranges[data->rpm_range[i]])
+			data->target_rpm[i] = rpm_ranges[data->rpm_range[i]];
+
+		target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
+		err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), target_duty);
 		if (err)
 			return err;
 	}

base-commit: 2115cbeec8a3ccc69e3b7ecdf97b4472b0829cfc
-- 
2.42.0


