Return-Path: <linux-kernel+bounces-347517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF298D3C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6929B281CD2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28351D0154;
	Wed,  2 Oct 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="T0eI2V+U"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AEB1D0140
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727873712; cv=none; b=n1x8VWRaPdfiDnXRTeQpJ5iHyiKD6YZQKjf/PRU1A1sGi/U+uklp3kqIaRfqwTgd3tyYdOOn2SqDaK5AeWAzx655UiadW5bmFhUOh8r3sshhe2A4N8ETuvo9Ufda6vi0EooRAnrRzroj4DyZaukY6Qlc2XDnKFwrmOx/2mJy1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727873712; c=relaxed/simple;
	bh=o+7MfBcSo1cEj+gPO+Bc7ROdWQdGBoQVw48ed1Ks3oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZnCWCSJys7zUGQqHtpJeMAajC4Udh+tcxybFXgGSSxcRuapIcRNGi/oDhaJjlpIBXYvsp1wrlnaWGrphNzg4KfrsIRq5SltkpwsfI/9CpVm+kPz+xCpPLl+nPaNBjjdyXuXJVnwQqtPKqWFCazmri2hgkaUCeFNq2iT4MmiMTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=T0eI2V+U; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so61181045e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 05:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1727873708; x=1728478508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1H1BT1k+rsiEeG0X+EheDN0MUsJLsJJbxjzEet5tn8E=;
        b=T0eI2V+Um0pZCzJ17YQ5a2vYflJhxiVKqcLMvyKZMP2uG67g+Ad2gAFCV1lBHWrgn5
         9pOi3TWJ0KQGIYf5Tl6OvJJU1EmBGV9M5vKH7x4eBxu3NRCKQ5qrm9bDP0clRLBngW3m
         R/jT+EDN7iXlta8rk18HltegSncqO9ZfNl0FzYI59QAMlMdeyOKrt7Q4Z/92p4Z2uvlw
         2mIHl6QzqasIdz4TfKZazmXP4JUYWtnznamGCFkaODt8hEvMl1cRBs5ZWLOdM0a396X4
         q+PYIL/yBuY5HfUrhgFxu30veCfmtkG+hKaPT/2xHHME4IV4N+EzfHCQVLiCozHijzTl
         kSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727873708; x=1728478508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1H1BT1k+rsiEeG0X+EheDN0MUsJLsJJbxjzEet5tn8E=;
        b=GAOOczzdvcojgtk3+01qzN+tugnuk1O1qxcV1d4v997bNza6685U+ArTijaKsUrV2A
         3p6evyUcZwCfach6WJov2xIBbTEb9d+WqMGoUXYhVFxCZJq0gaBOHGeEVtoPigR1dx2D
         /uHwMzo2EZMEXmBmKWyDGFx5wxFTI9TrgwSbIEogGxXpZvF1c65aN5ve1Ji5cSfKJXBN
         qkFpO9G9g08ybSTiyx6HXfjf7+3pXfzCvNJNUXeTTYtYRkRKKB9buScY4h7V2ukhsort
         Jgjl/D5rw/dqV6sQ5BdbL5gS44BilrgM+Iu6WS/V4XC19lvzIlVcFivYUk9RpC4p62Lo
         0txw==
X-Forwarded-Encrypted: i=1; AJvYcCXyBBsLsXnsqgGS+5UgksodtejGreIe4H17cwVul21msKjCuIdwwsLsKyRVmG9pqxqsDpvraIhL7JYjc/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlY81R+Hw9Qpg5J+mUmZreggNpJrmKlCyBm07rJeGFoTTvN27v
	3XFFG5p6mxJ+5PkIX2i+yevJ+NrW5swrXzT3+f619k2rqizwCPmk7PyRFt6NoTw=
X-Google-Smtp-Source: AGHT+IHRPKjXJnH3CqdEHgh0jvVZrVXMyB0gaydTxZ3Di1VnDfVb+gzUKotf2HVuQ5YPoECyL3sn/Q==
X-Received: by 2002:a05:6000:a84:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-37cfb8c0283mr2049217f8f.19.1727873708125;
        Wed, 02 Oct 2024 05:55:08 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd572fd9asm13934352f8f.75.2024.10.02.05.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:55:07 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Lee Jones <lee@kernel.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: max5970: Drop unused structs
Date: Wed,  2 Oct 2024 14:54:58 +0200
Message-ID: <20241002125500.78278-1-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After splitting the max5970 into a MFD device clean the remaining
code and drop unused structs.

The struct max5970_data and enum max5970_chip_type aren't used.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/regulator/max5970-regulator.c | 21 ++++-----------------
 include/linux/mfd/max5970.h           | 12 ------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/drivers/regulator/max5970-regulator.c b/drivers/regulator/max5970-regulator.c
index 4a568b1b0107..fc14177ddf5d 100644
--- a/drivers/regulator/max5970-regulator.c
+++ b/drivers/regulator/max5970-regulator.c
@@ -485,7 +485,7 @@ static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
 }
 
 static int max597x_adc_range(struct regmap *regmap, const int ch,
-			     u32 *irng, u32 *mon_rng)
+			     int *irng, int *mon_rng)
 {
 	unsigned int reg;
 	int ret;
@@ -552,7 +552,6 @@ static int max597x_setup_irq(struct device *dev,
 
 static int max597x_regulator_probe(struct platform_device *pdev)
 {
-	struct max5970_data *max597x;
 	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	struct max5970_regulator *data;
 	struct i2c_client *i2c = to_i2c_client(pdev->dev.parent);
@@ -566,26 +565,18 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	max597x = devm_kzalloc(&i2c->dev, sizeof(struct max5970_data), GFP_KERNEL);
-	if (!max597x)
-		return -ENOMEM;
-
 	rdevs = devm_kcalloc(&i2c->dev, MAX5970_NUM_SWITCHES, sizeof(struct regulator_dev *),
 			     GFP_KERNEL);
 	if (!rdevs)
 		return -ENOMEM;
 
-	i2c_set_clientdata(i2c, max597x);
-
 	if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5978"))
-		max597x->num_switches = MAX5978_NUM_SWITCHES;
+		num_switches = MAX5978_NUM_SWITCHES;
 	else if (of_device_is_compatible(i2c->dev.of_node, "maxim,max5970"))
-		max597x->num_switches = MAX5970_NUM_SWITCHES;
+		num_switches = MAX5970_NUM_SWITCHES;
 	else
 		return -ENODEV;
 
-	num_switches = max597x->num_switches;
-
 	for (i = 0; i < num_switches; i++) {
 		data =
 		    devm_kzalloc(&i2c->dev, sizeof(struct max5970_regulator),
@@ -596,13 +587,10 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 		data->num_switches = num_switches;
 		data->regmap = regmap;
 
-		ret = max597x_adc_range(regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
+		ret = max597x_adc_range(regmap, i, &data->irng, &data->mon_rng);
 		if (ret < 0)
 			return ret;
 
-		data->irng = max597x->irng[i];
-		data->mon_rng = max597x->mon_rng[i];
-
 		config.dev = &i2c->dev;
 		config.driver_data = (void *)data;
 		config.regmap = data->regmap;
@@ -614,7 +602,6 @@ static int max597x_regulator_probe(struct platform_device *pdev)
 			return PTR_ERR(rdev);
 		}
 		rdevs[i] = rdev;
-		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
 	}
 
 	if (IS_REACHABLE(CONFIG_HWMON)) {
diff --git a/include/linux/mfd/max5970.h b/include/linux/mfd/max5970.h
index 762a7d40c843..fc50e89edfaa 100644
--- a/include/linux/mfd/max5970.h
+++ b/include/linux/mfd/max5970.h
@@ -16,18 +16,6 @@
 #define MAX5978_NUM_SWITCHES 1
 #define MAX5970_NUM_LEDS     4
 
-struct max5970_data {
-	int num_switches;
-	u32 irng[MAX5970_NUM_SWITCHES];
-	u32 mon_rng[MAX5970_NUM_SWITCHES];
-	u32 shunt_micro_ohms[MAX5970_NUM_SWITCHES];
-};
-
-enum max5970_chip_type {
-	TYPE_MAX5978 = 1,
-	TYPE_MAX5970,
-};
-
 #define MAX5970_REG_CURRENT_L(ch)		(0x01 + (ch) * 4)
 #define MAX5970_REG_CURRENT_H(ch)		(0x00 + (ch) * 4)
 #define MAX5970_REG_VOLTAGE_L(ch)		(0x03 + (ch) * 4)
-- 
2.46.2


