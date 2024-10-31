Return-Path: <linux-kernel+bounces-389851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF969B7225
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC061F21429
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F71482E3;
	Thu, 31 Oct 2024 01:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXrYtOr2"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4AD142E9F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 01:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339029; cv=none; b=hw3B/dp1jvoVk8zsAApuIDel39asKZUZttYDVVcxFuNNYHHi2KobTmilB50HHhxAQRgRWhMbdiaOze287W0wNlRKrIRfxUlD8yRiMxi9eGMMHGFcX2XCEMbLPC/y5rJQdhA9UVZuiCq3uhOoV7SZqrWNytRPpyzS4bO7Cv3Y7gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339029; c=relaxed/simple;
	bh=Y7k15MkT30/A8lyrkiuyGM2T9Ad6ytcpFrWreD4e5Yc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KEbZb81La+kDdNNMBz5iOzzxlnCLyG/Txg26lxMOr12vH8ipz8WQCV9CRgqPBQZ0aQb4G0L5W8fEtPz2d84mPeWnF1DulwKYnlBeoSQXWLaN5Oej6qNchWO/dDXjFd4ggl+vh9+ogtaJLQgs7U7HHw5Nw1zV0aF4QN+zU1hSt6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXrYtOr2; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7fb84f99cso8862267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 18:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730339026; x=1730943826; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bgmf/JpaloLQYHqwCvUuDV8PrkKL2cewLYYHkwF5BH4=;
        b=ZXrYtOr2BfISzNN+dFvLdv2h0EBVztVo/9K09ZQLbGBWct5fHEvwQ9ANMYfuszjBme
         lp91dtEb3JmQo0p1sCDyIVm+NZm5aBBmIKsaDgc8frT/FQ97inM3nptDvHOBY3unnKyv
         CWUnUrq8BqcbdNa/qswjAULnvUvwzY7EUWG90OVZ+gXNK6Z3Q5NZLZFReWEGtvw/hjLL
         suEgNYl36dtmDdwraMyU3aigE+lCRX42xoW4PSmZHgMhFTWjnYaFrbzgpiA+DbcZIt2o
         3nNSpWi2/jqv4P66m6K5ml7LoGBrSE0yC+xxxPqPiM6HlwnuGt5J8ME+WBD+GMKkdzym
         Cw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730339026; x=1730943826;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bgmf/JpaloLQYHqwCvUuDV8PrkKL2cewLYYHkwF5BH4=;
        b=oafovBwCvhwdSzDZlyZm0yUvjqPtWO7lzHOnWEcSkgPA1gVymvO5IXUeEJfmuf5JW0
         zvbmrEG0NerSQex3svnCPHKFr5DoWjufeE8C7Gyx44EO7cp3l4liM7MkZU1/2BH/nJlB
         3yTPkjwXiVaIFlse9wMLlBRUE9zNER/PbRrMBym+4tY6aGi6hn9QHyuhEeFZQiMD5qou
         ivMNT2RE9f/yPZ14GZyVLhdFIKjM/+Kx9+n46eNR1FqaCbx3pDZ9SheyzJ3ylAP3hID7
         +J8wZysDEdLZiPZYHvSCNfgi+WF+ADCwl5moOKWU62igVLybAtoFh6rqwLiIr1MQKeNo
         wQBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWag5Zs6e2z7rfOfn7eCwm7J2fwhn26J8ZbveBDhjAbcztNs1Ws5EMEJvW/YBhUQ0EVBOULl1RndI/gyDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa9T5aJgYkm4I+LVn8brr+9PEveSSEFvVZ02YQOxXxwHuG6Suj
	l8GCPQ7I1S7fXBbaoO4m/vnfTvC22uoCOcCYv79VY+mABetgWJxjekpUcgFg5i9rZUztoVppob5
	/N1yvbg==
X-Google-Smtp-Source: AGHT+IEndKaU9Rg6Vbq1IfTDr5MuubT+9yr9iLYbMbcYGark7QvH+rUTuEDXrJ85fBxDVmbmN1K9W9CyRsAE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ad0f:67e7:f1a6:84c4])
 (user=irogers job=sendgmr) by 2002:a25:2d28:0:b0:e2b:d0e9:1cdc with SMTP id
 3f1490d57ef6-e3087c2be5emr93866276.10.1730339026305; Wed, 30 Oct 2024
 18:43:46 -0700 (PDT)
Date: Wed, 30 Oct 2024 18:42:44 -0700
In-Reply-To: <20241031014252.753588-1-irogers@google.com>
Message-Id: <20241031014252.753588-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241031014252.753588-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v5 13/21] perf env: Move arch errno function to only use in env
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

Move arch_syscalls__strerrno_function out of builtin-trace.c to env.c
so that there isn't a util to builtin function call. This allows the
python.c stub to be removed. Also, remove declaration/prototype from
env.h and make static to reduce scope. The include is moved inside
ifdefs to avoid, "defined but unused warnings".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                  | 1 -
 tools/perf/trace/beauty/arch_errno_names.sh | 3 ++-
 tools/perf/util/env.c                       | 4 ++++
 tools/perf/util/env.h                       | 2 --
 tools/perf/util/python.c                    | 6 ------
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 748b061f8678..5d0345480140 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1108,7 +1108,6 @@ static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size _
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
-#include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
 #include "trace/beauty/futex_val3.c"
diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index 30d3889b2957..b22890b8d272 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,7 +57,8 @@ create_arch_errno_table_func()
 	archlist="$1"
 	default="$2"
 
-	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
+	printf 'static arch_syscalls__strerrno_t *\n'
+	printf 'arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
 		arch_str=$(arch_string "$arch")
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ccb464026642..e58f56412fbb 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -470,6 +470,10 @@ const char *perf_env__arch(struct perf_env *env)
 	return normalize_arch(arch_name);
 }
 
+#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#include "trace/beauty/arch_errno_names.c"
+#endif
+
 const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
 {
 #if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index ae604c4edbb7..e9db89395dab 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -56,8 +56,6 @@ struct pmu_caps {
 
 typedef const char *(arch_syscalls__strerrno_t)(int err);
 
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
-
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 77e02fcc51dd..35d84a96dbec 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -16,7 +16,6 @@
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "util/env.h"
 #include "util/kwork.h"
 #include "util/sample.h"
 #include "util/lock-contention.h"
@@ -1305,11 +1304,6 @@ PyMODINIT_FUNC PyInit_perf(void)
 /* The following are stubs to avoid dragging in builtin-* objects. */
 /* TODO: move the code out of the builtin-* file into util. */
 
-arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
-{
-	return NULL;
-}
-
 struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
 				       struct kwork_class *class __maybe_unused,
 				       struct kwork_work *key  __maybe_unused)
-- 
2.47.0.163.g1226f6d8fa-goog


