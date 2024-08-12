Return-Path: <linux-kernel+bounces-283053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8194EC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916BF1F22C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86D17ADEA;
	Mon, 12 Aug 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sfDScTD3"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20678171658;
	Mon, 12 Aug 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464457; cv=none; b=JzJ2JG6jkGz8udQUxAC4JtYb/OwZBfS3gaGWgO8GyEyQZrrhc/lLgcHychkCWJ44UdZWuRBV6kJ95VKWroIfyjLjBPsxUJ13ZmJ/SDl+V4BV46hWLxfgS5mLlHWlGcRb4VKKYztG11zK05DnqRpS5m/Nlvkvj/N5at+WBr58bsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464457; c=relaxed/simple;
	bh=JQjHuW7IntHYW3k3TjRhT9Ye8zIry5958IOLBsb5u4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2dXS6NSbkMw70gwr09Bm1WbhOG4k95soOBGKHA5NJxbsIz4hrkWFAHenRKXEN/0IdhWjKWSEfmKlGbxrJrmmH0I3fAwoFp87o5IGA1hVzVC9u/RD6kKQLTddU92GHjGQ7e43dU5QC076BvOhs4VBc98qh5s+fzMhf0vplklaDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sfDScTD3; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47C85JVf012659;
	Mon, 12 Aug 2024 14:07:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	T4QganUbwjSgFOF+xaRaCgCJFxLL5CDlC4J3GqcBVvM=; b=sfDScTD3AuPc0rlI
	gJd+ppxiOHa48iMMsU8QZ2BW5Gpq3ImPi3o8RLWmrEP8PFnolYVzLjiIs23mnkvM
	3vuaZp7OEoFuIAWt9TOg9+d7GG2KsdJRUWwoXMiIn7nJsprT2BTy3/ljh6dhJrTK
	Z3ni7fjbzWTOcgKT7cPhkWhgzPaeX50z0WvIf/ZHqQ9EG3L1hbnG/3U9OgGWg/WD
	i88vCFJ5ono6khfnmPN3e1/NiY156MttAO9Av43jdF4DBK1vMtJLtvPUZVT+jXsf
	PS+eEc4fAYNyuU8XRl20OvFNoy0+sCPx2+prbOnstsdnJOCaQAaB+XFYipU4n1Qf
	Yv6fhw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40xk5hm8eu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 14:07:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3FBC340045;
	Mon, 12 Aug 2024 14:07:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C4FC325AF0C;
	Mon, 12 Aug 2024 14:06:15 +0200 (CEST)
Received: from localhost (10.129.178.198) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 12 Aug
 2024 14:06:15 +0200
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
Subject: [PATCH 3/5] phy: stm32: Add support for STM32MP25 COMBOPHY.
Date: Mon, 12 Aug 2024 14:05:27 +0200
Message-ID: <20240812120529.3564390-4-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812120529.3564390-1-christian.bruel@foss.st.com>
References: <20240812120529.3564390-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_02,2024-08-12_01,2024-05-17_01

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
 drivers/phy/st/phy-stm32-combophy.c | 607 ++++++++++++++++++++++++++++
 3 files changed, 619 insertions(+)
 create mode 100644 drivers/phy/st/phy-stm32-combophy.c

diff --git a/drivers/phy/st/Kconfig b/drivers/phy/st/Kconfig
index 3fc3d0781fb8a..304614b6dabfc 100644
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
index c862dd937b647..cb80e954ea9f0 100644
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
index 0000000000000..5ce9af0b569d7
--- /dev/null
+++ b/drivers/phy/st/phy-stm32-combophy.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * STMicroelectronics COMBOPHY STM32MP25 Controller driver.
+ *
+ * Copyright (C) 2024 STMicroelectronics
+ * Author: Christian Bruel <christian.bruel@foss.st.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <dt-bindings/phy/phy.h>
+
+#define SYSCFG_COMBOPHY_CR1 0x4C00
+#define SYSCFG_COMBOPHY_CR2 0x4C04
+#define SYSCFG_COMBOPHY_CR4 0x4C0C
+#define SYSCFG_COMBOPHY_CR5 0x4C10
+#define SYSCFG_COMBOPHY_SR  0x4C14
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
+#define MPLLMULT_20   (0x7Du << 1)
+#define MPLLMULT_24   (0x68u << 1)
+#define MPLLMULT_25   (0x64u << 1)
+#define MPLLMULT_26   (0x60u << 1)
+#define MPLLMULT_38_4 (0x41u << 1)
+#define MPLLMULT_48   (0x6Cu << 1)
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
+#define COMBOPHY_SUP_ANA_MPLL_LOOP_CTL 0xC0
+#define COMBOPHY_PROP_CNTRL GENMASK(7, 4)
+
+struct stm32_combophy {
+	struct phy *phy;
+	struct regmap *regmap;
+	struct device *dev;
+	void __iomem *base;
+	struct reset_control *phy_reset;
+	struct clk *phy_clk;
+	struct clk *pad_clk;
+	struct clk *ker_clk;
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
+ * PRG_IMP_CTRL register
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
+		for (imp_of = 0 ; imp_of < ARRAY_SIZE(imp_lookup); imp_of++)
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
+		for (vswing_of = 0 ; vswing_of < ARRAY_SIZE(imp_lookup[imp_of].vswing); vswing_of++)
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
+
+	if (combophy->pad_clk)
+		clk_rate = clk_get_rate(combophy->pad_clk);
+	else
+		clk_rate = clk_get_rate(combophy->ker_clk);
+
+	reset_control_assert(combophy->phy_reset);
+
+	dev_dbg(combophy->dev, "%s pll init rate %d\n",
+		combophy->pad_clk ? "External" : "Ker", clk_rate);
+
+	/*
+	 * vddcombophy is interconnected with vddcore. Isolation bit should be unset
+	 * before using the ComboPHY.
+	 */
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR2,
+			   SYSCFG_COMBOPHY_CR2_ISO_DIS, SYSCFG_COMBOPHY_CR2_ISO_DIS);
+
+	if (combophy->type != PHY_TYPE_PCIE)
+		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+				   SYSCFG_COMBOPHY_CR1_REFSSPEN, SYSCFG_COMBOPHY_CR1_REFSSPEN);
+
+	if (combophy->type == PHY_TYPE_PCIE && !combophy->pad_clk)
+		regmap_update_bits(combophy->regmap, SYSCFG_PCIEPRGCR,
+				   STM32MP25_PCIEPRGCR_EN, STM32MP25_PCIEPRGCR_EN);
+
+	if (of_property_read_bool(combophy->dev->of_node, "st,ssc-on")) {
+		dev_dbg(combophy->dev, "Enabling clock with SSC\n");
+		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+				   SYSCFG_COMBOPHY_CR1_SSCEN, SYSCFG_COMBOPHY_CR1_SSCEN);
+	}
+
+	if (!of_property_read_u32(combophy->dev->of_node, "st,rx_equalizer", &val)) {
+		dev_dbg(combophy->dev, "Set RX equalizer %u\n", val);
+		if (val > SYSCFG_COMBOPHY_CR4_RX0_EQ) {
+			dev_err(combophy->dev, "Invalid value %u for rx0 equalizer\n", val);
+			return -EINVAL;
+		}
+
+		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR4,
+			   SYSCFG_COMBOPHY_CR4_RX0_EQ, val);
+	}
+
+	if (combophy->type == PHY_TYPE_PCIE) {
+		ret = stm32_impedance_tune(combophy);
+		if (ret) {
+			reset_control_deassert(combophy->phy_reset);
+			goto out;
+		}
+
+		regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+				   SYSCFG_COMBOPHY_CR1_REFUSEPAD,
+				   combophy->pad_clk ? SYSCFG_COMBOPHY_CR1_REFUSEPAD : 0);
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
+		propcntrl = 0xEu << 4;
+		break;
+	case 24000000:
+		pllmult = MPLLMULT_24;
+		refclksel = REFCLKSEL_1;
+		propcntrl = 0xEu << 4;
+		break;
+	case 20000000:
+		pllmult = MPLLMULT_20;
+		refclksel = REFCLKSEL_0;
+		propcntrl = 0xEu << 4;
+		break;
+	default:
+		dev_err(combophy->dev, "Invalid rate 0x%x\n", clk_rate);
+		reset_control_deassert(combophy->phy_reset);
+		ret = -EINVAL;
+		goto out;
+	};
+
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+			   SYSCFG_COMBOPHY_CR1_REFCLKDIV2, REFCLDIV_0);
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+			   SYSCFG_COMBOPHY_CR1_REFCLKSEL, refclksel);
+	regmap_update_bits(combophy->regmap, SYSCFG_COMBOPHY_CR1,
+			   SYSCFG_COMBOPHY_CR1_MPLLMULT, pllmult);
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
+		goto out;
+	}
+
+	if (combophy->type == PHY_TYPE_PCIE) {
+		val = readl_relaxed(combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
+		val &= ~COMBOPHY_PROP_CNTRL;
+		val |= propcntrl;
+		writel_relaxed(val, combophy->base + COMBOPHY_SUP_ANA_MPLL_LOOP_CTL);
+	}
+
+	return 0;
+
+out:
+	if (combophy->type == PHY_TYPE_PCIE && !combophy->pad_clk)
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
+	if (combophy->pad_clk && type != PHY_TYPE_PCIE) {
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
+static int stm32_combophy_enable_clocks(struct stm32_combophy *combophy)
+{
+	int ret;
+
+	ret = clk_prepare_enable(combophy->phy_clk);
+	if (ret) {
+		dev_err(combophy->dev, "Core clock enable failed %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(combophy->ker_clk);
+	if (ret) {
+		dev_err(combophy->dev, "ker_usb3pcie clock enable failed %d\n", ret);
+		clk_disable_unprepare(combophy->phy_clk);
+		return ret;
+	}
+
+	if (combophy->pad_clk) {
+		ret = clk_prepare_enable(combophy->pad_clk);
+		if (ret) {
+			dev_err(combophy->dev, "External clock enable failed %d\n", ret);
+			clk_disable_unprepare(combophy->ker_clk);
+			clk_disable_unprepare(combophy->phy_clk);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void stm32_combophy_disable_clocks(struct stm32_combophy *combophy)
+{
+	if (combophy->pad_clk)
+		clk_disable_unprepare(combophy->pad_clk);
+	clk_disable_unprepare(combophy->ker_clk);
+	clk_disable_unprepare(combophy->phy_clk);
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
+		stm32_combophy_disable_clocks(combophy);
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
+		ret = stm32_combophy_enable_clocks(combophy);
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
+	if (combophy->type == PHY_TYPE_PCIE && !combophy->pad_clk)
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
+	stm32_combophy_disable_clocks(combophy);
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
+	ret = stm32_combophy_enable_clocks(combophy);
+	if (ret) {
+		dev_err(dev, "Clock enable failed %d\n", ret);
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	ret = stm32_combophy_set_mode(combophy);
+	if (ret) {
+		dev_err(dev, "combophy mode not set\n");
+		stm32_combophy_disable_clocks(combophy);
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	ret = stm32_combophy_pll_init(combophy);
+	if (ret) {
+		stm32_combophy_disable_clocks(combophy);
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
+static int stm32_combophy_probe(struct platform_device *pdev)
+{
+	struct stm32_combophy *combophy;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
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
+	combophy->phy_clk = devm_clk_get(dev, "apb-clk");
+	if (IS_ERR(combophy->phy_clk))
+		return dev_err_probe(dev, PTR_ERR(combophy->phy_clk),
+				     "Failed to get PHY clock source\n");
+
+	combophy->ker_clk = devm_clk_get(dev, "ker-clk");
+	if (IS_ERR(combophy->ker_clk))
+		return dev_err_probe(dev, PTR_ERR(combophy->ker_clk),
+				     "Failed to get PHY internal clock source\n");
+
+	combophy->pad_clk = devm_clk_get_optional(dev, "pad-clk");
+	if (IS_ERR(combophy->pad_clk))
+		return dev_err_probe(dev, PTR_ERR(combophy->pad_clk),
+				     "Failed to get PHY external clock source\n");
+
+	combophy->phy_reset = devm_reset_control_get(dev, "phy-rst");
+	if (IS_ERR(combophy->phy_reset))
+		return dev_err_probe(dev, PTR_ERR(combophy->phy_reset),
+				     "Failed to get PHY reset\n");
+
+	combophy->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
+	if (IS_ERR(combophy->regmap))
+		return dev_err_probe(dev, PTR_ERR(combophy->regmap),
+				     "No syscfg phandle specified\n");
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


