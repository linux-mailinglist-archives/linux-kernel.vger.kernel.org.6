Return-Path: <linux-kernel+bounces-229753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9762491739F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477C2284C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8AA17E44D;
	Tue, 25 Jun 2024 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/5U2QH0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A717E45D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351696; cv=none; b=YdjyrrRCwqrOm1XIPHOD8/oQHpB5nRVfulzbcG6rgL555bRWzqP7idnPQLsQ4sZ96a83uHwlYQOWOyYfVMC4d6LPAf7KzYg+1hYwTqVO0F5MhZX0SSwucFxs5g5GoLqjTskqb8DEjCisZa/IfW6M+IDV1FBBMLB4uRZvUR9F9rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351696; c=relaxed/simple;
	bh=2e1EB2J3C8Egr2O0Wpv7tQqwFPOyq60QZb+RTxrA24g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ef/r/YhOGZCs58nxTUH172gJIzCz6tLML8veqGIaWpL59WMkv0RthgjEcKc9pkU7/JHgR4Z4t4M9ayKQ3bRbTX3JDW0kghYiMOhYaPB48o7esUbHdnpIhDZb0leoHMZjKcPDRbAMx9X0cPPTxrPXEJxDY78Vy5oRP9s3Ggx5sB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d/5U2QH0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff1bcbc104so10668189276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351692; x=1719956492; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9lVzQaHUCF35to8PiObGttFlDy1f8wM6DLCbP51DQFE=;
        b=d/5U2QH0s68BbLlEo3cWpzspU1e7UsfjnpjzxYu3hbBRYIcao9TOGHzTzhZd5VbRMO
         70fZhUmoO1ZDhIbitGONq/X7gUoeFSXbiHV6aF5+UaU3Dy5/R5zDDHSRa4jmxkNMcDTZ
         PLl0GNht+XBPp2E8OF/tJyPDd7SoaabhGWl/a/LoDNpx4qmAU4Gu0VnXb4SM/OPdM4UI
         byJjGheZxepc6/ERhvAfBu9RPMNwKUBiX6jYC/fKD/25hehGfntZao+U7PBs4bp4AVpK
         pPyIbh1u0pDOic8ZFO+p4bSW88bNxyKixKaLkXu/Wo+GXTb6PypBSjqPQTxsm5f53eFu
         uOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351692; x=1719956492;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9lVzQaHUCF35to8PiObGttFlDy1f8wM6DLCbP51DQFE=;
        b=sgipFHa7Twnc+R3RAyZGE4VwNWJgpxpgXc8Q6ugqFB5W2jafusu8uH88l2CNpQko6v
         4XUp1b07nj/dHIaJq6/GQ/h6QW6lFqL9Bbjtf6vg346XzJ0nATb7IfaZf5JR5KxP2FI9
         bwi/hhO7WbIaCCGPBSQq2scg7YlF3KzTw/zHINA5QxNwhriBQNweLRLaVz5QRyDyokvD
         y2SNINq7TRsox1fkMOboGnIGzvUGH80ewyBfjU8UtDen5e2UABC8POBqhfsC+JZkQp57
         OUvICKc1Blb8XiK9Anfq4/6Qwi0N/EepcU5C0UcJvxBzLp+kH+O4yCj3WRNqqCzFMaew
         NUFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMHTulrlegYn9za+qwkWjWgq4BL0QdgZKJre/QOXz+Y7gQyOv4og91dZlKw19o3WHir+4tuWYMK5PI6EWrmS60Rcc/dMBqkWbhaATk
X-Gm-Message-State: AOJu0Yz+U/2PVf+xjZgELjoHQVClLiV9k5beWcybyZ8q7lM8jtHpZ7HI
	caSKLUDruInpXtve8FEv1EUI8mfDmXa3LxjwMf3bFIIY0GWVTZs2XWcK1vxgc8p4WfU852w6vrT
	mtVRVrw==
X-Google-Smtp-Source: AGHT+IEiqktqsRHMAN+mYvz7yr2VH/m55HbJlU/tORttvOZe5uxuQ/oF1k+fWMSXhb65BLgrCgHSbD9oWZSr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:20c5:b0:e03:2f91:b936 with SMTP
 id 3f1490d57ef6-e032f91babbmr10517276.10.1719351692199; Tue, 25 Jun 2024
 14:41:32 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:14 -0700
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
Message-Id: <20240625214117.953777-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625214117.953777-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 5/8] perf bench: Make bench its own library
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

Make the benchmark code into a library so it may be linked against
things like the python module to avoid compiling code twice.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
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
index 9fa69dd0b472..4a3c000b9845 100644
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
2.45.2.741.gdbec12cfda-goog


