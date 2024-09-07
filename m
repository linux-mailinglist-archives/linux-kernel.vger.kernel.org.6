Return-Path: <linux-kernel+bounces-319644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D3297001D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 07:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4871F22F93
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 05:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BAF156227;
	Sat,  7 Sep 2024 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hjXFjndD"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F651514CB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 05:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725685740; cv=none; b=ciMKhGxI2SckIHnLUY5Xyx4N/WQvpethq36DCCcicekZze+CezUCCvE0LAA6kZ4au7wtoZDHi5LY9Mnxk8KuwQsNKfK8etlidVjbWoA6qEXWNAswdYSVssPUK9lxivZ2WiZ3kQ1dE7geI1TGi6RH4axOtLPmTal5dIovExPacDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725685740; c=relaxed/simple;
	bh=ZUA58Go7Paa9FNArSeF2JqV7JukRYrPivcjrDirkUfs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kMVmUhjsNa0W/xGuh1ETKhoMlLCzT7o1J8t+M/377pLelFmMZKr+nyy4Ml06yUXFXSg9nHehVZY3izuTYpYyf82Sl75O/ZJqnHk+Ydvc7kshn39vUoiIDEtfx4LwfeLX6uTto9atA9ep9pGuQEXQOsmqC8MwuPeo47Cv2YKgGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hjXFjndD; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e163641feb9so9938511276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 22:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725685737; x=1726290537; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gafpIV7PLTIXAbNaWFlCtGU7rGYxILnDpzQagriofg=;
        b=hjXFjndDwivT7rUWERpSu5cb0iw+A4VYDVPRg6JJo3IqqZAH+XgiRrXREICa9zHWyK
         TEQyHoSfL7nM2/VffnNwBaqOW90Jf/1Vy9WirWovKz8DtnUuUzkX/d7xU+VTBGxqJSll
         cCE+0c6LgjPrSwvQ9uiCdCAankieSQHtdQluYqAsX4+rzvID0cxtmYGlxu47uMHmlDu4
         wFU+w4m0pUO4UJ4C6qEqcGS43fu2sriCcmfTXsziJ6inzyftMcyy+8kExHS9cmpJ/4SG
         6Mx8kiOoxutYiL3733lrhvJ60VGxHc6x1zduxefTFM1PSseHggMZFbdQmX8MnYMAwJoA
         t2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725685737; x=1726290537;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gafpIV7PLTIXAbNaWFlCtGU7rGYxILnDpzQagriofg=;
        b=HLMtvLMW9dYb1i7kV7roMxVUL1IDtuJekciRkZw0Bg2RpoGndNUc7g8ZaF2w7rdQH8
         A9sOKN3wByOi+L/ERg1fGT6WG0/yIae3sa57++ZUE98pmxJt/iqkBrZ3WDlcAEmn+3Xx
         JmNYA83SsPuURC5Q1MkWoqiGMlW+cBABxtSlZIihSyrXH5d9b6PnM8TU3EyJZa7GVJJO
         v7edygJ9heLRiKSpMWLoFNmsGTFknrHT5tzNXI5+a5g6TnwNM9F9m7BzmSVC2Zku5f02
         efgVC9mXhryYDmT6wgf+23wq1LEb5itvn+71eFLE1RLTmwyNHuyowkRfQGxQyyBMHhiS
         9Kww==
X-Forwarded-Encrypted: i=1; AJvYcCV6bZ/HA1K768O/F3Pfen0TVIF5Kj2ChieIbVjJmm2i6KfcplP9GNuf0TMHXq1wKu1MPVipWdHhJfMlBDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJgvbm/RcJKG0s+Ddgxt1XFqek9ddOARe/cHwNeGgY8k2SLCj
	UicYfL0x1pfmogjQxB0DkZUFGf+pQigNfbnhPRWCBQfBFuS9NQqaNOXK4abbcw/5XaPS4xbKPFv
	BakvBKQ==
X-Google-Smtp-Source: AGHT+IHIoB1Nh1VGLmC7EC5MPRgCuu1qV6s29+DvUzZD6IROPLEsPc2gBvgXs/PmOY63R+Qe/tZYTK70d5Qu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:90e5:a813:c3d3:daed])
 (user=irogers job=sendgmr) by 2002:a25:8448:0:b0:e1a:6fb8:1c3b with SMTP id
 3f1490d57ef6-e1d342906damr19126276.2.1725685736589; Fri, 06 Sep 2024 22:08:56
 -0700 (PDT)
Date: Fri,  6 Sep 2024 22:08:22 -0700
In-Reply-To: <20240907050830.6752-1-irogers@google.com>
Message-Id: <20240907050830.6752-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240907050830.6752-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v1 07/15] perf tool_pmu: Factor tool events into their own PMU
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Howard Chu <howardchu95@gmail.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Changbin Du <changbin.du@huawei.com>, Ze Gao <zegao2021@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, 
	"=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?=" <clement.legoffic@foss.st.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Junhao He <hejunhao3@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Rather than treat tool events as a special kind of event, create a
tool only PMU where the events/aliases match the existing
duration_time, user_time and system_time events. Remove special
parsing and printing support for the tool events, but add function
calls for when PMU functions are called on a tool_pmu.

Move the tool PMU code in evsel into tool_pmu.c to better encapsulate
the tool event behavior in that file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      |  13 +-
 tools/perf/builtin-stat.c      |   1 +
 tools/perf/util/Build          |   1 +
 tools/perf/util/evsel.c        | 272 ++--------------------
 tools/perf/util/evsel.h        |  28 +--
 tools/perf/util/metricgroup.c  |   1 +
 tools/perf/util/parse-events.c |  37 ---
 tools/perf/util/parse-events.h |   3 -
 tools/perf/util/parse-events.l |  11 -
 tools/perf/util/parse-events.y |  16 --
 tools/perf/util/pmu.c          |  20 +-
 tools/perf/util/pmu.h          |   2 +
 tools/perf/util/pmus.c         |   9 +
 tools/perf/util/print-events.c |  36 +--
 tools/perf/util/print-events.h |   1 -
 tools/perf/util/stat-display.c |   6 +-
 tools/perf/util/stat-shadow.c  |   1 +
 tools/perf/util/tool_pmu.c     | 411 +++++++++++++++++++++++++++++++++
 tools/perf/util/tool_pmu.h     |  51 ++++
 19 files changed, 530 insertions(+), 390 deletions(-)
 create mode 100644 tools/perf/util/tool_pmu.c
 create mode 100644 tools/perf/util/tool_pmu.h

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 65b8cba324be..b8378ba18c28 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -19,6 +19,7 @@
 #include "util/string2.h"
 #include "util/strlist.h"
 #include "util/strbuf.h"
+#include "util/tool_pmu.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <linux/zalloc.h>
@@ -614,9 +615,18 @@ int cmd_list(int argc, const char **argv)
 					event_symbols_hw, PERF_COUNT_HW_MAX);
 		else if (strcmp(argv[i], "sw") == 0 ||
 			 strcmp(argv[i], "software") == 0) {
+			char *old_pmu_glob = default_ps.pmu_glob;
+
 			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
 					event_symbols_sw, PERF_COUNT_SW_MAX);
-			print_tool_events(&print_cb, ps);
+			default_ps.pmu_glob = strdup("tool");
+			if (!default_ps.pmu_glob) {
+				ret = -1;
+				goto out;
+			}
+			perf_pmus__print_pmu_events(&print_cb, ps);
+			zfree(&default_ps.pmu_glob);
+			default_ps.pmu_glob = old_pmu_glob;
 		} else if (strcmp(argv[i], "cache") == 0 ||
 			 strcmp(argv[i], "hwcache") == 0)
 			print_hwcache_events(&print_cb, ps);
@@ -664,7 +674,6 @@ int cmd_list(int argc, const char **argv)
 					event_symbols_hw, PERF_COUNT_HW_MAX);
 			print_symbol_events(&print_cb, ps, PERF_TYPE_SOFTWARE,
 					event_symbols_sw, PERF_COUNT_SW_MAX);
-			print_tool_events(&print_cb, ps);
 			print_hwcache_events(&print_cb, ps);
 			perf_pmus__print_pmu_events(&print_cb, ps);
 			print_tracepoint_events(&print_cb, ps);
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 689a3d43c258..ae525fdcfbde 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -46,6 +46,7 @@
 #include "util/parse-events.h"
 #include "util/pmus.h"
 #include "util/pmu.h"
+#include "util/tool_pmu.h"
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/evsel.h"
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 260cec2f6c0b..80187e3a52be 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -83,6 +83,7 @@ perf-util-y += pmu.o
 perf-util-y += pmus.o
 perf-util-y += pmu-flex.o
 perf-util-y += pmu-bison.o
+perf-util-y += tool_pmu.o
 perf-util-y += svghelper.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-info.o
 perf-util-y += trace-event-scripting.o
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbf9c8cee3c5..b75c4a4c7aa7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -10,7 +10,6 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <linux/bitops.h>
-#include <api/io.h>
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <linux/hw_breakpoint.h>
@@ -51,6 +50,7 @@
 #include "off_cpu.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "tool_pmu.h"
 #include "rlimit.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
@@ -71,33 +71,6 @@ struct perf_missing_features perf_missing_features;
 
 static clockid_t clockid;
 
-static const char *const perf_tool_event__tool_names[PERF_TOOL_MAX] = {
-	NULL,
-	"duration_time",
-	"user_time",
-	"system_time",
-};
-
-const char *perf_tool_event__to_str(enum perf_tool_event ev)
-{
-	if (ev > PERF_TOOL_NONE && ev < PERF_TOOL_MAX)
-		return perf_tool_event__tool_names[ev];
-
-	return NULL;
-}
-
-enum perf_tool_event perf_tool_event__from_str(const char *str)
-{
-	int i;
-
-	perf_tool_event__for_each_event(i) {
-		if (!strcmp(str, perf_tool_event__tool_names[i]))
-			return i;
-	}
-	return PERF_TOOL_NONE;
-}
-
-
 static int evsel__no_extra_init(struct evsel *evsel __maybe_unused)
 {
 	return 0;
@@ -421,7 +394,6 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.leader = orig->core.leader;
 
 	evsel->max_events = orig->max_events;
-	evsel->tool_event = orig->tool_event;
 	free((char *)evsel->unit);
 	evsel->unit = strdup(orig->unit);
 	if (evsel->unit == NULL)
@@ -617,11 +589,6 @@ static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 	return r + evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
-static int evsel__tool_name(enum perf_tool_event ev, char *bf, size_t size)
-{
-	return scnprintf(bf, size, "%s", perf_tool_event__to_str(ev));
-}
-
 static int __evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
 {
 	int r;
@@ -772,10 +739,7 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_SOFTWARE:
-		if (evsel__is_tool(evsel))
-			evsel__tool_name(evsel__tool_event(evsel), bf, sizeof(bf));
-		else
-			evsel__sw_name(evsel, bf, sizeof(bf));
+		evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
@@ -786,6 +750,10 @@ const char *evsel__name(struct evsel *evsel)
 		evsel__bp_name(evsel, bf, sizeof(bf));
 		break;
 
+	case PERF_PMU_TYPE_TOOL:
+		scnprintf(bf, sizeof(bf), "%s", evsel__tool_pmu_event_name(evsel));
+		break;
+
 	default:
 		scnprintf(bf, sizeof(bf), "unknown attr type: %d",
 			  evsel->core.attr.type);
@@ -811,7 +779,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
 		return evsel->metric_id;
 
 	if (evsel__is_tool(evsel))
-		return perf_tool_event__to_str(evsel__tool_event(evsel));
+		return evsel__tool_pmu_event_name(evsel);
 
 	return "unknown";
 }
@@ -1684,167 +1652,6 @@ static int evsel__read_group(struct evsel *leader, int cpu_map_idx, int thread)
 	return evsel__process_group_data(leader, cpu_map_idx, thread, data);
 }
 
-static bool read_until_char(struct io *io, char e)
-{
-	int c;
-
-	do {
-		c = io__get_char(io);
-		if (c == -1)
-			return false;
-	} while (c != e);
-	return true;
-}
-
-static int read_stat_field(int fd, struct perf_cpu cpu, int field, __u64 *val)
-{
-	char buf[256];
-	struct io io;
-	int i;
-
-	io__init(&io, fd, buf, sizeof(buf));
-
-	/* Skip lines to relevant CPU. */
-	for (i = -1; i < cpu.cpu; i++) {
-		if (!read_until_char(&io, '\n'))
-			return -EINVAL;
-	}
-	/* Skip to "cpu". */
-	if (io__get_char(&io) != 'c') return -EINVAL;
-	if (io__get_char(&io) != 'p') return -EINVAL;
-	if (io__get_char(&io) != 'u') return -EINVAL;
-
-	/* Skip N of cpuN. */
-	if (!read_until_char(&io, ' '))
-		return -EINVAL;
-
-	i = 1;
-	while (true) {
-		if (io__get_dec(&io, val) != ' ')
-			break;
-		if (field == i)
-			return 0;
-		i++;
-	}
-	return -EINVAL;
-}
-
-static int read_pid_stat_field(int fd, int field, __u64 *val)
-{
-	char buf[256];
-	struct io io;
-	int c, i;
-
-	io__init(&io, fd, buf, sizeof(buf));
-	if (io__get_dec(&io, val) != ' ')
-		return -EINVAL;
-	if (field == 1)
-		return 0;
-
-	/* Skip comm. */
-	if (io__get_char(&io) != '(' || !read_until_char(&io, ')'))
-		return -EINVAL;
-	if (field == 2)
-		return -EINVAL; /* String can't be returned. */
-
-	/* Skip state */
-	if (io__get_char(&io) != ' ' || io__get_char(&io) == -1)
-		return -EINVAL;
-	if (field == 3)
-		return -EINVAL; /* String can't be returned. */
-
-	/* Loop over numeric fields*/
-	if (io__get_char(&io) != ' ')
-		return -EINVAL;
-
-	i = 4;
-	while (true) {
-		c = io__get_dec(&io, val);
-		if (c == -1)
-			return -EINVAL;
-		if (c == -2) {
-			/* Assume a -ve was read */
-			c = io__get_dec(&io, val);
-			*val *= -1;
-		}
-		if (c != ' ')
-			return -EINVAL;
-		if (field == i)
-			return 0;
-		i++;
-	}
-	return -EINVAL;
-}
-
-static int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
-{
-	__u64 *start_time, cur_time, delta_start;
-	int fd, err = 0;
-	struct perf_counts_values *count;
-	bool adjust = false;
-
-	count = perf_counts(evsel->counts, cpu_map_idx, thread);
-
-	switch (evsel__tool_event(evsel)) {
-	case PERF_TOOL_DURATION_TIME:
-		/*
-		 * Pretend duration_time is only on the first CPU and thread, or
-		 * else aggregation will scale duration_time by the number of
-		 * CPUs/threads.
-		 */
-		start_time = &evsel->start_time;
-		if (cpu_map_idx == 0 && thread == 0)
-			cur_time = rdclock();
-		else
-			cur_time = *start_time;
-		break;
-	case PERF_TOOL_USER_TIME:
-	case PERF_TOOL_SYSTEM_TIME: {
-		bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
-
-		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
-		fd = FD(evsel, cpu_map_idx, thread);
-		lseek(fd, SEEK_SET, 0);
-		if (evsel->pid_stat) {
-			/* The event exists solely on 1 CPU. */
-			if (cpu_map_idx == 0)
-				err = read_pid_stat_field(fd, system ? 15 : 14, &cur_time);
-			else
-				cur_time = 0;
-		} else {
-			/* The event is for all threads. */
-			if (thread == 0) {
-				struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus,
-									cpu_map_idx);
-
-				err = read_stat_field(fd, cpu, system ? 3 : 1, &cur_time);
-			} else {
-				cur_time = 0;
-			}
-		}
-		adjust = true;
-		break;
-	}
-	case PERF_TOOL_NONE:
-	case PERF_TOOL_MAX:
-	default:
-		err = -EINVAL;
-	}
-	if (err)
-		return err;
-
-	delta_start = cur_time - *start_time;
-	if (adjust) {
-		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
-
-		delta_start *= 1000000000 / ticks_per_sec;
-	}
-	count->val    = delta_start;
-	count->ena    = count->run = delta_start;
-	count->lost   = 0;
-	return 0;
-}
-
 int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
 {
 	if (evsel__is_tool(evsel))
@@ -2042,6 +1849,7 @@ static struct perf_thread_map *empty_thread_map;
 static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads)
 {
+	int ret = 0;
 	int nthreads = perf_thread_map__nr(threads);
 
 	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
@@ -2072,19 +1880,14 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	    perf_evsel__alloc_fd(&evsel->core, perf_cpu_map__nr(cpus), nthreads) < 0)
 		return -ENOMEM;
 
-	if ((evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
-	     evsel__tool_event(evsel) == PERF_TOOL_USER_TIME) &&
-	    !evsel->start_times) {
-		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus), nthreads, sizeof(__u64));
-		if (!evsel->start_times)
-			return -ENOMEM;
-	}
+	if (evsel__is_tool(evsel))
+		ret = evsel__tool_pmu_prepare_open(evsel, cpus, nthreads);
 
 	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
 	if (evsel->cgrp)
 		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
 
-	return 0;
+	return ret;
 }
 
 static void evsel__disable_missing_features(struct evsel *evsel)
@@ -2262,13 +2065,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err, old_errno;
 	enum rlimit_action set_rlimit = NO_CHANGE;
 
-	if (evsel__tool_event(evsel) == PERF_TOOL_DURATION_TIME) {
-		if (evsel->core.attr.sample_period) /* no sampling */
-			return -EINVAL;
-		evsel->start_time = rdclock();
-		return 0;
-	}
-
 	if (evsel__is_retire_lat(evsel))
 		return tpebs_start(evsel->evlist);
 
@@ -2293,6 +2089,12 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 	pr_debug3("Opening: %s\n", evsel__name(evsel));
 	display_attr(&evsel->core.attr);
 
+	if (evsel__is_tool(evsel)) {
+		return evsel__tool_pmu_open(evsel, threads,
+					    start_cpu_map_idx,
+					    end_cpu_map_idx);
+	}
+
 	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
 
 		for (thread = 0; thread < nthreads; thread++) {
@@ -2304,46 +2106,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 			if (!evsel->cgrp && !evsel->core.system_wide)
 				pid = perf_thread_map__pid(threads, thread);
 
-			if (evsel__tool_event(evsel) == PERF_TOOL_USER_TIME ||
-			    evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME) {
-				bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
-				__u64 *start_time = NULL;
-
-				if (evsel->core.attr.sample_period) {
-					/* no sampling */
-					err = -EINVAL;
-					goto out_close;
-				}
-				if (pid > -1) {
-					char buf[64];
-
-					snprintf(buf, sizeof(buf), "/proc/%d/stat", pid);
-					fd = open(buf, O_RDONLY);
-					evsel->pid_stat = true;
-				} else {
-					fd = open("/proc/stat", O_RDONLY);
-				}
-				FD(evsel, idx, thread) = fd;
-				if (fd < 0) {
-					err = -errno;
-					goto out_close;
-				}
-				start_time = xyarray__entry(evsel->start_times, idx, thread);
-				if (pid > -1) {
-					err = read_pid_stat_field(fd, system ? 15 : 14,
-								  start_time);
-				} else {
-					struct perf_cpu cpu;
-
-					cpu = perf_cpu_map__cpu(evsel->core.cpus, idx);
-					err = read_stat_field(fd, cpu, system ? 3 : 1,
-							      start_time);
-				}
-				if (err)
-					goto out_close;
-				continue;
-			}
-
 			group_fd = get_group_fd(evsel, idx, thread);
 
 			if (group_fd == -2) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15e745a9a798..bc30491bd490 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -11,6 +11,7 @@
 #include <perf/evsel.h>
 #include "symbol_conf.h"
 #include "pmus.h"
+#include "pmu.h"
 
 struct bpf_object;
 struct cgroup;
@@ -22,25 +23,9 @@ struct target;
 struct hashmap;
 struct bperf_leader_bpf;
 struct bperf_follower_bpf;
-struct perf_pmu;
 
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
-enum perf_tool_event {
-	PERF_TOOL_NONE		= 0,
-	PERF_TOOL_DURATION_TIME = 1,
-	PERF_TOOL_USER_TIME = 2,
-	PERF_TOOL_SYSTEM_TIME = 3,
-
-	PERF_TOOL_MAX,
-};
-
-const char *perf_tool_event__to_str(enum perf_tool_event ev);
-enum perf_tool_event perf_tool_event__from_str(const char *str);
-
-#define perf_tool_event__for_each_event(ev)		\
-	for ((ev) = PERF_TOOL_DURATION_TIME; (ev) < PERF_TOOL_MAX; ev++)
-
 /** struct evsel - event selector
  *
  * @evlist - evlist this evsel is in, if it is in one.
@@ -83,7 +68,6 @@ struct evsel {
 		const char		*unit;
 		struct cgroup		*cgrp;
 		const char		*metric_id;
-		enum perf_tool_event	tool_event;
 		/* parse modifier helper */
 		int			exclude_GH;
 		int			sample_read;
@@ -320,21 +304,11 @@ const char *evsel__name(struct evsel *evsel);
 bool evsel__name_is(struct evsel *evsel, const char *name);
 const char *evsel__metric_id(const struct evsel *evsel);
 
-static inline bool evsel__is_tool(const struct evsel *evsel)
-{
-	return evsel->tool_event != PERF_TOOL_NONE;
-}
-
 static inline bool evsel__is_retire_lat(const struct evsel *evsel)
 {
 	return evsel->retire_lat;
 }
 
-static inline enum perf_tool_event evsel__tool_event(const struct evsel *evsel)
-{
-	return evsel->tool_event;
-}
-
 const char *evsel__group_name(struct evsel *evsel);
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4dff3e925a47..9181548e8881 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -14,6 +14,7 @@
 #include "pmus.h"
 #include "print-events.h"
 #include "smt.h"
+#include "tool_pmu.h"
 #include "expr.h"
 #include "rblist.h"
 #include <string.h>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b68a744f41ba..80e2b4e06ab0 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -297,36 +297,6 @@ static int add_event(struct list_head *list, int *idx,
 			   /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOMEM;
 }
 
-static int add_event_tool(struct list_head *list, int *idx,
-			  enum perf_tool_event tool_event)
-{
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type = PERF_TYPE_SOFTWARE,
-		.config = PERF_COUNT_SW_DUMMY,
-	};
-	const char *cpu_list = NULL;
-
-	if (tool_event == PERF_TOOL_DURATION_TIME) {
-		/* Duration time is gathered globally, pretend it is only on CPU0. */
-		cpu_list = "0";
-	}
-	evsel = __add_event(list, idx, &attr, /*init_attr=*/true, /*name=*/NULL,
-			    /*metric_id=*/NULL, /*pmu=*/NULL,
-			    /*config_terms=*/NULL, /*auto_merge_stats=*/false,
-			    cpu_list);
-	if (!evsel)
-		return -ENOMEM;
-	evsel->tool_event = tool_event;
-	if (tool_event == PERF_TOOL_DURATION_TIME
-	    || tool_event == PERF_TOOL_USER_TIME
-	    || tool_event == PERF_TOOL_SYSTEM_TIME) {
-		free((char *)evsel->unit);
-		evsel->unit = strdup("ns");
-	}
-	return 0;
-}
-
 /**
  * parse_aliases - search names for entries beginning or equalling str ignoring
  *                 case. If mutliple entries in names match str then the longest
@@ -1400,13 +1370,6 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 					type, /*extended_type=*/0, config, head_config);
 }
 
-int parse_events_add_tool(struct parse_events_state *parse_state,
-			  struct list_head *list,
-			  int tool_event)
-{
-	return add_event_tool(list, &parse_state->idx, tool_event);
-}
-
 static bool config_term_percore(struct list_head *config_terms)
 {
 	struct evsel_config_term *term;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index cf3f07db0295..d77be173af22 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -223,9 +223,6 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
 			     u32 type, u64 config,
 			     const struct parse_events_terms *head_config,
 			     bool wildcard);
-int parse_events_add_tool(struct parse_events_state *parse_state,
-			  struct list_head *list,
-			  int tool_event);
 int parse_events_add_cache(struct list_head *list, int *idx, const char *name,
 			   struct parse_events_state *parse_state,
 			   struct parse_events_terms *parsed_terms);
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 5a0bcd7f166a..14e5bd856a18 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -121,14 +121,6 @@ static int sym(yyscan_t scanner, int type, int config)
 	return type == PERF_TYPE_HARDWARE ? PE_VALUE_SYM_HW : PE_VALUE_SYM_SW;
 }
 
-static int tool(yyscan_t scanner, enum perf_tool_event event)
-{
-	YYSTYPE *yylval = parse_events_get_lval(scanner);
-
-	yylval->num = event;
-	return PE_VALUE_SYM_TOOL;
-}
-
 static int term(yyscan_t scanner, enum parse_events__term_type type)
 {
 	YYSTYPE *yylval = parse_events_get_lval(scanner);
@@ -404,9 +396,6 @@ cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COU
 alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
 emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
-duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
-user_time						{ return tool(yyscanner, PERF_TOOL_USER_TIME); }
-system_time						{ return tool(yyscanner, PERF_TOOL_SYSTEM_TIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
 cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b3c51f06cbdc..5c4669264177 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -56,7 +56,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 
 %token PE_START_EVENTS PE_START_TERMS
 %token PE_VALUE PE_VALUE_SYM_HW PE_VALUE_SYM_SW PE_TERM
-%token PE_VALUE_SYM_TOOL
 %token PE_EVENT_NAME
 %token PE_RAW PE_NAME
 %token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
@@ -68,7 +67,6 @@ static void free_list_evsel(struct list_head* list_evsel)
 %type <num> PE_VALUE
 %type <num> PE_VALUE_SYM_HW
 %type <num> PE_VALUE_SYM_SW
-%type <num> PE_VALUE_SYM_TOOL
 %type <mod> PE_MODIFIER_EVENT
 %type <term_type> PE_TERM
 %type <num> value_sym
@@ -350,20 +348,6 @@ value_sym sep_slash_slash_dc
 		PE_ABORT(err);
 	$$ = list;
 }
-|
-PE_VALUE_SYM_TOOL sep_slash_slash_dc
-{
-	struct list_head *list;
-	int err;
-
-	list = alloc_list();
-	if (!list)
-		YYNOMEM;
-	err = parse_events_add_tool(_parse_state, list, $1);
-	if (err)
-		YYNOMEM;
-	$$ = list;
-}
 
 event_legacy_cache:
 PE_LEGACY_CACHE opt_event_config
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 29bd0fa9f88c..bbb8e207c6b9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -19,6 +19,7 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "tool_pmu.h"
 #include <util/pmu-bison.h>
 #include <util/pmu-flex.h>
 #include "parse-events.h"
@@ -1548,6 +1549,9 @@ int perf_pmu__config(struct perf_pmu *pmu, struct perf_event_attr *attr,
 {
 	bool zero = !!pmu->perf_event_attr_init_default;
 
+	if (perf_pmu__is_tool(pmu))
+		return tool_pmu__config_terms(attr, head_terms, err);
+
 	/* Fake PMU doesn't have proper terms so nothing to configure in attr. */
 	if (perf_pmu__is_fake(pmu))
 		return 0;
@@ -1660,8 +1664,8 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct parse_events_terms *head_
 	info->scale    = 0.0;
 	info->snapshot = false;
 
-	/* Fake PMU doesn't rewrite terms. */
-	if (perf_pmu__is_fake(pmu))
+	/* Tool/fake PMU doesn't rewrite terms. */
+	if (perf_pmu__is_tool(pmu) || perf_pmu__is_fake(pmu))
 		goto out;
 
 	list_for_each_entry_safe(term, h, &head_terms->terms, list) {
@@ -1827,6 +1831,8 @@ bool perf_pmu__have_event(struct perf_pmu *pmu, const char *name)
 {
 	if (!name)
 		return false;
+	if (perf_pmu__is_tool(pmu))
+		return perf_tool_event__from_str(name) != PERF_TOOL_NONE;
 	if (perf_pmu__find_alias(pmu, name, /*load=*/ true) != NULL)
 		return true;
 	if (pmu->cpu_aliases_added || !pmu->events_table)
@@ -1838,6 +1844,9 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
+	if (perf_pmu__is_tool(pmu))
+		return tool_pmu__num_events();
+
 	pmu_aliases_parse(pmu);
 	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;
 
@@ -1898,6 +1907,9 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	int ret = 0;
 	struct strbuf sb;
 
+	if (perf_pmu__is_tool(pmu))
+		return tool_pmu__for_each_event_cb(pmu, state, cb);
+
 	strbuf_init(&sb, /*hint=*/ 0);
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
@@ -1986,6 +1998,7 @@ bool perf_pmu__is_software(const struct perf_pmu *pmu)
 	case PERF_TYPE_HW_CACHE:	return false;
 	case PERF_TYPE_RAW:		return false;
 	case PERF_TYPE_BREAKPOINT:	return true;
+	case PERF_PMU_TYPE_TOOL:	return true;
 	default: break;
 	}
 	for (size_t i = 0; i < ARRAY_SIZE(known_sw_pmus); i++) {
@@ -2313,6 +2326,9 @@ const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
 	if (!pmu)
 		return NULL;
 
+	if (perf_pmu__is_tool(pmu))
+		return perf_tool_event__to_str(config);
+
 	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index af7532ca7fb1..880a8dc661b7 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -37,6 +37,7 @@ struct perf_pmu_caps {
 };
 
 enum {
+	PERF_PMU_TYPE_TOOL = 0xFFFFFFFE,
 	PERF_PMU_TYPE_FAKE = 0xFFFFFFFF,
 };
 
@@ -282,6 +283,7 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
+
 const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 
 #endif /* __PMU_H */
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 93e5c0435ee0..36329bc77316 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -15,6 +15,7 @@
 #include "evsel.h"
 #include "pmus.h"
 #include "pmu.h"
+#include "tool_pmu.h"
 #include "print-events.h"
 #include "strbuf.h"
 
@@ -200,6 +201,7 @@ static void pmu_read_sysfs(bool core_only)
 	int fd;
 	DIR *dir;
 	struct dirent *dent;
+	struct perf_pmu *tool_pmu;
 
 	if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
 		return;
@@ -229,6 +231,10 @@ static void pmu_read_sysfs(bool core_only)
 			pr_err("Failure to set up any core PMUs\n");
 	}
 	list_sort(NULL, &core_pmus, pmus_cmp);
+	if (!core_only) {
+		tool_pmu = perf_pmus__tool_pmu();
+		list_add_tail(&tool_pmu->list, &other_pmus);
+	}
 	list_sort(NULL, &other_pmus, pmus_cmp);
 	if (!list_empty(&core_pmus)) {
 		read_sysfs_core_pmus = true;
@@ -584,6 +590,9 @@ void perf_pmus__print_raw_pmu_events(const struct print_callbacks *print_cb, voi
 		int len = pmu_name_len_no_suffix(pmu->name);
 		const char *desc = "(see 'man perf-list' or 'man perf-record' on how to encode it)";
 
+		if (perf_pmu__is_tool(pmu))
+			continue;
+
 		if (!pmu->is_core)
 			desc = NULL;
 
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 81e0135cddf0..a786cbfb0ff5 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -29,6 +29,7 @@
 #include "tracepoint.h"
 #include "pfm.h"
 #include "thread_map.h"
+#include "tool_pmu.h"
 #include "util.h"
 
 #define MAX_NAME_LEN 100
@@ -43,21 +44,6 @@ static const char * const event_type_descriptors[] = {
 	"Hardware breakpoint",
 };
 
-static const struct event_symbol event_symbols_tool[PERF_TOOL_MAX] = {
-	[PERF_TOOL_DURATION_TIME] = {
-		.symbol = "duration_time",
-		.alias  = "",
-	},
-	[PERF_TOOL_USER_TIME] = {
-		.symbol = "user_time",
-		.alias  = "",
-	},
-	[PERF_TOOL_SYSTEM_TIME] = {
-		.symbol = "system_time",
-		.alias  = "",
-	},
-};
-
 /*
  * Print the events from <debugfs_mount_point>/tracing/events
  */
@@ -341,24 +327,6 @@ int print_hwcache_events(const struct print_callbacks *print_cb, void *print_sta
 	return 0;
 }
 
-void print_tool_events(const struct print_callbacks *print_cb, void *print_state)
-{
-	// Start at 1 because the first enum entry means no tool event.
-	for (int i = 1; i < PERF_TOOL_MAX; ++i) {
-		print_cb->print_event(print_state,
-				"tool",
-				/*pmu_name=*/NULL,
-				event_symbols_tool[i].symbol,
-				event_symbols_tool[i].alias,
-				/*scale_unit=*/NULL,
-				/*deprecated=*/false,
-				"Tool event",
-				/*desc=*/NULL,
-				/*long_desc=*/NULL,
-				/*encoding_desc=*/NULL);
-	}
-}
-
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max)
@@ -422,8 +390,6 @@ void print_events(const struct print_callbacks *print_cb, void *print_state)
 	print_symbol_events(print_cb, print_state, PERF_TYPE_SOFTWARE,
 			event_symbols_sw, PERF_COUNT_SW_MAX);
 
-	print_tool_events(print_cb, print_state);
-
 	print_hwcache_events(print_cb, print_state);
 
 	perf_pmus__print_pmu_events(print_cb, print_state);
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index bf4290bef0cd..445efa1636c1 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -36,7 +36,6 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 void print_symbol_events(const struct print_callbacks *print_cb, void *print_state,
 			 unsigned int type, const struct event_symbol *syms,
 			 unsigned int max);
-void print_tool_events(const struct print_callbacks *print_cb, void *print_state);
 void print_tracepoint_events(const struct print_callbacks *print_cb, void *print_state);
 bool is_event_supported(u8 type, u64 config);
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ea96e4ebad8c..a82a8ec79b39 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -21,6 +21,7 @@
 #include "iostat.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "tool_pmu.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -946,7 +947,10 @@ static bool should_skip_zero_counter(struct perf_stat_config *config,
 	if (config->aggr_mode == AGGR_THREAD && config->system_wide)
 		return true;
 
-	/* Tool events have the software PMU but are only gathered on 1. */
+	/*
+	 * Many tool events are only gathered on the first index, skip other
+	 * zero values.
+	 */
 	if (evsel__is_tool(counter))
 		return true;
 
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 99376c12dd8e..2d653f91400e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -15,6 +15,7 @@
 #include <linux/zalloc.h>
 #include "iostat.h"
 #include "util/hashmap.h"
+#include "tool_pmu.h"
 
 struct stats walltime_nsecs_stats;
 struct rusage_stats ru_stats;
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
new file mode 100644
index 000000000000..89b64f6482d9
--- /dev/null
+++ b/tools/perf/util/tool_pmu.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "cgroup.h"
+#include "counts.h"
+#include "evsel.h"
+#include "pmu.h"
+#include "print-events.h"
+#include "time-utils.h"
+#include "tool_pmu.h"
+#include <api/io.h>
+#include <internal/threadmap.h>
+#include <perf/threadmap.h>
+#include <fcntl.h>
+#include <strings.h>
+
+static const char *const tool_pmu__event_names[PERF_TOOL_MAX] = {
+	NULL,
+	"duration_time",
+	"user_time",
+	"system_time",
+};
+
+
+const char *perf_tool_event__to_str(enum perf_tool_event ev)
+{
+	if (ev > PERF_TOOL_NONE && ev < PERF_TOOL_MAX)
+		return tool_pmu__event_names[ev];
+
+	return NULL;
+}
+
+enum perf_tool_event perf_tool_event__from_str(const char *str)
+{
+	int i;
+
+	perf_tool_event__for_each_event(i) {
+		if (!strcasecmp(str, tool_pmu__event_names[i]))
+			return i;
+	}
+	return PERF_TOOL_NONE;
+}
+
+static int tool_pmu__config_term(struct perf_event_attr *attr,
+				 struct parse_events_term *term,
+				 struct parse_events_error *err)
+{
+	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER) {
+		enum perf_tool_event ev = perf_tool_event__from_str(term->config);
+
+		if (ev == PERF_TOOL_NONE)
+			goto err_out;
+
+		attr->config = ev;
+		return 0;
+	}
+err_out:
+	if (err) {
+		char *err_str;
+
+		parse_events_error__handle(err, term->err_val,
+					asprintf(&err_str,
+						"unexpected tool event term (%s) %s",
+						parse_events__term_type_str(term->type_term),
+						term->config) < 0
+					? strdup("unexpected tool event term")
+					: err_str,
+					NULL);
+	}
+	return -EINVAL;
+}
+
+int tool_pmu__config_terms(struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err)
+{
+	struct parse_events_term *term;
+
+	list_for_each_entry(term, &terms->terms, list) {
+		if (tool_pmu__config_term(attr, term, err))
+			return -EINVAL;
+	}
+
+	return 0;
+
+}
+
+int tool_pmu__for_each_event_cb(struct perf_pmu *pmu, void *state, pmu_event_callback cb)
+{
+	struct pmu_event_info info = {
+		.pmu = pmu,
+		.event_type_desc = "Tool event",
+	};
+	int i;
+
+	perf_tool_event__for_each_event(i) {
+		int ret;
+
+		info.name = perf_tool_event__to_str(i);
+		info.alias = NULL;
+		info.scale_unit = NULL;
+		info.desc = NULL;
+		info.long_desc = NULL;
+		info.encoding_desc = NULL;
+		info.topic = NULL;
+		info.pmu_name = pmu->name;
+		info.deprecated = false;
+		ret = cb(state, &info);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+bool perf_pmu__is_tool(const struct perf_pmu *pmu)
+{
+	return pmu && pmu->type == PERF_PMU_TYPE_TOOL;
+}
+
+bool evsel__is_tool(const struct evsel *evsel)
+{
+	return perf_pmu__is_tool(evsel->pmu);
+}
+
+enum perf_tool_event evsel__tool_event(const struct evsel *evsel)
+{
+	if (!evsel__is_tool(evsel))
+		return PERF_TOOL_NONE;
+
+	return (enum perf_tool_event)evsel->core.attr.config;
+}
+
+const char *evsel__tool_pmu_event_name(const struct evsel *evsel)
+{
+	return perf_tool_event__to_str(evsel->core.attr.config);
+}
+
+static bool read_until_char(struct io *io, char e)
+{
+	int c;
+
+	do {
+		c = io__get_char(io);
+		if (c == -1)
+			return false;
+	} while (c != e);
+	return true;
+}
+
+static int read_stat_field(int fd, struct perf_cpu cpu, int field, __u64 *val)
+{
+	char buf[256];
+	struct io io;
+	int i;
+
+	io__init(&io, fd, buf, sizeof(buf));
+
+	/* Skip lines to relevant CPU. */
+	for (i = -1; i < cpu.cpu; i++) {
+		if (!read_until_char(&io, '\n'))
+			return -EINVAL;
+	}
+	/* Skip to "cpu". */
+	if (io__get_char(&io) != 'c') return -EINVAL;
+	if (io__get_char(&io) != 'p') return -EINVAL;
+	if (io__get_char(&io) != 'u') return -EINVAL;
+
+	/* Skip N of cpuN. */
+	if (!read_until_char(&io, ' '))
+		return -EINVAL;
+
+	i = 1;
+	while (true) {
+		if (io__get_dec(&io, val) != ' ')
+			break;
+		if (field == i)
+			return 0;
+		i++;
+	}
+	return -EINVAL;
+}
+
+static int read_pid_stat_field(int fd, int field, __u64 *val)
+{
+	char buf[256];
+	struct io io;
+	int c, i;
+
+	io__init(&io, fd, buf, sizeof(buf));
+	if (io__get_dec(&io, val) != ' ')
+		return -EINVAL;
+	if (field == 1)
+		return 0;
+
+	/* Skip comm. */
+	if (io__get_char(&io) != '(' || !read_until_char(&io, ')'))
+		return -EINVAL;
+	if (field == 2)
+		return -EINVAL; /* String can't be returned. */
+
+	/* Skip state */
+	if (io__get_char(&io) != ' ' || io__get_char(&io) == -1)
+		return -EINVAL;
+	if (field == 3)
+		return -EINVAL; /* String can't be returned. */
+
+	/* Loop over numeric fields*/
+	if (io__get_char(&io) != ' ')
+		return -EINVAL;
+
+	i = 4;
+	while (true) {
+		c = io__get_dec(&io, val);
+		if (c == -1)
+			return -EINVAL;
+		if (c == -2) {
+			/* Assume a -ve was read */
+			c = io__get_dec(&io, val);
+			*val *= -1;
+		}
+		if (c != ' ')
+			return -EINVAL;
+		if (field == i)
+			return 0;
+		i++;
+	}
+	return -EINVAL;
+}
+
+
+
+int evsel__tool_pmu_prepare_open(struct evsel *evsel,
+				 struct perf_cpu_map *cpus,
+				 int nthreads)
+{
+	if ((evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME ||
+	     evsel__tool_event(evsel) == PERF_TOOL_USER_TIME) &&
+	    !evsel->start_times) {
+		evsel->start_times = xyarray__new(perf_cpu_map__nr(cpus),
+						  nthreads,
+						  sizeof(__u64));
+		if (!evsel->start_times)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+#define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
+
+int evsel__tool_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx)
+{
+	enum perf_tool_event ev = evsel__tool_event(evsel);
+	int pid = -1, idx = 0, thread = 0, nthreads, err = 0, old_errno;
+
+	if (ev == PERF_TOOL_DURATION_TIME) {
+		if (evsel->core.attr.sample_period) /* no sampling */
+			return -EINVAL;
+		evsel->start_time = rdclock();
+		return 0;
+	}
+
+	if (evsel->cgrp)
+		pid = evsel->cgrp->fd;
+
+	nthreads = perf_thread_map__nr(threads);
+	for (idx = start_cpu_map_idx; idx < end_cpu_map_idx; idx++) {
+		for (thread = 0; thread < nthreads; thread++) {
+			if (thread >= nthreads)
+				break;
+
+			if (!evsel->cgrp && !evsel->core.system_wide)
+				pid = perf_thread_map__pid(threads, thread);
+
+			if (ev == PERF_TOOL_USER_TIME || ev == PERF_TOOL_SYSTEM_TIME) {
+				bool system = ev == PERF_TOOL_SYSTEM_TIME;
+				__u64 *start_time = NULL;
+				int fd;
+
+				if (evsel->core.attr.sample_period) {
+					/* no sampling */
+					err = -EINVAL;
+					goto out_close;
+				}
+				if (pid > -1) {
+					char buf[64];
+
+					snprintf(buf, sizeof(buf), "/proc/%d/stat", pid);
+					fd = open(buf, O_RDONLY);
+					evsel->pid_stat = true;
+				} else {
+					fd = open("/proc/stat", O_RDONLY);
+				}
+				FD(evsel, idx, thread) = fd;
+				if (fd < 0) {
+					err = -errno;
+					goto out_close;
+				}
+				start_time = xyarray__entry(evsel->start_times, idx, thread);
+				if (pid > -1) {
+					err = read_pid_stat_field(fd, system ? 15 : 14,
+								  start_time);
+				} else {
+					struct perf_cpu cpu;
+
+					cpu = perf_cpu_map__cpu(evsel->core.cpus, idx);
+					err = read_stat_field(fd, cpu, system ? 3 : 1,
+							      start_time);
+				}
+				if (err)
+					goto out_close;
+			}
+
+		}
+	}
+	return 0;
+out_close:
+	if (err)
+		threads->err_thread = thread;
+
+	old_errno = errno;
+	do {
+		while (--thread >= 0) {
+			if (FD(evsel, idx, thread) >= 0)
+				close(FD(evsel, idx, thread));
+			FD(evsel, idx, thread) = -1;
+		}
+		thread = nthreads;
+	} while (--idx >= 0);
+	errno = old_errno;
+	return err;
+}
+
+int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread)
+{
+	__u64 *start_time, cur_time, delta_start;
+	int fd, err = 0;
+	struct perf_counts_values *count;
+	bool adjust = false;
+
+	count = perf_counts(evsel->counts, cpu_map_idx, thread);
+
+	switch (evsel__tool_event(evsel)) {
+	case PERF_TOOL_DURATION_TIME:
+		/*
+		 * Pretend duration_time is only on the first CPU and thread, or
+		 * else aggregation will scale duration_time by the number of
+		 * CPUs/threads.
+		 */
+		start_time = &evsel->start_time;
+		if (cpu_map_idx == 0 && thread == 0)
+			cur_time = rdclock();
+		else
+			cur_time = *start_time;
+		break;
+	case PERF_TOOL_USER_TIME:
+	case PERF_TOOL_SYSTEM_TIME: {
+		bool system = evsel__tool_event(evsel) == PERF_TOOL_SYSTEM_TIME;
+
+		start_time = xyarray__entry(evsel->start_times, cpu_map_idx, thread);
+		fd = FD(evsel, cpu_map_idx, thread);
+		lseek(fd, SEEK_SET, 0);
+		if (evsel->pid_stat) {
+			/* The event exists solely on 1 CPU. */
+			if (cpu_map_idx == 0)
+				err = read_pid_stat_field(fd, system ? 15 : 14, &cur_time);
+			else
+				cur_time = 0;
+		} else {
+			/* The event is for all threads. */
+			if (thread == 0) {
+				struct perf_cpu cpu = perf_cpu_map__cpu(evsel->core.cpus,
+									cpu_map_idx);
+
+				err = read_stat_field(fd, cpu, system ? 3 : 1, &cur_time);
+			} else {
+				cur_time = 0;
+			}
+		}
+		adjust = true;
+		break;
+	}
+	case PERF_TOOL_NONE:
+	case PERF_TOOL_MAX:
+	default:
+		err = -EINVAL;
+	}
+	if (err)
+		return err;
+
+	delta_start = cur_time - *start_time;
+	if (adjust) {
+		__u64 ticks_per_sec = sysconf(_SC_CLK_TCK);
+
+		delta_start *= 1000000000 / ticks_per_sec;
+	}
+	count->val    = delta_start;
+	count->ena    = count->run = delta_start;
+	count->lost   = 0;
+	return 0;
+}
+
+struct perf_pmu *perf_pmus__tool_pmu(void)
+{
+	static struct perf_pmu tool = {
+		.name = "tool",
+		.type = PERF_PMU_TYPE_TOOL,
+		.format = LIST_HEAD_INIT(tool.format),
+	};
+
+	return &tool;
+}
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
new file mode 100644
index 000000000000..05a4052c8b9d
--- /dev/null
+++ b/tools/perf/util/tool_pmu.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TOOL_PMU_H
+#define __TOOL_PMU_H
+
+#include "pmu.h"
+
+struct evsel;
+struct perf_thread_map;
+struct print_callbacks;
+
+enum perf_tool_event {
+	PERF_TOOL_NONE = 0,
+	PERF_TOOL_DURATION_TIME = 1,
+	PERF_TOOL_USER_TIME = 2,
+	PERF_TOOL_SYSTEM_TIME = 3,
+
+	PERF_TOOL_MAX,
+};
+
+#define perf_tool_event__for_each_event(ev)				\
+	for ((ev) = PERF_TOOL_DURATION_TIME; (ev) < PERF_TOOL_MAX; ev++)
+
+static inline size_t tool_pmu__num_events(void)
+{
+	return PERF_TOOL_MAX - 1;
+}
+
+const char *perf_tool_event__to_str(enum perf_tool_event ev);
+enum perf_tool_event perf_tool_event__from_str(const char *str);
+int tool_pmu__config_terms(struct perf_event_attr *attr,
+			   struct parse_events_terms *terms,
+			   struct parse_events_error *err);
+int tool_pmu__for_each_event_cb(struct perf_pmu *pmu, void *state, pmu_event_callback cb);
+
+bool perf_pmu__is_tool(const struct perf_pmu *pmu);
+
+
+bool evsel__is_tool(const struct evsel *evsel);
+enum perf_tool_event evsel__tool_event(const struct evsel *evsel);
+const char *evsel__tool_pmu_event_name(const struct evsel *evsel);
+int evsel__tool_pmu_prepare_open(struct evsel *evsel,
+				 struct perf_cpu_map *cpus,
+				 int nthreads);
+int evsel__tool_pmu_open(struct evsel *evsel,
+			 struct perf_thread_map *threads,
+			 int start_cpu_map_idx, int end_cpu_map_idx);
+int evsel__read_tool(struct evsel *evsel, int cpu_map_idx, int thread);
+
+struct perf_pmu *perf_pmus__tool_pmu(void);
+
+#endif /* __TOOL_PMU_H */
-- 
2.46.0.469.g59c65b2a67-goog


