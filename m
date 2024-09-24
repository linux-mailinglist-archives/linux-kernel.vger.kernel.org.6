Return-Path: <linux-kernel+bounces-337354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EADF5984908
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A042842AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F21154C0E;
	Tue, 24 Sep 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7W7zurV"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD09B1AB6D4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193885; cv=none; b=T1sQjSxplEHkfeIISB6Utq5oW+zYC5GLDbeN/aypvLUrYKoR2hpRACDUR6XOMbzXkk3lBh09lo2KSeeLXym3Actd/N2DjphUg6l0gqNrUBeZ2eoKb8woUIGdte+QR0a6KAbMoHw/gues9D4QgJN5Azyc6ZzUIJKBBVnwVJc5jFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193885; c=relaxed/simple;
	bh=uSZ19GQ1p4PBnKD+usp9BZ00z/UV7CE3cZ8oyYjEH8A=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=c22rtChvLAyHB0U78S7gfYX0zofDF0msQjhmF2OVcAYatZ7M4W1EImvk0zHBAAFRoLMFQS2k1ROAtqrPOxDe+W/R3ZhQi3gH23/tERt9dlrCrMdQhA23unQhTnqQqDBHx7wBsAY7A//p80uKiFyd7f88Sp6QZHvlWj3OygFk+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7W7zurV; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24b43799e9so35002276.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193883; x=1727798683; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pzN2UYCIB2Gfh1fGko5XGPwSmAf2oKNcjbSSWwvSW94=;
        b=A7W7zurVCoDv9NLEBmedJJEcZiBp/yxeKXtS6nG76MxaVi/jsEfk5l6uHM/iC36KEt
         qYxct9m44m2KGP6JPSr6Ij5Z+nD4Gz8SZnMK4QgOGk3Oa6926oGD223CAHJi7QwhFtQA
         jVQCHv9+XfNhPWHH9E/0+RRuQh4VZAp3+A3AtG1/XxWT7kRb+GgIBA82ZXebqTxpMBZI
         AilPbmNvePcTQ3wvrBmv9+ae8JwQMvo6vaHlb4iP516MlqnEIbG7Ivj4UU5EByrtVoVO
         ZK5AaYXfXhRRDQnRtuT4SEOWkgq/GSkCC6LgWwRH1n++7GpTCzOrxpNP6wdiiCPqcmIA
         0SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193883; x=1727798683;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzN2UYCIB2Gfh1fGko5XGPwSmAf2oKNcjbSSWwvSW94=;
        b=IWJtxLCr/V0HjNfwrco+3Byavych+4kKHSc6Fjt37gQcPTiMUKPYHI6tLYyfDM4E4v
         KSp5d1ARuo6ouIB80odwebVHmFBcWFaX/Hx75KOs6ACSNT8TtpJvKi2biesBejKRGUGn
         CueZzaqlK8M/W899dSoMw48BS+uHb+Q9l/HUlVXpZ6lb8v5GlgshsuDhYPB2ACSrA9MV
         xU8f74erAJPhJjqm96jZAZpd8EMAXugaHJgjKh8JYZyqBze2CuFylw6O76qmoy4ZNsKp
         iQX3PvTJOFW7OXfMCidpEG7QsWE6kga7QW+b4cqxz5ji3kcLpiBKAfRhqBZ3xPIeooE1
         z5TA==
X-Forwarded-Encrypted: i=1; AJvYcCV2xFKL+/cHGlrQdVNxyo/61uYiIvMGN8HauOqoJTMZJ2FB4LF+dN9DJcZf7B9TAUDBHHycId+tWcE8GnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1IQmGRmULE0CdgpWIMQv+9qUfUPsLoD8VMa4mOtel8p5Kj02
	FahNyqqi8FM7zl9dPN9KHEsKhMar5nQKm1YN++cbazUU1YC1F8d4nBr7vI76YdHGM1+HbLstrXh
	gcI8uUA==
X-Google-Smtp-Source: AGHT+IFH8yeY/B+IwoWda5Df5cvx/Y22S04rGnRLgULCM/6qvByJqucvwl/Uc+inT+AJ8Z0lA7b/kDjztB4I
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a25:ac66:0:b0:e24:a00a:518e with SMTP id
 3f1490d57ef6-e24a00a538fmr2173276.7.1727193882513; Tue, 24 Sep 2024 09:04:42
 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:07 -0700
Message-Id: <20240924160418.1391100-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 00/11] Libdw/dwarf build clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

There patches are on top of:
https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
where it was pointed out that a lot of the libdw conditional
compilation was due to features that have now been standard for 10 or
15 years. The patches remove the conditional compilation assuming the
features are in libdw where the feature test is expanded to check
there pressence.

In the Makefile code dwarf tends to mean unwind or libdw support for
dwarf things. To make it clearer when dwarf really just means libdw
numerous build variables and defines are renamed.

There is some tech debt in the changes as perf check still reports the
values using the old name and for features that are no longer tested.

Ian Rogers (11):
  perf build: Rename NO_DWARF to NO_LIBDW
  perf build: Remove defined but never used variable
  perf build: Rename test-dwarf to test-libdw
  perf build: Combine libdw-dwarf-unwind into libdw feature tests
  perf build: Combine test-dwarf-getlocations into test-libdw
  perf build: Combine test-dwarf-getcfi into test-libdw
  perf probe: Move elfutils support check to libdw check
  perf libdw: Remove unnecessary defines
  perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
  perf build: Rename CONFIG_DWARF to CONFIG_LIBDW
  perf build: Rename PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS

 tools/build/Makefile.feature                  | 11 +---
 tools/build/feature/Makefile                  | 24 ++------
 tools/build/feature/test-all.c                | 16 +-----
 tools/build/feature/test-dwarf.c              | 11 ----
 tools/build/feature/test-dwarf_getcfi.c       |  9 ---
 tools/build/feature/test-dwarf_getlocations.c | 13 -----
 tools/build/feature/test-libdw-dwarf-unwind.c | 14 -----
 tools/build/feature/test-libdw.c              | 56 ++++++++++++++++++
 tools/perf/Documentation/perf-check.txt       |  6 +-
 tools/perf/Makefile.config                    | 57 ++++++-------------
 tools/perf/Makefile.perf                      |  2 +-
 tools/perf/arch/arm/Makefile                  |  4 +-
 tools/perf/arch/arm/util/Build                |  2 +-
 tools/perf/arch/arm64/Makefile                |  4 +-
 tools/perf/arch/arm64/util/Build              |  2 +-
 tools/perf/arch/csky/Makefile                 |  4 +-
 tools/perf/arch/csky/util/Build               |  2 +-
 tools/perf/arch/loongarch/Makefile            |  4 +-
 tools/perf/arch/loongarch/util/Build          |  2 +-
 tools/perf/arch/mips/Makefile                 |  4 +-
 tools/perf/arch/mips/util/Build               |  2 +-
 tools/perf/arch/powerpc/Makefile              |  4 +-
 .../perf/arch/powerpc/annotate/instructions.c |  4 +-
 tools/perf/arch/powerpc/util/Build            |  4 +-
 tools/perf/arch/riscv/Makefile                |  4 +-
 tools/perf/arch/riscv/util/Build              |  2 +-
 tools/perf/arch/s390/Makefile                 |  4 +-
 tools/perf/arch/s390/util/Build               |  2 +-
 tools/perf/arch/sh/Makefile                   |  4 +-
 tools/perf/arch/sh/util/Build                 |  2 +-
 tools/perf/arch/sparc/Makefile                |  4 +-
 tools/perf/arch/sparc/util/Build              |  2 +-
 tools/perf/arch/x86/Makefile                  |  4 +-
 tools/perf/arch/x86/annotate/instructions.c   |  2 +-
 tools/perf/arch/x86/util/Build                |  2 +-
 tools/perf/arch/xtensa/Makefile               |  4 +-
 tools/perf/arch/xtensa/util/Build             |  2 +-
 tools/perf/builtin-annotate.c                 |  2 +-
 tools/perf/builtin-check.c                    |  6 +-
 tools/perf/builtin-probe.c                    | 14 ++---
 tools/perf/builtin-report.c                   |  4 +-
 tools/perf/util/Build                         | 12 ++--
 tools/perf/util/annotate-data.h               |  8 +--
 tools/perf/util/debuginfo.h                   |  6 +-
 tools/perf/util/disasm.c                      |  4 +-
 tools/perf/util/disasm.h                      |  4 +-
 tools/perf/util/dwarf-aux.c                   |  6 --
 tools/perf/util/dwarf-aux.h                   | 54 ------------------
 tools/perf/util/genelf.c                      |  4 +-
 tools/perf/util/genelf.h                      |  2 +-
 tools/perf/util/include/dwarf-regs.h          |  6 +-
 tools/perf/util/probe-event.c                 |  4 +-
 tools/perf/util/probe-finder.c                |  6 --
 tools/perf/util/probe-finder.h                |  6 +-
 54 files changed, 168 insertions(+), 279 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf.c
 delete mode 100644 tools/build/feature/test-dwarf_getcfi.c
 delete mode 100644 tools/build/feature/test-dwarf_getlocations.c
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c
 create mode 100644 tools/build/feature/test-libdw.c

-- 
2.46.0.792.g87dc391469-goog


