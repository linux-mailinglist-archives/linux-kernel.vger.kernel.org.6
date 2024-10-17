Return-Path: <linux-kernel+bounces-368960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9EF9A170C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D95BB22F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F011E49E;
	Thu, 17 Oct 2024 00:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mKHYIdRn"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7716D4E6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124766; cv=none; b=BYGRDXfPDMQIBUmZpfLnoWo0V+eNEHWoAXvAtfD+gCYKqcS3cmay/x6D8O973GdBlZvKjqKfrtkeqZV5cvDrirAZk34hh0DEETIoNPdbz0CSR1Uy72g6SH436KTSwJlPKwnrV06znwIsjq7pOMJqj1Ap/KWGeEQWjUOmgnEztrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124766; c=relaxed/simple;
	bh=tQFvREIQY7U0kHAscC0X44BcsztjavThWbNkAVIdS/M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CEqMg/YErkIYL0tFVTHdCoQL1HZUfW1nO5j41y0Ws1mj6Wq1ijNxzx9liKQew5QIFvW/8jJQeXS2uZatc2x4ZTp3wHA2knHbx4loctCBOGw8lsphTdr5YWr6lLAbguNuPf4i0QHkVQwKFiMuAPGvwH2xlojQPhKH0DuATrw3eYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mKHYIdRn; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35199eb2bso8983897b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124762; x=1729729562; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f+6tiaKaV6HvKOoydGJA88FSVOYPAhxZOHcfM2Yk7U8=;
        b=mKHYIdRnJP7JMtjtYs7MPooyEPGbQXEknp2Mh3wDJs1KnRLdTWUEjCvF1Hcr74NJN4
         8HeiBPVmYjKRoMt2kvhjJKMr/qWuPdn+/I6XrVC2dCsxiTCQmiRJd/fxqDbQ49j8jnYX
         geGCZWmwpBBotsly1xYQyZuo4U0YpUB3yq33RQFcedvXYPkEDHuowVOh+8ThKFLksygB
         sdelgpTDVxI45nao63NsOQyvV7wvAaPWTvKfI0FnAHATDsDsH43OV2ZgcxcPgU89UvkT
         H0weDtIXsrRfSjjky+Ilz8zcDGsfUtJw1YyrhdF329GfdI97heiUx5H/OMZc1+wCyPnl
         WKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124762; x=1729729562;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f+6tiaKaV6HvKOoydGJA88FSVOYPAhxZOHcfM2Yk7U8=;
        b=vJviDJnz7kPQtIPm3/rYpTUlnXRfk61DXvKNQ6Ho3kmG8qN8Xg4biJ2vsm+z2d2o5G
         jhYS4rZ/RGJenF1RuCTvmlVQd5Y44FgDaEHouqPubDeylndv+hQykUh+VCTUe2IVg5Ql
         Wzuq1iyb+hZD3w5mEE3ckUb35Yt7fEZtxv9Hgtz6LtnwMrJ5ktVp7cUWZZ3oVAmz83Sq
         Kv9/oSVcFt4YF9/vAvA9Wa2jxfZEBCgGdDhYAiJMTNjxx5pvtdcbPphwl/PGgaiOoiLL
         1ix2xMVZMFcgXDu+eZiQNKajJQb/03e7gHx35vJIEPxy2cQZOy8RjO+/qPXyyQ2r2zJw
         nwcA==
X-Forwarded-Encrypted: i=1; AJvYcCURkl20r6OlCun2P/ng9An07FBxI9e6AR7dNcSqygGyj83c+VBMTLdLZgGNlYJAhnIZrsvXBgRMXgJCdv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZJotQYardbqcA2rqF8B0hOSGOZgpUP1wG4AR16HPiQSVerX5
	TvcewuWlqfVH/Tm0F2ZjJWoub0eQpLXM3A/f/VNMCgRv9GZVYSKj2US8NK9vzh87eAhl/RhYYCn
	iV68P2g==
X-Google-Smtp-Source: AGHT+IF8vR2ODszdvUkiRs2C6hBOma5C+iYC6PWCAbaWDyF1xQHgEj5TqToGlUQxetf5HbIY0PdC8v7iaIAq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:870c:0:b0:e25:5cb1:77cd with SMTP id
 3f1490d57ef6-e2978585305mr4689276.10.1729124761924; Wed, 16 Oct 2024 17:26:01
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:14 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 14/20] perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
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
2.47.0.105.g07ac214952-goog


