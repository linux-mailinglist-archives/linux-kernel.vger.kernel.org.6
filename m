Return-Path: <linux-kernel+bounces-333174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B897C4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B39B12825F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F86C194C79;
	Thu, 19 Sep 2024 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QuVCn1Go"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C3194AF3;
	Thu, 19 Sep 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731168; cv=none; b=qo0rKLEFJy4TnqotY+opNeX4p8FD1weG32pYNNbDPUpwYT5S24im32/7RcmQz2O3SmXvrW/oVHcwmZFZloqOR9GRntNSFdBDzxiJDj6WwoNoxiRNgy6BDAaFF072kJ3BHslILlttNVn3B6dBVZF5Nb4vdmaPMXd6n4KtdAYf6o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731168; c=relaxed/simple;
	bh=FwjzkBKAUoxgKvltQnTsmnQzYD1pHQ8zGf+uIa6EpxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=plWVsoCBEqdm9fbH0uu9epaER2oF2Wn/9W6n7Xtn+LpYwQ+pIbXPlNr7Sf/B4FFUYJNf8HeylGlnOWi7ZJyIPNBVNW55XtpKs2LPKQVPQCYEKgILUMPwSGyJvWKTvRgaRQ5qYRJ8v+1zgPDPcjBqf1nXkzaSKD5nIth/XAHMirw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QuVCn1Go; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48INmB8b008833;
	Thu, 19 Sep 2024 07:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WaB6BW4wZf+d4R8NWTbtSI4nWUWThp4oipflCYcrMg0=; b=QuVCn1Go4feGb8i+
	UYW7jSUyQwwj5wjGE/t4K/IRmaKcCnXBu+Rb9p3YJsEmcxUHUr2t2TxlxII9byis
	hwOwCouYzIFdnE3iJcCu/nFltAwImG2TOYcat/R1iarntGLXi6GSWG8arjkzsQeL
	EqJ+4xc49CZeIzoiQAFNNxthL1ccT+Hz/OO1zsdtkeuq3vO9JAH1t7S/bnwOCAf8
	149q/SHRa8G0TSEJpb7DQDTE8HH3qFruROXdZCftwT2c0IEO5BigWujUsCL1dmaP
	kVpVolDW27A+2ytAMZhIff6Q40TM+3GokRYfnVWhyYJ7nuHb5IFqCQn5FERpFWaN
	CTDCPw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4hfmgp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 07:32:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48J7Wbhn023038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 07:32:37 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Sep 2024 00:32:33 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Thu, 19 Sep 2024 13:02:17 +0530
Subject: [PATCH 3/4] dt-bindings: clock: qcom: Add QCS615 GCC clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240919-qcs615-clock-driver-v1-3-51c0cc92e3a2@quicinc.com>
References: <20240919-qcs615-clock-driver-v1-0-51c0cc92e3a2@quicinc.com>
In-Reply-To: <20240919-qcs615-clock-driver-v1-0-51c0cc92e3a2@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>
X-Mailer: b4 0.14-dev-f7c49
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nXcDk2g_6aD3LM7ZZzPo4zbO-Ulj9tzP
X-Proofpoint-ORIG-GUID: nXcDk2g_6aD3LM7ZZzPo4zbO-Ulj9tzP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409190046

Add device tree bindings for global clock controller on QCS615 SoCs.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 .../devicetree/bindings/clock/qcom,qcs615-gcc.yaml |  59 ++++++
 include/dt-bindings/clock/qcom,qcs615-gcc.h        | 211 +++++++++++++++++++++
 2 files changed, 270 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,qcs615-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,qcs615-gcc.yaml
new file mode 100644
index 000000000000..fecc694cd71b
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,qcs615-gcc.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,qcs615-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Global Clock & Reset Controller on QCS615
+
+maintainers:
+  - Taniya Das <quic_tdas@quicinc.com>
+
+description: |
+  Qualcomm global clock control module provides the clocks, resets and power
+  domains on QCS615.
+
+  See also:: include/dt-bindings/clock/qcom,qcs615-gcc.h
+
+properties:
+  compatible:
+    const: qcom,qcs615-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Sleep clock source
+
+  clock-names:
+    items:
+      - const: bi_tcxo
+      - const: bi_tcxo_ao
+      - const: sleep_clk
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    clock-controller@100000 {
+      compatible = "qcom,qcs615-gcc";
+      reg = <0x00100000 0x1f0000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>;
+      clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,qcs615-gcc.h b/include/dt-bindings/clock/qcom,qcs615-gcc.h
new file mode 100644
index 000000000000..9704091636b8
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,qcs615-gcc.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_QCS615_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_QCS615_H
+
+/* GCC clocks */
+#define GPLL0_OUT_AUX2_DIV					0
+#define GPLL3_OUT_AUX2_DIV					1
+#define GPLL0							2
+#define GPLL3							3
+#define GPLL4							4
+#define GPLL6							5
+#define GPLL6_OUT_MAIN						6
+#define GPLL7							7
+#define GPLL8							8
+#define GPLL8_OUT_MAIN						9
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				10
+#define GCC_AGGRE_USB2_SEC_AXI_CLK				11
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				12
+#define GCC_AHB2PHY_EAST_CLK					13
+#define GCC_AHB2PHY_WEST_CLK					14
+#define GCC_BOOT_ROM_AHB_CLK					15
+#define GCC_CAMERA_AHB_CLK					16
+#define GCC_CAMERA_HF_AXI_CLK					17
+#define GCC_CAMERA_XO_CLK					18
+#define GCC_CE1_AHB_CLK						19
+#define GCC_CE1_AXI_CLK						20
+#define GCC_CE1_CLK						21
+#define GCC_CFG_NOC_USB2_SEC_AXI_CLK				22
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				23
+#define GCC_CPUSS_AHB_CLK					24
+#define GCC_CPUSS_AHB_CLK_SRC					25
+#define GCC_CPUSS_GNOC_CLK					26
+#define GCC_DDRSS_GPU_AXI_CLK					27
+#define GCC_DISP_AHB_CLK					28
+#define GCC_DISP_GPLL0_DIV_CLK_SRC				29
+#define GCC_DISP_HF_AXI_CLK					30
+#define GCC_DISP_XO_CLK						31
+#define GCC_EMAC_AXI_CLK					32
+#define GCC_EMAC_PTP_CLK					33
+#define GCC_EMAC_PTP_CLK_SRC					34
+#define GCC_EMAC_RGMII_CLK					35
+#define GCC_EMAC_RGMII_CLK_SRC					36
+#define GCC_EMAC_SLV_AHB_CLK					37
+#define GCC_GP1_CLK						38
+#define GCC_GP1_CLK_SRC						39
+#define GCC_GP2_CLK						40
+#define GCC_GP2_CLK_SRC						41
+#define GCC_GP3_CLK						42
+#define GCC_GP3_CLK_SRC						43
+#define GCC_GPU_CFG_AHB_CLK					44
+#define GCC_GPU_GPLL0_CLK_SRC					45
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				46
+#define GCC_GPU_IREF_CLK					47
+#define GCC_GPU_MEMNOC_GFX_CLK					48
+#define GCC_GPU_SNOC_DVM_GFX_CLK				49
+#define GCC_PCIE0_PHY_REFGEN_CLK				50
+#define GCC_PCIE_0_AUX_CLK					51
+#define GCC_PCIE_0_AUX_CLK_SRC					52
+#define GCC_PCIE_0_CFG_AHB_CLK					53
+#define GCC_PCIE_0_CLKREF_CLK					54
+#define GCC_PCIE_0_MSTR_AXI_CLK					55
+#define GCC_PCIE_0_PIPE_CLK					56
+#define GCC_PCIE_0_SLV_AXI_CLK					57
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				58
+#define GCC_PCIE_PHY_AUX_CLK					59
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC				60
+#define GCC_PDM2_CLK						61
+#define GCC_PDM2_CLK_SRC					62
+#define GCC_PDM_AHB_CLK						63
+#define GCC_PDM_XO4_CLK						64
+#define GCC_PRNG_AHB_CLK					65
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				66
+#define GCC_QMIP_DISP_AHB_CLK					67
+#define GCC_QMIP_PCIE_AHB_CLK					68
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				69
+#define GCC_QSPI_CNOC_PERIPH_AHB_CLK				70
+#define GCC_QSPI_CORE_CLK					71
+#define GCC_QSPI_CORE_CLK_SRC					72
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				73
+#define GCC_QUPV3_WRAP0_CORE_CLK				74
+#define GCC_QUPV3_WRAP0_S0_CLK					75
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				76
+#define GCC_QUPV3_WRAP0_S1_CLK					77
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				78
+#define GCC_QUPV3_WRAP0_S2_CLK					79
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				80
+#define GCC_QUPV3_WRAP0_S3_CLK					81
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				82
+#define GCC_QUPV3_WRAP0_S4_CLK					83
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				84
+#define GCC_QUPV3_WRAP0_S5_CLK					85
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				86
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				87
+#define GCC_QUPV3_WRAP1_CORE_CLK				88
+#define GCC_QUPV3_WRAP1_S0_CLK					89
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				90
+#define GCC_QUPV3_WRAP1_S1_CLK					91
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				92
+#define GCC_QUPV3_WRAP1_S2_CLK					93
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				94
+#define GCC_QUPV3_WRAP1_S3_CLK					95
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				96
+#define GCC_QUPV3_WRAP1_S4_CLK					97
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				98
+#define GCC_QUPV3_WRAP1_S5_CLK					99
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				100
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				101
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				102
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				103
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				104
+#define GCC_RX1_USB2_CLKREF_CLK					105
+#define GCC_RX3_USB2_CLKREF_CLK					106
+#define GCC_SDCC1_AHB_CLK					107
+#define GCC_SDCC1_APPS_CLK					108
+#define GCC_SDCC1_APPS_CLK_SRC					109
+#define GCC_SDCC1_ICE_CORE_CLK					110
+#define GCC_SDCC1_ICE_CORE_CLK_SRC				111
+#define GCC_SDCC2_AHB_CLK					112
+#define GCC_SDCC2_APPS_CLK					113
+#define GCC_SDCC2_APPS_CLK_SRC					114
+#define GCC_SDR_CORE_CLK					115
+#define GCC_SDR_CSR_HCLK					116
+#define GCC_SDR_PRI_MI2S_CLK					117
+#define GCC_SDR_SEC_MI2S_CLK					118
+#define GCC_SDR_WR0_MEM_CLK					119
+#define GCC_SDR_WR1_MEM_CLK					120
+#define GCC_SDR_WR2_MEM_CLK					121
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				122
+#define GCC_UFS_CARD_CLKREF_CLK					123
+#define GCC_UFS_MEM_CLKREF_CLK					124
+#define GCC_UFS_PHY_AHB_CLK					125
+#define GCC_UFS_PHY_AXI_CLK					126
+#define GCC_UFS_PHY_AXI_CLK_SRC					127
+#define GCC_UFS_PHY_ICE_CORE_CLK				128
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				129
+#define GCC_UFS_PHY_PHY_AUX_CLK					130
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				131
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				132
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				133
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				134
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				135
+#define GCC_USB20_SEC_MASTER_CLK				136
+#define GCC_USB20_SEC_MASTER_CLK_SRC				137
+#define GCC_USB20_SEC_MOCK_UTMI_CLK				138
+#define GCC_USB20_SEC_MOCK_UTMI_CLK_SRC				139
+#define GCC_USB20_SEC_SLEEP_CLK					140
+#define GCC_USB2_PRIM_CLKREF_CLK				141
+#define GCC_USB2_SEC_CLKREF_CLK					142
+#define GCC_USB2_SEC_PHY_AUX_CLK				143
+#define GCC_USB2_SEC_PHY_AUX_CLK_SRC				144
+#define GCC_USB2_SEC_PHY_COM_AUX_CLK				145
+#define GCC_USB2_SEC_PHY_PIPE_CLK				146
+#define GCC_USB30_PRIM_MASTER_CLK				147
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				148
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				149
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			150
+#define GCC_USB30_PRIM_SLEEP_CLK				151
+#define GCC_USB3_PRIM_CLKREF_CLK				152
+#define GCC_USB3_PRIM_PHY_AUX_CLK				153
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				154
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				155
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				156
+#define GCC_USB3_SEC_CLKREF_CLK					157
+#define GCC_VIDEO_AHB_CLK					158
+#define GCC_VIDEO_AXI0_CLK					159
+#define GCC_VIDEO_XO_CLK					160
+#define GCC_VSENSOR_CLK_SRC					161
+#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK			162
+#define GCC_UFS_PHY_AXI_HW_CTL_CLK				163
+#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK				164
+#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK				165
+#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK			166
+
+/* GCC Resets */
+#define GCC_EMAC_BCR                                            0
+#define GCC_QUSB2PHY_PRIM_BCR                                   1
+#define GCC_QUSB2PHY_SEC_BCR                                    2
+#define GCC_USB30_PRIM_BCR                                      3
+#define GCC_USB2_PHY_SEC_BCR                                    4
+#define GCC_USB3_DP_PHY_SEC_BCR                                 5
+#define GCC_USB3PHY_PHY_SEC_BCR                                 6
+#define GCC_PCIE_0_BCR                                          7
+#define GCC_PCIE_0_PHY_BCR                                      8
+#define GCC_PCIE_PHY_BCR                                        9
+#define GCC_PCIE_PHY_COM_BCR                                    10
+#define GCC_UFS_PHY_BCR                                         11
+#define GCC_USB20_SEC_BCR                                       12
+#define GCC_USB3_PHY_PRIM_SP0_BCR                               13
+#define GCC_USB3PHY_PHY_PRIM_SP0_BCR                            14
+#define GCC_SDCC1_BCR                                           15
+#define GCC_SDCC2_BCR                                           16
+
+/* GCC power domains */
+#define EMAC_GDSC						0
+#define PCIE_0_GDSC						1
+#define UFS_PHY_GDSC						2
+#define USB20_SEC_GDSC						3
+#define USB30_PRIM_GDSC						4
+#define HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_GDSC			5
+#define HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_GDSC			6
+#define HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_GDSC			7
+#define HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_GDSC			8
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC			9
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF_GDSC			10
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC			11
+
+#endif

-- 
2.45.2


