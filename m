Return-Path: <linux-kernel+bounces-290860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947509559A9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 22:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA9B2829CC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5666E15689A;
	Sat, 17 Aug 2024 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3Kmo1S2D"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAA815624B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927610; cv=none; b=pZKTFAjMHJkvXIbfKhq7UDUUJRzEawBb3qNaBDmb5RJLnQGmtJLHtcU0q2U7YTVYmaxO7eKFGdAjeMks1Rkq3bvuYDKpipbHlhGzAJsjwhIxEQXUQ5F/Dw27+cXy/FpXuld+Y7aq5dppXSR7D3E4gffw3r4T2lEK11RbUGcvNxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927610; c=relaxed/simple;
	bh=K0xjumLwWN6l2imOx3JvlkgsS/HBAmMUKFbMV39pZxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYT2LZcYwftRsb6UlcaiIhodvM6cJAhajNXU44ukKecBR8/HtlYu3sZEBNR2ZYWr+Qd/5lrtCk5Qtokxcnngrf3B7c4qXSMtRfTfbmHxiAYbuQfM1ALRlGi47xDsdlkWv77ADqJgFYpU21FgKXJzNHefAiuFiaQ3ohnwrzOp0OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3Kmo1S2D; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d0fc15efbso25730b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723927605; x=1724532405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkqFfu8TNNTkeL8UJk+hasytcQg+Y2ER8tyNsGPxyto=;
        b=3Kmo1S2DRq7A33txQCq24nF/12JFZzMNAKKnz7nARySFYv0vSUzXMCgBs6Sq3WV31A
         +bUwtgQ7JN2OdFZA4ZupNWPucZiXV9P5SjUMrWg3YnNJcKAdMj/E2C+6eaKoeg5yqdv+
         f1pGRHWHbmwy4s6cEGNzq+Z3zyofBqOapYr4CAPbB4FhdmFDWlKPuQhbgePnwdLIdAHP
         BiKrZ0kM66viWe+w3r37g9bjrecHIjSp3orNYM2lV03+X+xLR4pAzGCgjbEv9aZKVetq
         MLecrZX4fuI01HXZACT4YG41pVfjfep/GJjv5Mp9pxIs4OeiV4h+Y8gNS5HuuMlBh5b6
         C2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927605; x=1724532405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkqFfu8TNNTkeL8UJk+hasytcQg+Y2ER8tyNsGPxyto=;
        b=aUq0NzYtFTnLaonGxdlg3PBkY2h7IpVu6wfmHeXZ1lUC71nqBdYkyxTzdrKRH/ODR7
         E6D8sX4iCtZEM9+uEji297gNrsAkd9pTpBexQO9w1o5LoXnv0N3M31o8gnQNR6HegFO7
         j20CaARW0MUGjGaDQd9u/fHWTLR9IGWYO3G8xYZGTQveP1yrwag+KoqN6g1S7eMU6VjE
         0wFjeBoKasqgoq/9SQZi0xomc3O9g34jrEPUK8/qpCZKYs8wQ7A9v5gkmTViv9Ib962B
         k/KzwQK9wQZgRA2xTAZl8Hxqsq90JOJTxO1mQyzVHOy60lsjHtxnfrNUNRvPFbBXT/eT
         CPAw==
X-Gm-Message-State: AOJu0YxQjPgVo9YsWxqgGVvg0N/CGCemtnYQ4Ytr+X/mOeh9sBcCrSMp
	xX7XFT1W4Hbav4GbHaqrH+Qvla264AsndLis64iWTVgG4Om6i9P6nQVAQJtBJY226QXJnsIsgzH
	h
X-Google-Smtp-Source: AGHT+IEVx9zvTwiMTf8LUWcZri6euCeuaxNcG9dp1Cw7iLh1ROYQfLofEx+PG0jtzlyq5XsXpmP8GQ==
X-Received: by 2002:a05:6a00:9446:b0:710:5d44:5fe6 with SMTP id d2e1a72fcca58-713c557a36amr4960595b3a.1.1723927605087;
        Sat, 17 Aug 2024 13:46:45 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm4411039b3a.65.2024.08.17.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 13:46:44 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] sched/core: add helpers for iowait handling
Date: Sat, 17 Aug 2024 14:45:10 -0600
Message-ID: <20240817204639.132794-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817204639.132794-1-axboe@kernel.dk>
References: <20240817204639.132794-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds helpers to inc/dec the runqueue iowait count, based on the task, and
use those in the spots where the count is manipulated.

Adds an rq_iowait() helper, to abstract out how the per-rq stats are read.

No functional changes in this patch, just in preparation for switching
the type of 'nr_iowait'.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/sched/core.c    | 23 +++++++++++++++++++----
 kernel/sched/cputime.c |  3 +--
 kernel/sched/sched.h   |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ab50100363ca..9bf1b67818d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3541,6 +3541,21 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 
 #endif /* !CONFIG_SMP */
 
+static void task_iowait_inc(struct task_struct *p)
+{
+	atomic_inc(&task_rq(p)->nr_iowait);
+}
+
+static void task_iowait_dec(struct task_struct *p)
+{
+	atomic_dec(&task_rq(p)->nr_iowait);
+}
+
+int rq_iowait(struct rq *rq)
+{
+	return atomic_read(&rq->nr_iowait);
+}
+
 static void
 ttwu_stat(struct task_struct *p, int cpu, int wake_flags)
 {
@@ -3607,7 +3622,7 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 #endif
 	if (p->in_iowait) {
 		delayacct_blkio_end(p);
-		atomic_dec(&task_rq(p)->nr_iowait);
+		task_iowait_dec(p);
 	}
 
 	activate_task(rq, p, en_flags);
@@ -4184,7 +4199,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		if (task_cpu(p) != cpu) {
 			if (p->in_iowait) {
 				delayacct_blkio_end(p);
-				atomic_dec(&task_rq(p)->nr_iowait);
+				task_iowait_dec(p);
 			}
 
 			wake_flags |= WF_MIGRATED;
@@ -5282,7 +5297,7 @@ unsigned long long nr_context_switches(void)
 
 unsigned int nr_iowait_cpu(int cpu)
 {
-	return atomic_read(&cpu_rq(cpu)->nr_iowait);
+	return rq_iowait(cpu_rq(cpu));
 }
 
 /*
@@ -6512,7 +6527,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
+				task_iowait_inc(prev);
 				delayacct_blkio_start();
 			}
 		}
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0bed0fa1acd9..b826267714de 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -222,9 +222,8 @@ void account_steal_time(u64 cputime)
 void account_idle_time(u64 cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (rq_iowait(this_rq()) > 0)
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e1d1b467af2..b6b3b565bcb1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3579,6 +3579,8 @@ static inline void init_sched_mm_cid(struct task_struct *t) { }
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
+int rq_iowait(struct rq *rq);
+
 #ifdef CONFIG_RT_MUTEXES
 
 static inline int __rt_effective_prio(struct task_struct *pi_task, int prio)
-- 
2.43.0


