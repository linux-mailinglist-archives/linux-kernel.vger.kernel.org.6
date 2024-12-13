Return-Path: <linux-kernel+bounces-444221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14D69F0308
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5436188556D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B4145A0B;
	Fri, 13 Dec 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="cQv5jKFv"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9042077
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060125; cv=none; b=rOiG8AlsnXZO2j/i+wwzEdLv8j1WYBWedr1De9ZEVcR8Umjb+qulLZKPUJaQuFx9/+rr3oInWt7d4cNem75iaAHkk73u0HHJbaPN62QT/Q3rq215Fli0oCk3YACYmmiPo3TqOVkjHWXCRE4nHN5eocty6PPUcDHV0l5IpHtjiBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060125; c=relaxed/simple;
	bh=mBgqn2ObmBthm2BmC4PR5aOY4YbzFLpJ5xqXeNlnq5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYdioXdIttI11I7JkkzB2H1A7aorNM4XXi92MHJT0KUVLJ2WmiND2NiNCYjQDPs8i3vkKUNLGGouydE6iuWzl3rYiRCM38BMd35ToOyBRDGq99wGmeFHXGIIsUEDw9FQoa41vD31Wnz2Sbhv4+OlNI6etR9NvgYWGOQI8Y4pZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=cQv5jKFv; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-46677ef6920so11599401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1734060121; x=1734664921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUakkspjM852kYB415+rOLMVA918IhDFlEhqsIe/2zo=;
        b=cQv5jKFvzJAufE07GnV5tBZyFi1e4//auaPUoaZlIHd80UwhEQpYcRC26n1wg0Vhe6
         JN/xbTjt3XRfggmrfvDPItbdC3s/KJM/CP10VBAbpriDDaH+aw6D7LDXiv9xOZ/Es6A0
         HZztMU85f6ieOIRFi9w43sPvLRlRBPDSL4SYYXxfv2WufWXkAuuxjnoCf3d4hQoGolAg
         D5E7no3bgVRNGRMeWx3/C7Kwvixa0JDP67znMH35fy/3GTJQcvmvfmyiIZpV3IQsOaCr
         ewyEoo1dCflMHKjdEWXiDb9zMaDshMNaVejF9evcMbA8qrQ9SDQj8bNIuAt9UKLuxj4n
         9kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060121; x=1734664921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EUakkspjM852kYB415+rOLMVA918IhDFlEhqsIe/2zo=;
        b=mukaFJ6rW5huKj8mFX7+9N4hQyyNrHOhNlsT2P/ngmuQf47tG6TcYxuo3vATmGyou/
         bq7bzA9ApI+p4PqzoYouO4zK+QzIj71npRTQbUV6im1RSZ3YV3/SCh3Foa/dMj6OGcNb
         F9cMrl2hQtykCRP5/3MFajYF/Z0ekR5NdbSOhdlisAPyunK9guC5B7nsWnmK1TPyUTVC
         Cn56NCsLkt85TrJQ6ovWvw2UIzErLUJSdChrrfBBYYOoSEXUmLKEdpLU+NkT4tmNtXCi
         JdVudKLDswDvgeG6pjQhvuksTUDs6itD2rgVCGo5xx572G4hcPsf3EfePUHG3qbefkf9
         muTg==
X-Forwarded-Encrypted: i=1; AJvYcCUj4FaVGdTWlC/xXyUwJWB849MtUmxRX7ZtR4YeARgWwX40eyfjNmMoNkcKSHtHyfVVri5vY6mlMtWL1p8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiUvnOCFeQx2bwFY/dUw9OFArdw+LvD5ygX5aQ2ZfT9n6v7pMx
	1OEuHBjyVQ1oGFUOmzm0OZs4bMlTJOaaUDjOVzgYytAYgunsrCxcSZJUH1OaExc=
X-Gm-Gg: ASbGnctXqgafggoLxsQgjxmvapnrTB5dhNASYo7tTrgg9uMRBMKNXrwCR8bHTW5+Whn
	Z1trYGu2kT31c1r4M+NZWdhOh/xjrSdnX1QlIbDphmMQUCbAgQxRqxZg1Q/ORXW0K1nOvwRJwxe
	jTocTGrjmLMuFzbrVn/JnNE2uZRmm34tFaZS71gSlS4cQxRtwprUstEObMoDh0+ajKkX5K+0MIM
	mD87qEuIyNCNOA8SeqHabgLKtvYZ4EHS6SCuz9WZTG3aVG25ku/jqOChATKfPZtS09NtQKULOoJ
	MusCplL0wBlRlfHUvGEHAJA4EUU=
X-Google-Smtp-Source: AGHT+IHQ9/dumb2zTr7rLGuHYmv8eanY37ZeBmWwY8r/eDP9s1vRGAjQBxFxXOOQHZqUR3C9NU34+A==
X-Received: by 2002:ac8:5910:0:b0:467:72c1:7084 with SMTP id d75a77b69052e-467a1387abfmr51628951cf.0.1734060121428;
        Thu, 12 Dec 2024 19:22:01 -0800 (PST)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46787a4c953sm28052941cf.8.2024.12.12.19.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:22:01 -0800 (PST)
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
Date: Thu, 12 Dec 2024 22:21:46 -0500
Message-ID: <20241213032155.876919-1-vineeth@bitbyteword.org>
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


