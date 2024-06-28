Return-Path: <linux-kernel+bounces-233909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B1A91BF21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AD9283D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F91A0729;
	Fri, 28 Jun 2024 13:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E/lymA+W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E9155C88
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719579831; cv=none; b=U+CLLbSvCSlUbyPprFqnMbqnu3VBSPUUqU4cz8RFME74yRaW+AKJj03xNrcXrxZyNWOFaYAh9QU+sUc/nemYDuAlglM22Ca0RiqQhmVdsE4ygaLgo8KcsluEF3tusFukFK8TFobKIKL+WuzybkAJ5Aua8FnyjrNc6jQ7/zHa7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719579831; c=relaxed/simple;
	bh=381UpprK3Cw6DXQPEEV4snzq2B29zfrL9hV4ZFRciPI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULyjLsR2UGJNFNJy329l06hbBVUStbOH7zTXfZKTwHKZJXXcMivgf52LL+aI7SmTmb5QIhj3KSJ5dibUyFawYPkDZqGwOuEpPy//UrR0Hi1mINvTCcqM+2HMKrceIaLTOjvCEtegRXTKk13kOfIiHhMPGqb0ARg9POVoXWhNkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E/lymA+W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SCbYxa016452;
	Fri, 28 Jun 2024 13:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=4sAp7CQtI0iKWkcWAcm/fuMALu2i1rb//EdBPUlH00E=; b=E/
	lymA+WVQv4NXM/rXQhp9v3Gd3jw4Ti9Gd1iyod3wE4yY5xwRsaxr5Gf+yv0qxesP
	6bkUz3TmAyqIknHZjufA1XpohiqqZw0VhBfKCF0LLtXIVYbPWcRQaSRl+nah7NRo
	AygE9Pi0/OCVX1NEIRfrrHzjev0rfrgEUsZaE7mNU47u+/Vpgc4DnzkVWoUD12Ol
	tlBqEMcjkDCMf+nnMujwmaXQh6yA1bLw852J+7Ap9iYuN3TTG5GMjFCCIOHlm7x+
	WhgRI1GiYVg7nxuVJ+uwqaYjgM5ScBZeSaqLX3oK5NEPJxqFnT9KK9wGgN0pYSwx
	xj+uvxEnxvcYAB/yN7bA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 401pm5sb68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:03:46 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SD3jQA003874
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 13:03:45 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 28 Jun 2024 06:03:44 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] devres: Simplify devm_percpu_match() implementation
Date: Fri, 28 Jun 2024 21:03:41 +0800
Message-ID: <1719579821-11178-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lsDENO2OsYsUwB0miPp4pCIQ6WFeD69Y
X-Proofpoint-GUID: lsDENO2OsYsUwB0miPp4pCIQ6WFeD69Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280097

From: Zijun Hu <zijuhu@qti.qualcomm.com>

Simplify devm_percpu_match() implementation by removing redundant
conversions.

Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
---
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


