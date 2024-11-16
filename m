Return-Path: <linux-kernel+bounces-411753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0059CFF31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D361F22CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0091EAFA;
	Sat, 16 Nov 2024 13:53:14 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494542F29
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731765194; cv=none; b=GQ00odWzARR7YYTx3irn5972XO0hcy8ohZIDiqqUVCdP+dTc5SNcYt9XaGbABZUj1aY3tMg76LYwqyYei3tLcNnNiE7jcI/VLxTML7r+IXA8IHPAty6e4RWQdNMRT/+GEzQLgD1XA9RjP4O/gLpErd/sZ1OBWdQLWWEWja6Di8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731765194; c=relaxed/simple;
	bh=rc/fzpRB5id0C30wXB6KSJB5RBWUflpZVcQDsF9GbZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HEjhMk6ONjFJ7OAfei9ogbJPOPOAoe4wZvRB5cU2U5pvrGRrKrULxBr475OeC5NljxPP6aGSvrIYm7Otf4vRSMOWDGXqE54hxtl4jMSVsimiDvPASr9fvZOIoQgci8mZsaBBFngUrV+GfVOrJSYc6rmuNHlZpRMi2BK5S4JZbOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B0C4CEC3;
	Sat, 16 Nov 2024 13:53:13 +0000 (UTC)
Date: Sat, 16 Nov 2024 08:53:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing/ring-buffer: Fixes for the boot mapped buffer
 for v6.12
Message-ID: <20241116085339.4248f843@gandalf.local.home>
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

Ring buffer fixes for 6.12:

- Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"

  A crash that happened on cpu hotplug was actually caused by the incorrect
  ref counting that was fixed by commit 2cf9733891a4 ("ring-buffer: Fix
  refcount setting of boot mapped buffers"). The removal of calling cpu
  hotplug callbacks on memory mapped buffers was not an issue even though
  the tests at the time pointed toward it. But in fact, there's a check in
  that code that tests to see if the buffers are already allocated or not,
  and will not allocate them again if they are. Not calling the cpu hotplug
  callbacks ended up not initializing the non boot CPU buffers.

  Simply remove that change.

- Clear all CPU buffers when starting tracing in a boot mapped buffer

  To properly process events from a previous boot, the address space needs to
  be accounted for due to KASLR and the events in the buffer are updated
  accordingly when read. This also requires that when the buffer has tracing
  enabled again in the current boot that the buffers are reset so that events
  from the previous boot do not interact with the events of the current boot
  and cause confusing due to not having the proper meta data.

  It was found that if a CPU is taken offline, that its per CPU buffer is not
  reset when tracing starts. This allows for events to be from both the
  previous boot and the current boot to be in the buffer at the same time.
  Clear all CPU buffers when tracing is started in a boot mapped buffer.


Please pull the latest trace-ringbuffer-v6.12-rc7-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-ringbuffer-v6.12-rc7-2

Tag SHA1: cb739db989cfedfb27543e3c39314096ba0b2c13
Head SHA1: 09663753bb7c50b33f8e5fa562c20ce275b88237


Steven Rostedt (2):
      Revert: "ring-buffer: Do not have boot mapped buffers hook to CPU hotplug"
      tracing/ring-buffer: Clear all memory mapped CPU ring buffers on first recording

----
 kernel/trace/ring_buffer.c |  9 +++------
 kernel/trace/trace.c       | 28 ++++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 8 deletions(-)
---------------------------
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3ea4f7bb1837..5807116bcd0b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2337,12 +2337,9 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	if (!buffer->buffers[cpu])
 		goto fail_free_buffers;
 
-	/* If already mapped, do not hook to CPU hotplug */
-	if (!start) {
-		ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
-		if (ret < 0)
-			goto fail_free_buffers;
-	}
+	ret = cpuhp_state_add_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
+	if (ret < 0)
+		goto fail_free_buffers;
 
 	mutex_init(&buffer->mutex);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8f52b6527ca..619e9aa62201 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2386,6 +2386,25 @@ void tracing_reset_online_cpus(struct array_buffer *buf)
 	ring_buffer_record_enable(buffer);
 }
 
+static void tracing_reset_all_cpus(struct array_buffer *buf)
+{
+	struct trace_buffer *buffer = buf->buffer;
+
+	if (!buffer)
+		return;
+
+	ring_buffer_record_disable(buffer);
+
+	/* Make sure all commits have finished */
+	synchronize_rcu();
+
+	buf->time_start = buffer_ftrace_now(buf, buf->cpu);
+
+	ring_buffer_reset(buffer);
+
+	ring_buffer_record_enable(buffer);
+}
+
 /* Must have trace_types_lock held */
 void tracing_reset_all_online_cpus_unlocked(void)
 {
@@ -6141,8 +6160,13 @@ static void update_last_data(struct trace_array *tr)
 	if (!tr->text_delta && !tr->data_delta)
 		return;
 
-	/* Clear old data */
-	tracing_reset_online_cpus(&tr->array_buffer);
+	/*
+	 * Need to clear all CPU buffers as there cannot be events
+	 * from the previous boot mixed with events with this boot
+	 * as that will cause a confusing trace. Need to clear all
+	 * CPU buffers, even for those that may currently be offline.
+	 */
+	tracing_reset_all_cpus(&tr->array_buffer);
 
 	/* Using current data now */
 	tr->text_delta = 0;

