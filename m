Return-Path: <linux-kernel+bounces-187787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0E8CD87D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EE941C21314
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480531802E;
	Thu, 23 May 2024 16:35:58 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93EAD31
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482157; cv=none; b=Fd+WZIKTxncAikG5G+0Y5RkmM8ySCrAptEquCyd7a9KXc649sgw/UF20NC/0whxTuKO9dNZ3tT9GBDv3GtD64l1cB3rStAjtYSFuD5oqXCLQXnXzEV5gxyFCg2t84GyGDCZXjMw4/q42xbZCDEBQ7JK7XHzb6Q9cLZtYpg6zdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482157; c=relaxed/simple;
	bh=fCiXq2+boRzKiYqs6J/tR0g4gcJzzHcCC9A+1uj9Xh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tOHBl3hDohuOgR8Ioe8zvCqd4wCJCsTYdvualo2/vHDKg9FvTp/3LmH+Pk3ouzq26L9xb1IJq1EsZkOpGIaZmk4lsb5oNfrNC7GWMQ/vQmf+69GpNj0KeHTwzq2qWi5v74lKn/Jrht98+zi2v+7+rt30okHmIv3SDfOer6uXZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6351CC2BD10;
	Thu, 23 May 2024 16:35:56 +0000 (UTC)
Date: Thu, 23 May 2024 12:36:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Yang Li <yang.lee@linux.alibaba.com>
Subject: [GIT PULL] tracing: Small last minute fixes
Message-ID: <20240523123640.0316a063@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing: Minor last minute fixes

- Fix a very tight race between the ring buffer readers and resizing
  the ring buffer.

- Correct some stale comments in the ring buffer code.

- Fix kernel-doc in the rv code.

- Add a MODULE_DESCRIPTION to preemptirq_delay_test


Please pull the latest trace-fixes-v6.10 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-fixes-v6.10

Tag SHA1: 53ad9da2f490bc02e45f44bc2a33d4c3b6b78c6b
Head SHA1: 1e8b7b3dbb3103d577a586ca72bc329f7b67120b


Jeff Johnson (1):
      tracing: Add MODULE_DESCRIPTION() to preemptirq_delay_test

Petr Pavlu (2):
      ring-buffer: Correct stale comments related to non-consuming readers
      ring-buffer: Fix a race between readers and resize checks

Yang Li (1):
      rv: Update rv_en(dis)able_monitor doc to match kernel-doc

----
 kernel/trace/preemptirq_delay_test.c |  1 +
 kernel/trace/ring_buffer.c           | 25 ++++++++++++-------------
 kernel/trace/rv/rv.c                 |  2 ++
 3 files changed, 15 insertions(+), 13 deletions(-)
---------------------------
diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
index 8c4ffd076162..cb0871fbdb07 100644
--- a/kernel/trace/preemptirq_delay_test.c
+++ b/kernel/trace/preemptirq_delay_test.c
@@ -215,4 +215,5 @@ static void __exit preemptirq_delay_exit(void)
 
 module_init(preemptirq_delay_init)
 module_exit(preemptirq_delay_exit)
+MODULE_DESCRIPTION("Preempt / IRQ disable delay thread to test latency tracers");
 MODULE_LICENSE("GPL v2");
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7345a8b625fb..28853966aa9a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1460,6 +1460,11 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
+ *
+ * Callers of this function need to guarantee that the list of pages doesn't get
+ * modified during the check. In particular, if it's possible that the function
+ * is invoked with concurrent readers which can swap in a new reader page then
+ * the caller should take cpu_buffer->reader_lock.
  */
 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -2210,8 +2215,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
+			unsigned long flags;
+
 			cpu_buffer = buffer->buffers[cpu];
+			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
@@ -5046,13 +5055,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
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
@@ -5139,8 +5144,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_start);
  * ring_buffer_read_finish - finish reading the iterator of the buffer
  * @iter: The iterator retrieved by ring_buffer_start
  *
- * This re-enables the recording to the buffer, and frees the
- * iterator.
+ * This re-enables resizing of the buffer, and frees the iterator.
  */
 void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
@@ -5148,12 +5152,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
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
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 2f68e93fff0b..df0745a42a3f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,6 +245,7 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 
 /**
  * rv_disable_monitor - disable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
@@ -256,6 +257,7 @@ int rv_disable_monitor(struct rv_monitor_def *mdef)
 
 /**
  * rv_enable_monitor - enable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */

