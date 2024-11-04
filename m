Return-Path: <linux-kernel+bounces-395158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD009BB95F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE08B1C2196D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6691C07EC;
	Mon,  4 Nov 2024 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ve7f9sY8"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEA13D246;
	Mon,  4 Nov 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730735310; cv=none; b=FaAW4j37beF8D7taHoudLTDUXj+cd3m0J2FgpSpC/GqqRuLqe7LmvG3bZVf4WkaGPO4jCRVIpl1DgTfTGLNxuM38RGzTpGP2Jyq28kgF5Oj9JR8hGY2H0kFJ+ALDU/B3DPyd4hBnMTGDfwFvwQgWuq6/togyX1ETkX5oxI9fYbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730735310; c=relaxed/simple;
	bh=gFerD5ldOKvsFK+mw5dFheZKzWQUE9Sh2wiPh0XTxSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eg8Ym+7V3OKyudsqWmuuLbByeY8rWVg0rqKSxLFRcaRarGXseLYYkDV5hw0YrQrZnBN70wm38QLBEHKk906/Xmal1qhC+MW/b1c5rL+2QmIReR9aYW5VAQ3Nfl1I/LGIBgy7F7673MW7s9cFgFIqOAL03nXDmr03+CbC/inuqsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ve7f9sY8; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEE206000A;
	Mon,  4 Nov 2024 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730735300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sKR0gYnXlZ93kQz9P5jrXOjDSLStg/V94QAs8PFErM=;
	b=Ve7f9sY8n1/xQXgaGrrdcZtpWhmcXbTcLXJwmF/oxBnEcx5cbNxTHcrXwXuEA4TVoJYDR+
	i5RMuDrmONCwYSjVCB729RMIBLI983wBmhYOPT7GlriZV7PVdPMw9rs1GxudihJgk/GqJq
	dqw42t6A6fC5NFIerteKKkTaEK/z1f2m4JS/8JbzwiJPKRHw23m8I9MAOP73YQ4kR7zHK8
	X1FoYbhCLLzNXFSMtbcXBgm4tEkjjMZVUOpWbDEHQ3vFKaA1HPkzho3S0aD9JcpQmNZjl3
	htSLCgdoqiPEnnbvGWGRYF3m9Udpn5oiF3sFibr71bjGlyzw6rzyl4HLRSjXTA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 04 Nov 2024 16:48:07 +0100
Subject: [PATCH 1/2] hwmon: Add Congatec Board Controller monitoring driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-congatec-board-controller-hwmon-v1-1-871e4cd59d8e@bootlin.com>
References: <20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com>
In-Reply-To: <20241104-congatec-board-controller-hwmon-v1-0-871e4cd59d8e@bootlin.com>
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
 drivers/hwmon/cgbc-hwmon.c | 287 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 298 insertions(+)

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
index 000000000000..3234c7590acb
--- /dev/null
+++ b/drivers/hwmon/cgbc-hwmon.c
@@ -0,0 +1,287 @@
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
+#define CGBC_HWMON_TYPE_TEMP	1
+#define CGBC_HWMON_TYPE_IN	2
+#define CGBC_HWMON_TYPE_FAN	3
+
+#define CGBC_HWMON_CMD_SENSOR		0x77
+#define CGBC_HWMON_CMD_SENSOR_DATA_SIZE	0x05
+
+#define CGBC_HWMON_TYPE_MASK	GENMASK(6, 5)
+#define CGBC_HWMON_ID_MASK	GENMASK(4, 0)
+#define CGBC_HWMON_ACTIVE_BIT	BIT(7)
+#define CGBC_HWMON_DATA_HIGH	GENMASK(15, 8)
+#define CGBC_HWMON_DATA_LOW	GENMASK(7, 0)
+
+struct cgbc_hwmon_sensor {
+	enum hwmon_sensor_types type;
+	bool active;
+	u8 index;
+	const char *label;
+};
+
+struct cgbc_hwmon_data {
+	struct cgbc_device_data *cgbc;
+	u8 nb_sensors;
+	struct cgbc_hwmon_sensor *sensors;
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
+static const char * const cgbc_hwmon_labels_fan[] = {
+	"CPU Fan",
+	"Box Fan",
+	"Ambient Fan",
+	"Chipset Fan",
+	"Video Fan",
+	"Other Fan",
+};
+
+static int cgbc_hwmon_cmd(struct cgbc_device_data *cgbc, u8 id, u8 *data)
+{
+	u8 cmd[2] = {CGBC_HWMON_CMD_SENSOR, id};
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
+		u8 type, id;
+
+		ret = cgbc_hwmon_cmd(cgbc, i, &data[0]);
+		if (ret)
+			return ret;
+
+		type = FIELD_GET(CGBC_HWMON_TYPE_MASK, data[1]);
+		id = FIELD_GET(CGBC_HWMON_ID_MASK, data[1]) - 1;
+
+		if (type == CGBC_HWMON_TYPE_TEMP && id < ARRAY_SIZE(cgbc_hwmon_labels_temp)) {
+			sensor->type = hwmon_temp;
+			sensor->label = cgbc_hwmon_labels_temp[id];
+		} else if (type == CGBC_HWMON_TYPE_IN && id < ARRAY_SIZE(cgbc_hwmon_labels_in)) {
+			/*
+			 * The Board Controller doesn't do differences between current and voltage
+			 * sensors
+			 */
+			sensor->type = cgbc_hwmon_labels_in[id].type;
+			sensor->label = cgbc_hwmon_labels_in[id].label;
+		} else if (type == CGBC_HWMON_TYPE_FAN && id < ARRAY_SIZE(cgbc_hwmon_labels_fan)) {
+			sensor->type = hwmon_fan;
+			sensor->label = cgbc_hwmon_labels_fan[id];
+		} else {
+			dev_warn(dev, "Board Controller returned an unknown sensor (type=%d, id=%d), ignore it",
+				 type, id);
+			continue;
+		}
+
+		sensor->active = FIELD_GET(CGBC_HWMON_ACTIVE_BIT, data[1]);
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
+	int i, cnt = 0;
+
+	for (i = 0; i < hwmon->nb_sensors; i++) {
+		if (hwmon->sensors[i].type == type && cnt++ == channel) {
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
+	if (!sensor)
+		return -ENODEV;
+
+	ret = cgbc_hwmon_cmd(cgbc, sensor->index, &data[0]);
+	if (ret)
+		return ret;
+
+	*val = FIELD_PREP(CGBC_HWMON_DATA_HIGH, data[3]) | FIELD_PREP(CGBC_HWMON_DATA_LOW, data[2]);
+
+	/* For the Board Controller 1lsb = 0.1 degree centigrade */
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
+	if (!sensor)
+		return -ENODEV;
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
+	platform_set_drvdata(pdev, data);
+
+	ret = cgbc_hwmon_probe_sensors(dev, data);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to probe sensors");
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


