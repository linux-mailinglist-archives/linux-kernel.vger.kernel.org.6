Return-Path: <linux-kernel+bounces-211500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B479052B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 14:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BA71F259F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66186178398;
	Wed, 12 Jun 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chT2Agmq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B9F176FB7;
	Wed, 12 Jun 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196103; cv=none; b=iFEwdgR6uf2cBf+Rk7R4XhPqfJSVQ9U2xvJdYMuyKeiqRh0FDPq/no2yo6+y91rNhSyXf0DPHjzmLJUJldgQqvlN6rmZA3WDCbe7aHSsiUlMXejPGcYG5Q5StgtI5qYN/lVdC+BWYbshYItdYApPGLFGYYWqoYBNdSTJEXtqVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196103; c=relaxed/simple;
	bh=v+Vps9sF5m9+vsfaYrdnZmlPPtCx1wkQO+UOwHLUBUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezmxyiC5ik7gZQedNeYsC2iZh83QCVuUE3PrLGPJE6SDi7oIx6Z/LBO1SkqG9fG9uMNIe/anHOUxenoRWa2PiKQV2VDF9217ggJR+bj3WkVqd6VQJl8aE4gfYs2Dj0KDxod82j6R8X0rdV6NN4D5K6ZGJX44JXa3v1cFyuJ2QYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chT2Agmq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C4Z0j0002481;
	Wed, 12 Jun 2024 12:41:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ziALlH0oAv5kJDkztUT150mKhOCRXSeu9LtrxBg1U2Y=; b=chT2AgmqX+Yev5Wq
	J8tZFTec0uiSBcp5moNBeX7iJeXZwu8MI4LflJKGdDdzWpovTjeCASi4Obn6CZVW
	FowuxgOz4TWFzl2PieZHGZSAArltT8WdBBlhw1E/jbJlPANSgmEsWlieHnS1Qkyn
	PUo1NvgtD1MqUBUPwXY4D1Y7z26M4zxJiw1LMwTfdeDS//dK6c+5RSi9yCymCKMu
	X8iRKH+Sf4XtkjdhyERA9p4UQQIKBN7kccNYfNwycgP0NhS6yw+BQcxmCXTAF+8z
	bg/ZMG2MIPRgGZDJSZSfM+VPaVEAqh6rcdmDwghzyWhjT+/L7gBgpXLmDLWniZBD
	6y5jPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yq4s093jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:41:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45CCfYSi000684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 12:41:34 GMT
Received: from hu-sibis-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 12 Jun 2024 05:41:28 -0700
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
Subject: [PATCH V6 3/5] arm64: dts: qcom: x1e80100: Resize GIC Redistributor register region
Date: Wed, 12 Jun 2024 18:10:54 +0530
Message-ID: <20240612124056.39230-4-quic_sibis@quicinc.com>
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
X-Proofpoint-GUID: V0YdmlZnLOJHslFq9_hy3yj2-UTXsyQO
X-Proofpoint-ORIG-GUID: V0YdmlZnLOJHslFq9_hy3yj2-UTXsyQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_06,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxlogscore=689
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120092

Resize the GICR register region as it currently seeps into the CPU Control
Processor mailbox RX region.

Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---

v5:
* Pick Rbs

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 9944c654851e..28ae10c24a5f 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5091,7 +5091,7 @@ apps_smmu: iommu@15000000 {
 		intc: interrupt-controller@17000000 {
 			compatible = "arm,gic-v3";
 			reg = <0 0x17000000 0 0x10000>,     /* GICD */
-			      <0 0x17080000 0 0x480000>;    /* GICR * 12 */
+			      <0 0x17080000 0 0x300000>;    /* GICR * 12 */
 
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-- 
2.34.1


