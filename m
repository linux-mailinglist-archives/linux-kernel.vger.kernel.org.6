Return-Path: <linux-kernel+bounces-375627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D028B9A9860
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10B01C22A58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE413D251;
	Tue, 22 Oct 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO85s3sC"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4F913B780;
	Tue, 22 Oct 2024 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574974; cv=none; b=U+zq8SGuvr5I43ZT8at442y4x1y9jkt+BTZKa5iX96KxB4lzTlzseXpR5eL+E6ndhBK1FxG1Fl+Hn6ay7EWJF01VZj1JBsEzLtH/Fz/ZTVp5ixBTpJ9/5fR4Tamx+Bdn2xpp7yNq2sZnYsaZi+gvAqMeDg0o4CYhHjU/MhDCUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574974; c=relaxed/simple;
	bh=V6y/OPYAMbtYQEypAYOFXL9JyUDdcshIuxLLabqg6NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyAbDh/LS+MaboMl8PXxboKOiEyxd2gmP1oQhPx7eBOSOl69ykmpCKXD8na/Qt/8VK87rDNTJqo8+JqapG+2VrePLom0NPYjxrHRA4zqK/lcnY4qICeFZTe6gDhyidn3HPJSB14qcOgCuw1KNF+i8yZ6ptViLLKti24ALdoy38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PO85s3sC; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc0e13d25so741287eaf.1;
        Mon, 21 Oct 2024 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574972; x=1730179772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00HKRaDoE+KM2OuvT4dW1znoPMBG0COXUi37/7dRIsE=;
        b=PO85s3sCqIxHERXca+JYfPxC5drl7xN3oyMFevCVHpGOQFNXeVb2t0OheG4wLLzGiw
         hTX9hGgOA5V0YMluW9E41PAr5Ybu+lBgVlpegGY6CewN4jGCekQ86/2FtC7VORF4ng8i
         TAFtmIIcfaeaBllaLYHiZulU/SdWXtfpdCXzt/ZgL78cSeSJGjPBQou1qVjBrQCK0muP
         hiBd4B+TOr/NrbVjt7wAaIf1J27jeFC9vsYFRnt1MjmOAQc5PPE3dfDoJ+O+F31/jkqZ
         H+5niHytHpzL0FURN+Iu1abgdUYCLsODb/TOz8Sn+1AaIknbi4tO/9jZOQMbWLp/wkiS
         JI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574972; x=1730179772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00HKRaDoE+KM2OuvT4dW1znoPMBG0COXUi37/7dRIsE=;
        b=Z9NUsKhmqY4KN+1gIRVJt5WYZGStyzFmFgWRFeP86/wSobcUt86krbbTcJEz8smYFG
         UkeDzzJ0YNZtwctPKQO5FKxVRyHLj/oVtyLaPI5Ufj/HC/MXixzmi/gw8EPjkksmuhGu
         JkTU4uW+e4NceHRlXSNM26D/UstMh2fwUfiUdIqJWY6r2w0CdpaMdYA4tbvgFGtGgt9s
         lFiJ3UcZ2shfzqsvWRDzDAXoAzHfQ0sm+wlPvPUwRHDUaS6FlaYYB5YXAfu3v212PVa1
         kIx9CRvhtSgS34XqOf1KOFZgj0bX+OkM/wcvgFK1/Qjww4kKiuZhL6zBIRvr52p7G3B2
         phRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY4H0EOv4FKMGqGIT6Zegp8rjULVVLaTunLNN8ZNFqdfrmuozVwUoBSRzj4Gw37Mi+GchdxDtzgl+h@vger.kernel.org, AJvYcCVGWsB0v04MaKZcaTSi4snsqVI8LYPQfYY//jGNsCDhGUm2yByiAVqKIuB9AeKs+MD5dpoCkoXo8v43@vger.kernel.org, AJvYcCWMpEdqa8oHak15mHJemR2YTYBmD8G4chYLO4Hs1sOUJmCG2leqyxmAFv66Ap6sIMnXV74Pu9pWUPdGzhdg@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsc+tA5NQ0w96R5OzzzViBEPwGK6RfrIbVOcYsRhTNt7bpGvJH
	p9ceh9wPPGG84g+gP/ZjBhhBc+xyIjgsL9iC2nXD991Fz6G3MmfJ
X-Google-Smtp-Source: AGHT+IGsMISYdcO6MxsEhI0Umj3a3T4y6E39bVNkE6hGaekZp1b5rPASGyt5WZfp/00c/la21qeFqQ==
X-Received: by 2002:a05:6870:7012:b0:277:e1bc:7da7 with SMTP id 586e51a60fabf-28caff8e345mr1412502fac.22.1729574971707;
        Mon, 21 Oct 2024 22:29:31 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec141505bsm3845846b3a.219.2024.10.21.22.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 22:29:31 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com
Subject: [PATCH v6 2/2] hwmon: Add driver for I2C chip Nuvoton NCT7363Y
Date: Tue, 22 Oct 2024 13:29:05 +0800
Message-Id: <20241022052905.4062682-3-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
References: <20241022052905.4062682-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

The NCT7363Y is a fan controller which provides up to 16
independent FAN input monitors. It can report each FAN input count
values. The NCT7363Y also provides up to 16 independent PWM
outputs. Each PWM can output specific PWM signal by manual mode to
control the FAN duty outside.

Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 Documentation/hwmon/index.rst   |   1 +
 Documentation/hwmon/nct7363.rst |  35 +++
 MAINTAINERS                     |   2 +
 drivers/hwmon/Kconfig           |  11 +
 drivers/hwmon/Makefile          |   1 +
 drivers/hwmon/nct7363.c         | 447 ++++++++++++++++++++++++++++++++
 6 files changed, 497 insertions(+)
 create mode 100644 Documentation/hwmon/nct7363.rst
 create mode 100644 drivers/hwmon/nct7363.c

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index ea3b5be8fe4f..4331a6a64e9e 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -174,6 +174,7 @@ Hardware Monitoring Kernel Drivers
    mpq8785
    nct6683
    nct6775
+   nct7363
    nct7802
    nct7904
    npcm750-pwm-fan
diff --git a/Documentation/hwmon/nct7363.rst b/Documentation/hwmon/nct7363.rst
new file mode 100644
index 000000000000..623cb4f0c8ce
--- /dev/null
+++ b/Documentation/hwmon/nct7363.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver nct7363
+=====================
+
+Supported chip:
+
+  * Nuvoton NCT7363Y
+
+    Prefix: nct7363
+
+    Addresses: I2C 0x20, 0x21, 0x22, 0x23
+
+Author: Ban Feng <kcfeng0@nuvoton.com>
+
+
+Description
+-----------
+
+The NCT7363Y is a fan controller which provides up to 16 independent
+FAN input monitors, and up to 16 independent PWM outputs with SMBus interface.
+
+
+Sysfs entries
+-------------
+
+Currently, the driver supports the following features:
+
+==========  ==========================================
+fanX_input  provide current fan rotation value in RPM
+fanX_alarm  report fan low speed real status
+fanX_min    get or set fan count threshold
+
+pwmX        get or set PWM fan control value.
+==========  ==========================================
diff --git a/MAINTAINERS b/MAINTAINERS
index 86a65a7d9721..9d40ab32679c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15887,6 +15887,8 @@ M:	Ban Feng <kcfeng0@nuvoton.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+F:	Documentation/hwmon/nct7363.rst
+F:	drivers/hwmon/nct7363.c
 
 NETCONSOLE
 M:	Breno Leitao <leitao@debian.org>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08a3c863f80a..ae56a45dc7bc 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1670,6 +1670,17 @@ config SENSORS_NCT6775_I2C
 	  This driver can also be built as a module. If so, the module
 	  will be called nct6775-i2c.
 
+config SENSORS_NCT7363
+	tristate "Nuvoton NCT7363Y"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  If you say yes here you get support for the Nuvoton NCT7363Y
+	  hardware monitoring chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct7363.
+
 config SENSORS_NCT7802
 	tristate "Nuvoton NCT7802Y"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9554d2fdcf7b..dc55eace3dba 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -171,6 +171,7 @@ obj-$(CONFIG_SENSORS_NCT6775_CORE) += nct6775-core.o
 nct6775-objs			:= nct6775-platform.o
 obj-$(CONFIG_SENSORS_NCT6775)	+= nct6775.o
 obj-$(CONFIG_SENSORS_NCT6775_I2C) += nct6775-i2c.o
+obj-$(CONFIG_SENSORS_NCT7363)	+= nct7363.o
 obj-$(CONFIG_SENSORS_NCT7802)	+= nct7802.o
 obj-$(CONFIG_SENSORS_NCT7904)	+= nct7904.o
 obj-$(CONFIG_SENSORS_NPCM7XX)	+= npcm750-pwm-fan.o
diff --git a/drivers/hwmon/nct7363.c b/drivers/hwmon/nct7363.c
new file mode 100644
index 000000000000..11b50b362aff
--- /dev/null
+++ b/drivers/hwmon/nct7363.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Nuvoton Technology corporation.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/err.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define NCT7363_REG_FUNC_CFG_BASE(x)	(0x20 + (x))
+#define NCT7363_REG_LSRS(x)		(0x34 + ((x) / 8))
+#define NCT7363_REG_PWMEN_BASE(x)	(0x38 + (x))
+#define NCT7363_REG_FANINEN_BASE(x)	(0x41 + (x))
+#define NCT7363_REG_FANINX_HVAL(x)	(0x48 + ((x) * 2))
+#define NCT7363_REG_FANINX_LVAL(x)	(0x49 + ((x) * 2))
+#define NCT7363_REG_FANINX_HL(x)	(0x6C + ((x) * 2))
+#define NCT7363_REG_FANINX_LL(x)	(0x6D + ((x) * 2))
+#define NCT7363_REG_FSCPXDUTY(x)	(0x90 + ((x) * 2))
+#define NCT7363_REG_FSCPXDIV(x)		(0x91 + ((x) * 2))
+
+#define PWM_SEL(x)			(BIT(0) << ((x) * 2))
+#define FANIN_SEL(_x)			({typeof(_x) (x) = (_x); \
+					 BIT(1) << (((x) < 8) ? \
+					 (((x) + 8) * 2) : \
+					 (((x) % 8) * 2)); })
+#define ALARM_SEL(x, y)			((x) & (BIT((y) % 8)))
+#define VALUE_TO_REG(x, y)		(((x) >> ((y) * 8)) & 0xFF)
+
+#define NCT7363_FANINX_LVAL_MASK	GENMASK(4, 0)
+#define NCT7363_FANIN_MASK		GENMASK(12, 0)
+
+#define NCT7363_PWM_COUNT		16
+
+static inline unsigned int fan_from_reg(u16 val)
+{
+	if (val == NCT7363_FANIN_MASK || val == 0)
+		return 0;
+
+	return (1350000UL / val);
+}
+
+static const struct of_device_id nct7363_of_match[] = {
+	{ .compatible = "nuvoton,nct7363", },
+	{ .compatible = "nuvoton,nct7362", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, nct7363_of_match);
+
+struct nct7363_data {
+	struct regmap		*regmap;
+
+	u16			fanin_mask;
+	u16			pwm_mask;
+};
+
+static int nct7363_read_fan(struct device *dev, u32 attr, int channel,
+			    long *val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	unsigned int reg;
+	u8 regval[2];
+	int ret = 0;
+	u16 cnt;
+
+	switch (attr) {
+	case hwmon_fan_input:
+		/*
+		 * High-byte register should be read first to latch
+		 * synchronous low-byte value
+		 */
+		ret = regmap_bulk_read(data->regmap,
+				       NCT7363_REG_FANINX_HVAL(channel),
+				       &regval, 2);
+		if (ret)
+			return ret;
+
+		cnt = (regval[0] << 5) | (regval[1] & NCT7363_FANINX_LVAL_MASK);
+		*val = fan_from_reg(cnt);
+		return 0;
+	case hwmon_fan_min:
+		ret = regmap_bulk_read(data->regmap,
+				       NCT7363_REG_FANINX_HL(channel),
+				       &regval, 2);
+		if (ret)
+			return ret;
+
+		cnt = (regval[0] << 5) | (regval[1] & NCT7363_FANINX_LVAL_MASK);
+		*val = fan_from_reg(cnt);
+		return 0;
+	case hwmon_fan_alarm:
+		ret = regmap_read(data->regmap,
+				  NCT7363_REG_LSRS(channel), &reg);
+		if (ret)
+			return ret;
+
+		*val = (long)ALARM_SEL(reg, channel) > 0 ? 1 : 0;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int nct7363_write_fan(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	u8 regval[2];
+	int ret;
+
+	if (val <= 0)
+		return -EINVAL;
+
+	switch (attr) {
+	case hwmon_fan_min:
+		val = clamp_val(DIV_ROUND_CLOSEST(1350000, val),
+				1, NCT7363_FANIN_MASK);
+		regval[0] = val >> 5;
+		regval[1] = val & NCT7363_FANINX_LVAL_MASK;
+
+		ret = regmap_bulk_write(data->regmap,
+					NCT7363_REG_FANINX_HL(channel),
+					regval, 2);
+		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t nct7363_fan_is_visible(const void *_data, u32 attr, int channel)
+{
+	const struct nct7363_data *data = _data;
+
+	switch (attr) {
+	case hwmon_fan_input:
+	case hwmon_fan_alarm:
+		if (data->fanin_mask & BIT(channel))
+			return 0444;
+		break;
+	case hwmon_fan_min:
+		if (data->fanin_mask & BIT(channel))
+			return 0644;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nct7363_read_pwm(struct device *dev, u32 attr, int channel,
+			    long *val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	unsigned int regval;
+	int ret;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		ret = regmap_read(data->regmap,
+				  NCT7363_REG_FSCPXDUTY(channel), &regval);
+		if (ret)
+			return ret;
+
+		*val = (long)regval;
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int nct7363_write_pwm(struct device *dev, u32 attr, int channel,
+			     long val)
+{
+	struct nct7363_data *data = dev_get_drvdata(dev);
+	int ret;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		ret = regmap_write(data->regmap,
+				   NCT7363_REG_FSCPXDUTY(channel), val);
+
+		return ret;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t nct7363_pwm_is_visible(const void *_data, u32 attr, int channel)
+{
+	const struct nct7363_data *data = _data;
+
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (data->pwm_mask & BIT(channel))
+			return 0644;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int nct7363_read(struct device *dev, enum hwmon_sensor_types type,
+			u32 attr, int channel, long *val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return nct7363_read_fan(dev, attr, channel, val);
+	case hwmon_pwm:
+		return nct7363_read_pwm(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int nct7363_write(struct device *dev, enum hwmon_sensor_types type,
+			 u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_fan:
+		return nct7363_write_fan(dev, attr, channel, val);
+	case hwmon_pwm:
+		return nct7363_write_pwm(dev, attr, channel, val);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t nct7363_is_visible(const void *data,
+				  enum hwmon_sensor_types type,
+				  u32 attr, int channel)
+{
+	switch (type) {
+	case hwmon_fan:
+		return nct7363_fan_is_visible(data, attr, channel);
+	case hwmon_pwm:
+		return nct7363_pwm_is_visible(data, attr, channel);
+	default:
+		return 0;
+	}
+}
+
+static const struct hwmon_channel_info *nct7363_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_ALARM),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT,
+			   HWMON_PWM_INPUT),
+	NULL
+};
+
+static const struct hwmon_ops nct7363_hwmon_ops = {
+	.is_visible = nct7363_is_visible,
+	.read = nct7363_read,
+	.write = nct7363_write,
+};
+
+static const struct hwmon_chip_info nct7363_chip_info = {
+	.ops = &nct7363_hwmon_ops,
+	.info = nct7363_info,
+};
+
+static int nct7363_init_chip(struct nct7363_data *data)
+{
+	u32 func_config = 0;
+	int i, ret;
+
+	/* Pin Function Configuration */
+	for (i = 0; i < NCT7363_PWM_COUNT; i++) {
+		if (data->pwm_mask & BIT(i))
+			func_config |= PWM_SEL(i);
+		if (data->fanin_mask & BIT(i))
+			func_config |= FANIN_SEL(i);
+	}
+
+	for (i = 0; i < 4; i++) {
+		ret = regmap_write(data->regmap, NCT7363_REG_FUNC_CFG_BASE(i),
+				   VALUE_TO_REG(func_config, i));
+		if (ret < 0)
+			return ret;
+	}
+
+	/* PWM and FANIN Monitoring Enable */
+	for (i = 0; i < 2; i++) {
+		ret = regmap_write(data->regmap, NCT7363_REG_PWMEN_BASE(i),
+				   VALUE_TO_REG(data->pwm_mask, i));
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_write(data->regmap, NCT7363_REG_FANINEN_BASE(i),
+				   VALUE_TO_REG(data->fanin_mask, i));
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int nct7363_present_pwm_fanin(struct device *dev,
+				     struct device_node *child,
+				     struct nct7363_data *data)
+{
+	u8 fanin_ch[NCT7363_PWM_COUNT];
+	struct of_phandle_args args;
+	int ret, fanin_cnt;
+	u8 ch, index;
+
+	ret = of_parse_phandle_with_args(child, "pwms", "#pwm-cells",
+					 0, &args);
+	if (ret)
+		return ret;
+
+	if (args.args[0] >= NCT7363_PWM_COUNT)
+		return -EINVAL;
+	data->pwm_mask |= BIT(args.args[0]);
+
+	fanin_cnt = of_property_count_u8_elems(child, "tach-ch");
+	if (fanin_cnt < 1 || fanin_cnt > NCT7363_PWM_COUNT)
+		return -EINVAL;
+
+	ret = of_property_read_u8_array(child, "tach-ch", fanin_ch, fanin_cnt);
+	if (ret)
+		return ret;
+
+	for (ch = 0; ch < fanin_cnt; ch++) {
+		index = fanin_ch[ch];
+		if (index >= NCT7363_PWM_COUNT)
+			return -EINVAL;
+		data->fanin_mask |= BIT(index);
+	}
+
+	return 0;
+}
+
+static bool nct7363_regmap_is_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NCT7363_REG_LSRS(0) ... NCT7363_REG_LSRS(15):
+	case NCT7363_REG_FANINX_HVAL(0) ... NCT7363_REG_FANINX_LVAL(15):
+	case NCT7363_REG_FANINX_HL(0) ... NCT7363_REG_FANINX_LL(15):
+	case NCT7363_REG_FSCPXDUTY(0) ... NCT7363_REG_FSCPXDIV(15):
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config nct7363_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_read = true,
+	.use_single_write = true,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = nct7363_regmap_is_volatile,
+};
+
+static int nct7363_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device_node *child;
+	struct nct7363_data *data;
+	struct device *hwmon_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = devm_regmap_init_i2c(client, &nct7363_regmap_config);
+	if (IS_ERR(data->regmap))
+		return PTR_ERR(data->regmap);
+
+	for_each_child_of_node(dev->of_node, child) {
+		ret = nct7363_present_pwm_fanin(dev, child, data);
+		if (ret) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	/* Initialize the chip */
+	ret = nct7363_init_chip(data);
+	if (ret)
+		return ret;
+
+	hwmon_dev =
+		devm_hwmon_device_register_with_info(dev, client->name, data,
+						     &nct7363_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct i2c_driver nct7363_driver = {
+	.class = I2C_CLASS_HWMON,
+	.driver = {
+		.name = "nct7363",
+		.of_match_table = nct7363_of_match,
+	},
+	.probe = nct7363_probe,
+};
+
+module_i2c_driver(nct7363_driver);
+
+MODULE_AUTHOR("CW Ho <cwho@nuvoton.com>");
+MODULE_AUTHOR("Ban Feng <kcfeng0@nuvoton.com>");
+MODULE_DESCRIPTION("NCT7363 Hardware Monitoring Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


