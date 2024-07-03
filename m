Return-Path: <linux-kernel+bounces-238744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B42924F78
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C18B285FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39824087C;
	Wed,  3 Jul 2024 03:19:50 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3401078F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976790; cv=none; b=rp1BuiTbDJ+5v5L4vSjUnU2At+oZJVXgvyXOfsRyiSOhiCagxv0yrG15YR2oi5Sy4CZ4wxanxfAL6XvUQgbBC2LOws+hmGccxq/sFMJiMVtr5S2ynLxVa+JzSXFi9vDZEr4D0fJA6qreGqFx5tUS+h32RxuVdDdjLd8wmylhK+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976790; c=relaxed/simple;
	bh=Fk0IYafMlT2U3ZEawh69R/RGwgxCdMcOQ0JwoMuBx6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bf71yGsLQnApyN4mbi/I/njAWc2JJYd1b0LYpZFGBGVxWmVVfbya/u4uklWkCPknxcjADarAN71nmBDWh5fyJyrn4c7iD1o1x4AcvHJT3PGhDDcL3lPGgF2pCTf/wSmpno8Ck1kmOjqUPzkBynkWOCQH4qVWDIqW+/wkBBW61ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WDQ4M4tGZz4f3l14
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2F8AE1A016E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 11:19:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.103.91])
	by APP2 (Coremail) with SMTP id Syh0CgBn0YZHw4Rm+T8VBA--.56302S5;
	Wed, 03 Jul 2024 11:19:43 +0800 (CST)
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
Subject: [PATCH 1/4] sched/smt: Introduce sched_smt_present_inc/dec() helper
Date: Wed,  3 Jul 2024 11:16:07 +0800
Message-Id: <20240703031610.587047-2-yangyingliang@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBn0YZHw4Rm+T8VBA--.56302S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xur1UAryfAr1DWFW3Wrg_yoW8Zr4Upw
	1DXrWrKr4YyF1Utay5Ars3Jry5A3s3Jan7Xr43CFWrGF17J395trn7Kr9IqrWqg34F9rWa
	yFWxKaySk3WUJaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7TKZDUUUU
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Introduce sched_smt_present_inc/dec() helper, so it can be called
in normal or error path simply. No functional changed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 kernel/sched/core.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..880c4c03ef8a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9654,6 +9654,22 @@ static int cpuset_cpu_inactive(unsigned int cpu)
 	return 0;
 }
 
+static inline void sched_smt_present_inc(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
+#endif
+}
+
+static inline void sched_smt_present_dec(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_dec_cpuslocked(&sched_smt_present);
+#endif
+}
+
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -9665,13 +9681,10 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	balance_push_set(cpu, false);
 
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
-#endif
+	sched_smt_present_inc(cpu);
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
@@ -9740,13 +9753,12 @@ int sched_cpu_deactivate(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_dec_cpuslocked(&sched_smt_present);
+	sched_smt_present_dec(cpu);
 
+#ifdef CONFIG_SCHED_SMT
 	sched_core_cpu_deactivate(cpu);
 #endif
 
-- 
2.25.1


