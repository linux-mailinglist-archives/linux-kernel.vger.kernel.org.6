Return-Path: <linux-kernel+bounces-360688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E111999E0E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D911F23DFD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881420CCD1;
	Fri, 11 Oct 2024 07:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XU7LBvjg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024920C48F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632192; cv=none; b=e1S51NbQO+8uNFJJJ+xmx1AAWmEK+cRPtn5OSpAx2zeeuc1/KqBb8gLuZhYBDorVK3guu/kFjxKgFvakFQRta+x4XnAoNbqI6lnbPwVqdBERtVk1ipAmRyhB7Ho4/PsFpU4d+nR6oRoRRbTVA7+7GyLeiZyTLACoxvGzg9SoBm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632192; c=relaxed/simple;
	bh=EZ/KSG2YCgcvIuiR2hkvbB+QWUT2P7L8MSU3/WNrSEw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FlWSwdo5BwbfWsUWv/Pz11MNQ04pHvpHHCCG4tEIgAbAaqucu0y4VQ8Uky8aUPb8vuuTBx4dtAprfP9F9SjjT1WeImBnNOAe7Ql+rCqR2qGp/9yyWs2Z1XU8xgpZhBun2FtbRNAoZVJthMMLhS3LcKnLyjPvqXRsyWfkGDT89V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XU7LBvjg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e0082c1dd0so35241627b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632190; x=1729236990; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiVV7OPM9xYY9A282fOCtqbe0eCO4PXqRKkc+NuZBAM=;
        b=XU7LBvjgh28epU7V4n2EY6xytfXh7/tBFHsE2R/bW4oCq8hRhJKfpoPGKdMRFNmiMp
         f22qd5+GtblEXkvzBjKFi1fqG6mH9pJi9M0rGTc8NaYGjhtsXqO3equCSM31d8tF4Ws9
         XBCGl5DasObXi99AUKuCxWz6w0gaX/24GQrCDA7IQWJby5hwYaAUN1RZ9gwl//rldGsC
         jFU6wGjFVx6OTYt3PMl+dCKibNJ8NiCvMfs+YWe8Sk6fGWXXXkLtyiJBrP0jygeKc3n9
         fN35QYEKvBbEAOlk047tHXLbbXjNxIVw1I5h6bD5uoyoT+lkHic8dehX0GXmqG6bUnss
         E2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632190; x=1729236990;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiVV7OPM9xYY9A282fOCtqbe0eCO4PXqRKkc+NuZBAM=;
        b=jEZshVvcOEH/lfL30b4hxCcqbazPDOk1gcOKrlUlr226Va3iOwXajyE8UJ16NRw5n8
         e62smttlv1AZhNF5Z9JInxyCmp4bf8gkJMyKu7ULzYytOmLSbMOZA837qDrQf9oncgIQ
         VvtPvL81s9R0Cw6X6i0txb+h77yqXYntNsMroeXrK7wz5s5+Ar75Z0Ul05IM7I9qoQwo
         ao/YEe0r4lsaLcAoJpkmCGcpf2+ixq90CJzG9BmrXxTg/rnS+16FdCQOfa955LaBUxQf
         hkbu6j2y2f9gZTYdWWC5HTL8PUIrB2R0mSuPFq2GsZpS0IMB/t/0k3AY3Ewi+GoZ8m42
         LGfg==
X-Forwarded-Encrypted: i=1; AJvYcCXfJWuopRrffK6mDf+HQEHIAbnH/jlShNR0Kp1q+FZKEEgcAqEVgTG6SLOLgSibAl2IguBoJgVaTcMjexY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9xZ78IkKdY+dObCVQFhQ4w+brTuBOyoW1EK4lZqmOV92Xxjp1
	Aen/B3NsYwmSn3M87RqweQnU5ciwZXubTmnHLmJ0nfQKHofvxzQdZZaPZcx42sArvLbe9nIBxcX
	CRdE/ZA==
X-Google-Smtp-Source: AGHT+IGM45tCNomTmEn3OcKMTDY9R/u9tmt8y7Bg1uK9OcK6gzdkRtPRCoHu/FUBC1udeMjiND22pMmIlE9U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:4982:b0:648:fc8a:cd23 with SMTP
 id 00721157ae682-6e3477b49c8mr507797b3.2.1728632189615; Fri, 11 Oct 2024
 00:36:29 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:58 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 7/8] perf test: Run parallel tests in two passes
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

In pass 1 run all tests that succeed when run in parallel. In pass 2
sequentially run all remaining tests that are flagged as
"exclusive". Sequential and dont_fork tests keep to run in pass 1. Add
error handling to finish tests if starting a test fails.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c  | 149 +++++++++++++++++++------------
 tools/perf/tests/tests-scripts.c |   5 ++
 tools/perf/tests/tests.h         |   1 +
 3 files changed, 96 insertions(+), 59 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 45a31376fdb0..fd6b50f4d145 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -239,7 +239,7 @@ static int run_test_child(struct child_process *process)
 	const int signals[] = {
 		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
 	};
-	static struct child_test *child;
+	struct child_test *child = container_of(process, struct child_test, process);
 	int err;
 
 	err = sigsetjmp(run_test_jmp_buf, 1);
@@ -249,7 +249,6 @@ static int run_test_child(struct child_process *process)
 		goto err_out;
 	}
 
-	child = container_of(process, struct child_test, process);
 	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
 		signal(signals[i], child_test_sig_handler);
 
@@ -302,19 +301,25 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	return 0;
 }
 
-static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
-		       int width)
+static void finish_test(struct child_test **child_tests, int running_test, int child_test_num,
+		int width)
 {
 	struct child_test *child_test = child_tests[running_test];
-	struct test_suite *t = child_test->test;
-	int i = child_test->test_num;
-	int subi = child_test->subtest;
-	int err = child_test->process.err;
+	struct test_suite *t;
+	int i, subi, err;
 	bool err_done = false;
 	struct strbuf err_output = STRBUF_INIT;
 	int last_tests_in_progress = -1;
 	int ret;
 
+	if (child_test == NULL) {
+		/* Test wasn't started. */
+		return;
+	}
+	t = child_test->test;
+	i = child_test->test_num;
+	subi = child_test->subtest;
+	err = child_test->process.err;
 	/*
 	 * For test suites with subtests, display the suite name ahead of the
 	 * sub test names.
@@ -344,6 +349,8 @@ static int finish_test(struct child_test **child_tests, int running_test, int ch
 			int tests_in_progress = running_test;
 
 			for (int y = running_test; y < child_test_num; y++) {
+				if (child_tests[y] == NULL)
+					continue;
 				if (check_if_command_finished(&child_tests[y]->process))
 					tests_in_progress++;
 			}
@@ -397,23 +404,32 @@ static int finish_test(struct child_test **child_tests, int running_test, int ch
 	print_test_result(t, i, subi, ret, width, /*remaining=*/0);
 	if (err > 0)
 		close(err);
-	return 0;
+	zfree(&child_tests[running_test]);
 }
 
 static int start_test(struct test_suite *test, int i, int subi, struct child_test **child,
-		      int width)
+		int width, int pass)
 {
 	int err;
 
 	*child = NULL;
 	if (dont_fork) {
-		pr_debug("--- start ---\n");
-		err = test_function(test, subi)(test, subi);
-		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width, /*remaining=*/0);
+		if (pass == 1) {
+			pr_debug("--- start ---\n");
+			err = test_function(test, subi)(test, subi);
+			pr_debug("---- end ----\n");
+			print_test_result(test, i, subi, err, width, /*remaining=*/0);
+		}
+		return 0;
+	}
+	if (pass == 1 && !sequential && test->exclusive) {
+		/* When parallel, skip exclusive tests on the first pass. */
+		return 0;
+	}
+	if (pass != 1 && (sequential || !test->exclusive)) {
+		/* Sequential and non-exclusive tests were run on the first pass. */
 		return 0;
 	}
-
 	*child = zalloc(sizeof(**child));
 	if (!*child)
 		return -ENOMEM;
@@ -432,10 +448,14 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		(*child)->process.err = -1;
 	}
 	(*child)->process.no_exec_cmd = run_test_child;
-	err = start_command(&(*child)->process);
-	if (err || !sequential)
-		return  err;
-	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
+	if (sequential || pass == 2) {
+		err = start_command(&(*child)->process);
+		if (err)
+			return err;
+		finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
+		return 0;
+	}
+	return start_command(&(*child)->process);
 }
 
 #define for_each_test(j, k, t)					\
@@ -445,12 +465,11 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
-	unsigned int j, k;
-	int i = 0;
 	int width = 0;
+	unsigned int j, k;
 	size_t num_tests = 0;
 	struct child_test **child_tests;
-	int child_test_num = 0;
+	int err = 0;
 
 	for_each_test(j, k, t) {
 		int len = strlen(test_description(t, -1));
@@ -473,62 +492,73 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	if (!child_tests)
 		return -ENOMEM;
 
-	for_each_test(j, k, t) {
-		int curr = i++;
-
-		if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
-			bool skip = true;
+	/*
+	 * In parallel mode pass 1 runs non-exclusive tests in parallel, pass 2
+	 * runs the exclusive tests sequentially. In other modes all tests are
+	 * run in pass 1.
+	 */
+	for (int pass = 1; pass <= 2; pass++) {
+		int child_test_num = 0;
+		int i = 0;
+
+		for_each_test(j, k, t) {
+			int curr = i++;
+
+			if (!perf_test__matches(test_description(t, -1), curr, argc, argv)) {
+				/*
+				 * Test suite shouldn't be run based on
+				 * description. See if subtest should.
+				 */
+				bool skip = true;
+
+				for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
+					if (perf_test__matches(test_description(t, subi),
+								curr, argc, argv))
+						skip = false;
+				}
 
-			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				if (perf_test__matches(test_description(t, subi),
-							curr, argc, argv))
-					skip = false;
+				if (skip)
+					continue;
 			}
 
-			if (skip)
+			if (intlist__find(skiplist, i)) {
+				pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
+				color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
 				continue;
-		}
-
-		if (intlist__find(skiplist, i)) {
-			pr_info("%3d: %-*s:", curr + 1, width, test_description(t, -1));
-			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
-			continue;
-		}
-
-		if (!has_subtests(t)) {
-			int err = start_test(t, curr, -1, &child_tests[child_test_num++], width);
+			}
 
-			if (err) {
-				/* TODO: if !sequential waitpid the already forked children. */
-				free(child_tests);
-				return err;
+			if (!has_subtests(t)) {
+				err = start_test(t, curr, -1, &child_tests[child_test_num++],
+						 width, pass);
+				if (err)
+					goto err_out;
+				continue;
 			}
-		} else {
 			for (int subi = 0, subn = num_subtests(t); subi < subn; subi++) {
-				int err;
-
 				if (!perf_test__matches(test_description(t, subi),
 							curr, argc, argv))
 					continue;
 
 				err = start_test(t, curr, subi, &child_tests[child_test_num++],
-						 width);
+						 width, pass);
 				if (err)
-					return err;
+					goto err_out;
 			}
 		}
-	}
-	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests, i, child_test_num, width);
-
-			if (ret)
-				return ret;
+			/* Parallel mode starts tests but doesn't finish them. Do that now. */
+			for (size_t x = 0; x < num_tests; x++)
+				finish_test(child_tests, x, num_tests, width);
 		}
-		free(child_tests[i]);
+	}
+err_out:
+	if (err) {
+		pr_err("Internal test harness failure. Completing any started tests:\n:");
+		for (size_t x = 0; x < num_tests; x++)
+			finish_test(child_tests, x, num_tests, width);
 	}
 	free(child_tests);
-	return 0;
+	return err;
 }
 
 static int perf_test__list(int argc, const char **argv)
@@ -638,6 +668,7 @@ int cmd_test(int argc, const char **argv)
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
 
+
 	if (symbol__init(NULL) < 0)
 		return -1;
 
diff --git a/tools/perf/tests/tests-scripts.c b/tools/perf/tests/tests-scripts.c
index ed114b044293..443b55b0e05c 100644
--- a/tools/perf/tests/tests-scripts.c
+++ b/tools/perf/tests/tests-scripts.c
@@ -203,6 +203,11 @@ static void append_script(int dir_fd, const char *name, char *desc,
 	test_suite->desc = desc;
 	test_suite->test_cases = tests;
 	test_suite->priv = strdup_check(filename);
+	/*
+	 * Note, tests with lots of stdout can't be exclusive as if they block
+	 * then the file lock is held and no one makes progress.
+	 */
+	test_suite->exclusive = strstr(desc, "(exclusive)") != NULL;
 	/* Realloc is good enough, though we could realloc by chunks, not that
 	 * anyone will ever measure performance here */
 	result_tmp = realloc(*result, (*result_sz + 1) * sizeof(*result_tmp));
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 6ea2be86b7bf..1d3e1f91871c 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -42,6 +42,7 @@ struct test_suite {
 	const char *desc;
 	struct test_case *test_cases;
 	void *priv;
+	bool exclusive;
 };
 
 #define DECLARE_SUITE(name) \
-- 
2.47.0.rc1.288.g06298d1525-goog


