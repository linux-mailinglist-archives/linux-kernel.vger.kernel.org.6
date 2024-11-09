Return-Path: <linux-kernel+bounces-402486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3D9C284D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494691C2194C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BED219E2B;
	Fri,  8 Nov 2024 23:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y0sHDccx"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6062123DB
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109589; cv=none; b=LhCWui4x5VO5zicttIsCaKin3FkCqeb7jieOxAfUc2lnlvfJXhuX5jDw41me1lrqKQtF/XP5+pZV48gvOjNfHs54cR+wyxKWMRQn9J/DOjAoz/7pbVlkzqoo9bVIxrHp3uCaSTDuCiW0FA5EH8Kd0IKNgEArCgbnd7E0fyCvIjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109589; c=relaxed/simple;
	bh=VZ3QmTDWnt0mL4or9djdBBUx6wuMiiToex4rE0QC+cs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=jnM3YBcIaHo+lTl3eWnjvEXU4K8+eorQXDJoHEf4P9KgrCdXKffTjptnylu6AaDZcG1LFYs9132eqqCIm+saardMleK2Db1L3z34TXaUx5ZvR3Q5vxv6BdbD+qmGcs2SGH1rOMrZh0DfLlz4lNtFOSW2hToFubIF8jced8Z08zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y0sHDccx; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292dbfd834so4640276276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 15:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109586; x=1731714386; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oow4OtdyMh21LhDXWHu2ONlu9AVRg6bZvmdssdGNUzo=;
        b=Y0sHDccxWuyUHHtYn6eRVZ/aowy5MmE4Ozs3VVvXZkXItqWyXtMKrsQNr7ynvNd15C
         D2d+Di/s54WiF8ji17szSY8RXMnE8H0Ai76SscJdXnAPM3WTcxKkGLZADVMHYR5v7d7c
         wo6Cxk8rliOyTf6f0qM+kRQ2B0zJELYYSusfuGVM970azx+GXUka9xUQleTmDvx788+Z
         pm46fHUAB3FohgIUVcJk5I/+tgP9t4ukarrPxq9qLe1hV7N4pNK6zbutSkx+KUAzdUiL
         2kfS2dnMSSyvKnAFeDUx2AHtMxkJ26oWq8vPR/YHeFL09eRCF00HmeKWAMqcUld8bYdj
         wbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109586; x=1731714386;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oow4OtdyMh21LhDXWHu2ONlu9AVRg6bZvmdssdGNUzo=;
        b=ORuE1vLl6qRmfDyNolAi1Z/NPmsEJofJRCKMP60nOMXx/neYY5CN/LFkdreOoZlFvw
         TAy25wUrlTPLzHfvXxk/4qPnPXYkDdREuvcidoIoleM0ftNKVYdKKTeyxGhP5YqaO2rq
         Nm9w8y8wxg4mFrsa+H/809uYsLH+cbViuRSsPobQ73KzqrTcQidIRABcMtuRuMUQIIL7
         q+WesR2gaK9hzW/HXjsI+G0EeFx0F1DiwowdZwis1ufJVKZQxhRlDdceYpUWgTmNVulM
         03gCVgJ8xaLkOybrtxMhOtS8LwMiEAIjiI771+Y4aUe/1CLHnSG2qyDZ4p/CEGIdIjLh
         jQfA==
X-Forwarded-Encrypted: i=1; AJvYcCV8AP38PpNhtbnmFx1n+qvfKpP6h3D/WHGFtbCK5KKY3t8hmeQLo3vqWkXwnaKiSeKEYj0wLeexkHALjTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YweJhFvPMp7w92yZxnURsRhvsYKC5NRz7OJqrZjUatGTuStzZ6Z
	8A01wBno8aqaRdyItB2Jm34bu8aPrfalpHvtW3jTobEmelHoM0OsTMtpGZuxVN97XMZlGJfPk0U
	CehSB4w==
X-Google-Smtp-Source: AGHT+IHKhqVSgLqE3aKoJujJ2ynMX9CVA4id4xj8yQcV+relp1ZbhH/KTZnsnSlV1M1UfS+yayKDorj3sbkk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a5b:70a:0:b0:e28:e6a1:fc53 with SMTP id
 3f1490d57ef6-e337f8c6c5dmr11688276.5.1731109586518; Fri, 08 Nov 2024 15:46:26
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:52 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 07/20] perf dwarf-regs: Move x86 dwarf-regs out of arch
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

Move arch/x86/util/dwarf-regs.c to util/dwarf-regs-x86.c and compile
in unconditionally. To avoid get_arch_regnum being duplicated, rename
to get_x86_regnum and add to get_dwarf_regnum switch.

For get_arch_regstr, this was unused on x86 unless the machine type
was EM_NONE. Map that case to EM_HOST and remove get_arch_regstr from
dwarf-regs-x86.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
index bc56a8e70f34..848327378694 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -11,9 +11,6 @@ perf-util-y += mem-events.o
 perf-util-y += evsel.o
 perf-util-y += iostat.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
-perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
-
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 1eedead5f2f2..4c615611b9d7 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -203,6 +203,7 @@ endif
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
index 0ef428d07bcc..6aa66c375942 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -89,7 +89,10 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
+#if !defined(__x86_64__) && !defined(__i386__)
 const char *get_arch_regstr(unsigned int n);
+#endif
+
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
@@ -98,7 +101,12 @@ const char *get_arch_regstr(unsigned int n);
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
2.47.0.277.g8800431eea-goog


