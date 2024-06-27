Return-Path: <linux-kernel+bounces-232400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CDC91A847
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F201C2200F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B77194ACF;
	Thu, 27 Jun 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HHYyPUz+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A3D1946B8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496053; cv=none; b=hJhPjjXQ3uwEroEKDpYjfKbjdcME013wuETnO1o1cUqDiLioZ5MFG2WtMJQxFqKuI7NLsBdrLz+jGZeiQ6y6AHTw9VlqCqkgep4jp2zbpMLMPTQ7z8aiXZPJzpJwEx87rumveCISQLur0dnUaUa0wawUwCZ8dxTDEf4StBHAf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496053; c=relaxed/simple;
	bh=ZbwcNBkaCvxTyqLjwCfr9u0vykyNCm7VJyyxeRTuPew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZPPSaOQghfh1xfPTle7WkhJnNpURDM8Z46amjHXkuaelj/1HlpK5Ij0vMCeSMgrpPjO5gNx0j6KGrhUmwFhkE67ijHNL58K96p/PGWwsBzRBfWMmKDBQgH/EoLKXetfzi9YIUsGkvIdPmXygWtYzKy7KhNWDx1N2KYmUDzkM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HHYyPUz+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R9Y2OY018096;
	Thu, 27 Jun 2024 13:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IOWARdJ4qkdz/hHTjQ1+qcoJ
	IvPeuyV+pMrdVoLqR44=; b=HHYyPUz+h46U3P/neEwHeaGe2DrxZ909I3CzhUzF
	4oTqNkFeB98cyAOJNB2wXdqhDFiZvAF//Akn+zNqfcMZ0yQPAYJCDyxz2/ib4S3X
	261WLjVZCycbqr/LdWwWlZbklUDYa0aiX6HUuOaD6BWZG9Pnf6dgflCe9kXeQlfG
	n2Zuhe/rzyVJabQLV10YOTSbirtKoy/Pc+o6qE37v9B89p2Hvh+Beew3k5V4qWl4
	K4pW9g7QPi9t6Fa6AZ4l/eFp1j+HqigzlvdSq1giFUjI8ZeZPoR8bmqNWqApYVAo
	Pnc1i0MzRRNY2Xo8OnjeTHi+LI8VdvlHqspX4LcspS6kGg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywnm6v2fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:47:22 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RDlLmZ030847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 13:47:21 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Jun 2024 06:47:20 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH] devres: Simple code optimization
Date: Thu, 27 Jun 2024 21:47:16 +0800
Message-ID: <1719496036-24642-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <d029d754-aeb7-493a-8e48-6acaa53fee1e@quicinc.com>
References: <d029d754-aeb7-493a-8e48-6acaa53fee1e@quicinc.com>
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
X-Proofpoint-GUID: OJfWd-KgA61BIvN0pRLAkaXSo_4crxfT
X-Proofpoint-ORIG-GUID: OJfWd-KgA61BIvN0pRLAkaXSo_4crxfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_09,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=939 lowpriorityscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406270104

Initialize an uninitialized struct member for devres_open_group()
and simplify devm_percpu_match() implementation.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
This change is intend to replace below one:
https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/#t

 drivers/base/devres.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..5b1d498e83ab 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -567,6 +567,7 @@ void * devres_open_group(struct device *dev, void *id, gfp_t gfp)
 	grp->id = grp;
 	if (id)
 		grp->id = id;
+	grp->color = 0;
 
 	spin_lock_irqsave(&dev->devres_lock, flags);
 	add_dr(dev, &grp->node[0]);
@@ -1172,9 +1173,9 @@ static void devm_percpu_release(struct device *dev, void *pdata)
 
 static int devm_percpu_match(struct device *dev, void *data, void *p)
 {
-	struct devres *devr = container_of(data, struct devres, data);
+	void __percpu *ptr = *(void __percpu **)data;
 
-	return *(void **)devr->data == p;
+	return ptr == (void __percpu *)p;
 }
 
 /**
-- 
2.7.4


