Return-Path: <linux-kernel+bounces-515987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F6EA36BB4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304C53B22A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BE16CD1D;
	Sat, 15 Feb 2025 03:43:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CB155308;
	Sat, 15 Feb 2025 03:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591031; cv=none; b=cHAK/FLvF6Ha5oayuinixWQQpbWER0jldkeaT1/PrtsMp5JnNootWdCDM3fG93jx/bpcjt9qvGzEDVr70n8rysawtqk9hfyRq5v9canU+dI4Yr1pucbUtHqmZdA40CntFdg/Mb+mZiFIjmA14uumb6jmxdMnUxLv/ZgL3sAAPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591031; c=relaxed/simple;
	bh=Tn2lOle0ag6owIdPD8+uGiFuZDKAEyNygQQ3TGSMXg4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=T5Jd+pzpsl4CWsmyxs/DLsPYu/yFoXUUCP2vkTjjWIKCHNUjrfa6Ze0QVT8/YkpwEffiTmfW/gAAG4VDxtaqoqYRnIPLt8fBC4lc7ZpispYTa+7gfgy84n/s1QXhcOtAlsdVzk/2knUdbK/IbfLwdFlZ9MEL1tILvdjl8HZtX7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83623C4CEE5;
	Sat, 15 Feb 2025 03:43:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj964-00000002guM-1YFY;
	Fri, 14 Feb 2025 22:44:04 -0500
Message-ID: <20250215034404.219446232@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:43:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/8] ring-buffer: Use kaslr address instead of text delta
References: <20250215034301.624019422@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of saving off the text and data pointers and using them to compare
with the current boot's text and data pointers, just save off the KASLR
offset. Then that can be used to figure out how to read the previous boots
buffer.

The last_boot_info will now show this offset, but only if it is for a
previous boot:

  ~# cat instances/boot_mapped/last_boot_info
  39000000	[kernel]

  ~# echo function > instances/boot_mapped/current_tracer
  ~# cat instances/boot_mapped/last_boot_info
  # Current

If the KASLR offset saved is for the current boot, the last_boot_info will
show the value of "current".

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  3 +--
 kernel/trace/ring_buffer.c  | 31 ++++++++++++-------------------
 kernel/trace/trace.c        | 30 +++++++++++++++++++++---------
 kernel/trace/trace.h        |  9 +++++----
 4 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 17fbb7855295..8de035f4f0d9 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -94,8 +94,7 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
 					       unsigned long range_size,
 					       struct lock_class_key *key);
 
-bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
-				 long *data);
+bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr);
 
 /*
  * Because the ring buffer is generic, if other users of the ring buffer get
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 87caf9d48edb..1bf1228caf0e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -31,6 +31,7 @@
 
 #include <asm/local64.h>
 #include <asm/local.h>
+#include <asm/setup.h>
 
 #include "trace.h"
 
@@ -49,8 +50,7 @@ static void update_pages_handler(struct work_struct *work);
 struct ring_buffer_meta {
 	int		magic;
 	int		struct_size;
-	unsigned long	text_addr;
-	unsigned long	data_addr;
+	unsigned long	kaslr_addr;
 	unsigned long	first_buffer;
 	unsigned long	head_buffer;
 	unsigned long	commit_buffer;
@@ -550,8 +550,7 @@ struct trace_buffer {
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
 
-	long				last_text_delta;
-	long				last_data_delta;
+	unsigned long			kaslr_addr;
 
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
@@ -1891,16 +1890,13 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
-/* Used to calculate data delta */
-static char rb_data_ptr[] = "";
-
-#define THIS_TEXT_PTR		((unsigned long)rb_meta_init_text_addr)
-#define THIS_DATA_PTR		((unsigned long)rb_data_ptr)
-
 static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 {
-	meta->text_addr = THIS_TEXT_PTR;
-	meta->data_addr = THIS_DATA_PTR;
+#ifdef CONFIG_RANDOMIZE_BASE
+	meta->kaslr_addr = kaslr_offset();
+#else
+	meta->kaslr_addr = 0;
+#endif
 }
 
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
@@ -1928,8 +1924,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
-			buffer->last_text_delta = THIS_TEXT_PTR - meta->text_addr;
-			buffer->last_data_delta = THIS_DATA_PTR - meta->data_addr;
+			buffer->kaslr_addr = meta->kaslr_addr;
 			continue;
 		}
 
@@ -2482,17 +2477,15 @@ struct trace_buffer *__ring_buffer_alloc_range(unsigned long size, unsigned flag
  *
  * Returns: The true if the delta is non zero
  */
-bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, long *text,
-				 long *data)
+bool ring_buffer_last_boot_delta(struct trace_buffer *buffer, unsigned long *kaslr_addr)
 {
 	if (!buffer)
 		return false;
 
-	if (!buffer->last_text_delta)
+	if (!buffer->kaslr_addr)
 		return false;
 
-	*text = buffer->last_text_delta;
-	*data = buffer->last_data_delta;
+	*kaslr_addr = buffer->kaslr_addr;
 
 	return true;
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 25ff37aab00f..41d463e5327c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -50,7 +50,7 @@
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
 
-#include <asm/setup.h> /* COMMAND_LINE_SIZE */
+#include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
 #include "trace.h"
 #include "trace_output.h"
@@ -4193,7 +4193,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 		 * safe to use if the array has delta offsets
 		 * Force printing via the fields.
 		 */
-		if ((tr->text_delta || tr->data_delta) &&
+		if ((tr->text_delta) &&
 		    event->type > __TRACE_LAST_TYPE)
 			return print_event_fields(iter, event);
 
@@ -5990,7 +5990,7 @@ ssize_t tracing_resize_ring_buffer(struct trace_array *tr,
 
 static void update_last_data(struct trace_array *tr)
 {
-	if (!tr->text_delta && !tr->data_delta)
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return;
 
 	/*
@@ -6003,7 +6003,8 @@ static void update_last_data(struct trace_array *tr)
 
 	/* Using current data now */
 	tr->text_delta = 0;
-	tr->data_delta = 0;
+
+	tr->flags &= ~TRACE_ARRAY_FL_LAST_BOOT;
 }
 
 /**
@@ -6821,8 +6822,17 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
 
 	seq_buf_init(&seq, buf, 64);
 
-	seq_buf_printf(&seq, "text delta:\t%ld\n", tr->text_delta);
-	seq_buf_printf(&seq, "data delta:\t%ld\n", tr->data_delta);
+	/*
+	 * Do not leak KASLR address. This only shows the KASLR address of
+	 * the last boot. When the ring buffer is started, the LAST_BOOT
+	 * flag gets cleared, and this should only report "current".
+	 * Otherwise it shows the KASLR address from the previous boot which
+	 * should not be the same as the current boot.
+	 */
+	if (tr->flags & TRACE_ARRAY_FL_LAST_BOOT)
+		seq_buf_printf(&seq, "%lx\t[kernel]\n", tr->kaslr_addr);
+	else
+		seq_buf_puts(&seq, "# Current\n");
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
 }
@@ -9206,8 +9216,10 @@ allocate_trace_buffer(struct trace_array *tr, struct array_buffer *buf, int size
 						      tr->range_addr_start,
 						      tr->range_addr_size);
 
-		ring_buffer_last_boot_delta(buf->buffer,
-					    &tr->text_delta, &tr->data_delta);
+#ifdef CONFIG_RANDOMIZE_BASE
+		if (ring_buffer_last_boot_delta(buf->buffer, &tr->kaslr_addr))
+			tr->text_delta = kaslr_offset() - tr->kaslr_addr;
+#endif
 		/*
 		 * This is basically the same as a mapped buffer,
 		 * with the same restrictions.
@@ -10455,7 +10467,7 @@ __init static void enable_instances(void)
 		 * to it.
 		 */
 		if (start) {
-			tr->flags |= TRACE_ARRAY_FL_BOOT;
+			tr->flags |= TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT;
 			tr->ref++;
 		}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..abe8169c3e87 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,8 +348,8 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	unsigned long		kaslr_addr;
 	long			text_delta;
-	long			data_delta;
 
 	struct trace_pid_list	__rcu *filtered_pids;
 	struct trace_pid_list	__rcu *filtered_no_pids;
@@ -433,9 +433,10 @@ struct trace_array {
 };
 
 enum {
-	TRACE_ARRAY_FL_GLOBAL	= BIT(0),
-	TRACE_ARRAY_FL_BOOT	= BIT(1),
-	TRACE_ARRAY_FL_MOD_INIT	= BIT(2),
+	TRACE_ARRAY_FL_GLOBAL		= BIT(0),
+	TRACE_ARRAY_FL_BOOT		= BIT(1),
+	TRACE_ARRAY_FL_LAST_BOOT	= BIT(2),
+	TRACE_ARRAY_FL_MOD_INIT		= BIT(3),
 };
 
 #ifdef CONFIG_MODULES
-- 
2.47.2



