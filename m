Return-Path: <linux-kernel+bounces-186812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FC18CC997
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80C01F22301
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 23:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04B314B090;
	Wed, 22 May 2024 23:28:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866E1146A76
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 23:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716420509; cv=none; b=XG0ZtiP8E3CLguk1YmC5Nu8DMDQMLzKXPbxKcMmabM6qeaA2vazmFwyzi/U4a/W+VuefZgTgOgfdskn4SgQ5AeAcf66AIPK33HR+wXaSIHeKjzdpqD3/Od8aO5KfG9IzIEX34v5L8vihLr9BndOjYZz24UAK5wXUTasqsunNSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716420509; c=relaxed/simple;
	bh=OvHTuVo5CNzmC5yT47w1NybPjviPFhwuAR1EAyBqFxg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PxGeMkKyk5LmDMXx5BZYqlchTZ6APtd6nNWnGamfzu9K246FjA292ZP8ikq+PE8hyOi4hvFdKO1GJWFxwL+do8PSeIq472hX4MdXIM3o5+0x35h0U9Kmto3EPqve/T5TSAWqRcZCWVg9JQ+vBzKliVEe4mMrg3Za0YbmCfFYfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F10C3277B;
	Wed, 22 May 2024 23:28:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9vOT-00000006QhU-07eG;
	Wed, 22 May 2024 19:29:13 -0400
Message-ID: <20240522232912.893243051@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 19:28:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [for-linus][PATCH 1/4] ring-buffer: Correct stale comments related to non-consuming readers
References: <20240522232851.522913754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Petr Pavlu <petr.pavlu@suse.com>

Adjust the following code documentation:

* Kernel-doc comments for ring_buffer_read_prepare() and
  ring_buffer_read_finish() mention that recording to the ring buffer is
  disabled when the read is active. Remove mention of this restriction
  because it was already lifted in commit 1039221cc278 ("ring-buffer: Do
  not disable recording when there is an iterator").

* Function ring_buffer_read_finish() performs a self-check of the
  ring-buffer by locking cpu_buffer->reader_lock and then calling
  rb_check_pages(). The preceding comment explains that the lock is
  needed because rb_check_pages() clears the HEAD flag required by
  readers which might be running in parallel. Remove this explanation
  because commit 8843e06f67b1 ("ring-buffer: Handle race between
  rb_move_tail and rb_check_pages") simplified the function so it no
  longer resets the mentioned flag. Nonetheless, the lock is still
  needed because a reader swapping a page into the ring buffer can make
  the underlying doubly-linked list temporarily inconsistent.

This is a non-functional change.

Link: https://lore.kernel.org/linux-trace-kernel/20240517134008.24529-2-petr.pavlu@suse.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7345a8b625fb..42227727a49d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5046,13 +5046,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * @flags: gfp flags to use for memory allocation
  *
  * This performs the initial preparations necessary to iterate
- * through the buffer.  Memory is allocated, buffer recording
+ * through the buffer.  Memory is allocated, buffer resizing
  * is disabled, and the iterator pointer is returned to the caller.
  *
- * Disabling buffer recording prevents the reading from being
- * corrupted. This is not a consuming read, so a producer is not
- * expected.
- *
  * After a sequence of ring_buffer_read_prepare calls, the user is
  * expected to make at least one call to ring_buffer_read_prepare_sync.
  * Afterwards, ring_buffer_read_start is invoked to get things going
@@ -5139,8 +5135,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_start);
  * ring_buffer_read_finish - finish reading the iterator of the buffer
  * @iter: The iterator retrieved by ring_buffer_start
  *
- * This re-enables the recording to the buffer, and frees the
- * iterator.
+ * This re-enables resizing of the buffer, and frees the iterator.
  */
 void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
@@ -5148,12 +5143,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 	unsigned long flags;
 
-	/*
-	 * Ring buffer is disabled from recording, here's a good place
-	 * to check the integrity of the ring buffer.
-	 * Must prevent readers from trying to read, as the check
-	 * clears the HEAD page and readers require it.
-	 */
+	/* Use this opportunity to check the integrity of the ring buffer. */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_check_pages(cpu_buffer);
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.43.0



