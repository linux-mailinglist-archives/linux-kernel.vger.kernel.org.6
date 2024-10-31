Return-Path: <linux-kernel+bounces-389845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E699B721F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D20285C4A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B413AD32;
	Thu, 31 Oct 2024 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBiGvLyM"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9213957C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339016; cv=none; b=YKAgKoFqRNA3Exs5aynejcgxir9HhF/R1jxzuFcO0XmipccKtXs6YzF2VvrteNaODPTPhX4rZX1gVfUaE5n5qGeOxLtjjs2vEUZcDmPL8Sk1wjZTWQPlfPi8RPI2zKdN07fn4X/ZON16ewWq8G8AO0Nffp9xbaVSRNh5gBDBNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339016; c=relaxed/simple;
	bh=OkgfakVEBzNhVQvYPoWUWgsb9ea6uiwfv7CjO2/5vxs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=deFakQX3fi9w6yqx+ymYwJaUEkjqfTeXt+8uX+JqCTIuewrd76eefJwDC3gsxQfPlizffsheQcfdaT5IyVzuIdf/uach19qKWRYisRVipLMj8iChRrM+SXezZ54xXNOQs1RuoUsh61P34cCKrExg4Rn2wKDda0FJ2EvOYZS4mcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBiGvLyM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a31ad88aso750751276.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339013; x=1730943813; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zVk767eKKMka2fJeUsflenyL0QHm0J7Og37hcfkqc+Q=;
        b=fBiGvLyMq42/oAsJG5k/cqpY+JGLqjgeSUtNLy3Bu4ya4bNDFMkgqgBu++mAxghhdX
         JnETCbuO53ZbNfnUjd3xSf/9UcT72mvViU7cUFPdwvzF3NqXHg00Lz5tNlttsFKX2Jrd
         lmSO/vWuaB56UKnyebSj525XlXEso1GTsB9xykk1zLXSoSf5q9qK4I23KEXwEfE37eCI
         1jPyR2oUOh28fvFxc4mdjEYoofC7w4oW7AhsiHFlVA8wwWK4bGFDFdfn3qukWFh08kZW
         TUYRDWas4npBpA34inscwMA//cibAY6A4x3nJyQxgSvFmgYRAElM30M7WcXNqVL+5zIx
         zIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339013; x=1730943813;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVk767eKKMka2fJeUsflenyL0QHm0J7Og37hcfkqc+Q=;
        b=MSh8M3ZY6X0v3doQxl6IYye6WIY0tt9QoOFiZy1jfTLNqB6MBgVST7BTVy5NlqW9Mu
         tYp9iIcAAknTxYKuI4GGYLhOMHWVvnVnYIcEizjT1u/3Dn7kk5mXgQ8vYxLk3p3u7q3x
         zim7mqIlc0PnjtUK/RJxFw1CvnsoEUe8T7Pwo/2m9CqtaB6wfOrASVUyr7Szk/HNuiz9
         dFRzmUaGHGnCAOsvtmhSZ6ESICj3Aph41M9eWE26O+G4vWCbXhZ8v7qmM3y6b8n8BKu0
         qdrCurBR8h8HdyCj7NhJWZQwtU+8ZBa9l1+Zc/wekGtumdAVMZGG7mo378Hl0mjaNXw0
         6eaA==
X-Forwarded-Encrypted: i=1; AJvYcCVyQoaVJ5/AR3fPi5E3X4NATWiu3Y8ijoN1+QpkWmIPGigjvy4lzA7xA/WePfpgJRfc0cC3BvQQBouNyIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYs9LLnf5hktBquMhJHRhQvOjYHBOiDoPte4hWqdg60ROMH2pe
	svsIvFK7N99DTmRSee58aY2YcnFRW3QHJJKxCizETjQ4SoX3vucAUkRvyXEQpX0kT8O+UZ5nQFU
	jy8grPA==
X-Google-Smtp-Source: AGHT+IGpHHG8N7FxAL6vCvTXmjIng8pUhJCdXh7OTikcvfaqC5gJYr1V+cxcaRgy8j8lsb6l5WCpw3LtqDl5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:9086:0:b0:e29:74e3:616c with SMTP id
 3f1490d57ef6-e3087a4f19cmr12068276.3.1730339013331; Wed, 30 Oct 2024 18:43:33
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:38 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 07/21] perf stat: Move stat_config into config.c
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

stat_config is accessed by config.c via helper functions, but declared
in builtin-stat. Move to util/config.c so that stub functions aren't
needed in python.c which doesn't link against the builtin files.

To avoid name conflicts change builtin-script to use the same
stat_config as builtin-stat. Rename local variables in tests to avoid
shadow declaration warnings.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c |  1 -
 tools/perf/builtin-stat.c   | 27 ---------------------------
 tools/perf/tests/stat.c     | 16 +++++++++-------
 tools/perf/util/config.c    | 27 +++++++++++++++++++++++++++
 tools/perf/util/python.c    |  9 ---------
 tools/perf/util/stat.h      |  3 ++-
 6 files changed, 38 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e9ec74056f71..62e851fdf5ca 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -85,7 +85,6 @@ static bool			system_wide;
 static bool			print_flags;
 static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
-static struct perf_stat_config	stat_config;
 static int			max_blocks;
 static bool			native_arch;
 static struct dlfilter		*dlfilter;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c12158d99353..a1625443e5a5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -112,8 +112,6 @@ static struct target target = {
 	.uid	= UINT_MAX,
 };
 
-#define METRIC_ONLY_LEN 20
-
 static volatile sig_atomic_t	child_pid			= -1;
 static int			detailed_run			=  0;
 static bool			transaction_run;
@@ -151,21 +149,6 @@ static struct perf_stat		perf_stat;
 
 static volatile sig_atomic_t done = 0;
 
-static struct perf_stat_config stat_config = {
-	.aggr_mode		= AGGR_GLOBAL,
-	.aggr_level		= MAX_CACHE_LVL + 1,
-	.scale			= true,
-	.unit_width		= 4, /* strlen("unit") */
-	.run_count		= 1,
-	.metric_only_len	= METRIC_ONLY_LEN,
-	.walltime_nsecs_stats	= &walltime_nsecs_stats,
-	.ru_stats		= &ru_stats,
-	.big_num		= true,
-	.ctl_fd			= -1,
-	.ctl_fd_ack		= -1,
-	.iostat_run		= false,
-};
-
 /* Options set from the command line. */
 struct opt_aggr_mode {
 	bool node, socket, die, cluster, cache, core, thread, no_aggr;
@@ -1071,16 +1054,6 @@ static void sig_atexit(void)
 	kill(getpid(), signr);
 }
 
-void perf_stat__set_big_num(int set)
-{
-	stat_config.big_num = (set != 0);
-}
-
-void perf_stat__set_no_csv_summary(int set)
-{
-	stat_config.no_csv_summary = (set != 0);
-}
-
 static int stat__set_big_num(const struct option *opt __maybe_unused,
 			     const char *s __maybe_unused, int unset)
 {
diff --git a/tools/perf/tests/stat.c b/tools/perf/tests/stat.c
index 6468cc0d0204..d60983657bad 100644
--- a/tools/perf/tests/stat.c
+++ b/tools/perf/tests/stat.c
@@ -27,7 +27,7 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
 				     struct machine *machine __maybe_unused)
 {
 	struct perf_record_stat_config *config = &event->stat_config;
-	struct perf_stat_config stat_config = {};
+	struct perf_stat_config test_stat_config = {};
 
 #define HAS(term, val) \
 	has_term(config, PERF_STAT_CONFIG_TERM__##term, val)
@@ -39,25 +39,27 @@ static int process_stat_config_event(const struct perf_tool *tool __maybe_unused
 
 #undef HAS
 
-	perf_event__read_stat_config(&stat_config, config);
+	perf_event__read_stat_config(&test_stat_config, config);
 
-	TEST_ASSERT_VAL("wrong aggr_mode", stat_config.aggr_mode == AGGR_CORE);
-	TEST_ASSERT_VAL("wrong scale",     stat_config.scale == 1);
-	TEST_ASSERT_VAL("wrong interval",  stat_config.interval == 1);
+	TEST_ASSERT_VAL("wrong aggr_mode", test_stat_config.aggr_mode == AGGR_CORE);
+	TEST_ASSERT_VAL("wrong scale",     test_stat_config.scale == 1);
+	TEST_ASSERT_VAL("wrong interval",  test_stat_config.interval == 1);
 	return 0;
 }
 
 static int test__synthesize_stat_config(struct test_suite *test __maybe_unused,
 					int subtest __maybe_unused)
 {
-	struct perf_stat_config stat_config = {
+	struct perf_stat_config test_stat_config = {
 		.aggr_mode	= AGGR_CORE,
 		.scale		= 1,
 		.interval	= 1,
 	};
 
 	TEST_ASSERT_VAL("failed to synthesize stat_config",
-		!perf_event__synthesize_stat_config(NULL, &stat_config, process_stat_config_event, NULL));
+		!perf_event__synthesize_stat_config(NULL, &test_stat_config,
+						    process_stat_config_event,
+						    NULL));
 
 	return 0;
 }
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 68f9407ca74b..2d07c9257a1a 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -13,6 +13,7 @@
 #include <sys/param.h>
 #include "cache.h"
 #include "callchain.h"
+#include "header.h"
 #include <subcmd/exec-cmd.h>
 #include "util/event.h"  /* proc_map_timeout */
 #include "util/hist.h"  /* perf_hist_config */
@@ -34,6 +35,22 @@
 
 #define DEBUG_CACHE_DIR ".debug"
 
+#define METRIC_ONLY_LEN 20
+
+struct perf_stat_config stat_config = {
+	.aggr_mode		= AGGR_GLOBAL,
+	.aggr_level		= MAX_CACHE_LVL + 1,
+	.scale			= true,
+	.unit_width		= 4, /* strlen("unit") */
+	.run_count		= 1,
+	.metric_only_len	= METRIC_ONLY_LEN,
+	.walltime_nsecs_stats	= &walltime_nsecs_stats,
+	.ru_stats		= &ru_stats,
+	.big_num		= true,
+	.ctl_fd			= -1,
+	.ctl_fd_ack		= -1,
+	.iostat_run		= false,
+};
 
 char buildid_dir[MAXPATHLEN]; /* root dir for buildid, binary cache */
 
@@ -455,6 +472,16 @@ static int perf_ui_config(const char *var, const char *value)
 	return 0;
 }
 
+void perf_stat__set_big_num(int set)
+{
+	stat_config.big_num = (set != 0);
+}
+
+static void perf_stat__set_no_csv_summary(int set)
+{
+	stat_config.no_csv_summary = (set != 0);
+}
+
 static int perf_stat_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "stat.big-num"))
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 5f11ae88943d..0fa8e27769be 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -17,7 +17,6 @@
 #include "trace-event.h"
 #include "mmap.h"
 #include "util/env.h"
-#include "util/kvm-stat.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1306,14 +1305,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-void perf_stat__set_no_csv_summary(int set __maybe_unused)
-{
-}
-
-void perf_stat__set_big_num(int set __maybe_unused)
-{
-}
-
 int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
 {
 	return -1;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 6f8cff3cd39a..2fda9acd7374 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -117,8 +117,9 @@ struct perf_stat_config {
 	unsigned int		topdown_level;
 };
 
+extern struct perf_stat_config stat_config;
+
 void perf_stat__set_big_num(int set);
-void perf_stat__set_no_csv_summary(int set);
 
 void update_stats(struct stats *stats, u64 val);
 double avg_stats(struct stats *stats);
-- 
2.47.0.163.g1226f6d8fa-goog


