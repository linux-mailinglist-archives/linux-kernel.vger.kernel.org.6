Return-Path: <linux-kernel+bounces-402911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C859C2E59
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 17:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5FF28211D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1219D06B;
	Sat,  9 Nov 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNRGJLZ0"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B819CC3E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168146; cv=none; b=eJxPxP+4LrVv4NZMiRJIVlqqHBS2MfozLSCMYECIOxIXoPWWs25H87AAZ3T22C162AL23k+nDIk9C6Qco5xtsXg8SSzJZeqnUcOK90zunHZPvtIieCw5gTEq5tHrsw3L12t3syhWyznxn7/Ey3/12oA6VigcBdZfnWQJiHVccfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168146; c=relaxed/simple;
	bh=J/G+GK5A6r/3LWlVQx8WCEHZt004alpDLzh/cC/43kw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=AvWfO54iLkCouJ7JssGvTEzRUsPs7XKc2J8eEzVEJwn8uFZaR3XvWsAw/2rRmiw0NUSK3K0y/P5q96QZo580b7Z+svSJ9NjAy+zPUtGGGxQv2+MBrGJUzxR+9fGHNdU+jeXriflxeDg/REy0FmKzHIsanbaJXFt3kzSaVMhsL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNRGJLZ0; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e33152c8225so6637420276.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2024 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731168143; x=1731772943; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=myihIh0U0JAwI6hYWqHsU4WyoIg2aePskZq+v84soew=;
        b=sNRGJLZ0UPaYZ9qp4CeHnLUBbkLSiAeNLt/JeUEB1iDWbTF7kiCagd0eOM86U7n/dP
         vCOWoBMhNk2fX8m17E0jdVnr7/mKV4rUgHfih4MWgoTn/c9OfY+4jpZrAmkDSaG8JLWy
         3+Qu9B2r9AvohQp0Qkw1S814x5bpUGGlHgBPlGC1FfMMGj2CIrT334j2SPqC4h6BayFp
         giNbsJVYiOVeyAQZ7oS/o/IZMTxqi5mrO+rtalomqQhG2A0SU5RwI9YYCHvuWtXs7yh7
         2MrWYpongT2XM5cfRO2/OKoD91n0A8X0UZgTflM26aYGdeaXm/FVSDmrP/7iTU69ayuh
         IV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731168143; x=1731772943;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myihIh0U0JAwI6hYWqHsU4WyoIg2aePskZq+v84soew=;
        b=wh1MIWebTMqmGjTybw2imPOtgnPq+KJ4KvcwQrPJiSBHwxfdEHPD4+oq/MavpWrNg4
         oCL+9yU9+Ghh7wXdda8URkQIs8na02L2lVGczOAaZW/7BxvPbObe6TaoJe5jqJf014O5
         4HObbsDvweEDMo0/IC5aELSXut1Tz8/lzcytkUUYsy/O/AY0t1JuQY01cW5Fs4v5abYo
         ZqeSx8FlreYs7RUwLYluItktpo+cBkcU7w7QjyT/ROlkTgI6Q41NRq2rdJj9ejlfV9Jx
         Fpho3tHQU/XBSVNfsPs0HZGh/re62d5mVB+O0GRnJahmxJIYOZH/NDo6okY5V9F6mVT8
         5tEg==
X-Forwarded-Encrypted: i=1; AJvYcCVkZkYcFc6EClDxZj21O9giP/4dqzyyXd0LCP+5MZW/PoFXup28ICc0Nh0ZCyIpu0W8PLm/IwYAsT/4rl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBUHhM1lBVfMz889s8Tcb+KNy5GpQVyLOsjbenE1vpmaCT4Wg
	DZNCl/XZv373zDlHRlwRAQZkZijmT+MSLddYzHmGlcBMJIvtV+HJMC4yrmPJUIPp7sLilnfkt2v
	4j0JhBA==
X-Google-Smtp-Source: AGHT+IHYzZ5I9NuvOBIJjrVSWWfMoguJtT9xedtPSduE1h6lWzS33Fs7ybK99uBj+p3In+hAcavMeoyMLczH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a25:dc4a:0:b0:e25:5cb1:77d8 with SMTP id
 3f1490d57ef6-e337f8ed8bbmr4583276.6.1731168143667; Sat, 09 Nov 2024 08:02:23
 -0800 (PST)
Date: Sat,  9 Nov 2024 08:02:18 -0800
Message-Id: <20241109160219.49976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v1] perf test: Add a runs-per-test flag
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

To detect flakes it is useful to run tests more than once. Add a
runs-per-test flag that will run each test multiple times.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 38 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d2cabaa8ad92..574fbd5caff0 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -42,6 +42,8 @@
 static bool dont_fork;
 /* Fork the tests in parallel and wait for their completion. */
 static bool sequential;
+/* Numer of times each test is run. */
+static unsigned int runs_per_test = 1;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -490,10 +492,10 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 				len = strlen(test_description(*t, subi));
 				if (width < len)
 					width = len;
-				num_tests++;
+				num_tests += runs_per_test;
 			}
 		} else {
-			num_tests++;
+			num_tests += runs_per_test;
 		}
 	}
 	child_tests = calloc(num_tests, sizeof(*child_tests));
@@ -556,21 +558,25 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
 			}
 
 			if (!has_subtests(*t)) {
-				err = start_test(*t, curr, -1, &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+				for (unsigned int run = 0; run < runs_per_test; run++) {
+					err = start_test(*t, curr, -1, &child_tests[child_test_num++],
+							width, pass);
+					if (err)
+						goto err_out;
+				}
 				continue;
 			}
-			for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
-				if (!perf_test__matches(test_description(*t, subi),
-							curr, argc, argv))
-					continue;
-
-				err = start_test(*t, curr, subi, &child_tests[child_test_num++],
-						 width, pass);
-				if (err)
-					goto err_out;
+			for (unsigned int run = 0; run < runs_per_test; run++) {
+				for (int subi = 0, subn = num_subtests(*t); subi < subn; subi++) {
+					if (!perf_test__matches(test_description(*t, subi),
+									curr, argc, argv))
+						continue;
+
+					err = start_test(*t, curr, subi, &child_tests[child_test_num++],
+							width, pass);
+					if (err)
+						goto err_out;
+				}
 			}
 		}
 		if (!sequential) {
@@ -714,6 +720,8 @@ int cmd_test(int argc, const char **argv)
 		    "Do not fork for testcase"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
+	OPT_UINTEGER('r', "runs-per-test", &runs_per_test,
+		     "Run each test the given number of times, default 1"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
 	OPT_BOOLEAN(0, "list-workloads", &list_workloads, "List the available builtin workloads to use with -w/--workload"),
 	OPT_STRING(0, "dso", &dso_to_test, "dso", "dso to test"),
-- 
2.47.0.277.g8800431eea-goog


