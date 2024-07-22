Return-Path: <linux-kernel+bounces-259009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEF3938FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBC81F21BC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8F116D9DA;
	Mon, 22 Jul 2024 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2FnI7Ub"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCF16D9A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655053; cv=none; b=oRzWif5rpzoqBxWMottQfWf7Ch6IRIVgo3OetG/rmMhXxOZWpTGozxYtGmjR/joZk+sh+gjAeviq5BXh5IswcCgD1VmmkuHXAnbKzWM2NQri4Ua/ckOENX9WqG2GA9IzBvqkGE6fhldp2wO/XRktY5CN/QYcjF4C1PLmd4w+wF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655053; c=relaxed/simple;
	bh=9EgYOyUfPgq4l2dB7nBzMkJgVH7Gh16Hmzqde1fdYNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJwme4Mgm++zgN08yyh4F4z2lOfMN2iYXVRXhbEc6LMXRnhm/kTrjMpHcS1Tqi+m3ITOHylxTQaW1AD7BEt8JMb05vJdp/69hxFlxjxPk6pTi65qfJ5aIlQTd1KoGrWgn6COklhPXMegA4eoUrSIKbOYDb0uFKVejSXV6vn7izU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2FnI7Ub; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721655050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiYDJ2HZojduA6LqxB+JbsILn4/pVNUO9f+x0rZxZwY=;
	b=L2FnI7Ub1VZAYY8RDuQ5Cy0gglheXPrdobgR11X34YSog/mTw/k2+raar/N/zSntu14omW
	/cDBPAkeSPVWqADiaD415YN2k5pvfNhsp6IAfnRyBvYMlNLoCbi5btDXMfL/pVDzioVNzR
	otEtcSboWIdrg+6NwKAPDWefcLPhzVg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-5X6hSO-MNIaBZ0aKxFvklA-1; Mon,
 22 Jul 2024 09:30:47 -0400
X-MC-Unique: 5X6hSO-MNIaBZ0aKxFvklA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF15219776CE;
	Mon, 22 Jul 2024 13:30:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.96.134.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC5DD1955D44;
	Mon, 22 Jul 2024 13:30:36 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org (open list:SCHEDULER)
Cc: Wander Lairson Costa <wander@redhat.com>
Subject: [PATCH 3/3] sched/deadline: Consolidate Timer Cancellation
Date: Mon, 22 Jul 2024 10:29:27 -0300
Message-ID: <20240722132935.14426-4-wander@redhat.com>
In-Reply-To: <20240722132935.14426-1-wander@redhat.com>
References: <20240722132935.14426-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

After commit b58652db66c9 ("sched/deadline: Fix task_struct reference
leak"), I identified additional calls to hrtimer_try_to_cancel that
might also require a dl_server check. It remains unclear whether this
omission was intentional or accidental in those contexts.

This patch consolidates the timer cancellation logic into dedicated
functions, ensuring consistent behavior across all calls.
Additionally, it reduces code duplication and improves overall code
cleanliness.

Note the use of the __always_inline keyword. In some instances, we
have a task_struct pointer, dereference the dl member, and then use
the container_of macro to retrieve the task_struct pointer again. By
inlining the code, the compiler can potentially optimize out this
redundant round trip.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 kernel/sched/deadline.c | 44 ++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 908d5ce79425..8b0bbade2dcb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -320,6 +320,29 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 		__sub_running_bw(dl_se->dl_bw, dl_rq);
 }
 
+static __always_inline
+void cancel_timer(struct sched_dl_entity *dl_se, struct hrtimer *timer)
+{
+	/*
+	 * If the timer callback was running (hrtimer_try_to_cancel == -1),
+	 * it will eventually call put_task_struct().
+	 */
+	if (hrtimer_try_to_cancel(timer) == 1 && !dl_server(dl_se))
+		put_task_struct(dl_task_of(dl_se));
+}
+
+static __always_inline
+void cancel_dl_timer(struct sched_dl_entity *dl_se)
+{
+	cancel_timer(dl_se, &dl_se->dl_timer);
+}
+
+static __always_inline
+void cancel_inactive_timer(struct sched_dl_entity *dl_se)
+{
+	cancel_timer(dl_se, &dl_se->inactive_timer);
+}
+
 static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	struct rq *rq;
@@ -340,8 +363,7 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		cancel_inactive_timer(&p->dl);
 	}
 	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
 	__add_rq_bw(new_bw, &rq->dl);
@@ -490,10 +512,7 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
-			if (!dl_server(dl_se))
-				put_task_struct(dl_task_of(dl_se));
-		}
+		cancel_inactive_timer(dl_se);
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -1810,13 +1829,8 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 			 * The replenish timer needs to be canceled. No
 			 * problem if it fires concurrently: boosted threads
 			 * are ignored in dl_task_timer().
-			 *
-			 * If the timer callback was running (hrtimer_try_to_cancel == -1),
-			 * it will eventually call put_task_struct().
 			 */
-			if (hrtimer_try_to_cancel(&p->dl.dl_timer) == 1 &&
-			    !dl_server(&p->dl))
-				put_task_struct(p);
+			cancel_dl_timer(&p->dl);
 			p->dl.dl_throttled = 0;
 		}
 	} else if (!dl_prio(p->normal_prio)) {
@@ -1981,8 +1995,7 @@ static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __maybe_unused
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		cancel_inactive_timer(&p->dl);
 	}
 	sub_rq_bw(&p->dl, &rq->dl);
 	rq_unlock(rq, &rf);
@@ -2737,8 +2750,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
  */
 static void switched_to_dl(struct rq *rq, struct task_struct *p)
 {
-	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-		put_task_struct(p);
+	cancel_inactive_timer(&p->dl);
 
 	/*
 	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
-- 
2.45.2


