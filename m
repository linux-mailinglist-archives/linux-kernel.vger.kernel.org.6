Return-Path: <linux-kernel+bounces-190535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3440D8CFF99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC5C1F20F21
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9DF15E5DC;
	Mon, 27 May 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cmke/4R/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C015E5A1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811668; cv=none; b=Uy76pPUg/6ZNXyU4HzXXBUdDRX6IeB94dqiHKrpQIfSwZOot4XmG1YCyhULvahhD8hMrUJFgqjBSdFs6jfkY0BlGWrfCbbcsyT6MxNjK7VPxPNX5Nwcz/xx/incRY+9lcujBEhi2ZHG90RaMvkJVKbx8Di9E80qTnyAJcWxU0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811668; c=relaxed/simple;
	bh=TxEOnzOIGujg32HlOqWh78fNUd3cZ9WBcF3eGv0gPuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etQIEkDvSPPIEBfUWcJp8iF8gl6Y1cNfdmM3u3EgvmB0SvmXdIzSQOkshz3qlhruIJCk32Dndahhsw0RGSJL0B0Z3mkSOgAYxjnUSzaNVMmiHJ2Jp9T5I5oFwIes/VH4rZNicwQeIVEynw5ILzZei2cTZ5mNu5iH32rwUewl+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cmke/4R/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7341C32781;
	Mon, 27 May 2024 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811667;
	bh=TxEOnzOIGujg32HlOqWh78fNUd3cZ9WBcF3eGv0gPuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cmke/4R/wN8jjP+oMQSZTK1Q78xdhT484z6rsM/9wIYAqu//fb2XsPp+n+Et5sJ1x
	 aMb+kX0Nlx6Wd6FPMZy6hD7NVjg93ToeFZa3kPhRCVwMRclpAUd365J6h3pX7ESwIt
	 oIDSTt2ektVR4elbkDHd+tWvJwf0U8zHihP7AJOS4PK1YbRtgpuGXtRTopthf9G3zb
	 SgMBbOY2PTrc+jP16Ga5v93UXL231vGkwlFteLqx/DhwiWvbw+XBAZDCMZkU7piVqp
	 j1ezi2z8aU8836HYIY/4XftiJAhQeuykem4wkE3E374ixLBvUGcf9vKlSezZm/Syjm
	 MnpeJ1dFkht6Q==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V7 8/9] sched/core: Fix picking of tasks for core scheduling with DL server
Date: Mon, 27 May 2024 14:06:54 +0200
Message-ID: <b10489ab1f03d23e08e6097acea47442e7d6466f.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

* Use simple CFS pick_task for DL pick_task

  DL server's pick_task calls CFS's pick_next_task_fair(), this is wrong
  because core scheduling's pick_task only calls CFS's pick_task() for
  evaluation / checking of the CFS task (comparing across CPUs), not for
  actually affirmatively picking the next task. This causes RB tree
  corruption issues in CFS that were found by syzbot.

* Make pick_task_fair clear DL server

  A DL task pick might set ->dl_server, but it is possible the task will
  never run (say the other HT has a stop task). If the CFS task is picked
  in the future directly (say without DL server), ->dl_server will be
  set. So clear it in pick_task_fair().

This fixes the KASAN issue reported by syzbot in set_next_entity().

(DL refactoring suggestions by Vineeth Pillai).

Reviewed-by: Vineeth Pillai <vineeth@bitbyteword.org>
Reported-by: Suleiman Souhlal <suleiman@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |  3 ++-
 kernel/sched/deadline.c | 27 ++++++++++++++++++++++-----
 kernel/sched/fair.c     | 23 +++++++++++++++++++++--
 kernel/sched/sched.h    |  3 ++-
 4 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 611771fec4df..eb8f8b7929c8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -684,7 +684,8 @@ struct sched_dl_entity {
 	 */
 	struct rq			*rq;
 	dl_server_has_tasks_f		server_has_tasks;
-	dl_server_pick_f		server_pick;
+	dl_server_pick_f		server_pick_next;
+	dl_server_pick_f		server_pick_task;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index f8afe0a69c1e..0dbb42cf7fe6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1664,11 +1664,13 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick)
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task)
 {
 	dl_se->rq = rq;
 	dl_se->server_has_tasks = has_tasks;
-	dl_se->server_pick = pick;
+	dl_se->server_pick_next = pick_next;
+	dl_se->server_pick_task = pick_task;
 }
 
 void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
@@ -2394,7 +2396,12 @@ static struct sched_dl_entity *pick_next_dl_entity(struct dl_rq *dl_rq)
 	return __node_2_dle(left);
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+/*
+ * __pick_next_task_dl - Helper to pick the next -deadline task to run.
+ * @rq: The runqueue to pick the next task from.
+ * @peek: If true, just peek at the next task. Only relevant for dlserver.
+ */
+static struct task_struct *__pick_next_task_dl(struct rq *rq, bool peek)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2408,7 +2415,10 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick(dl_se);
+		if (IS_ENABLED(CONFIG_SMP) && peek)
+			p = dl_se->server_pick_task(dl_se);
+		else
+			p = dl_se->server_pick_next(dl_se);
 		if (!p) {
 			WARN_ON_ONCE(1);
 			dl_se->dl_yielded = 1;
@@ -2423,11 +2433,18 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	return p;
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_dl(struct rq *rq)
+{
+	return __pick_next_task_dl(rq, true);
+}
+#endif
+
 static struct task_struct *pick_next_task_dl(struct rq *rq)
 {
 	struct task_struct *p;
 
-	p = pick_task_dl(rq);
+	p = __pick_next_task_dl(rq, false);
 	if (!p)
 		return p;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20e8b02c5cb3..14ec002bb4f9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8484,6 +8484,14 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 
+	/*
+	 * This can be called from directly from CFS's ->pick_task() or indirectly
+	 * from DL's ->pick_task when fair server is enabled. In the indirect case,
+	 * DL will set ->dl_server just after this function is called, so its Ok to
+	 * clear. In the direct case, we are picking directly so we must clear it.
+	 */
+	task_of(se)->dl_server = NULL;
+
 	return task_of(se);
 }
 #endif
@@ -8643,7 +8651,16 @@ static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
 	return !!dl_se->rq->cfs.nr_running;
 }
 
-static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
+{
+#ifdef CONFIG_SMP
+	return pick_task_fair(dl_se->rq);
+#else
+	return NULL;
+#endif
+}
+
+static struct task_struct *fair_server_pick_next(struct sched_dl_entity *dl_se)
 {
 	return pick_next_task_fair(dl_se->rq, NULL, NULL);
 }
@@ -8654,7 +8671,9 @@ void fair_server_init(struct rq *rq)
 
 	init_dl_entity(dl_se);
 
-	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick_next,
+		       fair_server_pick_task);
+
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ed7be7b085af..3b8684b5ec8e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -354,7 +354,8 @@ extern void dl_server_start(struct sched_dl_entity *dl_se);
 extern void dl_server_stop(struct sched_dl_entity *dl_se);
 extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
-		    dl_server_pick_f pick);
+		    dl_server_pick_f pick_next,
+		    dl_server_pick_f pick_task);
 
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
-- 
2.45.1


