Return-Path: <linux-kernel+bounces-273666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FB7946BF9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C474B217A4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA81C287;
	Sun,  4 Aug 2024 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMkfr2bA"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056411803A
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739264; cv=none; b=ZIn0XNMMek1CiH+kk4jkHORAYLto40OIEAwE0ZhsTaOCS5TPGekFGjJ1ovM0kKjjowLq0x8A/Dd93zFA7/iuYegTTFz32jWGTG96pK0zJywn7LRc8rPzuZG1pq+S+gevcT4wfBTfQh+72I77wQ5eeY8es74Wds1m32maWfCv47g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739264; c=relaxed/simple;
	bh=UWn+HuhPuHXJXgXdEeNcbiamev3qZLaPDOwdwHwDcn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQBZPZB789FzYYD0hY+R39LgNuAQnnSzaBvTc6MpXcjQcRI/oj4Jv+BQocBdfl+09Ih2x7No0n6ddnAOThp5eBXLx8ubr16n6FPyx0vTTqdnkrKwxt3HFdrhnNoRYV53mSymCSl633XPs6fjxuoHo2qRAbyHomTyGuMrctGPPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMkfr2bA; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db14930a1aso6217450b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739262; x=1723344062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvSKieWh3sNFkVfHDKc9FKM+gKM4dX7Y7Clwjg0MG/s=;
        b=nMkfr2bApqoryPS6ne6ch41XRNIZLo6KoLc9AKp+yV/U2P04EW8RWz3tL+aHk/HRbI
         nEVgP8ZUC37AXyZSUgxTVmYTTIW6VsQkj+U4F2IjkUYhsq4Al2FmPjHA88LcL1xnoyJ0
         MRTGWagINswjKrVEEf51vvfWcOrjQlhpPUs57t75+2JdQT8e2V5TwAAhF07HIhcxQ7q0
         Xc9ez0ZVYm1D2pyggAKEy/dB+0sfkO//VNRHpPIVH+bkjPSf+s+fGeLZV37zafTPHtFP
         +LfNcpkDGXwivlpDHB/dis8LtGBB9F7LD5FY6LMtBVbtcYsMjow8tQRFyToz+yy1iIAq
         /2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739262; x=1723344062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gvSKieWh3sNFkVfHDKc9FKM+gKM4dX7Y7Clwjg0MG/s=;
        b=jW1oE5LYmSP8K/NVqPQ5xHeU7A3b9qqA7TOsqYEEkHmwkiPmVy5FNahj1bVU/gBMVy
         M8MvreMDLY311LDw/NfEkF4RmcV5rEEvrRFsg6qdE9uhBrBklSbFpW3SsG70RGi4z19n
         Sb4D2zptRqF5eZtsBgUsSXr5wkEQmNF05n4ScpKTVWBA/MLnZd9LwTt1yO6f2WUlBRDx
         QdHOl1sMqTvG8+gLy/CStqKkQB64ncg6yebKu+dTdx1Q3Hm4kFylKD4C6nTYR6Ptqip2
         u5VvKJaQWooG+oeFFkJe/O75xs4KGbqpjnZLNT+5sm6KXoM/EgcL5UkMtxB+/QAtUXeG
         rrZA==
X-Gm-Message-State: AOJu0YzXjz9BFCgTVoN/BI/PJl+bKKFWT7ScgEtvtqjegQqTh1d0jm5U
	sjUFTX6J0Cy4QNb6CA3B2QOAR3uZnKIKxL8HB4u6XqLQsaLrdjEh
X-Google-Smtp-Source: AGHT+IEBDK8UeYVjRVUmQtFuetgwgVjBfxz7rtiZAXz10fKd8cUnNY4zbbMNyqFe4nIlPE9XwVPTTg==
X-Received: by 2002:a05:6808:1984:b0:3d9:4147:4e38 with SMTP id 5614622812f47-3db55830b61mr9032928b6e.36.1722739261977;
        Sat, 03 Aug 2024 19:41:01 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f57aa2sm41980115ad.68.2024.08.03.19.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:41:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext: Make task_can_run_on_remote_rq() use common task_allowed_on_cpu()
Date: Sat,  3 Aug 2024 16:40:13 -1000
Message-ID: <20240804024047.100355-7-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

task_can_run_on_remote_rq() is similar to is_cpu_allowed() but there are
subtle differences. It currently open codes all the tests. This is
cumbersome to understand and error-prone in case the intersecting tests need
to be updated.

Factor out the common part - testing whether the task is allowed on the CPU
at all regardless of the CPU state - into task_allowed_on_cpu() and make
both is_cpu_allowed() and SCX's task_can_run_on_remote_rq() use it. As the
code is now linked between the two and each contains only the extra tests
that differ between them, it's less error-prone when the conditions need to
be updated. Also, improve the comment to explain why they are different.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/ext.c   | 21 ++++++++++++++++-----
 kernel/sched/sched.h | 18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2ccc2c4b4d3..3c22d0c8eed1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2311,7 +2311,7 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
 	/* When not in the task's cpumask, no point in looking further. */
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+	if (!task_allowed_on_cpu(p, cpu))
 		return false;
 
 	/* migrate_disabled() must be allowed to finish. */
@@ -2320,7 +2320,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 
 	/* Non kernel threads are not allowed during either online or offline. */
 	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu) && task_cpu_possible(cpu, p);
+		return cpu_active(cpu);
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7837a551022c..60a7eb7d8a9e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2224,19 +2224,30 @@ static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
 
 #ifdef CONFIG_SMP
 /*
- * Similar to kernel/sched/core.c::is_cpu_allowed() but we're testing whether @p
- * can be pulled to @rq.
+ * Similar to kernel/sched/core.c::is_cpu_allowed(). However, there are two
+ * differences:
+ *
+ * - is_cpu_allowed() asks "Can this task run on this CPU?" while
+ *   task_can_run_on_remote_rq() asks "Can the BPF scheduler migrate the task to
+ *   this CPU?".
+ *
+ *   While migration is disabled, is_cpu_allowed() has to say "yes" as the task
+ *   must be allowed to finish on the CPU that it's currently on regardless of
+ *   the CPU state. However, task_can_run_on_remote_rq() must say "no" as the
+ *   BPF scheduler shouldn't attempt to migrate a task which has migration
+ *   disabled.
+ *
+ * - The BPF scheduler is bypassed while the rq is offline and we can always say
+ *   no to the BPF scheduler initiated migrations while offline.
  */
 static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
 {
 	int cpu = cpu_of(rq);
 
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+	if (!task_allowed_on_cpu(p, cpu))
 		return false;
 	if (unlikely(is_migration_disabled(p)))
 		return false;
-	if (!(p->flags & PF_KTHREAD) && unlikely(!task_cpu_possible(cpu, p)))
-		return false;
 	if (!scx_rq_online(rq))
 		return false;
 	return true;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b88a46d3fce..2b369d8a36b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2530,6 +2530,19 @@ extern void sched_balance_trigger(struct rq *rq);
 extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
+extern inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
+{
+	/* When not in the task's cpumask, no point in looking further. */
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return false;
+
+	/* Can @cpu run a user thread? */
+	if (!(p->flags & PF_KTHREAD) && !task_cpu_possible(cpu, p))
+		return false;
+
+	return true;
+}
+
 static inline cpumask_t *alloc_user_cpus_ptr(int node)
 {
 	/*
@@ -2563,6 +2576,11 @@ extern int push_cpu_stop(void *arg);
 
 #else /* !CONFIG_SMP: */
 
+static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
+{
+	return true;
+}
+
 static inline int __set_cpus_allowed_ptr(struct task_struct *p,
 					 struct affinity_context *ctx)
 {
-- 
2.46.0


