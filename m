Return-Path: <linux-kernel+bounces-550558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6BA56118
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16B9176C3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4AE19D081;
	Fri,  7 Mar 2025 06:47:01 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223C18FDDF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 06:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330020; cv=none; b=U07yOhm0VDeFzuaLohyQftISR81BPOW7oM6uM9G9nqnPmfmn6t4FeYmDV3znVh9ZF7pIKbYjjNcdw+eOvjTKy4DDOuXKmCpatY/ydkg6kPtweaCledEH4xz8tzaO88s9+G1i3EptQYxYDYb+zdLsFF5G5KudFhSOta8JrR3GfCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330020; c=relaxed/simple;
	bh=tqN7YV2/K/pq6371MddAZ5p6Dol0Hg7j/y85drm3Qhg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMjGKYD9X/T+xn2Q0MjOT7lvT+E8hmT/Jy6TtB+5VjTJMc0IiQQJ6Vh3mUfbvoFtUYFYyL9WPcnktsoUpLlj5KHmj2PHJEbTCPQaSr5O1VzBGRyytEinK0hXYTUB3t5UXnQEjFAH2kRRXBKCsR0jOBCQBfqKg9jm+p+EDW2Vzdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <tj@kernel.org>, <void@manifault.com>, <arighi@nvidia.com>,
	<changwoo@igalia.com>, <mingo@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] sched_ext: Simplify cpumask computation in balance_scx
Date: Fri, 7 Mar 2025 14:45:33 +0800
Message-ID: <20250307064533.2663-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: BJHW-Mail-Ex08.internal.baidu.com (10.127.64.18) To
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-03-07 14:45:40:751
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2025-03-07 14:45:40:766
X-FEAS-Client-IP: 10.127.64.38
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Compare SMT CPU against RQ CPU and skip balance it, to avoid calling
for_each_cpu_andnot() and cpumask_of(), they are relatively expensive

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/sched/ext.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0f1da19..7e40ede 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2920,11 +2920,19 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 	 */
 	if (sched_core_enabled(rq)) {
 		const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
-		int scpu;
+		int scpu, cpu;
 
-		for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
-			struct rq *srq = cpu_rq(scpu);
-			struct task_struct *sprev = srq->curr;
+		cpu = cpu_of(rq);
+
+		for_each_cpu(scpu, smt_mask) {
+			struct rq *srq;
+			struct task_struct *sprev;
+
+			if (scpu == cpu)
+				continue;
+
+			srq = cpu_rq(scpu);
+			sprev = srq->curr;
 
 			WARN_ON_ONCE(__rq_lockp(rq) != __rq_lockp(srq));
 			update_rq_clock(srq);
-- 
2.9.4


