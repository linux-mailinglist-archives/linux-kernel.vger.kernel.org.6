Return-Path: <linux-kernel+bounces-370973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D5D9A3484
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D80285FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17718A6C6;
	Fri, 18 Oct 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="czd6LNOg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C6185B5F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230469; cv=none; b=ILuTFvkjL90Y2j53es91kwvuEN0W0DVeKDRbsmqLb6SPk/aeuiW4ytRy7syt/uUZonBwIExWH4y5I5omZhZB52jALFZ7EHhL8recdyhpGBCgHWz70VyXwWfq9A66XSjgFNkikfj/0fmBYHCYyPY+n+ez8yd1EaahW6jKhO9xOWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230469; c=relaxed/simple;
	bh=NyBi4ldcotgRIWXy+pyJqk7L/008dIgRW+IaUmHndKE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aaWLMK+YQtmrgArB5zZV6Qs37/4dD0Ik5ULxcvuLfqMbxCJiXOJLl/4JaeiVTu4pqK/4oy3wv/ywPVBsMB1oMqX0Ylp/3TugxFL0FyeEPK9nDKXVkDQxUQ6xniirctbI7rZ7Rj7ygM2k/a5w7hpkqJT0o/D5HoQzvHzGFer6+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=czd6LNOg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e31d9c8efcso36080447b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230467; x=1729835267; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRFmLYGgcJHBSD8LI17iLRO0wZ/dUkGCXCceddIu4Nc=;
        b=czd6LNOgd2AiALcqvDeRRgjrPDTaeqk3BWv31pOzU9R9x11JG+6XIUPmdUKrb2935r
         /5o3MhbN+X2bjOhKybfhjbeLIUaEXkcvUusY616c2/rSc1/BH0MaBevEdqC9Sc27oAzO
         3k1hMozzdDd6c14jm28bzmZUwQRQZmd6TH8tqlC3xrClvDgD9xZN2/Z4yte/yx2NI85e
         iFEykiMcHt1UJDFcndsBdlBNoesX1JC+I6QJyIQZhtGvxjY9PQ/aWBz+8WqzFqd8DGdB
         smNW8AAT/r1IHWTa3Jg6di5ybV1kcKhcfhgMD/jPjS25cvj9lWZzH/GrE3PkPL0RmH0G
         0ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230467; x=1729835267;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRFmLYGgcJHBSD8LI17iLRO0wZ/dUkGCXCceddIu4Nc=;
        b=ifH7jQAsDD8yScLzFV1Hfoo+7bPS32iJKb8NLkIxwDhlGZVY3pbQzQe7wuFMG4YrAy
         JN7Mn3eaOfsHtg5/WO6XdAy0kCyftk6nlM6AIwiKcBMPlTz0kKjQrxVyjQ75mdKvCXEy
         DFFOyz727aKkhC+ZSRNmvgIXBfHKxvnf6y/3uYY3hcxN+jPcAlAv1YB0oEtP81jfokn3
         yDox/VRXXq3sE+3iNLNwfHWL9/PrmKcyg5mL0cJP97oFPJWW1084bbdX3ruX7XKAUkdr
         P5nuyaKwKfgSnJ52w1wZjOkYjqi2QrD+Ls//ChXCL6SlRAz41Ra6vbcD9IVwX7hwu5ui
         UqgA==
X-Forwarded-Encrypted: i=1; AJvYcCUES1k1o0T3MeLCVYzCvvenNnYgl/JaOuqT+sEAm8LV/+Tq71TYPGjQEjaF829NKP/Q/JCkZMPeAjXzr4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRky/ryhtKHt7Xoa3mRn6TAXp8aBRElWy+t3kF8SQBLcWA93ys
	ig94c/vWSN3cqsG7XvO4Wv113i/EJzD/z+P9mk1UE1VKKur+1q5p7j4PHguBLGg45rtrpkUR5Cj
	PekDFtQ==
X-Google-Smtp-Source: AGHT+IFKrEsf9oi8iVB/8vbj394g4OdfsAGDRVko5LPfw+EWI4ka0AKsPwGUvXWJfCgWkVrCA2e+ufqmm8lm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a05:690c:640b:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6e5bfbd5bf7mr108587b3.1.1729230466217; Thu, 17 Oct 2024
 22:47:46 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:18 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 8/9] perf test: Make parallel testing the default
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

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 258dd97c122b..78ff7862845a 100644
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
 
@@ -627,19 +627,12 @@ int cmd_test(int argc, const char **argv)
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
@@ -670,8 +663,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.105.g07ac214952-goog


