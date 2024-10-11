Return-Path: <linux-kernel+bounces-360689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA61999E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC86289F69
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C717320A5E9;
	Fri, 11 Oct 2024 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTKWRUil"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4820CCC6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632194; cv=none; b=orMnINSSeChc/PIp5lLm3KhEooCzQne5MGS5ajqOuU7CrOcC7ehA+Xu6+SM3MQ96hzDB8mABrNqqr4KsRPaFvbi939L7V3OwfikfFjqzfFU4ofrbEOekawRIS8uBxF3Yer2pcUMv42PFuhVp/AephC5ca+fk6EzET1qHFOFTkuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632194; c=relaxed/simple;
	bh=7cqOV3OKkh0N+su0/SwF7baEzp7XzLuZ+XLRbByZ/6Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=oWSU37VjVltdzG3zkQvyUYLsknineX/7TeJSU/jlOzH4s6ROpxlk7+bgneGy+AyGkHcN+7cKv1n4OPz2/QY/L+jXflj0aaa71hV3CYZajbuX3ovedZCYmzyCkjeG7+HFspOcJNmYCC04AsvwiqL1quW1sYVh66wm3LDqQYhG37c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nTKWRUil; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f8dc491so33744827b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632192; x=1729236992; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fQaK0kCKOZGBatmn2bqZbV4z0l+dtzmVYsD8j3jWpk=;
        b=nTKWRUilqiqh4AEX8WKZ0HhnUIqvIufEtQ6IIEGKqTZ0Vc/mPSlFuQg0//imSejJTp
         CJrUXtOmHp1pQUpKZVl9ZqMzwVY9KA7KcDyq/sSxq5tLeRZgfgLpxJTj7cnsRJDqZ7CN
         qvF1Gk4n2UroSLAxAqv+kX6bU/o6HaMfu2VN7S14XDivJBHTCKkyEULLpIATcY8nK9ie
         BR3JvDRsYgSQ2hr6f5vwwkVHhiP77XpEramvO02qcPmElgb1Tt31Q1K27lI4H1tzCGc4
         FhnIW+Jh82nioUu7yNMTdA1BhQpcKw7YYYUGwuQyU8y51nvXgRhWg5H0dxsLHUZoXg3T
         UY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632192; x=1729236992;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fQaK0kCKOZGBatmn2bqZbV4z0l+dtzmVYsD8j3jWpk=;
        b=pQl7Uqb8/6FlA8CbFicr4rNwereEvqX7F3K8NoQRyuW6BDD4/SvmD7Is2UzPkS3OZO
         u+pLRMC/O/OGY8J7N6yy4nsDq4OVJmYJNr3GAsM3SFHxqM3UdPFc2mcOng9n8VoPhFlg
         lgptSvBkD+OI9gYHchfLXVjasGTC7wRHgJxQAewNu6Ff7x63CRB/TA5L49nUSr+7r8ju
         1GZbaZ5ZmxRalhgW8fG00LaQcYyH6+2SAE42/nyPKQ0PISZrCqA15wyHpE+/tKZv2LEJ
         d11Bjedvwk7KJCmGFO7hlFvhRZnGG/hMeHshCzQev3kmR9V0ymKK1tbUWIomfdH3fxJc
         RkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkEyYyRi94iQG0VbHcsBjs+iTevtBRUcI4v70IYbhZCb7Z94xF6S2UooYcOnz6hLuSDFv17ENsK4EoPLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvAE6i6hJ+65+jnGrqvaZSzacIbZ2Xf9auQ2FSJsCKZthMbGQ
	N5BCeU05HARWLCJ17IQD8/BesaKM/BGh7lEkMLYaLB+cjmEzMmWExFDb+WUw445uFCotpIrnmvH
	QE0feTg==
X-Google-Smtp-Source: AGHT+IF3KkyD+E9c898rKYU9e/dhW5sEakuibvn0Cey33Cw5++s26UatIho8gVX2C49X9jgcYvAvAPF5dAGC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:2e13:b0:6b2:3ecc:817 with SMTP id
 00721157ae682-6e347c6547dmr47247b3.8.1728632191939; Fri, 11 Oct 2024 00:36:31
 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:59 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 8/8] perf test: Make parallel testing the default
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

Now C tests can have the "exclusive" flag to run without other tests,
and shell tests can add "(exclusive)" to their description, run tests
in parallel by default. Tests which flake when run in parallel can be
marked exclusive to resolve the problem.

Non-scientifically, the reduction on `perf test` execution time is
from 8m35.890s to 3m55.115s on a Tigerlake laptop. So the tests
complete in less than half the time.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fd6b50f4d145..2d62b4961f85 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -40,8 +40,8 @@
  * making them easier to debug.
  */
 static bool dont_fork;
-/* Don't fork the tests in parallel and wait for their completion. */
-static bool sequential = true;
+/* Fork the tests in parallel and wait for their completion. */
+static bool sequential;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -619,19 +619,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
-	/*
-	 * Run tests in parallel, lacks infrastructure to avoid running tests
-	 * that clash for resources, So leave it as the developers choice to
-	 * enable while working on the needed infra.
-	 */
-	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
-	OPT_BOOLEAN('p', "parallel", &parallel, "Run the tests in parallel"),
 	OPT_BOOLEAN('S', "sequential", &sequential,
 		    "Run the tests one after another rather than in parallel"),
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
@@ -662,8 +655,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.rc1.288.g06298d1525-goog


