Return-Path: <linux-kernel+bounces-203362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10908FD9F6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D2F28A2F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3309416088F;
	Wed,  5 Jun 2024 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B6XjT51P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3EC15F3ED;
	Wed,  5 Jun 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717627199; cv=none; b=KazWw+wTRxEykdX4HXFeaPBr0MNwEqeBtA7iVmpvzxDv+WaxlleqZBESIjRLmzDHzYLMrpNU2J5DcumsanRI1OIOaV3kPUnibVInTRyd4MkAkjIw+rcL7VzKbWazdLlVGMEQQyl8DP7tQv85ItlOxTVt2KJlyz3j+LG3rlFQ8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717627199; c=relaxed/simple;
	bh=IskKsFA2/LXUqW0Tacqnyr0ow3eiHrAKVwj5qkWYFz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hgmBXK+wGF3h9SHFDXIZBPS2yDLe7CTKMP3ouKH3NAn1S4DWrBEHMqNQUOIg99hhrH1kXAOXOnuC2lmx+RtO5QnmbvUaOBlRbojJcrB3DNuWJMX6VVLEV2AvKu+H7eqdLn32/53xWU2xo8Hv+y3lGlGlr0LTofj/Sv8yXNWkAnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B6XjT51P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455L7NTJ016716;
	Wed, 5 Jun 2024 22:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IBSEFFyozq9AP7T7zCoic6
	K0+Ab6heDxsdmmvN5PFPw=; b=B6XjT51P9u+kbYTJzFe+Mrs5LsvjlAFD9ZLhvW
	Qt7+WPZK+GWEcnNR4iQGIqcXnCJllSIyKapSQfEWhf/Uiyzk+zFPvMrTtECDs/xi
	8Vexs+0TAlGP4GkcXjvUTCCkCPCLGKI6lIeYBEKJyR4ZpV39uoOmMtAsKLKoHfiR
	TmlKz3pRtVrKMs2KQvxRuNrKwv3HOzXH9zoGo6zwQuhjQAdJca9N7PgzIdNtEIm3
	T1TrE6BUX3tvMTIfCSy1srodvwF5J3hIcSO/baCULFCMzXpUjlamhQ3ulcUdUw1H
	c7oAli9MOt8EY+lLi8U1SbESvxtKRYKwPUeWQV/H8R4knUIA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjan2k1en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 22:39:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 455MdZjb031482
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 22:39:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 5 Jun 2024
 15:39:35 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 5 Jun 2024 15:39:34 -0700
Subject: [PATCH] fsi: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240605-md-drivers-fsi-v1-1-fefc82d81b12@quicinc.com>
X-B4-Tracking: v=1; b=H4sIACXpYGYC/x3MQQqDQAxA0atI1g2MoxbpVaSLaGIN1FGSVgTx7
 k67fIv/D3AxFYdHcYDJpq5LyihvBQwTpZegcjbEEOtwDw3OjGy6iTmOrhioqrmN1DZMkKPVZNT
 9P+ye2T25YG+Uhum3eWv67jiTf8TgPC/Xjxl4fwAAAA==
To: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Alistar Popple
	<alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-fsi@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4YyMX5gMIkxoGAUWDq0Ghiv32UuU6_8N
X-Proofpoint-ORIG-GUID: 4YyMX5gMIkxoGAUWDq0Ghiv32UuU6_8N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=856 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406050170

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o

Add the missing invocations of the MODULE_DESCRIPTION() macro, and fix the
copy/paste of the module description comment in fsi-master-ast-cf.c.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/fsi/fsi-core.c          | 1 +
 drivers/fsi/fsi-master-aspeed.c | 1 +
 drivers/fsi/fsi-master-ast-cf.c | 3 ++-
 drivers/fsi/fsi-master-gpio.c   | 1 +
 drivers/fsi/fsi-master-hub.c    | 1 +
 drivers/fsi/fsi-scom.c          | 1 +
 6 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 097d5a780264..716a924269ee 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1444,5 +1444,6 @@ static void fsi_exit(void)
 }
 module_exit(fsi_exit);
 module_param(discard_errors, int, 0664);
+MODULE_DESCRIPTION("FSI core driver");
 MODULE_LICENSE("GPL");
 MODULE_PARM_DESC(discard_errors, "Don't invoke error handling on bus accesses");
diff --git a/drivers/fsi/fsi-master-aspeed.c b/drivers/fsi/fsi-master-aspeed.c
index f0a19cd451a0..b454587790a2 100644
--- a/drivers/fsi/fsi-master-aspeed.c
+++ b/drivers/fsi/fsi-master-aspeed.c
@@ -672,4 +672,5 @@ static struct platform_driver fsi_master_aspeed_driver = {
 };
 
 module_platform_driver(fsi_master_aspeed_driver);
+MODULE_DESCRIPTION("FSI master driver for AST2600");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 812dfa9a9140..85096559dda3 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2018 IBM Corp
 /*
- * A FSI master controller, using a simple GPIO bit-banging interface
+ * A FSI master based on Aspeed ColdFire coprocessor
  */
 
 #include <linux/crc4.h>
@@ -1440,5 +1440,6 @@ static struct platform_driver fsi_master_acf = {
 };
 
 module_platform_driver(fsi_master_acf);
+MODULE_DESCRIPTION("A FSI master based on Aspeed ColdFire coprocessor");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FW_FILE_NAME);
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index ed03da4f2447..d32dcc98e85b 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -894,4 +894,5 @@ static struct platform_driver fsi_master_gpio_driver = {
 };
 
 module_platform_driver(fsi_master_gpio_driver);
+MODULE_DESCRIPTION("A FSI master controller, using a simple GPIO bit-banging interface");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 6d8b6e8854e5..6568fed7db3c 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -295,4 +295,5 @@ static struct fsi_driver hub_master_driver = {
 };
 
 module_fsi_driver(hub_master_driver);
+MODULE_DESCRIPTION("FSI hub master driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fsi/fsi-scom.c b/drivers/fsi/fsi-scom.c
index 61dbda9dbe2b..411ddc018cd8 100644
--- a/drivers/fsi/fsi-scom.c
+++ b/drivers/fsi/fsi-scom.c
@@ -625,4 +625,5 @@ static void scom_exit(void)
 
 module_init(scom_init);
 module_exit(scom_exit);
+MODULE_DESCRIPTION("SCOM FSI Client device driver");
 MODULE_LICENSE("GPL");

---
base-commit: 19ca0d8a433ff37018f9429f7e7739e9f3d3d2b4
change-id: 20240605-md-drivers-fsi-0a34d82a85da


