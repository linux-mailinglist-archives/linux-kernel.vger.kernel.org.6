Return-Path: <linux-kernel+bounces-389037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FA19B67C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DD31C20FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9450217452;
	Wed, 30 Oct 2024 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lPjADyxu"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBC213ECB
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301955; cv=none; b=Tn0wsrneLRcQjAN1WE5aAqjB3Hr4pYB9weoyflPi6jylkg6iKW2rYwcRIruxLVDZ1EVyJsXyZ9dfahVNApQkC/a3JdGd5z+7Rj7WkrJOl/cd+HEKtpas9EuRcXYO6nJDuFW72/mI3SnJT+i/h5BIpp3dXiIha3FD1Y/W+fZJ080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301955; c=relaxed/simple;
	bh=8E32x75lCrtV/w1t1rzOYa0pZAKOafPl72BulaYj7SA=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gbEdd2Lb9wfGqMoGN+pOC4Vba8O7ZWVnWGHMhrHpbw5t+TwLS5yX4O7j5NX9cgVTEcLqKq/9WybVAXXMjjisc5EMr8abdPYQsjjn1a4vCoj1x4sdbsSD4blU+ML+yBkrXmpEY8c4sQEaXpc7vU4jxlYfVSbziWx6Gbzvdu5CDsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lPjADyxu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=k7Ui+RJB68mM8gJ9CNv96KrJtDsj2TyL1J3cQNlTEpk=; b=lPjADyxuluDRY7Hox/Zdyj1fje
	24XclypEXGxgngZvduw9Dh/NMlnucbZvJh2MlMi3QpXve6nzNUJJmbkDRK/tM6lQGxRBGZoM3/eS0
	gUmat7ExuHZves7rjUzDKBneNvxdWMF0Eehhcv5nJYg/eecRWOiYZxymxA32nh3KH+6y58iUFv92f
	0ojSDRHcCcs/wunUbetx2L5e2Jc3w3sL9BIhNS6q0EkKcipm5dCnWK2GQqGV66eWG1atAoCr4PMp6
	mNrLjnH41TSKC6D8JINIWaED/hzro5mlA8q4dQm6Hv9G/zYcAOHoYhNmVP9WkaWlH1OYKUfJvVBhT
	K8tBmD5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AZt-0000000AI2E-3UAk;
	Wed, 30 Oct 2024 15:25:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0311930625D; Wed, 30 Oct 2024 16:25:43 +0100 (CET)
Message-Id: <20241030152142.928034708@infradead.org>
User-Agent: quilt/0.65
Date: Wed, 30 Oct 2024 16:13:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 void@manifault.com,
 linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 6/6] sched: Cleanup sched_delayed handling for class switches
References: <20241030151255.300069509@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Use the new sched_class::switching_from() method to dequeue delayed
tasks before switching to another class.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   12 ++++++++----
 kernel/sched/ext.c      |   12 ++++--------
 kernel/sched/fair.c     |    7 +++++++
 kernel/sched/syscalls.c |    3 ---
 4 files changed, 19 insertions(+), 15 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7139,9 +7139,6 @@ void rt_mutex_setprio(struct task_struct
 	if (prev_class != next_class)
 		queue_flag |= DEQUEUE_CLASS;
 
-	if (prev_class != next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
 		 * Boosting condition are:
@@ -10530,8 +10527,15 @@ struct sched_change_ctx sched_change_beg
 
 	lockdep_assert_rq_held(rq);
 
-	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from)
+	if ((flags & DEQUEUE_CLASS) && p->sched_class->switching_from) {
+		/*
+		 * switching_from_fair() assumes CLASS implies NOCLOCK; fixing
+		 * this assumption would mean switching_from() would need to be
+		 * able to change flags.
+		 */
+		SCHED_WARN_ON(!(flags & DEQUEUE_NOCLOCK));
 		p->sched_class->switching_from(rq, p, flags);
+	}
 
 	struct sched_change_ctx ctx = {
 		.p = p,
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4485,7 +4485,7 @@ static void scx_ops_disable_workfn(struc
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -4493,9 +4493,7 @@ static void scx_ops_disable_workfn(struc
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-
+		update_rq_clock(task_rq(p));
 		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class = new_class;
 		}
@@ -5202,7 +5200,7 @@ static int scx_ops_enable(struct sched_e
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
-		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE;
+		unsigned int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -5210,9 +5208,7 @@ static int scx_ops_enable(struct sched_e
 		if (old_class != new_class)
 			queue_flags |= DEQUEUE_CLASS;
 
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-
+		update_rq_clock(task_rq(p));
 		scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_MOVE) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->sched_class = new_class;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13175,6 +13175,12 @@ static void attach_task_cfs_rq(struct ta
 	attach_entity_cfs_rq(se);
 }
 
+static void switching_from_fair(struct rq *rq, struct task_struct *p, int flags)
+{
+	if ((flags & DEQUEUE_CLASS) && p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+}
+
 static void switched_from_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	detach_task_cfs_rq(p);
@@ -13592,6 +13598,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
+	.switching_from		= switching_from_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
 
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -701,9 +701,6 @@ int __sched_setscheduler(struct task_str
 	if (prev_class != next_class)
 		queue_flags |= DEQUEUE_CLASS;
 
-	if (prev_class != next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {



