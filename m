Return-Path: <linux-kernel+bounces-270740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F283F9444AE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8116C1F21E6B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D883158542;
	Thu,  1 Aug 2024 06:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VvXCQPoy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1F157485;
	Thu,  1 Aug 2024 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722494781; cv=none; b=WwcKxft9ZrIFlrz3A3g8AbiTTq15Qvs5u+Zcze/o4IlhcPDEILITiK8+QYt+hPB+I57IGAnzl615UufaGJnPt+iwUkA99DllqkVbSnNfCEUhsSW4CkLgxXokIeBG3A1Y9X5N1T/o0srmINIKM1RGfh7ZJFhWrbIJ0bCVIhTpaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722494781; c=relaxed/simple;
	bh=/w+LuyiehuoQOmgW5szWQzLu9BG3A4kyfYsruydpDnE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnxnJMzha29+euZ6n3t/It4rMNRywMZJ3vJKOMQsuneUcsJ7AR7J23iYUxFgSGtDXDCnn2He1W3sOAG5qWKqLpW8IRS155OLpdGppdTC4do1m+Nw7xLOHtngYsyT0ObaMqeS+YdnOPgSS18+a1qbmVMLflMqP75CBQdJT/PW0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VvXCQPoy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47120tth031483;
	Thu, 1 Aug 2024 06:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8/PGrtCu/nw9yK9UjzOwGi0VHWjtRnilWB9+2fUVZrI=; b=VvXCQPoyINGkae/m
	tNgnTl8lemAO0FPO+oNYSvGZfOGFrlAXZWAbR2rZgB2BMiOI/8a9ETyL9ESbWnd1
	TpdqBZP/I77pu/MxsuVrn9RbmYnWoRZ78NQhDZ75NR9zL9q3kG1SPk7/xOOS9RM/
	QHnD1mp04VtKKF3Om8TkzCSJ2u39B2KSVA8XNUNDT92YGuNV7liBXLQXUJX2aFTh
	fq767hzs02RCxGi8eR81yxiTycWhPU63TPhirlqq8s9+21jeXWHA6TfW/+QKvLbN
	HBmAfMsBhmEMMsf0Ft936s0jew0dvnlYyZ2yBxN735gZcG09Bc0A8bzmztLlCNHc
	Gky4wg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mqw7dxht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 06:46:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4716kC25023942
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 06:46:12 GMT
Received: from hu-jkona-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 31 Jul 2024 23:46:06 -0700
From: Jagadeesh Kona <quic_jkona@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Satya
 Priya Kakitapalli" <quic_skakitap@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH V4 2/2] dt-bindings: clock: qcom: Drop required-opps in required on SM8650 camcc
Date: Thu, 1 Aug 2024 12:14:48 +0530
Message-ID: <20240801064448.29626-3-quic_jkona@quicinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801064448.29626-1-quic_jkona@quicinc.com>
References: <20240801064448.29626-1-quic_jkona@quicinc.com>
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
X-Proofpoint-ORIG-GUID: b1Z__1SiHS0ITgBcUam6BXWOpRqKi71L
X-Proofpoint-GUID: b1Z__1SiHS0ITgBcUam6BXWOpRqKi71L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=954 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010037

On SM8650, the minimum voltage corner supported on MMCX from cmd-db is
sufficient for clock controllers to operate and there is no need to specify
the required-opps. Hence remove the required-opps property from the list of
required properties for SM8650 camcc bindings.

This fixes:

arch/arm64/boot/dts/qcom/sm8650-hdk.dtb: clock-controller@ade0000:
'required-opps' is a required property

arch/arm64/boot/dts/qcom/sm8650-mtp.dtb: clock-controller@ade0000:
'required-opps' is a required property

arch/arm64/boot/dts/qcom/sm8650-qrd.dtb: clock-controller@ade0000:
'required-opps' is a required property

Fixes: 1ae3f0578e0e ("dt-bindings: clock: qcom: Add SM8650 camera clock controller")
Reported-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Closes: https://lore.kernel.org/all/0f13ab6b-dff1-4b26-9707-704ae2e2b535@linaro.org/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407070147.C9c3oTqS-lkp@intel.com/
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
---
 .../bindings/clock/qcom,sm8450-camcc.yaml     | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
index f58edfc10f4c..26afbbe65511 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-camcc.yaml
@@ -21,9 +21,6 @@ description: |
     include/dt-bindings/clock/qcom,sm8650-camcc.h
     include/dt-bindings/clock/qcom,x1e80100-camcc.h
 
-allOf:
-  - $ref: qcom,gcc.yaml#
-
 properties:
   compatible:
     enum:
@@ -57,7 +54,21 @@ required:
   - compatible
   - clocks
   - power-domains
-  - required-opps
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc8280xp-camcc
+              - qcom,sm8450-camcc
+              - qcom,sm8550-camcc
+              - qcom,x1e80100-camcc
+    then:
+      required:
+        - required-opps
 
 unevaluatedProperties: false
 
-- 
2.45.2


