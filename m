Return-Path: <linux-kernel+bounces-575534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE1BA703E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52793B8BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2998525A64A;
	Tue, 25 Mar 2025 14:34:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5685C25A2D0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913258; cv=none; b=u+ZOGrRVEtYc4Rbz+rSh/OnI+EckDI/yKB84ZIE95D7WvNcHRD/GDEodpfE65ka37eLqs79qv4vpmA9tmZA2TRIWD8j06C7O7v2kFpZaL7332DaenyKmoGbxxGdppPWLXQ+7SGeqdOIUZdApfKRj5tKZPwREsm0l7m4+1Irz4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913258; c=relaxed/simple;
	bh=zwD8RJKar/Yad4gCsMq4QQbBGtH6LYz3vomASUvb/9E=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YRMjaxT3DRsDed6xf0KZ9zfyiI6EUglguIDKZ3sBTQH4Xsk0BnRr2EJqbQ76ip8fS3KGJTfxCo+F1rPfRha11zRDjXlWYZ5UtO2zKUSO/6Q76bLA7p4OGoTx5Jdu2vuo2A88csBcg3N3/gXjosjROBs6uszGlGJuZjneMLphpRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01ED0C4CEEE;
	Tue, 25 Mar 2025 14:34:18 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tx5Ms-00000002Ozt-1rHx;
	Tue, 25 Mar 2025 10:35:02 -0400
Message-ID: <20250325143502.291464364@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 10:34:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 3/9] rv: Add sco and tss per-cpu monitors
References: <20250325143436.168114339@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Add 2 per-cpu monitors as part of the sched model:

* sco: scheduling context operations
    Monitor to ensure sched_set_state happens only in thread context
* tss: task switch while scheduling
    Monitor to ensure sched_switch happens only in scheduling context

To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: John Kacur <jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250305140406.350227-4-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig                  |  2 +
 kernel/trace/rv/Makefile                 |  2 +
 kernel/trace/rv/monitors/sco/Kconfig     | 14 ++++
 kernel/trace/rv/monitors/sco/sco.c       | 88 +++++++++++++++++++++++
 kernel/trace/rv/monitors/sco/sco.h       | 47 ++++++++++++
 kernel/trace/rv/monitors/sco/sco_trace.h | 15 ++++
 kernel/trace/rv/monitors/tss/Kconfig     | 14 ++++
 kernel/trace/rv/monitors/tss/tss.c       | 91 ++++++++++++++++++++++++
 kernel/trace/rv/monitors/tss/tss.h       | 47 ++++++++++++
 kernel/trace/rv/monitors/tss/tss_trace.h | 15 ++++
 kernel/trace/rv/rv_trace.h               |  2 +
 tools/verification/models/sched/sco.dot  | 18 +++++
 tools/verification/models/sched/tss.dot  | 18 +++++
 13 files changed, 373 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/sco/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sco/sco.c
 create mode 100644 kernel/trace/rv/monitors/sco/sco.h
 create mode 100644 kernel/trace/rv/monitors/sco/sco_trace.h
 create mode 100644 kernel/trace/rv/monitors/tss/Kconfig
 create mode 100644 kernel/trace/rv/monitors/tss/tss.c
 create mode 100644 kernel/trace/rv/monitors/tss/tss.h
 create mode 100644 kernel/trace/rv/monitors/tss/tss_trace.h
 create mode 100644 tools/verification/models/sched/sco.dot
 create mode 100644 tools/verification/models/sched/tss.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 84c98a5327f3..961ac1e487df 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -28,6 +28,8 @@ menuconfig RV
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 source "kernel/trace/rv/monitors/sched/Kconfig"
+source "kernel/trace/rv/monitors/tss/Kconfig"
+source "kernel/trace/rv/monitors/sco/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 1c784df03b9a..ef2a084ff310 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -6,6 +6,8 @@ obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
+obj-$(CONFIG_RV_MON_TSS) += monitors/tss/tss.o
+obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/sco/Kconfig b/kernel/trace/rv/monitors/sco/Kconfig
new file mode 100644
index 000000000000..097c96cccdd7
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SCO
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "sco monitor"
+	help
+	  Monitor to ensure sched_set_state happens only in thread context.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
new file mode 100644
index 000000000000..4cff59220bfc
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -0,0 +1,88 @@
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
+#define MODULE_NAME "sco"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "sco.h"
+
+static struct rv_monitor rv_sco;
+DECLARE_DA_MON_PER_CPU(sco, unsigned char);
+
+static void handle_sched_set_state(void *data, struct task_struct *tsk, int state)
+{
+	da_handle_start_event_sco(sched_set_state_sco);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_event_sco(schedule_entry_sco);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_start_event_sco(schedule_exit_sco);
+}
+
+static int enable_sco(void)
+{
+	int retval;
+
+	retval = da_monitor_init_sco();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("sco", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("sco", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("sco", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_sco(void)
+{
+	rv_sco.enabled = 0;
+
+	rv_detach_trace_probe("sco", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("sco", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("sco", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_sco();
+}
+
+static struct rv_monitor rv_sco = {
+	.name = "sco",
+	.description = "scheduling context operations.",
+	.enable = enable_sco,
+	.disable = disable_sco,
+	.reset = da_monitor_reset_all_sco,
+	.enabled = 0,
+};
+
+static int __init register_sco(void)
+{
+	rv_register_monitor(&rv_sco, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_sco(void)
+{
+	rv_unregister_monitor(&rv_sco);
+}
+
+module_init(register_sco);
+module_exit(unregister_sco);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("sco: scheduling context operations.");
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
new file mode 100644
index 000000000000..7a4c1f2d5ca1
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of sco automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_sco {
+	thread_context_sco = 0,
+	scheduling_context_sco,
+	state_max_sco
+};
+
+#define INVALID_STATE state_max_sco
+
+enum events_sco {
+	sched_set_state_sco = 0,
+	schedule_entry_sco,
+	schedule_exit_sco,
+	event_max_sco
+};
+
+struct automaton_sco {
+	char *state_names[state_max_sco];
+	char *event_names[event_max_sco];
+	unsigned char function[state_max_sco][event_max_sco];
+	unsigned char initial_state;
+	bool final_states[state_max_sco];
+};
+
+static const struct automaton_sco automaton_sco = {
+	.state_names = {
+		"thread_context",
+		"scheduling_context"
+	},
+	.event_names = {
+		"sched_set_state",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
+		{          INVALID_STATE,          INVALID_STATE,     thread_context_sco },
+	},
+	.initial_state = thread_context_sco,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/sco/sco_trace.h b/kernel/trace/rv/monitors/sco/sco_trace.h
new file mode 100644
index 000000000000..b711cd9024ec
--- /dev/null
+++ b/kernel/trace/rv/monitors/sco/sco_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SCO
+DEFINE_EVENT(event_da_monitor, event_sco,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_sco,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_SCO */
diff --git a/kernel/trace/rv/monitors/tss/Kconfig b/kernel/trace/rv/monitors/tss/Kconfig
new file mode 100644
index 000000000000..479f86f52e60
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_TSS
+	depends on RV
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "tss monitor"
+	help
+	  Monitor to ensure sched_switch happens only in scheduling context.
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
new file mode 100644
index 000000000000..542787e6524f
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -0,0 +1,91 @@
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
+#define MODULE_NAME "tss"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "tss.h"
+
+static struct rv_monitor rv_tss;
+DECLARE_DA_MON_PER_CPU(tss, unsigned char);
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	da_handle_event_tss(sched_switch_tss);
+}
+
+static void handle_schedule_entry(void *data, bool preempt, unsigned long ip)
+{
+	da_handle_event_tss(schedule_entry_tss);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch, unsigned long ip)
+{
+	da_handle_start_event_tss(schedule_exit_tss);
+}
+
+static int enable_tss(void)
+{
+	int retval;
+
+	retval = da_monitor_init_tss();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("tss", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("tss", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("tss", sched_exit_tp, handle_schedule_exit);
+
+	return 0;
+}
+
+static void disable_tss(void)
+{
+	rv_tss.enabled = 0;
+
+	rv_detach_trace_probe("tss", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("tss", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("tss", sched_exit_tp, handle_schedule_exit);
+
+	da_monitor_destroy_tss();
+}
+
+static struct rv_monitor rv_tss = {
+	.name = "tss",
+	.description = "task switch while scheduling.",
+	.enable = enable_tss,
+	.disable = disable_tss,
+	.reset = da_monitor_reset_all_tss,
+	.enabled = 0,
+};
+
+static int __init register_tss(void)
+{
+	rv_register_monitor(&rv_tss, &rv_sched);
+	return 0;
+}
+
+static void __exit unregister_tss(void)
+{
+	rv_unregister_monitor(&rv_tss);
+}
+
+module_init(register_tss);
+module_exit(unregister_tss);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("tss: task switch while scheduling.");
diff --git a/kernel/trace/rv/monitors/tss/tss.h b/kernel/trace/rv/monitors/tss/tss.h
new file mode 100644
index 000000000000..f0a36fda1b87
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/tss.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of tss automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_tss {
+	thread_tss = 0,
+	sched_tss,
+	state_max_tss
+};
+
+#define INVALID_STATE state_max_tss
+
+enum events_tss {
+	sched_switch_tss = 0,
+	schedule_entry_tss,
+	schedule_exit_tss,
+	event_max_tss
+};
+
+struct automaton_tss {
+	char *state_names[state_max_tss];
+	char *event_names[event_max_tss];
+	unsigned char function[state_max_tss][event_max_tss];
+	unsigned char initial_state;
+	bool final_states[state_max_tss];
+};
+
+static const struct automaton_tss automaton_tss = {
+	.state_names = {
+		"thread",
+		"sched"
+	},
+	.event_names = {
+		"sched_switch",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{     INVALID_STATE,         sched_tss,     INVALID_STATE },
+		{         sched_tss,     INVALID_STATE,        thread_tss },
+	},
+	.initial_state = thread_tss,
+	.final_states = { 1, 0 },
+};
diff --git a/kernel/trace/rv/monitors/tss/tss_trace.h b/kernel/trace/rv/monitors/tss/tss_trace.h
new file mode 100644
index 000000000000..4619dbb50cc0
--- /dev/null
+++ b/kernel/trace/rv/monitors/tss/tss_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_TSS
+DEFINE_EVENT(event_da_monitor, event_tss,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_tss,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_TSS */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 5e65097423ba..f49e85ca97a1 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -58,6 +58,8 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 );
 
 #include <monitors/wip/wip_trace.h>
+#include <monitors/tss/tss_trace.h>
+#include <monitors/sco/sco_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
diff --git a/tools/verification/models/sched/sco.dot b/tools/verification/models/sched/sco.dot
new file mode 100644
index 000000000000..20b0e3b449a6
--- /dev/null
+++ b/tools/verification/models/sched/sco.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext] "scheduling_context"};
+	{node [shape = plaintext, style=invis, label=""] "__init_thread_context"};
+	{node [shape = ellipse] "thread_context"};
+	{node [shape = plaintext] "thread_context"};
+	"__init_thread_context" -> "thread_context";
+	"scheduling_context" [label = "scheduling_context"];
+	"scheduling_context" -> "thread_context" [ label = "schedule_exit" ];
+	"thread_context" [label = "thread_context", color = green3];
+	"thread_context" -> "scheduling_context" [ label = "schedule_entry" ];
+	"thread_context" -> "thread_context" [ label = "sched_set_state" ];
+	{ rank = min ;
+		"__init_thread_context";
+		"thread_context";
+	}
+}
diff --git a/tools/verification/models/sched/tss.dot b/tools/verification/models/sched/tss.dot
new file mode 100644
index 000000000000..7dfa1d9121bb
--- /dev/null
+++ b/tools/verification/models/sched/tss.dot
@@ -0,0 +1,18 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext] "sched"};
+	{node [shape = plaintext, style=invis, label=""] "__init_thread"};
+	{node [shape = ellipse] "thread"};
+	{node [shape = plaintext] "thread"};
+	"__init_thread" -> "thread";
+	"sched" [label = "sched"];
+	"sched" -> "sched" [ label = "sched_switch" ];
+	"sched" -> "thread" [ label = "schedule_exit" ];
+	"thread" [label = "thread", color = green3];
+	"thread" -> "sched" [ label = "schedule_entry" ];
+	{ rank = min ;
+		"__init_thread";
+		"thread";
+	}
+}
-- 
2.47.2



