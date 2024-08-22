Return-Path: <linux-kernel+bounces-296829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2B395AF90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6751F215FA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3B515A4B3;
	Thu, 22 Aug 2024 07:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MCDs0ZLj"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4571B33EA;
	Thu, 22 Aug 2024 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312705; cv=none; b=uO+lt8SyfEyUkH42PAjV/gaCqmE+2pU1vsOnKvwixdrZP0x7GYUGprCxGmimtNth1KOxdAyb3abpIFunz37w1kwXnAGxsfM9pM8c75ULxRMvwPH8O+87/Bnk2GjJf4u0GLlXOBlb/dPTn+7GCS/yzpsJ0JHP2CDwxDcRwd0SxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312705; c=relaxed/simple;
	bh=STIMiu5oDvJ1YurgMRrDaW+f7qCSUBEFBD5ZwouUW1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCApEIvDcajUg4EzABEpDTBsVbamGWhyZqNCFIA8b8LuEirfGGD19e1Jb9Q2Tl6QNsheYPqjjQHK+rVrwAK4mzNtsevt2hwfRMTwFnjnqFQnwD0l46+JpXTGwLw8KFKIb39OoVJL2RhnQzm1nxDVFd6dVm0YcFZqoIec21amDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MCDs0ZLj; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=Ycg0WA2R4XEXGgKaTrPTq/9U/YQ76h3jO7+JIFKlqEk=;
	b=MCDs0ZLjCZOFLEut0+2cNkAkh0yjd/wWLQPuJjRrtXeXJdlSTA3P2wJpnOHrWC
	KGsy1zDWMtcCaiZE93fXZ7cHhRuNQLDZQdlL6CpFICCXUeQ6GbG7dBMz/pbce2/M
	lnWt2m8yI/SXw1rOsm4ju90DOokEh8UPJ1/ZinFnB/dk0=
Received: from 100ask.localdomain (unknown [36.23.122.219])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wD3f8dc7MZm0tsaAA--.3738S2;
	Thu, 22 Aug 2024 15:44:30 +0800 (CST)
From: Wenliang <wenliang202407@163.com>
To: linux@roeck-us.net
Cc: jdelvare@suse.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wenliang <wenliang202407@163.com>
Subject: [PATCH linux dev 6.11] hwmon:add new hwmon driver sq52205
Date: Thu, 22 Aug 2024 03:44:26 -0400
Message-Id: <20240822074426.7241-1-wenliang202407@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <935f564b-fa3e-4cdf-bf12-19b897369a07@roeck-us.net>
References: <935f564b-fa3e-4cdf-bf12-19b897369a07@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f8dc7MZm0tsaAA--.3738S2
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kr4xZw18KF47KFyUZr1kXwb_yoW8ZrykWo
	WSgrs3uw18Xw1DArW8uwnrt3y7XFWDCr4rJ3WS9r4Dua47JF1Y9ayrtw1rJryava15XFWf
	Aw4fK345Jay8tw1xn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0F4RUUUUU
X-CM-SenderInfo: xzhqzxhdqjjiisuqlqqrwthudrp/1tbiGQBD02XAkoTTjQAAsk

Thank you for bringing up your questions and suggestions.The SQ52205 is a
part number specific to the Asian region, which is why you might not be
able to find it through a search. I'll provide you the website
(https://us1.silergy.com/zh/productsview/SQ52205FBP).
Some registers of this chip are similar to those of the INA226, but it has
additional registers such as integrators, which is the main reason why I'm
offering a new driver.And I plan add drivers of the same series based on
this. I commit the new patch and look forward to your reply.

Signed-off-by: Wenliang <wenliang202407@163.com>

---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/sq52205.rst |  44 +++
 MAINTAINERS                     |   5 +
 drivers/hwmon/Kconfig           |  13 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/sq52205.c         | 558 ++++++++++++++++++++++++++++++++
 6 files changed, 622 insertions(+)
 create mode 100644 Documentation/hwmon/sq52205.rst
 create mode 100644 drivers/hwmon/sq52205.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 913c11390a45..5130270c8efe 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -219,6 +219,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m1
    sparx5-temp
    spd5118
+   sq52205
    stpddc60
    surface_fan
    sy7636a-hwmon
diff --git a/Documentation/hwmon/sq52205.rst b/Documentation/hwmon/sq52205.rst
new file mode 100644
index 000000000000..e66bf883b42b
--- /dev/null
+++ b/Documentation/hwmon/sq52205.rst
@@ -0,0 +1,44 @@
+SPDX-License-Identifier: GPL-2.0-only
+
+Kernel driver sq52205
+====================
+
+Supported chips:
+
+  * Silergy SQ52205
+
+
+    Prefix: 'sq52205'
+    Addresses: I2C 0x40 - 0x4f
+
+    Datasheet: Publicly available at the Silergy website
+
+	       https://us1.silergy.com/zh
+
+
+Author: Wenliang Yan <wenliang202407@163.com>
+
+Description
+-----------
+
+The SQ52205 is a high- and low-side current shunt and power monitor with an I2C
+interface. The SQ52205 both shunt drop and supply voltage, with programmable
+calibration value and conversion times. The SQ52205 can also calculate average
+power for use in energy conversion.
+
+
+
+Sysfs entries
+---------------------
+
+======================= ===============================
+in0_input		Shunt voltage(mV) channel
+in1_input		Bus voltage(mV) channel
+curr1_input		Current(mA) measurement channel
+power1_input		Power(uW) measurement channel
+shunt_resistor		Shunt resistance(uOhm) channel
+update_interval		data conversion time; affects number of samples used
+			to average results for shunt and bus voltages.
+calculate_avg_power	calculate average power from last reading to the present
+======================= ===============================
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..4794c703da34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20822,6 +20822,11 @@ S:	Maintained
 F:	drivers/input/touchscreen/silead.c
 F:	drivers/platform/x86/touchscreen_dmi.c
 
+SILERGY HARDWARE MONITOR DRIVER
+M:	Wenliang Yan <wenliang202407@163.com>
+S:	Maintained
+F:	drivers/hwmon/sq52205.c
+
 SILICON LABS WIRELESS DRIVERS (for WFxxx series)
 M:	Jérôme Pouiller <jerome.pouiller@silabs.com>
 S:	Supported
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..7a6c21c9eee9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2521,6 +2521,19 @@ config SENSORS_INTEL_M10_BMC_HWMON
 	  sensors monitor various telemetry data of different components on the
 	  card, e.g. board temperature, FPGA core temperature/voltage/current.
 
+config SENSORS_SQ52205
+	tristate "Silergy SQ52205 and compatibles"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for SQ52205 power monitor chips.
+
+	  The SQ52205 driver is configured for the default configuration of
+	  the part as described in the datasheet.
+	  Default value for Rshunt is 10 mOhms.
+	  This driver can also be built as a module. If so, the module
+	  will be called sq52205.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b1c7056c37db..270f88e3c6e6 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -207,6 +207,7 @@ obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_SPD5118)	+= spd5118.o
+obj-$(CONFIG_SENSORS_SQ52205)	+= sq52205.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
diff --git a/drivers/hwmon/sq52205.c b/drivers/hwmon/sq52205.c
new file mode 100644
index 000000000000..a7a674a50289
--- /dev/null
+++ b/drivers/hwmon/sq52205.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for SQ52205 power monitor chip
+ *
+ * Copyright (C) 2024 Wenliang Yan <wenliang202407@163.com>
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/util_macros.h>
+#include <linux/regmap.h>
+
+
+
+/* common register definitions */
+#define SQ522XX_CONFIG			0x00
+#define SQ522XX_SHUNT_VOLTAGE	0x01 /* readonly */
+#define SQ522XX_BUS_VOLTAGE		0x02 /* readonly */
+#define SQ522XX_POWER			0x03 /* readonly */
+#define SQ522XX_CURRENT			0x04 /* readonly */
+#define SQ522XX_CALIBRATION		0x05
+
+/* SQ52205 register definitions */
+#define SQ52205_MASK_ENABLE		0x06
+#define SQ52205_ALERT_LIMIT		0x07
+#define SQ52205_EIN				0x0A
+#define SQ52205_ACCUM_CONFIG	0x0D
+
+/* register count */
+#define SQ52205_REGISTERS		0x0D
+#define SQ522XX_MAX_REGISTERS	0x0D
+
+/* settings - default */
+#define SQ52205_CONFIG_DEFAULT		0x4527	/* averages=16 */
+#define SQ52205_ACCUM_CONFIG_DEFAULT	0x044C
+
+/* worst case is 68.10 ms (~14.6Hz) */
+#define SQ522XX_CONVERSION_RATE		15
+#define SQ522XX_MAX_DELAY		69 /* worst case delay in ms */
+
+#define SQ522XX_RSHUNT_DEFAULT		10000	//10mOhms
+#define SQ52205_BUS_VOLTAGE_LSB		1250	//1.25mV
+
+/* bit mask for reading the averaging setting in the configuration register */
+#define SQ52205_AVG_RD_MASK		0x0E00
+
+#define SQ52205_READ_AVG(reg)		(((reg) & SQ52205_AVG_RD_MASK) >> 9)
+#define SQ52205_SHIFT_AVG(val)		((val) << 9)
+
+/* common attrs, sq52205 attrs and NULL */
+#define SQ522XX_MAX_ATTRIBUTE_GROUPS	3
+
+/*
+ * Both bus voltage and shunt voltage conversion times for sq52205 are set
+ * to 0b0100 on POR, which translates to 2200 microseconds in total.
+ */
+#define SQ52205_TOTAL_CONV_TIME_DEFAULT	2200
+
+static const struct regmap_config sq522xx_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+};
+
+enum sq522xx_ids { sq52205 };
+
+struct sq522xx_config {
+	u16 config_default;
+	int calibration_factor;
+	int registers;
+	int shunt_div;
+	int bus_voltage_shift;
+	int bus_voltage_lsb;	/* uV */
+	int power_lsb;			/* uW */
+};
+
+struct sq522xx_data {
+	const struct sq522xx_config *config;
+
+	long rshunt;
+
+	struct mutex config_lock;
+	struct i2c_client *client;
+	struct regmap *regmap;
+
+	const struct attribute_group *groups[SQ522XX_MAX_ATTRIBUTE_GROUPS];
+};
+
+static const struct sq522xx_config sq522xx_config[] = {
+	[sq52205] = {
+		.config_default = SQ52205_CONFIG_DEFAULT,
+		.calibration_factor = 5120000,
+		.registers = SQ52205_REGISTERS,
+		.shunt_div = 400,
+		.bus_voltage_shift = 0,
+		.bus_voltage_lsb = SQ52205_BUS_VOLTAGE_LSB,
+		.power_lsb = 25000,
+	},
+};
+
+/*
+ * Available averaging rates for sq52205. The indices correspond with
+ * the bit values expected by the chip (according to the sq52205 datasheet)
+ */
+static const int sq52205_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
+
+static int sq52205_reg_to_interval(u16 config)
+{
+	int avg = sq52205_avg_tab[SQ52205_READ_AVG(config)];
+
+	/*
+	 * Multiply the total conversion time by the number of averages.
+	 * Return the result in milliseconds.
+	 */
+	return DIV_ROUND_CLOSEST(avg * SQ52205_TOTAL_CONV_TIME_DEFAULT, 1000);
+}
+
+/*
+ * Return the new, shifted AVG field value of CONFIG register,
+ * to use with regmap_update_bits
+ */
+static u16 sq52205_interval_to_reg(int interval)
+{
+	int avg, avg_bits;
+
+	avg = DIV_ROUND_CLOSEST(interval * 1000,
+				SQ52205_TOTAL_CONV_TIME_DEFAULT);
+	avg_bits = find_closest(avg, sq52205_avg_tab,
+				ARRAY_SIZE(sq52205_avg_tab));
+
+	return SQ52205_SHIFT_AVG(avg_bits);
+}
+
+/*
+ * Calibration register is set to the best value, which eliminates
+ * truncation errors on calculating current register in hardware.
+ * According to datasheet the best values are 2048 for
+ * sq52205. They are hardcoded as calibration_value.
+ */
+static int sq522xx_calibrate(struct sq522xx_data *data)
+{
+	u16 val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
+					data->rshunt);
+
+	return regmap_write(data->regmap, SQ522XX_CALIBRATION,
+				val);
+}
+
+/*
+ * Initialize the configuration and calibration registers.
+ */
+static int sq522xx_init(struct sq522xx_data *data)
+{
+	int ret = regmap_write(data->regmap, SQ522XX_CONFIG,
+				data->config->config_default);
+	if (ret < 0)
+		return ret;
+
+	return sq522xx_calibrate(data);
+}
+static int sq52205_init(struct sq522xx_data *data)
+{
+	// configure ENABLE register
+	int ret = regmap_write(data->regmap, SQ52205_ACCUM_CONFIG,
+				SQ52205_ACCUM_CONFIG_DEFAULT);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int sq522xx_read_reg(struct device *dev, int reg, unsigned int *regval)
+{
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+	int ret, retry;
+
+	dev_dbg(dev, "Starting register %d read\n", reg);
+
+	for (retry = 5; retry; retry--) {
+
+		ret = regmap_read(data->regmap, reg, regval);
+		if (ret < 0)
+			return ret;
+
+		dev_dbg(dev, "read %d, val = 0x%04x\n", reg, *regval);
+
+		/*
+		 * If the current value in the calibration register is 0, the
+		 * power and current registers will also remain at 0. In case
+		 * the chip has been reset let's check the calibration
+		 * register and reinitialize if needed.
+		 * We do that extra read of the calibration register if there
+		 * is some hint of a chip reset.
+		 */
+		if (*regval == 0) {
+			unsigned int cal;
+
+			ret = regmap_read(data->regmap, SQ522XX_CALIBRATION,
+					  &cal);
+			if (ret < 0)
+				return ret;
+
+			if (cal == 0) {
+				dev_warn(dev, "chip not calibrated, reinitializing\n");
+
+				ret = sq522xx_init(data);
+				if (ret < 0)
+					return ret;
+				/*
+				 * Let's make sure the power and current
+				 * registers have been updated before trying
+				 * again.
+				 */
+				msleep(SQ522XX_MAX_DELAY);
+				continue;
+			}
+		}
+		return 0;
+	}
+
+	/*
+	 * If we're here then although all write operations succeeded, the
+	 * chip still returns 0 in the calibration register. Nothing more we
+	 * can do here.
+	 */
+	dev_err(dev, "unable to reinitialize the chip\n");
+	return -ENODEV;
+}
+
+static int sq522xx_get_value(struct sq522xx_data *data, u8 reg,
+				unsigned int regval)
+{
+	int val;
+
+	switch (reg) {
+	case SQ522XX_SHUNT_VOLTAGE:
+		/* signed register , value is in mV*/
+		val = DIV_ROUND_CLOSEST((s16)regval, data->config->shunt_div);
+		break;
+	case SQ522XX_BUS_VOLTAGE:
+		/* signed register , value is in mV*/
+		val = (regval >> data->config->bus_voltage_shift)
+		* data->config->bus_voltage_lsb;
+		val = DIV_ROUND_CLOSEST(val, 1000);
+		break;
+	case SQ522XX_POWER:
+		/* value is in uV*/
+		val = regval * data->config->power_lsb;
+		break;
+	case SQ522XX_CURRENT:
+		/* signed register, LSB=1mA (selected), in mA */
+		val = (s16)regval;
+		break;
+	case SQ522XX_CALIBRATION:
+		val = DIV_ROUND_CLOSEST(data->config->calibration_factor,
+					regval);
+		break;
+	default:
+		/* programmer goofed */
+		WARN_ON_ONCE(1);
+		val = 0;
+		break;
+	}
+
+	return val;
+}
+
+static ssize_t sq522xx_value_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+
+	int err = sq522xx_read_reg(dev, attr->index, &regval);
+
+	if (err < 0)
+		return err;
+
+	return sysfs_emit(buf, "%d\n", sq522xx_get_value(data, attr->index, regval));
+}
+
+
+/*
+ * In order to keep calibration register value fixed, the product
+ * of current_lsb and shunt_resistor should also be fixed and equal
+ * to shunt_voltage_lsb = 1 / shunt_div multiplied by 10^9 in order
+ * to keep the scale.
+ */
+static ssize_t sq522xx_shunt_store(struct device *dev,
+				  struct device_attribute *da,
+				  const char *buf, size_t count)
+{
+	unsigned long val;
+	int status;
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+
+	status = kstrtoul(buf, 10, &val);
+	if (status < 0)
+		return status;
+	/* Values greater than the calibration factor make no sense. */
+	if (val == 0 || val > data->config->calibration_factor)
+		return -EINVAL;
+
+	mutex_lock(&data->config_lock);
+	data->rshunt = val;
+
+	status = sq522xx_calibrate(data);
+	mutex_unlock(&data->config_lock);
+	if (status < 0)
+		return status;
+
+	return count;
+}
+
+static ssize_t sq522xx_shunt_show(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%li\n", data->rshunt);
+}
+
+
+
+static ssize_t sq52205_interval_store(struct device *dev,
+					struct device_attribute *da,
+					const char *buf, size_t count)
+{
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+	unsigned long val;
+	int status;
+
+	status = kstrtoul(buf, 10, &val);
+	if (status < 0)
+		return status;
+
+	if (val > INT_MAX || val == 0)
+		return -EINVAL;
+
+	status = regmap_update_bits(data->regmap, SQ522XX_CONFIG,
+					SQ52205_AVG_RD_MASK,
+					sq52205_interval_to_reg(val));
+	if (status < 0)
+		return status;
+
+	return count;
+}
+
+static ssize_t sq52205_interval_show(struct device *dev,
+					struct device_attribute *da, char *buf)
+{
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+	int status;
+	unsigned int regval;
+
+	status = regmap_read(data->regmap, SQ522XX_CONFIG, &regval);
+	if (status)
+		return status;
+
+	return sysfs_emit(buf, "%d\n", sq52205_reg_to_interval(regval));
+}
+
+static int sq52205_read_reg48(const struct i2c_client *client, u8 reg,
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
+static ssize_t sq52205_avg_power_show(struct device *dev,
+					struct device_attribute *da, char *buf)
+{
+	struct sq522xx_data *data = dev_get_drvdata(dev);
+	long sample_count, accumulator_24, regval;
+	int status;
+
+	status = sq52205_read_reg48(data->client, SQ52205_EIN,
+						&accumulator_24, &sample_count);
+	if (status)
+		return status;
+	regval = DIV_ROUND_CLOSEST(accumulator_24, sample_count);
+	regval = regval * data->config->power_lsb;
+
+
+	return sysfs_emit(buf, "%li\n", regval);
+}
+
+/* shunt voltage */
+static SENSOR_DEVICE_ATTR_RO(in0_input, sq522xx_value, SQ522XX_SHUNT_VOLTAGE);
+
+/* bus voltage */
+static SENSOR_DEVICE_ATTR_RO(in1_input, sq522xx_value, SQ522XX_BUS_VOLTAGE);
+
+/* calculated current */
+static SENSOR_DEVICE_ATTR_RO(curr1_input, sq522xx_value, SQ522XX_CURRENT);
+
+/* calculated power */
+static SENSOR_DEVICE_ATTR_RO(power1_input, sq522xx_value, SQ522XX_POWER);
+
+/* shunt resistance */
+static SENSOR_DEVICE_ATTR_RW(shunt_resistor, sq522xx_shunt, SQ522XX_CALIBRATION);
+
+/* update interval (sq52205 only) */
+static SENSOR_DEVICE_ATTR_RW(update_interval, sq52205_interval, 0);
+
+/* calculate_avg_power (sq52205 only) */
+static SENSOR_DEVICE_ATTR_RO(calculate_avg_power, sq52205_avg_power, 0);
+
+
+/* pointers to created device attributes */
+static struct attribute *sq522xx_attrs[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_power1_input.dev_attr.attr,
+	&sensor_dev_attr_shunt_resistor.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group sq522xx_group = {
+	.attrs = sq522xx_attrs,
+};
+
+static struct attribute *sq52205_attrs[] = {
+	&sensor_dev_attr_update_interval.dev_attr.attr,
+	&sensor_dev_attr_calculate_avg_power.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group sq52205_group = {
+	.attrs = sq52205_attrs,
+};
+
+static const struct i2c_device_id sq522xx_id[];
+
+static int sq522xx_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sq522xx_data *data;
+	struct device *hwmon_dev;
+	u32 val;
+	int ret, group = 0;
+	enum sq522xx_ids chip;
+
+	if (client->dev.of_node)
+		chip = (uintptr_t)of_device_get_match_data(&client->dev);
+	else
+		chip = i2c_match_id(sq522xx_id, client)->driver_data;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* set the device type */
+	data->client = client;
+	data->config = &sq522xx_config[chip];
+	mutex_init(&data->config_lock);
+
+	if (of_property_read_u32(dev->of_node, "shunt-resistor", &val) < 0)
+		val = SQ522XX_RSHUNT_DEFAULT;
+
+
+	if (val <= 0 || val > data->config->calibration_factor)
+		return -ENODEV;
+
+	data->rshunt = val;
+
+	sq522xx_regmap_config.max_register = data->config->registers;
+
+	data->regmap = devm_regmap_init_i2c(client, &sq522xx_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(dev, "failed to allocate register map\n");
+		return PTR_ERR(data->regmap);
+	}
+
+
+	ret = sq522xx_init(data);
+	if (ret < 0) {
+		dev_err(dev, "error configuring the device: %d\n", ret);
+		return -ENODEV;
+	}
+	if (chip == sq52205) {
+		ret = sq52205_init(data);
+		if (ret < 0) {
+			dev_err(dev, "error configuring the device cal: %d\n", ret);
+			return -ENODEV;
+		}
+	}
+
+	data->groups[group++] = &sq522xx_group;
+	if (chip == sq52205)
+		data->groups[group++] = &sq52205_group;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
+								data, data->groups);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	dev_info(dev, "power monitor %s (Rshunt = %li uOhm)\n",
+		 client->name, data->rshunt);
+
+	return 0;
+}
+
+static const struct i2c_device_id sq522xx_id[] = {
+	{ "sq52205", sq52205 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sq522xx_id);
+
+static const struct of_device_id __maybe_unused sq522xx_of_match[] = {
+	{
+		.compatible = "silergy,sq52205",
+		.data = (void *)sq52205
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, sq522xx_of_match);
+
+static struct i2c_driver sq522xx_driver = {
+	.driver = {
+		.name	= "sq522xx",
+		.of_match_table = of_match_ptr(sq522xx_of_match),
+	},
+	.probe		= sq522xx_probe,
+	.id_table	= sq522xx_id,
+};
+
+module_i2c_driver(sq522xx_driver);
+
+MODULE_AUTHOR(" <wenliang202407@163.com> ");
+MODULE_DESCRIPTION("SQ522xx driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1


