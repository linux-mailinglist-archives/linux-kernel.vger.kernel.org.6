Return-Path: <linux-kernel+bounces-413589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B09D1B54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FB81F21D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B35E1EF0A9;
	Mon, 18 Nov 2024 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM92ePW3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DD11EF087
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970488; cv=none; b=FLmj8VXwh1cko7FHXrvESawyyHz35gCLqGZV7/l0DFXgvNnpyhpqeGrCn7rkLvybsr0jLsYjNfXBWU9Y8V1IbHcZa0JYi77yFhI3BLApVJ52A4kOUs8XlsRCl1J4zBXEZA+965JjYqzNQubM9ZU7V7RNW7HIWB1lBMAmVfvHu3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970488; c=relaxed/simple;
	bh=6p59fnGhg3R8WxuGSRydhk66jb7GPNK67Y0Q+xJOfHU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PMJ6xLOp55q/O+10GV6TfAeCclqvTwnsDZNT+HwBaBcgpebnKLYmp8mJPCGm9iE/qo2WPQ7NHsB/9twGnpxwXE5LxrkkxBih7VSMCLwWR3ZMCpq4uz7EDSXp5Ss/L4+6zuEtMgGwGV8mxShM6Fw51ai4VMzBDweh78UogtH6R6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AM92ePW3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eae6aba72fso45132037b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731970484; x=1732575284; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mD5jCks16HgKMtJGIMozMf0vz7aQdcDKdJJkobIuclw=;
        b=AM92ePW37BYp3sik6DEYF8wHVlto9NN4Si+D/1pmJFmYCh1Z6H5wBhzVfubqyG0oyQ
         hBQbpL87qD3+fsihXK2uShYl0Ru0yWWYnnU2ejcXnCzCh0Ws9gv0pqNFWdhs1G1ALfiA
         5cmFO1msPz9icM31VQV6vNUK4mhZtBGdyBbVBhwU6ypFARlxHYncymILJNv9LaWnHWqL
         YqtuOUpNfaIroZeDZzDsz8VCOmSnjcEppUxQ03Pp0MNuyhyKoQIkj9LFesU3jycZSXOP
         JqoIgzAGZLzQqpp3E+Wetg3euTLUSWcXFTweQATsgxCPs3LLTQ7VbS+mC/g35U2mhz4g
         YP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970484; x=1732575284;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mD5jCks16HgKMtJGIMozMf0vz7aQdcDKdJJkobIuclw=;
        b=uV9WIzIOvFFKrO8PRDf5KKYUqunz//7LtQDXQ3a07LfTrmxCezZpXtL0rBIW/RQdZe
         mMc54beqNaqehDR2g4Su/SQj2NtrRm5FuRnNMufw0sz+ybsrhBWYah23gbK4b6TJe6YK
         n/X5Bl/xoUNkUPKAaTk1gEcnCP10Y6WafOVl3FqnqgAmC5baqqSxWH1Vlj2PZlVGGxTX
         4S9rEArycbaG5Mh6ytMQTrElEwobehoDlkcAD1+DY/oFIUqUH47ouzTNyR9P62sWNv43
         hkn4970m7cUOZIeSjogMM42F7gcvvgiJduKJUX2NnyCuLjceZqM20NnXMWaVaWTLuvp6
         aYUw==
X-Forwarded-Encrypted: i=1; AJvYcCWmT3zUdEx8p4Ja2nlddb+mjjnH3rjcIrVmqfg+tLOfKGwuOlOYQAc3sg6jeAhm+Keq9HrNHoe1znL7kTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99ohY6Sz6n0v8dqPPA8hmCbfq+cs9zaY7Js1MTm/IsuMpbwuC
	L6MzGDlHSxqbZt3SdyQ8uw7bVq8QfU6TIGG9OC1y3BK5lzCDukaIZ2edUMyDHdMWsm0m7OEDxyv
	luT2DUQ==
X-Google-Smtp-Source: AGHT+IGuX9TenwXB6zRWjhv+Zw88XIC0zVlyiSRcC9mseqOdSWcEQUv3ttxqHj2nG4fp9lkaeBfIfZttkCLY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:22a4:ded5:5c37:fcc7])
 (user=irogers job=sendgmr) by 2002:a81:d101:0:b0:6ea:fa4:a365 with SMTP id
 00721157ae682-6ee55ce4770mr1223427b3.8.1731970484513; Mon, 18 Nov 2024
 14:54:44 -0800 (PST)
Date: Mon, 18 Nov 2024 14:53:45 -0800
In-Reply-To: <20241118225345.889810-1-irogers@google.com>
Message-Id: <20241118225345.889810-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241118225345.889810-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v5 7/7] perf tests: Enable tests disabled due to tracepoint parsing
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
index ec4e1f034742..4bf8d3f5eae7 100644
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
index 8dcf74d3c0a3..738ad32b2c8a 100644
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
2.47.0.338.g60cca15819-goog


