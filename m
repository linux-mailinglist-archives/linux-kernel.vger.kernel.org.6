Return-Path: <linux-kernel+bounces-212365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB10905F17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 01:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0410B22E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C026A13049E;
	Wed, 12 Jun 2024 23:20:09 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140212CDB6;
	Wed, 12 Jun 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234407; cv=none; b=Wc2eY9CgDZPQEh21oK8B2yathzqBk8cCfzy0Ta7F0F3XMdIc+0A+/8gYN/kZugS/R3IWuHOC5kR+FD2HC12xT1EH0e4JliWBXaKxxAsaGCreteLbqTMwrLevKv/3zvsJWy2KVGSEsMTWo+nwbDwdqb68Mk3hvKaCeAlWIS/pK0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234407; c=relaxed/simple;
	bh=HMKN/PEsYb5BEHzYeuMsP40Og0l/i3X4MrOw0BDqnsA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CmcuEE0kV6M+bnFfszcjFYPaNknjC1vHd3oXN6fGKYsUlm5GMQ2Rk6n+0GLvmThNJONDqmE004ioaJHatnXU69ZUK9omSfteBeTbJN97Q9BuR5+2/fDgPb9sVP/v3nQb67eeMg79P/5rD1bW6XohD+eRz3IzS3Rv/7irdZ7BAoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55E0C116B1;
	Wed, 12 Jun 2024 23:20:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHXGT-00000001dcS-4ANB;
	Wed, 12 Jun 2024 19:20:25 -0400
Message-ID: <20240612232025.854471446@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 19:19:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
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
Subject: [PATCH v6 05/13] ring-buffer: Add output of ring buffer meta page
References: <20240612231934.608252486@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add a buffer_meta per-cpu file for the trace instance that is mapped to
boot memory. This shows the current meta-data and can be used by user
space tools to record off the current mappings to help reconstruct the
ring buffer after a reboot.

It does not expose any virtual addresses, just indexes into the sub-buffer
pages.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 77 ++++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c       | 30 ++++++++++++++-
 kernel/trace/trace.h       |  2 +
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0e3ed7f1cc5d..25b0e61e8c76 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -32,6 +32,8 @@
 #include <asm/local64.h>
 #include <asm/local.h>
 
+#include "trace.h"
+
 /*
  * The "absolute" timestamp in the buffer is only 59 bits.
  * If a clock has the 5 MSBs set, it needs to be saved and
@@ -1647,6 +1649,81 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 	}
 }
 
+static void *rbm_start(struct seq_file *m, loff_t *pos)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = m->private;
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	unsigned long val;
+
+	if (!meta)
+		return NULL;
+
+	if (*pos > meta->nr_subbufs)
+		return NULL;
+
+	val = *pos;
+	val++;
+
+	return (void *)val;
+}
+
+static void *rbm_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+
+	return rbm_start(m, pos);
+}
+
+static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf);
+
+static int rbm_show(struct seq_file *m, void *v)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = m->private;
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	unsigned long val = (unsigned long)v;
+
+	if (val == 1) {
+		seq_printf(m, "head_buffer:   %d\n",
+			   rb_meta_subbuf_idx(meta, (void *)meta->head_buffer));
+		seq_printf(m, "commit_buffer: %d\n",
+			   rb_meta_subbuf_idx(meta, (void *)meta->commit_buffer));
+		seq_printf(m, "subbuf_size:   %d\n", meta->subbuf_size);
+		seq_printf(m, "nr_subbufs:    %d\n", meta->nr_subbufs);
+		return 0;
+	}
+
+	val -= 2;
+	seq_printf(m, "buffer[%ld]:    %d\n", val, meta->buffers[val]);
+
+	return 0;
+}
+
+static void rbm_stop(struct seq_file *m, void *p)
+{
+}
+
+static const struct seq_operations rb_meta_seq_ops = {
+	.start		= rbm_start,
+	.next		= rbm_next,
+	.show		= rbm_show,
+	.stop		= rbm_stop,
+};
+
+int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, int cpu)
+{
+	struct seq_file *m;
+	int ret;
+
+	ret = seq_open(file, &rb_meta_seq_ops);
+	if (ret)
+		return ret;
+
+	m = file->private_data;
+	m->private = buffer->buffers[cpu];
+
+	return 0;
+}
+
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		long nr_pages, struct list_head *pages)
 {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ff2b504fbe00..622fe670949d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5018,7 +5018,7 @@ static int show_traces_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int show_traces_release(struct inode *inode, struct file *file)
+static int tracing_seq_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
 
@@ -5059,7 +5059,7 @@ static const struct file_operations show_traces_fops = {
 	.open		= show_traces_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= show_traces_release,
+	.release	= tracing_seq_release,
 };
 
 static ssize_t
@@ -6860,6 +6860,22 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
+static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
+{
+	struct trace_array *tr = inode->i_private;
+	int cpu = tracing_get_cpu(inode);
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, cpu);
+	if (ret < 0)
+		__trace_array_put(tr);
+	return ret;
+}
+
 static ssize_t
 tracing_free_buffer_write(struct file *filp, const char __user *ubuf,
 			  size_t cnt, loff_t *ppos)
@@ -7436,6 +7452,13 @@ static const struct file_operations tracing_entries_fops = {
 	.release	= tracing_release_generic_tr,
 };
 
+static const struct file_operations tracing_buffer_meta_fops = {
+	.open		= tracing_buffer_meta_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= tracing_seq_release,
+};
+
 static const struct file_operations tracing_total_entries_fops = {
 	.open		= tracing_open_generic_tr,
 	.read		= tracing_total_entries_read,
@@ -8668,6 +8691,9 @@ tracing_init_tracefs_percpu(struct trace_array *tr, long cpu)
 	trace_create_cpu_file("buffer_size_kb", TRACE_MODE_READ, d_cpu,
 				tr, cpu, &tracing_entries_fops);
 
+	if (tr->range_addr_start)
+		trace_create_cpu_file("buffer_meta", TRACE_MODE_READ, d_cpu,
+				      tr, cpu, &tracing_buffer_meta_fops);
 #ifdef CONFIG_TRACER_SNAPSHOT
 	if (!tr->range_addr_start) {
 		trace_create_cpu_file("snapshot", TRACE_MODE_WRITE, d_cpu,
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5dd48932509c..3e56d3b22212 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -645,6 +645,8 @@ trace_buffer_lock_reserve(struct trace_buffer *buffer,
 			  unsigned long len,
 			  unsigned int trace_ctx);
 
+int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, int cpu);
+
 struct trace_entry *tracing_get_trace_entry(struct trace_array *tr,
 						struct trace_array_cpu *data);
 
-- 
2.43.0



