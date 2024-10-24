Return-Path: <linux-kernel+bounces-379377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4C89ADDCB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC221C230B6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31141ABEB8;
	Thu, 24 Oct 2024 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D2n1e++9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4E1AC420
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755235; cv=none; b=dmW/al5e6qtiFAQ8bBzBxNCjWzIIghBdA3y2pHMNpUmIbNaxVASaEPT1IxGH+dXrGGa5UmF6PWdbxTEGFrLW1GDp9cDQSxxOxduYkTDbuZ4kA3W1sk64ycCAxzeg0lzwZKWl5wucYPw2tN+ImmrHSyoPU1vc0bnTqjBlH4FKMSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755235; c=relaxed/simple;
	bh=Oi8yNVa2wiiY6Ywh5UlHXbQB0L+hHag0iAWHPMmicIA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=krVlY6j5OXeOKptIxyAnKknS6El8zsOtRnevqIgmD3VSyuZZZMHz/YkZ0nOP3iIn0o4HJe4FaNyljPy//7a1HJjuUoppQZhJDn8rEp5qj+GioSQWJY63mtPVQVovJun2/58yeLzu2CYSU6PWOSPG6TYYCB70wVoig3SPSom5kPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D2n1e++9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso13060077b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755231; x=1730360031; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxy4GtW9n2s/XLPksaSuChJLGWTx8//e0wBhnjnFtvo=;
        b=D2n1e++9ejyRGxo2hNENnKpI/Cu3CAlc4I3/Sj9ny4OJCdzTrJWX7A+0diwTqznthy
         vjbd8zIBanxLldvLHKH1qM+Xz7gvJHy3ZYHQYaBQz+rzGHYHJnC2TlpBGlrSJL+eCh8g
         sAQKoP719q7JcP/KAPIu7XgLvhY4H9edXRp0incG4WBTrBZc8IvYv6Ew7Yq8Hk7TvNP1
         9cg8qWec4By18zG3hE8KLYEYAIluWAAgjrYYELO61xKLYTzZjgl4dgotHRMMmML7XyrS
         3gRuzVlBckIQwdi6U+T3G6rNLlvwJjTFvHahxy1M+8AxR+s0UxPh8g8k4pCGoe1RipxN
         tmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755231; x=1730360031;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxy4GtW9n2s/XLPksaSuChJLGWTx8//e0wBhnjnFtvo=;
        b=h4Gt3CcW0ppwWxATJqbqrrjxHLMNtQoS78VC0tvlmakKz67nJ7fH5D2Sr/TKLFe/Y3
         QJLltYRqdGQZovusXenQrPwGbiUF+dGvXIVBE4HiKz5ym1pzJ57BCvpnZnb8Uc7RC5/5
         nFKenHU1K0qJ2h/YoceV5AO0oEFCM3XKmnj4I5o530mEQZPzAmuJiQkJOk3ref5MLAtZ
         s1RiHrjProChGC7ci29fEGv1LrxgWZLEFGiM8RPNzZ62WPFEiZrCaMO+IWyUEbmimJPc
         8x4edJMRmBpho4W7CPYIbVi4P94EUeEGPUGAny8w2lF8F8plibryjkWf9FrJQHlwQotj
         6I/g==
X-Forwarded-Encrypted: i=1; AJvYcCW7SwLEiMWQtVHuSzUSHySN4iGQaet372iWb8lml739ODv/JCcYapTCs4cv84qhHeQgx6x9fs22lTdJyEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp71hIvP/RANtX6pkIVoQjkDxTH6usy5Jjh025jzwUCkKTN4KL
	aeFrrrr6fiB/5EItVeg5aJC2N1BF3ogSeZJNpkFpGMpyKZNIrxqk8h2Ma+eYncbur/eaAUnZTEg
	fIFd8mg==
X-Google-Smtp-Source: AGHT+IG2rU9ew71mU3VZAWwi/5uzcexhk9OmzX2TeEyewRA8jn1uf09N3Encw+uhmwgskCMKMBJKZGWpKzT/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:690c:3683:b0:663:ddc1:eab8 with SMTP
 id 00721157ae682-6e866334e48mr431597b3.4.1729755230911; Thu, 24 Oct 2024
 00:33:50 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:24 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-11-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 10/10] perf test: Sort tests placing exclusive tests last
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
index f5c5b82d3b61..2acb0dd5851b 100644
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
 	int width = 0;
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
@@ -539,18 +528,18 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
@@ -560,24 +549,24 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
@@ -601,27 +590,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
@@ -660,6 +647,55 @@ static int perf_test__config(const char *var, const char *value,
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
@@ -687,6 +723,7 @@ int cmd_test(int argc, const char **argv)
 	const char * const test_subcommands[] = { "list", NULL };
 	struct intlist *skiplist = NULL;
         int ret = hists__init();
+	struct test_suite **suites;
 
         if (ret < 0)
                 return ret;
@@ -696,10 +733,13 @@ int cmd_test(int argc, const char **argv)
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
@@ -727,5 +767,8 @@ int cmd_test(int argc, const char **argv)
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


