Return-Path: <linux-kernel+bounces-264100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF6B93DEFC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60201C215F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9567F483;
	Sat, 27 Jul 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JKlWRxQN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F11C2D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078147; cv=none; b=AM2zS9di0i7xs03U269jYm962CP+NCcBdqkEFP/j5THOLfYQDiyMhAa3hkEg4Ix4MA6VQ+rG4oAdcawkxie2llGLJ5Bgui+LivW6sHF8dA/l0yRlDeH2jX38K0lXfFQKecQvkGaQ6gJTxUQ8V2LFGoQv3QxrwTeXUv8bhd4i3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078147; c=relaxed/simple;
	bh=TtplGg6uk5+Os8Ofsvg2aLyv6W87kcH4oBqgaXL3AJs=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=F/uJY2AJmzcfrKL6lZI2eZuHJYtRjgzYRP9l872MkwazPsfnS3mzkZAszk87AVNsnIXsXaDw+dK5nR/Xw/JBwOHzf+yaAqjRHnzTUVIiMIq2YHvG2n5Tz5CKax1mMhl3us9fqvkmQ/HloaPw6MPh+KAt3tCQbpxoZ8JxZa2KgTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JKlWRxQN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=f5nSfXsjbdXc2zt2BxCGMWrjQwJeiNZOYkwovsM214c=; b=JKlWRxQNVdLdUBSathHe/VV3gx
	yhd+jENL0Uh2EXU1a4TknwXGsyEat2pVKNzkUnBpdzAgpEuHnLxgGTsgGYI6ceB/8rN2OvzKz0KXD
	Qed9E0lyBhQbszfzNKhoB/u8HRKz3AxZ9F37WAEXL5id/BaXZuXwgPoai4RbsKh5N8Yn+AEhYnTHp
	iwilHKXXt5Ov7h9EEzRfjtYx87MDJetLLXbtZMzpzXL/SMop/LUGiB8CVRJ402bF1uKXXT3RTNDuX
	mHozYJvgWRwYAxJ7sdMicQxDyDBXA4WmklbqSYkikI6oaLz01JJ6QRO1KGhRB3rhvyg4JqnUOf0+h
	jx+Ez8Eg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMp-41UF;
	Sat, 27 Jul 2024 11:02:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E08C1306210; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.403750550@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 18/24] sched/fair: Implement DELAY_ZERO
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

'Extend' DELAY_DEQUEUE by noting that since we wanted to dequeued them
at the 0-lag point, truncate lag (eg. don't let them earn positive
lag).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c     |   16 ++++++++++++++++
 kernel/sched/features.h |    3 +++
 2 files changed, 19 insertions(+)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5529,6 +5529,8 @@ pick_next_entity(struct rq *rq, struct c
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		SCHED_WARN_ON(se->sched_delayed);
 		SCHED_WARN_ON(se->on_rq);
+		if (sched_feat(DELAY_ZERO) && se->vlag > 0)
+			se->vlag = 0;
 
 		return NULL;
 	}
@@ -6827,6 +6829,20 @@ requeue_delayed_entity(struct sched_enti
 	SCHED_WARN_ON(!se->sched_delayed);
 	SCHED_WARN_ON(!se->on_rq);
 
+	if (sched_feat(DELAY_ZERO)) {
+		update_entity_lag(cfs_rq, se);
+		if (se->vlag > 0) {
+			cfs_rq->nr_running--;
+			if (se != cfs_rq->curr)
+				__dequeue_entity(cfs_rq, se);
+			se->vlag = 0;
+			place_entity(cfs_rq, se, 0);
+			if (se != cfs_rq->curr)
+				__enqueue_entity(cfs_rq, se);
+			cfs_rq->nr_running++;
+		}
+	}
+
 	se->sched_delayed = 0;
 }
 
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -34,8 +34,11 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
  * By delaying the dequeue for non-eligible tasks, they remain in the
  * competition and can burn off their negative lag. When they get selected
  * they'll have positive lag by definition.
+ *
+ * DELAY_ZERO clips the lag on dequeue (or wakeup) to 0.
  */
 SCHED_FEAT(DELAY_DEQUEUE, true)
+SCHED_FEAT(DELAY_ZERO, true)
 
 /*
  * Allow wakeup-time preemption of the current task:



