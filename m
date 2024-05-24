Return-Path: <linux-kernel+bounces-188281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B721D8CDFFE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB88B22C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 03:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88511374D3;
	Fri, 24 May 2024 03:56:15 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEF439850
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 03:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716522975; cv=none; b=A6i96EAR/UXwpQSl2E3/80LZ+andfMN+6Rjm4g2EludU97ZuVdi+9ZCsK12bnOmK84s/38FMHUxz+lM1DMykFERE0wTN6yi5xuxRrdyPjAqFAWg5UJdlW+cXAcY8PQv+qvrcjwRN04KgZ4W0jJUtSEsAdo0Ra3DuXQT1+k651TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716522975; c=relaxed/simple;
	bh=b0OXx68f3pRMuKufG4kLSg9yI3HiTxdnA3tB5xoFOEo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dD2VhFZNyJ45D+MWJ+PtbSwSKKoCiq0XWTVYchOigoLTeh7tloyInKyaaqVqh0jqjb3X/HURa5amzn7lYI5Q2qSZwHzfK/5fN/5qecep7gvc0oslH7aA8cdxht1YBzTkkCdZUYdsYSsMZZp+jT3FgExfr/t4VFcgWKgdHTtdzRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VlrjY4PQ7z1ypJ4;
	Fri, 24 May 2024 11:53:05 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 22211180067;
	Fri, 24 May 2024 11:56:09 +0800 (CST)
Received: from octopus.huawei.com (10.67.174.191) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:56:08 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH] sched/numa: Correct NUMA imbalance calculation
Date: Fri, 24 May 2024 11:54:38 +0800
Message-ID: <20240524035438.2701479-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500001.china.huawei.com (7.192.104.163)

When perform load balance, a NUMA imbalance is allowed
if busy CPUs is less than the maximum threshold, it
remains a pair of communication tasks on the current
node when the source doamin is lightly loaded. In many
cases, this prevents communicating tasks being pulled apart.

But when I ran the lmbench bw_pipe testcase, I found that
it was a little inconsistent with the above expectations,
the communicating tasks were migrated to two different
NUMA nodes.

There may be two reasons for this issue:
1. calculate_imbalance() use local->sum_nr_running, it
may not be accurate, because the communication tasks run
on busiest group, it should be busiest->sum_nr_running.

2. In calculate_imbalance(), idles cpus are used to calculat
imbalance, but the group_weight may not be equal between local
and busiest group(My server has 4 NUMA nodes and kernel
builds 3 level NUMA sched_domain, some sched_group's weight
is different). In this case, even if both groups are very idle,
imbalance will be calculated very large, the difference of busy
cpus between groups might be more appropriate as imbalance value.

For lmbench bw_pipe(bw_pipe -P 1):
v6.6: 			1776.7533 MB/sec
v6.6 + this patch:	4323 	  MB/sec

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..c6170cde9c14 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1323,7 +1323,6 @@ static inline bool is_core_idle(int cpu)
 }
 
 #ifdef CONFIG_NUMA
-#define NUMA_IMBALANCE_MIN 2
 
 static inline long
 adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
@@ -1342,7 +1341,7 @@ adjust_numa_imbalance(int imbalance, int dst_running, int imb_numa_nr)
 	 * Allow a small imbalance based on a simple pair of communicating
 	 * tasks that remain local when the destination is lightly loaded.
 	 */
-	if (imbalance <= NUMA_IMBALANCE_MIN)
+	if (imbalance <= imb_numa_nr)
 		return 0;
 
 	return imbalance;
@@ -10727,14 +10726,15 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			 */
 			env->migration_type = migrate_task;
 			env->imbalance = max_t(long, 0,
-					       (local->idle_cpus - busiest->idle_cpus));
+					(busiest->group_weight - busiest->idle_cpus) -
+					 (local->group_weight - local->idle_cpus));
 		}
 
 #ifdef CONFIG_NUMA
 		/* Consider allowing a small imbalance between NUMA groups */
 		if (env->sd->flags & SD_NUMA) {
 			env->imbalance = adjust_numa_imbalance(env->imbalance,
-							       local->sum_nr_running + 1,
+							       busiest->sum_nr_running,
 							       env->sd->imb_numa_nr);
 		}
 #endif
-- 
2.18.0.huawei.25


