Return-Path: <linux-kernel+bounces-405537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D50D9C52A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E153285563
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A993A21218E;
	Tue, 12 Nov 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6b0eDAo"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959E21217C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405869; cv=none; b=fWQbDX811YrTL4cCJ9zFwruxqHLsEWzflIbVL5gGFDsSquHBQ4i32pIGBjvyGfU7C9fp27OVxD6k2e3sh+cPaXH+Br5hz0QjonNIzsp1Cl3/A8zIRJAdlDs4DeoJbbVDuYMZNniQkfKaSb0g5GwbC9Rnad6rEvllBrLM0GrOFqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405869; c=relaxed/simple;
	bh=2gwS/61fEzxkosJK1R6z0gcBOVWNdzh5klEIsjEtwGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJFlS9nMkapFjhmdEMyRQjvK0R51Zstc+6zaMcHatHK/Mm90bo3mrTNNYAaxUwpkNv9rqOvyhAN1b6S654u5CU/nMFVpBIgvwkoPArLgMqLxybNnZ4i7z5zJ1R3Cr6OzRX5vGD8jUD2gsiN1/cp0m8HMzXAEx0+VDt8XINgILq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V6b0eDAo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YlLwh0y3dMds1+Rvwn4vnDOcZEXYdFFUtK9ETS2UId8=; b=V6b0eDAoiWAbD7Zbbh/q5Vc3bX
	3KRNR2AXYthgsyxWqC7yshEGyTdAMO2JrWZuhn5sAZvQn7SrPmLN7n0ZKdG9dgGBCfIivGfergeKC
	DdP190YR4mmMTHG4pn9UZ7i2alSoMyrBvL++ozaI3e7zgObbPkL0iw9A/OeJg8A0u9iRzrTVZEgbe
	91HxYYl2GIF/hmg/JOLskIEvqgFlKhuwMrH1oNqEUtV20A68f1ukWatTETIqeJ4iiAF6lUWvbLtIz
	ikmW7eDrgNa+loFnPvX3lmPlY+7wcsPXkS9gIc3r7uVE7+6dp26d7yPvVb7XADlHrhBU9qcG94Up+
	iFzDl6tw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAnky-0000000ECta-2DFi;
	Tue, 12 Nov 2024 10:04:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF904300478; Tue, 12 Nov 2024 11:04:19 +0100 (CET)
Date: Tue, 12 Nov 2024 11:04:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Oskolkov <posk@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Florian Weimer <fweimer@redhat.com>,
	Carlos O'Donell <carlos@redhat.com>, DJ Delorie <dj@redhat.com>,
	libc-alpha@sourceware.org
Subject: Re: [PATCH v1 1/1] rseq: Validate read-only fields under DEBUG_RSEQ
 config
Message-ID: <20241112100419.GN22801@noisy.programming.kicks-ass.net>
References: <20241111192214.1988000-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111192214.1988000-1-mathieu.desnoyers@efficios.com>

On Mon, Nov 11, 2024 at 02:22:14PM -0500, Mathieu Desnoyers wrote:

So I'm entirely agreeing with the intent, but perhaps we can argue a
little on the implementation :-)

> +#ifdef CONFIG_DEBUG_RSEQ
> +static struct rseq *rseq_kernel_fields(struct task_struct *t)
> +{
> +	return (struct rseq *) t->rseq_fields;
> +}
> +
> +static int rseq_validate_ro_fields(struct task_struct *t)
> +{
> +	u32 cpu_id_start, cpu_id, node_id, mm_cid;
> +	struct rseq __user *rseq = t->rseq;
> +
> +	/*
> +	 * Validate fields which are required to be read-only by
> +	 * user-space.
> +	 */
> +	if (!user_read_access_begin(rseq, t->rseq_len))
> +		goto efault;
> +	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
> +	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
> +	unsafe_get_user(node_id, &rseq->node_id, efault_end);
> +	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
> +	user_read_access_end();
> +
> +	if (cpu_id_start != rseq_kernel_fields(t)->cpu_id_start)
> +		printk_ratelimited(KERN_WARNING
> +			"Detected rseq cpu_id_start field corruption. Value: %u, expecting: %u (pid=%d).\n",
> +			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start, t->pid);
> +	if (cpu_id != rseq_kernel_fields(t)->cpu_id)
> +		printk_ratelimited(KERN_WARNING
> +			"Detected rseq cpu_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
> +			cpu_id, rseq_kernel_fields(t)->cpu_id, t->pid);
> +	if (node_id != rseq_kernel_fields(t)->node_id)
> +		printk_ratelimited(KERN_WARNING
> +			"Detected rseq node_id field corruption. Value: %u, expecting: %u (pid=%d).\n",
> +			node_id, rseq_kernel_fields(t)->node_id, t->pid);
> +	if (mm_cid != rseq_kernel_fields(t)->mm_cid)
> +		printk_ratelimited(KERN_WARNING
> +			"Detected rseq mm_cid field corruption. Value: %u, expecting: %u (pid=%d).\n",
> +			mm_cid, rseq_kernel_fields(t)->mm_cid, t->pid);

So aside from this just being ugly, this also has the problem of getting
the ratelimits out of sync and perhaps only showing partial corruption
for any one task. 

Completely untested hackery below.

> @@ -423,6 +504,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>  	current->rseq = rseq;
>  	current->rseq_len = rseq_len;
>  	current->rseq_sig = sig;
> +#ifdef CONFIG_DEBUG_RSEQ
> +	/*
> +	 * Initialize the in-kernel rseq fields copy for validation of
> +	 * read-only fields.
> +	 */
> +	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
> +	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
> +	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
> +	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
> +		return -EFAULT;
> +#endif

So I didn't change the above, but wouldn't it make more sense to do
rseq_reset_rseq_cpu_node_id() here, but without the validation?

---
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1364,6 +1364,15 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+# ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * This is a place holder to save a copy of the rseq fields for
+	 * validation of read-only fields. The struct rseq has a
+	 * variable-length array at the end, so it cannot be used
+	 * directly. Reserve a size large enough for the known fields.
+	 */
+	char 				rseq_fields[sizeof(struct rseq)];
+# endif
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -25,6 +25,79 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+#ifdef CONFIG_DEBUG_RSEQ
+static struct rseq *rseq_kernel_fields(struct task_struct *t)
+{
+	return (struct rseq *) t->rseq_fields;
+}
+
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	static DEFINE_RATELIMIT_STATE(_rs,
+				      DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	u32 cpu_id_start, cpu_id, node_id, mm_cid;
+	struct rseq __user *rseq = t->rseq;
+
+	/*
+	 * Validate fields which are required to be read-only by
+	 * user-space.
+	 */
+	if (!user_read_access_begin(rseq, t->rseq_len))
+		goto efault;
+	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
+	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
+	unsafe_get_user(node_id, &rseq->node_id, efault_end);
+	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
+	user_read_access_end();
+
+	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
+	     cpu_id != rseq_kernel_fields(t)->cpu_id ||
+	     node_id != rseq_kernel_fields(t)->node_id ||
+	     mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
+
+		pr_warn("Detected rseq corruption for pid: %d;\n"
+			"  cpu_id_start: %u ?= %u\n"
+			"  cpu_id:       %u ?= %u\n"
+			"  node_id:      %u ?= %u\n"
+			"  mm_cid:       %u ?= %u\n"
+			t->pid,
+			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
+			cpu_id, rseq_kernel_fields(t)->cpu_id,
+			node_id, rseq_kernel_fields(t)->node_id,
+			mm_cid, rseq_kernel_fields(t)->mm_cid);
+	}
+
+	/* For now, only print a console warning on mismatch. */
+	return 0;
+
+efault_end:
+	user_read_access_end();
+efault:
+	return -EFAULT;
+}
+
+static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
+			       u32 node_id, u32 mm_cid)
+{
+	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
+	rseq_kernel_fields(t)->cpu_id = cpu_id;
+	rseq_kernel_fields(t)->node_id = node_id;
+	rseq_kernel_fields(t)->mm_cid = mm_cid;
+}
+
+#else
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	return 0;
+}
+
+static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
+			       u32 node_id, u32 mm_cid)
+{
+}
+#endif
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -92,6 +165,11 @@ static int rseq_update_cpu_node_id(struc
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
 
+	/*
+	 * Validate read-only rseq fields.
+	 */
+	if (rseq_validate_ro_fields(t))
+		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
@@ -105,6 +183,7 @@ static int rseq_update_cpu_node_id(struc
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
+	rseq_set_ro_fields(t, cpu_id, cpu_id, node_id, mm_cid);
 	trace_rseq_update(t);
 	return 0;
 
@@ -120,6 +199,11 @@ static int rseq_reset_rseq_cpu_node_id(s
 	    mm_cid = 0;
 
 	/*
+	 * Validate read-only rseq fields.
+	 */
+	if (!rseq_validate_ro_fields(t))
+		return -EFAULT;
+	/*
 	 * Reset cpu_id_start to its initial state (0).
 	 */
 	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
@@ -141,6 +225,9 @@ static int rseq_reset_rseq_cpu_node_id(s
 	 */
 	if (put_user(mm_cid, &t->rseq->mm_cid))
 		return -EFAULT;
+
+	rseq_set_ro_fields(t, cpu_id_start, cpu_id, node_id, mm_cid);
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -423,6 +510,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
+#ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * Initialize the in-kernel rseq fields copy for validation of
+	 * read-only fields.
+	 */
+	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
+	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
+	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
+	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
+		return -EFAULT;
+#endif
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields

