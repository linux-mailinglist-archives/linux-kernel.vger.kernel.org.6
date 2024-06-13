Return-Path: <linux-kernel+bounces-214098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15817907F65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C0B23863
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 23:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642A2155312;
	Thu, 13 Jun 2024 23:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lb9BjgSb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A514B95B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321502; cv=none; b=m4HobeGccAF87D3bNhcsH9WG24I7FRhkzArwSQBiWzCf1wxZgarQXqevIp3/3OOjcP4hWpQuRExeGRUccqz9y0tdOkKOlAj67kV5XFN0Sxen31UH24vwdkf6ZF+UUN8koEDhvgyQOFuYx5v0/hcItRpDKV8qxy3s71f+zH7KEqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321502; c=relaxed/simple;
	bh=ABOAU2K5glRCpGOq5xujWwNgIlUPYqmruIjqw8FdZs0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=tRPSfvD+5ywyLfVKH6zmpdE2gDxtWx7q1ZodrM+nDAcdS6RyQFD6RyeiKTdW7TQHXrS4tSo6o9ZqdB7PlJ8V5ThASpQ82hcYABMgtgtdpUOq3fErlFqpw1tk3BJAWD/XU+GPki55C5XiD7Cd05pgelJliw2EQv+M8yqiNNXo6kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lb9BjgSb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dff189c7e65so264199276.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321499; x=1718926299; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bv/Fm1C1sIcT67jHqqKPUxG1mSp4iG3kEZiVQMnNilI=;
        b=lb9BjgSb3jBKObX2dp5cW/Nn5vzHwJmX3HsKeIGj2nwVaCdIPEwlvcLvBdWHrdoV28
         IoqgCuBZX6XNQ2rkZTAz4nesoDeXaoe5Qapi7NtKkxZnTchbi9l7ho7yQyJle6/hW58u
         hUz4FwlAAlROaiUHeO07VsJX2a0g7/6aS036V6bTS23lydSnomJ1wOBgMenaqVKO3xWh
         2Cw8tRSE6H33pC5sNBgMK8QRBZtqKo5ExPuj6bEB2vUa2mWnLLzYV/iOmSiiqkR6SBnM
         7Rdxnc7MsClcXH3MteVN6vVgfGoen7VBbMRNKTljEIZTFpNWHIQ/aKMdOssMA9WoG4SN
         PWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321499; x=1718926299;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bv/Fm1C1sIcT67jHqqKPUxG1mSp4iG3kEZiVQMnNilI=;
        b=fafeWQPAjiuDpG6BVL4zYcER/T8Lzw1x2VG3cxUoCbUzh7gzNuWYf0vY79Re1Jx+mh
         yRCGjWXOiWrcghulE00w4NHYOQWTzsX9MEPVfUZnWhMjTyMayJvfvVWNupS/alW1oloU
         crEozJbjwzwHCxKlHQpizpzf6o5e/A1TrehxHcMahRWemcsMAa6y5VDz3bSCKN0hkJh3
         CaSahROChHqJOS7RETGf2C6Wojju/3gmvu+knSduItIqIOf/BIMeeOss2VqsgXfkSJ9V
         Bz+nh/MD74YBJtpekcJgUaZFbKOPtMqCAnTcAlWGFkD1y9yEd19KDgkIn6ItG3jN3BrE
         hYVg==
X-Forwarded-Encrypted: i=1; AJvYcCVfiYyOIDXIHUfmr7jVG995bM4Vks+t8FWqWH5gJ+3QqYBdG2GZd7kCgbD6xp6DdQWgTeCIRw820+0rL4o4bChCRY1wDOYxmb1vzC/O
X-Gm-Message-State: AOJu0Yzi9xYsdnuHQ92RzeWLL7wjLUN70bNHy0v0RTc5ir1ghKEZ4EtW
	fmcZ7DCxE0jjEzLiTwxkeC9WB+8F9pZp5t1aa7kCZK7lxSGZat449eq1a1AlIMU6EGwXrNKugbY
	AWF9TqA==
X-Google-Smtp-Source: AGHT+IEeElc3Y5HxcuYVce8c3qaAQhtxoPOeS2i+52eehdbxjLd+idIerVIBEsPYYq9g+NtXzt+B6SE6V2RK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:2988:b0:dfa:4b20:bdaf with SMTP
 id 3f1490d57ef6-dff15470dfdmr79758276.13.1718321498506; Thu, 13 Jun 2024
 16:31:38 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:14 -0700
Message-Id: <20240613233122.3564730-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 0/8] Refactor perf python module build
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
 tools/perf/util/python.c                      | 271 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 50 files changed, 625 insertions(+), 729 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

-- 
2.45.2.627.g7a2c4fd464-goog


