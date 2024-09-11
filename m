Return-Path: <linux-kernel+bounces-324879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6D6975201
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25F01F22F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD01188A1C;
	Wed, 11 Sep 2024 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Azt3UGYN"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AE31E50B;
	Wed, 11 Sep 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057552; cv=none; b=upOLTclbpr5FD2WXm2kg12aXbj69IWpWgzETryFz0wwZJEi/y8aCz/nTTaR9qzOrCXdovH7J/NwHU7+wCO+ziQcfFOO3G58VCYcsz2EvjKj2ppp1Bfy/fDeJWCTyjvwbbnER3dmwl9pgSPtEKH5cWpJtcytx3PeDvQDtDHLwHZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057552; c=relaxed/simple;
	bh=K9Y83VJ8586BdIlflFlpaRFqEnkfAHXz/Vt45Q1LCV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eab/rvgphxabw6Et7lXlINkd4pePjrhd8u+xb465DtrEZ6FKZKDFJmmQahg/lSe+1tz3y3FzdD41WZudaIUfu+kv5s/nIUBR1j3oITXpGeBgUJle3Pkuj5QXlAP7A8WAzxnZ+MkLNsCa7eMAaKo8IaL96XMHnhuiP+sz7ZYKX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Azt3UGYN; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=WvrvO+6rDd7qGpyiDa
	edtkZtj5PJ2LKvswa22ubTrDQ=; b=Azt3UGYN8mXh3yHUvldorjTcTevjedSuIU
	1zgLhh/OxJz8cdXABF8kZvAY3CNqwL7N0IFciTSsfrjQw5G2meUrLQ6NbBE3s9ge
	XBNa6QaBtBRXOxuKZaWD/FiMvLogoBvO8vI3uxzQPWv3I9XBLJmBVmTfndynB9kr
	EK8XkYNSY=
Received: from 100ask.localdomain (unknown [36.23.125.181])
	by gzsmtp1 (Coremail) with SMTP id sCgvCgBXdnYyjOFmHo+DBQ--.2634S2;
	Wed, 11 Sep 2024 20:25:23 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: Wenliang <wenliang202407@163.com>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linux dev-6.11 1/2] hwmon: modified ina2xx to match SY24655(SQ52205)
Date: Wed, 11 Sep 2024 08:25:17 -0400
Message-Id: <20240911122518.41393-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
References: <7c155638-8c33-4873-9534-17a9454c83e6@roeck-us.net>
X-CM-TRANSID:sCgvCgBXdnYyjOFmHo+DBQ--.2634S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKFW5tFW3WFy8tr4kJr4rGrg_yoWftFykpF
	ZxGa4ftrW5ta43W3ykta1DWF15uw1xCry8CrykGw1F93W5A340934UKrWrJFW5Gr95AFW2
	qF9FyryUCrWDJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JjV6wZUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiRxRX02V4LVlaSgAAsu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

After listening to your advice, I have adapted SQ52205 by rewriting the
ina2xx driver.At the same time, I would like to clarify that SY24655 and
SQ52205 are different partnumber of the same chip. Therefore, you can
refer to SY24655FBP. I have also changed the naming within the driver to
SY24655, and I hope to receive your response.

Signed-off-by: Wenliang <wenliang202407@163.com>
---
 Documentation/hwmon/ina2xx.rst |  24 ++++++++
 drivers/hwmon/Kconfig          |   2 +-
 drivers/hwmon/ina2xx.c         | 106 +++++++++++++++++++++++++++++++--
 3 files changed, 126 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
index 27d2e39bc8ac..0bd16a0104a7 100644
--- a/Documentation/hwmon/ina2xx.rst
+++ b/Documentation/hwmon/ina2xx.rst
@@ -53,6 +53,16 @@ Supported chips:
 
 	       https://www.ti.com/
 
+  * Silergy SY24655
+
+
+    Prefix: 'sy24655'
+    Addresses: I2C 0x40 - 0x4f
+
+    Datasheet: Publicly available at the Silergy website
+
+	       https://us1.silergy.com/
+
 Author: Lothar Felten <lothar.felten@gmail.com>
 
 Description
@@ -72,6 +82,11 @@ INA230 and INA231 are high or low side current shunt and power monitors
 with an I2C interface. The chips monitor both a shunt voltage drop and
 bus supply voltage.
 
+The SY24655 is a high- and low-side current shunt and power monitor with an I2C
+interface. The SY24655 both shunt drop and supply voltage, with programmable
+calibration value and conversion times. The SY24655 can also calculate average
+power for use in energy conversion.
+
 The shunt value in micro-ohms can be set via platform data or device tree at
 compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
 refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
@@ -113,6 +128,15 @@ update_interval		data conversion time; affects number of samples used
 			to average results for shunt and bus voltages.
 ======================= ====================================================
 
+Sysfs entries for sy24655 only
+------------------------------------------------
+
+======================= ====================================================
+update_interval		data conversion time; affects number of samples used
+			to average results for shunt and bus voltages.
+calculate_avg_power	calculate average power from last reading to the present.
+======================= ====================================================
+
 .. note::
 
    - Configure `shunt_resistor` before configure `power1_crit`, because power
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..1f9752689ae8 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2138,7 +2138,7 @@ config SENSORS_INA2XX
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for INA219, INA220, INA226,
-	  INA230, and INA231 power monitor chips.
+	  INA230, INA231, and Silergy SY24655 power monitor chips.
 
 	  The INA2xx driver is configured for the default configuration of
 	  the part as described in the datasheet.
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 9ab4205622e2..34d474ac0b66 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -18,6 +18,10 @@
  * Bi-directional Current/Power Monitor with I2C Interface
  * Datasheet: https://www.ti.com/product/ina230
  *
+ * SY24655:
+ * Bi-directional Current/Power Monitor with I2C Interface
+ * Datasheet: https://us1.silergy.com/productsview/SY24655FBP
+ *
  * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  * Thanks to Jan Volkering
  */
@@ -51,15 +55,23 @@
 #define INA226_ALERT_LIMIT		0x07
 #define INA226_DIE_ID			0xFF
 
+/* SY24655 register definitions */
+#define SY24655_EIN				0x0A
+#define SY24655_ACCUM_CONFIG	0x0D
+
 /* register count */
 #define INA219_REGISTERS		6
 #define INA226_REGISTERS		8
+#define SY24655_REGISTERS		0x0D
 
-#define INA2XX_MAX_REGISTERS		8
+#define INA2XX_MAX_REGISTERS		0x0D
 
 /* settings - depend on use case */
 #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
 #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
+#define SY24655_CONFIG_DEFAULT		0x4527	/* averages=16 */
+/* (only for sy24655) */
+#define SY24655_ACCUM_CONFIG_DEFAULT	0x044C
 
 /* worst case is 68.10 ms (~14.6Hz, ina219) */
 #define INA2XX_CONVERSION_RATE		15
@@ -103,7 +115,7 @@ static struct regmap_config ina2xx_regmap_config = {
 	.val_bits = 16,
 };
 
-enum ina2xx_ids { ina219, ina226 };
+enum ina2xx_ids { ina219, ina226, sy24655};
 
 struct ina2xx_config {
 	u16 config_default;
@@ -117,12 +129,13 @@ struct ina2xx_config {
 
 struct ina2xx_data {
 	const struct ina2xx_config *config;
-
+
 	long rshunt;
 	long current_lsb_uA;
 	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
+	struct i2c_client *client;
 
 	const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
 };
@@ -146,6 +159,15 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.bus_voltage_lsb = 1250,
 		.power_lsb_factor = 25,
 	},
+	[sy24655] = {
+		.config_default = SY24655_CONFIG_DEFAULT,
+		.calibration_value = 2048,
+		.registers = SY24655_REGISTERS,
+		.shunt_div = 400,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = 1250,
+		.power_lsb_factor = 25,
+	},
 };
 
 /*
@@ -216,6 +238,12 @@ static int ina2xx_init(struct ina2xx_data *data)
 	return ina2xx_calibrate(data);
 }
 
+static int sy24655_init(struct ina2xx_data *data)
+{
+	return regmap_write(data->regmap, SY24655_ACCUM_CONFIG,
+				SY24655_ACCUM_CONFIG_DEFAULT);
+}
+
 static int ina2xx_read_reg(struct device *dev, int reg, unsigned int *regval)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
@@ -551,6 +579,48 @@ static ssize_t ina226_interval_show(struct device *dev,
 	return sysfs_emit(buf, "%d\n", ina226_reg_to_interval(regval));
 }
 
+static int sy24655_read_reg48(const struct i2c_client *client, u8 reg,
+					long *accumulator_24, long *sample_count)
+{
+	u8 data[6];
+	int err;
+	*accumulator_24 = 0;
+	*sample_count = 0;
+
+	/* 48-bit register read */
+	err = i2c_smbus_read_i2c_block_data(client, reg, 6, data);
+	if (err < 0)
+		return err;
+	if (err != 6)
+		return -EIO;
+	*accumulator_24 = ((data[3] << 16) |
+				(data[4] << 8) |
+				data[5]);
+	*sample_count = ((data[0] << 16) |
+				(data[1] << 8) |
+				data[2]);
+
+	return 0;
+}
+
+static ssize_t sy24655_avg_power_show(struct device *dev,
+					struct device_attribute *da, char *buf)
+{
+	struct ina2xx_data *data = dev_get_drvdata(dev);
+	long sample_count, accumulator_24, regval;
+	int status;
+
+	status = sy24655_read_reg48(data->client, SY24655_EIN,
+						&accumulator_24, &sample_count);
+	if (status)
+		return status;
+	regval = DIV_ROUND_CLOSEST(accumulator_24, sample_count);
+	regval = regval * data->power_lsb_uW;
+
+
+	return sysfs_emit(buf, "%li\n", regval);
+}
+
 /* shunt voltage */
 static SENSOR_DEVICE_ATTR_RO(in0_input, ina2xx_value, INA2XX_SHUNT_VOLTAGE);
 /* shunt voltage over/under voltage alert setting and alarm */
@@ -589,9 +659,13 @@ static SENSOR_DEVICE_ATTR_RO(power1_crit_alarm, ina226_alarm,
 /* shunt resistance */
 static SENSOR_DEVICE_ATTR_RW(shunt_resistor, ina2xx_shunt, INA2XX_CALIBRATION);
 
-/* update interval (ina226 only) */
+/* update interval (ina226 and sy24655) */
 static SENSOR_DEVICE_ATTR_RW(update_interval, ina226_interval, 0);
 
+/* calculate_avg_power (sy24655 only) */
+static SENSOR_DEVICE_ATTR_RO(calculate_avg_power, sy24655_avg_power, 0);
+
+
 /* pointers to created device attributes */
 static struct attribute *ina2xx_attrs[] = {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
@@ -624,6 +698,15 @@ static struct attribute *ina226_attrs[] = {
 static const struct attribute_group ina226_group = {
 	.attrs = ina226_attrs,
 };
+static struct attribute *sy24655_attrs[] = {
+	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_calculate_avg_power.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group sy24655_group = {
+	.attrs = sy24655_attrs,
+};
 
 static int ina2xx_probe(struct i2c_client *client)
 {
@@ -641,6 +724,7 @@ static int ina2xx_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	/* set the device type */
+	data->client = client;
 	data->config = &ina2xx_config[chip];
 	mutex_init(&data->config_lock);
 
@@ -691,10 +775,17 @@ static int ina2xx_probe(struct i2c_client *client)
 		dev_err(dev, "error configuring the device: %d\n", ret);
 		return -ENODEV;
 	}
-
+	if (chip == sy24655)
+		ret = sy24655_init(data);
+	if (ret < 0) {
+		dev_err(dev, "error configuring the accum_reg: %d\n", ret);
+		return -ENODEV;
+	}
 	data->groups[group++] = &ina2xx_group;
 	if (chip == ina226)
 		data->groups[group++] = &ina226_group;
+	else if (chip == sy24655)
+		data->groups[group++] = &sy24655_group;
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, data->groups);
@@ -713,6 +804,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina226", ina226 },
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
+	{ "sy24655", sy24655},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -738,6 +830,10 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
 		.compatible = "ti,ina231",
 		.data = (void *)ina226
 	},
+	{
+		.compatible = "silergy,sy24655",
+		.data = (void *)sy24655
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ina2xx_of_match);
-- 
2.17.1


