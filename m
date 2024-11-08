Return-Path: <linux-kernel+bounces-402482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 705739C2844
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E876D1F229E6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3EC20DD4D;
	Fri,  8 Nov 2024 23:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hDNKJ3K"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2F2010E1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109579; cv=none; b=ciqrLW4mFKTjKlK0HZ6huDHv5pws6H5Q73ndXPlRKqmVCg8C8vEru31iw340EYXjllj/VxzkmH0QtrSLMRN1QmRaEqoFmkVlkRIdZONTXzsECCT6dZjVXCHv+a+YwkatTV5MiyXPeRB7E3Vhf4IdroS8YKHqog7tq4cd/M1v0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109579; c=relaxed/simple;
	bh=OwDjlEcg+VsWUJdyq+jgB5rvXnEcuLkLZjSg4pCEQeA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ivmLDxSTQpMI2Hnsv4YWa2k6Q4pt6hqF4YvGDGScs+qGfa21a0oo/59HtwBEM9MmFCJC3hlVY1KQpkaETLObUGAkaoVX3i4EPjHlmvfOfgB8RHhFwhUp7rjYMMKlzzKK5bug5ubcL+4PLNKmNqS2lhBQAzjKcXCndW4CIids1xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hDNKJ3K; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea95f530fdso51639057b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109577; x=1731714377; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g82RToWDBgAxXg56Q2NaJKBXk5A1APOL73D1eJS6XJQ=;
        b=1hDNKJ3K8cszdNB0APsaw/N6QzrcnvqvcB674YZz3OMo2eg9Z2SkvHdwtE26teFEj+
         7ZMCuLjOIxrfwC1AY+g2sIIw/htRhFh7Obm/Sv4dCDhvy1aGnSqnJGB9wZNkOAotHTkU
         d15rs84B/Z4ejTfoC9SlVjmuKJCf6+69g86JxVQn2GfXFag4o8dUxmlr9Z1rxkl+wNbG
         FpMBl87IJFzwmeTMnnQIt9zR3PEtx8HaYo+DqBuw4SXFKkYJJA2ECv3Psv4PEA3UR4Co
         JOQ+lieoOoNR8v4hSUWWyrnlrQw0A6RU9T/P4QaYmucEloOG+6djvN/qizqy3z+Ut9bm
         azSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109577; x=1731714377;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g82RToWDBgAxXg56Q2NaJKBXk5A1APOL73D1eJS6XJQ=;
        b=DcEuR7fKuMvP7pL8Kb0TKMIk0VlXh/1TiCUgq9Uaj1YoVc7kjPvNSOR715qgaEY/E5
         HTDPboiZuZP/V44WTXpTNuQxaZb71EXWCkZevQMErBhl0/eCFvfPc30fnmcZAKNEliZE
         id/AzbMR0UDNi6Mv9VQYkEvI8UxAOWyXnX91vRZcPny6gv2Y/Mr0QeFWnZqXVE8CGTGI
         HiPnevgiOFtdydoc1e5o3JUeTFkgDzHG3x/Hxdg9iMh9/b5ucxfyrUACYNF2ccnwlnU4
         OPJ4LZ4Y5lmEvCU+18L1io0uTpvAtyJfJw3eZVy84F6DKOWeMCimJZ8f8PSNexPRunkW
         xnrg==
X-Forwarded-Encrypted: i=1; AJvYcCXcLfXq+tfNrvaN2y3llqTM9BG9mg9fLd5Cb5cQO+H/ZPyoruDqEXs4lJ35PeJlKPjDhW+DIeNwr2SSXEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UkkzaV3bYUescminz2TbRDxHqfGQn1RMoV4pUB5aXtVOChV/
	4RAD2ZZwWbQy+Tw134SZ6EXjeeUVKVWByCHhCMqzEaYeMfVDqLh0GN0tyrf052bFXtLMHh3igEE
	Yst+Swg==
X-Google-Smtp-Source: AGHT+IElDJGck4lM83rJ1PEL9nymEB4MsWS2o56lAC0eXJqXdZF9OIb7Wse2J+4ISIY+n+Ta53vUnbF5wBR0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:142:0:b0:e29:6df8:ef58 with SMTP id
 3f1490d57ef6-e337f861ec6mr5903276.4.1731109576800; Fri, 08 Nov 2024 15:46:16
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:48 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 03/20] perf dwarf-regs: Add EM_HOST and EF_HOST defines
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

Computed from the build architecture defines, EM_HOST and EF_HOST give
values that can be used in dwarf register lookup. Place in
dwarf-regs.h so the value can be shared. Move some dwarf-regs.c
constants used for EM_HOST to dwarf-regs.h. Add CSky constants that
may be missing.

In disasm.c add an include of dwarf-regs.h as the included
arch/*/annotate/instructions.c files make use of the constants and we
want the elf.h/dwarf-regs.h dependency to be explicit.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.c             |  1 +
 tools/perf/util/dwarf-regs.c         |  8 ---
 tools/perf/util/include/dwarf-regs.h | 82 ++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
index bd98fec903f7..a525b80b934f 100644
--- a/tools/perf/util/disasm.c
+++ b/tools/perf/util/disasm.c
@@ -18,6 +18,7 @@
 #include "disasm.h"
 #include "disasm_bpf.h"
 #include "dso.h"
+#include "dwarf-regs.h"
 #include "env.h"
 #include "evsel.h"
 #include "map.h"
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
index fbdd7307e0c2..ce9f10b3282d 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -2,6 +2,88 @@
 #ifndef _PERF_DWARF_REGS_H_
 #define _PERF_DWARF_REGS_H_
 #include "annotate.h"
+#include <elf.h>
+
+#ifndef EM_AARCH64
+#define EM_AARCH64	183  /* ARM 64 bit */
+#endif
+
+#ifndef EM_CSKY
+#define EM_CSKY		252  /* C-SKY */
+#endif
+#ifndef EF_CSKY_ABIV1
+#define EF_CSKY_ABIV1	0X10000000
+#endif
+#ifndef EF_CSKY_ABIV2
+#define EF_CSKY_ABIV2	0X20000000
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
2.47.0.277.g8800431eea-goog


