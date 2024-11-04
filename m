Return-Path: <linux-kernel+bounces-394989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC479BB6E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3BF2827B7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587C1BD039;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iMt944o9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445642A9E
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728614; cv=none; b=TbATnKuVf4sOnm1Z6T/NKZF3R9zUBXHhTGIhCvXmrouoqAjlq1b/eYS3yEPGKv4jDK0xrS5fVcB6guv7Qg/9Rxx33i8o+IdOTtx7QydSUQW5mWzqiAItPnFiVQJoOgqerur4/SoX1zbLJqQAU4X4WS1l7ylgQEdGz21Y89066m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728614; c=relaxed/simple;
	bh=pKtAqVOuuXSgB26Yl/vYdCLHnwYq67mkNICyAdD7Q1I=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XdJ6tpb3I5+48MeyOT7ivyW63MF26L6Mckv46PDQ7mnNXwNVp4UAMJquvPhC5MOl1l3Nkp0AB+zWrsWk1fkxvaADTKKbiHA2h1Sj6W4XrdgU897sjTDOvkOvxAy52zBWV38roN4PYwh4LnJ4FKxllE6m/UGXnJLbqN1WlewL0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iMt944o9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Ve/QPfWZvlAUrpIzMg6wcp2uRfSXlP8s7Qrc6d6TiW0=; b=iMt944o9hw4rc+7gPb+2PFyJ78
	U/domA2W/AQGvNKExRbAcEl7z+yru0JtEalqTBHxgdhvj9CdUAhUXR0VzqBjBTWwTzzeTFrpR9dnU
	ho0xeL6190Gb3ERVzTUVAORsAfh0TZyGvHRco6P67kVqrZOhk+Kk9b6Z4g8NScYSYtURIpDLlem2e
	PqNt3wWZffgJ3/hPKH0/Cbngwdf7ivdGxwHt5dgzSw4lyQ+YZsgEAEOPCCReMeM9EcieSsEFOg6s7
	eyJ/9hJsYiuG+xMRsl+qBvxi5ccVl/KIo30AyrVeJGkEYc5cSe9dQf/UhTlP2IWryT7oJ6Ib57FD2
	nctSG+9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZY-0000000BL8F-2rld;
	Mon, 04 Nov 2024 13:56:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A50AE308DD1; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135519.715883982@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com
Subject: [PATCH 19/19] perf: Make perf_pmu_unregister() useable
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Previously it was only safe to call perf_pmu_unregister() if there
were no active events of that pmu around -- which was impossible to
guarantee since it races all sorts against perf_init_event().

Rework the whole thing by:

 - keeping track of all events for a given pmu

 - 'hiding' the pmu from perf_init_event()

 - waiting for the appropriate (s)rcu grace periods such that all
   prior references to the PMU will be completed

 - detaching all still existing events of that pmu (see first point)
   and moving them to a new REVOKED state.

 - actually freeing the pmu data.

Where notably the new REVOKED state must inhibit all event actions
from reaching code that wants to use event->pmu.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/perf_event.h |   13 +-
 kernel/events/core.c       |  222 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 210 insertions(+), 25 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -318,6 +318,9 @@ struct perf_output_handle;
 struct pmu {
 	struct list_head		entry;
 
+	spinlock_t			events_lock;
+	struct list_head		events;
+
 	struct module			*module;
 	struct device			*dev;
 	struct device			*parent;
@@ -611,9 +614,10 @@ struct perf_addr_filter_range {
  * enum perf_event_state - the states of an event:
  */
 enum perf_event_state {
-	PERF_EVENT_STATE_DEAD		= -4,
-	PERF_EVENT_STATE_EXIT		= -3,
-	PERF_EVENT_STATE_ERROR		= -2,
+	PERF_EVENT_STATE_DEAD		= -5,
+	PERF_EVENT_STATE_REVOKED	= -4, /* pmu gone, must not touch */
+	PERF_EVENT_STATE_EXIT		= -3, /* task died, still inherit */
+	PERF_EVENT_STATE_ERROR		= -2, /* scheduling error, can enable */
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
 	PERF_EVENT_STATE_ACTIVE		=  1,
@@ -854,6 +858,7 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+	struct list_head		pmu_list;
 
 	/*
 	 * Certain events gets forwarded to another pmu internally by over-
@@ -1105,7 +1110,7 @@ extern void perf_aux_output_flag(struct
 extern void perf_event_itrace_started(struct perf_event *event);
 
 extern int perf_pmu_register(struct pmu *pmu, const char *name, int type);
-extern void perf_pmu_unregister(struct pmu *pmu);
+extern int perf_pmu_unregister(struct pmu *pmu);
 
 extern void __perf_event_task_sched_in(struct task_struct *prev,
 				       struct task_struct *task);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2412,7 +2412,9 @@ ctx_time_update_event(struct perf_event_
 
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
-#define DETACH_DEAD	0x04UL
+#define DETACH_EXIT	0x04UL
+#define DETACH_REVOKE	0x08UL
+#define DETACH_DEAD	0x10UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2427,6 +2429,7 @@ __perf_remove_from_context(struct perf_e
 			   void *info)
 {
 	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
+	enum perf_event_state state = PERF_EVENT_STATE_OFF;
 	unsigned long flags = (unsigned long)info;
 
 	ctx_time_update(cpuctx, ctx);
@@ -2435,16 +2438,22 @@ __perf_remove_from_context(struct perf_e
 	 * Ensure event_sched_out() switches to OFF, at the very least
 	 * this avoids raising perf_pending_task() at this time.
 	 */
-	if (flags & DETACH_DEAD)
+	if (flags & DETACH_EXIT)
+		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_REVOKE)
+		state = PERF_EVENT_STATE_REVOKED;
+	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
+		state = PERF_EVENT_STATE_DEAD;
+	}
 	event_sched_out(event, ctx);
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
-	if (flags & DETACH_DEAD)
-		event->state = PERF_EVENT_STATE_DEAD;
+
+	event->state = state;
 
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
@@ -4511,7 +4520,8 @@ static void perf_event_enable_on_exec(st
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx);
+				  struct perf_event_context *ctx,
+				  bool revoke);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4538,7 +4548,7 @@ static void perf_event_remove_on_exec(st
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx);
+		perf_event_exit_event(event, ctx, false);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -5138,6 +5148,7 @@ static bool is_sb_event(struct perf_even
 	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
 		return true;
+
 	return false;
 }
 
@@ -5339,6 +5350,8 @@ static void perf_pending_task_sync(struc
 /* vs perf_event_alloc() error */
 static void __free_event(struct perf_event *event)
 {
+	struct pmu *pmu = event->pmu;
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
 
@@ -5365,6 +5378,7 @@ static void __free_event(struct perf_eve
 		 * put_pmu_ctx() needs an event->ctx reference, because of
 		 * epc->ctx.
 		 */
+		WARN_ON_ONCE(!pmu);
 		WARN_ON_ONCE(!event->ctx);
 		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
 		put_pmu_ctx(event->pmu_ctx);
@@ -5377,8 +5391,13 @@ static void __free_event(struct perf_eve
 	if (event->ctx)
 		put_ctx(event->ctx);
 
-	if (event->pmu)
-		module_put(event->pmu->module);
+	if (pmu) {
+		module_put(pmu->module);
+		scoped_guard (spinlock, &pmu->events_lock) {
+			list_del(&event->pmu_list);
+			wake_up_var(pmu);
+		}
+	}
 
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
@@ -5397,6 +5416,7 @@ static void _free_event(struct perf_even
 	security_perf_event_free(event);
 
 	if (event->rb) {
+		WARN_ON_ONCE(!event->pmu);
 		/*
 		 * Can happen when we close an event with re-directed output.
 		 *
@@ -5527,7 +5547,11 @@ int perf_event_release_kernel(struct per
 	 * Thus this guarantees that we will in fact observe and kill _ALL_
 	 * child events.
 	 */
-	perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
+	if (event->state > PERF_EVENT_STATE_REVOKED) {
+		perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
+	} else {
+		event->state = PERF_EVENT_STATE_DEAD;
+	}
 
 	perf_event_ctx_unlock(event, ctx);
 
@@ -5838,7 +5862,7 @@ __perf_read(struct perf_event *event, ch
 	 * error state (i.e. because it was pinned but it couldn't be
 	 * scheduled on to the CPU at some point).
 	 */
-	if (event->state == PERF_EVENT_STATE_ERROR)
+	if (event->state <= PERF_EVENT_STATE_ERROR)
 		return 0;
 
 	if (count < event->read_size)
@@ -5877,8 +5901,14 @@ static __poll_t perf_poll(struct file *f
 	struct perf_buffer *rb;
 	__poll_t events = EPOLLHUP;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return EPOLLERR;
+
 	poll_wait(file, &event->waitq, wait);
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return EPOLLERR;
+
 	if (is_event_hup(event))
 		return events;
 
@@ -6058,6 +6088,9 @@ static long _perf_ioctl(struct perf_even
 	void (*func)(struct perf_event *);
 	u32 flags = arg;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return -ENODEV;
+
 	switch (cmd) {
 	case PERF_EVENT_IOC_ENABLE:
 		func = _perf_event_enable;
@@ -6507,6 +6540,7 @@ static void perf_mmap_close(struct vm_ar
 	unsigned long size = perf_data_size(rb);
 	bool detach_rest = false;
 
+	/* FIXIES vs perf_pmu_unregister() */
 	if (event->pmu->event_unmapped)
 		event->pmu->event_unmapped(event, vma->vm_mm);
 
@@ -6657,6 +6691,16 @@ static int perf_mmap(struct file *file,
 	mutex_lock(&event->mmap_mutex);
 	ret = -EINVAL;
 
+	/*
+	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
+	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
+	 * will detach the rb created here.
+	 */
+	if (event->state <= PERF_EVENT_STATE_REVOKED) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	if (vma->vm_pgoff == 0) {
 		nr_pages -= 1;
 
@@ -6840,6 +6884,9 @@ static int perf_fasync(int fd, struct fi
 	struct perf_event *event = filp->private_data;
 	int retval;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return -ENODEV;
+
 	inode_lock(inode);
 	retval = fasync_helper(fd, filp, on, &event->fasync);
 	inode_unlock(inode);
@@ -11892,6 +11939,9 @@ int perf_pmu_register(struct pmu *_pmu,
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
+	INIT_LIST_HEAD(&pmu->events);
+	spin_lock_init(&pmu->events_lock);
+
 	/*
 	 * Now that the PMU is complete, make it visible to perf_try_init_event().
 	 */
@@ -11905,11 +11955,100 @@ int perf_pmu_register(struct pmu *_pmu,
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
 
-void perf_pmu_unregister(struct pmu *pmu)
+static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
+			       struct perf_event_context *ctx)
+{
+	/*
+	 * De-schedule the event and mark it REVOKED.
+	 */
+	perf_event_exit_event(event, ctx, true);
+
+	/*
+	 * All _free_event() bits that rely on event->pmu:
+	 *
+	 * Notably, perf_mmap() relies on the ordering here.
+	 */
+	scoped_guard (mutex, &event->mmap_mutex) {
+		WARN_ON_ONCE(pmu->event_unmapped);
+		ring_buffer_attach(event, NULL);
+	}
+
+	perf_event_free_bpf_prog(event);
+	perf_free_addr_filters(event);
+
+	if (event->destroy) {
+		event->destroy(event);
+		event->destroy = NULL;
+	}
+
+	if (event->pmu_ctx) {
+		put_pmu_ctx(event->pmu_ctx);
+		event->pmu_ctx = NULL;
+	}
+
+	exclusive_event_destroy(event);
+	module_put(pmu->module);
+
+	event->pmu = NULL; /* force fault instead of UAF */
+}
+
+static void pmu_detach_event(struct pmu *pmu, struct perf_event *event)
+{
+	struct perf_event_context *ctx;
+
+	ctx = perf_event_ctx_lock(event);
+	__pmu_detach_event(pmu, event, ctx);
+	perf_event_ctx_unlock(event, ctx);
+
+	scoped_guard (spinlock, &pmu->events_lock)
+		list_del(&event->pmu_list);
+}
+
+static struct perf_event *pmu_get_event(struct pmu *pmu)
+{
+	struct perf_event *event;
+
+	guard(spinlock)(&pmu->events_lock);
+	list_for_each_entry(event, &pmu->events, pmu_list) {
+		if (atomic_long_inc_not_zero(&event->refcount))
+			return event;
+	}
+
+	return NULL;
+}
+
+static bool pmu_empty(struct pmu *pmu)
+{
+	guard(spinlock)(&pmu->events_lock);
+	return list_empty(&pmu->events);
+}
+
+static void pmu_detach_events(struct pmu *pmu)
+{
+	struct perf_event *event;
+
+	for (;;) {
+		event = pmu_get_event(pmu);
+		if (!event)
+			break;
+
+		pmu_detach_event(pmu, event);
+		put_event(event);
+	}
+
+	/*
+	 * wait for pending _free_event()s
+	 */
+	wait_var_event(pmu, pmu_empty(pmu));
+}
+
+int perf_pmu_unregister(struct pmu *pmu)
 {
 	scoped_guard (mutex, &pmus_lock) {
+		if (!idr_cmpxchg(&pmu_idr, pmu->type, pmu, NULL))
+			return -EINVAL;
+
 		list_del_rcu(&pmu->entry);
-		idr_remove(&pmu_idr, pmu->type);
 	}
 
 	/*
@@ -11919,7 +12058,31 @@ void perf_pmu_unregister(struct pmu *pmu
 	synchronize_srcu(&pmus_srcu);
 	synchronize_rcu();
 
+	if (pmu->event_unmapped && !pmu_empty(pmu)) {
+		/*
+		 * Can't force remove events when pmu::event_unmapped()
+		 * is used in perf_mmap_close().
+		 */
+		guard(mutex)(&pmus_lock);
+		idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu);
+		list_add_rcu(&pmu->entry, &pmus);
+		return -EBUSY;
+	}
+
+	scoped_guard (mutex, &pmus_lock)
+		idr_remove(&pmu_idr, pmu->type);
+
+	/*
+	 * PMU is removed from the pmus list, so no new events will
+	 * be created, now take care of the existing ones.
+	 */
+	pmu_detach_events(pmu);
+
+	/*
+	 * PMU is unused, make it go away.
+	 */
 	perf_pmu_free(pmu);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
@@ -12226,6 +12389,7 @@ perf_event_alloc(struct perf_event_attr
 	INIT_LIST_HEAD(&event->active_entry);
 	INIT_LIST_HEAD(&event->addr_filters.list);
 	INIT_HLIST_NODE(&event->hlist_entry);
+	INIT_LIST_HEAD(&event->pmu_list);
 
 
 	init_waitqueue_head(&event->waitq);
@@ -12294,6 +12458,13 @@ perf_event_alloc(struct perf_event_attr
 
 	perf_event__state_init(event);
 
+	/*
+	 * Hold SRCU critical section around perf_init_event(), until returning
+	 * the fully formed event put on pmu->events_list. This ensures that
+	 * perf_pmu_unregister() will see any in-progress event creation that
+	 * races.
+	 */
+	guard(srcu)(&pmus_srcu);
 	pmu = NULL;
 
 	hwc = &event->hw;
@@ -12383,6 +12554,9 @@ perf_event_alloc(struct perf_event_attr
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
+	scoped_guard (spinlock, &pmu->events_lock)
+		list_add(&event->pmu_list, &pmu->events);
+
 	return_ptr(event);
 }
 
@@ -12769,6 +12943,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		if (err)
 			goto err_fd;
 		group_leader = fd_file(group)->private_data;
+		if (group_leader->state <= PERF_EVENT_STATE_REVOKED) {
+			err = -ENODEV;
+			goto err_group_fd;
+		}
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
@@ -13316,10 +13494,11 @@ static void sync_child_event(struct perf
 }
 
 static void
-perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
+perf_event_exit_event(struct perf_event *event,
+		      struct perf_event_context *ctx, bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = 0;
+	unsigned long detach_flags = DETACH_EXIT;
 
 	if (parent_event) {
 		/*
@@ -13334,16 +13513,14 @@ perf_event_exit_event(struct perf_event
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags);
+	if (revoke)
+		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
 
-	raw_spin_lock_irq(&ctx->lock);
-	if (event->state > PERF_EVENT_STATE_EXIT)
-		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
-	raw_spin_unlock_irq(&ctx->lock);
+	perf_remove_from_context(event, detach_flags);
 
 	/*
 	 * Child events can be freed.
@@ -13419,7 +13596,7 @@ static void perf_event_exit_task_context
 	perf_event_task(child, child_ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &child_ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, child_ctx);
+		perf_event_exit_event(child_event, child_ctx, false);
 
 	mutex_unlock(&child_ctx->mutex);
 
@@ -13609,6 +13786,9 @@ inherit_event(struct perf_event *parent_
 	if (parent_event->parent)
 		parent_event = parent_event->parent;
 
+	if (parent_event->state <= PERF_EVENT_STATE_REVOKED)
+		return NULL;
+
 	child_event = perf_event_alloc(&parent_event->attr,
 					   parent_event->cpu,
 					   child,



