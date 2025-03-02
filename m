Return-Path: <linux-kernel+bounces-540624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1540BA4B2FD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C37A16F77D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA941EB5F4;
	Sun,  2 Mar 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tU67pHRr"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEF1EB1A9
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932019; cv=none; b=SGMeUAOaAX/V3RQc0AawwnalVKGwH/TiNSXkDzKbyQO6s5Y8hJkzt45h8FPdaTg2JxqcZGPQZ2AVGgTn2DaX5jmLFXFfU8jnQXPQqNHHr5PxFSE6u/Fpkju/bTfT29dz9uzov/fU2W6SfYn4PAex92DOrAw/mF4nYOuJAcpa7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932019; c=relaxed/simple;
	bh=M+AvDmAEBArgFT6+14lafuSfZPvZVBMk3Z1hP1vASLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di0oE+mvS30mRgBkKIU/QZygeOJL08fVXXqDvUA+iNQzhkU/33n0vwGoEsyq3KOAd9VmzpI/BuJd/g2Bq+KI6Q4Y2lOeZkU8vc72aMWY78qQYQlt6sPppmv6LdmN4Es+n1RGrDElEE6jiMs2JVcd7KbDpMQVj/D7L+9nvSlOXB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tU67pHRr; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43bbd711eedso2839205e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932015; x=1741536815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCa8lkfQvNrx2IlBh4QrAru9EVi5SrFl7QvJJUDndaY=;
        b=tU67pHRrhOfLcVFWR9w3uPe7JSEEKsa1Cn4m0LsC9pR9DJXrfVwE7RGrYPhZ98Fu7L
         /Qsy8HxbmyZbeIbRoWsn/hF02aig3iSCRebqft2Ud1McO+stzzaVBvuLdGqC14OLoono
         vPuVL4bRlZ3TzF62CHgy/NYwU4fYiN/WSDEmFwKNz9bgnEEBf0J/SAyeRrNVXCyKJ+7N
         zPlvbx3tLWzFJspbyFUs9IBKgk469OKA7Igk0XNJyRfC7cv46TRBxSE+enVmFWyPSPd9
         Hf98jijQN7DR+ifkFWrYD0kxqauRSljJeOpX7r97aVHuAPh/fT+xVz+KwH33fHYZLmJn
         yr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932015; x=1741536815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCa8lkfQvNrx2IlBh4QrAru9EVi5SrFl7QvJJUDndaY=;
        b=moqFZ7X8m7Ln41BTvKzQJfwGm+Bo7Ztlv2p3oRCRfaUEhfadxWoidRbe6JWGXkzAX+
         aRFa0zil5JxGZOSpCYcIyeZEClUfn23j9E5LoOlkrAwEowLk+6RVBjXscfgDm4wUsdtY
         sJdTKH3cscEp+C+J3VncgSjovgabvfY6zpM+HVVoRybWKKjQvOJXq6+IYgLKEqNMB9Bn
         20cXIpb/H3dnukBkZU1hnwQ5ojKaaR8o/++02UYsKav89Xog2HycdZjpttCt5U9k8Kmq
         hBC/aqH6gF9TVGm0FN6Y9Ycc+60CqIBBIOXFO6NcNKiJbrDQEkOea+7jR4qPj+Z/lhbz
         ZGgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAyg7BkDYS0NClZxmH6X+RXBUYksTzstiwyzMNu0je9RwlzzG9gLFjtIX75GogK1HjP3yAvCLiRP6PvkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcULotclmIeyTAa2GgeMkG5o3keRxQ6Qjz5Gmz2/L2EV0GuGC
	oilVRUKpHFhWodCNe+yLTEquD2dFl3Y0z7Dptw0QRjup8eBmtCRm//GBNq00VQE=
X-Gm-Gg: ASbGncuZEhmIB7obSdy5rEenBbjz5bMHU6HuWcUljgAfUEiLfaLV9WDa5K7EdF4myhc
	48/nlBwifPb+YJVs2cj6pNPYGV3x8VmEUpGtJ+4wcR7hhfkCJbA/HXQl237ObEUqQmURpB+gsYq
	+dDeQQttDqd55MG7S7ETjzA8Mh3HDj2F9uIeqKfUUlQQ0xll7Cfg1wvFC2pNzV0fEoM6S/F97VQ
	BpKK39t5keiZvUAxiYo4udA3wt5Aqj3BHhAmuC+/g0XDacxNRhjeFqIJTYv5F7Xhi9t30R9vxgL
	Mf3M4ds/gE+S6nPiXAKlTwWfNSoG4yTDDdt5Aiucf9KB84tgARq5
X-Google-Smtp-Source: AGHT+IFAMoaIGn4h2zoJeVcr3ysdQbYvJaB9hjr5OqcxdCsw2cvSbFNdlRHWa6DBFm27WmvHa7wL1Q==
X-Received: by 2002:a05:600c:1550:b0:439:6dba:adf2 with SMTP id 5b1f17b1804b1-43ba66e7550mr97201315e9.15.1740932015400;
        Sun, 02 Mar 2025 08:13:35 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:33 -0800 (PST)
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
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/7 v4] sched/fair: Add misfit case to push task mecanism for EAS
Date: Sun,  2 Mar 2025 17:13:20 +0100
Message-ID: <20250302161321.1476139-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302161321.1476139-1-vincent.guittot@linaro.org>
References: <20250302161321.1476139-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some task misfit cases can be handled directly by the push mecanism
instead of triggering an idle load balance to pull the task on a better
CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c3e383b86808..21bd62cf138c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8508,6 +8508,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
 			target_stat.capa = capacity_of(cpu);
 			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
+			if ((p->on_rq) && (!p->se.sched_delayed) && (cpu == prev_cpu))
+				target_stat.nr_running--;
 
 			/* If the target needs a lower OPP, then look up for
 			 * the corresponding OPP and its associated cost.
@@ -8613,6 +8615,9 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return false;
 
+	if (!task_fits_cpu(p, cpu_of(rq)))
+		return true;
+
 	if (is_rd_overutilized(rq->rd))
 		return false;
 
@@ -8624,33 +8629,33 @@ static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
 
 static int active_load_balance_cpu_stop(void *data);
 
-static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
+static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
 {
 	int new_cpu, cpu = cpu_of(rq);
 
 	if (!sched_energy_enabled())
-		return;
+		return false;
 
 	if (WARN_ON(!p))
-		return;
+		return false;
 
 	if (WARN_ON(!task_current(rq, p)))
-		return;
+		return false;
 
 	if (is_migration_disabled(p))
-		return;
+		return false;
 
 	/* If there are several task, wait for being put back */
 	if (rq->nr_running > 1)
-		return;
+		return false;
 
 	if (!sched_energy_push_task(p, rq))
-		return;
+		return false;
 
 	new_cpu = find_energy_efficient_cpu(p, cpu);
 
 	if (new_cpu == cpu)
-		return;
+		return false;
 
 	/*
 	 * ->active_balance synchronizes accesses to
@@ -8661,13 +8666,15 @@ static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
 		rq->active_balance = 1;
 		rq->push_cpu = new_cpu;
 	} else
-		return;
+		return false;
 
 	raw_spin_rq_unlock(rq);
 	stop_one_cpu_nowait(cpu,
 		active_load_balance_cpu_stop, rq,
 		&rq->active_balance_work);
 	raw_spin_rq_lock(rq);
+
+	return true;
 }
 
 static inline int has_pushable_tasks(struct rq *rq)
@@ -8952,7 +8959,11 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
-static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
+static inline bool check_pushable_task(struct task_struct *p, struct rq *rq)
+{
+	return false
+}
+
 static inline void fair_queue_pushable_tasks(struct rq *rq) {}
 static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
 static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
@@ -13362,9 +13373,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-	check_pushable_task(curr, rq);
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!check_pushable_task(curr, rq)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.43.0


