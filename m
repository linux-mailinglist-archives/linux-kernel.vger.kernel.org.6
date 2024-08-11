Return-Path: <linux-kernel+bounces-282065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E694DF4E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A45A0B21716
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBED256D;
	Sun, 11 Aug 2024 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKgGAs8O"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F77A15B7;
	Sun, 11 Aug 2024 00:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723335314; cv=none; b=MIg26jB4pSgneTORcJA92/U3MsV/c0EIUSMnHp0qFN0bp1t3A+NB3UXNqQzVCq2wJ1Doq6NW02kfwCUAYI+GV1aExHKDQJAT2fuMUAWbqhi2Ye3Cxg0RJodfC9ekCgwoB8aNIfpDQgKZnAdNuSn0AviSbtvW9uRwnZCWvvuw978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723335314; c=relaxed/simple;
	bh=CFxWkDdaBk4BlcAS2Z+VoYK1OP0g3Z3NXQC1IhP6yl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ec1ovZ2A8L+2w3Y6iT+InrC4HEgRUxWFh1ocM4MwEm/imi6b0Xis6rOFc7KxXl7oavmZuRfwjamzXzR09CQM4Qt4a8ZyitWTGtliVnTTO9b3blrHz/jWnUYsiryoQYcn/h+q0//F/LfQjXyiZ1JHiTnJISdWhGhXnQC0mczkt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKgGAs8O; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7ab76558a9so463211066b.1;
        Sat, 10 Aug 2024 17:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723335311; x=1723940111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJalfhmKi18rS5I0rTnbRBfCKSfHrboNvK1gbOyG+PA=;
        b=dKgGAs8OPpoUHmfI4z1wTs9xv+ZFJGYOKE2CF+Nn4F65WpSCo8tTgarKJW1asg/3Wj
         OxUdMA7FuJly5nNa52quR+sgrLYuThJrPPRKfgO07bZ/mu2DrwZILAmnOqYsD1jOigpm
         QY2pIOUpMWDvXNGP8g9s4CWZa7l7yc7YbK9WCljyC+2n5g24VcvCEhyRXXXh8nU3Ca96
         9OlZbfEnt86BBzBkuUhbSFkUd1JhHLI7h5Gb8Hl1kKj/W7XU2ItZdvkkkrFGVcc7WaN2
         qqr9kPE86nKQoG2mkDb7CrPl/dbZ3TjNWBUPKvniavK4yFTMpZu9bxSPRZHYoBHgHLcQ
         P2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723335311; x=1723940111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJalfhmKi18rS5I0rTnbRBfCKSfHrboNvK1gbOyG+PA=;
        b=XyuqpFFc8h12Ik3jgTHtt8jL9qEN7vHv8aJwY8SuDhsp3SnLV6hdLAspNcrJRtHF3T
         CWUwxNB9YMXKxHmwOhVHaroBdJEOVVmdp8w4/fR/ijLC6AlufsoaCHhPIpvub309V6AZ
         hfylYrXJpTqWyJlJJm6ML07FuiY/W7+9pdtwyEuvssFElPmFN4TRNY/LVFTUOLGcppf5
         HdQwMesmqn6x3TytCk4bz+VTuPGGVwyQHI/IH5Y49ziQtZS2EyOhBxM0l47L8gqKe29L
         3tn3BdEZsiYTZuVCEcVGYy/0whILpCRdXYjmjgXccyHKh5uoZnI+nR3UXQN+o/1LaXkL
         6Afw==
X-Forwarded-Encrypted: i=1; AJvYcCV8q2t/Gojt0cSxC8i3cBYvuooRcSZE0KNo9P4esmKA0gHBpcur4Cvqs36eGixXYg+ziQoG1nGIW/2+et8VMS1gTfaO9WGoxfMaBUVvQMSIT1EYl23ZWJHMyieaUmAgQLO45LWcRoE3IPY=
X-Gm-Message-State: AOJu0Yxy1acxFWAi4cOx0qMfg6pZRP2matijfYXxU3ZrNMbXwGLJFcrc
	z8e3pyrKaysjeu5ZTY2gAbR7pwcMADacSPvN1/mG2qoCY+YrZ0iD
X-Google-Smtp-Source: AGHT+IGcyozy5n1Q8Vt+4/cXZ1ErSaVge+vUAruWOzLxPQBKMP87FeDI87MSlBhJw7paGzdCeIkoFQ==
X-Received: by 2002:a17:906:4fce:b0:a7d:2772:6d5f with SMTP id a640c23a62f3a-a80ab94dedbmr545160466b.23.1723335310472;
        Sat, 10 Aug 2024 17:15:10 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2423fasm106705866b.218.2024.08.10.17.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Aug 2024 17:15:09 -0700 (PDT)
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Maximilian Luz <luzmaximilian@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ivor Wanders <ivor@iwanders.net>,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH v4] hwmon: Add thermal sensor driver for Surface Aggregator Module
Date: Sun, 11 Aug 2024 02:14:41 +0200
Message-ID: <20240811001503.753728-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the newer Microsoft Surface devices (such as the Surface Book
3 and Pro 9) have thermal sensors connected via the Surface Aggregator
Module (the embedded controller on those devices). Add a basic driver
to read out the temperature values of those sensors.

The EC can have up to 16 thermal sensors connected via a single
sub-device, each providing temperature readings and a label string.

Link: https://github.com/linux-surface/surface-aggregator-module/issues/59
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Co-developed-by: Ivor Wanders <ivor@iwanders.net>
Signed-off-by: Ivor Wanders <ivor@iwanders.net>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Links:
 - v3: https://lore.kernel.org/lkml/20240810214748.425520-1-luzmaximilian@gmail.com
 - v2: https://lore.kernel.org/lkml/20240804230832.247852-1-luzmaximilian@gmail.com
 - v1: https://lore.kernel.org/lkml/20240330112409.3402943-1-luzmaximilian@gmail.com

Changes in v4:
 - Fix kconfig recursion by switching to "depends on" for
   SURFACE_AGGREGATOR_BUS

Changes in v3:
 - Fix dependencies in Kconfig

Changes in v2:
 - Drop patch 0003 ("platform/surface: aggregator_registry: Add support
   for thermal sensors on the Surface Pro 9") as it has already been
   applied.
 - Squash patches 0001 ("hwmon: Add thermal sensor driver for Surface
   Aggregator Module") and 0002 ("hwmon: surface_temp: Add support for
   sensor names") into a single patch.
 - Replace usage of WARN_ON() with dev_err().
 - Fix formatting and (strict) checkpatch complaints.

---
 MAINTAINERS                  |   6 +
 drivers/hwmon/Kconfig        |  11 ++
 drivers/hwmon/Makefile       |   1 +
 drivers/hwmon/surface_temp.c | 235 +++++++++++++++++++++++++++++++++++
 4 files changed, 253 insertions(+)
 create mode 100644 drivers/hwmon/surface_temp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..3f53cb9242c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15200,6 +15200,12 @@ S:	Maintained
 F:	Documentation/hwmon/surface_fan.rst
 F:	drivers/hwmon/surface_fan.c
 
+MICROSOFT SURFACE SENSOR THERMAL DRIVER
+M:	Maximilian Luz <luzmaximilian@gmail.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	drivers/hwmon/surface_temp.c
+
 MICROSOFT SURFACE GPE LID SUPPORT DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index b60fe2e58ad6..108e4bef4a7c 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2080,6 +2080,17 @@ config SENSORS_SURFACE_FAN
 
 	  Select M or Y here, if you want to be able to read the fan's speed.
 
+config SENSORS_SURFACE_TEMP
+	tristate "Microsoft Surface Thermal Sensor Driver"
+	depends on SURFACE_AGGREGATOR
+	depends on SURFACE_AGGREGATOR_BUS
+	help
+	  Driver for monitoring thermal sensors connected via the Surface
+	  Aggregator Module (embedded controller) on Microsoft Surface devices.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called surface_temp.
+
 config SENSORS_ADC128D818
 	tristate "Texas Instruments ADC128D818"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index b1c7056c37db..3ce8d6a9202e 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -209,6 +209,7 @@ obj-$(CONFIG_SENSORS_SPARX5)	+= sparx5-temp.o
 obj-$(CONFIG_SENSORS_SPD5118)	+= spd5118.o
 obj-$(CONFIG_SENSORS_STTS751)	+= stts751.o
 obj-$(CONFIG_SENSORS_SURFACE_FAN)+= surface_fan.o
+obj-$(CONFIG_SENSORS_SURFACE_TEMP)+= surface_temp.o
 obj-$(CONFIG_SENSORS_SY7636A)	+= sy7636a-hwmon.o
 obj-$(CONFIG_SENSORS_AMC6821)	+= amc6821.o
 obj-$(CONFIG_SENSORS_TC74)	+= tc74.o
diff --git a/drivers/hwmon/surface_temp.c b/drivers/hwmon/surface_temp.c
new file mode 100644
index 000000000000..cd21f331f157
--- /dev/null
+++ b/drivers/hwmon/surface_temp.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Thermal sensor subsystem driver for Surface System Aggregator Module (SSAM).
+ *
+ * Copyright (C) 2022-2023 Maximilian Luz <luzmaximilian@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#include <linux/surface_aggregator/controller.h>
+#include <linux/surface_aggregator/device.h>
+
+/* -- SAM interface. -------------------------------------------------------- */
+
+/*
+ * Available sensors are indicated by a 16-bit bitfield, where a 1 marks the
+ * presence of a sensor. So we have at most 16 possible sensors/channels.
+ */
+#define SSAM_TMP_SENSOR_MAX_COUNT	16
+
+/*
+ * All names observed so far are 6 characters long, but there's only
+ * zeros after the name, so perhaps they can be longer. This number reflects
+ * the maximum zero-padded space observed in the returned buffer.
+ */
+#define SSAM_TMP_SENSOR_NAME_LENGTH	18
+
+struct ssam_tmp_get_name_rsp {
+	__le16 unknown1;
+	char unknown2;
+	char name[SSAM_TMP_SENSOR_NAME_LENGTH];
+} __packed;
+
+static_assert(sizeof(struct ssam_tmp_get_name_rsp) == 21);
+
+SSAM_DEFINE_SYNC_REQUEST_CL_R(__ssam_tmp_get_available_sensors, __le16, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x04,
+});
+
+SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_temperature, __le16, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x01,
+});
+
+SSAM_DEFINE_SYNC_REQUEST_MD_R(__ssam_tmp_get_name, struct ssam_tmp_get_name_rsp, {
+	.target_category = SSAM_SSH_TC_TMP,
+	.command_id      = 0x0e,
+});
+
+static int ssam_tmp_get_available_sensors(struct ssam_device *sdev, s16 *sensors)
+{
+	__le16 sensors_le;
+	int status;
+
+	status = __ssam_tmp_get_available_sensors(sdev, &sensors_le);
+	if (status)
+		return status;
+
+	*sensors = le16_to_cpu(sensors_le);
+	return 0;
+}
+
+static int ssam_tmp_get_temperature(struct ssam_device *sdev, u8 iid, long *temperature)
+{
+	__le16 temp_le;
+	int status;
+
+	status = __ssam_tmp_get_temperature(sdev->ctrl, sdev->uid.target, iid, &temp_le);
+	if (status)
+		return status;
+
+	/* Convert 1/10 °K to 1/1000 °C */
+	*temperature = (le16_to_cpu(temp_le) - 2731) * 100L;
+	return 0;
+}
+
+static int ssam_tmp_get_name(struct ssam_device *sdev, u8 iid, char *buf, size_t buf_len)
+{
+	struct ssam_tmp_get_name_rsp name_rsp;
+	int status;
+
+	status =  __ssam_tmp_get_name(sdev->ctrl, sdev->uid.target, iid, &name_rsp);
+	if (status)
+		return status;
+
+	/*
+	 * This should not fail unless the name in the returned struct is not
+	 * null-terminated or someone changed something in the struct
+	 * definitions above, since our buffer and struct have the same
+	 * capacity by design. So if this fails, log an error message. Since
+	 * the more likely cause is that the returned string isn't
+	 * null-terminated, we might have received garbage (as opposed to just
+	 * an incomplete string), so also fail the function.
+	 */
+	status = strscpy(buf, name_rsp.name, buf_len);
+	if (status < 0) {
+		dev_err(&sdev->dev, "received non-null-terminated sensor name string\n");
+		return status;
+	}
+
+	return 0;
+}
+
+/* -- Driver.---------------------------------------------------------------- */
+
+struct ssam_temp {
+	struct ssam_device *sdev;
+	s16 sensors;
+	char names[SSAM_TMP_SENSOR_MAX_COUNT][SSAM_TMP_SENSOR_NAME_LENGTH];
+};
+
+static umode_t ssam_temp_hwmon_is_visible(const void *data,
+					  enum hwmon_sensor_types type,
+					  u32 attr, int channel)
+{
+	const struct ssam_temp *ssam_temp = data;
+
+	if (!(ssam_temp->sensors & BIT(channel)))
+		return 0;
+
+	return 0444;
+}
+
+static int ssam_temp_hwmon_read(struct device *dev,
+				enum hwmon_sensor_types type,
+				u32 attr, int channel, long *value)
+{
+	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
+
+	return ssam_tmp_get_temperature(ssam_temp->sdev, channel + 1, value);
+}
+
+static int ssam_temp_hwmon_read_string(struct device *dev,
+				       enum hwmon_sensor_types type,
+				       u32 attr, int channel, const char **str)
+{
+	const struct ssam_temp *ssam_temp = dev_get_drvdata(dev);
+
+	*str = ssam_temp->names[channel];
+	return 0;
+}
+
+static const struct hwmon_channel_info * const ssam_temp_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip,
+			   HWMON_C_REGISTER_TZ),
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
+			   HWMON_T_INPUT | HWMON_T_LABEL),
+	NULL
+};
+
+static const struct hwmon_ops ssam_temp_hwmon_ops = {
+	.is_visible = ssam_temp_hwmon_is_visible,
+	.read = ssam_temp_hwmon_read,
+	.read_string = ssam_temp_hwmon_read_string,
+};
+
+static const struct hwmon_chip_info ssam_temp_hwmon_chip_info = {
+	.ops = &ssam_temp_hwmon_ops,
+	.info = ssam_temp_hwmon_info,
+};
+
+static int ssam_temp_probe(struct ssam_device *sdev)
+{
+	struct ssam_temp *ssam_temp;
+	struct device *hwmon_dev;
+	s16 sensors;
+	int channel;
+	int status;
+
+	status = ssam_tmp_get_available_sensors(sdev, &sensors);
+	if (status)
+		return status;
+
+	ssam_temp = devm_kzalloc(&sdev->dev, sizeof(*ssam_temp), GFP_KERNEL);
+	if (!ssam_temp)
+		return -ENOMEM;
+
+	ssam_temp->sdev = sdev;
+	ssam_temp->sensors = sensors;
+
+	/* Retrieve the name for each available sensor. */
+	for (channel = 0; channel < SSAM_TMP_SENSOR_MAX_COUNT; channel++) {
+		if (!(sensors & BIT(channel)))
+			continue;
+
+		status = ssam_tmp_get_name(sdev, channel + 1, ssam_temp->names[channel],
+					   SSAM_TMP_SENSOR_NAME_LENGTH);
+		if (status)
+			return status;
+	}
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&sdev->dev, "surface_thermal", ssam_temp,
+							 &ssam_temp_hwmon_chip_info, NULL);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct ssam_device_id ssam_temp_match[] = {
+	{ SSAM_SDEV(TMP, SAM, 0x00, 0x02) },
+	{ },
+};
+MODULE_DEVICE_TABLE(ssam, ssam_temp_match);
+
+static struct ssam_device_driver ssam_temp = {
+	.probe = ssam_temp_probe,
+	.match_table = ssam_temp_match,
+	.driver = {
+		.name = "surface_temp",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+};
+module_ssam_device_driver(ssam_temp);
+
+MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
+MODULE_DESCRIPTION("Thermal sensor subsystem driver for Surface System Aggregator Module");
+MODULE_LICENSE("GPL");
-- 
2.46.0


