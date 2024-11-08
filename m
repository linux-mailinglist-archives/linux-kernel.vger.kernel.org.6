Return-Path: <linux-kernel+bounces-402499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8330F9C2867
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A741C1C222A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5821EB8E;
	Fri,  8 Nov 2024 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx6cpxVZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7221E13A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109619; cv=none; b=IRLuC4DCDSXCmJ4f3xPiyA3ACYEBgmPIPKH1S2qhO5dEARlLmp0idkM2cNzZmCfg1rG6QiWG+8WlPLTYg9wbUiiTzmiwIuQS/SFrSZfrKdnAKXxp60F4VVAhCXhILe4KDExTVVdnN2pDR7klqC75t154b4eClbrWczi6hubOQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109619; c=relaxed/simple;
	bh=+qbC1BllbCYTtNQ2/CjIoZXsicAaiGDn8oCzA7nIsmw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jfWnEo8y1XGlyZtK10HnsrxmgE8BwLcoRLLlbDIVbpXgohy75jwvN+O/KVw4t6yzDpgBWN78tn5V1SvIEcUfe4N22CPGK6lY+uE0dbVw9eUG8ZyfDucctmPjxtM0B1n8N6LG9R7LPRdKWCYWruMoqhd9lfuf5mO14jdJLltiNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx6cpxVZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so3744297276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109617; x=1731714417; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKslcm2V1UHcqGqqi4FAiYTJwpOr2SEQn/AjeUS4EGg=;
        b=Mx6cpxVZqWlUPMKFCr/DQ0cJ+S1BxN/I14UvdZGnDvhtelq7MYcZZXNJ0TatBjZr1b
         wFG19KPoHLYlOxsfjvxSCyidCT5NeB1rjUE7+4Dvlax94RLuOsgVuArHgw3o6n7W4W5m
         /aMQU1IwpDeJxIStnRd+9iBi+mMfgvdVFY4sw/Fvcz5/wQBhQw6Z9Y0nID/wOCnxl3cc
         hYFDsNBnhjhjprKODfzmgt+/GzXbxsr6VKv1O3GBH/oej8tsPfHq5Yq6fNOXMFI+Eem1
         4gwmaJGuLWcQAlTFg/ixzy+FJrBwrjzDY85KE11O0DM5W5KpqQklPVZ1+OLr78KnvaF2
         JshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109617; x=1731714417;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKslcm2V1UHcqGqqi4FAiYTJwpOr2SEQn/AjeUS4EGg=;
        b=i0F8vrRUsVHOLYZcUfFZDibIen1V1oaZRUDCwKoZhu/k6DSRlneixw1/7q91FXOh77
         6UIhyO1TEXiKRTIxshwbU72eX1u/azmpg+JLy6ggH0PxwHBZpRDH/q8kN307xqPNiiLX
         Xi2VhWhLe6e9j8h9hpjFASpBbW8+7dx1r7vEIhcUSjoUkYmP5TQa8ZOHaZT/NzSFa3yD
         cVGQ+Xicz9cttiWaf6bS8ytqC5fswcT5lds5Nz9TX+FWL6eKekhFcalgz1zMYOIAyieT
         g1GWQOSeAlgRB/VgSkqx5JgkuH3kEfZoRovOFZN7hrHbF0FVYmg9F08V3u8kzqT7x58V
         Zsng==
X-Forwarded-Encrypted: i=1; AJvYcCXUxlR3r3nNz888QGhzoBPIZ4aNdtH2UCyJS45UDEpdGyDr+2+cXhSobKBAMUywnxFpuk9wFMJRRWY9YLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6niOeNhWRhCnCiJX+Knx1JErDTyq1B3GyF9Fj2FfOD9jrzDK1
	ywZCanF3ihaqGw8QVSqL7TttuPD1YWEHrUMwOdP2Yl5rih119IqhPGyswY8vrJ+qSpqw1Q96rxD
	wFbTmZw==
X-Google-Smtp-Source: AGHT+IG1zx26qQHAzqiLBUtrRzJXR+kqfJstP7FYSoC2xoOMAWBu+eO7OrTp0s/Fw2wwPvD/OOi7YEUCvyL0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:ae63:0:b0:e11:639b:6428 with SMTP id
 3f1490d57ef6-e337f77f713mr8790276.0.1731109617162; Fri, 08 Nov 2024 15:46:57
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:46:05 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 20/20] perf build: Remove PERF_HAVE_DWARF_REGS
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

PERF_HAVE_DWARF_REGS was true when an architecture had a dwarf-regs.c
file. There are no more architecture dwarf-regs.c files, selection is
done using constants from the ELF file rather than conditional
compilation. When removing PERF_HAVE_DWARF_REGS was the only variable
in the Makefile, remove the Makefile.

Add missing SPDX for RISC-V Makefile.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         | 13 ++++---------
 tools/perf/arch/arm/Makefile       |  3 ---
 tools/perf/arch/arm64/Makefile     |  3 ---
 tools/perf/arch/csky/Makefile      |  4 ----
 tools/perf/arch/loongarch/Makefile |  3 ---
 tools/perf/arch/mips/Makefile      |  4 ----
 tools/perf/arch/powerpc/Makefile   |  4 ----
 tools/perf/arch/riscv/Makefile     |  4 +---
 tools/perf/arch/s390/Makefile      |  3 ---
 tools/perf/arch/sh/Makefile        |  4 ----
 tools/perf/arch/sparc/Makefile     |  4 ----
 tools/perf/arch/x86/Makefile       |  3 ---
 tools/perf/arch/xtensa/Makefile    |  4 ----
 13 files changed, 5 insertions(+), 51 deletions(-)
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/xtensa/Makefile

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 52a216df9e2a..2916d59c88cd 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -559,15 +559,10 @@ ifndef NO_LIBELF
   endif
 
   ifndef NO_LIBDW
-    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
-      $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
-      NO_LIBDW := 1
-    else
-      CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
-      LDFLAGS += $(LIBDW_LDFLAGS)
-      EXTLIBS += ${DWARFLIBS}
-      $(call detected,CONFIG_LIBDW)
-    endif # PERF_HAVE_DWARF_REGS
+    CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
+    LDFLAGS += $(LIBDW_LDFLAGS)
+    EXTLIBS += ${DWARFLIBS}
+    $(call detected,CONFIG_LIBDW)
   endif # NO_LIBDW
 
   ifndef NO_LIBBPF
diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 9b164d379548..8b59ce8efb89 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -1,5 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index ca2e35961287..91570d5d428e 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/csky/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 79b432744296..52544d59245b 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index 733f7b76f52d..827168f1077a 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 # Syscall table generation for perf
 out    := $(OUTPUT)arch/mips/include/generated/asm
 header := $(out)/syscalls_n64.c
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index ae05727835d8..dc8f4fb8e324 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index d83e0f32f3a8..18ad078000e2 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,6 +1,4 @@
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
+# SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 58e79f5b67a4..c431c21b11ef 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/sh/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7741184894c8..8b59ce8efb89 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,6 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 51cf267f4d85..a6b6e0a9308a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/xtensa/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-- 
2.47.0.277.g8800431eea-goog


