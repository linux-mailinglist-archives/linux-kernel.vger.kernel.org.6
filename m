Return-Path: <linux-kernel+bounces-198348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E62508D7707
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 667F6B225EE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0004D5A5;
	Sun,  2 Jun 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GOfhTNEq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B8481A7;
	Sun,  2 Jun 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717343979; cv=none; b=Vcjr1tWBYW3fkJTOQ3bY75flBZic/28EbOcXXIKrDkJPRbuT3KP1aVBcR4yk4gWbgORputrhZ4vfjjif+Sphv7KmjZ/2hll5f2c0azQVZccJJ6JymbySev0ngxqSZxj2EK/ADu6c4hzQSCfEVLyN8VQC6s5xMeczwVPBSeWE3pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717343979; c=relaxed/simple;
	bh=NhRIo0Ra5R8aaKVasORj+WeRKMXMOqwqZC5Mr2clkok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Md0Wxpk3TQNilBO6UDMHUQi62oLxo8p4ou/XssjAMluXx7qjmfDc5w61Idc+Ns8N480cXQ9eVGDhkQP/s0iWt1W9hH6XS0ret4FZWzRVQ48kCJ2WJlat8O5AiSV2RSQqnF5ryWEIj4vSNw96NOoNV6mzpaY97/iE030ylb1q/PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GOfhTNEq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452EwXLY031481;
	Sun, 2 Jun 2024 15:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P5kXeOJlMUyHG8oSeX/YqW
	mTmy2VqA3LGlgqepAHGIo=; b=GOfhTNEqpw4rRO7aHKWd8+SNCSPAK02VM6npCV
	FAq3bqhStDMGcpyuQS+f7CKulCJMcXCrnS43SZYMYlhfQEHCPmCvnGJ6uSnr9wGA
	9xaXOs42I8gzKRYN70rdHPznXBCYkYZEbCYIxCoCyEk0UH/GZxAqGoWKFPuY9njj
	MoaYzEXJqE9wXsbcpMXR8Am4kq2M4Gu/5GKg2vo5GNjBD1BRyz1vrc5wXGj7up1E
	N5Ki0IoWsbZAzXe3u/mzVh2Asi29FYz1CJgdu9bVeQ/JBQ7MmYone3DM8w0g5p1A
	UNspCZyWFkC3id957FMIfTMImMqq2xHTGFFUl7GPTIqEIZog==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5t258d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 15:59:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452FxIb9020912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 15:59:18 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 08:59:18 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 08:59:17 -0700
Subject: [PATCH] clk: imx: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-clk-imx-v1-1-5c6d240f6fab@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANSWXGYC/x3MwQrCMAyA4VcZORvoqlPxVWSHtM1ccK2SqBTG3
 t3q8Tv8/wrGKmxw6VZQ/ojJozT0uw7iTOXGKKkZvPMHd3Qec8K43FFyxf3JTbFP54HCAC14Kk9
 S/7Pr2BzIGINSifNvsUh5V8xkL1bYti/qHdp0ewAAAA==
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, "Shawn
 Guo" <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam
	<festevam@gmail.com>
CC: <linux-clk@vger.kernel.org>, <imx@lists.linux.dev>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oPbszWzkp-86_8BQxWEDpQG8g06bT1xJ
X-Proofpoint-GUID: oPbszWzkp-86_8BQxWEDpQG8g06bT1xJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020138

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/mxc-clk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/clk/imx/clk-imxrt1050.c | 1 +
 drivers/clk/imx/clk.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 08d155feb035..efd1ac9d8eeb 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -176,6 +176,7 @@ static struct platform_driver imxrt1050_clk_driver = {
 };
 module_platform_driver(imxrt1050_clk_driver);
 
+MODULE_DESCRIPTION("NXP i.MX RT1050 clock driver");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Jesse Taube <Mr.Bossman075@gmail.com>");
 MODULE_AUTHOR("Giulio Benetti <giulio.benetti@benettiengineering.com>");
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index e35496af5ceb..df83bd939492 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -226,4 +226,5 @@ static int __init imx_clk_disable_uart(void)
 late_initcall_sync(imx_clk_disable_uart);
 #endif
 
+MODULE_DESCRIPTION("Common clock support for NXP i.MX SoC family");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240602-md-clk-imx-370fc1d85ab5


