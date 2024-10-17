Return-Path: <linux-kernel+bounces-368961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620089A170D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E456A1F21BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D67179956;
	Thu, 17 Oct 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTj2n29T"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81A175D32
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124767; cv=none; b=jvMVpVHAG0Po4PhXesKJdUCkkKwnKZXO59OwdAX3LZ4mVbxrYVdjOOoEO/ONfJVf18xjgrhTTF+Zq0ZHD7YZrcy6wiCslhtSUiRkmOBVrkzEkiJzOUNQ8boDiW4GSXueq454ZjE6PRqNnCqo/3gnSYy19jLGsLuCNAzEeRMbtjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124767; c=relaxed/simple;
	bh=avKPqbsQizfnd2YaF1SHUwMDk34bvOtZlva5/e8fDQ0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=s7opq58ZO1MWZVfijob9+u5E5CvCVFrdlO2A/SsLz1p830lqdfULvN5/3ykBy04MTm/Mlx9D+2ansQseDeoX4UW+VsC6nwXorMaS74G5KyahDt94QDxd0diC9cvSxnSDAAoqTRBzXkJ+VczL6dp8iX99nLPFzEaAnjdG8swGU3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NTj2n29T; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d660a1afso9874287b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124765; x=1729729565; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+vS3pAQ+haKP/8iv+6aAP7RJEQP9tkb6yzoJLAeVBwY=;
        b=NTj2n29T8tyxXH48+YcDJWEe6QU4Kxki2vLiHHWHi3wB9MZbcE5D9HSbnbMnikpSJK
         DMME9fQ+4DAXgaGN37pzbwNGVZ3Cy+Z4O9PTiJ/5J2sqUWd7E67I2JtP9te9m7vtcYMn
         i5vQwJKi6inBKihEKfWpGS1b27yv0vymz22NuFsQKkKfQ5DipIhc8kndnF6zo79XrW8R
         xh5HAJnF1Vkt4NiT+QybOaUBnSj38Qkkjz3WYEWHnFpP6inq56PlzLSLwuvBl7IGsgm3
         O8f0+T9jlA38jHlewtFyU0Cbq0TiqLrP8gMe48Y10FYbycdNSTUjbTyefdyLI159CRK0
         A9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124765; x=1729729565;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vS3pAQ+haKP/8iv+6aAP7RJEQP9tkb6yzoJLAeVBwY=;
        b=EfLJoTgCQrPqetXwfsu6Y1/+LeF3g/ClHKdimXjQhQ/tNnGjgy8b0zO/eJwGndL9vm
         Kza4ahy5UZvOLoDeMCwdZMIGUWqr/TrlCEA8CTinVY4m984KQu2Y3DuS02j3+M2+2aTV
         mHvm/xa/QHB2m9vHbQN9GP0vDRwe297kOm9CXlAWXt4K0y0ht6at/+1GG9jQqJQqIZxL
         tgo+YBOgejZrlTDQpd7NEFo5Fv4vgvNidTHGf9hNI//vvpks3fKx+4vKFXctpFRHDCUG
         OCCxsXrH/+gG78drjkJNobHao8WKH2bq2DRu2tXIwjWXHimXo4QTHtsrw8DWzNDbs8pl
         vfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcWGH6bF2dsaq6zFBqGtno3vzZcz/7HzQtLZw7Hw1T0L7H+yRYqBMzM+AxAPICkoudMoWVg/RlWqGyNnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNvlZV4jfYdZV48D+ZeP+CWhBEvn8pTOn9R7lvC4FlovTbLXLz
	Fok0351BjCnO/9tjQJitb7chp0NaL5v1JQ9TOXO5UuWE2f0qdukK1J/ACpZt8RoOp1KzjRscL1/
	EA5dh4g==
X-Google-Smtp-Source: AGHT+IHww5hKkYtrtEd7xFxuwiqgL1g9EP1jrDvOSFsM0YJ3aBoaypiL1q7z5gT/re1gw8cKAYiVLMh2TMTK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:9a84:b0:6e3:19d7:382a with SMTP
 id 00721157ae682-6e3d3f7f52fmr1338867b3.1.1729124764951; Wed, 16 Oct 2024
 17:26:04 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:15 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 15/20] perf s390: Remove dwarf-regs.c
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
EM_NONE cases for s390 in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/s390/util/Build        |  1 -
 tools/perf/arch/s390/util/dwarf-regs.c | 16 ----------------
 tools/perf/util/dwarf-regs.c           |  4 ++--
 tools/perf/util/include/dwarf-regs.h   |  2 +-
 4 files changed, 3 insertions(+), 20 deletions(-)
 delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c

diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 787410f99bb3..736c0ad09194 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -2,7 +2,6 @@ perf-util-y += header.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-y += machine.o
diff --git a/tools/perf/arch/s390/util/dwarf-regs.c b/tools/perf/arch/s390/util/dwarf-regs.c
deleted file mode 100644
index 5bcf3192623a..000000000000
--- a/tools/perf/arch/s390/util/dwarf-regs.c
+++ /dev/null
@@ -1,16 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright IBM Corp. 2010, 2017
- * Author(s): Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
- *
- */
-
-#include <linux/kernel.h>
-#include "dwarf-regs-table.h"
-
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n >= ARRAY_SIZE(s390_dwarf_regs)) ? NULL : s390_dwarf_regs[n];
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 2c6b197556dd..1649fc07f4f5 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 35f4f33205da..25f3d6b90f10 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.105.g07ac214952-goog


