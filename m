Return-Path: <linux-kernel+bounces-432085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A3E9E45A5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E285BA31DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 19:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C70206F35;
	Wed,  4 Dec 2024 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lJ5R32VY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5042066EE;
	Wed,  4 Dec 2024 19:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341077; cv=none; b=qkX5upcW4ec5hh1RS1dAduO720gtOux+/DGLxK2XLzubtj5wbxUGxChausjDAoClsZw5jE7BlFB1RRsfZyekzdZw5PUHe/hypZIVuifjBr6xWIWkrtfyMiYO8Ra3s7dJpp2eLAic4E9VbslH65CTLT+F/v5wSjrX0C1dhdEwZkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341077; c=relaxed/simple;
	bh=dhIxEFFdhlWqvNm8uX4Ugp37G33uywluu9w1TwAfmdc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WjUL6Xi/swKmPjlXeH2NEB+8nD8W56k1d6zwPPWoP2s7O+WMvXHaggIbne1/HCeMTSK7GyCPGOP9yx30IYrAuK0HtfNvSrUbCHVEuev9CmS1mbGfJKzH/LPH+bhs1v8xBn6bANu3UAg35guRimdIiRFdciBjBdOFcUY1Zpbozhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lJ5R32VY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FTJSs010103;
	Wed, 4 Dec 2024 19:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3/SJw9tJvUN9YDvKa9C/40GPCJfNWyFyWhahMXGslU=; b=lJ5R32VYR2yupyTS
	szK3PcBHFUGn8FMW69s/rU4odlXzTdc1DnB/ZZEusSUycdy0pofToe0/1obZyYdY
	qlhB4Bh4ioruWWdh+5qXqyDNazONfyRealTiqMHRaCcM2YT9VMYwnFqWho6g0BDN
	7nK4GhuA0DGqFOU/Npp6eb2DnpA5iHh/BLHWJGeM8HAgDdffFd3mLDp0djr3Ccqu
	/iuK+4U7dpRFotmklS/Y/Ut7jYOqnpCGQvtF/1D7huws3MwgtD9iD8IO+Uhr8gkg
	2Sc6H5nUwfqnEndc4zo+EDTYJ3/CqmCUeVsO2E57b6lMTJgrdVjwoyGhnCKhxqns
	Jf816w==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439v7ywf8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:37:42 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4Jbf5v004439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 19:37:41 GMT
Received: from hu-molvera-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 11:37:40 -0800
From: Melody Olvera <quic_molvera@quicinc.com>
Date: Wed, 4 Dec 2024 11:37:18 -0800
Subject: [PATCH v3 6/8] clk: qcom: Add support for GCC on SM8750
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241204-sm8750_master_clks-v3-6-1a8f31a53a86@quicinc.com>
References: <20241204-sm8750_master_clks-v3-0-1a8f31a53a86@quicinc.com>
In-Reply-To: <20241204-sm8750_master_clks-v3-0-1a8f31a53a86@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Melody Olvera
	<quic_molvera@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733341058; l=97812;
 i=quic_molvera@quicinc.com; s=20241204; h=from:subject:message-id;
 bh=mXT7WWRenMIo9xqMkOccrr5+rVkP5WZ56anTOqVL+1U=;
 b=N9aZxlyQZQ5V0Syhdk6OXcUVEiFWE713Fu4vRHva2M0+eS7hg6bRXW8e/cYrwzBUa0Vtrju0O
 bGD1uts4i3bCoH8kUzt8/p/ma6+Xi0hqgo83lqBybLXep8yGrd5ob1c
X-Developer-Key: i=quic_molvera@quicinc.com; a=ed25519;
 pk=1DGLp3zVYsHAWipMaNZZTHR321e8xK52C9vuAoeca5c=
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V79TW7-9s9KrzQzoi5BCvAZDoe2Z_Hlh
X-Proofpoint-GUID: V79TW7-9s9KrzQzoi5BCvAZDoe2Z_Hlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040150

From: Taniya Das <quic_tdas@quicinc.com>

Add support for GCC for SM8750 platform.

Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 drivers/clk/qcom/Kconfig      |    9 +
 drivers/clk/qcom/Makefile     |    1 +
 drivers/clk/qcom/gcc-sm8750.c | 3274 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 3284 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index ef89d686cbc4e0032a288da7021c32ca53405d44..26bfb607235bf3689744532e4f7c087606846b12 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -1130,6 +1130,15 @@ config SM_GCC_8650
 	  Say Y if you want to use peripheral devices such as UART,
 	  SPI, I2C, USB, SD/UFS, PCIe etc.
 
+config SM_GCC_8750
+	tristate "SM8750 Global Clock Controller"
+	depends on ARM64 || COMPILE_TEST
+	select QCOM_GDSC
+	help
+	  Support for the global clock controller on SM8750 devices.
+	  Say Y if you want to use peripheral devices such as UART,
+	  SPI, I2C, USB, SD/UFS, PCIe etc.
+
 config SM_GPUCC_4450
 	tristate "SM4450 Graphics Clock Controller"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index b09dbdc210eb1cec264dd4bcd9b13554bd081c52..1875018d1100f57a475d9cf6b2a267a7a87680be 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_SM_GCC_8350) += gcc-sm8350.o
 obj-$(CONFIG_SM_GCC_8450) += gcc-sm8450.o
 obj-$(CONFIG_SM_GCC_8550) += gcc-sm8550.o
 obj-$(CONFIG_SM_GCC_8650) += gcc-sm8650.o
+obj-$(CONFIG_SM_GCC_8750) += gcc-sm8750.o
 obj-$(CONFIG_SM_GPUCC_4450) += gpucc-sm4450.o
 obj-$(CONFIG_SM_GPUCC_6115) += gpucc-sm6115.o
 obj-$(CONFIG_SM_GPUCC_6125) += gpucc-sm6125.o
diff --git a/drivers/clk/qcom/gcc-sm8750.c b/drivers/clk/qcom/gcc-sm8750.c
new file mode 100644
index 0000000000000000000000000000000000000000..b36d70976095834ae4f7936d83f228d81b2c31e8
--- /dev/null
+++ b/drivers/clk/qcom/gcc-sm8750.c
@@ -0,0 +1,3274 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm8750-gcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+#include "clk-regmap-phy-mux.h"
+#include "common.h"
+#include "gdsc.h"
+#include "reset.h"
+
+enum {
+	DT_BI_TCXO,
+	DT_BI_TCXO_AO,
+	DT_SLEEP_CLK,
+	DT_PCIE_0_PIPE_CLK,
+	DT_UFS_PHY_RX_SYMBOL_0_CLK,
+	DT_UFS_PHY_RX_SYMBOL_1_CLK,
+	DT_UFS_PHY_TX_SYMBOL_0_CLK,
+	DT_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
+};
+
+enum {
+	P_BI_TCXO,
+	P_GCC_GPLL0_OUT_EVEN,
+	P_GCC_GPLL0_OUT_MAIN,
+	P_GCC_GPLL1_OUT_MAIN,
+	P_GCC_GPLL4_OUT_MAIN,
+	P_GCC_GPLL7_OUT_MAIN,
+	P_GCC_GPLL9_OUT_MAIN,
+	P_PCIE_0_PIPE_CLK,
+	P_SLEEP_CLK,
+	P_UFS_PHY_RX_SYMBOL_0_CLK,
+	P_UFS_PHY_RX_SYMBOL_1_CLK,
+	P_UFS_PHY_TX_SYMBOL_0_CLK,
+	P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
+};
+
+static struct clk_alpha_pll gcc_gpll0 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU],
+	.clkr = {
+		.enable_reg = 0x52020,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpll0",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_taycan_elu_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_gcc_gpll0_out_even[] = {
+	{ 0x1, 2 },
+	{ }
+};
+
+static struct clk_alpha_pll_postdiv gcc_gpll0_out_even = {
+	.offset = 0x0,
+	.post_div_shift = 10,
+	.post_div_table = post_div_table_gcc_gpll0_out_even,
+	.num_post_div = ARRAY_SIZE(post_div_table_gcc_gpll0_out_even),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU],
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_gpll0_out_even",
+		.parent_hws = (const struct clk_hw*[]) {
+			&gcc_gpll0.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_taycan_elu_ops,
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll1 = {
+	.offset = 0x1000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU],
+	.clkr = {
+		.enable_reg = 0x52020,
+		.enable_mask = BIT(1),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpll1",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_taycan_elu_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll4 = {
+	.offset = 0x4000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU],
+	.clkr = {
+		.enable_reg = 0x52020,
+		.enable_mask = BIT(4),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpll4",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_taycan_elu_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll7 = {
+	.offset = 0x7000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU],
+	.clkr = {
+		.enable_reg = 0x52020,
+		.enable_mask = BIT(7),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpll7",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_taycan_elu_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll gcc_gpll9 = {
+	.offset = 0x9000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_TAYCAN_ELU],
+	.clkr = {
+		.enable_reg = 0x52020,
+		.enable_mask = BIT(9),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpll9",
+			.parent_data = &(const struct clk_parent_data) {
+				.index = DT_BI_TCXO,
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_fixed_taycan_elu_ops,
+		},
+	},
+};
+
+static const struct parent_map gcc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_SLEEP_CLK, 5 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .index = DT_SLEEP_CLK },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL1_OUT_MAIN, 4 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_2[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll1.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_3[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_SLEEP_CLK, 5 },
+};
+
+static const struct clk_parent_data gcc_parent_data_4[] = {
+	{ .index = DT_BI_TCXO },
+	{ .index = DT_SLEEP_CLK },
+};
+
+static const struct parent_map gcc_parent_map_5[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL7_OUT_MAIN, 2 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_5[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll7.clkr.hw },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_6[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data gcc_parent_data_6[] = {
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct parent_map gcc_parent_map_8[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GCC_GPLL0_OUT_MAIN, 1 },
+	{ P_GCC_GPLL9_OUT_MAIN, 2 },
+	{ P_GCC_GPLL4_OUT_MAIN, 5 },
+	{ P_GCC_GPLL0_OUT_EVEN, 6 },
+};
+
+static const struct clk_parent_data gcc_parent_data_8[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gcc_gpll0.clkr.hw },
+	{ .hw = &gcc_gpll9.clkr.hw },
+	{ .hw = &gcc_gpll4.clkr.hw },
+	{ .hw = &gcc_gpll0_out_even.clkr.hw },
+};
+
+static const struct parent_map gcc_parent_map_9[] = {
+	{ P_UFS_PHY_RX_SYMBOL_0_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_9[] = {
+	{ .index = DT_UFS_PHY_RX_SYMBOL_0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct parent_map gcc_parent_map_10[] = {
+	{ P_UFS_PHY_RX_SYMBOL_1_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_10[] = {
+	{ .index = DT_UFS_PHY_RX_SYMBOL_1_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct parent_map gcc_parent_map_11[] = {
+	{ P_UFS_PHY_TX_SYMBOL_0_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_11[] = {
+	{ .index = DT_UFS_PHY_TX_SYMBOL_0_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static const struct parent_map gcc_parent_map_12[] = {
+	{ P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK, 0 },
+	{ P_BI_TCXO, 2 },
+};
+
+static const struct clk_parent_data gcc_parent_data_12[] = {
+	{ .index = DT_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK },
+	{ .index = DT_BI_TCXO },
+};
+
+static struct clk_regmap_phy_mux gcc_pcie_0_pipe_clk_src = {
+	.reg = 0x6b080,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_pipe_clk_src",
+			.parent_data = &(const struct clk_parent_data){
+				.index = DT_PCIE_0_PIPE_CLK,
+			},
+			.num_parents = 1,
+			.ops = &clk_regmap_phy_mux_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux gcc_ufs_phy_rx_symbol_0_clk_src = {
+	.reg = 0x77068,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_9,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_rx_symbol_0_clk_src",
+			.parent_data = gcc_parent_data_9,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_9),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux gcc_ufs_phy_rx_symbol_1_clk_src = {
+	.reg = 0x770ec,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_10,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_rx_symbol_1_clk_src",
+			.parent_data = gcc_parent_data_10,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_10),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux gcc_ufs_phy_tx_symbol_0_clk_src = {
+	.reg = 0x77058,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_11,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_tx_symbol_0_clk_src",
+			.parent_data = gcc_parent_data_11,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_11),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static struct clk_regmap_mux gcc_usb3_prim_phy_pipe_clk_src = {
+	.reg = 0x39070,
+	.shift = 0,
+	.width = 2,
+	.parent_map = gcc_parent_map_12,
+	.clkr = {
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb3_prim_phy_pipe_clk_src",
+			.parent_data = gcc_parent_data_12,
+			.num_parents = ARRAY_SIZE(gcc_parent_data_12),
+			.ops = &clk_regmap_mux_closest_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
+	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_gp1_clk_src = {
+	.cmd_rcgr = 0x64004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_gp1_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_gp2_clk_src = {
+	.cmd_rcgr = 0x65004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_gp2_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_gp3_clk_src = {
+	.cmd_rcgr = 0x66004,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_1,
+	.freq_tbl = ftbl_gcc_gp1_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_gp3_clk_src",
+		.parent_data = gcc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_aux_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pcie_0_aux_clk_src = {
+	.cmd_rcgr = 0x6b084,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_pcie_0_aux_clk_src",
+		.parent_data = gcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pcie_0_phy_rchng_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pcie_0_phy_rchng_clk_src = {
+	.cmd_rcgr = 0x6b068,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_phy_rchng_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_pcie_0_phy_rchng_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_pdm2_clk_src[] = {
+	F(60000000, P_GCC_GPLL0_OUT_MAIN, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_pdm2_clk_src = {
+	.cmd_rcgr = 0x33010,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pdm2_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_pdm2_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s0_clk_src = {
+	.cmd_rcgr = 0x17008,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s0_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s1_clk_src = {
+	.cmd_rcgr = 0x17024,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s1_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s2_clk_src = {
+	.cmd_rcgr = 0x17040,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s2_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s3_clk_src = {
+	.cmd_rcgr = 0x1705c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s3_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s4_clk_src = {
+	.cmd_rcgr = 0x17078,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s4_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s5_clk_src = {
+	.cmd_rcgr = 0x17094,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s5_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s6_clk_src = {
+	.cmd_rcgr = 0x170b0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s6_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s7_clk_src = {
+	.cmd_rcgr = 0x170cc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s7_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s8_clk_src = {
+	.cmd_rcgr = 0x170e8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s8_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_qupv3_i2c_s9_clk_src = {
+	.cmd_rcgr = 0x17104,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_i2c_s9_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+/* Check this frequency table.*/
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_qspi_ref_clk_src[] = {
+	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
+	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
+	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
+	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(51200000, P_GCC_GPLL0_OUT_EVEN, 1, 64, 375),
+	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
+	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
+	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(102400000, P_GCC_GPLL0_OUT_EVEN, 1, 128, 375),
+	F(112000000, P_GCC_GPLL0_OUT_EVEN, 1, 28, 75),
+	F(117964800, P_GCC_GPLL0_OUT_EVEN, 1, 6144, 15625),
+	F(120000000, P_GCC_GPLL0_OUT_MAIN, 5, 0, 0),
+	F(150000000, P_GCC_GPLL0_OUT_EVEN, 2, 0, 0),
+	F(250000000, P_GCC_GPLL7_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_qspi_ref_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_qspi_ref_clk_src",
+	.parent_data = gcc_parent_data_5,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_qspi_ref_clk_src = {
+	.cmd_rcgr = 0x188c0,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_5,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_qspi_ref_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_qspi_ref_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s0_clk_src[] = {
+	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
+	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
+	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
+	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(51200000, P_GCC_GPLL0_OUT_EVEN, 1, 64, 375),
+	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
+	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
+	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(102400000, P_GCC_GPLL0_OUT_EVEN, 1, 128, 375),
+	F(112000000, P_GCC_GPLL0_OUT_EVEN, 1, 28, 75),
+	F(117964800, P_GCC_GPLL0_OUT_EVEN, 1, 6144, 15625),
+	F(120000000, P_GCC_GPLL0_OUT_MAIN, 5, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s0_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s0_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s0_clk_src = {
+	.cmd_rcgr = 0x18014,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s0_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s1_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s1_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s1_clk_src = {
+	.cmd_rcgr = 0x18150,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s1_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s3_clk_src[] = {
+	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
+	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
+	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
+	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(51200000, P_GCC_GPLL0_OUT_EVEN, 1, 64, 375),
+	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
+	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
+	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s3_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s3_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s3_clk_src = {
+	.cmd_rcgr = 0x182a0,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s3_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s3_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s4_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s4_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s4_clk_src = {
+	.cmd_rcgr = 0x183dc,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s4_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s5_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s5_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s5_clk_src = {
+	.cmd_rcgr = 0x18518,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s3_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s5_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s6_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s6_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s6_clk_src = {
+	.cmd_rcgr = 0x18654,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s3_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s6_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap1_s7_clk_src_init = {
+	.name = "gcc_qupv3_wrap1_s7_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap1_s7_clk_src = {
+	.cmd_rcgr = 0x18790,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s3_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap1_s7_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap2_ibi_ctrl_0_clk_src[] = {
+	F(37500000, P_GCC_GPLL0_OUT_EVEN, 8, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_ibi_ctrl_0_clk_src = {
+	.cmd_rcgr = 0x1e9f4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_2,
+	.freq_tbl = ftbl_gcc_qupv3_wrap2_ibi_ctrl_0_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_wrap2_ibi_ctrl_0_clk_src",
+		.parent_data = gcc_parent_data_2,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_2),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s0_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s0_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s0_clk_src = {
+	.cmd_rcgr = 0x1e014,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s0_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s1_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s1_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s1_clk_src = {
+	.cmd_rcgr = 0x1e150,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s1_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s2_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s2_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s2_clk_src = {
+	.cmd_rcgr = 0x1e28c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s2_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s3_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s3_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s3_clk_src = {
+	.cmd_rcgr = 0x1e3c8,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s3_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s4_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s4_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s4_clk_src = {
+	.cmd_rcgr = 0x1e504,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s3_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s4_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s5_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s5_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s5_clk_src = {
+	.cmd_rcgr = 0x1e640,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s3_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s5_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_qupv3_wrap2_s6_clk_src[] = {
+	F(7372800, P_GCC_GPLL0_OUT_EVEN, 1, 384, 15625),
+	F(14745600, P_GCC_GPLL0_OUT_EVEN, 1, 768, 15625),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(29491200, P_GCC_GPLL0_OUT_EVEN, 1, 1536, 15625),
+	F(32000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 75),
+	F(48000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 25),
+	F(51200000, P_GCC_GPLL0_OUT_EVEN, 1, 64, 375),
+	F(64000000, P_GCC_GPLL0_OUT_EVEN, 1, 16, 75),
+	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
+	F(80000000, P_GCC_GPLL0_OUT_EVEN, 1, 4, 15),
+	F(96000000, P_GCC_GPLL0_OUT_EVEN, 1, 8, 25),
+	F(100000000, P_GCC_GPLL0_OUT_MAIN, 6, 0, 0),
+	F(102400000, P_GCC_GPLL0_OUT_EVEN, 1, 128, 375),
+	F(112000000, P_GCC_GPLL0_OUT_EVEN, 1, 28, 75),
+	F(117964800, P_GCC_GPLL0_OUT_EVEN, 1, 6144, 15625),
+	F(128000000, P_GCC_GPLL0_OUT_MAIN, 1, 16, 75),
+	{ }
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s6_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s6_clk_src",
+	.parent_data = gcc_parent_data_5,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s6_clk_src = {
+	.cmd_rcgr = 0x1e77c,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_5,
+	.freq_tbl = ftbl_gcc_qupv3_wrap2_s6_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s6_clk_src_init,
+};
+
+static struct clk_init_data gcc_qupv3_wrap2_s7_clk_src_init = {
+	.name = "gcc_qupv3_wrap2_s7_clk_src",
+	.parent_data = gcc_parent_data_0,
+	.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+	.flags = CLK_SET_RATE_PARENT,
+	.ops = &clk_rcg2_shared_ops,
+};
+
+static struct clk_rcg2 gcc_qupv3_wrap2_s7_clk_src = {
+	.cmd_rcgr = 0x1e8b8,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_qupv3_wrap1_s0_clk_src,
+	.clkr.hw.init = &gcc_qupv3_wrap2_s7_clk_src_init,
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
+	F(400000, P_BI_TCXO, 12, 1, 4),
+	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(50000000, P_GCC_GPLL0_OUT_EVEN, 6, 0, 0),
+	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
+	F(202000000, P_GCC_GPLL9_OUT_MAIN, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
+	.cmd_rcgr = 0x1401c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_8,
+	.freq_tbl = ftbl_gcc_sdcc2_apps_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_sdcc2_apps_clk_src",
+		.parent_data = gcc_parent_data_8,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_floor_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_sdcc4_apps_clk_src[] = {
+	F(400000, P_BI_TCXO, 12, 1, 4),
+	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(75000000, P_GCC_GPLL0_OUT_EVEN, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_sdcc4_apps_clk_src = {
+	.cmd_rcgr = 0x1601c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_sdcc4_apps_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_sdcc4_apps_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_floor_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_axi_clk_src[] = {
+	F(25000000, P_GCC_GPLL0_OUT_EVEN, 12, 0, 0),
+	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
+	F(201500000, P_GCC_GPLL4_OUT_MAIN, 4, 0, 0),
+	F(403000000, P_GCC_GPLL4_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_ufs_phy_axi_clk_src = {
+	.cmd_rcgr = 0x77034,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_ufs_phy_axi_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_ufs_phy_axi_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_ice_core_clk_src[] = {
+	F(100000000, P_GCC_GPLL0_OUT_EVEN, 3, 0, 0),
+	F(201500000, P_GCC_GPLL4_OUT_MAIN, 4, 0, 0),
+	F(403000000, P_GCC_GPLL4_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_ufs_phy_ice_core_clk_src = {
+	.cmd_rcgr = 0x7708c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_ufs_phy_ice_core_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_ufs_phy_phy_aux_clk_src[] = {
+	F(9600000, P_BI_TCXO, 2, 0, 0),
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
+	.cmd_rcgr = 0x770c0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_6,
+	.freq_tbl = ftbl_gcc_ufs_phy_phy_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_ufs_phy_phy_aux_clk_src",
+		.parent_data = gcc_parent_data_6,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_6),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_ufs_phy_unipro_core_clk_src = {
+	.cmd_rcgr = 0x770a4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
+	.freq_tbl = ftbl_gcc_ufs_phy_ice_core_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_ufs_phy_unipro_core_clk_src",
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
+	F(66666667, P_GCC_GPLL0_OUT_EVEN, 4.5, 0, 0),
+	F(133333333, P_GCC_GPLL0_OUT_MAIN, 4.5, 0, 0),
+	F(200000000, P_GCC_GPLL0_OUT_MAIN, 3, 0, 0),
+	F(240000000, P_GCC_GPLL0_OUT_MAIN, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gcc_usb30_prim_master_clk_src = {
+	.cmd_rcgr = 0x39030,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_usb30_prim_master_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_usb30_prim_master_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
+	.cmd_rcgr = 0x39048,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_0,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_usb30_prim_mock_utmi_clk_src",
+		.parent_data = gcc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 gcc_usb3_prim_phy_aux_clk_src = {
+	.cmd_rcgr = 0x39074,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gcc_parent_map_4,
+	.freq_tbl = ftbl_gcc_pcie_0_aux_clk_src,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_usb3_prim_phy_aux_clk_src",
+		.parent_data = gcc_parent_data_4,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_4),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_regmap_div gcc_qupv3_wrap1_s2_clk_src = {
+	.reg = 0x1828c,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_qupv3_wrap1_s2_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&gcc_qupv3_wrap1_qspi_ref_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div gcc_usb30_prim_mock_utmi_postdiv_clk_src = {
+	.reg = 0x39060,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(const struct clk_init_data) {
+		.name = "gcc_usb30_prim_mock_utmi_postdiv_clk_src",
+		.parent_hws = (const struct clk_hw*[]) {
+			&gcc_usb30_prim_mock_utmi_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch gcc_aggre_noc_pcie_axi_clk = {
+	.halt_reg = 0x10068,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x10068,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(12),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_aggre_noc_pcie_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_aggre_ufs_phy_axi_clk = {
+	.halt_reg = 0x770f0,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x770f0,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x770f0,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_aggre_ufs_phy_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_aggre_usb3_prim_axi_clk = {
+	.halt_reg = 0x39090,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x39090,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x39090,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_aggre_usb3_prim_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_boot_rom_ahb_clk = {
+	.halt_reg = 0x38004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x38004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(10),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_boot_rom_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camera_hf_axi_clk = {
+	.halt_reg = 0x26014,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x26014,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x26014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_camera_hf_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_camera_sf_axi_clk = {
+	.halt_reg = 0x26024,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x26024,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x26024,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_camera_sf_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cfg_noc_pcie_anoc_ahb_clk = {
+	.halt_reg = 0x10050,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x10050,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(20),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_cfg_noc_pcie_anoc_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cfg_noc_usb3_prim_axi_clk = {
+	.halt_reg = 0x3908c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x3908c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3908c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_cfg_noc_usb3_prim_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_cnoc_pcie_sf_axi_clk = {
+	.halt_reg = 0x10058,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x10058,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(6),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_cnoc_pcie_sf_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ddrss_gpu_axi_clk = {
+	.halt_reg = 0x71150,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x71150,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x71150,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ddrss_gpu_axi_clk",
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ddrss_pcie_sf_qtb_clk = {
+	.halt_reg = 0x1007c,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x1007c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(19),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ddrss_pcie_sf_qtb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_disp_hf_axi_clk = {
+	.halt_reg = 0x27008,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x27008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_disp_hf_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eva_axi0_clk = {
+	.halt_reg = 0x9f008,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x9f008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x9f008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_eva_axi0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_eva_axi0c_clk = {
+	.halt_reg = 0x9f018,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x9f018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x9f018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_eva_axi0c_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp1_clk = {
+	.halt_reg = 0x64000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x64000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gp1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_gp1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp2_clk = {
+	.halt_reg = 0x65000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x65000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gp2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_gp2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gp3_clk = {
+	.halt_reg = 0x66000,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x66000,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gp3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_gp3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_gemnoc_gfx_clk = {
+	.halt_reg = 0x71010,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x71010,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x71010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpu_gemnoc_gfx_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_gpll0_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(15),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpu_gpll0_clk_src",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_gpll0.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_gpu_gpll0_div_clk_src = {
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(16),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_gpu_gpll0_div_clk_src",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_gpll0_out_even.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_aux_clk = {
+	.halt_reg = 0x6b044,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(3),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_pcie_0_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_cfg_ahb_clk = {
+	.halt_reg = 0x6b040,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x6b040,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(2),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_cfg_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_mstr_axi_clk = {
+	.halt_reg = 0x6b030,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x6b030,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(1),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_mstr_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_phy_rchng_clk = {
+	.halt_reg = 0x6b064,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(22),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_phy_rchng_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_pcie_0_phy_rchng_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_pipe_clk = {
+	.halt_reg = 0x6b054,
+	.halt_check = BRANCH_HALT_SKIP,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(4),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_pcie_0_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_slv_axi_clk = {
+	.halt_reg = 0x6b020,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x6b020,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_slv_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pcie_0_slv_q2a_axi_clk = {
+	.halt_reg = 0x6b01c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(5),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pcie_0_slv_q2a_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm2_clk = {
+	.halt_reg = 0x3300c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3300c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pdm2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_pdm2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_ahb_clk = {
+	.halt_reg = 0x33004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x33004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x33004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pdm_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_pdm_xo4_clk = {
+	.halt_reg = 0x33008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x33008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_pdm_xo4_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_camera_cmd_ahb_clk = {
+	.halt_reg = 0x26010,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x26010,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x26010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_camera_cmd_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_camera_nrt_ahb_clk = {
+	.halt_reg = 0x26008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x26008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x26008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_camera_nrt_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_camera_rt_ahb_clk = {
+	.halt_reg = 0x2600c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x2600c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x2600c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_camera_rt_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_gpu_ahb_clk = {
+	.halt_reg = 0x71008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x71008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x71008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_gpu_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_pcie_ahb_clk = {
+	.halt_reg = 0x6b018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x6b018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52000,
+		.enable_mask = BIT(11),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_pcie_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_video_cv_cpu_ahb_clk = {
+	.halt_reg = 0x32014,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x32014,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x32014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_video_cv_cpu_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_video_cvp_ahb_clk = {
+	.halt_reg = 0x32008,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x32008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x32008,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_video_cvp_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_video_v_cpu_ahb_clk = {
+	.halt_reg = 0x32010,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x32010,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x32010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_video_v_cpu_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qmip_video_vcodec_ahb_clk = {
+	.halt_reg = 0x3200c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x3200c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3200c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qmip_video_vcodec_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_core_clk = {
+	.halt_reg = 0x23004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(8),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s0_clk = {
+	.halt_reg = 0x17004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(10),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s1_clk = {
+	.halt_reg = 0x17020,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(11),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s2_clk = {
+	.halt_reg = 0x1703c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(12),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s3_clk = {
+	.halt_reg = 0x17058,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(13),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s4_clk = {
+	.halt_reg = 0x17074,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(14),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s4_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s5_clk = {
+	.halt_reg = 0x17090,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(15),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s5_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s5_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s6_clk = {
+	.halt_reg = 0x170ac,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(16),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s6_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s6_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s7_clk = {
+	.halt_reg = 0x170c8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(17),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s7_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s7_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s8_clk = {
+	.halt_reg = 0x170e4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(14),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s8_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s8_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s9_clk = {
+	.halt_reg = 0x17100,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(15),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s9_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_i2c_s9_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_i2c_s_ahb_clk = {
+	.halt_reg = 0x23000,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x23000,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(7),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_i2c_s_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_core_2x_clk = {
+	.halt_reg = 0x2315c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(18),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_core_2x_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_core_clk = {
+	.halt_reg = 0x23148,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(19),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_qspi_ref_clk = {
+	.halt_reg = 0x188bc,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(29),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_qspi_ref_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_qspi_ref_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s0_clk = {
+	.halt_reg = 0x18004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(22),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s1_clk = {
+	.halt_reg = 0x18140,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(23),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s2_clk = {
+	.halt_reg = 0x1827c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(24),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s3_clk = {
+	.halt_reg = 0x18290,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(25),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s4_clk = {
+	.halt_reg = 0x183cc,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(26),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s4_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s5_clk = {
+	.halt_reg = 0x18508,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(27),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s5_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s5_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s6_clk = {
+	.halt_reg = 0x18644,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(28),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s6_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s6_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap1_s7_clk = {
+	.halt_reg = 0x18780,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(16),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap1_s7_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap1_s7_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_core_2x_clk = {
+	.halt_reg = 0x232b4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(3),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_core_2x_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_core_clk = {
+	.halt_reg = 0x232a0,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_core_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_ibi_ctrl_2_clk = {
+	.halt_reg = 0x1e9ec,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x1e9ec,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(27),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_ibi_ctrl_2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_ibi_ctrl_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_ibi_ctrl_3_clk = {
+	.halt_reg = 0x1e9f0,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x1e9f0,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(28),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_ibi_ctrl_3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_ibi_ctrl_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s0_clk = {
+	.halt_reg = 0x1e004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(4),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s1_clk = {
+	.halt_reg = 0x1e140,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(5),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s2_clk = {
+	.halt_reg = 0x1e27c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(6),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s2_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s2_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s3_clk = {
+	.halt_reg = 0x1e3b8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(7),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s3_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s3_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s4_clk = {
+	.halt_reg = 0x1e4f4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(8),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s4_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s4_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s5_clk = {
+	.halt_reg = 0x1e630,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(9),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s5_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s5_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s6_clk = {
+	.halt_reg = 0x1e76c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(10),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s6_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s6_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap2_s7_clk = {
+	.halt_reg = 0x1e8a8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(17),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap2_s7_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_qupv3_wrap2_s7_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_1_m_ahb_clk = {
+	.halt_reg = 0x23140,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x23140,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(20),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap_1_m_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_1_s_ahb_clk = {
+	.halt_reg = 0x23144,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x23144,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52008,
+		.enable_mask = BIT(21),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap_1_s_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_2_ibi_2_ahb_clk = {
+	.halt_reg = 0x1e9e4,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x1e9e4,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(25),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap_2_ibi_2_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_2_ibi_3_ahb_clk = {
+	.halt_reg = 0x1e9e8,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x1e9e8,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(26),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap_2_ibi_3_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_2_m_ahb_clk = {
+	.halt_reg = 0x23298,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x23298,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(2),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap_2_m_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_qupv3_wrap_2_s_ahb_clk = {
+	.halt_reg = 0x2329c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x2329c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x52010,
+		.enable_mask = BIT(1),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_qupv3_wrap_2_s_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc2_ahb_clk = {
+	.halt_reg = 0x14014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x14014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_sdcc2_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc2_apps_clk = {
+	.halt_reg = 0x14004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x14004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_sdcc2_apps_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_sdcc2_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc4_ahb_clk = {
+	.halt_reg = 0x16014,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x16014,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_sdcc4_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_sdcc4_apps_clk = {
+	.halt_reg = 0x16004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x16004,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_sdcc4_apps_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_sdcc4_apps_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_ahb_clk = {
+	.halt_reg = 0x77028,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x77028,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x77028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_ahb_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_axi_clk = {
+	.halt_reg = 0x77018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x77018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x77018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_axi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_axi_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_ice_core_clk = {
+	.halt_reg = 0x7707c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x7707c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7707c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_ice_core_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_ice_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_phy_aux_clk = {
+	.halt_reg = 0x770bc,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x770bc,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x770bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_phy_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_rx_symbol_0_clk = {
+	.halt_reg = 0x77030,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x77030,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_rx_symbol_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_rx_symbol_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_rx_symbol_1_clk = {
+	.halt_reg = 0x770d8,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x770d8,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_rx_symbol_1_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_rx_symbol_1_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_tx_symbol_0_clk = {
+	.halt_reg = 0x7702c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x7702c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_tx_symbol_0_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_tx_symbol_0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_ufs_phy_unipro_core_clk = {
+	.halt_reg = 0x7706c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.hwcg_reg = 0x7706c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x7706c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_ufs_phy_unipro_core_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_ufs_phy_unipro_core_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_prim_master_clk = {
+	.halt_reg = 0x39018,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb30_prim_master_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb30_prim_master_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_prim_mock_utmi_clk = {
+	.halt_reg = 0x3902c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3902c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb30_prim_mock_utmi_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb30_prim_mock_utmi_postdiv_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb30_prim_sleep_clk = {
+	.halt_reg = 0x39028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb30_prim_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_phy_aux_clk = {
+	.halt_reg = 0x39064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39064,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb3_prim_phy_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_phy_com_aux_clk = {
+	.halt_reg = 0x39068,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x39068,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb3_prim_phy_com_aux_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb3_prim_phy_aux_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_usb3_prim_phy_pipe_clk = {
+	.halt_reg = 0x3906c,
+	.halt_check = BRANCH_HALT_DELAY,
+	.hwcg_reg = 0x3906c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x3906c,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_usb3_prim_phy_pipe_clk",
+			.parent_hws = (const struct clk_hw*[]) {
+				&gcc_usb3_prim_phy_pipe_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_video_axi0_clk = {
+	.halt_reg = 0x32018,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x32018,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x32018,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_video_axi0_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gcc_video_axi1_clk = {
+	.halt_reg = 0x32028,
+	.halt_check = BRANCH_HALT_SKIP,
+	.hwcg_reg = 0x32028,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x32028,
+		.enable_mask = BIT(0),
+		.hw.init = &(const struct clk_init_data) {
+			.name = "gcc_video_axi1_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc gcc_pcie_0_gdsc = {
+	.gdscr = 0x6b004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.collapse_ctrl = 0x5214c,
+	.collapse_mask = BIT(0),
+	.pd = {
+		.name = "gcc_pcie_0_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
+};
+
+static struct gdsc gcc_pcie_0_phy_gdsc = {
+	.gdscr = 0x6c000,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x2,
+	.collapse_ctrl = 0x5214c,
+	.collapse_mask = BIT(2),
+	.pd = {
+		.name = "gcc_pcie_0_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE | VOTABLE,
+};
+
+static struct gdsc gcc_ufs_mem_phy_gdsc = {
+	.gdscr = 0x9e000,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x2,
+	.pd = {
+		.name = "gcc_ufs_mem_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc gcc_ufs_phy_gdsc = {
+	.gdscr = 0x77004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_ufs_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE | POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc gcc_usb30_prim_gdsc = {
+	.gdscr = 0x39004,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0xf,
+	.pd = {
+		.name = "gcc_usb30_prim_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc gcc_usb3_phy_gdsc = {
+	.gdscr = 0x50018,
+	.en_rest_wait_val = 0x2,
+	.en_few_wait_val = 0x2,
+	.clk_dis_wait_val = 0x2,
+	.pd = {
+		.name = "gcc_usb3_phy_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
+};
+
+static struct clk_regmap *gcc_sm8750_clocks[] = {
+	[GCC_AGGRE_NOC_PCIE_AXI_CLK] = &gcc_aggre_noc_pcie_axi_clk.clkr,
+	[GCC_AGGRE_UFS_PHY_AXI_CLK] = &gcc_aggre_ufs_phy_axi_clk.clkr,
+	[GCC_AGGRE_USB3_PRIM_AXI_CLK] = &gcc_aggre_usb3_prim_axi_clk.clkr,
+	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
+	[GCC_CAMERA_HF_AXI_CLK] = &gcc_camera_hf_axi_clk.clkr,
+	[GCC_CAMERA_SF_AXI_CLK] = &gcc_camera_sf_axi_clk.clkr,
+	[GCC_CFG_NOC_PCIE_ANOC_AHB_CLK] = &gcc_cfg_noc_pcie_anoc_ahb_clk.clkr,
+	[GCC_CFG_NOC_USB3_PRIM_AXI_CLK] = &gcc_cfg_noc_usb3_prim_axi_clk.clkr,
+	[GCC_CNOC_PCIE_SF_AXI_CLK] = &gcc_cnoc_pcie_sf_axi_clk.clkr,
+	[GCC_DDRSS_GPU_AXI_CLK] = &gcc_ddrss_gpu_axi_clk.clkr,
+	[GCC_DDRSS_PCIE_SF_QTB_CLK] = &gcc_ddrss_pcie_sf_qtb_clk.clkr,
+	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
+	[GCC_EVA_AXI0_CLK] = &gcc_eva_axi0_clk.clkr,
+	[GCC_EVA_AXI0C_CLK] = &gcc_eva_axi0c_clk.clkr,
+	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
+	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
+	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
+	[GCC_GP2_CLK_SRC] = &gcc_gp2_clk_src.clkr,
+	[GCC_GP3_CLK] = &gcc_gp3_clk.clkr,
+	[GCC_GP3_CLK_SRC] = &gcc_gp3_clk_src.clkr,
+	[GCC_GPLL0] = &gcc_gpll0.clkr,
+	[GCC_GPLL0_OUT_EVEN] = &gcc_gpll0_out_even.clkr,
+	[GCC_GPLL1] = &gcc_gpll1.clkr,
+	[GCC_GPLL4] = &gcc_gpll4.clkr,
+	[GCC_GPLL7] = &gcc_gpll7.clkr,
+	[GCC_GPLL9] = &gcc_gpll9.clkr,
+	[GCC_GPU_GEMNOC_GFX_CLK] = &gcc_gpu_gemnoc_gfx_clk.clkr,
+	[GCC_GPU_GPLL0_CLK_SRC] = &gcc_gpu_gpll0_clk_src.clkr,
+	[GCC_GPU_GPLL0_DIV_CLK_SRC] = &gcc_gpu_gpll0_div_clk_src.clkr,
+	[GCC_PCIE_0_AUX_CLK] = &gcc_pcie_0_aux_clk.clkr,
+	[GCC_PCIE_0_AUX_CLK_SRC] = &gcc_pcie_0_aux_clk_src.clkr,
+	[GCC_PCIE_0_CFG_AHB_CLK] = &gcc_pcie_0_cfg_ahb_clk.clkr,
+	[GCC_PCIE_0_MSTR_AXI_CLK] = &gcc_pcie_0_mstr_axi_clk.clkr,
+	[GCC_PCIE_0_PHY_RCHNG_CLK] = &gcc_pcie_0_phy_rchng_clk.clkr,
+	[GCC_PCIE_0_PHY_RCHNG_CLK_SRC] = &gcc_pcie_0_phy_rchng_clk_src.clkr,
+	[GCC_PCIE_0_PIPE_CLK] = &gcc_pcie_0_pipe_clk.clkr,
+	[GCC_PCIE_0_PIPE_CLK_SRC] = &gcc_pcie_0_pipe_clk_src.clkr,
+	[GCC_PCIE_0_SLV_AXI_CLK] = &gcc_pcie_0_slv_axi_clk.clkr,
+	[GCC_PCIE_0_SLV_Q2A_AXI_CLK] = &gcc_pcie_0_slv_q2a_axi_clk.clkr,
+	[GCC_PDM2_CLK] = &gcc_pdm2_clk.clkr,
+	[GCC_PDM2_CLK_SRC] = &gcc_pdm2_clk_src.clkr,
+	[GCC_PDM_AHB_CLK] = &gcc_pdm_ahb_clk.clkr,
+	[GCC_PDM_XO4_CLK] = &gcc_pdm_xo4_clk.clkr,
+	[GCC_QMIP_CAMERA_CMD_AHB_CLK] = &gcc_qmip_camera_cmd_ahb_clk.clkr,
+	[GCC_QMIP_CAMERA_NRT_AHB_CLK] = &gcc_qmip_camera_nrt_ahb_clk.clkr,
+	[GCC_QMIP_CAMERA_RT_AHB_CLK] = &gcc_qmip_camera_rt_ahb_clk.clkr,
+	[GCC_QMIP_GPU_AHB_CLK] = &gcc_qmip_gpu_ahb_clk.clkr,
+	[GCC_QMIP_PCIE_AHB_CLK] = &gcc_qmip_pcie_ahb_clk.clkr,
+	[GCC_QMIP_VIDEO_CV_CPU_AHB_CLK] = &gcc_qmip_video_cv_cpu_ahb_clk.clkr,
+	[GCC_QMIP_VIDEO_CVP_AHB_CLK] = &gcc_qmip_video_cvp_ahb_clk.clkr,
+	[GCC_QMIP_VIDEO_V_CPU_AHB_CLK] = &gcc_qmip_video_v_cpu_ahb_clk.clkr,
+	[GCC_QMIP_VIDEO_VCODEC_AHB_CLK] = &gcc_qmip_video_vcodec_ahb_clk.clkr,
+	[GCC_QUPV3_I2C_CORE_CLK] = &gcc_qupv3_i2c_core_clk.clkr,
+	[GCC_QUPV3_I2C_S0_CLK] = &gcc_qupv3_i2c_s0_clk.clkr,
+	[GCC_QUPV3_I2C_S0_CLK_SRC] = &gcc_qupv3_i2c_s0_clk_src.clkr,
+	[GCC_QUPV3_I2C_S1_CLK] = &gcc_qupv3_i2c_s1_clk.clkr,
+	[GCC_QUPV3_I2C_S1_CLK_SRC] = &gcc_qupv3_i2c_s1_clk_src.clkr,
+	[GCC_QUPV3_I2C_S2_CLK] = &gcc_qupv3_i2c_s2_clk.clkr,
+	[GCC_QUPV3_I2C_S2_CLK_SRC] = &gcc_qupv3_i2c_s2_clk_src.clkr,
+	[GCC_QUPV3_I2C_S3_CLK] = &gcc_qupv3_i2c_s3_clk.clkr,
+	[GCC_QUPV3_I2C_S3_CLK_SRC] = &gcc_qupv3_i2c_s3_clk_src.clkr,
+	[GCC_QUPV3_I2C_S4_CLK] = &gcc_qupv3_i2c_s4_clk.clkr,
+	[GCC_QUPV3_I2C_S4_CLK_SRC] = &gcc_qupv3_i2c_s4_clk_src.clkr,
+	[GCC_QUPV3_I2C_S5_CLK] = &gcc_qupv3_i2c_s5_clk.clkr,
+	[GCC_QUPV3_I2C_S5_CLK_SRC] = &gcc_qupv3_i2c_s5_clk_src.clkr,
+	[GCC_QUPV3_I2C_S6_CLK] = &gcc_qupv3_i2c_s6_clk.clkr,
+	[GCC_QUPV3_I2C_S6_CLK_SRC] = &gcc_qupv3_i2c_s6_clk_src.clkr,
+	[GCC_QUPV3_I2C_S7_CLK] = &gcc_qupv3_i2c_s7_clk.clkr,
+	[GCC_QUPV3_I2C_S7_CLK_SRC] = &gcc_qupv3_i2c_s7_clk_src.clkr,
+	[GCC_QUPV3_I2C_S8_CLK] = &gcc_qupv3_i2c_s8_clk.clkr,
+	[GCC_QUPV3_I2C_S8_CLK_SRC] = &gcc_qupv3_i2c_s8_clk_src.clkr,
+	[GCC_QUPV3_I2C_S9_CLK] = &gcc_qupv3_i2c_s9_clk.clkr,
+	[GCC_QUPV3_I2C_S9_CLK_SRC] = &gcc_qupv3_i2c_s9_clk_src.clkr,
+	[GCC_QUPV3_I2C_S_AHB_CLK] = &gcc_qupv3_i2c_s_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP1_CORE_2X_CLK] = &gcc_qupv3_wrap1_core_2x_clk.clkr,
+	[GCC_QUPV3_WRAP1_CORE_CLK] = &gcc_qupv3_wrap1_core_clk.clkr,
+	[GCC_QUPV3_WRAP1_QSPI_REF_CLK] = &gcc_qupv3_wrap1_qspi_ref_clk.clkr,
+	[GCC_QUPV3_WRAP1_QSPI_REF_CLK_SRC] = &gcc_qupv3_wrap1_qspi_ref_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S0_CLK] = &gcc_qupv3_wrap1_s0_clk.clkr,
+	[GCC_QUPV3_WRAP1_S0_CLK_SRC] = &gcc_qupv3_wrap1_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S1_CLK] = &gcc_qupv3_wrap1_s1_clk.clkr,
+	[GCC_QUPV3_WRAP1_S1_CLK_SRC] = &gcc_qupv3_wrap1_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S2_CLK] = &gcc_qupv3_wrap1_s2_clk.clkr,
+	[GCC_QUPV3_WRAP1_S2_CLK_SRC] = &gcc_qupv3_wrap1_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S3_CLK] = &gcc_qupv3_wrap1_s3_clk.clkr,
+	[GCC_QUPV3_WRAP1_S3_CLK_SRC] = &gcc_qupv3_wrap1_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S4_CLK] = &gcc_qupv3_wrap1_s4_clk.clkr,
+	[GCC_QUPV3_WRAP1_S4_CLK_SRC] = &gcc_qupv3_wrap1_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S5_CLK] = &gcc_qupv3_wrap1_s5_clk.clkr,
+	[GCC_QUPV3_WRAP1_S5_CLK_SRC] = &gcc_qupv3_wrap1_s5_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S6_CLK] = &gcc_qupv3_wrap1_s6_clk.clkr,
+	[GCC_QUPV3_WRAP1_S6_CLK_SRC] = &gcc_qupv3_wrap1_s6_clk_src.clkr,
+	[GCC_QUPV3_WRAP1_S7_CLK] = &gcc_qupv3_wrap1_s7_clk.clkr,
+	[GCC_QUPV3_WRAP1_S7_CLK_SRC] = &gcc_qupv3_wrap1_s7_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_CORE_2X_CLK] = &gcc_qupv3_wrap2_core_2x_clk.clkr,
+	[GCC_QUPV3_WRAP2_CORE_CLK] = &gcc_qupv3_wrap2_core_clk.clkr,
+	[GCC_QUPV3_WRAP2_IBI_CTRL_0_CLK_SRC] = &gcc_qupv3_wrap2_ibi_ctrl_0_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_IBI_CTRL_2_CLK] = &gcc_qupv3_wrap2_ibi_ctrl_2_clk.clkr,
+	[GCC_QUPV3_WRAP2_IBI_CTRL_3_CLK] = &gcc_qupv3_wrap2_ibi_ctrl_3_clk.clkr,
+	[GCC_QUPV3_WRAP2_S0_CLK] = &gcc_qupv3_wrap2_s0_clk.clkr,
+	[GCC_QUPV3_WRAP2_S0_CLK_SRC] = &gcc_qupv3_wrap2_s0_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S1_CLK] = &gcc_qupv3_wrap2_s1_clk.clkr,
+	[GCC_QUPV3_WRAP2_S1_CLK_SRC] = &gcc_qupv3_wrap2_s1_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S2_CLK] = &gcc_qupv3_wrap2_s2_clk.clkr,
+	[GCC_QUPV3_WRAP2_S2_CLK_SRC] = &gcc_qupv3_wrap2_s2_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S3_CLK] = &gcc_qupv3_wrap2_s3_clk.clkr,
+	[GCC_QUPV3_WRAP2_S3_CLK_SRC] = &gcc_qupv3_wrap2_s3_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S4_CLK] = &gcc_qupv3_wrap2_s4_clk.clkr,
+	[GCC_QUPV3_WRAP2_S4_CLK_SRC] = &gcc_qupv3_wrap2_s4_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S5_CLK] = &gcc_qupv3_wrap2_s5_clk.clkr,
+	[GCC_QUPV3_WRAP2_S5_CLK_SRC] = &gcc_qupv3_wrap2_s5_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S6_CLK] = &gcc_qupv3_wrap2_s6_clk.clkr,
+	[GCC_QUPV3_WRAP2_S6_CLK_SRC] = &gcc_qupv3_wrap2_s6_clk_src.clkr,
+	[GCC_QUPV3_WRAP2_S7_CLK] = &gcc_qupv3_wrap2_s7_clk.clkr,
+	[GCC_QUPV3_WRAP2_S7_CLK_SRC] = &gcc_qupv3_wrap2_s7_clk_src.clkr,
+	[GCC_QUPV3_WRAP_1_M_AHB_CLK] = &gcc_qupv3_wrap_1_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_1_S_AHB_CLK] = &gcc_qupv3_wrap_1_s_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_2_IBI_2_AHB_CLK] = &gcc_qupv3_wrap_2_ibi_2_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_2_IBI_3_AHB_CLK] = &gcc_qupv3_wrap_2_ibi_3_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_2_M_AHB_CLK] = &gcc_qupv3_wrap_2_m_ahb_clk.clkr,
+	[GCC_QUPV3_WRAP_2_S_AHB_CLK] = &gcc_qupv3_wrap_2_s_ahb_clk.clkr,
+	[GCC_SDCC2_AHB_CLK] = &gcc_sdcc2_ahb_clk.clkr,
+	[GCC_SDCC2_APPS_CLK] = &gcc_sdcc2_apps_clk.clkr,
+	[GCC_SDCC2_APPS_CLK_SRC] = &gcc_sdcc2_apps_clk_src.clkr,
+	[GCC_SDCC4_AHB_CLK] = &gcc_sdcc4_ahb_clk.clkr,
+	[GCC_SDCC4_APPS_CLK] = &gcc_sdcc4_apps_clk.clkr,
+	[GCC_SDCC4_APPS_CLK_SRC] = &gcc_sdcc4_apps_clk_src.clkr,
+	[GCC_UFS_PHY_AHB_CLK] = &gcc_ufs_phy_ahb_clk.clkr,
+	[GCC_UFS_PHY_AXI_CLK] = &gcc_ufs_phy_axi_clk.clkr,
+	[GCC_UFS_PHY_AXI_CLK_SRC] = &gcc_ufs_phy_axi_clk_src.clkr,
+	[GCC_UFS_PHY_ICE_CORE_CLK] = &gcc_ufs_phy_ice_core_clk.clkr,
+	[GCC_UFS_PHY_ICE_CORE_CLK_SRC] = &gcc_ufs_phy_ice_core_clk_src.clkr,
+	[GCC_UFS_PHY_PHY_AUX_CLK] = &gcc_ufs_phy_phy_aux_clk.clkr,
+	[GCC_UFS_PHY_PHY_AUX_CLK_SRC] = &gcc_ufs_phy_phy_aux_clk_src.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_0_CLK] = &gcc_ufs_phy_rx_symbol_0_clk.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC] = &gcc_ufs_phy_rx_symbol_0_clk_src.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_1_CLK] = &gcc_ufs_phy_rx_symbol_1_clk.clkr,
+	[GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC] = &gcc_ufs_phy_rx_symbol_1_clk_src.clkr,
+	[GCC_UFS_PHY_TX_SYMBOL_0_CLK] = &gcc_ufs_phy_tx_symbol_0_clk.clkr,
+	[GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC] = &gcc_ufs_phy_tx_symbol_0_clk_src.clkr,
+	[GCC_UFS_PHY_UNIPRO_CORE_CLK] = &gcc_ufs_phy_unipro_core_clk.clkr,
+	[GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC] = &gcc_ufs_phy_unipro_core_clk_src.clkr,
+	[GCC_USB30_PRIM_MASTER_CLK] = &gcc_usb30_prim_master_clk.clkr,
+	[GCC_USB30_PRIM_MASTER_CLK_SRC] = &gcc_usb30_prim_master_clk_src.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_CLK] = &gcc_usb30_prim_mock_utmi_clk.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC] = &gcc_usb30_prim_mock_utmi_clk_src.clkr,
+	[GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC] = &gcc_usb30_prim_mock_utmi_postdiv_clk_src.clkr,
+	[GCC_USB30_PRIM_SLEEP_CLK] = &gcc_usb30_prim_sleep_clk.clkr,
+	[GCC_USB3_PRIM_PHY_AUX_CLK] = &gcc_usb3_prim_phy_aux_clk.clkr,
+	[GCC_USB3_PRIM_PHY_AUX_CLK_SRC] = &gcc_usb3_prim_phy_aux_clk_src.clkr,
+	[GCC_USB3_PRIM_PHY_COM_AUX_CLK] = &gcc_usb3_prim_phy_com_aux_clk.clkr,
+	[GCC_USB3_PRIM_PHY_PIPE_CLK] = &gcc_usb3_prim_phy_pipe_clk.clkr,
+	[GCC_USB3_PRIM_PHY_PIPE_CLK_SRC] = &gcc_usb3_prim_phy_pipe_clk_src.clkr,
+	[GCC_VIDEO_AXI0_CLK] = &gcc_video_axi0_clk.clkr,
+	[GCC_VIDEO_AXI1_CLK] = &gcc_video_axi1_clk.clkr,
+};
+
+static struct gdsc *gcc_sm8750_gdscs[] = {
+	[GCC_PCIE_0_GDSC] = &gcc_pcie_0_gdsc,
+	[GCC_PCIE_0_PHY_GDSC] = &gcc_pcie_0_phy_gdsc,
+	[GCC_UFS_MEM_PHY_GDSC] = &gcc_ufs_mem_phy_gdsc,
+	[GCC_UFS_PHY_GDSC] = &gcc_ufs_phy_gdsc,
+	[GCC_USB30_PRIM_GDSC] = &gcc_usb30_prim_gdsc,
+	[GCC_USB3_PHY_GDSC] = &gcc_usb3_phy_gdsc,
+};
+
+static const struct qcom_reset_map gcc_sm8750_resets[] = {
+	[GCC_CAMERA_BCR] = { 0x26000 },
+	[GCC_DISPLAY_BCR] = { 0x27000 },
+	[GCC_EVA_BCR] = { 0x9f000 },
+	[GCC_EVA_AXI0_CLK_ARES] = { 0x9f008, 2 },
+	[GCC_EVA_AXI0C_CLK_ARES] = { 0x9f018, 2 },
+	[GCC_GPU_BCR] = { 0x71000 },
+	[GCC_PCIE_0_BCR] = { 0x6b000 },
+	[GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
+	[GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
+	[GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
+	[GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
+	[GCC_PCIE_PHY_BCR] = { 0x6f000 },
+	[GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x6f00c },
+	[GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
+	[GCC_PCIE_RSCC_BCR] = { 0x11000 },
+	[GCC_PDM_BCR] = { 0x33000 },
+	[GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
+	[GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
+	[GCC_QUPV3_WRAPPER_I2C_BCR] = { 0x17000 },
+	[GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
+	[GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
+	[GCC_SDCC2_BCR] = { 0x14000 },
+	[GCC_SDCC4_BCR] = { 0x16000 },
+	[GCC_UFS_PHY_BCR] = { 0x77000 },
+	[GCC_USB30_PRIM_BCR] = { 0x39000 },
+	[GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
+	[GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
+	[GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
+	[GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
+	[GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
+	[GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
+	[GCC_VIDEO_BCR] = { 0x32000 },
+	[GCC_VIDEO_AXI0_CLK_ARES] = { 0x32018, 2 },
+	[GCC_VIDEO_AXI1_CLK_ARES] = { 0x32028, 2 },
+};
+
+
+static const struct clk_rcg_dfs_data gcc_dfs_clocks[] = {
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_qspi_ref_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s0_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s1_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s3_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s4_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s5_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s6_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap1_s7_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s0_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s1_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s2_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s3_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s4_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s5_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s6_clk_src),
+	DEFINE_RCG_DFS(gcc_qupv3_wrap2_s7_clk_src),
+};
+
+static const struct regmap_config gcc_sm8750_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x1f41f0,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc gcc_sm8750_desc = {
+	.config = &gcc_sm8750_regmap_config,
+	.clks = gcc_sm8750_clocks,
+	.num_clks = ARRAY_SIZE(gcc_sm8750_clocks),
+	.resets = gcc_sm8750_resets,
+	.num_resets = ARRAY_SIZE(gcc_sm8750_resets),
+	.gdscs = gcc_sm8750_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_sm8750_gdscs),
+};
+
+static const struct of_device_id gcc_sm8750_match_table[] = {
+	{ .compatible = "qcom,sm8750-gcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gcc_sm8750_match_table);
+
+static int gcc_sm8750_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = qcom_cc_map(pdev, &gcc_sm8750_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
+				       ARRAY_SIZE(gcc_dfs_clocks));
+	if (ret)
+		return ret;
+
+	/*
+	 * Keep clocks always enabled:
+	 *	gcc_cam_bist_mclk_ahb_clk
+	 *	gcc_camera_ahb_clk
+	 *	gcc_camera_xo_clk
+	 *	gcc_disp_ahb_clk
+	 *	gcc_eva_ahb_clk
+	 *	gcc_eva_xo_clk
+	 *	gcc_gpu_cfg_ahb_clk
+	 *	gcc_video_ahb_clk
+	 *	gcc_video_xo_clk
+	 *	gcc_pcie_rscc_cfg_ahb_clk
+	 *	gcc_pcie_rscc_xo_clk
+	 */
+	qcom_branch_set_clk_en(regmap, 0xa0004);
+	qcom_branch_set_clk_en(regmap, 0x26004);
+	qcom_branch_set_clk_en(regmap, 0x26034);
+	qcom_branch_set_clk_en(regmap, 0x27004);
+	qcom_branch_set_clk_en(regmap, 0x9f004);
+	qcom_branch_set_clk_en(regmap, 0x9f01c);
+	qcom_branch_set_clk_en(regmap, 0x71004);
+	qcom_branch_set_clk_en(regmap, 0x32004);
+	qcom_branch_set_clk_en(regmap, 0x32038);
+	regmap_update_bits(regmap, 0x52010, BIT(20), BIT(20));
+	regmap_update_bits(regmap, 0x52010, BIT(21), BIT(21));
+
+	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
+	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
+
+	return qcom_cc_really_probe(&pdev->dev, &gcc_sm8750_desc, regmap);
+}
+
+static struct platform_driver gcc_sm8750_driver = {
+	.probe = gcc_sm8750_probe,
+	.driver = {
+		.name = "gcc-sm8750",
+		.of_match_table = gcc_sm8750_match_table,
+	},
+};
+
+static int __init gcc_sm8750_init(void)
+{
+	return platform_driver_register(&gcc_sm8750_driver);
+}
+subsys_initcall(gcc_sm8750_init);
+
+static void __exit gcc_sm8750_exit(void)
+{
+	platform_driver_unregister(&gcc_sm8750_driver);
+}
+module_exit(gcc_sm8750_exit);
+
+MODULE_DESCRIPTION("QTI GCC SM8750 Driver");
+MODULE_LICENSE("GPL");

-- 
2.46.1


