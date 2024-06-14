Return-Path: <linux-kernel+bounces-215246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75974909044
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E262842D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D6D181B83;
	Fri, 14 Jun 2024 16:30:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022E35280
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382647; cv=none; b=cYjwmvRH0liZ3Jw3qX5GvLiIrOCDOtjb8uYM1eIlMicpVevAcZXlEUM3H5bIrFKcyU1XeWA6lahI1YvNKY6l62PvvjfubBeusiB5Nw4BMZ0uLFbKyOmTED9wvGRuGLkDhYK/42WS0GQVTvQNtYxtyiftKhXxCz0C8/okqe4SiN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382647; c=relaxed/simple;
	bh=6RXP7s+1fSEPmeGdjAdu3vzp+mywRk+tKqNadmV1o24=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FZoPdvdP1sGTpUjrTw1w/uyGaRRyRMf5blkme36eRCztQ+RnjulldYVz6RVRPujNH8Ebbxxt8vE5etHUnUlaoKmKK5AQFvAKnTwL8NtIedD+sEPTkXqDYvgpxgiiPnLZeA/bzhkPQ3ArLf2d7wQkEeFgF3ma1eestbMquDDzBfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731DAC32786;
	Fri, 14 Jun 2024 16:30:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sI9pW-00000001rpV-27Ri;
	Fri, 14 Jun 2024 12:31:10 -0400
Message-ID: <20240614163110.367920910@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Jun 2024 12:30:16 -0400
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
Subject: [for-next][PATCH 01/13] ring-buffer: Allow mapped field to be set without mapping
References: <20240614163015.456541709@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation for having the ring buffer mapped to a dedicated location,
which will have the same restrictions as user space memory mapped buffers,
allow it to use the "mapped" field of the ring_buffer_per_cpu structure
without having the user space meta page mapping.

When this starts using the mapped field, it will need to handle adding a
user space mapping (and removing it) from a ring buffer that is using a
dedicated memory range.

Link: https://lkml.kernel.org/r/20240612232025.190908567@goodmis.org

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
 kernel/trace/ring_buffer.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..a240bdc0f2d8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -491,6 +491,7 @@ struct ring_buffer_per_cpu {
 	unsigned long			pages_removed;
 
 	unsigned int			mapped;
+	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
 	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
@@ -5224,6 +5225,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 
+	if (!meta)
+		return;
+
 	meta->reader.read = cpu_buffer->reader_page->read;
 	meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
@@ -5280,7 +5284,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->lost_events = 0;
 	cpu_buffer->last_overrun = 0;
 
-	if (cpu_buffer->mapped)
+	if (cpu_buffer->user_mapped)
 		rb_update_meta_page(cpu_buffer);
 
 	rb_head_page_activate(cpu_buffer);
@@ -6167,7 +6171,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->user_mapped) {
 		mutex_unlock(&cpu_buffer->mapping_lock);
 		return ERR_PTR(-ENODEV);
 	}
@@ -6191,19 +6195,26 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 
 	lockdep_assert_held(&cpu_buffer->mapping_lock);
 
+	/* mapped is always greater or equal to user_mapped */
+	if (WARN_ON(cpu_buffer->mapped < cpu_buffer->user_mapped))
+		return -EINVAL;
+
 	if (inc && cpu_buffer->mapped == UINT_MAX)
 		return -EBUSY;
 
-	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
+	if (WARN_ON(!inc && cpu_buffer->user_mapped == 0))
 		return -EINVAL;
 
 	mutex_lock(&cpu_buffer->buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	if (inc)
+	if (inc) {
+		cpu_buffer->user_mapped++;
 		cpu_buffer->mapped++;
-	else
+	} else {
+		cpu_buffer->user_mapped--;
 		cpu_buffer->mapped--;
+	}
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	mutex_unlock(&cpu_buffer->buffer->mutex);
@@ -6328,7 +6339,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (cpu_buffer->mapped) {
+	if (cpu_buffer->user_mapped) {
 		err = __rb_map_vma(cpu_buffer, vma);
 		if (!err)
 			err = __rb_inc_dec_mapped(cpu_buffer, true);
@@ -6359,12 +6370,15 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	 */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	err = __rb_map_vma(cpu_buffer, vma);
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-		cpu_buffer->mapped = 1;
+		/* This is the first time it is mapped by user */
+		cpu_buffer->mapped++;
+		cpu_buffer->user_mapped = 1;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
 		kfree(cpu_buffer->subbuf_ids);
@@ -6392,10 +6406,10 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->user_mapped) {
 		err = -ENODEV;
 		goto out;
-	} else if (cpu_buffer->mapped > 1) {
+	} else if (cpu_buffer->user_mapped > 1) {
 		__rb_inc_dec_mapped(cpu_buffer, false);
 		goto out;
 	}
@@ -6403,7 +6417,10 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	mutex_lock(&buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	cpu_buffer->mapped = 0;
+	/* This is the last user space mapping */
+	if (!WARN_ON_ONCE(cpu_buffer->mapped < cpu_buffer->user_mapped))
+		cpu_buffer->mapped--;
+	cpu_buffer->user_mapped = 0;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-- 
2.43.0



