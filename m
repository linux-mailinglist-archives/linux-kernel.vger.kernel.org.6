Return-Path: <linux-kernel+bounces-541447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8404AA4BD08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E353B5C96
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8431F63C3;
	Mon,  3 Mar 2025 10:53:35 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28961F460B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999215; cv=none; b=UPQsPw1spyF2MxEepMMJOuSYX/MMlowsHbayJkvc62pLo+TiPVtPPCwXr2TOcDq2rSVkUqfRYwkel6gt65DI4oNHdHFsIOADhl8gBQKFd4d5xqBp7srWxfFCDASwySVwgkWlIzdtRozLV1xRnBfeKfN+wCwztQsO/OhjVSxzxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999215; c=relaxed/simple;
	bh=NA0aZjnv29CzK7eDSeZL4KPyo9JgFZx3N5dSEtDTILA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9JmqXZrJICxO+VppqxpyHnpmxtY699KBcemcRpLeZ7sKfN6nLxz9BrNmPPmAh+AXr2lzTiVs95rK1ztwa281M/3Z9Q7XQVMDG0CDgCIlCrkAEib5d3n577zMFweMw0libghBLk6NJOgyoXhiQxakPGKFZqa/DzAGMTUjOAFHMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArJRx092018;
	Mon, 3 Mar 2025 18:53:19 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wXL58vBz2K8nM6;
	Mon,  3 Mar 2025 18:48:34 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:17 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 1/3] sched/fair: Fixup-wake_up_sync-vs-DELAYED_DEQUEUE
Date: Mon, 3 Mar 2025 18:52:39 +0800
Message-ID: <20250303105241.17251-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105241.17251-1-xuewen.yan@unisoc.com>
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArJRx092018

Delayed dequeued feature keeps a sleeping task enqueued until its
lag has elapsed. As a result, it stays also visible in rq->nr_running.
So when in wake_affine_idle(), we should use the real running-tasks
in rq to check whether we should place the wake-up task to
current cpu.
On the other hand, add a helper function to return the nr-delayed.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
V2:
- add helper function (Vincent)
---
 kernel/sched/fair.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..a354f29c4f6f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7181,6 +7181,11 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	return true;
 }
 
+static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
+{
+	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
+}
+
 #ifdef CONFIG_SMP
 
 /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
@@ -7342,8 +7347,12 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
-		return this_cpu;
+	if (sync) {
+		struct rq *rq = cpu_rq(this_cpu);
+
+		if ((rq->nr_running - cfs_h_nr_delayed(rq)) == 1)
+			return this_cpu;
+	}
 
 	if (available_idle_cpu(prev_cpu))
 		return prev_cpu;
-- 
2.25.1


