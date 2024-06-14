Return-Path: <linux-kernel+bounces-215255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8866A909049
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC48E2812A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AF19FA93;
	Fri, 14 Jun 2024 16:30:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F6197540
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382649; cv=none; b=mFVwl5ZFv9wtGOqX856laTaA8ZMLFliK/F0nQ+HP2/ddl+tdCcLwU6V+6nPa4gnGvoRzsOxdRVmw8SCf5GlKPhAnvwHeaSJgYf8Z+/+ZK9eSiAg230TYcfIjLFswUqwARXjjirkhNLuCiZSwCP91xrAb/BFJZbUDp75g8jdwQ7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382649; c=relaxed/simple;
	bh=NrGztyQ2fxIxQ20yMarYlwx0m3vGxMYmC4av516Lq4o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EZsLgPIK+M/yUKsvCFVdNtmFQ1FRnd4VFWPi3Uz2DG0YTuTTk21YiZG3edSy3oq0noesJpx8MhITfOPL04jOZhxLUZVnPNBEyTiB9YiulGJJWmPvDxHVwm06oEtw7zn1x7y5EPS+J8ZV9YsSkG4AT1LshENqA2UMnFacalcczzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED9AC4DDFD;
	Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pX-00000001rtu-3vHE;
	Fri, 14 Jun 2024 12:31:11 -0400
Message-ID: <20240614163111.794376049@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:25 -0400
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
Subject: [for-next][PATCH 10/13] tracing/ring-buffer: Add last_boot_info file to boot instance
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If an instance is mapped to memory on boot up, create a new file called
"last_boot_info" that will hold information that can be used to properly
parse the raw data in the ring buffer.

It will export the delta of the addresses for text and data from what it
was from the last boot. It does not expose actually addresses (unless you
knew what the actual address was from the last boot).

The output will look like:

 # cat last_boot_info
 text delta:	-268435456
 data delta:	-268435456

The text and data are kept separate in case they are ever made different.

Link: https://lkml.kernel.org/r/20240612232026.658680738@goodmis.org

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
 include/linux/ring_buffer.h |  3 +++
 kernel/trace/ring_buffer.c  | 23 ++++++++++++++++++
 kernel/trace/trace.c        | 47 ++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h        |  2 ++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index a50b0223b1d3..55de3798a9b9 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -94,6 +94,9 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       unsigned long range_size,
 					       struct lock_class_key *key);
 
+bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
+				 long *data);
+
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
  * traced by ftrace, it can produce lockdep warnings. We need to keep each
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8c287430411d..f3d772461a60 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2396,6 +2396,29 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 	return alloc_buffer(size, flags, order, start, start + range_size, key);
 }
 
+/**
+ * ring_buffer_last_boot_delta - return the delta offset from last boot
+ * @buffer: The buffer to return the delta from
+ * @text: Return text delta
+ * @data: Return data delta
+ *
+ * Returns: The true if the delta is non zero
+ */
+bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
+				 long *data)
+{
+	if (!buffer)
+		return false;
+
+	if (!buffer->last_text_delta)
+		return false;
+
+	*text = buffer->last_text_delta;
+	*data = buffer->last_data_delta;
+
+	return true;
+}
+
 /**
  * ring_buffer_free - free a ring buffer.
  * @buffer: the buffer to free.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dfde26aa3211..dc4eee33d920 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6041,6 +6041,18 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 	return ret;
 }
 
+static void update_last_data(struct trace_array *tr)
+{
+	if (!tr->text_delta && !tr->data_delta)
+		return;
+
+	/* Clear old data */
+	tracing_reset_online_cpus(&tr->array_buffer);
+
+	/* Using current data now */
+	tr->text_delta = 0;
+	tr->data_delta = 0;
+}
 
 /**
  * tracing_update_buffers - used by tracing facility to expand ring buffers
@@ -6058,6 +6070,9 @@ int tracing_update_buffers(struct trace_array *tr)
 	int ret = 0;
 
 	mutex_lock(&trace_types_lock);
+
+	update_last_data(tr);
+
 	if (!tr->ring_buffer_expanded)
 		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
@@ -6113,6 +6128,8 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 
 	mutex_lock(&trace_types_lock);
 
+	update_last_data(tr);
+
 	if (!tr->ring_buffer_expanded) {
 		ret = __tracing_resize_ring_buffer(tr, trace_buf_size,
 						RING_BUFFER_ALL_CPUS);
@@ -6860,6 +6877,21 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
+static ssize_t
+tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	struct seq_buf seq;
+	char buf[64];
+
+	seq_buf_init(&seq, buf, 64);
+
+	seq_buf_printf(&seq, "text delta:\t%ld\n", tr->text_delta);
+	seq_buf_printf(&seq, "data delta:\t%ld\n", tr->data_delta);
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
+}
+
 static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7499,6 +7531,13 @@ static const struct file_operations trace_time_stamp_mode_fops = {
 	.release	= tracing_single_release_tr,
 };
 
+static const struct file_operations last_boot_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= tracing_last_boot_read,
+	.llseek		= generic_file_llseek,
+	.release	= tracing_release_generic_tr,
+};
+
 #ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations snapshot_fops = {
 	.open		= tracing_snapshot_open,
@@ -9242,6 +9281,9 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 		buf->buffer = ring_buffer_alloc_range(size, rb_flags, 0,
 						      tr->range_addr_start,
 						      tr->range_addr_size);
+
+		ring_buffer_last_boot_delta(buf->buffer,
+					    &tr->text_delta, &tr->data_delta);
 		/*
 		 * This is basically the same as a mapped buffer,
 		 * with the same restrictions.
@@ -9751,7 +9793,10 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 		MEM_FAIL(1, "Could not allocate function filter files");
 
 #ifdef CONFIG_TRACER_SNAPSHOT
-	if (!tr->range_addr_start) {
+	if (tr->range_addr_start) {
+		trace_create_file("last_boot_info", TRACE_MODE_READ, d_tracer,
+				  tr, &last_boot_fops);
+	} else {
 		trace_create_file("snapshot", TRACE_MODE_WRITE, d_tracer,
 				  tr, &snapshot_fops);
 	}
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 3e56d3b22212..3dc5c8f14ce9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -347,6 +347,8 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	long			text_delta;
+	long			data_delta;
 
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
-- 
2.43.0



