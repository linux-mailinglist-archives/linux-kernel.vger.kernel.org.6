Return-Path: <linux-kernel+bounces-324352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3202974B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043E71C20D2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B413B58D;
	Wed, 11 Sep 2024 07:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j1RD6bUr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB6127E18;
	Wed, 11 Sep 2024 07:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040081; cv=none; b=uBXpBlppU3lrnKGi14KV9bJxL7ojhAJ9y+SUhY7wXeInUKJKiAsUlisu2ERplTQCa29W80KB8mZ9qGqnA6/c5b1laroC2m6mLfyqCnNnQDSKldIVD+klPCyTm9v3qUWPAYFkI3kE68MTeDeDHbfD3XejqX61Pgrt9yOEC/K5JGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040081; c=relaxed/simple;
	bh=7OaRAY5sH7K002fpqf5X6EL++YyIotZiIy8ypIgxIkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrTqkXigDBl1ekZs9/Ru0yYIK99K3IYF2M89fZ8Go5TC3SVdTGAIRNnJJ7lI4DLkfIsg1dSXdpnESRlgVe81qiKplvt1PHHqUvhVjQca7bT59T9AwBcoPjkw+NvgjaZG4ZTyZT8J/BL77+/IFOAb01gUxghahSOI0UW+D7t9VV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j1RD6bUr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AK49mx031020;
	Wed, 11 Sep 2024 07:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WBADym/GmM8dmzYv6s89eu9aInPEfKbNVb9H6EA7+0=; b=j1RD6bUrHdr7IFfq
	+BZ/H4xR4goK4gl4fubW1gmPKglCBJ00F+/79SxFo07GKg24YKBMRVXnzReeOPow
	5Kahah2/rras1iGRB8ohd7qvbGXT34OO3UG3M0N1epOpPBjjHMt2ckBqjTqD0al1
	p76K+2g3ndBSuhS8Y1ubBm5y0Di4BvMD45tRtZZeQQXpuAunJC6G8B4weVjsnfxh
	iob3Qkdq8BZke/8wRCUfeoekPaA3RHh9umHGMEs9ebRKwZZLzn1dECoGA8TuG54N
	k5U+mANYA3c/FsZWmyKBWtqQpyhij/FHh2Baf4JRSUKrGjNKqoIpFrBSLbs0c8Sb
	MaUwFA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41j6gmvykh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 07:34:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48B7YYnS022828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Sep 2024 07:34:34 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Sep 2024 00:34:30 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <abel.vesa@linaro.org>,
        <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: Add X1E001DE Snapdragon Devkit for Windows
Date: Wed, 11 Sep 2024 13:03:37 +0530
Message-ID: <20240911073337.90577-3-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911073337.90577-1-quic_sibis@quicinc.com>
References: <20240911073337.90577-1-quic_sibis@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E3B42BWmrj1LHLEwfbyCpIaxZnRtJ4qU
X-Proofpoint-GUID: E3B42BWmrj1LHLEwfbyCpIaxZnRtJ4qU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409110056

Add initial support for x1e001de devkit platform. This includes:

-DSPs
-Ethernet (RTL8125BG) over the pcie 5 instance.
-NVme
-Wifi
-USB-C ports

Link: https://www.qualcomm.com/news/releases/2024/05/qualcomm-accelerates-development-for-copilot--pcs-with-snapdrago
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 813 +++++++++++++++++++
 2 files changed, 814 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index ae002c7cf126..1cbc7b91389d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -268,6 +268,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8650-qrd.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= x1e001de-devkit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e78100-lenovo-thinkpad-t14s.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-asus-vivobook-s15.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= x1e80100-crd.dtb
diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
new file mode 100644
index 000000000000..07b4e60d9b66
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -0,0 +1,813 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "x1e80100.dtsi"
+#include "x1e80100-pmics.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. X1E001DE Snapdragon Devkit for Windows";
+	compatible = "qcom,x1e001de-devkit", "qcom,x1e001de", "qcom,x1e80100";
+
+	aliases {
+		serial0 = &uart21;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	pmic-glink {
+		compatible = "qcom,x1e80100-pmic-glink",
+			     "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		orientation-gpios = <&tlmm 121 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
+				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
+
+		/* Back panel port closer to the RJ45 connector */
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss0_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss0_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		/* Back panel port closer to the audio jack */
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss1_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss1_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss1_qmpphy_out>;
+					};
+				};
+			};
+		};
+
+		/* Front panel port */
+		connector@2 {
+			compatible = "usb-c-connector";
+			reg = <2>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_ss2_hs_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_ss2_ss_in: endpoint {
+						remote-endpoint = <&usb_1_ss2_qmpphy_out>;
+					};
+				};
+			};
+		};
+	};
+
+	reserved-memory {
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_NVME_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 18 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nvme_reg_en>;
+	};
+
+	vreg_wwan: regulator-wwan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDX_VPH_PWR";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 221 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&wwan_sw_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8550-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-bob1-supply = <&vph_pwr>;
+		vdd-bob2-supply = <&vph_pwr>;
+		vdd-l1-l4-l10-supply = <&vreg_s4c_1p8>;
+		vdd-l2-l13-l14-supply = <&vreg_bob1>;
+		vdd-l5-l16-supply = <&vreg_bob1>;
+		vdd-l6-l7-supply = <&vreg_bob2>;
+		vdd-l8-l9-supply = <&vreg_bob1>;
+		vdd-l12-supply = <&vreg_s5j_1p2>;
+		vdd-l15-supply = <&vreg_s4c_1p8>;
+		vdd-l17-supply = <&vreg_bob2>;
+
+		vreg_bob1: bob1 {
+			regulator-name = "vreg_bob1";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob2: bob2 {
+			regulator-name = "vreg_bob2";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1b_1p8: ldo1 {
+			regulator-name = "vreg_l1b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2b_3p0: ldo2 {
+			regulator-name = "vreg_l2b_3p0";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4b_1p8: ldo4 {
+			regulator-name = "vreg_l4b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5b_3p0: ldo5 {
+			regulator-name = "vreg_l5b_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b_1p8: ldo6 {
+			regulator-name = "vreg_l6b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7b_2p8: ldo7 {
+			regulator-name = "vreg_l7b_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8b_3p0: ldo8 {
+			regulator-name = "vreg_l8b_3p0";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_2p9: ldo9 {
+			regulator-name = "vreg_l9b_2p9";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10b_1p8: ldo10 {
+			regulator-name = "vreg_l10b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12b_1p2: ldo12 {
+			regulator-name = "vreg_l12b_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13b_3p0: ldo13 {
+			regulator-name = "vreg_l13b_3p0";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14b_3p0: ldo14 {
+			regulator-name = "vreg_l14b_3p0";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l15b_1p8: ldo15 {
+			regulator-name = "vreg_l15b_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l16b_2p9: ldo16 {
+			regulator-name = "vreg_l16b_2p9";
+			regulator-min-microvolt = <2912000>;
+			regulator-max-microvolt = <2912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17b_2p5: ldo17 {
+			regulator-name = "vreg_l17b_2p5";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2504000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-l1-supply = <&vreg_s5j_1p2>;
+		vdd-l2-supply = <&vreg_s1f_0p7>;
+		vdd-l3-supply = <&vreg_s1f_0p7>;
+		vdd-s4-supply = <&vph_pwr>;
+
+		vreg_s4c_1p8: smps4 {
+			regulator-name = "vreg_s4c_1p8";
+			regulator-min-microvolt = <1856000>;
+			regulator-max-microvolt = <2000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1c_1p2: ldo1 {
+			regulator-name = "vreg_l1c_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2c_0p8: ldo2 {
+			regulator-name = "vreg_l2c_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_0p8: ldo3 {
+			regulator-name = "vreg_l3c_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pmc8380-rpmh-regulators";
+		qcom,pmic-id = "d";
+
+		vdd-l1-supply = <&vreg_s1f_0p7>;
+		vdd-l2-supply = <&vreg_s1f_0p7>;
+		vdd-l3-supply = <&vreg_s4c_1p8>;
+		vdd-s1-supply = <&vph_pwr>;
+
+		vreg_l1d_0p8: ldo1 {
+			regulator-name = "vreg_l1d_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2d_0p9: ldo2 {
+			regulator-name = "vreg_l2d_0p9";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3d_1p8: ldo3 {
+			regulator-name = "vreg_l3d_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-3 {
+		compatible = "qcom,pmc8380-rpmh-regulators";
+		qcom,pmic-id = "e";
+
+		vdd-l2-supply = <&vreg_s1f_0p7>;
+		vdd-l3-supply = <&vreg_s5j_1p2>;
+
+		vreg_l2e_0p8: ldo2 {
+			regulator-name = "vreg_l2e_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3e_1p2: ldo3 {
+			regulator-name = "vreg_l3e_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-4 {
+		compatible = "qcom,pmc8380-rpmh-regulators";
+		qcom,pmic-id = "f";
+
+		vdd-l1-supply = <&vreg_s5j_1p2>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-supply = <&vreg_s5j_1p2>;
+		vdd-s1-supply = <&vph_pwr>;
+
+		vreg_s1f_0p7: smps1 {
+			regulator-name = "vreg_s1f_0p7";
+			regulator-min-microvolt = <700000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1f_1p0: ldo1 {
+			regulator-name = "vreg_l1f_1p0";
+			regulator-min-microvolt = <1024000>;
+			regulator-max-microvolt = <1024000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_1p0: ldo2 {
+			regulator-name = "vreg_l2f_1p0";
+			regulator-min-microvolt = <1024000>;
+			regulator-max-microvolt = <1024000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3f_1p0: ldo3 {
+			regulator-name = "vreg_l3f_1p0";
+			regulator-min-microvolt = <1024000>;
+			regulator-max-microvolt = <1024000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-6 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "i";
+
+		vdd-l1-supply = <&vreg_s4c_1p8>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-supply = <&vreg_s1f_0p7>;
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+
+		vreg_s1i_0p9: smps1 {
+			regulator-name = "vreg_s1i_0p9";
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2i_1p0: smps2 {
+			regulator-name = "vreg_s2i_1p0";
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1i_1p8: ldo1 {
+			regulator-name = "vreg_l1i_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2i_1p2: ldo2 {
+			regulator-name = "vreg_l2i_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3i_0p8: ldo3 {
+			regulator-name = "vreg_l3i_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-7 {
+		compatible = "qcom,pm8550ve-rpmh-regulators";
+		qcom,pmic-id = "j";
+
+		vdd-l1-supply = <&vreg_s1f_0p7>;
+		vdd-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-supply = <&vreg_s1f_0p7>;
+		vdd-s5-supply = <&vph_pwr>;
+
+		vreg_s5j_1p2: smps5 {
+			regulator-name = "vreg_s5j_1p2";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1j_0p8: ldo1 {
+			regulator-name = "vreg_l1j_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2j_1p2: ldo2 {
+			regulator-name = "vreg_l2j_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3j_0p8: ldo3 {
+			regulator-name = "vreg_l3j_0p8";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&pcie4 {
+	perst-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
+	pinctrl-0 = <&pcie4_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l3i_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&pcie5 {
+	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_wwan>;
+
+	pinctrl-0 = <&pcie5_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&pcie5_phy {
+	vdda-phy-supply = <&vreg_l3i_0p8>;
+	vdda-pll-supply = <&vreg_l3e_1p2>;
+
+	status = "okay";
+};
+
+&pcie6a {
+	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie6a_default>;
+
+	status = "okay";
+};
+
+&pcie6a_phy {
+	vdda-phy-supply = <&vreg_l1d_0p8>;
+	vdda-pll-supply = <&vreg_l2j_1p2>;
+
+	status = "okay";
+};
+
+&qupv3_0 {
+	status = "okay";
+};
+
+&qupv3_1 {
+	status = "okay";
+};
+
+&qupv3_2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/x1e80100/devkit/qcadsp8380.mbn",
+			"qcom/x1e80100/devkit/adsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/x1e80100/devkit/qccdsp8380.mbn",
+			"qcom/x1e80100/devkit/cdsp_dtbs.elf";
+
+	status = "okay";
+};
+
+&smb2360_0_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l2b_3p0>;
+};
+
+&smb2360_1_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l14b_3p0>;
+};
+
+&smb2360_2 {
+	status = "okay";
+};
+
+&smb2360_2_eusb2_repeater {
+	vdd18-supply = <&vreg_l3d_1p8>;
+	vdd3-supply = <&vreg_l8b_3p0>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <34 2>, /* Unused */
+			       <44 4>, /* SPI (TPM) */
+			       <238 1>; /* UFS Reset */
+
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie4_default: pcie4-default-state {
+		clkreq-n-pins {
+			pins = "gpio147";
+			function = "pcie4_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio146";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio148";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie5_default: pcie5-default-state {
+		clkreq-n-pins {
+			pins = "gpio150";
+			function = "pcie5_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio149";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio151";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie6a_default: pcie6a-default-state {
+		clkreq-n-pins {
+			pins = "gpio153";
+			function = "pcie6a_clk";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio152";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio154";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	wwan_sw_en: wwan-sw-en-state {
+		pins = "gpio221";
+		function = "gpio";
+		drive-strength = <4>;
+		bias-disable;
+	};
+};
+
+&uart21 {
+	compatible = "qcom,geni-debug-uart";
+	status = "okay";
+};
+
+&usb_1_ss0_hsphy {
+	vdd-supply = <&vreg_l3j_0p8>;
+	vdda12-supply = <&vreg_l2j_1p2>;
+
+	phys = <&smb2360_0_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l1j_0p8>;
+
+	status = "okay";
+};
+
+&usb_1_ss0 {
+	status = "okay";
+};
+
+&usb_1_ss0_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_ss0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss0_hs_in>;
+};
+
+&usb_1_ss0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+};
+
+&usb_1_ss1_hsphy {
+	vdd-supply = <&vreg_l3j_0p8>;
+	vdda12-supply = <&vreg_l2j_1p2>;
+
+	phys = <&smb2360_1_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
+	status = "okay";
+};
+
+&usb_1_ss1 {
+	status = "okay";
+};
+
+&usb_1_ss1_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_ss1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss1_hs_in>;
+};
+
+&usb_1_ss1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+};
+
+&usb_1_ss2_hsphy {
+	vdd-supply = <&vreg_l3j_0p8>;
+	vdda12-supply = <&vreg_l2j_1p2>;
+
+	phys = <&smb2360_2_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
+	status = "okay";
+};
+
+&usb_1_ss2 {
+	status = "okay";
+};
+
+&usb_1_ss2_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_ss2_dwc3_hs {
+	remote-endpoint = <&pmic_glink_ss2_hs_in>;
+};
+
+&usb_1_ss2_qmpphy_out {
+	remote-endpoint = <&pmic_glink_ss2_ss_in>;
+};
-- 
2.34.1


