Return-Path: <linux-kernel+bounces-237071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CB891EAB6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688D9283DAB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A250B16F84D;
	Mon,  1 Jul 2024 22:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GeL6kUYg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC924F602
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871778; cv=none; b=ABaqxkloGh1zJpjT2upnjOkIIKlRGCdIBNqrBTTCYlEvN/W3JD1F9SVM0Y5TroxnGTiPmLsQi9qPb34d4/qwkRj2SrnJO/aNDicXUBVUhainG9V2Gib/UOckLy6o9Y5sJDAmoN9zh/dIHGSyVZdA5fBQu5N4ZCeSQAlCLzb5nzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871778; c=relaxed/simple;
	bh=2U270ZnKbvvmn+Vv/Z1WUHk369WD8K9S7H2lKnDv9j0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cmz5rIqcM7kYOtR3I7KPxca1LPjyxeRaf42W3NbFWmguB2oWUgnkbQvzvoEYL4kSZ9+J4yW2VkQ62R/gcd1cBMrYLxMkNr34t+BdS/ckfiyxM9hBpzV9KorQdIwh2bXvDOR+N+/TsZidmr2IdEdDwgmcj2/Sb6Ve0PjZfMsiMWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GeL6kUYg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461JB8v2016199;
	Mon, 1 Jul 2024 22:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=u3R9n/+0laa6Ph7ZHAds6e9tCONEwcE+ARW1fcbSQcM=; b=Ge
	L6kUYg7Gg/YBmORvVuAvwVS1MZgAsCMigt9Gp26mYhrmxMmIizjJiorv2gKa5SO1
	yM0L7iZmfbOU/IeoqfaLRsfuwInEQZLWFIp611w0pBBu7iu9M0DZCyExtA+Om7Ji
	pHjNuVLzR7OUgXJB3Akvc8caED6yEAj45qbiE51lkPwHF88qmF69qsFWk/SqHZBt
	AB8IQC7bq4hX3FUQSbTsiLpAQF50vsafTxhl3ze8RiJ1CpKZ4YiWebxLz48HsZt1
	yK3p9uFhO04CWQw89w44eIJd5h3sbqEInicIwL0V4iTeFSyy7vXisdfhrywugSAG
	busr3hXFLOClXNKi6O+g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029kh5ghn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 22:09:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461M9UeT013520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 22:09:30 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 1 Jul 2024 15:09:29 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v3] devres: Initialize a uninitialized struct member
Date: Tue, 2 Jul 2024 06:09:25 +0800
Message-ID: <1719871765-14774-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cg2jY4UHFiDnOA4AH0EE1MlitszQmjtt
X-Proofpoint-ORIG-GUID: cg2jY4UHFiDnOA4AH0EE1MlitszQmjtt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=806
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010165

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
V3: Correct mail address
V2: Simplify fix by use = instead of memset() and commit message

Previous discussion link:
https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/

 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..3beedeaa0ffc 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
-- 
2.7.4


