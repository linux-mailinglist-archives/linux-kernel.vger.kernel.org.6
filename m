Return-Path: <linux-kernel+bounces-184180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5E8CA3A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 23:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CF731F21EA1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A53A139CFB;
	Mon, 20 May 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i50mf5/T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F941D531;
	Mon, 20 May 2024 21:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716238838; cv=none; b=ZqHSBSAywW7kkpQGz5PzF8Z0C34U5Tc92bjgspHWcs2UMsfq6E59kDSR8jmxKMAYdRvtJRqIngepd0TWM6vYiw3DJI4L04G77dOe9GpGIgnyntRo47pw0tV95DYMh+zefGHB84gwQdMte3gOUn0ZT+bs0LFHisByr06fHjzHg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716238838; c=relaxed/simple;
	bh=WiIsDcxGKSNo3IEj19mx++4Cdt1GgDRPXa444+VvdAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Olp3wmjItEfV5wAfkmpqoJI/9ocG5n7w+bTPw+VGcXT+SiZZkKk+8mXCshFJYlE0xpuaqGKrNPCPqcclQwqywOa6p2jwNreteQ+0s28Iev92AnePXlyiy5yK8HR38g3hH+1aAqvHTs9wL+IcPQxYDIAezKb9SMfHSHGvyS152tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i50mf5/T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KBnaW0014011;
	Mon, 20 May 2024 21:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=qcppdkim1; bh=hS7tQ/y
	eLAV8ZIfktRMHN2xygzBU8HL5cfKi/32s6AM=; b=i50mf5/TbHxRVev7JV+UeBb
	piF4j+gI0FHNHzAjTr8I0NNuYpxv29L+ejfE8scQuEVTDIr57MqGlUEGsXF9wFCu
	N4ZRhw87ThNSe5MmaFeEJSBz5j5PHhXqbWztU7w0f/v/Sj2Myr1sPRlC4dNAPuWt
	k5ivWcIodLVorPWbPD9WO/g409HNDqxJ8vhN1HGZngbD5L68vX8mGRIvdvfEIv0/
	oLSAjvmoT046Ks7kzlp3hdVI6PNkEr4u4A1xyiZCxOdcV1VBdbd26ubmQHTkN1ca
	4ZGysyytCICobfmJs7nATSOJL1sO76fglNCdNgLTGeaytnposAxz5B4mNWNLZtw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psnc77r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 21:00:31 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44KL0UUR006686;
	Mon, 20 May 2024 21:00:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3y6ndmsehn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 21:00:30 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44KL0UCf006681;
	Mon, 20 May 2024 21:00:30 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-uchalich-lv.qualcomm.com [10.81.89.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 44KL0Uf6006680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 21:00:30 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4184210)
	id 492A6641; Mon, 20 May 2024 14:00:24 -0700 (PDT)
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: [PATCH v5 4/5] arm64: dts: qcom: sm8550: Add Broadcast_AND register in LLCC block
Date: Mon, 20 May 2024 14:00:16 -0700
Message-Id: <e34eff8d5c61e95dcc974837527a96cf05da0d65.1716228054.git.quic_uchalich@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716228054.git.quic_uchalich@quicinc.com>
References: <cover.1716228054.git.quic_uchalich@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: isP3IeQxAI--gjXx4aV39euZHc5agxwL
X-Proofpoint-ORIG-GUID: isP3IeQxAI--gjXx4aV39euZHc5agxwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_11,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200167

Chipsets before SM8450 have only one broadcast register (Broadcast_OR)
which is used to broadcast writes and check for status bit 0 only in
all channels.
From SM8450 onwards, a new Broadcast_AND region was added
which checks for status bit 1. This hasn't been updated and Broadcast_OR
region was wrongly being used to check for status bit 1 all along.
Hence mapping Broadcast_AND region's address space to LLCC in SM8550.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 3904348075f6..ee387e6f9832 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4263,12 +4263,14 @@ system-cache-controller@25000000 {
 			      <0 0x25200000 0 0x200000>,
 			      <0 0x25400000 0 0x200000>,
 			      <0 0x25600000 0 0x200000>,
-			      <0 0x25800000 0 0x200000>;
+			      <0 0x25800000 0 0x200000>,
+			      <0 0x25a00000 0 0x200000>;
 			reg-names = "llcc0_base",
 				    "llcc1_base",
 				    "llcc2_base",
 				    "llcc3_base",
-				    "llcc_broadcast_base";
+				    "llcc_broadcast_base",
+				    "llcc_broadcast_and_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.34.1


