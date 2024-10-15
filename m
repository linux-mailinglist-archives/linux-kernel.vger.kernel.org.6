Return-Path: <linux-kernel+bounces-365990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B0099EF21
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1355C1F25994
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E89E1B2190;
	Tue, 15 Oct 2024 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wz5KeoqR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E087CF16;
	Tue, 15 Oct 2024 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001857; cv=none; b=FtIclTFI0OOSbFn0Q4pDM/xGB0yx+j8tlP6TiTVXWIbGCVxzNPg4W7WQYDVuR2szEq8pf/4sJMKwgpafjvdHy6cqYhbUkmogyDzOKVjjzFw9/Ppb9HX2hVj4LBEoNWlXsVIQyPAgndEh0utUt9Pqik5BTgGOx05n/mUGhGwLbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001857; c=relaxed/simple;
	bh=Zx/zmlNEn9bEHO0UYA3kk4QlwogqkzWua0DKPL5OlSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FlIiwB/Ja0YZ+dMrYAgFckJX0UR+a4i5pEQ4VWHDPvfP5ty1zA47U2kqS8f+rHvtE+ozu6y8cq3b1Mjg2U/qVkDcAmO8Jj0idCNywFkkiLR/Uu54k8r+Jo3e4DkCijItD4/QKcOXdX8xTyDnnUHT5X3NQVCHqFXXkcfGTccB5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wz5KeoqR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F60tGR022433;
	Tue, 15 Oct 2024 14:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FEPer4mXKA6LH/3mf8SQAlsvVMPnZCdl6x28KUMSKRo=; b=Wz5KeoqRRgdA+vDn
	7fbQK2L76vBmhieGvexbn+2FSST0gCxr+PjnwEEKwlEe4BRby0Tfu9rsmo/xcm7p
	ydPrVpAsMBBxfozwiqHP8pPINdefLaH1qc5AGof1OQRci+RO2j7XeFkz0+H2uui9
	gl1NCH4Bv5JZhsLa3izr6MCTb760bNZDFrA9itik6ikKNEpY4KB5qx+xI5WxtnWr
	MGgElfSqlWmZ3/tzQYkUxD8Lssn8wjttgWPgYxnOty9kREUweauiXZ2hF1KYp9gL
	P9J4TDIG9RUEfnSozXNYl1GA4TcNddn2jsmPilCk2mOnsBxkT2WDrybLWbED6MH+
	BDtUEg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429jrf997w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:17:25 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FEHOX2024336
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 14:17:24 GMT
Received: from nsssdc-sh01-lnx.ap.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 15 Oct 2024 07:17:18 -0700
From: Luo Jie <quic_luoj@quicinc.com>
Date: Tue, 15 Oct 2024 22:16:52 +0800
Subject: [PATCH v4 2/4] clk: qcom: Add CMN PLL clock controller driver for
 IPQ SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-qcom_ipq_cmnpll-v4-2-27817fbe3505@quicinc.com>
References: <20241015-qcom_ipq_cmnpll-v4-0-27817fbe3505@quicinc.com>
In-Reply-To: <20241015-qcom_ipq_cmnpll-v4-0-27817fbe3505@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_kkumarcs@quicinc.com>,
        <quic_suruchia@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_linchen@quicinc.com>, <quic_leiwei@quicinc.com>,
        <bartosz.golaszewski@linaro.org>, <srinivas.kandagatla@linaro.org>,
        Luo Jie
	<quic_luoj@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729001826; l=14264;
 i=quic_luoj@quicinc.com; s=20240808; h=from:subject:message-id;
 bh=Zx/zmlNEn9bEHO0UYA3kk4QlwogqkzWua0DKPL5OlSQ=;
 b=gOUkpc08Dy/EVdXrwwTFmwsAJkywYqldj0GOVjGGZO/7ajRH9dlPEjHb6+t+FK40+J+NcWjA4
 qAZEhrRW6Z4D88QkYM4xqTam47VCFB7pj3nOGLPXmiULkqyX2aSgTfF
X-Developer-Key: i=quic_luoj@quicinc.com; a=ed25519;
 pk=P81jeEL23FcOkZtXZXeDDiPwIwgAHVZFASJV12w3U6w=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ahxPw5LZh752oL7RYT8Y4Nf4HAs7R4zE
X-Proofpoint-ORIG-GUID: ahxPw5LZh752oL7RYT8Y4Nf4HAs7R4zE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150098

The CMN PLL clock controller supplies clocks to the hardware
blocks that together make up the Ethernet function on Qualcomm
IPQ SoCs and to GCC. The driver is initially supported for
IPQ9574 SoC.

The CMN PLL clock controller expects a reference input clock
from the on-board Wi-Fi block acting as clock source. The input
reference clock needs to be configured to one of the supported
clock rates.

The controller supplies a number of fixed-rate output clocks.
For the IPQ9574, there is one output clock of 353 MHZ to PPE
(Packet Process Engine) hardware block, three 50 MHZ output
clocks and an additional 25 MHZ output clock supplied to the
connected Ethernet devices. The PLL also supplies a 24 MHZ
clock as XO and a 32 KHZ sleep clock to GCC, and one 31.25
MHZ clock to PCS.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/clk/qcom/Kconfig       |  10 +
 drivers/clk/qcom/Makefile      |   1 +
 drivers/clk/qcom/ipq-cmn-pll.c | 411 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 422 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 30eb8236c9d8..3def659fc5cb 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -190,6 +190,16 @@ config IPQ_APSS_6018
 	  Say Y if you want to support CPU frequency scaling on
 	  ipq based devices.
 
+config IPQ_CMN_PLL
+	tristate "IPQ CMN PLL Clock Controller"
+	depends on IPQ_GCC_9574
+	help
+	  Support for CMN PLL clock controller on IPQ platform. The
+	  CMN PLL feeds the reference clocks to the Ethernet devices
+	  based on IPQ SoC.
+	  Say Y or M if you want to support CMN PLL clock on the IPQ
+	  based devices.
+
 config IPQ_GCC_4019
 	tristate "IPQ4019 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 2b378667a63f..83d11434714c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_CLK_X1E80100_TCSRCC) += tcsrcc-x1e80100.o
 obj-$(CONFIG_CLK_QCM2290_GPUCC) += gpucc-qcm2290.o
 obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
 obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
+obj-$(CONFIG_IPQ_CMN_PLL) += ipq-cmn-pll.o
 obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
 obj-$(CONFIG_IPQ_GCC_5018) += gcc-ipq5018.o
 obj-$(CONFIG_IPQ_GCC_5332) += gcc-ipq5332.o
diff --git a/drivers/clk/qcom/ipq-cmn-pll.c b/drivers/clk/qcom/ipq-cmn-pll.c
new file mode 100644
index 000000000000..f5ebc7d93ed8
--- /dev/null
+++ b/drivers/clk/qcom/ipq-cmn-pll.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/*
+ * CMN PLL block expects the reference clock from on-board Wi-Fi block,
+ * and supplies fixed rate clocks as output to the networking hardware
+ * blocks and to GCC. The networking related blocks include PPE (packet
+ * process engine), the externally connected PHY or switch devices, and
+ * the PCS.
+ *
+ * On the IPQ9574 SoC, there are three clocks with 50 MHZ and one clock
+ * with 25 MHZ which are output from the CMN PLL to Ethernet PHY (or switch),
+ * and one clock with 353 MHZ to PPE. The other fixed rate output clocks
+ * are supplied to GCC (24 MHZ as XO and 32 KHZ as sleep clock), and to PCS
+ * with 31.25 MHZ.
+ *
+ *               +---------+
+ *               |   GCC   |
+ *               +--+---+--+
+ *           AHB CLK|   |SYS CLK
+ *                  V   V
+ *          +-------+---+------+
+ *          |                  +-------------> eth0-50mhz
+ * REF CLK  |     IPQ9574      |
+ * -------->+                  +-------------> eth1-50mhz
+ *          |  CMN PLL block   |
+ *          |                  +-------------> eth2-50mhz
+ *          |                  |
+ *          +----+----+----+---+-------------> eth-25mhz
+ *               |    |    |
+ *               V    V    V
+ *              GCC  PCS  NSS/PPE
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_clock.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,ipq-cmn-pll.h>
+
+#define CMN_PLL_REFCLK_SRC_SELECTION		0x28
+#define CMN_PLL_REFCLK_SRC_DIV			GENMASK(9, 8)
+
+#define CMN_PLL_LOCKED				0x64
+#define CMN_PLL_CLKS_LOCKED			BIT(8)
+
+#define CMN_PLL_POWER_ON_AND_RESET		0x780
+#define CMN_ANA_EN_SW_RSTN			BIT(6)
+
+#define CMN_PLL_REFCLK_CONFIG			0x784
+#define CMN_PLL_REFCLK_EXTERNAL			BIT(9)
+#define CMN_PLL_REFCLK_DIV			GENMASK(8, 4)
+#define CMN_PLL_REFCLK_INDEX			GENMASK(3, 0)
+
+#define CMN_PLL_CTRL				0x78c
+#define CMN_PLL_CTRL_LOCK_DETECT_EN		BIT(15)
+
+#define CMN_PLL_DIVIDER_CTRL			0x794
+#define CMN_PLL_DIVIDER_CTRL_FACTOR		GENMASK(9, 0)
+
+/**
+ * struct cmn_pll_fixed_output_clk - CMN PLL output clocks information
+ * @id:	Clock specifier to be supplied
+ * @name: Clock name to be registered
+ * @rate: Clock rate
+ */
+struct cmn_pll_fixed_output_clk {
+	unsigned int id;
+	const char *name;
+	unsigned long rate;
+};
+
+/**
+ * struct clk_cmn_pll - CMN PLL hardware specific data
+ * @regmap: hardware regmap.
+ * @hw: handle between common and hardware-specific interfaces
+ */
+struct clk_cmn_pll {
+	struct regmap *regmap;
+	struct clk_hw hw;
+};
+
+#define CLK_PLL_OUTPUT(_id, _name, _rate) {		\
+	.id =		_id,				\
+	.name =		_name,				\
+	.rate =		_rate,				\
+}
+
+#define to_clk_cmn_pll(_hw) container_of(_hw, struct clk_cmn_pll, hw)
+
+static const struct regmap_config ipq_cmn_pll_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x7fc,
+	.fast_io = true,
+};
+
+static const struct cmn_pll_fixed_output_clk ipq9574_output_clks[] = {
+	CLK_PLL_OUTPUT(XO_24MHZ_CLK, "xo-24mhz", 24000000UL),
+	CLK_PLL_OUTPUT(SLEEP_32KHZ_CLK, "sleep-32khz", 32000UL),
+	CLK_PLL_OUTPUT(PCS_31P25MHZ_CLK, "pcs-31p25mhz", 31250000UL),
+	CLK_PLL_OUTPUT(NSS_1200MHZ_CLK, "nss-1200mhz", 1200000000UL),
+	CLK_PLL_OUTPUT(PPE_353MHZ_CLK, "ppe-353mhz", 353000000UL),
+	CLK_PLL_OUTPUT(ETH0_50MHZ_CLK, "eth0-50mhz", 50000000UL),
+	CLK_PLL_OUTPUT(ETH1_50MHZ_CLK, "eth1-50mhz", 50000000UL),
+	CLK_PLL_OUTPUT(ETH2_50MHZ_CLK, "eth2-50mhz", 50000000UL),
+	CLK_PLL_OUTPUT(ETH_25MHZ_CLK, "eth-25mhz", 25000000UL),
+};
+
+static unsigned long clk_cmn_pll_recalc_rate(struct clk_hw *hw,
+					     unsigned long parent_rate)
+{
+	struct clk_cmn_pll *cmn_pll = to_clk_cmn_pll(hw);
+	u32 val, factor;
+
+	/*
+	 * The value of CMN_PLL_DIVIDER_CTRL_FACTOR is automatically adjusted
+	 * by HW according to the parent clock rate.
+	 */
+	regmap_read(cmn_pll->regmap, CMN_PLL_DIVIDER_CTRL, &val);
+	factor = FIELD_GET(CMN_PLL_DIVIDER_CTRL_FACTOR, val);
+
+	return parent_rate * 2 * factor;
+}
+
+/*
+ * This function is used to initialize the CMN PLL to enable the fixed
+ * rate output clocks. It is expected to be configured once.
+ */
+static int clk_cmn_pll_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
+{
+	struct clk_cmn_pll *cmn_pll = to_clk_cmn_pll(hw);
+	u32 val;
+	int ret;
+
+	/*
+	 * Configure the reference input clock selection as per the given
+	 * parent clock. The output clock rates are always of fixed value.
+	 */
+	switch (req->best_parent_rate) {
+	case 25000000:
+		val = 3;
+		break;
+	case 31250000:
+		val = 4;
+		break;
+	case 40000000:
+		val = 6;
+		break;
+	case 50000000:
+		val = 8;
+		break;
+	case 48000000:
+	case 96000000:
+		/*
+		 * Parent clock rate 48 MHZ and 96 MHZ take the same value
+		 * of reference clock index. 96 MHZ needs the source clock
+		 * divider to be programmed as 2.
+		 */
+		val = 7;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(cmn_pll->regmap, CMN_PLL_REFCLK_CONFIG,
+				 CMN_PLL_REFCLK_INDEX,
+				 FIELD_PREP(CMN_PLL_REFCLK_INDEX, val));
+	if (ret)
+		return ret;
+
+	/*
+	 * Update the source clock rate selection and source clock
+	 * divider as 2 when the parent clock rate is 96 MHZ.
+	 */
+	if (req->best_parent_rate == 96000000) {
+		ret = regmap_update_bits(cmn_pll->regmap, CMN_PLL_REFCLK_CONFIG,
+					 CMN_PLL_REFCLK_DIV,
+					 FIELD_PREP(CMN_PLL_REFCLK_DIV, 2));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(cmn_pll->regmap, CMN_PLL_REFCLK_SRC_SELECTION,
+					 CMN_PLL_REFCLK_SRC_DIV,
+					 FIELD_PREP(CMN_PLL_REFCLK_SRC_DIV, 0));
+		if (ret)
+			return ret;
+	}
+
+	/* Enable PLL locked detect. */
+	ret = regmap_update_bits(cmn_pll->regmap, CMN_PLL_CTRL,
+				 CMN_PLL_CTRL_LOCK_DETECT_EN,
+				 CMN_PLL_CTRL_LOCK_DETECT_EN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Reset the CMN PLL block to ensure the updated configurations
+	 * take effect.
+	 */
+	ret = regmap_update_bits(cmn_pll->regmap, CMN_PLL_POWER_ON_AND_RESET,
+				 CMN_ANA_EN_SW_RSTN, 0);
+	if (ret)
+		return ret;
+
+	usleep_range(1000, 1200);
+	ret = regmap_update_bits(cmn_pll->regmap, CMN_PLL_POWER_ON_AND_RESET,
+				 CMN_ANA_EN_SW_RSTN, CMN_ANA_EN_SW_RSTN);
+	if (ret)
+		return ret;
+
+	/* Stability check of CMN PLL output clocks. */
+	return regmap_read_poll_timeout(cmn_pll->regmap, CMN_PLL_LOCKED, val,
+					(val & CMN_PLL_CLKS_LOCKED),
+					100, 100 * USEC_PER_MSEC);
+}
+
+static const struct clk_ops clk_cmn_pll_ops = {
+	.determine_rate = clk_cmn_pll_determine_rate,
+	.recalc_rate = clk_cmn_pll_recalc_rate,
+};
+
+static struct clk_hw *ipq_cmn_pll_clk_hw_register(struct platform_device *pdev)
+{
+	struct clk_parent_data pdata = { .index = 0 };
+	struct device *dev = &pdev->dev;
+	struct clk_init_data init = {};
+	struct clk_cmn_pll *cmn_pll;
+	struct regmap *regmap;
+	void __iomem *base;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &ipq_cmn_pll_regmap_config);
+	if (IS_ERR(regmap))
+		return ERR_CAST(regmap);
+
+	cmn_pll = devm_kzalloc(dev, sizeof(*cmn_pll), GFP_KERNEL);
+	if (!cmn_pll)
+		return ERR_PTR(-ENOMEM);
+
+	init.name = "cmn_pll";
+	init.parent_data = &pdata;
+	init.num_parents = 1;
+	init.ops = &clk_cmn_pll_ops;
+
+	cmn_pll->hw.init = &init;
+	cmn_pll->regmap = regmap;
+
+	ret = devm_clk_hw_register(dev, &cmn_pll->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return &cmn_pll->hw;
+}
+
+static int ipq_cmn_pll_register_clks(struct platform_device *pdev)
+{
+	const struct cmn_pll_fixed_output_clk *fixed_clk;
+	struct clk_hw_onecell_data *hw_data;
+	struct device *dev = &pdev->dev;
+	struct clk_hw *cmn_pll_hw;
+	unsigned int num_clks;
+	struct clk_hw *hw;
+	int ret, i;
+
+	fixed_clk = ipq9574_output_clks;
+	num_clks = ARRAY_SIZE(ipq9574_output_clks);
+
+	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, num_clks + 1),
+			       GFP_KERNEL);
+	if (!hw_data)
+		return -ENOMEM;
+
+	/*
+	 * Register the CMN PLL clock, which is the parent clock of
+	 * the fixed rate output clocks.
+	 */
+	cmn_pll_hw = ipq_cmn_pll_clk_hw_register(pdev);
+	if (IS_ERR(cmn_pll_hw))
+		return PTR_ERR(cmn_pll_hw);
+
+	/* Register the fixed rate output clocks. */
+	for (i = 0; i < num_clks; i++) {
+		hw = clk_hw_register_fixed_rate_parent_hw(dev, fixed_clk[i].name,
+							  cmn_pll_hw, 0,
+							  fixed_clk[i].rate);
+		if (IS_ERR(hw)) {
+			ret = PTR_ERR(hw);
+			goto unregister_fixed_clk;
+		}
+
+		hw_data->hws[fixed_clk[i].id] = hw;
+	}
+
+	/*
+	 * Provide the CMN PLL clock. The clock rate of CMN PLL
+	 * is configured to 12 GHZ by DT property assigned-clock-rates-u64.
+	 */
+	hw_data->hws[CMN_PLL_CLK] = cmn_pll_hw;
+	hw_data->num = num_clks + 1;
+
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, hw_data);
+	if (ret)
+		goto unregister_fixed_clk;
+
+	platform_set_drvdata(pdev, hw_data);
+
+	return 0;
+
+unregister_fixed_clk:
+	while (i > 0)
+		clk_hw_unregister(hw_data->hws[fixed_clk[--i].id]);
+
+	return ret;
+}
+
+static int ipq_cmn_pll_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_clk_create(dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * To access the CMN PLL registers, the GCC AHB & SYSY clocks
+	 * of CMN PLL block need to be enabled.
+	 */
+	ret = pm_clk_add(dev, "ahb");
+	if (ret)
+		return dev_err_probe(dev, ret, "Fail to add AHB clock\n");
+
+	ret = pm_clk_add(dev, "sys");
+	if (ret)
+		return dev_err_probe(dev, ret, "Fail to add SYS clock\n");
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	/* Register CMN PLL clock and fixed rate output clocks. */
+	ret = ipq_cmn_pll_register_clks(pdev);
+	pm_runtime_put(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Fail to register CMN PLL clocks\n");
+
+	return 0;
+}
+
+static void ipq_cmn_pll_clk_remove(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *hw_data = platform_get_drvdata(pdev);
+	int i;
+
+	/*
+	 * The clock with index CMN_PLL_CLK is unregistered by
+	 * device management.
+	 */
+	for (i = 0; i < hw_data->num; i++) {
+		if (i != CMN_PLL_CLK)
+			clk_hw_unregister(hw_data->hws[i]);
+	}
+}
+
+static const struct dev_pm_ops ipq_cmn_pll_pm_ops = {
+	SET_RUNTIME_PM_OPS(pm_clk_suspend, pm_clk_resume, NULL)
+};
+
+static const struct of_device_id ipq_cmn_pll_clk_ids[] = {
+	{ .compatible = "qcom,ipq9574-cmn-pll", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ipq_cmn_pll_clk_ids);
+
+static struct platform_driver ipq_cmn_pll_clk_driver = {
+	.probe = ipq_cmn_pll_clk_probe,
+	.remove = ipq_cmn_pll_clk_remove,
+	.driver = {
+		.name = "ipq_cmn_pll",
+		.of_match_table = ipq_cmn_pll_clk_ids,
+		.pm = &ipq_cmn_pll_pm_ops,
+	},
+};
+module_platform_driver(ipq_cmn_pll_clk_driver);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. IPQ CMN PLL Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


