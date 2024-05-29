Return-Path: <linux-kernel+bounces-193509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8B8D2D37
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEB3B292D7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFB16191E;
	Wed, 29 May 2024 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PlLloM0F"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE315F417;
	Wed, 29 May 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716964044; cv=none; b=dGskMOGF/TK3ywZpXjI2Qw8pVC6Itpur65SbEWWa42ZSFS42k7N2BYzAcytpiyMlWE8lK+ynYb2/lnmJcIyKpSNo9RxxoQpI77lXDK2PpfqzLgcTprMc6Sk/MLW2nJhrHDDBbRS9ezW0lpW8cGQewRplq/AvcswSzo0xMwh2I6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716964044; c=relaxed/simple;
	bh=35Nmu3ktrJpC4c9LU6YISZcM/t9jt3cr7DDfkBZyoV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HuZrBckSJ+EVfGzJO9gnlgWZpAjUysQ0d16pmiMR13tGWDI57HZ+dpZD58sr6XYys7mSzbVfuwr7LeNF1ZEDbBmPZNvwR/kY69bdb9GBMn+7t4lSo+pNXe6oRqHM5aO4n1K9Dwz4fiPw5s9YToZfqTf+X/sHK+5T2Jxg8OTPPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PlLloM0F; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716964039;
	bh=35Nmu3ktrJpC4c9LU6YISZcM/t9jt3cr7DDfkBZyoV8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PlLloM0FJpfFUq+IB3etWiQmES6jB7s5x8D2SpS8tV9W5L4IKVPlkSKEB/o1mznjf
	 gz0LDaiqaAer3DRxuWBoxHmOJFQEY8TuSVyClvUbGRWCKj3RzPn80uh3OzaaCNWUgi
	 WGqLxIjXV64w4CEAW2pJYsCyaGkKbR8d6fGkKyK4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 29 May 2024 08:27:12 +0200
Subject: [PATCH v4 2/3] hwmon: add ChromeOS EC driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240529-cros_ec-hwmon-v4-2-5cdf0c5db50a@weissschuh.net>
References: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
In-Reply-To: <20240529-cros_ec-hwmon-v4-0-5cdf0c5db50a@weissschuh.net>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
 Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Dustin Howett <dustin@howett.net>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Moritz Fischer <mdf@kernel.org>, Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716964039; l=12617;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=35Nmu3ktrJpC4c9LU6YISZcM/t9jt3cr7DDfkBZyoV8=;
 b=CCVEBpRt0QiZkPuJRIM7W120A2bwTm7egruTp1pbzI0XCmz1/cSle93bA1FhBQx+VxHdM9VDN
 Bse4BuCjTJWC+C8iwBXiLZc2jcL5/534NrFIKq1icx1UCt2noK/7xvM
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
 drivers/hwmon/cros_ec_hwmon.c         | 286 ++++++++++++++++++++++++++++++++++
 6 files changed, 333 insertions(+)

diff --git a/Documentation/hwmon/cros_ec_hwmon.rst b/Documentation/hwmon/cros_ec_hwmon.rst
new file mode 100644
index 000000000000..47ecae983bdb
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
+  * ChromeOS embedded controllers.
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
index 03d313af469a..342ea5deba24 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -58,6 +58,7 @@ Hardware Monitoring Kernel Drivers
    coretemp
    corsair-cpro
    corsair-psu
+   cros_ec_hwmon
    da9052
    da9055
    dell-smm-hwmon
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..0c85aa5073e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5135,6 +5135,14 @@ S:	Maintained
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
index e14ae18a973b..702dc45ea405 100644
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
index e3f25475d1f0..4fb14dd1eafd 100644
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
index 000000000000..f503f9343364
--- /dev/null
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  ChromeOS EC driver for hwmon
+ *
+ *  Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#define DRV_NAME	"cros-ec-hwmon"
+
+struct cros_ec_hwmon_priv {
+	struct cros_ec_device *cros_ec;
+	const char *temp_sensor_names[EC_TEMP_SENSOR_ENTRIES + EC_TEMP_SENSOR_B_ENTRIES];
+	u8 usable_fans;
+};
+
+static int cros_ec_hwmon_read_fan_speed(struct cros_ec_device *cros_ec, u8 index, u16 *speed)
+{
+	int ret;
+
+	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, speed);
+	if (ret < 0)
+		return ret;
+
+	*speed = le16_to_cpu(*speed);
+	return 0;
+}
+
+static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *temp)
+{
+	unsigned int offset;
+	int ret;
+
+	if (index < EC_TEMP_SENSOR_ENTRIES)
+		offset = EC_MEMMAP_TEMP_SENSOR + index;
+	else
+		offset = EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENSOR_ENTRIES;
+
+	ret = cros_ec_cmd_readmem(cros_ec, offset, 1, temp);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static bool cros_ec_hwmon_is_error_fan(u16 speed)
+{
+	return speed == EC_FAN_SPEED_NOT_PRESENT || speed == EC_FAN_SPEED_STALLED;
+}
+
+static bool cros_ec_hwmon_is_error_temp(u8 temp)
+{
+	return temp == EC_TEMP_SENSOR_NOT_PRESENT     ||
+	       temp == EC_TEMP_SENSOR_ERROR           ||
+	       temp == EC_TEMP_SENSOR_NOT_POWERED     ||
+	       temp == EC_TEMP_SENSOR_NOT_CALIBRATED;
+}
+
+static long cros_ec_hwmon_temp_to_millicelsius(u8 temp)
+{
+	return kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
+}
+
+static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
+	u16 speed;
+	u8 temp;
+
+	if (type == hwmon_fan) {
+		if (attr == hwmon_fan_input) {
+			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
+			if (ret == 0) {
+				if (cros_ec_hwmon_is_error_fan(speed))
+					ret = -ENODATA;
+				else
+					*val = speed;
+			}
+
+		} else if (attr == hwmon_fan_fault) {
+			ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
+			if (ret == 0)
+				*val = cros_ec_hwmon_is_error_fan(speed);
+		}
+
+	} else if (type == hwmon_temp) {
+		if (attr == hwmon_temp_input) {
+			ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
+			if (ret == 0) {
+				if (cros_ec_hwmon_is_error_temp(temp))
+					ret = -ENODATA;
+				else
+					*val = cros_ec_hwmon_temp_to_millicelsius(temp);
+			}
+
+		} else if (attr == hwmon_temp_fault) {
+			ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
+			if (ret == 0)
+				*val = cros_ec_hwmon_is_error_temp(temp);
+		}
+	}
+
+	return ret;
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
+	return -EOPNOTSUPP;
+}
+
+static umode_t cros_ec_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	const struct cros_ec_hwmon_priv *priv = data;
+
+	if (type == hwmon_fan) {
+		if (priv->usable_fans & BIT(channel))
+			return 0444;
+
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
+			   HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_FAULT),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_FAULT | HWMON_T_LABEL),
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
+static void cros_ec_hwmon_probe_temp_sensors(struct device *dev, struct cros_ec_hwmon_priv *priv,
+					     u8 thermal_version)
+{
+	struct ec_params_temp_sensor_get_info req = {};
+	struct ec_response_temp_sensor_get_info resp;
+	size_t candidates, i, sensor_name_size;
+	int ret;
+	u8 temp;
+
+	if (thermal_version < 2)
+		candidates = EC_TEMP_SENSOR_ENTRIES;
+	else
+		candidates = ARRAY_SIZE(priv->temp_sensor_names);
+
+	for (i = 0; i < candidates; i++) {
+		if (cros_ec_hwmon_read_temp(priv->cros_ec, i, &temp) < 0)
+			continue;
+
+		if (temp == EC_TEMP_SENSOR_NOT_PRESENT)
+			continue;
+
+		req.id = i;
+		ret = cros_ec_cmd(priv->cros_ec, 0, EC_CMD_TEMP_SENSOR_GET_INFO,
+				  &req, sizeof(req), &resp, sizeof(resp));
+		if (ret < 0)
+			continue;
+
+		sensor_name_size = strnlen(resp.sensor_name, sizeof(resp.sensor_name));
+		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%*s",
+							    (int)sensor_name_size,
+							    resp.sensor_name);
+	}
+}
+
+static void cros_ec_hwmon_probe_fans(struct cros_ec_hwmon_priv *priv)
+{
+	u16 speed;
+	size_t i;
+	int ret;
+
+	for (i = 0; i < EC_FAN_SPEED_ENTRIES; i++) {
+		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, i, &speed);
+		if (ret == 0 && speed != EC_FAN_SPEED_NOT_PRESENT)
+			priv->usable_fans |= BIT(i);
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
+	u8 thermal_version;
+	int ret;
+
+	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_THERMAL_VERSION, 1, &thermal_version);
+	if (ret < 0)
+		return ret;
+
+	/* Covers both fan and temp sensors */
+	if (thermal_version == 0)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->cros_ec = cros_ec;
+
+	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
+	cros_ec_hwmon_probe_fans(priv);
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cros_ec", priv,
+							 &cros_ec_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct platform_device_id cros_ec_hwmon_id[] = {
+	{ DRV_NAME, 0 },
+	{}
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
2.45.1


