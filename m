Return-Path: <linux-kernel+bounces-212090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7F4905B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5981E1F2445E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFDD84A48;
	Wed, 12 Jun 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLcKjrqe"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500684A4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217223; cv=none; b=YK+LsTiCjJu+CO7pNKtIoup9Snfgt9xu/oXcgsUFzIQJKcg3peiN+XBhwEVG4ju5BZYE7Xt9MEEV3PFezF4NYGbLPAtmX6O450K7coNMKVBQFH4znlDFkeq7x9wycPI0r8iaxerBigSzuLsWmFrE83ZEp1yn7SRZIpL5r+NJD9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217223; c=relaxed/simple;
	bh=pIZhUcoXHyik9pZkUTEunk00EFpUNuHTLWXhNxRFRA8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WpZWyvZYz7TdDC7R275eurN6FAfaYNcLfhr+aGc7BEEor6CyBZNK/uip+49catRBgGRoXR47z2ktyTlUs3iBb5Nu3dKfjADrnuhdKUkm8pXS/WFZucnPhHx/0RKkuNQIjFe47PEo9vXh8OuKmoABwxgvYWI6XrfJIv0bK2q7F3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLcKjrqe; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62f4a731ad4so3171857b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217220; x=1718822020; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uqZ1KGEezj4hUmhWmZJmRX9PTE7HsiBO9PBBQHCwspA=;
        b=sLcKjrqeF8wSjU3M9IUYEGtqS7eMjqN/vtjS47DbRyIpLofCGEiqamQZn6cp2G/hZX
         E8wfo8H61aDFkAZNMl4Nya/kZ7yCMY+KHZLSpkUcFVyd+VxN9dNm5uHTVY1J3vJCVWXu
         C9dKa15sxWJc4NofZ/oE3KfjQ9ia614S+vNwox+hyh5v/oGnwrb+LBnfG5o7u8Fe+kH4
         cp3Qnj8wbQsptCKTJvbn1YL1GY+wCqBiqc0EuX0PY/bs6uSi52S6Bp21fp36vUxvGsQz
         EtNC30DSrNmqvg6VLR5oK2ApTbwpWdelzijvSxyJBd3aqSblmX8ReiUADDJwlxhtnfYR
         lmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217220; x=1718822020;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uqZ1KGEezj4hUmhWmZJmRX9PTE7HsiBO9PBBQHCwspA=;
        b=ZKYTT3bXWfsX5Kcta0/ImELPARDnfkQT9aIdJuWbMjfhTfAZ/al/n9rB9+Tv+GrLmV
         zR5W03rAiE1Yp6B2f/g4zZCiSNA7IGaXi4b0ozM8Srbwa+V4H+0LYff+zGE2acfh1Lzl
         N1aEdNXAaqwI22ufMvZcRYQsY1EEjs7ABcHX9wRgUSZedqB18+b5BsOcbzxqzgnyslde
         ggET8jqwDu3z7beB9wDvIbwDHWVYhQUvt4HOXYVzLlN3d5zK9GW/s8k9pOogI2FXKOPj
         yOuT9EarITX1VX2qHaP3mQw+30fk7ojl4qHpedBQmpOW+mINN832eFF9t/ncK+Z0fHBN
         NxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfZblYVe/xc3tNwcAjEv13+4JPSzji+DbLIQ8zV6MHC255vfTV43mIl609rPuUX3pFVL7iWBL93tcyUo2UDybPndNWpUrfECfIKFIE
X-Gm-Message-State: AOJu0YztFWD7lcYjJJLqtRBF7SJAgT4UwPJ/wYrr3PSeu0ELQR9YG9eB
	UiazMFfTlR3Zj7cXJVj/VG5x3ClroOLr6LqM5N0VyU91b6nfR76T2XF8wEWxjUo9f+B+ziEVT7g
	x7XXdyA==
X-Google-Smtp-Source: AGHT+IFtDmanaEUm9Z5/3+1uhF+2RHkB4c2ke/vKwK3+9makZwnelJN7vBrlMJ9+MeHgHb29ct4yE3BNWl1U
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:959d:4302:db0e:d12a])
 (user=irogers job=sendgmr) by 2002:a05:690c:c8e:b0:61b:e524:f91a with SMTP id
 00721157ae682-62fbbfeb2a5mr5862037b3.10.1718217220579; Wed, 12 Jun 2024
 11:33:40 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:32:04 -0700
In-Reply-To: <20240612183205.3120248-1-irogers@google.com>
Message-Id: <20240612183205.3120248-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612183205.3120248-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1 6/7] perf python: Switch module to linking libraries from
 building source
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

setup.py was building most perf sources causing setup.py to mimic the
Makefile logic as well as flex/bison code to be stubbed out, due to
complexity building. By using libraries fewer functions are stubbed
out, the build is faster and the Makefile logic is reused which should
simplify updating. The libraries are passed through LDFLAGS to avoid
complexity in python.

Force the -fPIC flag for libbpf.a to ensure it is suitable for linking
into the perf python module.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config |   5 +
 tools/perf/Makefile.perf   |   6 +-
 tools/perf/util/python.c   | 271 ++++++++++++++-----------------------
 tools/perf/util/setup.py   |  33 +----
 4 files changed, 110 insertions(+), 205 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..639be696f597 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -910,6 +910,11 @@ else
          endif
          CFLAGS += -DHAVE_LIBPYTHON_SUPPORT
          $(call detected,CONFIG_LIBPYTHON)
+	 ifeq ($(filter -fPIC,$(CFLAGS)),)
+           # Building a shared library requires position independent code.
+           CFLAGS += -fPIC
+           CXXFLAGS += -fPIC
+         endif
       endif
     endif
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 28c2d7ba3c1f..6f66d3a7ffb2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -715,9 +715,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF) $(LIBSUBCMD)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(PERFLIBS)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
-        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
+        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
 	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
@@ -933,7 +933,7 @@ $(LIBAPI)-clean:
 $(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
 	$(Q)$(MAKE) -C $(LIBBPF_DIR) FEATURES_DUMP=$(FEATURE_DUMP_EXPORT) \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= subdir= \
-		$@ install_headers
+		EXTRA_CFLAGS="-fPIC" $@ install_headers
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0aeb97c11c03..3be882b2e845 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -10,21 +10,19 @@
 #endif
 #include <perf/mmap.h>
 #include "evlist.h"
-#include "callchain.h"
 #include "evsel.h"
 #include "event.h"
 #include "print_binary.h"
 #include "thread_map.h"
 #include "trace-event.h"
 #include "mmap.h"
-#include "stat.h"
-#include "metricgroup.h"
 #include "util/bpf-filter.h"
 #include "util/env.h"
-#include "util/pmu.h"
-#include "util/pmus.h"
+#include "util/kvm-stat.h"
+#include "util/kwork.h"
+#include "util/lock-contention.h"
 #include <internal/lib.h>
-#include "util.h"
+#include "../builtin.h"
 
 #if PY_MAJOR_VERSION < 3
 #define _PyUnicode_FromString(arg) \
@@ -50,166 +48,6 @@
 #define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
 #endif
 
-/*
- * Avoid bringing in event parsing.
- */
-int parse_event(struct evlist *evlist __maybe_unused, const char *str __maybe_unused)
-{
-	return 0;
-}
-
-/*
- * Provide these two so that we don't have to link against callchain.c and
- * start dragging hist.c, etc.
- */
-struct callchain_param callchain_param;
-
-int parse_callchain_record(const char *arg __maybe_unused,
-			   struct callchain_param *param __maybe_unused)
-{
-	return 0;
-}
-
-/*
- * Add these not to drag util/env.c
- */
-struct perf_env perf_env;
-
-const char *perf_env__cpuid(struct perf_env *env __maybe_unused)
-{
-	return NULL;
-}
-
-// This one is a bit easier, wouldn't drag too much, but leave it as a stub we need it here
-const char *perf_env__arch(struct perf_env *env __maybe_unused)
-{
-	return NULL;
-}
-
-/*
- * These ones are needed not to drag the PMU bandwagon, jevents generated
- * pmu_sys_event_tables, etc and evsel__find_pmu() is used so far just for
- * doing per PMU perf_event_attr.exclude_guest handling, not really needed, so
- * far, for the perf python binding known usecases, revisit if this become
- * necessary.
- */
-struct perf_pmu *evsel__find_pmu(const struct evsel *evsel __maybe_unused)
-{
-	return NULL;
-}
-
-int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char *fmt, ...)
-{
-	return EOF;
-}
-
-const char *perf_pmu__name_from_config(struct perf_pmu *pmu __maybe_unused, u64 config __maybe_unused)
-{
-	return NULL;
-}
-
-struct perf_pmu *perf_pmus__find_by_type(unsigned int type __maybe_unused)
-{
-	return NULL;
-}
-
-int perf_pmus__num_core_pmus(void)
-{
-	return 1;
-}
-
-bool evsel__is_aux_event(const struct evsel *evsel __maybe_unused)
-{
-	return false;
-}
-
-bool perf_pmus__supports_extended_type(void)
-{
-	return false;
-}
-
-/*
- * Add this one here not to drag util/metricgroup.c
- */
-int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
-				    struct rblist *new_metric_events,
-				    struct rblist *old_metric_events)
-{
-	return 0;
-}
-
-/*
- * Add this one here not to drag util/trace-event-info.c
- */
-char *tracepoint_id_to_name(u64 config)
-{
-	return NULL;
-}
-
-/*
- * XXX: All these evsel destructors need some better mechanism, like a linked
- * list of destructors registered when the relevant code indeed is used instead
- * of having more and more calls in perf_evsel__delete(). -- acme
- *
- * For now, add some more:
- *
- * Not to drag the BPF bandwagon...
- */
-void bpf_counter__destroy(struct evsel *evsel);
-int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
-int bpf_counter__disable(struct evsel *evsel);
-
-void bpf_counter__destroy(struct evsel *evsel __maybe_unused)
-{
-}
-
-int bpf_counter__install_pe(struct evsel *evsel __maybe_unused, int cpu __maybe_unused, int fd __maybe_unused)
-{
-	return 0;
-}
-
-int bpf_counter__disable(struct evsel *evsel __maybe_unused)
-{
-	return 0;
-}
-
-// not to drag util/bpf-filter.c
-#ifdef HAVE_BPF_SKEL
-int perf_bpf_filter__prepare(struct evsel *evsel __maybe_unused)
-{
-	return 0;
-}
-
-int perf_bpf_filter__destroy(struct evsel *evsel __maybe_unused)
-{
-	return 0;
-}
-#endif
-
-/*
- * Support debug printing even though util/debug.c is not linked.  That means
- * implementing 'verbose' and 'eprintf'.
- */
-int verbose;
-int debug_kmaps;
-int debug_peo_args;
-
-int eprintf(int level, int var, const char *fmt, ...);
-
-int eprintf(int level, int var, const char *fmt, ...)
-{
-	va_list args;
-	int ret = 0;
-
-	if (var >= level) {
-		va_start(args, fmt);
-		ret = vfprintf(stderr, fmt, args);
-		va_end(args);
-	}
-
-	return ret;
-}
-
 /* Define PyVarObject_HEAD_INIT for python 2.5 */
 #ifndef PyVarObject_HEAD_INIT
 # define PyVarObject_HEAD_INIT(type, size) PyObject_HEAD_INIT(type) size,
@@ -1510,15 +1348,102 @@ PyMODINIT_FUNC PyInit_perf(void)
 #endif
 }
 
-/*
- * Dummy, to avoid dragging all the test_attr infrastructure in the python
- * binding.
- */
-void test_attr__open(struct perf_event_attr *attr, pid_t pid, struct perf_cpu cpu,
-                     int fd, int group_fd, unsigned long flags)
+
+/* The following are stubs to avoid dragging in builtin-* objects. */
+/* TODO: move the code out of the builtin-* file into util. */
+
+unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
+
+bool kvm_entry_event(struct evsel *evsel __maybe_unused)
 {
+	return false;
+}
+
+bool kvm_exit_event(struct evsel *evsel __maybe_unused)
+{
+	return false;
+}
+
+bool exit_event_begin(struct evsel *evsel __maybe_unused,
+		      struct perf_sample *sample  __maybe_unused,
+		      struct event_key *key  __maybe_unused)
+{
+	return false;
+}
+
+bool exit_event_end(struct evsel *evsel __maybe_unused,
+		    struct perf_sample *sample __maybe_unused,
+		    struct event_key *key __maybe_unused)
+{
+	return false;
+}
+
+void exit_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
+			   struct event_key *key __maybe_unused,
+			   char *decode __maybe_unused)
+{
+}
+
+int find_scripts(char **scripts_array  __maybe_unused, char **scripts_path_array  __maybe_unused,
+		int num  __maybe_unused, int pathlen __maybe_unused)
+{
+	return -1;
+}
+
+void perf_stat__set_no_csv_summary(int set __maybe_unused)
+{
+}
+
+void perf_stat__set_big_num(int set __maybe_unused)
+{
+}
+
+int script_spec_register(const char *spec __maybe_unused, struct scripting_ops *ops __maybe_unused)
+{
+	return -1;
+}
+
+arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch __maybe_unused)
+{
+	return NULL;
+}
+
+struct kwork_work *perf_kwork_add_work(struct perf_kwork *kwork __maybe_unused,
+				       struct kwork_class *class __maybe_unused,
+				       struct kwork_work *key  __maybe_unused)
+{
+	return NULL;
+}
+
+void script_fetch_insn(struct perf_sample *sample __maybe_unused,
+		struct thread *thread __maybe_unused,
+		struct machine *machine __maybe_unused)
+{
+}
+
+int perf_sample__sprintf_flags(u32 flags __maybe_unused, char *str __maybe_unused,
+			size_t sz __maybe_unused)
+{
+	return -1;
+}
+
+bool match_callstack_filter(struct machine *machine __maybe_unused, u64 *callstack __maybe_unused)
+{
+	return false;
+}
+
+struct lock_stat *lock_stat_find(u64 addr __maybe_unused)
+{
+	return NULL;
+}
+
+struct lock_stat *lock_stat_findnew(u64 addr __maybe_unused, const char *name __maybe_unused,
+				int flags __maybe_unused)
+{
+	return NULL;
 }
 
-void evlist__free_stats(struct evlist *evlist)
+int cmd_inject(int argc __maybe_unused, const char *argv[] __maybe_unused)
 {
+	return -1;
 }
diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index 3107f5aa8c9a..142e9d447ce7 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -60,7 +60,7 @@ class install_lib(_install_lib):
 
 cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls', '-DPYTHON_PERF' ]
+cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc_is_clang:
     cflags += ["-Wno-unused-command-line-argument" ]
 else:
@@ -72,36 +72,11 @@ cflags += [ "-Wno-declaration-after-statement" ]
 src_perf  = getenv('srctree') + '/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
 build_tmp = getenv('PYTHON_EXTBUILD_TMP')
-libtraceevent = getenv('LIBTRACEEVENT')
-libapikfs = getenv('LIBAPI')
-libperf = getenv('LIBPERF')
-
-ext_sources = [f.strip() for f in open('util/python-ext-sources')
-				if len(f.strip()) > 0 and f[0] != '#']
-
-extra_libraries = []
-
-if '-DHAVE_LIBTRACEEVENT' in cflags:
-    extra_libraries += [ 'traceevent' ]
-else:
-    ext_sources.remove('util/trace-event.c')
-    ext_sources.remove('util/trace-event-parse.c')
-
-# use full paths with source files
-ext_sources = list(map(lambda x: '%s/%s' % (src_perf, x) , ext_sources))
-
-if '-DHAVE_LIBNUMA_SUPPORT' in cflags:
-    extra_libraries += [ 'numa' ]
-if '-DHAVE_LIBCAP_SUPPORT' in cflags:
-    extra_libraries += [ 'cap' ]
 
 perf = Extension('perf',
-		  sources = ext_sources,
-		  include_dirs = ['util/include'],
-		  libraries = extra_libraries,
-		  extra_compile_args = cflags,
-		  extra_objects = [ x for x in [libtraceevent, libapikfs, libperf]
-                                    if x is not None],
+                 sources = [ src_perf + '/util/python.c' ],
+		         include_dirs = ['util/include'],
+		         extra_compile_args = cflags,
                  )
 
 setup(name='perf',
-- 
2.45.2.505.gda0bf45e8d-goog


