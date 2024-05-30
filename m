Return-Path: <linux-kernel+bounces-195305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9EE8D4AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DFB9282C05
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56FE174EE1;
	Thu, 30 May 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xHSGWRVZ"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDF3174ED4;
	Thu, 30 May 2024 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068344; cv=none; b=PydOes8QRFt0BDLV2oPDja8uKexOHJenOafXqO7NSXRwrImiRAC+cY7oOV4Wemoy7KpBLf180guTVY7h+mi0FIqf360RYuw1Ouxc+9IgMg2WagonxXlf7hXQUjDuQeStVyfwgsGTBsI7Urg9JW/fEADbdpOvdGLCpc7biEkNEoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068344; c=relaxed/simple;
	bh=jQVnzAUuOiKydtGaCdk5k3Wo+voTKlo++AyxFkU5rAU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kE0bL/+JrVsjSwt0G4BbCPx8k3zSp42pvHWW4MigWLv/PMV3qn898H+uCUqkoi4+6FQKSKdH/bqZ5lYi5WWWj4+CM38VjaIFhbWxrvwIgWLoQulieU31jtpOnweGI/fJIfgbauHwmnu/GX2/IdG+WZq/IFV7UKQQEEUViuNIDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xHSGWRVZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U8hPlw030357;
	Thu, 30 May 2024 07:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=8R/jjHCQYhz79Z2NduZjhzneZYu
	jIUZE3Rkgee7+xtY=; b=xHSGWRVZIyN8KN0xExJeSOLEFHtWosmrAIvqQcx0y7a
	SOF2Tou641MdcCOBZiIs7Q+Z4kZ1znBFkJalMuRpmLZfBGLDr5NXESfSWWDoEczg
	IMd0uSUghUP4pzE4ydiGjqGz0Cz++TpwkLCnNEwBzy9uCk+08/PwfJnPS0mNo+jT
	oohjqAsAF47q4WN0lvBYj0EiiKLLOKEbB8BmKR9Zm1KqrsV88+YqRgkM0IgoT+de
	Ftwkzy8YfzmXDrASUFm7DvII1aMpcafzKnG5eARGfVrtuwSyMuFdHEBscVES/xki
	AUDLuf1t50PiaZDUq83+KfvClhqawThTdFtpePuUogw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yep6t8gtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 07:25:28 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 44UBPQN6063409
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 07:25:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 30 May 2024 07:25:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 30 May 2024 07:25:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 30 May 2024 07:25:25 -0400
Received: from radu.ad.analog.com ([10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44UBPEVs013499;
	Thu, 30 May 2024 07:25:17 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH v5] drivers: hwmon: max31827: Add PEC support
Date: Thu, 30 May 2024 14:25:05 +0300
Message-ID: <20240530112505.14831-1-radu.sabau@analog.com>
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
X-Proofpoint-ORIG-GUID: h6mLk5h_H1aZEa2BLnfWqmlx-320f5hr
X-Proofpoint-GUID: h6mLk5h_H1aZEa2BLnfWqmlx-320f5hr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_08,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300085

Add support for PEC by configuring chip accordingly to the hwmon core
PEC attribute handling.
Add chip_write function to be used by max31827_write when setting
the attribute.

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
v5:
 *Adapt driver to the new hwmon PEC attribute handling from the hwmon core.
---
 Documentation/hwmon/max31827.rst | 13 ++++++++++---
 drivers/hwmon/max31827.c         | 17 ++++++++++++++++-
 2 files changed, 26 insertions(+), 4 deletions(-)

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
index f8a13b30f100..4a5f86afd84e 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -24,6 +24,7 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
 #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
 #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
@@ -332,6 +333,18 @@ static int max31827_read(struct device *dev, enum hwmon_sensor_types type,
 	return ret;
 }
 
+static int max31827_chip_write(struct *regmap, u32 attr, long val)
+{
+	switch (attr) {
+	case hwmon_chip_pec:
+		return regmap_update_bits(regmap, MAX31827_CONFIGURATION_REG,
+					  MAX38127_CONFIGURATION_PEC_EN_MASK,
+					  val ? MAX38127_CONFIGURATION_PEC_EN_MASK : 0);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 			  u32 attr, int channel, long val)
 {
@@ -340,6 +353,8 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 	int ret;
 
 	switch (type) {
+	case hwmon_chip:
+		return max31827_chip_write(st->regmap, attr, val);
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_enable:
@@ -583,7 +598,7 @@ static const struct hwmon_channel_info *max31827_info[] = {
 					 HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM |
 					 HWMON_T_MAX | HWMON_T_MAX_HYST |
 					 HWMON_T_MAX_ALARM),
-	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL | HWMON_C_PEC),
 	NULL,
 };
 
-- 
2.34.1


