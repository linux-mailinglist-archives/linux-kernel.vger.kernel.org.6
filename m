Return-Path: <linux-kernel+bounces-234748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A697B91CA59
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 03:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D3BCB2287C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 01:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70A61173F;
	Sat, 29 Jun 2024 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OgMbV9mf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24A6138;
	Sat, 29 Jun 2024 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719626080; cv=none; b=LFpqxDb2KiViCCefujZoJdXOa2JDuMxkhqVzbUhPtpwPVDPFa4DPPYgw99/wZk6mlDARqMceJ4XPfgqzkOfcouLTh8yuSw9BrlIAvxilYrwgXPQZiaXk6v6duIfZSery/4+jghRmS8BbHjcfToRh2eaLpbp3/2oxSn1PoOeCYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719626080; c=relaxed/simple;
	bh=/GQfBDJw7xykpxT1/TXPV27mUnfIzvwqIMP8IFZbckQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcRiRnHVx1U23m4NJ8yTusFFBLznfm7LMImyqdHdzboNImY+8TV8ivnrBhnUHfYyYTcUTBkmLu8hNawBGD6WND4iVOyXHWdB2+Fr1o18LXCMyIQG+UTlTGBmCav7eFkOMHMYqUeo34vi7MeciSaB936IdJyy2vC3hJ9zEICbz/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OgMbV9mf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SNU9tq020131;
	Sat, 29 Jun 2024 01:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sinBut3qStp+WDQ0auBrvP5cA7oV0uzJFIHa6cSUR/A=; b=OgMbV9mf7uOEKJPA
	q8B/pKcyc7KceR65SzYDeKxsxbqBMO0KsRkp/GIh4jKCYZ0JGvob3MP8QXYLcTde
	gG5c44QOe3XDLXe0VD4A4yy3col/NKuHcatAJLe/sMga+5rPHcicsCDHxgxW0hKr
	vT4UrYpQ2FboQEsUWli5kETRuNhZI2ibVbtuF4pkVlWr+Qm+i604VgpkP3xzyrrS
	vR4GWTtcKS8WKs8mmOK7cFYP+cRxxck4jo3O01ufnM7ayb91yUQz1pp6dyC4zHcd
	YVYKbYtufAupSEF5uzl82O//vx1qwhx9AoKyjFns80Nx0CpzT8pICBkhiALz5bDG
	aJFaPQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401ubvt9c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 01:54:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45T1sRcI017026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 29 Jun 2024 01:54:27 GMT
Received: from hu-akhilpo-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 18:54:22 -0700
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
To: freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Will
 Deacon" <will@kernel.org>
CC: Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Conor Dooley
	<conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>,
        <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/5] dt-bindings: arm-smmu: Add X1E80100 GPU SMMU
Date: Sat, 29 Jun 2024 07:19:37 +0530
Message-ID: <20240629015111.264564-5-quic_akhilpo@quicinc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240629015111.264564-1-quic_akhilpo@quicinc.com>
References: <20240629015111.264564-1-quic_akhilpo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r66KVX3Tt2TlDE5nYLCjBeFMJ5LTuwpu
X-Proofpoint-GUID: r66KVX3Tt2TlDE5nYLCjBeFMJ5LTuwpu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_18,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=995
 adultscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406290013

Update the devicetree bindings to support the gpu present in
X1E80100 platform.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

Changes in v2:
- New patch in v2

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 5c130cf06a21..7ef225d4d783 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -95,6 +95,7 @@ properties:
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
               - qcom,sm8650-smmu-500
+              - qcom,x1e80100-smmu-500
           - const: qcom,adreno-smmu
           - const: qcom,smmu-500
           - const: arm,mmu-500
@@ -520,6 +521,7 @@ allOf:
             - enum:
                 - qcom,sm8550-smmu-500
                 - qcom,sm8650-smmu-500
+                - qcom,x1e80100-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
             - const: arm,mmu-500
@@ -557,7 +559,6 @@ allOf:
               - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-              - qcom,x1e80100-smmu-500
     then:
       properties:
         clock-names: false
-- 
2.45.1


