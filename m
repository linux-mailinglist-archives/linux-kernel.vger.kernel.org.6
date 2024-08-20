Return-Path: <linux-kernel+bounces-293357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3C1957E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAF21C23DED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7D9205E2E;
	Tue, 20 Aug 2024 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OOcJuJhw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BQJwJlre"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8D205E1C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135419; cv=none; b=Ygz4tQtRVc8eO+k1KGBqIR8P3FHkfAyKZKqzwJ/q+UoYm8FZ0R0VuSqL4ek0oVlo9uxhVex+HgitLPPq/a2sXoRyfq76HC07Fp6kT/605QgPSWGvPG9WAhJgGcf80hpyRMM0Z2SmLN0ukjWlFQYldV4OtNJjQ2E5GKHLA1RVmxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135419; c=relaxed/simple;
	bh=4YpwA1ZZHeu7FPUKudcAcTfqn1bSj3WLKHEhlcdreNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iG5xnhjO+LgR1j9+WRDTxE+bCrk4nWv4BxyBfHEKuEi6YLAoCL8kLzYxV8aOvmHT97E1pYD8AzDW9aspOYFF1Xzv0RMWJ6Nh/APgwmEyeXeDVpUjOH1yielRqlSNRpL4FMYy2W8uFVN1Dfhk1n6V9sYZwpZQl90w59jZVK2BZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OOcJuJhw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BQJwJlre; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724135415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpXkZeLTtTOfmzNsI9WbmA2RmHcpcGMsJkUuhGdxcTc=;
	b=OOcJuJhwS42cqbrxkdIGRhwjuaMBmBmS/RphsPt07zXItGtNOhV6r7b5vr//CV4htoEiMS
	m7dz8v4dDl0tpaGOsx891Vyx386oHgwnxfnTttRALzLZeRZ6AkaFQV6b5GDYdp2jnWYgxf
	ajRIRtGbmB12nUwZlSdTfCzIeib+JaHwwExiinJj0mYwalCoqm+Qw/NIYmHI+JpK8UhugV
	XYple/L5jiH2dSmQHcMx00j+KMu1vXgDTaMMA/psrnLveMMsdUC9ji4bKS33I5NYBw1hTN
	Jp1GRcK9UnUN3Kj1yEddGzTBx2ORIg4fKpiTKEVXeKdhEp50mT95/+UowJyy0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724135415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QpXkZeLTtTOfmzNsI9WbmA2RmHcpcGMsJkUuhGdxcTc=;
	b=BQJwJlrenUBhYmLjqaDgJvrKap+iN2FSIOohxrxO+Rfcka+yeMgWdadOd2vXxY9PLtLmIQ
	lQ1gvHXjMHsPWMBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v8 31/35] printk: nbcon: Implement emergency sections
Date: Tue, 20 Aug 2024 08:35:57 +0206
Message-Id: <20240820063001.36405-32-john.ogness@linutronix.de>
In-Reply-To: <20240820063001.36405-1-john.ogness@linutronix.de>
References: <20240820063001.36405-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

In emergency situations (something has gone wrong but the
system continues to operate), usually important information
(such as a backtrace) is generated via printk(). This
information should be pushed out to the consoles ASAP.

Add per-CPU emergency nesting tracking because an emergency
can arise while in an emergency situation.

Add functions to mark the beginning and end of emergency
sections where the urgent messages are generated.

Perform direct console flushing at the emergency priority if
the current CPU is in an emergency state and it is safe to do
so.

Note that the emergency state is not system-wide. While one CPU
is in an emergency state, another CPU may attempt to print
console messages at normal priority.

Also note that printk() already attempts to flush consoles in
the caller context for normal priority. However, follow-up
changes will introduce printing kthreads, in which case the
normal priority printk() calls will offload to the kthreads.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h  |  4 +++
 kernel/printk/internal.h |  1 +
 kernel/printk/nbcon.c    | 75 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 3706f944de46..9a13f91b0c43 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -553,10 +553,14 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
+extern void nbcon_cpu_emergency_enter(void);
+extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
 #else
+static inline void nbcon_cpu_emergency_enter(void) { }
+static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index ba2e0f1940bd..8e36d8695f81 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -182,6 +182,7 @@ static inline void printk_get_console_flush_type(struct console_flush_type *ft)
 
 	switch (nbcon_get_default_prio()) {
 	case NBCON_PRIO_NORMAL:
+	case NBCON_PRIO_EMERGENCY:
 		if (have_nbcon_console && !have_boot_console)
 			ft->nbcon_atomic = true;
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 18488d6c17c0..92ac5c590927 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -972,6 +972,36 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
 	return nbcon_context_exit_unsafe(ctxt);
 }
 
+/* Track the nbcon emergency nesting per CPU. */
+static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
+static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
+
+/**
+ * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
+ *
+ * Context:	For reading, any context. For writing, any context which could
+ *		not be migrated to another CPU.
+ * Return:	Either a pointer to the per CPU emergency nesting counter of
+ *		the current CPU or to the init data during early boot.
+ *
+ * The function is safe for reading per-CPU variables in any context because
+ * preemption is disabled if the current CPU is in the emergency state. See
+ * also nbcon_cpu_emergency_enter().
+ */
+static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
+{
+	/*
+	 * The value of __printk_percpu_data_ready gets set in normal
+	 * context and before SMP initialization. As a result it could
+	 * never change while inside an nbcon emergency section.
+	 */
+	if (!printk_percpu_data_ready())
+		return &early_nbcon_pcpu_emergency_nesting;
+
+	/* Open code this_cpu_ptr() without checking migration. */
+	return per_cpu_ptr(&nbcon_pcpu_emergency_nesting, raw_smp_processor_id());
+}
+
 /**
  * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
  *				printing on the current CPU
@@ -981,13 +1011,20 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
  *		context for printing.
  *
  * The function is safe for reading per-CPU data in any context because
- * preemption is disabled if the current CPU is in the panic state.
+ * preemption is disabled if the current CPU is in the emergency or panic
+ * state.
  */
 enum nbcon_prio nbcon_get_default_prio(void)
 {
+	unsigned int *cpu_emergency_nesting;
+
 	if (this_cpu_in_panic())
 		return NBCON_PRIO_PANIC;
 
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	if (*cpu_emergency_nesting)
+		return NBCON_PRIO_EMERGENCY;
+
 	return NBCON_PRIO_NORMAL;
 }
 
@@ -1246,6 +1283,42 @@ void nbcon_atomic_flush_unsafe(void)
 	__nbcon_atomic_flush_pending(prb_next_reserve_seq(prb), true);
 }
 
+/**
+ * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
+ *				messages for that CPU are flushed directly
+ *
+ * Context:	Any context. Disables preemption.
+ *
+ * When within an emergency section, printk() calls will attempt to flush any
+ * pending messages in the ringbuffer.
+ */
+void nbcon_cpu_emergency_enter(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	preempt_disable();
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	(*cpu_emergency_nesting)++;
+}
+
+/**
+ * nbcon_cpu_emergency_exit - Exit an emergency section
+ *
+ * Context:	Within an emergency section. Enables preemption.
+ */
+void nbcon_cpu_emergency_exit(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+
+	if (!WARN_ON_ONCE(*cpu_emergency_nesting == 0))
+		(*cpu_emergency_nesting)--;
+
+	preempt_enable();
+}
+
 /**
  * nbcon_alloc - Allocate and init the nbcon console specific data
  * @con:	Console to initialize
-- 
2.39.2


