Return-Path: <linux-kernel+bounces-328694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3457F978777
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 20:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68FAD1C215D1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 18:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB8012C530;
	Fri, 13 Sep 2024 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YPFJlkA3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35B12C489
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 18:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726250593; cv=none; b=KHzTYhCpv/+1ogvFaAxzNf/xhxGfQ0XYmve6MIJ4kumf78XbTxK7DfbwwcaCs+s/tGJbl706wqbMmQ/Kqxxpa+cKQvfeNXCw0RVkY90cMPQIOlAbFhRZN1Mo55tAhpT+RB8M/LopAie8AUvhf9QdyvDie9QKqSMByWw39CKPPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726250593; c=relaxed/simple;
	bh=KIHeaeEayN+Ydo6yEdiNp00KP6cY+SrZfAAZnNbI0Aw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=IVseXEiKFGi9su2gAITSAsczi38dgLe1BXGOlrWNXl0eh1Bo44O+0s12d4FdYBaaCgkThjy6k7F2N0ucfNPqd4eK+OWNJ6/DGXQdyRknfzrTMrKaQYxLHPitp+b+Sv0kwyK0Ohv4RIt+nkYP7BkcIF9DEU/O1NKHX34rKpfU404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YPFJlkA3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DAgZYZ005111;
	Fri, 13 Sep 2024 18:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Q/7ZcuILwZBV0A7i7UsOIq
	P2Q3us8B88wOf2he08q5w=; b=YPFJlkA3tX6hGqhUMrPJ1UC5rCzWqRx8myoX4G
	6/4prVVOxiC8mVW73B/njCIzLQ61lJOdqYHbIBHnCAPg4z4bxibl7s5RCcm62Tzb
	BYDdTjWJv7hbU1i9RsnU1tia6oCfjYPPtRZXOXZAyqzk5Xiujig5AgjnrXMGte1I
	Cwo7owqbna5S9Wl8BpFjFHuOLwkG9NsaRcLpZ741hcp9jZTFrrIs4U4rqkPf2jhz
	mfEimP40AKH24Y/c6An52Z6zvQ0uxwKWIl96SA8fyhVlMsb6CZz/5IP1pG5UvyYC
	CsdeCOmQJsvPE5hRb1Aam/GxMjTA23BEfEFMwlx83wAyFi/g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy739rnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 18:03:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48DI2weI019597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 18:02:59 GMT
Received: from hu-tdas-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Sep 2024 11:02:56 -0700
From: Taniya Das <quic_tdas@quicinc.com>
Date: Fri, 13 Sep 2024 23:32:41 +0530
Subject: [PATCH] arm64: defconfig: Enable sc7280 clock controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240913-qcm6490-clock-configs-v1-1-1586c72ee641@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAEB+5GYC/y3MQQrCMBCF4auUWTswTaoQryIumnHSDmpiEy2F0
 rsbtMvvwftXKJJVCpybFbLMWjTFivbQAI99HAT1Vg2GTEeutTjx89Q5Qn4kviOnGHQoSMa6YMn
 33h+hfl9Zgi6/7uX6d5bpU/Pvfdy2L54mUpB8AAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
X-Mailer: b4 0.14-dev-f7c49
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: b2y57yrrkRja2VXqj5bFvb0NAHtiL5Zz
X-Proofpoint-GUID: b2y57yrrkRja2VXqj5bFvb0NAHtiL5Zz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=500 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130129

Enable the SC7280 video, camera and audio clock controllers to enable
the video, camera and audio functionalities on Qualcomm RB3gen2.

Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..844ff1a0dc14 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1323,6 +1323,7 @@ CONFIG_MSM_MMCC_8998=m
 CONFIG_QCM_GCC_2290=y
 CONFIG_QCM_DISPCC_2290=m
 CONFIG_QCS_GCC_404=y
+CONFIG_SC_CAMCC_7280=m
 CONFIG_QDU_GCC_1000=y
 CONFIG_SC_CAMCC_8280XP=m
 CONFIG_SC_DISPCC_7280=m
@@ -1336,6 +1337,8 @@ CONFIG_SC_GCC_8280XP=y
 CONFIG_SC_GPUCC_7280=m
 CONFIG_SC_GPUCC_8280XP=m
 CONFIG_SC_LPASSCC_8280XP=m
+CONFIG_SC_LPASS_CORECC_7280=m
+CONFIG_SC_VIDEOCC_7280=m
 CONFIG_SDM_CAMCC_845=m
 CONFIG_SDM_GPUCC_845=y
 CONFIG_SDM_VIDEOCC_845=y

---
base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
change-id: 20240913-qcm6490-clock-configs-0239f30babb5

Best regards,
-- 
Taniya Das <quic_tdas@quicinc.com>


