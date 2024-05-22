Return-Path: <linux-kernel+bounces-186236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CF28CC16E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B9C1F237AF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1D913F452;
	Wed, 22 May 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="MJMg4/AE"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67413E031;
	Wed, 22 May 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381645; cv=none; b=MNqFXalKlvBJq6Cn8sCx3jc/GoKyzg2jLuDKDKp4R/l+Hr1uluEclQtvAeEPhj35os1GU4Smwi5YFeN8nZSP03BAlRC1V202WF6fKZg3zgOcod50ey7vBnWkX7fL3DamfNht2/2hOEJYducr2+EHvwcAw55E1iT98TEJrcH9Nos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381645; c=relaxed/simple;
	bh=7vkFt0/Es8eM9NpOoGJklRPQA1fts2tNghOMr5lXFgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOamYs/7qWvFSp05iAsATNfyXibF64HkPjTl9j80Y46psHcjsSzVieF6wxpHJAN86DlQJ0AgZLl/3nYCRE4bK16ma43w+GG04er15ZrrLtQilpLJlL+xOIBRobkC9yR7Y8OmCs04keuschgKnMAGlOAVFkJG4JVNXvI/gxVWE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=MJMg4/AE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44MC5WkT011821;
	Wed, 22 May 2024 08:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=DKIM;
	 bh=OHKGS8+XN26OG5c7BXLOon/rMIiAQs5YVbHPwWDNZWg=; b=MJMg4/AEUctR
	752+fPxjUx31aWGacu8H7AAfbT1lL6m1G9rWT3LLaDzD7oNNZLsumcPmbhPI1fZY
	7F5mCwI5cGfFoCE7nWhr5q9pruJyh8PLe/axrVGvbJ4gCJ/8w+As1WsUhLanhKJU
	fNc3IiWwoKy2ZfOYRJBQ2uzCfN9KOFvDDFh85yR2bUfFFpo0luvXneXXZr/cZJKp
	D5MrFSGOKD/Bt/Zm2rH/CkBbum6FtSuutmIbo5V5R0lTPx5rimoX3Gw2Oorc+wp3
	Lt1+e7ABXdqO2bN+1Vahq8vEJLW0hoq/5cYe7AnUdl683cUjhNy48BSWSmxhyBX8
	KcTL6foXGw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3y87pwh4dw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 08:40:30 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44MCeTpu013953
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 08:40:29 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 08:40:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 08:40:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 08:40:28 -0400
Received: from radu.ad.analog.com ([10.48.65.150])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44MCe7Ic005879;
	Wed, 22 May 2024 08:40:22 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH 2/2] drivers: hwmon: max31827: Add debugfs support
Date: Wed, 22 May 2024 15:39:23 +0300
Message-ID: <20240522123923.22320-3-radu.sabau@analog.com>
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
X-Proofpoint-ORIG-GUID: Tj0zzfQgAWtB2qbzwPx6sE8vcBJsKnrj
X-Proofpoint-GUID: Tj0zzfQgAWtB2qbzwPx6sE8vcBJsKnrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220085

Add debugfs support by creating directory in sys-fs which includes
debugfs specific files used for configuring the device by
preference.

Signed-off-b: Radu Sabau <radu.sabau@analog.com>
---
 Documentation/hwmon/max31827.rst |  25 ++++
 drivers/hwmon/max31827.c         | 202 ++++++++++++++++++++++++++++++-
 2 files changed, 225 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9c11a9518c67..940310be6075 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -142,3 +142,28 @@ usage (+33% for both write and reads) in normal conditions.
 Since this operation implies there will be an extra delay to each
 transaction, PEC can be disabled or enabled through sysfs.
 Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
+
+DebugFs entries
+---------------
+
+The chip also has a configuration register where each bit stands for a specific
+functionality to be configured. Hence as one would like to have access to these
+features, we give access to them in debugfs.
+
+.. warning:: The debugfs interface is subject to change without notice
+             and is only available when the kernel is compiled with
+             ``CONFIG_DEBUG_FS`` defined.
+
+``/sys/kernel/debug/max31827/``
+contains the following attributes:
+
+==============  ===============================================================
+alarm_polarity  Write 1 for ALARM pin active state is low, 0 otherwise
+comp_int        Set to 1 if OT and UT status bits are in interrupt mode
+fault_queue     Number of consecutive temperature faults until OT and UT faults
+                are indicated in status bits
+pec_error       Set to 1 if PEC Enable bit is set, 0 otherwise
+resolution      2-bit value that select the conversion resolution, please see
+                datasheet for corresponding values
+timeout         Write 1 do disable bus timeout, 0 otherwise
+==============  ===============================================================
diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
index 16a1524413db..1303ea81250d 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -13,8 +13,19 @@
 #include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/debugfs.h>
 #include <linux/of_device.h>
 
+enum {
+	MAX31827_DEBUGFS_TIMEOUT = 0,
+	MAX31827_DEBUGFS_RESOLUTION,
+	MAX31827_DEBUGFS_ALARM_POLARITY,
+	MAX31827_DEBUGFS_COMP_INT,
+	MAX31827_DEBUGFS_FAULT_QUEUE,
+	MAX31827_DEBUGFS_PEC_ERROR,
+	MAX31827_DEBUGFS_NUM_ENTRIES
+};
+
 #define MAX31827_T_REG	0x0
 #define MAX31827_CONFIGURATION_REG	0x2
 #define MAX31827_TH_REG	0x4
@@ -30,6 +41,7 @@
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
 #define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
 #define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
+#define MAX31827_CONFIGURATION_PEC_ERR_MASK	BIT(13)
 #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
 #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
 
@@ -92,12 +104,17 @@ static const u16 max31827_conv_times[] = {
 	[MAX31827_RES_12_BIT] = MAX31827_12_BIT_CNV_TIME,
 };
 
+struct max31827_debugfs_data {
+	int debugfs_entries[MAX31827_DEBUGFS_NUM_ENTRIES];
+};
+
 struct max31827_state {
 	/*
 	 * Prevent simultaneous access to the i2c client.
 	 */
 	struct mutex lock;
 	struct regmap *regmap;
+	struct max31827_debugfs_data psu;
 	bool enable;
 	unsigned int resolution;
 	unsigned int update_interval;
@@ -552,7 +569,6 @@ static int max31827_init_client(struct max31827_state *st,
 	int ret;
 
 	fwnode = dev_fwnode(dev);
-
 	st->enable = true;
 	res |= MAX31827_DEVICE_ENABLE(1);
 
@@ -655,6 +671,182 @@ static const struct hwmon_chip_info max31827_chip_info = {
 	.info = max31827_info,
 };
 
+#ifdef CONFIG_DEBUG_FS
+static ssize_t max31827_debugfs_read(struct file *file, char __user *buf,
+				     size_t count, loff_t *ppos)
+{
+	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
+	struct max31827_debugfs_data *psu;
+	struct max31827_state *st;
+	int *attrp = file_inode(file)->i_private;
+	int attr = *attrp;
+	unsigned int uval;
+	int ret, len;
+
+	psu = container_of(attrp, struct max31827_debugfs_data, debugfs_entries[attr]);
+	st = container_of(psu, struct max31827_state, psu);
+
+	ret = regmap_read(st->regmap, MAX31827_CONFIGURATION_REG, &uval);
+	if (ret)
+		return ret;
+
+	switch (attr) {
+	case MAX31827_DEBUGFS_TIMEOUT:
+		uval = FIELD_GET(MAX31827_CONFIGURATION_TIMEOUT_MASK, uval);
+		len = scnprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", uval);
+		break;
+	case MAX31827_DEBUGFS_RESOLUTION:
+		uval = FIELD_GET(MAX31827_CONFIGURATION_RESOLUTION_MASK, uval);
+		len = scnprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", uval);
+		break;
+	case MAX31827_DEBUGFS_ALARM_POLARITY:
+		uval = FIELD_GET(MAX31827_CONFIGURATION_ALRM_POL_MASK, uval);
+		len = scnprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", uval);
+		break;
+	case MAX31827_DEBUGFS_COMP_INT:
+		uval = FIELD_GET(MAX31827_CONFIGURATION_COMP_INT_MASK, uval);
+		len = scnprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", uval);
+		break;
+	case MAX31827_DEBUGFS_FAULT_QUEUE:
+		uval = FIELD_GET(MAX31827_CONFIGURATION_FLT_Q_MASK, uval);
+		len = scnprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", uval);
+		break;
+	case MAX31827_DEBUGFS_PEC_ERROR:
+		uval = FIELD_GET(MAX31827_CONFIGURATION_PEC_ERR_MASK, uval);
+		len = scnprintf(tbuf, DEBUG_FS_DATA_MAX, "%d\n", uval);
+		break;
+	default:
+		len = strscpy(tbuf, "Invalid\n", DEBUG_FS_DATA_MAX);
+	}
+
+	return simple_read_from_buffer(buf, count, ppos, tbuf, len);
+}
+
+static ssize_t max31827_debugfs_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	char tbuf[DEBUG_FS_DATA_MAX] = { 0 };
+	struct max31827_debugfs_data *psu;
+	struct max31827_state *st;
+	int *attrp = file_inode(file)->i_private;
+	int attr = *attrp;
+	u16 uval;
+	int ret;
+
+	pr_info("attr = %d\n", attr);
+	psu = container_of(attrp, struct max31827_debugfs_data, debugfs_entries[attr]);
+	pr_info("First container ok.\n");
+	st = container_of(psu, struct max31827_state, psu);
+
+	ret = kstrtou16_from_user(buf, count, 0, &uval);
+	if (ret)
+		return ret;
+
+	pr_info("uval = %s\n", tbuf);
+
+	switch (attr) {
+	case MAX31827_DEBUGFS_TIMEOUT:
+		uval = FIELD_PREP(MAX31827_CONFIGURATION_TIMEOUT_MASK, uval);
+		ret = regmap_update_bits(st->regmap,
+					 MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_TIMEOUT_MASK,
+					 uval);
+		break;
+	case MAX31827_DEBUGFS_RESOLUTION:
+		uval = FIELD_PREP(MAX31827_CONFIGURATION_RESOLUTION_MASK, uval);
+		ret = regmap_update_bits(st->regmap,
+					 MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_RESOLUTION_MASK,
+					 uval);
+		break;
+	case MAX31827_DEBUGFS_ALARM_POLARITY:
+		uval = FIELD_PREP(MAX31827_CONFIGURATION_ALRM_POL_MASK, uval);
+		ret = regmap_update_bits(st->regmap,
+					 MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_ALRM_POL_MASK,
+					 uval);
+		break;
+	case MAX31827_DEBUGFS_COMP_INT:
+		uval = FIELD_PREP(MAX31827_CONFIGURATION_COMP_INT_MASK, uval);
+		ret = regmap_update_bits(st->regmap,
+					 MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_COMP_INT_MASK,
+					 uval);
+		break;
+	case MAX31827_DEBUGFS_FAULT_QUEUE:
+		uval = FIELD_PREP(MAX31827_CONFIGURATION_FLT_Q_MASK, uval);
+		ret = regmap_update_bits(st->regmap,
+					 MAX31827_CONFIGURATION_REG,
+					 MAX31827_CONFIGURATION_FLT_Q_MASK,
+					 uval);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations max31827_fops = {
+	.read = max31827_debugfs_read,
+	.write = max31827_debugfs_write,
+};
+
+static void max31827_debugfs_remove(void *dir)
+{
+	debugfs_remove_recursive(dir);
+}
+
+static int max31827_init_debugfs(struct max31827_state *st,
+				 struct i2c_client *client)
+{
+	struct dentry *debugfs;
+	int ret, i;
+
+	debugfs = debugfs_create_dir(client->name, NULL);
+	if (!debugfs)
+		return -ENOENT;
+
+	for (i = 0; i < MAX31827_DEBUGFS_NUM_ENTRIES; ++i)
+		st->psu.debugfs_entries[i] = i;
+
+	ret = devm_add_action_or_reset(&client->dev, max31827_debugfs_remove,
+				       debugfs);
+	if (ret)
+		return ret;
+
+	debugfs_create_file("timeout", 0644, debugfs,
+			    &st->psu.debugfs_entries[MAX31827_DEBUGFS_TIMEOUT],
+			    &max31827_fops);
+	debugfs_create_file("resolution", 0644, debugfs,
+			    &st->psu.debugfs_entries[MAX31827_DEBUGFS_RESOLUTION],
+			    &max31827_fops);
+	debugfs_create_file("alarm_polarity", 0644, debugfs,
+			    &st->psu.debugfs_entries[MAX31827_DEBUGFS_ALARM_POLARITY],
+			    &max31827_fops);
+	debugfs_create_file("comp_int", 0644, debugfs,
+			    &st->psu.debugfs_entries[MAX31827_DEBUGFS_COMP_INT],
+			    &max31827_fops);
+	debugfs_create_file("fault_queue", 0644, debugfs,
+			    &st->psu.debugfs_entries[MAX31827_DEBUGFS_FAULT_QUEUE],
+			    &max31827_fops);
+	debugfs_create_file("pec_error", 0444, debugfs,
+			    &st->psu.debugfs_entries[MAX31827_DEBUGFS_PEC_ERROR],
+			    &max31827_fops);
+
+	return 0;
+}
+#else
+static int max31827_init_debugfs(struct max31827_state *st,
+				 struct i2c_client *client)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_FS */
+
 static int max31827_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -698,7 +890,13 @@ static int max31827_probe(struct i2c_client *client)
 							 &max31827_chip_info,
 							 max31827_groups);
 
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	if (IS_ERR(hwmon_dev))
+		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
+				     "Failed to register device");
+
+	max31827_init_debugfs(st, client);
+
+	return 0;
 }
 
 static const struct of_device_id max31827_of_match[] = {
-- 
2.34.1


