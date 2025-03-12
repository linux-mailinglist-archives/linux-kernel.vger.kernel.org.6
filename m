Return-Path: <linux-kernel+bounces-558315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6CAA5E440
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BEA174DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399E2561A3;
	Wed, 12 Mar 2025 19:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggaBli9P"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EC1D54E2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807111; cv=none; b=rCZSqPveMjYQW+KLFeyeOtKi+mtGKxQ2rk6FbbWOLgAtsYwoHGhpx/VLyHZ2uyRqCpERIM+mMXPsrzgR63r6eRypC4FZ2nCIV1J0fNXm2Fddzt6bfzGWt2bAhf/Fe4LhehbYG8FKp8J6334zMPCvtlJYzVGjyP/NYF1TE6COwMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807111; c=relaxed/simple;
	bh=YvnNT1XiJVLgjHjHQqAnT8ePEUcxaHyoesdhRBdVTF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGymsVbkC9+9lh15dDbuaOHCW90e6DL+duwnzlwdlVJww1EcZRj+Kot0FPU3R3KxTuopoHOz+E8KZgLFrubnpJxO3QX0q2MISAp9V185p6xk3XEpKV5GmCtsiSYWFuEIZmSFukBzjzWe86TKhR8iGhAXDJdNggFuQA6efKqOSig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ggaBli9P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7gIjdKDBOJgTeCHCAxnDrmjov7z/kYBsOHm/ApyClTw=; b=ggaBli9PECYlUBZ70PuyBJx/L1
	7yx9KxjoFThWjbEE0yzFKTiEnRa2GWd3n813BfTobf2yHAgnLexokW8EWs0H4hh0QRS4EqEzJfmms
	EDZjBKx+tWDPUHscou/4HHleEZqIj3GK+wh9cBULEKUiA3osnShLVYK0exIARlX9Ssu+rxaVwf07P
	Dv+1JiG5+g5jpfC5RxBkgnx0LFmA9ulfbnoaoGbdTS6cxDlPFk+n6Gfc9t5Vb+0VY85CcpoRrIhqP
	UJaPtHe/h6p/jNMIY/2KGA0RKNJ8aPUgfABjDrk3H6iVKoM9NzhCtEbQm+/hcegIk+CUzYeO8wUIA
	gIu33UjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsRay-0000000DEzK-2lVo;
	Wed, 12 Mar 2025 19:18:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2423D300599; Wed, 12 Mar 2025 20:18:24 +0100 (CET)
Date: Wed, 12 Mar 2025 20:18:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V8 2/6] perf: attach/detach PMU specific data
Message-ID: <20250312191823.GB10453@noisy.programming.kicks-ass.net>
References: <20250312182525.4078433-1-kan.liang@linux.intel.com>
 <20250312182525.4078433-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312182525.4078433-2-kan.liang@linux.intel.com>

On Wed, Mar 12, 2025 at 11:25:21AM -0700, kan.liang@linux.intel.com wrote:

> +static int
> +attach_global_ctx_data(struct kmem_cache *ctx_cache)
> +{
> +	if (refcount_inc_not_zero(&global_ctx_data_ref))
> +		return 0;
> +
> +	percpu_down_write(&global_ctx_data_rwsem);
> +	if (!refcount_inc_not_zero(&global_ctx_data_ref)) {
> +		struct task_struct *g, *p;
> +		struct perf_ctx_data *cd;
> +		int ret;
> +
> +again:
> +		/* Allocate everything */
> +		rcu_read_lock();
> +		for_each_process_thread(g, p) {
> +			cd = rcu_dereference(p->perf_ctx_data);
> +			if (cd && !cd->global) {
> +				cd->global = 1;
> +				if (!refcount_inc_not_zero(&cd->refcount))
> +					cd = NULL;
> +			}
> +			if (!cd) {
> +				get_task_struct(p);
> +				rcu_read_unlock();
> +
> +				ret = attach_task_ctx_data(p, ctx_cache, true);
> +				put_task_struct(p);
> +				if (ret) {
> +					__detach_global_ctx_data();
> +					return ret;

AFAICT this returns with global_ctx_data_rwsem taken, no?

> +				}
> +				goto again;
> +			}
> +		}
> +		rcu_read_unlock();
> +
> +		refcount_set(&global_ctx_data_ref, 1);
> +	}
> +	percpu_up_write(&global_ctx_data_rwsem);
> +
> +	return 0;
> +}

Can we rework this with guards? A little something like so?

---
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5233,18 +5233,20 @@ static refcount_t global_ctx_data_ref;
 static int
 attach_global_ctx_data(struct kmem_cache *ctx_cache)
 {
+	struct task_struct *g, *p;
+	struct perf_ctx_data *cd;
+	int ret;
+
 	if (refcount_inc_not_zero(&global_ctx_data_ref))
 		return 0;
 
-	percpu_down_write(&global_ctx_data_rwsem);
-	if (!refcount_inc_not_zero(&global_ctx_data_ref)) {
-		struct task_struct *g, *p;
-		struct perf_ctx_data *cd;
-		int ret;
+	guard(percpu_write)(&global_ctx_data_rwsem);
+	if (refcount_inc_not_zero(&global_ctx_data_ref))
+		return 0;
 
 again:
-		/* Allocate everything */
-		rcu_read_lock();
+	/* Allocate everything */
+	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
 			cd = rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
@@ -5254,24 +5256,23 @@ attach_global_ctx_data(struct kmem_cache
 			}
 			if (!cd) {
 				get_task_struct(p);
-				rcu_read_unlock();
-
-				ret = attach_task_ctx_data(p, ctx_cache, true);
-				put_task_struct(p);
-				if (ret) {
-					__detach_global_ctx_data();
-					return ret;
-				}
-				goto again;
+				goto alloc;
 			}
 		}
-		rcu_read_unlock();
-
-		refcount_set(&global_ctx_data_ref, 1);
 	}
-	percpu_up_write(&global_ctx_data_rwsem);
+
+	refcount_set(&global_ctx_data_ref, 1);
 
 	return 0;
+
+alloc:
+	ret = attach_task_ctx_data(p, ctx_cache, true);
+	put_task_struct(p);
+	if (ret) {
+		__detach_global_ctx_data();
+		return ret;
+	}
+	goto again;
 }
 
 static int
@@ -5338,15 +5339,12 @@ static void detach_global_ctx_data(void)
 	if (refcount_dec_not_one(&global_ctx_data_ref))
 		return;
 
-	percpu_down_write(&global_ctx_data_rwsem);
+	guard(perpcu_write)(&global_ctx_data_rwsem);
 	if (!refcount_dec_and_test(&global_ctx_data_ref))
-		goto unlock;
+		return;
 
 	/* remove everything */
 	__detach_global_ctx_data();
-
-unlock:
-	percpu_up_write(&global_ctx_data_rwsem);
 }
 
 static void detach_perf_ctx_data(struct perf_event *event)
@@ -8776,9 +8774,9 @@ perf_event_alloc_task_data(struct task_s
 	if (!ctx_cache)
 		return;
 
-	percpu_down_read(&global_ctx_data_rwsem);
+	guard(percpu_read)(&global_ctx_data_rwsem);
+	guard(rcu)();
 
-	rcu_read_lock();
 	cd = rcu_dereference(child->perf_ctx_data);
 
 	if (!cd) {
@@ -8787,21 +8785,16 @@ perf_event_alloc_task_data(struct task_s
 		 * when attaching the perf_ctx_data.
 		 */
 		if (!refcount_read(&global_ctx_data_ref))
-			goto rcu_unlock;
+			return;
 		rcu_read_unlock();
 		attach_task_ctx_data(child, ctx_cache, true);
-		goto up_rwsem;
+		return;
 	}
 
 	if (!cd->global) {
 		cd->global = 1;
 		refcount_inc(&cd->refcount);
 	}
-
-rcu_unlock:
-	rcu_read_unlock();
-up_rwsem:
-	percpu_up_read(&global_ctx_data_rwsem);
 }
 
 void perf_event_fork(struct task_struct *task)
@@ -13845,9 +13838,8 @@ void perf_event_exit_task(struct task_st
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
 	 */
-	percpu_down_read(&global_ctx_data_rwsem);
+	guard(percpu_read)(&global_ctx_data_rwsem);
 	detach_task_ctx_data(child);
-	percpu_up_read(&global_ctx_data_rwsem);
 }
 
 static void perf_free_event(struct perf_event *event,
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index c012df33a9f0..36f3082f2d82 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -8,6 +8,7 @@
 #include <linux/wait.h>
 #include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
+#include <linux/cleanup.h>
 
 struct percpu_rw_semaphore {
 	struct rcu_sync		rss;
@@ -125,6 +126,13 @@ extern bool percpu_is_read_locked(struct percpu_rw_semaphore *);
 extern void percpu_down_write(struct percpu_rw_semaphore *);
 extern void percpu_up_write(struct percpu_rw_semaphore *);
 
+DEFINE_GUARD(percpu_read, struct perpcu_rw_semaphore *,
+	     perpcu_down_read(_T), percpu_up_read(_T))
+DEFINE_GUARD_COND(perpcu_read, _try, percpu_down_read_trylock(_T))
+
+DEFINE_GUARD(percpu_write, struct percpu_rw_semaphore *,
+	     percpu_down_write(_T), perpcu_up_write(_T))
+
 static inline bool percpu_is_write_locked(struct percpu_rw_semaphore *sem)
 {
 	return atomic_read(&sem->block);

