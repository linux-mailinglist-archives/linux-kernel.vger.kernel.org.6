Return-Path: <linux-kernel+bounces-549625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF3A554AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4825518859F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6926E153;
	Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB725A352
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285104; cv=none; b=cCYHgmckdDGrMpyIriKtLaQRogETCPCvaQP4HwD8e4QJTjHFHM1pzUUk15aKUkLXm6BpgY0NgHGAFRHgFySfRu7fLm6kREGH3RBLjUaf4cBEsMBVx/hGs2VtVUvU8EddH9C7bzikL9tyHGyMxHyehSx8nrCwCpTXnPph+6KocPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285104; c=relaxed/simple;
	bh=FfEjKuJiNgHIPyUUV8qxwFx6AfmL84iNsoSiLWHBSXs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eXZ4uSeF8R0SnEecZgOVb7uY7OxRTTZNcwfSLtLgCHYrJVx84dadfxNcxqa+atg/oqykZBqQBEvWlCJ+1dlgEm8Zyljq0hA7su9KTKkP63jPf2TMwaQwJYwfTNlLfOUeuAjryl6xGlxxL+e10xJjX9pQw6V/DM/qwZuQ++P+IXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A798C4CEE4;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFnd-00000000PFf-2qBr;
	Thu, 06 Mar 2025 13:18:25 -0500
Message-ID: <20250306181825.533946130@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 01/10] rtla/timerlat: Unify params struct
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Instead of having separate structs timerlat_top_params and
timerlat_hist_params, use one struct timerlat_params for both.

This allows code using the structs to be shared between timerlat-top and
timerlat-hist.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.h       |  2 +
 tools/tracing/rtla/src/timerlat.h      | 54 ++++++++++++++++++++++
 tools/tracing/rtla/src/timerlat_aa.c   |  2 -
 tools/tracing/rtla/src/timerlat_hist.c | 62 +++++---------------------
 tools/tracing/rtla/src/timerlat_top.c  | 57 +++++------------------
 5 files changed, 78 insertions(+), 99 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 91835a7d8c2b..056c8b113dee 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -1,4 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
+#pragma once
+
 #include "trace.h"
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index 88561bfd14f3..e452d385cb0f 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,4 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0
+#include "utils.h"
+#include "osnoise.h"
+
+struct timerlat_params {
+	/* Common params */
+	char			*cpus;
+	cpu_set_t		monitored_cpus;
+	char			*trace_output;
+	char			*cgroup_name;
+	unsigned long long	runtime;
+	long long		stop_us;
+	long long		stop_total_us;
+	long long		timerlat_period_us;
+	long long		print_stack;
+	int			sleep_time;
+	int			output_divisor;
+	int			duration;
+	int			quiet;
+	int			set_sched;
+	int			dma_latency;
+	int			no_aa;
+	int			aa_only;
+	int			dump_tasks;
+	int			cgroup;
+	int			hk_cpus;
+	int			user_workload;
+	int			kernel_workload;
+	int			pretty_output;
+	int			warmup;
+	int			buffer_size;
+	int			deepest_idle_state;
+	cpu_set_t		hk_cpu_set;
+	struct sched_attr	sched_param;
+	struct trace_events	*events;
+	union {
+		struct {
+			/* top only */
+			int			user_top;
+		};
+		struct {
+			/* hist only */
+			int			user_hist;
+			char			no_irq;
+			char			no_thread;
+			char			no_header;
+			char			no_summary;
+			char			no_index;
+			char			with_zeros;
+			int			bucket_size;
+			int			entries;
+		};
+	};
+};
+
 int timerlat_hist_main(int argc, char *argv[]);
 int timerlat_top_main(int argc, char *argv[]);
 int timerlat_main(int argc, char *argv[]);
diff --git a/tools/tracing/rtla/src/timerlat_aa.c b/tools/tracing/rtla/src/timerlat_aa.c
index 7bd80ee2a5b4..31e66ea2b144 100644
--- a/tools/tracing/rtla/src/timerlat_aa.c
+++ b/tools/tracing/rtla/src/timerlat_aa.c
@@ -5,8 +5,6 @@
 
 #include <stdlib.h>
 #include <errno.h>
-#include "utils.h"
-#include "osnoise.h"
 #include "timerlat.h"
 #include <unistd.h>
 
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 6d7d0a2d45b4..fe683a20b0e2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -14,50 +14,10 @@
 #include <sched.h>
 #include <pthread.h>
 
-#include "utils.h"
-#include "osnoise.h"
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_u.h"
 
-struct timerlat_hist_params {
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*trace_output;
-	char			*cgroup_name;
-	unsigned long long	runtime;
-	long long		stop_us;
-	long long		stop_total_us;
-	long long		timerlat_period_us;
-	long long		print_stack;
-	int			sleep_time;
-	int			output_divisor;
-	int			duration;
-	int			set_sched;
-	int			dma_latency;
-	int			cgroup;
-	int			hk_cpus;
-	int			no_aa;
-	int			dump_tasks;
-	int			user_workload;
-	int			kernel_workload;
-	int			user_hist;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
-	char			no_irq;
-	char			no_thread;
-	char			no_header;
-	char			no_summary;
-	char			no_index;
-	char			with_zeros;
-	int			bucket_size;
-	int			entries;
-	int			warmup;
-	int			buffer_size;
-	int			deepest_idle_state;
-};
-
 struct timerlat_hist_cpu {
 	int			*irq;
 	int			*thread;
@@ -174,7 +134,7 @@ timerlat_hist_update(struct osnoise_tool *tool, int cpu,
 		     unsigned long long context,
 		     unsigned long long latency)
 {
-	struct timerlat_hist_params *params = tool->params;
+	struct timerlat_params *params = tool->params;
 	struct timerlat_hist_data *data = tool->data;
 	int entries = data->entries;
 	int bucket;
@@ -238,7 +198,7 @@ timerlat_hist_handler(struct trace_seq *s, struct tep_record *record,
  */
 static void timerlat_hist_header(struct osnoise_tool *tool)
 {
-	struct timerlat_hist_params *params = tool->params;
+	struct timerlat_params *params = tool->params;
 	struct timerlat_hist_data *data = tool->data;
 	struct trace_seq *s = tool->trace.seq;
 	char duration[26];
@@ -300,7 +260,7 @@ static void format_summary_value(struct trace_seq *seq,
  * timerlat_print_summary - print the summary of the hist data to the output
  */
 static void
-timerlat_print_summary(struct timerlat_hist_params *params,
+timerlat_print_summary(struct timerlat_params *params,
 		       struct trace_instance *trace,
 		       struct timerlat_hist_data *data)
 {
@@ -427,7 +387,7 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 }
 
 static void
-timerlat_print_stats_all(struct timerlat_hist_params *params,
+timerlat_print_stats_all(struct timerlat_params *params,
 			 struct trace_instance *trace,
 			 struct timerlat_hist_data *data)
 {
@@ -575,7 +535,7 @@ timerlat_print_stats_all(struct timerlat_hist_params *params,
  * timerlat_print_stats - print data for each CPUs
  */
 static void
-timerlat_print_stats(struct timerlat_hist_params *params, struct osnoise_tool *tool)
+timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *tool)
 {
 	struct timerlat_hist_data *data = tool->data;
 	struct trace_instance *trace = &tool->trace;
@@ -734,10 +694,10 @@ static void timerlat_hist_usage(char *usage)
 /*
  * timerlat_hist_parse_args - allocs, parse and fill the cmd line parameters
  */
-static struct timerlat_hist_params
+static struct timerlat_params
 *timerlat_hist_parse_args(int argc, char *argv[])
 {
-	struct timerlat_hist_params *params;
+	struct timerlat_params *params;
 	struct trace_events *tevent;
 	int auto_thresh;
 	int retval;
@@ -1017,7 +977,7 @@ static struct timerlat_hist_params
  * timerlat_hist_apply_config - apply the hist configs to the initialized tool
  */
 static int
-timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_params *params)
+timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_params *params)
 {
 	int retval, i;
 
@@ -1122,7 +1082,7 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
  * timerlat_init_hist - initialize a timerlat hist tool with parameters
  */
 static struct osnoise_tool
-*timerlat_init_hist(struct timerlat_hist_params *params)
+*timerlat_init_hist(struct timerlat_params *params)
 {
 	struct osnoise_tool *tool;
 	int nr_cpus;
@@ -1170,7 +1130,7 @@ static void stop_hist(int sig)
  * timerlat_hist_set_signals - handles the signal to stop the tool
  */
 static void
-timerlat_hist_set_signals(struct timerlat_hist_params *params)
+timerlat_hist_set_signals(struct timerlat_params *params)
 {
 	signal(SIGINT, stop_hist);
 	if (params->duration) {
@@ -1181,7 +1141,7 @@ timerlat_hist_set_signals(struct timerlat_hist_params *params)
 
 int timerlat_hist_main(int argc, char *argv[])
 {
-	struct timerlat_hist_params *params;
+	struct timerlat_params *params;
 	struct osnoise_tool *record = NULL;
 	struct timerlat_u_params params_u;
 	struct osnoise_tool *tool = NULL;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 05a9403b01d2..97eead91decc 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -15,45 +15,10 @@
 #include <sched.h>
 #include <pthread.h>
 
-#include "utils.h"
-#include "osnoise.h"
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_u.h"
 
-struct timerlat_top_params {
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*trace_output;
-	char			*cgroup_name;
-	unsigned long long	runtime;
-	long long		stop_us;
-	long long		stop_total_us;
-	long long		timerlat_period_us;
-	long long		print_stack;
-	int			sleep_time;
-	int			output_divisor;
-	int			duration;
-	int			quiet;
-	int			set_sched;
-	int			dma_latency;
-	int			no_aa;
-	int			aa_only;
-	int			dump_tasks;
-	int			cgroup;
-	int			hk_cpus;
-	int			user_top;
-	int			user_workload;
-	int			kernel_workload;
-	int			pretty_output;
-	int			warmup;
-	int			buffer_size;
-	int			deepest_idle_state;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
-};
-
 struct timerlat_top_cpu {
 	unsigned long long	irq_count;
 	unsigned long long	thread_count;
@@ -194,7 +159,7 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 		     struct tep_event *event, void *context)
 {
 	struct trace_instance *trace = context;
-	struct timerlat_top_params *params;
+	struct timerlat_params *params;
 	unsigned long long latency, thread;
 	struct osnoise_tool *top;
 	int cpu = record->cpu;
@@ -215,7 +180,7 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 /*
  * timerlat_top_header - print the header of the tool output
  */
-static void timerlat_top_header(struct timerlat_top_params *params, struct osnoise_tool *top)
+static void timerlat_top_header(struct timerlat_params *params, struct osnoise_tool *top)
 {
 	struct trace_seq *s = top->trace.seq;
 	char duration[26];
@@ -263,7 +228,7 @@ static const char *no_value = "        -";
 static void timerlat_top_print(struct osnoise_tool *top, int cpu)
 {
 
-	struct timerlat_top_params *params = top->params;
+	struct timerlat_params *params = top->params;
 	struct timerlat_top_data *data = top->data;
 	struct timerlat_top_cpu *cpu_data = &data->cpu_data[cpu];
 	int divisor = params->output_divisor;
@@ -327,7 +292,7 @@ static void
 timerlat_top_print_sum(struct osnoise_tool *top, struct timerlat_top_cpu *summary)
 {
 	const char *split = "----------------------------------------";
-	struct timerlat_top_params *params = top->params;
+	struct timerlat_params *params = top->params;
 	unsigned long long count = summary->irq_count;
 	int divisor = params->output_divisor;
 	struct trace_seq *s = top->trace.seq;
@@ -404,7 +369,7 @@ static void clear_terminal(struct trace_seq *seq)
  * timerlat_print_stats - print data for all cpus
  */
 static void
-timerlat_print_stats(struct timerlat_top_params *params, struct osnoise_tool *top)
+timerlat_print_stats(struct timerlat_params *params, struct osnoise_tool *top)
 {
 	struct trace_instance *trace = &top->trace;
 	struct timerlat_top_cpu summary;
@@ -505,10 +470,10 @@ static void timerlat_top_usage(char *usage)
 /*
  * timerlat_top_parse_args - allocs, parse and fill the cmd line parameters
  */
-static struct timerlat_top_params
+static struct timerlat_params
 *timerlat_top_parse_args(int argc, char **argv)
 {
-	struct timerlat_top_params *params;
+	struct timerlat_params *params;
 	struct trace_events *tevent;
 	long long auto_thresh;
 	int retval;
@@ -765,7 +730,7 @@ static struct timerlat_top_params
  * timerlat_top_apply_config - apply the top configs to the initialized tool
  */
 static int
-timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *params)
+timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_params *params)
 {
 	int retval;
 	int i;
@@ -876,7 +841,7 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
  * timerlat_init_top - initialize a timerlat top tool with parameters
  */
 static struct osnoise_tool
-*timerlat_init_top(struct timerlat_top_params *params)
+*timerlat_init_top(struct timerlat_params *params)
 {
 	struct osnoise_tool *top;
 	int nr_cpus;
@@ -924,7 +889,7 @@ static void stop_top(int sig)
  * timerlat_top_set_signals - handles the signal to stop the tool
  */
 static void
-timerlat_top_set_signals(struct timerlat_top_params *params)
+timerlat_top_set_signals(struct timerlat_params *params)
 {
 	signal(SIGINT, stop_top);
 	if (params->duration) {
@@ -935,7 +900,7 @@ timerlat_top_set_signals(struct timerlat_top_params *params)
 
 int timerlat_top_main(int argc, char *argv[])
 {
-	struct timerlat_top_params *params;
+	struct timerlat_params *params;
 	struct osnoise_tool *record = NULL;
 	struct timerlat_u_params params_u;
 	struct osnoise_tool *top = NULL;
-- 
2.47.2



