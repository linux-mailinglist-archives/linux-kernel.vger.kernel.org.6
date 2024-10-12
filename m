Return-Path: <linux-kernel+bounces-362128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A9399B169
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA06283C05
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C7B13D245;
	Sat, 12 Oct 2024 07:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KoXPQaCJ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582FA126F2A;
	Sat, 12 Oct 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728716841; cv=none; b=prb7jgMiOg1h6nR0mO0LDDqYoDu8nNfbGxjol2OLuvK+eKLDHZKvxoQqf1kHW8khC7K/mEheTaxecm+y21ddtfT5sL8piy//2HCuDH9ibtDPpP/uy4JO/4+cN/mreDlE29enc/F/QWBieqGRzVDyZpmwADGPv0budLPaF/3h9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728716841; c=relaxed/simple;
	bh=Q02qGI1GFEBz4DIBXzJJi2NZRBwEG1pW6BoCNMuUENE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NB31WgyYhb6wXcWCG7lF6zYTdLbF2gN+XCULgrbN0XNN8g7K6C22CLxni8btYfrRauUOsqQ8JkYCvWiw/mlHziQcBE3mfKe1W8mldvUYBgWuzG5XSv1X+fQFwaMzuhDkidJZf9xUnCHzm/iR++Dxoq80dULZ5Ic/ZS5iECAS59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KoXPQaCJ; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=45OTr03UIjp01gqaKi
	ekyC41ovcOTUrGeuFGziMck9A=; b=KoXPQaCJSdWxXOc3EF2gblzlMobO2tOj9G
	eJsDR2SmzV2zXP1chH9egwprFCtYV7PHA9ZtMYPA9NJEOQ08uxVeH3QVzD/QRewp
	v1MRe5FjBMPlwF1uofFW3t5x4GExVI7kjl1+rsXdRSQEHtXcJn0FpW7CTmM+0ZxF
	apHfRdtIk=
Received: from 100ask.localdomain (unknown [36.18.172.102])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3nwP1HwpnNwWcAg--.5517S2;
	Sat, 12 Oct 2024 15:06:31 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: Wenliang <wenliang202407@163.com>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH linux dev-6.11 1/2] v3: hwmon: modified ina2xx to match SY24655
Date: Sat, 12 Oct 2024 03:06:26 -0400
Message-Id: <20241012070627.20788-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <f7653d58-9cee-4496-91b8-55dda44289bc@roeck-us.net>
References: <f7653d58-9cee-4496-91b8-55dda44289bc@roeck-us.net>
X-CM-TRANSID:_____wD3nwP1HwpnNwWcAg--.5517S2
X-Coremail-Antispam: 1Uf129KBjvJXoWfGr4fCw4rCFyUWrWxGF45ZFb_yoWDWw4Upr
	sxJayftr4UtF9xXr4kt3yUGr15Awn7CrW8Cr18G34ru3W5A34ku34UKr18tFWUGrykZFWU
	tFyktry8Cr1UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRSPf9UUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiox5202cKHjIfuwAAs9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This change makes the INA2XX driver compatible with sy24655,
involving the reading of average power

Signed-off-by: Wenliang <wenliang202407@163.com>
---

This change uses the latest ina2xx driver under the Linux NEXT branch.
I will explain the operation and significance of the average power
read function. I configure the READ_EIN (bit 10) of the ACCUM_CONFIG
register to 1, so that every time the EIN register is read, it will be
cleared. Therefore, the average power from the current read to the
previous read can be directly calculated. The reason for adopting 
this continuous reading mode is to facilitate upper level users to
use more accurate time to convert energy instead of using internal
time intervals.

 Documentation/hwmon/ina2xx.rst |  25 +++++++-
 drivers/hwmon/Kconfig          |   2 +-
 drivers/hwmon/ina2xx.c         | 103 +++++++++++++++++++++++++++++++--
 3 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
index 1ce161e6c0bf..eac8bb1deda0 100644
--- a/Documentation/hwmon/ina2xx.rst
+++ b/Documentation/hwmon/ina2xx.rst
@@ -63,6 +63,16 @@ Supported chips:
 
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
@@ -85,6 +95,11 @@ bus supply voltage.
 INA260 is a high or low side current and power monitor with integrated shunt
 resistor.
 
+The SY24655 is a high- and low-side current shunt and power monitor with an I2C
+interface. The SY24655 both shunt drop and supply voltage, with programmable
+calibration value and conversion times. The SY24655 can also calculate average
+power for use in energy conversion.
+
 The shunt value in micro-ohms can be set via platform data or device tree at
 compile-time or via the shunt_resistor attribute in sysfs at run-time. Please
 refer to the Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml for bindings
@@ -108,7 +123,7 @@ power1_input		Power(uW) measurement channel
 shunt_resistor		Shunt resistance(uOhm) channel (not for ina260)
 ======================= ===============================================
 
-Additional sysfs entries for ina226, ina230, ina231, and ina260
+Additional sysfs entries for ina226, ina230, ina231, ina260, and sy24655
 ---------------------------------------------------------------
 
 ======================= ====================================================
@@ -130,6 +145,14 @@ update_interval		data conversion time; affects number of samples used
 			to average results for shunt and bus voltages.
 ======================= ====================================================
 
+Sysfs entries for sy24655 only
+------------------------------------------------
+
+======================= ====================================================
+power1_average		calculate average power from last reading to the
+			present.
+======================= ====================================================
+
 .. note::
 
    - Configure `shunt_resistor` before configure `power1_crit`, because power
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 6a3385598cc6..11eb1c5aa358 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2167,7 +2167,7 @@ config SENSORS_INA2XX
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for INA219, INA220, INA226,
-	  INA230, INA231, and INA260 power monitor chips.
+	  INA230, INA231, INA260, and SY24655 power monitor chips.
 
 	  The INA2xx driver is configured for the default configuration of
 	  the part as described in the datasheet.
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index cecc80a41a97..89d2d2ae7f15 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -51,12 +51,25 @@
 #define INA226_ALERT_LIMIT		0x07
 #define INA226_DIE_ID			0xFF
 
-#define INA2XX_MAX_REGISTERS		8
+/* SY24655 register definitions */
+#define SY24655_EIN				0x0A
+#define SY24655_ACCUM_CONFIG	0x0D
+
+/* register count */
+#define INA219_REGISTERS		6
+#define INA226_REGISTERS		8
+#define SY24655_REGISTERS		0x0D
+
+#define INA2XX_MAX_REGISTERS		0x0D
 
 /* settings - depend on use case */
 #define INA219_CONFIG_DEFAULT		0x399F	/* PGA=8 */
 #define INA226_CONFIG_DEFAULT		0x4527	/* averages=16 */
 #define INA260_CONFIG_DEFAULT		0x6527	/* averages=16 */
+#define SY24655_CONFIG_DEFAULT		0x4527	/* averages=16 */
+
+/* (only for sy24655) */
+#define SY24655_ACCUM_CONFIG_DEFAULT	0x044C	/* continuous mode, clear after read*/
 
 /* worst case is 68.10 ms (~14.6Hz, ina219) */
 #define INA2XX_CONVERSION_RATE		15
@@ -84,6 +97,8 @@
 #define INA226_ALERT_CONFIG_MASK	GENMASK(15, 10)
 #define INA226_ALERT_FUNCTION_FLAG	BIT(4)
 
+#define SY24655_EIN_OVERFLOW_FLAG	BIT(6)
+
 /*
  * Both bus voltage and shunt voltage conversion times for ina226 are set
  * to 0b0100 on POR, which translates to 2200 microseconds in total.
@@ -97,6 +112,7 @@ static bool ina2xx_writeable_reg(struct device *dev, unsigned int reg)
 	case INA2XX_CALIBRATION:
 	case INA226_MASK_ENABLE:
 	case INA226_ALERT_LIMIT:
+	case SY24655_ACCUM_CONFIG:
 		return true;
 	default:
 		return false;
@@ -110,6 +126,7 @@ static bool ina2xx_volatile_reg(struct device *dev, unsigned int reg)
 	case INA2XX_BUS_VOLTAGE:
 	case INA2XX_POWER:
 	case INA2XX_CURRENT:
+	case SY24655_EIN:
 		return true;
 	default:
 		return false;
@@ -127,7 +144,7 @@ static const struct regmap_config ina2xx_regmap_config = {
 	.writeable_reg = ina2xx_writeable_reg,
 };
 
-enum ina2xx_ids { ina219, ina226, ina260 };
+enum ina2xx_ids { ina219, ina226, ina260, sy24655 };
 
 struct ina2xx_config {
 	u16 config_default;
@@ -149,6 +166,8 @@ struct ina2xx_data {
 	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
+	struct i2c_client *client;
+
 };
 
 static const struct ina2xx_config ina2xx_config[] = {
@@ -181,6 +200,16 @@ static const struct ina2xx_config ina2xx_config[] = {
 		.has_alerts = true,
 		.has_ishunt = true,
 	},
+	[sy24655] = {
+		.config_default = SY24655_CONFIG_DEFAULT,
+		.calibration_value = 2048,
+		.shunt_div = 400,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = 1250,
+		.power_lsb_factor = 25,
+		.has_alerts = false,
+		.has_ishunt = false,
+	},
 };
 
 /*
@@ -485,6 +514,49 @@ static int ina2xx_in_read(struct device *dev, u32 attr, int channel, long *val)
 	return 0;
 }
 
+/*
+ * Configuring the READ_EIN (bit 10) of the ACCUM_CONFIG register to 1
+ * can clear accumulator and sample_count after reading the EIN register.
+ * This way, the average power between the last read and the current
+ * read can be obtained. By combining with accurate time data from
+ * outside, the energy consumption during that period can be calculated.
+ */
+static int sy24655_average_power_read(struct ina2xx_data *data, u8 reg, long *val)
+{
+	u8 template[6];
+	int ret;
+	long accumulator_24, sample_count;
+	unsigned int regval;
+
+	ret = regmap_read_bypassed(data->regmap, INA226_MASK_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	if (regval & SY24655_EIN_OVERFLOW_FLAG)
+		return -ENOMEM;
+
+	/* 48-bit register read */
+	ret = i2c_smbus_read_i2c_block_data(data->client, reg, 6, template);
+	if (ret < 0)
+		return ret;
+	if (ret != 6)
+		return -EIO;
+	accumulator_24 = ((template[3] << 16) |
+				(template[4] << 8) |
+				template[5]);
+	sample_count = ((template[0] << 16) |
+				(template[1] << 8) |
+				template[2]);
+	if (sample_count <= 0) {
+		*val = 0;
+		return 0;
+	}
+
+	*val = DIV_ROUND_CLOSEST(accumulator_24, sample_count) * data->power_lsb_uW;
+
+	return 0;
+}
+
 static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
 {
 	struct ina2xx_data *data = dev_get_drvdata(dev);
@@ -492,6 +564,8 @@ static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
 	switch (attr) {
 	case hwmon_power_input:
 		return ina2xx_read_init(dev, INA2XX_POWER, val);
+	case hwmon_power_average:
+		return sy24655_average_power_read(data, SY24655_EIN, val);
 	case hwmon_power_crit:
 		return ina226_alert_limit_read(data, INA226_POWER_OVER_LIMIT_MASK,
 					       INA2XX_POWER, val);
@@ -702,6 +776,8 @@ static umode_t ina2xx_is_visible(const void *_data, enum hwmon_sensor_types type
 			if (has_alerts)
 				return 0444;
 			break;
+		case hwmon_power_average:
+			return 0444;
 		default:
 			break;
 		}
@@ -734,7 +810,8 @@ static const struct hwmon_channel_info * const ina2xx_info[] = {
 	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
 			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
 	HWMON_CHANNEL_INFO(power,
-			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
+			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM |
+			   HWMON_P_AVERAGE),
 	NULL
 };
 
@@ -840,6 +917,18 @@ static int ina2xx_init(struct device *dev, struct ina2xx_data *data)
 						FIELD_PREP(INA226_ALERT_POLARITY, active_high));
 	}
 
+	if (data->chip == sy24655) {
+		/*
+		 * Initialize the power accumulation method to continuous
+		 * mode and clear the EIN register after each read of the
+		 * EIN register
+		 */
+		ret = regmap_write(regmap, SY24655_ACCUM_CONFIG,
+				SY24655_ACCUM_CONFIG_DEFAULT);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (data->config->has_ishunt)
 		return 0;
 
@@ -868,6 +957,7 @@ static int ina2xx_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	/* set the device type */
+	data->client = client;
 	data->config = &ina2xx_config[chip];
 	data->chip = chip;
 	mutex_init(&data->config_lock);
@@ -906,6 +996,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
 	{ "ina260", ina260 },
+	{ "sy24655", sy24655 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -935,7 +1026,11 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
 		.compatible = "ti,ina260",
 		.data = (void *)ina260
 	},
-	{ },
+	{
+		.compatible = "silergy,sy24655",
+		.data = (void *)sy24655
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ina2xx_of_match);
 
-- 
2.17.1


