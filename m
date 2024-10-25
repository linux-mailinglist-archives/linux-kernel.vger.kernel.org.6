Return-Path: <linux-kernel+bounces-382484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9603C9B0EDE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DEF2859C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD5216E0A;
	Fri, 25 Oct 2024 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0CM3qlx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED551216204
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884082; cv=none; b=paxcUMwdrUr2Zd6aXCOVLVBJOIizukO4xmMyA0d/kXSVZO8prAS6webDTpVagVhTvUuydLHlDsqDmMBDROGiv6tOVR3LJeNudy3tSXeC8z3Vo74FgzKzrRZkotjRm0MsYXx9oLuzdbWHkRQc3vm/QXprcuilEz/q03JKAiCUJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884082; c=relaxed/simple;
	bh=TSak5ySXPhsLutG7PU4Surkoqp+hdpOAqqLFfKer4U4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dhTXDyx9QTy0hEeJYf9Ef49w/V4DDJq5TqRrRYmUpwgSDNNt73moBrDzC2I2oFENcan3r3XzgQs0It8O+deWATvr6lTBTve198W4qCIwB25fmOEfB9SMyk18YCL6xOFaIQbhKaeS9oJYY7VnQAw4RQDJb5Wfz9UWyUMpDK4sr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n0CM3qlx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so4608589276.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729884079; x=1730488879; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6to4NuyfolqiFxIhj4wLEb7fpmyV6YykqeCK5v8XPJY=;
        b=n0CM3qlxR7A0VYCh7ZEhhK5cQHXTAhT3zWBhzw8hCNnWocXZ6U4t5sPTpVfsSCKH5n
         ndFMFk/ZaLW059oVfdPcukUnVFvNfGlOHjz6rgFlfCB/DcCl+rUerGZxbx+0r+a58wJZ
         t5YSAqen31kh3mP7GfyfT7NP4N+hT+4tcU+l7atiM4CkFfpWIBDUFyV7fo9Ht9Zfn4lD
         6n7sYXMgHHK7DsbNGla9MZjdHtpGbjUHQkUA3vo4u6Gix+YltvIZaD1gcqwMvg8YoHR9
         V8P8OXUB5Ji13GbVf2AvPzp+QQ7zrxUYOnM/DunOkWn9vtJMDXq1If8dTqxqq3scpAMl
         rNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884079; x=1730488879;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6to4NuyfolqiFxIhj4wLEb7fpmyV6YykqeCK5v8XPJY=;
        b=v/s5J6LTjYKLBm4kjfktCA6iSYSIbpiIWGOJjwrSnRvxwB54bQTXKD9obyg5aWpJDZ
         qevUL0kQoGGiUeZc5L3q7XgzUS+7wFJi92Pugbmurak8UzLKvbEQ+ZMiaC+ZYg49tGQX
         ekS5GSHNYWSBVTymeOCOo/hEPkhlpxP5nnFhO+bTz+Lm9wdXvwXWKKwwVLu6el6Roebe
         5oqeNq8xW9p18UTHDzNxSzRvF6C0exRuIVHKDnjLOK7jkR1IJcGBXQxw+bYx9DbLWWPa
         3WJbY4pkBSubnIwXmVxAYSQaaiZEJZK618oIZNX7Aof1jwHIeCvGyldjB5tDb7GVfB0V
         Cj8g==
X-Forwarded-Encrypted: i=1; AJvYcCW7oCMw0KzOWZYvh7SqcCFihEJuNA9B8PXl8sHOEqSEcnEHNNVJEz6taXq1c7DmMUc2OMdt66o2dZ4oXW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijyRr8J+SYZ2W3bVQQhoq//JQiahyix7vEODXgQuIphPtl/XV
	aYBftyfgkq8l57j5dgY8sQ6dZPEBsvSE8nY5K1L3Gx3g6y+UhyeX5dqsDvlKOVi8yK2XE2I9tOr
	AMlPdZw==
X-Google-Smtp-Source: AGHT+IFl8rpmB5FEi/EyN+kh7NSuUq3DxgF+xg/csv+FgCNCtMuNqbfN+F6ZnzymbET6RYToa4IrWf6THyTU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:5d42:c43e:5e08:3a85])
 (user=irogers job=sendgmr) by 2002:a05:6902:4ca:b0:e2e:4391:67cc with SMTP id
 3f1490d57ef6-e3087a65968mr2038276.4.1729884078818; Fri, 25 Oct 2024 12:21:18
 -0700 (PDT)
Date: Fri, 25 Oct 2024 12:21:01 -0700
In-Reply-To: <20241025192109.132482-1-irogers@google.com>
Message-Id: <20241025192109.132482-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241025192109.132482-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 02/10] perf test: Display number of active running tests
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


