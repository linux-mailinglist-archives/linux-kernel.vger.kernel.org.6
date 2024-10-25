Return-Path: <linux-kernel+bounces-382492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4219B0EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A198E1C2352F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210BF21B864;
	Fri, 25 Oct 2024 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2HBFvx0v"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099521B848
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884102; cv=none; b=k2nG5L3qXA9sKxovmURv9cVknYw7sm0MCJcXUAXXj/7bNa3VJDcpgJnuKE2tr39OQSqGmUh9ITi+nZ9+0AfZV5XP4iN7IgkQa9z0uxFIfqabI6hwBWrC/+jPReUuQyltDWi8+4mrKeL1x4LK3gUTgQ0o9WPIy15OlUVV72zxOvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884102; c=relaxed/simple;
	bh=rNAcF8wM8gvz4H8uQaNqviqYDP2ME6uNIt9wV+wjHHQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C2J6Jiumx9yb0Ip3wsQ8GWuN+gB3po1RJudZW4Cc3jQ/Er2cQQpxl5uF0N8A+eT0++nIkOkqreFwUYblQYllOAIOSi0VgbG4oUNekIJAWYfZvAoUnrfMa1zujPXCC5vJXi61zCz6uSPI7aVARr93KwogrXLADL2x8RqNFj8h8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2HBFvx0v; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so4162808276.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884098; x=1730488898; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dxz2W/8vDBHa448LZ9Sd6x6HeOGt9H5wdrppWaYtKk=;
        b=2HBFvx0v8xJCI17kERjyrZMzHpPctIb37U77ct8HhkDj+0YJ97Qo8Z6sOxHXPZrTJ8
         ca834jwrKT0dwAac7k0vj4gEyxRVfc9wor2VFc0lAjXKQuDBfbcSqiyuA0VYSqPUQhQw
         zmtHSXha5QCh+DETmk3W92DQme6WPoroRQsF/2VZdwGOMfiYXP8rUt/UCkydHAaybL31
         BxPP4fOyQhjNpEVFt/zTBvE+mB9eAXne2I86Dt2ycOeCzgZmeqVjxpn33+o2Je5+JvJQ
         p8o8VMMnSRgRrR2KpXF4DFgL6nO01F/iKBHkr0OCM+Ie2hjP0CYu9clQCbnNo8kPS4WP
         zo1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884098; x=1730488898;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dxz2W/8vDBHa448LZ9Sd6x6HeOGt9H5wdrppWaYtKk=;
        b=PvGJtpzOYrbiwFLWaR5Cekr42B2FZtC9qQ27pwFNdep/CUn1u4sd3cgTeKOcJ/4eVZ
         lGlDXFYOPrq2iTwXw4Js9SETSQVQN4Xp7TqGj1Q9ANVyyEhb7orHNvHvp5NNdA/zKsx3
         XBLaS1k9LTClYFWX1TVFER4o35AI/8k854faF9/VgQ3BhaWCB/Qyx2gWOdDGLPCivFq8
         r8z6VcbLr7tmIXCHLFo+l0K9unkJSmAUiuBKh6cZv+iUqrWO3mMu7iGiX+yMcUIkS7sm
         AwioXEcsaYWnjFoUllLyX0Z/JPc9nSUr6swwZ+T1vLGJyyqBexqotgqnYf4vT0yXN6+0
         J2bw==
X-Forwarded-Encrypted: i=1; AJvYcCVRgMdwvVjeflP9S6WhLRJQgDER338EiSSciiQdBIo21SUPNpWYbuqoQ1Ua4MbeJigJ/PwnwWhHYUPTUJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoHqR+4qbmYIjMeaqauSG6YOhko/apHM101eBJx1K5w8koN9No
	A4z0BrQMuweD68UYzU7PF9VcNFQPpDRW1jFix+LYGi4fy7j5WPbz0q1cUNo9P9pKS45d71n4pbm
	NjoezQw==
X-Google-Smtp-Source: AGHT+IEUKi5wV3YEZPlz2DurrhYIqR/SpWkQ+hDi0Tx37uRYxgfi+MljIzUcCfqShJ1/JNUl8DrAvdnw/RfC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a25:c78a:0:b0:e17:8e4f:981a with SMTP id
 3f1490d57ef6-e3087c2d8b1mr1832276.11.1729884097267; Fri, 25 Oct 2024 12:21:37
 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:09 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 10/10] perf test: Sort tests placing exclusive tests last
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This allows a uniform test numbering even though two passes are used
to execute them.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 125 +++++++++++++++++++++-----------
 1 file changed, 84 insertions(+), 41 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2f880f48cdc5..d2cabaa8ad92 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -137,12 +137,6 @@ static struct test_suite *generic_tests[] = {
 	NULL,
 };
 
-static struct test_suite **tests[] = {
-	generic_tests,
-	arch_tests,
-	NULL, /* shell tests created at runtime. */
-};
-
 static struct test_workload *workloads[] = {
 	&workload__noploop,
 	&workload__thloop,
@@ -468,10 +462,6 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	return start_command(&(*child)->process);
 }
 
-#define for_each_test(j, k, t)					\
-	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
-		while ((t = tests[j][k++]) != NULL)
-
 /* State outside of __cmd_test for the sake of the signal handler. */
 
 static size_t num_tests;
@@ -483,22 +473,21 @@ static void cmd_test_sig_handler(int sig)
 	siglongjmp(cmd_test_jmp_buf, sig);
 }
 
-static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
+static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
+		      struct intlist *skiplist)
 {
-	struct test_suite *t;
 	static int width = 0;
-	unsigned int j, k;
 	int err = 0;
 
-	for_each_test(j, k, t) {
-		int len = strlen(test_description(t, -1));
+	for (struct test_suite **t = suites; *t; t++) {
+		int len = strlen(test_description(*t, -1));
 
 		if (width < len)
 			width = len;
 
-		if (has_subtests(t)) {
-			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				len = strlen(test_description(t, subi));
+		if (has_subtests(*t)) {
+			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+				len = strlen(test_description(*t, subi));
 				if (width < len)
 					width = len;
 				num_tests++;
@@ -540,18 +529,18 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		int child_test_num = 0;
 		int i = 0;
 
-		for_each_test(j, k, t) {
+		for (struct test_suite **t = suites; *t; t++) {
 			int curr = i++;
 
-			if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
+			if (!perf_test__matches(test_description(*t, -1), curr, argc, argv)) {
 				/*
 				 * Test suite shouldn't be run based on
 				 * description. See if subtest should.
 				 */
 				bool skip = true;
 
-				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-					if (perf_test__matches(test_description(t, subi),
+				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+					if (perf_test__matches(test_description(*t, subi),
 								curr, argc, argv))
 						skip = false;
 				}
@@ -561,24 +550,24 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			}
 
 			if (intlist__find(skiplist, i)) {
-				pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
+				pr_info("%3d: %-*s:", curr + 1, width, test_description(*t, -1));
 				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 				continue;
 			}
 
-			if (!has_subtests(t)) {
-				err = start_test(t, curr, -1, &child_tests[child_test_num++],
+			if (!has_subtests(*t)) {
+				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
 						 width, pass);
 				if (err)
 					goto err_out;
 				continue;
 			}
-			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				if (!perf_test__matches(test_description(t, subi),
+			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+				if (!perf_test__matches(test_description(*t, subi),
 							curr, argc, argv))
 					continue;
 
-				err = start_test(t, curr, subi, &child_tests[child_test_num++],
+				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
 						 width, pass);
 				if (err)
 					goto err_out;
@@ -602,27 +591,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	return err;
 }
 
-static int perf_test__list(int argc, const char **argv)
+static int perf_test__list(struct test_suite **suites, int argc, const char **argv)
 {
-	unsigned int j, k;
-	struct test_suite *t;
 	int i = 0;
 
-	for_each_test(j, k, t) {
+	for (struct test_suite **t = suites; *t; t++) {
 		int curr = i++;
 
-		if (!perf_test__matches(test_description(t, -1), curr, argc, argv))
+		if (!perf_test__matches(test_description(*t, -1), curr, argc, argv))
 			continue;
 
-		pr_info("%3d: %s\n", i, test_description(t, -1));
+		pr_info("%3d: %s\n", i, test_description(*t, -1));
 
-		if (has_subtests(t)) {
-			int subn = num_subtests(t);
+		if (has_subtests(*t)) {
+			int subn = num_subtests(*t);
 			int subi;
 
 			for (subi = 0; subi < subn; subi++)
 				pr_info("%3d:%1d: %s\n", i, subi + 1,
-					test_description(t, subi));
+					test_description(*t, subi));
 		}
 	}
 	return 0;
@@ -661,6 +648,55 @@ static int perf_test__config(const char *var, const char *value,
 	return 0;
 }
 
+static struct test_suite **build_suites(void)
+{
+	/*
+	 * TODO: suites is static to avoid needing to clean up the scripts tests
+	 * for leak sanitizer.
+	 */
+	static struct test_suite **suites[] = {
+		generic_tests,
+		arch_tests,
+		NULL,
+	};
+	struct test_suite **result;
+	struct test_suite *t;
+	size_t n = 0, num_suites = 0;
+
+	if (suites[2] == NULL)
+		suites[2] = create_script_test_suites();
+
+#define for_each_test(t)						\
+	for (size_t i = 0, j = 0; i < ARRAY_SIZE(suites); i++, j = 0)	\
+		while ((t = suites[i][j++]) != NULL)
+
+	for_each_test(t)
+		num_suites++;
+
+	result = calloc(num_suites + 1, sizeof(struct test_suite *));
+
+	for (int pass = 1; pass <= 2; pass++) {
+		for_each_test(t) {
+			bool exclusive = false;
+
+			if (!has_subtests(t)) {
+				exclusive = test_exclusive(t, -1);
+			} else {
+				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
+					if (test_exclusive(t, subi)) {
+						exclusive = true;
+						break;
+					}
+				}
+			}
+			if ((!exclusive && pass == 1) || (exclusive && pass == 2))
+				result[n++] = t;
+		}
+	}
+	return result;
+#undef for_each_test
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -688,6 +724,7 @@ int cmd_test(int argc, const char **argv)
 	const char * const test_subcommands[] = { "list", NULL };
 	struct intlist *skiplist = NULL;
         int ret = hists__init();
+	struct test_suite **suites;
 
         if (ret < 0)
                 return ret;
@@ -697,10 +734,13 @@ int cmd_test(int argc, const char **argv)
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
 
-	tests[2] = create_script_test_suites();
 	argc = parse_options_subcommand(argc, argv, test_options, test_subcommands, test_usage, 0);
-	if (argc >= 1 && !strcmp(argv[0], "list"))
-		return perf_test__list(argc - 1, argv + 1);
+	if (argc >= 1 && !strcmp(argv[0], "list")) {
+		suites = build_suites();
+		ret = perf_test__list(suites, argc - 1, argv + 1);
+		free(suites);
+		return ret;
+	}
 
 	if (workload)
 		return run_workload(workload, argc, argv);
@@ -728,5 +768,8 @@ int cmd_test(int argc, const char **argv)
 	 */
 	rlimit__bump_memlock();
 
-	return __cmd_test(argc, argv, skiplist);
+	suites = build_suites();
+	ret = __cmd_test(suites, argc, argv, skiplist);
+	free(suites);
+	return ret;
 }
-- 
2.47.0.163.g1226f6d8fa-goog


