Return-Path: <linux-kernel+bounces-410881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE6E9CF007
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE093B32772
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4F61D47AD;
	Fri, 15 Nov 2024 15:22:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2331CDA2F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684145; cv=none; b=QcAuqnKGsf3aTiKnIIBiBZ2pyXopzfO7jgnOSMY9jdbz9ELF/96pwhWTOD9ghkqF5VAOVABy6oGM0u1PRp7mOC/AXwR4/r8XOG/T5BScBQUnmWomd7gt3hMR7OeayXsHKfXf3AFrOM9GXCJiOiMPU3Uv46SzFWsVU0QubAvrCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684145; c=relaxed/simple;
	bh=JG9wzZAxrWcUqKqSKkSfRXDlYubm7e3orhR/A6kj0L0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UuFtcYQaKtqja57FzFteWpKs4YGZbYxQ1q5EOJgzIx0rmSf9YBrjZL8WFIatO8nGxHQ17X8X+UI3YhPrjs2TIwqz0WeyAQyKCh16MoZREF2Y/spGf045qVbBXvAcLAX+vyQSpJb4GpXUqyu4IEbdb0Csg2b0w7X68VE8vlwffjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1602C4CECF;
	Fri, 15 Nov 2024 15:22:24 +0000 (UTC)
Date: Fri, 15 Nov 2024 10:22:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [for-linus][PATCH] tracing/ring-buffer: Clear all memory mapped CPU
 ring buffers on first recording
Message-ID: <20241115102248.60710e5d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Clear all CPU buffers when starting tracing in a boot mapped buffer

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

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/fixes

Head SHA1: 09663753bb7c50b33f8e5fa562c20ce275b88237


Steven Rostedt (1):
      tracing/ring-buffer: Clear all memory mapped CPU ring buffers on first recording

----
 kernel/trace/trace.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)
---------------------------
commit 09663753bb7c50b33f8e5fa562c20ce275b88237
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Thu Nov 14 11:28:25 2024 -0500

    tracing/ring-buffer: Clear all memory mapped CPU ring buffers on first recording
    
    The events of a memory mapped ring buffer from the previous boot should
    not be mixed in with events from the current boot. There's meta data that
    is used to handle KASLR so that function names can be shown properly.
    
    Also, since the timestamps of the previous boot have no meaning to the
    timestamps of the current boot, having them intermingled in a buffer can
    also cause confusion because there could possibly be events in the future.
    
    When a trace is activated the meta data is reset so that the pointers of
    are now processed for the new address space. The trace buffers are reset
    when tracing starts for the first time. The problem here is that the reset
    only happens on online CPUs. If a CPU is offline, it does not get reset.
    
    To demonstrate the issue, a previous boot had tracing enabled in the boot
    mapped ring buffer on reboot. On the following boot, tracing has not been
    started yet so the function trace from the previous boot is still visible.
    
     # trace-cmd show -B boot_mapped -c 3 | tail
              <idle>-0       [003] d.h2.   156.462395: __rcu_read_lock <-cpu_emergency_disable_virtualization
              <idle>-0       [003] d.h2.   156.462396: vmx_emergency_disable_virtualization_cpu <-cpu_emergency_disable_virtualization
              <idle>-0       [003] d.h2.   156.462396: __rcu_read_unlock <-__sysvec_reboot
              <idle>-0       [003] d.h2.   156.462397: stop_this_cpu <-__sysvec_reboot
              <idle>-0       [003] d.h2.   156.462397: set_cpu_online <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462397: disable_local_APIC <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462398: clear_local_APIC <-disable_local_APIC
              <idle>-0       [003] d.h2.   156.462574: mcheck_cpu_clear <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462575: mce_intel_feature_clear <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462575: lmce_supported <-mce_intel_feature_clear
    
    Now, if CPU 3 is taken offline, and tracing is started on the memory
    mapped ring buffer, the events from the previous boot in the CPU 3 ring
    buffer is not reset. Now those events are using the meta data from the
    current boot and produces just hex values.
    
     # echo 0 > /sys/devices/system/cpu/cpu3/online
     # trace-cmd start -B boot_mapped -p function
     # trace-cmd show -B boot_mapped -c 3 | tail
              <idle>-0       [003] d.h2.   156.462395: 0xffffffff9a1e3194 <-0xffffffff9a0f655e
              <idle>-0       [003] d.h2.   156.462396: 0xffffffff9a0a1d24 <-0xffffffff9a0f656f
              <idle>-0       [003] d.h2.   156.462396: 0xffffffff9a1e6bc4 <-0xffffffff9a0f7323
              <idle>-0       [003] d.h2.   156.462397: 0xffffffff9a0d12b4 <-0xffffffff9a0f732a
              <idle>-0       [003] d.h2.   156.462397: 0xffffffff9a1458d4 <-0xffffffff9a0d12e2
              <idle>-0       [003] d.h2.   156.462397: 0xffffffff9a0faed4 <-0xffffffff9a0d12e7
              <idle>-0       [003] d.h2.   156.462398: 0xffffffff9a0faaf4 <-0xffffffff9a0faef2
              <idle>-0       [003] d.h2.   156.462574: 0xffffffff9a0e3444 <-0xffffffff9a0d12ef
              <idle>-0       [003] d.h2.   156.462575: 0xffffffff9a0e4964 <-0xffffffff9a0d12ef
              <idle>-0       [003] d.h2.   156.462575: 0xffffffff9a0e3fb0 <-0xffffffff9a0e496f
    
    Reset all CPUs when starting a boot mapped ring buffer for the first time,
    and not just the online CPUs.
    
    Fixes: 7a1d1e4b9639f ("tracing/ring-buffer: Add last_boot_info file to boot instance")
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

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

