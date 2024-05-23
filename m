Return-Path: <linux-kernel+bounces-187438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1A8CD1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 14:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B441F22C71
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 12:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314D913F44A;
	Thu, 23 May 2024 12:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bqSOLSqC"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752913B7A6;
	Thu, 23 May 2024 12:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716466309; cv=none; b=MYjUiaSxoJudhl1ZGbCqbzWjoFJ7OaLvt7o+Fwl6Rmt0U2fd8ZDI54Juybfr2kN5R2m1iVtY0bfT6O79PBPqWrT3hFVKXa8OpZae8Ki5Kjkd4Y0F5lk4YSnzRMxnQIccwYzBvdMPBvB8dnYUtPa/04DsXbI8qdRDew0EcGaVWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716466309; c=relaxed/simple;
	bh=vALmUqA5Wog+zqLtOkN/QaJNWqWwzNf0U+orGc33tQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EXXXCSSf6o3bQ5nmEpYYtco/I2s/Qaizrw0wido3EAoDe6euGg3emrpX1psCyVbNVAHUWq3ks9a2WBQxE8NW2WzXOhCs8/89XoBC2l82oY9YwsxwnCGZOKxIh65oaxSPZaVpZ44C/WoItuF4/B9xnr4p+TgISo7cJEFbEx6kANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bqSOLSqC; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44NA1Zhg011307;
	Thu, 23 May 2024 08:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=EdFbmO6SN0AAHhccZL9llajYuxh
	Q6Qu7Stq9Fo0o8LI=; b=bqSOLSqCwZLDDbX8JoO7RBW97SCn8XuOxI+27TcJokM
	KLZUG350eSX14K4wx79ihiNf5eW4YWaLmJ6YcfzHHIFDztXbS7krYkOrsvCMx2a2
	v0R4N9RLY1KrsUShFhQsmtLXmk7bcKQswvR1sJgNs+Nwtj8IQg9jo32a5Gmxcqfi
	B3UfprmhdtVLWHuTK/fWQby5z9RQFJkyhV6UYZBhPPhB8aqqpsEk9xGuYdK/6m82
	X7V2sAunikz7si4j+nEwV0RXdBBWMDXJyJQ6PKoUbn47b1tSD3QsLPX3el6qsiRW
	mjrceCRoa0rE9+CX+sYOMMeCeu+04S7bCIb590gqUUw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y9xwuhgt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 08:11:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44NCBR1k024808
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 May 2024 08:11:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 23 May
 2024 08:11:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 23 May 2024 08:11:26 -0400
Received: from radu.ad.analog.com ([10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44NCBF7Y029999;
	Thu, 23 May 2024 08:11:18 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH v2] drivers: hwmon: max31827: Add PEC support
Date: Thu, 23 May 2024 15:10:56 +0300
Message-ID: <20240523121057.5689-1-radu.sabau@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: h9Tr9HCB91KG15ivkVUtZyfpR07p5NaD
X-Proofpoint-ORIG-GUID: h9Tr9HCB91KG15ivkVUtZyfpR07p5NaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_07,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405230083

Add support for PEC by attaching PEC attribute to the i2c device.
Add pec_store and pec_show function for accesing the "pec" file.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 Documentation/hwmon/max31827.rst | 13 +++++--
 drivers/hwmon/max31827.c         | 64 ++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+), 3 deletions(-)

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
index f8a13b30f100..e86f8890ee72 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -24,6 +24,7 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
 #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
 #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
@@ -475,6 +476,54 @@ static ssize_t temp1_resolution_store(struct device *dev,
 
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
+	unsigned int val;
+	int err;
+
+	err = kstrtouint(buf, 10, &val);
+	if (err < 0)
+		return err;
+
+	switch (val) {
+	case 0:
+		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_PEC_EN_MASK,
+					 val);
+		if (err)
+			return err;
+
+		client->flags &= ~I2C_CLIENT_PEC;
+		break;
+	case 1:
+		err = regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_PEC_EN_MASK,
+					 val);
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
+
+static DEVICE_ATTR_RW(pec);
+
 static struct attribute *max31827_attrs[] = {
 	&dev_attr_temp1_resolution.attr,
 	NULL
@@ -578,6 +627,11 @@ static int max31827_init_client(struct max31827_state *st,
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
@@ -627,6 +681,16 @@ static int max31827_probe(struct i2c_client *client)
 	if (err)
 		return err;
 
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC)) {
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
-- 
2.34.1


