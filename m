Return-Path: <linux-kernel+bounces-368923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824159A169C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E41DBB21450
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F5F20ED;
	Thu, 17 Oct 2024 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOLfKDKi"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6068779C2
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124046; cv=none; b=TdOI6nA789UI8ow9htk6B1qljPZO+NMAzwzCTFVHxn5x/hgP5Cx9o1k3sCT7yhMB7qYt6zdEal8fRIuslfaIkj7yedJrO/sThT8fSP/Jgbp9AwOfnfakjjZrUdiLCjh636X8pez4Pu8Ve56ocHq3CTtet+cviFD3mHbo9XfhN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124046; c=relaxed/simple;
	bh=dP1Q2v80ftL0GvbsW3CTvfvDP98HCCl+fkgj0xYspN0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mGMBMls1MpyPkd5NX5mfG9vQufej5S8zyHM98/NxMp5927cTOKWDYZI2lXpLCySRah6yfUNZqN+aveyNcVuEiC3zvl1MSJ1fpY27pXtvx0rEcCnLupxfW4ZilTRE9noW1zMeLjK1VPeY6tDqalrxF8dUKrS1tXYAmX86adG1ZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOLfKDKi; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2974759f5fso511887276.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124043; x=1729728843; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EiSvPeoRUp8BxyR9oFd1+sHW5VYvYw8ni5QPRWGYfRA=;
        b=IOLfKDKiZRAJ2YdumItc+bpIMPfIKrYWkm1301rLJGF7zmLPDkHgXRcDB+ec3tONFd
         523QX0AIIlb16cFfoOcAyKJPBqpG25258eJuFwyqlzhjPAmdL9XTY/9W5+3JjfdfOygY
         piA2Mi+lxYVXWf7s2lUBV7qIkhdjijPmV+c6btpY9lpGwp3iQyKcn38WFGokrdPcHh5N
         FPteBv4maWEp5ehZo5s773XDVHH2DKtV4m7yEXN0tKLLCs8deuRzOykITMKXYe1Duw/K
         GY6MWZzKk7kKkXDhkqGYVNHrD/If/GqVV5FyPKPOkiwwMRYGsxJzuCxkIvQQWUWkKALp
         +xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124043; x=1729728843;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EiSvPeoRUp8BxyR9oFd1+sHW5VYvYw8ni5QPRWGYfRA=;
        b=Ua25zKeuwnra6QuMxSH+9loKdh6vL9/mXhqezdn6vxSWMgGh7VmtUj6hcG6gIIjC5H
         PxR6h4PvdeP1hUC4XEo0Ig/W2I6Ato8nzOyi63487O3ATmghrwJ+j8LZg0R2pQOzgdbc
         rRfo/SnDN6ltY/QH7IMFGcV9mS4zTeVaCpXiQkcfHZYe3dn9iNU1zRhShy3XNSK/6OUL
         QBD9iuBCIMkq3z/2fwR8SHY0qx4FvqeJPpdazHkPT6ICdXGuVqiS5kavcj82WGvMehJ4
         IOP7IG3SeX7Ruti3eA3M5fX3aWk7bwOQ9DD+It1TQxtdkWNkb7V4NE0Em/Ou+qgrCZXt
         edYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlaF2RtRxQC8PtnI9wolVGBRpxW/B41GKHIQJQDnKAKI7rWD97ASdsyPbWaHO4P6/GPl/YmWzF0qeNL0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyed0I+QL7XiScv7S0d+xMReKJpRF0vtHD+cZlnrsaY0k1KpfIo
	rsVAC4GfJwN0k9llmeGE72ix4aTNsC1HXc28Ui1Vu8o/zstXv+X4dgaYNxsNbmAHTwH13zg4uxb
	qYem+bw==
X-Google-Smtp-Source: AGHT+IGWAA1ezUi0zImlaYNN3LkMp/FqrMVYh+LBbCtzIRBEEa/71ZWVK8WYNSeDn0R7vnfNGuT6qxuKOTd6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:664c:0:b0:e29:7454:e773 with SMTP id
 3f1490d57ef6-e2b9d02921cmr1374276.5.1729124043150; Wed, 16 Oct 2024 17:14:03
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:43 -0700
Message-Id: <20241017001354.56973-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 00/11] Libdw/dwarf build clean up
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

These patches were originally on top of:
https://lore.kernel.org/lkml/20240924003720.617258-1-irogers@google.com/
where it was pointed out that a lot of the libdw conditional
compilation was due to features that have now been standard for 10 or
15 years. The patches remove the conditional compilation assuming the
features are in libdw where the feature test is expanded to check
there pressence. The patch series is now on top of:
https://lore.kernel.org/lkml/20241016235622.52166-1-irogers@google.com/

In the Makefile code, and for `perf record --call-graph`, dwarf tends
to mean unwind or libdw support for dwarf things. To make it clearer
when dwarf really just means libdw numerous build variables and
defines are renamed.

There is some tech debt in the changes as perf check still reports the
values using the old name and for features that are no longer
tested. This can be cleanup for another day.

v3: Move PERF_HAVE_DWARF_REGS cleanup to follow up patch series. Add
    build fix from patch series these changes are on top of.
v2: Instead of renaming PERF_HAVE_DWARF_REGS to PERF_HAVE_LIBDW_REGS,
    remove it.

Ian Rogers (11):
  perf build: Fix LIBDW_DIR
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

 tools/build/Makefile.feature                  | 11 +---
 tools/build/feature/Makefile                  | 24 ++------
 tools/build/feature/test-all.c                | 16 +-----
 tools/build/feature/test-dwarf.c              | 11 ----
 tools/build/feature/test-dwarf_getcfi.c       |  9 ---
 tools/build/feature/test-dwarf_getlocations.c | 13 -----
 tools/build/feature/test-libdw-dwarf-unwind.c | 14 -----
 tools/build/feature/test-libdw.c              | 56 +++++++++++++++++++
 tools/perf/Documentation/perf-check.txt       |  6 +-
 tools/perf/Makefile.config                    | 47 +++++-----------
 tools/perf/Makefile.perf                      |  2 +-
 tools/perf/arch/arm/Makefile                  |  2 +-
 tools/perf/arch/arm/util/Build                |  2 +-
 tools/perf/arch/arm64/Makefile                |  2 +-
 tools/perf/arch/arm64/util/Build              |  2 +-
 tools/perf/arch/csky/Makefile                 |  2 +-
 tools/perf/arch/csky/util/Build               |  2 +-
 tools/perf/arch/loongarch/Makefile            |  2 +-
 tools/perf/arch/loongarch/util/Build          |  2 +-
 tools/perf/arch/mips/Makefile                 |  2 +-
 tools/perf/arch/mips/util/Build               |  2 +-
 tools/perf/arch/powerpc/Makefile              |  2 +-
 .../perf/arch/powerpc/annotate/instructions.c |  4 +-
 tools/perf/arch/powerpc/util/Build            |  4 +-
 tools/perf/arch/riscv/Makefile                |  2 +-
 tools/perf/arch/riscv/util/Build              |  2 +-
 tools/perf/arch/s390/Makefile                 |  2 +-
 tools/perf/arch/s390/util/Build               |  2 +-
 tools/perf/arch/sh/Makefile                   |  2 +-
 tools/perf/arch/sh/util/Build                 |  2 +-
 tools/perf/arch/sparc/Makefile                |  2 +-
 tools/perf/arch/sparc/util/Build              |  2 +-
 tools/perf/arch/x86/Makefile                  |  2 +-
 tools/perf/arch/x86/annotate/instructions.c   |  2 +-
 tools/perf/arch/x86/util/Build                |  2 +-
 tools/perf/arch/xtensa/Makefile               |  2 +-
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
 54 files changed, 154 insertions(+), 259 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf.c
 delete mode 100644 tools/build/feature/test-dwarf_getcfi.c
 delete mode 100644 tools/build/feature/test-dwarf_getlocations.c
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c
 create mode 100644 tools/build/feature/test-libdw.c

-- 
2.47.0.105.g07ac214952-goog


