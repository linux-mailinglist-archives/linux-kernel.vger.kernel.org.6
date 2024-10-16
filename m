Return-Path: <linux-kernel+bounces-367245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C39A002A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC421C24972
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783CA190686;
	Wed, 16 Oct 2024 04:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvDzyGdq"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB918E05E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729052702; cv=none; b=NJCry8GZvUaajFcugqhq4Q1hYXE3SdblA+SJi8Zoy2gctUJRjblzn+Y5z3uz5zyLO+sa1O45roVTeNvHS0uKu8+c0IbuEo2jf4MVETC2/3s3tF19csy6ni14TUy1PweqNjrTwa9PoQjmqoEDyOTdrRl7FOGc+TGNh6/aMczdpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729052702; c=relaxed/simple;
	bh=csnU2nMbZf5Pe92hJAmSHVFhIlfl3DEzLXbD5ATPQLs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kSaQk0a/jNUy0cTx+SvRcMx9Jq4WHKOqU711cTftlR/Eq3kf0OpN76/Kz/t8i0u3Iwo8BH7foNyNaOqYBEMmefc20nfILWMAWIKpGt0KmuvXDmVXrp8PjrGOe8Rym3eQV9wnZmaXXXpjGtNLD5OP6JVzuCfekq9kzZarlkWT8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvDzyGdq; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370d76c15so54665777b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729052700; x=1729657500; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFPRD+Qjr10yjyax0Sdihwuno8XGcCJ8rIRuK3Rp//c=;
        b=NvDzyGdqNflZzzodaxQStqZIirL071z0lzlD/gXiUkW+prgQh7YyytjFdY0wfPUKBo
         L7zLvxlgjy+ZtuAGJE8qe6PdU09HXyzHR9qlwB05LfDACEwNoXC6jdFzzYZSHt9iSOHy
         QNNt4CHepmlOI327Ct0BMKJKwLZwM22KKMiwiHpRSDoLm7UoT+L845tQCXynR0eJmaG3
         KHQxxoA66B5ZutLhHueYFK/Ot4+U18w/HJtLLDDMFp4L38pJL6hbmsqHGiaMBSLYryop
         4/0cUcHu6FUN8Ev/GMbYuPsuAXIDpvcu+R+rNvrC79rSb4RUGWyXQags4d9c3aB64kb3
         AgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729052700; x=1729657500;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFPRD+Qjr10yjyax0Sdihwuno8XGcCJ8rIRuK3Rp//c=;
        b=rNTu16CTPJllnatF7xkTuvFkB8l7qSK2es7kmgOZcUKDpHpeewcvoGD15dLn1qeN0k
         RRuWj1baVAjeUYj+Bfy2qxIHEm54+qJ6OPvKmtivCciCuga/iHVIivJaI60Ru/yYzpam
         iC6Wu/JJGs43ril5OTaRzaB3seJC9IHvDR9tCT1qLjtYOL31JGr1g8tVA8eVuwUxYUhl
         tQfsnttVNJIHhzf55Pr/85V1eLlNRW7WOdAFYR7eoMQx6ROcUyffjG+nDJYD2jkWQo+A
         cjd89XKgTyxxFpbq2/dZE0HboSYtae+86OrIVL7ysCF/wpB0VNoGe57OaV2ucle8flE3
         zsKg==
X-Forwarded-Encrypted: i=1; AJvYcCXQIcSDMIGcIudGLjHFuzdG/WjXVGCE5grwOCDcJrwyBi+t5eq617C22JtXoQJ5HhXoo3sgxhkPMBGro50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqYEXdR+EsUlaun3vLOcT5QAk1eD1rba62OSYDDQcwPd0A8Oyr
	7OJvKP2/5vw9eRJ2E94m8dfzjuZ8ePG9xZAS0H34+ijuO6JsaorhtYwV7U+BEJZcdTX2vwnxuzf
	DZ+Sg7Q==
X-Google-Smtp-Source: AGHT+IHy9VhwEOlQQZCPiCmNMOLjfo0Pg6kbmWFmia3Btzn9BB2PiEzR8ZQYj+cKn0L1Hy3IxY51u3+e8H1l
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6204:b0:6dd:bf69:7e23 with SMTP
 id 00721157ae682-6e3d41dfebbmr777617b3.7.1729052700409; Tue, 15 Oct 2024
 21:25:00 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:24:10 -0700
In-Reply-To: <20241016042415.7552-1-irogers@google.com>
Message-Id: <20241016042415.7552-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016042415.7552-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 11/16] perf env: Move arch errno function to only use in env
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
index 0b30297b4ecb..dbcf74a9e047 100644
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
index 1edbccfc3281..a903917a09a4 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -22,6 +22,8 @@ struct perf_env perf_env;
 #include "bpf-utils.h"
 #include <bpf/libbpf.h>
 
+#include "trace/beauty/arch_errno_names.c"
+
 void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 51b36c36019b..6a61ceff10bc 100644
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
2.47.0.rc1.288.g06298d1525-goog


