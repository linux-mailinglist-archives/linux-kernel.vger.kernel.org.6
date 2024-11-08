Return-Path: <linux-kernel+bounces-402490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7999C2855
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4A1B1F22E83
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35FD20B7F6;
	Fri,  8 Nov 2024 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IivN3FaP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6114820B7F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109597; cv=none; b=grftVJ3T2XKQBnVER1JHQUu2Wqz9jXYsTUeIFUvwSPhFiEznXfqqps1C+B/zR5PkXDysCpmlzVl8Q+QAgBKLOu0rSVSM8xw4WClcfJbN5cgfmNwZ2Lcl+QSC41/qAfqoX1/7rQHa/+76HmOiUHVHNnaX/8FDQwRmLB47S/97Dhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109597; c=relaxed/simple;
	bh=CJAss1K1FFdi2qTs4ASD5hvqm0DqKv6JOJD+43+WHyE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HnZG1YLZtG9Qir9WhzP2BOghgThmdvxHF8X2kzug2G9L9I366QGbBk6gz8etMHNYeSLzWpQ/NKokv+t3Ev6I5Jv9StPzo8J8DRqjk0siKTrJlCHVgJ67YDdgyxLl+lvQ+k1K17c6OSBPG4BJljASJuu09Pqxj7C1XZ5fMxFTNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IivN3FaP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so573207b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109595; x=1731714395; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azojZIK4P+JI8rufI/R8xa4D5fUVVVyAlbNpxVfvbC4=;
        b=IivN3FaPhvvGwoxd+GnTZkrfbImeLEzn5w9ssOiu/8w36l1V0acfZ+CnMU9LluorT+
         yZrkkco52lq9GgY/mU3cEUZs5exs6ngrDc82BP/FWMEpzvG1H+PzCxgUt0xdSULI85BK
         tOoJOmKZdhVLs6CzOyEcrNHalKwxl2zC2JP1jzrMmCDrAfu3d/dzwASfVy5pqz1QVl+C
         RihUSTEhAGoXzJO/n9zCItYzsu2efp2QeKnNFuWBpEhmwU7PlqdjF5MXhKv0EzeAebwW
         8lixpdl1fTnpdODnqP+DV26XLM/60DLE9lajvX42B51A+ta6ZezxWO/VMO3UpTptRcFw
         MmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109595; x=1731714395;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azojZIK4P+JI8rufI/R8xa4D5fUVVVyAlbNpxVfvbC4=;
        b=HkHdIsa5XatZtHLsWkRGJuLG4+mKpW7w9SaWkV4fJ+yedznHYFFX8dXqaNo9WdzPiH
         zAdeInHoSSwNku664+kXjf6PcqNxEwU9otLDbFPU/kF/3b9OEtVA39YmEfG0n37MB2Fl
         eBdqyDhzFTIXMtE9y2lrDIq6WvjCbln03szKwxFWgcjcEyzUxVU7EMnD4LBDcyEWqWqx
         07gU8tdN5cBpIK3Y1vUnBpapzquFnO8f6YhaLNcCDT/dODvqpDCEv+HNiY0Kb1c5FKpR
         fmFlFkwe0+jDg26HjImk6hhz6NlXmkj+2y2n+FK7znvszfkZ6OK60/zz7X4+EusNnyzV
         VbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rMR6Z1n4cjmqSzOMIR54oSIjhmPtM+MnRTIM9K95vlDAW7HSuZseHV3C4P783w+awnP6bRroCkF0H2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKyL5SDrSXvoqQFHA0N9Fjdo6DZmfdyOHg3GRg23Dqa8v1iVdX
	oYuZQwfRyBNG99i0pVIR5NEgzww4uhjqFtMl+ymHj9VcQaw0X9gDnkCp0anuNwAgDb17Kg+Qr+9
	r63ojMw==
X-Google-Smtp-Source: AGHT+IHvxaz+IUsygm0KRuAKCEHm0Hu0ZezrckPWQ5vrrDTKrO7SMIdnfNdCCVlp0iIRJj3j38NKn+fR9CMz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:d856:0:b0:e30:c868:1eba with SMTP id
 3f1490d57ef6-e337f845652mr9447276.2.1731109595364; Fri, 08 Nov 2024 15:46:35
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:56 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 11/20] perf loongarch: Remove dwarf-regs.c
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
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. Tidy up the
EM_NONE cases for loongarch in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/loongarch/util/Build        |  1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c | 34 ---------------------
 tools/perf/util/dwarf-regs.c                |  4 +--
 tools/perf/util/include/dwarf-regs.h        |  3 +-
 4 files changed, 4 insertions(+), 38 deletions(-)
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c

diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index 06ff95394921..0aa31986ecb5 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,7 +1,6 @@
 perf-util-y += header.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/arch/loongarch/util/dwarf-regs.c
deleted file mode 100644
index bee08fdcf2fd..000000000000
--- a/tools/perf/arch/loongarch/util/dwarf-regs.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2020-2023 Loongson Technology Corporation Limited
- */
-
-#include <stdio.h>
-#include <errno.h> /* for EINVAL */
-#include <string.h> /* for strcmp */
-#include <dwarf-regs.h>
-
-struct pt_regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-static struct pt_regs_dwarfnum loongarch_gpr_table[] = {
-	{"%r0", 0}, {"%r1", 1}, {"%r2", 2}, {"%r3", 3},
-	{"%r4", 4}, {"%r5", 5}, {"%r6", 6}, {"%r7", 7},
-	{"%r8", 8}, {"%r9", 9}, {"%r10", 10}, {"%r11", 11},
-	{"%r12", 12}, {"%r13", 13}, {"%r14", 14}, {"%r15", 15},
-	{"%r16", 16}, {"%r17", 17}, {"%r18", 18}, {"%r19", 19},
-	{"%r20", 20}, {"%r21", 21}, {"%r22", 22}, {"%r23", 23},
-	{"%r24", 24}, {"%r25", 25}, {"%r26", 26}, {"%r27", 27},
-	{"%r28", 28}, {"%r29", 29}, {"%r30", 30}, {"%r31", 31},
-	{NULL, 0}
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	n %= 32;
-	return loongarch_gpr_table[n].name;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 9a76f83af62c..efc41d0fbee9 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,7 +32,7 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY
+    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -40,7 +40,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #endif
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY
+    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 0641c2942b01..4e591379f367 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -89,7 +89,8 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__)
+#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
+    && !defined(__loongarch__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog


