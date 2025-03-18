Return-Path: <linux-kernel+bounces-565390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EA3A6675F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EBE7A26A7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB31C4A10;
	Tue, 18 Mar 2025 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HB9rrUc"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE3E1B85D1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268724; cv=none; b=q9+l580zM1rjm9ddqdgGnV4bJXqdD8Hd1YxJqFfVwaL72kh8wFEUeWIxspfoBtGeajDJB973hjuy0MwuC3WRzo7X+/hMUUGW4fJN37QEWgA2xdVzvMOCRmx51K1BgmsHutE/hAAaj6jirBhMIPlCL/mzJQwK/i0m7TqacRymVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268724; c=relaxed/simple;
	bh=V6Z1VaaZvWtk/tEXjKtJfP6Ld5lnXtv1c/u2guFja8I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aVr2nx9HHwDiUfMDZaV/2QIsGRRZDUnjf44TRSA7rFXi7PZWihMcHsPz77xySkxh9Ow/J6ZcJYAFm+T/YR2lQzSEBAXCULP2CDjrQVP32XZanO3O6E8yNgMV2JpqpKfbUpqCJxvOwi7UF6j0Rbecwcf7EqeiVS43L7cK9PGGbJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HB9rrUc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2c7008c05so74262797b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742268722; x=1742873522; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFFalelwH8VoySEJuALgzWg3CwByqG22Rt5iA2R562U=;
        b=1HB9rrUcUdc+HIqbHMpOX31M3gVH1VScivxuvK+FI/loiGnwI8mWkKxHAhfhe4OFFR
         CAg6SVcSbyoYXekYXp9SsecbZmZBd/JAqLr6Rdftl8N9YSxjS9QbDCC2mMC0pB6KcTnB
         30Z2YD6ng0P2Mrz1Nup5cBkv0sHGDYElQRTK/B+nX7WgsP0fvIUy7j05M7Rc6SfvpsCo
         iT4aL2C0qusRxvmAyLzGGND6q/by/qlakgW86hfAvxDCoqO5JB5Yr3zYeROIBfcU6qzK
         HNSWZSVBo0pBB8H+OscPwEDKIIwTwnS291esk8WkISdq7LYDFrxfxXz8vbWzemLyVVtv
         LyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268722; x=1742873522;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFFalelwH8VoySEJuALgzWg3CwByqG22Rt5iA2R562U=;
        b=rp9cDPy7KYpacywfIby3p3w/LYwJORtEgPpnfColt36GSJ3Lwe5akYdMpTNuxdPSoN
         OUZfVyFp2oXWPlMwR7a1102J8VAlhJwr10o5E0qW7xKbK8AxOG1zdhdpCnZapRqPhwbu
         rR1vT2ktfO+vflrC5Hg3RlBOKQuPL9dpylzSMzf1a/+0fGu06e1G+RNma9l3Q2j9txKK
         4XeQaAIXYgzyy75JhJa/6PBm/wT39cyzheuC8988WtLjK9Wo5keu9eLWLElmvO8DcHJ1
         wFxh/XpzulsNpFD8QYgBj2EHDmnZYUO92ANhQ3wf1eO2vVJTm/5Z13sD3B2gpvtILniE
         4aCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTwnXioqJedxEnz0rYk4v1uGg5rlsXojWDPeGTCDG4u5LahbjUz1aUeVuhHmF/x32907hBdAq/b3SL+1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9o2fL9lAqoPB4O/EKxVhNqnspjPyUTqe/R4+A6zU/qyl7Ttz
	2tahrqHf1QXyTGd1eIuzLQTrtM+LTaEdX/EX1Rqr75Xuh+aiRNr/Sufu6ukmr7Y5yBVO8hT9XSO
	bLZcw7A==
X-Google-Smtp-Source: AGHT+IE8h21clMGypRwFdkAJ8HSsdR0DLiUdSQCYfCnO3kEzoqhIUGiKiT6x5H6nRskrGzjfDm0d53UaKClF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a05:690c:3604:b0:6f9:8797:a245 with SMTP
 id 00721157ae682-6ff46063bfamr69497b3.3.1742268722359; Mon, 17 Mar 2025
 20:32:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:31:40 -0700
In-Reply-To: <20250318033150.119174-1-irogers@google.com>
Message-Id: <20250318033150.119174-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318033150.119174-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v6 03/13] perf syscalltbl: Remove syscall_table.h
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The definition of "static const char *const syscalltbl[] = {" is done
in a generated syscalls_32.h or syscalls_64.h that is architecture
dependent. In order to include the appropriate file a syscall_table.h
is found via the perf include path and it includes the syscalls_32.h
or syscalls_64.h as appropriate.

To support having multiple syscall tables, one for 32-bit and one for
64-bit, or for different architectures, an include path cannot be
used. Remove syscall_table.h because of this and inline what it does
into syscalltbl.c.

For architectures without a syscall_table.h this will cause a failure
to include either syscalls_32.h or syscalls_64.h rather than a failure
to include syscall_table.h. For architectures that only included one
or other, the behavior matches BITS_PER_LONG as previously done on
architectures supporting both syscalls_32.h and syscalls_64.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/arch/alpha/include/syscall_table.h     | 2 --
 tools/perf/arch/arc/include/syscall_table.h       | 2 --
 tools/perf/arch/arm/include/syscall_table.h       | 2 --
 tools/perf/arch/arm64/include/syscall_table.h     | 8 --------
 tools/perf/arch/csky/include/syscall_table.h      | 2 --
 tools/perf/arch/loongarch/include/syscall_table.h | 2 --
 tools/perf/arch/mips/include/syscall_table.h      | 2 --
 tools/perf/arch/parisc/include/syscall_table.h    | 8 --------
 tools/perf/arch/powerpc/include/syscall_table.h   | 8 --------
 tools/perf/arch/riscv/include/syscall_table.h     | 8 --------
 tools/perf/arch/s390/include/syscall_table.h      | 2 --
 tools/perf/arch/sh/include/syscall_table.h        | 2 --
 tools/perf/arch/sparc/include/syscall_table.h     | 8 --------
 tools/perf/arch/x86/include/syscall_table.h       | 8 --------
 tools/perf/arch/xtensa/include/syscall_table.h    | 2 --
 tools/perf/util/syscalltbl.c                      | 8 +++++++-
 16 files changed, 7 insertions(+), 67 deletions(-)
 delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
 delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
 delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
 delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
 delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
 delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
 delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h

diff --git a/tools/perf/arch/alpha/include/syscall_table.h b/tools/perf/arch/alpha/include/syscall_table.h
deleted file mode 100644
index b53e31c15805..000000000000
--- a/tools/perf/arch/alpha/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_64.h>
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/arc/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/arm/include/syscall_table.h b/tools/perf/arch/arm/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/arm/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/arm64/include/syscall_table.h b/tools/perf/arch/arm64/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/arm64/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/csky/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
deleted file mode 100644
index 9d0646d3455c..000000000000
--- a/tools/perf/arch/loongarch/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscall_table_64.h>
diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
deleted file mode 100644
index b53e31c15805..000000000000
--- a/tools/perf/arch/mips/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_64.h>
diff --git a/tools/perf/arch/parisc/include/syscall_table.h b/tools/perf/arch/parisc/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/parisc/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/powerpc/include/syscall_table.h b/tools/perf/arch/powerpc/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/powerpc/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/riscv/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/s390/include/syscall_table.h b/tools/perf/arch/s390/include/syscall_table.h
deleted file mode 100644
index b53e31c15805..000000000000
--- a/tools/perf/arch/s390/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_64.h>
diff --git a/tools/perf/arch/sh/include/syscall_table.h b/tools/perf/arch/sh/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/sh/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/sparc/include/syscall_table.h b/tools/perf/arch/sparc/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/sparc/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/x86/include/syscall_table.h b/tools/perf/arch/x86/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/x86/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/xtensa/include/syscall_table.h b/tools/perf/arch/xtensa/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/xtensa/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 928aca4cd6e9..2f76241494c8 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -7,13 +7,19 @@
 
 #include "syscalltbl.h"
 #include <stdlib.h>
+#include <asm/bitsperlong.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
 
 #include <string.h>
 #include "string2.h"
 
-#include <syscall_table.h>
+#if __BITS_PER_LONG == 64
+  #include <asm/syscalls_64.h>
+#else
+  #include <asm/syscalls_32.h>
+#endif
+
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


