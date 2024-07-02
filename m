Return-Path: <linux-kernel+bounces-237971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F8B92416F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 16:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2B0284E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A725A1BA872;
	Tue,  2 Jul 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hsKC0fkJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB3171653
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 14:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932010; cv=none; b=cIMFMsZSm/aNez5vb96vLrkQ9cW3ueoHeSgA5SMTgYkFqMNYtyP//4vT00CVCcZv9+Qe3UnVeqYGM3JdZtvQT7gM7Se1fA2LgK5JcSvT7pXxroSr6yMVEo9fLJEaBuT/x0Xskjz2CvvguPeRXwm69L8BharG5u7/Bgi4dCaq7KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932010; c=relaxed/simple;
	bh=n9+OSyY6JVVaHuxEs+OmSQkkojAPnO262eUlmjcpEwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWQnX9XZo0aIk4bqy8dpI60E0laOBLlekbrbmZyyxZlq/DqGwJaoMUVu2S20QXozS3sYB1+fbyozOxXIgM5s5d+b8pHa4qJdo63DDWgebm61ItpcQmYvQtWUX87AUe1ekZnoyFjyL4daf8QG2HBwVMRcwrBCS3hkofkTC/o/xDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hsKC0fkJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462CODAQ019885;
	Tue, 2 Jul 2024 14:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xIP+35kcvwVY+DrSEssdp2NJ
	vcSiut1rraURdmETjLo=; b=hsKC0fkJ+6KCAYNyoLgkzO1l6IHiWHL8xkoqI0+i
	0ognMsOT5wVXKvl9gFIDw9w/sC/DMjTv/Z6ZxNyk4vr8ppiTwlDhDY/2sOvpCx/J
	6Uu34+nqvQnRFcmvc2whmvfsD0wJH0UEGWsOD/08tZbcVrusxd9Jg3jluPNer2uS
	E5HoB/SO3Y4j6bTGOSnszpEd+vSR8eceL4i0cUtQ9+Kr1LNS1kxmKQXn9hBgbGai
	b7BVO8KQSU9EtO8LgtrASOFt2vGIrzRxJ5nLr1SoBywa0SxxZBB8u30jQmgFr3B0
	Cu/FkwGxdg3LqG9Th7nUgqScH8XAwTVEZyacpJmK6GJ+uA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402ag2gju4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 14:53:21 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462ErLfl006560
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 14:53:21 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 2 Jul 2024 07:53:18 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <brgl@bgdev.pl>,
        <madalin.bucur@nxp.com>, <davem@davemloft.net>,
        <andriy.shevchenko@linux.intel.com>,
        Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1 3/5] devres: Initialize an uninitialized struct member
Date: Tue, 2 Jul 2024 22:51:52 +0800
Message-ID: <1719931914-19035-4-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1719931914-19035-1-git-send-email-quic_zijuhu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: h8HOLRoaAz2KbaAdLQcAywq1VIpZD_YV
X-Proofpoint-GUID: h8HOLRoaAz2KbaAdLQcAywq1VIpZD_YV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_10,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=823 bulkscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020110

Initialize an uninitialized struct member for driver API
devres_open_group().

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
Previous discussion link:
https://lore.kernel.org/lkml/1718629765-32720-1-git-send-email-quic_zijuhu@quicinc.com/

Changes since the original one:
 - Simplify fix by use = instead of memset() and commit message

 drivers/base/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 8d709dbd4e0c..e9b0d94aeabd 100644
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
2.34.1


