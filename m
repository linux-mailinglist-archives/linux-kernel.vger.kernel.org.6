Return-Path: <linux-kernel+bounces-276796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A9949888
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E4D28315B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0B14901A;
	Tue,  6 Aug 2024 19:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2GaIWdC"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B4273451
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722973148; cv=none; b=Yuib3JF52YGkOL0/2zOuq8YnSi5+2GxpFUugRh/hOXCpJKn4u4Z8XCJ5l+mJvtbRrVhIjmw9XN3CCrAh3BPMOuOQqUcHeSIhmHywyvOz7SqOUIrU3iMY6s2Bw00kUYsxlgKGhiDldH/ewCbTlJxPViUPriuluOl6jSRdM3aMg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722973148; c=relaxed/simple;
	bh=CEmV9kk1x9NVUxu7pV5ghytiouKJapHQK+y1plpAfpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAus5S2eNiyYYx4PgdE0ml9lw4jBT8xHs1kdTk33q1eoWkYyb3asZ9VupkJLqAbvSMYWfUpMK0IwAB56mSLExTpC7ImrcUUhIIVf3pQNlMG3zRymnQY4rCR5gWfIbRRVcTQGVcQRKuHUTgmy9qddBcnR8WAUMK3imqzmE+tQzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2GaIWdC; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd69e44596so1440665ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 12:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722973146; x=1723577946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2//OghJIZHl3CzmmdpguEikihfgbtuoM+g+3QYs2as=;
        b=X2GaIWdC+t/g2oNpHmULjTDEfk/cNlBYptsMDn9A/1czyF3hVfiobV1ClDmQeCPiJi
         4iQ0QmnHSvYyEbezOubfBTb7jyGBZNvoD61ZIXqk6O3k5jysHjYMDmpEBISoHRo6aAWe
         Zed5XWil9jJxGUTJcu1ORskHp1Y/6wGOIez3o+uijbOzhbarb0QMNKoeitiUZu0HsBkn
         llgetQijziKTvT8eKnxIZ3hKMkDLthstFKs9aMqHwsOGQzyhv+RuKxRM1MzcfLhrmj68
         4pzkkygjViod0kNHmk9k0Eb3xF6wXjU6yk6t47hleMgwriM0tkXi3knHsapCNwvSXwyr
         znGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722973146; x=1723577946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2//OghJIZHl3CzmmdpguEikihfgbtuoM+g+3QYs2as=;
        b=slsPi9sbOlTGpmTAtFrqyJGvW9Ims8aCY2SvUwTJDbWxDYrKpwOW7IxtuO2yCyf6mQ
         nAdo18Txy3thQ3IvwrNGyO804cPwVt6kpHPMhpw1taP6o5Hnl7ALG5IFzgxpxR1FXrLV
         sa1rPWS0jEPqsPiuavM3O/GQPtZaNqaXuSVeYRQWqy7GVZOG6UyrpNDDB8btt20Rk5fU
         P9tNRcJvGrPPOUDPp1ZJh+6oYN0YmCBGCY19DRktySacDQXOsc99sVtXSQVzly34Q1Vg
         P02jpgQ3d+C7tukT/wQfGMKQycsXCtj061nvKoa6xvpcYY1tzaj0gQsqM97MoLC1b2GA
         2elg==
X-Gm-Message-State: AOJu0YzMD6MElj0V64lm/Bo4yndF2hKvjiDrUHepqDSajYx2M8lmVXwk
	mjJkk/grIgZXWaK+BQLuNUVaDR/BigmkIzQPDbhAy6qT3tnqBOL+
X-Google-Smtp-Source: AGHT+IEt9wqQtnYymABcnZOGazDKjA/oGriq+w4JzKrQBZVV2TuJb+5nAfs/ZPu3M0TeiWeyq72vFg==
X-Received: by 2002:a17:902:ea0d:b0:1f7:1bf3:db10 with SMTP id d9443c01a7336-1ff57ea1bd6mr264790825ad.20.1722973146339;
        Tue, 06 Aug 2024 12:39:06 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20077401e79sm19576795ad.100.2024.08.06.12.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 12:39:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 6 Aug 2024 09:39:04 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, mingo@redhat.com
Subject: [PATCH v2 6/6] sched_ext: Make task_can_run_on_remote_rq() use
 common task_allowed_on_cpu()
Message-ID: <ZrJ72PZ2UTwubZRp@slm.duckdns.org>
References: <20240804024047.100355-1-tj@kernel.org>
 <20240804024047.100355-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804024047.100355-7-tj@kernel.org>

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

v2: Replace accidental "extern inline" with "static inline" (Peter).

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/core.c  |    4 ++--
 kernel/sched/ext.c   |   21 ++++++++++++++++-----
 kernel/sched/sched.h |   18 ++++++++++++++++++
 3 files changed, 36 insertions(+), 7 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2311,7 +2311,7 @@ static inline bool rq_has_pinned_tasks(s
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
 	/* When not in the task's cpumask, no point in looking further. */
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+	if (!task_allowed_on_cpu(p, cpu))
 		return false;
 
 	/* migrate_disabled() must be allowed to finish. */
@@ -2320,7 +2320,7 @@ static inline bool is_cpu_allowed(struct
 
 	/* Non kernel threads are not allowed during either online or offline. */
 	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu) && task_cpu_possible(cpu, p);
+		return cpu_active(cpu);
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2224,19 +2224,30 @@ static void consume_local_task(struct rq
 
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
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2530,6 +2530,19 @@ extern void sched_balance_trigger(struct
 extern int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx);
 extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_context *ctx);
 
+static inline bool task_allowed_on_cpu(struct task_struct *p, int cpu)
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

