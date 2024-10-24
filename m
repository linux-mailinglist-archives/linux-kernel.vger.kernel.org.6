Return-Path: <linux-kernel+bounces-379375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EB99ADDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 317DDB23B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921DB1B392A;
	Thu, 24 Oct 2024 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1QXGdYh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACD71B21A6
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755229; cv=none; b=nzIqbOrlLbo7VgI14wAJi3nYtzaGIXprUz1mqenvOdCUZmMBgFOHuRnGDcnVEB/FX8THsWbDArJY5iS6WR0CsWhqB/3Vk35/N4CAceWjS/4oreFuhxix52QzMRx5n+HVcUa8ow8uyp8dlPdR2rur8+AIZZmcJA7Uh17ApO2yT1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755229; c=relaxed/simple;
	bh=M0R3zHDAes8blHNNb56eB/dYrJt3dM5C0cEG6y4au10=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FVX+iybsg8gl8fwRLZVqnN+4P9Xa82kadLvceUgIhrhaKj79VttKrrPMMJmDyFBQUZxBlCvvyCwWwKjKpoXkPzHyAG8CG5Jt3bKucZ77LB16SDGvxAneYTmDtjBAOrd2RVTojYIKg64tjvBG9DW2ugz5BzFiZ2vbavnRkCG6uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1QXGdYh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2939e25402so1191801276.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729755226; x=1730360026; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2We4CvxKfLkecfrv/oDL8pHcCSPB/kc+5ogezpwpnuw=;
        b=u1QXGdYh51wCk4m5cIy2szxKpMSn8cOQm196pTl+DdOTqYiDTpnCJRt1wOutVyBo2F
         0jwqY5DEb2JOc4G2Paq8AfW3DiLbtrL9mNuaJ0NFQJxROMJF2aen8H0v285OrSGqnb0F
         AtV7QE4Uc16/c/021T2wLck1lMg4BTGowg7d2jSTqZrIaVqFJ9TxOPrh+vbPmr7CuSxP
         twwi4XjVT3F55224P4jjt3CJgrpkXL+9Kw68738+eqXEUWxISPg+zntp2GleDjXErFKh
         9AKWmGhS2FZo2dOuZqWH+Zufy9irpKWI6xBPExr54MmqOBB+Z7JNGlSviJ3HBRePkffE
         9XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729755226; x=1730360026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2We4CvxKfLkecfrv/oDL8pHcCSPB/kc+5ogezpwpnuw=;
        b=E86miIfmXjwNXb/tEubBNoDTqfLdSg3cSWE1dkQwIvFY9bnjsNWJM3YqpQArXccf4p
         U/Cv5JzFt3IvpyDZa1QTuM39u3kLyyDUKJeA31axK6qx4H0SsXGeJbiCiKRFUQKyRULJ
         gJE0F28+8bp15g611bfkd7cArpPormFVuH8DpN1eQmncYUXqspZwDz45Sf5jI66hkPK3
         jbtL+JAzCAFnrLvADC9m4F/ZWbpx6F7dfQFRtot4+fY/BTKAaenMGi9Pu+Y4OCbyUeYS
         LSZo/gIKy7hsr33cXRibtrkmpBhFIW29HvkA5UpTysjFpVc0GOZ0RihQ5sPhWryy5P6d
         qt0A==
X-Forwarded-Encrypted: i=1; AJvYcCVRXtWhz4VtMw0wLhO6WLxs7+02/jyYv/iQAdSmJVLG1/WSfGx4TyVm1qbLB+Z2/on9WoGtimB3V0tqVOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/WEy5P+S4euZxqlE5phnGvs1zGegAuMhqv3VvGmtWmfYBZQj
	El4ZAUiWisbAsxdrWG9DiSzA9d3S5wgzsVXlF9JU/O8Q3YSz6wN861x8sFVKGy4qjw0mXOrcGbM
	YSlFb8A==
X-Google-Smtp-Source: AGHT+IEQF3XmUMfnQFWXLgOqMIZJcZqb0suCDYaD0YRwhNPawy5pg39Y3574SaLRcZwU19FWRca8TDWM5lw2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:2391:e0be:5394:f85d])
 (user=irogers job=sendgmr) by 2002:a25:bbcd:0:b0:e29:76b7:ed37 with SMTP id
 3f1490d57ef6-e2f2fc0f2c6mr17376276.9.1729755225660; Thu, 24 Oct 2024 00:33:45
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:33:22 -0700
In-Reply-To: <20241024073324.1513433-1-irogers@google.com>
Message-Id: <20241024073324.1513433-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024073324.1513433-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 08/10] perf test: Make parallel testing the default
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
index b997d0a68ca2..a0a678facc45 100644
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
 
@@ -639,19 +639,12 @@ int cmd_test(int argc, const char **argv)
 	const char *skip = NULL;
 	const char *workload = NULL;
 	bool list_workloads = false;
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
 	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing, use '--list-workloads' to list the available ones."),
@@ -688,8 +681,6 @@ int cmd_test(int argc, const char **argv)
 
 	if (dont_fork)
 		sequential = true;
-	else if (parallel)
-		sequential = false;
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-- 
2.47.0.163.g1226f6d8fa-goog


