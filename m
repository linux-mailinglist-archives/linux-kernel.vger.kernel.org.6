Return-Path: <linux-kernel+bounces-360683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69211999E08
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D524B2196D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02CB20ADF7;
	Fri, 11 Oct 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xxs9S83"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6B20ADD5
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632181; cv=none; b=igFCSS75c8kFuQBbULM5BC+kr72HaDqh07ozixqg3HZWU37QGCLUw8mqB70bNmgQytX6vMIc+/ZuZ7HPChCL1ysOMZPyNye1xWISbVOOZKTQWFsZ0F6Lhov8U+bUxTZFE5z+8NWoPQhaRt2PmHwW8eIQ9BGQZ6wW2NWSJOrw9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632181; c=relaxed/simple;
	bh=BE71A4+W6in6OwHiqTPbNMyMV9/lD4f0WqGEUCVsUYQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YjF3AKsYtuEO4LRP2h2WFaYHJoWxqUNI8fYHbjmw349CR+zQY+rIfHgRn9917A+PYnkWRJzslnzYamhRW4hOy38FUNKD6uSk2E+HmCpHvSZnLRWynSVEd6snbYeMaNRBn943MLJVCdiBfBNmeo2atzAaCUImUzlpCjwM+gyybpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xxs9S83; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2e5e376fcso36956887b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632178; x=1729236978; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gloykLWNJIS7hYRxIxhrcOUu11SUMIFR6gR0myrd+Q=;
        b=0xxs9S83YJkv81OetXTEoaHBetfCIJtKh0YLIFv9Yq03GYy2guWentTDO14Y1za6ND
         fR6BEFbvdoSMh7S5rbvXM1jRJOt8v2pb5aX+A0VKcOTcnewiNYL6/BvQSfjVy7f5R68o
         aCtgl39+kvNj4q38/bcq7qkY+xtBoarGApMzK5+6+qLDrsY013MZulS1f7oRuPtpXmGC
         OYtT0V8sypjoeieIMXLqTZLrbn+gifRDTij7GPoZS41OkXNPjED09RjMrO5WdxHJGovd
         90bkhR1Z8vJQJJk8cNjt/ik18PuzCkdpoKm1wXGg65DV7jWWuQpW7Lp/coZoirgbx7fp
         grng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632178; x=1729236978;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gloykLWNJIS7hYRxIxhrcOUu11SUMIFR6gR0myrd+Q=;
        b=QIYIXwh47HYFB64HhuqHCUqjLRuZomMtOhcKN13Y87h41xa9BAlCwz3HJMqVv9dY27
         kI9+di8hcLWkms38v4QzkxR/xxo0WVoBbAjqMKLlO7bfCbkVkiQW+H5fG9v/xqFtP89r
         7rCcrxeE8zpgkgtH8vgMTqIHrmK3keCFbErq2v+X4gmSUEqoy8doehhMYuO85+czkRcA
         K6f/FtFMMK2mI2E91sQFjj7OZSShSXAQEs1n/6OCVhimfvNef9AItCcFFebI5YAWzwyG
         /4qmC3U9/b2dEqdR6vrsVjiMiVZ7No/kkK6xN7Sw037MbtufMVe0wDBxcLR9CQwE1w3Z
         EzUw==
X-Forwarded-Encrypted: i=1; AJvYcCX4d4uembGLyEIxbu5VdVVzuHkQlZcUE9ZnmUoVkeTZj0xMgMaSu06ZSw9GhXFuvfQFhyjP6x9Th4+OrS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBBA+GsrbbGvHcWZH1pG1quZdI2pS8k+21zUsQMU6Zl4Xl4bE
	rY0i1EU6fsxAp1pnZaLbqtSYRiuLmuZAuNvVIJzOx+NW/xu26afyE1Hv/zjKeR7MV+Fx0wl/4ho
	X713YkQ==
X-Google-Smtp-Source: AGHT+IFYMA3DLH38O9T3fJNzW1JyevwOdHaC5UQ340R2tC+oOSQhzpqT9U/uWhRGS1xK4D9caQ1extcgyIJa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:c09:b0:6e3:1702:b3e6 with SMTP id
 00721157ae682-6e347b368d2mr367447b3.4.1728632178512; Fri, 11 Oct 2024
 00:36:18 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:53 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 2/8] perf test: Display number of remaining tests
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
": Running (<num> remaining)" where the number of remaining tests is
determined by iterating over the remaining tests and seeing which
return true for check_if_command_finished. The line erasing and
printing out only occur if the number of runnings tests changes to
avoid the line flickering excessively. Knowing tests are running
allows a user to know a test is running and in parallel mode how many
of the tests are waiting to complete. If color mode is disabled then
avoid displaying the "Running" message as deleting the line isn't
reliable.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 94 ++++++++++++++++++++++-----------
 tools/perf/util/color.h         |  1 +
 2 files changed, 64 insertions(+), 31 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 470a9709427d..df0466d3def6 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -242,7 +242,10 @@ static int run_test_child(struct child_process *process)
 	return -err;
 }
 
-static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width)
+#define TEST_RUNNING -3
+
+static int print_test_result(struct test_suite *t, int i, int subtest, int result, int width,
+			     int remaining)
 {
 	if (has_subtests(t)) {
 		int subw = width > 2 ? width - 2 : width;
@@ -252,6 +255,9 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
 		pr_info("%3d: %-*s:", i + 1, width, test_description(t, subtest));
 
 	switch (result) {
+	case TEST_RUNNING:
+		color_fprintf(stderr, PERF_COLOR_YELLOW, " Running (%d remaining)\n", remaining);
+		break;
 	case TEST_OK:
 		pr_info(" Ok\n");
 		break;
@@ -273,14 +279,17 @@ static int print_test_result(struct test_suite *t, int i, int subtest, int resul
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
+	int last_tests_in_progress = -1;
 	int ret;
 
 	/*
@@ -294,7 +303,7 @@ static int finish_test(struct child_test *child_test, int width)
 	 * Busy loop reading from the child's stdout/stderr that are set to be
 	 * non-blocking until EOF.
 	 */
-	if (!err_done)
+	if (err > 0)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
 		if (has_subtests(t))
@@ -308,38 +317,61 @@ static int finish_test(struct child_test *child_test, int width)
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
+			int tests_in_progress = running_test;
+
+			for (int y = running_test; y < child_test_num; y++) {
+				if (check_if_command_finished(&child_tests[y]->process))
+					tests_in_progress++;
+			}
+			if (tests_in_progress != last_tests_in_progress) {
+				if (last_tests_in_progress != -1) {
+					/*
+					 * Erase "Running (.. remaining)" line
+					 * printed before poll/sleep.
+					 */
+					fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
+				}
+				print_test_result(t, i, subi, TEST_RUNNING, width,
+						  child_test_num - tests_in_progress);
+				last_tests_in_progress = tests_in_progress;
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
+	if (perf_use_color_default && last_tests_in_progress != -1) {
+		/* Erase "Running (.. remaining)" line printed before poll/sleep. */
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
+	print_test_result(t, i, subi, ret, width, /*remaining=*/0);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -355,7 +387,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		pr_debug("--- start ---\n");
 		err = test_function(test, subi)(test, subi);
 		pr_debug("---- end ----\n");
-		print_test_result(test, i, subi, err, width);
+		print_test_result(test, i, subi, err, width, /*remaining=*/0);
 		return 0;
 	}
 
@@ -380,7 +412,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	err = start_command(&(*child)->process);
 	if (err || !sequential)
 		return  err;
-	return finish_test(*child, width);
+	return finish_test(child, /*running_test=*/0, /*child_test_num=*/1, width);
 }
 
 #define for_each_test(j, k, t)					\
@@ -465,7 +497,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	}
 	for (i = 0; i < child_test_num; i++) {
 		if (!sequential) {
-			int ret  = finish_test(child_tests[i], width);
+			int ret  = finish_test(child_tests, i, child_test_num, width);
 
 			if (ret)
 				return ret;
diff --git a/tools/perf/util/color.h b/tools/perf/util/color.h
index 01f7bed21c9b..4b9f8d5d4439 100644
--- a/tools/perf/util/color.h
+++ b/tools/perf/util/color.h
@@ -22,6 +22,7 @@
 #define MIN_GREEN	0.5
 #define MIN_RED		5.0
 
+#define PERF_COLOR_DELETE_LINE	"\033[A\33[2K\r"
 /*
  * This variable stores the value of color.ui
  */
-- 
2.47.0.rc1.288.g06298d1525-goog


