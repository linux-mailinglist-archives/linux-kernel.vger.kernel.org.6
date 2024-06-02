Return-Path: <linux-kernel+bounces-198323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF38D76BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EE528127B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A6C47F53;
	Sun,  2 Jun 2024 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H0DBUZ+C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3843ADC;
	Sun,  2 Jun 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342026; cv=none; b=d0MhX656KsLDIEjDBW1o6LOSOZwOQnYE70Yituc778+PcKPsGYRKKYoSy5xgqMuhaVqWI7T5zOKZXaj02Ezy5OQHk1bou1aJObZ8WnTeAPpAwyAN2ookIBs35jjAu4Dj6porG4e+0NYigubcaIksh1yEW7QorD53hrOgad08kOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342026; c=relaxed/simple;
	bh=pkLa8OOPaBWLl8t+N7DuSt4pgQ8Y90LTgiiRLW0vlq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=OxPxn5JDUsu7Ctn6MtlpdklEqVs+iPXoyG75fGDWyk4P0v+h+jYtiSAwJ3DJXMD3CCmUWemGjooxvhWwPfDQa3IKmuhyRWYSatFQvEukZ1Y89GToSHM7YY79A3dCOk2lgUZwTf0vRkrW1swe+jKX3Pwv8IqVd5Mcc74YvZVajHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H0DBUZ+C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 452EcEYV031638;
	Sun, 2 Jun 2024 15:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OfPVRF6bZeh2SWxvyV1Ma7
	ziRLXZFAh1Sz4zmWtYvwQ=; b=H0DBUZ+CViCuZfYq7qQzfjzpRY8q7Ix/U1jkcM
	9F3kDaZMW9/35yAUL7mg0wOEDfsaF5ufeHxosQS49KNM7DrwJeGePfguI8HVhNHP
	BhN+ZnZqoXkLAAj3Qo2esyBtiK5CMOb02Lf8Hze5KU9iOTvpGjME2f6qbOisE1Sh
	XE3cLuL8Or0mQ6QB6fQQzuEZZfMn1asfS3vpESA7d2la1gzcCQjy+3GSwCmDZ2KN
	nyFP77XA6/ZIE31O9p5BhlVsgxYrVTkLrAwizCFy81c7WzwXhJ0rqgkDcjS8tqsv
	7UTe3EF1AyV7lmq81uDLqeMYgQd8QyB9MuH8IgBqS+uvGzjA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw5wj5r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jun 2024 15:26:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 452FQmT1015381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jun 2024 15:26:48 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 2 Jun 2024
 08:26:48 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 2 Jun 2024 08:26:47 -0700
Subject: [PATCH] clk: sprd: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240602-md-clk-sprd-v1-1-de0884ea6fc7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADePXGYC/x3MQQrCQAxA0auUrA2Mg1XxKuIinWRssB1LUqVQe
 nenLt/i/xVcTMXh1qxg8lXXd6k4HhpIPZWnoHI1xBBP4RwijoxpeKFPxhg5MVF7yfkaoBaTSdb
 lf7s/qjtywc6opH5/DFo+C47ksxhs2w9AwWaEfAAAAA==
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Bzm9G61d58s8yy86-HY8BPBrV2-YMIy0
X-Proofpoint-ORIG-GUID: Bzm9G61d58s8yy86-HY8BPBrV2-YMIy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_10,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406020133

make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/sprd/clk-sprd.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/clk/sprd/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/sprd/common.c b/drivers/clk/sprd/common.c
index 762f0961f17f..0f218161704f 100644
--- a/drivers/clk/sprd/common.c
+++ b/drivers/clk/sprd/common.c
@@ -109,4 +109,5 @@ int sprd_clk_probe(struct device *dev, struct clk_hw_onecell_data *clkhw)
 }
 EXPORT_SYMBOL_GPL(sprd_clk_probe);
 
+MODULE_DESCRIPTION("Spreadtrum clock infrastructure");
 MODULE_LICENSE("GPL v2");

---
base-commit: 83814698cf48ce3aadc5d88a3f577f04482ff92a
change-id: 20240602-md-clk-sprd-2dcdaa57ff80


