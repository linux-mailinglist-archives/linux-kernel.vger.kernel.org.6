Return-Path: <linux-kernel+bounces-196288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CD18D59C7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A551C20939
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 05:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72F945022;
	Fri, 31 May 2024 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RR5iUIL0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B54405;
	Fri, 31 May 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717132606; cv=none; b=oc+0Rhf1g7LU6LJmSGB/mNUaQHXccu9dKnFpTZ9AunZ55nR065CjSAiiiMEuxDPlYkyp0su0f2ki9WNbkrd8yTMows06FbEZdSgWid7tSSIhaT6oyIRdDkTnv5ez5fj8WKf422oxTVGAZFT7DLMqGfUAav+FWLI+77QRhYV4z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717132606; c=relaxed/simple;
	bh=rc9coK1EQVuMySMkXLylr5VmrSIA6HyYoHiydHI2IjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=KgwUS6eDAmS7VwwMN1ApX6GY++dJcAXo1Arp3q4SI3Va1thXCFc1uSVcv5qnULj9QNbUVIGsPXu7zpJS7B+ijwWHsPjmt2ktkYgvfLBOcY0TKvsJ1m1HJgnKCG3FFEZHXGxwh7v+t5NRniHseuU+c5P03cP8/zX+P9kTBnjPhtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RR5iUIL0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44UGrmlB019268;
	Fri, 31 May 2024 05:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TB351GK1yk9ksnTo9pyYUF
	IaEZ/tPZBjG4F83Nt1RJw=; b=RR5iUIL0zxd/MJJt4HLuaanWfAB/R2BaeMU707
	E2qvrczFGdyRImVtS55yQ8IVd0EMWHw5vEw61Qhto351dFkLcaOnX97je18+WL5L
	A8kebgv6/B8GKdnUd1C5OguKDWQmc+KSetd3jfiLV5nflT5agrI+JxH8ocduUjBs
	HxZICfu4aiznPVbOlV4xmYnFCyzqGZjumFyl2NT+70TtSy434criub9tw+MhZDUH
	fPvnc+sh5Ycltzpt7p1IvEEGyM35HMXp4O3PvacTr6eTNVMi3h0rowGHQa/6IBwJ
	9LPbQrSb04HF4u2k54oSYYPKLLjV+tVtFfaZbpjBVOdN6Ihg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0ge3jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:16:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V5G6n2003381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 05:16:06 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 22:16:05 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 22:16:04 -0700
Subject: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
X-B4-Tracking: v=1; b=H4sIABNdWWYC/x3MywqDMBBG4VeRWXcgtQrqq5QucvlbB0waJlYE8
 d2bdvktzjmoQAWFpuYgxSZF3qniemnIzza9wBKqqTVtZ/qb4Rg4bRFsc17AMAhudOPgu55qkxV
 P2f+/+6Pa2QJ2apOff5dF0mfnaMsKpfP8Auu9pCt+AAAA
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        "Alyssa
 Rosenzweig" <alyssa@rosenzweig.io>,
        Keith Busch <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
CC: <asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mP3ETysDdDj1tLBnR_cxY8-ywO1_2p3-
X-Proofpoint-ORIG-GUID: mP3ETysDdDj1tLBnR_cxY8-ywO1_2p3-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310039

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/host/nvme-apple.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/nvme/host/apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index dd6ec0865141..0cfa39361d3b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1602,4 +1602,5 @@ static struct platform_driver apple_nvme_driver = {
 module_platform_driver(apple_nvme_driver);
 
 MODULE_AUTHOR("Sven Peter <sven@svenpeter.dev>");
+MODULE_DESCRIPTION("Apple ANS NVM Express device driver");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240530-md-nvme-apple-e0edb9b98c45


