Return-Path: <linux-kernel+bounces-288310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A609538A5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87C31C237F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069C1BBBF0;
	Thu, 15 Aug 2024 16:57:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299971BB696
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723741076; cv=none; b=NKm3qJFlxtx2hXTCe6ZtvVDLZ7V3VH/put94pVbGupS0l//1fpi/8QY1jZWBfcTENrCKl9fGVVovddRco3Frdv8IH2Spc6U2YALhnrVeME9hzAAdSKLapGE3DO4Nu7n+lvd7Q1jSqGnK8Zz0/JXNDs6Akgdb5r97t2IzQ71ByKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723741076; c=relaxed/simple;
	bh=xfWU3XuAqZqyTXefIqyf9DlelEbM06kkB1qL8Z09GD8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GVy/xZ91Bb+KpIO5XYcws6gOWNBAQCg9Koe7oryzzWIwWF+lSVsF/ClF34Oz/COORNlLfPAsIYO2TBwb/dRACMias2Y5/UMv1Zm3HSbrO4VBcEoKoseDVj+4ZKGe+9aq6fJKc80gQDuueytiQW4dJcTQUr8B1kz9lGqVBQf29yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F181FC4AF0D;
	Thu, 15 Aug 2024 16:57:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sedng-00000001uLy-1qZY;
	Thu, 15 Aug 2024 12:58:12 -0400
Message-ID: <20240815165812.299370296@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 15 Aug 2024 12:57:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ross Zwisler <zwisler@google.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 3/3] tracing/fgraph: Have fgraph handle previous boot function addresses
References: <20240815165744.699054530@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Update the function graph code to modify the function addresses for a
previous boot buffer so that it matches the current kallsyms (note this
does not handle module addresses, yet).

After a reboot, instead of seeing:

 # trace-cmd show -B boot_mapped | tail -n30
       swapper/0-1       [000] d..2.    56.286470:  0)   0.481 us    |                    0xffffffff925da5c4();
       swapper/0-1       [000] d....    56.286471:  0)   4.065 us    |                  }
       swapper/0-1       [000] d....    56.286471:  0)   4.920 us    |                }
       swapper/0-1       [000] d..1.    56.286472:  0)               |                0xffffffff92536254() {
       swapper/0-1       [000] d..1.    56.286472:  0) + 28.974 us   |                  0xffffffff92534e30();
       swapper/0-1       [000] d....    56.286516:  0) + 43.881 us   |                }
       swapper/0-1       [000] d..1.    56.286517:  0)               |                0xffffffff925136c4() {
       swapper/0-1       [000] d..1.    56.286518:  0)               |                  0xffffffff92514a14() {
       swapper/0-1       [000] d..1.    56.286518:  0)   6.003 us    |                    0xffffffff92514200();
       swapper/0-1       [000] d....    56.286529:  0) + 11.510 us   |                  }
       swapper/0-1       [000] d....    56.286529:  0) + 12.895 us   |                }
       swapper/0-1       [000] d....    56.286530:  0) ! 382.884 us  |              }
       swapper/0-1       [000] d..1.    56.286530:  0)               |              0xffffffff92536444() {
       swapper/0-1       [000] d..1.    56.286531:  0)               |                0xffffffff92536254() {
       swapper/0-1       [000] d..1.    56.286531:  0) + 26.335 us   |                  0xffffffff92534e30();
       swapper/0-1       [000] d....    56.286560:  0) + 29.511 us   |                }
       swapper/0-1       [000] d....    56.286561:  0) + 30.452 us   |              }
       swapper/0-1       [000] d..1.    56.286562:  0)               |              0xffffffff9253c014() {
       swapper/0-1       [000] d..1.    56.286562:  0)               |                0xffffffff9253bed4() {
       swapper/0-1       [000] d..1.    56.286563:  0) + 13.465 us   |                  0xffffffff92536684();
       swapper/0-1       [000] d....    56.286577:  0) + 14.651 us   |                }
       swapper/0-1       [000] d....    56.286577:  0) + 15.821 us   |              }
       swapper/0-1       [000] d..1.    56.286578:  0)   0.667 us    |              0xffffffff92547074();
       swapper/0-1       [000] d..1.    56.286579:  0)   0.453 us    |              0xffffffff924f35c4();
       swapper/0-1       [000] d....    56.286580:  0) # 3906.348 us |            }
       swapper/0-1       [000] d..1.    56.286581:  0)               |            0xffffffff92531a14() {
       swapper/0-1       [000] d..1.    56.286581:  0)   0.518 us    |              0xffffffff92505cb4();
       swapper/0-1       [000] d..1.    56.286595:  0)               |              0xffffffff92db83c4() {
       swapper/0-1       [000] d..1.    56.286596:  0)               |                0xffffffff92dec2e4() {
       swapper/0-1       [000] d..1.    56.286597:  0)               |                  0xffffffff92db5304() {

It now shows:

 # trace-cmd show -B boot_mapped | tail -n30
       swapper/0-1       [000] d..2.   363.079099:  0)   0.483 us    |                    preempt_count_sub();
       swapper/0-1       [000] d....   363.079100:  0)   4.112 us    |                  }
       swapper/0-1       [000] d....   363.079101:  0)   4.979 us    |                }
       swapper/0-1       [000] d..1.   363.079101:  0)               |                disable_local_APIC() {
       swapper/0-1       [000] d..1.   363.079102:  0) + 29.153 us   |                  clear_local_APIC.part.0();
       swapper/0-1       [000] d....   363.079148:  0) + 46.517 us   |                }
       swapper/0-1       [000] d..1.   363.079149:  0)               |                mcheck_cpu_clear() {
       swapper/0-1       [000] d..1.   363.079149:  0)               |                  mce_intel_feature_clear() {
       swapper/0-1       [000] d..1.   363.079150:  0)   5.871 us    |                    lmce_supported();
       swapper/0-1       [000] d....   363.079161:  0) + 11.340 us   |                  }
       swapper/0-1       [000] d....   363.079161:  0) + 12.638 us   |                }
       swapper/0-1       [000] d....   363.079162:  0) ! 383.518 us  |              }
       swapper/0-1       [000] d..1.   363.079162:  0)               |              lapic_shutdown() {
       swapper/0-1       [000] d..1.   363.079163:  0)               |                disable_local_APIC() {
       swapper/0-1       [000] d..1.   363.079163:  0) + 26.144 us   |                  clear_local_APIC.part.0();
       swapper/0-1       [000] d....   363.079192:  0) + 29.424 us   |                }
       swapper/0-1       [000] d....   363.079192:  0) + 30.376 us   |              }
       swapper/0-1       [000] d..1.   363.079193:  0)               |              restore_boot_irq_mode() {
       swapper/0-1       [000] d..1.   363.079194:  0)               |                native_restore_boot_irq_mode() {
       swapper/0-1       [000] d..1.   363.079194:  0) + 13.863 us   |                  disconnect_bsp_APIC();
       swapper/0-1       [000] d....   363.079209:  0) + 14.933 us   |                }
       swapper/0-1       [000] d....   363.079209:  0) + 16.009 us   |              }
       swapper/0-1       [000] d..1.   363.079210:  0)   0.694 us    |              hpet_disable();
       swapper/0-1       [000] d..1.   363.079211:  0)   0.511 us    |              iommu_shutdown_noop();
       swapper/0-1       [000] d....   363.079212:  0) # 3980.260 us |            }
       swapper/0-1       [000] d..1.   363.079212:  0)               |            native_machine_emergency_restart() {
       swapper/0-1       [000] d..1.   363.079213:  0)   0.495 us    |              tboot_shutdown();
       swapper/0-1       [000] d..1.   363.079230:  0)               |              acpi_reboot() {
       swapper/0-1       [000] d..1.   363.079231:  0)               |                acpi_reset() {
       swapper/0-1       [000] d..1.   363.079232:  0)               |                  acpi_os_write_port() {

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20240813171257.478901820@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 13d0387ac6a6..a569daaac4c4 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -544,6 +544,8 @@ print_graph_irq(struct trace_iterator *iter, unsigned long addr,
 	struct trace_seq *s = &iter->seq;
 	struct trace_entry *ent = iter->ent;
 
+	addr += iter->tr->text_delta;
+
 	if (addr < (unsigned long)__irqentry_text_start ||
 		addr >= (unsigned long)__irqentry_text_end)
 		return;
@@ -710,6 +712,7 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	struct ftrace_graph_ret *graph_ret;
 	struct ftrace_graph_ent *call;
 	unsigned long long duration;
+	unsigned long func;
 	int cpu = iter->cpu;
 	int i;
 
@@ -717,6 +720,8 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	call = &entry->graph_ent;
 	duration = graph_ret->rettime - graph_ret->calltime;
 
+	func = call->func + iter->tr->text_delta;
+
 	if (data) {
 		struct fgraph_cpu_data *cpu_data;
 
@@ -747,10 +752,10 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	 * enabled.
 	 */
 	if (flags & __TRACE_GRAPH_PRINT_RETVAL)
-		print_graph_retval(s, graph_ret->retval, true, (void *)call->func,
+		print_graph_retval(s, graph_ret->retval, true, (void *)func,
 				!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
 	else
-		trace_seq_printf(s, "%ps();\n", (void *)call->func);
+		trace_seq_printf(s, "%ps();\n", (void *)func);
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -766,6 +771,7 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	struct ftrace_graph_ent *call = &entry->graph_ent;
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
+	unsigned long func;
 	int i;
 
 	if (data) {
@@ -788,7 +794,9 @@ print_graph_entry_nested(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps() {\n", (void *)call->func);
+	func = call->func + iter->tr->text_delta;
+
+	trace_seq_printf(s, "%ps() {\n", (void *)func);
 
 	if (trace_seq_has_overflowed(s))
 		return TRACE_TYPE_PARTIAL_LINE;
@@ -863,6 +871,8 @@ check_irq_entry(struct trace_iterator *iter, u32 flags,
 	int *depth_irq;
 	struct fgraph_data *data = iter->private;
 
+	addr += iter->tr->text_delta;
+
 	/*
 	 * If we are either displaying irqs, or we got called as
 	 * a graph event and private data does not exist,
@@ -990,11 +1000,14 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 	unsigned long long duration = trace->rettime - trace->calltime;
 	struct fgraph_data *data = iter->private;
 	struct trace_array *tr = iter->tr;
+	unsigned long func;
 	pid_t pid = ent->pid;
 	int cpu = iter->cpu;
 	int func_match = 1;
 	int i;
 
+	func = trace->func + iter->tr->text_delta;
+
 	if (check_irq_return(iter, flags, trace->depth))
 		return TRACE_TYPE_HANDLED;
 
@@ -1033,7 +1046,7 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 	 * function-retval option is enabled.
 	 */
 	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
-		print_graph_retval(s, trace->retval, false, (void *)trace->func,
+		print_graph_retval(s, trace->retval, false, (void *)func,
 			!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
 	} else {
 		/*
@@ -1046,7 +1059,7 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
 			trace_seq_puts(s, "}\n");
 		else
-			trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
+			trace_seq_printf(s, "} /* %ps */\n", (void *)func);
 	}
 
 	/* Overrun */
-- 
2.43.0



