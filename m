Return-Path: <linux-kernel+bounces-402697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4B79C2A93
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 07:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F618282FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86A0145FE4;
	Sat,  9 Nov 2024 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LLUMObdA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3B17E01B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731133135; cv=none; b=tiEoNg9hI9EeliCLx6+nJom+UcdKQwlt3EqQx19r2jXGMZ4uHeqKyBUNpalUKmrZRV0tZtrXieqBEM5hE+jFeW4BVuUFuuYYbs7diw0Sa+1Ucr4TpGJRL6CdIH1w1IMulDxBR/MUVMYJu9Sda95cHYqYY2MxHXElQ9bEyMq+pGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731133135; c=relaxed/simple;
	bh=Wbl/xP4VdR5ZVYx+gs/s7yb4T91c4UvpqUcjo9rjNDg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=grWH4D5TdmcUeVjBmatDnX/yPS7XP5rbRB7Sf21V6mOuL58RVtxxXl6ZJxuOeBnsS5TcizCRUikJmFujvirxfQdNvHYrGpqAihdyxURwd88UAKWVD6+q3YT+InLUfcthsudP9YUHKN/rWlLlC0ltK6xZhAveHBhUpIGQfUf7fmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LLUMObdA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea33140094so56190247b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 22:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731133133; x=1731737933; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vx9oh/oHlJIJYsgb8VChVGCOrMitkPgbmFPZ/WsME0=;
        b=LLUMObdAGtbQ4ghMJveZHOCxdf54ntWHKV51/J+GAlGaHoX12QS4MjCaelqFKlborI
         Lmwgo1Y4It+lqPM4SCrETB4jmSwxxAWUGLqO4GThWQPvzFVCnL5XEVN8qDHpk29D1gYC
         iU8tfgE03R1wHXXAf4/OKq3WmJEBBuUQNVhRRwlsnlb7XPyKrwuuRMs+OE8DH/i4EUXu
         j6RDLJUXbFiqhHNh9wZz2AvzUfh6p6ljNrmBN4O8aH7+CObpa3+sH8mlc0tJeN78o9Av
         yU56f1qFyDS3SdYLDvuZp00FzTKOihOyAmYwRiWmIxf97nGevhq6QmDpZ36kdiJXIQUI
         JEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731133133; x=1731737933;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Vx9oh/oHlJIJYsgb8VChVGCOrMitkPgbmFPZ/WsME0=;
        b=h0jzDI+fPqG6hPrMKh9cxFCHQUyiVlMb86o78JSfEzjlFYTYk7TRErB+w/US9HqiX5
         xtkvHLqJZZ1GubVb+VZ/0vN+SKehCXPtzt39AymqokwN8QEI4KE0Dyi8OyAXx1kDjfGw
         5+jMgps3KrhQF7FSnYXiRepxvItY+Yr3j0HvOjiO3G8zSqrVtnvc8+TRnYPHXnUO5nW7
         RUhOzF3+TK/2WdrIGPldy0ZInpYzedOYJ+Y8oYFbb9O1oRQ5JYoKoWBYvtAUtKeGUMNM
         4i4Ti42Av7GEOv5RvcrAFsazxnycWYP+D1Mdz5+LlLxv1Ptb9/mZ1bFxo6vnEWStrYw2
         N8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIl8kj3/9Jgk/Qww4HicPLwDr9fuqlXyKxqFzyTPZkzmi6Oqj6IYqQ7I5BHdB6g5bWqNN1iygSA0VRgoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3272QyhOHHylnjywQ+cDIYvI1Phn6I/xlAypi4DKpNrKNImII
	rhHIAqKwpBMRQGqem7MXV5eUgkfmoJiy+akg0dt/fJvr5uOLZOXN21grQAglFLnflkoVHywDISF
	8UhUMkA==
X-Google-Smtp-Source: AGHT+IFpNFhlI/CNVGIaK6Ib11HgYVVc8sX3OtfxqRD2FvGZdFxE8hca2Bt5p4qyWlKorL+a5Jw0t7j7k1RD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:acc2:d48f:a998:5915])
 (user=irogers job=sendgmr) by 2002:a05:690c:6f12:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6eaddd6a3e4mr397097b3.1.1731133133585; Fri, 08 Nov 2024
 22:18:53 -0800 (PST)
Date: Fri,  8 Nov 2024 22:18:01 -0800
In-Reply-To: <20241109061809.811922-1-irogers@google.com>
Message-Id: <20241109061809.811922-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241109061809.811922-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v6 14/22] perf env: Move arch errno function to only use in env
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Move arch_syscalls__strerrno_function out of builtin-trace.c to env.c
so that there isn't a util to builtin function call. This allows the
python.c stub to be removed. Also, remove declaration/prototype from
env.h and make static to reduce scope. The include is moved inside
ifdefs to avoid, "defined but unused warnings".

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                  | 1 -
 tools/perf/trace/beauty/arch_errno_names.sh | 3 ++-
 tools/perf/util/env.c                       | 4 ++++
 tools/perf/util/env.h                       | 2 --
 tools/perf/util/python.c                    | 6 ------
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a661fbd870e7..29f64a4352dd 100644
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
2.47.0.277.g8800431eea-goog


