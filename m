Return-Path: <linux-kernel+bounces-577086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62AEA71832
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6A63BB526
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D6F1F0E5C;
	Wed, 26 Mar 2025 14:13:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7E1E51EC
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998426; cv=none; b=KhFgkvXOU1R465Q+2BUYXAxVdaz71t1+pK+QOVqEsDz7r05av/IdfUH419dFP9PtGBpgtaZRXftsnLqFiBTqUokRTifG0e47dLn3+54XxwTgMF6XPAhKE0XwdV1DAT1pGBX9P7bP7azBN7Bh3FlczWJWdpVxDgdCxsoZZIhCiAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998426; c=relaxed/simple;
	bh=U07NBKERSkDwFINb+ML+xFm2mxnEFKEOcG1UxFrFgtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZdaT/2fJktpU45AiRClAnYSJGHJXMbhPtVW1LUqwxwcme2LoLZ2IRnrBnszzShU17/52IE4f0LkjAlzHswh2tpH0q9RSRLLAMsGR8sfvWrdvwwY2nquyiUaPL1Cpgwg9THXW4WHm+MUTgmAvh19Qs1zYBwPPdHQFQMDUJArqUXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9011CC4CEE2;
	Wed, 26 Mar 2025 14:13:45 +0000 (UTC)
Date: Wed, 26 Mar 2025 10:14:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [for-next][PATCH] tracing: Show last module text symbols in the
 stacktrace
Message-ID: <20250326101431.6b81bc3c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
ring-buffer/for-next

Head SHA1: bab85a646dd91089bd4de518951be068096c7a20


Masami Hiramatsu (Google) (1):
      tracing: Show last module text symbols in the stacktrace

----
 kernel/trace/trace.c        | 133 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/trace/trace.h        |   8 +++
 kernel/trace/trace_output.c |   4 +-
 3 files changed, 138 insertions(+), 7 deletions(-)
---------------------------
commit bab85a646dd91089bd4de518951be068096c7a20
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Mon Mar 24 23:34:52 2025 +0900

    tracing: Show last module text symbols in the stacktrace
    
    Since the previous boot trace buffer can include module text address in
    the stacktrace. As same as the kernel text address, convert the module
    text address using the module address information.
    
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/174282689201.356346.17647540360450727687.stgit@mhiramat.tok.corp.google.com
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0be048fecc89..7ca8a0dbd4fa 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -49,6 +49,7 @@
 #include <linux/fsnotify.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/sort.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE and kaslr_offset() */
 
@@ -6001,6 +6002,59 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
+static int cmp_mod_entry(const void *key, const void *pivot)
+{
+	unsigned long addr = (unsigned long)key;
+	const struct trace_mod_entry *ent = pivot;
+
+	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
+		return 0;
+	else
+		return addr - ent->mod_addr;
+}
+
+/**
+ * trace_adjust_address() - Adjust prev boot address to current address.
+ * @tr: Persistent ring buffer's trace_array.
+ * @addr: Address in @tr which is adjusted.
+ */
+unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
+{
+	struct trace_module_delta *module_delta;
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	int idx = 0, nr_entries;
+
+	/* If we don't have last boot delta, return the address */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return addr;
+
+	/* tr->module_delta must be protected by rcu. */
+	guard(rcu)();
+	tscratch = tr->scratch;
+	/* if there is no tscrach, module_delta must be NULL. */
+	module_delta = READ_ONCE(tr->module_delta);
+	if (!module_delta || tscratch->entries[0].mod_addr > addr)
+		return addr + tr->text_delta;
+
+	/* Note that entries must be sorted. */
+	nr_entries = tscratch->nr_entries;
+	if (nr_entries == 1 ||
+	    tscratch->entries[nr_entries - 1].mod_addr < addr)
+		idx = nr_entries - 1;
+	else {
+		entry = __inline_bsearch((void *)addr,
+				tscratch->entries,
+				nr_entries - 1,
+				sizeof(tscratch->entries[0]),
+				cmp_mod_entry);
+		if (entry)
+			idx = entry - tscratch->entries;
+	}
+
+	return addr + module_delta->delta[idx];
+}
+
 #ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
@@ -6035,6 +6089,7 @@ static int save_mod(struct module *mod, void *data)
 
 static void update_last_data(struct trace_array *tr)
 {
+	struct trace_module_delta *module_delta;
 	struct trace_scratch *tscratch;
 
 	if (!(tr->flags & TRACE_ARRAY_FL_BOOT))
@@ -6073,6 +6128,9 @@ static void update_last_data(struct trace_array *tr)
 		return;
 
 	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tr->module_delta);
+	WRITE_ONCE(tr->module_delta, NULL);
+	kfree_rcu(module_delta, rcu);
 
 	/* Set the persistent ring buffer meta data to this address */
 #ifdef CONFIG_RANDOMIZE_BASE
@@ -9351,10 +9409,51 @@ static struct dentry *trace_instance_dir;
 static void
 init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer);
 
+#ifdef CONFIG_MODULES
+static int make_mod_delta(struct module *mod, void *data)
+{
+	struct trace_module_delta *module_delta;
+	struct trace_scratch *tscratch;
+	struct trace_mod_entry *entry;
+	struct trace_array *tr = data;
+	int i;
+
+	tscratch = tr->scratch;
+	module_delta = READ_ONCE(tr->module_delta);
+	for (i = 0; i < tscratch->nr_entries; i++) {
+		entry = &tscratch->entries[i];
+		if (strcmp(mod->name, entry->mod_name))
+			continue;
+		if (mod->state == MODULE_STATE_GOING)
+			module_delta->delta[i] = 0;
+		else
+			module_delta->delta[i] = (unsigned long)mod->mem[MOD_TEXT].base
+						 - entry->mod_addr;
+		break;
+	}
+	return 0;
+}
+#else
+static int make_mod_delta(struct module *mod, void *data)
+{
+	return 0;
+}
+#endif
+
+static int mod_addr_comp(const void *a, const void *b, const void *data)
+{
+	const struct trace_mod_entry *e1 = a;
+	const struct trace_mod_entry *e2 = b;
+
+	return e1->mod_addr > e2->mod_addr ? 1 : -1;
+}
+
 static void setup_trace_scratch(struct trace_array *tr,
 				struct trace_scratch *tscratch, unsigned int size)
 {
+	struct trace_module_delta *module_delta;
 	struct trace_mod_entry *entry;
+	int i, nr_entries;
 
 	if (!tscratch)
 		return;
@@ -9371,7 +9470,7 @@ static void setup_trace_scratch(struct trace_array *tr,
 		goto reset;
 
 	/* Check if each module name is a valid string */
-	for (int i = 0; i < tscratch->nr_entries; i++) {
+	for (i = 0; i < tscratch->nr_entries; i++) {
 		int n;
 
 		entry = &tscratch->entries[i];
@@ -9385,6 +9484,25 @@ static void setup_trace_scratch(struct trace_array *tr,
 		if (n == MODULE_NAME_LEN)
 			goto reset;
 	}
+
+	/* Sort the entries so that we can find appropriate module from address. */
+	nr_entries = tscratch->nr_entries;
+	sort_r(tscratch->entries, nr_entries, sizeof(struct trace_mod_entry),
+	       mod_addr_comp, NULL, NULL);
+
+	if (IS_ENABLED(CONFIG_MODULES)) {
+		module_delta = kzalloc(struct_size(module_delta, delta, nr_entries), GFP_KERNEL);
+		if (!module_delta) {
+			pr_info("module_delta allocation failed. Not able to decode module address.");
+			goto reset;
+		}
+		init_rcu_head(&module_delta->rcu);
+	} else
+		module_delta = NULL;
+	WRITE_ONCE(tr->module_delta, module_delta);
+
+	/* Scan modules to make text delta for modules. */
+	module_for_each_mod(make_mod_delta, tr);
 	return;
  reset:
 	/* Invalid trace modules */
@@ -10101,16 +10219,20 @@ static void trace_module_remove_evals(struct module *mod)
 static inline void trace_module_remove_evals(struct module *mod) { }
 #endif /* CONFIG_TRACE_EVAL_MAP_FILE */
 
-static void trace_module_record(struct module *mod)
+static void trace_module_record(struct module *mod, bool add)
 {
 	struct trace_array *tr;
+	unsigned long flags;
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-		if ((tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT)) ==
-		    TRACE_ARRAY_FL_BOOT) {
+		if (flags == TRACE_ARRAY_FL_BOOT && add) {
 			guard(mutex)(&scratch_mutex);
 			save_mod(mod, tr);
+		} else if (flags & TRACE_ARRAY_FL_LAST_BOOT) {
+			/* Update delta if the module loaded in previous boot */
+			make_mod_delta(mod, tr);
 		}
 	}
 }
@@ -10123,10 +10245,11 @@ static int trace_module_notify(struct notifier_block *self,
 	switch (val) {
 	case MODULE_STATE_COMING:
 		trace_module_add_evals(mod);
-		trace_module_record(mod);
+		trace_module_record(mod, true);
 		break;
 	case MODULE_STATE_GOING:
 		trace_module_remove_evals(mod);
+		trace_module_record(mod, false);
 		break;
 	}
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 0d6efb8a1179..ab7c7a1930cc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -312,6 +312,11 @@ struct trace_func_repeats {
 	u64		ts_last_call;
 };
 
+struct trace_module_delta {
+	struct rcu_head	rcu;
+	long		delta[];
+};
+
 /*
  * The trace array - an array of per-CPU trace arrays. This is the
  * highest level data structure that individual tracers deal with.
@@ -350,6 +355,7 @@ struct trace_array {
 	unsigned long		range_addr_size;
 	char			*range_name;
 	long			text_delta;
+	struct trace_module_delta *module_delta;
 	void			*scratch; /* pointer in persistent memory */
 	int			scratch_size;
 
@@ -466,6 +472,8 @@ extern int tracing_set_clock(struct trace_array *tr, const char *clockstr);
 
 extern bool trace_clock_in_ns(struct trace_array *tr);
 
+extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 03d56f711ad1..1ad54fcf25cb 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
  *
  */
+#include "trace.h"
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/ftrace.h>
@@ -1248,7 +1249,6 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 	struct trace_seq *s = &iter->seq;
 	unsigned long *p;
 	unsigned long *end;
-	long delta = iter->tr->text_delta;
 
 	trace_assign_type(field, iter->ent);
 	end = (unsigned long *)((long)iter->ent + iter->ent_size);
@@ -1265,7 +1265,7 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			trace_seq_puts(s, "[FTRACE TRAMPOLINE]\n");
 			continue;
 		}
-		seq_print_ip_sym(s, (*p) + delta, flags);
+		seq_print_ip_sym(s, trace_adjust_address(iter->tr, *p), flags);
 		trace_seq_putc(s, '\n');
 	}
 

