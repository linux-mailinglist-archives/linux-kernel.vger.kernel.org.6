Return-Path: <linux-kernel+bounces-347246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3498CFF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECE21C213F1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816F1198A0C;
	Wed,  2 Oct 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Uqb4l/An"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046151974F4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861009; cv=none; b=StuGbv8REO6a18uUmbPs86FsoBVNF7JWJ3jH323FYrbgrd7jbf501Q5DINojVmzeuvnqTa1roOsioqhf/AOL1pZoh2Q/eSyloW1/qJKQjNifH+JESFzN2ZQ0+9fhqxSf6LM6JFVJhyCc50AIzKYNQKdPKzuRR7rvMHEMjfB/pYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861009; c=relaxed/simple;
	bh=rHnHIuSyzhmPhP0FfAgMPg49xxDTPvlg4d1owihhlg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cflkSUyV7Ja9Q44ueT4V2GBhFH5XuVBCsQvssbfhgZXeYHcR492GP1B53WtAh197OVvZ1kllS9yrTXvaQDTOy8MWwu1aoLs0LKNxdmjdXFIepJRIguLLtgQPlxzgmYsat6KdKMWD0V4yQFNrmMtuuYbiAY6mjbODhJW4Whd2Ms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Uqb4l/An; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso3716925e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727861006; x=1728465806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlfjEIyAahvf18dv7sYHryYHa0mCJBKK6mnx44cMQ7Q=;
        b=Uqb4l/Anc8axUKtx6KsimqdWPzxLkPlyP9a4D3Fx/JAebKdlxlaezn0ZehH2EmXOY3
         C9rwFVhyuf7GPV+ZSuAh95bnEgszk3F+UOtFSiXynR+o0/5A8QpZ7WYWrd0X9z112wd7
         ZD59E+I8NyIVpEk+9ZcNwZAYvNO3exkIkMDZaRS3iNEdPX8lMWu0e/yHsQRutGPyqkWV
         xrD5trb4Tag5Bkswp1vk6lc5/m1nitREkXchH93+nrUvMFd2IBjtGD5wcFtu//0bT4s8
         apWtVpEHJ3hcZhpbXQmWgJvLFmlIE7h37Km9lhlxjJz21HVvuHo+KgDQ2M3oo/Ll0Rgv
         bfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727861006; x=1728465806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlfjEIyAahvf18dv7sYHryYHa0mCJBKK6mnx44cMQ7Q=;
        b=wfvw8xvLR00oWjNhz5xV+s7h4BUIikiu/wqKnpX/NsISOQosNm1c2mIORJgCh1WHUP
         BX357XNVWvr7D+QAbD1f3QWDfPNMr+/isf3IsOxVyinmnPLpAVgyN/DuZlhTf7QLeOia
         aEM+UuXc8BfbFajKP2UXOXab/CVcZR5ulMi2OI4tqTzGiK5FbtkRQkiB4cIqh0I/GlY2
         pv0VaoWLc9D7IXIXNrRMbPYYfGDPyBye4v6Oy6wtDIymP8n0+jAXiEME7vN+aM6sp87v
         DceNwJZA+qamdWTTbCIXejVq9RBDg9aA7y+rpKYMTCMM4NU172xujDOBxGY8h0pUsQwK
         6sQA==
X-Forwarded-Encrypted: i=1; AJvYcCV7cxwrTz/g+ZpfAi5pb0CKikd5WhhXeOc5Y9AR09JcUSs51Qy3gApcPs+cEDANXXTk/fgTaqxWRxnKNII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuv8pR02DxodVbb9p345M7mSoNLY5vqvbdPLYeCJgtkkLhOMJn
	0Bv700mUalKVrqLZBCDW8c3nm2nCj2IntsavF2pKpXpYtKx2CWpNy5JKuZIBlOQ=
X-Google-Smtp-Source: AGHT+IEXO3zx+73ZsZBfYY1Gm4EtHfSbEd3IMn7R0Afp07XQzAfFGjOaxi2qGn1hoKttNi+MoTYkQA==
X-Received: by 2002:a05:600c:45c5:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-42f776e0694mr14780645e9.8.1727861006222;
        Wed, 02 Oct 2024 02:23:26 -0700 (PDT)
Received: from stroh80.lab.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ec0a44sm13261905e9.17.2024.10.02.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:23:25 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>,
	krzysztof.kozlowski+dt@linaro.org
Cc: linux-hwmon@vger.kernel.org,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (max6639) : Configure based on DT property
Date: Wed,  2 Oct 2024 14:53:11 +0530
Message-ID: <20241002092313.500993-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove platform data & initialize with defaults
configuration & overwrite based on DT properties.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 drivers/hwmon/max6639.c               | 85 +++++++++++++++++++--------
 include/linux/platform_data/max6639.h | 15 -----
 2 files changed, 62 insertions(+), 38 deletions(-)
 delete mode 100644 include/linux/platform_data/max6639.h

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index c955b0f3a8d3..6eacb5aed96d 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -19,7 +19,6 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <linux/platform_data/max6639.h>
 #include <linux/regmap.h>
 #include <linux/util_macros.h>
 
@@ -531,14 +530,51 @@ static int rpm_range_to_reg(int range)
 	return 1; /* default: 4000 RPM */
 }
 
+static int max6639_probe_child_from_dt(struct i2c_client *client,
+				       struct device_node *child,
+				       struct max6639_data *data)
+
+{
+	struct device *dev = &client->dev;
+	u32 i;
+	int err, val;
+
+	err = of_property_read_u32(child, "reg", &i);
+	if (err) {
+		dev_err(dev, "missing reg property of %pOFn\n", child);
+		return err;
+	}
+
+	if (i > 1) {
+		dev_err(dev, "Invalid fan index reg %d\n", i);
+		return -EINVAL;
+	}
+
+	err = of_property_read_u32(child, "pulses-per-revolution", &val);
+
+	if (!err) {
+		if (val < 1 || val > 5) {
+			dev_err(dev, "invalid pulses-per-revolution %d of %pOFn\n", val, child);
+			return -EINVAL;
+		}
+		data->ppr[i] = val;
+	}
+
+	err = of_property_read_u32(child, "max-rpm", &val);
+
+	if (!err)
+		data->rpm_range[i] = rpm_range_to_reg(val);
+
+	return 0;
+}
+
 static int max6639_init_client(struct i2c_client *client,
 			       struct max6639_data *data)
 {
-	struct max6639_platform_data *max6639_info =
-		dev_get_platdata(&client->dev);
-	int i;
-	int rpm_range = 1; /* default: 4000 RPM */
-	int err, ppr;
+	struct device *dev = &client->dev;
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int i, err;
 
 	/* Reset chip to default values, see below for GCONFIG setup */
 	err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
@@ -546,21 +582,29 @@ static int max6639_init_client(struct i2c_client *client,
 		return err;
 
 	/* Fans pulse per revolution is 2 by default */
-	if (max6639_info && max6639_info->ppr > 0 &&
-			max6639_info->ppr < 5)
-		ppr = max6639_info->ppr;
-	else
-		ppr = 2;
+	data->ppr[0] = 2;
+	data->ppr[1] = 2;
 
-	data->ppr[0] = ppr;
-	data->ppr[1] = ppr;
+	/* default: 4000 RPM */
+	data->rpm_range[0] = 1;
+	data->rpm_range[1] = 1;
 
-	if (max6639_info)
-		rpm_range = rpm_range_to_reg(max6639_info->rpm_range);
-	data->rpm_range[0] = rpm_range;
-	data->rpm_range[1] = rpm_range;
+	for_each_child_of_node(np, child) {
+		if (strcmp(child->name, "fan"))
+			continue;
+
+		err = max6639_probe_child_from_dt(client, child, data);
+		if (err) {
+			of_node_put(child);
+			return err;
+		}
+	}
 
 	for (i = 0; i < MAX6639_NUM_CHANNELS; i++) {
+		err = regmap_set_bits(data->regmap, MAX6639_REG_OUTPUT_MASK, BIT(1 - i));
+		if (err)
+			return err;
+
 		/* Set Fan pulse per revolution */
 		err = max6639_set_ppr(data, i, data->ppr[i]);
 		if (err)
@@ -573,12 +617,7 @@ static int max6639_init_client(struct i2c_client *client,
 			return err;
 
 		/* Fans PWM polarity high by default */
-		if (max6639_info) {
-			if (max6639_info->pwm_polarity == 0)
-				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-			else
-				err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x02);
-		}
+		err = regmap_write(data->regmap, MAX6639_REG_FAN_CONFIG2a(i), 0x00);
 		if (err)
 			return err;
 
diff --git a/include/linux/platform_data/max6639.h b/include/linux/platform_data/max6639.h
deleted file mode 100644
index 65bfdb4fdc15..000000000000
--- a/include/linux/platform_data/max6639.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_MAX6639_H
-#define _LINUX_MAX6639_H
-
-#include <linux/types.h>
-
-/* platform data for the MAX6639 temperature sensor and fan control */
-
-struct max6639_platform_data {
-	bool pwm_polarity;	/* Polarity low (0) or high (1, default) */
-	int ppr;		/* Pulses per rotation 1..4 (default == 2) */
-	int rpm_range;		/* 2000, 4000 (default), 8000 or 16000 */
-};
-
-#endif /* _LINUX_MAX6639_H */
-- 
2.42.0


