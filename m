Return-Path: <linux-kernel+bounces-540787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACCCA4B4DD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F391516CC11
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9EF1EFF82;
	Sun,  2 Mar 2025 21:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7yGBPub"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF381EE002
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949557; cv=none; b=UuQeeTiKPBsehqLSIV4qUFine/aMxh5Mxsk9LO+9Et0a9mrmQ6jobpHqe6/eqNZhOKa/L+boygcIbH51oJeP/RGm4AR1+Q98YAKtfWTs5tICUeSiw42HRC3B65PG74+GI5MGQEr/dmB2365Fo7f32rkHDctTzmXEzwCoHe1jv9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949557; c=relaxed/simple;
	bh=mYD+5wpDOEjCHe7SLqpycP+Ms/nkEueyBuD5lomGr8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+suRDKsmRMcVAFcrEPYW0vEDkBStZNsdcnGMhoR/4IFhrXAJXLX9QGXlCFC33uRRBgZ3aM+eTcupbWfgURuX7d9zDq1hr9IrwgWA1teN1Af/nlH16owq1yi4jVCOxJ6E0LdqUp/LC3RQCCLnn2lkkGqzdDR8u90ulfOQZYvni8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7yGBPub; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4399a1eada3so34871575e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740949553; x=1741554353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwUN4HVHeJlZ7MbhuW0mt9rOr3uOjQJOwaCCI8I09rc=;
        b=J7yGBPub8uxWyUB5cepAo5FD3BDwYFnVG28VZpblCIQokzyXlhzVDqfxr1wlKzTgqG
         doRMzY/XLBGse0nwTzK7nNuKeBMyr6uH37YIIDKE1lojCADMRT5tvEvc7YHHM5xjcgH5
         qcRZPaA9Y8Cjj6gccKIx8VAv4l0BX0F+im64qZaD6gpdSjLobsimN15WvXeTbKPyZZ26
         QFukuwjV89UydoVtfU69K0Vl088nVp5zogEmdLNrFiHuaQAoNShMAKlZu4T0507Nxc86
         mrqjDXj1Tiq+9pd0p0jEs6eORpZeBWFl27Z50qrjNPERKQ6aQbewmrLOhvodNRK6oq04
         BSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949553; x=1741554353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwUN4HVHeJlZ7MbhuW0mt9rOr3uOjQJOwaCCI8I09rc=;
        b=RZrEzVlPXjca9Kj/qu5f5/QSFYuAGcWSc2gj97xk5sl1Ex1gmL8uWUZsx4xkn5gfPk
         9nyudgDYc+rhlDagVRZJgC09cU2J11yPZ/SvCnRTKdyKaEZLEASPeg0PHp+orVlXQ0dH
         viUw8rlb8ga9FT2rLnGuD+SODT5h18pW0UAD0RNm/FPmywKxeU+seMSosujc+Wds38C+
         Fo3bs3RwKqV3SDWLczznYBqNKwYo7szy8yGEFWqE8j/llcVEqsFma8prgatlRakygBUk
         WchtKxwr30k7JzgXo9POEX9I0xaMVGjZMJHUNt0QoKULLju/p+TvxiIPnUD9EQvGRQB4
         3oCA==
X-Forwarded-Encrypted: i=1; AJvYcCUN9G31/yJIC4XPwSelMfLpYBGWXHw0BM0kpANrO1zASAJMVG5Ml+2FwhsrCsnaJvuDsOWCL8uzGaxSw/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza6gnr96vAB3YN3Wq/JHIweRoFNVEGFv8+wK07+St6ntUlpigb
	FPpGUhILNcm8/f8tfV1NkfTJES76sd+1Oy+JFp0gg8PZO+OEaHvq+0mrC9QwPo8=
X-Gm-Gg: ASbGncsG2Aj5Ar6ejmtxEq8otT0Yl9qRTlA72EyqaujtAkZ7cb2lsd+pCnX6ufNw/wZ
	F2GhlozaHCT5ZpfR4x3jElWnwhVexfUmR9jS6zLWdw/PoYfvEJiLYav2O10uBSmBg0tsDGhErvv
	lS2em/waG6LhBgIIKvjIcd99j8gW2PnwkrzOS/z7U4uUcO4Ym6H+/8bcP5CzLi8+7XZKwZd6Xm7
	TxF7d0pMJfdnjkLlyoY6BJ+NgmvjHy5Alisczu6s/XNiE2OTxotFu7MoIcl9rfBE6BBtDwRwhpZ
	4b9Df32av9XhIiEdQTE42XnGwpVhTHPARCKavPk5VuDeyVkml3p8
X-Google-Smtp-Source: AGHT+IGsre+4yt+K927E11a+Tl0KuAxhKq6njMFM6kDrAbaFIfBYMLy6cHnN7923nY9vPJ98QeC6uw==
X-Received: by 2002:a05:6000:400d:b0:390:f898:92be with SMTP id ffacd0b85a97d-390f8989367mr6051642f8f.8.1740949553071;
        Sun, 02 Mar 2025 13:05:53 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e045sm12480923f8f.99.2025.03.02.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 13:05:51 -0800 (PST)
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
Subject: [PATCH 6/7 v5] sched/fair: Add misfit case to push task mecanism for EAS
Date: Sun,  2 Mar 2025 22:05:38 +0100
Message-ID: <20250302210539.1563190-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302210539.1563190-1-vincent.guittot@linaro.org>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
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
index c3e383b86808..d21fe0a26633 100644
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
+	return false;
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


