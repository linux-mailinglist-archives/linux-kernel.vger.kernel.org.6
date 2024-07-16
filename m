Return-Path: <linux-kernel+bounces-254383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2E93329E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087C01C20B30
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC657C8E;
	Tue, 16 Jul 2024 20:04:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B628DD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160265; cv=none; b=QbNin1wQJQgM9U0bgetgqO3kmGOUlF7IU9/7EPl5WlEL494d5cHLCk8+iLQ8IrY71RrqtEcUT6ZNrr9HCbslJu6qqmV/6r/0DQNj/ZGVfHOSMNehbQEICmrPNgNJwLC9sDqcC9viLir75LVXpeEZLi2XnRpAI2l1chuW9W2CfmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160265; c=relaxed/simple;
	bh=PM8euHqYg3FSysA8yMP8pFLKBHaSRdNDDir6kgSneX8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bs4zTxVc1WjHvPJbaEW5iGpSTXPiDT2BLeiZXz94Cwy+Q/saEx4LcZgcbcWW/pXIp5BO4oIsARjr30AnQ8BmZYGEgZGoRm+TSQC0ZOv6XT0Tjq/0fWfCZKDuQNeQ1lKAWu7ZXzdf36a90tNbYAtzVvMDf0G9K8K6nAJ8RaxGpLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE296C4AF0C;
	Tue, 16 Jul 2024 20:04:22 +0000 (UTC)
Date: Tue, 16 Jul 2024 16:04:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>, Tio Zhang <tiozhang@didiglobal.com>, "levi.yun"
 <yeoreum.yun@arm.com>
Subject: [GIT PULL] tracing: Updates for 6.11
Message-ID: <20240716160421.5586ae41@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

tracing: Trivial updates for 6.11

- Set rtla/osnoise default threshold to 1us from 5us
  The 5us default was missing noise that people cared about.
  Changing it to 1us makes it work as expected.

- Restructure how sched_switch prev_comm and next_comm was being saved.
  The prev_comm was being saved along with the other next fields, and the
  next_comm was being saved along with the other prev fields. This is just
  a cosmetic change.

- Have the allocation of pid_list use GFP_NOWAIT instead of GFP_KERNEL.
  The allocation can happen in irq_work context, but luckily, the size
  was by default so large, it was never triggered. But in case it ever is,
  use the NOWAIT allocation in the interrupt context.

- Fix some kernel doc errors.


Please pull the latest trace-v6.11 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.11

Tag SHA1: 3f602d8bc58b45986419d9885618da57b0ebc15f
Head SHA1: 7dc836187f7c6f70a82b4521503e9f9f96194581


Jeff Johnson (1):
      tracing: Fix trace_pid_list_free() kernel-doc

Luis Claudio R. Goncalves (1):
      rtla/osnoise: set the default threshold to 1us

Tio Zhang (1):
      tracing/sched: sched_switch: place prev_comm and next_comm in right order

levi.yun (1):
      trace/pid_list: Change gfp flags in pid_list_fill_irq()

----
 Documentation/trace/osnoise-tracer.rst | 2 +-
 include/trace/events/sched.h           | 4 ++--
 kernel/trace/pid_list.c                | 5 +++--
 kernel/trace/trace_osnoise.c           | 4 ++--
 4 files changed, 8 insertions(+), 7 deletions(-)
---------------------------
diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 140ef2533d26..a520adbd3476 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
    option.
  - tracing_threshold: the minimum delta between two time() reads to be
    considered as noise, in us. When set to 0, the default value will
-   be used, which is currently 5 us.
+   be used, which is currently 1 us.
  - osnoise/options: a set of on/off options that can be enabled by
    writing the option name to the file or disabled by writing the option
    name preceded with the 'NO\_' prefix. For example, writing
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 6df2b4685b08..9ea4c404bd4e 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -239,11 +239,11 @@ TRACE_EVENT(sched_switch,
 	),
 
 	TP_fast_assign(
-		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
+		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
 		__entry->prev_pid	= prev->pid;
 		__entry->prev_prio	= prev->prio;
 		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
-		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
+		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
 		/* XXX SCHED_DEADLINE */
diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index 95106d02b32d..4966e6bbdf6f 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -354,7 +354,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	while (upper_count-- > 0) {
 		union upper_chunk *chunk;
 
-		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
 		if (!chunk)
 			break;
 		*upper_next = chunk;
@@ -365,7 +365,7 @@ static void pid_list_refill_irq(struct irq_work *iwork)
 	while (lower_count-- > 0) {
 		union lower_chunk *chunk;
 
-		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		chunk = kzalloc(sizeof(*chunk), GFP_NOWAIT);
 		if (!chunk)
 			break;
 		*lower_next = chunk;
@@ -451,6 +451,7 @@ struct trace_pid_list *trace_pid_list_alloc(void)
 
 /**
  * trace_pid_list_free - Frees an allocated pid_list.
+ * @pid_list: The pid list to free.
  *
  * Frees the memory for a pid_list that was allocated.
  */
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a8e28f9b9271..66a871553d4a 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1444,9 +1444,9 @@ static int run_osnoise(void)
 	save_osn_sample_stats(osn_var, &s);
 
 	/*
-	 * if threshold is 0, use the default value of 5 us.
+	 * if threshold is 0, use the default value of 1 us.
 	 */
-	threshold = tracing_thresh ? : 5000;
+	threshold = tracing_thresh ? : 1000;
 
 	/*
 	 * Apply PREEMPT and IRQ disabled options.

