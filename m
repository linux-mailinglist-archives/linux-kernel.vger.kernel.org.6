Return-Path: <linux-kernel+bounces-190323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47A8CFCE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD821C2194A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0913A3FC;
	Mon, 27 May 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="liET+FTP"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870973B79F;
	Mon, 27 May 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802230; cv=none; b=nlOaVwRd4JYGBe/NsL7iCWh48r5LfqdsWT2wocTA845ANlPaL5zAMLRFWDepTlXzas1N0DBH+9+nVvqsKso36EKe5q7mqWbdQ/s+zkv8yOtLf7LJqmnVhmTFdVRL+pbadWG9CkWu/kilm1XBWTlOpwhVv3wj+YWA39Vp3wOUFvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802230; c=relaxed/simple;
	bh=j46PnwFGIjwfKrPkQohHnCw9GlnNH915/OdzLM+EKxM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Or8htlfkpPctg3DTsd6RIemijV1Qdgz/JWci1dB2MZoPNT5SvmY6CTJngfw6zMYUen8fbVlk9qg2ZC7TGV7k7FGqA23/BZBtJlJ4LCLyLx4VhAL+7KGR7XNHBZIEDbwi78RAqLxvrNTurnNXx+YeXUc4D2I6pluZsX+pSxBkGvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=liET+FTP; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R8Bsnj013587;
	Mon, 27 May 2024 05:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=COaWAn4zkH3eoeXQxnwPb3tvK1q
	yqTv7O9wQvouZ3Tk=; b=liET+FTPWoz7HwNoWYis7l8NBm5pZ19jlVBAixIJTDR
	HUQkcHiOIgX7iqmZaDbPWySzPpCRLuXA6ELxTvY7y0qGgDczIJx3qCAnDPnog2BK
	OomQEM79XQK4aNV3X83RI0D4mbNuRZEdV1vGjxre9eVMExkFLWjiF6AkVRw/eIqY
	9NK/ApALsZlsVMmayb05hU5ScDtQLqvxQay7ru6r8B0i+mBkx9ASHiERwe5QxdiB
	G6RXWr5GWqZ0NOBd8eJKe97bWXhPD66K0Bk4cg/kj5CrKU3YtAnAlEWm5XA5CcQW
	m2SwIWCjtE42+ofSUZOztnOJUANYm/qyOgC7adqRz2g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ybcw25s5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 05:30:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44R9U7un046826
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 May 2024 05:30:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 May
 2024 05:30:06 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 May 2024 05:30:06 -0400
Received: from radu.ad.analog.com ([10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44R9TrPZ006193;
	Mon, 27 May 2024 05:29:56 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH v4] drivers: hwmon: max31827: Add PEC support
Date: Mon, 27 May 2024 12:29:47 +0300
Message-ID: <20240527092947.4370-1-radu.sabau@analog.com>
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
X-Proofpoint-ORIG-GUID: ylmytddwowMI5yZCFZHKo--NJNEG6diu
X-Proofpoint-GUID: ylmytddwowMI5yZCFZHKo--NJNEG6diu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405270077

Add support for PEC by attaching PEC attribute to the i2c device.
Add pec_store and pec_show function for accessing the "pec" file.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
Change log:
v2:
 *Rebase on top of v6.9
 *Attach pec attribute only to i2c device
 *Fix bug to attach pec attribute to i2c device if the device supports it.
v3:
 *Use only one variable to write PEC_EN bit in configuration register
 *Use regmap_set_bits to set PEC_EN bit when requested instead of
  regmap_update_bits.
 *Fix typo in commit message.
v4:
 *Use regmap_clear_bits to clear PEC_EN bit when requested instead of
  regmap_update_bits.
---
 Documentation/hwmon/max31827.rst | 13 +++++--
 drivers/hwmon/max31827.c         | 62 ++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 3 deletions(-)

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
index f8a13b30f100..c120032582ac 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -24,6 +24,7 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
 #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
 #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
@@ -475,6 +476,52 @@ static ssize_t temp1_resolution_store(struct device *dev,
 
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
+		err = regmap_clear_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+					MAX31827_CONFIGURATION_PEC_EN_MASK);
+		if (err)
+			return err;
+
+		client->flags &= ~I2C_CLIENT_PEC;
+		break;
+	case 1:
+		err = regmap_set_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+				      MAX31827_CONFIGURATION_PEC_EN_MASK);
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
@@ -578,6 +625,11 @@ static int max31827_init_client(struct max31827_state *st,
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
@@ -627,6 +679,16 @@ static int max31827_probe(struct i2c_client *client)
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


