Return-Path: <linux-kernel+bounces-340332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 977889871B8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54720289400
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BB01AD3E9;
	Thu, 26 Sep 2024 10:40:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6B4193408
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347203; cv=none; b=LP32N+Ht0YyFaHg0J5S8KELXz2a78zWnmyVSjlrOR0VUSLPsO0fyKtk8gQPQedJxOCUa1ZmK2oqZG+HzcPMXqAPKQLWa1wrhGnoOERXpE8+95iNTFFWJe9IFRCJy5+MvlCirePW/LGrSpPxAXuhYB3BQtO4SzCXERMGS1xahio4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347203; c=relaxed/simple;
	bh=PLN2G6uQseNnthBFGF7QiMJ4BYonwnZaYTOe+ZHhWr4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jk4bnZ8S9H6SYcRSL8v4jNlV0LVex8t5gnnfc0OWhAO5zvszg9nQzDTeLzmycM8AP/LUWJluJhM9GaLLN/jZykJ3DnyFQMtOotxiC+vTXtI7JEa0aIOagSSElZnFmNDl4FBqW+aEfc0rEtg02M1c/gdlfTEqf/idNtk7Co6gGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XDqpv3LD9z20pGc;
	Thu, 26 Sep 2024 18:39:35 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id D0D6A1A0188;
	Thu, 26 Sep 2024 18:39:57 +0800 (CST)
Received: from huawei.com (7.223.141.1) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 18:39:56 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH] sched_ext: Remove redundant p->nr_cpus_allowed checker
Date: Thu, 26 Sep 2024 18:39:49 +0800
Message-ID: <20240926103949.694868-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200007.china.huawei.com (7.202.181.34)

select_rq_task() already checked that 'p->nr_cpus_allowed > 1',
'p->nr_cpus_allowed == 1' checker in scx_select_cpu_dfl() is redundant.

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index eabf8705e1e6..e91d5e9caa2f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3051,22 +3051,13 @@ static s32 scx_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 	 * there is an idle core elsewhere on the system.
 	 */
 	cpu = smp_processor_id();
-	if ((wake_flags & SCX_WAKE_SYNC) && p->nr_cpus_allowed > 1 &&
+	if ((wake_flags & SCX_WAKE_SYNC) &&
 	    !cpumask_empty(idle_masks.cpu) && !(current->flags & PF_EXITING) &&
 	    cpu_rq(cpu)->scx.local_dsq.nr == 0) {
 		if (cpumask_test_cpu(cpu, p->cpus_ptr))
 			goto cpu_found;
 	}
 
-	if (p->nr_cpus_allowed == 1) {
-		if (test_and_clear_cpu_idle(prev_cpu)) {
-			cpu = prev_cpu;
-			goto cpu_found;
-		} else {
-			return prev_cpu;
-		}
-	}
-
 	/*
 	 * If CPU has SMT, any wholly idle CPU is likely a better pick than
 	 * partially idle @prev_cpu.
-- 
2.33.0


