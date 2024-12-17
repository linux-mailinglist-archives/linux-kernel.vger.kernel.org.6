Return-Path: <linux-kernel+bounces-449557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8D99F50B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03881892104
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB91F942F;
	Tue, 17 Dec 2024 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PiQ19sid"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB51F8AD2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451662; cv=none; b=TrlixuLGyFXHdmhy8q5k+yngaUlOuMnozJGTMSx/0X1+rZkBYij3alBhwCfq+jpNyUAyZDkRJw1y98lWj4N7lX32Dk9mnPg8LmOc9ZU0TinoWhD1qSf38ocnZBJq28/b4y+98xlLBA15l6A0Myneljt7rXP9a7Xw9kVF4Yxr/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451662; c=relaxed/simple;
	bh=By5YuEIuipiFnXmiDz/n4TQ75Kjk6rASsidWVGdlzT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ea5L8QEROYjBg5UCWVdD2eD6+cwvCR4yT1b2vAiK/p90Kp3KGu6h9CzdL8QXFykimP/V/nPx4qtAtFoKiQ4ix65CK6iV1M7sekEcCr1NyufTRPDE1NLiQaq34OlAkweHDt5sljKN1pnEragyoBhL0xC+r+OMt3SKBvYjrJ2wH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PiQ19sid; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4361815b96cso36871175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451658; x=1735056458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awmbUvkEZ2PZscQIRijoAF3PtVROPsmlOyeOqA542IY=;
        b=PiQ19sid07rdMOwmy6snMC4am7FF7ESCa+dhVMjudAEz5wgRiuN48PHkLbEKJApt6q
         5ruzm70JUYvNSqPFLtWXf9pk0UPb3WKtfzIhAsusxvb/35RDEI+LtjfyampF8CvEUKYP
         0xfUa/I5HCTHY3nbvCIe4W9aUUl3YWiAvfJcWpm0CGuhV7zLZs2iD/dHL1wZmDoldUjW
         dbb440dLtUyp1x5/HJCbKQbH/f0yFfboy9Uw3JdbH86ULewXz0njZ8U6dt456TkkrsKb
         5CTrs4/4KTqLvBKq7EsPKe3JYqIfEpdscsRgNt4Fkevm04533uyUatQLAnhdFAUR6YNe
         Gi/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451658; x=1735056458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awmbUvkEZ2PZscQIRijoAF3PtVROPsmlOyeOqA542IY=;
        b=A//GjC+mnXHQKDAWPuShT6vF/4FLHI/lI+s1oL9hn/5k/6jwe/Mp6DZ7ZDOT9dJ0RQ
         c336mqbZHDtg/VpRr+JwrhowoujgAOPRrN/MEWAWsaYZN2jov0Jl70QoGu2QRmLjqBGr
         447xUy6jQUqPQemfsoPLgmTE6tAbgM5GWNGbdtYI8yDLymrN3BUEaeZcLSJJID7B8MV0
         +UJxX3DNr92lLjxPxQW96AIAK3J4p9zyixcQospaI3M+YrpAtTlfTjXvgRAz1wY/FrgB
         xnnZ3pHX0L6OJwY7KrYYHliRePnl4frp9U6/jCJJWRije0aWWUJkiz6JIztPqfdbrKee
         MbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9h8ymZ5K0K7eX8Srq8j5CwjpJvxuAW5+GPYl72XMn9SglnUwNo3Cc4MlgxQWROjYIvsp9qrgobNqPq68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVc753T9jTZDse63rV5g5Bf12BfQRCLBkBwrO+tNPyeHGsSb9H
	MSreouTYJ9Z7BT1mEBkK+7p9xhfANYOBItmnPJ3KHK9pdBc5A+rrMKS6SNaEEiI=
X-Gm-Gg: ASbGnctsd//4tk/ZehbyyGfEJq5Y6nlYARwPEQ1Soud8SwYHtenl9h+zasDfkDdh80T
	/4TBRKcPCrjoPzQdI/qSLeOu02dzCGXkAKTYf1Iaml5LLznwNLx+SXAMbo4b8vpvi1usyDHiw0d
	o0gefUo2GRRQ/7Hl6mxebicWjrCaIZcqOiafQrl6WE+bzeFEL5Tkm0hai1VXmG2ZimlxIM/tCAq
	pHUublYnFcEyhAtZcKhS7oIb5h6oPf79TGGKQ5q0enNqQgdaJYrtd0Nh/VUmHgerg==
X-Google-Smtp-Source: AGHT+IGRkMVZLIS5wLAtxsUV4PQoSXKo0CJ9pQ9HEzWckDbZ7iIOhor9AyFDTVFHHSpjZUopOWXt8g==
X-Received: by 2002:a05:600c:1c07:b0:434:ff25:1988 with SMTP id 5b1f17b1804b1-4362aaa9632mr136849545e9.32.1734451657625;
        Tue, 17 Dec 2024 08:07:37 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:36 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/7 v2] sched/fair: Add push task callback for EAS
Date: Tue, 17 Dec 2024 17:07:18 +0100
Message-ID: <20241217160720.2397239-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217160720.2397239-1-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task will not have wakeup events anymore or at a
far too low pace. For such situation, we can take advantage of the task
being put back in the enqueued list to check if it should be migrated on
another CPU.

Wake up events remain the main way to migrate tasks but we now detect
situation where a task is stuck on a CPU by checking that its utilization
is larger than the max available compute capacity (max cpu capacity or
uclamp max setting)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 206 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   2 +
 2 files changed, 208 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd046e8216a9..2affc063da55 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7088,6 +7088,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
+static void dequeue_pushable_task(struct rq *rq, struct task_struct *p);
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -7118,6 +7119,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
+
+		if (task_sleep || task_on_rq_migrating(p))
+			dequeue_pushable_task(rq, p);
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -8617,6 +8621,182 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return target;
 }
 
+static inline bool task_misfit_cpu(struct task_struct *p, int cpu)
+{
+	unsigned long max_capa = get_actual_cpu_capacity(cpu);
+	unsigned long util = task_util_est(p);
+
+	max_capa = min(max_capa, uclamp_eff_value(p, UCLAMP_MAX));
+	util = max(util, task_runnable(p));
+
+	/*
+	 * Return true only if the task might not sleep/wakeup because of a low
+	 * compute capacity. Tasks, which wake up regularly, will be handled by
+	 * feec().
+	 */
+	return (util > max_capa);
+}
+
+static int active_load_balance_cpu_stop(void *data);
+
+static inline void migrate_misfit_task(struct task_struct *p, struct rq *rq)
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_energy_enabled() || is_rd_overutilized(rq->rd))
+		return;
+
+	if (WARN_ON(!p))
+		return;
+
+	if (WARN_ON(p != rq->curr))
+		return;
+
+	if (is_migration_disabled(p))
+		return;
+
+	if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))
+		return;
+
+	if (!task_misfit_cpu(p, cpu))
+		return;
+
+	new_cpu = find_energy_efficient_cpu(p, cpu);
+
+	if (new_cpu == cpu)
+		return;
+
+	/*
+	 * ->active_balance synchronizes accesses to
+	 * ->active_balance_work.  Once set, it's cleared
+	 * only after active load balance is finished.
+	 */
+	if (!rq->active_balance) {
+		rq->active_balance = 1;
+		rq->push_cpu = new_cpu;
+	} else
+		return;
+
+	raw_spin_rq_unlock(rq);
+	stop_one_cpu_nowait(cpu,
+		active_load_balance_cpu_stop, rq,
+		&rq->active_balance_work);
+	raw_spin_rq_lock(rq);
+}
+
+static inline int has_pushable_tasks(struct rq *rq)
+{
+	return !plist_head_empty(&rq->cfs.pushable_tasks);
+}
+
+static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->cfs.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+
+	/*
+	 * Remove task from the pushable list as we try only once after that
+	 * the task has been put back in enqueued list.
+	 */
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+
+	return p;
+}
+
+/*
+ * See if the non running fair tasks on this rq can be sent on other CPUs
+ * that fits better with their profile.
+ */
+static bool push_fair_task(struct rq *rq)
+{
+	struct task_struct *next_task;
+	int prev_cpu, new_cpu;
+	struct rq *new_rq;
+
+	next_task = pick_next_pushable_fair_task(rq);
+	if (!next_task)
+		return false;
+
+	if (is_migration_disabled(next_task))
+		return true;
+
+	/* We might release rq lock */
+	get_task_struct(next_task);
+
+	prev_cpu = rq->cpu;
+
+	new_cpu = find_energy_efficient_cpu(next_task, prev_cpu);
+
+	if (new_cpu == prev_cpu)
+		goto out;
+
+	new_rq = cpu_rq(new_cpu);
+
+	if (double_lock_balance(rq, new_rq)) {
+		/* The task has already migrated in between */
+		if (task_cpu(next_task) != rq->cpu) {
+			double_unlock_balance(rq, new_rq);
+			goto out;
+		}
+
+		deactivate_task(rq, next_task, 0);
+		set_task_cpu(next_task, new_cpu);
+		activate_task(new_rq, next_task, 0);
+
+		resched_curr(new_rq);
+
+		double_unlock_balance(rq, new_rq);
+	}
+
+out:
+	put_task_struct(next_task);
+
+	return true;
+}
+
+static void push_fair_tasks(struct rq *rq)
+{
+	/* push_fair_task() will return true if it moved a fair task */
+	while (push_fair_task(rq))
+		;
+}
+
+static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
+
+static inline void fair_queue_push_tasks(struct rq *rq)
+{
+	if (!sched_energy_enabled() || !has_pushable_tasks(rq))
+		return;
+
+	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), push_fair_tasks);
+}
+static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	if (sched_energy_enabled())
+		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+}
+
+static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	if (sched_energy_enabled() && task_on_rq_queued(p) && !p->se.sched_delayed) {
+		if (!is_rd_overutilized(rq->rd) && task_misfit_cpu(p, rq->cpu)) {
+			plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+			plist_node_init(&p->pushable_tasks, p->prio);
+			plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+		}
+	}
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
@@ -8786,6 +8966,10 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
+static inline void migrate_misfit_task(struct task_struct *p, struct rq *rq) {}
+static inline void fair_queue_push_tasks(struct rq *rq) {}
+static void dequeue_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
+static inline void enqueue_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
 static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
@@ -8968,6 +9152,12 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		put_prev_entity(cfs_rq, pse);
 		set_next_entity(cfs_rq, se);
 
+		/*
+		 * The previous task might be eligible for being pushed on
+		 * another cpu if it is still runnable.
+		 */
+		enqueue_pushable_task(rq, prev);
+
 		__set_next_task_fair(rq, p, true);
 	}
 
@@ -9040,6 +9230,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
 	}
+
+	/*
+	 * The previous task might be eligible for pushing it on
+	 * another cpu if it is still active.
+	 */
+	enqueue_pushable_task(rq, prev);
+
 }
 
 /*
@@ -13102,6 +13299,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	migrate_misfit_task(curr, rq);
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
 
@@ -13254,6 +13452,8 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 {
 	struct sched_entity *se = &p->se;
 
+	dequeue_pushable_task(rq, p);
+
 #ifdef CONFIG_SMP
 	if (task_on_rq_queued(p)) {
 		/*
@@ -13271,6 +13471,11 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
 
+	/*
+	 * Try to push prev task before checking misfit for next task as
+	 * the migration of prev can make next fitting the CPU
+	 */
+	fair_queue_push_tasks(rq);
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
 }
@@ -13301,6 +13506,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
+	plist_head_init(&cfs_rq->pushable_tasks);
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aef716c41edb..c9875cd4c986 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -717,6 +717,8 @@ struct cfs_rq {
 	struct list_head	leaf_cfs_rq_list;
 	struct task_group	*tg;	/* group that "owns" this runqueue */
 
+	struct plist_head	pushable_tasks;
+
 	/* Locally cached copy of our task_group's idle value */
 	int			idle;
 
-- 
2.43.0


