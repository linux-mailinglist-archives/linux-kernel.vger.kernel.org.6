Return-Path: <linux-kernel+bounces-344522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9B98AAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969D11C219EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A21198E77;
	Mon, 30 Sep 2024 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="y4SJp+iG"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622AF5103F;
	Mon, 30 Sep 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716305; cv=none; b=bMA5ZN+Cc14NTsfcZjzooC0DobtqkFXpguWQsQkIIfMG7z9HFqZqgP2FKZ4WiGG/FXHdoBhAEp+ZKPRxCMoaqWZiqPirdjg+lyaKsk3a+1QMHoWtDbLWF1JrcnMOMFl8fL5vhlk1IdLIzLlzs8I3uEJubxubFWXCsL1DX1Sk9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716305; c=relaxed/simple;
	bh=AlaIEGImYYmPumtTfOsH6xg+Uc9cEpJVNIiOpbVEMjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sie+70t/Np8iX7jZvk6aCpz2ST1DCADV/kHiN8hFp7i+ySmEC1oougO/6G519DdqhdHOriVjtduQ0L/B0+tflisGuq3G8eMZ3ObNMBLrs08+Pv36AFxK8Y1Zm5YxQaOShexdViHNftyv3Sp+ODIwFNy3XWCHnCT28+OzBcuuGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=y4SJp+iG; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UF4b1w018825;
	Mon, 30 Sep 2024 19:11:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	1Ye6L3DfRK4HczvtuqdQ1WjvVCYeUFM7kYI5Yl8YF/A=; b=y4SJp+iGlF5xLHDn
	AigOkKEAEdMGM0Sg9W73RMsF+c+9xSbjwZX06HmpKiQl0qODqGp3B0Q3zeDU17Yb
	eJucvQLBCd/OqaokM5nMc1vpopZrtIqZfjxtkw6g5cVdDri06mZQlWAUb5M8SmQ5
	x+HO75XaMAri7HPFM8qAr/d8/QFGmYMaD/95Ha4zauhSNEOcQFFDJCN5mdI9ZcEX
	PvUzIDereNa4H51pgww1QoQMGBCbzR+0CT//0h6Wgj/2BXfbM7gaIfl2M1q60gpE
	gwiJnv7Oi+QewRtMmKWz4JLYy5Yi1KqTMGgQidlLU2XNn65thiBVbp3vNNIfdeRR
	sLe3tA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 41x77gj3xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 19:11:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6C5D14005E;
	Mon, 30 Sep 2024 19:09:44 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 933C12A2FF1;
	Mon, 30 Sep 2024 19:09:05 +0200 (CEST)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 30 Sep
 2024 19:09:05 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <vkoul@kernel.org>, <kishon@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>
CC: <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH v9 2/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
Date: Mon, 30 Sep 2024 19:08:44 +0200
Message-ID: <20240930170847.948779-3-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930170847.948779-1-christian.bruel@foss.st.com>
References: <20240930170847.948779-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Addition of the COMBOPHY driver found on STM32MP25 platforms

This single lane PHY is shared (exclusive) between the USB3 and PCIE
controllers.
Supports 5Gbit/s for PCIE gen2 or 2.5Gbit/s for PCIE gen1.

Supports wakeup-source capability to wakeup system using remote-wakeup
capable USB device

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/phy/st/Kconfig              |  11 +
 drivers/phy/st/Makefile             |   1 +
 drivers/phy/st/phy-stm32-combophy.c | 598 ++++++++++++++++++++++++++++
 3 files changed, 610 insertions(+)
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
index 3fc3d0781fb8..304614b6dabf 100644
--- a/drivers/phy/st/Kconfig
+++ b/drivers/phy/st/Kconfig
@@ -33,6 +33,17 @@ config PHY_STIH407_USB
 	  Enable this support to enable the picoPHY device used by USB2
 	  and USB3 controllers on STMicroelectronics STiH407 SoC families.
 
+config PHY_STM32_COMBOPHY
+	tristate "STMicroelectronics COMBOPHY driver for STM32MP25"
+	depends on ARCH_STM32 || COMPILE_TEST
+	select GENERIC_PHY
+	help
+	  Enable this to support the COMBOPHY device used by USB3 or PCIe
+	  controllers on STMicroelectronics STM32MP25 SoC.
+	  This driver controls the COMBOPHY block to generate the PCIe 100Mhz
+	  reference clock from either the external clock generator or HSE
+	  internal SoC clock source.
+
 config PHY_STM32_USBPHYC
 	tristate "STMicroelectronics STM32 USB HS PHY Controller driver"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/phy/st/Makefile b/drivers/phy/st/Makefile
index c862dd937b64..cb80e954ea9f 100644
--- a/drivers/phy/st/Makefile
+++ b/drivers/phy/st/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_PHY_MIPHY28LP) 		+= phy-miphy28lp.o
 obj-$(CONFIG_PHY_ST_SPEAR1310_MIPHY)	+= phy-spear1310-miphy.o
 obj-$(CONFIG_PHY_ST_SPEAR1340_MIPHY)	+= phy-spear1340-miphy.o
 obj-$(CONFIG_PHY_STIH407_USB)		+= phy-stih407-usb.o
+obj-$(CONFIG_PHY_STM32_COMBOPHY)	+= phy-stm32-combophy.o
 obj-$(CONFIG_PHY_STM32_USBPHYC) 	+= phy-stm32-usbphyc.o
diff --git a/drivers/phy/st/phy-stm32-combophy.c b/drivers/phy/st/phy-stm32-combophy.c
new file mode 100644
index 000000000000..e1e7083ccb5f
--- /dev/null
+++ b/drivers/phy/st/phy-stm32-combophy.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics COMBOPHY STM32MP25 Controller driver.
+ *
+ * Copyright (C) 2024 STMicroelectronics
+ * Author: Christian Bruel <christian.bruel@foss.st.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <dt-bindings/phy/phy.h>
+
+#define SYSCFG_COMBOPHY_CR1 0x4c00
+#define SYSCFG_COMBOPHY_CR2 0x4c04
+#define SYSCFG_COMBOPHY_CR4 0x4c0c
+#define SYSCFG_COMBOPHY_CR5 0x4c10
+#define SYSCFG_COMBOPHY_SR  0x4c14
+#define SYSCFG_PCIEPRGCR    0x6080
+
+/* SYSCFG PCIEPRGCR */
+#define STM32MP25_PCIEPRGCR_EN	  BIT(0)
+#define STM32MP25_PCIEPRG_IMPCTRL_OHM     GENMASK(3, 1)
+#define STM32MP25_PCIEPRG_IMPCTRL_VSWING  GENMASK(5, 4)
+
+/* SYSCFG SYSCFG_COMBOPHY_SR */
+#define STM32MP25_PIPE0_PHYSTATUS BIT(1)
+
+/* SYSCFG CR1 */
+#define SYSCFG_COMBOPHY_CR1_REFUSEPAD BIT(0)
+#define SYSCFG_COMBOPHY_CR1_MPLLMULT GENMASK(7, 1)
+#define SYSCFG_COMBOPHY_CR1_REFCLKSEL GENMASK(16, 8)
+#define SYSCFG_COMBOPHY_CR1_REFCLKDIV2 BIT(17)
+#define SYSCFG_COMBOPHY_CR1_REFSSPEN BIT(18)
+#define SYSCFG_COMBOPHY_CR1_SSCEN BIT(19)
+
+/* SYSCFG CR4 */
+#define SYSCFG_COMBOPHY_CR4_RX0_EQ GENMASK(2, 0)
+
+#define MPLLMULT_19_2 (0x02u << 1)
+#define MPLLMULT_20   (0x7du << 1)
+#define MPLLMULT_24   (0x68u << 1)
+#define MPLLMULT_25   (0x64u << 1)
+#define MPLLMULT_26   (0x60u << 1)
+#define MPLLMULT_38_4 (0x41u << 1)
+#define MPLLMULT_48   (0x6cu << 1)
+#define MPLLMULT_50   (0x32u << 1)
+#define MPLLMULT_52   (0x30u << 1)
+#define MPLLMULT_100  (0x19u << 1)
+
+#define REFCLKSEL_0   0
+#define REFCLKSEL_1   (0x108u << 8)
+
+#define REFCLDIV_0    0
+
+/* SYSCFG CR2 */
+#define SYSCFG_COMBOPHY_CR2_MODESEL GENMASK(1, 0)
+#define SYSCFG_COMBOPHY_CR2_ISO_DIS BIT(15)
+
+#define COMBOPHY_MODESEL_PCIE 0
+#define COMBOPHY_MODESEL_USB  3
+
+/* SYSCFG CR5 */
+#define SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS BIT(12)
+
+#define COMBOPHY_SUP_ANA_MPLL_LOOP_CTL 0xc0
+#define COMBOPHY_PROP_CNTRL GENMASK(7, 4)
+
+/* Required apb/ker clocks first, optional pad last. */
+static const char * const combophy_clks[] = {"apb", "ker", "pad"};
+#define APB_CLK 0
+#define KER_CLK 1
+#define PAD_CLK 2
+
+struct stm32_combophy {
+	struct phy *phy;
+	struct regmap *regmap;
+	struct device *dev;
+	void __iomem *base;
+	struct reset_control *phy_reset;
+	struct clk_bulk_data clks[ARRAY_SIZE(combophy_clks)];
+	int num_clks;
+	bool have_pad_clk;
+	unsigned int type;
+	bool is_init;
+	int irq_wakeup;
+};
+
+struct clk_impedance  {
+	u32 microohm;
+	u32 vswing[4];
+};
+
+/*
+ * lookup table to hold the settings needed for a ref clock frequency
+ * impedance, the offset is used to set the IMP_CTL and DE_EMP bit of the
+ * PRG_IMP_CTRL register. Use ordered discrete values in the table
+ */
+static const struct clk_impedance imp_lookup[] = {
+	{ 6090000, { 442000, 564000, 684000, 802000 } },
+	{ 5662000, { 528000, 621000, 712000, 803000 } },
+	{ 5292000, { 491000, 596000, 700000, 802000 } },
+	{ 4968000, { 558000, 640000, 722000, 803000 } },
+	{ 4684000, { 468000, 581000, 692000, 802000 } },
+	{ 4429000, { 554000, 613000, 717000, 803000 } },
+	{ 4204000, { 511000, 609000, 706000, 802000 } },
+	{ 3999000, { 571000, 648000, 726000, 803000 } }
+};
+
+static int stm32_impedance_tune(struct stm32_combophy *combophy)
+{
+	u8 imp_size = ARRAY_SIZE(imp_lookup);
+	u8 vswing_size = ARRAY_SIZE(imp_lookup[0].vswing);
+	u8 imp_of, vswing_of;
+	u32 max_imp = imp_lookup[0].microohm;
+	u32 min_imp = imp_lookup[imp_size - 1].microohm;
+	u32 max_vswing = imp_lookup[imp_size - 1].vswing[vswing_size - 1];
+	u32 min_vswing = imp_lookup[0].vswing[0];
+	u32 val;
+
+	if (!of_property_read_u32(combophy->dev->of_node, "st,output-micro-ohms", &val)) {
+		if (val < min_imp || val > max_imp) {
+			dev_err(combophy->dev, "Invalid value %u for output ohm\n", val);
+			return -EINVAL;
+		}
+
+		for (imp_of = 0; imp_of < ARRAY_SIZE(imp_lookup); imp_of++)
+			if (imp_lookup[imp_of].microohm <= val)
+				break;
+
+		dev_dbg(combophy->dev, "Set %u micro-ohms output impedance\n",
+			imp_lookup[imp_of].microohm);
+
+		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
+				   STM32MP25_PCIEPRG_IMPCTRL_OHM,
+				   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_OHM, imp_of));
+	} else {
+		regmap_read(combophy->regmap, SYSCFG_PCIEPRGCR, &val);
+		imp_of = FIELD_GET(STM32MP25_PCIEPRG_IMPCTRL_OHM, val);
+	}
+
+	if (!of_property_read_u32(combophy->dev->of_node, "st,output-vswing-microvolt", &val)) {
+		if (val < min_vswing || val > max_vswing) {
+			dev_err(combophy->dev, "Invalid value %u for output vswing\n", val);
+			return -EINVAL;
+		}
+
+		for (vswing_of = 0; vswing_of < ARRAY_SIZE(imp_lookup[imp_of].vswing); vswing_of++)
+			if (imp_lookup[imp_of].vswing[vswing_of] >= val)
+				break;
+
+		dev_dbg(combophy->dev, "Set %u microvolt swing\n",
+			 imp_lookup[imp_of].vswing[vswing_of]);
+
+		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
+				   STM32MP25_PCIEPRG_IMPCTRL_VSWING,
+				   FIELD_PREP(STM32MP25_PCIEPRG_IMPCTRL_VSWING, vswing_of));
+	}
+
+	return 0;
+}
+
+static int stm32_combophy_pll_init(struct stm32_combophy *combophy)
+{
+	int ret;
+	u32 refclksel, pllmult, propcntrl, val;
+	u32 clk_rate;
+	struct clk *clk;
+	u32 cr1_val = 0, cr1_mask = 0;
+
+	if (combophy->have_pad_clk)
+		clk = combophy->clks[PAD_CLK].clk;
+	else
+		clk = combophy->clks[KER_CLK].clk;
+
+	clk_rate = clk_get_rate(clk);
+
+	dev_dbg(combophy->dev, "%s pll init rate %d\n",
+		combophy->have_pad_clk ? "External" : "Ker", clk_rate);
+
+	if (combophy->type != PHY_TYPE_PCIE) {
+		cr1_mask |= SYSCFG_COMBOPHY_CR1_REFSSPEN;
+		cr1_val |= SYSCFG_COMBOPHY_CR1_REFSSPEN;
+	}
+
+	if (of_property_present(combophy->dev->of_node, "st,ssc-on")) {
+		dev_dbg(combophy->dev, "Enabling clock with SSC\n");
+		cr1_mask |= SYSCFG_COMBOPHY_CR1_SSCEN;
+		cr1_val |= SYSCFG_COMBOPHY_CR1_SSCEN;
+	}
+
+	switch (clk_rate) {
+	case 100000000:
+		pllmult = MPLLMULT_100;
+		refclksel = REFCLKSEL_0;
+		propcntrl = 0x8u << 4;
+		break;
+	case 19200000:
+		pllmult = MPLLMULT_19_2;
+		refclksel = REFCLKSEL_1;
+		propcntrl = 0x8u << 4;
+		break;
+	case 25000000:
+		pllmult = MPLLMULT_25;
+		refclksel = REFCLKSEL_0;
+		propcntrl = 0xeu << 4;
+		break;
+	case 24000000:
+		pllmult = MPLLMULT_24;
+		refclksel = REFCLKSEL_1;
+		propcntrl = 0xeu << 4;
+		break;
+	case 20000000:
+		pllmult = MPLLMULT_20;
+		refclksel = REFCLKSEL_0;
+		propcntrl = 0xeu << 4;
+		break;
+	default:
+		dev_err(combophy->dev, "Invalid rate 0x%x\n", clk_rate);
+		return -EINVAL;
+	};
+
+	cr1_mask |= SYSCFG_COMBOPHY_CR1_REFCLKDIV2;
+	cr1_val |= REFCLDIV_0;
+
+	cr1_mask |= SYSCFG_COMBOPHY_CR1_REFCLKSEL;
+	cr1_val |= refclksel;
+
+	cr1_mask |= SYSCFG_COMBOPHY_CR1_MPLLMULT;
+	cr1_val |= pllmult;
+
+	/*
+	 * vddcombophy is interconnected with vddcore. Isolation bit should be unset
+	 * before using the ComboPHY.
+	 */
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
+			   SYSCFG_COMBOPHY_CR2_ISO_DIS, SYSCFG_COMBOPHY_CR2_ISO_DIS);
+
+	reset_control_assert(combophy->phy_reset);
+
+	if (combophy->type == PHY_TYPE_PCIE) {
+		ret = stm32_impedance_tune(combophy);
+		if (ret)
+			goto out_iso;
+
+		cr1_mask |= SYSCFG_COMBOPHY_CR1_REFUSEPAD;
+		cr1_val |= combophy->have_pad_clk ? SYSCFG_COMBOPHY_CR1_REFUSEPAD : 0;
+	}
+
+	if (!of_property_read_u32(combophy->dev->of_node, "st,rx-equalizer", &val)) {
+		dev_dbg(combophy->dev, "Set RX equalizer %u\n", val);
+		if (val > SYSCFG_COMBOPHY_CR4_RX0_EQ) {
+			dev_err(combophy->dev, "Invalid value %u for rx0 equalizer\n", val);
+			ret = -EINVAL;
+			goto out_iso;
+		}
+
+		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR4,
+			   SYSCFG_COMBOPHY_CR4_RX0_EQ, val);
+	}
+
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1, cr1_mask, cr1_val);
+
+	/*
+	 * Force elasticity buffer to be tuned for the reference clock as
+	 * the separated clock model is not supported
+	 */
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR5,
+			   SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS, SYSCFG_COMBOPHY_CR5_COMMON_CLOCKS);
+
+	reset_control_deassert(combophy->phy_reset);
+
+	ret = regmap_read_poll_timeout(combophy->regmap, SYSCFG_COMBOPHY_SR, val,
+				       !(val & STM32MP25_PIPE0_PHYSTATUS),
+				       10, 1000);
+	if (ret) {
+		dev_err(combophy->dev, "timeout, cannot lock PLL\n");
+		if (combophy->type == PHY_TYPE_PCIE && !combophy->have_pad_clk)
+			regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
+					   STM32MP25_PCIEPRGCR_EN, 0);
+
+		if (combophy->type != PHY_TYPE_PCIE)
+			regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+					   SYSCFG_COMBOPHY_CR1_REFSSPEN, 0);
+
+		goto out;
+	}
+
+
+	if (combophy->type == PHY_TYPE_PCIE) {
+		if (!combophy->have_pad_clk)
+			regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
+					   STM32MP25_PCIEPRGCR_EN, STM32MP25_PCIEPRGCR_EN);
+
+		val = readl_relaxed(combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
+		val &= ~COMBOPHY_PROP_CNTRL;
+		val |= propcntrl;
+		writel_relaxed(val, combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
+	}
+
+	return 0;
+
+out_iso:
+	reset_control_deassert(combophy->phy_reset);
+
+out:
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
+			   SYSCFG_COMBOPHY_CR2_ISO_DIS, 0);
+
+	return ret;
+}
+
+static struct phy *stm32_combophy_xlate(struct device *dev,
+					const struct of_phandle_args *args)
+{
+	struct stm32_combophy *combophy = dev_get_drvdata(dev);
+	unsigned int type;
+
+	if (args->args_count != 1) {
+		dev_err(dev, "invalid number of cells in 'phy' property\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	type = args->args[0];
+	if (type != PHY_TYPE_USB3 && type != PHY_TYPE_PCIE) {
+		dev_err(dev, "unsupported device type: %d\n", type);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (combophy->have_pad_clk && type != PHY_TYPE_PCIE) {
+		dev_err(dev, "Invalid use of clk_pad for USB3 mode\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	combophy->type = type;
+
+	return combophy->phy;
+}
+
+static int stm32_combophy_set_mode(struct stm32_combophy *combophy)
+{
+	int type = combophy->type;
+	u32 val;
+
+	switch (type) {
+	case PHY_TYPE_PCIE:
+		dev_dbg(combophy->dev, "setting PCIe ComboPHY\n");
+		val = COMBOPHY_MODESEL_PCIE;
+		break;
+	case PHY_TYPE_USB3:
+		dev_dbg(combophy->dev, "setting USB3 ComboPHY\n");
+		val = COMBOPHY_MODESEL_USB;
+		break;
+	default:
+		dev_err(combophy->dev, "Invalid PHY mode %d\n", type);
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
+				  SYSCFG_COMBOPHY_CR2_MODESEL, val);
+}
+
+static int stm32_combophy_suspend_noirq(struct device *dev)
+{
+	struct stm32_combophy *combophy = dev_get_drvdata(dev);
+
+	/*
+	 * Clocks should be turned off since it is not needed for
+	 * wakeup capability. In case usb-remote wakeup is not enabled,
+	 * combo-phy is already turned off by HCD driver using exit callback
+	 */
+	if (combophy->is_init) {
+		clk_bulk_disable_unprepare(combophy->num_clks, combophy->clks);
+
+		/* since wakeup is enabled for ctrl */
+		enable_irq_wake(combophy->irq_wakeup);
+	}
+
+	return 0;
+}
+
+static int stm32_combophy_resume_noirq(struct device *dev)
+{
+	struct stm32_combophy *combophy = dev_get_drvdata(dev);
+	int ret;
+
+	/*
+	 * If clocks was turned off by suspend call for wakeup then needs
+	 * to be turned back ON in resume. In case usb-remote wakeup is not
+	 * enabled, clocks already turned ON by HCD driver using init callback
+	 */
+	if (combophy->is_init) {
+		/* since wakeup was enabled for ctrl */
+		disable_irq_wake(combophy->irq_wakeup);
+
+		ret = clk_bulk_prepare_enable(combophy->num_clks, combophy->clks);
+		if (ret) {
+			dev_err(dev, "can't enable clocks (%d)\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int stm32_combophy_exit(struct phy *phy)
+{
+	struct stm32_combophy *combophy = phy_get_drvdata(phy);
+	struct device *dev = combophy->dev;
+
+	combophy->is_init = false;
+
+	if (combophy->type == PHY_TYPE_PCIE && !combophy->have_pad_clk)
+		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
+				   STM32MP25_PCIEPRGCR_EN, 0);
+
+	if (combophy->type != PHY_TYPE_PCIE)
+		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+				   SYSCFG_COMBOPHY_CR1_REFSSPEN, 0);
+
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
+			   SYSCFG_COMBOPHY_CR2_ISO_DIS, 0);
+
+	clk_bulk_disable_unprepare(combophy->num_clks, combophy->clks);
+
+	pm_runtime_put_noidle(dev);
+
+	return 0;
+}
+
+static int stm32_combophy_init(struct phy *phy)
+{
+	struct stm32_combophy *combophy = phy_get_drvdata(phy);
+	struct device *dev = combophy->dev;
+	int ret;
+
+	pm_runtime_get_noresume(dev);
+
+	ret = clk_bulk_prepare_enable(combophy->num_clks, combophy->clks);
+	if (ret) {
+		dev_err(dev, "can't enable clocks (%d)\n", ret);
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	ret = stm32_combophy_set_mode(combophy);
+	if (ret) {
+		dev_err(dev, "combophy mode not set\n");
+		clk_bulk_disable_unprepare(combophy->num_clks, combophy->clks);
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	ret = stm32_combophy_pll_init(combophy);
+	if (ret) {
+		clk_bulk_disable_unprepare(combophy->num_clks, combophy->clks);
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	combophy->is_init = true;
+
+	return ret;
+}
+
+static const struct phy_ops stm32_combophy_phy_data = {
+	.init = stm32_combophy_init,
+	.exit = stm32_combophy_exit,
+	.owner = THIS_MODULE
+};
+
+static irqreturn_t stm32_combophy_irq_wakeup_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static int stm32_combophy_get_clocks(struct stm32_combophy *combophy)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(combophy_clks); i++)
+		combophy->clks[i].id = combophy_clks[i];
+
+	combophy->num_clks = ARRAY_SIZE(combophy_clks) - 1;
+
+	ret = devm_clk_bulk_get(combophy->dev, combophy->num_clks, combophy->clks);
+	if (ret)
+		return ret;
+
+	ret = devm_clk_bulk_get_optional(combophy->dev, 1, combophy->clks + combophy->num_clks);
+	if (ret)
+		return ret;
+
+	if (combophy->clks[combophy->num_clks].clk != NULL) {
+		combophy->have_pad_clk = true;
+		combophy->num_clks++;
+	}
+
+	return 0;
+}
+
+static int stm32_combophy_probe(struct platform_device *pdev)
+{
+	struct stm32_combophy *combophy;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	int ret, irq;
+
+	combophy = devm_kzalloc(dev, sizeof(*combophy), GFP_KERNEL);
+	if (!combophy)
+		return -ENOMEM;
+
+	combophy->dev = dev;
+
+	dev_set_drvdata(dev, combophy);
+
+	combophy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(combophy->base))
+		return PTR_ERR(combophy->base);
+
+	ret = stm32_combophy_get_clocks(combophy);
+	if (ret)
+		return ret;
+
+	combophy->phy_reset = devm_reset_control_get_exclusive(dev, "phy");
+	if (IS_ERR(combophy->phy_reset))
+		return dev_err_probe(dev, PTR_ERR(combophy->phy_reset),
+				     "Failed to get PHY reset\n");
+
+	combophy->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
+	if (IS_ERR(combophy->regmap))
+		return dev_err_probe(dev, PTR_ERR(combophy->regmap),
+				     "No syscfg specified\n");
+
+	combophy->phy = devm_phy_create(dev, NULL, &stm32_combophy_phy_data);
+	if (IS_ERR(combophy->phy))
+		return dev_err_probe(dev, PTR_ERR(combophy->phy),
+				     "failed to create PCIe/USB3 ComboPHY\n");
+
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		irq = platform_get_irq(pdev, 0);
+		if (irq < 0)
+			return dev_err_probe(dev, irq, "failed to get IRQ\n");
+		combophy->irq_wakeup = irq;
+
+		ret = devm_request_threaded_irq(dev, combophy->irq_wakeup, NULL,
+						stm32_combophy_irq_wakeup_handler, IRQF_ONESHOT,
+						NULL, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "unable to request wake IRQ %d\n",
+						 combophy->irq_wakeup);
+	}
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pm runtime\n");
+
+	phy_set_drvdata(combophy->phy, combophy);
+
+	phy_provider = devm_of_phy_provider_register(dev, stm32_combophy_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct dev_pm_ops stm32_combophy_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_combophy_suspend_noirq,
+				  stm32_combophy_resume_noirq)
+};
+
+static const struct of_device_id stm32_combophy_of_match[] = {
+	{ .compatible = "st,stm32mp25-combophy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, stm32_combophy_of_match);
+
+static struct platform_driver stm32_combophy_driver = {
+	.probe = stm32_combophy_probe,
+	.driver = {
+		   .name = "stm32-combophy",
+		   .of_match_table = stm32_combophy_of_match,
+		   .pm = pm_sleep_ptr(&stm32_combophy_pm_ops)
+	}
+};
+
+module_platform_driver(stm32_combophy_driver);
+
+MODULE_AUTHOR("Christian Bruel <christian.bruel@foss.st.com>");
+MODULE_DESCRIPTION("STM32MP25 Combophy USB3/PCIe controller driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


