Return-Path: <linux-kernel+bounces-362880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E1999BA95
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 19:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBDB1C20B0B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940051494A7;
	Sun, 13 Oct 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lwsSZcDE"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452BD1487E3
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728841177; cv=none; b=bzscKYR5C0rPGgOcLGVd32qX0y1bDVw9GGok1BRYzss2FDIaXGi74+HkFgnQC9JeqmJ9o3vN6SLtnuuBoedUMUvRSM8iqLhPZVVsqKTbceQXDGOAd1UnKujfON/4ae1M8KX167ADr206Vn5+OXiHR35NnyDx5pIZ+jwddhiC9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728841177; c=relaxed/simple;
	bh=XfZfMzw30WnicN3a1qE9PuEGVSuYQuX/oCyayE7NgWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kva0r0AWjdKt8qyXdXQYdE5ZpH9HeplmiZVGf1S/21F0M5xqYva4rDvHldGcvPz1ZpOJg1LkKUWbBMdvRCQYJ/pJGo24VkPuyJNyO+eKqfO6isJ0oXA+N5pVcFYE5j1QowojoSttguki8R46Ti9oAY7vDgK1/v6QWtkBBsLIST8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lwsSZcDE; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728841173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P4vayhhJlhZN3GgkGgPuAI8sSuIdRw4HReRwmMjKpO0=;
	b=lwsSZcDEqH99tfQWS451EzNmMz5V61QRAfc0bUkP7264lS5oHst/6uKvFZUdM8iJxtWvp8
	3GrJh184t+ArC8f3G7XR4pgmwhQ++9BJ9lEamc+x2cf6pQ5A0EmuzP0+/EsGqPD7O3XZmm
	V3PFtTNgdybNxhbC6YZn5amZ9WcZ1rw=
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Always call put_prev_task() with scx enabled
Date: Sun, 13 Oct 2024 19:39:28 +0200
Message-ID: <20241013173928.20738-1-andrea.righi@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

With the consolidation of put_prev_task/set_next_task(), we are now
skipping the sched_ext ops.stopping/running() transitions when the
previous and next tasks are the same, see commit 436f3eed5c69 ("sched:
Combine the last put_prev_task() and the first set_next_task()").

While this optimization makes sense in general, it can negatively impact
performance in some user-space schedulers, that expect to handle such
transitions when tasks exhaust their timeslice (see SCX_OPS_ENQ_LAST).

For example, scx_rustland suffers a significant performance regression
(e.g., gaming benchmarks drop from ~60fps to ~10fps).

To fix this, ensure that put_prev_task()/set_next_task() are never
skipped when the scx scheduling class is enabled, allowing the scx class
to handle such transitions.

This change restores the previous behavior, fixing the performance
regression in scx_rustland.

Link: https://github.com/sched-ext/scx/issues/788
Fixes: 7c65ae81ea86 ("sched_ext: Don't call put_prev_task_scx() before picking the next task")
Signed-off-by: Andrea Righi <andrea.righi@linux.dev>
---
 kernel/sched/sched.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6085ef50febf..44d736e49d06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2470,21 +2470,6 @@ __put_prev_set_next_dl_server(struct rq *rq,
 	rq->dl_server = NULL;
 }
 
-static inline void put_prev_set_next_task(struct rq *rq,
-					  struct task_struct *prev,
-					  struct task_struct *next)
-{
-	WARN_ON_ONCE(rq->curr != prev);
-
-	__put_prev_set_next_dl_server(rq, prev, next);
-
-	if (next == prev)
-		return;
-
-	prev->sched_class->put_prev_task(rq, prev, next);
-	next->sched_class->set_next_task(rq, next, true);
-}
-
 /*
  * Helper to define a sched_class instance; each one is placed in a separate
  * section which is ordered by the linker script:
@@ -2523,6 +2508,21 @@ DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
 #define scx_switched_all()	false
 #endif /* !CONFIG_SCHED_CLASS_EXT */
 
+static inline void put_prev_set_next_task(struct rq *rq,
+					  struct task_struct *prev,
+					  struct task_struct *next)
+{
+	WARN_ON_ONCE(rq->curr != prev);
+
+	__put_prev_set_next_dl_server(rq, prev, next);
+
+	if (next == prev && !scx_enabled())
+		return;
+
+	prev->sched_class->put_prev_task(rq, prev, next);
+	next->sched_class->set_next_task(rq, next, true);
+}
+
 /*
  * Iterate only active classes. SCX can take over all fair tasks or be
  * completely disabled. If the former, skip fair. If the latter, skip SCX.
-- 
2.47.0


