Return-Path: <linux-kernel+bounces-361889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B42F99AE75
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025121F22957
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD111E6DFF;
	Fri, 11 Oct 2024 22:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sP3dZpOM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F21E630D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684261; cv=none; b=He9jl+iC0BmXIpgu8kGik08dMvaoIamsFxdt28a0yoO4xL9RqiSBkVx7RvDTMOSeo1DrUj/i4DSTvvEWI4xxd1hXAOJQnT2O9vbRWG5SBxFpctSwWRH+r5HqSPDK7J5Hykqq5HBXi0lF6gKj1JOjz5Wnx8WjO2CQXJINQei8KFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684261; c=relaxed/simple;
	bh=9Cp0Yfo6BG+TyU+ZsosYSdQA+YPv9U8nc3gSHMMpOc0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=duv3Rp4uJpKUsS9kfBZV7haciBA+cwnyHAdU8tQOE5gkT6EMcRVvZUUPtd+BpUplIXgCvVyHUvL8ZYE7sm7NdB0e3P9Ff85SabyG5DZq4Px2rmJ12X928T9WImE3Afb25vBm23+U26igdV6MoRLQWYVdQCDu+AQ+svdiNUxWTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sP3dZpOM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e32b43e053so36116287b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684259; x=1729289059; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mS/z99BEEiYdboIN11Xm9wOu4EbwK22EIzUA/5+qJ8=;
        b=sP3dZpOM2Nok48s0VKRjogTicGRsDg+ZrF6zv+q8+i4LJv1rYD7D50MLKthZhBNO43
         t/ACnWgUMwdLp4EGmNNh9Isl/r+D6F+4KMrqEx3D/0CbRrk9agLXtLRZVwNVNCqETxRa
         sPctX6XAgxV5TzpOU4l/ZvGHuxeX7lvSuM/i8Elp+AA0eboBOjCN51v+Qi4eGetnjN67
         tlqp0z9kvLzODqVPviwE7TH8XRdP1lQ2EPVdDfwmXjo4N1lcoeN32wVkwSEJArSUDi1e
         xifsRAiTAZi2GKgJJnoC+d4NzqSbUQ2YeouygGd+aTMGCk9RPP4aqNj3ccqWekCSD1Hg
         thyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684259; x=1729289059;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mS/z99BEEiYdboIN11Xm9wOu4EbwK22EIzUA/5+qJ8=;
        b=nu/Lq2IgN8EdYMsTIUwapow7dPhJUj7zGbnrO+mkfInwrhdk+n8Huq54LnexT0GVuh
         vunniuc5RU+Ir2X8KhM6nLZA6o7KkbnYwbx1xVSpgfQRYhqK11kCCNAO0ko0eObCL6BL
         sQ0KE8O68YUbDYQhkukBzabNj1OMY15ceCAc+ZPdqKN+3NYS+md6rzVDL4KjpFNXq/Uy
         r8JtAPys3hHQcFVo0w0PUJDqz2NEqK5HPRxULlP6qZR7gByHENdU48JbhL0/wbPD++GC
         p3cGT6HyJnXHpZ73DQ6N3aWh4knDhO3yI0Kd/Abl50DVYsPhy09kROBxhlyL7HkRrPd1
         Prvw==
X-Forwarded-Encrypted: i=1; AJvYcCVfdocnJnlnLW1e3w0dpHznjYMYEdNYdjiMS9DSFsGjogPmJXL9aPpxiS5rt0eRprxG1W++sUFPVt/JbgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcYvsCjcY5r9qmNiZej6qxcyduwKQMx70wqsoXxRBeDayHREXK
	TTeTZarDm+tmIbFS32tfR0NjDsGDjhzS+00/CpoYYE2CBAOIUmIO6OzABXzoEFRq4txC3swvICQ
	yb+uIFw==
X-Google-Smtp-Source: AGHT+IH260dbXRg7ABxe5w92OeDs+i3LnrNLL6kFrsQZCcme1ZQcn3sfkUpQbKxTkVd6dNLYkk+tqhXPC72D
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:5c07:b0:6e3:189a:ad66 with SMTP
 id 00721157ae682-6e347c52ab6mr350497b3.5.1728684258753; Fri, 11 Oct 2024
 15:04:18 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:52 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 6/8] perf test: Add a signal handler around running a test
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

Add a signal handler around running a test. If a signal occurs during
the test a siglongjmp unwinds the stack and output is flushed. The
global run_test_jmp_buf is either unique per forked child or not
shared during sequential execution.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 88ffc0feb51e..eca2e765beb5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <poll.h>
 #include <unistd.h>
+#include <setjmp.h>
 #include <string.h>
 #include <stdlib.h>
 #include <sys/types.h>
@@ -226,16 +227,41 @@ struct child_test {
 	int subtest;
 };
 
+static jmp_buf run_test_jmp_buf;
+
+static void child_test_sig_handler(int sig)
+{
+	siglongjmp(run_test_jmp_buf, sig);
+}
+
 static int run_test_child(struct child_process *process)
 {
-	struct child_test *child = container_of(process, struct child_test, process);
+	const int signals[] = {
+		SIGABRT, SIGBUS, SIGFPE, SIGILL, SIGINT, SIGPIPE, SIGQUIT, SIGSEGV, SIGTERM,
+	};
+	static struct child_test *child;
 	int err;
 
+	err = sigsetjmp(run_test_jmp_buf, 1);
+	if (err) {
+		fprintf(stderr, "\n---- unexpected signal (%d) ----\n", err);
+		err = err > 0 ? -err : -1;
+		goto err_out;
+	}
+
+	child = container_of(process, struct child_test, process);
+	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
+		signal(signals[i], child_test_sig_handler);
+
 	pr_debug("--- start ---\n");
 	pr_debug("test child forked, pid %d\n", getpid());
 	err = test_function(child->test, child->subtest)(child->test, child->subtest);
 	pr_debug("---- end(%d) ----\n", err);
+
+err_out:
 	fflush(NULL);
+	for (size_t i = 0; i < ARRAY_SIZE(signals); i++)
+		signal(signals[i], SIG_DFL);
 	return -err;
 }
 
-- 
2.47.0.rc1.288.g06298d1525-goog


