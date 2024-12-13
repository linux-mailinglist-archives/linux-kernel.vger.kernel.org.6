Return-Path: <linux-kernel+bounces-444655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9399F0A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4163118869F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C11C3C0D;
	Fri, 13 Dec 2024 11:04:11 +0000 (UTC)
Received: from smtp134-25.sina.com.cn (smtp134-25.sina.com.cn [180.149.134.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E01C07FC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087850; cv=none; b=VsDFQDK8R3b4eeWvDYn/nHfBPdUXCvn8lwKqqq0SLyCWxuXBVz71kw7/LVkozV2IvKlcQANz68/8M9sWg6LeWxqbINFO8ijn03rzL9n0gfZAlolLuo7xI0EZ7CuVWdKvTpr4qP8zpTB1APXqGueCO7/0hSL70IuviDBHBiNImZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087850; c=relaxed/simple;
	bh=hc4CGaYrwIZL16AakL7s1Q9XiOloC0c6v9NZQOYF/+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJ5wyChPFbiLn8SjqLIJ7NCgMP9rp+WXVHPzdMkcvLwAkHj7Nb5IukyfI6BgNGzqebk4n/sKJGvQfl/Qb01PhzUeYSpnycQBH+yAedt+Yqas5D6JB9H64UT70LSgp0FIC7837EVYPhcT8wtrc6XSLLovTFtr1ttrOWMEmRSxHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.125])
	by sina.com (10.185.250.21) with ESMTP
	id 675C146E00000674; Fri, 13 Dec 2024 19:03:14 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4016673408336
X-SMAIL-UIID: 40F2E86CDD094C889E6AC88E44822EC6-20241213-190314-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+00a022dc9979d67df050@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] WARNING in enqueue_dl_entity
Date: Fri, 13 Dec 2024 19:03:05 +0800
Message-Id: <20241213110305.1839-1-hdanton@sina.com>
In-Reply-To: <67410a37.050a0220.363a1b.0150.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Nov 2024 14:48:23 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    28eb75e178d3 Merge tag 'drm-next-2024-11-21' of https://gi..
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1016fec0580000

Test fix (https://lore.kernel.org/lkml/20241213032244.877029-1-vineeth@bitbyteword.org/ )

#syz test upstream master

diff -pur x/include/linux/sched.h y/include/linux/sched.h
--- x/include/linux/sched.h	2024-12-13 18:53:21.592682100 +0800
+++ y/include/linux/sched.h	2024-12-13 18:55:17.754180400 +0800
@@ -656,6 +656,12 @@ struct sched_dl_entity {
 	 * @dl_defer_armed tells if the deferrable server is waiting
 	 * for the replenishment timer to activate it.
 	 *
+	 * @dl_server_active tells if the dlserver is active(started).
+	 * dlserver is started on first cfs enqueue on an idle runqueue
+	 * and is stopped when a dequeue results in 0 cfs tasks on the
+	 * runqueue. In other words, dlserver is active only when cpu's
+	 * runqueue has atleast one cfs task.
+	 *
 	 * @dl_defer_running tells if the deferrable server is actually
 	 * running, skipping the defer phase.
 	 */
@@ -664,6 +670,7 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_server_active  : 1;
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
diff -pur x/kernel/sched/deadline.c y/kernel/sched/deadline.c
--- x/kernel/sched/deadline.c	2024-12-13 18:51:17.093081100 +0800
+++ y/kernel/sched/deadline.c	2024-12-13 18:55:17.770211500 +0800
@@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_ent
 	if (!dl_se->dl_runtime)
 		return;
 
+	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 		resched_curr(dl_se->rq);
@@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_enti
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_server_active = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -2421,8 +2423,10 @@ again:
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			dl_se->dl_yielded = 1;
-			update_curr_dl_se(rq, dl_se, 0);
+			if (dl_server_active(dl_se)) {
+				dl_se->dl_yielded = 1;
+				update_curr_dl_se(rq, dl_se, 0);
+			}
 			goto again;
 		}
 		rq->dl_server = dl_se;
diff -pur x/kernel/sched/fair.c y/kernel/sched/fair.c
--- x/kernel/sched/fair.c	2024-12-13 18:50:13.649803300 +0800
+++ y/kernel/sched/fair.c	2024-12-13 18:56:11.779225700 +0800
@@ -1159,8 +1159,6 @@ static inline void update_curr_task(stru
 	trace_sched_stat_runtime(p, delta_exec);
 	account_group_exec_runtime(p, delta_exec);
 	cgroup_account_cputime(p, delta_exec);
-	if (p->dl_server)
-		dl_server_update(p->dl_server, delta_exec);
 }
 
 static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
@@ -1237,11 +1235,16 @@ static void update_curr(struct cfs_rq *c
 		update_curr_task(p, delta_exec);
 
 		/*
-		 * Any fair task that runs outside of fair_server should
-		 * account against fair_server such that it can account for
-		 * this time and possibly avoid running this period.
+		 * If the fair_server is active, we need to account for the
+		 * fair_server time whether or not the task is running on
+		 * behalf of fair_server or not:
+		 *  - If the task is running on behalf of fair_server, we need
+		 *    to limit its time based on the assigned runtime.
+		 *  - Fair task that runs outside of fair_server should account
+		 *    against fair_server such that it can account for this time
+		 *    and possibly avoid running this period.
 		 */
-		if (p->dl_server != &rq->fair_server)
+		if (dl_server_active(&rq->fair_server))
 			dl_server_update(&rq->fair_server, delta_exec);
 	}
 
diff -pur x/kernel/sched/sched.h y/kernel/sched/sched.h
--- x/kernel/sched/sched.h	2024-12-13 18:50:42.985005300 +0800
+++ y/kernel/sched/sched.h	2024-12-13 18:55:17.801793100 +0800
@@ -398,6 +398,11 @@ extern void __dl_server_attach_root(stru
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
 
+static inline bool dl_server_active(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server_active;
+}
+
 #ifdef CONFIG_CGROUP_SCHED
 
 extern struct list_head task_groups;
--

