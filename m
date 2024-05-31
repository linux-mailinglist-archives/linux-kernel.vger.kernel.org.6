Return-Path: <linux-kernel+bounces-197580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C678D6CB6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 01:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967451C2567D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53531824B9;
	Fri, 31 May 2024 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR7CSZHu"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0246312F5B1;
	Fri, 31 May 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717196767; cv=none; b=iI5EhWsAE/YJ0NDW6xuhSvLP7i/NDPtOplvF5BeXA4UMBb8TGf5FxvW49jlNQAG0JIhu2BIhGU06kl6tzKNpzq6JcTkNqw3NUl+erSitIjgsKnzBFF0BOco5UkKwOjIrElbIey2XHrmwNNJqL/f64rwMzuI3VH0Qr+omasUpEk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717196767; c=relaxed/simple;
	bh=VWe1hC5XxxcNcqor6qu109tvC43BKqijjGRcgjuBsE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGD8r/72uCv6e5wc1t2o5wqsslf8N/F8/VQHjsBXXX50GLhI/jXN2OzQPFGDc6I8xJmkU6KgjJ8nwPzrkzftYu7tXM9CdzWqGYaIbBh4mRrb2ey4Yjm82hLWC+ZiLxx1N1ZymFHPIklyooAoI7igX/18w36o88gKtk9IYhEsUUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR7CSZHu; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7024791a950so811191b3a.0;
        Fri, 31 May 2024 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717196765; x=1717801565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3k1e7e5ObSKBTWrLdj1Bg49bVE88LuH5wceiXhNuxuQ=;
        b=bR7CSZHuQRMnl/XLAxjyQrFBs0GogcusKRNNb/Q4Y0kRvTqGV6kNWHCHue/KnDzFLn
         96UmbnZxoI62icw63fceKifO+07V+daiCPUeHi26M/hKj3u2aOkzZH2CXdx4W3c8IXWV
         Y/Gog1+Unl4Rlo6W/4GoIIjI48+NZo9q8sSDYswBiLmift1tu1N6d88QzWCyIBPiNngo
         sjsNtShvGw5/zApGp8G6kvKBz/EXRUiky1XNSyKwOg7RYn/DNdsxxBuslRN+29AzdHHu
         tnUfqMDYc0VERfWiPjDYYBiYo9o1mi7FYTuxhvHgSOmNUhzG7dJz59PNGLB7/s/N3l8b
         NU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717196765; x=1717801565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3k1e7e5ObSKBTWrLdj1Bg49bVE88LuH5wceiXhNuxuQ=;
        b=C7vRN9xEf102srWGp0dgIE8Ckb2aOiZYTU4FKdGEHYrq29aCOLWmql+P4llbPcFJ1p
         UM3PEOrYhkIQx3qxHCKVmvIop9Ozj5GOYQ+zCzk4BpitQOUeM0IAjG/e8XYwiaopa/tp
         DWIlC+R2K10CQkPkiJ17FRMdVsNve4AK6Mu37CZv9rN7OtCn2LSVHtT12ZVzfLxJ+gTd
         EVATWijsSOkRYaeXERhkRXWnP1ho2hk8cmNNpYoLX5S8TduCxjq7K+MshOBkYp5EH9Jx
         fvRrdhdnng8U30sYdr/QptnUIBQZzBNC/5n4onIXC5UbMHDS4bkz5u1C8dEIsERPHAgp
         AEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF4yck0uJNm30FE8jfebwxYd2EWCgg/QxweJE3ZAPaFgO4TJLkk3wIWEk0VHIXOXoLnBU0NnfKJWS5u7upTicUPYMePxxIwR8/l0o6
X-Gm-Message-State: AOJu0Yyqspb3rTrGuTIXvEvzo3l8Nzzp5emW2XR/Mp7SzaUcc11YRkYT
	R6Y0O49Rw+pjdEmXIfvEirudPekF3h8wP7kAosdgF53goGaLToN7xlNnTw==
X-Google-Smtp-Source: AGHT+IH/byftp6CFDFgHfT6uHurqfl6Vd3ZvkePZkhzRZ2baBuvUcotid9Rig9u4tmaDmD2TsU4A2w==
X-Received: by 2002:a05:6a21:789c:b0:1b0:20e9:d215 with SMTP id adf61e73a8af0-1b26f16ec7bmr5368639637.14.1717196764342;
        Fri, 31 May 2024 16:06:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-702425d8a5fsm1876557b3a.76.2024.05.31.16.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 16:06:03 -0700 (PDT)
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
Subject: [PATCH v3 2/4] hwmon: Add support for SPD5118 compliant temperature sensors
Date: Fri, 31 May 2024 16:05:54 -0700
Message-Id: <20240531230556.1409532-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531230556.1409532-1-linux@roeck-us.net>
References: <20240531230556.1409532-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for SPD5118 (Jedec JESD300) compliant temperature
sensors. Such sensors are typically found on DDR5 memory modules.

Cc: René Rebe <rene@exactcode.de>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Shorten JESD300-5B.01 to JESD300; 5B.01 refers to the version
    of the standard
    Drop unnecessary 'attr' parameter from spd5118_{read,write}_enable()

v2: Drop PEC property documentation
    Add note indicating that alarm attributes are sticky until read
    to documentation
    Fix detect function
    Fix misspelling in Makefile (CONFIG_SENSORS_SPD5118->CONFIG_SENSORS_SPD5118)

 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/spd5118.rst |  55 ++++
 drivers/hwmon/Kconfig           |  12 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/spd5118.c         | 481 ++++++++++++++++++++++++++++++++
 5 files changed, 550 insertions(+)
 create mode 100644 Documentation/hwmon/spd5118.rst
 create mode 100644 drivers/hwmon/spd5118.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 03d313af469a..6e7b8726b60c 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -215,6 +215,7 @@ Hardware Monitoring Kernel Drivers
    smsc47m192
    smsc47m1
    sparx5-temp
+   spd5118
    stpddc60
    surface_fan
    sy7636a-hwmon
diff --git a/Documentation/hwmon/spd5118.rst b/Documentation/hwmon/spd5118.rst
new file mode 100644
index 000000000000..a15d75aa2066
--- /dev/null
+++ b/Documentation/hwmon/spd5118.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver spd5118
+=====================
+
+Supported chips:
+
+  * SPD5118 (JEDEC JESD300) compliant temperature sensor chips
+
+    JEDEC standard download:
+	https://www.jedec.org/standards-documents/docs/jesd300-5b01
+	(account required)
+
+
+    Prefix: 'spd5118'
+
+    Addresses scanned: I2C 0x50 - 0x57
+
+Author:
+	Guenter Roeck <linux@roeck-us.net>
+
+
+Description
+-----------
+
+This driver implements support for SPD5118 (JEDEC JESD300) compliant temperature
+sensors, which are used on many DDR5 memory modules. Some systems use the sensor
+to prevent memory overheating by automatically throttling the memory controller.
+
+The driver auto-detects SPD5118 compliant chips, but can also be instantiated
+using devicetree/firmware nodes.
+
+A SPD5118 compliant chip supports a single temperature sensor. Critical minimum,
+minimum, maximum, and critical temperature can be configured. There are alarms
+for low critical, low, high, and critical thresholds.
+
+
+Hardware monitoring sysfs entries
+---------------------------------
+
+======================= ==================================
+temp1_input		Temperature (RO)
+temp1_lcrit		Low critical high temperature (RW)
+temp1_min		Minimum temperature (RW)
+temp1_max		Maximum temperature (RW)
+temp1_crit		Critical high temperature (RW)
+
+temp1_lcrit_alarm	Temperature low critical alarm
+temp1_min_alarm		Temperature low alarm
+temp1_max_alarm		Temperature high alarm
+temp1_crit_alarm	Temperature critical alarm
+======================= ==================================
+
+Alarm attributes are sticky until read and will be cleared afterwards
+unless the alarm condition still applies.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e14ae18a973b..d0fb5fe1b2ac 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2181,6 +2181,18 @@ config SENSORS_INA3221
 	  This driver can also be built as a module. If so, the module
 	  will be called ina3221.
 
+config SENSORS_SPD5118
+	tristate "SPD5118 Compliant Temperature Sensors"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for SPD5118 (JEDEC JESD300)
+	  compliant temperature sensors. Such sensors are found on DDR5 memory
+	  modules.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called spd5118.
+
 config SENSORS_TC74
 	tristate "Microchip TC74"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index e3f25475d1f0..6574ca67d761 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -207,6 +207,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
+obj-$(CONFIG_SENSORS_SPD5118)	+= spd5118.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
new file mode 100644
index 000000000000..d3fc0ae17743
--- /dev/null
+++ b/drivers/hwmon/spd5118.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for Jedec 5118 compliant temperature sensors
+ *
+ * Derived from https://github.com/Steve-Tech/SPD5118-DKMS
+ * Originally from T/2 driver at https://t2sde.org/packages/linux
+ *	Copyright (c) 2023 René Rebe, ExactCODE GmbH; Germany.
+ *
+ * Copyright (c) 2024 Guenter Roeck
+ *
+ * Inspired by ee1004.c and jc42.c.
+ *
+ * SPD5118 compliant temperature sensors are typically used on DDR5
+ * memory modules.
+ */
+
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+/* Addresses to scan */
+static const unsigned short normal_i2c[] = {
+	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, I2C_CLIENT_END };
+
+/* SPD5118 registers. */
+#define SPD5118_REG_TYPE		0x00	/* MR0:MR1 */
+#define SPD5118_REG_REVISION		0x02	/* MR2 */
+#define SPD5118_REG_VENDOR		0x03	/* MR3:MR4 */
+#define SPD5118_REG_CAPABILITY		0x05	/* MR5 */
+#define SPD5118_REG_I2C_LEGACY_MODE	0x0B	/* MR11 */
+#define SPD5118_REG_TEMP_CLR		0x13	/* MR19 */
+#define SPD5118_REG_ERROR_CLR		0x14	/* MR20 */
+#define SPD5118_REG_TEMP_CONFIG		0x1A	/* MR26 */
+#define SPD5118_REG_TEMP_MAX		0x1c	/* MR28:MR29 */
+#define SPD5118_REG_TEMP_MIN		0x1e	/* MR30:MR31 */
+#define SPD5118_REG_TEMP_CRIT		0x20	/* MR32:MR33 */
+#define SPD5118_REG_TEMP_LCRIT		0x22	/* MR34:MR35 */
+#define SPD5118_REG_TEMP		0x31	/* MR49:MR50 */
+#define SPD5118_REG_TEMP_STATUS		0x33	/* MR51 */
+
+#define SPD5118_TEMP_STATUS_HIGH	BIT(0)
+#define SPD5118_TEMP_STATUS_LOW		BIT(1)
+#define SPD5118_TEMP_STATUS_CRIT	BIT(2)
+#define SPD5118_TEMP_STATUS_LCRIT	BIT(3)
+
+#define SPD5118_CAP_TS_SUPPORT		BIT(1)	/* temperature sensor support */
+
+#define SPD5118_TS_DISABLE		BIT(0)	/* temperature sensor disable */
+
+/* Temperature unit in millicelsius */
+#define SPD5118_TEMP_UNIT		(MILLIDEGREE_PER_DEGREE / 4)
+/* Representable temperature range in millicelsius */
+#define SPD5118_TEMP_RANGE_MIN		-256000
+#define SPD5118_TEMP_RANGE_MAX		255750
+
+static int spd5118_temp_from_reg(u16 reg)
+{
+	int temp = sign_extend32(reg >> 2, 10);
+
+	return temp * SPD5118_TEMP_UNIT;
+}
+
+static u16 spd5118_temp_to_reg(long temp)
+{
+	temp = clamp_val(temp, SPD5118_TEMP_RANGE_MIN, SPD5118_TEMP_RANGE_MAX);
+	return (DIV_ROUND_CLOSEST(temp, SPD5118_TEMP_UNIT) & 0x7ff) << 2;
+}
+
+static int spd5118_read_temp(struct regmap *regmap, u32 attr, long *val)
+{
+	int reg, err;
+	u8 regval[2];
+	u16 temp;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		reg = SPD5118_REG_TEMP;
+		break;
+	case hwmon_temp_max:
+		reg = SPD5118_REG_TEMP_MAX;
+		break;
+	case hwmon_temp_min:
+		reg = SPD5118_REG_TEMP_MIN;
+		break;
+	case hwmon_temp_crit:
+		reg = SPD5118_REG_TEMP_CRIT;
+		break;
+	case hwmon_temp_lcrit:
+		reg = SPD5118_REG_TEMP_LCRIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = regmap_bulk_read(regmap, reg, regval, 2);
+	if (err)
+		return err;
+
+	temp = (regval[1] << 8) | regval[0];
+
+	*val = spd5118_temp_from_reg(temp);
+	return 0;
+}
+
+static int spd5118_read_alarm(struct regmap *regmap, u32 attr, long *val)
+{
+	unsigned int mask, regval;
+	int err;
+
+	switch (attr) {
+	case hwmon_temp_max_alarm:
+		mask = SPD5118_TEMP_STATUS_HIGH;
+		break;
+	case hwmon_temp_min_alarm:
+		mask = SPD5118_TEMP_STATUS_LOW;
+		break;
+	case hwmon_temp_crit_alarm:
+		mask = SPD5118_TEMP_STATUS_CRIT;
+		break;
+	case hwmon_temp_lcrit_alarm:
+		mask = SPD5118_TEMP_STATUS_LCRIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	err = regmap_read(regmap, SPD5118_REG_TEMP_STATUS, &regval);
+	if (err < 0)
+		return err;
+	*val = !!(regval & mask);
+	if (*val)
+		return regmap_write(regmap, SPD5118_REG_TEMP_CLR, mask);
+	return 0;
+}
+
+static int spd5118_read_enable(struct regmap *regmap, long *val)
+{
+	u32 regval;
+	int err;
+
+	err = regmap_read(regmap, SPD5118_REG_TEMP_CONFIG, &regval);
+	if (err < 0)
+		return err;
+	*val = !(regval & SPD5118_TS_DISABLE);
+	return 0;
+}
+
+static int spd5118_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	if (type != hwmon_temp)
+		return -EOPNOTSUPP;
+
+	switch (attr) {
+	case hwmon_temp_input:
+	case hwmon_temp_max:
+	case hwmon_temp_min:
+	case hwmon_temp_crit:
+	case hwmon_temp_lcrit:
+		return spd5118_read_temp(regmap, attr, val);
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_min_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_lcrit_alarm:
+		return spd5118_read_alarm(regmap, attr, val);
+	case hwmon_temp_enable:
+		return spd5118_read_enable(regmap, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int spd5118_write_temp(struct regmap *regmap, u32 attr, long val)
+{
+	u8 regval[2];
+	u16 temp;
+	int reg;
+
+	switch (attr) {
+	case hwmon_temp_max:
+		reg = SPD5118_REG_TEMP_MAX;
+		break;
+	case hwmon_temp_min:
+		reg = SPD5118_REG_TEMP_MIN;
+		break;
+	case hwmon_temp_crit:
+		reg = SPD5118_REG_TEMP_CRIT;
+		break;
+	case hwmon_temp_lcrit:
+		reg = SPD5118_REG_TEMP_LCRIT;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	temp = spd5118_temp_to_reg(val);
+	regval[0] = temp & 0xff;
+	regval[1] = temp >> 8;
+
+	return regmap_bulk_write(regmap, reg, regval, 2);
+}
+
+static int spd5118_write_enable(struct regmap *regmap, long val)
+{
+	if (val && val != 1)
+		return -EINVAL;
+
+	return regmap_update_bits(regmap, SPD5118_REG_TEMP_CONFIG,
+				  SPD5118_TS_DISABLE,
+				  val ? 0 : SPD5118_TS_DISABLE);
+}
+
+static int spd5118_temp_write(struct regmap *regmap, u32 attr, long val)
+{
+	switch (attr) {
+	case hwmon_temp_max:
+	case hwmon_temp_min:
+	case hwmon_temp_crit:
+	case hwmon_temp_lcrit:
+		return spd5118_write_temp(regmap, attr, val);
+	case hwmon_temp_enable:
+		return spd5118_write_enable(regmap, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int spd5118_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	struct regmap *regmap = dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_temp:
+		return spd5118_temp_write(regmap, attr, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t spd5118_is_visible(const void *_data, enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	if (type != hwmon_temp)
+		return 0;
+
+	switch (attr) {
+	case hwmon_temp_input:
+		return 0444;
+	case hwmon_temp_min:
+	case hwmon_temp_max:
+	case hwmon_temp_lcrit:
+	case hwmon_temp_crit:
+	case hwmon_temp_enable:
+		return 0644;
+	case hwmon_temp_min_alarm:
+	case hwmon_temp_max_alarm:
+	case hwmon_temp_crit_alarm:
+	case hwmon_temp_lcrit_alarm:
+		return 0444;
+	default:
+		return 0;
+	}
+}
+
+static inline bool spd5118_parity8(u8 w)
+{
+	w ^= w >> 4;
+	return (0x6996 >> (w & 0xf)) & 1;
+}
+
+/*
+ * Bank and vendor id are 8-bit fields with seven data bits and odd parity.
+ * Vendor IDs 0 and 0x7f are invalid.
+ * See Jedec standard JEP106BJ for details and a list of assigned vendor IDs.
+ */
+static bool spd5118_vendor_valid(u8 bank, u8 id)
+{
+	if (!spd5118_parity8(bank) || !spd5118_parity8(id))
+		return false;
+
+	id &= 0x7f;
+	return id && id != 0x7f;
+}
+
+/* Return 0 if detection is successful, -ENODEV otherwise */
+static int spd5118_detect(struct i2c_client *client, struct i2c_board_info *info)
+{
+	struct i2c_adapter *adapter = client->adapter;
+	int regval;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	regval = i2c_smbus_read_word_swapped(client, SPD5118_REG_TYPE);
+	if (regval != 0x5118)
+		return -ENODEV;
+
+	regval = i2c_smbus_read_word_data(client, SPD5118_REG_VENDOR);
+	if (regval < 0 || !spd5118_vendor_valid(regval & 0xff, regval >> 8))
+		return -ENODEV;
+
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_CAPABILITY);
+	if (regval < 0)
+		return -ENODEV;
+	if (!(regval & SPD5118_CAP_TS_SUPPORT) || (regval & 0xfc))
+		return -ENODEV;
+
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CLR);
+	if (regval)
+		return -ENODEV;
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_ERROR_CLR);
+	if (regval)
+		return -ENODEV;
+
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_REVISION);
+	if (regval < 0 || (regval & 0xc1))
+		return -ENODEV;
+
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CONFIG);
+	if (regval < 0)
+		return -ENODEV;
+	if (regval & ~SPD5118_TS_DISABLE)
+		return -ENODEV;
+
+	strscpy(info->type, "spd5118", I2C_NAME_SIZE);
+	return 0;
+}
+
+static const struct hwmon_channel_info *spd5118_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT |
+			   HWMON_T_LCRIT | HWMON_T_LCRIT_ALARM |
+			   HWMON_T_MIN | HWMON_T_MIN_ALARM |
+			   HWMON_T_MAX | HWMON_T_MAX_ALARM |
+			   HWMON_T_CRIT | HWMON_T_CRIT_ALARM |
+			   HWMON_T_ENABLE),
+	NULL
+};
+
+static const struct hwmon_ops spd5118_hwmon_ops = {
+	.is_visible = spd5118_is_visible,
+	.read = spd5118_read,
+	.write = spd5118_write,
+};
+
+static const struct hwmon_chip_info spd5118_chip_info = {
+	.ops = &spd5118_hwmon_ops,
+	.info = spd5118_info,
+};
+
+static bool spd5118_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SPD5118_REG_TEMP_CLR:
+	case SPD5118_REG_TEMP_CONFIG:
+	case SPD5118_REG_TEMP_MAX:
+	case SPD5118_REG_TEMP_MAX + 1:
+	case SPD5118_REG_TEMP_MIN:
+	case SPD5118_REG_TEMP_MIN + 1:
+	case SPD5118_REG_TEMP_CRIT:
+	case SPD5118_REG_TEMP_CRIT + 1:
+	case SPD5118_REG_TEMP_LCRIT:
+	case SPD5118_REG_TEMP_LCRIT + 1:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool spd5118_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SPD5118_REG_TEMP_CLR:
+	case SPD5118_REG_ERROR_CLR:
+	case SPD5118_REG_TEMP:
+	case SPD5118_REG_TEMP + 1:
+	case SPD5118_REG_TEMP_STATUS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config spd5118_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = SPD5118_REG_TEMP_STATUS,
+	.writeable_reg = spd5118_writeable_reg,
+	.volatile_reg = spd5118_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int spd5118_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	unsigned int regval, revision, vendor, bank;
+	struct device *hwmon_dev;
+	struct regmap *regmap;
+	int err;
+
+	regmap = devm_regmap_init_i2c(client, &spd5118_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "regmap init failed\n");
+
+	err = regmap_read(regmap, SPD5118_REG_CAPABILITY, &regval);
+	if (err)
+		return err;
+	if (!(regval & SPD5118_CAP_TS_SUPPORT))
+		return -ENODEV;
+
+	err = regmap_read(regmap, SPD5118_REG_REVISION, &revision);
+	if (err)
+		return err;
+
+	err = regmap_read(regmap, SPD5118_REG_VENDOR, &bank);
+	if (err)
+		return err;
+	err = regmap_read(regmap, SPD5118_REG_VENDOR + 1, &vendor);
+	if (err)
+		return err;
+	if (!spd5118_vendor_valid(bank, vendor))
+		return -ENODEV;
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "spd5118",
+							 regmap, &spd5118_chip_info,
+							 NULL);
+	if (IS_ERR(hwmon_dev))
+		return PTR_ERR(hwmon_dev);
+
+	/*
+	 * From JESD300-5B
+	 *   MR2 bits [5:4]: Major revision, 1..4
+	 *   MR2 bits [3:1]: Minor revision, 0..8? Probably a typo, assume 1..8
+	 */
+	dev_info(dev, "DDR5 temperature sensor: vendor 0x%02x:0x%02x revision %d.%d\n",
+		 bank & 0x7f, vendor, ((revision >> 4) & 0x03) + 1, ((revision >> 1) & 0x07) + 1);
+
+	return 0;
+}
+
+static const struct i2c_device_id spd5118_id[] = {
+	{ "spd5118", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, spd5118_id);
+
+static const struct of_device_id spd5118_of_ids[] = {
+	{ .compatible = "jedec,spd5118", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spd5118_of_ids);
+
+static struct i2c_driver spd5118_driver = {
+	.class		= I2C_CLASS_HWMON,
+	.driver = {
+		.name	= "spd5118",
+		.of_match_table = spd5118_of_ids,
+	},
+	.probe		= spd5118_probe,
+	.id_table	= spd5118_id,
+	.detect		= spd5118_detect,
+	.address_list	= normal_i2c,
+};
+
+module_i2c_driver(spd5118_driver);
+
+MODULE_AUTHOR("René Rebe <rene@exactcode.de>");
+MODULE_AUTHOR("Guenter Roeck <linux@roeck-us.net>");
+MODULE_DESCRIPTION("SPD 5118 driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2


