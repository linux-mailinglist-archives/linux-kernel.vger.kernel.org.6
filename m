Return-Path: <linux-kernel+bounces-532292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6D0A44B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1E703AFC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E5B1B2182;
	Tue, 25 Feb 2025 19:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcdO49Dl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACCD21ABC6;
	Tue, 25 Feb 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510719; cv=none; b=Q0LveKkwxz+x6bEdnWl5TUd6ESpF8fGimJDvL+MyW0doVNbPXWfc1FdkBhnruPivLceB/bunR/Qve9HnZwh62qsUNOv8yJH3bZSz7gpMYQl908Igi9r+t2JP1iHCzAu4avZcFXpeFHUzr0emUkFMBqd/5YaDvx/137Ix9Q81bZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510719; c=relaxed/simple;
	bh=MUX52mLrc9tAzehVSU27yGUahedRxwTwQS/B41HkVUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jGkWug2sv7mUcDSPjZBVmFHKrdMGWdzkY9vSkZ1dpaDXFhH50anpxVf3YnX2KBluxZjTL/bPacbyjU21SWl4BHFPZ4XV+938cptnIUEcyoeVrV54xUlxnMBOfiYWHdxYLQCBQzpldgivzJw51YNTlkQy892qJZBoqRJMnruQe4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcdO49Dl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab7430e27b2so936158366b.3;
        Tue, 25 Feb 2025 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740510715; x=1741115515; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNTMaZPxHxVjFYDVf/mtPKH9G4p1SDbuEUdw5G3mAak=;
        b=RcdO49Dluldk+/U2kvPpykyNMPWJ0+JPXYos7Lnh35XEsCW5IqnaVyhmFooWHHEvG1
         w+uBoyQ4FWHppGRk5HmKhjjYG+320H7QcBTu3zHWMjm8APOB+TkQo5mbQ9cqrr421kpG
         Fk8GFmadI0jFis89mHljgfifONultjUIFf2MElnEe1uhSG5/rtxvlAGTJE1BmYp+mJzb
         SQM/1Ia5HKsG5+koH4H20n3SOuM3xaEcgpWkYvBPvbYpbdeyudWm6gpuRL2VRG2H29mQ
         v5PA1HPh3r088fqkbjMl+x5Ne9aa03KjfjzAkDdXqZXZYgCYqXwBmx5+erb7DCFDJ91t
         DhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740510715; x=1741115515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNTMaZPxHxVjFYDVf/mtPKH9G4p1SDbuEUdw5G3mAak=;
        b=JggnC5XpM174Nd1CrJWi21T4yfT5Me4/m10UwxPYJGBBZ3bXMNxl4+ebneMYW3H603
         4ny46ayPTs4XV5xrDxrbps/DLXwX3pr+rLtsGvCiG2UEk3vTGFqfEslEWvYijFP2M71V
         uDq8sYPc4W7lFfrMBphaMDgbC8Ch6rUSwTxNRINMAG9YFqLYd6+LJpiGJoYpWje0pp0M
         eWqiM2lvwR5XI4Rt4I1VYlR7wjNmeRhy0rgElyA7cq5lovf/1TjSRTH7h5MW/KtuH2vZ
         5KHgCMc5G/F5Xz183vblYAMQFpkrw2rIaXu36cv3SP52cGL206iqUWLnPSHdJb7HpN4F
         uVbg==
X-Forwarded-Encrypted: i=1; AJvYcCUnPjr7i+GwrR6lfBVdC8dkmrRKECG+tCszTzQ8PRAOYAoM5teJQ5lbWWtfMZmX1SNTPIIQjzHFOyU=@vger.kernel.org, AJvYcCVuXyKaculkcYqHWFK2W6Ugp8rHLRtpvcahlF6msC7tmZ7bBPS9WaRT9EZvSV/vY7npOU5ytjZqgUG+Iq4A@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKsXtqNIL34g03mGiMA7MxSCLMiRqYkILNKiojxmPNjjkel0+
	JDzM+XChyWbhK2lMPO8OBbiGzLMWHW9kUIKaIhKTE0mkNjgtZvtQBx3U/dK6
X-Gm-Gg: ASbGncuIJV/E8jwXjdAPT1OYdu0IX3Gic5CX6Gy2PiEn33FcwzfybcnAlEAr2nPGyb/
	vVyhXLmQuJgCFfWjjT++4+8J370M96tYDdLC0GMZyfpy45MRTmQ9mBEJqtl7VpMP8+iOhkhGVrq
	GmLOWV5inD89zL0UGxnfojVGr3+f72aFxmpb1IEhJfS0Se03Dp2wXXmJzKuXt5S70vDgPKNrE9V
	kIbM0rVNtyO1RMbsgmkRU1cQ4RLVU2DXbWIv5b4sS/Si+jsD4OROTs39Eisq1n3gt3Xhh142+4d
	o3UVxJuHOgOqewBUj8/bQwJ4
X-Google-Smtp-Source: AGHT+IEqmZ/zw/2RYAb/i5OhbSJ5JrlYwM3gww/+dRFqbYgXrwVkj6qJ6V8F3Z30APjy+N/Ji+N1ew==
X-Received: by 2002:a17:906:3296:b0:abb:b1ae:173b with SMTP id a640c23a62f3a-abc0d994e4emr1665532466b.11.1740510714491;
        Tue, 25 Feb 2025 11:11:54 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abed2010d58sm187491366b.88.2025.02.25.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 11:11:54 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 25 Feb 2025 22:11:46 +0300
Subject: [PATCH] hwmon: (max77705) add initial support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPEVvmcC/y3NQQrCMBCF4auUWTuQpISAVxEXIZ3qgCZxJi2F0
 rs3qMvvLd6/g5IwKVyHHYRWVi65w14GSM+YH4Q8dYMzzhvrRuTMjeMLdam1SMO5CL7jFkIwHpW
 yFlGMk7HBxGQpeehXVWjm7Zu53X8W+iy91v7jcZwY+tbIiwAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740510713; l=11128;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=MUX52mLrc9tAzehVSU27yGUahedRxwTwQS/B41HkVUA=;
 b=wSbpoMAXVidnW1lel99HXq7bllZF+eNL2/kUHW7joXzoTo84MU1HrCQpF+pqkgl1lGn35eYRz
 5t9AooMYg+cD+1PqRQYGXFJBOch/XwVDjdCgZ3hIQw1whpWV/CQyViE
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Add support for max77705 hwmon. Includes charger input, system bus, and
vbyp measurements.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
Maxim MAX77705 is a Companion Power Management and Type-C interface IC.
It includes charger and fuel gauge blocks, and is capable of measuring
charger input current, system bus volatage and current, and bypass
voltage.

This patch add support for mentioned measurements.
---
 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/max77705.rst |  39 +++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                      |   7 +++++++
 drivers/hwmon/Kconfig            |  10 ++++++++++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/max77705-hwmon.c   | 260 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 318 insertions(+)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 874f8fd26325..444c7865f74f 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -158,6 +158,7 @@ Hardware Monitoring Kernel Drivers
    max6639
    max6650
    max6697
+   max77705
    max8688
    mc13783-adc
    mc34vr500
diff --git a/Documentation/hwmon/max77705.rst b/Documentation/hwmon/max77705.rst
new file mode 100644
index 000000000000..9037226c50b9
--- /dev/null
+++ b/Documentation/hwmon/max77705.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver max77705
+====================
+
+Supported chips:
+
+  * Maxim Integrated MAX77705
+
+    Prefix: 'max77705'
+
+    Addresses scanned: none
+
+    Datasheet: Not available
+
+Authors:
+      - Dzmitry Sankouski <dsankouski@gmail.com>
+
+Description
+-----------
+
+The MAX77705 PMIC provides current and voltage measurements besides fuelgauge:
+- chip input current
+- system bus current and voltage
+- VBYP voltage
+
+Sysfs Attributes
+----------------
+
+================= ========================================
+in1_label         "vbyp"
+in1_input         Measured chip vbyp voltage
+in2_label         "vsys"
+in2_input         Measured chip system bus voltage
+curr1_label       "iin"
+curr1_input       Measured chip input current.
+curr2_label       "isys"
+curr2_input       Measured chip system bus current.
+================= ========================================
diff --git a/MAINTAINERS b/MAINTAINERS
index f076360ce3c6..b6e970731928 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18025,6 +18025,13 @@ S:	Maintained
 F:	Documentation/hwmon/pc87427.rst
 F:	drivers/hwmon/pc87427.c
 
+MAX77705 HARDWARE MONITORING DRIVER
+M:	Dzmitry Sankouski <dsankouski@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/max77705.rst
+F:	drivers/hwmon/max77705-hwmon.c
+
 PCA9532 LED DRIVER
 M:	Riku Voipio <riku.voipio@iki.fi>
 S:	Maintained
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index f114d0c55d78..17b2e1b535eb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1287,6 +1287,16 @@ config SENSORS_MAX31790
 	  This driver can also be built as a module. If so, the module
 	  will be called max31790.
 
+config SENSORS_MAX77705
+	tristate "MAX77705 current and voltage sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for MAX77705 sensors connected with I2C.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called max77705-hwmon.
+
 config SENSORS_MC34VR500
 	tristate "NXP MC34VR500 hardware monitoring driver"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b7ef0f0562d3..ff69f45eca50 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -159,6 +159,7 @@ obj-$(CONFIG_SENSORS_MAX6650)	+= max6650.o
 obj-$(CONFIG_SENSORS_MAX6697)	+= max6697.o
 obj-$(CONFIG_SENSORS_MAX31790)	+= max31790.o
 obj-$(CONFIG_MAX31827) += max31827.o
+obj-$(CONFIG_SENSORS_MAX77705) += max77705-hwmon.o
 obj-$(CONFIG_SENSORS_MC13783_ADC)+= mc13783-adc.o
 obj-$(CONFIG_SENSORS_MC34VR500)	+= mc34vr500.o
 obj-$(CONFIG_SENSORS_MCP3021)	+= mcp3021.o
diff --git a/drivers/hwmon/max77705-hwmon.c b/drivers/hwmon/max77705-hwmon.c
new file mode 100644
index 000000000000..3218e9f5a726
--- /dev/null
+++ b/drivers/hwmon/max77705-hwmon.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  MAX77705 voltage and current hwmon driver.
+ *
+ *  Copyright (C) 2025 Dzmitry Sankouski <dsankouski@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/regmap.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+
+struct max77705_hwmon {
+	struct regmap *regmap;
+};
+
+struct channel_desc {
+	u8 reg;
+	u8 avg_reg;
+	const char *const label;
+	// register resolution. nano Volts for voltage, nano Amperes for current
+	u64 resolution;
+};
+
+static const struct channel_desc current_channel_desc[] = {
+	{
+		.reg = IIN_REG,
+		.label = "IIN_REG",
+		.resolution = 125000
+	},
+	{
+		.reg = ISYS_REG,
+		.avg_reg = AVGISYS_REG,
+		.label = "ISYS_REG",
+		.resolution = 312500
+	}
+};
+
+static const struct channel_desc voltage_channel_desc[] = {
+	{
+		.reg = VBYP_REG,
+		.label = "VBYP_REG",
+		.resolution = 427246
+	},
+	{
+		.reg = VSYS_REG,
+		.label = "VSYS_REG",
+		.resolution = 156250
+	}
+};
+
+static const struct regmap_range max77705_hwmon_readable_ranges[] = {
+	regmap_reg_range(AVGISYS_REG,	AVGISYS_REG + 1),
+	regmap_reg_range(IIN_REG,	IIN_REG + 1),
+	regmap_reg_range(ISYS_REG,	ISYS_REG + 1),
+	regmap_reg_range(VBYP_REG,	VBYP_REG + 1),
+	regmap_reg_range(VSYS_REG,	VSYS_REG + 1),
+};
+
+static const struct regmap_access_table max77705_hwmon_readable_table = {
+	.yes_ranges = max77705_hwmon_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(max77705_hwmon_readable_ranges),
+};
+
+static const struct regmap_config max77705_hwmon_regmap_config = {
+	.name = "max77705_hwmon",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.rd_table = &max77705_hwmon_readable_table,
+	.max_register = MAX77705_FG_END,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE
+};
+
+static umode_t max77705_is_visible(const void *data,
+		enum hwmon_sensor_types type,
+		u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_in:
+		if (channel >= ARRAY_SIZE(voltage_channel_desc))
+			return 0;
+
+		switch (attr) {
+		case hwmon_in_input:
+		case hwmon_in_label:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	case hwmon_curr:
+		if (channel >= ARRAY_SIZE(current_channel_desc))
+			return 0;
+
+		switch (attr) {
+		case hwmon_curr_input:
+		case hwmon_in_label:
+			return 0444;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int max77705_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+		int channel, const char **buf)
+{
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_in_label:
+			*buf = current_channel_desc[channel].label;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_label:
+			*buf = voltage_channel_desc[channel].label;
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int max77705_read(struct device *dev, enum hwmon_sensor_types type,
+		u32 attr, int channel, long *val)
+{
+	struct max77705_hwmon *drv_data = dev_get_drvdata(dev);
+	struct regmap *regmap = drv_data->regmap;
+	u8 reg;
+	u32 regval;
+	u64 res;
+	int ret;
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			reg = current_channel_desc[channel].reg;
+			res = current_channel_desc[channel].resolution;
+			ret = regmap_read(regmap, reg, &regval);
+			if (ret < 0)
+				return ret;
+			*val = mult_frac((long) regval, res, 1000000);
+			return 0;
+		case hwmon_curr_average:
+			reg = current_channel_desc[channel].avg_reg;
+			res = current_channel_desc[channel].resolution;
+			if (reg) {
+				ret = regmap_read(regmap, reg, &regval);
+				if (ret < 0)
+					return ret;
+				*val = mult_frac((long) regval, res, 1000000);
+			}
+			return 0;
+
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			reg = voltage_channel_desc[channel].reg;
+			res = voltage_channel_desc[channel].resolution;
+			ret = regmap_read(regmap, reg, &regval);
+			if (ret < 0)
+				return ret;
+			*val = mult_frac((long) regval, res, 1000000);
+			return 0;
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops max77705_hwmon_ops = {
+	.is_visible = max77705_is_visible,
+	.read = max77705_read,
+	.read_string = max77705_read_string,
+};
+
+static const struct hwmon_channel_info *max77705_info[] = {
+	HWMON_CHANNEL_INFO(in,
+			HWMON_I_INPUT | HWMON_I_LABEL,
+			HWMON_I_INPUT | HWMON_I_LABEL
+			),
+	HWMON_CHANNEL_INFO(curr,
+			HWMON_C_INPUT | HWMON_C_AVERAGE | HWMON_C_LABEL,
+			HWMON_C_INPUT | HWMON_C_LABEL
+			),
+	NULL
+};
+
+static const struct hwmon_chip_info max77705_chip_info = {
+	.ops = &max77705_hwmon_ops,
+	.info = max77705_info,
+};
+
+static int max77705_hwmon_probe(struct platform_device *pdev)
+{
+	struct i2c_client *i2c;
+	struct device *hwmon_dev;
+	struct max77705_hwmon *drv_data;
+
+	drv_data = devm_kzalloc(&pdev->dev, sizeof(struct max77705_hwmon),
+			GFP_KERNEL);
+	if (!drv_data)
+		return -ENOMEM;
+
+	i2c = to_i2c_client(pdev->dev.parent);
+	drv_data->regmap = devm_regmap_init_i2c(i2c, &max77705_hwmon_regmap_config);
+	if (IS_ERR(drv_data->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(drv_data->regmap),
+				"Failed to register max77705 hwmon regmap\n");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "max77705", drv_data,
+			&max77705_chip_info, NULL);
+	if (IS_ERR(hwmon_dev)) {
+		return dev_err_probe(&i2c->dev, PTR_ERR(hwmon_dev),
+				"Unable to register hwmon device\n");
+	}
+
+	return 0;
+};
+
+static struct platform_driver max77705_hwmon_driver = {
+	.driver = {
+		.name = "max77705-hwmon",
+	},
+	.probe = max77705_hwmon_probe,
+};
+
+module_platform_driver(max77705_hwmon_driver);
+
+MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
+MODULE_DESCRIPTION("MAX77705 monitor driver");
+MODULE_LICENSE("GPL");
+

---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250123-initial-support-for-max77705-sensors-ad0170ac1ec5

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


