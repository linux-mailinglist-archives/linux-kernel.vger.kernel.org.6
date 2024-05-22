Return-Path: <linux-kernel+bounces-186234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99AE8CC167
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641802853B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B513DDA7;
	Wed, 22 May 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hG2hnAnC"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C083D13D61A;
	Wed, 22 May 2024 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381641; cv=none; b=YpMkfFgP2ObeQwHhhzc1BI5erJ740Iitl0nSU8nZ8JR33xik/uAqHa5ipCrcXW7y9AR+6Sv7VeTMuO5q6dTtDuq4+pAhmQTrOUqi9v2nObEru8RXQeD3cIZ2c/SM0AmC1YEaGepvbeyEAbjJabcV4PJn9UqIdau8L+mF3zR0fuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381641; c=relaxed/simple;
	bh=HWRRwi3ccbUGSDEuBLfvypPHdGVov7NeIQA1lGgI61g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oWV/lswQvwtnMCNxE3TPkE3JiKFTlu6KC88+M0+Ft2XalaDa6sIp9vDzTKW72quTOlxwCe7Kzho5G7jOuNrWSRUUlqVNgcne5hzdP/8J20BHWVP5CHoK6KqC91UcvBY6ralfDqYoeiZp+mPg6dSRrpLlmanR/+SuxkxxYWdA5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hG2hnAnC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M75CC1011851;
	Wed, 22 May 2024 08:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=m/4b11ulW92ZtW0QmJVH/fhK9uSDEPAoQ3Jgqoo0FxY=; b=hG2hnAnC5RGO
	GHYB+NmgbMGUmOU5nu5IfZ7JEejXnkIXkN/30nEtSGa1SPozcDyETCuXzkqy0Ej6
	IWeQ9J3v6L4vDbzXkdysq7i6VA+LJ6/WASvWmuRm9a2Ml/txvxYo4BfNcK+MloTt
	68rAf3EKMZg8YKS1b/QSmhhfLFsx9aAq+eG29YFeVuBwao4AMXMi7fUIrO9t3xDg
	B6GsWMX7XdkcBQban1HVbiFImqxXdJxz+Eyr5WIR9VUCU2MbfmZva3Ic2iy+UyKz
	r2kivYCkZn/y8EWfdR3xEF6u/OGtNKE/I1XGaUSc5uufAJi0xMPxfA5CXS/1GCKz
	trQMR4cUWw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y87pwh4dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 08:40:26 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44MCePH8013946
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 08:40:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 22 May
 2024 08:40:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 08:40:24 -0400
Received: from radu.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44MCe7Ib005879;
	Wed, 22 May 2024 08:40:20 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH 1/2] drivers: hwmon: max31827: Add PEC support
Date: Wed, 22 May 2024 15:39:22 +0300
Message-ID: <20240522123923.22320-2-radu.sabau@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522123923.22320-1-radu.sabau@analog.com>
References: <20240522123923.22320-1-radu.sabau@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: SYLXcLj7rIfqmbU5NrXGBMWayJbXjA6F
X-Proofpoint-GUID: SYLXcLj7rIfqmbU5NrXGBMWayJbXjA6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220085

Add support for PEC by attaching PEC attribute to the i2c device.
Add pec_store and pec_show function for accesing the "pec" file.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 Documentation/hwmon/max31827.rst | 13 ++++-
 drivers/hwmon/max31827.c         | 95 +++++++++++++++++++++++++++-----
 2 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 44ab9dc064cb..9c11a9518c67 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive temperature faults must occur
 before overtemperature or undertemperature faults are indicated in the
 corresponding status bits.
 
-Notes
------
+PEC Support
+-----------
+
+When reading a register value, the PEC byte is computed and sent by the chip.
+
+PEC on word data transaction respresents a signifcant increase in bandwitdh
+usage (+33% for both write and reads) in normal conditions.
 
-PEC is not implemented.
+Since this operation implies there will be an extra delay to each
+transaction, PEC can be disabled or enabled through sysfs.
+Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index f8a13b30f100..16a1524413db 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -11,19 +11,20 @@
 #include <linux/hwmon.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
-#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/of_device.h>
 
-#define MAX31827_T_REG			0x0
+#define MAX31827_T_REG	0x0
 #define MAX31827_CONFIGURATION_REG	0x2
-#define MAX31827_TH_REG			0x4
-#define MAX31827_TL_REG			0x6
-#define MAX31827_TH_HYST_REG		0x8
-#define MAX31827_TL_HYST_REG		0xA
+#define MAX31827_TH_REG	0x4
+#define MAX31827_TL_REG 0x6
+#define MAX31827_TH_HYST_REG	0x8
+#define MAX31827_TL_HYST_REG	0xA
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
 #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
 #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
@@ -46,6 +47,8 @@
 #define MAX31827_M_DGR_TO_16_BIT(x)	(((x) << 4) / 1000)
 #define MAX31827_DEVICE_ENABLE(x)	((x) ? 0xA : 0x0)
 
+#define DEBUG_FS_DATA_MAX	16
+
 enum chips { max31827 = 1, max31828, max31829 };
 
 enum max31827_cnv {
@@ -151,8 +154,8 @@ static int shutdown_write(struct max31827_state *st, unsigned int reg,
 		goto unlock;
 
 	ret = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
-				 MAX31827_CONFIGURATION_CNV_RATE_MASK,
-				 cnv_rate);
+				   MAX31827_CONFIGURATION_CNV_RATE_MASK,
+				   cnv_rate);
 
 unlock:
 	mutex_unlock(&st->lock);
@@ -344,7 +347,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 		switch (attr) {
 		case hwmon_temp_enable:
 			if (val >> 1)
-				return -EINVAL;
+				return -EOPNOTSUPP;
 
 			mutex_lock(&st->lock);
 			/**
@@ -384,7 +387,7 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_chip:
 		if (attr == hwmon_chip_update_interval) {
 			if (!st->enable)
-				return -EINVAL;
+				return -EOPNOTSUPP;
 
 			/*
 			 * Convert the desired conversion rate into register
@@ -472,11 +475,60 @@ static ssize_t temp1_resolution_store(struct device *dev,
 
 	return ret ? ret : count;
 }
-
 static DEVICE_ATTR_RW(temp1_resolution);
 
+static ssize_t pec_show(struct device *dev, struct device_attribute *devattr,
+			char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
+}
+
+static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct max31827_state *st = dev_get_drvdata(dev);
+	struct i2c_client *client = to_i2c_client(dev);
+	unsigned int val, val2;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	val2 = FIELD_PREP(MAX31827_CONFIGURATION_PEC_EN_MASK, !!val);
+
+	switch (val) {
+	case 0:
+		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_PEC_EN_MASK,
+					 val2);
+		if (err)
+			return err;
+
+		client->flags &= ~I2C_CLIENT_PEC;
+		break;
+	case 1:
+		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_PEC_EN_MASK,
+					 val2);
+		if (err)
+			return err;
+
+		client->flags |= I2C_CLIENT_PEC;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(pec);
+
 static struct attribute *max31827_attrs[] = {
 	&dev_attr_temp1_resolution.attr,
+	&dev_attr_pec.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(max31827);
@@ -493,8 +545,8 @@ static int max31827_init_client(struct max31827_state *st,
 				struct device *dev)
 {
 	struct fwnode_handle *fwnode;
+	unsigned int data, lsb_idx;
 	unsigned int res = 0;
-	u32 data, lsb_idx;
 	enum chips type;
 	bool prop;
 	int ret;
@@ -578,6 +630,11 @@ static int max31827_init_client(struct max31827_state *st,
 	return regmap_write(st->regmap, MAX31827_CONFIGURATION_REG, res);
 }
 
+static void max31827_remove_pec(void *dev)
+{
+	device_remove_file(dev, &dev_attr_pec);
+}
+
 static const struct hwmon_channel_info *max31827_info[] = {
 	HWMON_CHANNEL_INFO(temp, HWMON_T_ENABLE | HWMON_T_INPUT | HWMON_T_MIN |
 					 HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM |
@@ -627,6 +684,16 @@ static int max31827_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC)) {
+		err = device_create_file(dev, &dev_attr_pec);
+		if (err)
+			return err;
+
+		err = devm_add_action_or_reset(dev, max31827_remove_pec, dev);
+		if (err)
+			return err;
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name, st,
 							 &max31827_chip_info,
 							 max31827_groups);
@@ -652,15 +719,17 @@ static const struct of_device_id max31827_of_match[] = {
 MODULE_DEVICE_TABLE(of, max31827_of_match);
 
 static struct i2c_driver max31827_driver = {
+	.class = I2C_CLASS_HWMON,
 	.driver = {
 		.name = "max31827",
 		.of_match_table = max31827_of_match,
 	},
-	.probe = max31827_probe,
+	.probe_new = max31827_probe,
 	.id_table = max31827_i2c_ids,
 };
 module_i2c_driver(max31827_driver);
 
 MODULE_AUTHOR("Daniel Matyas <daniel.matyas@analog.com>");
+MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
 MODULE_DESCRIPTION("Maxim MAX31827 low-power temperature switch driver");
 MODULE_LICENSE("GPL");
-- 
2.34.1


