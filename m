Return-Path: <linux-kernel+bounces-264939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E366B93EA5D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985A3280C68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 00:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E78CFBFD;
	Mon, 29 Jul 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc3Kb0XZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F98F72;
	Mon, 29 Jul 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213691; cv=none; b=CzZcqCNMwovdGbPtil7mtGROkH0m3SXayZAS7xKA6Cf+Fhf83kwReAvoIpLMl+jddWkjhbTb360pR/jH6Bor+xc2R+C6L2XIHhfVRS9klyvYLRXLMku2Aj7kUYF6bmluWwhzsTyxkmqsF2/OmVqhJJB05ioFYZs7YBlsk7U9Nuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213691; c=relaxed/simple;
	bh=1Mmp/w3vfm1R4mAz1PWP95agTnfr8xNHOGqUFP4LtVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feztMe8KXjzfyn+87b6Quz4qKnIppAMIW6XpEEd0MWBq6o9SoHIntSMcJRxKFXKvv05aP5qRppLR+c/VXo6yfM+wbgwGUN6EuhbgyvF4h0j7u851TJ5JlhVRTUjyfmMxQRiT7I5RY4Uh81FViJ7ifF0x5TAY3GoAwqtjRo2WOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc3Kb0XZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DC9C4AF10;
	Mon, 29 Jul 2024 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722213690;
	bh=1Mmp/w3vfm1R4mAz1PWP95agTnfr8xNHOGqUFP4LtVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pc3Kb0XZw5yw/NiNjK8yI01Hgdr4Z+OVDzsDvJ4QyZCazu37CGOJHjYgvopz3n2bF
	 c7OLf3tz3ydJzBUFCITZw+aNYnmPHVF9PH/7eUjU71eM2M7gbTykIRM+NMc38f0pid
	 4wV6vl/0c5s2XxrsygNBHGzDaCxcpFOWRq5G6gOnADfi6jRNd6xckDX9FFS7BK+lRA
	 6eMb7E3CfundZMnpcAhPx/YiAFsSKJfJ1pDzJfSKR7JXWU3+/ROSiBmiH6KuNCujNl
	 pPmDYC3BVn0pUHFZ6c0TdGiqUL6KRHCa6pOT6ewKhkr8Eu5zHa02qQgfuIx3DxxKOs
	 0czqlbTwr4xCA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 3/4] perf ftrace: Add 'profile' command
Date: Sun, 28 Jul 2024 17:41:26 -0700
Message-ID: <20240729004127.238611-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240729004127.238611-1-namhyung@kernel.org>
References: <20240729004127.238611-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'perf ftrace profile' command is to get function execution profiles
using function-graph tracer so that users can see the total, average,
max execution time as well as the number of invocation easily.

The following is a profile for perf_event_open syscall.

  $ sudo perf ftrace profile -G __x64_sys_perf_event_open -- \
    perf stat -e cycles -C1 true 2> /dev/null | head
  # Total (us)   Avg (us)   Max (us)      Count   Function
        65.611     65.611     65.611          1   __x64_sys_perf_event_open
        30.527     30.527     30.527          1   anon_inode_getfile
        30.260     30.260     30.260          1   __anon_inode_getfile
        29.700     29.700     29.700          1   alloc_file_pseudo
        17.578     17.578     17.578          1   d_alloc_pseudo
        17.382     17.382     17.382          1   __d_alloc
        16.738     16.738     16.738          1   kmem_cache_alloc_lru
        15.686     15.686     15.686          1   perf_event_alloc
        14.012      7.006     11.264          2   obj_cgroup_charge

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt |  42 ++-
 tools/perf/builtin-ftrace.c              | 318 ++++++++++++++++++++++-
 tools/perf/util/ftrace.h                 |   2 +
 3 files changed, 359 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 7ea1645a13cf..33f32467f287 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -9,7 +9,7 @@ perf-ftrace - simple wrapper for kernel's ftrace functionality
 SYNOPSIS
 --------
 [verse]
-'perf ftrace' {trace|latency} <command>
+'perf ftrace' {trace|latency|profile} <command>
 
 DESCRIPTION
 -----------
@@ -23,6 +23,9 @@ kernel's ftrace infrastructure.
   'perf ftrace latency' calculates execution latency of a given function
   (optionally with BPF) and display it as a histogram.
 
+  'perf ftrace profile' show a execution profile for each function including
+  total, average, max time and the number of calls.
+
 The following options apply to perf ftrace.
 
 COMMON OPTIONS
@@ -146,6 +149,43 @@ OPTIONS for 'perf ftrace latency'
 	Use nano-second instead of micro-second as a base unit of the histogram.
 
 
+OPTIONS for 'perf ftrace profile'
+---------------------------------
+
+-T::
+--trace-funcs=::
+	Set function filter on the given function (or a glob pattern).
+	Multiple functions can be given by using this option more than once.
+	The function argument also can be a glob pattern. It will be passed
+	to 'set_ftrace_filter' in tracefs.
+
+-N::
+--notrace-funcs=::
+	Do not trace functions given by the argument.  Like -T option, this
+	can be used more than once to specify multiple functions (or glob
+	patterns).  It will be passed to 'set_ftrace_notrace' in tracefs.
+
+-G::
+--graph-funcs=::
+	Set graph filter on the given function (or a glob pattern). This is
+	useful to trace for functions executed from the given function. This
+	can be used more than once to specify multiple functions. It will be
+	passed to 'set_graph_function' in tracefs.
+
+-g::
+--nograph-funcs=::
+	Set graph notrace filter on the given function (or a glob pattern).
+	Like -G option, this is useful for the function_graph tracer only and
+	disables tracing for function executed from the given function. This
+	can be used more than once to specify multiple functions. It will be
+	passed to 'set_graph_notrace' in tracefs.
+
+-m::
+--buffer-size::
+	Set the size of per-cpu tracing buffer, <size> is expected to
+	be a number with appended unit character - B/K/M/G.
+
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 978608ecd89c..ae9389435d1b 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -13,6 +13,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <fcntl.h>
+#include <inttypes.h>
 #include <math.h>
 #include <poll.h>
 #include <ctype.h>
@@ -22,15 +23,18 @@
 #include "debug.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
+#include <api/io.h>
 #include <api/fs/tracing_path.h>
 #include "evlist.h"
 #include "target.h"
 #include "cpumap.h"
+#include "hashmap.h"
 #include "thread_map.h"
 #include "strfilter.h"
 #include "util/cap.h"
 #include "util/config.h"
 #include "util/ftrace.h"
+#include "util/stat.h"
 #include "util/units.h"
 #include "util/parse-sublevel-options.h"
 
@@ -959,6 +963,294 @@ static int __cmd_latency(struct perf_ftrace *ftrace)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
+static size_t profile_hash(long func, void *ctx __maybe_unused)
+{
+	return str_hash((char *)func);
+}
+
+static bool profile_equal(long func1, long func2, void *ctx __maybe_unused)
+{
+	return !strcmp((char *)func1, (char *)func2);
+}
+
+static int prepare_func_profile(struct perf_ftrace *ftrace)
+{
+	ftrace->tracer = "function_graph";
+	ftrace->graph_tail = 1;
+
+	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
+	if (ftrace->profile_hash == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* This is saved in a hashmap keyed by the function name */
+struct ftrace_profile_data {
+	struct stats st;
+};
+
+static int add_func_duration(struct perf_ftrace *ftrace, char *func, double time_ns)
+{
+	struct ftrace_profile_data *prof = NULL;
+
+	if (!hashmap__find(ftrace->profile_hash, func, &prof)) {
+		char *key = strdup(func);
+
+		if (key == NULL)
+			return -ENOMEM;
+
+		prof = zalloc(sizeof(*prof));
+		if (prof == NULL) {
+			free(key);
+			return -ENOMEM;
+		}
+
+		init_stats(&prof->st);
+		hashmap__add(ftrace->profile_hash, key, prof);
+	}
+
+	update_stats(&prof->st, time_ns);
+	return 0;
+}
+
+/*
+ * The ftrace function_graph text output normally looks like below:
+ *
+ * CPU   DURATION       FUNCTION
+ *
+ *  0)               |  syscall_trace_enter.isra.0() {
+ *  0)               |    __audit_syscall_entry() {
+ *  0)               |      auditd_test_task() {
+ *  0)   0.271 us    |        __rcu_read_lock();
+ *  0)   0.275 us    |        __rcu_read_unlock();
+ *  0)   1.254 us    |      } /\* auditd_test_task *\/
+ *  0)   0.279 us    |      ktime_get_coarse_real_ts64();
+ *  0)   2.227 us    |    } /\* __audit_syscall_entry *\/
+ *  0)   2.713 us    |  } /\* syscall_trace_enter.isra.0 *\/
+ *
+ *  Parse the line and get the duration and function name.
+ */
+static int parse_func_duration(struct perf_ftrace *ftrace, char *line, size_t len)
+{
+	char *p;
+	char *func;
+	double duration;
+
+	/* skip CPU */
+	p = strchr(line, ')');
+	if (p == NULL)
+		return 0;
+
+	/* get duration */
+	p = skip_spaces(p + 1);
+
+	/* no duration? */
+	if (p == NULL || *p == '|')
+		return 0;
+
+	/* skip markers like '*' or '!' for longer than ms */
+	if (!isdigit(*p))
+		p++;
+
+	duration = strtod(p, &p);
+
+	if (strncmp(p, " us", 3)) {
+		pr_debug("non-usec time found.. ignoring\n");
+		return 0;
+	}
+
+	/*
+	 * profile stat keeps the max and min values as integer,
+	 * convert to nsec time so that we can have accurate max.
+	 */
+	duration *= 1000;
+
+	/* skip to the pipe */
+	while (p < line + len && *p != '|')
+		p++;
+
+	if (*p++ != '|')
+		return -EINVAL;
+
+	/* get function name */
+	func = skip_spaces(p);
+
+	/* skip the closing bracket and the start of comment */
+	if (*func == '}')
+		func += 5;
+
+	/* remove semi-colon or end of comment at the end */
+	p = line + len - 1;
+	while (!isalnum(*p) && *p != ']') {
+		*p = '\0';
+		--p;
+	}
+
+	return add_func_duration(ftrace, func, duration);
+}
+
+static int cmp_profile_data(const void *a, const void *b)
+{
+	const struct hashmap_entry *e1 = *(const struct hashmap_entry **)a;
+	const struct hashmap_entry *e2 = *(const struct hashmap_entry **)b;
+	struct ftrace_profile_data *p1 = e1->pvalue;
+	struct ftrace_profile_data *p2 = e2->pvalue;
+
+	/* compare by total time */
+	if ((p1->st.n * p1->st.mean) > (p2->st.n * p2->st.mean))
+		return -1;
+	else
+		return 1;
+}
+
+static void print_profile_result(struct perf_ftrace *ftrace)
+{
+	struct hashmap_entry *entry, **profile;
+	size_t i, nr, bkt;
+
+	nr = hashmap__size(ftrace->profile_hash);
+	if (nr == 0)
+		return;
+
+	profile = calloc(nr, sizeof(*profile));
+	if (profile == NULL) {
+		pr_err("failed to allocate memory for the result\n");
+		return;
+	}
+
+	i = 0;
+	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt)
+		profile[i++] = entry;
+
+	assert(i == nr);
+
+	//cmp_profile_data(profile[0], profile[1]);
+	qsort(profile, nr, sizeof(*profile), cmp_profile_data);
+
+	printf("# %10s %10s %10s %10s   %s\n",
+	       "Total (us)", "Avg (us)", "Max (us)", "Count", "Function");
+
+	for (i = 0; i < nr; i++) {
+		const char *name = profile[i]->pkey;
+		struct ftrace_profile_data *p = profile[i]->pvalue;
+
+		printf("%12.3f %10.3f %6"PRIu64".%03"PRIu64" %10.0f   %s\n",
+		       p->st.n * p->st.mean / 1000, p->st.mean / 1000,
+		       p->st.max / 1000, p->st.max % 1000, p->st.n, name);
+	}
+
+	free(profile);
+
+	hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
+		free((char *)entry->pkey);
+		free(entry->pvalue);
+	}
+
+	hashmap__free(ftrace->profile_hash);
+	ftrace->profile_hash = NULL;
+}
+
+static int __cmd_profile(struct perf_ftrace *ftrace)
+{
+	char *trace_file;
+	int trace_fd;
+	char buf[4096];
+	struct io io;
+	char *line = NULL;
+	size_t line_len = 0;
+
+	if (prepare_func_profile(ftrace) < 0) {
+		pr_err("failed to prepare func profiler\n");
+		goto out;
+	}
+
+	if (reset_tracing_files(ftrace) < 0) {
+		pr_err("failed to reset ftrace\n");
+		goto out;
+	}
+
+	/* reset ftrace buffer */
+	if (write_tracing_file("trace", "0") < 0)
+		goto out;
+
+	if (set_tracing_options(ftrace) < 0)
+		return -1;
+
+	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
+		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
+		goto out_reset;
+	}
+
+	setup_pager();
+
+	trace_file = get_tracing_file("trace_pipe");
+	if (!trace_file) {
+		pr_err("failed to open trace_pipe\n");
+		goto out_reset;
+	}
+
+	trace_fd = open(trace_file, O_RDONLY);
+
+	put_tracing_file(trace_file);
+
+	if (trace_fd < 0) {
+		pr_err("failed to open trace_pipe\n");
+		goto out_reset;
+	}
+
+	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
+
+	if (write_tracing_file("tracing_on", "1") < 0) {
+		pr_err("can't enable tracing\n");
+		goto out_close_fd;
+	}
+
+	evlist__start_workload(ftrace->evlist);
+
+	io__init(&io, trace_fd, buf, sizeof(buf));
+	io.timeout_ms = -1;
+
+	while (!done && !io.eof) {
+		if (io__getline(&io, &line, &line_len) < 0)
+			break;
+
+		if (parse_func_duration(ftrace, line, line_len) < 0)
+			break;
+	}
+
+	write_tracing_file("tracing_on", "0");
+
+	if (workload_exec_errno) {
+		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		/* flush stdout first so below error msg appears at the end. */
+		fflush(stdout);
+		pr_err("workload failed: %s\n", emsg);
+		goto out_free_line;
+	}
+
+	/* read remaining buffer contents */
+	io.timeout_ms = 0;
+	while (!io.eof) {
+		if (io__getline(&io, &line, &line_len) < 0)
+			break;
+
+		if (parse_func_duration(ftrace, line, line_len) < 0)
+			break;
+	}
+
+	print_profile_result(ftrace);
+
+out_free_line:
+	free(line);
+out_close_fd:
+	close(trace_fd);
+out_reset:
+	reset_tracing_files(ftrace);
+out:
+	return (done && !workload_exec_errno) ? 0 : -1;
+}
+
 static int perf_ftrace_config(const char *var, const char *value, void *cb)
 {
 	struct perf_ftrace *ftrace = cb;
@@ -1126,6 +1418,7 @@ enum perf_ftrace_subcommand {
 	PERF_FTRACE_NONE,
 	PERF_FTRACE_TRACE,
 	PERF_FTRACE_LATENCY,
+	PERF_FTRACE_PROFILE,
 };
 
 int cmd_ftrace(int argc, const char **argv)
@@ -1191,13 +1484,28 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Use nano-second histogram"),
 	OPT_PARENT(common_options),
 	};
+	const struct option profile_options[] = {
+	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
+		     "Trace given functions using function tracer",
+		     parse_filter_func),
+	OPT_CALLBACK('N', "notrace-funcs", &ftrace.notrace, "func",
+		     "Do not trace given functions", parse_filter_func),
+	OPT_CALLBACK('G', "graph-funcs", &ftrace.graph_funcs, "func",
+		     "Trace given functions using function_graph tracer",
+		     parse_filter_func),
+	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
+		     "Set nograph filter on given functions", parse_filter_func),
+	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
+		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
+	OPT_PARENT(common_options),
+	};
 	const struct option *options = ftrace_options;
 
 	const char * const ftrace_usage[] = {
 		"perf ftrace [<options>] [<command>]",
 		"perf ftrace [<options>] -- [<command>] [<options>]",
-		"perf ftrace {trace|latency} [<options>] [<command>]",
-		"perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]",
+		"perf ftrace {trace|latency|profile} [<options>] [<command>]",
+		"perf ftrace {trace|latency|profile} [<options>] -- [<command>] [<options>]",
 		NULL
 	};
 	enum perf_ftrace_subcommand subcmd = PERF_FTRACE_NONE;
@@ -1226,6 +1534,9 @@ int cmd_ftrace(int argc, const char **argv)
 		} else if (!strcmp(argv[1], "latency")) {
 			subcmd = PERF_FTRACE_LATENCY;
 			options = latency_options;
+		} else if (!strcmp(argv[1], "profile")) {
+			subcmd = PERF_FTRACE_PROFILE;
+			options = profile_options;
 		}
 
 		if (subcmd != PERF_FTRACE_NONE) {
@@ -1261,6 +1572,9 @@ int cmd_ftrace(int argc, const char **argv)
 		}
 		cmd_func = __cmd_latency;
 		break;
+	case PERF_FTRACE_PROFILE:
+		cmd_func = __cmd_profile;
+		break;
 	case PERF_FTRACE_NONE:
 	default:
 		pr_err("Invalid subcommand\n");
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 2515e841c64c..bae649ef50e8 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -6,6 +6,7 @@
 #include "target.h"
 
 struct evlist;
+struct hashamp;
 
 struct perf_ftrace {
 	struct evlist		*evlist;
@@ -15,6 +16,7 @@ struct perf_ftrace {
 	struct list_head	notrace;
 	struct list_head	graph_funcs;
 	struct list_head	nograph_funcs;
+	struct hashmap		*profile_hash;
 	unsigned long		percpu_buffer_size;
 	bool			inherit;
 	bool			use_nsec;
-- 
2.46.0.rc1.232.g9752f9e123-goog


