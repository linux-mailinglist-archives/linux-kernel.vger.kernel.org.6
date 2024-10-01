Return-Path: <linux-kernel+bounces-345853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5656098BBE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D798E1F2291E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CAB1C2DA7;
	Tue,  1 Oct 2024 12:15:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212CD1C2438;
	Tue,  1 Oct 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727784950; cv=none; b=RdXvhGzgWXhwrJ0z9n1fRJqui1x3r4JLNWTNkBSycfbSZ2FnQSEE/3D9mIa/nFFCUSf2ksTPJq3oxgX3fo5bAwnpp/MfcxE5pJMIseVfHo6s10IoSUCnARAL+Xe4oERu1bSe8Zmb+vxYY4GtdCXO4/mN9ExDNKKlZXNjVYbssls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727784950; c=relaxed/simple;
	bh=gCR3KLInBSs1V1xQ4gsZJMF6jcF6sqI3qnZobKenBfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GItqXIMuy/B+CFd0F760P2+VubVROcjx5PoxYkIVAdMNfaRm+fPY0z2UGevAfbX/zxRB75JhzLWo4rzIlSuPS0t1jVpAHuuB2beyLDdNdgmi2dsdRHhJ4ehXDPEbso1CXnfqr+k3TMFP0yuMnQt4NwbwN+PuTeUFeRIRxjRq0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B469DA7;
	Tue,  1 Oct 2024 05:16:17 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7EE633F58B;
	Tue,  1 Oct 2024 05:15:45 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v12 2/2] tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events
Date: Tue,  1 Oct 2024 13:15:05 +0100
Message-ID: <20241001121505.1009685-3-ben.gainey@arm.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241001121505.1009685-1-ben.gainey@arm.com>
References: <20241001121505.1009685-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "perf record" tool will now default to this new mode if the user
specifies a sampling group when not in system-wide mode, and when
"--no-inherit" is not specified.

This change updates evsel to allow the combination of inherit
and PERF_SAMPLE_READ.

A fallback is implemented for kernel versions where this feature is not
supported.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/perf/tests/attr/README                  |  2 +
 tools/perf/tests/attr/test-record-C0          |  2 +
 tools/perf/tests/attr/test-record-dummy-C0    |  2 +-
 .../tests/attr/test-record-group-sampling     |  3 +-
 .../tests/attr/test-record-group-sampling1    | 51 ++++++++++++++++
 .../tests/attr/test-record-group-sampling2    | 61 +++++++++++++++++++
 tools/perf/tests/attr/test-record-group2      |  1 +
 ...{test-record-group2 => test-record-group3} | 10 +--
 tools/perf/util/evsel.c                       | 21 ++++++-
 tools/perf/util/evsel.h                       |  1 +
 10 files changed, 145 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/attr/test-record-group-sampling2
 copy tools/perf/tests/attr/{test-record-group2 => test-record-group3} (81%)

diff --git a/tools/perf/tests/attr/README b/tools/perf/tests/attr/README
index 4066fec7180a..67c4ca76b85d 100644
--- a/tools/perf/tests/attr/README
+++ b/tools/perf/tests/attr/README
@@ -51,6 +51,8 @@ Following tests are defined (with perf commands):
   perf record --call-graph fp kill              (test-record-graph-fp-aarch64)
   perf record -e '{cycles,instructions}' kill   (test-record-group1)
   perf record -e '{cycles/period=1/,instructions/period=2/}:S' kill (test-record-group2)
+  perf record -e '{cycles,cache-misses}:S' kill (test-record-group-sampling1)
+  perf record -c 10000 -e '{cycles,cache-misses}:S' kill (test-record-group-sampling2)
   perf record -D kill                           (test-record-no-delay)
   perf record -i kill                           (test-record-no-inherit)
   perf record -n kill                           (test-record-no-samples)
diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
index 198e8429a1bf..1049ac8b52f2 100644
--- a/tools/perf/tests/attr/test-record-C0
+++ b/tools/perf/tests/attr/test-record-C0
@@ -18,5 +18,7 @@ sample_type=65927
 mmap=0
 comm=0
 task=0
+inherit=0
 
 [event:system-wide-dummy]
+inherit=0
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 576ec48b3aaf..3050298bd614 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -19,7 +19,7 @@ sample_period=4000
 sample_type=391
 read_format=4|20
 disabled=0
-inherit=1
+inherit=0
 pinned=0
 exclusive=0
 exclude_user=0
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index 97e7e64a38f0..86a940d7895d 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -2,6 +2,7 @@
 command = record
 args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
 ret     = 1
+kernel_until = 6.12
 
 [event-1:base-record]
 fd=1
@@ -18,7 +19,7 @@ group_fd=1
 type=0
 config=3
 
-# default | PERF_SAMPLE_READ
+# default | PERF_SAMPLE_READ | PERF_SAMPLE_PERIOD
 sample_type=343
 
 # PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
diff --git a/tools/perf/tests/attr/test-record-group-sampling1 b/tools/perf/tests/attr/test-record-group-sampling1
new file mode 100644
index 000000000000..e96a10627a46
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group-sampling1
@@ -0,0 +1,51 @@
+[config]
+command = record
+args    = --no-bpf-event -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.12
+
+[event-1:base-record]
+fd=1
+group_fd=-1
+
+# cycles
+type=0
+config=0
+
+# default | PERF_SAMPLE_READ | PERF_SAMPLE_PERIOD
+sample_type=343
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=28|31
+task=1
+mmap=1
+comm=1
+enable_on_exec=1
+disabled=1
+
+# inherit is enabled for group sampling
+inherit=1
+
+[event-2:base-record]
+fd=2
+group_fd=1
+
+# cache-misses
+type=0
+config=3
+
+# default | PERF_SAMPLE_READ | PERF_SAMPLE_PERIOD
+sample_type=343
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=28|31
+task=0
+mmap=0
+comm=0
+enable_on_exec=0
+disabled=0
+freq=0
+
+# inherit is enabled for group sampling
+inherit=1
+
diff --git a/tools/perf/tests/attr/test-record-group-sampling2 b/tools/perf/tests/attr/test-record-group-sampling2
new file mode 100644
index 000000000000..e0432244a0eb
--- /dev/null
+++ b/tools/perf/tests/attr/test-record-group-sampling2
@@ -0,0 +1,61 @@
+[config]
+command = record
+args    = --no-bpf-event -c 10000 -e '{cycles,cache-misses}:S' kill >/dev/null 2>&1
+ret     = 1
+kernel_since = 6.12
+
+[event-1:base-record]
+fd=1
+group_fd=-1
+
+# cycles
+type=0
+config=0
+
+# default | PERF_SAMPLE_READ
+sample_type=87
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=28|31
+task=1
+mmap=1
+comm=1
+enable_on_exec=1
+disabled=1
+
+# inherit is enabled for group sampling
+inherit=1
+
+# sampling disabled
+sample_freq=0
+sample_period=10000
+freq=0
+write_backward=0
+
+[event-2:base-record]
+fd=2
+group_fd=1
+
+# cache-misses
+type=0
+config=3
+
+# default | PERF_SAMPLE_READ
+sample_type=87
+
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST | PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING
+read_format=28|31
+task=0
+mmap=0
+comm=0
+enable_on_exec=0
+disabled=0
+
+# inherit is enabled for group sampling
+inherit=1
+
+# sampling disabled
+sample_freq=0
+sample_period=0
+freq=0
+write_backward=0
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
index cebdaa8e64e4..891d41a7bddf 100644
--- a/tools/perf/tests/attr/test-record-group2
+++ b/tools/perf/tests/attr/test-record-group2
@@ -2,6 +2,7 @@
 command = record
 args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
+kernel_until = 6.12
 
 [event-1:base-record]
 fd=1
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group3
similarity index 81%
copy from tools/perf/tests/attr/test-record-group2
copy to tools/perf/tests/attr/test-record-group3
index cebdaa8e64e4..249be884959e 100644
--- a/tools/perf/tests/attr/test-record-group2
+++ b/tools/perf/tests/attr/test-record-group3
@@ -2,6 +2,7 @@
 command = record
 args    = --no-bpf-event -e '{cycles/period=1234000/,instructions/period=6789000/}:S' kill >/dev/null 2>&1
 ret     = 1
+kernel_since = 6.12
 
 [event-1:base-record]
 fd=1
@@ -9,8 +10,9 @@ group_fd=-1
 config=0|1
 sample_period=1234000
 sample_type=87
-read_format=12|28
-inherit=0
+read_format=28|31
+disabled=1
+inherit=1
 freq=0
 
 [event-2:base-record]
@@ -19,9 +21,9 @@ group_fd=1
 config=0|1
 sample_period=6789000
 sample_type=87
-read_format=12|28
+read_format=28|31
 disabled=0
-inherit=0
+inherit=1
 mmap=0
 comm=0
 freq=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index edfb376f0611..337d9091996d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1147,7 +1147,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 	bool per_cpu = opts->target.default_per_cpu && !opts->target.per_thread;
 
 	attr->sample_id_all = perf_missing_features.sample_id_all ? 0 : 1;
-	attr->inherit	    = !opts->no_inherit;
+	attr->inherit	    = target__has_cpu(&opts->target) ? 0 : !opts->no_inherit;
 	attr->write_backward = opts->overwrite ? 1 : 0;
 	attr->read_format   = PERF_FORMAT_LOST;
 
@@ -1169,7 +1169,15 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		 */
 		if (leader->core.nr_members > 1) {
 			attr->read_format |= PERF_FORMAT_GROUP;
-			attr->inherit = 0;
+		}
+
+		/*
+		 * Inherit + SAMPLE_READ requires SAMPLE_TID in the read_format
+		 */
+		if (attr->inherit) {
+			evsel__set_sample_bit(evsel, TID);
+			evsel->core.attr.read_format |=
+				PERF_FORMAT_ID;
 		}
 	}
 
@@ -2103,6 +2111,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.inherit_sample_read)
+		evsel->core.attr.inherit = 0;
 	if (perf_missing_features.branch_counters)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
 	if (perf_missing_features.read_lost)
@@ -2158,7 +2168,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.inherit_sample_read &&
+	    evsel->core.attr.inherit && (evsel->core.attr.sample_type & PERF_SAMPLE_READ)) {
+		perf_missing_features.inherit_sample_read = true;
+		pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
+		return true;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3e751ea769ac..bd08d94d3f8a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -221,6 +221,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool inherit_sample_read;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.46.1


