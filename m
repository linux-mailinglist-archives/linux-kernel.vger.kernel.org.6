Return-Path: <linux-kernel+bounces-257854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE27937FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 09:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1861C1F21E11
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE86A39AC9;
	Sat, 20 Jul 2024 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDWoKQNp"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C71CA87
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 07:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721461611; cv=none; b=ocgyaGVu1NtZ346xMGJR5bUJlzMxDqEs76+Fnkci1CTXJR6BetVKF0QG2ydF09294d6HlpxQMxS9vpp4x1mkpsJzDPDdc6GR9RsKnrB1evnCfnxRQ/aZ1ZBaFG/fmj+nztVuQX394T2JLR90QVyzIJ2eUWmqBlKO9VyCYoLSxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721461611; c=relaxed/simple;
	bh=PcuNt+j9SkPVkQuILod93snJW56Tlu18mM1b/bUfLiM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AX1oZ9fh9xTI5/u4CirVysGdona7KraS/z4TLck1lICnxGK+L+CmMdDk8fM5224hwrrAl5F6RH0yZz8gmU2ef+/dIeCku/DG9QpAE9j56c8pZn+YrhPoTMmBOOZJqEXfe8ZV5+YaewJ/sY09JZluR26TxpPYZ7cVl5GRHzMaAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDWoKQNp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e05faf3fdc4so5789062276.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721461609; x=1722066409; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QQRAAaT8VLbvyjabk6+mERLbtWilL5TeouuOaIO2aDk=;
        b=KDWoKQNpELDe351BYOxgd7QiOmOSesDiljgvTxZVHpev5xRkjlzmL+DJcQ4yWzlsIX
         YsB2n6cOAOJzCGjfnQHonDlBwTekIv3fUqxhlzkLtwIP3SRB7u6jcgKXhnJakFt+1r5g
         jIaAvn1VKjl47P29M2scYe9qsLTQp1en+yCaVoDDA+3SO2aOswdxt/yJU+JBolx1hdNS
         rW3GqgU8R0w7XfOSxYiUBCsNhRwSR1y/dndtw2kIP3iYpeZfYxiHRHpTIphEOGMtMH+V
         0QY8d7Jnx4h5QnGnZZTcm5S5jsylu3kzLM4ywDxa2BCgKOt4riS+BpJeZoh4/pQT66GQ
         klWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721461609; x=1722066409;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QQRAAaT8VLbvyjabk6+mERLbtWilL5TeouuOaIO2aDk=;
        b=X7UYqOkHNRvLeDGjipfhzj3YCmp49Wvq8ZUFuhaldS8fnWCl3lWf3rkSmLmi/jobuf
         wp193qvJxFpT/JYrfpJXEsGW274jxOq321kpI2f09620wn/CzRl1bkh8GffbBw1YJNWv
         4q7DuVwT3wjAbhcv00TKTIWYdKq1JFE+TjQLAcR2F7h3E+XjnHcyrUYy7G4hhzKfMLnv
         jzBnKAfHgz8/WNu0w0zR1GLi/k7vEetujb/1xx3QBUqiqPKZkL4FhwwHePVly77rkgTI
         UHD5nGmoSyq+sf2PW9cOsrwRkCAPXei0WVY2MeFNokg4F2OSZZrK5MOQyPbZ/Q7ynEyZ
         +ykg==
X-Forwarded-Encrypted: i=1; AJvYcCVpa0XDCxdedREyYlwotHXi91P8gSkLBCEMz6jG5FAwtmhD1AfPzf6FzjJd01YcKJfZI+19Jc+8KQKgyt3swtOf8yNVjvGRv7hufSYt
X-Gm-Message-State: AOJu0YwXHEjFEzD/62YGttoAinG/sVoOh3hy/6aVhMiTzq9z2m1XrpK8
	RTatXW5/gx9NhjQuzaAYXK1PUMEzCbfZ+dlgyNflF4Dq65TjKPt/N4fq8XhPYYiME0L1yImqkbr
	PgOi7rg==
X-Google-Smtp-Source: AGHT+IF5ch8hU0uyOjYUDC4RRpq4r9jOhmFMQzumBHz2EHGaUDIbX3GuCOaaEeoehezq2JfY68rrN9pK7NAZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5df:6f0f:a93c:ac73])
 (user=irogers job=sendgmr) by 2002:a05:6902:1101:b0:e05:6026:f741 with SMTP
 id 3f1490d57ef6-e086fe58788mr4359276.2.1721461609358; Sat, 20 Jul 2024
 00:46:49 -0700 (PDT)
Date: Sat, 20 Jul 2024 00:45:52 -0700
In-Reply-To: <20240720074552.1915993-1-irogers@google.com>
Message-Id: <20240720074552.1915993-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240720074552.1915993-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Subject: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Andi Kleen reported a regression where `perf script +F metric` would
crash. With this change the output is:

```
$ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy

      21.229620 GB/sec

      15.751008 GB/sec

      16.009221 GB/sec
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
$ perf --no-pager script -F +metric
            perf 1912464 [000] 814503.473101:       6325       cycles:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
            perf 1912464 [000] 814503.473101:   metric:    0.06  insn per cycle
            perf 1912464 [000] 814503.473101:        351 instructions:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
            perf 1912464 [000] 814503.473101:   metric:    0.03  insn per cycle
...
```

The change fixes perf script to update counts and thereby aggregate
values which then get consumed by unchanged metric logic in the shadow
stat output. Note, it would be preferential to switch to json metrics.

Reported-by: Andi Kleen <ak@linux.intel.com>
Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378-1-ak@linux.intel.com/
Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")'
Signed-off-by: Ian Rogers <irogers@google.com>
---
The code isn't well tested nor does it support non-leader sampling
reading of counts based on periods that seemed to present in the
previous code. Sending out for the sake of discussion. Andi's changes
added a test and that should certainly be added.
---
 tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
 1 file changed, 93 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c16224b1fef3..752d6219fb08 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -63,6 +63,7 @@
 #include "util/util.h"
 #include "util/cgroup.h"
 #include "perf.h"
+#include <internal/threadmap.h>
 
 #include <linux/ctype.h>
 #ifdef HAVE_LIBTRACEEVENT
@@ -334,16 +335,8 @@ struct evsel_script {
        char *filename;
        FILE *fp;
        u64  samples;
-       /* For metric output */
-       u64  val;
-       int  gnum;
 };
 
-static inline struct evsel_script *evsel_script(struct evsel *evsel)
-{
-	return (struct evsel_script *)evsel->priv;
-}
-
 static struct evsel_script *evsel_script__new(struct evsel *evsel, struct perf_data *data)
 {
 	struct evsel_script *es = zalloc(sizeof(*es));
@@ -2107,6 +2100,12 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
 	fputs("\tmetric: ", mctx->fp);
 }
 
+static struct aggr_cpu_id perf_script__get_cpu(struct perf_stat_config *config __maybe_unused,
+					struct perf_cpu cpu)
+{
+	return aggr_cpu_id__cpu(cpu, /*data=*/NULL);
+}
+
 static void perf_sample__fprint_metric(struct perf_script *script,
 				       struct thread *thread,
 				       struct evsel *evsel,
@@ -2126,23 +2125,96 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 		.force_header = false,
 	};
 	struct evsel *ev2;
-	u64 val;
+	struct perf_cpu sample_cpu = { .cpu = sample->cpu, };
+	int thread_idx, cpu_map_idx;
+	u64 read_format = evsel->core.attr.read_format;
+	int aggr_idx;
 
+	/* Only support leader sampling with a group of read events. */
+	if ((read_format & PERF_FORMAT_GROUP) == 0)
+		return;
+
+	/* Lazy initialization of stats values. */
 	if (!evsel->stats)
 		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
-	if (evsel_script(leader)->gnum++ == 0)
-		perf_stat__reset_shadow_stats();
-	val = sample->period * evsel->scale;
-	evsel_script(evsel)->val = val;
-	if (evsel_script(leader)->gnum == leader->core.nr_members) {
-		for_each_group_member (ev2, leader) {
-			perf_stat__print_shadow_stats(&stat_config, ev2,
-						      evsel_script(ev2)->val,
-						      sample->cpu,
-						      &ctx,
-						      NULL);
+	if (!stat_config.aggr_map) {
+		int nr_aggr;
+
+		stat_config.aggr_get_id = perf_script__get_cpu;
+		stat_config.aggr_map =
+			cpu_aggr_map__new(evsel->evlist->core.user_requested_cpus,
+					aggr_cpu_id__cpu,
+					/*data=*/NULL,
+					/*needs_sort=*/false);
+		if (!stat_config.aggr_map) {
+			pr_err("cannot allocate aggr map\n");
+			return;
+		}
+		nr_aggr = stat_config.aggr_map->nr;
+		if (evlist__alloc_aggr_stats(evsel->evlist, nr_aggr) < 0) {
+			pr_err("cannot allocate aggr counts\n");
+			return;
 		}
-		evsel_script(leader)->gnum = 0;
+	}
+
+	/* Add group counts from sample into appropriate evsel counts by id. */
+	for_each_group_evsel(ev2, leader) {
+		struct perf_thread_map *threads = perf_evsel__threads(&ev2->core);
+		struct perf_cpu_map *cpus = evsel__cpus(ev2);
+		int id_num = 0;
+		bool match = false;
+
+		perf_cpu_map__for_each_idx(cpu_map_idx, cpus) {
+			for (thread_idx = 0; thread_idx < threads->nr; thread_idx++) {
+				struct sample_read_value *value = sample->read.group.values;
+				u64 id = ev2->core.id[id_num++];
+
+				sample_read_group__for_each(value, sample->read.group.nr,
+							    read_format) {
+					struct perf_counts_values *counts;
+
+					if (value->id != id)
+						continue;
+
+					counts = perf_counts(ev2->counts, cpu_map_idx, thread_idx);
+					counts->val += value->value;
+					/*
+					 * Ensure the enabled/running time isn't
+					 * 0, which implies an error.
+					 */
+					counts->ena += sample->read.time_enabled ?: sample->period;
+					counts->run += sample->read.time_running ?: sample->period;
+					match = true;
+				}
+			}
+		}
+		if (match) {
+			/* Update the aggreate count in ev2. */
+			perf_stat_process_counter(&stat_config, ev2);
+		}
+	}
+
+	/* Find the appropriate indices for dumping of this sample. */
+	thread_idx = perf_thread_map__idx(perf_evsel__threads(&evsel->core),
+					thread__pid(thread));
+	cpu_map_idx = perf_cpu_map__idx(evsel__cpus(evsel), sample_cpu);
+	if (thread_idx == -1 || cpu_map_idx == -1)
+		return;
+
+	cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
+		if (stat_config.aggr_map->map[aggr_idx].cpu.cpu == sample_cpu.cpu)
+			break;
+	}
+	/* Iterate all events and the leader of the group, trying to print stats. */
+	for_each_group_evsel(ev2, leader) {
+		struct perf_counts_values *counts =
+			perf_counts(ev2->counts, cpu_map_idx, thread_idx);
+
+		if (!counts)
+			continue;
+
+		perf_stat__print_shadow_stats(&stat_config, ev2, counts->val * ev2->scale,
+					      aggr_idx, &ctx, NULL);
 	}
 }
 
-- 
2.45.2.1089.g2a221341d9-goog


