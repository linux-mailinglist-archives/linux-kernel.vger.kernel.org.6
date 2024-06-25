Return-Path: <linux-kernel+bounces-229525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4196891706E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5323B257C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9594B17D8B0;
	Tue, 25 Jun 2024 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4F+GP/t"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A80C17D889
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340964; cv=none; b=eobE3gMwV27E/FjUCA8CstPwKuGjWx9aN5333tGBFLRVuOnrs9+cz34SotRDp6TTpN7mj6gROgQuG2iWMhPUvhGVHLC1tngHPkgIDvZMMYekqe/14/IYuMWLGVi/sJ2IOZPfUFZQxcuKnuihV8zhGMXXsb9GO8OszJZ+EQcwNwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340964; c=relaxed/simple;
	bh=N5E4meGJMW6NrkK2/H6Z1wvt8B2rm7TZLxu23z7djY0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=LFERza6Y0zEr/wuHMEa8JrotWWOaymaHzL4dT4OwVBs3M8NREJwbhzr70vbAfxQV7bxgWg/4YwvkGmYEQKw6E2dMoJ1kHGPdc3YKTKdQ+KvgmzPiUoGF4z7mt4lMKAWwHsvVyV5WTWpctIRoGMS15PF5sV3Di/8M1XEqWnNabxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4F+GP/t; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff16daff8dso11720161276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719340960; x=1719945760; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INYs1zZMYGf3GJdIHQS7QZYH+KY4EsCuofnbdRJz94s=;
        b=e4F+GP/tRoExrZLAG7mNljpJYZJJBwwYjWQsrRu3IlXGCVj08mRXPQGut82h9SpXYV
         pVkNxBY6+F0nmKHpsLF7dIUSr5nPcAwhVW3Qjh8xAgcPXGzy4d+N1pNzPQsJxEPtrNtk
         wfTmLNbUDIAL8YjxSLktal1z0+iunW0Zz6dd6tnUSe6ACSb5WJQFSJRPmpgjMH8Ot7h+
         pM3+dykTis777fS5JH6ttR5VSTbjlb8y/Q35oSviXkL3klYeF3E+i+vV91gCIVA3Dp8r
         OTr8Xm0miNdFO80pCpOa73raT5gPBP7Ung/X4Ke/KIK+LrzfVo5kZFPFk/GXdYh4poi0
         5PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340960; x=1719945760;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INYs1zZMYGf3GJdIHQS7QZYH+KY4EsCuofnbdRJz94s=;
        b=gUX6aAnBBkO/QIwCsz7Y/AyoHPFvRCpj9jwK5n3icIf0p0k+L8BgbnLvCp+UW+n9xF
         DDYwkgg1gkg1/sWA4F94iP8ofNy1xZD/2MTaU7fhE+yEkEgr8x8FP6dcNML3plSQPUPf
         Ky3GEQLriP+9NgDZF2FhE6Mc7wf81ngzCh4ARWzGbGAlM+q0FbGwr30AbuR4ctOePeno
         lb7utXS3Kk36dB8C0mii35ex913ll4pQNa0L+Yw79x6IruMWhvWj9EzUWmQEMPwRJa7J
         T9fhf2XrheW4s2dCkMSwVWoZVin0loWy/lKF2XvBox2pm5YY507gLXplzKdwpRRnsTrt
         6WVg==
X-Forwarded-Encrypted: i=1; AJvYcCVNOpFgslQE6z99d+oUZtER7TPetEQaMRhSUaVh3xw8H8tNnKQokukEMhAPOUMkYocNs8KM06LWcBHiLr3DvCSdSdwq15/piBhIwZXF
X-Gm-Message-State: AOJu0YwhUwlCTOGgeIHUJIQwaTrI6E20+n0GVk6TykC7wN1HEoUsgKit
	crXwvgT+bqGfN6EPoxa9SrzwRh2JT9WxxzcIxsqcjz7CSMYm5ZGrUNW8s/BPu0xR76UHI/H+PiM
	SoyaoYg==
X-Google-Smtp-Source: AGHT+IEDJJpW7nj928BZNqsml+71dbrBWuqMhVc05Zpdb0T3rGzmmxbvKXWlJVG6rJhqASBjrqJwdX7LWTuX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:704:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e0303fce998mr332330276.9.1719340960593; Tue, 25 Jun 2024
 11:42:40 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:42:21 -0700
In-Reply-To: <20240625184224.929018-1-irogers@google.com>
Message-Id: <20240625184224.929018-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625184224.929018-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v4 4/7] perf test: Make tests its own library
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
	Nick Terrell <terrelln@fb.com>, Andrei Vagin <avagin@google.com>, Kees Cook <keescook@chromium.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the tests code its own library. This is done to avoid compiling
code twice, once for the perf tool and once for the perf python
module.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Build                    |   3 +-
 tools/perf/Makefile.perf            |  11 ++-
 tools/perf/arch/Build               |   1 +
 tools/perf/arch/arm/Build           |   2 +-
 tools/perf/arch/arm/tests/Build     |   8 +-
 tools/perf/arch/arm64/Build         |   2 +-
 tools/perf/arch/arm64/tests/Build   |   8 +-
 tools/perf/arch/powerpc/Build       |   2 +-
 tools/perf/arch/powerpc/tests/Build |   6 +-
 tools/perf/arch/x86/Build           |   4 +-
 tools/perf/arch/x86/tests/Build     |  20 ++--
 tools/perf/tests/Build              | 140 ++++++++++++++--------------
 tools/perf/tests/workloads/Build    |  12 +--
 13 files changed, 115 insertions(+), 104 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index 16ed1357202b..fddd45ab35b4 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -36,7 +36,7 @@ endif
 perf-$(CONFIG_LIBELF) += builtin-probe.o
 
 perf-y += bench/
-perf-y += tests/
+perf-test-y += tests/
 
 perf-y += perf.o
 
@@ -55,6 +55,7 @@ CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
 
 perf-y += util/
 perf-y += arch/
+perf-test-y += arch/
 perf-ui-y += ui/
 perf-y += scripts/
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 9640c6ae1837..9fa69dd0b472 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,6 +425,9 @@ endif
 
 export PERL_PATH
 
+LIBPERF_TEST_IN := $(OUTPUT)perf-test-in.o
+LIBPERF_TEST := $(OUTPUT)libperf-test.a
+
 LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
 LIBPERF_UI := $(OUTPUT)libperf-ui.a
 
@@ -435,7 +438,7 @@ PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_UI) $(LIBPMU_EVENTS)
+PERFLIBS += $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -737,6 +740,12 @@ $(LIBPMU_EVENTS_IN): FORCE prepare
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
+$(LIBPERF_TEST_IN): FORCE prepare
+	$(Q)$(MAKE) $(build)=perf-test
+
+$(LIBPERF_TEST): $(LIBPERF_TEST_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_UI_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-ui
 
diff --git a/tools/perf/arch/Build b/tools/perf/arch/Build
index 688818844c11..6dd68c17924c 100644
--- a/tools/perf/arch/Build
+++ b/tools/perf/arch/Build
@@ -1,2 +1,3 @@
 perf-y += common.o
 perf-y += $(SRCARCH)/
+perf-test-y += $(SRCARCH)/
diff --git a/tools/perf/arch/arm/Build b/tools/perf/arch/arm/Build
index 36222e64bbf7..6b4fdec52122 100644
--- a/tools/perf/arch/arm/Build
+++ b/tools/perf/arch/arm/Build
@@ -1,2 +1,2 @@
 perf-y += util/
-perf-$(CONFIG_DWARF_UNWIND) += tests/
+perf-test-$(CONFIG_DWARF_UNWIND) += tests/
diff --git a/tools/perf/arch/arm/tests/Build b/tools/perf/arch/arm/tests/Build
index bc8e97380c82..599efa545727 100644
--- a/tools/perf/arch/arm/tests/Build
+++ b/tools/perf/arch/arm/tests/Build
@@ -1,5 +1,5 @@
-perf-y += regs_load.o
-perf-y += dwarf-unwind.o
-perf-y += vectors-page.o
+perf-test-y += regs_load.o
+perf-test-y += dwarf-unwind.o
+perf-test-y += vectors-page.o
 
-perf-y += arch-tests.o
+perf-test-y += arch-tests.o
diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
index a7dd46a5b678..58b2d965ed86 100644
--- a/tools/perf/arch/arm64/Build
+++ b/tools/perf/arch/arm64/Build
@@ -1,2 +1,2 @@
 perf-y += util/
-perf-y += tests/
+perf-test-y += tests/
diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
index e337c09e7f56..d44c9de92d42 100644
--- a/tools/perf/arch/arm64/tests/Build
+++ b/tools/perf/arch/arm64/tests/Build
@@ -1,5 +1,5 @@
-perf-y += regs_load.o
-perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+perf-test-y += regs_load.o
+perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
-perf-y += arch-tests.o
-perf-y += cpuid-match.o
+perf-test-y += arch-tests.o
+perf-test-y += cpuid-match.o
diff --git a/tools/perf/arch/powerpc/Build b/tools/perf/arch/powerpc/Build
index a7dd46a5b678..58b2d965ed86 100644
--- a/tools/perf/arch/powerpc/Build
+++ b/tools/perf/arch/powerpc/Build
@@ -1,2 +1,2 @@
 perf-y += util/
-perf-y += tests/
+perf-test-y += tests/
diff --git a/tools/perf/arch/powerpc/tests/Build b/tools/perf/arch/powerpc/tests/Build
index 3526ab0af9f9..275026950645 100644
--- a/tools/perf/arch/powerpc/tests/Build
+++ b/tools/perf/arch/powerpc/tests/Build
@@ -1,4 +1,4 @@
-perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
-perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+perf-test-$(CONFIG_DWARF_UNWIND) += regs_load.o
+perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
-perf-y += arch-tests.o
+perf-test-y += arch-tests.o
diff --git a/tools/perf/arch/x86/Build b/tools/perf/arch/x86/Build
index ed37013b4289..132cf8beaca2 100644
--- a/tools/perf/arch/x86/Build
+++ b/tools/perf/arch/x86/Build
@@ -1,5 +1,5 @@
 perf-y += util/
-perf-y += tests/
+perf-test-y += tests/
 
 ifdef SHELLCHECK
   SHELL_TESTS := entry/syscalls/syscalltbl.sh
@@ -13,4 +13,4 @@ $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(TEST_LOGS)
+perf-test-y += $(TEST_LOGS)
diff --git a/tools/perf/arch/x86/tests/Build b/tools/perf/arch/x86/tests/Build
index c1e3b7d39554..3227053f3355 100644
--- a/tools/perf/arch/x86/tests/Build
+++ b/tools/perf/arch/x86/tests/Build
@@ -1,15 +1,15 @@
-perf-$(CONFIG_DWARF_UNWIND) += regs_load.o
-perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+perf-test-$(CONFIG_DWARF_UNWIND) += regs_load.o
+perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 
-perf-y += arch-tests.o
-perf-y += sample-parsing.o
-perf-y += hybrid.o
-perf-$(CONFIG_AUXTRACE) += intel-pt-test.o
+perf-test-y += arch-tests.o
+perf-test-y += sample-parsing.o
+perf-test-y += hybrid.o
+perf-test-$(CONFIG_AUXTRACE) += intel-pt-test.o
 ifeq ($(CONFIG_EXTRA_TESTS),y)
-perf-$(CONFIG_AUXTRACE) += insn-x86.o
+perf-test-$(CONFIG_AUXTRACE) += insn-x86.o
 endif
-perf-$(CONFIG_X86_64) += bp-modify.o
-perf-y += amd-ibs-via-core-pmu.o
+perf-test-$(CONFIG_X86_64) += bp-modify.o
+perf-test-y += amd-ibs-via-core-pmu.o
 
 ifdef SHELLCHECK
   SHELL_TESTS := gen-insn-x86-dat.sh
@@ -23,4 +23,4 @@ $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(TEST_LOGS)
+perf-test-y += $(TEST_LOGS)
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index c7f9d9676095..5671ee530019 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -1,82 +1,82 @@
 # SPDX-License-Identifier: GPL-2.0
 
-perf-y += builtin-test.o
-perf-y += tests-scripts.o
-perf-y += parse-events.o
-perf-y += dso-data.o
-perf-y += attr.o
-perf-y += vmlinux-kallsyms.o
-perf-$(CONFIG_LIBTRACEEVENT) += openat-syscall.o
-perf-$(CONFIG_LIBTRACEEVENT) += openat-syscall-all-cpus.o
-perf-$(CONFIG_LIBTRACEEVENT) += openat-syscall-tp-fields.o
-perf-$(CONFIG_LIBTRACEEVENT) += mmap-basic.o
-perf-y += perf-record.o
-perf-y += evsel-roundtrip-name.o
-perf-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
-perf-y += fdarray.o
-perf-y += pmu.o
-perf-y += pmu-events.o
-perf-y += hists_common.o
-perf-y += hists_link.o
-perf-y += hists_filter.o
-perf-y += hists_output.o
-perf-y += hists_cumulate.o
-perf-y += python-use.o
-perf-y += bp_signal.o
-perf-y += bp_signal_overflow.o
-perf-y += bp_account.o
-perf-y += wp.o
-perf-y += task-exit.o
-perf-y += sw-clock.o
-perf-y += mmap-thread-lookup.o
-perf-y += thread-maps-share.o
-perf-$(CONFIG_LIBTRACEEVENT) += switch-tracking.o
-perf-y += keep-tracking.o
-perf-y += code-reading.o
-perf-y += sample-parsing.o
-perf-y += parse-no-sample-id-all.o
-perf-y += kmod-path.o
-perf-y += thread-map.o
-perf-y += topology.o
-perf-y += mem.o
-perf-y += cpumap.o
-perf-y += stat.o
-perf-y += event_update.o
-perf-y += event-times.o
-perf-y += expr.o
-perf-y += backward-ring-buffer.o
-perf-y += sdt.o
-perf-y += is_printable_array.o
-perf-y += bitmap.o
-perf-y += perf-hooks.o
-perf-y += unit_number__scnprintf.o
-perf-y += mem2node.o
-perf-y += maps.o
-perf-y += time-utils-test.o
-perf-y += genelf.o
-perf-y += api-io.o
-perf-y += demangle-java-test.o
-perf-y += demangle-ocaml-test.o
-perf-y += pfm.o
-perf-y += parse-metric.o
-perf-y += pe-file-parsing.o
-perf-y += expand-cgroup.o
-perf-y += perf-time-to-tsc.o
-perf-y += dlfilter-test.o
-perf-y += sigtrap.o
-perf-y += event_groups.o
-perf-y += symbols.o
-perf-y += util.o
+perf-test-y += builtin-test.o
+perf-test-y += tests-scripts.o
+perf-test-y += parse-events.o
+perf-test-y += dso-data.o
+perf-test-y += attr.o
+perf-test-y += vmlinux-kallsyms.o
+perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall.o
+perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-all-cpus.o
+perf-test-$(CONFIG_LIBTRACEEVENT) += openat-syscall-tp-fields.o
+perf-test-$(CONFIG_LIBTRACEEVENT) += mmap-basic.o
+perf-test-y += perf-record.o
+perf-test-y += evsel-roundtrip-name.o
+perf-test-$(CONFIG_LIBTRACEEVENT) += evsel-tp-sched.o
+perf-test-y += fdarray.o
+perf-test-y += pmu.o
+perf-test-y += pmu-events.o
+perf-test-y += hists_common.o
+perf-test-y += hists_link.o
+perf-test-y += hists_filter.o
+perf-test-y += hists_output.o
+perf-test-y += hists_cumulate.o
+perf-test-y += python-use.o
+perf-test-y += bp_signal.o
+perf-test-y += bp_signal_overflow.o
+perf-test-y += bp_account.o
+perf-test-y += wp.o
+perf-test-y += task-exit.o
+perf-test-y += sw-clock.o
+perf-test-y += mmap-thread-lookup.o
+perf-test-y += thread-maps-share.o
+perf-test-$(CONFIG_LIBTRACEEVENT) += switch-tracking.o
+perf-test-y += keep-tracking.o
+perf-test-y += code-reading.o
+perf-test-y += sample-parsing.o
+perf-test-y += parse-no-sample-id-all.o
+perf-test-y += kmod-path.o
+perf-test-y += thread-map.o
+perf-test-y += topology.o
+perf-test-y += mem.o
+perf-test-y += cpumap.o
+perf-test-y += stat.o
+perf-test-y += event_update.o
+perf-test-y += event-times.o
+perf-test-y += expr.o
+perf-test-y += backward-ring-buffer.o
+perf-test-y += sdt.o
+perf-test-y += is_printable_array.o
+perf-test-y += bitmap.o
+perf-test-y += perf-hooks.o
+perf-test-y += unit_number__scnprintf.o
+perf-test-y += mem2node.o
+perf-test-y += maps.o
+perf-test-y += time-utils-test.o
+perf-test-y += genelf.o
+perf-test-y += api-io.o
+perf-test-y += demangle-java-test.o
+perf-test-y += demangle-ocaml-test.o
+perf-test-y += pfm.o
+perf-test-y += parse-metric.o
+perf-test-y += pe-file-parsing.o
+perf-test-y += expand-cgroup.o
+perf-test-y += perf-time-to-tsc.o
+perf-test-y += dlfilter-test.o
+perf-test-y += sigtrap.o
+perf-test-y += event_groups.o
+perf-test-y += symbols.o
+perf-test-y += util.o
 
 ifeq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc))
-perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+perf-test-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
 CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
 
-perf-y += workloads/
+perf-test-y += workloads/
 
 ifdef SHELLCHECK
   SHELL_TESTS := $(shell find tests/shell -executable -type f -name '*.sh')
@@ -90,4 +90,4 @@ $(OUTPUT)%.shellcheck_log: %
 	$(call rule_mkdir)
 	$(Q)$(call echo-cmd,test)shellcheck -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
 
-perf-y += $(TEST_LOGS)
+perf-test-y += $(TEST_LOGS)
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
index a1f34d5861e3..48bf0d3b0f3d 100644
--- a/tools/perf/tests/workloads/Build
+++ b/tools/perf/tests/workloads/Build
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
-perf-y += noploop.o
-perf-y += thloop.o
-perf-y += leafloop.o
-perf-y += sqrtloop.o
-perf-y += brstack.o
-perf-y += datasym.o
+perf-test-y += noploop.o
+perf-test-y += thloop.o
+perf-test-y += leafloop.o
+perf-test-y += sqrtloop.o
+perf-test-y += brstack.o
+perf-test-y += datasym.o
 
 CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
 CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
-- 
2.45.2.741.gdbec12cfda-goog


