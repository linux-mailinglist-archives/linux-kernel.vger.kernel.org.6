Return-Path: <linux-kernel+bounces-410928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C86429CF224
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2796FB3E5B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90F1F666A;
	Fri, 15 Nov 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pMBmuf5e"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3D1D5CC5;
	Fri, 15 Nov 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685158; cv=none; b=hRlJgJOR7AisGfQ5aKXHD/i2HCoUVZS4cXfe0/09bfztihEtLqFkkEdV1g8ZnW/pQnGH5LQJ6N+fvC1AfBdk+pETAZk2hbSBig+4XrDGNxRbxQe+v/G/OsRb/8FwcsapiARfNpA7q0UgvOClFzHoLQrk3lLMDFLFvlp4pNJ8aEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685158; c=relaxed/simple;
	bh=vDfaNcIdkFFzf3iPJWSRvH6cXWCVn5Jm2j7uyRslLMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b+UqEIn2J76RPG92F6ZVQHPlISpe/90k6cbjGn3oXif0lWhsuXkXUevAMvQk4hHxEsm6EE7zuBxCqQ8MXTWU/h3fWwcU5maQ++44NhD9pKT4eEUd7mXxbsjjw5QOKUz8D96TQ7DCbAPQY+imVKx1XqsrIU2P+YEbok/hl8iFHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pMBmuf5e; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7928E60005;
	Fri, 15 Nov 2024 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731685153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXUBApD4nhMXWCjH+wwbz4rldN2jq/9nUqpCE4NFUek=;
	b=pMBmuf5eXojtHonuHcBMhwRz6pn1V1SJbp/06TerErWiAUdQzt97zAjxiXSz2HUkEp3gpc
	pHKw7Ef/T/pNMMnRyeSmNWzs8lxd9Pm8LFD0+eJf9cVsvrKx/EKeta8OQEjmwduc/0+LY2
	zAs7+dqiEDlL4HaYp0CfrQgOby47UI+UFZmzh4e/p1Li0SXm6V5dOP9UkfQcdst7+8y6pX
	COvqlazKrxf6HWpPJp9Smp7b6fjlAGlJIq7Io4sEz/eCfVDpNnR4zxkCVAj+GM0ocf8rIu
	6YM+j+u1YY27L38Dt7wYEfJTpy4qV3WAV36shWGCjfKmsUhLMutDd/pfooKSiQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Fri, 15 Nov 2024 16:39:08 +0100
Subject: [PATCH v3 1/2] hwmon: Add Congatec Board Controller monitoring
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-congatec-board-controller-hwmon-v3-1-1c45637c8266@bootlin.com>
References: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
In-Reply-To: <20241115-congatec-board-controller-hwmon-v3-0-1c45637c8266@bootlin.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, blake.vermeer@keysight.com, 
 Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.1
X-GND-Sasl: thomas.richard@bootlin.com

Add support for the Congatec Board Controller. This controller exposes
temperature, voltage, current and fan sensors.

The available sensors list cannot be predicted. Some sensors can be
present or not, depending the system.
The driver has an internal list of all possible sensors, for all Congatec
boards. The Board Controller gives to the driver its sensors list, and
their status (active or not).

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 MAINTAINERS                |   1 +
 drivers/hwmon/Kconfig      |   9 ++
 drivers/hwmon/Makefile     |   1 +
 drivers/hwmon/cgbc-hwmon.c | 304 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3507df3381b1..5e96646593b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5784,6 +5784,7 @@ CONGATEC BOARD CONTROLLER MFD DRIVER
 M:	Thomas Richard <thomas.richard@bootlin.com>
 S:	Maintained
 F:	drivers/gpio/gpio-cgbc.c
+F:	drivers/hwmon/cgbc-hwmon.c
 F:	drivers/i2c/busses/i2c-cgbc.c
 F:	drivers/mfd/cgbc-core.c
 F:	drivers/watchdog/cgbc_wdt.c
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index cfb4e9314c62..c7b6e93aeb9b 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -463,6 +463,15 @@ config SENSORS_BT1_PVT_ALARMS
 	  the data conversion will be periodically performed and the data will be
 	  saved in the internal driver cache.
 
+config SENSORS_CGBC
+	tristate "Congatec Board Controller Sensors"
+	depends on MFD_CGBC
+	help
+	  Enables sensors support for the Congatec Board Controller.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called cgbc-hwmon.
+
 config SENSORS_CHIPCAP2
 	tristate "Amphenol ChipCap 2 relative humidity and temperature sensor"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b827b92f2a78..318da6d8f752 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_SENSORS_ASUS_ROG_RYUJIN)	+= asus_rog_ryujin.o
 obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
 obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
 obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
+obj-$(CONFIG_SENSORS_CGBC)	+= cgbc-hwmon.o
 obj-$(CONFIG_SENSORS_CHIPCAP2) += chipcap2.o
 obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
 obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
diff --git a/drivers/hwmon/cgbc-hwmon.c b/drivers/hwmon/cgbc-hwmon.c
new file mode 100644
index 000000000000..772f44d56ccf
--- /dev/null
+++ b/drivers/hwmon/cgbc-hwmon.c
@@ -0,0 +1,304 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * cgbc-hwmon - Congatec Board Controller hardware monitoring driver
+ *
+ * Copyright (C) 2024 Thomas Richard <thomas.richard@bootlin.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/mfd/cgbc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define CGBC_HWMON_CMD_SENSOR		0x77
+#define CGBC_HWMON_CMD_SENSOR_DATA_SIZE	0x05
+
+#define CGBC_HWMON_TYPE_MASK	GENMASK(6, 5)
+#define CGBC_HWMON_ID_MASK	GENMASK(4, 0)
+#define CGBC_HWMON_ACTIVE_BIT	BIT(7)
+
+struct cgbc_hwmon_sensor {
+	enum hwmon_sensor_types type;
+	bool active;
+	unsigned int index;
+	unsigned int channel;
+	const char *label;
+};
+
+struct cgbc_hwmon_data {
+	struct cgbc_device_data *cgbc;
+	unsigned int nb_sensors;
+	struct cgbc_hwmon_sensor *sensors;
+};
+
+enum cgbc_sensor_types {
+	CGBC_HWMON_TYPE_TEMP = 1,
+	CGBC_HWMON_TYPE_IN,
+	CGBC_HWMON_TYPE_FAN
+};
+
+static const char * const cgbc_hwmon_labels_temp[] = {
+	"CPU Temperature",
+	"Box Temperature",
+	"Ambient Temperature",
+	"Board Temperature",
+	"Carrier Temperature",
+	"Chipset Temperature",
+	"Video Temperature",
+	"Other Temperature",
+	"TOPDIM Temperature",
+	"BOTTOMDIM Temperature",
+};
+
+static const struct {
+	enum hwmon_sensor_types type;
+	const char *label;
+} cgbc_hwmon_labels_in[] = {
+	{ hwmon_in, "CPU Voltage" },
+	{ hwmon_in, "DC Runtime Voltage" },
+	{ hwmon_in, "DC Standby Voltage" },
+	{ hwmon_in, "CMOS Battery Voltage" },
+	{ hwmon_in, "Battery Voltage" },
+	{ hwmon_in, "AC Voltage" },
+	{ hwmon_in, "Other Voltage" },
+	{ hwmon_in, "5V Voltage" },
+	{ hwmon_in, "5V Standby Voltage" },
+	{ hwmon_in, "3V3 Voltage" },
+	{ hwmon_in, "3V3 Standby Voltage" },
+	{ hwmon_in, "VCore A Voltage" },
+	{ hwmon_in, "VCore B Voltage" },
+	{ hwmon_in, "12V Voltage" },
+	{ hwmon_curr, "DC Current" },
+	{ hwmon_curr, "5V Current" },
+	{ hwmon_curr, "12V Current" },
+};
+
+#define CGBC_HWMON_NB_IN_SENSORS	14
+
+static const char * const cgbc_hwmon_labels_fan[] = {
+	"CPU Fan",
+	"Box Fan",
+	"Ambient Fan",
+	"Chipset Fan",
+	"Video Fan",
+	"Other Fan",
+};
+
+static int cgbc_hwmon_cmd(struct cgbc_device_data *cgbc, u8 index, u8 *data)
+{
+	u8 cmd[2] = {CGBC_HWMON_CMD_SENSOR, index};
+
+	return cgbc_command(cgbc, cmd, sizeof(cmd), data, CGBC_HWMON_CMD_SENSOR_DATA_SIZE, NULL);
+}
+
+static int cgbc_hwmon_probe_sensors(struct device *dev, struct cgbc_hwmon_data *hwmon)
+{
+	struct cgbc_device_data *cgbc = hwmon->cgbc;
+	struct cgbc_hwmon_sensor *sensor = hwmon->sensors;
+	u8 data[CGBC_HWMON_CMD_SENSOR_DATA_SIZE], nb_sensors, i;
+	int ret;
+
+	ret = cgbc_hwmon_cmd(cgbc, 0, &data[0]);
+	if (ret)
+		return ret;
+
+	nb_sensors = data[0];
+
+	hwmon->sensors = devm_kzalloc(dev, sizeof(*hwmon->sensors) * nb_sensors, GFP_KERNEL);
+	sensor = hwmon->sensors;
+
+	for (i = 0; i < nb_sensors; i++) {
+		enum cgbc_sensor_types type;
+		unsigned int channel;
+
+		/*
+		 * No need to request data for the first sensor.
+		 * We got data for the first sensor when we ask the number of sensors to the Board
+		 * Controller.
+		 */
+		if (i) {
+			ret = cgbc_hwmon_cmd(cgbc, i, &data[0]);
+			if (ret)
+				return ret;
+		}
+
+		type = FIELD_GET(CGBC_HWMON_TYPE_MASK, data[1]);
+		channel = FIELD_GET(CGBC_HWMON_ID_MASK, data[1]) - 1;
+
+		if (type == CGBC_HWMON_TYPE_TEMP && channel < ARRAY_SIZE(cgbc_hwmon_labels_temp)) {
+			sensor->type = hwmon_temp;
+			sensor->label = cgbc_hwmon_labels_temp[channel];
+		} else if (type == CGBC_HWMON_TYPE_IN &&
+			   channel < ARRAY_SIZE(cgbc_hwmon_labels_in)) {
+			/*
+			 * The Board Controller doesn't differentiate current and voltage sensors.
+			 * Get the sensor type from cgbc_hwmon_labels_in[channel].type instead.
+			 */
+			sensor->type = cgbc_hwmon_labels_in[channel].type;
+			sensor->label = cgbc_hwmon_labels_in[channel].label;
+		} else if (type == CGBC_HWMON_TYPE_FAN &&
+			   channel < ARRAY_SIZE(cgbc_hwmon_labels_fan)) {
+			sensor->type = hwmon_fan;
+			sensor->label = cgbc_hwmon_labels_fan[channel];
+		} else {
+			dev_warn(dev, "Board Controller returned an unknown sensor (type=%d, channel=%d), ignore it",
+				 type, channel);
+			continue;
+		}
+
+		sensor->active = FIELD_GET(CGBC_HWMON_ACTIVE_BIT, data[1]);
+		sensor->channel = channel;
+		sensor->index = i;
+		sensor++;
+		hwmon->nb_sensors++;
+	}
+
+	return 0;
+}
+
+static struct cgbc_hwmon_sensor *cgbc_hwmon_find_sensor(struct cgbc_hwmon_data *hwmon,
+							enum hwmon_sensor_types type, int channel)
+{
+	struct cgbc_hwmon_sensor *sensor = NULL;
+	int i;
+
+	/*
+	 * The Board Controller doesn't differentiate current and voltage sensors.
+	 * The channel value (from the Board Controller point of view) shall be computed for current
+	 * sensors.
+	 */
+	if (type == hwmon_curr)
+		channel += CGBC_HWMON_NB_IN_SENSORS;
+
+	for (i = 0; i < hwmon->nb_sensors; i++) {
+		if (hwmon->sensors[i].type == type && hwmon->sensors[i].channel == channel) {
+			sensor = &hwmon->sensors[i];
+			break;
+		}
+	}
+
+	return sensor;
+}
+
+static int cgbc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
+			   long *val)
+{
+	struct cgbc_hwmon_data *hwmon = dev_get_drvdata(dev);
+	struct cgbc_hwmon_sensor *sensor = cgbc_hwmon_find_sensor(hwmon, type, channel);
+	struct cgbc_device_data *cgbc = hwmon->cgbc;
+	u8 data[CGBC_HWMON_CMD_SENSOR_DATA_SIZE];
+	int ret;
+
+	ret = cgbc_hwmon_cmd(cgbc, sensor->index, &data[0]);
+	if (ret)
+		return ret;
+
+	*val = (data[3] << 8) | data[2];
+
+	/*
+	 * For the Board Controller 1lsb = 0.1 degree centigrade.
+	 * Other units are as expected.
+	 */
+	if (sensor->type == hwmon_temp)
+		*val *= 100;
+
+	return 0;
+}
+
+static umode_t cgbc_hwmon_is_visible(const void *_data, enum hwmon_sensor_types type, u32 attr,
+				     int channel)
+{
+	struct cgbc_hwmon_data *data = (struct cgbc_hwmon_data *)_data;
+	struct cgbc_hwmon_sensor *sensor;
+
+	sensor = cgbc_hwmon_find_sensor(data, type, channel);
+	if (!sensor)
+		return 0;
+
+	return sensor->active ? 0444 : 0;
+}
+
+static int cgbc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
+				  int channel, const char **str)
+{
+	struct cgbc_hwmon_data *hwmon = dev_get_drvdata(dev);
+	struct cgbc_hwmon_sensor *sensor = cgbc_hwmon_find_sensor(hwmon, type, channel);
+
+	*str = sensor->label;
+
+	return 0;
+}
+
+static const struct hwmon_channel_info * const cgbc_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL,
+			   HWMON_T_INPUT | HWMON_T_LABEL, HWMON_T_INPUT | HWMON_T_LABEL),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL,
+			   HWMON_I_INPUT | HWMON_I_LABEL, HWMON_I_INPUT | HWMON_I_LABEL),
+	HWMON_CHANNEL_INFO(curr,
+			   HWMON_C_INPUT | HWMON_C_LABEL, HWMON_C_INPUT | HWMON_C_LABEL,
+			   HWMON_C_INPUT | HWMON_C_LABEL),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL,
+			   HWMON_F_INPUT | HWMON_F_LABEL, HWMON_F_INPUT | HWMON_F_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops cgbc_hwmon_ops = {
+	.is_visible = cgbc_hwmon_is_visible,
+	.read = cgbc_hwmon_read,
+	.read_string = cgbc_hwmon_read_string,
+};
+
+static const struct hwmon_chip_info cgbc_chip_info = {
+	.ops = &cgbc_hwmon_ops,
+	.info = cgbc_hwmon_info,
+};
+
+static int cgbc_hwmon_probe(struct platform_device *pdev)
+{
+	struct cgbc_device_data *cgbc = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct cgbc_hwmon_data *data;
+	struct device *hwmon_dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->cgbc = cgbc;
+
+	ret = cgbc_hwmon_probe_sensors(dev, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to probe sensors");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "cgbc_hwmon", data, &cgbc_chip_info,
+							 NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static struct platform_driver cgbc_hwmon_driver = {
+	.driver = {
+		.name = "cgbc-hwmon",
+	},
+	.probe = cgbc_hwmon_probe,
+};
+
+module_platform_driver(cgbc_hwmon_driver);
+
+MODULE_AUTHOR("Thomas Richard <thomas.richard@bootlin.com>");
+MODULE_DESCRIPTION("Congatec Board Controller Hardware Monitoring Driver");
+MODULE_LICENSE("GPL");

-- 
2.39.5


