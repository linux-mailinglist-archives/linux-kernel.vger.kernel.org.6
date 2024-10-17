Return-Path: <linux-kernel+bounces-368948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861D9A16F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 183A8286B40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944AE5661;
	Thu, 17 Oct 2024 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x7o3/Wt/"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB921E498
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124736; cv=none; b=Igl/bzin9wEXI3sCkAvIgGUaLtbITV/0PvtMaQ57OksKapyWnEGaWwK/BX2rjAJijJ8Td13s/RVgXYiRZANgjBKu9uXmELQh95s8wLy/dn7BcIItysgePYue+CSsCL/1tvLzCJx2jd5Xgqjr5ruZ43vPrwH4H9T6J2VAJUqjtSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124736; c=relaxed/simple;
	bh=RXHl40JBthAQkhSPp00Rrv1IKF2asm6rRGu2vt5jJgE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iDhxqed8P0CDDeT/U8lAKuJ+aEUiJT8Q2dyj7aDCRRkH1du42kTUXyrR7hBCwLbo9PvcjfQCq/ZJy4hrG2vzAYuI078rbGvQkPRfJU1fLWV8ZLEk6LWGWJ5rML1XOnsy1DYvvveJoIbYoSgTv2jklsyVwCvp/1YIxMbkS78VPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x7o3/Wt/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3529d80e5so8568087b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124733; x=1729729533; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NsEr7msd173iKSV9/VCmecavKBITUiPRN43mS0QcMU=;
        b=x7o3/Wt/jXzzc3xJ+2WGMHY2XqLP/CvxczY1S7XsuYCjhFh0MFS9z1ocRpE8OaUtXN
         0KbIXoEBjmK9dOv/FmThRYFG2tPj73z/iMwuNzLcAkgNsg1Rsb1Au9G/LDAsqjjBRhTX
         I6PiMUZBafGqrdiyKEHgI9WW4+ynS+42SMCjbOMThBZU1hXYhIlgUWx2hFUdRiwLnseV
         3UHivSdvgcT1kgowFoll6/EfldG9qjbBBP50/caeOycveZNJjxX1F9mN7SvGy4sDt7C6
         uFULXbtVvSfsp4U7HYEBkrt3lE/ztmCF4QCrMzFMzEYAIUQutL+ME6J6J+nFHIx1yDdI
         yXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124733; x=1729729533;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NsEr7msd173iKSV9/VCmecavKBITUiPRN43mS0QcMU=;
        b=Kzr0PPZWZCI+84u589KBKd7/gEtvgON2/MjYsYwZvEBLQ1pUAbvyzG7mjCaGzPFgOG
         IcA9ED/3XfuqHA43z1eQwF2cWH4NftEgmZKKfDwFx4Hybhjw9B3cF11pLOLV8oFfgE5W
         zeDMyuqSQDyVydLx/Q67E/GLuz/h8Qg4wFv0C/n5O1Y+JeSA2m8BV9EOIdD5rKVuKjri
         FZtD7iFwZMOzYNNvRoU4TeCNlK6eOLGUJeG2q2RzHBvvuNRNrLx7cscL4UgGuZBwWq26
         T612iYKMOMf8xHMspqt0QMKTyeo98U1vUFu95vznlrG9RjDSdbxI2jOHpoD1as/waew0
         slPw==
X-Forwarded-Encrypted: i=1; AJvYcCWEyKeIhSwRD8RiljmwGwilcx3RFWsyac1tMHt57qCxuMKx2tQPl0Ls+vGqRECuQqhtpWJrE0aB/gF48t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4aaZ9tn93khWTZV5TGxzeu6T9zxb9/4Qj9yKZCDQGm4spWBC
	jVfNVGchWuWMGUEmqCFM4iyZHgP1juG+TAHkYG+x+NIFWzRF2szOR6lkZkVxMDren/1EFr55jhy
	aiUC9Lw==
X-Google-Smtp-Source: AGHT+IGgUPEeAoj0GCHJRw0hDSDrqo6vL+2D8u0aKVLNqtcDlviAMIAP2xZin6A4jNkd/xtNmfp3B0Sj1e8R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:6993:b0:6e2:1b8c:39bf with SMTP
 id 00721157ae682-6e3d3f7f6fdmr1369657b3.2.1729124732661; Wed, 16 Oct 2024
 17:25:32 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:02 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 02/20] perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
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

PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET was used for BPF prologue
support which was removed in Commit 3d6dfae88917 ("perf parse-events:
Remove BPF event support"). The code is no longer used so remove.

Remove the offset from various dwarf-regs.c tables and the dependence
on ptrace.h. Rename structs starting pt_ as the ptrace derived offset is
now removed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config                  |   4 -
 tools/perf/arch/arm64/Makefile              |   1 -
 tools/perf/arch/arm64/util/dwarf-regs.c     |  20 +---
 tools/perf/arch/loongarch/Makefile          |   1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c |  10 --
 tools/perf/arch/powerpc/Makefile            |   1 -
 tools/perf/arch/powerpc/util/dwarf-regs.c   |  26 ++---
 tools/perf/arch/riscv/Makefile              |   1 -
 tools/perf/arch/riscv/util/dwarf-regs.c     |  14 +--
 tools/perf/arch/s390/Makefile               |   1 -
 tools/perf/arch/s390/util/dwarf-regs.c      |  27 -----
 tools/perf/arch/x86/Makefile                |   1 -
 tools/perf/arch/x86/util/dwarf-regs.c       | 109 +++-----------------
 tools/perf/util/include/dwarf-regs.h        |   8 --
 14 files changed, 27 insertions(+), 197 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index b93ed2b7623f..1d3f7dcc6b66 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -203,10 +203,6 @@ FEATURE_CHECK_CFLAGS-bpf = -I. -I$(srctree)/tools/include -I$(srctree)/tools/arc
 # include ARCH specific config
 -include $(src-perf)/arch/$(SRCARCH)/Makefile
 
-ifdef PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-  CFLAGS += -DHAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-endif
-
 include $(srctree)/tools/scripts/utilities.mak
 
 ifeq ($(call get-executable,$(FLEX)),)
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index 8a5ffbfe809f..ca2e35961287 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -3,7 +3,6 @@ ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 PERF_HAVE_JITDUMP := 1
-PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
 #
diff --git a/tools/perf/arch/arm64/util/dwarf-regs.c b/tools/perf/arch/arm64/util/dwarf-regs.c
index 917b97d7c5d3..343a62fa4199 100644
--- a/tools/perf/arch/arm64/util/dwarf-regs.c
+++ b/tools/perf/arch/arm64/util/dwarf-regs.c
@@ -9,10 +9,9 @@
 #include <stddef.h>
 #include <string.h>
 #include <dwarf-regs.h>
-#include <linux/ptrace.h> /* for struct user_pt_regs */
 #include <linux/stringify.h>
 
-struct pt_regs_dwarfnum {
+struct regs_dwarfnum {
 	const char *name;
 	unsigned int dwarfnum;
 };
@@ -21,14 +20,12 @@ struct pt_regs_dwarfnum {
 #define GPR_DWARFNUM_NAME(num) \
 	{.name = __stringify(%x##num), .dwarfnum = num}
 #define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-#define DWARFNUM2OFFSET(index) \
-	(index * sizeof((struct user_pt_regs *)0)->regs[0])
 
 /*
  * Reference:
  * http://infocenter.arm.com/help/topic/com.arm.doc.ihi0057b/IHI0057B_aadwarf64.pdf
  */
-static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
+static const struct regs_dwarfnum regdwarfnum_table[] = {
 	GPR_DWARFNUM_NAME(0),
 	GPR_DWARFNUM_NAME(1),
 	GPR_DWARFNUM_NAME(2),
@@ -74,19 +71,10 @@ static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
  */
 const char *get_arch_regstr(unsigned int n)
 {
-	const struct pt_regs_dwarfnum *roff;
+	const struct regs_dwarfnum *roff;
+
 	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
 		if (roff->dwarfnum == n)
 			return roff->name;
 	return NULL;
 }
-
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_dwarfnum *roff;
-
-	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return DWARFNUM2OFFSET(roff->dwarfnum);
-	return -EINVAL;
-}
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 1cc5eb01f32b..79b432744296 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -2,7 +2,6 @@
 ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
-PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/loongarch/util/dwarf-regs.c b/tools/perf/arch/loongarch/util/dwarf-regs.c
index 0f6ebc387463..bee08fdcf2fd 100644
--- a/tools/perf/arch/loongarch/util/dwarf-regs.c
+++ b/tools/perf/arch/loongarch/util/dwarf-regs.c
@@ -32,13 +32,3 @@ const char *get_arch_regstr(unsigned int n)
 	n %= 32;
 	return loongarch_gpr_table[n].name;
 }
-
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_dwarfnum *roff;
-
-	for (roff = loongarch_gpr_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->dwarfnum;
-	return -EINVAL;
-}
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index 7672d555f6cd..ae05727835d8 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -4,7 +4,6 @@ PERF_HAVE_DWARF_REGS := 1
 endif
 
 HAVE_KVM_STAT_SUPPORT := 1
-PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
 
 #
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 104c7ae5c433..23846c59a522 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -9,29 +9,25 @@
 #include <errno.h>
 #include <string.h>
 #include <dwarf-regs.h>
-#include <linux/ptrace.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 
-struct pt_regs_dwarfnum {
+struct regs_dwarfnum {
 	const char *name;
 	unsigned int dwarfnum;
-	unsigned int ptregs_offset;
 };
 
 #define REG_DWARFNUM_NAME(r, num)					\
-		{.name = __stringify(%)__stringify(r), .dwarfnum = num,			\
-		.ptregs_offset = offsetof(struct pt_regs, r)}
+	{.name = __stringify(%)__stringify(r), .dwarfnum = num}
 #define GPR_DWARFNUM_NAME(num)						\
-		{.name = __stringify(%gpr##num), .dwarfnum = num,		\
-		.ptregs_offset = offsetof(struct pt_regs, gpr[num])}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0, .ptregs_offset = 0}
+	{.name = __stringify(%gpr##num), .dwarfnum = num}
+#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
 
 /*
  * Reference:
  * http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
  */
-static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
+static const struct regs_dwarfnum regdwarfnum_table[] = {
 	GPR_DWARFNUM_NAME(0),
 	GPR_DWARFNUM_NAME(1),
 	GPR_DWARFNUM_NAME(2),
@@ -83,22 +79,14 @@ static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
  */
 const char *get_arch_regstr(unsigned int n)
 {
-	const struct pt_regs_dwarfnum *roff;
+	const struct regs_dwarfnum *roff;
+
 	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
 		if (roff->dwarfnum == n)
 			return roff->name;
 	return NULL;
 }
 
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_dwarfnum *roff;
-	for (roff = regdwarfnum_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->ptregs_offset;
-	return -EINVAL;
-}
-
 #define PPC_OP(op)	(((op) >> 26) & 0x3F)
 #define PPC_RA(a)	(((a) >> 16) & 0x1f)
 #define PPC_RT(t)	(((t) >> 21) & 0x1f)
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index 4664a78a1afd..f01ab2171fd0 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,6 +1,5 @@
 ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
-PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/riscv/util/dwarf-regs.c b/tools/perf/arch/riscv/util/dwarf-regs.c
index cd0504c02e2e..a9c4402ae57e 100644
--- a/tools/perf/arch/riscv/util/dwarf-regs.c
+++ b/tools/perf/arch/riscv/util/dwarf-regs.c
@@ -9,7 +9,7 @@
 #include <string.h> /* for strcmp */
 #include <dwarf-regs.h>
 
-struct pt_regs_dwarfnum {
+struct regs_dwarfnum {
 	const char *name;
 	unsigned int dwarfnum;
 };
@@ -17,7 +17,7 @@ struct pt_regs_dwarfnum {
 #define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
 #define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
 
-struct pt_regs_dwarfnum riscv_dwarf_regs_table[] = {
+struct regs_dwarfnum riscv_dwarf_regs_table[] = {
 	REG_DWARFNUM_NAME("%zero", 0),
 	REG_DWARFNUM_NAME("%ra", 1),
 	REG_DWARFNUM_NAME("%sp", 2),
@@ -60,13 +60,3 @@ const char *get_arch_regstr(unsigned int n)
 {
 	return (n < RISCV_MAX_REGS) ? riscv_dwarf_regs_table[n].name : NULL;
 }
-
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_dwarfnum *roff;
-
-	for (roff = riscv_dwarf_regs_table; roff->name; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->dwarfnum;
-	return -EINVAL;
-}
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 3f66e2ede3f7..58e79f5b67a4 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -3,7 +3,6 @@ ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
-PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
 
 #
diff --git a/tools/perf/arch/s390/util/dwarf-regs.c b/tools/perf/arch/s390/util/dwarf-regs.c
index dfddb3099bfa..5bcf3192623a 100644
--- a/tools/perf/arch/s390/util/dwarf-regs.c
+++ b/tools/perf/arch/s390/util/dwarf-regs.c
@@ -7,37 +7,10 @@
  *
  */
 
-#include <errno.h>
-#include <stddef.h>
-#include <stdlib.h>
 #include <linux/kernel.h>
-#include <asm/ptrace.h>
-#include <string.h>
-#include <dwarf-regs.h>
 #include "dwarf-regs-table.h"
 
 const char *get_arch_regstr(unsigned int n)
 {
 	return (n >= ARRAY_SIZE(s390_dwarf_regs)) ? NULL : s390_dwarf_regs[n];
 }
-
-/*
- * Convert the register name into an offset to struct pt_regs (kernel).
- * This is required by the BPF prologue generator.  The BPF
- * program is called in the BPF overflow handler in the perf
- * core.
- */
-int regs_query_register_offset(const char *name)
-{
-	unsigned long gpr;
-
-	if (!name || strncmp(name, "%r", 2))
-		return -EINVAL;
-
-	errno = 0;
-	gpr = strtoul(name + 2, NULL, 10);
-	if (errno || gpr >= 16)
-		return -EINVAL;
-
-	return offsetof(user_pt_regs, gprs) + 8 * gpr;
-}
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 9aa58acb5564..51cf267f4d85 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -3,7 +3,6 @@ ifndef NO_LIBDW
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
-PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1
 
 ###
diff --git a/tools/perf/arch/x86/util/dwarf-regs.c b/tools/perf/arch/x86/util/dwarf-regs.c
index 399c4a0a29d8..530905118cd4 100644
--- a/tools/perf/arch/x86/util/dwarf-regs.c
+++ b/tools/perf/arch/x86/util/dwarf-regs.c
@@ -6,112 +6,31 @@
  * Written by Masami Hiramatsu <mhiramat@redhat.com>
  */
 
-#include <stddef.h>
 #include <errno.h> /* for EINVAL */
 #include <string.h> /* for strcmp */
-#include <linux/ptrace.h> /* for struct pt_regs */
-#include <linux/kernel.h> /* for offsetof */
+#include <linux/kernel.h> /* for ARRAY_SIZE */
 #include <dwarf-regs.h>
 
-/*
- * See arch/x86/kernel/ptrace.c.
- * Different from it:
- *
- *  - Since struct pt_regs is defined differently for user and kernel,
- *    but we want to use 'ax, bx' instead of 'rax, rbx' (which is struct
- *    field name of user's pt_regs), we make REG_OFFSET_NAME to accept
- *    both string name and reg field name.
- *
- *  - Since accessing x86_32's pt_regs from x86_64 building is difficult
- *    and vise versa, we simply fill offset with -1, so
- *    get_arch_regstr() still works but regs_query_register_offset()
- *    returns error.
- *    The only inconvenience caused by it now is that we are not allowed
- *    to generate BPF prologue for a x86_64 kernel if perf is built for
- *    x86_32. This is really a rare usecase.
- *
- *  - Order is different from kernel's ptrace.c for get_arch_regstr(). Use
- *    the order defined by dwarf.
- */
+#define DEFINE_DWARF_REGSTR_TABLE 1
+#include "dwarf-regs-table.h"
 
-struct pt_regs_offset {
-	const char *name;
-	int offset;
-};
-
-#define REG_OFFSET_END {.name = NULL, .offset = 0}
-
-#ifdef __x86_64__
-# define REG_OFFSET_NAME_64(n, r) {.name = n, .offset = offsetof(struct pt_regs, r)}
-# define REG_OFFSET_NAME_32(n, r) {.name = n, .offset = -1}
+/* Return architecture dependent register string (for kprobe-tracer) */
+const char *get_arch_regstr(unsigned int n)
+{
+#if defined(__i386__)
+	size_t len = ARRAY_SIZE(x86_32_regstr_tbl);
 #else
-# define REG_OFFSET_NAME_64(n, r) {.name = n, .offset = -1}
-# define REG_OFFSET_NAME_32(n, r) {.name = n, .offset = offsetof(struct pt_regs, r)}
+	size_t len = ARRAY_SIZE(x86_64_regstr_tbl);
 #endif
 
-/* TODO: switching by dwarf address size */
-#ifndef __x86_64__
-static const struct pt_regs_offset x86_32_regoffset_table[] = {
-	REG_OFFSET_NAME_32("%ax",	eax),
-	REG_OFFSET_NAME_32("%cx",	ecx),
-	REG_OFFSET_NAME_32("%dx",	edx),
-	REG_OFFSET_NAME_32("%bx",	ebx),
-	REG_OFFSET_NAME_32("$stack",	esp),	/* Stack address instead of %sp */
-	REG_OFFSET_NAME_32("%bp",	ebp),
-	REG_OFFSET_NAME_32("%si",	esi),
-	REG_OFFSET_NAME_32("%di",	edi),
-	REG_OFFSET_END,
-};
+	if (n >= len)
+		return NULL;
 
-#define regoffset_table x86_32_regoffset_table
+#if defined(__i386__)
+	return x86_32_regstr_tbl[n];
 #else
-static const struct pt_regs_offset x86_64_regoffset_table[] = {
-	REG_OFFSET_NAME_64("%ax",	rax),
-	REG_OFFSET_NAME_64("%dx",	rdx),
-	REG_OFFSET_NAME_64("%cx",	rcx),
-	REG_OFFSET_NAME_64("%bx",	rbx),
-	REG_OFFSET_NAME_64("%si",	rsi),
-	REG_OFFSET_NAME_64("%di",	rdi),
-	REG_OFFSET_NAME_64("%bp",	rbp),
-	REG_OFFSET_NAME_64("%sp",	rsp),
-	REG_OFFSET_NAME_64("%r8",	r8),
-	REG_OFFSET_NAME_64("%r9",	r9),
-	REG_OFFSET_NAME_64("%r10",	r10),
-	REG_OFFSET_NAME_64("%r11",	r11),
-	REG_OFFSET_NAME_64("%r12",	r12),
-	REG_OFFSET_NAME_64("%r13",	r13),
-	REG_OFFSET_NAME_64("%r14",	r14),
-	REG_OFFSET_NAME_64("%r15",	r15),
-	REG_OFFSET_END,
-};
-
-#define regoffset_table x86_64_regoffset_table
+	return x86_64_regstr_tbl[n];
 #endif
-
-/* Minus 1 for the ending REG_OFFSET_END */
-#define ARCH_MAX_REGS ((sizeof(regoffset_table) / sizeof(regoffset_table[0])) - 1)
-
-/* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < ARCH_MAX_REGS) ? regoffset_table[n].name : NULL;
-}
-
-/* Reuse code from arch/x86/kernel/ptrace.c */
-/**
- * regs_query_register_offset() - query register offset from its name
- * @name:	the name of a register
- *
- * regs_query_register_offset() returns the offset of a register in struct
- * pt_regs from its name. If the name is invalid, this returns -EINVAL;
- */
-int regs_query_register_offset(const char *name)
-{
-	const struct pt_regs_offset *roff;
-	for (roff = regoffset_table; roff->name != NULL; roff++)
-		if (!strcmp(roff->name, name))
-			return roff->offset;
-	return -EINVAL;
 }
 
 struct dwarf_regs_idx {
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 29a7d0546b82..fbdd7307e0c2 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -42,12 +42,4 @@ static inline void get_powerpc_regs(u32 raw_insn __maybe_unused, int is_source _
 void get_powerpc_regs(u32 raw_insn, int is_source, struct annotated_op_loc *op_loc);
 #endif
 
-#ifdef HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
-/*
- * Arch should support fetching the offset of a register in pt_regs
- * by its name. See kernel's regs_query_register_offset in
- * arch/xxx/kernel/ptrace.c.
- */
-int regs_query_register_offset(const char *name);
-#endif
 #endif
-- 
2.47.0.105.g07ac214952-goog


