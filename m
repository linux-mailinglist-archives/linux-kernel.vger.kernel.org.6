Return-Path: <linux-kernel+bounces-352122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5420E991A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14947280EF3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DFC16130C;
	Sat,  5 Oct 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMli5bb6"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E6718BB89
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158222; cv=none; b=Bae0/I5t3DFsLeF4bpkehMoHhFpsaTsTRljKJDEhLoUXFmnMzZ9SUKDRj9XU8GWB7Xup6BWBqh2oYQ1TC6QoFQoAby7PQXjeNeAcfPkgsnQjp7QkikGJmjO6kVbZ4lwPkSAD0iUYbR3L/7dW1rH5VhegdXOrfrlPCAYV/H7AksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158222; c=relaxed/simple;
	bh=8qjRlEcZv7MlmzingnT/N+Gd/hYl6tzGS2IvVKEovyY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JFpkKwio5VEh/U+Zj3cvWU30Fa+P0jDE28qKtIuGm+7dB7DQFdq6nfqkt8hL4VmGF+vcl6rwTyVs/ETwl/RjyioauZPj8D0OEjHm/bSibuviGXyCXbO/6lM/sCUHI0BjFY0PLazbcw3cCqAApENrEUgyLjpK3BKafGh0TloICk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMli5bb6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e262e764f46so5589731276.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158219; x=1728763019; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ma4kgoFy2RIK7A+71lTzE6CEm9/tJ6zbTbn85DXB8RQ=;
        b=SMli5bb64C8AVHAjnE1qXfwQb5miAIj0T6FBKpDjzokxSwL/uClhnEz3229laFF4sy
         4/e77FMOjbSzPYR4SOR0QOq1aW4YF+eblvTh/U531y67V3mXOcR+iV3WjtgKOg8qfAGl
         uBTE13zGAzF5E6ECWywOSK20eMel7GwfKTYH5pl4npPgeiIU1LsF+H/QhaIPYzHvvNJl
         /SWtzXWMMrne3IgktmFWmtIZH+8LuyFVfQWKnWaAstJ/RhvoRhR5Byzt1Jnm0iDQYm/P
         CHi5Tx/XfMK2tDsrcj8nMB/paQr7fgB0DV7WCNY+rtPPzw/goykew8akXNvUH+w3+rii
         2CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158219; x=1728763019;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma4kgoFy2RIK7A+71lTzE6CEm9/tJ6zbTbn85DXB8RQ=;
        b=qDGFk818A9//Gr94gXneDMB/S2iS7rRz6JiEaYf+7yPnJ9v36pHSTtE/bWMdC1tbQ1
         9rK8wQicsQspgyHbYTerr0sOHa8eNU1NDpNimxqS+/7iEnk6Sahp2jTZGz/RTE4ISztU
         akY6/DaZYaQ8pi4tRqGp8EVhhoG1yC/mT4W7SujYh3y1W17N6z+GH6yKjfFJuA/xQfRr
         V9uN+GCkp8w5kq45xicRp0q3nCQLW318xun+UNyBIiuK4gYYc8IRuNviq+0mKNPg4u6e
         A5soUYpdAYWu9I1yrUlb1syx3vBWowr0AR/qRXBjxdR6w2pl4mJERDdfC+6dbTDoKGPI
         wCog==
X-Forwarded-Encrypted: i=1; AJvYcCWr+pHoGLT+HJ9ALaShY+PcZe4vC2vDi9f17YXV/0zroAIIR+J8XRAsa3Hly95Gud3jUzljSgnFnDDZHVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoqFOdNhn6JkUr31bQppwmp0ky3vR107hqDpNptuzR0ijRMAWw
	S8ThzqX3uMlWawWDYJNXXaPPueqLj7SeXCT5N+4h/KaUGN+yqDe7g8uKU4YR3z8hyWG1IkIjO9D
	yexp1fw==
X-Google-Smtp-Source: AGHT+IEl51HegVcv/pl0KKiaLpVIfkXCyaK+ttN6DaWvP25wIl/YaqJ6jogCCBBTO/D119SZYDZzeC85Makg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:aa21:0:b0:e22:5bdf:39b4 with SMTP id
 3f1490d57ef6-e28936baae8mr4651276.2.1728158218682; Sat, 05 Oct 2024 12:56:58
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:37 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 27/31] perf sh: Remove dwarf-regs.c
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
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. As this is
the only file in the arch/sh/util clean up Build files. Tidy up the
EM_NONE cases for sh in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/sh/Build             |  1 -
 tools/perf/arch/sh/util/Build        |  1 -
 tools/perf/arch/sh/util/dwarf-regs.c | 41 ----------------------------
 tools/perf/util/dwarf-regs.c         |  4 +--
 tools/perf/util/include/dwarf-regs.h |  2 +-
 5 files changed, 3 insertions(+), 46 deletions(-)
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c

diff --git a/tools/perf/arch/sh/Build b/tools/perf/arch/sh/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/sh/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
deleted file mode 100644
index 2337a0b710a2..000000000000
--- a/tools/perf/arch/sh/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sh/util/dwarf-regs.c b/tools/perf/arch/sh/util/dwarf-regs.c
deleted file mode 100644
index 4b17fc86c73b..000000000000
--- a/tools/perf/arch/sh/util/dwarf-regs.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 Matt Fleming <matt@console-pimps.org>
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-/*
- * Generic dwarf analysis helpers
- */
-
-#define SH_MAX_REGS 18
-const char *sh_regs_table[SH_MAX_REGS] = {
-	"r0",
-	"r1",
-	"r2",
-	"r3",
-	"r4",
-	"r5",
-	"r6",
-	"r7",
-	"r8",
-	"r9",
-	"r10",
-	"r11",
-	"r12",
-	"r13",
-	"r14",
-	"r15",
-	"pc",
-	"pr",
-};
-
-/* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < SH_MAX_REGS) ? sh_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 1649fc07f4f5..944ff4ef0290 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 25f3d6b90f10..2b212ed70a15 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


