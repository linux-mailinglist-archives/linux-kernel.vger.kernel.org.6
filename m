Return-Path: <linux-kernel+bounces-191408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CBB8D0ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 22:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487491C20A7A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C0D1649D9;
	Mon, 27 May 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YH5vlTIM"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225653389;
	Mon, 27 May 2024 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716843533; cv=none; b=dVf6ebrxveG0Xs2lIAUUDd8yUwOHy0Fc8wpK/RxyyxfbDHhf8DFDkNeO8mMDm9JOZN0jupHxeiPy/hLc/gSPSLUz4wI5MJkkAzc9yKXSncu99QEz/Mq1JfoOAXqIfVHS3KEMVM+C7fzkCT5Jg5cb2n5AkULbOVLMhWgOEZknvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716843533; c=relaxed/simple;
	bh=xCpt36meGCfFbDkNSp5HAAoLOxkIh6XbG3vXvxF/Fi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FsvxmDy+ww0S9z9mZqaOjiuMk/LKrA/9tQpeLgWyVuKxc6ASX759PpX3uCxmb+eDsGWjcO5ABgr4cgd56xjJ/2JJ8ev/7DNoL8yKlk93WQ5bnZhtu2jqTSlpDWhP/dGN75hkjYps18Xm+o2doc53LB22xU7QObxv7yS18hxZYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YH5vlTIM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1716843529;
	bh=xCpt36meGCfFbDkNSp5HAAoLOxkIh6XbG3vXvxF/Fi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YH5vlTIMHexcNHCP4WbgIm2M+PB3VyBybJAIdea2t4Aq/ePOoMbV9YI60D59ee8st
	 S61aI78zEENHadXWD2lTE1e9sqxcJF3nTokVWVUX85cOXcktAi2Q+Qflh/xhY7aAQM
	 FKne4Zbj+BNBWZjsEGwhepYe0RpPDWYreTuh/VB4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 27 May 2024 22:58:32 +0200
Subject: [PATCH v3 2/3] hwmon: add ChromeOS EC driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240527-cros_ec-hwmon-v3-2-e5cd5ab5ba37@weissschuh.net>
References: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
In-Reply-To: <20240527-cros_ec-hwmon-v3-0-e5cd5ab5ba37@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716843528; l=12930;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=xCpt36meGCfFbDkNSp5HAAoLOxkIh6XbG3vXvxF/Fi0=;
 b=LhbSOaV8X4kTkG9NgoPy8QsjvcRB7B26CfacSq75iPZ45AM/NtYsDBbTCzFVawotaJUtX5u8Y
 0s0Ani113KkD2sOGCSsadmUh96pKRsTtczd1A3TwqOhMUjDq7F87YZ8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ChromeOS Embedded Controller exposes fan speed and temperature
readings.
Expose this data through the hwmon subsystem.

The driver is designed to be probed via the cros_ec mfd device.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/hwmon/cros_ec_hwmon.rst |  26 +++
 Documentation/hwmon/index.rst         |   1 +
 MAINTAINERS                           |   8 +
 drivers/hwmon/Kconfig                 |  11 ++
 drivers/hwmon/Makefile                |   1 +
 drivers/hwmon/cros_ec_hwmon.c         | 291 ++++++++++++++++++++++++++++++++++
 6 files changed, 338 insertions(+)

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
index 000000000000..2d9c1f4ec09a
--- /dev/null
+++ b/drivers/hwmon/cros_ec_hwmon.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  ChromesOS EC driver for hwmon
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
+	u16 data;
+	int ret;
+
+	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_FAN + index * 2, 2, &data);
+	if (ret < 0)
+		return ret;
+
+	data = le16_to_cpu(data);
+	*speed = data;
+
+	if (data == EC_FAN_SPEED_NOT_PRESENT || data == EC_FAN_SPEED_STALLED)
+		return -EIO;
+	return 0;
+}
+
+static int cros_ec_hwmon_read_temp(struct cros_ec_device *cros_ec, u8 index, u8 *data)
+{
+	unsigned int offset;
+	int ret;
+
+	if (index < EC_TEMP_SENSOR_ENTRIES)
+		offset = EC_MEMMAP_TEMP_SENSOR + index;
+	else
+		offset = EC_MEMMAP_TEMP_SENSOR_B + index - EC_TEMP_SENSOR_ENTRIES;
+
+	ret = cros_ec_cmd_readmem(cros_ec, offset, 1, data);
+	if (ret < 0)
+		return ret;
+
+	if (*data == EC_TEMP_SENSOR_NOT_PRESENT ||
+	    *data == EC_TEMP_SENSOR_ERROR ||
+	    *data == EC_TEMP_SENSOR_NOT_POWERED ||
+	    *data == EC_TEMP_SENSOR_NOT_CALIBRATED)
+		return -EIO;
+
+	return 0;
+}
+
+static int cros_ec_hwmon_read_temp_sensor_info(struct cros_ec_device *cros_ec, u8 id,
+					       struct ec_response_temp_sensor_get_info *resp)
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
+static int cros_ec_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+	struct cros_ec_hwmon_priv *priv = dev_get_drvdata(dev);
+	int ret = -ENODATA;
+	u16 speed = 0;
+	u8 temp = 0;
+
+	if (type == hwmon_fan && attr == hwmon_fan_input) {
+		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
+		if (ret == 0)
+			*val = speed;
+	} else if (type == hwmon_fan && attr == hwmon_fan_fault) {
+		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, channel, &speed);
+		if (ret == -EIO && speed == EC_FAN_SPEED_STALLED)
+			ret = 0;
+		if (ret == 0)
+			*val = speed == EC_FAN_SPEED_STALLED;
+	} else if (type == hwmon_temp && attr == hwmon_temp_input) {
+		ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
+		if (ret == 0)
+			*val = kelvin_to_millicelsius((((long)temp) + EC_TEMP_SENSOR_OFFSET));
+	} else if (type == hwmon_temp && attr == hwmon_temp_fault) {
+		ret = cros_ec_hwmon_read_temp(priv->cros_ec, channel, &temp);
+		if (ret == -EIO && speed == EC_TEMP_SENSOR_ERROR)
+			ret = 0;
+		if (ret == 0)
+			*val = temp == EC_TEMP_SENSOR_ERROR;
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
+	return -ENODATA;
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
+	struct ec_response_temp_sensor_get_info info;
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
+		if (cros_ec_hwmon_read_temp(priv->cros_ec, i, &temp) != 0)
+			continue;
+
+		ret = cros_ec_hwmon_read_temp_sensor_info(priv->cros_ec, i, &info);
+		if (ret < 0)
+			continue;
+
+		sensor_name_size = strnlen(info.sensor_name, sizeof(info.sensor_name));
+		priv->temp_sensor_names[i] = devm_kasprintf(dev, GFP_KERNEL, "%*s",
+							    (int)sensor_name_size,
+							    info.sensor_name);
+	}
+}
+
+static void cros_ec_hwmon_probe_fans(struct device *dev, struct cros_ec_hwmon_priv *priv)
+{
+	u16 speed;
+	size_t i;
+	int ret;
+
+	for (i = 0; i < EC_FAN_SPEED_ENTRIES; i++) {
+		speed = EC_FAN_SPEED_NOT_PRESENT;
+		ret = cros_ec_hwmon_read_fan_speed(priv->cros_ec, i, &speed);
+		if (ret == 0 || speed != EC_FAN_SPEED_NOT_PRESENT)
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
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = cros_ec_cmd_readmem(cros_ec, EC_MEMMAP_THERMAL_VERSION, 1, &thermal_version);
+	if (ret < 0)
+		return ret;
+
+	/* Covers both fan and temp sensors */
+	if (thermal_version == 0)
+		return -ENODEV;
+
+	priv->cros_ec = cros_ec;
+
+	cros_ec_hwmon_probe_temp_sensors(dev, priv, thermal_version);
+	cros_ec_hwmon_probe_fans(dev, priv);
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
2.45.1


