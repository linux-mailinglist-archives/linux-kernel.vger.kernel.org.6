Return-Path: <linux-kernel+bounces-261225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C493B45C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FD2285653
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881415B562;
	Wed, 24 Jul 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ojcYHJH4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048D81598F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836590; cv=none; b=VYuIvXNKkV/NIYfo3jwdcMe9qSGmbmthT2/9+TtcTSc4QNEECPg1dNoWBfHopP0CAtlcfVaEtOruIETd6UQwoKaxqpxquNuT8ED3VeDQQv/Anq6y2QRniho9DXWmJ76A3CoeaS7E1RZgXnji7kzFNRzxACIy1y8sMdhPZuPMSsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836590; c=relaxed/simple;
	bh=S/fZPy5vixoJo4JGrNaWp35RnKFIhX+NfSwY91JdQ1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=khv+cwp/iJPSK8X1UMh798nZUc78yzreUTr7V+JsRanQVTi0oOmcmDGJ3c7mOSpCptgfgYnscitObiME7f3ue9A7bs6P9omtPJYdHkiAi8sco5dt9/pIsnktix1aJpyALxgc5gpa2AeMm0CMjOUPfcuy7AIKkksv8d1E54EWwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ojcYHJH4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OASlfZ032004;
	Wed, 24 Jul 2024 15:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mHVZdRnl1C9yZAw3PDvlUl
	8KeuKay5/3Gkqs4K3YQbQ=; b=ojcYHJH4c/7BIwtE04U3gIVnqxq/Y3DdMVDP3v
	+KT6DKkZyQDesQyLz4xun1YnrgTW8VlzibWu/VUeAOGXLUEbUTo6NxGlxiLtgDXC
	Vq/WjZGCoEhow9lRtWwVNIckkmteA8TGfgKqo5rCy9SCXtSI0ecbNM+Dp6ubsCLc
	hcEzjFzLkpZmEsAN3XEiQFVswFYw3t12CAzv4Pdn9Pr2fW0WxakfZyaQykA9DGR9
	nrMStERIaukuMyXUKCVlbuqXlgJokOPpezh6ZmErkOjxoK6g7O3u0qi8sS/sgba3
	XTAiE8QWvUkRykwla1Z1zmQgqG55xQ4sCFybNB/ziiSRJa3Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurts58v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 15:56:22 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OFuLBX028506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 15:56:21 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Jul 2024 08:56:17 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <gregkh@linuxfoundation.org>, <arve@android.com>, <tkjos@android.com>,
        <maco@android.com>, <joel@joelfernandes.org>, <brauner@kernel.org>,
        <cmllamas@google.com>, <surenb@google.com>
CC: <linux-kernel@vger.kernel.org>, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] binder_alloc: Fix sleeping function called from invalid context
Date: Wed, 24 Jul 2024 21:25:55 +0530
Message-ID: <20240724155555.2405467-1-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: lCchki5777u3v2WOmAIoVxcrSNhmC78s
X-Proofpoint-ORIG-GUID: lCchki5777u3v2WOmAIoVxcrSNhmC78s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_15,2024-07-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240115

36c55ce8703c ("binder_alloc: Replace kcalloc with kvcalloc to
mitigate OOM issues") introduce schedule while atomic issue.

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
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
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


