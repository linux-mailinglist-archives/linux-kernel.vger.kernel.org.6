Return-Path: <linux-kernel+bounces-513345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC143A34939
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F91161B35
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC6207A11;
	Thu, 13 Feb 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QtFAjul/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705D204C2A;
	Thu, 13 Feb 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463069; cv=none; b=UM/Hr5qZm48Yi+GFnOkt/9ILifO0bS8v9abTlvJsZlKxeQvji46o1rPomZ+joZP6so0VmsJba6gqlloRvzy7jy6VPToWvJDo2BGcdpbxTOIQtFK8z4gsKdJASIg+zOGCaUzwc/ULUWyCz21Bn6rykmEcfUEB5mdRM1km7G5mkrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463069; c=relaxed/simple;
	bh=ZXR6uZPPSNjlV7BwzA/XQwlQEaqWKUi2GtqQZmT2W4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cdGOPkaBpdE2sRSMc1Zwy0HHbuYOkUbcrMK6qxuLnKfAAJSrZXp1X2mHXZUbeN6EvoPbrs59jY4SbxMDLAI6omTAjMiAeDnTigpG3/kPuYXHz05vy1kMYxtkKIVt0+FxYLpXvR8/dcv0kn7wlAe6ptOMmqPW94t2VXodenH/VX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QtFAjul/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D9hFcw028583;
	Thu, 13 Feb 2025 16:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	l2Ajh8Y73Ln476N472eQTy0WATeWGxbxbqWxTVMVTzs=; b=QtFAjul/6+G6fsWk
	jvs5lpSW5y6Hfg15qICJV1hinctqW7RK0STMsEzTpKnpzjAQDv/QwSDXUg/L0/ov
	9tg91TWEx+B/l48vHkRCE4cORHIv/j8yzU3cI7ZLlamTZlqrSQRCYncgxJcF2Xn1
	VPf06wab0ayNnz24aju9ZLhFTx5J/7PGFjq+3pi/x9xOZqcN31uTwotckF319V1F
	Tn9i0Tfhct3p8jdb0sy2G0/wN3SHwEM1pwM/wVTt5dI+h8HRQZqTUxrTrxolZ4Gm
	5PgkLwk5vjm7XxAmmqai2Gsv+XyFBuKIKZIXxndxlKJraJMivhW+jgjWTU6KqMXC
	8pOQcA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44sebn91ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 16:10:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51DGAuwO005150
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 16:10:56 GMT
Received: from [10.213.111.143] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Feb
 2025 08:10:50 -0800
From: Akhil P Oommen <quic_akhilpo@quicinc.com>
Date: Thu, 13 Feb 2025 21:40:08 +0530
Subject: [PATCH 3/5] dt-bindings: display/msm/gmu: Add Adreno 623 GMU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-a623-gpu-support-v1-3-993c65c39fd2@quicinc.com>
References: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
In-Reply-To: <20250213-a623-gpu-support-v1-0-993c65c39fd2@quicinc.com>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        "Konrad
 Dybcio" <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Jie Zhang <quic_jiezh@quicinc.com>,
        "Akhil P
 Oommen" <quic_akhilpo@quicinc.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739463031; l=830;
 i=quic_akhilpo@quicinc.com; s=20240726; h=from:subject:message-id;
 bh=gQj1VQiYMN/f9a0siBHb0FvuUZ2PAbq1RbNDN5wcv0s=;
 b=rSzMOu1pZwQZgAMowcAREdCPgYHi93RTb8iOJO9pLBEaeyNLTaLlSLLLT6wBqgiUwiHC67XL1
 DCe99YT81nyC8K9Mp8WZ6RATy/dDyHY2ViHp51CIC785+EiOm6L5JGw
X-Developer-Key: i=quic_akhilpo@quicinc.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n9IlOs_hYxPqIdkaJe7m_npzoY8aDl_s
X-Proofpoint-ORIG-GUID: n9IlOs_hYxPqIdkaJe7m_npzoY8aDl_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=984 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502130118

From: Jie Zhang <quic_jiezh@quicinc.com>

Document Adreno 623 GMU in the dt-binding specification.

Signed-off-by: Jie Zhang <quic_jiezh@quicinc.com>
Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index ab884e236429..4392aa7a4ffe 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -123,6 +123,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,adreno-gmu-623.0
               - qcom,adreno-gmu-635.0
               - qcom,adreno-gmu-660.1
               - qcom,adreno-gmu-663.0

-- 
2.45.2


