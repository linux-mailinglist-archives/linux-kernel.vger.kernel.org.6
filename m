Return-Path: <linux-kernel+bounces-389853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 080589B7228
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851B51F214B3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7B1494A3;
	Thu, 31 Oct 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qK7LzFQh"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35356148314
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339034; cv=none; b=GKuJLUYXFQwFkaf0bEpTMX59lRBnNVcjG3s+KUBdIHGyQU+Uc7jkFEsVjon2GjvvtgGvXdmiCNxyxUqXn++NcZVFX2Ffj1Vx/62cmnioC0oQXmsSaxGGM5Moop8ntslmFJ5W5KaTxcHwyZdSpLVoEHLIPl4JB+6s6IgQcV82qWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339034; c=relaxed/simple;
	bh=wvbasbr/bHT6byIIBcUUP6y+LhSLf7VNj3pt+3TFKi0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=XoD6FvclXWUpCtfkcCdAMhUP4nV5Hw3ASxXvZQkFjTe6wle2Yhg+c5GN6syokSRbiYmtkCEDUr9lNvFCSoUg1+moab7i4T+g1WVIuh/7UKx4v9wsXXdmRhYI8kFIpLXeghkj/AQpZ6dQN/NgGjaQ7SXmRYitM1Z8YntChgJ4IzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qK7LzFQh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e291ac8dcf3so725617276.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339031; x=1730943831; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2ba9KAPKd1ye/yPm45C2inPyTurG9rFVVaZ7EYtd/Q=;
        b=qK7LzFQhqbtd1mAGVjNW0NKFUFYvsI2Z9f9aVeybYXqugWRlp6bx9xD0SY+mAYLmU9
         qiUD8CfhKOiIj4Gh0/uAMoNr34hhctNvCjl0PHnx+tgJTbhIN+qKhngQ9TJDm2EgyUv4
         FCJIPXBh8CeP+xDccyefgYcSRW2P1ioXvd3nCmQEirn/wuTw8PmoJaYOtzjHVMLplH2c
         fZha4eUWD6jqpNJ4TRi5mwa6u4WdBUPgpfX5PNUz8UdFMCDXjV6vFt7ybOSFWVDx5TGv
         yS61V2Ik+FvoFSmhyzYIoNGig3QfCEy3Fd8/sckUiiQ3DAqT4W9tSj3RDDXKeLXQWvbv
         AnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339031; x=1730943831;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R2ba9KAPKd1ye/yPm45C2inPyTurG9rFVVaZ7EYtd/Q=;
        b=aBqQla+BsHZ5B9lU+a9Sj/HQu0KdGlsHp/keRxRc60Ez4dmBz/aLV1EW8/1YDL7iXQ
         9zwwgb7ls8OijJa0cmmWc34Zp+yIEWTtuIikCTeAg6cdvJEdMNpqT/qEtdvJV9yxC6tZ
         7ENPS2TkQaWXrwkKpNh5d1xp8AumOgS4Loatq1cfvP2cYYS1MlaI3PfFlmAHx3Uw9Gln
         i9Y0Z39Mw5znJ6LJwL6eykhQbIM8TSf+CvE2HlxSAafAnSLxs8VXEWdFhYsYzNL7Kr5p
         5Fg/WqqVrVXJjRs46QuSmwhZulmV1Yb1e2HkdL59ipeb9ovHlxzgzOFKUxTWVCPWzk8N
         Kypw==
X-Forwarded-Encrypted: i=1; AJvYcCVLaxhJSp3EAIduklwQlFGbMI1B6wq7R0yDqCF+ChYV/hia1BYcLTcbuX68SVklbRiZN+Mjltiw1xsF1fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/TKnysGKqHVvjQ+aNXxYe3I7wI0FBLMLpl9i0rCn09N4GQw6Y
	wyCdvj3s0y2PaZrcCle84AASfNsOYglvP3f2KGCk6gqJRM8z21egq/iz/eY21FeNTGds/i3O247
	BlxQ8Cg==
X-Google-Smtp-Source: AGHT+IE6z5vPED/uLJOGmFJYAUbGjMLVAz6keaBEJdHcoHVGklglOAt/IvD+PSSVPz37oh93JhJrnTW5NGaS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:ae64:0:b0:e20:2db0:932e with SMTP id
 3f1490d57ef6-e3087bceae0mr63811276.6.1730339031301; Wed, 30 Oct 2024 18:43:51
 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:46 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 15/21] perf bench: Remove reference to cmd_inject
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
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid `perf bench internals inject-build-id` referencing the
cmd_inject sub-command that requires perf-bench to backward reference
internals of builtins. Replace the reference to cmd_inject with a call
to main. To avoid python.c needing to link with something providing
main, drop the libperf-bench library from the python shared object.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf          |  7 +++++--
 tools/perf/bench/inject-buildid.c | 13 +++++++------
 tools/perf/util/python.c          |  6 ------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b4dee7c20ed1..ef1b39b5042d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -487,6 +487,9 @@ endif
 EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
+PERFLIBS_PY := $(call filter-out,$(LIBPERF_BENCH),$(PERFLIBS))
+LIBS_PY = -Wl,--whole-archive $(PERFLIBS_PY) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
+
 export INSTALL SHELL_PATH
 
 ### Build rules
@@ -735,9 +738,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS_PY)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
-        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
+        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS_PY)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index a759eb2328be..f55c07e4be94 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -52,7 +52,7 @@ struct bench_dso {
 static int nr_dsos;
 static struct bench_dso *dsos;
 
-extern int cmd_inject(int argc, const char *argv[]);
+extern int main(int argc, const char **argv);
 
 static const struct option options[] = {
 	OPT_UINTEGER('i', "iterations", &iterations,
@@ -294,7 +294,7 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 
 	if (data->pid == 0) {
 		const char **inject_argv;
-		int inject_argc = 2;
+		int inject_argc = 3;
 
 		close(data->input_pipe[1]);
 		close(data->output_pipe[0]);
@@ -318,15 +318,16 @@ static int setup_injection(struct bench_data *data, bool build_id_all)
 		if (inject_argv == NULL)
 			exit(1);
 
-		inject_argv[0] = strdup("inject");
-		inject_argv[1] = strdup("-b");
+		inject_argv[0] = strdup("perf");
+		inject_argv[1] = strdup("inject");
+		inject_argv[2] = strdup("-b");
 		if (build_id_all)
-			inject_argv[2] = strdup("--buildid-all");
+			inject_argv[3] = strdup("--buildid-all");
 
 		/* signal that we're ready to go */
 		close(ready_pipe[1]);
 
-		cmd_inject(inject_argc, inject_argv);
+		main(inject_argc, inject_argv);
 
 		exit(0);
 	}
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 91fd444615cd..c52da509ae58 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -19,7 +19,6 @@
 #include "util/kwork.h"
 #include "util/sample.h"
 #include <internal/lib.h>
-#include "../builtin.h"
 
 #define _PyUnicode_FromString(arg) \
   PyUnicode_FromString(arg)
@@ -1309,8 +1308,3 @@ struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 {
 	return NULL;
 }
-
-int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
-{
-	return -1;
-}
-- 
2.47.0.163.g1226f6d8fa-goog


