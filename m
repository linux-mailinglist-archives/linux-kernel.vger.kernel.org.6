Return-Path: <linux-kernel+bounces-389852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A09B7227
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011EDB24C95
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29831487FE;
	Thu, 31 Oct 2024 01:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EoE3pB2A"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1991482ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339033; cv=none; b=ax0Nw7Hun844jBDoIM6nMaewKO2iqSlhOj50skY9BnmkDnB4ATl3/IuuV9TDL6se7DPNYwpSpym0nvkixxB11SnYFmCczBvwhAVNLVA8f+1mFOMsl5FS/kkVQ+eJy8SU3gT13rOIOa+JpaBhTSTZJMpl0cUKt4fFXJ9onFIaB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339033; c=relaxed/simple;
	bh=iHOKIdkJKn5OohvH2Y5eDxRnBsLlbcQV9FkSQyGhP0Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oC3ZSNNOR4DRqzTnti6zFjTOPHK9pBcjkjMPadzi8AazQdZ6b9WyLJarp53xIlCC0hvwuNUZkpCO9zg+8MIWziyiKrQx7unz2QzutEX63gdPz59YWST0VmvEwdXwhXs9pty5F3p9w6eIdH+MSnHCDPp3sXt6zeF38CBW60lOvfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EoE3pB2A; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e38562155bso10227317b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339029; x=1730943829; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgKZjzUuV/L3+to29vj/idvGzpfhLPLw+vFOZgW77l8=;
        b=EoE3pB2Ab5OnowVUL+P5OmOJmDUz2OoeNTIU1HTWx1v14MjRPCVXOroubh8SX03Vas
         HZZBo+lt+nQ6sDxFu4S68mwf91u48FfIUrJ0F+lVSFc3rKBpQTSXONt63MaQqIqI4nZn
         vogQNbUUAuDEHJVBDM2dE8+DJVoECfxUo9L8XUSF3VvAJ9Uaia/Z37+l7xIQhDSLc3Cj
         3c7Rx3x70m7TsXvt6VAtIKPBWvHZvslhO2i0N8WVQFHNk/fQbHCgpIT9KzFquHjt107+
         9TMQJAwsZIOx96RHzApD8uLSReOa4BV/0zg+27Yn5hDTiYnopWbLPXey3rHie0UIOwaa
         8qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339029; x=1730943829;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgKZjzUuV/L3+to29vj/idvGzpfhLPLw+vFOZgW77l8=;
        b=wW3sEMnGZZJmMTbILrIo1JXdRaUhcWV+B8TI38e8M8exUSE+pmlbMjpf1pLFdb4pSN
         p2VK25d6cO2nK1oaorKEOnir4crQEEOySJUnaN9nmXKy2TvJQ/JaLEim11GTZdmkXYci
         tjKtGEj4bd4/7BeqX+BYNl0tFXvdb8/ghjmQ0szqvLUfXwOPiAUgUysizUR3NUVMAALs
         ziGh5HVOjAbxa3Jd/bELFTLFzD4eQ95KucViA0RP4mWNFuF7z43p/iftG8SXW5I4BgNk
         t2JADMzjqp7mkNNXc6omVMt+D7uAXlsoIA2TZ4KBVbQrZ8bqDaCypdr7bMu8PvDtpbW9
         VA8w==
X-Forwarded-Encrypted: i=1; AJvYcCX7pK6QWqzx/Q2OlYZ80YCM1J/HxXs5icHQNy8Po2X3zSZtaunTBck+QihCZFSq/sNiVCuEfAuXGUwpSm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRDYhUMGCfGkh+F63CZwifkHqZkdcOcyZcPp3csJyMbima21v
	dIrYd7NLXtmEhEJ3QE3ccV68S9EMEb4ryPTda2CyUtvyE1FES4aIs6YpnS4LI8gfG+IlsFzI1Mk
	4XpyTOg==
X-Google-Smtp-Source: AGHT+IESYhHH0YHqZZP/CUDn21hDBb+ojNf+QFDtv5NrSAaC4jOualWN+74xgiHkIoPV01shsDPUjpoJfyzW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a05:690c:6383:b0:6e2:ad08:4924 with SMTP
 id 00721157ae682-6e9d8aacb2dmr10893567b3.4.1730339028213; Wed, 30 Oct 2024
 18:43:48 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:45 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 14/21] perf lock: Move common lock contention code to new file
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid references from util code to builtin-lock that require python
stubs. Move the functions and related variables to
util/lock-contention.c. Add max_stack_depth parameter to
match_callstack_filter to avoid sharing a global variable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c             | 137 +--------------------
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   2 +-
 tools/perf/util/lock-contention.c     | 170 ++++++++++++++++++++++++++
 tools/perf/util/lock-contention.h     |  37 ++----
 tools/perf/util/python.c              |  17 ---
 6 files changed, 185 insertions(+), 179 deletions(-)
 create mode 100644 tools/perf/util/lock-contention.c

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 062e2b56a2ab..f66948b1fbed 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -46,15 +46,6 @@
 static struct perf_session *session;
 static struct target target;
 
-/* based on kernel/lockdep.c */
-#define LOCKHASH_BITS		12
-#define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
-
-static struct hlist_head *lockhash_table;
-
-#define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
-#define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
-
 static struct rb_root		thread_stats;
 
 static bool combine_locks;
@@ -67,24 +58,13 @@ static unsigned long bpf_map_entries = MAX_ENTRIES;
 static int max_stack_depth = CONTENTION_STACK_DEPTH;
 static int stack_skip = CONTENTION_STACK_SKIP;
 static int print_nr_entries = INT_MAX / 2;
-static LIST_HEAD(callstack_filters);
 static const char *output_name = NULL;
 static FILE *lock_output;
 
-struct callstack_filter {
-	struct list_head list;
-	char name[];
-};
-
 static struct lock_filter filters;
 
 static enum lock_aggr_mode aggr_mode = LOCK_AGGR_ADDR;
 
-static bool needs_callstack(void)
-{
-	return !list_empty(&callstack_filters);
-}
-
 static struct thread_stat *thread_stat_find(u32 tid)
 {
 	struct rb_node *node;
@@ -477,93 +457,6 @@ static struct lock_stat *pop_from_result(void)
 	return container_of(node, struct lock_stat, rb);
 }
 
-struct lock_stat *lock_stat_find(u64 addr)
-{
-	struct hlist_head *entry = lockhashentry(addr);
-	struct lock_stat *ret;
-
-	hlist_for_each_entry(ret, entry, hash_entry) {
-		if (ret->addr == addr)
-			return ret;
-	}
-	return NULL;
-}
-
-struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
-{
-	struct hlist_head *entry = lockhashentry(addr);
-	struct lock_stat *ret, *new;
-
-	hlist_for_each_entry(ret, entry, hash_entry) {
-		if (ret->addr == addr)
-			return ret;
-	}
-
-	new = zalloc(sizeof(struct lock_stat));
-	if (!new)
-		goto alloc_failed;
-
-	new->addr = addr;
-	new->name = strdup(name);
-	if (!new->name) {
-		free(new);
-		goto alloc_failed;
-	}
-
-	new->flags = flags;
-	new->wait_time_min = ULLONG_MAX;
-
-	hlist_add_head(&new->hash_entry, entry);
-	return new;
-
-alloc_failed:
-	pr_err("memory allocation failed\n");
-	return NULL;
-}
-
-bool match_callstack_filter(struct machine *machine, u64 *callstack)
-{
-	struct map *kmap;
-	struct symbol *sym;
-	u64 ip;
-	const char *arch = perf_env__arch(machine->env);
-
-	if (list_empty(&callstack_filters))
-		return true;
-
-	for (int i = 0; i < max_stack_depth; i++) {
-		struct callstack_filter *filter;
-
-		/*
-		 * In powerpc, the callchain saved by kernel always includes
-		 * first three entries as the NIP (next instruction pointer),
-		 * LR (link register), and the contents of LR save area in the
-		 * second stack frame. In certain scenarios its possible to have
-		 * invalid kernel instruction addresses in either LR or the second
-		 * stack frame's LR. In that case, kernel will store that address as
-		 * zero.
-		 *
-		 * The below check will continue to look into callstack,
-		 * incase first or second callstack index entry has 0
-		 * address for powerpc.
-		 */
-		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
-						(i != 1 && i != 2))))
-			break;
-
-		ip = callstack[i];
-		sym = machine__find_kernel_symbol(machine, ip, &kmap);
-		if (sym == NULL)
-			continue;
-
-		list_for_each_entry(filter, &callstack_filters, list) {
-			if (strstr(sym->name, filter->name))
-				return true;
-		}
-	}
-	return false;
-}
-
 struct trace_lock_handler {
 	/* it's used on CONFIG_LOCKDEP */
 	int (*acquire_event)(struct evsel *evsel,
@@ -1165,7 +1058,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
 		if (callstack == NULL)
 			return -ENOMEM;
 
-		if (!match_callstack_filter(machine, callstack)) {
+		if (!match_callstack_filter(machine, callstack, max_stack_depth)) {
 			free(callstack);
 			return 0;
 		}
@@ -2449,34 +2342,6 @@ static int parse_lock_addr(const struct option *opt __maybe_unused, const char *
 	return ret;
 }
 
-static int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
-			   int unset __maybe_unused)
-{
-	char *s, *tmp, *tok;
-	int ret = 0;
-
-	s = strdup(str);
-	if (s == NULL)
-		return -1;
-
-	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
-		struct callstack_filter *entry;
-
-		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
-		if (entry == NULL) {
-			pr_err("Memory allocation failure\n");
-			free(s);
-			return -1;
-		}
-
-		strcpy(entry->name, tok);
-		list_add_tail(&entry->list, &callstack_filters);
-	}
-
-	free(s);
-	return ret;
-}
-
 static int parse_output(const struct option *opt __maybe_unused, const char *str,
 			int unset __maybe_unused)
 {
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 340544a6f5ec..3c6cd8d81d88 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -121,6 +121,7 @@ perf-util-y += topdown.o
 perf-util-y += iostat.o
 perf-util-y += stream.o
 perf-util-y += kvm-stat.o
+perf-util-y += lock-contention.o
 perf-util-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-util-y += intel-pt-decoder/
 perf-util-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index 41a1ad087895..37e17c56f106 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -458,7 +458,7 @@ int lock_contention_read(struct lock_contention *con)
 		if (con->save_callstack) {
 			bpf_map_lookup_elem(stack, &key.stack_id, stack_trace);
 
-			if (!match_callstack_filter(machine, stack_trace)) {
+			if (!match_callstack_filter(machine, stack_trace, con->max_stack)) {
 				con->nr_filtered += data.count;
 				goto next;
 			}
diff --git a/tools/perf/util/lock-contention.c b/tools/perf/util/lock-contention.c
new file mode 100644
index 000000000000..841bb18b1f06
--- /dev/null
+++ b/tools/perf/util/lock-contention.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
+#include "env.h"
+#include "lock-contention.h"
+#include "machine.h"
+#include "symbol.h"
+
+#include <limits.h>
+#include <string.h>
+
+#include <linux/hash.h>
+#include <linux/zalloc.h>
+
+#define __lockhashfn(key)	hash_long((unsigned long)key, LOCKHASH_BITS)
+#define lockhashentry(key)	(lockhash_table + __lockhashfn((key)))
+
+struct callstack_filter {
+	struct list_head list;
+	char name[];
+};
+
+static LIST_HEAD(callstack_filters);
+struct hlist_head *lockhash_table;
+
+int parse_call_stack(const struct option *opt __maybe_unused, const char *str,
+		     int unset __maybe_unused)
+{
+	char *s, *tmp, *tok;
+	int ret = 0;
+
+	s = strdup(str);
+	if (s == NULL)
+		return -1;
+
+	for (tok = strtok_r(s, ", ", &tmp); tok; tok = strtok_r(NULL, ", ", &tmp)) {
+		struct callstack_filter *entry;
+
+		entry = malloc(sizeof(*entry) + strlen(tok) + 1);
+		if (entry == NULL) {
+			pr_err("Memory allocation failure\n");
+			free(s);
+			return -1;
+		}
+
+		strcpy(entry->name, tok);
+		list_add_tail(&entry->list, &callstack_filters);
+	}
+
+	free(s);
+	return ret;
+}
+
+bool needs_callstack(void)
+{
+	return !list_empty(&callstack_filters);
+}
+
+struct lock_stat *lock_stat_find(u64 addr)
+{
+	struct hlist_head *entry = lockhashentry(addr);
+	struct lock_stat *ret;
+
+	hlist_for_each_entry(ret, entry, hash_entry) {
+		if (ret->addr == addr)
+			return ret;
+	}
+	return NULL;
+}
+
+struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags)
+{
+	struct hlist_head *entry = lockhashentry(addr);
+	struct lock_stat *ret, *new;
+
+	hlist_for_each_entry(ret, entry, hash_entry) {
+		if (ret->addr == addr)
+			return ret;
+	}
+
+	new = zalloc(sizeof(struct lock_stat));
+	if (!new)
+		goto alloc_failed;
+
+	new->addr = addr;
+	new->name = strdup(name);
+	if (!new->name) {
+		free(new);
+		goto alloc_failed;
+	}
+
+	new->flags = flags;
+	new->wait_time_min = ULLONG_MAX;
+
+	hlist_add_head(&new->hash_entry, entry);
+	return new;
+
+alloc_failed:
+	pr_err("memory allocation failed\n");
+	return NULL;
+}
+
+bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth)
+{
+	struct map *kmap;
+	struct symbol *sym;
+	u64 ip;
+	const char *arch = perf_env__arch(machine->env);
+
+	if (list_empty(&callstack_filters))
+		return true;
+
+	for (int i = 0; i < max_stack_depth; i++) {
+		struct callstack_filter *filter;
+
+		/*
+		 * In powerpc, the callchain saved by kernel always includes
+		 * first three entries as the NIP (next instruction pointer),
+		 * LR (link register), and the contents of LR save area in the
+		 * second stack frame. In certain scenarios its possible to have
+		 * invalid kernel instruction addresses in either LR or the second
+		 * stack frame's LR. In that case, kernel will store that address as
+		 * zero.
+		 *
+		 * The below check will continue to look into callstack,
+		 * incase first or second callstack index entry has 0
+		 * address for powerpc.
+		 */
+		if (!callstack || (!callstack[i] && (strcmp(arch, "powerpc") ||
+						(i != 1 && i != 2))))
+			break;
+
+		ip = callstack[i];
+		sym = machine__find_kernel_symbol(machine, ip, &kmap);
+		if (sym == NULL)
+			continue;
+
+		list_for_each_entry(filter, &callstack_filters, list) {
+			if (strstr(sym->name, filter->name))
+				return true;
+		}
+	}
+	return false;
+}
+
+#ifndef HAVE_BPF_SKEL
+int lock_contention_prepare(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
+
+int lock_contention_start(void)
+{
+	return 0;
+}
+
+int lock_contention_stop(void)
+{
+	return 0;
+}
+
+int lock_contention_finish(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
+
+int lock_contention_read(struct lock_contention *con __maybe_unused)
+{
+	return 0;
+}
+#endif  /* !HAVE_BPF_SKEL */
diff --git a/tools/perf/util/lock-contention.h b/tools/perf/util/lock-contention.h
index 1a7248ff3889..bfa5c7db0a5d 100644
--- a/tools/perf/util/lock-contention.h
+++ b/tools/perf/util/lock-contention.h
@@ -67,10 +67,11 @@ struct lock_stat {
  */
 #define MAX_LOCK_DEPTH 48
 
-struct lock_stat *lock_stat_find(u64 addr);
-struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
+/* based on kernel/lockdep.c */
+#define LOCKHASH_BITS		12
+#define LOCKHASH_SIZE		(1UL << LOCKHASH_BITS)
 
-bool match_callstack_filter(struct machine *machine, u64 *callstack);
+extern struct hlist_head *lockhash_table;
 
 /*
  * struct lock_seq_stat:
@@ -148,7 +149,14 @@ struct lock_contention {
 	bool save_callstack;
 };
 
-#ifdef HAVE_BPF_SKEL
+struct option;
+int parse_call_stack(const struct option *opt, const char *str, int unset);
+bool needs_callstack(void);
+
+struct lock_stat *lock_stat_find(u64 addr);
+struct lock_stat *lock_stat_findnew(u64 addr, const char *name, int flags);
+
+bool match_callstack_filter(struct machine *machine, u64 *callstack, int max_stack_depth);
 
 int lock_contention_prepare(struct lock_contention *con);
 int lock_contention_start(void);
@@ -156,25 +164,4 @@ int lock_contention_stop(void);
 int lock_contention_read(struct lock_contention *con);
 int lock_contention_finish(struct lock_contention *con);
 
-#else  /* !HAVE_BPF_SKEL */
-
-static inline int lock_contention_prepare(struct lock_contention *con __maybe_unused)
-{
-	return 0;
-}
-
-static inline int lock_contention_start(void) { return 0; }
-static inline int lock_contention_stop(void) { return 0; }
-static inline int lock_contention_finish(struct lock_contention *con __maybe_unused)
-{
-	return 0;
-}
-
-static inline int lock_contention_read(struct lock_contention *con __maybe_unused)
-{
-	return 0;
-}
-
-#endif  /* HAVE_BPF_SKEL */
-
 #endif  /* PERF_LOCK_CONTENTION_H */
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 35d84a96dbec..91fd444615cd 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -18,7 +18,6 @@
 #include "mmap.h"
 #include "util/kwork.h"
 #include "util/sample.h"
-#include "util/lock-contention.h"
 #include <internal/lib.h>
 #include "../builtin.h"
 
@@ -1311,22 +1310,6 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 	return NULL;
 }
 
-bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
-{
-	return false;
-}
-
-struct lock_stat *lock_stat_find(u64 addr __maybe_unused)
-{
-	return NULL;
-}
-
-struct lock_stat *lock_stat_findnew(u64 addr __maybe_unused, const char *name __maybe_unused,
-				int flags __maybe_unused)
-{
-	return NULL;
-}
-
 int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
 {
 	return -1;
-- 
2.47.0.163.g1226f6d8fa-goog


