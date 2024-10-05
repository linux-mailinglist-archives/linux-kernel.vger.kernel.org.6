Return-Path: <linux-kernel+bounces-352120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5271991A5C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 637BF28103A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C12A18B492;
	Sat,  5 Oct 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvJzSbIO"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A5918A6A1
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158218; cv=none; b=M7XBOp5xSNwKh1Yfi7xsEX+3V698NRlIoxm9SMsNYf50Os/kCLmNUL3fDdtNU9VSZJyFv9c6Q+fh/LUxwaZR6HBeQnGWjqDGzGVh6+R2HOSIUSH6Wh4rMnHvdPR0uCW5OBkYFHdVKp9WQTrywA/eDKdjZRlvshu3cG+qIYgYohs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158218; c=relaxed/simple;
	bh=udd5WlhhnmwqnkiIWTPOqQEmfxASluatpyr3EoOTRkk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Y45dzGWEO6Isy1UIHrUTrDpbBFIxTOy+wR8IYkda8arIPgSbph06ZQHG2NxG79IGnaXT+daS64Ffff9LhqAJgeRWKQFeJJ9RRsVT1msvwb7b0X+P6S3YSdlQz+WBZ+MtRDQ9IykYCXPbfnrtZ+snu2roIUoqn2eLWWEkohlTdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FvJzSbIO; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cc76cae1so4921330276.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158214; x=1728763014; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSL2ccbL1zMKXwe4tQXqPGcWrUHTWmz3veARUKGe9SA=;
        b=FvJzSbIOP869ukyWohO0qjsu07iV9QuxNvT3futPM3vorPG+CD9kNzaWy9+k96roAw
         XAKim42YdGAtLJSnkg41ubrpoVBRjW1MR/AXHkpnsafaX1kr3mT17BiFIF4qYEatsMOQ
         Q2lcyjgRvao1vLs/9H1Q17VOp9oF1sUjpllhFZHeM5GdG4BwqeIZRADqM0Ms2LNJPx8w
         IXqnovbbQ7rwDKja6V+jZYtf+JikDA4pQR+lgrEop2Yfal0BLwOB7doDi5cFPWByt8Hy
         F8IS1X8yNSdyzSh0r7sFCnKNtGjGVOzNJ/KaUi95LjrwfduseMfIoAvDuEdhzZRvHMpH
         FOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158214; x=1728763014;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSL2ccbL1zMKXwe4tQXqPGcWrUHTWmz3veARUKGe9SA=;
        b=HTl780PjCwnJl13Ops6jtbBxKT2rdHhURkJh1R/lYdcYMoUUNAAtM6krJcl7MHP3hk
         eNhwSu7C2NBUcX13HJHeRDKr6/lXm5S5H9AXXPg1J1agpLonBceCmSOXYWyixEgy8VbU
         fzamte/WvssgHoo3/GD/q4BBgfZMlnGPuMOyurKPqrdZA2QpgKZKYDED93i96KWyt5gE
         +ZjFXMV/NPQ8rid2ST03c4ZqU1/6zNxIVTXgjZC8wCxKcAgK4pxtu2jNS/ODJ3ihJ7OR
         Tuf5B8xhjSGjsgr97yNcmBwSQjqkfnWL6wXV6B3hXBtmmXuS6QutLsass8NZ2nLh4jL0
         yaUw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7yYWul/g1+g0rZ7z6q1Lx9RP7tkkDCuAwMCfnhGhMmrP8WSkd/UOJinl8tIT2oybGdm8U1sZ9TukjE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgszbh6ahS9vZVdF264cZd2z4kF/RaSGSzT3UFSwiqreoDyNs
	fwK5ZN4XC8vKIVAdJ+wJzCd1dXF/l5RwyHUdfYIqH8+9B57PdN5Lez56oja6i7dFAYvwGXGzy+W
	1xSjCnQ==
X-Google-Smtp-Source: AGHT+IFqH49xvkBQa7keg1rzZuWU/08D0ii8FTpSBX6sVpAkmGWs4m8R5YhQwlrDd8JE/onJIqb9MBMS1dlP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:6f05:0:b0:e20:cfc2:a326 with SMTP id
 3f1490d57ef6-e28932a484bmr64009276.6.1728158214036; Sat, 05 Oct 2024 12:56:54
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:35 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-26-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 25/31] perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case,
and the register table is provided in a header file, the function can
never be called. So remove as dead code. Tidy up the EM_NONE cases for
riscv in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../dwarf-regs-table.h}                       | 32 ++++---------------
 tools/perf/arch/riscv/util/Build              |  1 -
 tools/perf/util/dwarf-regs.c                  |  7 ++--
 tools/perf/util/include/dwarf-regs.h          |  2 +-
 4 files changed, 12 insertions(+), 30 deletions(-)
 rename tools/perf/arch/riscv/{util/dwarf-regs.c => include/dwarf-regs-table.h} (56%)

diff --git a/tools/perf/arch/riscv/util/dwarf-regs.c b/tools/perf/arch/riscv/include/dwarf-regs-table.h
similarity index 56%
rename from tools/perf/arch/riscv/util/dwarf-regs.c
rename to tools/perf/arch/riscv/include/dwarf-regs-table.h
index a9c4402ae57e..a45b63a6d5a8 100644
--- a/tools/perf/arch/riscv/util/dwarf-regs.c
+++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
@@ -1,23 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
- * Mapping of DWARF debug register numbers into register names.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef DEFINE_DWARF_REGSTR_TABLE
+/* This is included in perf/util/dwarf-regs.c */
 
-#include <stddef.h>
-#include <errno.h> /* for EINVAL */
-#include <string.h> /* for strcmp */
-#include <dwarf-regs.h>
+#define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
 
-struct regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-
-struct regs_dwarfnum riscv_dwarf_regs_table[] = {
+static const char * const riscv_regstr_tbl[] = {
 	REG_DWARFNUM_NAME("%zero", 0),
 	REG_DWARFNUM_NAME("%ra", 1),
 	REG_DWARFNUM_NAME("%sp", 2),
@@ -50,13 +37,6 @@ struct regs_dwarfnum riscv_dwarf_regs_table[] = {
 	REG_DWARFNUM_NAME("%t4", 29),
 	REG_DWARFNUM_NAME("%t5", 30),
 	REG_DWARFNUM_NAME("%t6", 31),
-	REG_DWARFNUM_END,
 };
 
-#define RISCV_MAX_REGS ((sizeof(riscv_dwarf_regs_table) / \
-		 sizeof(riscv_dwarf_regs_table[0])) - 1)
-
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < RISCV_MAX_REGS) ? riscv_dwarf_regs_table[n].name : NULL;
-}
+#endif
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 8f93091b8345..58a672246024 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -2,5 +2,4 @@ perf-util-y += perf_regs.o
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 3d98c2bf6035..2c6b197556dd 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -20,6 +20,7 @@
 #include "../arch/arm64/include/dwarf-regs-table.h"
 #include "../arch/sh/include/dwarf-regs-table.h"
 #include "../arch/powerpc/include/dwarf-regs-table.h"
+#include "../arch/riscv/include/dwarf-regs-table.h"
 #include "../arch/s390/include/dwarf-regs-table.h"
 #include "../arch/sparc/include/dwarf-regs-table.h"
 #include "../arch/xtensa/include/dwarf-regs-table.h"
@@ -33,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -42,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
@@ -63,6 +64,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	case EM_PPC:
 	case EM_PPC64:
 		return __get_dwarf_regstr(powerpc_regstr_tbl, n);
+	case EM_RISCV:
+		return __get_dwarf_regstr(riscv_regstr_tbl, n);
 	case EM_SPARC:
 	case EM_SPARCV9:
 		return __get_dwarf_regstr(sparc_regstr_tbl, n);
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 1763280855ce..35f4f33205da 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__)
+    && !defined(__powerpc64__) && !defined(__riscv__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


