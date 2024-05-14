Return-Path: <linux-kernel+bounces-178935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330DE8C598F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 18:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24511F23836
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922DB181322;
	Tue, 14 May 2024 16:16:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E71802CB
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 16:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703366; cv=none; b=N0NOT9WxmtQRtjXO1IpbcuplGDKioP4sJ4WQ2A4PfZM/IWMJXZ+kFu0KbN8aEk3mpP8JdMPpiIpyHOo9bC7tiqeFzkOS23KuNqe9NmQGOAaojHNI95UQgjv64vl+NULBx1pfHAkf4/r9x2vhAGjzqyvW98B8sVIW/mkCwjJfkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703366; c=relaxed/simple;
	bh=lNDiM/Uq5wrWns/B7nDbmtssx387hZ1a15F9tX0qxgw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rapZwOrOyYLQgGOgQqOKOIFMnxH81ZIPGytMgmb6B2lpdzWMVpLy7JmqTkLio5Wx3XIdoKuACL/JdVd6+uOhLyT6N7KMr3IwkHWCo+bJ9jqyjE6hIrXBVly94Yf+/yjJPYr1rutA6lqK6aaDleVtXcF+q+evAZZA8C2iABbnSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2B5C4AF11;
	Tue, 14 May 2024 16:16:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6upL-00000003tEd-0H8r;
	Tue, 14 May 2024 12:16:31 -0400
Message-ID: <20240514161630.920384249@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:16:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 6/6] ring-buffer: Have mmapped ring buffer keep track of missed events
References: <20240514161558.664348429@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

While testing libtracefs on the mmapped ring buffer, the test that checks
if missed events are accounted for failed when using the mapped buffer.
This is because the mapped page does not update the missed events that
were dropped because the writer filled up the ring buffer before the
reader could catch it.

Add the missed events to the reader page/sub-buffer when the IOCTL is done
and a new reader page is acquired.

Note that all accesses to the reader_page via rb_page_commit() had to be
switched to rb_page_size(), and rb_page_size() which was just a copy of
rb_page_commit() but now it masks out the RB_MISSED bits. This is needed
as the mapped reader page is still active in the ring buffer code and
where it reads the commit field of the bpage for the size, it now must
mask it otherwise the missed bits that are now set will corrupt the size
returned.

Link: https://lore.kernel.org/linux-trace-kernel/20240312175405.12fb6726@gandalf.local.home

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 53 +++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index cb303052bff2..a02c7a52a0f5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -314,6 +314,8 @@ static u64 rb_event_time_stamp(struct ring_buffer_event *event)
 /* Missed count stored at end */
 #define RB_MISSED_STORED	(1 << 30)
 
+#define RB_MISSED_MASK		(3 << 30)
+
 struct buffer_data_page {
 	u64		 time_stamp;	/* page time stamp */
 	local_t		 commit;	/* write committed index */
@@ -2326,7 +2328,7 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 /* Size is determined by what has been committed */
 static __always_inline unsigned rb_page_size(struct buffer_page *bpage)
 {
-	return rb_page_commit(bpage);
+	return rb_page_commit(bpage) & ~RB_MISSED_MASK;
 }
 
 static __always_inline unsigned
@@ -3953,7 +3955,7 @@ static bool rb_per_cpu_empty(struct ring_buffer_per_cpu *cpu_buffer)
 		return true;
 
 	/* Reader should exhaust content in reader page */
-	if (reader->read != rb_page_commit(reader))
+	if (reader->read != rb_page_size(reader))
 		return false;
 
 	/*
@@ -4424,7 +4426,7 @@ int ring_buffer_iter_empty(struct ring_buffer_iter *iter)
 	return ((iter->head_page == commit_page && iter->head >= commit) ||
 		(iter->head_page == reader && commit_page == head_page &&
 		 head_page->read == commit &&
-		 iter->head == rb_page_commit(cpu_buffer->reader_page)));
+		 iter->head == rb_page_size(cpu_buffer->reader_page)));
 }
 EXPORT_SYMBOL_GPL(ring_buffer_iter_empty);
 
@@ -5753,7 +5755,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	event = rb_reader_event(cpu_buffer);
 
 	read = reader->read;
-	commit = rb_page_commit(reader);
+	commit = rb_page_size(reader);
 
 	/* Check if any events were dropped */
 	missed_events = cpu_buffer->lost_events;
@@ -5830,7 +5832,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += rb_page_commit(reader);
+		cpu_buffer->read_bytes += rb_page_size(reader);
 
 		/* swap the pages */
 		rb_init_page(bpage);
@@ -6422,6 +6424,8 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
+	struct buffer_page *reader;
+	unsigned long missed_events;
 	unsigned long reader_size;
 	unsigned long flags;
 
@@ -6448,9 +6452,46 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
-	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
+	reader = rb_get_reader_page(cpu_buffer);
+	if (WARN_ON(!reader))
 		goto out;
 
+	/* Check if any events were dropped */
+	missed_events = cpu_buffer->lost_events;
+
+	if (cpu_buffer->reader_page != cpu_buffer->commit_page) {
+		if (missed_events) {
+			struct buffer_data_page *bpage = reader->page;
+			unsigned int commit;
+			/*
+			 * Use the real_end for the data size,
+			 * This gives us a chance to store the lost events
+			 * on the page.
+			 */
+			if (reader->real_end)
+				local_set(&bpage->commit, reader->real_end);
+			/*
+			 * If there is room at the end of the page to save the
+			 * missed events, then record it there.
+			 */
+			commit = rb_page_size(reader);
+			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+				memcpy(&bpage->data[commit], &missed_events,
+				       sizeof(missed_events));
+				local_add(RB_MISSED_STORED, &bpage->commit);
+			}
+			local_add(RB_MISSED_EVENTS, &bpage->commit);
+		}
+	} else {
+		/*
+		 * There really shouldn't be any missed events if the commit
+		 * is on the reader page.
+		 */
+		WARN_ON_ONCE(missed_events);
+	}
+
+	cpu_buffer->lost_events = 0;
+
 	goto consume;
 
 out:
-- 
2.43.0



