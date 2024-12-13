Return-Path: <linux-kernel+bounces-444118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5239F0111
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 01:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B43E162760
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3970018EA2;
	Fri, 13 Dec 2024 00:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PSmOJcOu"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684C16D9DF
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734050023; cv=none; b=D/byClx5W7dMtrPebT/q05yFp/RRKZjDbrVuNH/HcJTsMptT7t6Abf+Fx5cRIhdDzbyrXUuf6rV7qTj/1dntrseixNghCjN8oDpY65Gw3EKQbPTinFfFGwboZStxlEv7onOrlV3GCjc/IRfjE3oeuVqubtxa9V3QoLMN027HY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734050023; c=relaxed/simple;
	bh=vnr7cWoZFfQ0KvHH41RaqWCLqYQBec4e5YesLO6WOkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRgKPjo/vzESyt+v8KArpfuTiSYXpjmpGK1xNd2j2xG25jhlYFCc80ch7CSt2Zq7U0YUnJvA6QlCoOTZ0P2bJfbvAFmMtf0TkXpLt/srQ8XnzF9TzibKDwOvV0EdUt7Gq4pBhaWhUPbhddzlR7ntaKUNd6B1IAxIbS9utOzs9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PSmOJcOu; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd49d85f82so1001850a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734050019; x=1734654819; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BkBpGiJJV1xZfjJsAMeOkH46KtRGtX/VgJPGRtgwU6w=;
        b=PSmOJcOuIlQbZbb9coBLP96zAltkF4n3XshkRaNH/lUIpGfi8W7l26Fy5KX76OIBfr
         hENzzteAR/BUiO7oTBZ6tYKjHwd7dZpgPnG8fmuD+qCARgQzJ7vTKixWqnzlV+yd7tRM
         XNljwkJ+c//gPbmICqQbKCunpXgqiCMDFB/8hP7V8XLdpO5jMY6O++tGrpKAvRXHDYxP
         QasciCYTo827FnccJ11ZJktvTD1p1PPCAlQroAUSV0PMoMxZMVmknTq4r2QJILlUBaWZ
         H5Mht6yCI2mXn0f6JIgd1qqDCWZom1eDLSq4TUJzZHe8tzfnTVugryf4ruj9XZcCybqf
         ne3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734050019; x=1734654819;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkBpGiJJV1xZfjJsAMeOkH46KtRGtX/VgJPGRtgwU6w=;
        b=giTTx+oaMY4YuWaq0So1b0FKSMfbBTssKJDr92To595healdJxW5ZRmG1oVhPigOfA
         T3zEoJM+L6+6UMBuqSQi8zBbxM3EKovmwLQknLMMgLib5rpFxktMCSqR7hYTu+TQpak3
         pLbITRHl+q5I/MLwU8umorF21hqHzR+WsvP0ItKCow9WU2Hbe1nmGLrsOvs/GqapeRd9
         Dcwl3o2tiA50aJ90UGKo/M+e4aSw1siycM/a+P26OJXVhdpAZ+mrMCoyQuRa9Gk/LsDP
         O0ORq7mw+FLXwZf2V6QfO3IFFKviDzuLTkZYYELyNp1juW6e5TrjyoIMzO46xigXTc6j
         Ek/A==
X-Gm-Message-State: AOJu0Yxilew//kLTlat+nUUSA5kSgpM4tHL+MImsJESV3wiYIwLv6MrH
	BDMrxTxcoRkCUBAElb/gSPFP2Z4sbN7MxojQYndehAqd1PaHscs5bXX9XfEHCGA=
X-Gm-Gg: ASbGnctzhpHSaC+VpBj6uBYPOq/CuzATZnC5/9zR62uzUZkG1GW416RJ8wRJfEgQNp7
	UcSbgxTdUqLvNWCf9z5Hk1+M55/0h/vMANUW+QWI4SiglYCJqtZVNNmMMazpEcaYmKfppdDguRD
	UN6TaNEnFSq7gAS0zLx1mENKQxILtZbq+sonTIHahSV9Po+3HSSTKk7epMOpbnVB+Y9zgqYpHFU
	uOpLdr+ETn71M/Nzc7S6RfYg71lxE8KRfEWnH5wl939Uoz/gXX/f9duyFkwZ72UWpihHzMy
X-Google-Smtp-Source: AGHT+IEmO14yRzV89oAAj+86B3/3giiM5XjE+fq4YvWiIgXAskruD2olv5GrMtWghrbv8f8V9rlHTQ==
X-Received: by 2002:a17:90b:1810:b0:2ee:ab29:1482 with SMTP id 98e67ed59e1d1-2f28fb68bbcmr1241837a91.16.1734050019164;
        Thu, 12 Dec 2024 16:33:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:33:02 -0800
Subject: [PATCH v2 12/16] perf tools: loongarch: Use syscall table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-12-f8ca984ffe40@rivosinc.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
In-Reply-To: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6826; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=vnr7cWoZFfQ0KvHH41RaqWCLqYQBec4e5YesLO6WOkY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w4HTye2XcxtrZ6/5XW1/pLfSpiWjrXlBk6B+w4br7
 DEsIbYdpSwMYhwMsmKKLDzXGphb7+iXHRUtmwAzh5UJZAgDF6cATETsN8MfzqMn9+TkLWL+ImUd
 xxD7bN3Prven/tfWNv4V7Q0r90/QZfin5P/Xmv/m57/LV6u62Gypl79zQ5Vjh+edycdmFSVn+/W
 wAgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

loongarch uses a syscall table, use that in perf instead of using unistd.h.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  5 +--
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/loongarch/Makefile                 | 22 -----------
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |  2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |  3 ++
 .../arch/loongarch/entry/syscalls/mksyscalltbl     | 45 ----------------------
 tools/perf/arch/loongarch/include/syscall_table.h  |  2 +
 tools/perf/util/syscalltbl.c                       |  4 --
 8 files changed, 10 insertions(+), 75 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aefcbed7cdfac7c2a5d8db5cb111513f2d7c74ed..84ed266ce54f5291af5c59c02ccb06bfe17d840f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,12 +31,12 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
     NO_SYSCALL_TABLE := 0
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
@@ -75,7 +75,6 @@ ifeq ($(SRCARCH),arm64)
 endif
 
 ifeq ($(SRCARCH),loongarch)
-  CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
 endif
 
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6a287f15fa1da5e8957558ee0a73b297d347f00d..7fefeea1799231af61e77c9372318e025bed078a 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 52544d59245bab5a0fb2baa1e962b2ad4bf25332..087e099fb453a9236db34878077a51f711881ce0 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,25 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/loongarch/include/generated/asm
-header := $(out)/syscalls.c
-incpath := $(srctree)/tools
-sysdef := $(srctree)/tools/arch/loongarch/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, loongarch) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Kbuild b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..47d32da2aed8d67a7ac026271600e84723031a6b
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 +=
diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
deleted file mode 100755
index c10ad3580aef25e48ff0682eca4217cbafdfa333..0000000000000000000000000000000000000000
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# powerpc script.
-#
-# Author(s):  Ming Wang <wangming01@loongson.cn>
-# Author(s):  Huacai Chen <chenhuacai@loongson.cn>
-# Copyright (C) 2020-2023 Loongson Technology Corporation Limited
-
-gcc=$1
-hostcc=$2
-incpath=$3
-input=$4
-
-if ! test -r $input; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_sc_table()
-{
-	local sc nr max_nr
-
-	while read sc nr; do
-		printf "%s\n" "	[$nr] = \"$sc\","
-		max_nr=$nr
-	done
-
-	echo "#define SYSCALLTBL_LOONGARCH_MAX_ID $max_nr"
-}
-
-create_table()
-{
-	echo "#include \"$input\""
-	echo "static const char *const syscalltbl_loongarch[] = {"
-	create_sc_table
-	echo "};"
-}
-
-$gcc -E -dM -x c -I $incpath/include/uapi $input \
-	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
-		sub("^#define __NR(3264)?_", "");
-		print | "sort -k2 -n"}' \
-	|create_table
diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..9d0646d3455cdaf1a3db8c8565af8eba9a8df8c6
--- /dev/null
+++ b/tools/perf/arch/loongarch/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscall_table_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index b7c0a4b9245a94b3b245fea59af79081b1f91081..3001386e13a502be5279aa6e4742af0b96202b35 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -30,10 +30,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_mips_n64;
-#elif defined(__loongarch__)
-#include <asm/syscalls.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_loongarch;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


