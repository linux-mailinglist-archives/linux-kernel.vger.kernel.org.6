Return-Path: <linux-kernel+bounces-229521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5409E91706A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C877B1F21F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC24817C9F4;
	Tue, 25 Jun 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYwFQfrY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E94417C7D3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340953; cv=none; b=QcrS/+EQAvmw6D6TXyJ5WTdjTg9qDuhVya9Xohv45zKdaeErWHax8qGwGzVjGu5qH0dZVSVOg7vU8nd5yODrC5PY4zd18AErQoYlx04fb4w8rIOs4okBOm1EgTybYjflsKwK6bUoJnJMLMAiaCc4B8gKP3SReuksukcVZmFtYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340953; c=relaxed/simple;
	bh=uRakYP9YwtSrkRypd0sus0mo63iXTbShYivQP4vojDY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=XPi0y6whIrR+Zhfui3XpddF9kwYd/xbuuisjLFRWPCuUK1wYEM9muXczFBUBi+yC3XVeuZUrGiDVfDkVJU+mSiKjifOm9wknoBAbjuXE3by4Dm1mQkXE5xwhtEoOA5ITmulceGhGZcFsC91p36TQ6sArh+4WlRt1IRhJkOlJS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYwFQfrY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b7adfb95so13151197276.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719340951; x=1719945751; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eTeAroXO/wxI5kEA8VbI1l6499SWylVFeT71mGO4Lpo=;
        b=UYwFQfrYws0+D2MvOckrNyr3sHMZwDDUw25Og0reG7qDZRKstQd+k4Vt/v1XLE5bBp
         X/BcHdmwqVF7ya9rh/9o3OTgvdm8M+db1G48MGi80DJaDLS7XVvfzSWRCjkW4Yp6NtrZ
         z8jRI6jBda9iA2Fu7CasOMWMLXBL6lqRxbG+G9LyaIjkcgSSiruyd1kb/BWGnY0FF0Dr
         933ZYALLub86KlGmYQASH1QoXkTGgk2mbDghvDlPkimTt7Rj9DGX4qmozdc0uwl8o4j+
         +t6Q5StjkeMf9UluSapnLmJIPBNwg7OHgl9nyxJd+eSrfLj+f4e/Uw79ltvLwQN/BA8i
         0GTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340951; x=1719945751;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eTeAroXO/wxI5kEA8VbI1l6499SWylVFeT71mGO4Lpo=;
        b=Yo4zz3c36c2i0g2KVOA5qFMetJJGmkAXnyl7I36iACnq4VtgQj5m+27gfE/OiygvK8
         RUZGvH1Hz8XfVJbOsLh6Tm4WLdtgBDmFnykFqqKbZ6ioDgd90RmHy60RDVFJdKpBvbtU
         gsp+dRjPwQDpahnMzOB53aDnaDV1xMEF71KOGIeVLJs8fwkvCn+4Qc/nYUuB0BzZw2DU
         P9tA3m5Afbsbtd2xws1CpNXqA/qRQD8fgsNY4LBYEsJZ5BwdHSQBNgvdggCSxJQUGVAi
         22izCj1n3gkDR0SDmUoRJk1Bk+D6ur1nBSMPMiAMcHWXXVIJnfcrcdDdTb8l5hgsmlFf
         mkBA==
X-Forwarded-Encrypted: i=1; AJvYcCW9qNwkv2RS2jcd+0xH6NOgbqZhyZGz99qHx4DHKmI2mDu+92+Xy3mUBx4lrXSPrMFPuOzLOJRxuZmvzqkMdgo1/0CeN8KKSSK4dcjU
X-Gm-Message-State: AOJu0Yw71SvSMfkuHAuIbQWo/vcFpiSubq7/aMuEqv2rXR2yaLTTdF21
	Ma63PnMJIx48lbPJUB/hNBkPrzw3wTvti6z294Ap07d8hmjDS9jcLIWSu1+qQlvlcqfz0VdT2o1
	9ZN3gcg==
X-Google-Smtp-Source: AGHT+IFyZ7kXRo1fobxWOpR60+105e2CUJB1svUXS6WY+BeDAegQYQ5D1PdonDyHNqGhZMEWQteOMSmoioOM
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:1208:b0:dfa:59bc:8857 with SMTP
 id 3f1490d57ef6-e03040ff7bamr193288276.9.1719340951339; Tue, 25 Jun 2024
 11:42:31 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:42:17 -0700
Message-Id: <20240625184224.929018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v4 0/7] Refactor perf python module build
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

v4: Rebase past conflict with commit eae7044b67a6 ("perf hist: Honor
    symbol_conf.skip_empty") - fixes like this commit won't be
    necessary after these changes. Swap a tab for spaces for better
    consistency.
v3: Add missed xtensa directory for the util build. Remove adding the
    arch directory to perf-y as it creates an empty object file that
    breaks with GCC and LTO.
v2: Add '*.a' cleanup to clean target. Add reviewed-by James Clark.

Ian Rogers (7):
  perf build: Add '*.a' to clean targets
  perf ui: Make ui its own library
  perf pmu-events: Make pmu-events a library
  perf test: Make tests its own library
  perf bench: Make bench its own library
  perf util: Make util its own library
  perf python: Switch module to linking libraries from building source

 tools/perf/Build                              |  14 +-
 tools/perf/Makefile.config                    |   5 +
 tools/perf/Makefile.perf                      |  75 +++-
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
 tools/perf/util/python.c                      | 274 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 49 files changed, 625 insertions(+), 671 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


