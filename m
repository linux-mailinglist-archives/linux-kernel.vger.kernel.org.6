Return-Path: <linux-kernel+bounces-196499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6058D5D10
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6661F253E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F4155A23;
	Fri, 31 May 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nAOB4i1u"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F44E1C8;
	Fri, 31 May 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145248; cv=none; b=Q9k+3l/fcZZJO/9rFMwqF9HwbTJSmTYMbQOFuvDu+CCCoBoze8JzER4ELngHpLBcbJ2Ol81mVHS3oQ6nrSVJ1q6CAz+j7FgHXFkW05cEelEhFXLCRRl/ipF7Zg34A7R+Z6J4W9ET632ouznfKRrutwTqaplEbIIOZdPlUE9PUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145248; c=relaxed/simple;
	bh=puLHBzNZ26APQMzwfYvHHSHrulunZMrMo+MEGm1JwjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/eKZujJ7Bh6FUqI2Aew4awBR/fn+zOVj4GxtO/gwnLlHb8uY7wN2eOLhyNrQJUv5i+eMFkzbvCfyEzq9FAX0DEv5I7cvdXEmF3TDQ2vPOGy2WBuhxCmbTC1rtLFA3AdLxOgc7nMB5neU37cNnU0d0Pffchz2DEv7yYAQOAuinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nAOB4i1u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V80o2s031840;
	Fri, 31 May 2024 04:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=g1kRZ
	lNIOKNCVjWxqEE5O19ed4HqbyIxzVGl4/CiTpo=; b=nAOB4i1ubAHpVA6q8V6sd
	DRkhw/9D6VPCBKuZPWbhz0hokUCQA5WVq9+Laf9+bz4e9Jeq2U8cX6B5/tO2yTWA
	1bvsyXIcnZ9k6z9Xw8kPMWPRn1PgWX9XCCPdz/DeUONHgA3bS17e+MqBSn4E5c3L
	jCHdQXwpqXCqEEG0/Wsdg7eNw+zMSSFF3RuUe7CQpU7PWA9v5/FrV7W7e6sKBSKW
	ErLl/KO+tuOwbZ6RB3VjbK1JOylIGWpYiCvJ3p4fOx8YUaPwqThbZjtpQgvnwnq7
	y9CVXkU1uVvvYrNDj5KtNsEkCVq3TJFJkgk4Kj1WdtK/wJtZuesTgLwalkXRdR0x
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3yeddx6k7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:47:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44V8lB7X044918
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 31 May 2024 04:47:11 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 04:47:10 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 31 May 2024 04:47:10 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 31 May 2024 04:47:10 -0400
Received: from radu.ad.analog.com ([10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44V8kshe031459;
	Fri, 31 May 2024 04:47:06 -0400
From: Radu Sabau <radu.sabau@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-hwmon@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Radu Sabau <radu.sabau@analog.com>
Subject: [PATCH v6 2/2] drivers: hwmon: max31827: Add PEC support
Date: Fri, 31 May 2024 11:46:44 +0300
Message-ID: <20240531084645.12935-2-radu.sabau@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531084645.12935-1-radu.sabau@analog.com>
References: <20240531084645.12935-1-radu.sabau@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ZR_1fOSEMhxZW_gt8hhdnT9LNNr8S_Kz
X-Proofpoint-ORIG-GUID: ZR_1fOSEMhxZW_gt8hhdnT9LNNr8S_Kz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405310064

Add support for PEC by configuring the chip accordingly to the hwmon core PEC
attribute handling
Handle hwmon_chip_pec attribute writing in the max31827_write in the
hwmon_chip type switch case, approaching the same code structure
as for temp writing.

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
v6:
 *Apply patch containing hwmon core code and rebase driver PEC patch on top
  of it.
 *Handle hwmon_chip_pec attribute write in the max31827_write function, the same
  way temp writes are handled, therefore remove the max31827_chip_write function
 *Fix typos.
---
 Documentation/hwmon/max31827.rst | 13 ++++++++++---
 drivers/hwmon/max31827.c         | 18 ++++++++++++------
 2 files changed, 22 insertions(+), 9 deletions(-)

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
index f8a13b30f100..4d89b6a7060b 100644
--- a/drivers/hwmon/max31827.c
+++ b/drivers/hwmon/max31827.c
@@ -24,6 +24,7 @@
 
 #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
 #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
+#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
 #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
 #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
 #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
@@ -382,7 +383,8 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 		}
 
 	case hwmon_chip:
-		if (attr == hwmon_chip_update_interval) {
+		switch (attr) {
+		case hwmon_chip_update_interval:
 			if (!st->enable)
 				return -EINVAL;
 
@@ -410,14 +412,18 @@ static int max31827_write(struct device *dev, enum hwmon_sensor_types type,
 				return ret;
 
 			st->update_interval = val;
-		}
-		break;
 
+			return 0;
+		case hwmon_chip_pec:
+			return regmap_update_bits(st->regmap, MAX31827_CONFIGURATION_REG,
+						  MAX31827_CONFIGURATION_PEC_EN_MASK,
+						  val ? MAX31827_CONFIGURATION_PEC_EN_MASK : 0);
+		default:
+			return -EOPNOTSUPP;
+		}
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return 0;
 }
 
 static ssize_t temp1_resolution_show(struct device *dev,
@@ -583,7 +589,7 @@ static const struct hwmon_channel_info *max31827_info[] = {
 					 HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM |
 					 HWMON_T_MAX | HWMON_T_MAX_HYST |
 					 HWMON_T_MAX_ALARM),
-	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
+	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL | HWMON_C_PEC),
 	NULL,
 };
 
-- 
2.34.1


