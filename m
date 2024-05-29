Return-Path: <linux-kernel+bounces-194680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 757ED8D3FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ACA1F227C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7241CB306;
	Wed, 29 May 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5tlOOg/"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CB1C8FC4;
	Wed, 29 May 2024 20:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015935; cv=none; b=oA6/7HDwBzDCpjxduj8nxUWk/s2S8v5QGVQ9Yy3+VkTzlpSgcVResLab4xX4syRdVFdNXhwHIg3jQgF9c7exoObCoUD5gcg7ucPby016aP3PGISqFzjXdE6hjaZrigQDO0U7E27b2rDSAVtnxM7dk+y9w54JyauUqbD/9fKL9RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015935; c=relaxed/simple;
	bh=dL7pHEn9S4eWhuWfF+clYoSRFyaOTZRYzPy6UJ2KAxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWfxyQvVD4Ny1ahk6Ezm0rDLhQivsQXOzgZDKiNKKTV9wnBMeroVM858ulC4Kz0O6x/XhJnOrL2Q9z1PmNFlfDYMXtuNAZ2vWEcqjkFW6AgTousgJVxRBfOFDPQMGVy+3mpCPZ4hUQFbPvdsOShzPNJwC+dMys+MqhPhOQ8ylG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5tlOOg/; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f44b5b9de6so1579175ad.3;
        Wed, 29 May 2024 13:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717015932; x=1717620732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u+Ax6de+UJXyMIvZDgx1oZsHAvf+AzdXxEDtwiE02g=;
        b=l5tlOOg/m3nAkKeN247amDbXbL0rV8P0vxNUTsjKHWi7YQPQUb3TXQ0zXXBUK6aqk9
         WDqiplnmBfhZ36vqBrF/f8AICakkS5aQqRBjzAcjK1k9agXcZbqXO5zTR9xztb3pidcs
         /lGw4uX57h3GFnCleJ+N2CXQryXlsev4Ke8VCoO7DH1Qtv7CP66+C62OBYdYIj5E9imU
         58FS/wtiOG0ZF1TZk0SJWccYwEKEaTPVs1CLKl/pV3Mj1XAPYdJuFg7z7KxduCwrLitH
         5sK5YzrKyVOFC0tjvRVrT0H8FwxV+JghkgUV9UP7Mf/KYiNPm1GxHpYt5CEzOYFxrAFr
         e80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717015932; x=1717620732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2u+Ax6de+UJXyMIvZDgx1oZsHAvf+AzdXxEDtwiE02g=;
        b=MoFUaP2eRKDVRuoV0lnV6Jzf0KbzmjlPeb+MSA0Jt54897j+qwYxwts6L28qkjomkS
         V1wb5Ex+zriFKJwRyq7WNM7XK+MIbgpf2CHAaUPrDlVd0oJsSyDP7jvEsL+1sr4K6NPb
         55qJTJzQdRTrCc5+jzDOalxtusGwkmFCk0At+7HLuvKN7QAshaCZjIXnUe7r8J28/QZ1
         Sk56HGwNx6W+GAzpwt5lrPKE+knrT8uUbooK0ueVJykYHFVY9bnl+onczETCjesn03py
         qYN0rqfDhrCAqW+fwO8R623K8x8Q+ac9u9hDZuT4wopXdAUYrv41aOFF1KGxi+k0uoBm
         L9jg==
X-Forwarded-Encrypted: i=1; AJvYcCWdWSiwTkHvyA8QVEUr8kEymxBwHY6ytXunVE1y9EC7a+u9TwH7G8Z7dFe7ZSXATbWvkEUS3QqRarCM8CVPrwIMUW24+fdsQknUdoS0aKDKhOkxcKt9vUbFfLXJI/cfNal+BUacdG21IQ==
X-Gm-Message-State: AOJu0Yxy1Uc0ZYI3LphiyjeXcXN9QP6HBXBX6MOPEC7F0lSb81wpfpKW
	R5JaCqRKmyNmHw+YWx/+jK42FDc2YowNQAnUvVq2GMua3Te4LttL22h9ew==
X-Google-Smtp-Source: AGHT+IGGjVTbGj3Y8Gd7CtkWNrTHqQbPcYHL5kxeVf5zf9v7gBRGqtoHZkl96DUAQclCTjjhaTvNFQ==
X-Received: by 2002:a17:902:ec91:b0:1f4:8738:6510 with SMTP id d9443c01a7336-1f619830b78mr1640145ad.44.1717015931623;
        Wed, 29 May 2024 13:52:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f60f227705sm5606905ad.126.2024.05.29.13.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 13:52:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature sensors
Date: Wed, 29 May 2024 13:52:03 -0700
Message-Id: <20240529205204.81208-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529205204.81208-1-linux@roeck-us.net>
References: <20240529205204.81208-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for SPD5118 (Jedec JESD300-5B.01) compliant temperature
sensors. Such sensors are typically found on DDR5 memory modules.

Cc: René Rebe <rene@exactcode.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Tested on MAG B650 TOMAHAWK WIFI with CMH32GX5M2B6000Z30
(Corsair Venegance DDR5).

René: I included you as MODULE_AUTHOR since the patch is derived from
      your driver. Please let me know if you prefer not to be listed as
      author.

 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/spd5118.rst |  60 ++++
 drivers/hwmon/Kconfig           |  12 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/spd5118.c         | 482 ++++++++++++++++++++++++++++++++
 5 files changed, 556 insertions(+)
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
index 000000000000..67e990551a8a
--- /dev/null
+++ b/Documentation/hwmon/spd5118.rst
@@ -0,0 +1,60 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver spd5118
+=====================
+
+Supported chips:
+
+  * SPD5118 (JEDEC JESD300-5B.01) compliant temperature sensor chips
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
+This driver implements support for SPD5118 (JEDEC JESD300-5B.01) compliant
+temperature sensors, which are used on many DDR5 memory modules. Some systems
+use the sensor to prevent memory overheating by automatically throttling
+the memory controller.
+
+The driver auto-detects SPD5118 compliant chips, but can also be instantiated
+using devicetree/firmware nodes.
+
+A SPD5118 compliant chip supports a single temperature sensor. Critical minimum,
+minimum, maximum, and critical temperature can be configured. There are alarms
+for low critical, low, high, and critical thresholds.
+
+
+PEC configuration
+-----------------
+
+If the I2C/SMBus controller supports PEC, it can be enabled or disabled using
+the 'pec' sysfs attribute attached to the i2c device.
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
+======================= ===========================================
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7f384a2494c9..111d05718b89 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2182,6 +2182,18 @@ config SENSORS_INA3221
 	  This driver can also be built as a module. If so, the module
 	  will be called ina3221.
 
+config SENSORS_SPD5118
+	tristate "SPD5118 Compliant Temperature Sensors"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for SPD5118 (JEDEC JESD300-5B)
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
index e3f25475d1f0..07c593fae9a3 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -207,6 +207,7 @@ obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_SMSC47M192)+= smsc47m192.o
 obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
+obj-$(CONFIG_SENSORS_SPD51118)	+= spd5118.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
new file mode 100644
index 000000000000..440503d09d13
--- /dev/null
+++ b/drivers/hwmon/spd5118.c
@@ -0,0 +1,482 @@
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
+static int spd5118_read_enable(struct regmap *regmap, u32 attr, long *val)
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
+		return spd5118_read_enable(regmap, attr, val);
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
+static int spd5118_write_enable(struct regmap *regmap, u32 attr, long val)
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
+		return spd5118_write_enable(regmap, attr, val);
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
+
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_TEMP_CLR);
+	if (regval)
+		return -ENODEV;
+	regval = i2c_smbus_read_byte_data(client, SPD5118_REG_ERROR_CLR);
+	if (regval)
+		return -ENODEV;
+
+	if (!(regval & SPD5118_CAP_TS_SUPPORT) || (regval & 0xfc))
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


