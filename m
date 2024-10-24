Return-Path: <linux-kernel+bounces-379376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A74E9ADDCA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2801C22B62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1821B3955;
	Thu, 24 Oct 2024 07:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aMabW+d"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7A31ABEB8
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755231; cv=none; b=UzuWOFJjApdojB5b0e5CyRNz50bBsX5+owox4vafhWX+guB9aHvWW5U8gB+zxK/bGZTJxKplLkr1ApCeDnuELBiEC5ISMnC089nrZiC2W+Etf+DVnZWs2dD8HMl9jOtphDRrgXuVuFCa26o/V7xQUGhVk9qeBguVY/amzEvqk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755231; c=relaxed/simple;
	bh=0dbC+RaKdnXsIuzKstqRrgk9vgSNwCpbsbK3CmdWFOM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PxRT6Is8o24SmPB/elTbUdUtxBMgbEIO8wLA1zSxLpJnMyWiXC546kE0XR5MyCF3GYaYAKY7UbP9MSdyHn6yhTNC7+X2rn3WXVxmdq8Ua6dLRYyQrOMiuXK4sB84nDwLObDR1fgAekdepXJ/VDfsonS0VvW63nlw4A1OVs4Sogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aMabW+d; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e315a5b199so11801937b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755228; x=1730360028; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hzA55k1i5KBhNuyGUjIcGDdjfOELqkQQIEY92Z4/408=;
        b=0aMabW+dX5dcxpc8+a7KMV8gLy4337U5cZTEZvPfWq7ZFdKFZql7Lm8AyyQLhW1xVI
         KPH8voqWlB1b61Od7v7Mu9+SKYVB2X/oy5t0chYE1ZpgGNUXMUBwdxwrSDdH/IOUVsjM
         azXG+EbGm0zXiOg2f/3JlgOzhuUXLqmEtsAPe0O5jWKRFNfQ/duDViNyzMayuztVKdLS
         e0YAPr8RsU5d5xsXLqu1iIojB3FomZmrbEpIDtMR1loddBpVSVsTHSyxrep8DasbBJwh
         EWYEP6R1EimoQLRWIqBuhv1zSgVbrzsTPojKKInMaDk20tVYHEAaptbpLZaHa0nGUzrS
         qu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755228; x=1730360028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hzA55k1i5KBhNuyGUjIcGDdjfOELqkQQIEY92Z4/408=;
        b=VCryVcVVsO1dGTZG/nIcY8ZpZ7ehCaaw++lyixtX7tOUioYTrRlNqOq4GJ9eJbaHhl
         QpdI8kFnc1MHpSbJJsBYnOfqM0m1ZO5UOF7xcZEsCVMa9R3xaEXo8FpjgPZnG3lMn91H
         h/7FQam4pZ62Q2Ydk1hcYp97AhEfj2mLcjEq89H5OEZgZgM+0JBPpAfIKAlO2ANK30YU
         lbWX6IWGcA+8Vf4VbXZtW0Kbf5gVSRqjtX0NgsDxR7vIePomlQE5KbSzgtMLgtVqcfiZ
         zSOYxqpvwY+oanKuW1fvVUawAQgA2Y2g3+pTGyYFG3VDWaDRsYBkW5yN1c03OIL9qDtQ
         s7/g==
X-Forwarded-Encrypted: i=1; AJvYcCUqedMJCVLPVTA44foejT6l605tn2h12YOITl4exQ1qsM+nFm64RydzMzWlmAABigVwgNLgNddXySHmfNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwTPEQPQyXSEvqJoIz5VxV2e+Zqv3wx6nvyDqoNR9S84xvVcu
	8IB/cyXsadqnJpBjGf6H4k9TD42KMbPMzT3GnAOljK/JSp+29fCUCfhvyTkk2QGxMevsESGvGbO
	n9QklFQ==
X-Google-Smtp-Source: AGHT+IEqIg41JDb2+znglXqj+7LVxCtedSDwoe22Mk9wZTuT+OYqe9v7oCYf/mqBdD5tDXGnCHdiMVg8b18W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a05:690c:23c6:b0:6e3:f12:1ad3 with SMTP id
 00721157ae682-6e86635e441mr502117b3.6.1729755228029; Thu, 24 Oct 2024
 00:33:48 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:23 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 09/10] perf test: Add a signal handler to kill forked child processes
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

If the `perf test` process is killed the child tests continue running
and may run indefinitely. Propagate SIGINT (ctrl-C) and SIGTERM (kill)
signals to the running child processes so that they terminate when the
parent is killed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index a0a678facc45..f5c5b82d3b61 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -472,13 +472,22 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 	for (j = 0, k = 0; j < ARRAY_SIZE(tests); j++, k = 0)	\
 		while ((t = tests[j][k++]) != NULL)
 
+/* State outside of __cmd_test for the sake of the signal handler. */
+
+static size_t num_tests;
+static struct child_test **child_tests;
+static jmp_buf cmd_test_jmp_buf;
+
+static void cmd_test_sig_handler(int sig)
+{
+	siglongjmp(cmd_test_jmp_buf, sig);
+}
+
 static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 {
 	struct test_suite *t;
 	int width = 0;
 	unsigned int j, k;
-	size_t num_tests = 0;
-	struct child_test **child_tests;
 	int err = 0;
 
 	for_each_test(j, k, t) {
@@ -502,6 +511,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 	if (!child_tests)
 		return -ENOMEM;
 
+	err = sigsetjmp(cmd_test_jmp_buf, 1);
+	if (err) {
+		pr_err("Signal while running tests. Terminating tests with signal %d\n", err);
+		for (size_t x = 0; x < num_tests; x++) {
+			struct child_test *child_test = child_tests[x];
+
+			if (!child_test)
+				continue;
+
+			pr_debug3("Killing %3d pid %d\n",
+				  child_test->test_num + 1,
+				  child_test->process.pid);
+			kill(child_test->process.pid, SIGTERM);
+		}
+		goto err_out;
+	}
+	signal(SIGINT, cmd_test_sig_handler);
+	signal(SIGTERM, cmd_test_sig_handler);
+
 	/*
 	 * In parallel mode pass 1 runs non-exclusive tests in parallel, pass 2
 	 * runs the exclusive tests sequentially. In other modes all tests are
@@ -562,6 +590,8 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 err_out:
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (err) {
 		pr_err("Internal test harness failure. Completing any started tests:\n:");
 		for (size_t x = 0; x < num_tests; x++)
-- 
2.47.0.163.g1226f6d8fa-goog


