Return-Path: <linux-kernel+bounces-575536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC712A703C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369C8188915C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2701525A648;
	Tue, 25 Mar 2025 14:34:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8086025A342
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913258; cv=none; b=RzAlI1OYyfF3ibNurTOoF36gESsS6Hs90CKHQ/AZJ6sLd//N3IiUfpcMBMRDAfiE4ZzhM1WusN1YmjCcz4RgV94NMXWtLMJ07NpoxZtFQJL8FFnICgZ0DnPe750SftTHI7Lmy/r407RxaLQMYuqjNiOLXXOTawHblVOUlBYJPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913258; c=relaxed/simple;
	bh=j/22C1ELCqdkl3uiT5TUGnj1yAILJowwAHWxIvGqDvw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gFtutG4PGKzfrOi3znBW7kNEBeKLhMdQDZxbOUrCd69LYHKCjq5bg3g/f1IAQjYdUCMxfUPgjIhyaadP2+bB2jhTUV1tLzQJWM+SXtInhqrcjqMIgyN5boGq3diyE3yBrpEyvNJyaBGmVdgszKqtud6ANKKMjs1ip03ZnyStJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30233C4CEEF;
	Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Ms-00000002P0N-2Ykr;
	Tue, 25 Mar 2025 10:35:02 -0400
Message-ID: <20250325143502.464488872@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 4/9] rv: Add snroc per-task monitor
References: <20250325143436.168114339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Add a per-task monitor as part of the sched model:

* snroc: set non runnable on its own context
    Monitor to ensure set_state happens only in the respective task's context

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250305140406.350227-5-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig                      |  1 +
 kernel/trace/rv/Makefile                     |  1 +
 kernel/trace/rv/monitors/snroc/Kconfig       | 14 ++++
 kernel/trace/rv/monitors/snroc/snroc.c       | 85 ++++++++++++++++++++
 kernel/trace/rv/monitors/snroc/snroc.h       | 47 +++++++++++
 kernel/trace/rv/monitors/snroc/snroc_trace.h | 15 ++++
 kernel/trace/rv/rv_trace.h                   |  1 +
 tools/verification/models/sched/snroc.dot    | 18 +++++
 8 files changed, 182 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/snroc/Kconfig
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.c
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc.h
 create mode 100644 kernel/trace/rv/monitors/snroc/snroc_trace.h
 create mode 100644 tools/verification/models/sched/snroc.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 961ac1e487df..c4f1c0fc3abc 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -30,6 +30,7 @@ source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
 source "kernel/trace/rv/monitors/tss/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
+source "kernel/trace/rv/monitors/snroc/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index ef2a084ff310..6d11d6400ddd 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
 obj-$(CONFIG_RV_MON_TSS) += monitors/tss/tss.o
 obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
+obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/snroc/Kconfig b/kernel/trace/rv/monitors/snroc/Kconfig
new file mode 100644
index 000000000000..6e4365a2fea3
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SNROC
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_ID
+	bool "snroc monitor"
+	help
+	  Monitor to ensure sched_set_state happens only in the respective task's context.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
new file mode 100644
index 000000000000..bb1f60d55296
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "snroc"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "snroc.h"
+
+static struct rv_monitor rv_snroc;
+DECLARE_DA_MON_PER_TASK(snroc, unsigned char);
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+{
+	da_handle_event_snroc(tsk, sched_set_state_snroc);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	da_handle_start_event_snroc(prev, sched_switch_out_snroc);
+	da_handle_event_snroc(next, sched_switch_in_snroc);
+}
+
+static int enable_snroc(void)
+{
+	int retval;
+
+	retval = da_monitor_init_snroc();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("snroc", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_snroc(void)
+{
+	rv_snroc.enabled = 0;
+
+	rv_detach_trace_probe("snroc", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("snroc", sched_switch, handle_sched_switch);
+
+	da_monitor_destroy_snroc();
+}
+
+static struct rv_monitor rv_snroc = {
+	.name = "snroc",
+	.description = "set non runnable on its own context.",
+	.enable = enable_snroc,
+	.disable = disable_snroc,
+	.reset = da_monitor_reset_all_snroc,
+	.enabled = 0,
+};
+
+static int __init register_snroc(void)
+{
+	rv_register_monitor(&rv_snroc, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_snroc(void)
+{
+	rv_unregister_monitor(&rv_snroc);
+}
+
+module_init(register_snroc);
+module_exit(unregister_snroc);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("snroc: set non runnable on its own context.");
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
new file mode 100644
index 000000000000..c3650a2b1b10
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of snroc automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_snroc {
+	other_context_snroc = 0,
+	own_context_snroc,
+	state_max_snroc
+};
+
+#define INVALID_STATE state_max_snroc
+
+enum events_snroc {
+	sched_set_state_snroc = 0,
+	sched_switch_in_snroc,
+	sched_switch_out_snroc,
+	event_max_snroc
+};
+
+struct automaton_snroc {
+	char *state_names[state_max_snroc];
+	char *event_names[event_max_snroc];
+	unsigned char function[state_max_snroc][event_max_snroc];
+	unsigned char initial_state;
+	bool final_states[state_max_snroc];
+};
+
+static const struct automaton_snroc automaton_snroc = {
+	.state_names = {
+		"other_context",
+		"own_context"
+	},
+	.event_names = {
+		"sched_set_state",
+		"sched_switch_in",
+		"sched_switch_out"
+	},
+	.function = {
+		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
+		{  own_context_snroc,      INVALID_STATE, other_context_snroc },
+	},
+	.initial_state = other_context_snroc,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/snroc/snroc_trace.h b/kernel/trace/rv/monitors/snroc/snroc_trace.h
new file mode 100644
index 000000000000..50114cef5122
--- /dev/null
+++ b/kernel/trace/rv/monitors/snroc/snroc_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SNROC
+DEFINE_EVENT(event_da_monitor_id, event_snroc,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_snroc,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_SNROC */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index f49e85ca97a1..a533bc29cfdd 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -120,6 +120,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 );
 
 #include <monitors/wwnr/wwnr_trace.h>
+#include <monitors/snroc/snroc_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
 
 #endif /* CONFIG_DA_MON_EVENTS_ID */
diff --git a/tools/verification/models/sched/snroc.dot b/tools/verification/models/sched/snroc.dot
new file mode 100644
index 000000000000..8b71c32d4dca
--- /dev/null
+++ b/tools/verification/models/sched/snroc.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_other_context"};
+	{node [shape = ellipse] "other_context"};
+	{node [shape = plaintext] "other_context"};
+	{node [shape = plaintext] "own_context"};
+	"__init_other_context" -> "other_context";
+	"other_context" [label = "other_context", color = green3];
+	"other_context" -> "own_context" [ label = "sched_switch_in" ];
+	"own_context" [label = "own_context"];
+	"own_context" -> "other_context" [ label = "sched_switch_out" ];
+	"own_context" -> "own_context" [ label = "sched_set_state" ];
+	{ rank = min ;
+		"__init_other_context";
+		"other_context";
+	}
+}
-- 
2.47.2



