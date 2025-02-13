Return-Path: <linux-kernel+bounces-512543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3FA33AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BE1188D74E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459F2101B7;
	Thu, 13 Feb 2025 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTbuTTxg"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A3F20E309
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437724; cv=none; b=CqUcS0HRv/7soWfDJSiPX5Izq77rrCN0xr2oDvSULrepiD9o02+qgGw8OiCeSLWSbCzDL4UKs+ZNne2c+llfa+FkAxBZ53i8Ka612A7Vn255dgf+Q+juQENW8DezUXFgx4weHPaJGPPG+o57QZaZk6K88dwtTnHSuxnD4smA9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437724; c=relaxed/simple;
	bh=9gukdcfV9Nf9Mc/TOrp11xJ/gBhYjmqkZTKk9PTNb30=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PFHSvAt4BLGnHIulgAsxnjOuyqnEc7Iw6lJdxO1D9fneM82eWox28SK3/B6ACS/p6pIH2F1amGESsHnrLqEH2jX3GGkGuFuRkwkgIDoqDXHvg9sOA2Xqu8CgS2l2qpOAM0GHhpXSMgfBYBS9MPO5sd+IF3ZUswHEcD77CvbPBCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTbuTTxg; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ab7e1beaa45so73780966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739437721; x=1740042521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9f+e9kCTsyr4pVok6kl9UHneh9IdRYlU7MPwMhOzrI=;
        b=RTbuTTxgj42tCsc0RiibASyaHCcGotDcIYWy92tBAUuoMnVliuswVCKt/U1WyzOC1V
         HsLOqVGYOXCFiALMR3lhOn67j8JKfJTSnPwSkLJ48m6GLW3qVRAcwlVu8vxinjdhx2nN
         mma8D5mksuxHBf5sNO4XWLIVMLyLGKAOnfFw8hNB1P+b0V2HVpbcoAdLvjSlj2wSeux9
         txWEqePBUi7K/km2IYrG0ZNO63kbuGr+HNefqbhU5mM6TFORv9om42kAMERocx92TOk1
         u8O3IFESiIX2M6IfnEIK26BgZemo3HkTZRlIKP7FR23pnAgZntFnBTicbXBuuLxYA70+
         Esqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437721; x=1740042521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9f+e9kCTsyr4pVok6kl9UHneh9IdRYlU7MPwMhOzrI=;
        b=mQffWQERoFOxhxBuBY1wKn3R4Rmw4IaowJW7n4jRtD2fQFii+N1wvcsgabGOtx8kk0
         s+VXhRhTXBuekSsJAaoKrIa3atan76HW4kEmMMkVPZUyFAyk2vW9OXaePjSQlFM5K7W6
         W+nvFWgZql8aJDAPF/T79czhxoL8uAIcGcQXywBORe86xgW4kj87dFFd51O3D0epxals
         EXKvml99WHQtygel5hMpChgJvF5HeHiN8JWX9ChgfurCcOKjb0XSDdNJ9RD9ea4KCqtZ
         lWsmNnS83HziqZkznsL70aCoHR3hEWXWv63imv0n7fO9m6xiSlV0cXONeMLlN+7RgADp
         Zthg==
X-Forwarded-Encrypted: i=1; AJvYcCWmeQAFtA01DB59W4ZaZru0d0cyPDQFhYtLn0FroKr/wKcIt83rSUwjt2Y9Sr4hPRYGLTDixGiDbv/qm8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ewtiWSlkTfUI+pgjJxv5q85WqFpfZtYXacc+Qi317DBa+Baw
	VF4Sk+G4WKmRSs7a6TswxPjV2CSoBLsHalrr2qbXIZHZ0aM7SzSvnih/TqbA993Pmgyl2CoqFCR
	QFm9uVg==
X-Google-Smtp-Source: AGHT+IFnZI34vFrDlF4QR8m8y6Jps3gdJLmqcSJyyQ/NTGFCYAh5/9C3IJgivuf4buDViN6P7KIFLY9nD+HL
X-Received: from edbig14.prod.google.com ([2002:a05:6402:458e:b0:5db:68bc:eb3d])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:1c85:b0:aa6:9624:78f1
 with SMTP id a640c23a62f3a-ab7f3714978mr662602066b.9.1739437720849; Thu, 13
 Feb 2025 01:08:40 -0800 (PST)
Date: Thu, 13 Feb 2025 10:08:17 +0100
In-Reply-To: <cover.1739437531.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <e61348985ff0a6a14b07c39e880edbd60a8f8635.1739437531.git.dvyukov@google.com>
Subject: [PATCH v7 4/9] perf report: Add parallelism filter
From: Dmitry Vyukov <dvyukov@google.com>
To: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	ak@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

Add parallelism filter that can be used to look at specific parallelism
levels only. The format is the same as cpu lists. For example:

Only single-threaded samples: --parallelism=1
Low parallelism only: --parallelism=1-4
High parallelism only: --parallelism=64-128

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/builtin-report.c   |  5 ++++-
 tools/perf/util/event.c       |  2 ++
 tools/perf/util/hist.c        | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/hist.h        |  6 +++++-
 tools/perf/util/sort.c        | 11 +++++++++++
 tools/perf/util/symbol.c      | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/symbol_conf.h |  4 ++++
 7 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 14d49f0625881..2a19abdc869a1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1390,6 +1390,8 @@ int cmd_report(int argc, const char **argv)
 		     symbol__config_symfs),
 	OPT_STRING('C', "cpu", &report.cpu_list, "cpu",
 		   "list of cpus to profile"),
+	OPT_STRING(0, "parallelism", &symbol_conf.parallelism_list_str, "parallelism",
+		   "only consider these parallelism levels (cpu set format)"),
 	OPT_BOOLEAN('I', "show-info", &report.show_full_info,
 		    "Display extended information about perf.data file"),
 	OPT_BOOLEAN(0, "source", &annotate_opts.annotate_src,
@@ -1721,7 +1723,8 @@ int cmd_report(int argc, const char **argv)
 	}
 
 	if (report.disable_order || !perf_session__has_switch_events(session)) {
-		if ((sort_order && strstr(sort_order, "parallelism")) ||
+		if (symbol_conf.parallelism_list_str ||
+				(sort_order && strstr(sort_order, "parallelism")) ||
 				(field_order && strstr(field_order, "parallelism"))) {
 			if (report.disable_order)
 				ui__error("Use of parallelism is incompatible with --disable-order.\n");
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 2f10e31157572..6ceed46acd5a4 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -769,6 +769,8 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
 
 	/* Account for possible out-of-order switch events. */
 	al->parallelism = max(1, min(machine->parallelism, machine__nr_cpus_avail(machine)));
+	if (test_bit(al->parallelism, symbol_conf.parallelism_filter))
+		al->filtered |= (1 << HIST_FILTER__PARALLELISM);
 
 	if (al->map) {
 		if (symbol_conf.dso_list &&
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 6b8f8da8d3b66..446342246f5ee 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -43,6 +43,8 @@ static bool hists__filter_entry_by_symbol(struct hists *hists,
 					  struct hist_entry *he);
 static bool hists__filter_entry_by_socket(struct hists *hists,
 					  struct hist_entry *he);
+static bool hists__filter_entry_by_parallelism(struct hists *hists,
+					       struct hist_entry *he);
 
 u16 hists__col_len(struct hists *hists, enum hist_column col)
 {
@@ -1457,6 +1459,10 @@ static void hist_entry__check_and_remove_filter(struct hist_entry *he,
 		if (symbol_conf.sym_list == NULL)
 			return;
 		break;
+	case HIST_FILTER__PARALLELISM:
+		if (__bitmap_weight(symbol_conf.parallelism_filter, MAX_NR_CPUS + 1) == 0)
+			return;
+		break;
 	case HIST_FILTER__PARENT:
 	case HIST_FILTER__GUEST:
 	case HIST_FILTER__HOST:
@@ -1515,6 +1521,9 @@ static void hist_entry__apply_hierarchy_filters(struct hist_entry *he)
 	hist_entry__check_and_remove_filter(he, HIST_FILTER__SYMBOL,
 					    perf_hpp__is_sym_entry);
 
+	hist_entry__check_and_remove_filter(he, HIST_FILTER__PARALLELISM,
+					    perf_hpp__is_parallelism_entry);
+
 	hists__apply_filters(he->hists, he);
 }
 
@@ -1711,6 +1720,7 @@ static void hists__apply_filters(struct hists *hists, struct hist_entry *he)
 	hists__filter_entry_by_thread(hists, he);
 	hists__filter_entry_by_symbol(hists, he);
 	hists__filter_entry_by_socket(hists, he);
+	hists__filter_entry_by_parallelism(hists, he);
 }
 
 int hists__collapse_resort(struct hists *hists, struct ui_progress *prog)
@@ -2197,6 +2207,16 @@ static bool hists__filter_entry_by_socket(struct hists *hists,
 	return false;
 }
 
+static bool hists__filter_entry_by_parallelism(struct hists *hists,
+					       struct hist_entry *he)
+{
+	if (test_bit(he->parallelism, hists->parallelism_filter)) {
+		he->filtered |= (1 << HIST_FILTER__PARALLELISM);
+		return true;
+	}
+	return false;
+}
+
 typedef bool (*filter_fn_t)(struct hists *hists, struct hist_entry *he);
 
 static void hists__filter_by_type(struct hists *hists, int type, filter_fn_t filter)
@@ -2366,6 +2386,16 @@ void hists__filter_by_socket(struct hists *hists)
 				      hists__filter_entry_by_socket);
 }
 
+void hists__filter_by_parallelism(struct hists *hists)
+{
+	if (symbol_conf.report_hierarchy)
+		hists__filter_hierarchy(hists, HIST_FILTER__PARALLELISM,
+					hists->parallelism_filter);
+	else
+		hists__filter_by_type(hists, HIST_FILTER__PARALLELISM,
+				      hists__filter_entry_by_parallelism);
+}
+
 void events_stats__inc(struct events_stats *stats, u32 type)
 {
 	++stats->nr_events[0];
@@ -2872,6 +2902,7 @@ int __hists__init(struct hists *hists, struct perf_hpp_list *hpp_list)
 	hists->entries = RB_ROOT_CACHED;
 	mutex_init(&hists->lock);
 	hists->socket_filter = -1;
+	hists->parallelism_filter = symbol_conf.parallelism_filter;
 	hists->hpp_list = hpp_list;
 	INIT_LIST_HEAD(&hists->hpp_formats);
 	return 0;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 4035106a74087..c2236e0d89f2a 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -31,6 +31,7 @@ enum hist_filter {
 	HIST_FILTER__HOST,
 	HIST_FILTER__SOCKET,
 	HIST_FILTER__C2C,
+	HIST_FILTER__PARALLELISM,
 };
 
 typedef u16 filter_mask_t;
@@ -112,6 +113,7 @@ struct hists {
 	const struct dso	*dso_filter;
 	const char		*uid_filter_str;
 	const char		*symbol_filter_str;
+	unsigned long		*parallelism_filter;
 	struct mutex		lock;
 	struct hists_stats	stats;
 	u64			event_stream;
@@ -388,11 +390,13 @@ void hists__filter_by_dso(struct hists *hists);
 void hists__filter_by_thread(struct hists *hists);
 void hists__filter_by_symbol(struct hists *hists);
 void hists__filter_by_socket(struct hists *hists);
+void hists__filter_by_parallelism(struct hists *hists);
 
 static inline bool hists__has_filter(struct hists *hists)
 {
 	return hists->thread_filter || hists->dso_filter ||
-		hists->symbol_filter_str || (hists->socket_filter > -1);
+		hists->symbol_filter_str || (hists->socket_filter > -1) ||
+		hists->parallelism_filter;
 }
 
 u16 hists__col_len(struct hists *hists, enum hist_column col);
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 7eef43f5be360..3055496358ebb 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -900,6 +900,16 @@ sort__parallelism_cmp(struct hist_entry *left, struct hist_entry *right)
 	return right->parallelism - left->parallelism;
 }
 
+static int hist_entry__parallelism_filter(struct hist_entry *he, int type, const void *arg)
+{
+	const unsigned long *parallelism_filter = arg;
+
+	if (type != HIST_FILTER__PARALLELISM)
+		return -1;
+
+	return test_bit(he->parallelism, parallelism_filter);
+}
+
 static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
 				    size_t size, unsigned int width)
 {
@@ -909,6 +919,7 @@ static int hist_entry__parallelism_snprintf(struct hist_entry *he, char *bf,
 struct sort_entry sort_parallelism = {
 	.se_header      = "Parallelism",
 	.se_cmp	        = sort__parallelism_cmp,
+	.se_filter	= hist_entry__parallelism_filter,
 	.se_snprintf    = hist_entry__parallelism_snprintf,
 	.se_width_idx	= HISTC_PARALLELISM,
 };
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 49b08adc6ee34..315f74b5bac06 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -18,6 +18,7 @@
 #include "annotate.h"
 #include "build-id.h"
 #include "cap.h"
+#include "cpumap.h"
 #include "dso.h"
 #include "util.h" // lsdir()
 #include "debug.h"
@@ -2471,6 +2472,36 @@ int symbol__annotation_init(void)
 	return 0;
 }
 
+static int setup_parallelism_bitmap(void)
+{
+	struct perf_cpu_map *map;
+	struct perf_cpu cpu;
+	int i, err = -1;
+
+	if (symbol_conf.parallelism_list_str == NULL)
+		return 0;
+
+	map = perf_cpu_map__new(symbol_conf.parallelism_list_str);
+	if (map == NULL) {
+		pr_err("failed to parse parallelism filter list\n");
+		return -1;
+	}
+
+	bitmap_fill(symbol_conf.parallelism_filter, MAX_NR_CPUS + 1);
+	perf_cpu_map__for_each_cpu(cpu, i, map) {
+		if (cpu.cpu <= 0 || cpu.cpu > MAX_NR_CPUS) {
+			pr_err("Requested parallelism level %d is invalid.\n", cpu.cpu);
+			goto out_delete_map;
+		}
+		__clear_bit(cpu.cpu, symbol_conf.parallelism_filter);
+	}
+
+	err = 0;
+out_delete_map:
+	perf_cpu_map__put(map);
+	return err;
+}
+
 int symbol__init(struct perf_env *env)
 {
 	const char *symfs;
@@ -2490,6 +2521,9 @@ int symbol__init(struct perf_env *env)
 		return -1;
 	}
 
+	if (setup_parallelism_bitmap())
+		return -1;
+
 	if (setup_list(&symbol_conf.dso_list,
 		       symbol_conf.dso_list_str, "dso") < 0)
 		return -1;
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index a9c51acc722fe..c5b2e56127e22 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -3,6 +3,8 @@
 #define __PERF_SYMBOL_CONF 1
 
 #include <stdbool.h>
+#include <linux/bitmap.h>
+#include "perf.h"
 
 struct strlist;
 struct intlist;
@@ -62,6 +64,7 @@ struct symbol_conf {
 			*pid_list_str,
 			*tid_list_str,
 			*sym_list_str,
+			*parallelism_list_str,
 			*col_width_list_str,
 			*bt_stop_list_str;
 	const char		*addr2line_path;
@@ -82,6 +85,7 @@ struct symbol_conf {
 	int		pad_output_len_dso;
 	int		group_sort_idx;
 	int		addr_range;
+	DECLARE_BITMAP(parallelism_filter, MAX_NR_CPUS + 1);
 };
 
 extern struct symbol_conf symbol_conf;
-- 
2.48.1.502.g6dc24dfdaf-goog


