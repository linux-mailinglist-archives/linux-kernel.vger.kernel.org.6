Return-Path: <linux-kernel+bounces-237072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6E591EAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818321F22510
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D934F602;
	Mon,  1 Jul 2024 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pd/Y8qU/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BD8120F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871791; cv=none; b=qiRY1zNO9LVwDMafxxtGQTOAJ6ix25xDksSsulPNT9sDwqamVbw4Vip+cJ3eIf0s6VLZ9XzbybQPSfjqWKak/eExaFAgWhKIGIzQKKAa8QgKKlccgxhcS9YJ33QeUZkkV7Arffbp/Wj3/VfkydBcTbb+WrU3TJo2GvNySBF5s4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871791; c=relaxed/simple;
	bh=rWlqQQ3w+K3a0NSSe6Ws9JaFvpjJwZ06ykOzrBJOBhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NizoD1Rf426uOns2PwLcvQ0NOISftN+kPOKqoJ/X4IuTK/ULdXmk8P517nqkj53tvyiym/kslEP4lqu+CAfd21sFU+BDB8MuYnKuc1Azwe0RCsygs5zZVRT3/H/HiGui84doNlq8yqpYZLzSPeNcQSHFouCYnNw2cFsR0SSfw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pd/Y8qU/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461JBQMe009329;
	Mon, 1 Jul 2024 22:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=wwOXFR2SO6i4TVwGKOGskb/uNt+ICFpXBRPIq+WBYWg=; b=pd
	/Y8qU/KWOx3sHVhT1e1TU7STSulujRwCMYo789O6TUrFItNQfQPq+1lJb4a1gXVR
	79v5IW//sUEpvJjcukA6zPXCEVSzDEtHQq6U/5eJZHyGFwAPQZopB2CG35F41dvT
	IISW7fQ2tRyi2sHfCb9tm4IOR6JxkB4wH39YkORcZdoCQFSmhMMHbhM6OXlSDGE5
	jgoMYbPKP4n/253u+epFuuuFq6k3+YzkyvO5NNSOACK/TvZjcjKF+9G29E7UyEz1
	xNG0q3qmQAeOEKe4e8iaaF+/mZ9AQFLXPQd0XsEcBnQ8UcedfppwQ2EKyQ6MIvF5
	95EuPSRy3tIFy+lCZxzA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402abtngd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 22:09:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461M9jwB002791
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 22:09:45 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 1 Jul 2024 15:09:44 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v2] devres: Simplify devm_percpu_match() implementation
Date: Tue, 2 Jul 2024 06:09:39 +0800
Message-ID: <1719871779-14818-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QE3KB_fP2AN55r4pM_SLtBZrAQbeZIS1
X-Proofpoint-ORIG-GUID: QE3KB_fP2AN55r4pM_SLtBZrAQbeZIS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010165

Simplify devm_percpu_match() implementation by removing redundant
conversions.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
V2: Correct mail address

Previous discussion link:
https://lore.kernel.org/lkml/1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com/

 drivers/base/devres.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3beedeaa0ffc..050d7fcd0634 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1173,9 +1173,8 @@ static void devm_percpu_release(struct device *dev, void *pdata)
 
 static int devm_percpu_match(struct device *dev, void *data, void *p)
 {
-	struct devres *devr = container_of(data, struct devres, data);
-
-	return *(void **)devr->data == p;
+	/* @data is already and must be (void *)devr->data */
+	return *(void **)data == p;
 }
 
 /**
-- 
2.7.4


