Return-Path: <linux-kernel+bounces-352124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B30991A63
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C9228207B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1AF18BBAA;
	Sat,  5 Oct 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPQISKi0"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA018C34F
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158226; cv=none; b=e6hMsJcg0CRw+L7AnUMJHNDDWJ8zCIaaloVmbJLVF4CzUluCgW6TB60BQG1hHujFoNHUg1Sap1L3Lskllvp+TgSoCZg3BLE3X5YFzgP3GjvEy/Q+T0+8o/owNCUVSmudX+/t/Pj12QIWsZSbxvDWN8zQ4mue02+Vj1FxLuIHe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158226; c=relaxed/simple;
	bh=+GtmCKTOnorsBBNnJyPOkLl+5stCTqHcJSBIHoG4bgQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jSWy+vhbJZDqt5maHk4vhEsLY7zCwXoKYU3HJhiEyY65aS5uTqsep6kdilezSAtufQ3eQ0nCYSephQoO2XJls/CvBgZtC29zM1+D1Z+ODGHTjWANoSOKUUVo1Q8XJZMEBacdkeMxHY1rBCIBH92VkPKFu2WUDNHyg1G0DsshmyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPQISKi0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so5650771276.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158223; x=1728763023; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9r02I9/reaWwVY1P5PCE7HG7NRQUH/biYWG5AAi0nY=;
        b=LPQISKi0FveNgtzssWfEfoHzxi3U6VsH3JP6MoOmqapgPsVGvgUn1vSBTqXAcz/+8R
         ix/K6fZ6vBTglJP39V1D2szNYCHtlaNbQ0Jp04x/V2ZKMcbSJehp43brqkf6I4/R6ER9
         9qDZxehAc919DZFiWjdwRFZdj+bSUMejM15DV2EDZ0A+Z5nDiue8PGi92u7qemUkrRdV
         J1cMZPwpdtftRhgp2z/V+xWfirPv+v0gmkaXagfxJflJ3EvUtWBYR9muM1/RIlXO4Fz/
         WY5ILmHbgyCwiQhPELrq9vSJowaX6rnMweeZX6pnWbatK99eOYJ2RgmF3Ee4/sRDxAuh
         NnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158223; x=1728763023;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9r02I9/reaWwVY1P5PCE7HG7NRQUH/biYWG5AAi0nY=;
        b=u4VRi31KcwpSvS1SqsS6vPEQ4emva01k34hHLaJtEgjDereuACFFpmHD9q+gbnXjk1
         Dd/JP4lzjM2V6XuLySTva8vovBCidN3AXdBz044MJq6UQcHtIYCuaVGUKSFmqYJ+rTfM
         Fwen4D+19XX90WKaJ9kV5l8/wbPOVVC0cfHVLVVRwbzPZ6kAPRgVx+6Tah8TLhN6S/UD
         FyTximsSpxfAI3ib4t8X6fo0Dyzw4Jh2PCgxSKKUKKxDaXdd1DSv1NHmSSWWZqvpyMBt
         l4gsRHaBLntv8nu7PJuO2KSMceIjlGF1ku3vLUo5+nxQo4lR+dW3+tl33xNdW6w0IR8d
         Uj/g==
X-Forwarded-Encrypted: i=1; AJvYcCVdc//O+9GLgje3pVQ1nikSjE19D8e26x4cgp390A32agybAZ9HzQ2XgXQ2pfxXFxL+bQXbV9h7NIvzkuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozJ5+jUTCOl4XGZ5i5N8lzvfsYGpEiS4LBTW/jfWeN1jGfuB0
	9K/DeS2W1PT5DyxUcrLbPhMiiGZeILzvMOBlIe+xCeJxyUtcMzPJLwLFQZl7vR8+a+BlYZxbWyL
	NBjn/Lg==
X-Google-Smtp-Source: AGHT+IEG5cyh98/NV6Z3s0KsXI6aIqDOuzALXm1Fg1UBkWYHg5crgQgGWUEdyntPKI0TigP58C1hZgymXz95
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:b191:0:b0:e26:177c:86ed with SMTP id
 3f1490d57ef6-e28936bb059mr4706276.1.1728158223465; Sat, 05 Oct 2024 12:57:03
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:39 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-30-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 29/31] perf xtensa: Remove dwarf-regs.c
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
the only file in the arch/xtensa/util clean up Build files. Tidy up the
EM_NONE cases for xtensa in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/xtensa/Build             |  1 -
 tools/perf/arch/xtensa/util/Build        |  1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c | 21 ---------------------
 tools/perf/util/dwarf-regs.c             |  4 ++--
 tools/perf/util/include/dwarf-regs.h     |  2 +-
 5 files changed, 3 insertions(+), 26 deletions(-)
 delete mode 100644 tools/perf/arch/xtensa/Build
 delete mode 100644 tools/perf/arch/xtensa/util/Build
 delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c

diff --git a/tools/perf/arch/xtensa/Build b/tools/perf/arch/xtensa/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/xtensa/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/xtensa/util/Build b/tools/perf/arch/xtensa/util/Build
deleted file mode 100644
index 2d1a48696ad9..000000000000
--- a/tools/perf/arch/xtensa/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/xtensa/util/dwarf-regs.c b/tools/perf/arch/xtensa/util/dwarf-regs.c
deleted file mode 100644
index 12f5457300f5..000000000000
--- a/tools/perf/arch/xtensa/util/dwarf-regs.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (c) 2015 Cadence Design Systems Inc.
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-#define XTENSA_MAX_REGS 16
-
-const char *xtensa_regs_table[XTENSA_MAX_REGS] = {
-	"a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
-	"a8", "a9", "a10", "a11", "a12", "a13", "a14", "a15",
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	return n < XTENSA_MAX_REGS ? xtensa_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index a0bcc2529cb0..05fff75a8f59 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -35,7 +35,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
     || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH \
-    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9
+    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9 || EM_HOST == EM_XTENSA
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -45,7 +45,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
     && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH \
-    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9
+    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9 && EM_HOST != EM_XTENSA
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index b2cf7d9e4785..9dfc9abfdddd 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -82,7 +82,7 @@
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
     && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
-    && !defined(__sparc64__) && !defined(__sparc__)
+    && !defined(__sparc64__) && !defined(__sparc__) && !defined(__xtensa__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


