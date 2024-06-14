Return-Path: <linux-kernel+bounces-215254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C6909055
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2520BB21F95
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CE619EEBD;
	Fri, 14 Jun 2024 16:30:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD49195B04
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382649; cv=none; b=NQX5BKL/O5eda2XTrcxsCRjUA45H0pG+gXlZw3k3P8jT0ksP0jSylcaeSG2p1tw8NZ8ChmzbWsPLy5yPdmjR3YsuWUng7dkQ6nOsK1U0E6lYndNbwmw9dQFVfdfmlt7+MGXUG48hFdVzvTvxOpt+hs06Wj1ZQEyFwZsYyWB6Tuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382649; c=relaxed/simple;
	bh=ffDMNay5V4HCQNkyqfXkxcR32rvFhwWt7bVdmaqOd6M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ji3/NfSGw0c/AkTnPEqyARFywYqVlgVfKETPTgessXor4CLF764kl+lg8qIn4UIVVLorkpuoXFtsK91LNOPKFpnZ5RGXEC0JS5DRjW8xly++WCH4GdYvA2JOa48I2PX4lI+wwQvFhO/gCoDGhaJ/Uz3uei8hJ6VUww0NcAqnlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6854EC4DDEA;
	Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pX-00000001rsP-1u2O;
	Fri, 14 Jun 2024 12:31:11 -0400
Message-ID: <20240614163111.310579196@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:22 -0400
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
Subject: [for-next][PATCH 07/13] ring-buffer: Validate boot range memory events
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Make sure all the events in each of the sub-buffers that were mapped in a
memory region are valid. This moves the code that walks the buffers for
time-stamp validation out of the CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS
ifdef block and is used to validate the content. Only the ring buffer
event meta data and time stamps are checked and not the data load.

This also has a second purpose. The buffer_page structure that points to
the data sub-buffers has accounting that keeps track of the number of
events that are on the sub-buffer. This updates that counter as well. That
counter is used in reading the buffer and knowing if the ring buffer is
empty or not.

Link: https://lkml.kernel.org/r/20240612232026.172503570@goodmis.org

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
 kernel/trace/ring_buffer.c | 190 +++++++++++++++++++++++++++++--------
 1 file changed, 152 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 588bc057bad7..804dfbdeef84 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1675,10 +1675,152 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 		subbuf = (void *)subbuf + subbuf_size;
 	}
 
-	pr_info("Ring buffer meta is from previous boot!\n");
 	return true;
 }
 
+static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf);
+
+static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu,
+			       unsigned long long *timestamp, u64 *delta_ptr)
+{
+	struct ring_buffer_event *event;
+	u64 ts, delta;
+	int events = 0;
+	int e;
+
+	*delta_ptr = 0;
+	*timestamp = 0;
+
+	ts = dpage->time_stamp;
+
+	for (e = 0; e < tail; e += rb_event_length(event)) {
+
+		event = (struct ring_buffer_event *)(dpage->data + e);
+
+		switch (event->type_len) {
+
+		case RINGBUF_TYPE_TIME_EXTEND:
+			delta = rb_event_time_stamp(event);
+			ts += delta;
+			break;
+
+		case RINGBUF_TYPE_TIME_STAMP:
+			delta = rb_event_time_stamp(event);
+			delta = rb_fix_abs_ts(delta, ts);
+			if (delta < ts) {
+				*delta_ptr = delta;
+				*timestamp = ts;
+				return -1;
+			}
+			ts = delta;
+			break;
+
+		case RINGBUF_TYPE_PADDING:
+			if (event->time_delta == 1)
+				break;
+			fallthrough;
+		case RINGBUF_TYPE_DATA:
+			events++;
+			ts += event->time_delta;
+			break;
+
+		default:
+			return -1;
+		}
+	}
+	*timestamp = ts;
+	return events;
+}
+
+static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu)
+{
+	unsigned long long ts;
+	u64 delta;
+	int tail;
+
+	tail = local_read(&dpage->commit);
+	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
+}
+
+/* If the meta data has been validated, now validate the events */
+static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
+{
+	struct ring_buffer_meta *meta = cpu_buffer->ring_meta;
+	struct buffer_page *head_page;
+	unsigned long entry_bytes = 0;
+	unsigned long entries = 0;
+	int ret;
+	int i;
+
+	if (!meta || !meta->head_buffer)
+		return;
+
+	/* Do the reader page first */
+	ret = rb_validate_buffer(cpu_buffer->reader_page->page, cpu_buffer->cpu);
+	if (ret < 0) {
+		pr_info("Ring buffer reader page is invalid\n");
+		goto invalid;
+	}
+	entries += ret;
+	entry_bytes += local_read(&cpu_buffer->reader_page->page->commit);
+	local_set(&cpu_buffer->reader_page->entries, ret);
+
+	head_page = cpu_buffer->head_page;
+
+	/* If both the head and commit are on the reader_page then we are done. */
+	if (head_page == cpu_buffer->reader_page &&
+	    head_page == cpu_buffer->commit_page)
+		goto done;
+
+	/* Iterate until finding the commit page */
+	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_inc_page(&head_page)) {
+
+		/* Reader page has already been done */
+		if (head_page == cpu_buffer->reader_page)
+			continue;
+
+		ret = rb_validate_buffer(head_page->page, cpu_buffer->cpu);
+		if (ret < 0) {
+			pr_info("Ring buffer meta [%d] invalid buffer page\n",
+				cpu_buffer->cpu);
+			goto invalid;
+		}
+		entries += ret;
+		entry_bytes += local_read(&head_page->page->commit);
+		local_set(&cpu_buffer->head_page->entries, ret);
+
+		if (head_page == cpu_buffer->commit_page)
+			break;
+	}
+
+	if (head_page != cpu_buffer->commit_page) {
+		pr_info("Ring buffer meta [%d] commit page not found\n",
+			cpu_buffer->cpu);
+		goto invalid;
+	}
+ done:
+	local_set(&cpu_buffer->entries, entries);
+	local_set(&cpu_buffer->entries_bytes, entry_bytes);
+
+	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
+	return;
+
+ invalid:
+	/* The content of the buffers are invalid, reset the meta data */
+	meta->head_buffer = 0;
+	meta->commit_buffer = 0;
+
+	/* Reset the reader page */
+	local_set(&cpu_buffer->reader_page->entries, 0);
+	local_set(&cpu_buffer->reader_page->page->commit, 0);
+
+	/* Reset all the subbuffers */
+	for (i = 0; i < meta->nr_subbufs - 1; i++, rb_inc_page(&head_page)) {
+		local_set(&head_page->entries, 0);
+		local_set(&head_page->page->commit, 0);
+	}
+}
+
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
@@ -1757,8 +1899,6 @@ static void *rbm_next(struct seq_file *m, void *v, loff_t *pos)
 	return rbm_start(m, pos);
 }
 
-static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf);
-
 static int rbm_show(struct seq_file *m, void *v)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = m->private;
@@ -2011,6 +2151,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	if (ret < 0)
 		goto fail_free_reader;
 
+	rb_meta_validate_events(cpu_buffer);
+
 	/* If the boot meta was valid then this has already been updated */
 	meta = cpu_buffer->ring_meta;
 	if (!meta || !meta->head_buffer ||
@@ -3955,11 +4097,10 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 			 struct rb_event_info *info,
 			 unsigned long tail)
 {
-	struct ring_buffer_event *event;
 	struct buffer_data_page *bpage;
 	u64 ts, delta;
 	bool full = false;
-	int e;
+	int ret;
 
 	bpage = info->tail_page->page;
 
@@ -3985,39 +4126,12 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	if (atomic_inc_return(this_cpu_ptr(&checking)) != 1)
 		goto out;
 
-	ts = bpage->time_stamp;
-
-	for (e = 0; e < tail; e += rb_event_length(event)) {
-
-		event = (struct ring_buffer_event *)(bpage->data + e);
-
-		switch (event->type_len) {
-
-		case RINGBUF_TYPE_TIME_EXTEND:
-			delta = rb_event_time_stamp(event);
-			ts += delta;
-			break;
-
-		case RINGBUF_TYPE_TIME_STAMP:
-			delta = rb_event_time_stamp(event);
-			delta = rb_fix_abs_ts(delta, ts);
-			if (delta < ts) {
-				buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
-						   cpu_buffer->cpu, ts, delta);
-			}
-			ts = delta;
-			break;
-
-		case RINGBUF_TYPE_PADDING:
-			if (event->time_delta == 1)
-				break;
-			fallthrough;
-		case RINGBUF_TYPE_DATA:
-			ts += event->time_delta;
-			break;
-
-		default:
-			RB_WARN_ON(cpu_buffer, 1);
+	ret = rb_read_data_buffer(bpage, tail, cpu_buffer->cpu, &ts, &delta);
+	if (ret < 0) {
+		if (delta < ts) {
+			buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
+					   cpu_buffer->cpu, ts, delta);
+			goto out;
 		}
 	}
 	if ((full && ts > info->ts) ||
-- 
2.43.0



