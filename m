Return-Path: <linux-kernel+bounces-261819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D293BC85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77595282503
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223B716C6A5;
	Thu, 25 Jul 2024 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Svn74ksF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E919BB7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 06:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888748; cv=none; b=Q+9Ap4eJUHD1B2pt3aI2l/flYpVs+CRj9Mfcjog2gGVfAX1ZMxCs1r29+yk4NiN4uMQeKunphl8GsSC6lQ2Q0k0NjxBsPBBzEOvqp9gkXIAN8xVtnZ1NzQK0CcDAWH5xg6ljQlBu5Wi/Z884yExlEDVWsBTVxELuOX1DkP3Mn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888748; c=relaxed/simple;
	bh=gT7xCuuBm4YTL921K/hz8dhZ4C1rhSIUnF8BEilq9KU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RUND5KI0oBefjw2+JcOFThYzE43OKiB1rCRIF4HYvamOiIxEpBb6pPCybXhJxZao7jrq7cc2XQ/TWOjFcVsjcfLyKCLPbOewh1QRyACXMRpbaqur56+gLr/f7ZorAji+uXshOnGJSuTV6FWs83mMCeGhT+aIzzNNR9mfzl8R0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Svn74ksF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P48Jvd006897;
	Thu, 25 Jul 2024 06:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DcakYKsNw9rsmu1ouxOu3e
	BRMxRp066i73VmpTdSR5A=; b=Svn74ksFIfJFnKHe2YE5vM2Kb6a56Dd4u9ZC/T
	9/cUowe32fthydwWnC1LgxRVOpS3e2ewpzR0KZMN50CMgHWcX7Cp8fbjwpJ9lGKX
	yhdYqDOK76nf2krXxPfMF+F42ShvEZZjTAYzzgPnycDe4p04cQKXg30wkvYLRge/
	6prkmZLPFLU2yRE40TbAsPTkpFo/ovOGKl4s3brQp6hDPQJuwBe9t3WCp03EIrqm
	VJH8Ty81Gjnny/16XBBEPRlywszka12pOtN1JeOpyW6ZvB6lRD46moKgp/cATiiQ
	Xdvfk2N1mwBXpbFnIblehne/aT87w1xJWjPnhgsqDfGDu0yw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40k413hqjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 06:25:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46P6PXgF021414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 06:25:33 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Jul 2024 23:25:30 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <gregkh@linuxfoundation.org>, <arve@android.com>, <tkjos@android.com>,
        <maco@android.com>, <joel@joelfernandes.org>, <brauner@kernel.org>,
        <cmllamas@google.com>, <surenb@google.com>, <liulei.rjpt@vivo.com>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2] binder_alloc: Fix sleeping function called from invalid context
Date: Thu, 25 Jul 2024 11:55:10 +0530
Message-ID: <20240725062510.2856662-1-quic_mojha@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zZxccSUVXyphlv3DiOD00FgRl4t4MUF8
X-Proofpoint-GUID: zZxccSUVXyphlv3DiOD00FgRl4t4MUF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_05,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250039

36c55ce8703c ("binder_alloc: Replace kcalloc with kvcalloc to
mitigate OOM issues") introduced schedule while atomic issue.

[ 2689.152635][ T4275] BUG: sleeping function called from invalid context at mm/vmalloc.c:2847
[ 2689.161291][ T4275] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 4275, name: kworker/1:140
[ 2689.170708][ T4275] preempt_count: 1, expected: 0
[ 2689.175572][ T4275] RCU nest depth: 0, expected: 0
[ 2689.180521][ T4275] INFO: lockdep is turned off.
[ 2689.180523][ T4275] Preemption disabled at:
[ 2689.180525][ T4275] [<ffffffe031f2a2dc>] binder_alloc_deferred_release+0x2c/0x388
..
..
[ 2689.213419][ T4275]  __might_resched+0x174/0x178
[ 2689.213423][ T4275]  __might_sleep+0x48/0x7c
[ 2689.213426][ T4275]  vfree+0x4c/0x15c
[ 2689.213430][ T4275]  kvfree+0x24/0x44
[ 2689.213433][ T4275]  binder_alloc_deferred_release+0x2c0/0x388
[ 2689.213436][ T4275]  binder_proc_dec_tmpref+0x15c/0x2a8
[ 2689.213440][ T4275]  binder_deferred_func+0xa8/0x8ec
[ 2689.213442][ T4275]  process_one_work+0x254/0x59c
[ 2689.213447][ T4275]  worker_thread+0x274/0x3ec
[ 2689.213450][ T4275]  kthread+0x110/0x134
[ 2689.213453][ T4275]  ret_from_fork+0x10/0x20

Fix it by moving the place of kvfree outside of spinlock context.

Fixes: 36c55ce8703c ("binder_alloc: Replace kcalloc with kvcalloc to mitigate OOM issues")
Acked-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2:
 - Added Acked-by from Carlos.L .
 - Fixed one typo error in commit text pointed by Carlos.L .

 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index b00961944ab1..b3acbc4174fb 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -939,9 +939,9 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
-		kvfree(alloc->pages);
 	}
 	spin_unlock(&alloc->lock);
+	kvfree(alloc->pages);
 	if (alloc->mm)
 		mmdrop(alloc->mm);
 
-- 
2.34.1


