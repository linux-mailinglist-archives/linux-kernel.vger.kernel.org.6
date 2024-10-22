Return-Path: <linux-kernel+bounces-376723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E49AB526
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716C1287ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0261C8FC1;
	Tue, 22 Oct 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4CldvtaT"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286141C7B73
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618283; cv=none; b=u4XvUDjNHMiwuCjNRlWFJmha2bWvBmR6GXKRWHZev94sDOg0/iwxJiTtVZt3WTuifzVgLJqCVcGTU1VoIgeNAO9ss9ue2H0ZKmD1sAiJySXhRqkOsGQPHtWzTiQW1ySqiwvAewZsvIb0d2lWHGJ25Bco7ypOg6ZzTUR5CNWh1xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618283; c=relaxed/simple;
	bh=h8Ou5g5DrhLFfv50C/dN4S1HrMs3trrQOcpAWXFdCag=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OI0RmBZza+X+yYKXHDxGR0HNw7KnTcxZFx3YCyJpSro59w27ozDer6OkHfVnWnCLt5plslJy6B8IJ842PRP010Eet/DPnbSjfMROK6qxXewiw9GqGyvGO+iTHCrh2wB0UGGD3olh8OsJI45APH5dNu/uePyCBB9XdVpdfVVZE4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4CldvtaT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3231725c9so101949317b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729618280; x=1730223080; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kd9t++03UqxW+nAg8foHREOoohXM4WxHxsh35bvMJTw=;
        b=4CldvtaT3VL3NM+J6R4h8a5SRnsDFWp5rrpbc7Bes+WqT5+DTJkVpjx+gvdrMAByrm
         xyguf+P/CurYftM8u0UW1vxioowhsvxVk4v/Ar1ASKYTDeZPzLJP6PUU/XLvfZlFKV97
         ikvpv58k7ERNqXgtIwEwj1vpikIXJL0LdKl1hhcGWUQw/yV+hlqjQkBjv0IW8F0ogykp
         aUBGS8QcZARnoUaXn+wyvUZCOTnAqNmtFhkTLKv7q9HR5l8lHjU38sFaWMR3RmRKKLRb
         CYEy2QOYA/6OfBNBqjMgCvU2HYiGcbWlz5px9HaOUQgZBdiS5dOJwMtyv/0PjlpRQiNi
         /HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729618280; x=1730223080;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd9t++03UqxW+nAg8foHREOoohXM4WxHxsh35bvMJTw=;
        b=SgXJ35gKqCMW6DeVMjjQUpbH1qGg/8ysZ1u3zbM4ZfBDIlFCWfCIlrkbOAqrlWtJeK
         5KVEM0WNjVGbWb2laDNHawx2/3wYyze8DEkX987ig39uIkOxCVFe8TYF94Hryhwz7RtA
         rkqbbbrPkB6juAzS6YWDfFeI+BmK0A62+5KAP8wWUaWix4tiFdBiKjDrvC1TY2Cy8zGE
         fwy9CfwlEU9KQ23vqCPZv4R2JhJ5U9O1qh0VgHM4HnFTT/vjugy6OzQw0qiumH7ejlcr
         q9OJHCzu51X3NG2msECIeEUcieSgDCRAds+LZBLkquWc4iZoL8UEylPusTdc57zCZ3Px
         lPQw==
X-Forwarded-Encrypted: i=1; AJvYcCW98U/qYuEDwrlrl4OCnjTCOi2ij88T4UIpjzHVIPG1xkHhdjhSY8e7BNNM5nq02xdZZjf6V3TNMGT2kO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJf/S/z1LrtMigHWbywwzItIveRMbSHkbVfW4ePbGPpJ6B1vH
	Pmqa2m9BUwDXdr5zdqpuqqu49XtGrDBhuA07sQn8Tug09e9edwy1gKHAZi9s0+kGnS4Su7maB5d
	EBbBHsg==
X-Google-Smtp-Source: AGHT+IEPVjkVUrVyWr92okZd44uTJWhsJ7++u4e+qUxWtLRQgdL/39dFblyN0funt1fdnaaLPWEpJa2VplC3
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:57ba:88e0:aaf6:282])
 (user=irogers job=sendgmr) by 2002:a05:690c:6902:b0:6db:c6eb:bae9 with SMTP
 id 00721157ae682-6e5bfb868e1mr4151097b3.2.1729618280324; Tue, 22 Oct 2024
 10:31:20 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:30:11 -0700
In-Reply-To: <20241022173015.437550-1-irogers@google.com>
Message-Id: <20241022173015.437550-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241022173015.437550-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v3 13/16] perf bench: Remove reference to cmd_inject
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
index 105f734b6820..e54c6953cf02 100644
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


