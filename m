Return-Path: <linux-kernel+bounces-373946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786C79A5FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42216281F18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E361E231E;
	Mon, 21 Oct 2024 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hu8i5kkK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30721E1C24
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501437; cv=none; b=hCzV3WohxC9u7/I9bGaWzMMCeJfgEtOLbZhgJ9IrnBv4s2Wsche/yTtA31tnmvT6FG9n87KMqGUEGXRt7Y+MyLrGVx+t9jDJv7OIqKRK3paJzaQuMVYBPtSTNUfPnulb74cEDSTBxCeE1HOmfgeVhwJ2EFMWr/vzM6GP9ainvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501437; c=relaxed/simple;
	bh=M5om2NYgQzV9S6XHtWClztMxXF0CcNOZBTvcuqqfLH8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jqn8e3tkHTWS/Tf9xgmVNcEbZ6g7BvQqVhBqybvZXRHynDH4L/qE46JqixxoK/KRP1XakEzYueZYtEW/ggwHpHFJOsA+AsIzvfkPQZi0kcNU3KgXG/UHGdFH1btTi0GOQiDJIIKMdd7DHIzQOlBUHMAPwOU/Seb1Zz7JjuJi2Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hu8i5kkK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KMi8K4019347;
	Mon, 21 Oct 2024 09:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=idjSNcB2qQ5J14nefQeUT+GG3fTiDOIcmLy7nCwHmW0=; b=Hu
	8i5kkKFnQpMv/7Y2+ywUvRY54a2e3qA6BN0pYErKkdKT59sWgiRVVbVZlixKGgMI
	XvykQFnKjIk+soZNzMcdDBdEHAPGnE1nzfVmRaTI9zuKfBpEKckdjkiCtFvGwYAK
	s6q9Yzi5YPF38dwBg2rkAz8a8Qh121C78qe1CxkbwS1zy0PmNLknFUve9Y/+kTY+
	NJtucG62TFO1FRs69JBhG+1sRnxmQoEr+IrIpCQkZiXc1R+9+d/FQI2Ahydma6ab
	NlivZoKOBgK4H3GVShTGur3m76CTO2jRGr8Xpb/WifAeJ6h9dq+ZiYeo491IqxLs
	WG1AkTgTZShaINlyY8tw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vc40xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:03:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49L93do2018074
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 09:03:39 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 21 Oct 2024 02:03:35 -0700
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
Subject: [PATCH v4] arm64: defconfig: Enable STM protocol and source configs
Date: Mon, 21 Oct 2024 17:03:17 +0800
Message-ID: <20241021090317.5934-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VFeqTwtGTy5m45-5cGyexubN-m4BTpEw
X-Proofpoint-ORIG-GUID: VFeqTwtGTy5m45-5cGyexubN-m4BTpEw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 mlxlogscore=557 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210063

COERSIGHT_STM config is enabled. Refer to Documentation/trace/stm.rst,
to make software trace sources go through STM(System Trace Module),
need to enable STP (System Trace Protocol) protocols and stm sources
configs. With COERSIGHT_STM config, protocol configs and stm source
configs, STM function will be fully functional.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
Changes in v4:
- Remove Ftrace config.

Changes in v3:
- update commit message.

Changes in v2:
- select ftrace config explicitly.

 arch/arm64/configs/defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5506dfaf1b5c..2079544f1b5b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1564,6 +1564,11 @@ CONFIG_NVMEM_SNVS_LPGPR=y
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


