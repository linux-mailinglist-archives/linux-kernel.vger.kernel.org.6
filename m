Return-Path: <linux-kernel+bounces-289465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3A95467E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86DE62895BF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C671F170A3C;
	Fri, 16 Aug 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aNcffg5b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FF16F27C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802836; cv=none; b=g6i0FMHXlOXAMGXWQB48GHSkt9LLKuYTWnONwOXm/uVhEP/tqW/a7VHt97Xb7QBP+kYRlgeJiMOB4UH1um58RxqY/w7cIdt4W+D/7kPtxPOOVFJ+mtfVPlLsyaRYkInedn80Y3z4G4pfYAyzpz1JB+DSBDEKyK/rlsofKsvzHlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802836; c=relaxed/simple;
	bh=kkeurzW1y+5hb6c8UxDc61+XVWJTLKGpYqVjRXZ8cMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fYYcQFLNyUnQG7trY2xOrKx0QPs3f8ZZigtVtRTKgYYrG+4irnNOdrEsUuNFHGjNEVGf67xgRdzFmOdj4Qgo7+iMvogohlClL+sEKN/LbYRjLX5KqmiTDpeLcCkDm6F7Y67CUebT0/mbekoSWQQRYO+1+XXHhShRDVplszr2bmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aNcffg5b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G7TnfF031047;
	Fri, 16 Aug 2024 10:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NHJ6WJjM4DIScQtkRLyT+I
	4AAQ8AX5dzgiRjHLnx5EQ=; b=aNcffg5b/L8nmyMM+RiRl+jR1uf2maZ7SYu6GQ
	6c2MhBZXbFEyx5W4ZvGfejSfMBgfDjY/1eudmGJZK0IeQrPuXq6vhvpjD1UdaEfK
	pShCA3hECEhVSFup4RELWKSuQ2Rtf05puhXUtiF+TN8jcQeeymsEwGfX6q47ZGdP
	46rt7DV62ONxhbbo39n91oq6Lq1BeD89VZqfPGLLPLs5D56INQ8Jc1hry6XHa5B5
	1yqN8keyOEdT5sHeeZptP3kd1imvrXIGyXuWy9MIoK1rOAE2mhiYopJj8RC22Q+/
	6XY2ObhaVfTTI2v+N/c62HS0v8OYagtlS3tJsWej26+XAwcA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4103wsa0q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 10:06:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GA6uQn005110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 10:06:56 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 16 Aug 2024 03:06:53 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH RESEND] sched: idle: Optimize the generic idle loop by removing needless memory barrier
Date: Fri, 16 Aug 2024 18:06:21 +0800
Message-ID: <20240816100621.2518365-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: 7DMEQPNgffvVY3k35Bc3N9J9_8IiMlfu
X-Proofpoint-ORIG-GUID: 7DMEQPNgffvVY3k35Bc3N9J9_8IiMlfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_01,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=561 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160073

The memory barrier rmb() in generic idle loop do_idle() function is not
needed, it doesn't order any load instruction, just remove it as needless
rmb() can cause performance impact.

the rmb() was introduced by the tglx/history.git commit f2f1b44c75c4
("[PATCH] Remove RCU abuse in cpu_idle()") to order the loads between
cpu_idle_map and pm_idle. It pairs with wmb() in function cpu_idle_wait().

And then with the removal of cpu_idle_state in function cpu_idle() and
wmb() in function cpu_idle_wait() in commit 783e391b7b5b ("x86: Simplify
cpu_idle_wait"), rmb() no longer has a reason to exist.

After that, commit d16699123434 ("idle: Implement generic idle function")
implemented a generic idle function cpu_idle_loop() which resembles the
functionality found in arch/. And it retained the rmb() in generic idle
loop in file kernel/cpu/idle.c.

And at last, commit cf37b6b48428 ("sched/idle: Move cpu/idle.c to
sched/idle.c") moved cpu/idle.c to sched/idle.c. And commit c1de45ca831a
("sched/idle: Add support for tasks that inject idle") renamed function
cpu_idle_loop() to do_idle().

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
---
 kernel/sched/idle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index e53e2da04ba4..712c1ce16c8b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -271,7 +271,6 @@ static void do_idle(void)
 	tick_nohz_idle_enter();
 
 	while (!need_resched()) {
-		rmb();
 
 		/*
 		 * Interrupts shouldn't be re-enabled from that point on until
-- 
2.25.1


