Return-Path: <linux-kernel+bounces-549629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922F7A554B5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761607A85E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27F27602D;
	Thu,  6 Mar 2025 18:18:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CF26B0AD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285105; cv=none; b=SJQKsDJrEqp6DpT+1ynQbYPRvMIP2K1kLV9zGK72U2hyqSAHT9MmPnRpkbtmHo/Hx9tl3n6RCFaqUmK+fSV85EuOgSIReIY9R6udtT+bhDBPEGMMdj2gIV22FtIIGQFj9VAl/+pxaDo0s6WNUQIIPHRIYaZWYynBvA5odc2Hb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285105; c=relaxed/simple;
	bh=ilX529DTLpsqCQGfXWAAG8SFq3FlOwbPaR7bvG6Qt3c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m7v5oYV9rcCwmHCq4uFxfJYW2DPiK2aMIEBZER7hVDgQjrgZdpE2JMYb7vZIXCSnzFfh948bxNkGX8zOWRKrYLTMtWLg5UYQCvpQNeLNOrOnhUn9hqaE9839DnRqp+JTL7R0wC4+nuZVPhw9ght3qyH4LhXsOwD1aSlXDkPdG3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D397EC4CEF2;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFne-00000000PIc-2UPa;
	Thu, 06 Mar 2025 13:18:26 -0500
Message-ID: <20250306181826.480658964@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 07/10] rtla/timerlat_top: Use BPF to collect samples
References: <20250306181801.485766945@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Collect samples using BPF program instead of pulling them from tracefs.

If the osnoise:timerlat_sample tracepoint is unavailable or the BPF
program fails to load for whatever reason, rtla falls back to the old
implementation.

The collection of samples using the BPF program is fully self-contained
and requires no activity of the userspace part of rtla during the
measurement. Thus, rtla only pulls the summary from the BPF map and
displays it every second, improving the performance.

In --aa-only mode, the BPF program does not collect any data and only
signalizes the end of tracing to userspace. An optimization that re-used
the main trace instance for auto-analysis in aa-only mode was dropped, as
rtla no longer turns tracing on in the main trace instance, making it
useless for auto-analysis.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-8-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 255 ++++++++++++++++++++++----
 1 file changed, 215 insertions(+), 40 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index a3d9e8f67a4f..1b6455b9e093 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -18,6 +18,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_u.h"
+#include "timerlat_bpf.h"
 
 struct timerlat_top_cpu {
 	unsigned long long	irq_count;
@@ -181,6 +182,76 @@ timerlat_top_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+/*
+ * timerlat_top_bpf_pull_data - copy data from BPF maps into userspace
+ */
+static int timerlat_top_bpf_pull_data(struct osnoise_tool *tool)
+{
+	struct timerlat_top_data *data = tool->data;
+	int i, err;
+	long long value_irq[data->nr_cpus],
+		  value_thread[data->nr_cpus],
+		  value_user[data->nr_cpus];
+
+	/* Pull summary */
+	err = timerlat_bpf_get_summary_value(SUMMARY_CURRENT,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].cur_irq = value_irq[i];
+		data->cpu_data[i].cur_thread = value_thread[i];
+		data->cpu_data[i].cur_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].irq_count = value_irq[i];
+		data->cpu_data[i].thread_count = value_thread[i];
+		data->cpu_data[i].user_count = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].min_irq = value_irq[i];
+		data->cpu_data[i].min_thread = value_thread[i];
+		data->cpu_data[i].min_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].max_irq = value_irq[i];
+		data->cpu_data[i].max_thread = value_thread[i];
+		data->cpu_data[i].max_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->cpu_data[i].sum_irq = value_irq[i];
+		data->cpu_data[i].sum_thread = value_thread[i];
+		data->cpu_data[i].sum_user = value_user[i];
+	}
+
+	return 0;
+}
+
 /*
  * timerlat_top_header - print the header of the tool output
  */
@@ -894,6 +965,111 @@ timerlat_top_set_signals(struct timerlat_params *params)
 	}
 }
 
+/*
+ * timerlat_top_main_loop - main loop to process events
+ */
+static int
+timerlat_top_main_loop(struct osnoise_tool *top,
+		       struct osnoise_tool *record,
+		       struct timerlat_params *params,
+		       struct timerlat_u_params *params_u)
+{
+	struct trace_instance *trace = &top->trace;
+	int retval;
+
+	while (!stop_tracing) {
+		sleep(params->sleep_time);
+
+		if (params->aa_only && !osnoise_trace_is_off(top, record))
+			continue;
+
+		retval = tracefs_iterate_raw_events(trace->tep,
+						    trace->inst,
+						    NULL,
+						    0,
+						    collect_registered_events,
+						    trace);
+		if (retval < 0) {
+			err_msg("Error iterating on events\n");
+			return retval;
+		}
+
+		if (!params->quiet)
+			timerlat_print_stats(params, top);
+
+		if (osnoise_trace_is_off(top, record))
+			break;
+
+		/* is there still any user-threads ? */
+		if (params->user_workload) {
+			if (params_u->stopped_running) {
+				debug_msg("timerlat user space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * timerlat_top_bpf_main_loop - main loop to process events (BPF variant)
+ */
+static int
+timerlat_top_bpf_main_loop(struct osnoise_tool *top,
+			   struct osnoise_tool *record,
+			   struct timerlat_params *params,
+			   struct timerlat_u_params *params_u)
+{
+	int retval, wait_retval;
+
+	if (params->aa_only) {
+		/* Auto-analysis only, just wait for stop tracing */
+		timerlat_bpf_wait(-1);
+		return 0;
+	}
+
+	if (params->quiet) {
+		/* Quiet mode: wait for stop and then, print results */
+		timerlat_bpf_wait(-1);
+
+		retval = timerlat_top_bpf_pull_data(top);
+		if (retval) {
+			err_msg("Error pulling BPF data\n");
+			return retval;
+		}
+
+		return 0;
+	}
+
+	/* Pull and display data in a loop */
+	while (!stop_tracing) {
+		wait_retval = timerlat_bpf_wait(params->sleep_time);
+
+		retval = timerlat_top_bpf_pull_data(top);
+		if (retval) {
+			err_msg("Error pulling BPF data\n");
+			return retval;
+		}
+
+		timerlat_print_stats(params, top);
+
+		if (wait_retval == 1)
+			/* Stopping requested by tracer */
+			break;
+
+		/* is there still any user-threads ? */
+		if (params->user_workload) {
+			if (params_u->stopped_running) {
+				debug_msg("timerlat user space threads stopped!\n");
+				break;
+			}
+		}
+	}
+
+	return 0;
+}
+
 int timerlat_top_main(int argc, char *argv[])
 {
 	struct timerlat_params *params;
@@ -908,6 +1084,7 @@ int timerlat_top_main(int argc, char *argv[])
 	char *max_lat;
 	int retval;
 	int nr_cpus, i;
+	bool no_bpf = false;
 
 	params = timerlat_top_parse_args(argc, argv);
 	if (!params)
@@ -933,6 +1110,23 @@ int timerlat_top_main(int argc, char *argv[])
 	*/
 	top_inst = trace;
 
+	if (getenv("RTLA_NO_BPF") && strncmp(getenv("RTLA_NO_BPF"), "1", 2) == 0) {
+		debug_msg("RTLA_NO_BPF set, disabling BPF\n");
+		no_bpf = true;
+	}
+
+	if (!no_bpf && !tep_find_event_by_name(trace->tep, "osnoise", "timerlat_sample")) {
+		debug_msg("osnoise:timerlat_sample missing, disabling BPF\n");
+		no_bpf = true;
+	}
+
+	if (!no_bpf) {
+		retval = timerlat_bpf_init(params);
+		if (retval) {
+			debug_msg("Could not enable BPF\n");
+			no_bpf = true;
+		}
+	}
 
 	retval = enable_timerlat(trace);
 	if (retval) {
@@ -1007,15 +1201,9 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 	if (!params->no_aa) {
-		if (params->aa_only) {
-			/* as top is not used for display, use it for aa */
-			aa = top;
-		} else  {
-			/* otherwise, a new instance is needed */
-			aa = osnoise_init_tool("timerlat_aa");
-			if (!aa)
-				goto out_top;
-		}
+		aa = osnoise_init_tool("timerlat_aa");
+		if (!aa)
+			goto out_top;
 
 		retval = timerlat_aa_init(aa, params->dump_tasks);
 		if (retval) {
@@ -1066,44 +1254,31 @@ int timerlat_top_main(int argc, char *argv[])
 	 */
 	if (params->trace_output)
 		trace_instance_start(&record->trace);
-	if (!params->no_aa && aa != top)
+	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	trace_instance_start(trace);
+	if (no_bpf) {
+		trace_instance_start(trace);
+	} else {
+		retval = timerlat_bpf_attach();
+		if (retval) {
+			err_msg("Error attaching BPF program\n");
+			goto out_top;
+		}
+	}
 
 	top->start_time = time(NULL);
 	timerlat_top_set_signals(params);
 
-	while (!stop_tracing) {
-		sleep(params->sleep_time);
+	if (no_bpf)
+		retval = timerlat_top_main_loop(top, record, params, &params_u);
+	else
+		retval = timerlat_top_bpf_main_loop(top, record, params, &params_u);
 
-		if (params->aa_only && !osnoise_trace_is_off(top, record))
-			continue;
+	if (retval)
+		goto out_top;
 
-		retval = tracefs_iterate_raw_events(trace->tep,
-						    trace->inst,
-						    NULL,
-						    0,
-						    collect_registered_events,
-						    trace);
-		if (retval < 0) {
-			err_msg("Error iterating on events\n");
-			goto out_top;
-		}
-
-		if (!params->quiet)
-			timerlat_print_stats(params, top);
-
-		if (osnoise_trace_is_off(top, record))
-			break;
-
-		/* is there still any user-threads ? */
-		if (params->user_workload) {
-			if (params_u.stopped_running) {
-				debug_msg("timerlat user space threads stopped!\n");
-				break;
-			}
-		}
-	}
+	if (!no_bpf)
+		timerlat_bpf_detach();
 
 	if (params->user_workload && !params_u.stopped_running) {
 		params_u.should_run = 0;
-- 
2.47.2



