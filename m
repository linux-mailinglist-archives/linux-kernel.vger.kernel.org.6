Return-Path: <linux-kernel+bounces-370971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036279A3481
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1791F2469E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81BE18455B;
	Fri, 18 Oct 2024 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fo1c46Et"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA5188901
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230464; cv=none; b=petQAu6AgYnTNO5m3Mmbt1yIf+5e3pGrmYMQjPN8oSx5YJVHO5jt0LeA4d3br38Sz/pSK95FEWIrK+v/CKuTKlFQg+GAIwCXqAlIewkI/QwkO03Nq3cfU74X0yDZmOzlUZ1igWCs4INKc+giKc08wqUy8nbwGyQAJ19phtIfxm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230464; c=relaxed/simple;
	bh=k0BOXCGZynGmVHFfSxAt15i/jsThHEDa9Z9xA4vwOcU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=maslqMJuM46z47+TSnPaYHR7p9uf5wu0t4Kkwe89DMjOkdwK2hbGoppp/ZfIO+x90F5MHXXVmupq8haZb/UaUaG4fmK/f7ZWne5W6dDW01asCptv3E4T/MfX4DEjtcQNOqHc9rBgNyL+mH/E2BfPUpSW2rwYIM8vgK+42LgSKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fo1c46Et; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so2700729276.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729230462; x=1729835262; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlqOyFIbRvuFWfGY7KqjkQMxIKLW0DMuZ9kuTzuxI/g=;
        b=Fo1c46EtcAO3pPFLwMreKRY2ay0ipVD5UQDqlZfASoYQKxJoyOrssMRFUPOQMQeGr0
         2mWx5l6J8qnOyGBN8IvHLOE0Knfvs8lj4NRnHZGSxoXj6G90PN1e8fJPAEJfHzFZWJJO
         EbcCuCKfLBW8/ypqddvkNCN87hPMgnyjf9ZbC5El7DKWoL84dA54fMEQUiU7iWdCq5XV
         QSs2abtp4276eqpWAHfdVKlVsKhlQoJ9cVVSwmtOZOFD4Zu2nAjm7IbIv3RdlEu3QAkb
         eSubFqSw6kcdi2W6Tn9PghwKeiKGKd79ed/Ae8BYFSpMEBY63oeUL2tXdpw05SCdmpe2
         1xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230462; x=1729835262;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlqOyFIbRvuFWfGY7KqjkQMxIKLW0DMuZ9kuTzuxI/g=;
        b=fgaubHMS5L9m8Nu5qWQOKGNCIlF1Abxz1vob+3T3oSuP4ReeKS998mBJ8MK8sv0geD
         kKL2x9qIfaMJA/epLOwkMNJ/ZNy+1elCMRtLlmd8MX0CT0e+vP7kzsnLysEtrO7xx4Fj
         BHO2zziJ8iBJbO3CohGNmzSi2hec9IaInoog9eRgbso4kglNrcKjyad7SPdvdF59DjWI
         h5oqq7GZIbz14vEx+OAYEoT1+kW4ioaCWsuNiLo7Qw2BxlYqY3Ue+q4DvGKxMw7+lwtN
         oYddmtTfS6aAE3Cdm7EPV7hI4hcDDUsFxWMU3uDCaDSbqJu3bQZGPPGonmOYSsWjjEjs
         sruQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXnYjRyH1m9DeVVkAOtcZPNSNRxNVTQPj+IuiJghNKKyFXnE+78FLgW6CT++QJQuGzZlg2Ngf3Xq6sFJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1LQ8u0bKaDuPWnmzdUUNTcx8O0vhcXYMMM+ODU4b5klTjKZr
	m2bRhaJNY5ahzV8pJoDM6WBr43DALkya2sOWqMX4LqQ7+/mvg78rWJzn/VZM28qIUT1yQluEuv9
	JMPJ5/A==
X-Google-Smtp-Source: AGHT+IFEZkKpnOQlkP6vldZgwtko866JrioCfyYPDfy2d1AJe5t/D3hNGzKduhx0GSV7SGg+9mfCQAy0lhQ1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:30c5:9d92:bcd:7977])
 (user=irogers job=sendgmr) by 2002:a25:fc07:0:b0:e29:6e61:3db4 with SMTP id
 3f1490d57ef6-e2bb11cea47mr3154276.2.1729230461616; Thu, 17 Oct 2024 22:47:41
 -0700 (PDT)
Date: Thu, 17 Oct 2024 22:47:16 -0700
In-Reply-To: <20241018054719.1004128-1-irogers@google.com>
Message-Id: <20241018054719.1004128-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241018054719.1004128-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 6/9] perf test: Add a signal handler around running a test
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
index db6cc83ba505..f8d6477c3b0c 100644
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
@@ -227,16 +228,41 @@ struct child_test {
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
2.47.0.105.g07ac214952-goog


