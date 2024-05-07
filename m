Return-Path: <linux-kernel+bounces-171823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A348BE928
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06281F2395D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F51416E865;
	Tue,  7 May 2024 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fdx6JLA1"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C716DEAE;
	Tue,  7 May 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099373; cv=none; b=oDjaL1InRKYyZEcjVvVqbRnsV3X7ZOKVzSm0GlnTE50f7zcKJyC1h5zxQfnh6sDWDlVzoQdSl6hSrd6npXTVTrV52aAuzFV6gbtdv63wcnXzmtUIAHu2X1hyH44MEWYgdXNwTrhZSWXN4v8tqZcI14fJRZX0zBFhXaM6vLbvsCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099373; c=relaxed/simple;
	bh=HCMyhrEyLFujXuxhyn2vJharsJdwklcQIpTdK3j/XmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SwYCHEF/gfFdDj8ji/MnLhdfk3qAtTXailRRJuXDrS2AWxicQlqqJfRZ4AVZoGlgCYM4ZR2m3hAX8UN4hKuBnu7rSYjcOVxIgc50WoyGqx4g2e+8ONKNaxqE/DJwIM36C1ltKRyCPzCrWU8Ze0Sp4gaa/ntpg06CdnhZicKX+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fdx6JLA1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1715099369;
	bh=HCMyhrEyLFujXuxhyn2vJharsJdwklcQIpTdK3j/XmQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fdx6JLA1LNHGHRhnS4My6GHROht4NnuPIBI/4u6RiGw11oMkQ1S9Q554j91fZiEyb
	 5mZT5jgEnuVCKqSeftBzQBcB+J6TEXJ2V/gBxdRwdAZtQwssxlKX4y0Y2MiY7CB6ln
	 A1QzPSAQvkx3G7mnQgHN9gOeGQS32mD8Oq3wxgh8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 07 May 2024 18:29:22 +0200
Subject: [PATCH v2 1/2] hwmon: add ChromeOS EC driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240507-cros_ec-hwmon-v2-1-1222c5fca0f7@weissschuh.net>
References: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
In-Reply-To: <20240507-cros_ec-hwmon-v2-0-1222c5fca0f7@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715099369; l=11569;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HCMyhrEyLFujXuxhyn2vJharsJdwklcQIpTdK3j/XmQ=;
 b=flz4ZSF7TKiDf707160wY0IS+qJPDd/H0FWMZYS+kvx54et8LJ+tLwvi3PDWrf9ZMrk9MG22f
 iCOgQmHOmInAPr3FPK/MO7GVIywTXjF4JmfZlAw4TM+SVTf88NRqI8T
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ChromeOS Embedded Controller exposes fan speed and temperature
readings.
Expose this data through the hwmon subsystem.

The driver is designed to be probed via the cros_ec mfd device.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |  26 ++++
 Documentation/hwmon/index.rst         |   1 +
 MAINTAINERS                           |   8 +
 drivers/hwmon/Kconfig                 |  11 ++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/cros_ec_hwmon.c         | 269 ++++++++++++++++++++++++++++++++++
 6 files changed, 316 insertions(+)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
new file mode 100644
index 000000000000..aeb88c79d11b
--- /dev/null
+++ b/Documentation/hwmon/cros_ec_hwmon.rst
@@ -0,0 +1,26 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Kernel driver cros_ec_hwmon
+===========================
+
+Supported chips:
+
+  * ChromeOS embedded controllers connected via LPC
+
+    Prefix: 'cros_ec'
+
+    Addresses scanned: -
+
+Author:
+
+  - Thomas Weißschuh <linux@weissschuh.net>
+
+Description
+-----------
+
+This driver implements support for hardware monitoring commands exposed by the
+ChromeOS embedded controller used in Chromebooks and other devices.
+
+The channel labels exposed via hwmon are retrieved from the EC itself.
+
+Fan and temperature readings are supported.
diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index 1ca7a4fe1f8f..355a83e66928 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -57,6 +57,7 @@ Hardware Monitoring Kernel Drivers
    coretemp
    corsair-cpro
    corsair-psu
+   cros_ec_hwmon
    da9052
    da9055
    dell-smm-hwmon
diff --git a/MAINTAINERS b/MAINTAINERS
index c23fda1aa1f0..aa5689169eca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4988,6 +4988,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
+CHROMEOS EC HARDWARE MONITORING
+M:	Thomas Weißschuh <thomas@weissschuh.net>
+L:	chrome-platform@lists.linux.dev
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/hwmon/chros_ec_hwmon.rst
+F:	drivers/hwmon/cros_ec_hwmon.c
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 83945397b6eb..c1284d42697f 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -506,6 +506,17 @@ config SENSORS_CORSAIR_PSU
 	  This driver can also be built as a module. If so, the module
 	  will be called corsair-psu.
 
+config SENSORS_CROS_EC
+	tristate "ChromeOS Embedded Controller sensors"
+	depends on MFD_CROS_EC_DEV
+	default MFD_CROS_EC_DEV
+	help
+	  If you say yes here you get support for ChromeOS Embedded Controller
+	  sensors.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called cros_ec_hwmon.
+
 config SENSORS_DRIVETEMP
 	tristate "Hard disk drives with temperature sensors"
 	depends on SCSI && ATA
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 5c31808f6378..8519a6b36c00 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
 obj-$(CONFIG_SENSORS_CORSAIR_PSU) += corsair-psu.o
+obj-$(CONFIG_SENSORS_CROS_EC)	+= cros_ec_hwmon.o
 obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
 obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
 obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
diff --git a/drivers/hwmon/cros_ec_hwmon.c b/drivers/hwmon/cros_ec_hwmon.c
new file mode 100644
index 000000000000..d59d39df2ac4
--- /dev/null
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -0,0 +1,269 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  ChromesOS EC driver for hwmon
+ *
+ *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/units.h>
+
+#define DRV_NAME	"cros-ec-hwmon"
+
+struct cros_ec_hwmon_priv {
+	struct cros_ec_device *cros_ec;
+	u8 thermal_version;
+	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
+};
+
+static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
+{
+	u16 data;
+	int ret;
+
+	ret = cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
+	if (ret < 0)
+		return ret;
+
+	data = le16_to_cpu(data);
+
+	if (data == EC_FAN_SPEED_NOT_PRESENT)
+		return -ENODEV;
+
+	*speed = data;
+	return 0;
+}
+
+static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 thermal_version,
+				   u8 index, u8 *data)
+{
+	unsigned int offset;
+	int ret;
+
+	if (index < EC_TEMP_SENSOR_ENTRIES)
+		offset = EC_MEMMAP_TEMP_SENSOR + index;
+	else
+		offset = EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENSOR_ENTRIES;
+
+	ret = cros_ec->cmd_readmem(cros_ec, offset, 1, data);
+	if (ret < 0)
+		return ret;
+
+	if (*data == EC_TEMP_SENSOR_NOT_PRESENT ||
+	    *data == EC_TEMP_SENSOR_ERROR ||
+	    *data == EC_TEMP_SENSOR_NOT_POWERED ||
+	    *data == EC_TEMP_SENSOR_NOT_CALIBRATED)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+	int ret = -ENODATA;
+	u16 speed;
+	u8 temp;
+
+	if (type == hwmon_fan) {
+		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
+		if (ret == 0)
+			*val = speed;
+	} else if (type == hwmon_temp) {
+		ret = cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_version, channel, &temp);
+		if (ret == 0)
+			*val = kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
+	}
+
+	return ret;
+}
+
+static int cros_ec_hwmon_get_temp_sensor_info(struct cros_ec_device *cros_ec, u8 id,
+					      struct ec_response_temp_sensor_get_info *resp)
+{
+	int ret;
+	struct {
+		struct cros_ec_command msg;
+		union {
+			struct ec_params_temp_sensor_get_info req;
+			struct ec_response_temp_sensor_get_info resp;
+		} __packed data;
+	} __packed buf = {
+		.msg = {
+			.version = 0,
+			.command = EC_CMD_TEMP_SENSOR_GET_INFO,
+			.insize  = sizeof(buf.data.resp),
+			.outsize = sizeof(buf.data.req),
+		},
+		.data.req.id = id,
+	};
+
+	ret = cros_ec_cmd_xfer_status(cros_ec, &buf.msg);
+	if (ret < 0)
+		return ret;
+
+	*resp = buf.data.resp;
+	return 0;
+}
+
+static int cros_ec_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+				     u32 attr, int channel, const char **str)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+
+	if (type == hwmon_temp && attr == hwmon_temp_label) {
+		*str = priv->temp_sensor_names[channel];
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	const struct cros_ec_hwmon_priv *priv = data;
+	u16 speed;
+
+	if (type == hwmon_fan) {
+		if (cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed) == 0)
+			return 0444;
+	} else if (type == hwmon_temp) {
+		if (priv->temp_sensor_names[channel])
+			return 0444;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_channel_info * const cros_ec_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops cros_ec_hwmon_ops = {
+	.read = cros_ec_hwmon_read,
+	.read_string = cros_ec_hwmon_read_string,
+	.is_visible = cros_ec_hwmon_is_visible,
+};
+
+static const struct hwmon_chip_info cros_ec_hwmon_chip_info = {
+	.ops = &cros_ec_hwmon_ops,
+	.info = cros_ec_hwmon_info,
+};
+
+static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_hwmon_priv *priv)
+{
+	struct ec_response_temp_sensor_get_info info;
+	size_t candidates, i;
+	int ret;
+	u8 temp;
+
+	if (priv->thermal_version < 2)
+		candidates = EC_TEMP_SENSOR_ENTRIES;
+	else
+		candidates = ARRAY_SIZE(priv->temp_sensor_names);
+
+	for (i = 0; i < candidates; i++) {
+		if (cros_ec_hwmon_read_temp(priv->cros_ec, priv->thermal_version, i, &temp) != 0)
+			continue;
+
+		ret = cros_ec_hwmon_get_temp_sensor_info(priv->cros_ec, i, &info);
+		if (ret < 0)
+			continue;
+
+		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%*s",
+							    (int)sizeof(info.sensor_name),
+							    info.sensor_name);
+	}
+}
+
+static int cros_ec_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
+	struct cros_ec_device *cros_ec = ec_dev->ec_dev;
+	struct cros_ec_hwmon_priv *priv;
+	struct device *hwmon_dev;
+	int ret;
+
+	/* Not every platform supports direct reads */
+	if (!cros_ec->cmd_readmem)
+		return -ENODEV;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->cros_ec = cros_ec;
+
+	ret = priv->cros_ec->cmd_readmem(cros_ec, EC_MEMMAP_THERMAL_VERSION,
+					 1, &priv->thermal_version);
+	if (ret < 0)
+		return ret;
+
+	/* Covers both fan and temp sensors */
+	if (!priv->thermal_version)
+		return -ENODEV;
+
+	cros_ec_hwmon_probe_temp_sensors(dev, priv);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
+							 &cros_ec_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct platform_device_id cros_ec_hwmon_id[] = {
+	{ DRV_NAME, 0 },
+	{ }
+};
+
+static struct platform_driver cros_ec_hwmon_driver = {
+	.driver.name	= DRV_NAME,
+	.probe		= cros_ec_hwmon_probe,
+	.id_table	= cros_ec_hwmon_id,
+};
+module_platform_driver(cros_ec_hwmon_driver);
+
+MODULE_DEVICE_TABLE(platform, cros_ec_hwmon_id);
+MODULE_DESCRIPTION("ChromeOS EC Hardware Monitoring Driver");
+MODULE_AUTHOR("Thomas Weißschuh <linux@weissschuh.net");
+MODULE_LICENSE("GPL");

-- 
2.45.0


