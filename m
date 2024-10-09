Return-Path: <linux-kernel+bounces-356927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523489968D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62A921C22B5E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F21B1940B3;
	Wed,  9 Oct 2024 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ss+3KZlS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14AE1922FB;
	Wed,  9 Oct 2024 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728473175; cv=none; b=R2BQiKa3c2h9TA79gY0YyGW2JYudfR5l1GXMQ9pWpocPvwKh9lLt5InuhpDh4zfcMb58Tp9Eaf1jrocdeIEghKG9Zkr/q6i2z+VJrWA7AN8+eLTR+bO4qcd7AOenF8xUFBwJTKC1uq4o9u1TeDlXyYLIP9B8xHiVuvqHwyxI1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728473175; c=relaxed/simple;
	bh=U7NA+JsrPdzN5kBsLH3uKGYHv+3ItrkYTzbs7HOm+1w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uas21OZmLkrkTRw5u+rcj8qiDiDPuCRhisAOSz7vhmWIrlSy0VW+sur6Fs14I3QHcgdJptceliVFjYOCXV3w17pHvpvOxDrswe8mWlI+sapuUSgeIkrCBj4tCPvuNQe/7AmIYeHWOpqFaHcRyzYxfeWqbzseAkIj2ew0GII+a6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ss+3KZlS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499B87fW001300;
	Wed, 9 Oct 2024 11:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NZVqJ6ITNZBxVmVOX6KXNNlxd4+e2WmL5nLNsFXn2Os=; b=Ss+3KZlSqyNa+hDH
	FaEMVh7WbLtZ6p4HNNLHpJe5xK85CgBTJ6sn+HArQ/SgdzcWhYudJjQ41DU4HwIA
	Ix83/C3rQzXfZc0q619mJ+EtCAT9Rla5WD8qoksocXW1grrp3gSCshHmwkkciJeP
	F8bXMHNGnutTaMW63dUJNsJgxilm6y0XWeoKWiCUYpjcF9vmKLPeozAHZ6T6uLJv
	qXDhv461k4fxxz0x1QBcrLlcziHoUmbIzoj0gIIzmM1eAf+RpR+fW8T+pFF8f4OZ
	Z8J10ULElYtHBn4JAXHtqsfbMldQaTYvOhlh6vPYJbdRdEq/n6gutXO/Mh5ZcJmH
	TOFXlA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4252wsun7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 11:25:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 499BPwwq012247
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Oct 2024 11:25:58 GMT
Received: from jiegan-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Oct 2024 04:25:52 -0700
From: Jie Gan <quic_jiegan@quicinc.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
	<mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v6 5/5] arm64: dts: qcom: Add CTCU and ETR nodes for SA8775p
Date: Wed, 9 Oct 2024 19:25:03 +0800
Message-ID: <20241009112503.1851585-6-quic_jiegan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009112503.1851585-1-quic_jiegan@quicinc.com>
References: <20241009112503.1851585-1-quic_jiegan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oE0T2CgVOLvOF8gyeGvbnquOGRI_WVG-
X-Proofpoint-GUID: oE0T2CgVOLvOF8gyeGvbnquOGRI_WVG-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090075

Add CTCU and ETR nodes in DT to enable related functions.

Signed-off-by: Jie Gan <quic_jiegan@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 160 ++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index e8dbc8d820a6..eefecc33aa08 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1912,6 +1912,35 @@ ice: crypto@1d88000 {
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};
 
+		ctcu@4001000 {
+			compatible = "qcom,sa8775p-ctcu";
+			reg = <0x0 0x4001000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb";
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ctcu_in0: endpoint {
+						remote-endpoint =
+						<&etr0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ctcu_in1: endpoint {
+						remote-endpoint =
+						<&etr1_out>;
+					};
+				};
+			};
+		};
+
 		stm: stm@4002000 {
 			compatible = "arm,coresight-stm", "arm,primecell";
 			reg = <0x0 0x4002000 0x0 0x1000>,
@@ -2115,6 +2144,129 @@ qdss_funnel_in1: endpoint {
 			};
 		};
 
+		replicator@4046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x4046000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				port {
+					qdss_rep_out0: endpoint {
+						remote-endpoint =
+						<&etr_rep_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					qdss_rep_in: endpoint {
+						remote-endpoint =
+						<&swao_rep_out0>;
+					};
+				};
+			};
+		};
+
+		tmc_etr: tmc@4048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x4048000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04c0 0x00>;
+
+			arm,scatter-gather;
+
+			out-ports {
+				port {
+					etr0_out: endpoint {
+						remote-endpoint =
+						<&ctcu_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					etr0_in: endpoint {
+						remote-endpoint =
+						<&etr_rep_out0>;
+					};
+				};
+			};
+		};
+
+		replicator@404e000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x0 0x404e000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					etr_rep_out0: endpoint {
+						remote-endpoint =
+						<&etr0_in>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					etr_rep_out1: endpoint {
+						remote-endpoint =
+						<&etr1_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					etr_rep_in: endpoint {
+						remote-endpoint =
+						<&qdss_rep_out0>;
+					};
+				};
+			};
+		};
+
+		tmc_etr1: tmc@404f000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x0 0x404f000 0x0 0x1000>;
+
+			clocks = <&aoss_qmp>;
+			clock-names = "apb_pclk";
+			iommus = <&apps_smmu 0x04a0 0x40>;
+
+			arm,scatter-gather;
+			arm,buffer-size = <0x400000>;
+
+			out-ports {
+				port {
+					etr1_out: endpoint {
+						remote-endpoint =
+						<&ctcu_in1>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					etr1_in: endpoint {
+						remote-endpoint =
+						<&etr_rep_out1>;
+					};
+				};
+			};
+		};
+
 		funnel@4b04000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0x0 0x4b04000 0x0 0x1000>;
@@ -2190,6 +2342,14 @@ out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
+				port@0 {
+					reg = <0>;
+					swao_rep_out0: endpoint {
+						remote-endpoint =
+						<&qdss_rep_in>;
+					};
+				};
+
 				port@1 {
 					reg = <1>;
 					swao_rep_out1: endpoint {
-- 
2.34.1


