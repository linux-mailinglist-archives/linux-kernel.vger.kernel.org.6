Return-Path: <linux-kernel+bounces-356719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581499659C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5470E1C213F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA547189520;
	Wed,  9 Oct 2024 09:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jpMlhsOf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE4176AB5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466710; cv=none; b=kRYcqIIABtiuK5tPhw4/8v/QDL3YxwA3llgbL5KNWe502MJtnNilY6NQX/Yj0aAECsyoL2AA49myG3Mp/6H4mBTtt3T2dlIFEl+phMekFiV8WQdYo/raAjY5Y6gRu8O1tOfV82VPDHwj+0pmAl/G949tvZ+vfIB8cFWYKQUsBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466710; c=relaxed/simple;
	bh=aGeuVzjmFfKhtNsDcqyEG1QhHCAlTEz544fl8iWTuvA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jtcn9ytg39y8vSLkULwnYGizeDpEIokTwJpwhoLufJJ53eDvF3r+91/e7JPNUiXkVFmpk8jn0hxTRXXU3IErVDu8Nu+ys7ZmeH82rkfysep3t9btJOZuJ8PZWTF7TwbACQ72H8alGvENrnohtTfm0Mwer5JfAmZfwYUWvb4+Ka8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jpMlhsOf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4996QEfI014232;
	Wed, 9 Oct 2024 09:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mB11MqhjrdbezmMyBd9hVL
	ETfc7M2OTBcldOgM+DDh8=; b=jpMlhsOfHY9iT6RCZJ8aqKJPlMMwXnJx4vr+qT
	xmKSTs5bUrIo0az+jk/hGowtLjN6RKGrueqmgoN+bxsfE7/LyaZs4iw+EAv0A7O3
	+YtMXOG8O+K1h8YpLhG1+L0AB6DMIeoGNEUseM3XKhBi/kj9VJStHWrfW+DDhAk2
	U0uPqJ3xMyYcCH5R9muG0zoRR4YwagY1PXw+FkSoM637qX7qL1vJ5mTrS5QFEUZn
	AayYfi753Z1IeU0YSV7o35XQ+uf3ONNIxXhSbJWOxJrVgVRAXykNele3p1fFR2ZP
	WEjlhPjn3ALcmBk2PC/Twk1fehOd7ThILjm36aZzcCCTUZcQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42513u3rg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Oct 2024 09:38:09 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4999c8U3015141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Oct 2024 09:38:08 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 9 Oct 2024 02:38:05 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH RESEND] sched: idle: Optimize the generic idle loop by removing needless memory barrier
Date: Wed, 9 Oct 2024 17:37:45 +0800
Message-ID: <20241009093745.9504-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: EEKWr1xUWb9gJyqfV-1cp1G0b8I_jG2J
X-Proofpoint-GUID: EEKWr1xUWb9gJyqfV-1cp1G0b8I_jG2J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=559 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410090063

The memory barrier rmb() in generic idle loop do_idle() function is not
needed, it doesn't order any load instruction, just remove it as needless
rmb() can cause performance impact.

The rmb() was introduced by the tglx/history.git commit f2f1b44c75c4
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
index d2f096bb274c..ab911d1335ba 100644
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


