Return-Path: <linux-kernel+bounces-292409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D167F956F16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 258C4B2793E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B4012EBE1;
	Mon, 19 Aug 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3L3KlOZO"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B2D4964D
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082189; cv=none; b=bvMFw7nlkQ91RPYaR/gVB/3A5Au1+955D58/qUuIuvpAZM1sAtKO/hO3PGCLQ6Q+jx3U5Oo1prcuC5rmSfxROGo9ppn/1z1Li0zMiO12dAXYaNdHg5jZ9qUO4CxzH/k+iNybkGmM4FlVpT9I4JF276rA89BU/AZX93DcGUpR4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082189; c=relaxed/simple;
	bh=K0xjumLwWN6l2imOx3JvlkgsS/HBAmMUKFbMV39pZxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLwBDS7qFT+wwJpFzts/yId+Kru6uiyoDKOGjUJVCMizLgRgVkM7P6VD0eX2Ktwx+w8Ijn8EJyMcaCaGVcLLW1MtKJPDzhgGf/DWYdXH6oum8nfIAON97SJO9Vy9gzvcsEs7+3iIrdr2XYs5r13YtEWLlI/K4ZiwreydXZLO13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3L3KlOZO; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d3f39e7155so561675a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724082185; x=1724686985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkqFfu8TNNTkeL8UJk+hasytcQg+Y2ER8tyNsGPxyto=;
        b=3L3KlOZOljEBFK7cqNPgZX8S8TsfH13v0zRaivILOV98UEqq4NvPac3J57FyYUhrzi
         JzVtb5oZksFiAS9cPqbn78SPX+qDXHXLENECHbYKRp9w24nPbByT/hfgAIwNclJAVAzp
         Mjo95BCbKrk0Liz2EQH0+0ezQVmR8ucPtOaLjNg4dU3LJARayeV35braKuNceHJYGL9b
         ypEKHdPD9mX8Wk5t0g8zpBgnLVfHMhFbWBNZJ30iRni5LrNRF9o2KJ7I3Cin/sxmys8x
         JEHBYQP2FoVXYl5T6scRVXUnLDoYLXNmAp4a2rt1PTBkxVLNdE+D6ue6kuZKZ8EFMfxL
         O/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082185; x=1724686985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkqFfu8TNNTkeL8UJk+hasytcQg+Y2ER8tyNsGPxyto=;
        b=g9NzgRAUCRaSMSTmwouSj1tHB+XT8QFqxYb3jWYCDV8HBMYf5WNZpuAXZNyBsCaS4K
         kcs58G6DJzSjXbsFVPnjT5UuOI+aPRZGRsjzkDgdP7xWPQKSimgnve9spYtJDKclNnrx
         AszXmnehL2WQXNEcFKAWffaucBtDlY7FpAvQ8FgDZOm33vBS5J3ouoKMy4BX6+QD01Sq
         TwiiPLfdpE7sjjF/wPD+xE+B3eQhIMihPJwRFjkNABvmPQv6xbGnYC44Ow6t4Roea1Cw
         NPg/nLjzaIIzpdLLLPGzPZiUrULYAKpZlaRQQ+UxEmxwQuura7cngtpA8/ZHXPyyEcYl
         uvZA==
X-Gm-Message-State: AOJu0YwN1g0DBzmG9deCtGG95thkqkPHjpcX8Ok8hmNp4dXVgVyc/nOG
	NinGLpMSkXFPJ2BZPP7OEdPLdFSAdxoHaHBfTB3yJHYK1CvYE0E5jfRrVfc9cTwsRg8qmOPc1z0
	s
X-Google-Smtp-Source: AGHT+IHehYd4v6KtW8X7VGSGbhwu5p208ySNI/IH/HH5ydnbOd4lF7D/RhXDCtJt2VCxomuthnjLYw==
X-Received: by 2002:a17:90b:146:b0:2c8:4623:66cd with SMTP id 98e67ed59e1d1-2d3e1a42e70mr7456254a91.1.1724082184746;
        Mon, 19 Aug 2024 08:43:04 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c751f1sm7356041a91.38.2024.08.19.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:43:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/4] sched/core: add helpers for iowait handling
Date: Mon, 19 Aug 2024 09:39:46 -0600
Message-ID: <20240819154259.215504-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819154259.215504-1-axboe@kernel.dk>
References: <20240819154259.215504-1-axboe@kernel.dk>
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


