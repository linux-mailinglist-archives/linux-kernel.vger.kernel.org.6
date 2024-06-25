Return-Path: <linux-kernel+bounces-229748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDA591739A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 23:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F81C21200
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 21:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482317E45D;
	Tue, 25 Jun 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l5X43YiB"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5E417D8AA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351684; cv=none; b=HEeM/Nk/qfi7/fSvO0nUtzQWxJzMvzO5rIU4gpuJ6m9UE36WfpmuGl+UZd08Jz+08w5YYraua+WB6pQXyV7SM7aKgfZyETNeinJT2Jepbrj4eQhtXcbtlYEU2TO2MiNMwQ/u8Lmd94zNTyZ0XNirme/5m8Cd5t7AYjKVSGyUdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351684; c=relaxed/simple;
	bh=mfqLJpdxWtbrpONRyXNGYHJVLRBJusHUTyGW8ZqGXds=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=p2+JRRG9vv8t/TP4YgkarOTke2P3sU+j5HkbDnBikjeZXQ+KEY226aGftf9Z/D4yU3raF3jSKlOSokCo6hRF0jDl0BEmxwnuHpB8ejIv8AKgeXr30AqjrS4T++2kn5KOyKyErNzwySDGtrpuFPuGJ8dYA7Z6PNUjs9a2XvRv+eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l5X43YiB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63548741556so110010157b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719351681; x=1719956481; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pB20YctkByMbfeEqJS5b21c7qXK0FPZDELOAznW8QUg=;
        b=l5X43YiB+O598xsAqHeGiabTq6EBKWmE2d0pFcRw9R6Ktjx1Wpq6PQRTfgporYsKD4
         vPXzQ0BcP1bFlDMnJEaRSAku7iwNZsmvwsB38VFbOaL9UhXssmMn0O479aSc6x057IlZ
         vRznrIEjmeCACqQCYO8xtx/HCWZQUoyQ0KGMN8AV21nJS/EhXLuESjfWmzAqwoNqdA9H
         F53flAkPm9leo0r08bLMfAniJofbKs3CbrTfaU1UTLzd7XRYIBhEqJcvlaXgd1cvfkOc
         v/h0I94jS9lP5oK9duV8pEJrRu6PXrauu9Q8orpWRLpjLOypwLzoH9jfpNtqCjpstzSG
         dtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719351681; x=1719956481;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pB20YctkByMbfeEqJS5b21c7qXK0FPZDELOAznW8QUg=;
        b=Qb6YOYFOYBg9eWV31T5m6meCOymaBUDvl6GAV3vSfxSQXt7Mpbs1Ii4GMUz/8kFo/p
         IGjrhKf0s1wt6wPcrWAPvtgGTb1ojz2lY25YGChnSjH8puDHFFY3UOYww+ohQ3UyAaAk
         Nb/vPmu/WM8t3UGkDalpHZ0DFx03vlnlf9YFJdIXLTxQCC+zYzJ6ifoRdJABfkiCB5Mw
         ztWiyX4Z6dpWS4YLebS/fh39EnqY+dGL6L670c/X5JRVUEv3ilAcpEqXiqMW+bcOwG7F
         MQ3OSICjk6nrDQap0RFfCIA+l/l8QbDhOxVy89F3jVnVej0AHZ52IlqTHlytPpSyAXvC
         TzTg==
X-Forwarded-Encrypted: i=1; AJvYcCXkr6PvlWVLDrfQtQXcQIJ3BHx7Tau3l+5V6e1F/oPcf1hKAOoCTnYXqvpDSHD65ioMFZjsxIsBSUCNXO+VqrIKbEMaiOPHWlnnQF09
X-Gm-Message-State: AOJu0Yx4GG5f3J2ciED/t+xYBxdLcFAaj3Uvk/9+L2ZV71bbkxCFr+FD
	QAXFIc1duAU/s34WDSJz8i+VMb3CGXqTwDEZTsp6s7LsyL/cx/yaLMvOG+Yei72N/l/4B/JgvAX
	LiszayQ==
X-Google-Smtp-Source: AGHT+IEm5+4Z5pme1l/QEMTgpR1uFk8cJ0f8ej6scwGggGs2QmMoz+HvN8CRlVBUyHSmiR719nZFZ1fB2KaU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:690c:f0b:b0:61b:e524:f91a with SMTP id
 00721157ae682-64341c235b3mr1640907b3.10.1719351680839; Tue, 25 Jun 2024
 14:41:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 14:41:09 -0700
Message-Id: <20240625214117.953777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v5 0/8] Refactor perf python module build
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

Refactor the perf python module build to instead of building C files
it links libraries. To support this make static libraries for tests,
ui, util and pmu-events. Doing this allows fewer functions to be
stubbed out, importantly parse_events is no longer stubbed out which
will improve the ability to work with heterogeneous cores.

By not building .c files for the python module and for the build of
perf, this should also help build times.

Patch 1 adds '*.a' cleanup to the clean target.

Patches 2 to 6 add static libraries for existing parts of the perf
build.

Patch 7 adds the python build using libraries rather than C source
files.

Patch 8 cleans up the python dependencies and removes the no longer
needed python-ext-sources.

v5: Resend with missing patch 8.
v4: Rebase past conflict with commit eae7044b67a6 ("perf hist: Honor
    symbol_conf.skip_empty") - fixes like this commit won't be
    necessary after these changes. Swap a tab for spaces for better
    consistency.
v3: Add missed xtensa directory for the util build. Remove adding the
    arch directory to perf-y as it creates an empty object file that
    breaks with GCC and LTO.
v2: Add '*.a' cleanup to clean target. Add reviewed-by James Clark.

Ian Rogers (8):
  perf build: Add '*.a' to clean targets
  perf ui: Make ui its own library
  perf pmu-events: Make pmu-events a library
  perf test: Make tests its own library
  perf bench: Make bench its own library
  perf util: Make util its own library
  perf python: Switch module to linking libraries from building source
  perf python: Clean up build dependencies

 tools/perf/Build                              |  14 +-
 tools/perf/Makefile.config                    |   5 +
 tools/perf/Makefile.perf                      |  83 +++-
 tools/perf/arch/Build                         |   5 +-
 tools/perf/arch/arm/Build                     |   4 +-
 tools/perf/arch/arm/tests/Build               |   8 +-
 tools/perf/arch/arm/util/Build                |  10 +-
 tools/perf/arch/arm64/Build                   |   4 +-
 tools/perf/arch/arm64/tests/Build             |   8 +-
 tools/perf/arch/arm64/util/Build              |  20 +-
 tools/perf/arch/csky/Build                    |   2 +-
 tools/perf/arch/csky/util/Build               |   6 +-
 tools/perf/arch/loongarch/Build               |   2 +-
 tools/perf/arch/loongarch/util/Build          |   8 +-
 tools/perf/arch/mips/Build                    |   2 +-
 tools/perf/arch/mips/util/Build               |   6 +-
 tools/perf/arch/powerpc/Build                 |   4 +-
 tools/perf/arch/powerpc/tests/Build           |   6 +-
 tools/perf/arch/powerpc/util/Build            |  24 +-
 tools/perf/arch/riscv/Build                   |   2 +-
 tools/perf/arch/riscv/util/Build              |   8 +-
 tools/perf/arch/s390/Build                    |   2 +-
 tools/perf/arch/s390/util/Build               |  16 +-
 tools/perf/arch/sh/Build                      |   2 +-
 tools/perf/arch/sh/util/Build                 |   2 +-
 tools/perf/arch/sparc/Build                   |   2 +-
 tools/perf/arch/sparc/util/Build              |   2 +-
 tools/perf/arch/x86/Build                     |   6 +-
 tools/perf/arch/x86/tests/Build               |  20 +-
 tools/perf/arch/x86/util/Build                |  42 +-
 tools/perf/arch/xtensa/Build                  |   2 +-
 tools/perf/bench/Build                        |  46 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/tests/Build                        | 140 +++----
 tools/perf/tests/workloads/Build              |  12 +-
 tools/perf/ui/Build                           |  18 +-
 tools/perf/ui/browsers/Build                  |  14 +-
 tools/perf/ui/tui/Build                       |   8 +-
 tools/perf/util/Build                         | 394 +++++++++---------
 tools/perf/util/arm-spe-decoder/Build         |   2 +-
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   2 +-
 tools/perf/util/perf-regs-arch/Build          |  18 +-
 tools/perf/util/python-ext-sources            |  53 ---
 tools/perf/util/python.c                      | 274 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 50 files changed, 625 insertions(+), 732 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

-- 
2.45.2.741.gdbec12cfda-goog


