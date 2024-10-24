Return-Path: <linux-kernel+bounces-379479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D089ADF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44345B2113F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861991B0F25;
	Thu, 24 Oct 2024 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IoeNJWSA"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99391B0F1A;
	Thu, 24 Oct 2024 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758690; cv=none; b=RgN4WuG+l0ZyGMATiD3lJxPVG9fkMhKCPbVFxquQ4oz2kSJE1npKiENzHKXMbYa3+m/iGPC9S2sArtJbwo0GQNRThbC/XUm4qKDHmunqGFXmkG+eIpAVoXlNj/rsGbbX0wuDuej2/NkLMzE/bndki6m9bG3vrUCjtjZkQPtRrEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758690; c=relaxed/simple;
	bh=FIyL9wTlJVY8UykGGvmUpzDcH1Vwsy+uNN4CYmXaqMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Irv9cqytDSKPYMsix8pEwoMr9NfLyWLK7ZOAILjufggd2+9eIih1wVn4LSFk5HVwKj6H1FZz0AxaYmldOMTaQc/4JBdi8B+KgOTws4HGUac60LwGb3T3soI5JjD+tJ1h6XW/VjCTiuRN24M9OXzFRS/NKAOOwBDcv6DjAoWzcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IoeNJWSA; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=9j1jVInBa3aoNuEyXN
	llBIdcnOIOKZMzOu6HCDyuF2c=; b=IoeNJWSAI/03rHewRsmO3M/rmSAPAhneQy
	VjkgzmekxjUHBZSvOouuaTGTPdYSFyAGJhk4It4BIzIbSVUow+MFXm4F9ROGcm1w
	u3LLr0ladIEjzMq2FHmWGZftJtEWRz7i9tCU96pfkNVKNW1Vq+68HJwSk5gSxLtl
	YosGRgD7M=
Received: from 100ask.localdomain (unknown [36.18.166.195])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3v07CBRpnboiLDA--.18S2;
	Thu, 24 Oct 2024 16:31:00 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: Wenliang <wenliang202407@163.com>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] hwmon: modified ina2xx to match SY24655
Date: Thu, 24 Oct 2024 04:30:54 -0400
Message-Id: <20241024083055.82047-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
References: <80bfd968-8f12-46b1-9b72-837502ccdb2a@roeck-us.ne>
X-CM-TRANSID:_____wD3v07CBRpnboiLDA--.18S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GF1rWFyUGrW8XrWkJrW7twb_yoWfKF4Upr
	ZxGa4ftrWUtF9xXr4kt3y5Gr15Awn7ArWUCr18G34ru3W5A34v934Utr10yFWUGrykAFWU
	tFyktr18Gr1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRS_MwUUUUU=
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbioxaC02caAfpBuAAAsb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

v3:Support the SY24655 for current and voltage detection as well as
power calculation.

SY24655 provides a power accumulator, thus adding the power1_average
parameter to output the average power, which can be used to calculate
energy; In order to achieve average power, adding extra EIN register
and ACCUM_CONFIG register addresses for SY24655. Due to the 48 bit
read-only nature of the EIN register, a function has been added
specifically for average power reading.


Signed-off-by: Wenliang <wenliang202407@163.com>
---



 Documentation/hwmon/ina2xx.rst | 25 ++++++++-
 drivers/hwmon/Kconfig          |  2 +-
 drivers/hwmon/ina2xx.c         | 97 ++++++++++++++++++++++++++++++++--
 3 files changed, 118 insertions(+), 6 deletions(-)

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
index 64fefb22ecee..48b446c366f2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2178,7 +2178,7 @@ config SENSORS_INA2XX
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for INA219, INA220, INA226,
-	  INA230, INA231, and INA260 power monitor chips.
+	  INA230, INA231, INA260, and SY24655 power monitor chips.
 
 	  The INA2xx driver is configured for the default configuration of
 	  the part as described in the datasheet.
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index cecc80a41a97..9270af69ef6f 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -51,12 +51,20 @@
 #define INA226_ALERT_LIMIT		0x07
 #define INA226_DIE_ID			0xFF
 
-#define INA2XX_MAX_REGISTERS		8
+/* SY24655 register definitions */
+#define SY24655_EIN				0x0A
+#define SY24655_ACCUM_CONFIG	0x0D
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
@@ -84,6 +92,8 @@
 #define INA226_ALERT_CONFIG_MASK	GENMASK(15, 10)
 #define INA226_ALERT_FUNCTION_FLAG	BIT(4)
 
+#define SY24655_EIN_OVERFLOW_FLAG	BIT(6)
+
 /*
  * Both bus voltage and shunt voltage conversion times for ina226 are set
  * to 0b0100 on POR, which translates to 2200 microseconds in total.
@@ -97,6 +107,7 @@ static bool ina2xx_writeable_reg(struct device *dev, unsigned int reg)
 	case INA2XX_CALIBRATION:
 	case INA226_MASK_ENABLE:
 	case INA226_ALERT_LIMIT:
+	case SY24655_ACCUM_CONFIG:
 		return true;
 	default:
 		return false;
@@ -127,7 +138,7 @@ static const struct regmap_config ina2xx_regmap_config = {
 	.writeable_reg = ina2xx_writeable_reg,
 };
 
-enum ina2xx_ids { ina219, ina226, ina260 };
+enum ina2xx_ids { ina219, ina226, ina260, sy24655 };
 
 struct ina2xx_config {
 	u16 config_default;
@@ -149,6 +160,8 @@ struct ina2xx_data {
 	long power_lsb_uW;
 	struct mutex config_lock;
 	struct regmap *regmap;
+	struct i2c_client *client;
+
 };
 
 static const struct ina2xx_config ina2xx_config[] = {
@@ -181,6 +194,16 @@ static const struct ina2xx_config ina2xx_config[] = {
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
@@ -485,6 +508,49 @@ static int ina2xx_in_read(struct device *dev, u32 attr, int channel, long *val)
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
@@ -492,6 +558,8 @@ static int ina2xx_power_read(struct device *dev, u32 attr, long *val)
 	switch (attr) {
 	case hwmon_power_input:
 		return ina2xx_read_init(dev, INA2XX_POWER, val);
+	case hwmon_power_average:
+		return sy24655_average_power_read(data, SY24655_EIN, val);
 	case hwmon_power_crit:
 		return ina226_alert_limit_read(data, INA226_POWER_OVER_LIMIT_MASK,
 					       INA2XX_POWER, val);
@@ -702,6 +770,8 @@ static umode_t ina2xx_is_visible(const void *_data, enum hwmon_sensor_types type
 			if (has_alerts)
 				return 0444;
 			break;
+		case hwmon_power_average:
+			return 0444;
 		default:
 			break;
 		}
@@ -734,7 +804,8 @@ static const struct hwmon_channel_info * const ina2xx_info[] = {
 	HWMON_CHANNEL_INFO(curr, HWMON_C_INPUT | HWMON_C_CRIT | HWMON_C_CRIT_ALARM |
 			   HWMON_C_LCRIT | HWMON_C_LCRIT_ALARM),
 	HWMON_CHANNEL_INFO(power,
-			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM),
+			   HWMON_P_INPUT | HWMON_P_CRIT | HWMON_P_CRIT_ALARM |
+			   HWMON_P_AVERAGE),
 	NULL
 };
 
@@ -840,6 +911,18 @@ static int ina2xx_init(struct device *dev, struct ina2xx_data *data)
 						FIELD_PREP(INA226_ALERT_POLARITY, active_high));
 	}
 
+	if (data->chip == sy24655) {
+		/*
+		 * Initialize the power accumulation method to continuous
+		 * mode and clear the EIN register after each read of the
+		 * EIN register
+		 */
+		ret = regmap_write(regmap, SY24655_ACCUM_CONFIG,
+				   SY24655_ACCUM_CONFIG_DEFAULT);
+		if (ret < 0)
+			return ret;
+	}
+
 	if (data->config->has_ishunt)
 		return 0;
 
@@ -868,6 +951,7 @@ static int ina2xx_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	/* set the device type */
+	data->client = client;
 	data->config = &ina2xx_config[chip];
 	data->chip = chip;
 	mutex_init(&data->config_lock);
@@ -906,6 +990,7 @@ static const struct i2c_device_id ina2xx_id[] = {
 	{ "ina230", ina226 },
 	{ "ina231", ina226 },
 	{ "ina260", ina260 },
+	{ "sy24655", sy24655 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
@@ -935,7 +1020,11 @@ static const struct of_device_id __maybe_unused ina2xx_of_match[] = {
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


