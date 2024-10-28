Return-Path: <linux-kernel+bounces-384180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2BA9B25BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF151B20C44
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319C918F2CF;
	Mon, 28 Oct 2024 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R3UFWT/m"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372B18DF68
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097207; cv=none; b=LjmHSuVCW+ReU5U1UuabVym6D6V0LSWTxVdnCfG81yKep3R8+1UyFHVHpG7kLB9Uc7aGwV3qn1wGPOkeUGR+MBVaZgbbsjEhVUj0nGvJc993Ii0gPudN096IEobbSmF/mxBtFsChWfUsdgudGd5mqqneiMMBb3Azbr3VCxXMXCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097207; c=relaxed/simple;
	bh=vNll1SMgi0otneBaANsSGFtb0NchrOZ0cV5lKY+bvK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NJE//h3/YkQfceGNgjo0JLladPBg5NGQYAiu1FD3316NkMeI94DJoPJysuSwiji2SvSgCP+MoW9ofwtRv84KZmb5NlUSRKnMLPkFDHGn6xgwQeuAYwp8TJ2BPmdd09U7RUYk3KoSJUGi05b+JvyFLim1yGAUt6qDezsFf89T/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R3UFWT/m; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730097201; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=elNekcpj/G8cv44W/V+w3ol+a4kfJq6UJseGzdiC6lU=;
	b=R3UFWT/mKY6Jrp/Xoa+iTe3oN1Uo/tW2QlSyKfvzgS635vuclEOGV+eYyDqtrvAvFrTOn0gjxa56kFQ4670jXxkmetw/zi/QsnCq/ktshwrXmFeiLzrM2ihN5OuxWsosSmIcyECY0lXRHH6EqrMBjhwpGvgnYttShpuZnWOR6J0=
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WI.X8uw_1730097200 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Oct 2024 14:33:21 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] sched/eevdf: Force propagating min_slice of cfs_rq when a task changing slice
Date: Mon, 28 Oct 2024 14:33:12 +0800
Message-Id: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
References: <20241028063313.8039-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a task changes slice and its cgroup se is already on_rq, the cgroup
se will not be enqueued again, and hence the root->min_slice leaves
unchanged.

Force propagating it when se doesn't need to be enqueued (or dequeued).
Ensure the se hierarchy always get the latest min_slice.

Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6512258dc71f..7dc90a6e6e26 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7017,6 +7017,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
@@ -7141,6 +7142,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running -= h_nr_running;
-- 
2.39.3


