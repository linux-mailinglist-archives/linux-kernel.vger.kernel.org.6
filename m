Return-Path: <linux-kernel+bounces-336871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6BF9841EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3433285B07
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9190815572E;
	Tue, 24 Sep 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ifw2AwLt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972AB1552FD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169681; cv=none; b=sz9MojZVwjOHM8PgZ6iHdvY9FNNcq7I9YisE6QUAC6WF5qhXkmFyr81R9Oe/RkKR5T912/CYlf/JUyJsxrSVea++Ra+nriLXXEDW1jNyiKVjM01Of7KE0DIxgV1geVl3LTCav9J/qgbRJ3GCpjGEFweqGUDZX4KN0Q7nX11Ck10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169681; c=relaxed/simple;
	bh=dAeXcXbiVZ0q7cDkg0ByeSwVVqmnwEQO7KvXFXnXMYs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Df8TBqSaZvcDTnZmAfu7XZDbqj0XtE3n3Eq+3g6NeOatp7a+y8rKdKUZN4ZVa4FEmiCWBlSskUchbt0Ts4N33ftZ7wSiHlDpGp9mXDK7Jk5v5wKELTbz/LkOJ8tlz/bshyyp7+8xuEzfzHC7w3x1YHZRZN7JQKlREAVyUXqZU6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ifw2AwLt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NMuNJi027530;
	Tue, 24 Sep 2024 09:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0KM+FJAr/cYes3wxTLSxON
	y/JO5Uoi2TW3jKtZroXq0=; b=Ifw2AwLt5qvlqiyCPNrzhzZLRWtqjjCup0P0FU
	07ovUtcHZHsYXrlGfIbkk8Z9EZMtcCr7PTQtxUGSMNv1ZwOsTHK7d4hdOSNp4EGJ
	cSLDRGmfzfj/w6saQN+tNw/lyXPVk9jFAxG24CTaFka51OE0j/l+ZctK18Woj7z9
	BbaHqrk2faDoAsXrt9QtzWQY6UT4A7nriVmPKgJUgDkCIJByOBCP/lr7SpRkQBvQ
	yYpXk9Ih/wTHBhEsdm7zsOIWFx0sFjomhH1vD1IJtf3HhYlnvcuf1U7lY73DfQ28
	9yFar5rXwmxePRK7znIUGtwAsRpzCUF2fGybSlJaBc/mxOGQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snfh032u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:20:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48O9Kigg025681
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:20:44 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 02:20:43 -0700
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
Subject: [PATCH v3] arm64: defconfig: Enable Ftrace and STM configs
Date: Tue, 24 Sep 2024 02:20:31 -0700
Message-ID: <20240924092033.2626-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: AnoOUsiCCTJ8lhUmQc56pMXZ7ScXK6zD
X-Proofpoint-GUID: AnoOUsiCCTJ8lhUmQc56pMXZ7ScXK6zD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=676
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240065

To make software trace sources go through STM(System Trace Module),
need to enable STP (System Trace Protocol) protocols and stm sources.
Refer to Documentation/trace/stm.rst. Then software trace logs can be
captured by STM over TMC sink path. We can enable software trace(Ftrace,
console) logs along with HW trace of coresight component. The timestamp
of software trace logs and hw traces will be in sync which helps to
debug.

Changes in v3:
- update commit message.

Changes in v2:
- select ftrace config explicitly.

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 arch/arm64/configs/defconfig | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4a3999eefa67..c0a56e58e554 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1554,6 +1554,12 @@ CONFIG_NVMEM_SNVS_LPGPR=y
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
@@ -1663,7 +1669,7 @@ CONFIG_DEBUG_INFO_REDUCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_FS=y
 # CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
+CONFIG_FTRACE=y
 CONFIG_CORESIGHT=m
 CONFIG_CORESIGHT_LINK_AND_SINK_TMC=m
 CONFIG_CORESIGHT_CATU=m
-- 
2.46.0


