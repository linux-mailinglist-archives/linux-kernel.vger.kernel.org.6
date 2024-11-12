Return-Path: <linux-kernel+bounces-406500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D807F9C62BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31780BE36B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801321744F;
	Tue, 12 Nov 2024 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9sfJ2mH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C72161F3;
	Tue, 12 Nov 2024 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435163; cv=none; b=R3Xp6a3PQWsH+5g1CT6W/h0d0bDjOMQz4r6kzDYW7Sckwmh2emSl2EDdpiYxN2vK5M/EneJlHDFbSQeatX9lTkJvx5EE74SvWxzI9H2JbbsOhCPwzFmz/Y0x5MM452qfj76PY8caZBzlZq0CsKkS1KQhZc+fm/mc9Pb4erADkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435163; c=relaxed/simple;
	bh=JuzEbkLJBIeOY1qMGehwx9tZn/7lQze5kr6rAHnm//Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo1h0gk4eSkwTQ+F7eidr1sfz4ph1KhNyRywy0xVR2xlutH7ah44odJ3Ap+Wta9wEm17uAkp0yb4xn/CXJQ6xeh6XihuijNq7I6LD8ntHJI4fYCb/Mm4Hubc+0PN25VfdBbSIvMba2zg/rpVW/IKJwZHrnKTnfXigZ6cqxfV8pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9sfJ2mH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F730C4CED7;
	Tue, 12 Nov 2024 18:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435162;
	bh=JuzEbkLJBIeOY1qMGehwx9tZn/7lQze5kr6rAHnm//Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9sfJ2mHtiXuaIBsG8gcgYSYM5U5+Ii9dKZUaAAEmzaUy7aXCOJSxeDfghHjQbI3t
	 W+ZVM7wPTTgMlb5e/wS8j8C5+5iXe7S1pkdwnEYYsXvgLw5GuPgqYsV5wn09lfcMA4
	 F/1ETyfiX6Af0eYqYodNOlnUBDPCkwsvFCbeFgMLiRIL05jbZs6GmzVXAzzPRW3spb
	 x6Zqea9YExb/G19YL2SEoIDF0ZGFReUrUPwsoXLpTpf4ILXYlTPPRnYltCcv3gJb75
	 BiH5F0bHCmDUm8+aO45fOkCetb9eyC9cAIn42QxrFKeKatmUUCMLDDyRGSVabx+ElL
	 pGa13/eQZSJyw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 3/4] perf ftrace latency: Introduce --min-latency to narrow down into a latency range
Date: Tue, 12 Nov 2024 15:12:13 -0300
Message-ID: <20241112181214.1171244-4-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112181214.1171244-1-acme@kernel.org>
References: <20241112181214.1171244-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Things below and over will be in the first and last, outlier, buckets.

Without it:

  # perf ftrace latency --use-nsec --use-bpf \
			--bucket-range=200 \
			-T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH                                   |
       0 -  200 ns |          0 |                                         |
     200 -  400 ns |         44 |                                         |
     400 -  600 ns |        291 | #                                       |
     600 -  800 ns |        506 | ##                                      |
     800 - 1000 ns |        148 |                                         |
    1.00 - 1.20 us |        581 | ##                                      |
    1.20 - 1.40 us |       2199 | ##########                              |
    1.40 - 1.60 us |       1048 | ####                                    |
    1.60 - 1.80 us |       1448 | ######                                  |
    1.80 - 2.00 us |       1091 | #####                                   |
    2.00 - 2.20 us |        517 | ##                                      |
    2.20 - 2.40 us |        318 | #                                       |
    2.40 - 2.60 us |        370 | #                                       |
    2.60 - 2.80 us |        271 | #                                       |
    2.80 - 3.00 us |        150 |                                         |
    3.00 - 3.20 us |         85 |                                         |
    3.20 - 3.40 us |         48 |                                         |
    3.40 - 3.60 us |         40 |                                         |
    3.60 - 3.80 us |         22 |                                         |
    3.80 - 4.00 us |         13 |                                         |
    4.00 - 4.20 us |         14 |                                         |
    4.20 - ...  us |        626 | ##                                      |
  #
  # perf ftrace latency --use-nsec --use-bpf \
			--bucket-range=20 --min-latency=1200 \
			-T switch_mm_irqs_off -a sleep 2
  #   DURATION     |      COUNT | GRAPH                                   |
       0 - 1200 ns |       1243 | #####                                   |
    1.20 - 1.22 us |        141 |                                         |
    1.22 - 1.24 us |        202 |                                         |
    1.24 - 1.26 us |        209 |                                         |
    1.26 - 1.28 us |        219 |                                         |
    1.28 - 1.30 us |        208 |                                         |
    1.30 - 1.32 us |        245 | #                                       |
    1.32 - 1.34 us |        246 | #                                       |
    1.34 - 1.36 us |        224 | #                                       |
    1.36 - 1.38 us |        219 |                                         |
    1.38 - 1.40 us |        206 |                                         |
    1.40 - 1.42 us |        190 |                                         |
    1.42 - 1.44 us |        190 |                                         |
    1.44 - 1.46 us |        146 |                                         |
    1.46 - 1.48 us |        140 |                                         |
    1.48 - 1.50 us |        125 |                                         |
    1.50 - 1.52 us |        115 |                                         |
    1.52 - 1.54 us |        102 |                                         |
    1.54 - 1.56 us |         87 |                                         |
    1.56 - 1.58 us |         90 |                                         |
    1.58 - 1.60 us |         85 |                                         |
    1.60 - ...  us |       5487 | ########################                |
  #

Now we want focus on the latencies starting at 1.2us, with a finer
grained range of 20ns:

This is all on a live system, so statistically interesting, but not
narrowing down on the same numbers, so a 'perf ftrace latency record'
seems interesting to then use all on the same snapshot of latencies.

A --max-latency counterpart should come next, at first limiting the
max-latency to 20 * bucket-size, as we have a fixed buckets array with
20 + 2 entries (+ for the outliers) and thus would need to make it
larger for higher latencies.

We also may need a way to ask for not considering the out of range
values (first and last buckets) when drawing the buckets bars.

Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-ftrace.txt    |  4 +++
 tools/perf/builtin-ftrace.c                 | 32 +++++++++++++++++----
 tools/perf/util/bpf_ftrace.c                |  1 +
 tools/perf/util/bpf_skel/func_latency.bpf.c | 12 ++++++--
 tools/perf/util/ftrace.h                    |  1 +
 5 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index e8cc8208e29fca7e..82219e4262c73bc2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -151,6 +151,10 @@ OPTIONS for 'perf ftrace latency'
 --bucket-range=::
 	Bucket range in ms or ns (according to -n/--use-nsec), default is log2() mode.
 
+--min-latency=::
+	Minimum latency for the start of the first bucket, in ms or ns (according to
+	-n/--use-nsec).
+
 
 OPTIONS for 'perf ftrace profile'
 ---------------------------------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e047e5dcda2656df..d9fbe7a329268572 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -729,6 +729,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 			   char *buf, size_t len, char *linebuf)
 {
+	int min_latency = ftrace->min_latency;
 	char *p, *q;
 	char *unit;
 	double num;
@@ -777,6 +778,12 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 		if (ftrace->use_nsec)
 			num *= 1000;
 
+		i = 0;
+		if (num < min_latency)
+			goto do_inc;
+
+		num -= min_latency;
+
 		if (!ftrace->bucket_range) {
 			i = log2(num);
 			if (i < 0)
@@ -784,13 +791,13 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 		} else {
 			// Less than 1 unit (ms or ns), or, in the future,
 			// than the min latency desired.
-			i = 0;
 			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
 				i = num / ftrace->bucket_range + 1;
 		}
 		if (i >= NUM_BUCKET)
 			i = NUM_BUCKET - 1;
 
+do_inc:
 		buckets[i]++;
 
 next:
@@ -804,6 +811,7 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
 
 static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 {
+	int min_latency = ftrace->min_latency;
 	bool use_nsec = ftrace->use_nsec;
 	int i;
 	int total = 0;
@@ -825,7 +833,8 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	bar_len = buckets[0] * bar_total / total;
 
 	printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
-	       0, 1, use_nsec ? "ns" : "us", buckets[0], bar_len, bar, bar_total - bar_len, "");
+	       0, min_latency, use_nsec ? "ns" : "us",
+	       buckets[0], bar_len, bar, bar_total - bar_len, "");
 
 	for (i = 1; i < NUM_BUCKET - 1; i++) {
 		int start, stop;
@@ -841,8 +850,8 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 				unit = use_nsec ? "us" : "ms";
 			}
 		} else {
-			start = (i - 1) * ftrace->bucket_range + 1;
-			stop  = i * ftrace->bucket_range + 1;
+			start = (i - 1) * ftrace->bucket_range + min_latency;
+			stop  = i * ftrace->bucket_range + min_latency;
 
 			if (start >= 1000) {
 				double dstart = start / 1000.0,
@@ -864,7 +873,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
 	if (!ftrace->bucket_range) {
 		printf("  %4d - %-4s %s", 1, "...", use_nsec ? "ms" : "s ");
 	} else {
-		int upper_outlier = (NUM_BUCKET - 2) * ftrace->bucket_range;
+		int upper_outlier = (NUM_BUCKET - 2) * ftrace->bucket_range + min_latency;
 
 		if (upper_outlier >= 1000) {
 			double dstart = upper_outlier / 1000.0;
@@ -1598,6 +1607,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Use nano-second histogram"),
 	OPT_UINTEGER(0, "bucket-range", &ftrace.bucket_range,
 		    "Bucket range in ms or ns (-n/--use-nsec), default is log2() mode"),
+	OPT_UINTEGER(0, "min-latency", &ftrace.min_latency,
+		    "Minimum latency (1st bucket). Works only with --bucket-range."),
 	OPT_PARENT(common_options),
 	};
 	const struct option profile_options[] = {
@@ -1693,6 +1704,17 @@ int cmd_ftrace(int argc, const char **argv)
 			ret = -EINVAL;
 			goto out_delete_filters;
 		}
+		if (!ftrace.bucket_range && ftrace.min_latency) {
+			pr_err("--min-latency works only with --bucket-range\n");
+			parse_options_usage(ftrace_usage, options,
+					    "min-latency", /*short_opt=*/false);
+			ret = -EINVAL;
+			goto out_delete_filters;
+		}
+		if (!ftrace.min_latency) {
+			/* default min latency should be the bucket range */
+			ftrace.min_latency = ftrace.bucket_range;
+		}
 		cmd_func = __cmd_latency;
 		break;
 	case PERF_FTRACE_PROFILE:
diff --git a/tools/perf/util/bpf_ftrace.c b/tools/perf/util/bpf_ftrace.c
index b3cb68295e56631c..bc484e65fb8f69ca 100644
--- a/tools/perf/util/bpf_ftrace.c
+++ b/tools/perf/util/bpf_ftrace.c
@@ -37,6 +37,7 @@ int perf_ftrace__latency_prepare_bpf(struct perf_ftrace *ftrace)
 	}
 
 	skel->rodata->bucket_range = ftrace->bucket_range;
+	skel->rodata->min_latency = ftrace->min_latency;
 
 	/* don't need to set cpu filter for system-wide mode */
 	if (ftrace->target.cpu_list) {
diff --git a/tools/perf/util/bpf_skel/func_latency.bpf.c b/tools/perf/util/bpf_skel/func_latency.bpf.c
index 00a340ca1543dff0..a89d2b4c38174c03 100644
--- a/tools/perf/util/bpf_skel/func_latency.bpf.c
+++ b/tools/perf/util/bpf_skel/func_latency.bpf.c
@@ -42,6 +42,7 @@ const volatile int has_cpu = 0;
 const volatile int has_task = 0;
 const volatile int use_nsec = 0;
 const volatile unsigned int bucket_range;
+const volatile unsigned int min_latency;
 
 SEC("kprobe/func")
 int BPF_PROG(func_begin)
@@ -93,7 +94,7 @@ int BPF_PROG(func_end)
 	start = bpf_map_lookup_elem(&functime, &tid);
 	if (start) {
 		__s64 delta = bpf_ktime_get_ns() - *start;
-		__u32 key;
+		__u32 key = 0;
 		__u64 *hist;
 
 		bpf_map_delete_elem(&functime, &tid);
@@ -103,9 +104,16 @@ int BPF_PROG(func_end)
 
 		if (bucket_range != 0) {
 			delta /= cmp_base;
+
+			if (min_latency > 0) {
+				if (delta > min_latency)
+					delta -= min_latency;
+				else
+					goto do_lookup;
+			}
+
 			// Less than 1 unit (ms or ns), or, in the future,
 			// than the min latency desired.
-			key = 0;
 			if (delta > 0) { // 1st entry: [ 1 unit .. bucket_range units )
 				key = delta / bucket_range + 1;
 				if (key >= NUM_BUCKET)
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 6ac136484349a9a5..78d7745d497a8988 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -21,6 +21,7 @@ struct perf_ftrace {
 	bool			inherit;
 	bool			use_nsec;
 	unsigned int		bucket_range;
+	unsigned int		min_latency;
 	int			graph_depth;
 	int			func_stack_trace;
 	int			func_irq_info;
-- 
2.47.0


