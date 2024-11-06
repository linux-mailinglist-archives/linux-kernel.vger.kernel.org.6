Return-Path: <linux-kernel+bounces-397879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B919BE1C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F211F238B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4C1DED53;
	Wed,  6 Nov 2024 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LQZ4D/m5"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900C1DE8AA;
	Wed,  6 Nov 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883845; cv=none; b=pEL92YEwEQnUi20HUH7f7JGYiYw7LKy+SZ7B6Yh062eEyV8W0APYnJbSBH+i+6YB8O7pA76Zr5JTYp6QZGhgAprg9+4UNAwokDk8sjoX585isv/M60AYXMNsyjY1LDJIJq5DMlra70KeEby339BV9Lz88Rdw0kw3wY3rT1Bg+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883845; c=relaxed/simple;
	bh=3r21XRN3UpgjXD9NjMS6rOTS6phVDAT7Vp1FP+ogCIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ur10UHKaxykgztvvogamYVGtqs7fo2pd10oZ8jt70Ob1gv7QnRsBueGw5MK72TkOPX61+3klEITEQn0Xhp5GTXtQWAIZlOOwsco8gJ44G1577Gn3rvhwSEXXvJ7ukoer6wG9UQky8Agu0wrR0ga9qwAsPjKu2ZjXsFJ0esi6PZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LQZ4D/m5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A687rpU019762;
	Wed, 6 Nov 2024 04:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uJMJV
	fIOafJRves3UKb0L/emqLVFnZqj4bvZYN0+nS8=; b=LQZ4D/m5bQKYQ2/n/6Mgw
	FohyHs7ObQfITBDoHNW5XVx7aBSRfBJoWwHaDHgQt7v6IcDW84TZ8cc4m8jRZodG
	7H6LrSMW4eLhyFX21s5zLrQrG56jfH5IB+qa6ZUVBpHZ/4S5uxQJrPM3tPhX8tAJ
	f2SBO3RRgJpRRCkYZ/VEsV982otJTARoccgamDCkzBkwoNAx747r81O+e74GUQFB
	ytGZlsNwrBmNdnqaNcfucENLLWdN2hXuppB/aEEEZ0OBg5jXjIfGKUoJqf+8ZErF
	SEqE/ZoASsLsOoMJnKEvFbK/Dhv4pUHFvlhaZpdwnDoAA7qV0Vo6T8p0Yaq+Kfoj
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42qbq36kf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 04:03:46 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A693jGg025342
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 04:03:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 6 Nov 2024
 04:03:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 6 Nov 2024 04:03:45 -0500
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.44.137])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A693GTE006260;
	Wed, 6 Nov 2024 04:03:36 -0500
From: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
To: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>,
        Alexis Cezar Torreno
	<alexisczezar.torreno@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2] hwmon: (pmbus/adp1050): Support adp1051 and adp1055
Date: Wed, 6 Nov 2024 17:03:11 +0800
Message-ID: <20241106090311.17536-3-alexisczezar.torreno@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
References: <20241106090311.17536-1-alexisczezar.torreno@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1tcfpG5b4eFXICtNvjch-qh3Xmbjtdrn
X-Proofpoint-GUID: 1tcfpG5b4eFXICtNvjch-qh3Xmbjtdrn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060073

ADP1051: 6 PWM for I/O Voltage, I/O Current, Temperature
ADP1055: 6 PWM for I/O Voltage, I/O Current, Power, Temperature
Signed-off-by: Alexis Cezar Torreno <alexisczezar.torreno@analog.com>
---
 Documentation/hwmon/adp1050.rst | 52 ++++++++++++++++++++++++++++++---
 drivers/hwmon/pmbus/adp1050.c   | 44 +++++++++++++++++++++++++---
 2 files changed, 88 insertions(+), 8 deletions(-)

diff --git a/Documentation/hwmon/adp1050.rst b/Documentation/hwmon/adp1050.rst
index 8fa937064886..5e2edcbe0c59 100644
--- a/Documentation/hwmon/adp1050.rst
+++ b/Documentation/hwmon/adp1050.rst
@@ -13,18 +13,33 @@ Supported chips:
 
     Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADP1050.pdf
 
+  * Analog Devices ADP1051
+
+    Prefix: 'adp1051'
+
+    Addresses scanned: I2C 0x70 - 0x77
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADP1051.pdf
+
+  * Analog Devices ADP1055
+
+    Prefix: 'adp1055'
+
+    Addresses scanned: I2C 0x4B - 0x77
+
+    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADP1055.pdf
+
 Authors:
 
   - Radu Sabau <radu.sabau@analog.com>
 
-
 Description
 -----------
 
-This driver supprts hardware monitoring for Analog Devices ADP1050 Digital
-Controller for Isolated Power Supply with PMBus interface.
+This driver supports hardware monitoring for Analog Devices ADP1050, ADP1051, and
+ADP1055 Digital Controller for Isolated Power Supply with PMBus interface.
 
-The ADP1050 is an advanced digital controller with a PMBus™
+The ADP105X is an advanced digital controller with a PMBus™
 interface targeting high density, high efficiency dc-to-dc power
 conversion used to monitor system temperatures, voltages and currents.
 Through the PMBus interface, the device can monitor input/output voltages,
@@ -49,16 +64,45 @@ Sysfs Attributes
 in1_label         "vin"
 in1_input         Measured input voltage
 in1_alarm	  Input voltage alarm
+in1_crit          Critical maximum input voltage
+in1_crit_alarm    Input voltage high alarm
+in1_lcrit         Critical minimum input voltage
+in1_lcrit_alarm   Input voltage critical low alarm
 in2_label	  "vout1"
 in2_input	  Measured output voltage
 in2_crit	  Critical maximum output voltage
 in2_crit_alarm    Output voltage high alarm
 in2_lcrit	  Critical minimum output voltage
 in2_lcrit_alarm	  Output voltage critical low alarm
+in2_max           Critical maximum output voltage
+in2_max_alarm     Output voltage critical max alarm
+in2_min           Critical minimum output voltage
+in2_min_alarm     Output voltage critical min alarm
 curr1_label	  "iin"
 curr1_input	  Measured input current.
 curr1_alarm	  Input current alarm
+curr1_crit        Critical maximum input current
+curr1_crit_alarm  Input current high alarm
+curr2_label       "iout1"
+curr2_input       Measured output current
+curr2_crit        Critical maximum output current
+curr2_crit_alarm  Output current high alarm
+curr2_lcrit       Critical minimum output current
+curr2_lcrit_alarm Output current critical low alarm
+curr2_max         Critical maximum output current
+curr2_max_alarm   Output current critical max alarm
+power1_label      "pout1"
+power1_input      Measured output power
+power1_crit       Critical maximum output power
+power1_crit_alarm Output power high alarm
 temp1_input       Measured temperature
 temp1_crit	  Critical high temperature
 temp1_crit_alarm  Chip temperature critical high alarm
+temp1_max         Critical maximum temperature
+temp1_max_alarm   Temperature critical max alarm
+temp2_input       Measured temperature
+temp2_crit        Critical high temperature
+temp2_crit_alarm  Chip temperature critical high alarm
+temp2_max         Critical maximum temperature
+temp2_max_alarm   Temperature critical max alarm
 ================= ========================================
diff --git a/drivers/hwmon/pmbus/adp1050.c b/drivers/hwmon/pmbus/adp1050.c
index 20f22730fc01..db2054181d14 100644
--- a/drivers/hwmon/pmbus/adp1050.c
+++ b/drivers/hwmon/pmbus/adp1050.c
@@ -6,8 +6,8 @@
  */
 #include <linux/bits.h>
 #include <linux/i2c.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 
 #include "pmbus.h"
 
@@ -23,19 +23,55 @@ static struct pmbus_driver_info adp1050_info = {
 		| PMBUS_HAVE_STATUS_TEMP,
 };
 
+static struct pmbus_driver_info adp1051_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
+		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_VOUT
+		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
+		   | PMBUS_HAVE_STATUS_TEMP,
+};
+
+static struct pmbus_driver_info adp1055_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_IIN | PMBUS_HAVE_VOUT
+		   | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP2 | PMBUS_HAVE_TEMP3
+		   | PMBUS_HAVE_POUT | PMBUS_HAVE_STATUS_VOUT
+		   | PMBUS_HAVE_STATUS_IOUT | PMBUS_HAVE_STATUS_INPUT
+		   | PMBUS_HAVE_STATUS_TEMP,
+};
+
 static int adp1050_probe(struct i2c_client *client)
 {
-	return pmbus_do_probe(client, &adp1050_info);
+	const struct pmbus_driver_info *info;
+
+	info = device_get_match_data(&client->dev);
+	if (!info)
+		return -ENODEV;
+
+	return pmbus_do_probe(client, info);
 }
 
 static const struct i2c_device_id adp1050_id[] = {
-	{"adp1050"},
+	{ .name = "adp1050", .driver_data = (kernel_ulong_t)&adp1050_info},
+	{ .name = "adp1051", .driver_data = (kernel_ulong_t)&adp1051_info},
+	{ .name = "adp1055", .driver_data = (kernel_ulong_t)&adp1055_info},
 	{}
 };
+
 MODULE_DEVICE_TABLE(i2c, adp1050_id);
 
 static const struct of_device_id adp1050_of_match[] = {
-	{ .compatible = "adi,adp1050"},
+	{ .compatible = "adi,adp1050", .data = &adp1050_info},
+	{ .compatible = "adi,adp1051", .data = &adp1051_info},
+	{ .compatible = "adi,adp1055", .data = &adp1055_info},
 	{}
 };
 MODULE_DEVICE_TABLE(of, adp1050_of_match);
-- 
2.34.1


