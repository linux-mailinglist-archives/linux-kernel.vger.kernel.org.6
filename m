Return-Path: <linux-kernel+bounces-375945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0188B9A9D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6329283650
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997C19AA43;
	Tue, 22 Oct 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pyp9hGVn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CDE199EA7;
	Tue, 22 Oct 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587330; cv=none; b=NWCgv10bWtI/V1/flFrQWSFZ5SR3H5vm1Nri7W+qQ04W56O+8H9R4RtByH5Pm8rKMfuRuUfRJNpl7D99Ytk6IL4/yI0O5qbsBdpn6mfP3XVp1PpY7UhlA1AHg3RGm6iAGNjuWDUsakgeLTem3/XbBromElfaykvvcSgc0rRnpos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587330; c=relaxed/simple;
	bh=Bu8TDLJO/Pajbvm6M+YMG9w7/Wx2E956N48d3vNzr8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qc+P5/ibIeIx0HtKBzPHEcaHzgi3icORUFENp6kA6zMk42uMnZY/VB3K4haykhCDD8EdJLjHEek9F/N4qma/h19Ruh51qKtJl4zViiQKQIVaHHfIHrD2doupTqcnGlgI2zZPBAeFxcFa4tW5eWbkHsE1ACN6Iu/QKbB2YUT1kuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pyp9hGVn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M8bxpU001170;
	Tue, 22 Oct 2024 08:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A/z+Va26yeJvq5i3i1fXkOXjLo/FqXBEQQWOgrImndw=; b=Pyp9hGVn8oQ9xtaF
	URTqRPuQYBDtjPyff3D4d5/TP15rCWLhjk6OVre6wxI1z3BWvNfGF+4F+aCbE2d7
	nrlfmduV/QAvRWklbh6sJGVU7iwi8ZLveBRF8XeNSbAwO5aMb+m0XHOl0aEEQ/62
	Ue237b/ZoIt0Wir2/BVVsjq1rF3BvLAlmiyyrQStGgn0c1CZYp7Vwh1z2tv4EamX
	MeChvLnmF9Nh5Y6jujDp+y8ecLzQKNb5T8Vvxj871t7kPDtWsVSTrAtUssCW70/U
	yiCMSGv0FHQKbFGUQRv9cUm+qOFvYF1Qz+6JqsgzZSxt6O9l4cXLp64OwXXR8S+a
	zv936w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42dmj13k9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 08:55:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49M8tIAt002628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 08:55:18 GMT
Received: from lijuang2-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 01:55:11 -0700
From: Lijuan Gao <quic_lijuang@quicinc.com>
Date: Tue, 22 Oct 2024 16:54:35 +0800
Subject: [PATCH v4 7/7] arm64: defconfig: enable clock controller,
 interconnect and pinctrl for QCS615
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241022-add_initial_support_for_qcs615-v4-7-0a551c6dd342@quicinc.com>
References: <20241022-add_initial_support_for_qcs615-v4-0-0a551c6dd342@quicinc.com>
In-Reply-To: <20241022-add_initial_support_for_qcs615-v4-0-0a551c6dd342@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>
CC: <kernel@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lijuan Gao <quic_lijuang@quicinc.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729587284; l=1428;
 i=quic_lijuang@quicinc.com; s=20240827; h=from:subject:message-id;
 bh=Bu8TDLJO/Pajbvm6M+YMG9w7/Wx2E956N48d3vNzr8U=;
 b=ShYbnzHB3S7f6c8EGUqCSodlb+mhDnc4QwNLmEZBrlfNnJx0dqC7VXcWOGnSqrlFw074oe8Xd
 wl+z4GISSPWA8LNT4viWS1RCRWE+SrgVU/QvWQuxvKWtcyACVqM56ER
X-Developer-Key: i=quic_lijuang@quicinc.com; a=ed25519;
 pk=1zeM8FpQK/J1jSFHn8iXHeb3xt7F/3GvHv7ET2RNJxE=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y1nBKKyu0OnfRQCIoTSqrU2QwM6LR6lZ
X-Proofpoint-ORIG-GUID: Y1nBKKyu0OnfRQCIoTSqrU2QwM6LR6lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=688 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220056

Enable clock controller, interconnect and pinctrl for Qualcomm
QCS615 platform to boot to UART console.

The serial engine depends on gcc, interconnect and pinctrl. Since
the serial console driver is only available as built-in, so these
configs needs be built-in for the UART device to probe and register
the console.

Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 36b33b9f1704..fd0dfa9ebae0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -607,6 +607,7 @@ CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_MSM8998=y
 CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
+CONFIG_PINCTRL_QCS615=y
 CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
 CONFIG_PINCTRL_SA8775P=y
@@ -1323,6 +1324,7 @@ CONFIG_MSM_MMCC_8998=m
 CONFIG_QCM_GCC_2290=y
 CONFIG_QCM_DISPCC_2290=m
 CONFIG_QCS_GCC_404=y
+CONFIG_QCS_GCC_615=y
 CONFIG_SC_CAMCC_7280=m
 CONFIG_QDU_GCC_1000=y
 CONFIG_SC_CAMCC_8280XP=m
@@ -1629,6 +1631,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8996=y
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCM2290=y
 CONFIG_INTERCONNECT_QCOM_QCS404=m
+CONFIG_INTERCONNECT_QCOM_QCS615=y
 CONFIG_INTERCONNECT_QCOM_QDU1000=y
 CONFIG_INTERCONNECT_QCOM_SA8775P=y
 CONFIG_INTERCONNECT_QCOM_SC7180=y

-- 
2.46.0


