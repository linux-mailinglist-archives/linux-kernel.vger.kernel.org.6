Return-Path: <linux-kernel+bounces-196500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38F78D5D11
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385931F22394
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC20155A43;
	Fri, 31 May 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GYGEn6rB"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98928762D0;
	Fri, 31 May 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145248; cv=none; b=mendaMBJUOKi2PkI/EMtEmPnscovWC3cJv3ZO0nksnKsjdVhNEos+29w5sdcSfeI+ZNP2hr/JiW3cOOPcxVrksF8jl+vowei3IjpRQ+yexAKn2OeAN9aEzBRV737jSvO8RDR8wp4iY1Gtfxwzk6sKzZ354g9/2u2vOcMB7obZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145248; c=relaxed/simple;
	bh=YIMxgbIBKA/bQc04vaweWwut+0w6tL08S/RLf90TwtI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=elcpqKPTCrn8qBQ6qyyQSO2n2W9yPl2NqclL+QDSgSXjifiTgdp9a9miYh0Gv6g3MezubHOu9j0BFrNKSQ2ioiqLMEf/Cx5aQSuX0gelnJ4Lv5IrO4ivmnjYvImvZWXXpXwQQ5O+/4re9GidSNx+1QRdHG2/ABfhvOHqBVxUALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GYGEn6rB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V8Nq6G013196;
	Fri, 31 May 2024 04:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=BfOvY2XFvLZ55QcFRnNAA1SivDB
	6mZk+DCeAdeMBKPk=; b=GYGEn6rBTOkSfLFVSm8F1mXWIG0ExWgn/ZgK1h2KRfl
	Mb6MxlW3jvXvndq+ufhEjptv+v8CuKmvtOJ/HfmV1840yaxCbdOu5eON1qOK4vhO
	hSG9yrV2EELGKSJtqPcQdrNximXFJW6inkcnGXOjFzcQctwl9ritkW6Bq/E9BYpu
	oYTEstIOsCX/CFFgUBJ5vWs+dKrunlXbKbK2pmuVYr1FvUh1anbmDmnamLBU4oxM
	92a4yV3c7jIRYuSA9jc5i5cR8jicdVts9oFcePWiiuDHD3ACnUjhXeiPR8c5zgiy
	Kmz9xhp8m7kgRFiybMwq9SrGSkGUvwwEKBck4TMF09g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yf60qh2q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:47:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44V8l52g039322
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 04:47:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 04:47:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 04:47:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 31 May 2024 04:47:04 -0400
Received: from radu.ad.analog.com ([10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44V8kshd031459;
	Fri, 31 May 2024 04:46:56 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v6 1/2] hwmon: Add PEC attribute support to hardware monitoring core
Date: Fri, 31 May 2024 11:46:43 +0300
Message-ID: <20240531084645.12935-1-radu.sabau@analog.com>
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
X-Proofpoint-ORIG-GUID: jkIseQdnZ54Zs506JX4nCrbqLBUdkAoP
X-Proofpoint-GUID: jkIseQdnZ54Zs506JX4nCrbqLBUdkAoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310064

From: Guenter Roeck <linux@roeck-us.net>

Several hardware monitoring chips optionally support Packet Error Checking
(PEC). For some chips, PEC support can be enabled simply by setting
I2C_CLIENT_PEC in the i2c client data structure. Others require chip
specific code to enable or disable PEC support.

Introduce hwmon_chip_pec and HWMON_C_PEC to simplify adding configurable
PEC support for hardware monitoring drivers. A driver can set HWMON_C_PEC
in its chip information data to indicate PEC support. If a chip requires
chip specific code to enable or disable PEC support, the driver only needs
to implement support for the hwmon_chip_pec attribute to its write
function.

The hardware monitoring core does not depend on the I2C subsystem after
this change. However, the I2C subsystem needs to be reachable. This
requires a new HWMON dependency to ensure that HWMON can only be built
as module if I2C is built as module. This should not make a practical
difference.

Cc: Radu Sabau <radu.sabau@analog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/hwmon/Kconfig |   1 +
 drivers/hwmon/hwmon.c | 136 +++++++++++++++++++++++++++++++++++++-----
 include/linux/hwmon.h |   2 +
 3 files changed, 123 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index e14ae18a973b..7f384a2494c9 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -6,6 +6,7 @@
 menuconfig HWMON
 	tristate "Hardware Monitoring support"
 	depends on HAS_IOMEM
+	depends on I2C || I2C=n
 	default y
 	help
 	  Hardware monitoring devices let you monitor the hardware health
diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 3b259c425ab7..1fdea8b1ec91 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/hwmon.h>
+#include <linux/i2c.h>
 #include <linux/idr.h>
 #include <linux/kstrtox.h>
 #include <linux/list.h>
@@ -309,6 +310,103 @@ static int hwmon_attr_base(enum hwmon_sensor_types type)
 	return 1;
 }
 
+/*
+ * PEC support
+ *
+ * The 'pec' attribute is attached to I2C client devices. It is only provided
+ * if the i2c controller supports PEC.
+ *
+ * The mutex ensures that PEC configuration between i2c device and the hardware
+ * is consistent. Use a single mutex because attribute writes are supposed to be
+ * rare, and maintaining a separate mutex for each hardware monitoring device
+ * would add substantial complexity to the driver for little if any gain.
+ *
+ * The hardware monitoring device is identified as child of the i2c client
+ * device. This assumes that only a single hardware monitoring device is
+ * attached to an i2c client device.
+ */
+
+static DEFINE_MUTEX(hwmon_pec_mutex);
+
+static int hwmon_match_device(struct device *dev, void *data)
+{
+	return dev->class == &hwmon_class;
+}
+
+static ssize_t pec_show(struct device *dev, struct device_attribute *dummy,
+			char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	return sprintf(buf, "%d\n", !!(client->flags & I2C_CLIENT_PEC));
+}
+
+static ssize_t pec_store(struct device *dev, struct device_attribute *devattr,
+			 const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hwmon_device *hwdev;
+	struct device *hdev;
+	bool val;
+	int err;
+
+	err = kstrtobool(buf, &val);
+	if (err < 0)
+		return err;
+
+	hdev = device_find_child(dev, NULL, hwmon_match_device);
+	if (!hdev)
+		return -ENODEV;
+
+	mutex_lock(&hwmon_pec_mutex);
+
+	/*
+	 * If there is no write function, we assume that chip specific
+	 * handling is not required.
+	 */
+	hwdev = to_hwmon_device(hdev);
+	if (hwdev->chip->ops->write) {
+		err = hwdev->chip->ops->write(hdev, hwmon_chip, hwmon_chip_pec, 0, val);
+		if (err && err != -EOPNOTSUPP)
+			goto unlock;
+	}
+
+	if (!val)
+		client->flags &= ~I2C_CLIENT_PEC;
+	else
+		client->flags |= I2C_CLIENT_PEC;
+
+	err = count;
+unlock:
+	mutex_unlock(&hwmon_pec_mutex);
+	put_device(hdev);
+
+	return err;
+}
+
+static DEVICE_ATTR_RW(pec);
+
+static void hwmon_remove_pec(void *dev)
+{
+	device_remove_file(dev, &dev_attr_pec);
+}
+
+static int hwmon_pec_register(struct device *hdev)
+{
+	struct i2c_client *client = i2c_verify_client(hdev->parent);
+	int err;
+
+	if (!client ||
+	    !i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_PEC))
+		return 0;
+
+	err = device_create_file(&client->dev, &dev_attr_pec);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(hdev, hwmon_remove_pec, &client->dev);
+}
+
 /* sysfs attribute management */
 
 static ssize_t hwmon_attr_show(struct device *dev,
@@ -397,10 +495,6 @@ static struct attribute *hwmon_genattr(const void *drvdata,
 	const char *name;
 	bool is_string = is_string_attr(type, attr);
 
-	/* The attribute is invisible if there is no template string */
-	if (!template)
-		return ERR_PTR(-ENOENT);
-
 	mode = ops->is_visible(drvdata, type, attr, index);
 	if (!mode)
 		return ERR_PTR(-ENOENT);
@@ -712,8 +806,8 @@ static int hwmon_genattrs(const void *drvdata,
 
 			attr = __ffs(attr_mask);
 			attr_mask &= ~BIT(attr);
-			if (attr >= template_size)
-				return -EINVAL;
+			if (attr >= template_size || !templates[attr])
+				continue;	/* attribute is invisible */
 			a = hwmon_genattr(drvdata, info->type, attr, i,
 					  templates[attr], ops);
 			if (IS_ERR(a)) {
@@ -849,16 +943,26 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	INIT_LIST_HEAD(&hwdev->tzdata);
 
 	if (hdev->of_node && chip && chip->ops->read &&
-	    chip->info[0]->type == hwmon_chip &&
-	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
-		err = hwmon_thermal_register_sensors(hdev);
-		if (err) {
-			device_unregister(hdev);
-			/*
-			 * Don't worry about hwdev; hwmon_dev_release(), called
-			 * from device_unregister(), will free it.
-			 */
-			goto ida_remove;
+	    chip->info[0]->type == hwmon_chip) {
+		u32 config = chip->info[0]->config[0];
+
+		if (config & HWMON_C_REGISTER_TZ) {
+			err = hwmon_thermal_register_sensors(hdev);
+			if (err) {
+				device_unregister(hdev);
+				/*
+				 * Don't worry about hwdev; hwmon_dev_release(),
+				 * called from device_unregister(), will free it.
+				 */
+				goto ida_remove;
+			}
+		}
+		if (config & HWMON_C_PEC) {
+			err = hwmon_pec_register(hdev);
+			if (err) {
+				device_unregister(hdev);
+				goto ida_remove;
+			}
 		}
 	}
 
diff --git a/include/linux/hwmon.h b/include/linux/hwmon.h
index edf96f249eb5..e94314760aab 100644
--- a/include/linux/hwmon.h
+++ b/include/linux/hwmon.h
@@ -45,6 +45,7 @@ enum hwmon_chip_attributes {
 	hwmon_chip_power_samples,
 	hwmon_chip_temp_samples,
 	hwmon_chip_beep_enable,
+	hwmon_chip_pec,
 };
 
 #define HWMON_C_TEMP_RESET_HISTORY	BIT(hwmon_chip_temp_reset_history)
@@ -60,6 +61,7 @@ enum hwmon_chip_attributes {
 #define HWMON_C_POWER_SAMPLES		BIT(hwmon_chip_power_samples)
 #define HWMON_C_TEMP_SAMPLES		BIT(hwmon_chip_temp_samples)
 #define HWMON_C_BEEP_ENABLE		BIT(hwmon_chip_beep_enable)
+#define HWMON_C_PEC			BIT(hwmon_chip_pec)
 
 enum hwmon_temp_attributes {
 	hwmon_temp_enable,
-- 
2.34.1


