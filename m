Return-Path: <linux-kernel+bounces-345042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5198B161
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AA30B20CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F4EAC7;
	Tue,  1 Oct 2024 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBzGjJ5f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237564A11;
	Tue,  1 Oct 2024 00:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727742031; cv=none; b=as6/XEt/ZECqgC2w5jspQPMCyWRjO6EA1JPaVuOq+ShZUk07cA+4nouTrdgPc6E1RBd7KqJpWP0H80YYLSVE3SFLHFBqPhZ128LXGbv68i9/5jdPe1Vfo3Dd0NUjFUrto/GhEJwVR+shVwXktz9JsiyaMBjfd2FIHv0+fH8UD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727742031; c=relaxed/simple;
	bh=ZTAUJtGBCA92G9auFnZoo3tHeZiI0RIqR6tlTOwqNVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxRLaP38YnfN6X0ob/8kMvPxsldvy1PHWzVc8q3oTUDGoJjRJPNR2p7NRG737cNbHwofpU4DQ3jqw3s+o5dA+IaqpNi3oOdtYvnylePXPJuR0U4/YQVttzvGrqfeaEuAm/spnkBsA7xXu0pvtw4K1+NLsLqq0STeBcd3DzCnpA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBzGjJ5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1894CC4CED6;
	Tue,  1 Oct 2024 00:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727742030;
	bh=ZTAUJtGBCA92G9auFnZoo3tHeZiI0RIqR6tlTOwqNVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBzGjJ5f0jGoJtAhdmPTUXYL7aNMvmwBMW+KrLIILHK9T7RCb6MiiJEvSpWAiFxVd
	 6/Q23b2lEN78KeyCsVz7cRfNnuLCKAeHDO+sJcmT5Y4VdPRHxXr4Gw7Ze8h9nQLs6F
	 rpR2ZQORpYbBDwKJN8EpsBwT1iFqSmQAhFo2T2IY4ti5Ta3yMeEAG3jVjnotpw6e5H
	 889PpnucNPobjsyaZs4A+3t2244LKDW/NcYXefWC4bRv6D1YSxlXQECbTF4GrTUTc/
	 w5jr8aJY3dJj/KZFHTP1SDA4La0tP1kPZKIlrjz4girB+UZE9IE5Xt0VC9xqEbvion
	 Zp78qduvq3qUw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Atish Patra <atishp@atishpatra.org>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Mingwei Zhang <mizhang@google.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 2/8] perf tools: Don't set attr.exclude_guest by default
Date: Mon, 30 Sep 2024 17:20:21 -0700
Message-ID: <20241001002027.1272889-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001002027.1272889-1-namhyung@kernel.org>
References: <20241001002027.1272889-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The exclude_guest in the event attribute is to limit profiling in the
host environment.  But I'm not sure why we want to set it by default
cause we don't care about it in most cases and I feel like it just
makes new PMU implementation complicated.

Of course it's useful for perf kvm command so I added the
exclude_GH_default variable to preserve the old behavior for perf kvm
and other commands like perf record and stat won't set the exclude bit.
This is helpful for AMD IBS case since having exclude_guest bit will
clear new feature bit due to the missing feature check logic.

  $ sysctl kernel.perf_event_paranoid
  kernel.perf_event_paranoid = 0

  $ perf record -W -e ibs_op// -vv true 2>&1 | grep switching
  switching off PERF_FORMAT_LOST support
  switching off weight struct support
  switching off bpf_event
  switching off ksymbol
  switching off cloexec flag
  switching off mmap2
  switching off exclude_guest, exclude_host

Intestingly, I found it sets the exclude_bit if "u" modifier is used.
I don't know why but it's neither intuitive nor consistent.  Let's
remove the bit there too.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c                   |  1 +
 tools/perf/tests/attr/test-record-dummy-C0 |  2 +-
 tools/perf/tests/parse-events.c            | 18 +++++++++---------
 tools/perf/util/parse-events.c             |  2 +-
 tools/perf/util/util.c                     | 10 ++++++++--
 tools/perf/util/util.h                     |  3 +++
 6 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 55ea17c5ff02acf7..099ce3ebf67ce6ee 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2147,6 +2147,7 @@ int cmd_kvm(int argc, const char **argv)
 						"buildid-list", "stat", NULL };
 	const char *kvm_usage[] = { NULL, NULL };
 
+	exclude_GH_default = true;
 	perf_host  = 0;
 	perf_guest = 1;
 
diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 576ec48b3aafaa6a..8ce6f0a5df5b7013 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -37,7 +37,7 @@ precise_ip=0
 mmap_data=0
 sample_id_all=1
 exclude_host=0
-exclude_guest=1
+exclude_guest=0
 exclude_callchain_kernel=0
 exclude_callchain_user=0
 mmap2=1
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 78e999f03d2d75f4..727683f249f66f5a 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -932,7 +932,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 			TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -947,7 +947,7 @@ static int test__group2(struct evlist *evlist)
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-			TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+			TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 			TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 			TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 			if (evsel__has_leader(evsel, leader))
@@ -1072,7 +1072,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -1222,7 +1222,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
@@ -1437,7 +1437,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1453,7 +1453,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
@@ -1468,7 +1468,7 @@ static int test__leader_sample1(struct evlist *evlist)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1497,7 +1497,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
@@ -1513,7 +1513,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
 		TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 		TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 		TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
-		TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
+		TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
 		TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 		TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 		TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index e96cf13dc396193f..ff67213d6e887169 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1776,7 +1776,7 @@ static int parse_events__modifier_list(struct parse_events_state *parse_state,
 		if (mod.user) {
 			if (!exclude)
 				exclude = eu = ek = eh = 1;
-			if (!exclude_GH && !perf_guest)
+			if (!exclude_GH && !perf_guest && exclude_GH_default)
 				eG = 1;
 			eu = 0;
 		}
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 9d55a13787ce3c05..280c86d61d8a7956 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -78,17 +78,23 @@ bool sysctl__nmi_watchdog_enabled(void)
 
 bool test_attr__enabled;
 
+bool exclude_GH_default;
+
 bool perf_host  = true;
 bool perf_guest = false;
 
 void event_attr_init(struct perf_event_attr *attr)
 {
+	/* to capture ABI version */
+	attr->size = sizeof(*attr);
+
+	if (!exclude_GH_default)
+		return;
+
 	if (!perf_host)
 		attr->exclude_host  = 1;
 	if (!perf_guest)
 		attr->exclude_guest = 1;
-	/* to capture ABI version */
-	attr->size = sizeof(*attr);
 }
 
 int mkdir_p(char *path, mode_t mode)
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9966c21aaf048479..4920e102ff54879a 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -21,6 +21,9 @@ extern const char perf_more_info_string[];
 
 extern const char *input_name;
 
+/* This will control if perf_{host,guest} will set attr.exclude_{host,guest}. */
+extern bool exclude_GH_default;
+
 extern bool perf_host;
 extern bool perf_guest;
 
-- 
2.46.1.824.gd892dcdcdd-goog


