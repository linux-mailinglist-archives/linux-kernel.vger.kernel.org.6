Return-Path: <linux-kernel+bounces-401374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A20069C195D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E751F21B73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03B31E25F9;
	Fri,  8 Nov 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ha+C9zBz"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD81E231C;
	Fri,  8 Nov 2024 09:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058585; cv=none; b=AIDZDrQBJaKECnKbwfY+15yjOBSTy87kihRzBsHyI3vBSOy2pLjQShoYyTkT1/UkBZVa6anIzdGYn0iMYz47OaGqQa2HwOEWlOKx80sghIxgfBuTMQWQDNSotjzaHhhXslrRGNPPpUKllmJhButb0G3/DBntQGj48WbX/JUxydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058585; c=relaxed/simple;
	bh=BAP0EbMY27dY1a+Kg4qYRdjeQqd8nmiWxYoCOprE1Gc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RL1gRI8IuMlfYuIiNr8nNcmVzhciKtZWnz0BuQa2CdBr/liaxFOrwRiS0jNcRR33H/h1EeEgSiiYoYf1q+KAvrCJVpXIhJzpedY985txdZKOA2nOfFdLhHMo7sD0MXWb7w0AOtQ2UQQ24D+SKgxvu03nG/MtzvN4vMkSc6TjYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ha+C9zBz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A84xUJ0031708;
	Fri, 8 Nov 2024 04:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=fd8Qf
	59pXLY/QSl8GpWlVGr38UYpKn+B1KgQHY0z3dA=; b=Ha+C9zBzHZjaPODvw0zpj
	rnLCJJwcdX7kZ0gRb3pA7gfVDVRvysfsgHkUimOqlid66pGOPBQPK40MUBGn+Zml
	q5IOdducfVEfqqeG3jOHBK8fV/JRyWgX2gkvvvPD7gVV8kuNaRDebm8jhTdx/Cv+
	pocavraL2oXiEIJIp9x/GacvEjnm487CZJJ15EWPmoTW9ZRqfbDSQNl4ietjknBb
	n8jiA6frooSgi7ZK2Vtrt0Mptrd3V8WPyOxyAXtYgnpWuDvw2IG8DoUosW1ZZGOV
	FFUiEHMWdAJPNybj5tlSK1V/VYG0TPXyaOBWYCvWV2Ir7KZBTsgR0dn7MK4VVHva
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42s6jd2gq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 04:36:07 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4A89a68c034340
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 8 Nov 2024 04:36:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 8 Nov 2024
 04:36:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 8 Nov 2024 04:36:06 -0500
Received: from RCALAM-L02.ad.analog.com (RCALAM-L02.ad.analog.com [10.117.222.43])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A89Zn5N026842;
	Fri, 8 Nov 2024 04:35:57 -0500
From: "Ramon Cristopher M. Calam" <ramoncristopher.calam@analog.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Cristopher Calam
	<ramoncristopher.calam@analog.com>
Subject: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
Date: Fri, 8 Nov 2024 17:35:43 +0800
Message-ID: <20241108093544.9492-2-ramoncristopher.calam@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: mPbyEMAGZ3bWIiPH14h2IdqPbcITRyFF
X-Proofpoint-GUID: mPbyEMAGZ3bWIiPH14h2IdqPbcITRyFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 impostorscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411080077

Add ADI LT8722 full bridge DC/DC converter driver.

Signed-off-by: Ramon Cristopher M. Calam <ramoncristopher.calam@analog.com>
---
 drivers/regulator/Kconfig            |  10 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/lt8722-regulator.c | 701 +++++++++++++++++++++++++++
 3 files changed, 712 insertions(+)
 create mode 100644 drivers/regulator/lt8722-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d8177..d88b050ce166 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -550,6 +550,16 @@ config REGULATOR_LP8788
 	help
 	  This driver supports LP8788 voltage regulator chip.
 
+config REGULATOR_LT8722
+	tristate "LT8722 ultracompact full bridge driver with SPI"
+	depends on SPI && OF
+	help
+	  This driver controls an Analog Devices LT8722 ultracompact 4A, 15V,
+	  full bridge driver with SPI interface.
+
+	  Say M here if you want to include support for the regulator as a
+	  module.
+
 config REGULATOR_LTC3589
 	tristate "LTC3589 8-output voltage regulator"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a..8f9e5aec74d2 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_REGULATOR_LP87565) += lp87565-regulator.o
 obj-$(CONFIG_REGULATOR_LP8788) += lp8788-buck.o
 obj-$(CONFIG_REGULATOR_LP8788) += lp8788-ldo.o
 obj-$(CONFIG_REGULATOR_LP8755) += lp8755.o
+obj-$(CONFIG_REGULATOR_LT8722) += lt8722-regulator.o
 obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
diff --git a/drivers/regulator/lt8722-regulator.c b/drivers/regulator/lt8722-regulator.c
new file mode 100644
index 000000000000..f5d378c0b1f2
--- /dev/null
+++ b/drivers/regulator/lt8722-regulator.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices LT8722 Ultracompact Full Bridge Driver with SPI driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/spi/spi.h>
+#include <linux/util_macros.h>
+
+/* Register map */
+#define LT8722_SPIS_COMMAND		0x00
+#define LT8722_SPIS_STATUS		0x01
+#define	LT8722_SPIS_DAC_ILIMN		0x02
+#define	LT8722_SPIS_DAC_ILIMP		0x03
+#define	LT8722_SPIS_DAC			0x04
+#define	LT8722_SPIS_OV_CLAMP		0x05
+#define	LT8722_SPIS_UV_CLAMP		0x06
+#define	LT8722_SPIS_AMUX		0x07
+
+/* Register masks */
+#define LT8722_SPIS_COMMAND_MASK	GENMASK(21, 0)
+#define LT8722_SPIS_STATUS_MASK		GENMASK(10, 0)
+#define LT8722_SPIS_DAC_ILIMN_MASK	GENMASK(8, 0)
+#define LT8722_SPIS_DAC_ILIMP_MASK	GENMASK(8, 0)
+#define LT8722_SPIS_DAC_MASK		GENMASK(31, 0)
+#define LT8722_SPIS_OV_CLAMP_MASK	GENMASK(3, 0)
+#define LT8722_SPIS_UV_CLAMP_MASK	GENMASK(3, 0)
+#define LT8722_SPIS_AMUX_MASK		GENMASK(6, 0)
+
+/* SPIS_COMMAND register bit masks */
+#define LT8722_EN_REQ_MASK		BIT(0)
+#define LT8722_SWEN_REQ_MASK		BIT(1)
+#define LT8722_SW_FRQ_SET_MASK		GENMASK(4, 2)
+#define LT8722_SW_FRQ_ADJ_MASK		GENMASK(6, 5)
+#define LT8722_SYS_DC_MASK		GENMASK(8, 7)
+#define LT8722_VCC_VREG_MASK		BIT(9)
+#define LT8722_SW_VC_IN_MASK		GENMASK(13, 11)
+#define LT8722_SPI_RST_MASK		BIT(14)
+#define LT8722_PWR_LIM_MASK		GENMASK(18, 15)
+
+#define LT8722_FAULTS_MASK		GENMASK(10, 5)
+#define LT8722_UV_OV_MASK		GENMASK(23, 20)
+#define LT8722_OC_MASK			BIT(5)
+#define LT8722_TSD_MASK			BIT(6)
+
+#define LT8722_CRC8_POLY		0x07
+#define LT8722_CRC_INIT			0x00
+
+#define LT8722_READ_CMD			0xF4
+#define LT8722_WRITE_CMD		0xF2
+#define LT8722_RW_CMD_SIZE		8
+#define LT8722_DATA_SIZE		4
+#define LT8722_DATA_POS			2
+#define LT8722_CRC_POS			6
+#define LT8722_ACK			0xA5
+#define LT8722_ACK_POS			7
+
+#define LT8722_DAC_VREF			2500000
+#define LT8722_DAC_BITS			25
+#define LT8722_ILIM_STEP		13280
+#define LT8722_RAMP_STEPS		5
+
+#define LT8722_MIN_DAC_CODE		0xFF000000
+#define LT8722_MAX_DAC_CODE		0x00FFFFFF
+#define LT8722_ILIMN_MIN_IOUT		-6786000
+#define LT8722_ILIMN_MAX_IOUT		-664640
+#define LT8722_ILIMP_MIN_IOUT		637440
+#define LT8722_ILIMP_MAX_IOUT		6800000
+#define LT8722_MIN_VOUT			-20000000
+#define LT8722_MAX_VOUT			20000000
+#define LT8722_MIN_IOUT			-6786000
+#define LT8722_MAX_IOUT			6800000
+
+DECLARE_CRC8_TABLE(lt8722_crc8_table);
+
+struct lt8722_chip_info {
+	struct spi_device *spi;
+	struct regulator_dev *rdev;
+	struct gpio_desc *en_gpio;
+	struct gpio_desc *swen_gpio;
+	int uv_clamp_uV;
+	int ov_clamp_uV;
+	int ilimn_uA;
+	int ilimp_uA;
+	int switch_freq_hz;
+	const char *switch_freq_adjust;
+	const char *duty_cycle_range;
+	int vcc_vreg_mV;
+	int peak_inductor_current_mA;
+	int power_limit_mW;
+};
+
+static const unsigned int lt8722_uv_clamp[] = {
+	-20000000,
+	-18750000,
+	-17500000,
+	-16250000,
+	-15000000,
+	-13750000,
+	-12500000,
+	-11250000,
+	-10000000,
+	-8750000,
+	-7500000,
+	-6250000,
+	-5000000,
+	-3750000,
+	-2500000,
+	-1250000,
+};
+
+static const unsigned int lt8722_ov_clamp[] = {
+	1250000,
+	2500000,
+	3750000,
+	5000000,
+	6250000,
+	7500000,
+	8750000,
+	10000000,
+	11250000,
+	12500000,
+	13750000,
+	15000000,
+	16250000,
+	17500000,
+	18750000,
+	20000000,
+};
+
+static const unsigned int lt8722_switch_freq[] = {
+	500000,
+	1000000,
+	1500000,
+	2000000,
+	2500000,
+	3000000,
+};
+
+static const char * const lt8722_switch_freq_adjust[] = {
+	"0%",
+	"15%",
+	"-15%",
+};
+
+static const char * const lt8722_duty_cycle_range[] = {
+	"20%-80%",
+	"15%-85%",
+	"10%-90%",
+};
+
+static const unsigned int lt8722_vcc_vreg[] = {
+	3100,
+	3400,
+};
+
+static const unsigned int lt8722_peak_inductor_current[] = {
+	252,
+	594,
+	936,
+	1278,
+	1620,
+	1962,
+	2304,
+	2646,
+};
+
+static const unsigned int lt8722_power_limit[] = {
+	2000,
+	0,
+	3000,
+	3500,
+};
+
+static s32 _lt8722_dac_to_uV(u32 dac_val)
+{
+	s64 tmp;
+
+	tmp = (s64)dac_val * LT8722_DAC_VREF;
+	tmp = 16 * div_s64(tmp, BIT(LT8722_DAC_BITS));
+
+	return tmp;
+}
+
+static s32 _lt8722_uV_to_dac(s32 uV)
+{
+	s64 tmp;
+
+	tmp = (s64)uV * BIT(LT8722_DAC_BITS);
+	tmp = div_s64(tmp, LT8722_DAC_VREF * 16);
+
+	return tmp;
+}
+
+static int lt8722_reg_read(struct spi_device *spi, u8 reg, u32 *val)
+{
+	int ret;
+	struct spi_transfer t;
+	u8 rx_buf[LT8722_RW_CMD_SIZE] = {0};
+	u8 tx_buf[LT8722_RW_CMD_SIZE] = {0};
+
+	tx_buf[0] = LT8722_READ_CMD;
+	tx_buf[1] = reg << 1;
+	tx_buf[2] = crc8(lt8722_crc8_table, tx_buf, 2, LT8722_CRC_INIT);
+
+	t.tx_buf = tx_buf;
+	t.rx_buf = rx_buf;
+	t.len = LT8722_RW_CMD_SIZE;
+
+	ret = spi_sync_transfer(spi, &t, 1);
+	if (ret < 0)
+		return ret;
+
+	if (rx_buf[LT8722_CRC_POS] != crc8(lt8722_crc8_table, rx_buf,
+				LT8722_CRC_POS, LT8722_CRC_INIT))
+		return -EIO;
+
+	if (rx_buf[LT8722_ACK_POS] != LT8722_ACK)
+		return -EIO;
+
+	*val = get_unaligned_be32(&rx_buf[LT8722_DATA_POS]);
+
+	return 0;
+}
+
+static int lt8722_reg_write(struct spi_device *spi, u8 reg, u32 val)
+{
+	int ret;
+	struct spi_transfer t;
+	u8 rx_buf[LT8722_RW_CMD_SIZE] = {0};
+	u8 tx_buf[LT8722_RW_CMD_SIZE] = {0};
+
+	tx_buf[0] = LT8722_WRITE_CMD;
+	tx_buf[1] = reg << 1;
+
+	put_unaligned_be32(val, &tx_buf[LT8722_DATA_POS]);
+
+	tx_buf[LT8722_CRC_POS] = crc8(lt8722_crc8_table, tx_buf, LT8722_CRC_POS,
+				      LT8722_CRC_INIT);
+
+	t.tx_buf = tx_buf;
+	t.rx_buf = rx_buf;
+	t.len = LT8722_RW_CMD_SIZE;
+
+	ret = spi_sync_transfer(spi, &t, 1);
+	if (ret < 0)
+		return ret;
+
+	if (rx_buf[LT8722_ACK_POS] != LT8722_ACK)
+		return -EIO;
+
+	return 0;
+}
+
+static int lt8722_reg_write_mask(struct spi_device *spi, u8 reg, u32 mask,
+				 u32 val)
+{
+	int ret;
+	u32 reg_val;
+
+	ret = lt8722_reg_read(spi, reg, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	reg_val = (reg_val & ~mask) | (val & mask);
+
+	return lt8722_reg_write(spi, reg, reg_val);
+}
+
+static int lt8722_set_voltage(struct regulator_dev *rdev, int min_uV,
+			      int max_uV, unsigned int *selector)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+
+	if (min_uV < LT8722_MIN_VOUT || max_uV > LT8722_MAX_VOUT)
+		return -EINVAL;
+
+	*selector = _lt8722_uV_to_dac(min_uV);
+
+	return lt8722_reg_write(chip->spi, LT8722_SPIS_DAC, *selector);
+}
+
+static int lt8722_get_voltage(struct regulator_dev *rdev)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+	int ret, dac_val;
+
+	ret = lt8722_reg_read(chip->spi, LT8722_SPIS_DAC, &dac_val);
+	if (ret < 0)
+		return ret;
+
+	dac_val = FIELD_GET(LT8722_SPIS_DAC_MASK, dac_val);
+
+	return _lt8722_dac_to_uV(dac_val);
+}
+
+static int lt8722_get_prop_index(const u32 *table, size_t table_size, u32 value)
+{
+	int i;
+
+	for (i = 0; i < table_size; i++)
+		if (table[i] == value)
+			break;
+
+	if (i == table_size)
+		return -EINVAL;
+
+	return i;
+}
+
+static int lt8722_parse_fw(struct lt8722_chip_info *chip,
+			   struct regulator_init_data *init_data)
+{
+	int ret;
+
+	/* Override the min_uV constraint with the minimum output voltage */
+	init_data->constraints.min_uV = LT8722_MIN_VOUT;
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,uv-clamp-microvolt",
+				       &chip->uv_clamp_uV);
+	if (!ret) {
+		ret = lt8722_get_prop_index(lt8722_uv_clamp,
+				ARRAY_SIZE(lt8722_uv_clamp), chip->uv_clamp_uV);
+		if (ret < 0)
+			return ret;
+
+		ret = lt8722_reg_write(chip->spi, LT8722_SPIS_UV_CLAMP, ret);
+		if (ret < 0)
+			return ret;
+
+		/* Override the min_uV constraint with the UV clamp value */
+		init_data->constraints.min_uV = chip->uv_clamp_uV;
+	}
+
+	/* Override the max_uV constraint with the maximum output voltage */
+	init_data->constraints.max_uV = LT8722_MAX_VOUT;
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,ov-clamp-microvolt",
+				       &chip->ov_clamp_uV);
+	if (!ret) {
+		ret = lt8722_get_prop_index(lt8722_ov_clamp,
+				ARRAY_SIZE(lt8722_ov_clamp), chip->ov_clamp_uV);
+		if (ret < 0)
+			return ret;
+
+		ret = lt8722_reg_write(chip->spi, LT8722_SPIS_OV_CLAMP, ret);
+		if (ret < 0)
+			return ret;
+
+		/* Override the max_uV constraint with the OV clamp value */
+		init_data->constraints.max_uV = chip->ov_clamp_uV;
+	}
+
+	/* Override the min_uA constraint with the minimum output current */
+	init_data->constraints.min_uA = LT8722_MIN_IOUT;
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,ilimn-microamp",
+				       &chip->ilimn_uA);
+	if (!ret) {
+		if (chip->ilimn_uA < LT8722_ILIMN_MIN_IOUT ||
+		    chip->ilimn_uA > LT8722_ILIMN_MAX_IOUT)
+			return -EINVAL;
+
+		ret = div_s64(chip->ilimn_uA, -LT8722_ILIM_STEP);
+
+		ret = lt8722_reg_write(chip->spi, LT8722_SPIS_DAC_ILIMN, ret);
+		if (ret < 0)
+			return ret;
+
+		/* Override the min_uA constraint with the ILIMN value */
+		init_data->constraints.min_uA = chip->ilimn_uA;
+	}
+
+	/* Override the max_uA constraint with the maximum output current */
+	init_data->constraints.max_uA = LT8722_MAX_IOUT;
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,ilimp-microamp",
+				       &chip->ilimp_uA);
+	if (!ret) {
+		if (chip->ilimp_uA < LT8722_ILIMP_MIN_IOUT ||
+		    chip->ilimp_uA > LT8722_ILIMP_MAX_IOUT)
+			return -EINVAL;
+
+		ret = div_s64(LT8722_MAX_IOUT - chip->ilimp_uA, LT8722_ILIM_STEP);
+
+		ret = lt8722_reg_write(chip->spi, LT8722_SPIS_DAC_ILIMP, ret);
+		if (ret < 0)
+			return ret;
+
+		/* Override the max_uA constraint with the ILIMP value */
+		init_data->constraints.max_uA = chip->ilimp_uA;
+	}
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,switch-frequency-hz",
+				       &chip->switch_freq_hz);
+	if (!ret) {
+		ret = lt8722_get_prop_index(lt8722_switch_freq,
+					    ARRAY_SIZE(lt8722_switch_freq),
+					    chip->switch_freq_hz);
+		if (ret < 0)
+			return ret;
+
+		ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+				LT8722_SW_FRQ_SET_MASK,
+				FIELD_PREP(LT8722_SW_FRQ_SET_MASK, ret));
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = device_property_match_property_string(&chip->spi->dev,
+			"adi,switch-frequency-adjust",
+			lt8722_switch_freq_adjust,
+			ARRAY_SIZE(lt8722_switch_freq_adjust));
+	if (ret >= 0) {
+		ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+				LT8722_SW_FRQ_ADJ_MASK,
+				FIELD_PREP(LT8722_SW_FRQ_ADJ_MASK, ret));
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = device_property_match_property_string(&chip->spi->dev,
+			"adi,duty-cycle-range", lt8722_duty_cycle_range,
+			ARRAY_SIZE(lt8722_duty_cycle_range));
+	if (ret >= 0) {
+		ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+				LT8722_SYS_DC_MASK,
+				FIELD_PREP(LT8722_SYS_DC_MASK, ret));
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,vcc-vreg-millivolt",
+				       &chip->vcc_vreg_mV);
+	if (!ret) {
+		ret = lt8722_get_prop_index(lt8722_vcc_vreg,
+				ARRAY_SIZE(lt8722_vcc_vreg), chip->vcc_vreg_mV);
+		if (ret < 0)
+			return ret;
+
+		ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+				LT8722_VCC_VREG_MASK,
+				FIELD_PREP(LT8722_VCC_VREG_MASK, ret));
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = device_property_read_u32(&chip->spi->dev,
+				       "adi,peak-inductor-current-milliamp",
+				       &chip->peak_inductor_current_mA);
+	if (!ret) {
+		ret = lt8722_get_prop_index(lt8722_peak_inductor_current,
+				ARRAY_SIZE(lt8722_peak_inductor_current),
+				chip->peak_inductor_current_mA);
+		if (ret < 0)
+			return ret;
+
+		ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+				LT8722_SW_VC_IN_MASK,
+				FIELD_PREP(LT8722_SW_VC_IN_MASK, ret));
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = device_property_read_u32(&chip->spi->dev, "adi,power-limit-milliwatt",
+				       &chip->power_limit_mW);
+	if (!ret) {
+		ret = lt8722_get_prop_index(lt8722_power_limit,
+					    ARRAY_SIZE(lt8722_power_limit),
+					    chip->power_limit_mW);
+		if (ret < 0)
+			return ret;
+
+		ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+				LT8722_PWR_LIM_MASK,
+				FIELD_PREP(LT8722_PWR_LIM_MASK, ret));
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int lt8722_enable(struct regulator_dev *rdev)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+
+	gpiod_set_value_cansleep(chip->en_gpio, 1);
+
+	return lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+			LT8722_EN_REQ_MASK,
+			FIELD_PREP(LT8722_EN_REQ_MASK, 0x1));
+}
+
+static int lt8722_disable(struct regulator_dev *rdev)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+
+	gpiod_set_value_cansleep(chip->en_gpio, 0);
+
+	return lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+			LT8722_EN_REQ_MASK,
+			FIELD_PREP(LT8722_EN_REQ_MASK, 0x0));
+}
+
+static int lt8722_is_enabled(struct regulator_dev *rdev)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+	int ret;
+	u32 reg_val;
+	bool en_req, en_pin;
+
+	ret = lt8722_reg_read(chip->spi, LT8722_SPIS_COMMAND, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	en_req = FIELD_GET(LT8722_EN_REQ_MASK, reg_val);
+	en_pin = gpiod_get_value(chip->en_gpio);
+
+	return en_req && en_pin;
+}
+
+static int lt8722_get_error_flags(struct regulator_dev *rdev,
+				  unsigned int *flags)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+	int ret;
+	u32 reg_val;
+
+	ret = lt8722_reg_read(chip->spi, LT8722_SPIS_STATUS, &reg_val);
+	if (ret < 0)
+		return ret;
+
+	*flags = 0;
+
+	if (FIELD_GET(LT8722_OC_MASK, reg_val))
+		*flags |= REGULATOR_ERROR_OVER_CURRENT;
+
+	if (FIELD_GET(LT8722_TSD_MASK, reg_val))
+		*flags |= REGULATOR_ERROR_OVER_TEMP;
+
+	return 0;
+}
+
+static int lt8722_set_soft_start(struct regulator_dev *rdev)
+{
+	struct lt8722_chip_info *chip = rdev_get_drvdata(rdev);
+	s32 dac_val;
+	int ret, i;
+
+	/* Clear faults before enabled VCC LDO and other device circuitry */
+	ret = lt8722_reg_write(chip->spi, LT8722_SPIS_STATUS, 0x0);
+	if (ret < 0)
+		return ret;
+
+	ret = lt8722_enable(rdev);
+	if (ret < 0)
+		return ret;
+
+	/* Configure output voltage control DAC to 0xFF000000 */
+	ret = lt8722_reg_write(chip->spi, LT8722_SPIS_DAC, LT8722_MIN_DAC_CODE);
+	if (ret < 0)
+		return ret;
+
+	/* Write all SPIS_STATUS register bits to 0 */
+	ret = lt8722_reg_write(chip->spi, LT8722_SPIS_STATUS, 0x0);
+	if (ret < 0)
+		return ret;
+
+	fsleep(1000);
+
+	/* Ramp the output voltage control DAC from 0xFF000000 to 0x00000000 */
+	for (i = 0; i < LT8722_RAMP_STEPS; i++) {
+		dac_val = LT8722_MIN_DAC_CODE + 0x400000 * i;
+
+		ret = lt8722_reg_write(chip->spi, LT8722_SPIS_DAC, dac_val);
+		if (ret < 0)
+			return ret;
+
+		fsleep(1000);
+	}
+
+	/* Enable the PWM switching behavior */
+	gpiod_set_value_cansleep(chip->swen_gpio, 1);
+
+	ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+			LT8722_SWEN_REQ_MASK,
+			FIELD_PREP(LT8722_SWEN_REQ_MASK, 0x1));
+	if (ret < 0)
+		return ret;
+
+	fsleep(160);
+
+	return 0;
+}
+
+static const struct regulator_ops lt8722_regulator_ops = {
+	.set_voltage = lt8722_set_voltage,
+	.get_voltage = lt8722_get_voltage,
+	.enable = lt8722_enable,
+	.disable = lt8722_disable,
+	.is_enabled = lt8722_is_enabled,
+	.set_soft_start = lt8722_set_soft_start,
+	.get_error_flags = lt8722_get_error_flags,
+};
+
+static struct regulator_desc lt8722_regulator_desc = {
+	.name = "lt8722",
+	.ops = &lt8722_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int lt8722_probe(struct spi_device *spi)
+{
+	struct regulator_init_data *init_data;
+	struct regulator_config config = { };
+	struct lt8722_chip_info *chip;
+	int ret;
+
+	init_data = of_get_regulator_init_data(&spi->dev, spi->dev.of_node,
+					       &lt8722_regulator_desc);
+	if (!init_data)
+		return -EINVAL;
+
+	chip = devm_kzalloc(&spi->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	crc8_populate_msb(lt8722_crc8_table, LT8722_CRC8_POLY);
+
+	chip->spi = spi;
+
+	chip->en_gpio = devm_gpiod_get(&spi->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(chip->en_gpio))
+		return PTR_ERR(chip->en_gpio);
+
+	chip->swen_gpio = devm_gpiod_get(&spi->dev, "switch-enable",
+			GPIOD_OUT_LOW);
+	if (IS_ERR(chip->swen_gpio))
+		return PTR_ERR(chip->swen_gpio);
+
+	ret = lt8722_reg_write_mask(chip->spi, LT8722_SPIS_COMMAND,
+			LT8722_SPI_RST_MASK,
+			FIELD_PREP(LT8722_SPI_RST_MASK, 0x1));
+	if (ret < 0)
+		return ret;
+
+	ret = lt8722_parse_fw(chip, init_data);
+	if (ret < 0)
+		return ret;
+
+	config.dev = &spi->dev;
+	config.init_data = init_data;
+	config.driver_data = chip;
+
+	chip->rdev = devm_regulator_register(&spi->dev, &lt8722_regulator_desc,
+					     &config);
+	if (IS_ERR(chip->rdev))
+		return PTR_ERR(chip->rdev);
+
+	return 0;
+}
+
+static const struct of_device_id lt8722_of_match[] = {
+	{ .compatible = "adi,lt8722", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lt8722_of_match);
+
+static const struct spi_device_id lt8722_id[] = {
+	{ "lt8722" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, lt8722_id);
+
+struct spi_driver lt8722_driver = {
+	.driver = {
+		.name = "lt8722",
+		.of_match_table = lt8722_of_match,
+	},
+	.probe = lt8722_probe,
+	.id_table = lt8722_id,
+};
+module_spi_driver(lt8722_driver);
+
+MODULE_AUTHOR("Ramon Cristopher Calam <ramoncristopher.calam@analog.com>");
+MODULE_DESCRIPTION("LT8722 ultracompact full bridge driver with SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.47.0


