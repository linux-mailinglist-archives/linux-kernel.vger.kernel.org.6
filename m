Return-Path: <linux-kernel+bounces-307050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9307796474E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EB11F22739
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AD71AC883;
	Thu, 29 Aug 2024 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SubGUyCe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5349218A6BA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939675; cv=none; b=RIwBwCvz5TO9blX9A9nidOYQVMQ+0dYp+u3PS50Jd2dOvNdvqRit7Z4JR6XsXBur15EKM5CIZKX5XZcjm6ZNY77FjYDQycPz9VLVS4Qox0zq+vXlBsQ5RdFJ6E1ifJkHRRkQyVI8fubLl0k6o7CuIbyY8trct5+ER0m4VyIFIKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939675; c=relaxed/simple;
	bh=Rq+yNcUwPWx41zQSO5KmqMvIsQRScXdlmsTqVPKSxf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P42fZkaW8luqw2lZZFHk4bSJrEVJQ1vesOMVXv98xP9Pn8mfZdTh9OCzSBKNBXB0/GWFHjlcok3eOaIlaDa6aDI8b4+lORyHXz8/W6qtfkrQkNhQ7jJxkoFy14cqMoOtzKeEeMpwZaps+Mg6DqGHzRjgD03CEvjq7bxHxXdgkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SubGUyCe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724939672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vX4yi4Z2CPW0eHhvuU5h0SjR1OL4/r7rT7T4GvJLHuA=;
	b=SubGUyCeSOS7qbafiRU4i9Ov4/tOK9fWsjL72SXWTN+1cLH+jdjs6O6MTbP78O7bDjaA9w
	tmfanBzfBICNkdAtm4vyxRVJYii8QDCygiGKpRn6fGzY+roSPnPUOIJKAG2htUA16//Anr
	prPzwLB23+f9O2rHb+mvyEcqAjMhHGI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-y2zAJ-lJPRiKUMMPommj5Q-1; Thu,
 29 Aug 2024 09:54:29 -0400
X-MC-Unique: y2zAJ-lJPRiKUMMPommj5Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 531E51955BF1;
	Thu, 29 Aug 2024 13:54:26 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16B9519560AA;
	Thu, 29 Aug 2024 13:54:20 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Chen Yu <yu.c.chen@intel.com>,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com,
	youssefesmat@chromium.org,
	tglx@linutronix.de,
	efault@gmx.de
Subject: [PATCH] sched/fair: Properly deactivate sched_delayed task upon class change
Date: Thu, 29 Aug 2024 15:53:53 +0200
Message-ID: <20240829135353.1524260-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

__sched_setscheduler() goes through an enqueue/dequeue cycle like so:

  flags := DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
  prev_class->dequeue_task(rq, p, flags);
  new_class->enqueue_task(rq, p, flags);

when prev_class := fair_sched_class, this is followed by:

  dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);

the idea being that since the task has switched classes, we need to drop
the sched_delayed logic and have that task be deactivated per its previous
dequeue_task(..., DEQUEUE_SLEEP).

Unfortunately, this leaves the task on_rq. This is missing the tail end of
dequeue_entities() that issues __block_task(), which __sched_setscheduler()
won't have done due to not using DEQUEUE_DELAYED - not that it should, as
it is pretty much a fair_sched_class specific thing.

Make switched_from_fair() properly deactivate sched_delayed tasks upon
class changes via __block_task(), as if a
  dequeue_task(..., DEQUEUE_DELAYED)
had been issued.

Fixes: 2e0199df252a ("sched/fair: Prepare exit/cleanup paths for delayed_dequeue")
Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fea057b311f69..3a3286df282fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5456,6 +5456,13 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
+static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
+{
+	se->sched_delayed = 0;
+	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
+		se->vlag = 0;
+}
+
 static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
@@ -5531,11 +5538,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
 		update_min_vruntime(cfs_rq);
 
-	if (flags & DEQUEUE_DELAYED) {
-		se->sched_delayed = 0;
-		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
-			se->vlag = 0;
-	}
+	if (flags & DEQUEUE_DELAYED)
+		finish_delayed_dequeue_entity(se);
 
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
@@ -13107,11 +13111,16 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 	 * and we cannot use DEQUEUE_DELAYED.
 	 */
 	if (p->se.sched_delayed) {
+		/* First, dequeue it from its new class' structures */
 		dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);
-		p->se.sched_delayed = 0;
+		/*
+		 * Now, clean up the fair_sched_class side of things
+		 * related to sched_delayed being true and that wasn't done
+		 * due to the generic dequeue not using DEQUEUE_DELAYED.
+		 */
+		finish_delayed_dequeue_entity(&p->se);
 		p->se.rel_deadline = 0;
-		if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
-			p->se.vlag = 0;
+		__block_task(rq, p);
 	}
 }
 
-- 
2.43.0


