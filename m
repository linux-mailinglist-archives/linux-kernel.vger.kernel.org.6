Return-Path: <linux-kernel+bounces-369191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F879A1A23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 07:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38993B225E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2FE2905;
	Thu, 17 Oct 2024 05:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YxrsrTsn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3D721E3C1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 05:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142515; cv=none; b=fS4pDyI4WvPOh+vzmipkSr9a96rJJJ72WEP2xO+Lx34V1/8TFPk6cRM6t5ED31VU1QCGjZolEVJEK1D1KLJshaSpDYfXAkUqqBQr/fiESlr4ljYKJ9mthVMLSOr+rALeUE4GOzP1RwUMfVChRrQDsaV+TnTfb9hcIvcp3R6Z9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142515; c=relaxed/simple;
	bh=xkntsTyW214McUZOI4YK0PdX88OTCnH1vIdM2rrkYrU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FACA0z//y5RloXikPN5CnQo2RPD/JYdPVifqqMVdmH8Kyl2jfsmuEUoo4I7D6a97MioV8++md53pQ3fVXt2dn0l/9VVGPOK86NOrKwURpOCjYnTsw8M4+ltIG3F3+CdHC9beSQXdWpIl1jnc40DS9iiL+9fWSdecnf7nd5vuhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YxrsrTsn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so12738197b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729142512; x=1729747312; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pHJ2/jYB0ZkRftk8XT40WjO6Pb9plA13uzt50byz9E=;
        b=YxrsrTsnKHtmKmWfKJx6z9ivdLISuC+n7g/szog5ctcOSkRWsNomgLtDemQcDiytvs
         FI7byPPepDbFQjPM1bK9zjyXSKjWzj3IISfl/oekrCIrAsC7EoXoGw6OTpurLrDkTS3q
         a1HuYZp8YLLtTzxevEhLvqg8mSVOq2i11LUyt9egSjbr7lQIMzO1FSXSXF9x1qkYvbuB
         aJ39z+CgnpqAF9d6r868itWyUemDoW18iRr9u1m1qFFbdSzvl2i1Mh5TtepaIItkRwHs
         PojEO4fTIZgv591CC/4t5SMUnp37WTt/fG17NseH4dhPMxFHkqrNmJ1BPVSAWwH+krrZ
         gwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729142512; x=1729747312;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/pHJ2/jYB0ZkRftk8XT40WjO6Pb9plA13uzt50byz9E=;
        b=s2Ifo04PaS+OarbSs4YbnvoRCoefbOzuqdFzbC2qjpLiYRQimKjUNjuJkp8oXA38a0
         Gl45QYZetLpKBamo6/yT5QQuOBMaxQztMi+CyyUD45twPUCFQSy7vkOonruTqX8wW7Cx
         lGO65/3wZXzhls2iVmMFj0POSsoTHHEVcAGsC6JYnAuzvHhZZ4LK4T044LHN2I80POP8
         nKZhttlh+i8q1KTxBW7xihW/goYPhqRGcsNzoCbUfIQdpWnOjtXJZYq+x+TZwxy1mlvM
         KqUFVfGAs9Jfx5FE/p8sdEpuLtYkmn0mJdulAJG1Fo2JyV9nzhciZLvRC4MGrSL6Xfv5
         tarQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW22tUNOhbIRV2AJLn03WEu7pmdaXj69QsxiQdib91sJcjsbmRIa3Or84EE8gzUGpVD1EHiHbmp3hQA00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWavuKHrTxWeTkylpbypPNaHKLzF9W+KtveRVngbom3eKIXD/
	s+qe82BLY1qWFXhPpUQ7xAyKAIi8PEusfpfvYK+3J8l7UydiS+kFnrf2jwNxPeo4Wexye8pK4Sb
	MXotjmg==
X-Google-Smtp-Source: AGHT+IFx8038/Nn1GMMW99JA4rgv+GkI2D/hoWH0ohWCXwjlgYSNRt1ck55s/92JZpdrRJKxcd/rbvUywVcL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:98a5:142e:8c2e:e9e5])
 (user=irogers job=sendgmr) by 2002:a05:690c:6906:b0:6db:c3b8:c4ce with SMTP
 id 00721157ae682-6e3d41e8dbdmr799607b3.7.1729142511774; Wed, 16 Oct 2024
 22:21:51 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:21:37 -0700
Message-Id: <20241017052137.225514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v1] perf test: Add a signal handler to kill forked child processes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the `perf test` process is killed the child tests continue running
and may run indefinitely. Propagate SIGINT (ctrl-C) and SIGTERM (kill)
signals to the running child processes so that they terminate when the
parent is killed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
This change is on top of the 8 patch parallel test series:
https://lore.kernel.org/lkml/20241011220354.756798-1-irogers@google.com/
---
 tools/perf/tests/builtin-test.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 09afe884a987..5c93608e9a75 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -469,13 +469,22 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
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
@@ -499,6 +508,25 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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
@@ -559,6 +587,8 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 err_out:
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (err) {
 		pr_err("Internal test harness failure. Completing any started tests:\n:");
 		for (size_t x = 0; x < num_tests; x++)
-- 
2.47.0.105.g07ac214952-goog


