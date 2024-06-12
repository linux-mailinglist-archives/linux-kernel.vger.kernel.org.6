Return-Path: <linux-kernel+bounces-212089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8518F905B19
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915F61C2253D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1D884A36;
	Wed, 12 Jun 2024 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBAfei2k"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A3823AC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217220; cv=none; b=YjnSUWX0RqMzmAESvzeJOcnv05OLVhIbq0kKVtNkslg4dgx8+HIw3S5JRj9VTVZVc/xjml4ZwQB53dud6HT2VrIZj8x8/HuUNFHpZEXhEJo9Igqz41DWWcpBaNnuXpxtY1ilgIEPnsjzGwTtSgOCuc6lH4Hy7425rFZzoSw4f+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217220; c=relaxed/simple;
	bh=GW3F5bRDidIfzFfzx2XH9TZgHygHBWW2YgjI9x1i9kA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=stpJkg0vAk80CV7KzdeChmWk9TdgioYShhS1fGbYGz4zHhrHYOQB/24GV/QXMWhiAAVyCSC8X4j6rZjjrEup+vl4khD0FxRIlYXMvzoszFIjsi+IgvJ+EsWGqvUPMCsXmT9yUUucLE9yVMWf6mUxLu4a9rf8aB1emzK7S2hURCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wBAfei2k; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfdddb9b425so244674276.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217216; x=1718822016; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hxFca2akLEi/c6aeiWryG3twAj/x8mJ+5CcLXE4nJMw=;
        b=wBAfei2kL1ZcoeHo2BHZAsPPT1zDP5xxnU6YYpceSEzBFi7SBKeExgVLw0n+LAhgqL
         ekC+59Nvwt5+iMo05pAagN5j5k+BkZQqUiH1hUcfyLxpi8QTPTSTuzemGfa4/8kdV/2D
         /21CWctfBEE1zX6ZTbrg/p9pSmGE7LozNvRQg7Kr0WMCep7AWEsnYk6vwwubXp2ft1CF
         ORBSVxUQIo0qYo9tLnVDk2NMJuksDau5vpMvBmbh08RNRId1YVUbmaW2rLdlTeJEUhpB
         8DXegtwm1hB2qCQXlbjiwdIANggpt0Fx0YrTb8X660HCXQvz6W2k/j3yHoqEI8bE8nCt
         /6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217216; x=1718822016;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxFca2akLEi/c6aeiWryG3twAj/x8mJ+5CcLXE4nJMw=;
        b=FHQTshzgrmPwU5bb/h0+fVifqhYrALYx1lUfHWVU5xALJthiAb4OqCOInpuUeDumHN
         Cp9HiCMyxRLwTYyYHKWb2ntkHz1J6CHjMxyNsj4KDHBTgxZ4YxiIeHG5uR1piKBzWuCw
         +eeQV0EXPofW8nkmEDluI6CqkjwP8Zl2Xjx+EHu2Wc88GbuItP6sbwddBhQ5KfFnl8F+
         Sn/DDaVinBV0jyUQy+E1WDQ2fLVVvo4oyjjlmlgssIxN4gQdDZjhsTnGnJSlljWgYxtL
         TrLtO6VOBIBMAgNOC/zMHy3x9jRDkyatdn6oTpgqYPJWAXXahKpMMOy/Jjkj/G6rfWXO
         kEMA==
X-Forwarded-Encrypted: i=1; AJvYcCUiqb498gximWiUHaojTuJ73JLmqKGXB/fK8pzf0or/z2zO14QP5WCJ1lxvfglE6tYBNv+NloplkuB0GGLNfSAFvyFItu2wOaHWFVOc
X-Gm-Message-State: AOJu0Yz8BNmpLxx7FkAaevR84HsCum9dUhA/w/bjP+I2APkRg0GhJsBZ
	vaTv1g31nCWRIe5JYZxIQ86rcMoijRgfpHLlo0axcJRvQLDH6ihUuTonyEm/GZC54cQuCigzYhB
	IFqCfCg==
X-Google-Smtp-Source: AGHT+IHHEhm3YqNyXbkwlJqf7zAbA10K5YtztZ12tlPf+OX1TpaElO1uBuwFIrHE76zPeVUQ691ENdAPSP7k
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:959d:4302:db0e:d12a])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b03:b0:dda:c57c:b69b with SMTP
 id 3f1490d57ef6-dfe62f13456mr822488276.0.1718217216102; Wed, 12 Jun 2024
 11:33:36 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:32:02 -0700
In-Reply-To: <20240612183205.3120248-1-irogers@google.com>
Message-Id: <20240612183205.3120248-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612183205.3120248-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1 4/7] perf bench: Make bench its own library
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

Make the benchmark code into a library so it may be linked against
things like the python module to avoid compiling code twice.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Build         |  4 ++--
 tools/perf/Makefile.perf | 11 +++++++++-
 tools/perf/bench/Build   | 46 ++++++++++++++++++++--------------------
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/tools/perf/Build b/tools/perf/Build
index fddd45ab35b4..2787f5630ff7 100644
--- a/tools/perf/Build
+++ b/tools/perf/Build
@@ -1,4 +1,4 @@
-perf-y += builtin-bench.o
+perf-bench-y += builtin-bench.o
 perf-y += builtin-annotate.o
 perf-y += builtin-config.o
 perf-y += builtin-diff.o
@@ -35,7 +35,7 @@ endif
 
 perf-$(CONFIG_LIBELF) += builtin-probe.o
 
-perf-y += bench/
+perf-bench-y += bench/
 perf-test-y += tests/
 
 perf-y += perf.o
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index ecf0586e9061..f9709718cb83 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -425,6 +425,9 @@ endif
 
 export PERL_PATH
 
+LIBPERF_BENCH_IN := $(OUTPUT)perf-bench-in.o
+LIBPERF_BENCH := $(OUTPUT)libperf-bench.a
+
 LIBPERF_TEST_IN := $(OUTPUT)perf-test-in.o
 LIBPERF_TEST := $(OUTPUT)libperf-test.a
 
@@ -438,7 +441,7 @@ PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPMU_EVENTS)
+PERFLIBS += $(LIBPERF_BENCH) $(LIBPERF_TEST) $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -740,6 +743,12 @@ $(LIBPMU_EVENTS_IN): FORCE prepare
 $(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
+$(LIBPERF_BENCH_IN): FORCE prepare
+	$(Q)$(MAKE) $(build)=perf-bench
+
+$(LIBPERF_BENCH): $(LIBPERF_BENCH_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_TEST_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-test
 
diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
index c2ab30907ae7..279ab2ab4abe 100644
--- a/tools/perf/bench/Build
+++ b/tools/perf/bench/Build
@@ -1,25 +1,25 @@
-perf-y += sched-messaging.o
-perf-y += sched-pipe.o
-perf-y += sched-seccomp-notify.o
-perf-y += syscall.o
-perf-y += mem-functions.o
-perf-y += futex-hash.o
-perf-y += futex-wake.o
-perf-y += futex-wake-parallel.o
-perf-y += futex-requeue.o
-perf-y += futex-lock-pi.o
-perf-y += epoll-wait.o
-perf-y += epoll-ctl.o
-perf-y += synthesize.o
-perf-y += kallsyms-parse.o
-perf-y += find-bit-bench.o
-perf-y += inject-buildid.o
-perf-y += evlist-open-close.o
-perf-y += breakpoint.o
-perf-y += pmu-scan.o
-perf-y += uprobe.o
+perf-bench-y += sched-messaging.o
+perf-bench-y += sched-pipe.o
+perf-bench-y += sched-seccomp-notify.o
+perf-bench-y += syscall.o
+perf-bench-y += mem-functions.o
+perf-bench-y += futex-hash.o
+perf-bench-y += futex-wake.o
+perf-bench-y += futex-wake-parallel.o
+perf-bench-y += futex-requeue.o
+perf-bench-y += futex-lock-pi.o
+perf-bench-y += epoll-wait.o
+perf-bench-y += epoll-ctl.o
+perf-bench-y += synthesize.o
+perf-bench-y += kallsyms-parse.o
+perf-bench-y += find-bit-bench.o
+perf-bench-y += inject-buildid.o
+perf-bench-y += evlist-open-close.o
+perf-bench-y += breakpoint.o
+perf-bench-y += pmu-scan.o
+perf-bench-y += uprobe.o
 
-perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
-perf-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
+perf-bench-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
+perf-bench-$(CONFIG_X86_64) += mem-memset-x86-64-asm.o
 
-perf-$(CONFIG_NUMA) += numa.o
+perf-bench-$(CONFIG_NUMA) += numa.o
-- 
2.45.2.505.gda0bf45e8d-goog


