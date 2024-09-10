Return-Path: <linux-kernel+bounces-322759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0D2972D60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6E21C2460E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D07188920;
	Tue, 10 Sep 2024 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LkbraMOh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AA13AD09
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960109; cv=none; b=lyMQ93mAHEfF8qrGm3g9Gd/rNe1hoQGswjMQGHelJLm7GuXOuMwEDxFtPrr4IIZCcdaeB2kVsPu0Bn1eGa5pkyeIsao/PbR0DQwLc/54bpChUdcuPhqylSOvkd6J61CCcybZ0F4CSDsjxNj32ZNgfRcIjCM4/RN611UT0l6jI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960109; c=relaxed/simple;
	bh=K1yJwcoRaKdt/SUT4i/Go4fJJnaHxij0TBnqFfdBqcE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P3vr4UHMLzku2Mc8rn/nmajbcYzOiPWn9kiMy5P5Mg4WMId0L28cPHvIwLCViCdFOGbCbVnsmBsJBxSf1EQtE9fqx2yBDNCXz70Jfr7o16HoSO/g3vroXBX4fN1K2j/IScubej/xJ7JU7R6JMfbW3JRCRe1caRe5ro0zFD1jY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LkbraMOh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48A3Gsbu026711;
	Tue, 10 Sep 2024 09:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sw/XzC/ht6A91OEMU/MXC5
	T8p5qxpo/z3bBvSPHckgk=; b=LkbraMOhJM/SCbo6ZVv7wSUdfIy1ud1F5DsdSm
	LFpM7Tc6kLqz/t4ch4z38/kDCDY6vUCZlSUVBPpxeGuqKOWE8bZHuCjks15ZTcO3
	QmcHQ1cDReQhFdoAa0args8rX3G/o37hjaERhCp/Ee6gqnrUgnK/niiQd1dsVRS6
	AE0nvdLC+wmmCtg4mHrpy09Kw2rw6tyir9108Dvhq6EMeXWF/6Af9mCMIZcgesCq
	PKiRC/UOxvUrL4pVTW8M83WRDpzSvTFyrcAD4uQsfn/N5jIkKOOPeBuYGonA4zfn
	MoaSfbTiw9TME0WgAwo0oQnAZ/CVKq3/NPEqv4ifqLZmHgUQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy6e5d8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 09:21:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48A9LWDD016893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 09:21:32 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 02:21:32 -0700
From: Mao Jinlong <quic_jinlmao@quicinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?=27N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado=27?=
	<nfraprado@collabora.com>
CC: Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: defconfig: Enable Ftrace and STM configs
Date: Tue, 10 Sep 2024 02:21:18 -0700
Message-ID: <20240910092121.20433-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lq9KCxP8nUEBu-Wl3-4kzgL4OHaT2dom
X-Proofpoint-ORIG-GUID: lq9KCxP8nUEBu-Wl3-4kzgL4OHaT2dom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=720 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409100070

Ftrace logs can be captured by STM over TMC sink path. We can enable
ftrace logs along with HW trace of coresight component. The timestamp
of ftrace logs and hw traces will be in sync which helps to debug.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/configs/defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 362df9390263..979f6eeecf2b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1588,6 +1588,12 @@ CONFIG_NVMEM_SNVS_LPGPR=y
 CONFIG_NVMEM_SPMI_SDAM=m
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_NVMEM_UNIPHIER_EFUSE=y
+CONFIG_STM_PROTO_BASIC=m
+CONFIG_STM_PROTO_SYS_T=m
+CONFIG_STM_DUMMY=m
+CONFIG_STM_SOURCE_CONSOLE=m
+CONFIG_STM_SOURCE_HEARTBEAT=m
+CONFIG_STM_SOURCE_FTRACE=m
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_ALTERA_CVP=m
 CONFIG_FPGA_MGR_STRATIX10_SOC=m
@@ -1703,7 +1709,6 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_DEBUG_PREEMPT is not set
-# CONFIG_FTRACE is not set
 CONFIG_CORESIGHT=m
 CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
 CONFIG_CORESIGHT_CATU=m
-- 
2.46.0


