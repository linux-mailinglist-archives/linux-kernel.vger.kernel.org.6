Return-Path: <linux-kernel+bounces-215249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7AC909045
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39AE1C211C7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B546D1922F8;
	Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC717C20F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382648; cv=none; b=sNPV90+AjJOeTN4qR32MEOjZKK/iRxl8tXXqCGtPOh5/2Q6Qy11TUfBNQHXM1TKdwLYBWwlDvU9AbQ0dHIjCnGNx0Li0GrWDd6xudB6dxQjvxg0mdc2a85SpuYUhbCaCg/JrsrHl7EEvuaGlNT2BGgllxoFgnWwyaImH218RXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382648; c=relaxed/simple;
	bh=31NBALkfn3aOfHpudA5VSY4NumAiBezUCSuJsOGQ3gs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H6dvolGWLjfjLo/2Vcx+MbNgGV4E8Ru0F17iwVIdd2+lusfJijPJbiQ/wLIUfA6arpMotBxsyMi1+U/DcGZ5L3qLkRiyVxneW/sdhGSLT2AaTxSWd1Zv1nETr0ZOp6k9KwNmiE9IjHjB5sNMNPDI+YHkRNirqIfhgekecvsynX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF894C4AF1D;
	Fri, 14 Jun 2024 16:30:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pW-00000001rqx-43mm;
	Fri, 14 Jun 2024 12:31:10 -0400
Message-ID: <20240614163110.829234556@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>
Subject: [for-next][PATCH 04/13] tracing: Implement creating an instance based on a given memory
 region
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow for creating a new instance by passing in an address and size to map
the ring buffer for the instance to.

This will allow features like a pstore memory mapped region to be used for
an tracing instance ring buffer that can be retrieved from one boot to the
next.

Link: https://lkml.kernel.org/r/20240612232025.692086240@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineeth Pillai <vineeth@bitbyteword.org>
Cc: Youssef Esmat <youssefesmat@google.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 50 +++++++++++++++++++++++++++++++++++---------
 kernel/trace/trace.h |  6 +++++-
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 578a49ff5c32..ff2b504fbe00 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4921,6 +4921,11 @@ static int tracing_open(struct inode *inode, struct file *file)
 static bool
 trace_ok_for_array(struct tracer *t, struct trace_array *tr)
 {
+#ifdef CONFIG_TRACER_SNAPSHOT
+	/* arrays with mapped buffer range do not have snapshots */
+	if (tr->range_addr_start && t->use_max_tr)
+		return false;
+#endif
 	return (tr->flags & TRACE_ARRAY_FL_GLOBAL) || t->allow_instances;
 }
 
@@ -8664,11 +8669,13 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 				tr, cpu, &tracing_entries_fops);
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
-				tr, cpu, &snapshot_fops);
+	if (!tr->range_addr_start) {
+		trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
+				      tr, cpu, &snapshot_fops);
 
-	trace_create_cpu_file("snapshot_raw", TRACE_MODE_READ, d_cpu,
-				tr, cpu, &snapshot_raw_fops);
+		trace_create_cpu_file("snapshot_raw", TRACE_MODE_READ, d_cpu,
+				      tr, cpu, &snapshot_raw_fops);
+	}
 #endif
 }
 
@@ -9205,7 +9212,18 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 
 	buf->tr = tr;
 
-	buf->buffer = ring_buffer_alloc(size, rb_flags);
+	if (tr->range_addr_start && tr->range_addr_size) {
+		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
+						      tr->range_addr_start,
+						      tr->range_addr_size);
+		/*
+		 * This is basically the same as a mapped buffer,
+		 * with the same restrictions.
+		 */
+		tr->mapped++;
+	} else {
+		buf->buffer = ring_buffer_alloc(size, rb_flags);
+	}
 	if (!buf->buffer)
 		return -ENOMEM;
 
@@ -9242,6 +9260,10 @@ static int allocate_trace_buffers(struct trace_array *tr, int size)
 		return ret;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
+	/* Fix mapped buffer trace arrays do not have snapshot buffers */
+	if (tr->range_addr_start)
+		return 0;
+
 	ret = allocate_trace_buffer(tr, &tr->max_buffer,
 				    allocate_snapshot ? size : 1);
 	if (MEM_FAIL(ret, "Failed to allocate trace buffer\n")) {
@@ -9342,7 +9364,9 @@ static int trace_array_create_dir(struct trace_array *tr)
 }
 
 static struct trace_array *
-trace_array_create_systems(const char *name, const char *systems)
+trace_array_create_systems(const char *name, const char *systems,
+			   unsigned long range_addr_start,
+			   unsigned long range_addr_size)
 {
 	struct trace_array *tr;
 	int ret;
@@ -9368,6 +9392,10 @@ trace_array_create_systems(const char *name, const char *systems)
 			goto out_free_tr;
 	}
 
+	/* Only for boot up memory mapped ring buffers */
+	tr->range_addr_start = range_addr_start;
+	tr->range_addr_size = range_addr_size;
+
 	tr->trace_flags = global_trace.trace_flags & ~ZEROED_TRACE_FLAGS;
 
 	cpumask_copy(tr->tracing_cpumask, cpu_all_mask);
@@ -9425,7 +9453,7 @@ trace_array_create_systems(const char *name, const char *systems)
 
 static struct trace_array *trace_array_create(const char *name)
 {
-	return trace_array_create_systems(name, NULL);
+	return trace_array_create_systems(name, NULL, 0, 0);
 }
 
 static int instance_mkdir(const char *name)
@@ -9479,7 +9507,7 @@ struct trace_array *trace_array_get_by_name(const char *name, const char *system
 			goto out_unlock;
 	}
 
-	tr = trace_array_create_systems(name, systems);
+	tr = trace_array_create_systems(name, systems, 0, 0);
 
 	if (IS_ERR(tr))
 		tr = NULL;
@@ -9672,8 +9700,10 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 		MEM_FAIL(1, "Could not allocate function filter files");
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
-			  tr, &snapshot_fops);
+	if (!tr->range_addr_start) {
+		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
+				  tr, &snapshot_fops);
+	}
 #endif
 
 	trace_create_file("error_log", TRACE_MODE_WRITE, d_tracer,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 749a182dab48..5dd48932509c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -336,7 +336,6 @@ struct trace_array {
 	bool			allocated_snapshot;
 	spinlock_t		snapshot_trigger_lock;
 	unsigned int		snapshot;
-	unsigned int		mapped;
 	unsigned long		max_latency;
 #ifdef CONFIG_FSNOTIFY
 	struct dentry		*d_max_latency;
@@ -344,6 +343,11 @@ struct trace_array {
 	struct irq_work		fsnotify_irqwork;
 #endif
 #endif
+	/* The below is for memory mapped ring buffer */
+	unsigned int		mapped;
+	unsigned long		range_addr_start;
+	unsigned long		range_addr_size;
+
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
 	/*
-- 
2.43.0



