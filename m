Return-Path: <linux-kernel+bounces-393205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61C99B9D99
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 08:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B051F25535
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 07:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476BD17085C;
	Sat,  2 Nov 2024 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q3FOzObC"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076C16DC36
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 07:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730532190; cv=none; b=jYhr7xsGTijDOx24S94Tgw9wB7YtHOIGJaHg8XAG8ukaBhkHseqR1l3+k8yCqTRQmpTTqyvmvmTJJM+syOSupSVgK7bRCMqM0vbpMfs0UXHqjyvH/Y+JRS1wzkJZi2eHCP5vFSTm1Mkkp+82c6jDjbHm9bB3TSSOvrv4tE1alHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730532190; c=relaxed/simple;
	bh=CkQ0PqkTIWt9YwGPuFgU+xUVEgjnar/6hDiTfIJH+ac=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=GwjMYzMDV3hsBmIwSB72WIjtye2mCFfonfGc9ZmZ4XXlBBECdhhfjx6Wpxt70kgAh7whWr956XmOq1N0zyMa3agiXNdXMcN409wKBasTE0yQyodQfqFiDYaQFpaL9qU5n4Nq3qm0kU504nS40Ktjd2J8+3hvNqaRL4rim+SF+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q3FOzObC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso4837858276.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730532187; x=1731136987; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHyQZ7KuzF1BHlUEcfMzmmjCRw5gxHBITHCl3IdIk30=;
        b=q3FOzObCJ3un9ppxhdsQYxUJpTbD8oCDDCglsYV7tO26wyGjduLHSDLvJTMHivFbKq
         hfh77X5WBIKY94xDGysfNA6nQZ8tqwfgY1Tbb2EKDHXJNY2Jtv3oejKorXg7FHjqqwzF
         URgc7J0eNVxHvzLP2rEYNx9qmDDsmfqMkRVDZX6knsSXHsldAz1yXcnJOHLoB51BWlPh
         b1Ymi5atQoy9TcwFOpSKHSyrT45Nj5wvgTxu8xNcA2hzVgiXCW2G8r/E+r+rbgrGBOoG
         nKI3USEno8RjPGzl06HyUGqeEjN6PojcTC5SSe3teUIQocrYBYK+w0Glz8I4iDUyuzZ7
         XqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730532187; x=1731136987;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bHyQZ7KuzF1BHlUEcfMzmmjCRw5gxHBITHCl3IdIk30=;
        b=f9fZIzhXutTK1mCN6glatW7gWw/PP6PuyLOIOfYv7l8NwB7EuZaDFeRMLeNrLl+XFf
         Nz7oYkDviylDUM1YvKbbNXNPNtkj6uam9q6bUm9aXpAeUuwQwtwUPR6UhVtclbSTPFhb
         ghHJUFj7eh/to94fbHr0Kb8qDgZ7XKGH0Dqlza7RcvZTR+qQDbBzp+mYvU/CmM38HGXk
         10Ng6z8/28i5OGbExSenOgyGEGx51cl+NYE5Kgr7s2do5fPjvGXwkVIjsrk9tjb75qJE
         HV6aapxMi0sCyCfIlDCgLd26RN/9jy+v2sx637tFFmixOH6+kZsuBN9yf6HQgpaUs+Aj
         94bw==
X-Forwarded-Encrypted: i=1; AJvYcCVJUPkwkYaeDbr2m3t9nBiBFl9hpVxpY8D8CXgW+2X2D0qV44klAewJE3Wnl0qnU/Nqn0UQ7NS2HSH2Yw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuB23v1e0+gg3eVurHz+bu5+k+O78W46x82j20joveauIB+/zI
	u3W0MwbSoYjfZ1fR9M30sOk2SGOJ8jFhu+Gr4UuZLyCGKZSj+BgElBpJFwFLufGxMWSTFCzOE46
	5gdkmZw==
X-Google-Smtp-Source: AGHT+IF41Zce63ZGMol91oHS/oZlPI7m9OX/9GhTsBQL/w+GJOBsQG34pjM2JIHDhO2xseniM2IUe7NhaMGk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:26a5:cdb5:356c:64a4])
 (user=irogers job=sendgmr) by 2002:a25:9012:0:b0:e2e:44ae:111a with SMTP id
 3f1490d57ef6-e30cf4c9ffamr8497276.8.1730532187061; Sat, 02 Nov 2024 00:23:07
 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:22:48 -0700
In-Reply-To: <20241102072248.12836-1-irogers@google.com>
Message-Id: <20241102072248.12836-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102072248.12836-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Subject: [PATCH v1 6/6] perf tests: Enable tests disabled due to tracepoint parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Li <yang.lee@linux.alibaba.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Yang Jihong <yangjihong@bytedance.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Zixian Cai <fzczx123@gmail.com>, Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"

Tracepoint parsing required libtraceevent but no longer does. Remove
the Build logic and #ifdefs that caused the tests not to be run. Test
code that directly uses libtraceevent is still guarded.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/Build          |  6 +++---
 tools/perf/tests/builtin-test.c |  2 --
 tools/perf/tests/parse-events.c | 25 +------------------------
 3 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 03cbdf7c50a0..db33b33dc970 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -5,10 +5,10 @@ perf-test-y += tests-scripts.o
 perf-test-y += parse-events.o
 perf-test-y += dso-data.o
 perf-test-y += vmlinux-kallsyms.o
-perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall.o
-perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-all-cpus.o
+perf-test-y += openat-syscall.o
+perf-test-y += openat-syscall-all-cpus.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-tp-fields.o
-perf-test-$(CONFIG_LIBTRACEEVENT) += mmap-basic.o
+perf-test-y += mmap-basic.o
 perf-test-y += perf-record.o
 perf-test-y += evsel-roundtrip-name.o
 perf-test-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad92..4c3b622130a9 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -60,11 +60,9 @@ static struct test_suite *arch_tests[] = {
 
 static struct test_suite *generic_tests[] = {
 	&suite__vmlinux_matches_kallsyms,
-#ifdef HAVE_LIBTRACEEVENT
 	&suite__openat_syscall_event,
 	&suite__openat_syscall_event_on_all_cpus,
 	&suite__basic_mmap,
-#endif
 	&suite__mem,
 	&suite__parse_events,
 	&suite__expr,
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 82a19674a38f..5ec2e5607987 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -54,8 +54,6 @@ static bool test_perf_config(const struct perf_evsel *evsel, __u64 expected_conf
 	return (evsel->attr.config & PERF_HW_EVENT_MASK) == expected_config;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
-
 #if defined(__s390x__)
 /* Return true if kvm module is available and loaded. Test this
  * and return success when trace point kvm_s390_create_vm
@@ -112,7 +110,6 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
 	}
 	return TEST_OK;
 }
-#endif /* HAVE_LIBTRACEEVENT */
 
 static int test__checkevent_raw(struct evlist *evlist)
 {
@@ -311,7 +308,6 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -340,7 +336,6 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
 
 	return test__checkevent_tracepoint_multi(evlist);
 }
-#endif /* HAVE_LIBTRACEEVENT */
 
 static int test__checkevent_raw_modifier(struct evlist *evlist)
 {
@@ -629,7 +624,6 @@ static int test__checkevent_pmu(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int test__checkevent_list(struct evlist *evlist)
 {
 	struct evsel *evsel = evlist__first(evlist);
@@ -671,7 +665,6 @@ static int test__checkevent_list(struct evlist *evlist)
 
 	return TEST_OK;
 }
-#endif
 
 static int test__checkevent_pmu_name(struct evlist *evlist)
 {
@@ -971,7 +964,6 @@ static int test__group2(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int test__group3(struct evlist *evlist __maybe_unused)
 {
 	struct evsel *evsel, *group1_leader = NULL, *group2_leader = NULL;
@@ -1078,7 +1070,6 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	}
 	return TEST_OK;
 }
-#endif
 
 static int test__group4(struct evlist *evlist __maybe_unused)
 {
@@ -1813,7 +1804,6 @@ static int test__term_equal_legacy(struct evlist *evlist)
 	return TEST_OK;
 }
 
-#ifdef HAVE_LIBTRACEEVENT
 static int count_tracepoints(void)
 {
 	struct dirent *events_ent;
@@ -1867,7 +1857,6 @@ static int test__all_tracepoints(struct evlist *evlist)
 
 	return test__checkevent_tracepoint_multi(evlist);
 }
-#endif /* HAVE_LIBTRACEVENT */
 
 struct evlist_test {
 	const char *name;
@@ -1876,7 +1865,6 @@ struct evlist_test {
 };
 
 static const struct evlist_test test__events[] = {
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "syscalls:sys_enter_openat",
 		.check = test__checkevent_tracepoint,
@@ -1887,7 +1875,6 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_tracepoint_multi,
 		/* 1 */
 	},
-#endif
 	{
 		.name  = "r1a",
 		.check = test__checkevent_raw,
@@ -1938,7 +1925,6 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_w,
 		/* 1 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "syscalls:sys_enter_openat:k",
 		.check = test__checkevent_tracepoint_modifier,
@@ -1949,7 +1935,6 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_tracepoint_multi_modifier,
 		/* 3 */
 	},
-#endif
 	{
 		.name  = "r1a:kp",
 		.check = test__checkevent_raw_modifier,
@@ -1995,13 +1980,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_w_modifier,
 		/* 2 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "r1,syscalls:sys_enter_openat:k,1:1:hp",
 		.check = test__checkevent_list,
 		/* 3 */
 	},
-#endif
 	{
 		.name  = "instructions:G",
 		.check = test__checkevent_exclude_host_modifier,
@@ -2032,13 +2015,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__group2,
 		/* 9 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
 		.check = test__group3,
 		/* 0 */
 	},
-#endif
 	{
 		.name  = "{cycles:u,instructions:kp}:p",
 		.check = test__group4,
@@ -2049,13 +2030,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__group5,
 		/* 2 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name  = "*:*",
 		.check = test__all_tracepoints,
 		/* 3 */
 	},
-#endif
 	{
 		.name  = "{cycles,cache-misses:G}:H",
 		.check = test__group_gh1,
@@ -2111,7 +2090,7 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_len_rw_modifier,
 		/* 4 */
 	},
-#if defined(__s390x__) && defined(HAVE_LIBTRACEEVENT)
+#if defined(__s390x__)
 	{
 		.name  = "kvm-s390:kvm_s390_create_vm",
 		.check = test__checkevent_tracepoint,
@@ -2265,13 +2244,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_2_events,
 		/* 3 */
 	},
-#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name = "9p:9p_client_req",
 		.check = test__checkevent_tracepoint,
 		/* 4 */
 	},
-#endif
 };
 
 static const struct evlist_test test__events_pmu[] = {
-- 
2.47.0.199.ga7371fff76-goog


