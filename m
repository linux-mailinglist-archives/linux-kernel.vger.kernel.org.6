Return-Path: <linux-kernel+bounces-190410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D62EA8CFDF3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6046D1F21344
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD1A13AD2A;
	Mon, 27 May 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD6IT/8U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BA422EE8
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716804934; cv=none; b=O07HeePEnmezNrPBPOGU9Vxk9pV/aMEMDXOAWK4leDU/QP6vkoSA+mZMySzq/Zp7GLGhCmEGqAeaf4cA+zy/TjrtnyzQ5raEB2Ovxs7eYOe7xCWDNJ3lOfjhQEc43N+q8/WQUWbmLSLZ1OhfCTSMRYlN4BfJP6EGvojXfDYehnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716804934; c=relaxed/simple;
	bh=SaTHtM3+CzAX3Nqlt1UrAv706o4OTbTRxvuPgYz9kG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJcjPLQGSuuOrYnFi0zKOE8Rn9lqVMyuA4RB8hzcvgUP2Ln9vSBmCw5xjWmG52Rwd05PmpNEcCooIcjlJqD8BUkawJdSLPzLO1QEycZt8vqFZ9eVFGmkGfIY+3StW+5i+7QeDSVp5+jbSUszolnsXlYpWWgpIgnTFFZ+ZkAiXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YD6IT/8U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716804931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R8cvAHQEMV5i/B574wxhIOQP308p8fXzk2BaEibPcEQ=;
	b=YD6IT/8UVE4yl3sgE++qzos82Rtc9l14P/7e1IG9F5lLZDfyH168HPSb2eJkehVHWqO4Xk
	kb/jQlbtwHsOcmnnSl4cxSOT+RSAEWGP8uikBA958Pk2GX2l6PO4WyX27umwn8rQmqWHJK
	7lIuUM31SEjaa6OkzeadEXKJyG46xAE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-3Ud599KLPy-lM_MM7PTFyQ-1; Mon, 27 May 2024 06:15:25 -0400
X-MC-Unique: 3Ud599KLPy-lM_MM7PTFyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB81F85A58C;
	Mon, 27 May 2024 10:15:24 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.45.225.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D40741000A0E;
	Mon, 27 May 2024 10:15:21 +0000 (UTC)
From: Artem Savkov <asavkov@redhat.com>
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: [PATCH] perf record: add a shortcut for metrics
Date: Mon, 27 May 2024 12:15:19 +0200
Message-ID: <20240527101519.356342-1-asavkov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add -M/--metrics option to perf-record providing a shortcut to record
metrics and metricgroups. This option mirrors the one in perf-stat.

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  7 +++-
 tools/perf/builtin-record.c              | 43 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 6015fdd08fb63..ebb560d137e62 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -18,7 +18,6 @@ from it, into perf.data - without displaying anything.
 
 This file can then be inspected later on, using 'perf report'.
 
-
 OPTIONS
 -------
 <command>...::
@@ -216,6 +215,12 @@ OPTIONS
 	  na, by_data, by_addr (for mem_blk)
 	  hops0, hops1, hops2, hops3 (for mem_hops)
 
+-M::
+--metrics::
+Record metrics or metricgroups specified in a comma separated list.
+For a group all metrics from the group are added.
+See perf list output for the possible metrics and metricgroups.
+
 --exclude-perf::
 	Don't record events issued by perf itself. This option should follow
 	an event selector (-e) which selects tracepoint event(s). It adds a
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 66a3de8ac6618..5828051ff2736 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -40,6 +40,7 @@
 #include "util/trigger.h"
 #include "util/perf-hooks.h"
 #include "util/cpu-set-sched.h"
+#include "util/metricgroup.h"
 #include "util/synthetic-events.h"
 #include "util/time-utils.h"
 #include "util/units.h"
@@ -188,6 +189,7 @@ static volatile int done;
 static volatile int auxtrace_record__snapshot_started;
 static DEFINE_TRIGGER(auxtrace_snapshot_trigger);
 static DEFINE_TRIGGER(switch_output_trigger);
+static char *metrics;
 
 static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
@@ -200,6 +202,25 @@ static inline pid_t gettid(void)
 }
 #endif
 
+static int append_metric_groups(const struct option *opt __maybe_unused,
+			       const char *str,
+			       int unset __maybe_unused)
+{
+	if (metrics) {
+		char *tmp;
+
+		if (asprintf(&tmp, "%s,%s", metrics, str) < 0)
+			return -ENOMEM;
+		free(metrics);
+		metrics = tmp;
+	} else {
+		metrics = strdup(str);
+		if (!metrics)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
 static int record__threads_enabled(struct record *rec)
 {
 	return rec->opts.threads_spec;
@@ -3382,6 +3403,9 @@ static struct option __record_options[] = {
 		     parse_events_option),
 	OPT_CALLBACK(0, "filter", &record.evlist, "filter",
 		     "event filter", parse_filter),
+	OPT_CALLBACK('M', "metrics", &record.evlist, "metric/metric group list",
+		     "monitor specified metrics or metric groups (separated by ,)",
+		     append_metric_groups),
 	OPT_CALLBACK_NOOPT(0, "exclude-perf", &record.evlist,
 			   NULL, "don't record events from perf itself",
 			   exclude_perf),
@@ -3984,6 +4008,7 @@ int cmd_record(int argc, const char **argv)
 	int err;
 	struct record *rec = &record;
 	char errbuf[BUFSIZ];
+	struct rblist mevents;
 
 	setlocale(LC_ALL, "");
 
@@ -4153,6 +4178,23 @@ int cmd_record(int argc, const char **argv)
 	if (record.opts.overwrite)
 		record.opts.tail_synthesize = true;
 
+	if (metrics) {
+		const char *pmu = parse_events_option_args.pmu_filter ?: "all";
+		int ret = metricgroup__parse_groups(rec->evlist, pmu, metrics,
+						false, /* metric_no_group */
+						false, /* metric_no_merge */
+						false, /* metric_no_threshold */
+						rec->opts.target.cpu_list,
+						rec->opts.target.system_wide,
+						false, /* hardware_aware_grouping */
+						&mevents);
+		if (ret) {
+			err = ret;
+			goto out;
+		}
+		zfree(&metrics);
+	}
+
 	if (rec->evlist->core.nr_entries == 0) {
 		bool can_profile_kernel = perf_event_paranoid_check(1);
 
@@ -4264,6 +4306,7 @@ int cmd_record(int argc, const char **argv)
 out_opts:
 	record__free_thread_masks(rec, rec->nr_threads);
 	rec->nr_threads = 0;
+	metricgroup__rblist_exit(&mevents);
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
 	return err;
 }
-- 
2.45.1


