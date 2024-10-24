Return-Path: <linux-kernel+bounces-379369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF659ADDC3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A2C1C21820
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6A01AF0B3;
	Thu, 24 Oct 2024 07:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjV6ZARk"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3E1AC42B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755215; cv=none; b=bUgUpySzU7Q8qbsgaNiKqqOHWo4sxNcL0fxRwzSwr8Q8aLGTHIcQOejpqy2Mm5l0gUXGCNkcwOJZ19Gc2490k9blniCh386cLIAOHZuAKZ3yuTTiO5UTxrxCw9RpwK49W2GJyiDfQ1fFFBeFG4HddPc67X8DTuqI9dp7YidCDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755215; c=relaxed/simple;
	bh=TSak5ySXPhsLutG7PU4Surkoqp+hdpOAqqLFfKer4U4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FYbpkA2Xz5PWaUjuId0dmqy9A9Jbp2YGSJAaYZy1rAopmEOD/0c211r2hHScTioWZVokGT5xkqEE2U78WqdnmCVCwQFMRlyAvRDnFu99+B5M4Z0E112OSqevx84a+mJtvD20ZownVVcriD3iceiX2mdrL0zbJeW7YSoeAQPqg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HjV6ZARk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e290b8b69f8so1212778276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755212; x=1730360012; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6to4NuyfolqiFxIhj4wLEb7fpmyV6YykqeCK5v8XPJY=;
        b=HjV6ZARk3iO28gS4hkw2iA1qUBY1DREF6cgOORtoIa9BaI2TvaC4CGTQt0a1KOmQ5r
         GL5aft4CePzM3g9AQAH185LahU5c7AaF9VFx4fVnqoYSl24XHKvCn8vAtP7C96jtjGRY
         hq99HjD/NPskuHq8dzqedeGH2bGwy7e/HGRc/R4gde2pJnADKBPT9lpPA6xGeHRj53MF
         Np3+BrPzx08NJPWjMARqBj+waQKLCWL4vFbluho/U2sJrxUzvvNEUevLMHB1d7pWB7qF
         8bibLa1likRmXKfdTaqgwEq2anpNAoi0msC9BM1vo1Ya/kZnW61rn2XGb0ecXxMl4hSl
         3WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755212; x=1730360012;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6to4NuyfolqiFxIhj4wLEb7fpmyV6YykqeCK5v8XPJY=;
        b=siXC0y07C/ilt0k28FyO4yU8qz/I2akJ2jDRmKpguPD/qwX+cczhBK+pxg5LspRVH5
         FVRqUrfn6P3aClkrRCCjH3ep+1bOVGBt4nEzbcM37ZeIhNt6NRlxfKRc3X2OZUE91fSh
         eW/+v1S563MLSbDnwY7XsuF8K0tn3YrANwsjAA6MN10w2aM5vE1jKz4+mb3Vogqy0fdE
         I2fDGySFrudMhWGyxMrLddcvUPHQ8HP/+uHTzuNpvLfvFcsCibdVG3svRxn/zha0VWD6
         McKbBk1dXicTVkPNclT6dWz2kvEmkNk1aFbWsSEDRijTiewWBdhYuVLq/KCxiZqHZ7wH
         5IqA==
X-Forwarded-Encrypted: i=1; AJvYcCVMSime3qfGP3Gixs5d57EdXFtQOM4B1UW6+CYc8yn7uAQOXGK1ez9yHq+7BBFNOEy2yWmnhMcW/JhhSNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO551RrnYxWfc8m3u/uZncbgFvL2SIVlXtu7O2lZRZqLSxwF4u
	luGy8qlWeccWyjeU0m52IGxtI50oMzWdeCyxNDPRKJHr2EXsoZ5abhaJnTOY44EpkLj8xRGbJ7h
	zDmppPw==
X-Google-Smtp-Source: AGHT+IE/3pt+QSPw5jo9m6FWclN/3Hb9t2DDd3wM7nv2BGyfys15KEILu/W7GdtX2gbyErfst+UiUJhiWkp5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a5b:b09:0:b0:e28:e97f:538d with SMTP id
 3f1490d57ef6-e2f2fc1ad8dmr609276.6.1729755212347; Thu, 24 Oct 2024 00:33:32
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:16 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 02/10] perf test: Display number of active running tests
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

Before polling or sleeping to wait for a test to complete, print out
": Running (<num> active)" where the number of active tests is
determined by iterating over the tests and seeing which return false
for check_if_command_finished. The line erasing and printing out only
occur if the number of runnings tests changes to avoid the line
flickering excessively. Knowing tests are running allows a user to
know a test is running and in parallel mode how many of the tests are
waiting to complete. If color mode is disabled then avoid displaying
the "Running" message as deleting the line isn't reliable.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 93 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 2 files changed, 63 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7d27e30d9b2d..57d2e9e03fbc 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -245,7 +245,10 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
+#define TEST_RUNNING -3
+
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
+			     int running)
 {
 	if (has_subtests(t)) {
 		int subw = width > 2 ? width - 2 : width;
@@ -255,6 +258,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
 	switch (result) {
+	case TEST_RUNNING:
+		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d active)\n", running);
+		break;
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -276,14 +282,17 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 	return 0;
 }
 
-static int finish_test(struct child_test *child_test, int width)
+static int finish_test(struct child_test **child_tests, int running_test, int child_test_num,
+		       int width)
 {
+	struct child_test *child_test = child_tests[running_test];
 	struct test_suite *t = child_test->test;
 	int i = child_test->test_num;
 	int subi = child_test->subtest;
 	int err = child_test->process.err;
-	bool err_done = err <= 0;
+	bool err_done = false;
 	struct strbuf err_output = STRBUF_INIT;
+	int last_running = -1;
 	int ret;
 
 	/*
@@ -297,7 +306,7 @@ static int finish_test(struct child_test *child_test, int width)
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
-	if (!err_done)
+	if (err > 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
 		if (has_subtests(t))
@@ -311,38 +320,60 @@ static int finish_test(struct child_test *child_test, int width)
 			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
 			},
 		};
-		char buf[512];
-		ssize_t len;
-
-		/* Poll to avoid excessive spinning, timeout set for 100ms. */
-		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
-		if (!err_done && pfds[0].revents) {
-			errno = 0;
-			len = read(err, buf, sizeof(buf) - 1);
-
-			if (len <= 0) {
-				err_done = errno != EAGAIN;
-			} else {
-				buf[len] = '\0';
-				if (verbose > 1)
-					fprintf(stdout, "%s", buf);
-				else
+		if (perf_use_color_default) {
+			int running = 0;
+
+			for (int y = running_test; y < child_test_num; y++) {
+				if (check_if_command_finished(&child_tests[y]->process) == 0)
+					running++;
+			}
+			if (running != last_running) {
+				if (last_running != -1) {
+					/*
+					 * Erase "Running (.. active)" line
+					 * printed before poll/sleep.
+					 */
+					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+				}
+				print_test_result(t, i, subi, TEST_RUNNING, width, running);
+				last_running = running;
+			}
+		}
+
+		err_done = true;
+		if (err <= 0) {
+			/* No child stderr to poll, sleep for 10ms for child to complete. */
+			usleep(10 * 1000);
+		} else {
+			/* Poll to avoid excessive spinning, timeout set for 100ms. */
+			poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
+			if (pfds[0].revents) {
+				char buf[512];
+				ssize_t len;
+
+				len = read(err, buf, sizeof(buf) - 1);
+
+				if (len > 0) {
+					err_done = false;
+					buf[len] = '\0';
 					strbuf_addstr(&err_output, buf);
+				}
 			}
 		}
+		if (err_done)
+			err_done = check_if_command_finished(&child_test->process);
+	}
+	if (perf_use_color_default && last_running != -1) {
+		/* Erase "Running (.. active)" line printed before poll/sleep. */
+		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
 	}
 	/* Clean up child process. */
 	ret = finish_command(&child_test->process);
-	if (verbose == 1 && ret == TEST_FAIL) {
-		/* Add header for test that was skipped above. */
-		if (has_subtests(t))
-			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
-		else
-			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
+	if (verbose > 1 || (verbose == 1 && ret == TEST_FAIL))
 		fprintf(stderr, "%s", err_output.buf);
-	}
+
 	strbuf_release(&err_output);
-	print_test_result(t, i, subi, ret, width);
+	print_test_result(t, i, subi, ret, width, /*running=*/0);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -358,7 +389,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		pr_debug("--- start ---\n");
 		err = test_function(test, subi)(test, subi);
 		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width);
+		print_test_result(test, i, subi, err, width, /*running=*/0);
 		return 0;
 	}
 
@@ -383,7 +414,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	err = start_command(&(*child)->process);
 	if (err || !sequential)
 		return  err;
-	return finish_test(*child, width);
+	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
 }
 
 #define for_each_test(j, k, t)					\
@@ -468,7 +499,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	}
 	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests[i], width);
+			int ret  = finish_test(child_tests, i, child_test_num, width);
 
 			if (ret)
 				return ret;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index b2f37de305f6..9a7248dbe2d7 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -23,6 +23,7 @@
 #define MIN_GREEN	0.5
 #define MIN_RED		5.0
 
+#define PERF_COLOR_DELETE_LINE	"\033[A\33[2K\r"
 /*
  * This variable stores the value of color.ui
  */
-- 
2.47.0.163.g1226f6d8fa-goog


