Return-Path: <linux-kernel+bounces-352109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C51E991A44
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE8F1C209D3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9418452D;
	Sat,  5 Oct 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScxMiB73"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0C183CBC
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158192; cv=none; b=hmsOWDWWIjEMXYb4OGUTKlbt9AdVkm0G+wPe3go8F/Vx2/mK15cP6Pn9xd7uQ+v0mLZ032lt1ZNkR+IxICKcXsdUc1kFbspPTBlmIqTtYY9laUYTfOdxD1OBbVRV05yaTh3uP5LBHeLcdmqFORBHBYMfhMsCdz2qWuNFlhz7CYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158192; c=relaxed/simple;
	bh=vKC6wvleEdmOYy/UFkVbvo/Aszxf0yDcXtV1RWbZSGU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=r4T9HizhTlX78/4D1DmMLxNheeUAEkh41jtXIFblyrVDfF5sowoqc8kvd69IvIO3e7Sg3QV5Kfxd9qOqioX4b5M+6za305xu7sszSSlPLJ0xhhkxEy8aCjpdcylIMTMX2Y6+b81uEw1O22SL+QIR8fTv/z5VwfvkgbgCx4XPHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScxMiB73; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e25b39871fso57100397b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158190; x=1728762990; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWkTi+vsghXUwthwHY0WZVikiFTqOtXMvpUNhV0UTzM=;
        b=ScxMiB73MLdmBkDmKZJLgEXTgCCt/iF9LpERf0VdAL178pjngPnqDMjxvN2peqRSuj
         pCGKPr1HE+85dX9LG0+syIIsmkg9pFgmwBWXTxv/49qQcWgtIlotLszm09V1joYDdttn
         LRL26i+UQqj7GKWWypffFD+oJUFOE32D3yrjD6QbeRskyGcymsYIVm8Lszf4L1Oig+qt
         7DFyMDN8lOOnXSu+mL4X/Zrj7Y0N8Uf+ZAkCAWSiEpSR9HR9gEfbQHkalsKUGR3arQqf
         FIc6YXCoXm9ZVEMtskz/U6NrfWY3jAvntT4byGS/y1GuS5BCLSLQhnMgqUulL8aFv5/e
         EuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158190; x=1728762990;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWkTi+vsghXUwthwHY0WZVikiFTqOtXMvpUNhV0UTzM=;
        b=JwQBVMCFmJEXdfPYvA6OUbOQ9QNgy9BMBMRKklBngfVm40BPugBEzTxQk3Dxwt+G0f
         WgbGPQR1dzEEEFsLFGr6G/+KwRssJDIvu5jnwVU/KUBGmKdIq8kPwJCg+JAqBzfhsmZB
         Mcr1eky7XGA8glKLN0SBu8M9sr+pJui8/2gXW8PAvyxQINY1wTZSKhk8jVi/QNh32JEf
         HDqueJp10bB/wBKKz1hwJpR4koFas8N7cgTtkzkAsletzIFMMIzo7hTnDD1VjwzS1rxZ
         20GKQxxuq6kbDYoJGsU1BP4oPfTSK7zp9bld07aAWesGMq/Z9DsR5VBjVXAtwzGDatGe
         rF7A==
X-Forwarded-Encrypted: i=1; AJvYcCXR4+nfzNMuEzrlIp683e2DO8a1iU9AHlJVYaV35pk7c1UThyJptVFKgtsJuZDDGhbHnbRXDlN1B0prWTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YywRRFhXUTEzy8vJR5cxNcH7BldnlzIL5pjTrQuCRtjOfS6anwy
	8ZOzIlWDD0IOgjruk8z1RLYjbnpxZL6/a24slzKv1leDscYQd+lYEAo3he1LbG+zehvexexHK8y
	QsFlL9Q==
X-Google-Smtp-Source: AGHT+IFa/DEWlqyexb9NXBm2CUUiJMwHO0NQypXq4kNJjdEZhDoVi6dbJfe11i8jnstusJCUTq1JNIQBgCj5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:c512:0:b0:e28:8f62:e735 with SMTP id
 3f1490d57ef6-e28936c055bmr5224276.1.1728158189715; Sat, 05 Oct 2024 12:56:29
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:24 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 14/31] perf dwarf-regs: Add EM_HOST and EF_HOST defines
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

Computed from the build architecture defines, EM_HOST and EF_HOST give
values that can be used in dwarf register lookup. Place in
dwarf-regs.h so the value can be shared. Move some dwarf-regs.c
constants used for EM_HOST to dwarf-regs.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         |  8 ----
 tools/perf/util/include/dwarf-regs.h | 72 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 5b7f86c0063f..7c01bc4d7e5b 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -13,14 +13,6 @@
 #include <errno.h>
 #include <linux/kernel.h>
 
-#ifndef EM_AARCH64
-#define EM_AARCH64	183  /* ARM 64 bit */
-#endif
-
-#ifndef EM_LOONGARCH
-#define EM_LOONGARCH	258 /* LoongArch */
-#endif
-
 /* Define const char * {arch}_register_tbl[] */
 #define DEFINE_DWARF_REGSTR_TABLE
 #include "../arch/x86/include/dwarf-regs-table.h"
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index fbdd7307e0c2..f4f87ded5e3d 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -2,6 +2,78 @@
 #ifndef _PERF_DWARF_REGS_H_
 #define _PERF_DWARF_REGS_H_
 #include "annotate.h"
+#include <elf.h>
+
+#ifndef EM_AARCH64
+#define EM_AARCH64	183  /* ARM 64 bit */
+#endif
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258 /* LoongArch */
+#endif
+
+/* EM_HOST gives the ELF machine for host, EF_HOST gives additional flags. */
+#if defined(__x86_64__)
+  #define EM_HOST EM_X86_64
+#elif defined(__i386__)
+  #define EM_HOST EM_386
+#elif defined(__aarch64__)
+  #define EM_HOST EM_AARCH64
+#elif defined(__arm__)
+  #define EM_HOST EM_ARM
+#elif defined(__alpha__)
+  #define EM_HOST EM_ALPHA
+#elif defined(__arc__)
+  #define EM_HOST EM_ARC
+#elif defined(__AVR__)
+  #define EM_HOST EM_AVR
+#elif defined(__AVR32__)
+  #define EM_HOST EM_AVR32
+#elif defined(__bfin__)
+  #define EM_HOST EM_BLACKFIN
+#elif defined(__csky__)
+  #define EM_HOST EM_CSKY
+  #if defined(__CSKYABIV2__)
+    #define EF_HOST EF_CSKY_ABIV2
+  #else
+    #define EF_HOST EF_CSKY_ABIV1
+  #endif
+#elif defined(__cris__)
+  #define EM_HOST EM_CRIS
+#elif defined(__hppa__) // HP PA-RISC
+  #define EM_HOST EM_PARISC
+#elif defined(__loongarch__)
+  #define EM_HOST EM_LOONGARCH
+#elif defined(__mips__)
+  #define EM_HOST EM_MIPS
+#elif defined(__m32r__)
+  #define EM_HOST EM_M32R
+#elif defined(__microblaze__)
+  #define EM_HOST EM_MICROBLAZE
+#elif defined(__MSP430__)
+  #define EM_HOST EM_MSP430
+#elif defined(__powerpc64__)
+  #define EM_HOST EM_PPC64
+#elif defined(__powerpc__)
+  #define EM_HOST EM_PPC
+#elif defined(__riscv)
+  #define EM_HOST EM_RISCV
+#elif defined(__s390x__)
+  #define EM_HOST EM_S390
+#elif defined(__sh__)
+  #define EM_HOST EM_SH
+#elif defined(__sparc64__) || defined(__sparc__)
+  #define EM_HOST EM_SPARC
+#elif defined(__xtensa__)
+  #define EM_HOST EM_XTENSA
+#else
+  /* Unknown host ELF machine type. */
+  #define EM_HOST EM_NONE
+#endif
+
+#if !defined(EF_HOST)
+  #define EF_HOST 0
+#endif
 
 #define DWARF_REG_PC  0xd3af9c /* random number */
 #define DWARF_REG_FB  0xd3affb /* random number */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


