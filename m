Return-Path: <linux-kernel+bounces-264115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5393DF0F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3239C1F22F7B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31B313BC03;
	Sat, 27 Jul 2024 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lc+hP98b"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF877114
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078150; cv=none; b=uY+GiVB5AkHAeeSxDOO3qbXOIoNwIdnyyYnsy2twVqcaCMSZE7ljOWPK8603pl60/cYBXFpOOTt2WJIg2MkEBDitx9CuD8Enu8xIeKHtX+yXOJbSYRtAj2xuwELOILlSgEr8iBD9ovsitvb4pm8ET37yv63os7/Lv5/KfZUqyrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078150; c=relaxed/simple;
	bh=VRvKCSO+u3SVIJJGEgQSXAVEe0CYqd2QHfPZ5uoKIVw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mSz2nZ9XxjNK3B8tXLYIMhdVDztOWK9gvcqQnmNovGrC2OSZ4iUodrwiQTQf5D6ZTPLpC4NPaVZ6xOox6WcEVQqnnnE6cW6SpgV1GVH9zInlXSY40uLNKfLuq7JO9N/bmmuTLMc5+bTbg54jV/P0XwI7h1FV4N13mDM+rPEh8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lc+hP98b; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=thXjteC/Xnc5IiNOadt/4ekOLhMA+NC8yGXwI3xUFUQ=; b=lc+hP98bjyDH+7AxRy/bfzfxDc
	XytfExVaWQxu0v/piFxABt9514uQIfKXEVwRDzgcW6QjURQzDQ3uRCHiKmpTbiq4l1/hONqA81Glm
	1KBZ3aPBcUBjzvtMAWg6CFT2Gs0xPGIdaIuvESEju1qxrn5AYXQbXP0OTsvptVNp/XL6h3h20KlsB
	fDrzu/Tel79uQ+Gu34VT2YJarrm8ZOSEgaTwnJ9jPw42HFir3wV0QTsSFM19U37yLcDVIsQwXtEPH
	GtA3nVbHr+GyAilVs4KflW03m0cft959xe/UgbUrf1CO39aJsFxu8GY2yplhEcKShY6AcRMWcicmH
	CRDQkquA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMi-0ksP;
	Sat, 27 Jul 2024 11:02:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id B75FF30325A; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105029.315205425@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:42 +0200
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
 efault@gmx.de,
 Luis Machado <luis.machado@arm.com>,
 Hongyan Xia <hongyan.xia2@arm.com>
Subject: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Delayed dequeue has tasks sit around on the runqueue that are not
actually runnable -- specifically, they will be dequeued the moment
they get picked.

One side-effect is that such a task can get migrated, which leads to a
'nested' dequeue_task() scenario that messes up uclamp if we don't
take care.

Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
the runqueue. This however will have removed the task from uclamp --
per uclamp_rq_dec() in dequeue_task(). So far so good.

However, if at that point the task gets migrated -- or nice adjusted
or any of a myriad of operations that does a dequeue-enqueue cycle --
we'll pass through dequeue_task()/enqueue_task() again. Without
modification this will lead to a double decrement for uclamp, which is
wrong.

Reported-by: Luis Machado <luis.machado@arm.com>
Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
 
@@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
@@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
-	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
+	/*
+	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
+	 * ->sched_delayed.
+	 */
+	uclamp_rq_inc(rq, p);
 
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
@@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
+	/*
+	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
+	 * and mark the task ->sched_delayed.
+	 */
 	uclamp_rq_dec(rq, p);
 	return p->sched_class->dequeue_task(rq, p, flags);
 }



