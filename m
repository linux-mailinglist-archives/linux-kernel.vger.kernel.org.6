Return-Path: <linux-kernel+bounces-387781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F079B55FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7681F23287
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAB32038C1;
	Tue, 29 Oct 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ndsBI4q3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D5720E020
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 22:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241906; cv=none; b=myM1z5Q+i7g3KJH0cfjy3zXarmt0i+CWtj35b5AVp2rh1ZIC+T4cpy3F91JIcmBIJF3MGmso4aLbSJ7VspOaQR7dS2ZPVBD1PnZvE8Qs3xvRMx06MibrmPJvL5XHHVeviNRs0QRspS2p/75TR1ce4mzrC8HBSXDkCI5snqPYJEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241906; c=relaxed/simple;
	bh=fwmYWdU7N7URJAGtQhLxs2/TrwKA2MxnPVgK6daSthY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Rk2llIHSTL8VG7qFKDFTiLujaO/f//ws1aYZ670GpKkJxpCq8k/V7DUXHgnda6vJ+j59MU7Vkk9J7yH7topR73uZeGbR7t3uvh2UAkLv/qAMaWEWH3RJ1KbqmRCPTNKaAGnwbs6eSweK32LMDeptivZAbLusx411iJGO0b7+nqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ndsBI4q3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e9d6636498so85657817b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730241902; x=1730846702; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObTCP+/V1RG4e6j09kWPCLIxYn8jcx1wj19Z/KXwVRo=;
        b=ndsBI4q3o6Fs7hz81cR+tWq8oM9ynL3uNBUqSOSrdNkgWRS1vPna6Qpkt4aqWc+PWb
         9gaBCWm04lzj8k842oh3+NPaY0DQAMUBk5u6tkGgXbGAlQJDnP+shntKjUaY2CjxGEC5
         DedrJIEAkjBvOf+9qvg5hhsDRl13VKlhgaZ7eN7yvQ2uuYqBs4BAfghi0dgB5CkfYSv+
         V7upKhFJzrM3lF2IvVb5fae+RQOR4AJZ04sV1hBIKLhMfx0xCYsMJ+UTh9g14DouNkif
         z5B2YEIcw06pjQFHJ80yJONdGb5pP57quGlm3/ln/GJY+DYit5uNWDTGJ0QX/R5ft6St
         ppqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241902; x=1730846702;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObTCP+/V1RG4e6j09kWPCLIxYn8jcx1wj19Z/KXwVRo=;
        b=lb6S8VbxAlI5UYWFvlk1YosVi7H3EDpyk7qVrnAWd+e2WdhZfJetWyse59KD9Ogjua
         JRtNtVeoGGtsoMFoSJlKf+rEUcwb2AN0AkOnQECVUe5De35HdNIMgMY6YW1LEfQdhZWd
         TaYTNi1Ak0zsVsqn52+XTjh/WLcnAF28FtG2Zc3mi7RpX9GYFhJ2drHrRre3UPZ1n9cv
         N5dk3V03wIfVxjEqIE3o6pGPQCGkVDey405JY2d4BlX8ZBjGmDSxEqrJQ8ueRnpEr07i
         2RxihUjHNjbKQLndmwwANCgDdDtQG9QkM/9R9YJxmHpgwpKoJhacBF4GRgiJM3JCAFhL
         Axog==
X-Forwarded-Encrypted: i=1; AJvYcCWz+jXP9R0A5MUZ6i6MkcNniXqNYCywh+ZynpCgOi3ihx8K52oK/jkgZqG/AEOXMiat0pTu9hxeYmuyXk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGNX7AawdT54ij1gBv+irdMbiEuRCoS2bOz+tZw3DgrYinLIB
	3cF3UNzRW4QR6PlACHoCG0NvyR5zvxFB0PEXsnScaMktPuS/tKpL+HJwSaDJwPY2MSx1DhvXSZ/
	U0JCgoQ==
X-Google-Smtp-Source: AGHT+IHOi4rYCRTPSIBfrSYRS9C66jwrDwv7mNQnq1I9ksD1zgayYtaGJpbrPAO3NxXtBeNYrXhD/TUf77Jh
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8991:d3fd:38a7:c282])
 (user=irogers job=sendgmr) by 2002:a25:eb0d:0:b0:e28:e97f:5394 with SMTP id
 3f1490d57ef6-e3087a55327mr8751276.4.1730241902419; Tue, 29 Oct 2024 15:45:02
 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:44:23 -0700
In-Reply-To: <20241029224431.167623-1-irogers@google.com>
Message-Id: <20241029224431.167623-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029224431.167623-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Subject: [PATCH v4 11/19] perf env: Move arch errno function to only use in env
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

Move arch_syscalls__strerrno_function out of builtin-trace.c to env.c
so that there isn't a util to builtin function call. This allows the
python.c stub to be removed. Also, remove declaration/prototype from
env.h and make static to reduce scope.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c                  | 1 -
 tools/perf/trace/beauty/arch_errno_names.sh | 3 ++-
 tools/perf/util/env.c                       | 2 ++
 tools/perf/util/env.h                       | 2 --
 tools/perf/util/python.c                    | 6 ------
 5 files changed, 4 insertions(+), 10 deletions(-)

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
index ccb464026642..b3fc7d32cc1b 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -23,6 +23,8 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
+#include "trace/beauty/arch_errno_names.c"
+
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
 {
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


