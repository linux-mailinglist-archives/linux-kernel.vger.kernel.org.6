Return-Path: <linux-kernel+bounces-197582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEF98D6CB9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E68F28A65F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91282D72;
	Fri, 31 May 2024 23:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vja/C/aN"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9A31311A8;
	Fri, 31 May 2024 23:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196770; cv=none; b=VOeHhl6wnxAjhdR3oO4/C+fKdK6hpjT4epUGn0o5B8na9fAP81e/HCg5PfxUbeRJHtQQp41Es0XLW4tJ7Fh5nlHcGz6+shse/WGN5eXdCiGw0otwEbWH1lJe/5QFGUZnDPVNylySFVujNbSj/HakjDwPnR9r2V0Pq3xl6gBXirE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196770; c=relaxed/simple;
	bh=NLXdBYP5xSDSZwdoBKv2u1+dSJvbzLgheG/Iu5/zJlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bw8EprTjag9ECjPae6faxccTSsgQ/5DY5my7STipWcFGy58fpB21AlQ1hYoxpzQrRGW9FkB9zONbI94RSTrR0/sAoq640UJ8zvKQ9qjXP4+qFPPdl6E8Zmc7AbhhAvvBY7YO7anPn/BHsWJFK6SC7/M5I22lSuCPJ/JgT531S3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vja/C/aN; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6c7bf648207so111426a12.0;
        Fri, 31 May 2024 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717196768; x=1717801568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCn4zu6cFuoPtIrWcHmiUd/3HvSWfOyTPCkZwL/CbAg=;
        b=Vja/C/aNt5+EqISkaVgvDR5Tyr2m652bb/j9Z+Mb8TQLvKONIPmF6ikC7yoYdXFn9H
         zOZj025o6S+wU0TktffUeo0oVQj91l04AMsTP/kGVdWBn5vb3j3FiQRKr1251rbWXFUJ
         ApY39qRYAAk/f1xXPqrk0XAMmnEBuzn9WNY8HzhTmVU/O5e/EKc2mAMqRqYB+RWXKJNu
         FxGNSVxKYofRMrDTVx+QY3EpBce1bnr6oniO/UYgvyqo54FH3A0Ybah7Au1Z8V7YI/2Q
         UOGy7sMeWekNsIczEn8YffdhsAybHzW+dupCrDlbCUxDnyJ6+7ttSY3nhONH2Tip13p2
         zYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717196768; x=1717801568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCn4zu6cFuoPtIrWcHmiUd/3HvSWfOyTPCkZwL/CbAg=;
        b=obAzuMzWhpC4w37Nic17Ecvtjs+XQJMh6pln7JDbt8mA27bG79cBuGKkV9UeBn4bif
         9NMT6/ZpeItAgeZINZ7X3jfAGCKERcdjhPkpVd/lmfQHK7cW2hnBH7tT2vfJsBCRDEnk
         RczwUlNwu4mAY15ZSLvpfFWJcfBTri/VPtqLRHMiAYrBsFvgWK/iLWA3MnTqaUQ655t/
         5MwwejdWyHfDuXCAbpPrUPmimiqzCXt/DrH72TP4xZJrOIEtvErKmBcEr7uZ05qOWeMT
         9JOnvpMOPc6CuxyJeqYI+kpAxPnQ5tcVnIQowW3eiQm4fmmTepB9Rr3d644GJMATI65N
         n7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWSfUVHP74JYUqXbxpeHViijhpEyodai76RXeP0bUIzgeUSEpQk4zoYlIp/ZWux0kY4CgxbDmspC9Ac0oc77ncSZlE61cTEzttWctC
X-Gm-Message-State: AOJu0YxKAnF79JNZrt9dT8GeTLw9UOvG7egrajveZyOwtCUKB1yTiBMo
	zd8+Bfy9jxWNMxzhjXB+Psw4JKcC5GF9C4KGeG3YAAqWIezEIN5T20nY/w==
X-Google-Smtp-Source: AGHT+IFscZTUdaiAfZVecYgW0V4bZBTAOhc9ZnXdNhR3wkGnu8EA8+wddIivWWAECcg0xy34JXkpEQ==
X-Received: by 2002:a17:90a:d60e:b0:2bd:fcda:ef2e with SMTP id 98e67ed59e1d1-2c1dc588b8dmr3321106a91.22.1717196767742;
        Fri, 31 May 2024 16:06:07 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a776f526sm4024943a91.13.2024.05.31.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:06:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Armin Wolf <W_Armin@gmx.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH RFT v3 4/4] hwmon: (spd5118) Add support for reading SPD data
Date: Fri, 31 May 2024 16:05:56 -0700
Message-Id: <20240531230556.1409532-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531230556.1409532-1-linux@roeck-us.net>
References: <20240531230556.1409532-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading SPD NVRAM data from SPD5118 (Jedec JESD300)
compliant memory modules. NVRAM write operation is not supported.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: New patch

RFT: I'd like to get some more test coverage before moving forward
     with this patch. decode-dimms doesn't recognize the 'spd5118'
     driver.

 Documentation/hwmon/spd5118.rst |   8 ++
 drivers/hwmon/spd5118.c         | 146 +++++++++++++++++++++++++++++++-
 2 files changed, 150 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/spd5118.rst b/Documentation/hwmon/spd5118.rst
index a15d75aa2066..ef7338f46575 100644
--- a/Documentation/hwmon/spd5118.rst
+++ b/Documentation/hwmon/spd5118.rst
@@ -53,3 +53,11 @@ temp1_crit_alarm	Temperature critical alarm
 
 Alarm attributes are sticky until read and will be cleared afterwards
 unless the alarm condition still applies.
+
+
+SPD (Serial Presence Detect) support
+------------------------------------
+
+The driver also supports reading the SPD NVRAM on SPD5118 compatible chips.
+SPD data is available from the 'eeprom' binary attribute file attached to the
+chip's I2C device.
diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
index baa315172298..131002290ff3 100644
--- a/drivers/hwmon/spd5118.c
+++ b/drivers/hwmon/spd5118.c
@@ -20,6 +20,8 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-provider.h>
 #include <linux/pm.h>
 #include <linux/regmap.h>
 #include <linux/units.h>
@@ -53,12 +55,31 @@ static const unsigned short normal_i2c[] = {
 
 #define SPD5118_TS_DISABLE		BIT(0)	/* temperature sensor disable */
 
+#define SPD5118_LEGACY_MODE_ADDR	BIT(3)
+#define SPD5118_LEGACY_PAGE_MASK	GENMASK(2, 0)
+#define SPD5118_LEGACY_MODE_MASK	(SPD5118_LEGACY_MODE_ADDR | SPD5118_LEGACY_PAGE_MASK)
+
+
+#define SPD5118_NUM_PAGES		8
+#define SPD5118_PAGE_SIZE		128
+#define SPD5118_PAGE_SHIFT		7
+#define SPD5118_PAGE_MASK		GENMASK(6, 0)
+#define SPD5118_EEPROM_BASE		0x80
+#define SPD5118_EEPROM_SIZE		(SPD5118_PAGE_SIZE * SPD5118_NUM_PAGES)
+
 /* Temperature unit in millicelsius */
 #define SPD5118_TEMP_UNIT		(MILLIDEGREE_PER_DEGREE / 4)
 /* Representable temperature range in millicelsius */
 #define SPD5118_TEMP_RANGE_MIN		-256000
 #define SPD5118_TEMP_RANGE_MAX		255750
 
+struct spd5118_data {
+	struct regmap *regmap;
+	struct mutex nvmem_lock;
+};
+
+/* hwmon */
+
 static int spd5118_temp_from_reg(u16 reg)
 {
 	int temp = sign_extend32(reg >> 2, 10);
@@ -360,9 +381,111 @@ static const struct hwmon_chip_info spd5118_chip_info = {
 	.info = spd5118_info,
 };
 
+/* nvmem */
+
+static int spd5118_nvmem_set_page(struct regmap *regmap, int page)
+{
+	unsigned int old_page;
+	int err;
+
+	err = regmap_read(regmap, SPD5118_REG_I2C_LEGACY_MODE, &old_page);
+	if (err)
+		return err;
+
+	if (page != (old_page & SPD5118_LEGACY_MODE_MASK)) {
+		/* Update page and explicitly select 1-byte addressing */
+		err = regmap_update_bits(regmap, SPD5118_REG_I2C_LEGACY_MODE,
+					 SPD5118_LEGACY_MODE_MASK, page);
+		if (err)
+			return err;
+
+		/* Selected new NVMEM page, drop cached data */
+		regcache_drop_region(regmap, SPD5118_EEPROM_BASE, 0xff);
+	}
+
+	return 0;
+}
+
+static ssize_t spd5118_nvmem_read_page(struct regmap *regmap, char *buf,
+				       unsigned int offset, size_t count)
+{
+	int err;
+
+	err = spd5118_nvmem_set_page(regmap, offset >> SPD5118_PAGE_SHIFT);
+	if (err)
+		return err;
+
+	offset &= SPD5118_PAGE_MASK;
+
+	/* Can't cross page boundaries */
+	if (offset + count > SPD5118_PAGE_SIZE)
+		count = SPD5118_PAGE_SIZE - offset;
+
+	err = regmap_bulk_read(regmap, SPD5118_EEPROM_BASE + offset, buf, count);
+	if (err)
+		return err;
+
+	return count;
+}
+
+static int spd5118_nvmem_read(void *priv, unsigned int off, void *val, size_t count)
+{
+	struct spd5118_data *data = priv;
+	char *buf = val;
+	int ret;
+
+	if (unlikely(!count))
+		return count;
+
+	if (off + count > SPD5118_EEPROM_SIZE)
+		return -EINVAL;
+
+	mutex_lock(&data->nvmem_lock);
+
+	while (count) {
+		ret = spd5118_nvmem_read_page(data->regmap, buf, off, count);
+		if (ret < 0) {
+			mutex_unlock(&data->nvmem_lock);
+			return ret;
+		}
+		buf += ret;
+		off += ret;
+		count -= ret;
+	}
+	mutex_unlock(&data->nvmem_lock);
+	return 0;
+}
+
+static int spd5118_nvmem_init(struct device *dev, struct spd5118_data *data)
+{
+	struct nvmem_config nvmem_config = {
+		.type = NVMEM_TYPE_EEPROM,
+		.name = dev_name(dev),
+		.id = NVMEM_DEVID_AUTO,
+		.dev = dev,
+		.base_dev = dev,
+		.read_only = true,
+		.root_only = false,
+		.owner = THIS_MODULE,
+		.compat = true,
+		.reg_read = spd5118_nvmem_read,
+		.priv = data,
+		.stride = 1,
+		.word_size = 1,
+		.size = SPD5118_EEPROM_SIZE,
+	};
+	struct nvmem_device *nvmem;
+
+	nvmem = devm_nvmem_register(dev, &nvmem_config);
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+/* regmap */
+
 static bool spd5118_writeable_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case SPD5118_REG_I2C_LEGACY_MODE:
 	case SPD5118_REG_TEMP_CLR:
 	case SPD5118_REG_TEMP_CONFIG:
 	case SPD5118_REG_TEMP_MAX:
@@ -396,7 +519,7 @@ static bool spd5118_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config spd5118_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.max_register = SPD5118_REG_TEMP_STATUS,
+	.max_register = 0xff,
 	.writeable_reg = spd5118_writeable_reg,
 	.volatile_reg = spd5118_volatile_reg,
 	.cache_type = REGCACHE_MAPLE,
@@ -406,10 +529,15 @@ static int spd5118_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	unsigned int regval, revision, vendor, bank;
+	struct spd5118_data *data;
 	struct device *hwmon_dev;
 	struct regmap *regmap;
 	int err;
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	regmap = devm_regmap_init_i2c(client, &spd5118_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
@@ -433,7 +561,15 @@ static int spd5118_probe(struct i2c_client *client)
 	if (!spd5118_vendor_valid(bank, vendor))
 		return -ENODEV;
 
-	dev_set_drvdata(dev, regmap);
+	data->regmap = regmap;
+	mutex_init(&data->nvmem_lock);
+	dev_set_drvdata(dev, data);
+
+	err = spd5118_nvmem_init(dev, data);
+	if (err) {
+		dev_err_probe(dev, err, "failed to register nvmem\n");
+		return err;
+	}
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, "spd5118",
 							 regmap, &spd5118_chip_info,
@@ -454,7 +590,8 @@ static int spd5118_probe(struct i2c_client *client)
 
 static int spd5118_suspend(struct device *dev)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct spd5118_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 
 	regcache_cache_bypass(regmap, true);
 	regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG, SPD5118_TS_DISABLE,
@@ -469,7 +606,8 @@ static int spd5118_suspend(struct device *dev)
 
 static int spd5118_resume(struct device *dev)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct spd5118_data *data = dev_get_drvdata(dev);
+	struct regmap *regmap = data->regmap;
 
 	regcache_cache_only(regmap, false);
 	return regcache_sync(regmap);
-- 
2.39.2


