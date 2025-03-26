Return-Path: <linux-kernel+bounces-577182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DDA71998
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F73AF978
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A56B1F419D;
	Wed, 26 Mar 2025 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46911F3BA4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000917; cv=none; b=R2g6OYqldkDEK6cOfSil6binEo6YIvQ6VrNu85thH/d8yYkayn7muljiKmZS+QXVisDRPD2qz6jvq933VT83LkNCmQilXRtRnaD/kJuDe33qFylfLsqL1Rdl8pAgNT9e6aeG9r8Oljapd07u34Vj9TpZyV8ka2Q9Flg89EQOwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000917; c=relaxed/simple;
	bh=IaqyKWPwwjeWngeDaXAYsAb/BKumclTNuSAL5upMQ2M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nuUFMXuCr/8NWyky27tC9tlwKaUyyp73pMc2YvTAKHKTJBO/9Hz1pYIvoBPBFJoFJjCON4UgcDG5RDkaM8TEqbqe+UsAQUZkjOI0BjY9dzqplIvq2jo7OjNrEoNTe7M3kV0gucqBLwzmTPJYR1qx8qw6bRrwDaH7IlB9G0JJbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D29C4CEE9;
	Wed, 26 Mar 2025 14:55:17 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txSAm-00000002kDb-1DGH;
	Wed, 26 Mar 2025 10:56:04 -0400
Message-ID: <20250326145604.138550459@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 26 Mar 2025 10:55:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 3/9] rtla/osnoise: Unify params struct
References: <20250326145549.978154551@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Instead of having separate structs osnoise_top_params and
osnoise_hist_params, use one struct osnoise_params for both.

This allows code using the structs to be shared between osnoise-top and
osnoise-hist.

Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250320092500.101385-2-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reviewed-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/osnoise.c      |  1 -
 tools/tracing/rtla/src/osnoise.h      | 47 +++++++++++++++++++++++
 tools/tracing/rtla/src/osnoise_hist.c | 52 ++++++--------------------
 tools/tracing/rtla/src/osnoise_top.c  | 54 +++++----------------------
 tools/tracing/rtla/src/timerlat.h     |  1 -
 5 files changed, 68 insertions(+), 87 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 85f398b89597..93d485c0e949 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -14,7 +14,6 @@
 #include <stdio.h>
 
 #include "osnoise.h"
-#include "utils.h"
 
 /*
  * osnoise_get_cpus - return the original "osnoise/cpus" content
diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 056c8b113dee..f78ffbdc8c8d 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -1,8 +1,55 @@
 // SPDX-License-Identifier: GPL-2.0
 #pragma once
 
+#include "utils.h"
 #include "trace.h"
 
+enum osnoise_mode {
+	MODE_OSNOISE = 0,
+	MODE_HWNOISE
+};
+
+struct osnoise_params {
+	/* Common params */
+	char			*cpus;
+	cpu_set_t		monitored_cpus;
+	char			*trace_output;
+	char			*cgroup_name;
+	unsigned long long	runtime;
+	unsigned long long	period;
+	long long		threshold;
+	long long		stop_us;
+	long long		stop_total_us;
+	int			sleep_time;
+	int			duration;
+	int			set_sched;
+	int			cgroup;
+	int			hk_cpus;
+	cpu_set_t		hk_cpu_set;
+	struct sched_attr	sched_param;
+	struct trace_events	*events;
+	int			warmup;
+	int			buffer_size;
+	union {
+		struct {
+			/* top only */
+			int			quiet;
+			int			pretty_output;
+			enum osnoise_mode	mode;
+		};
+		struct {
+			/* hist only */
+			int			output_divisor;
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
 /*
  * osnoise_context - read, store, write, restore osnoise configs.
  */
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index f4c9051c33c4..4721f15f77cd 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -14,38 +14,8 @@
 #include <time.h>
 #include <sched.h>
 
-#include "utils.h"
 #include "osnoise.h"
 
-struct osnoise_hist_params {
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*trace_output;
-	char			*cgroup_name;
-	unsigned long long	runtime;
-	unsigned long long	period;
-	long long		threshold;
-	long long		stop_us;
-	long long		stop_total_us;
-	int			sleep_time;
-	int			duration;
-	int			set_sched;
-	int			output_divisor;
-	int			cgroup;
-	int			hk_cpus;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
-	char			no_header;
-	char			no_summary;
-	char			no_index;
-	char			with_zeros;
-	int			bucket_size;
-	int			entries;
-	int			warmup;
-	int			buffer_size;
-};
-
 struct osnoise_hist_cpu {
 	int			*samples;
 	int			count;
@@ -126,7 +96,7 @@ static struct osnoise_hist_data
 static void osnoise_hist_update_multiple(struct osnoise_tool *tool, int cpu,
 					 unsigned long long duration, int count)
 {
-	struct osnoise_hist_params *params = tool->params;
+	struct osnoise_params *params = tool->params;
 	struct osnoise_hist_data *data = tool->data;
 	unsigned long long total_duration;
 	int entries = data->entries;
@@ -168,7 +138,7 @@ static void osnoise_destroy_trace_hist(struct osnoise_tool *tool)
  */
 static int osnoise_init_trace_hist(struct osnoise_tool *tool)
 {
-	struct osnoise_hist_params *params = tool->params;
+	struct osnoise_params *params = tool->params;
 	struct osnoise_hist_data *data = tool->data;
 	int bucket_size;
 	char buff[128];
@@ -253,7 +223,7 @@ static void osnoise_read_trace_hist(struct osnoise_tool *tool)
  */
 static void osnoise_hist_header(struct osnoise_tool *tool)
 {
-	struct osnoise_hist_params *params = tool->params;
+	struct osnoise_params *params = tool->params;
 	struct osnoise_hist_data *data = tool->data;
 	struct trace_seq *s = tool->trace.seq;
 	char duration[26];
@@ -292,7 +262,7 @@ static void osnoise_hist_header(struct osnoise_tool *tool)
  * osnoise_print_summary - print the summary of the hist data to the output
  */
 static void
-osnoise_print_summary(struct osnoise_hist_params *params,
+osnoise_print_summary(struct osnoise_params *params,
 		       struct trace_instance *trace,
 		       struct osnoise_hist_data *data)
 {
@@ -370,7 +340,7 @@ osnoise_print_summary(struct osnoise_hist_params *params,
  * osnoise_print_stats - print data for all CPUs
  */
 static void
-osnoise_print_stats(struct osnoise_hist_params *params, struct osnoise_tool *tool)
+osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *tool)
 {
 	struct osnoise_hist_data *data = tool->data;
 	struct trace_instance *trace = &tool->trace;
@@ -508,10 +478,10 @@ static void osnoise_hist_usage(char *usage)
 /*
  * osnoise_hist_parse_args - allocs, parse and fill the cmd line parameters
  */
-static struct osnoise_hist_params
+static struct osnoise_params
 *osnoise_hist_parse_args(int argc, char *argv[])
 {
-	struct osnoise_hist_params *params;
+	struct osnoise_params *params;
 	struct trace_events *tevent;
 	int retval;
 	int c;
@@ -731,7 +701,7 @@ static struct osnoise_hist_params
  * osnoise_hist_apply_config - apply the hist configs to the initialized tool
  */
 static int
-osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params *params)
+osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 {
 	int retval;
 
@@ -808,7 +778,7 @@ osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params
  * osnoise_init_hist - initialize a osnoise hist tool with parameters
  */
 static struct osnoise_tool
-*osnoise_init_hist(struct osnoise_hist_params *params)
+*osnoise_init_hist(struct osnoise_params *params)
 {
 	struct osnoise_tool *tool;
 	int nr_cpus;
@@ -842,7 +812,7 @@ static void stop_hist(int sig)
  * osnoise_hist_set_signals - handles the signal to stop the tool
  */
 static void
-osnoise_hist_set_signals(struct osnoise_hist_params *params)
+osnoise_hist_set_signals(struct osnoise_params *params)
 {
 	signal(SIGINT, stop_hist);
 	if (params->duration) {
@@ -853,7 +823,7 @@ osnoise_hist_set_signals(struct osnoise_hist_params *params)
 
 int osnoise_hist_main(int argc, char *argv[])
 {
-	struct osnoise_hist_params *params;
+	struct osnoise_params *params;
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index dacec2f99017..7f393019bbf5 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -14,40 +14,6 @@
 #include <sched.h>
 
 #include "osnoise.h"
-#include "utils.h"
-
-enum osnoise_mode {
-	MODE_OSNOISE = 0,
-	MODE_HWNOISE
-};
-
-/*
- * osnoise top parameters
- */
-struct osnoise_top_params {
-	char			*cpus;
-	cpu_set_t		monitored_cpus;
-	char			*trace_output;
-	char			*cgroup_name;
-	unsigned long long	runtime;
-	unsigned long long	period;
-	long long		threshold;
-	long long		stop_us;
-	long long		stop_total_us;
-	int			sleep_time;
-	int			duration;
-	int			quiet;
-	int			set_sched;
-	int			cgroup;
-	int			hk_cpus;
-	int			warmup;
-	int			buffer_size;
-	int			pretty_output;
-	cpu_set_t		hk_cpu_set;
-	struct sched_attr	sched_param;
-	struct trace_events	*events;
-	enum osnoise_mode	mode;
-};
 
 struct osnoise_top_cpu {
 	unsigned long long	sum_runtime;
@@ -158,7 +124,7 @@ osnoise_top_handler(struct trace_seq *s, struct tep_record *record,
  */
 static void osnoise_top_header(struct osnoise_tool *top)
 {
-	struct osnoise_top_params *params = top->params;
+	struct osnoise_params *params = top->params;
 	struct trace_seq *s = top->trace.seq;
 	char duration[26];
 
@@ -218,7 +184,7 @@ static void clear_terminal(struct trace_seq *seq)
  */
 static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
 {
-	struct osnoise_top_params *params = tool->params;
+	struct osnoise_params *params = tool->params;
 	struct trace_seq *s = tool->trace.seq;
 	struct osnoise_top_cpu *cpu_data;
 	struct osnoise_top_data *data;
@@ -258,7 +224,7 @@ static void osnoise_top_print(struct osnoise_tool *tool, int cpu)
  * osnoise_print_stats - print data for all cpus
  */
 static void
-osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
+osnoise_print_stats(struct osnoise_params *params, struct osnoise_tool *top)
 {
 	struct trace_instance *trace = &top->trace;
 	static int nr_cpus = -1;
@@ -286,7 +252,7 @@ osnoise_print_stats(struct osnoise_top_params *params, struct osnoise_tool *top)
 /*
  * osnoise_top_usage - prints osnoise top usage message
  */
-static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
+static void osnoise_top_usage(struct osnoise_params *params, char *usage)
 {
 	int i;
 
@@ -354,9 +320,9 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 /*
  * osnoise_top_parse_args - allocs, parse and fill the cmd line parameters
  */
-struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
+struct osnoise_params *osnoise_top_parse_args(int argc, char **argv)
 {
-	struct osnoise_top_params *params;
+	struct osnoise_params *params;
 	struct trace_events *tevent;
 	int retval;
 	int c;
@@ -553,7 +519,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
  * osnoise_top_apply_config - apply the top configs to the initialized tool
  */
 static int
-osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *params)
+osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_params *params)
 {
 	int retval;
 
@@ -640,7 +606,7 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 /*
  * osnoise_init_top - initialize a osnoise top tool with parameters
  */
-struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
+struct osnoise_tool *osnoise_init_top(struct osnoise_params *params)
 {
 	struct osnoise_tool *tool;
 	int nr_cpus;
@@ -674,7 +640,7 @@ static void stop_top(int sig)
 /*
  * osnoise_top_set_signals - handles the signal to stop the tool
  */
-static void osnoise_top_set_signals(struct osnoise_top_params *params)
+static void osnoise_top_set_signals(struct osnoise_params *params)
 {
 	signal(SIGINT, stop_top);
 	if (params->duration) {
@@ -685,7 +651,7 @@ static void osnoise_top_set_signals(struct osnoise_top_params *params)
 
 int osnoise_top_main(int argc, char **argv)
 {
-	struct osnoise_top_params *params;
+	struct osnoise_params *params;
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
diff --git a/tools/tracing/rtla/src/timerlat.h b/tools/tracing/rtla/src/timerlat.h
index e452d385cb0f..cadc613dc82e 100644
--- a/tools/tracing/rtla/src/timerlat.h
+++ b/tools/tracing/rtla/src/timerlat.h
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "utils.h"
 #include "osnoise.h"
 
 struct timerlat_params {
-- 
2.47.2



