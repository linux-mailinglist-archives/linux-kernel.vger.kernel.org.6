Return-Path: <linux-kernel+bounces-211502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA99052C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49DE1C20EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836CA17C7A8;
	Wed, 12 Jun 2024 12:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ikAaxpqk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E407172762;
	Wed, 12 Jun 2024 12:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196114; cv=none; b=mKse0H+WoSM/+rXppEYXbwu93YNEzAVTeD4/H22Sp7haYyIR32mXbJ2VyhUDAXLyHsUBdhBpkmIw1QEWgiH9MoSk2omlJwKeB1uA/Y66m0pZ5u4FYQQU1Ms2R/JGtfW5E3xIaHVlM7woIfqgkCP2FwsdLkVi5o5xN/a2obVALZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196114; c=relaxed/simple;
	bh=nsOzgIGVh8i9darpIkpH96n/RS7dt193t1r9I4zBilo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2Wt/N1WwWlqzfjzlRuKjRfUF72sglyw+bjSeG7xPC6W/Z8eX9Q5pewaPgUGIl+oiE6GoGyrMb1bLqYTecjW/ZjloXConDc4eAH61eWVnXrxJBoa5CNagrVBSzwT5TqZ2ZR1ViVJ5f3tHryxhoqDnsGsuadzEvMR1c6Cdv3FJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ikAaxpqk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C4YDQR001288;
	Wed, 12 Jun 2024 12:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uCeQX9o7rZqWhhhCkhaPUKfVMlLEvloOp0eyMQjfCFk=; b=ikAaxpqkoDIFhepi
	7aF8GfZeOiACGKIfo6mWS3G9lNr3z5bvmvtGZPvyIH83jrSATGh1ZsNrQq+9z1Sb
	0cMlfKBZxLsuJLsEedDj9xHAAcdllD+HqGiPPLR6gp2YNfNMwBhOL+ZptQr37aBb
	iXRU6o/8meDKScgHU2ovRW9M5YaHma/ROkF0OIWo4GHMXRKVUt9GBKmD7NWXr17W
	5qZwMsse03Qo1aGVjFcBnPCOyhrsYNqq/ceCZwqPFv6f2z5ACYokasIO8ez0YGHT
	bRh4RUjT7fx2aFHsZF1ijMzopPcZ88aWIFiO1J+q0nTdHpCc6nlfisotsq9pbowy
	lQ6Ekg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yq4s093k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:41:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CCfjjJ016325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:41:45 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 05:41:40 -0700
From: Sibi Sankar <quic_sibis@quicinc.com>
To: <sudeep.holla@arm.com>, <cristian.marussi@arm.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.baryshkov@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_rgottimu@quicinc.com>,
        <quic_kshivnan@quicinc.com>, <quic_sibis@quicinc.com>,
        <conor+dt@kernel.org>, <quic_nkela@quicinc.com>,
        <quic_psodagud@quicinc.com>, <abel.vesa@linaro.org>
Subject: [PATCH V6 5/5] arm64: dts: qcom: x1e80100: Enable cpufreq
Date: Wed, 12 Jun 2024 18:10:56 +0530
Message-ID: <20240612124056.39230-6-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612124056.39230-1-quic_sibis@quicinc.com>
References: <20240612124056.39230-1-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: fPSKKh4nApuCd9MDb9JfN-UMtPQFYlm-
X-Proofpoint-ORIG-GUID: fPSKKh4nApuCd9MDb9JfN-UMtPQFYlm-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=938
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120092

Enable cpufreq on X1E80100 SoCs through the SCMI perf protocol node.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 63 ++++++++++++++++----------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 7b619db07694..d134dc4c7425 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -69,8 +69,8 @@ CPU0: cpu@0 {
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD0>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD0>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 
 			L2_0: l2-cache {
@@ -86,8 +86,8 @@ CPU1: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD1>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD1>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -97,8 +97,8 @@ CPU2: cpu@200 {
 			reg = <0x0 0x200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD2>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD2>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -108,8 +108,8 @@ CPU3: cpu@300 {
 			reg = <0x0 0x300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
-			power-domains = <&CPU_PD3>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD3>, <&scmi_dvfs 0>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -119,8 +119,8 @@ CPU4: cpu@10000 {
 			reg = <0x0 0x10000>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD4>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD4>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 
 			L2_1: l2-cache {
@@ -136,8 +136,8 @@ CPU5: cpu@10100 {
 			reg = <0x0 0x10100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD5>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD5>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -147,8 +147,8 @@ CPU6: cpu@10200 {
 			reg = <0x0 0x10200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD6>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD6>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -158,8 +158,8 @@ CPU7: cpu@10300 {
 			reg = <0x0 0x10300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
-			power-domains = <&CPU_PD7>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD7>, <&scmi_dvfs 1>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -169,8 +169,8 @@ CPU8: cpu@20000 {
 			reg = <0x0 0x20000>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD8>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD8>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 
 			L2_2: l2-cache {
@@ -186,8 +186,8 @@ CPU9: cpu@20100 {
 			reg = <0x0 0x20100>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD9>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD9>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -197,8 +197,8 @@ CPU10: cpu@20200 {
 			reg = <0x0 0x20200>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD10>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD10>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -208,8 +208,8 @@ CPU11: cpu@20300 {
 			reg = <0x0 0x20300>;
 			enable-method = "psci";
 			next-level-cache = <&L2_2>;
-			power-domains = <&CPU_PD11>;
-			power-domain-names = "psci";
+			power-domains = <&CPU_PD11>, <&scmi_dvfs 2>;
+			power-domain-names = "psci", "perf";
 			cpu-idle-states = <&CLUSTER_C4>;
 		};
 
@@ -309,6 +309,21 @@ scm: scm {
 			interconnects = <&aggre2_noc MASTER_CRYPTO QCOM_ICC_TAG_ALWAYS
 					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
 		};
+
+		scmi {
+			compatible = "arm,scmi";
+			mboxes = <&cpucp_mbox 0>, <&cpucp_mbox 2>;
+			mbox-names = "tx", "rx";
+			shmem = <&cpu_scp_lpri0>, <&cpu_scp_lpri1>;
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			scmi_dvfs: protocol@13 {
+				reg = <0x13>;
+				#power-domain-cells = <1>;
+			};
+		};
 	};
 
 	clk_virt: interconnect-0 {
-- 
2.34.1


