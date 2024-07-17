Return-Path: <linux-kernel+bounces-255393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01877934040
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD56E1F239D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70A181BBA;
	Wed, 17 Jul 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cPKPIPb2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17028C04
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233037; cv=none; b=piXa5n4BbX2bz2P6CUBRf6r/yX8Xw7fX++Rc7Igswq1RTnRiiwNSYhBKZf2CUMddvXzn6v71B8WJjMs4mNrDU4ppCEdqDxWmIbYV95Lht2pRWjOC0nI7c9HLYc5+UFSOSWiOEklICPDiwpfH0mLg0MAjvoG3Pj/yIXX2ru9Kuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233037; c=relaxed/simple;
	bh=95MdCSCr7xhK2591wQudm9XsQXjhTGPPYRrwJsKf8b0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=A/pUm6CJVPbK2vx4XVn/V8H3Dm92LhOQb7ZWlCoII5WK1sSfKJNa+89zPEi7BilGRrpyUb9BVy9UwvSXZJCi7xvC9cdpRuBN6MJ8kx0JXTUx1gRk4JpJ8C8gLgOq0dzn2eNNpqJ6L8HX18u0i1hltevSuFGdwvoar6IJSSsPXFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cPKPIPb2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFvlii004004;
	Wed, 17 Jul 2024 16:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vmlNgatOajUjuRnbWZp38Y
	mp6Wa+7ibELXSwNhzMZ2w=; b=cPKPIPb2KE+Mtg8lX1pV21MwnlvzSjsevVveOt
	JAOOs5qP+ycJFK9CngAcRnb4d/1CLg4ETIjYwQM/k2hL1jKYZ4M02P33ZVKDv7nv
	8ukRvnIBtZEnl9usXt1AQQaf997kreY/W4pwCK0erI+cfUT+P+/A+IBLeP6PeltK
	VrhE/xvK0g+ibafAeRICVHtWqptgFPKJ8Mp/rVbohp2HCFtZc4hMNm9taV8gxpqf
	N54midOG7leAXzTaPgngY42j9psOqwiApUwtrDGqRELEJ4DlE2TgVIWxQaz9cViT
	GzNSFdTBaEDMlLfG207w+HBO7teOUl38gepKCyXM8RFnPfTg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpb1gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:17:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46HGHBk7027830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 16:17:11 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 17 Jul
 2024 09:17:10 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 17 Jul 2024 09:17:07 -0700
Subject: [PATCH] char: add missing NetWinder MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240717-md-arm-drivers-char-nw-v1-1-fee7a8505e9e@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAILul2YC/x3M0QrCMAyF4VcZuTawjUrBVxEv0jZzARsl0W0w9
 u5WLz8459/B2YQdLt0Oxou4PLVhOHWQZ9I7o5RmGPsx9HGIWAuSVSwmC5tjGxnqiuGcMuVYphI
 ytPPLeJLtH77emhM5YzLSPP9yD9HPhpX8zQbH8QUO92kIhwAAAA==
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jd3wDtVERauOK1vQuhaTrDBdMQ4b4Ull
X-Proofpoint-GUID: jd3wDtVERauOK1vQuhaTrDBdMQ4b4Ull
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_12,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407170125

Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
description is missing"), a module without a MODULE_DESCRIPTION() will
result in a warning with make W=1. The following warnings are being
observed in drivers/char when CONFIG_ARCH_NETWINDER is enabled:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/ds1620.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/nwbutton.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/nwflash.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/char/ds1620.c   | 1 +
 drivers/char/nwbutton.c | 1 +
 drivers/char/nwflash.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/char/ds1620.c b/drivers/char/ds1620.c
index cf89a9631107..a4f4291b4492 100644
--- a/drivers/char/ds1620.c
+++ b/drivers/char/ds1620.c
@@ -421,4 +421,5 @@ static void __exit ds1620_exit(void)
 module_init(ds1620_init);
 module_exit(ds1620_exit);
 
+MODULE_DESCRIPTION("Dallas Semiconductor DS1620 thermometer driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/nwbutton.c b/drivers/char/nwbutton.c
index ea378c0ed549..92cee5717237 100644
--- a/drivers/char/nwbutton.c
+++ b/drivers/char/nwbutton.c
@@ -241,6 +241,7 @@ static void __exit nwbutton_exit (void)
 
 
 MODULE_AUTHOR("Alex Holden");
+MODULE_DESCRIPTION("NetWinder button driver");
 MODULE_LICENSE("GPL");
 
 module_init(nwbutton_init);
diff --git a/drivers/char/nwflash.c b/drivers/char/nwflash.c
index 0973c2c2b01a..9f52f0306ef7 100644
--- a/drivers/char/nwflash.c
+++ b/drivers/char/nwflash.c
@@ -618,6 +618,7 @@ static void __exit nwflash_exit(void)
 	iounmap((void *)FLASH_BASE);
 }
 
+MODULE_DESCRIPTION("NetWinder flash memory driver");
 MODULE_LICENSE("GPL");
 
 module_param(flashdebug, bool, 0644);

---
base-commit: 51835949dda3783d4639cfa74ce13a3c9829de00
change-id: 20240717-md-arm-drivers-char-nw-45bcac7dfd4c


