Return-Path: <linux-kernel+bounces-368946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD80C9A16ED
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BCB1C2204B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0F44A0F;
	Thu, 17 Oct 2024 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j594cU7g"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5623A6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124729; cv=none; b=NnPd8QFk8CuUnyawFBMahWsPfMVb7m7Ul1CEPPWn/XloS2zlAoKuud4c30PW5xAbtlMY/fBeXTnW3cSYKquK9Y0wE0C1Sd5DzPfCJa4OBoJNLVtBl1yvu9xWlYN2gFHeSAPd6Ak3y8QQAyIG3cscVQkxBZSya3ZSie1mEdEslx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124729; c=relaxed/simple;
	bh=rWGtnLl1arxCDHU3ybrEX26z/6hreqHLWTvxIM8Zohc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=A59mrMiECfFG+Ybn74j78/uv0oHM+3P8IG/YHL9GA6M9SXobdQi350ztsiuR6WLmm2Cqm/MH53CFGalt+WnBQ36q+sxEMKHkcCYWjULDrm+ovGUZ1pGDoUGrKKYXFjTZNp1um6kQVlUDayEwf6V8ko2LQnTf47hYHcOZ48qvyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j594cU7g; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28ef71f0d8so755889276.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124727; x=1729729527; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MVEopwQelkynI+vONSt1eNqCP+P10MdFmkRWcj813Q=;
        b=j594cU7g8g2HJBX0DKMeMeSyN29q6rs1QRvT8Nf1hlbHehsQuk4bbIZFzwf1R53DXY
         RrI5oBuQUX5jRzgCn2ITr3mrpEALRgxPyyCc3oLJ0Bb4G2dzBeTTjr6qCnnP33qc2wAG
         gRLbDIAQmHcvKURxEbevfnVC9dF63MtijlHB9C5j6Q+obI1Jd1Oivq+mk+DRIXZD0OSf
         omQ4u0ZuKUqtV1wXNrSBfWbQctKWZIaHgHMwM00nXbU25AHQMWs3mheIhhojnddBYpKq
         /zZRZhzQiVDARB40ykauvmN3jrDJNpoikePGE1m7kQ80b31kJDYSWYho61Cf0p1ogEfV
         PBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124727; x=1729729527;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MVEopwQelkynI+vONSt1eNqCP+P10MdFmkRWcj813Q=;
        b=WbSNhzUHoZkJ8T36o6FtMr+kdgUKBiFYb6baWwaVGsq5DycICNCdEeibnfJusbrQOv
         axrHXXWyg7svwTpufovnYUAgRmb01sU2U73M/cqGU2fbyVHVDzS8WyKE0x2nONooFDPM
         lFiyPlqs3rA9Xj5c2UutBrhYiNJP2F3uVNMX6PYG/gHTt+paz6l4xmFgKT5QkLftLvnu
         jdn1AfA288jYgMNbkLyKWkuQqYG7AHbe+D+QGTbejCxSYn1ggANgZsb8Q/AKTIET/9oW
         bXNJ0cXUISdQtrx+DJbEd8sYJ3NMuDNx2EQ5S7cwmaHC9MOuXo/O4tTnUSU3tUsEYknE
         vf8A==
X-Forwarded-Encrypted: i=1; AJvYcCWWJXsoRuAiafg+W8thLuezHWtW4HH+TdkXzvzYzoOjj9rMm5Bccb3hyr+4Ftbw10km8wSDrB4KKx14NTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhqmcCUe1A7qa3t8M2tmJTjoUtPp/ZAXsJd8PhUXFPPJilgPZT
	gc1rr5TpOIfDbRJkBcGxlgvzkBkxesbFoOQZBUuBHGk4hYCq2rlfQBn0Q39ke9sU7aNIxb0lQF2
	1H+gBTw==
X-Google-Smtp-Source: AGHT+IGs6rtJljCigsHxy+gP6Zvfa6mMr4o1JCjh56mqE4HiFoyek51h2OZvh4lGlezQ3sjgUNIEEbqKPWUq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e28:f6b3:3666 with SMTP
 id 3f1490d57ef6-e2978567367mr4642276.7.1729124726404; Wed, 16 Oct 2024
 17:25:26 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:00 -0700
Message-Id: <20241017002520.59124-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 00/20] Remove PERF_HAVE_DWARF_REGS
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
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

These changes are on top of:
https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/

Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
functions:

1) regs_query_register_offset would translate a register name into a
pt_regs offset and was used by BPF prologues. BPF prologues existed
for BPF events and support for these was removed many releases ago.
This code was dead and could be removed.

2) get_arch_regstr duplicated get_dwarf_regstr and so it could be
removed.  The case for csky was a little more complicated as the ABI
controlled the string. The callers of get_dwarf_regstr were updated to
also pass the ELF flags so that on csky the ABI appropriate table
could be used. As the argument is only used on csky this a no-op for
everything else.

3) get_arch_regnum translated a register name back to a dwarf number
and only existed on x86 where "al", "ax", "eax" and "rax" could all
mean register 0. This code was moved to util with similar
machine/flags logic to get_arch_regstr and for consistency with it.

4) get_powerpc_regs a PowerPC specific function used by annotate that
should really be in util.

2 and 3 required the wiring through of the ELF machine and flags in
callers to get_dwarf_regstr and get_dwarf_regnum. When these values
weren't dependent on an ELF file a new EM_HOST and EF_HOST were added
to give the host ELF machine and flags. These 2 #defines got rid of
the existing separate arch files and #ifdefs.

v3: These files were separated from the rest of the v2 libdw clean up
    in:
https://lore.kernel.org/lkml/CAP-5=fVZH3L-6y_sxLwSmT8WyMXDMFnuqUksNULdQYJCPNBFYw@mail.gmail.com/

Ian Rogers (20):
  perf bpf-prologue: Remove unused file
  perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
  perf dwarf-regs: Add EM_HOST and EF_HOST defines
  perf disasm: Add e_machine/e_flags to struct arch
  perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
  perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
  perf dwarf-regs: Move x86 dwarf-regs out of arch
  perf arm64: Remove dwarf-regs.c
  perf arm: Remove dwarf-regs.c
  perf dwarf-regs: Move csky dwarf-regs out of arch
  perf loongarch: Remove dwarf-regs.c
  perf mips: Remove dwarf-regs.c
  perf dwarf-regs: Move powerpc dwarf-regs out of arch
  perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
  perf s390: Remove dwarf-regs.c
  perf sh: Remove dwarf-regs.c
  perf sparc: Remove dwarf-regs.c
  perf xtensa: Remove dwarf-regs.c
  perf dwarf-regs: Remove get_arch_regstr code
  perf build: Remove PERF_HAVE_DWARF_REGS

 tools/perf/Makefile.config                    |  17 +-
 tools/perf/arch/arc/annotate/instructions.c   |   2 +
 tools/perf/arch/arm/Makefile                  |   3 -
 tools/perf/arch/arm/annotate/instructions.c   |   2 +
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/dwarf-regs.c         |  61 -------
 tools/perf/arch/arm64/Makefile                |   4 -
 tools/perf/arch/arm64/annotate/instructions.c |   2 +
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/dwarf-regs.c       |  92 -----------
 tools/perf/arch/csky/Makefile                 |   4 -
 tools/perf/arch/csky/annotate/instructions.c  |   7 +-
 tools/perf/arch/csky/util/Build               |   1 -
 tools/perf/arch/loongarch/Makefile            |   4 -
 .../arch/loongarch/annotate/instructions.c    |   2 +
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c   |  44 -----
 tools/perf/arch/mips/Makefile                 |   4 -
 tools/perf/arch/mips/annotate/instructions.c  |   2 +
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/dwarf-regs.c        |  38 -----
 tools/perf/arch/powerpc/Makefile              |   5 -
 .../perf/arch/powerpc/annotate/instructions.c |   2 +
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/powerpc/util/dwarf-regs.c     | 153 ------------------
 tools/perf/arch/riscv/Makefile                |   5 +-
 .../arch/riscv/include/dwarf-regs-table.h     |  42 +++++
 tools/perf/arch/riscv/util/Build              |   1 -
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ---------
 .../perf/arch/riscv64/annotate/instructions.c |   2 +
 tools/perf/arch/s390/Makefile                 |   4 -
 tools/perf/arch/s390/annotate/instructions.c  |   2 +
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/s390/util/dwarf-regs.c        |  43 -----
 tools/perf/arch/sh/Build                      |   1 -
 tools/perf/arch/sh/Makefile                   |   4 -
 tools/perf/arch/sh/util/Build                 |   1 -
 tools/perf/arch/sh/util/dwarf-regs.c          |  41 -----
 tools/perf/arch/sparc/Build                   |   1 -
 tools/perf/arch/sparc/Makefile                |   4 -
 tools/perf/arch/sparc/annotate/instructions.c |   2 +
 tools/perf/arch/sparc/util/Build              |   1 -
 tools/perf/arch/sparc/util/dwarf-regs.c       |  39 -----
 tools/perf/arch/x86/Makefile                  |   4 -
 tools/perf/arch/x86/annotate/instructions.c   |   3 +-
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/dwarf-regs.c         | 153 ------------------
 tools/perf/arch/xtensa/Build                  |   1 -
 tools/perf/arch/xtensa/Makefile               |   4 -
 tools/perf/arch/xtensa/util/Build             |   1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c      |  21 ---
 tools/perf/util/Build                         |   3 +
 tools/perf/util/annotate.c                    |   6 +-
 tools/perf/util/bpf-prologue.h                |  37 -----
 tools/perf/util/disasm.h                      |   4 +
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   |  19 +--
 tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
 tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
 tools/perf/util/dwarf-regs.c                  |  38 +++--
 tools/perf/util/include/dwarf-regs.h          | 110 ++++++++++---
 tools/perf/util/probe-finder.c                |  13 +-
 tools/perf/util/probe-finder.h                |   3 +-
 62 files changed, 328 insertions(+), 927 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/include/dwarf-regs-table.h
 delete mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sparc/Build
 delete mode 100644 tools/perf/arch/sparc/util/Build
 delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/xtensa/Build
 delete mode 100644 tools/perf/arch/xtensa/Makefile
 delete mode 100644 tools/perf/arch/xtensa/util/Build
 delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c
 delete mode 100644 tools/perf/util/bpf-prologue.h
 rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)
 create mode 100644 tools/perf/util/dwarf-regs-powerpc.c
 create mode 100644 tools/perf/util/dwarf-regs-x86.c

-- 
2.47.0.105.g07ac214952-goog


