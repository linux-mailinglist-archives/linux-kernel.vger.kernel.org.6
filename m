Return-Path: <linux-kernel+bounces-549626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D612BA554AF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E361886EAC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8826E62D;
	Thu,  6 Mar 2025 18:18:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47925D54E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741285104; cv=none; b=aHDY+4Lh/cdspdUeQfm6FqlnrWFAWHNqlsOe5NalLpcw4y9ETt9W+9arUa2wSGpnAPsNF/0qSY7ZlRziwXbBidu168cGrd/mIffeoqPIKIreMn/E+bFR6eoyXKspGnJY6drBu75pvTrJZTT1aM3jGGG6Ev5js/a3k/tKzak//Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741285104; c=relaxed/simple;
	bh=BT/zsGO2ost9yei3Tam/3K3wPgLq3JjuFRpxiowqqlM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HQKcv0YvgPE5WGRu9u6WlmWZolGULNKan0K+aeLtnJV+0EFHbyMn1NZcsPJNbwxRGtsF6DzTnRqI5EWRauE9ozgz2DBp+J8XSKEjcqEpxXUliZVGBPr3jnjsT0hIBkxtxlZfYDOn5YXmktDmQkGpVw+i9YaGy4iEasYecgygCiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D44DC4CEEC;
	Thu,  6 Mar 2025 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tqFne-00000000PHd-1FT1;
	Thu, 06 Mar 2025 13:18:26 -0500
Message-ID: <20250306181826.175499698@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Mar 2025 13:18:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Clark Williams <williams@redhat.com>
Subject: [for-next][PATCH 05/10] rtla/timerlat_hist: Use BPF to collect samples
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
measurement. Thus, instead of waking up every second to collect samples,
rtla simply sleeps until woken up by a signal or threshold overflow.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Link: https://lore.kernel.org/20250218145859.27762-6-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 167 +++++++++++++++++++++----
 1 file changed, 146 insertions(+), 21 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index fe683a20b0e2..202d99a598ba 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -17,6 +17,7 @@
 #include "timerlat.h"
 #include "timerlat_aa.h"
 #include "timerlat_u.h"
+#include "timerlat_bpf.h"
 
 struct timerlat_hist_cpu {
 	int			*irq;
@@ -193,6 +194,89 @@ timerlat_hist_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+/*
+ * timerlat_hist_bpf_pull_data - copy data from BPF maps into userspace
+ */
+static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
+{
+	struct timerlat_hist_data *data = tool->data;
+	int i, j, err;
+	long long value_irq[data->nr_cpus],
+		  value_thread[data->nr_cpus],
+		  value_user[data->nr_cpus];
+
+	/* Pull histogram */
+	for (i = 0; i < data->entries; i++) {
+		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
+						  value_user, data->nr_cpus);
+		if (err)
+			return err;
+		for (j = 0; j < data->nr_cpus; j++) {
+			data->hist[j].irq[i] = value_irq[j];
+			data->hist[j].thread[i] = value_thread[j];
+			data->hist[j].user[i] = value_user[j];
+		}
+	}
+
+	/* Pull summary */
+	err = timerlat_bpf_get_summary_value(SUMMARY_COUNT,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].irq_count = value_irq[i];
+		data->hist[i].thread_count = value_thread[i];
+		data->hist[i].user_count = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MIN,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].min_irq = value_irq[i];
+		data->hist[i].min_thread = value_thread[i];
+		data->hist[i].min_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_MAX,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].max_irq = value_irq[i];
+		data->hist[i].max_thread = value_thread[i];
+		data->hist[i].max_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_SUM,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].sum_irq = value_irq[i];
+		data->hist[i].sum_thread = value_thread[i];
+		data->hist[i].sum_user = value_user[i];
+	}
+
+	err = timerlat_bpf_get_summary_value(SUMMARY_OVERFLOW,
+					     value_irq, value_thread, value_user,
+					     data->nr_cpus);
+	if (err)
+		return err;
+	for (i = 0; i < data->nr_cpus; i++) {
+		data->hist[i].irq[data->entries] = value_irq[i];
+		data->hist[i].thread[data->entries] = value_thread[i];
+		data->hist[i].user[data->entries] = value_user[i];
+	}
+
+	return 0;
+}
+
 /*
  * timerlat_hist_header - print the header of the tracer to the output
  */
@@ -1152,6 +1236,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	pthread_t timerlat_u;
 	int retval;
 	int nr_cpus, i;
+	bool no_bpf = false;
 
 	params = timerlat_hist_parse_args(argc, argv);
 	if (!params)
@@ -1177,6 +1262,24 @@ int timerlat_hist_main(int argc, char *argv[])
 	 */
 	hist_inst = trace;
 
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
+
 	retval = enable_timerlat(trace);
 	if (retval) {
 		err_msg("Failed to enable timerlat tracer\n");
@@ -1304,35 +1407,55 @@ int timerlat_hist_main(int argc, char *argv[])
 		trace_instance_start(&record->trace);
 	if (!params->no_aa)
 		trace_instance_start(&aa->trace);
-	trace_instance_start(trace);
+	if (no_bpf) {
+		trace_instance_start(trace);
+	} else {
+		retval = timerlat_bpf_attach();
+		if (retval) {
+			err_msg("Error attaching BPF program\n");
+			goto out_hist;
+		}
+	}
 
 	tool->start_time = time(NULL);
 	timerlat_hist_set_signals(params);
 
-	while (!stop_tracing) {
-		sleep(params->sleep_time);
-
-		retval = tracefs_iterate_raw_events(trace->tep,
-						    trace->inst,
-						    NULL,
-						    0,
-						    collect_registered_events,
-						    trace);
-		if (retval < 0) {
-			err_msg("Error iterating on events\n");
-			goto out_hist;
-		}
-
-		if (osnoise_trace_is_off(tool, record))
-			break;
+	if (no_bpf) {
+		while (!stop_tracing) {
+			sleep(params->sleep_time);
+
+			retval = tracefs_iterate_raw_events(trace->tep,
+							    trace->inst,
+							    NULL,
+							    0,
+							    collect_registered_events,
+							    trace);
+			if (retval < 0) {
+				err_msg("Error iterating on events\n");
+				goto out_hist;
+			}
 
-		/* is there still any user-threads ? */
-		if (params->user_workload) {
-			if (params_u.stopped_running) {
-				debug_msg("timerlat user-space threads stopped!\n");
+			if (osnoise_trace_is_off(tool, record))
 				break;
+
+			/* is there still any user-threads ? */
+			if (params->user_workload) {
+				if (params_u.stopped_running) {
+					debug_msg("timerlat user-space threads stopped!\n");
+					break;
+				}
 			}
 		}
+	} else
+		timerlat_bpf_wait(-1);
+
+	if (!no_bpf) {
+		timerlat_bpf_detach();
+		retval = timerlat_hist_bpf_pull_data(tool);
+		if (retval) {
+			err_msg("Error pulling BPF data\n");
+			goto out_hist;
+		}
 	}
 
 	if (params->user_workload && !params_u.stopped_running) {
@@ -1376,6 +1499,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	osnoise_destroy_tool(tool);
 	free(params);
 	free_cpu_idle_disable_states();
+	if (!no_bpf)
+		timerlat_bpf_destroy();
 out_exit:
 	exit(return_value);
 }
-- 
2.47.2



