Return-Path: <linux-kernel+bounces-530851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A81BEA43953
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 997063AAA42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2461B266B62;
	Tue, 25 Feb 2025 09:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vYDtFzib"
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD6266577;
	Tue, 25 Feb 2025 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474926; cv=none; b=UN4DESYGikFkzvrMCjRhy8pKvjAt1gYfINfhDTFQj9T2KePHWiA7As/XKSpRGf7tIUxZ2d7pgWMq13818ZVYhv5MikQAkZ125J41Vl0++CagDssZL6Qv2yHEV//u9FsymnuUEgeEyMJvy+1INm/iVRtTpJlglr3DfFXn5pjySQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474926; c=relaxed/simple;
	bh=LB4YsfToFr8m2tj7regQWa5LvzlGwsx5Gm1AYSd+I6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o8YfQ2t8cb6Isgs4ohOitsFLlAukjPKVhJ0W93eXj0RAUrGE1TtXwyGB97U5vQgRF/DMCTgyCcLKQsxs/dEiwA7Mv2DyNVeDyJ0hoC09R9pwcTDlK9O5SWImYEzmwSQAdaxLtc+bwwu4ZAwE7YZt6+p4z+b+Z+NeVFwLpvFZ6bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vYDtFzib; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8B3Gd014630;
	Tue, 25 Feb 2025 04:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q7FU3
	mJc8b+NepCFT6Jnh0XD4ZecHnRascaluQTYmGw=; b=vYDtFzibNpynv3o4wvITY
	szyasuYXXps9G2ldcCncB7o3XTqF5B78pkvhBx+M0hvc+yTeMz8Bphp76NZFrWh2
	zX0OiPUi1+JYcXgWAs6jNo2BEqGuJyj7qFqqhCZ6wEyRkKyaZ0gjh5GS+i37iGk1
	9VeEVzcvdbLVOSDLc8CSatMkRxUiC0T+ItX8quzF+H6AYwfl8V1ehXbULWiQzy2E
	ixbjbz9mICa7Eg8llMLPpR0HIczLa+HIA2UPYkZjEoW3G3ZMxEYPVxP2FqCN+KK6
	Nqfl8UMwHLODKpdHcToHmd3pnDFZwMBa90UXmnSgrh+kpUXILXPJIn32etFV+Ecw
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 451a4kra8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 04:15:13 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51P9F9Wj003900
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 25 Feb 2025 04:15:09 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Feb 2025 04:15:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 25 Feb 2025 04:15:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 25 Feb 2025 04:15:08 -0500
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.116.45.25])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51P9EofA011564;
	Tue, 25 Feb 2025 04:15:01 -0500
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Tue, 25 Feb 2025 17:08:34 +0800
Subject: [PATCH 2/2] regulator: adp5055: Add driver for adp5055
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250225-upstream-adp5055-v1-2-a5a7f8e46986@analog.com>
References: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
In-Reply-To: <20250225-upstream-adp5055-v1-0-a5a7f8e46986@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Alexis
 Czezar Torreno" <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740474891; l=17136;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=LB4YsfToFr8m2tj7regQWa5LvzlGwsx5Gm1AYSd+I6c=;
 b=jWN1FM853xcMaciEOqvv37izzbJxzLGuKKO5C94Dn5DXvoeWFlUsurTSnh2n/tA0K+bJ4xIuc
 2QO/YOZYOxHCvjMdF01qX1f2jtYCygYgqFi/EgkYZGU443IvOBdCQS2
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _1alP-tL-N4D1uM6JJfdFHlBHdPg6bcj
X-Authority-Analysis: v=2.4 cv=cK4askeN c=1 sm=1 tr=0 ts=67bd8a21 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=TZCsTV-SBRFodM4dN0cA:9 a=QEXdDO2ut3YA:10
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: _1alP-tL-N4D1uM6JJfdFHlBHdPg6bcj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250063

Add ADI ADP5055 driver support. The device consists
of 3 buck regulators able to connect to high input voltages of up to 18V
with no preregulators.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 MAINTAINERS                           |   1 +
 drivers/regulator/Kconfig             |  11 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/adp5055-regulator.c | 490 ++++++++++++++++++++++++++++++++++
 4 files changed, 503 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2ec43f84d84765c319d8403fb5650afa273db83..7ac35d895b4c8297c6de70cd2bfaec516ff5b100 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1530,6 +1530,7 @@ M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/regulator/adi,adp5055-regulator.yaml
+F:	drivers/regulator/adp5055-regulator.c
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d8177193e51c99bc2b360c6d9936e62fe..2378559b3ca12e77db263418144e9b8598eb97e0 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -122,6 +122,17 @@ config REGULATOR_AD5398
 	  This driver supports AD5398 and AD5821 current regulator chips.
 	  If building into module, its name is ad5398.ko.
 
+config REGULATOR_ADP5055
+	tristate "Analog Devices ADP5055 Triple Buck Regulator"
+	depends on I2C
+        select REGMAP_I2C
+	help
+	  This driver controls an Analog Devices ADP5055 with triple buck
+          regulators using an I2C interface.
+
+	  Say M here if you want to include support for the regulator as a
+	  module.
+
 config REGULATOR_ANATOP
 	tristate "Freescale i.MX on-chip ANATOP LDO regulators"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a0556ba9557fa069c6e37593b3c69..71f45d9317d24e7081ac919eb31efff6652edf3f 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_REGULATOR_AB8500)	+= ab8500-ext.o ab8500.o
 obj-$(CONFIG_REGULATOR_ACT8865) += act8865-regulator.o
 obj-$(CONFIG_REGULATOR_ACT8945A) += act8945a-regulator.o
 obj-$(CONFIG_REGULATOR_AD5398) += ad5398.o
+obj-$(CONFIG_REGULATOR_ADP5055) += adp5055-regulator.o
 obj-$(CONFIG_REGULATOR_ANATOP) += anatop-regulator.o
 obj-$(CONFIG_REGULATOR_ARIZONA_LDO1) += arizona-ldo1.o
 obj-$(CONFIG_REGULATOR_ARIZONA_MICSUPP) += arizona-micsupp.o
diff --git a/drivers/regulator/adp5055-regulator.c b/drivers/regulator/adp5055-regulator.c
new file mode 100644
index 0000000000000000000000000000000000000000..3b99c1b2fcbbeb1ad8c13886da242a45c90cf26f
--- /dev/null
+++ b/drivers/regulator/adp5055-regulator.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regulator driver for Analog Devices ADP5055
+ *
+ * Copyright (C) 2025 Analog Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+/*
+ * ADP5055 Register Map.
+ */
+#define ADP5055_CTRL123         0xD1
+#define ADP5055_CTRL_MODE1      0xD3
+#define ADP5055_CTRL_MODE2      0xD4
+#define ADP5055_DLY0            0xD5
+#define ADP5055_DLY1            0xD6
+#define ADP5055_DLY2            0xD7
+#define ADP5055_VID0            0xD8
+#define ADP5055_VID1            0xD9
+#define ADP5055_VID2            0xDA
+#define ADP5055_DVS_LIM0        0xDC
+#define ADP5055_DVS_LIM1        0xDD
+#define ADP5055_DVS_LIM2        0xDE
+#define ADP5055_FT_CFG          0xDF
+#define ADP5055_PG_CFG          0xE0
+
+/*
+ * ADP5055 Field Masks.
+ */
+#define	ADP5055_MASK_EN_MODE		BIT(0)
+#define	ADP5055_MASK_OCP_BLANKING	BIT(7)
+#define	ADP5055_MASK_PSM2		BIT(6)
+#define	ADP5055_MASK_PSM1		BIT(5)
+#define	ADP5055_MASK_PSM0		BIT(4)
+#define	ADP5055_MASK_DIS2		BIT(2)
+#define	ADP5055_MASK_DIS1		BIT(1)
+#define	ADP5055_MASK_DIS0		BIT(0)
+#define	ADP5055_MASK_DIS_DLY		GENMASK(6, 4)
+#define	ADP5055_MASK_EN_DLY		GENMASK(2, 0)
+#define	ADP5055_MASK_DVS_LIM_UPPER	GENMASK(7, 4)
+#define	ADP5055_MASK_DVS_LIM_LOWER	GENMASK(3, 0)
+#define	ADP5055_MASK_FAST_TRANSIENT2	GENMASK(5, 4)
+#define	ADP5055_MASK_FAST_TRANSIENT1	GENMASK(3, 2)
+#define	ADP5055_MASK_FAST_TRANSIENT0	GENMASK(1, 0)
+#define	ADP5055_MASK_DLY_PWRGD		BIT(4)
+#define	ADP5055_MASK_PWRGD2		BIT(2)
+#define	ADP5055_MASK_PWRGD1		BIT(1)
+#define	ADP5055_MASK_PWRGD0		BIT(0)
+
+#define	ADP5055_MIN_VOUT		408000
+#define ADP5055_NUM_CH			3
+
+struct adp5055 {
+	struct regmap *regmap;
+	struct gpio_descs *hw_en_array_gpios;
+};
+
+static const unsigned int adp5055_tset_vals[] = {
+	2600,
+	20800,
+};
+
+static const unsigned int adp5055_disable_delay_vals_2_6[] = {
+	0,
+	5200,
+	10400,
+	15600,
+	20800,
+	26000,
+	31200,
+	36400,
+};
+
+static const unsigned int adp5055_disable_delay_vals_20_8[] = {
+	0,
+	41600,
+	83200,
+	124800,
+	166400,
+	208000,
+	249600,
+	291200,
+};
+
+static const unsigned int adp5055_enable_delay_vals_2_6[] = {
+	0,
+	2600,
+	5200,
+	7800,
+	10400,
+	13000,
+	15600,
+	18200,
+};
+
+static const unsigned int adp5055_enable_delay_vals_20_8[] = {
+	0,
+	20800,
+	41600,
+	62400,
+	83200,
+	104000,
+	124800,
+	145600,
+};
+
+static const char * const adp5055_fast_transient_vals[] = {
+	"none",
+	"3G_1.5%",
+	"5G_1.5%",
+	"5G_2.5%",
+};
+
+static int adp5055_get_prop_index(const u32 *table, size_t table_size,
+				  u32 value)
+{
+	int i;
+
+	for (i = 0; i < table_size; i++)
+		if (table[i] == value)
+			return i;
+
+	return -EINVAL;
+}
+
+static const struct regmap_range adp5055_reg_ranges[] = {
+	regmap_reg_range(0xD1, 0xE0),
+};
+
+static const struct regmap_access_table adp5055_write_ranges_table = {
+	.yes_ranges	= adp5055_reg_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(adp5055_reg_ranges),
+};
+
+static const struct regmap_access_table adp5055_read_ranges_table = {
+	.yes_ranges	= adp5055_reg_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(adp5055_reg_ranges),
+};
+
+static const struct regmap_config adp5055_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xFF,
+	.wr_table = &adp5055_write_ranges_table,
+	.rd_table = &adp5055_read_ranges_table,
+};
+
+static const struct linear_range adp5055_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(ADP5055_MIN_VOUT, 0, 255, 1500),
+};
+
+static int adp5055_parse_fw(struct device *dev, struct  adp5055 *adp5055)
+{
+	int i, ret;
+	struct regmap *regmap = adp5055->regmap;
+	int val;
+	u32 tset;
+	bool ocp_blanking;
+	bool power_saving_mode[ADP5055_NUM_CH];
+	bool output_discharge_function[ADP5055_NUM_CH];
+	u32 disable_delay[ADP5055_NUM_CH];
+	u32 enable_delay[ADP5055_NUM_CH];
+	int dvs_limit_upper[ADP5055_NUM_CH];
+	int dvs_limit_lower[ADP5055_NUM_CH];
+	u32 fast_transient[ADP5055_NUM_CH];
+	bool delay_power_good;
+	bool mask_power_good[ADP5055_NUM_CH];
+
+	tset = 2600;
+
+	adp5055->hw_en_array_gpios = devm_gpiod_get_array_optional(dev,
+				"adi,hw-en-array", GPIOD_OUT_LOW);
+	if (IS_ERR(adp5055->hw_en_array_gpios))
+		return dev_err_probe(dev, PTR_ERR(adp5055->hw_en_array_gpios),
+				     "Failed to get hw_en_array GPIOs\n");
+
+	if (!adp5055->hw_en_array_gpios)
+		if (adp5055->hw_en_array_gpios->ndescs != ADP5055_NUM_CH)
+			return dev_err_probe(dev, adp5055->hw_en_array_gpios->ndescs,
+				     "Invalid amount of channels described\n");
+
+	ret = device_property_read_u32(dev, "adi,tset-us", &tset);
+	if (!ret) {
+		ret = adp5055_get_prop_index(adp5055_tset_vals,
+					ARRAY_SIZE(adp5055_tset_vals), tset);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+				"Failed to initialize tset.");
+		tset = adp5055_tset_vals[ret];
+	}
+
+	ocp_blanking = device_property_read_bool(dev, "adi,ocp-blanking");
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &i);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to read reg value of child node");
+		if (i >= ADP5055_NUM_CH)
+			return dev_err_probe(dev, ret, "Child node exceeds channel count");
+
+		power_saving_mode[i] = fwnode_property_read_bool(child,
+						   "adi,power-saving-mode");
+
+		output_discharge_function[i] = fwnode_property_read_bool(child,
+			"adi,output-discharge-function");
+
+		ret = fwnode_property_read_u32(child, "adi,disable-delay-us",
+					   &disable_delay[i]);
+		if (!ret) {
+			if (tset == 2600)
+				ret = adp5055_get_prop_index(adp5055_disable_delay_vals_2_6,
+							ARRAY_SIZE(adp5055_disable_delay_vals_2_6),
+							disable_delay[i]);
+			else
+				ret = adp5055_get_prop_index(adp5055_disable_delay_vals_20_8,
+							ARRAY_SIZE(adp5055_disable_delay_vals_20_8),
+							disable_delay[i]);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+					"Failed to initialize disable-delay-us.");
+			disable_delay[i] = ret;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,enable-delay-us",
+					   &enable_delay[i]);
+		if (!ret) {
+			if (tset == 2600)
+				ret = adp5055_get_prop_index(adp5055_enable_delay_vals_2_6,
+							ARRAY_SIZE(adp5055_enable_delay_vals_2_6),
+							enable_delay[i]);
+			else
+				ret = adp5055_get_prop_index(adp5055_enable_delay_vals_20_8,
+							ARRAY_SIZE(adp5055_enable_delay_vals_20_8),
+							enable_delay[i]);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+					"Failed to initialize enable-delay-us.");
+			enable_delay[i] = ret;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,dvs-limit-upper-microvolt",
+					&dvs_limit_upper[i]);
+		if (ret)
+			dvs_limit_upper[i] = 192000;
+		else
+			if (dvs_limit_upper[i] > 192000 || dvs_limit_upper[i] < 12000)
+				return dev_err_probe(dev, dvs_limit_upper[i],
+					"Out of range - dvs-limit-upper-microvolt value.");
+
+		ret = fwnode_property_read_u32(child, "adi,dvs-limit-lower-microvolt",
+					&dvs_limit_lower[i]);
+		if (ret)
+			dvs_limit_lower[i] = -190500;
+		else
+			if (dvs_limit_lower[i] > -10500 || dvs_limit_lower[i] < -190500)
+				return dev_err_probe(dev, dvs_limit_lower[i],
+					"Out of range - dvs-limit-lower-microvolt value.");
+
+		ret = fwnode_property_match_string(child, "adi,fast-transient",
+							*adp5055_fast_transient_vals);
+		if (ret < 0)
+			fast_transient[i] = 3;
+		else
+			fast_transient[i] = ret;
+
+		mask_power_good[i] = fwnode_property_read_bool(child,
+						 "adi,mask-power-good");
+
+		val = FIELD_PREP(ADP5055_MASK_DIS_DLY, disable_delay[i]);
+		val |= FIELD_PREP(ADP5055_MASK_EN_DLY, enable_delay[i]);
+		ret = regmap_write(regmap, ADP5055_DLY0 + i, val);
+		if (ret)
+			return ret;
+
+		val = FIELD_PREP(ADP5055_MASK_DVS_LIM_UPPER,
+				DIV_ROUND_CLOSEST_ULL(192000 - dvs_limit_upper[i], 12000));
+		val |= FIELD_PREP(ADP5055_MASK_DVS_LIM_LOWER,
+				DIV_ROUND_CLOSEST_ULL(dvs_limit_lower[i] + 190500, 12000));
+		ret = regmap_write(regmap, ADP5055_DVS_LIM0 + i, val);
+		if (ret)
+			return ret;
+
+		i++;
+	};
+
+	delay_power_good = device_property_read_bool(dev,
+				    "adi,delay-power-good");
+
+	if (!adp5055->hw_en_array_gpios)
+		val = FIELD_PREP(ADP5055_MASK_EN_MODE, 1);
+	else
+		val = FIELD_PREP(ADP5055_MASK_EN_MODE, 0);
+	ret = regmap_write(regmap, ADP5055_CTRL_MODE1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADP5055_MASK_OCP_BLANKING, ocp_blanking);
+	val |= FIELD_PREP(ADP5055_MASK_PSM2, power_saving_mode[2]);
+	val |= FIELD_PREP(ADP5055_MASK_PSM1, power_saving_mode[1]);
+	val |= FIELD_PREP(ADP5055_MASK_PSM0, power_saving_mode[0]);
+	val |= FIELD_PREP(ADP5055_MASK_DIS2, output_discharge_function[2]);
+	val |= FIELD_PREP(ADP5055_MASK_DIS1, output_discharge_function[1]);
+	val |= FIELD_PREP(ADP5055_MASK_DIS0, output_discharge_function[0]);
+	ret = regmap_write(regmap, ADP5055_CTRL_MODE2, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADP5055_MASK_FAST_TRANSIENT2, fast_transient[2]);
+	val |= FIELD_PREP(ADP5055_MASK_FAST_TRANSIENT1, fast_transient[1]);
+	val |= FIELD_PREP(ADP5055_MASK_FAST_TRANSIENT0, fast_transient[0]);
+	ret = regmap_write(regmap, ADP5055_FT_CFG, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(ADP5055_MASK_DLY_PWRGD, delay_power_good);
+	val |= FIELD_PREP(ADP5055_MASK_PWRGD2, mask_power_good[2]);
+	val |= FIELD_PREP(ADP5055_MASK_PWRGD1, mask_power_good[1]);
+	val |= FIELD_PREP(ADP5055_MASK_PWRGD0, mask_power_good[0]);
+	ret = regmap_write(regmap, ADP5055_PG_CFG, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int adp5055_is_enabled(struct regulator_dev *dev)
+{
+	struct adp5055 *adp5055 = rdev_get_drvdata(dev);
+	int id, ret;
+	int mask;
+	int val_sw, val_hw;
+
+	id = rdev_get_id(dev);
+	mask = BIT(id);
+	ret = regmap_read(adp5055->regmap, ADP5055_CTRL_MODE1, &val_sw);
+	if (ret)
+		return ret;
+
+	if (!adp5055->hw_en_array_gpios)
+		return (val_sw & mask) != 0;
+
+	val_hw = gpiod_get_value_cansleep(adp5055->hw_en_array_gpios->desc[id]);
+
+	return val_hw;
+};
+
+static int adp5055_en_func(struct regulator_dev *dev, int en_val)
+{
+	struct adp5055 *adp5055 = rdev_get_drvdata(dev);
+	int id;
+	int mask;
+
+	id = rdev_get_id(dev);
+	mask = BIT(id);
+
+	if (!adp5055->hw_en_array_gpios)
+		return regmap_update_bits(adp5055->regmap, ADP5055_CTRL_MODE1, mask, en_val);
+
+	gpiod_set_value_cansleep(adp5055->hw_en_array_gpios->desc[id], en_val);
+
+	return 0;
+}
+
+static int adp5055_enable(struct regulator_dev *dev)
+{
+	return adp5055_en_func(dev, 1);
+}
+
+static int adp5055_disable(struct regulator_dev *dev)
+{
+	return adp5055_en_func(dev, 0);
+}
+
+static const struct regulator_ops adp5055_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.enable = adp5055_enable,
+	.disable = adp5055_disable,
+	.is_enabled = adp5055_is_enabled,
+};
+
+#define ADP5055_REG_(_name, _id, _ch, _ops)					\
+	[_id] = { \
+		.name = _name, \
+		.ops = _ops, \
+		.linear_ranges = adp5055_voltage_ranges, \
+		.n_linear_ranges = ARRAY_SIZE(adp5055_voltage_ranges), \
+		.vsel_reg = ADP5055_VID##_ch, \
+		.vsel_mask = GENMASK(7, 0), \
+		.enable_reg = ADP5055_CTRL123, \
+		.enable_mask = BIT(_ch), \
+		.owner = THIS_MODULE, \
+	}
+
+#define ADP5055_REG(_name, _id, _ch) \
+	ADP5055_REG_(_name, _id, _ch, &adp5055_ops)
+
+static const struct regulator_desc adp5055_regulators[] = {
+	ADP5055_REG("DCDC1", 0, 0),
+	ADP5055_REG("DCDC2", 1, 1),
+	ADP5055_REG("DCDC3", 2, 2),
+};
+
+static const struct of_device_id adp5055_dt_ids[] = {
+	{ .compatible = "adi,adp5055"},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adp5055_dt_ids);
+
+static int adp5055_probe(struct i2c_client *client)
+{
+	struct regulator_init_data *init_data;
+	struct device *dev = &client->dev;
+	struct adp5055 *adp5055;
+	int i, ret;
+
+	init_data = of_get_regulator_init_data(dev, client->dev.of_node,
+					       &adp5055_regulators[0]);
+	if (!init_data)
+		return -EINVAL;
+
+	adp5055 = devm_kzalloc(dev, sizeof(struct adp5055), GFP_KERNEL);
+	if (!adp5055)
+		return -ENOMEM;
+
+	adp5055->regmap = devm_regmap_init_i2c(client, &adp5055_regmap_config);
+	if (IS_ERR(adp5055->regmap))
+		return dev_err_probe(dev, PTR_ERR(adp5055->regmap), "Failed to allocate reg map");
+
+	ret = adp5055_parse_fw(dev, adp5055);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ADP5055_NUM_CH; i++) {
+		const struct regulator_desc *desc = &adp5055_regulators[i];
+		struct regulator_config config = { };
+		struct regulator_dev *rdev;
+
+		config.dev = dev;
+		config.driver_data = adp5055;
+		config.regmap = adp5055->regmap;
+		config.init_data = init_data;
+
+		rdev = devm_regulator_register(dev, desc, &config);
+		if (IS_ERR(rdev)) {
+			return dev_err_probe(dev, PTR_ERR(rdev),
+					"Failed to register %s\n", desc->name);
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id adp5055_of_match[] = {
+	{ .compatible = "adi,adp5055", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adp5055_of_match);
+
+static const struct i2c_device_id adp5055_ids[] = {
+	{ .name = "adp5055"},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, adp5055_ids);
+
+static struct i2c_driver adp5055_driver = {
+	.driver	= {
+		.name	= "adp5055",
+		.of_match_table = adp5055_of_match,
+	},
+	.probe		= adp5055_probe,
+	.id_table	= adp5055_ids,
+};
+module_i2c_driver(adp5055_driver);
+
+MODULE_DESCRIPTION("ADP5055 Voltage Regulator Driver");
+MODULE_AUTHOR("Alexis Czezar Torreno <alexisczezar.torreno@analog.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1


