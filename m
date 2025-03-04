Return-Path: <linux-kernel+bounces-543962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66534A4DBDD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E52188DCC7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B51FF1A0;
	Tue,  4 Mar 2025 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bde/3n0y"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31751FECDB;
	Tue,  4 Mar 2025 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086528; cv=none; b=P12cDmLFgiHv+jfiUCkiJt1+KRFzvCvhMDp0MP7R5pcRVti4wq9z6fRAwqw+KYhUZpVHgCV5ukfkTkYEKUpDY6Eube82dVtJA1+qTciCATfXjD7WuH4tSX7AF3DFb9lwdTd/fKfEkvNVmEadB26NPrscY17/QPMPXc/pasR897s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086528; c=relaxed/simple;
	bh=4xkw0yYacB0/6Q5LwI8fkd9jTNv0eZdwxdKwCFqlyEc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PbTQ0ydw5M9bYKO/qpljP7lpnu1UIO0hAMiRfpO3XpNUtznVGJZQQvfCgAfFj3th0NM5isttUNKW4LVKNCrFjQernNZryGSMhU/cFAnBWfineQXSlv8FKpfpm7pWWRCop5yzC1Cm5qEuSygADbvdAggVBygQkyIS35kdidx26QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bde/3n0y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so7867731a12.2;
        Tue, 04 Mar 2025 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741086525; x=1741691325; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MRjbS74Nsh8/qZkVcV7Vot+3slTDRd+TY3FbkFl3aNo=;
        b=Bde/3n0y9icKKRCtSLbOwqCszWjgEbxHM+whyGY2P/AGQ3DvQw1b3PXjBNZyUIVjhd
         UKIsSk4SKd9/jSdCVhS0odliX2AtUrWy/LVpb4+n1HG72X3jJN9wppXTp2N2W18n+f39
         6mtKO+G+ekxc/8T9+pwli6jdkAMFa30KNm/zqX+2ffa8yUtkPN6bJiNz5dOEeLIes+a5
         1y4ALq0fflvUJ4QLH5l8kqZQo36A2gebloa658ah//PhCT70gumjdYtwotIQUW/DOiuY
         2zInwphDr3IVfIa2wBsJNPLoYHgsyBvV3EcKhlUl7j3A9P8wE/xb/P3y+EP2MFrdG8WY
         uvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086525; x=1741691325;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRjbS74Nsh8/qZkVcV7Vot+3slTDRd+TY3FbkFl3aNo=;
        b=BpeW6QvQSk8Yv2L4bK90tQXNrNj3LvuB9gZ0aR6n2iD1sW7nJfT7za7xYGmDetas3i
         ZWWN6MIcGiXNrHAAOmWfVFZJ83P+mieil2d796sKQfAP/nfO4P8gI0p9GvHyW4sln/QM
         Xppn2HQR0nlhFefYSgpM3YwZQvZVYaYhCmEYTCxNwkt6BnJXf36mxUpRn+DOvGMkHIKm
         0/g+ZCo7roe841noF/b+NFsJX5Eu+dW3V6t4ynh6CwoZK2YP53dA4TYtI/XmDhZ2Vptw
         L2i2+q4T4w7B3XuHfnw+VHZBaJ3qR+L0NUcpHq6IcJYyw5Qqf5YTkeK4MP7IpL/g2TYJ
         c5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV5iROHbzIUENCz3FrHNstyrxwHLqRamNEQOaGs360YQOtISfdhXsQxXF+qE1CUCr2M7RvFNZTi4JM=@vger.kernel.org, AJvYcCW8oFhICIkDwG6mPNqJ+X7CJwuZ3TzARSLDjg5XAtBTflzWhaVNRmMiGSEFs1NDEzqrgYDLljyBZElp6FHf@vger.kernel.org
X-Gm-Message-State: AOJu0YxY0hrQT+SkpdsSgnnOC3G53oJWFLmZKNslKa0W0pDHwxv24V5B
	75QF7cn1Ln/0dSdo1Z7nxESptr4W0XrQwt2DMAbvnJ9dh/TX9y2L
X-Gm-Gg: ASbGnct5xIJfWD18SvC6sjG4D7WwRUh0FIZN6xcDVp4SFCwcarM0iAU0PhUTCfNqB2E
	xNTi1KxbrOcZMgcn/VG2iTWfOAkGvLsiq4BqlsYUsaRdhdFCXr1tLpC9+7ppk68mqe33WMXJ0/P
	RNFcm+JmuGMMWK80q/0HC1TmD8ShnqD5rfVTm5ugu16ct3UgBN5xi4HatvC4PlaCHobqsTyc8Kk
	gccDhZRXI0ppkS1tJKUSl/wX9j/zMMzPNONicrw05JRbxw2RFAVX53tl5iLmm5wPw4iy3L2Xx3U
	B6W8JxOitSo1rzbMiZ4fZErqKE5+tQuQutNDkjRX9Gc=
X-Google-Smtp-Source: AGHT+IE1Np6k0sfwEuo8edx8oMlGkUOpQl3WFhV3iKjRQEVe2y/wzupGuFLz92VZSFKAR8kjCHXWLQ==
X-Received: by 2002:a05:6402:1d4a:b0:5e4:be64:b562 with SMTP id 4fb4d7f45d1cf-5e4d6adb99fmr14634828a12.1.1741086524560;
        Tue, 04 Mar 2025 03:08:44 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.22])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51e1sm8262041a12.61.2025.03.04.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:08:43 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 04 Mar 2025 14:08:40 +0300
Subject: [PATCH v2] hwmon: (max77705) add initial support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-initial-support-for-max77705-sensors-v2-1-58d2207c732b@gmail.com>
X-B4-Tracking: v=1; b=H4sIADffxmcC/42OsQ6CMBRFf4V09pm2Wmqc/A/DUMoDXgIttoVgC
 P8uwuDqeM5wz11YxEAY2T1bWMCJInm3gTxlzLbGNQhUbcwkl4oLeQFylMh0EMdh8CFB7QP0ZtZ
 acwURXfQhgqm40NxYgVaxbWoIWNO8Z57FwQFf41ZLP9lSTD689yuT+NqjKqX6rzoJECBLzK+5z
 uWt5I+mN9Sdre9Zsa7rBx9gDRDtAAAA
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741086522; l=11567;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=4xkw0yYacB0/6Q5LwI8fkd9jTNv0eZdwxdKwCFqlyEc=;
 b=8IF6/x0sJWHtuL5LtWUNiphXXL3SiISj+3oqxNmfvm5zmngkg9prKJfjO3lxnVNOWb3y14jHV
 hqVRyO5AWuTC5m0ts/ev3/2GUJYowpiowP7WA+pGwhShCjsuEHpgUqC
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

Add support for mentioned measurements.
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250225-initial-support-for-max77705-sensors-v1-1-2be6467628b0@gmail.com
---
Changes in v2:
- sort headers alphabetically
- swap curr channel info, to align indeces with channel_desc struct
- reword coverletter
- fix checkpatch --strict warnings
- remove struct max77705_hwmon, use regmap directly
- move register validation logic to is_visible function
- move common register reading and converting logic to separate function
- remove unnessesary {} in if statement
- s/i2c->dev/pdev->dev in dev_err_probe
---
 Documentation/hwmon/index.rst    |   1 +
 Documentation/hwmon/max77705.rst |  39 +++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                      |   7 +++++++
 drivers/hwmon/Kconfig            |  10 ++++++++++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/max77705-hwmon.c   | 250 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 308 insertions(+)

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
index 29e1a423eee5..0175f9f89325 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18110,6 +18110,13 @@ S:	Maintained
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
index 56494ab85b83..c86fe094a978 100644
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
index 000000000000..6d2161421ac7
--- /dev/null
+++ b/drivers/hwmon/max77705-hwmon.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  MAX77705 voltage and current hwmon driver.
+ *
+ *  Copyright (C) 2025 Dzmitry Sankouski <dsankouski@gmail.com>
+ */
+
+#include <linux/err.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/i2c.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mfd/max77705-private.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
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
+static int max77705_read_and_convert(struct regmap *regmap, u8 reg, u64 res, long *val)
+{
+	int ret;
+	u32 regval;
+
+	ret = regmap_read(regmap, reg, &regval);
+	if (ret < 0)
+		return ret;
+	*val = mult_frac((long)regval, res, 1000000);
+
+	return 0;
+}
+
+static umode_t max77705_is_visible(const void *data,
+				   enum hwmon_sensor_types type,
+				   u32 attr, int channel)
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
+		case hwmon_curr_average:
+			if (current_channel_desc[channel].avg_reg)
+				return 0444;
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
+				int channel, const char **buf)
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
+			 u32 attr, int channel, long *val)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+	u8 reg;
+	u64 res;
+
+	switch (type) {
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_input:
+			reg = current_channel_desc[channel].reg;
+			res = current_channel_desc[channel].resolution;
+
+			return max77705_read_and_convert(regmap, reg, res, val);
+		case hwmon_curr_average:
+			reg = current_channel_desc[channel].avg_reg;
+			res = current_channel_desc[channel].resolution;
+
+			return max77705_read_and_convert(regmap, reg, res, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			reg = voltage_channel_desc[channel].reg;
+			res = voltage_channel_desc[channel].resolution;
+
+			return max77705_read_and_convert(regmap, reg, res, val);
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
+			   HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL
+			),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_AVERAGE | HWMON_C_LABEL
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
+	struct regmap *regmap;
+
+	i2c = to_i2c_client(pdev->dev.parent);
+	regmap = devm_regmap_init_i2c(i2c, &max77705_hwmon_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(regmap),
+				"Failed to register max77705 hwmon regmap\n");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev, "max77705", regmap,
+							 &max77705_chip_info, NULL);
+	if (IS_ERR(hwmon_dev))
+		return dev_err_probe(&pdev->dev, PTR_ERR(hwmon_dev),
+				"Unable to register hwmon device\n");
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
base-commit: 20d5c66e1810e6e8805ec0d01373afb2dba9f51a
change-id: 20250123-initial-support-for-max77705-sensors-ad0170ac1ec5

Best regards,
-- 
Dzmitry Sankouski <dsankouski@gmail.com>


