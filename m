Return-Path: <linux-kernel+bounces-535195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C7CA47000
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D35516DB84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735F9167DB7;
	Thu, 27 Feb 2025 00:12:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A78C133
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615133; cv=none; b=ZbFd4YOxWs3AMIRF+egK7bsx/IFVAzylGJYBPIBxf3akB3skCqoQp1r4/VUz5AAAaDqigytVNqWxjoOV5uSKGOSA3EBLRCaNvzrYQKqQnnlSJ8N0KXmLaUIcBwyJm+zOgpMXAPuDb4hcnuGDs8CduI60WjWzT+YnTW9zzQjAtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615133; c=relaxed/simple;
	bh=930gZKhLgdCHbmsCso2yuEEbwWgxnmJbIbvm5UQU7Ig=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JKD+NMk+xsUYSklGGcipE8xypWBf9ttOusKU/paloI8TI/e/LneKFIUyN3bHWNCsOuYjCB89A7VxHVC0OYl+q+fJeakhDh0I0ZveFuCQfj4cjsPwZekURwI1fZe1adL3ZpvBe5Y3b+wxnyk0Mu36/l5cPkKhuKDTNTSmbUZHTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A9FC4CEEC;
	Thu, 27 Feb 2025 00:12:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tnRWI-00000009XRX-3Ef3;
	Wed, 26 Feb 2025 19:12:54 -0500
Message-ID: <20250227001254.624778797@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Feb 2025 19:12:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@kernel.org>
Subject: [for-next][PATCH 3/3] tracing: Freeable reserved ring buffer
References: <20250227001235.355892523@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Make the ring buffer on reserved memory to be freeable. This allows us
to free the trace instance on the reserved memory without changing
cmdline and rebooting. Even if we can not change the kernel cmdline
for security reason, we can release the reserved memory for the ring
buffer as free (available) memory.

For example, boot kernel with reserved memory;
"reserve_mem=20M:2M:trace trace_instance=boot_mapped^traceoff@trace"

~ # free
              total        used        free      shared  buff/cache   available
Mem:        1995548       50544     1927568       14964       17436     1911480
Swap:             0           0           0
~ # rmdir /sys/kernel/tracing/instances/boot_mapped/
[   23.704023] Freeing reserve_mem:trace memory: 20476K
~ # free
              total        used        free      shared  buff/cache   available
Mem:        2016024       41844     1956740       14968       17440     1940572
Swap:             0           0           0

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Link: https://lore.kernel.org/173989134814.230693.18199312930337815629.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 13 ++++++++++++-
 kernel/trace/trace.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 61458d8c3a61..b4bcb85094d9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9292,6 +9292,9 @@ static void free_trace_buffers(struct trace_array *tr)
 #ifdef CONFIG_TRACER_MAX_TRACE
 	free_trace_buffer(&tr->max_buffer);
 #endif
+
+	if (tr->range_addr_start)
+		vunmap((void *)tr->range_addr_start);
 }
 
 static void init_trace_flags_index(struct trace_array *tr)
@@ -9453,6 +9456,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree_const(tr->system_names);
+	kfree(tr->range_name);
 	kfree(tr->name);
 	kfree(tr);
 
@@ -9579,6 +9583,11 @@ static int __remove_instance(struct trace_array *tr)
 	free_trace_buffers(tr);
 	clear_tracing_err_log(tr);
 
+	if (tr->range_name) {
+		reserve_mem_release_by_name(tr->range_name);
+		kfree(tr->range_name);
+	}
+
 	for (i = 0; i < tr->nr_topts; i++) {
 		kfree(tr->topts[i].topts);
 	}
@@ -10376,6 +10385,7 @@ __init static void enable_instances(void)
 		bool traceoff = false;
 		char *flag_delim;
 		char *addr_delim;
+		char *rname __free(kfree) = NULL;
 
 		tok = strsep(&curr_str, ",");
 
@@ -10432,6 +10442,7 @@ __init static void enable_instances(void)
 				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
 				continue;
 			}
+			rname = kstrdup(tok, GFP_KERNEL);
 		}
 
 		if (start) {
@@ -10468,7 +10479,7 @@ __init static void enable_instances(void)
 		 */
 		if (start) {
 			tr->flags |= TRACE_ARRAY_FL_BOOT;
-			tr->ref++;
+			tr->range_name = no_free_ptr(rname);
 		}
 
 		while ((tok = strsep(&curr_str, ","))) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 9c21ba45b7af..93b6279d3da4 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -348,6 +348,7 @@ struct trace_array {
 	unsigned int		mapped;
 	unsigned long		range_addr_start;
 	unsigned long		range_addr_size;
+	char			*range_name;
 	long			text_delta;
 	long			data_delta;
 
-- 
2.47.2



