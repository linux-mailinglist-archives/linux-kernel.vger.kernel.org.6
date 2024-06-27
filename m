Return-Path: <linux-kernel+bounces-231843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD202919F06
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7866A1F21D20
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940A2374C;
	Thu, 27 Jun 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E6KMmUlo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4D61CF92;
	Thu, 27 Jun 2024 06:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719468353; cv=none; b=oru8Xqy2zMBI3IbtwSN+IWpytbgi+/Wt6gDn6ZQl0Gq4W7AXm3q1hktENVJ0sR2TQ27sKDA8kro25TY/AeWkM5vTn8RR0163GorfxA/XdzZEpcom4rOG5NECuR65DkHKQFeP87yG4f1TjLtkMs1INyZYiLx/gKgcHLcRQVD3DR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719468353; c=relaxed/simple;
	bh=H5VF+l68DcTm9bz64mmOzOSS/8PFfU136LFYP9ln8RE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kn3CVizS/HV+4DkMHA0tnB1e8YSv9ROzshShwPgcjlo35CJS3feaN0hQ8+IN7iLsob9sSjBDZt46yC3CEZeMUpBGJtL+2NU9UrSLxJx03dU7j4lqj+wTUjmtNHayZlycOMMv9k2vMC6wYxf2AYTCpXWN/sExIZ5DLlQy6Usiv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E6KMmUlo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R1AYKo019664;
	Thu, 27 Jun 2024 06:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qds3p3qHA6+WZ2ajsEavoH
	+smW6BoQfK9ybky+7OLzc=; b=E6KMmUlofO4BhDjFW/zDi9dcIzPwXL7lYaDlox
	GQP8wfEUzhVqdkm9CGRwDlfwBhZCv+gYDINBDDY5nMeisHjVlNd28c2lm0xpqUIU
	IR1A+RErZiDcmVcAZuU+tAZGexJ8zDflNOlHCAfWkcFSRr5OOeulxNK/oOUlCG1H
	FrvjsxInDfxKOyLs2ebBpP9djsfXDig7xfRp/1RGDNKGjXA626TcNo6NWMa86CL2
	PFW5X9uEUkQEOA9Qu6kH0owqIiDGZY/wbbDxG64p9MGubkAM+LHexwO91VFPX7RD
	Q+pQ+1nEs+IkhZz9BQZUhugLQghsczbcVyDYLTXTUDWz3tmg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400f90jn0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 06:05:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45R65gjg020397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 06:05:42 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 23:05:26 -0700
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <quic_bkumar@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_chennak@quicinc.com>,
        <dri-devel@lists.freedesktop.org>, <arnd@arndb.de>,
        stable
	<stable@kernel.org>
Subject: [PATCH v2] misc: fastrpc: Remove user PD initmem size check
Date: Thu, 27 Jun 2024 11:35:18 +0530
Message-ID: <20240627060518.1510124-1-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BSCAxBFTNYK2lMSxuttyccRj2S0dM9uL
X-Proofpoint-GUID: BSCAxBFTNYK2lMSxuttyccRj2S0dM9uL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_02,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406270044

For user PD initialization, initmem is allocated and sent to DSP for
initial memory requirements like shell loading. This size is passed
by user space and is checked against a max size. For unsigned PD
offloading, more than 2MB size could be passed by user which would
result in PD initialization failure. Remove the user PD initmem size
check and allow buffer allocation for user passed size. Any additional
memory sent to DSP during PD init is used as the PD heap.

Fixes: 7f1f481263c3 ("misc: fastrpc: check before loading process to the DSP")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v2:
  - Modified commit text.
  - Removed size check instead of updating max file size.

 drivers/misc/fastrpc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5204fda51da3..9d064deeac89 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1389,11 +1389,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
-	if (init.filelen > INIT_FILELEN_MAX) {
-		err = -EINVAL;
-		goto err;
-	}
-
 	inbuf.pgid = fl->tgid;
 	inbuf.namelen = strlen(current->comm) + 1;
 	inbuf.filelen = init.filelen;
-- 
2.34.1


