Return-Path: <linux-kernel+bounces-352113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85D4991A4D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 22:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AD01F21BB6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0028186E51;
	Sat,  5 Oct 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORLCPsL6"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66257185B57
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158201; cv=none; b=QgsyjhWCfnqEOB8516JTBuVCDgmTpxknygjbehAG6jCCAueFlQlI/33fZccDGZ6yE1MXQeUxGxChXiAZueSHRhB4jP1k6EWFLKeQvtE3kZwaGFaR+iuhpsve6FXGkZaF4ztty7xcDTLnQmmWINYjCGJF9nBGq2Rxv9sNejrGksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158201; c=relaxed/simple;
	bh=49KaBYkgiQCH/sxX0+BhoWOtHOvGgEnOu9KKe+ceHgg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lIIYy9xvxpqFztoo9zO4DCJH/vtWyVEN4wIOcKLFVaycZYScpUS13t1b0jWErwJXCtZteo16a96MIk2u3354bewXaLJmb/jHhqtUPaeUsP2qVH0+NokcPgeiq76YJ799gIUUWuVFmNGTkRjbUuatBLDTlFy2D3jymHDIrB9M5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ORLCPsL6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e28694ff555so4916775276.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158198; x=1728762998; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNGVUzOXKwKEko/OAaLmYeM8n2VtlYeblr7R3DSaWhY=;
        b=ORLCPsL6p0veqUhFpPZTFKJHjs6NeUfpWfnXfw0kRnL32WZYv998UQXrm2YKOO70Tm
         SanYNZm9wg+CJOUoSbSNIYj5iqnDk9JoofL96VE+c0FJ4o27KBNzXFl/fagJRbR3qecB
         A6m7J5xoRLzd28ifbWsrYiXc3SaZK7vF8XQEAVsbEkWZAFvdadRYdu9TYMk9zlziJSiP
         L4SsKrcps34T90ZHYRxlXc4DagwZXYpUQftfOT56E2bs/eEFbXPr4ZjXEAeuCGxMNEF2
         CzscSHHSNWeXAzY6gkCybxRl7pp6ntmGVxXil1042jXSJr9ZixzaN8fBmFpl/9PJz4Jd
         m/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158198; x=1728762998;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNGVUzOXKwKEko/OAaLmYeM8n2VtlYeblr7R3DSaWhY=;
        b=OAOA8ho8QyMKUsBKNLwwD4XulOJCY0nI1OKT6fS24UFPV/9OgkF83K7tvLTwCsdHf0
         FIaiXIZ7rp55n5vokwhcmNOSL86kPPGGcj32qYiC2wld+CNUnE/fpiH4TIzhG1RA1K2x
         B4pXJ3v+aDzKZvJOMbnfX2k6xGKtRr8r8RAobSWaI8ZHUEXsk9QrYcBBKfmh7wK+lVyO
         uI1FQ00Tk6y3MKYR071HmW4Kqc6XHVobJYkYFrhu0Wp3kwNi7n6a+g8gL6wDrwua8JK1
         yNdJNSB5ppeeCr2/+ug2m+g2qVQl0c8Sc/HiA2/q2vSpaOpMPVjr3ygEFSK5dBx+brMA
         epcA==
X-Forwarded-Encrypted: i=1; AJvYcCVMZut0QqNWkFj9Vfe4ue6lBVtCDUfQmYAKHrLCJucDKLLrXQhPoAfYbbGHi82IkIa8IpdONiavGFYuQb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMX8KMBvgwxBBUX+v1SrrCsqLaa3L8NXBBgqsTPiRvLiND2BYM
	u5IlYm1UTxpMmj1CMMwISKBtkymDGk7oX8P7nwCzVrwLReY3WrktlHl4t21haPfixIx1QwneATk
	ItN3yqw==
X-Google-Smtp-Source: AGHT+IFzfrKFHBTJFAcCSdwh/qg6jN5gpz4SXfcgyMqV1tiB3/k6fNsR9y4uPMkIlIzDZudO3VL2v9PECHkd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:d003:0:b0:e24:a28e:9399 with SMTP id
 3f1490d57ef6-e28936d2d3bmr4324276.4.1728158198436; Sat, 05 Oct 2024 12:56:38
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:28 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-19-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 18/31] perf dwarf-regs: Move x86 dwarf-regs out of arch
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

Move arch/x86/util/dwarf-regs.c to util/dwarf-regs-x86.c and compile
in unconditionally. To avoid get_arch_regnum being duplicated, rename
to get_x86_regnum and add to get_dwarf_regnum switch.

For get_arch_regstr, this was unused on x86 unless the machine type
was EM_NONE. Map that case to EM_HOST and remove get_arch_regstr from
dwarf-regs-x86.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/Build                |  3 ---
 tools/perf/util/Build                         |  1 +
 .../dwarf-regs.c => util/dwarf-regs-x86.c}    | 24 +------------------
 tools/perf/util/dwarf-regs.c                  | 17 +++++++++++++
 tools/perf/util/include/dwarf-regs.h          |  8 +++++++
 5 files changed, 27 insertions(+), 26 deletions(-)
 rename tools/perf/{arch/x86/util/dwarf-regs.c => util/dwarf-regs-x86.c} (77%)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 9705cda4f240..70af491a6dd7 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -12,9 +12,6 @@ perf-util-y += evsel.o
 perf-util-y += iostat.o
 perf-util-y += env.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
-perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
-
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1d08608b7e1b..c2221ef431f3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -202,6 +202,7 @@ endif
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 
diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/util/dwarf-regs-x86.c
similarity index 77%
rename from tools/perf/arch/x86/util/dwarf-regs.c
rename to tools/perf/util/dwarf-regs-x86.c
index 530905118cd4..7a55c65e8da6 100644
--- a/tools/perf/arch/x86/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs-x86.c
@@ -11,28 +11,6 @@
 #include <linux/kernel.h> /* for ARRAY_SIZE */
 #include <dwarf-regs.h>
 
-#define DEFINE_DWARF_REGSTR_TABLE 1
-#include "dwarf-regs-table.h"
-
-/* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_arch_regstr(unsigned int n)
-{
-#if defined(__i386__)
-	size_t len = ARRAY_SIZE(x86_32_regstr_tbl);
-#else
-	size_t len = ARRAY_SIZE(x86_64_regstr_tbl);
-#endif
-
-	if (n >= len)
-		return NULL;
-
-#if defined(__i386__)
-	return x86_32_regstr_tbl[n];
-#else
-	return x86_64_regstr_tbl[n];
-#endif
-}
-
 struct dwarf_regs_idx {
 	const char *name;
 	int idx;
@@ -58,7 +36,7 @@ static const struct dwarf_regs_idx x86_regidx_table[] = {
 	{ "rip", DWARF_REG_PC },
 };
 
-int get_arch_regnum(const char *name)
+int get_x86_regnum(const char *name)
 {
 	unsigned int i;
 
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 86b3ef638fbb..eac99a246737 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,9 +32,17 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 			     unsigned int flags __maybe_unused)
 {
+#if EM_HOST == EM_X86_64 || EM_HOST == EM_386
+	if (machine == EM_NONE) {
+		/* Generic arch - use host arch */
+		machine = EM_HOST;
+	}
+#endif
 	switch (machine) {
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
+#endif
 	case EM_386:
 		return __get_dwarf_regstr(x86_32_regstr_tbl, n);
 	case EM_X86_64:
@@ -65,10 +73,12 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
 	return NULL;
 }
 
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
 __weak int get_arch_regnum(const char *name __maybe_unused)
 {
 	return -ENOTSUP;
 }
+#endif
 
 /* Return DWARF register number from architecture register name */
 int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
@@ -90,9 +100,16 @@ int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags
 		machine = EM_HOST;
 	}
 	switch (machine) {
+#if EM_HOST != EM_X86_64 && EM_HOST != EM_386
 	case EM_HOST:
 		reg = get_arch_regnum(regname);
 		break;
+#endif
+	case EM_X86_64:
+		fallthrough;
+	case EM_386:
+		reg = get_x86_regnum(regname);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 	}
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 925525405e2d..062623aefd5a 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -79,7 +79,10 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
+#if !defined(__x86_64__) && !defined(__i386__)
 const char *get_arch_regstr(unsigned int n);
+#endif
+
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
@@ -88,7 +91,12 @@ const char *get_arch_regstr(unsigned int n);
  */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags);
 
+int get_x86_regnum(const char *name);
+
+#if !defined(__x86_64__) && !defined(__i386__)
 int get_arch_regnum(const char *name);
+#endif
+
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
  * name: architecture register name
-- 
2.47.0.rc0.187.ge670bccf7e-goog


