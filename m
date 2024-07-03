Return-Path: <linux-kernel+bounces-238745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28659924F79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D496F28652D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9725B49655;
	Wed,  3 Jul 2024 03:19:51 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ABF3B298
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976791; cv=none; b=D1JSd6rBoOr3gRNNgmkECpKLa9/Op2Fv30FIULTO0mQ4TDATTOgyHRq/NE/137p98/uYp+QnBsRDUmHKtu2WLT0zmob5JM61eANiCM2IY4ALpPq/wil6X/Vk6B/lwvhPuTjWHbwvW2dnZO1RWsuFw4LG8zxBXFfCf8revBRIxak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976791; c=relaxed/simple;
	bh=+Fg0EpTU/dsZtDLluZ/U+IGeSTNF6TLM5CzbgMNvRjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUSxKdmhVIwVagygPRXfXwSJo9kVBhy1AoHcgxnO+hs+De/uUUnE3d0jjmhh4S9o+mrZRqHqI2dFbj+7tMGAvcnoLesd41puZglDI71NxlK/N12kRZ1wqs5fNzFZgf9MyIPEQwxS6ytxyzdMfSIeToKrC/s+/FALGA+X19AfdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WDQ4N5z5Zz4f3l11
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 549A31A0572
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YZHw4Rm+T8VBA--.56302S7;
	Wed, 03 Jul 2024 11:19:45 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	tglx@linutronix.de,
	yu.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Subject: [PATCH 3/4] sched/core: Introduce sched_set_rq_on/offline() helper
Date: Wed,  3 Jul 2024 11:16:09 +0800
Message-Id: <20240703031610.587047-4-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703031610.587047-1-yangyingliang@huaweicloud.com>
References: <20240703031610.587047-1-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBn0YZHw4Rm+T8VBA--.56302S7
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xur1rJr17AF13WryUZFb_yoW8Kr1Upw
	srZr45KrW5tF42934Yqr48GrW3uwn3Jry7ZF4fG3yrAF15C39Yyr18X3WaqrWjg3s5uFW3
	ArykKrWIga1DJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbHa0PUUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Introduce sched_set_rq_on/offline() helper, so it can be called
in normal or error path simply. No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/sched/core.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5cff01046685..2e114bce517a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9604,6 +9604,30 @@ void set_rq_offline(struct rq *rq)
 	}
 }
 
+static inline void sched_set_rq_online(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_online(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void sched_set_rq_offline(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -9673,7 +9697,6 @@ static inline void sched_smt_present_dec(int cpu)
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 
 	/*
 	 * Clear the balance_push callback and prepare to schedule
@@ -9702,12 +9725,7 @@ int sched_cpu_activate(unsigned int cpu)
 	 * 2) At runtime, if cpuset_cpu_active() fails to rebuild the
 	 *    domains.
 	 */
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_online(rq, cpu);
 
 	return 0;
 }
@@ -9715,7 +9733,6 @@ int sched_cpu_activate(unsigned int cpu)
 int sched_cpu_deactivate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
 	int ret;
 
 	/*
@@ -9746,12 +9763,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
 
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_offline(rq, cpu);
 
 	/*
 	 * When going down, decrement the number of cores with SMT present.
-- 
2.25.1


