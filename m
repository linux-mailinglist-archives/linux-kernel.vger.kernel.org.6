Return-Path: <linux-kernel+bounces-220122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA5790DCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B517E1C24138
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9716EB6F;
	Tue, 18 Jun 2024 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvoxhnbz"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D416DC1C;
	Tue, 18 Jun 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740437; cv=none; b=c2JJzLiHqtBoC4D2az5QWd3Z5E2W466XyQUIWGyDKi9GIu2moyzgFMbWWXJ1RYUB9aGpsHAXI5kdX7MqgZNhuL+5ibYBV2XixbwRlFzDjKzf9QRgy3TnObf6uuO91qC7QqYUm0Zdv/FwfgGOFQ0R0V7BFD6gFmQcqSgJiNIlRCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740437; c=relaxed/simple;
	bh=82spDEIGhtFCgEtCb6qyJ82SA/FC3rJrhTS4o90L334=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gnliciz5ZNpmh49kBB6+hCQamjw21gTPtDl4Fp0olRwSq273sD0sy+4NDa5+mm14g6dTL94e7X+K4/ZT8BIeWdXG3EtBdjpUAqDzyPYVY4uu8GdITIsc+4k7xl5jvtiBUpMQ0kU2L/syDJePS+vBLXNfqXY7fAfy3eqdePQUQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gvoxhnbz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-705c0115192so4948477b3a.1;
        Tue, 18 Jun 2024 12:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740435; x=1719345235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4xI1qGGU9cjMurdZFNvmg32N3b1z8wGZUQlDVo3QRc=;
        b=GvoxhnbziDA3F/tXM5FZ+N2zIaMfCppnZsM6tmlD6eNefBF3cNerFbgavUUUskwnO0
         vMLim7hHNK1UiGx7ziMQLBIvB4tvHNm78tSU0vxR4tnpbOARgHuIMAzLzFM53qzR9PRN
         08xyFknwsRO8ugT3iGjG+Z2uWhrrU0QXpy/faUgJoBjp2zcL/ml9LVM8D9IEFo7ARuQF
         fofRaGoiDqvr2TrPDptgvtw7ZXOHQTlI7LPO5KdYL6q4YBQOZ1uQ/DSN05jqO/clnTzK
         iZbc+B5kW9VMcNQsS0QOqSV6sWifUG7nOgn7JvZLfmNesKbpQ8TSHFjCX5pR8T5hjJZ/
         YHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740435; x=1719345235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R4xI1qGGU9cjMurdZFNvmg32N3b1z8wGZUQlDVo3QRc=;
        b=drHZqWlKL9End8WwjWWgNlZMr3KqmqTj7i+tukrz2OMLncnz0iXC4dcJG7Zpomvt3T
         5UmbZWudqss8clL2QOJS7bgAhwUwiBMILkpIQyFQlXPL0ksmxyNb+vrqcMOzCiG+8qSX
         yS8mA1rzZq2DSGHjHatklCbqlCya0FaAN4vVzI+YBd7U0gVLLgM/NokH5kCRR4XG7LZ4
         1SyEwUm8OqXB10M0Bj9F6BmMIWjLqaV5UEV5JNWEGgqC8rtGgbZLaUwx8IbXMkx4pjje
         GeWKWu+CLoHxTY1hSLCf20aDKW8GqEt3k034KtGmLk7U3fX8tg+/cyV3YAWQ26WI+YEU
         lw6g==
X-Gm-Message-State: AOJu0Yyt9yzv4lOR98AHMAS9Cdad3xZCzmDI1DQDBy0u7JC75E1PjfMi
	O211SqsaMzPR72LsdBdiY8GurQ7Tj1cTBkWPVZhwkrUjIafX7GPoiNI6rg==
X-Google-Smtp-Source: AGHT+IHIPdCTDzuT52NsmK/SHlpshdhRoY3yFcIknwSIvMz//8KnMEs12aDaROr0kh+JKhHagxGrAQ==
X-Received: by 2002:a05:6a00:bc6:b0:705:bfaa:3891 with SMTP id d2e1a72fcca58-70629c4d406mr610172b3a.17.1718740435017;
        Tue, 18 Jun 2024 12:53:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb90a33sm9349382b3a.187.2024.06.18.12.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:53:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Armin Wolf <W_Armin@gmx.de>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Kozachuk <skozachuk@google.com>,
	John Hamrick <johnham@google.com>,
	Chris Sarra <chrissarra@google.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH v2 2/3] hwmon: (spd5118) Use spd5118 specific read/write operations
Date: Tue, 18 Jun 2024 12:53:47 -0700
Message-Id: <20240618195348.1670547-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618195348.1670547-1-linux@roeck-us.net>
References: <20240618195348.1670547-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

regmap write operations on i801 controllers were observed to fail with
-ENXIO errors. It appears that the i801 controller and/or at least some
spd5118 compatible chips do not support the I2C_FUNC_SMBUS_I2C_BLOCK
operation used by the regmap-i2c core if I2C_FUNC_SMBUS_I2C_BLOCK is
supported by the I2C/SMBus controller.

Stop using the regmap-i2c core and always use basic SMBus operations
instead.

Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
Closes: https://lore.kernel.org/linux-hwmon/33f369c1-1098-458e-9398-30037bd8c5aa@molgen.mpg.de/
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/hwmon/Kconfig   |  2 +-
 drivers/hwmon/spd5118.c | 28 +++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index d5eced417fc3..fdfa778a965d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2184,7 +2184,7 @@ config SENSORS_INA3221
 config SENSORS_SPD5118
 	tristate "SPD5118 Compliant Temperature Sensors"
 	depends on I2C
-	select REGMAP_I2C
+	select REGMAP
 	help
 	  If you say yes here you get support for SPD5118 (JEDEC JESD300)
 	  compliant temperature sensors. Such sensors are found on DDR5 memory
diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index d405c5ef755d..995c45e2a997 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -489,6 +489,31 @@ static bool spd5118_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static int spd5118_regmap_reg_read(void *context, unsigned int reg,
+				   unsigned int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(context, reg);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
+static int spd5118_regmap_reg_write(void *context, unsigned int reg,
+				    unsigned int val)
+{
+	return i2c_smbus_write_byte_data(context, reg, val);
+}
+
+static const struct regmap_bus spd5118_regmap_bus = {
+	.reg_write = spd5118_regmap_reg_write,
+	.reg_read = spd5118_regmap_reg_read,
+};
+
 static const struct regmap_range_cfg spd5118_regmap_range_cfg[] = {
 	{
 	.selector_reg   = SPD5118_REG_I2C_LEGACY_MODE,
@@ -526,7 +551,8 @@ static int spd5118_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
-	regmap = devm_regmap_init_i2c(client, &spd5118_regmap_config);
+	regmap = devm_regmap_init(dev, &spd5118_regmap_bus, client,
+				  &spd5118_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
 
-- 
2.39.2


