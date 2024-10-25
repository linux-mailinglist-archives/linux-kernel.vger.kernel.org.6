Return-Path: <linux-kernel+bounces-381635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28499B01D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D171F20F9C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD408202F61;
	Fri, 25 Oct 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rdyURk9x"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AC41FCC63;
	Fri, 25 Oct 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729857680; cv=none; b=XaZIhQXM+TrjLvX+lgVhfGbwonFl8YgKV/h6tIVVOovx8Fcr7rnx0+FGsn+zYMocR1CF0SMOE9UD66BmP5n3i0BZhT1IUcsw/YPR68fFNx3wGk3I8sF3aYDVWSs5hSqhLjWm85cyHyUjSICRFMVsKAIduyorlJX6OsHnaDKVIKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729857680; c=relaxed/simple;
	bh=Xwq50n+V+nbq2SxRfSKBGyiNep8tQiWQcDpBixVgR5A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuF3xFqOtWvkb8CGA6O01alaQs4JpGOigNmhunQY/7Yt1LoHsCrnwuWnPoPMeavPQfMJmbNIUQIhiHuLaNJy2cRwXBo79Zl24Qfs6G/fxDtny+xtz1cBB5LtTSQO+s4Yx3XDAIHMLNREHEoXFvvt8AwHsALkqdHb/CGY/1iD6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rdyURk9x; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8qVRr025978;
	Fri, 25 Oct 2024 08:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Rlgof
	i/bytYYUKaGfoesUoc7agBEX4UxcR/G9v4w6C8=; b=rdyURk9xOvQDWaPtmKHaQ
	oEKZ9aihIERiZKve6+50VgGn0hfUxOMxcm4O/KGLusNj1HH1r2dmgvn/ylhOBGNs
	du7UUbcW29ujdENAdZJZxL0NnBTsVkpSrPMM04irKADRYaPFXaF01fDjCUIpEHTh
	HeKsIUZi1PCpFCGcBqJvsnEMPmNW+SeeX8mZ+fbEW7YSIAniTA03kuzDj4MhoRVa
	Bwd+vsJop+GBuFW8sb7MExVd51y78rghr2MYKtv8MtLIQql52TBK0tGl4S8aUggd
	W3Dx2qL2pB07d5B01eUC+P5oe60Qy+BCfTNZOz+nl8wKYHNczt7tLO5NpVCfj+8b
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42g872rnmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 08:00:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49PC0r6E045702
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 25 Oct 2024 08:00:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Oct 2024 08:00:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 25 Oct 2024 08:00:52 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 25 Oct 2024 08:00:52 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.117])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49PC0XRu016585;
	Fri, 25 Oct 2024 08:00:49 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] hwmon: ltc4296-1: add driver support
Date: Fri, 25 Oct 2024 14:56:11 +0300
Message-ID: <20241025115624.21835-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241025115624.21835-1-antoniu.miclaus@analog.com>
References: <20241025115624.21835-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: p731O3EvCspAvC57Du136wSZ8clmRA12
X-Proofpoint-ORIG-GUID: p731O3EvCspAvC57Du136wSZ8clmRA12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250092

Add support for LTC4296-1 is an IEEE 802.3cg-compliant,
five port, single-pair power over Ethernet (SPoE), power
sourcing equipment (PSE) controller.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/hwmon/Kconfig     |  10 +
 drivers/hwmon/Makefile    |   1 +
 drivers/hwmon/ltc4296-1.c | 644 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 655 insertions(+)
 create mode 100644 drivers/hwmon/ltc4296-1.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08a3c863f80a..fc6c2a4f6029 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1095,6 +1095,16 @@ config SENSORS_LTC4282
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc4282.
 
+config SENSORS_LTC4296_1
+	tristate "Analog Devices LTC4296-1"
+	depends on SPI
+	help
+	  If you say yes here you get support for Analog Devices LTC4296-1
+	  5-Port SPoE PSE Controller.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc4296-1.
+
 config SENSORS_LTQ_CPUTEMP
 	bool "Lantiq cpu temperature sensor driver"
 	depends on SOC_XWAY
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 9554d2fdcf7b..943c6858dded 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_SENSORS_LTC4245)	+= ltc4245.o
 obj-$(CONFIG_SENSORS_LTC4260)	+= ltc4260.o
 obj-$(CONFIG_SENSORS_LTC4261)	+= ltc4261.o
 obj-$(CONFIG_SENSORS_LTC4282)	+= ltc4282.o
+obj-$(CONFIG_SENSORS_LTC4296_1)	+= ltc4296-1.o
 obj-$(CONFIG_SENSORS_LTQ_CPUTEMP) += ltq-cputemp.o
 obj-$(CONFIG_SENSORS_MAX1111)	+= max1111.o
 obj-$(CONFIG_SENSORS_MAX127)	+= max127.o
diff --git a/drivers/hwmon/ltc4296-1.c b/drivers/hwmon/ltc4296-1.c
new file mode 100644
index 000000000000..22651f166a36
--- /dev/null
+++ b/drivers/hwmon/ltc4296-1.c
@@ -0,0 +1,644 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Analog Devices Inc.
+ *
+ * Driver for the LTC4296_1 SPoE PSE.
+ *
+ * Author: Antoniu Miclaus <antoniu.miclaus@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+
+#include <linux/unaligned.h>
+
+#define LTC4296_1_REG_GFLTEV			0x02
+#define LTC4296_1_REG_GFLTMSK			0x03
+#define LTC4296_1_REG_GCAP			0x06
+#define LTC4296_1_REG_GIOST			0x07
+#define LTC4296_1_REG_GCMD			0x08
+#define LTC4296_1_REG_GCFG			0x09
+#define LTC4296_1_REG_GADCCFG			0x0A
+#define LTC4296_1_REG_GADCDAT			0x0B
+#define LTC4296_1_REG_P0EV			0x10
+#define LTC4296_1_REG_P0ST			0x12
+#define LTC4296_1_REG_P0CFG0			0x13
+#define LTC4296_1_REG_P0CFG1			0x14
+#define LTC4296_1_REG_P0ADCCFG			0x15
+#define LTC4296_1_REG_P0ADCDAT			0x16
+#define LTC4296_1_REG_P0SELFTEST		0x17
+#define LTC4296_1_REG_P1EV			0x20
+#define LTC4296_1_REG_P1ST			0x22
+#define LTC4296_1_REG_P1CFG0			0x23
+#define LTC4296_1_REG_P1CFG1			0x24
+#define LTC4296_1_REG_P1ADCCFG			0x25
+#define LTC4296_1_REG_P1ADCDAT			0x26
+#define LTC4296_1_REG_P1SELFTEST		0x27
+#define LTC4296_1_REG_P2EV			0x30
+#define LTC4296_1_REG_P2ST			0x32
+#define LTC4296_1_REG_P2CFG0			0x33
+#define LTC4296_1_REG_P2CFG1			0x34
+#define LTC4296_1_REG_P2ADCCFG			0x35
+#define LTC4296_1_REG_P2ADCDAT			0x36
+#define LTC4296_1_REG_P2SELFTEST		0x37
+#define LTC4296_1_REG_P3EV			0x40
+#define LTC4296_1_REG_P3ST			0x42
+#define LTC4296_1_REG_P3CFG0			0x43
+#define LTC4296_1_REG_P3CFG1			0x44
+#define LTC4296_1_REG_P3ADCCFG			0x45
+#define LTC4296_1_REG_P3ADCDAT			0x46
+#define LTC4296_1_REG_P3SELFTEST		0x47
+#define LTC4296_1_REG_P4EV			0x50
+#define LTC4296_1_REG_P4ST			0x52
+#define LTC4296_1_REG_P4CFG0			0x53
+#define LTC4296_1_REG_P4CFG1			0x54
+#define LTC4296_1_REG_P4ADCCFG			0x55
+#define LTC4296_1_REG_P4ADCDAT			0x56
+#define LTC4296_1_REG_P4SELFTEST		0x57
+
+/* LTC4296_1_REG_GFLTEV */
+#define LTC4296_1_UVLO_DIGITAL_MSK		BIT(4)
+#define LTC4296_1_COMMAND_FAULT_MSK		BIT(3)
+#define LTC4296_1_PEC_FAULT_MSK			BIT(2)
+#define LTC4296_1_MEMORY_FAULT_MSK		BIT(1)
+#define LTC4296_1_LOW_CKT_BRK_FAULT_MSK		BIT(0)
+
+/* LTC4296_1_REG_GCAP */
+#define LTC4296_1_SCCP_SUPPORT_MSK		BIT(6)
+#define LTC4296_1_WAKE_FWD_SUPPORT_MSK		BIT(5)
+#define LTC4296_1_NUMPORTS_MSK			GENMASK(4, 0)
+
+/* LTC4296_1_REG_GIOST */
+#define LTC4296_1_PG_OUT4_MSK			BIT(8)
+#define LTC4296_1_PG_OUT3_MSK			BIT(7)
+#define LTC4296_1_PG_OUT2_MSK			BIT(6)
+#define LTC4296_1_PG_OUT1_MSK			BIT(5)
+#define LTC4296_1_PG_OUT0_MSK			BIT(4)
+#define LTC4296_1_PAD_AUTO_MSK			BIT(3)
+#define LTC4296_1_PAD_WAKEUP_MSK		BIT(2)
+#define LTC4296_1_PAD_WAKEUP_DRIVE_MSK		BIT(1)
+
+/* LTC4296_1_REG_GCMD */
+#define LTC4296_1_SW_RESET_MSK			GENMASK(15, 8)
+#define LTC4296_1_WRITE_PROTECT_MSK		GENMASK(7, 0)
+
+/* LTC4296_1_REG_GCFG */
+#define LTC4296_1_MASK_LOWFAULT_MSK		BIT(5)
+#define LTC4296_1_TLIM_DISABLE_MSK		BIT(4)
+#define LTC4296_1_TLIM_TIMER_SLEEP_MSK		GENMASK(3, 2)
+#define LTC4296_1_REFRESH_MSK			BIT(1)
+#define LTC4296_1_SW_VIN_PGOOD_MSK		BIT(0)
+
+/* LTC4296_1_REG_GADCCFG */
+#define LTC4296_1_GADC_SAMPLE_MODE_MSK		GENMASK(6, 5)
+#define LTC4296_1_GADC_SEL_MSK			GENMASK(4, 0)
+
+/* LTC4296_1_REG_GADCDAT */
+#define LTC4296_1_GADC_MISSED_MSK		BIT(13)
+#define LTC4296_1_GADC_NEW_MSK			BIT(12)
+#define LTC4296_1_GADC_MSK			GENMASK(11, 0)
+
+/* LTC4296_1_REG_PXEV */
+#define LTC4296_1_VALID_SIGNATURE_MSK		BIT(9)
+#define LTC4296_1_INVALID_SIGNATURE_MSK		BIT(8)
+#define LTC4296_1_TOFF_TIMER_DONE_MSK		BIT(7)
+#define LTC4296_1_OVERLOAD_DETECTED_ISLEEP_MSK	BIT(6)
+#define LTC4296_1_OVERLOAD_DETECTED_IPOWER_MSK	BIT(5)
+#define LTC4296_1_MFVS_TIMEOUT_MSK		BIT(4)
+#define LTC4296_1_TINRUSH_TIMER_DONE_MSK	BIT(3)
+#define LTC4296_1_PD_WAKEUP_MSK			BIT(2)
+#define LTC4296_1_LSNS_FORWARD_FAULT_MSK	BIT(1)
+#define LTC4296_1_LSNS_REVERSE_FAULT_MSK	BIT(0)
+
+/* LTC4296_1_REG_PXST */
+#define LTC4296_1_DET_VHIGH_MSK			BIT(13)
+#define LTC4296_1_DET_VLOW_MSK			BIT(12)
+#define LTC4296_1_POWER_STABLE_HI_MSK		BIT(11)
+#define LTC4296_1_POWER_STABLE_LO_MSK		BIT(10)
+#define LTC4296_1_POWER_STABLE_MSK		BIT(9)
+#define LTC4296_1_OVERLOAD_HELD_MSK		BIT(8)
+#define LTC4296_1_PI_SLEEPING_MSK		BIT(7)
+#define LTC4296_1_PI_PREBIASED_MSK		BIT(6)
+#define LTC4296_1_PI_DETECTING_MSK		BIT(5)
+#define LTC4296_1_PI_POWERED_MSK		BIT(4)
+#define LTC4296_1_PI_DISCHARGE_EN_MSK		BIT(3)
+#define LTC4296_1_PSE_STATUS_MSK		GENMASK(2, 0)
+
+/* LTC4296_1_REG_PXCFG0 */
+#define LTC4296_1_SW_INRUSH_MSK			BIT(15)
+#define LTC4296_1_END_CLASSIFICATION_MSK	BIT(14)
+#define LTC4296_1_SET_CLASSIFICATION_MODE_MSK	BIT(13)
+#define LTC4296_1_DISABLE_DETECTION_PULLUP_MSK	BIT(12)
+#define LTC4296_1_TDET_DISABLE_MSK		BIT(11)
+#define LTC4296_1_FOLDBACK_DISABLE_MSK		BIT(10)
+#define LTC4296_1_SOFT_START_DISABLE_MSK	BIT(9)
+#define LTC4296_1_TOFF_TIMER_DISABLE_MSK	BIT(8)
+#define LTC4296_1_TMFVDO_TIMER_DISABLE_MSK	BIT(7)
+#define LTC4296_1_SW_PSE_READY_MSK		BIT(6)
+#define LTC4296_1_SW_POWER_AVAILABLE_MSK	BIT(5)
+#define LTC4296_1_UPSTREAM_WAKEUP_DISABLE_MSK	BIT(4)
+#define LTC4296_1_DOWNSTREAM_WAKEUP_DISABLE_MSK	BIT(3)
+#define LTC4296_1_SW_PSE_WAKEUP_MSK		BIT(2)
+#define LTC4296_1_HW_EN_MASK_MSK		BIT(1)
+#define LTC4296_1_SW_EN_MSK			BIT(0)
+
+/* LTC4296_1_REG_PXCFG1 */
+#define LTC4296_1_PREBIAS_OVERRIDE_GOOD_MSK	BIT(8)
+#define LTC4296_1_TLIM_TIMER_TOP_MSK		GENMASK(7, 6)
+#define LTC4296_1_TOD_TRESTART_TIMER_MSK	GENMASK(5, 4)
+#define LTC4296_1_TINRUSH_TIMER_MSK		GENMASK(3, 2)
+#define LTC4296_1_SIG_OVERRIDE_BAD_MSK		BIT(1)
+#define LTC4296_1_SIG_OVERRIDE_GOOD_MSK		BIT(0)
+
+/* LTC4296_1_REG_PXADCCFG */
+#define LTC4296_1_MFVS_THRESHOLD_MSK		GENMASK(7, 0)
+
+/* LTC4296_1_REG_PXADCDAT */
+#define LTC4296_1_MISSED_MSK			BIT(13)
+#define LTC4296_1_NEW_MSK			BIT(12)
+#define LTC4296_1_SOURCE_CURRENT_MSK		GENMASK(11, 0)
+
+/* Miscellaneous Definitions*/
+#define LTC4296_1_RESET_CODE			0x73
+#define LTC4296_1_UNLOCK_KEY			0x05
+#define LTC4296_1_LOCK_KEY			0xA0
+
+#define LTC4296_1_ADC_OFFSET			2049
+
+#define LTC4296_1_VGAIN				(35230 / 1000)
+#define LTC4296_1_IGAIN				(1 / 10)
+
+#define LTC4296_1_VMAX				1
+#define LTC4296_1_VMIN				0
+
+#define LTC4296_1_MAX_PORTS			5
+
+enum ltc4296_1_port {
+	LTC_PORT0,
+	LTC_PORT1,
+	LTC_PORT2,
+	LTC_PORT3,
+	LTC_PORT4,
+	LTC_NO_PORT
+};
+
+enum ltc4296_1_port_status {
+	LTC_PORT_DISABLED,
+	LTC_PORT_ENABLED
+};
+
+enum ltc4296_1_port_reg_offset_e {
+	LTC_PORT_EVENTS   = 0,
+	LTC_PORT_STATUS   = 2,
+	LTC_PORT_CFG0     = 3,
+	LTC_PORT_CFG1     = 4,
+	LTC_PORT_ADCCFG   = 5,
+	LTC_PORT_ADCDAT   = 6,
+	LTC_PORT_SELFTEST = 7
+};
+
+static u8 set_port_vout[LTC4296_1_MAX_PORTS] = {0x04, 0x06, 0x08, 0x0A, 0x0C};
+
+struct ltc4296_1_state {
+	struct spi_device *spi;
+	u32 r_sense_mohm[LTC4296_1_MAX_PORTS];
+	u8 data[5];
+};
+
+static u8 ltc4296_1_get_pec_byte(u8 data, u8 seed)
+{
+	u8 pec = seed;
+	u8 din, in0, in1, in2;
+	int bit;
+
+	for (bit = 7; bit >= 0; bit--) {
+		din = (data >> bit) & 0x01;
+		in0 = din ^ ((pec >> 7) & 0x01);
+		in1 = in0 ^ (pec & 0x01);
+		in2 = in0 ^ ((pec >> 1) & 0x01);
+		pec = (pec << 1);
+		pec &= ~(0x07);
+		pec = pec | in0 | (in1 << 1) | (in2 << 2);
+	}
+
+	return pec;
+}
+
+static int ltc4296_1_spi_write(struct ltc4296_1_state *st, unsigned int reg, u16 val)
+{
+	st->data[0] = reg << 1 | 0x0;
+	st->data[1] = ltc4296_1_get_pec_byte(st->data[0], 0x41);
+	st->data[2] = val >> 8;
+	st->data[3] = val & 0xFF;
+	st->data[4] = ltc4296_1_get_pec_byte(st->data[3],
+					     ltc4296_1_get_pec_byte(st->data[2], 0x41));
+
+	return spi_write(st->spi, &st->data[0], 5);
+}
+
+static int ltc4296_1_spi_read(struct ltc4296_1_state *st, unsigned int reg,
+			      u16 *val)
+{
+	int ret;
+	struct spi_transfer t = {0};
+
+	t.tx_buf = &st->data[0];
+	t.rx_buf = &st->data[0];
+	t.len = 5;
+
+	st->data[0] = reg << 1 | 0x1;
+	st->data[1] = ltc4296_1_get_pec_byte(st->data[0], 0x41);
+
+	ret = spi_sync_transfer(st->spi, &t, 1);
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be16(&st->data[2]);
+
+	return 0;
+}
+
+static int ltc4296_1_reset(struct ltc4296_1_state *st)
+{
+	int ret;
+
+	ret = ltc4296_1_spi_write(st, LTC4296_1_REG_GCMD, LTC4296_1_RESET_CODE);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	return 0;
+}
+
+static int ltc4296_1_get_port_addr(enum ltc4296_1_port port_no,
+				   enum ltc4296_1_port_reg_offset_e port_offset,
+				   u8 *port_addr)
+{
+	if (!port_addr)
+		return -EINVAL;
+
+	*port_addr = (((port_no + 1) << 4) + port_offset);
+
+	return 0;
+}
+
+static int ltc4296_1_read_gadc(struct ltc4296_1_state *st, int *port_voltage_mv)
+{
+	int ret;
+	u16 val16;
+
+	if (!st || !port_voltage_mv)
+		return -EINVAL;
+
+	ret = ltc4296_1_spi_read(st, LTC4296_1_REG_GADCDAT, &val16);
+	if (ret)
+		return ret;
+	if ((val16 & LTC4296_1_GADC_NEW_MSK) != LTC4296_1_GADC_NEW_MSK)
+		return -EINVAL;
+
+	/* A new ADC value is available */
+	*port_voltage_mv = (((val16 & LTC4296_1_GADC_MSK) - LTC4296_1_ADC_OFFSET) *
+			    LTC4296_1_VGAIN);
+
+	return 0;
+}
+
+static int ltc4296_1_read_port_current(struct ltc4296_1_state *st, enum ltc4296_1_port port_no,
+				       int *port_i_out_ma)
+{
+	int ret;
+	u8 port_addr = 0;
+	u16 val16;
+
+	if (!st || !port_i_out_ma || !st->r_sense_mohm[port_no])
+		return -EINVAL;
+
+	ret = ltc4296_1_get_port_addr(port_no, LTC_PORT_ADCDAT, &port_addr);
+	if (ret)
+		return ret;
+
+	ret = ltc4296_1_spi_read(st, port_addr, &val16);
+	if (ret)
+		return ret;
+
+	if ((val16 & LTC4296_1_NEW_MSK) == LTC4296_1_NEW_MSK)
+		/* A new ADC value is available */
+		*port_i_out_ma = (FIELD_GET(LTC4296_1_SOURCE_CURRENT_MSK, val16) - LTC4296_1_ADC_OFFSET)
+				  * 100 / st->r_sense_mohm[port_no];
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ltc4296_1_port_prebias(struct ltc4296_1_state *st, enum ltc4296_1_port port_no)
+{
+	int ret;
+	u8 port_addr = 0;
+
+	ret = ltc4296_1_get_port_addr(port_no, LTC_PORT_CFG1, &port_addr);
+	if (ret)
+		return ret;
+
+	return ltc4296_1_spi_write(st, port_addr, LTC4296_1_PREBIAS_OVERRIDE_GOOD_MSK |
+						FIELD_PREP(LTC4296_1_TINRUSH_TIMER_MSK, 2) |
+						LTC4296_1_SIG_OVERRIDE_GOOD_MSK);
+}
+
+static int ltc4296_1_port_en(struct ltc4296_1_state *st, enum ltc4296_1_port port_no)
+{
+	int ret;
+	u8 port_addr = 0;
+
+	ret = ltc4296_1_get_port_addr(port_no, LTC_PORT_CFG0, &port_addr);
+	if (ret)
+		return ret;
+
+	return ltc4296_1_spi_write(st, port_addr, (LTC4296_1_SW_EN_MSK |
+				 LTC4296_1_SW_POWER_AVAILABLE_MSK |
+				 LTC4296_1_SW_PSE_READY_MSK |
+				 LTC4296_1_TMFVDO_TIMER_DISABLE_MSK));
+}
+
+static int ltc4296_1_port_dis(struct ltc4296_1_state *st, enum ltc4296_1_port port_no)
+{
+	int ret;
+	u8 port_addr = 0;
+
+	ret = ltc4296_1_get_port_addr(port_no, LTC_PORT_CFG0, &port_addr);
+	if (ret)
+		return ret;
+
+	return ltc4296_1_spi_write(st, port_addr, 0);
+}
+
+static int ltc4296_1_force_port_pwr(struct ltc4296_1_state *st, enum ltc4296_1_port port_no)
+{
+	int ret;
+	u8 port_addr = 0;
+
+	if (!st)
+		return -EINVAL;
+
+	ret = ltc4296_1_get_port_addr(port_no, LTC_PORT_CFG0, &port_addr);
+	if (ret)
+		return ret;
+
+	return ltc4296_1_spi_write(st, port_addr,
+				 (LTC4296_1_SW_EN_MSK | LTC4296_1_SW_POWER_AVAILABLE_MSK |
+				  LTC4296_1_SW_PSE_READY_MSK | LTC4296_1_TMFVDO_TIMER_DISABLE_MSK));
+}
+
+static int ltc4296_1_set_gadc_vout(struct ltc4296_1_state *st, enum ltc4296_1_port port_no)
+{
+	u16 val16;
+
+	if (!st)
+		return -EINVAL;
+
+	/* LTC4296_1-1 Set global ADC to measure Port Vout GADCCFG=ContModeLowGain|VoutPort */
+	val16 = FIELD_PREP(LTC4296_1_GADC_SEL_MSK, set_port_vout[port_no]);
+	/* Set Continuous mode with LOW GAIN bit */
+	val16 = val16 | FIELD_PREP(LTC4296_1_GADC_SAMPLE_MODE_MSK, 2);
+
+	return ltc4296_1_spi_write(st, LTC4296_1_REG_GADCCFG, val16);
+}
+
+static int ltc4296_1_init(struct ltc4296_1_state *st)
+{
+	int ret;
+	u16 value;
+
+	ret = ltc4296_1_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ltc4296_1_spi_write(st, LTC4296_1_REG_GCMD, LTC4296_1_UNLOCK_KEY);
+	if (ret)
+		return ret;
+
+	ret = ltc4296_1_spi_read(st, LTC4296_1_REG_GCMD, &value);
+	if (ret)
+		return ret;
+
+	if (value != LTC4296_1_UNLOCK_KEY) {
+		dev_err_probe(&st->spi->dev, -EINVAL, "Device locked. Write Access is disabled\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t input_enable_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+	struct ltc4296_1_state *st = dev_get_drvdata(dev);
+	int ret;
+	bool val;
+
+	ret = kstrtobool(buf, &val);
+	if (ret)
+		return ret;
+
+	if (!val) {
+		ret = ltc4296_1_port_dis(st, channel);
+	} else {
+		ret = ltc4296_1_port_prebias(st, channel);
+		if (ret)
+			return ret;
+
+		ret = ltc4296_1_port_en(st, channel);
+	}
+
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static ssize_t input_enable_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+	struct ltc4296_1_state *st = dev_get_drvdata(dev);
+	int ret;
+	u8 port_addr = 0;
+	u16 val = 0;
+
+	ret = ltc4296_1_get_port_addr(channel, LTC_PORT_CFG0, &port_addr);
+	if (ret)
+		return ret;
+
+	ret = ltc4296_1_spi_read(st, port_addr, &val);
+	if (ret)
+		return ret;
+
+	if (val & LTC4296_1_SW_EN_MSK)
+		return sprintf(buf, "Port %d enabled.\n", channel);
+
+	return sprintf(buf, "Port %d disabled.\n", channel);
+}
+
+static ssize_t input_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+	struct ltc4296_1_state *st = dev_get_drvdata(dev);
+	int ret, data;
+
+	ret = ltc4296_1_port_prebias(st, channel);
+	if (ret)
+		return ret;
+
+	ret = ltc4296_1_force_port_pwr(st, channel);
+	if (ret)
+		return ret;
+
+	ret = ltc4296_1_set_gadc_vout(st, channel);
+	if (ret)
+		return ret;
+
+	fsleep(10000);
+
+	ret = ltc4296_1_read_gadc(st, &data);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d mV\n", data);
+}
+
+static ssize_t curr_input_show(struct device *dev, struct device_attribute *attr,
+			       char *buf)
+{
+	int channel = to_sensor_dev_attr(attr)->index;
+	struct ltc4296_1_state *st = dev_get_drvdata(dev);
+	int ret, data;
+
+	ret = ltc4296_1_read_port_current(st, channel, &data);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d mA\n", data);
+}
+
+static SENSOR_DEVICE_ATTR_RW(in0_input_enable, input_enable, 0);
+static SENSOR_DEVICE_ATTR_RW(in1_input_enable, input_enable, 1);
+static SENSOR_DEVICE_ATTR_RW(in2_input_enable, input_enable, 2);
+static SENSOR_DEVICE_ATTR_RW(in3_input_enable, input_enable, 3);
+static SENSOR_DEVICE_ATTR_RW(in4_input_enable, input_enable, 4);
+
+static SENSOR_DEVICE_ATTR_RO(in0_input, input, 0);
+static SENSOR_DEVICE_ATTR_RO(in1_input, input, 1);
+static SENSOR_DEVICE_ATTR_RO(in2_input, input, 2);
+static SENSOR_DEVICE_ATTR_RO(in3_input, input, 3);
+static SENSOR_DEVICE_ATTR_RO(in4_input, input, 4);
+
+static SENSOR_DEVICE_ATTR_RO(curr0_input, curr_input, 0);
+static SENSOR_DEVICE_ATTR_RO(curr1_input, curr_input, 1);
+static SENSOR_DEVICE_ATTR_RO(curr2_input, curr_input, 2);
+static SENSOR_DEVICE_ATTR_RO(curr3_input, curr_input, 3);
+static SENSOR_DEVICE_ATTR_RO(curr4_input, curr_input, 4);
+
+static struct attribute *ltc4296_1_attrs[] = {
+	&sensor_dev_attr_in0_input_enable.dev_attr.attr,
+	&sensor_dev_attr_in1_input_enable.dev_attr.attr,
+	&sensor_dev_attr_in2_input_enable.dev_attr.attr,
+	&sensor_dev_attr_in3_input_enable.dev_attr.attr,
+	&sensor_dev_attr_in4_input_enable.dev_attr.attr,
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_curr0_input.dev_attr.attr,
+	&sensor_dev_attr_curr1_input.dev_attr.attr,
+	&sensor_dev_attr_curr2_input.dev_attr.attr,
+	&sensor_dev_attr_curr3_input.dev_attr.attr,
+	&sensor_dev_attr_curr4_input.dev_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(ltc4296_1);
+
+static int ltc4296_1_probe(struct spi_device *spi)
+{
+	struct ltc4296_1_state *st;
+	struct device *hwmon_dev;
+	u32 val, addr;
+	int ret;
+
+	st = devm_kzalloc(&spi->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->spi = spi;
+
+	ret = devm_regulator_get_enable(dev, "vin");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable regulator\n");
+
+	device_for_each_child_node_scoped(&spi->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &addr);
+		if (ret < 0)
+			return ret;
+
+		if (addr > 4)
+			return -EINVAL;
+
+		ret = fwnode_property_read_u32(child,
+					       "shunt-resistor-micro-ohms",
+					       &val);
+
+		if (!ret) {
+			if (!val)
+				return dev_err_probe(&spi->dev, -EINVAL,
+						     "shunt resistor value cannot be zero\n");
+
+			st->r_sense_mohm[addr] = val;
+		}
+	}
+
+	ret = ltc4296_1_init(st);
+	if (ret)
+		return ret;
+
+	hwmon_dev = devm_hwmon_device_register_with_groups(&spi->dev,
+							   spi->modalias,
+							   st, ltc4296_1_groups);
+	return PTR_ERR_OR_ZERO(hwmon_dev);
+}
+
+static const struct spi_device_id ltc4296_1_id[] = {
+	{ "ltc4296-1", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ltc4296_1_id);
+
+static const struct of_device_id ltc4296_1_of_match[] = {
+	{ .compatible = "adi,ltc4296-1", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc4296_1_of_match);
+
+static struct spi_driver ltc4296_1_driver = {
+	.probe = ltc4296_1_probe,
+	.driver = {
+		.name = "ltc4296-1",
+		.of_match_table	= ltc4296_1_of_match,
+	},
+	.id_table = ltc4296_1_id,
+};
+module_spi_driver(ltc4296_1_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("LTC4296_1 SPoE PSE");
-- 
2.46.2


