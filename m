Return-Path: <linux-kernel+bounces-198062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95978D72F3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658782822F5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3372184F;
	Sun,  2 Jun 2024 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fj5fWnKP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084F64B;
	Sun,  2 Jun 2024 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717289443; cv=none; b=Ez7vNn1CTGKgIDhrNdaeTanbGbMEW7SRckUrjb0tcQ4w3DR9bY5uOMIlPoWQNv+Ru9ivT7M7n0fR3uOE9FE5A954dd3j7u3VJ+brfALu5yW+3eSpkfQjjSfop4h7VnOhx+HEq1FgFXgl7cWCREGXutVOf5rhqzE4TUreunRawHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717289443; c=relaxed/simple;
	bh=7MCRYP6nsXV2dohJHHpunHUXRb2cL1VE1ZDdnR5Dhr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=aI21/9s80hAT+j08VtB10OGR+DZ+NprcxEWBEXYkWJ/0I2jhApNS9ncAjBmgeamp34ASyZ/g0VlU3xlVim90fciPXUhl5IwGGhd6IuWHmUs9u1wpGnTGphiNJ5Da/uDoSImGIuuz7Xu9E8Ca4yqj9ZGqJ+8g4kshie+TKNg7leE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fj5fWnKP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4520fSOj024625;
	Sun, 2 Jun 2024 00:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=BKAwhU1NFx3ft5/D8jElvn
	nsJ0XTcHgCCp6q0YP3eNM=; b=Fj5fWnKPK41ebZLcLmoPuz9x0VE8miooVUefit
	UDdQWsGdyuHRB9VYUndjzHrkYjPNPsdA7Z0t3He5Vlz90Ol9bOXkE5hTRuqHYBtN
	iOyPvF0sOCMF+V8MdDzdAdbsSbtuyzXEMkUCdNlQKE5TpTtoT0VaHlB/hgEb49kN
	8lvIMYbcqa3WmMIf3yCFsO02wIdEO5j0uWSLcI8H3JL47rinfHAuVHYSi16nVYRZ
	L9JwiGYLi1v0Fl4RuUjMEXkmGI5X+5k7ucDH5E0Xa7+Ugxq/p9G0ONpk4YZPHT+X
	Lefo0WEjsBv8XRPnMl1gIO0ob4wNnxz4O63nrvDCPLygpwfA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wher1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 00:50:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4520oSkY024781
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 00:50:28 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Jun 2024
 17:50:28 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 1 Jun 2024 17:50:27 -0700
Subject: [PATCH] kfifo: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240601-md-samples-kfifo-v1-1-de34345c5fd8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIANLBW2YC/x3MwQrCMAyA4VcZORvISlHwVcRDuqUuuHYjURmMv
 bvV43f4/x1cTMXh2u1g8lHXpTb0pw6GietDUMdmCBQinanHMqJzWWdxfGbNC0ZKTMwXiiFDy1a
 TrNt/ebs3J3bBZFyH6Teatb43LOwvMTiOL4G9U9uBAAAA
To: Stefani Seibold <stefani@seibold.net>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9o5eQJkxKgTR8seWxn64v0EyN7jh9SfJ
X-Proofpoint-ORIG-GUID: 9o5eQJkxKgTR8seWxn64v0EyN7jh9SfJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020005

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/bytestream-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/dma-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/inttype-example.o
WARNING: modpost: missing MODULE_DESCRIPTION() in samples/kfifo/record-example.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 samples/kfifo/bytestream-example.c | 1 +
 samples/kfifo/dma-example.c        | 1 +
 samples/kfifo/inttype-example.c    | 1 +
 samples/kfifo/record-example.c     | 1 +
 4 files changed, 4 insertions(+)

diff --git a/samples/kfifo/bytestream-example.c b/samples/kfifo/bytestream-example.c
index 642d0748c169..4ae29a12cc8a 100644
--- a/samples/kfifo/bytestream-example.c
+++ b/samples/kfifo/bytestream-example.c
@@ -191,5 +191,6 @@ static void __exit example_exit(void)
 
 module_init(example_init);
 module_exit(example_exit);
+MODULE_DESCRIPTION("Sample kfifo byte stream implementation");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
diff --git a/samples/kfifo/dma-example.c b/samples/kfifo/dma-example.c
index 74fe915b7ffe..48df719dac8c 100644
--- a/samples/kfifo/dma-example.c
+++ b/samples/kfifo/dma-example.c
@@ -138,5 +138,6 @@ static void __exit example_exit(void)
 
 module_init(example_init);
 module_exit(example_exit);
+MODULE_DESCRIPTION("Sample fifo dma implementation");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
diff --git a/samples/kfifo/inttype-example.c b/samples/kfifo/inttype-example.c
index c61482ba94f4..e4f93317c5d0 100644
--- a/samples/kfifo/inttype-example.c
+++ b/samples/kfifo/inttype-example.c
@@ -182,5 +182,6 @@ static void __exit example_exit(void)
 
 module_init(example_init);
 module_exit(example_exit);
+MODULE_DESCRIPTION("Sample kfifo int type implementation");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");
diff --git a/samples/kfifo/record-example.c b/samples/kfifo/record-example.c
index e4087b2d3fc4..e4d1a2d7983c 100644
--- a/samples/kfifo/record-example.c
+++ b/samples/kfifo/record-example.c
@@ -198,5 +198,6 @@ static void __exit example_exit(void)
 
 module_init(example_init);
 module_exit(example_exit);
+MODULE_DESCRIPTION("Sample dynamic sized record fifo implementation");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefani Seibold <stefani@seibold.net>");

---
base-commit: b050496579632f86ee1ef7e7501906db579f3457
change-id: 20240601-md-samples-kfifo-40ba0aa7042f


