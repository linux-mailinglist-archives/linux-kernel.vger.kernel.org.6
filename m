Return-Path: <linux-kernel+bounces-358272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DDB997C67
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 07:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B011F1C21768
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986AF19EEC7;
	Thu, 10 Oct 2024 05:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UovbyWSO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F712AEEC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728538058; cv=none; b=jLpANiSJ5EYBfaaSYmjb54d2nhIOR8Ws7iMM3sIdLbPYhiGLAvOFzUafI3yuHjbG3TumJvVr7Yk0TSb28RBW8YFWj+GnScZegJOu2nPFKSmFN8JR7D8+wF6Ca+kZTjSDh45y7bbNXZqAzuRCWmtmoPEnlVI0USrDPVbxXbna6Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728538058; c=relaxed/simple;
	bh=EvioNNLDIEs1Bc5eLnQliexHwYetYgPdzzvnxiCPCBI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mi7f+K9NXQr+wBneYKtNXV5mlyhh2ug7p/SvgYNT3/5Q3iYEf4rhQ4i+thoZZxLQiQgNlJjeySD4bSmNGWqOMcSlX6aE1vAZw7UCvddsIHtcD8PNnbvb680fZ+2UAT0FySe55GXQi8Gfn3PnNcWN7mY2jbKinO59kLZjSGXA/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UovbyWSO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A1bQT5024235;
	Thu, 10 Oct 2024 05:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4rZV1jLO1ZScpzDxJGiRNm
	Wd0ZB05iuSv2dLx6NXGX8=; b=UovbyWSOqaPX7GZw//i51AcJE9R1w7n26aQuj4
	IdM46PJlmbLV4A0qrWR6kNjqcLCiSw+us6DGuTaANvOxviPCWvzBV97ZP6/l6ACs
	3XBr/Wa+F7fCcB5ZY6DDIs8/WPRdgQ4i9IU0Y14fxHQ/92ECAV9vUCz/XVnGUrBM
	qNpqkE5vFarMBVmGC5BEmQhoF4UGItQY3pVarW6EwhzQ3cdwHLDKAq0E6p3mMQ0K
	mob33/L0z7dbs3zN80VafFaGWY5vNf3KbLBwuCcHPcxV3MjAJrBnhucEbvmvrbpy
	dzsgnloPpwSNc2MGXw5unuTCuWkxUqRX1V77Bfd3g75uohtw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wgs7dc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 05:27:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49A5RPkN028241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 05:27:25 GMT
Received: from hu-mohs-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Oct 2024 22:27:20 -0700
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <kernel@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        "Mohammad
 Rafi Shaik" <quic_mohs@quicinc.com>
Subject: [PATCH v2] arm64: defconfig: Enable WCD937x driver as module
Date: Thu, 10 Oct 2024 10:56:46 +0530
Message-ID: <20241010052646.2597418-1-quic_mohs@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: y9r0G70FJR3PtkZgQbBu1DKGq12Lun9X
X-Proofpoint-ORIG-GUID: y9r0G70FJR3PtkZgQbBu1DKGq12Lun9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=629
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410100034

Enable Qualcomm WCD937x codec driver as modules
since it is now used on the QCM6490 platform.

Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Reviewed-by: Rohit Kumar <quic_rohkumar@quicinc.com>
---
Changes in v2:
- Rephrase the commit message as suggested by Trilok Soni.
- Link to v1: https://lore.kernel.org/linux-arm-kernel/6cabe8cf-7286-22f8-029f-140b084004e1@quicinc.com/
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5fdbfea7a5b2..c4746e3412f8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1036,6 +1036,8 @@ CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
 CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SOC_WCD9335=m
 CONFIG_SND_SOC_WCD934X=m
+CONFIG_SND_SOC_WCD937X=m
+CONFIG_SND_SOC_WCD937X_SDW=m
 CONFIG_SND_SOC_WCD939X=m
 CONFIG_SND_SOC_WCD939X_SDW=m
 CONFIG_SND_SOC_WM8524=m
-- 
2.25.1


