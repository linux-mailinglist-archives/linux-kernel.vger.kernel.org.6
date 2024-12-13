Return-Path: <linux-kernel+bounces-444223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5259F030A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAB284486
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9591459EA;
	Fri, 13 Dec 2024 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="peElN5SB"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6F39AEB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060170; cv=none; b=bCgeL0N1vqXD4vUCzsBVMGxbzPjydGtY5FE7+MZGyK2y14+WSMjCts9RvIo7Mswx5Nk03JwvVjG1aqkQsEWLfXgsybZbohmSt4ubW8+NH8MGyodOGDNO0x4+uyrD1FkV+yTZzOMxOAtQlP5mjbXThJQciedoGFWFAL6r43m7qVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060170; c=relaxed/simple;
	bh=mBgqn2ObmBthm2BmC4PR5aOY4YbzFLpJ5xqXeNlnq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iNqrGvnyrOTH3u7/2hgOfbuCPUzxhNmrEIAhDcH3stGRIoBl7RXzDL1g/Gx5LaNQdgNVDuQp2NzqiZKNEi6dfaUrru5/QaydvmXaEWFCfu8S4BpUTILp72GW7XEC6DpWT0EycDq7qSVz+SPiv1MvrSRNYrWwKB3M6/3GkYjRb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=peElN5SB; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d888c38841so10892926d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1734060167; x=1734664967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUakkspjM852kYB415+rOLMVA918IhDFlEhqsIe/2zo=;
        b=peElN5SBi4fU5CNmcRAcYgNu0JxHd7pT6h71EC53uZjotjtL6Swn35u+Ij1JJye+no
         p77OQSCDlrTV1qE6envBq8UjAxBQTFze4tXHicF/5xFijWICalI/AQ+eHDR1u2abOZ5O
         QvOxM6iV3parqLUXl/KsgeCv1s3mi3UfMJf9QKMxy7EDT5A6FseJGoqLxuzn6L/YP2mw
         vntCoTUiR/ZZuy8GASZ8opPezreNqr4P+Ve1QPdv/4HX1PJd38V/NGIayl67yh4bOOjd
         f/oQMr1GDUDTXX69uP/bCAb2p3nNl63PnSZEI0+8BfyTIZelKnJr1EclQ0n7qvgZNOrJ
         ApZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060167; x=1734664967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUakkspjM852kYB415+rOLMVA918IhDFlEhqsIe/2zo=;
        b=sjAlSP8HrRNyJJmA+Iqnvsg5o8DEjUthulcrtztI4vUMFffJQhG+sYyYCKuEDFDBNG
         IxVVUl7VWVu0fP+CWkT7WAz5qLMa16XRhOnz9AMbBHVNZjharO7Oh90Vbet2hK4xt+Vt
         KP1rfDZLhpeAZg4494h0adno+AnT1YO3ZgWKW71JIo/cCp9vzi4qMiNh9WglYfarMHdl
         tak2ybKMOdBomUexEQYsybzRm+TRq/HNNuU2tGTKZNs/yqKZNTFUEWumbG2DzmX3MxIG
         7cJGDW7cliWCcflLqOn2mzEOSCDopg4tGJ47wDaT4dqVTpPCCART1BdOVrlNahlC920N
         0lgg==
X-Forwarded-Encrypted: i=1; AJvYcCVqOVLH5G9iABszeB/2bHFerL/daSkybXpwx+CaJEqVS8sjv2oL6889Wz+ak9JbI5SD67++i7RJneNzh+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLpexvKwLfIN7Qyv8TSZtWBXwvtVViJiAhHGugy4wV2tteY0zC
	eJgwmlIua++bBt4oFbOST0cRV1cPYU9R1iVzRPRaeM5Wt/+5nPOXeTDQKHQidyI=
X-Gm-Gg: ASbGncsKC3XwyFj5yxJDHKvStke307nZLm1qWJFQIQVR3kugslut86HhOczLIkcyUUN
	ePAAf74P0jKaHacUJJ+83DDy7ni4h7IAjFg+lOafybbxsICnEQFJS0vzc7EUMXzXkTB6hljn9DY
	z95ioLMR0i5dZUwyrEPG3E6Hq2xyqCKUfQLWRRYjVpvQa9mVLGYAqv4pRGcKViSBHSI++HjNyer
	CS3d+1+KOjSV6WYsQdt1qnBz/TsxUwkoxc5NjbNWJ+PNKt4ngZQ7I0AEwSJ+RvXcIlzBcq14wrp
	na40DH6cwj7ADFlOiUZtFfeJTRs=
X-Google-Smtp-Source: AGHT+IGXBXCfLtT79d9kk/zLtfiwaLVJ+fFMkVeEiPxHKwySOTmFIh9MbwQeR2MkLxYeUh96h2EurQ==
X-Received: by 2002:a05:6214:19e7:b0:6d8:6a74:ae68 with SMTP id 6a1803df08f44-6dc8ca94760mr12140016d6.29.1734060167479;
        Thu, 12 Dec 2024 19:22:47 -0800 (PST)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696d87sm88111736d6.40.2024.12.12.19.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:22:47 -0800 (PST)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	shraash@google.com,
	marcel.ziswiler@codethink.co.uk,
	i.maximets@ovn.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] sched/dlserver: flag to represent active status of dlserver
Date: Thu, 12 Dec 2024 22:22:36 -0500
Message-ID: <20241213032244.877029-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dlserver can get dequeued during a dlserver pick_task due to the delayed
deueue feature and this can lead to issues with dlserver logic as it
still thinks that dlserver is on the runqueue. The dlserver throttling
and replenish logic gets confused and can lead to double enqueue of
dlserver.

Double enqueue of dlserver could happend due to couple of reasons:

Case 1
------

Delayed dequeue feature[1] can cause dlserver being stopped during a
pick initiated by dlserver:
  __pick_next_task
   pick_task_dl -> server_pick_task
    pick_task_fair
     pick_next_entity (if (sched_delayed))
      dequeue_entities
       dl_server_stop

server_pick_task goes ahead with update_curr_dl_se without knowing that
dlserver is dequeued and this confuses the logic and may lead to
unintended enqueue while the server is stopped.

Case 2
------
A race condition between a task dequeue on one cpu and same task's enqueue
on this cpu by a remote cpu while the lock is released causing dlserver
double enqueue.

One cpu would be in the schedule() and releasing RQ-lock:

current->state = TASK_INTERRUPTIBLE();
        schedule();
          deactivate_task()
            dl_stop_server();
          pick_next_task()
            pick_next_task_fair()
              sched_balance_newidle()
                rq_unlock(this_rq)

at which point another CPU can take our RQ-lock and do:

        try_to_wake_up()
          ttwu_queue()
            rq_lock()
            ...
            activate_task()
              dl_server_start() --> first enqueue
            wakeup_preempt() := check_preempt_wakeup_fair()
              update_curr()
                update_curr_task()
                  if (current->dl_server)
                    dl_server_update()
                      enqueue_dl_entity() --> second enqueue

This bug was not apparent as the enqueue in dl_server_start doesn't
usually happen because of the defer logic. But as a side effect of the
first case(dequeue during dlserver pick), dl_throttled and dl_yield will
be set and this causes the time accounting of dlserver to messup and
then leading to a enqueue in dl_server_start.

Have an explicit flag representing the status of dlserver to avoid the
confusion. This is set in dl_server_start and reset in dlserver_stop.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 include/linux/sched.h   | 7 +++++++
 kernel/sched/deadline.c | 8 ++++++--
 kernel/sched/sched.h    | 5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..66b311fbd5d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
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
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 33b4646f8b24..0abf14ac5ca7 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1667,6 +1667,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime)
 		return;
 
+	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 		resched_curr(dl_se->rq);
@@ -1681,6 +1682,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_server_active = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -2435,8 +2437,10 @@ static struct task_struct *__pick_task_dl(struct rq *rq)
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
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aef716c41edb..65fa64845d9f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -398,6 +398,11 @@ extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq
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
2.45.2


