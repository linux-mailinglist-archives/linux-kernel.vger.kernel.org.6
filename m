Return-Path: <linux-kernel+bounces-391913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C17D9B8D44
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D7EB22EB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5788D15667B;
	Fri,  1 Nov 2024 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g9upk/BZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCE225757
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450797; cv=none; b=I9Q3bVEmq49UW9wt9ZBEfWI0oqZuGM34+lLvQ+vvPUyGYdLsf2II1IRmK+CAYaKGDqmdNDXxGMiz2TqXdMSrORIJy0Zom8mi1Dxh3CERDCHzgaWfP4ptUuSAG4x1bL1m7Ss4C1QUQ5HoZVveJtee78kE4bUYdu0StUj/pw3Gk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450797; c=relaxed/simple;
	bh=K1V3vdHigu99axIZm25bMypHk1ainthXgYopWI6Qc48=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nd65Zk0XP2nXcjF5QG1huTWNWVXOK0hvIUxHijP3pQSHtRlu/LMKYzX8Rk0LkDAyjlaxfXLJ4CqIJwEfe9EmupP0agcr9/tO20NY/269iUugHOnAeiNNeOPHUcdMxxOLpvzQTLlw5ikj1xVgjwcXP3JMYQMGjNpax8E5WnVG5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g9upk/BZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A14d2CM002440;
	Fri, 1 Nov 2024 08:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=kEacnyYxkFp32FAGX42OrlFB1RCx1qkrp2NUdwCUyIQ=; b=g9
	upk/BZyFl+6uG4SQjaSrCm5hwqK5uOg6cijR/CPSHItcLiQ4QXUbLdijEee+OVGk
	x9gMFE1PUohTvC2nBy5PvngrnFKCyuDLAcBevU8PmE4JMtSmQ046Z1IPMdHOlMef
	qehbyp8DuS/jJG3toEluOzFkdaioKt/3iS8MkKMQBrPYksKctiobnpHUJADj1GeK
	dJantyGK7oGzXWmz02zfcsvE/8R1yF/TfngcqIoO7/EWRCVRcFWvdJ1mzXvJD5yH
	0Ub++bKfHb1IEXFLYTRDPcv3+3hkligFEmQiwSnYtCIkeV8q7p57XD0k4GFRzA2P
	LQCUY2ijoMc5secmBioA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmn5ee7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 08:46:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A18kKXg014792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 08:46:20 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 01:46:16 -0700
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] arm64: defconfig: Enable STM protocol and source configs
Date: Fri, 1 Nov 2024 16:45:58 +0800
Message-ID: <20241101084558.36948-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jOVcNP3-4BL3zlHvbV3N46NMm11svx-H
X-Proofpoint-GUID: jOVcNP3-4BL3zlHvbV3N46NMm11svx-H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxlogscore=843
 priorityscore=1501 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010062

STM is used for logging useful softevens from various entities.
With STM and TMC sink enabled, there will be more buffer size to store
the logs. STM source and STM protocol need to be configured along with
STM device for STM function refer to Documentation/trace/stm.rst.
CONFIG_CORESIGHT_STM is already added as module. Add Coresight STM
source and Protocol configs as module so that STM functions can be
used.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
Changes in v5:
- Update commit message.

Changes in v4:
- Remove Ftrace config.

Changes in v3:
- update commit message.

Changes in v2:
- select ftrace config explicitly.
 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..ac11cd1a7c06 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1599,6 +1599,11 @@ CONFIG_NVMEM_SNVS_LPGPR=y
 CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_UNIPHIER_EFUSE=y
+CONFIG_STM_PROTO_BASIC=m
+CONFIG_STM_PROTO_SYS_T=m
+CONFIG_STM_DUMMY=m
+CONFIG_STM_SOURCE_CONSOLE=m
+CONFIG_STM_SOURCE_HEARTBEAT=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_ALTERA_CVP=m
 CONFIG_FPGA_MGR_STRATIX10_SOC=m
-- 
2.17.1


