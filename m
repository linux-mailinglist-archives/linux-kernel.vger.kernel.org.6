Return-Path: <linux-kernel+bounces-272652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DB1945F72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14F71F2380D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922AA20FABE;
	Fri,  2 Aug 2024 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UsqKBTiw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD8E17C6A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609123; cv=none; b=FSthAXUq2rU0HCkZJUjRhTRyE6x+fVE1ijEL1N5K8zSTFL874NpFoWw++JuIc5goqrZr38xGTNXVNx6zdb+/9PU05suItpuwEGvqFAJ9vKpoMvUc9Mqr1S2HCuUD+aCskkY8MX5RAOAitObOTf+BJuUegjKp5zlosUcLvBnZFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609123; c=relaxed/simple;
	bh=kkeurzW1y+5hb6c8UxDc61+XVWJTLKGpYqVjRXZ8cMI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdAsLPWJwhvTf94MyIaE7Ux1FaEY7Xs7ICwTR6LbjwOycq0ZuoLEF97OQTjn80GK1QPiYKruVZgoxXl/lSs13lMlslfN+RlbnQtTOPUAWvKnRVCby1KXpbgZGydYJaz40Q4mVv8UCSx92Pd4zz4zfrLAtR/Y/1Jm8dObQ6O4d8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UsqKBTiw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471LfLJZ020395;
	Fri, 2 Aug 2024 14:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=NHJ6WJjM4DIScQtkRLyT+I
	4AAQ8AX5dzgiRjHLnx5EQ=; b=UsqKBTiwwlbLCM3hTIEtkEk/4yONQ3Apm4D9s7
	JPebE5hjT8Np0SoSj1G90qEbRMsG9JlV/x/w7mOxiftcrVX9H4FkTtOp/e0hJb+R
	CL9XQfZbfmUyemyTlk/iKk+H7PHF4E8Ed1hfAIEDZ9MGFNy90bN6cmJmB4nXUlsM
	1a56GbYjrUO8qk+QuE98iO77TEoA8udEBJ/qAG/svl2Sfn1CcEsk1JQhtri0Lynd
	1KjQlX85/JwZlcmx7FLjVsagd0ASraP7W/gB5hfUPrtrkaQ3xqXeErP38qXWkO5B
	H6LbS6D8AgQJ3Ocmynfv1EfnI05dvKWxOvzXAOHzJXdOSWPQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40rjgchx2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 14:31:34 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 472EVXcb001697
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 14:31:33 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 07:31:30 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <vschneid@redhat.com>,
        <mgorman@suse.de>
CC: <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH] sched: idle: Optimize the generic idle loop by removing needless memory barrier
Date: Fri, 2 Aug 2024 22:30:07 +0800
Message-ID: <20240802143007.2438213-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YROW4Oj_wpW_0QKuwKLMBVVIIAe8XuhI
X-Proofpoint-GUID: YROW4Oj_wpW_0QKuwKLMBVVIIAe8XuhI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=566 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408020100

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


