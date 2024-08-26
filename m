Return-Path: <linux-kernel+bounces-301335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7E095EF32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BF9B1C21C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6614E2E2;
	Mon, 26 Aug 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0FSjRMmu"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6239ACC
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669863; cv=none; b=Zy1S445L2PXhhKe3YT1P3pTO8i3zV8tdseQqhd8muXHx8jQu1O8c49IZPxGJQtXXeroUNZbs8BM4Znj3EIhUucCoFSJkZv9rc7fq7ce870SiTaxfmjVwepqv9W5esKnjEIpKR134RXih/zlj+UdiWZJ7KzIGttwGm5oGpd7pPAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669863; c=relaxed/simple;
	bh=aOAGsHeA41r+3qYW/TnAW8x0CBae6pcZS1JwYcSsLTA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NagpirEAo3F+qseoHUZRGkXWhp5YcpD7UO5xvZdZ4jaBszI+RQsg9KKzvpUvwElyf1BY1YsOBRLhRI5sZE7YFxdXXC3rd5HXB2yPE7yDmNT5oC4oNSyvoqG0Mj5eHktxOiiClquEiFLUc4BD4i4vXmV+EgcvV9l5lsgVgN5k+BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0FSjRMmu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428e0d18666so35765775e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724669859; x=1725274659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rUDYsNzKPDakoR8t1erMElmoWZbKHeQKwZAuEcREEvs=;
        b=0FSjRMmujN5m480M+fXpf0raWu8+vU6OggJs79sRMC58BjBtIQUmz59xuvn/LdTwlb
         Y2t47BdT9TIweNuXQVjsXDZPV2si7Ra5C8pGC0/akeIe03KpIb0H35O0GHIOXspFRjSz
         bf/UjDvTS/W7M18MvLJK4H3M4qmHVCxkHtnujZdcQCWwIUF1CipWwGytmu98dcxlrxvx
         iU3VslyRZNcFs7PvA0NF7C8cx/scChunlMsdlJEpZ/g4AmpHPGLsuKSl28cx0RNTHKct
         B2yS4ocVvv28tuWZf9apeo4KwC/zuP8Ms4fUlO3ANGkDEjYFxQ+pSViW7of0CYszslNk
         ZDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669859; x=1725274659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rUDYsNzKPDakoR8t1erMElmoWZbKHeQKwZAuEcREEvs=;
        b=Oscq+qO9tE+xH8mTfcBR9LBb/sufkZzcC88REr6EmjCZUPz7tIEe4m+pg5dld4Y9TN
         sx+3vWg/B354GAO7eawEA4MiQxmWua4FnT1AYHkl3bdVlUvvVEZ9WfFq7srYvDvRCCQJ
         aEzlQ6zquKyuo+jNbMpu7Wg1UXx2BJHfeiGmSwvk1aNQ9KGccnBcimXjXw9Adw18GwXS
         /FOzV7XaKqj0lNAPHr2dLvil07pamsoX3jiId4hgmGz3wDqEEOnjaDtLijW3Z54rALww
         7c5Ndywy6SSXwQBLXlIkt2YlPPuGRTXQ9ag9W6WjA7V92avJ29LE5GfIfOd5MZaXnGwg
         z4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB9Z4zrMv8eAt9jhEYFGJJu7y3nLU5vB95tZbHQK8DdKdnrUtjryNftIVw6yA2vokm4uEO6jO8luJigGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjG4MpTGfoukc4zsXHmR+Q1FCNriQjyZdGXR4jJTYMeQow8piT
	SXqjTQ1px/PSDE32uoGEot1smnlVTpRpg9zL234YYlnZffeu4tiZqgNM5xLU5Ig=
X-Google-Smtp-Source: AGHT+IEsR1/6NVxEyhN6BHVWC4KeJ2FDaiiHGT5LpbIIwXcJ1VaPNCaPZhqmoLBgKfWmSJW1DiSBYA==
X-Received: by 2002:a5d:4583:0:b0:368:8015:8a96 with SMTP id ffacd0b85a97d-3731185f2f6mr6284586f8f.16.1724669859216;
        Mon, 26 Aug 2024 03:57:39 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308160586sm10511722f8f.58.2024.08.26.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:57:38 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: Fix RISCV_ALTERNATIVE_EARLY
Date: Mon, 26 Aug 2024 12:57:37 +0200
Message-Id: <20240826105737.106879-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISCV_ALTERNATIVE_EARLY will issue sbi_ecall() very early in the boot
process, before the first memory mapping is setup so we can't have any
instrumentation happening here.

In addition, when the kernel is relocatable, we must also not issue any
relocation this early since they would have been patched virtually only.

So, instead of disabling instrumentation for the whole kernel/sbi.c file
and compiling it with -fno-pie, simply move __sbi_ecall() and
__sbi_base_ecall() into their own file where this is fixed.

Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alternative data")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h  |  2 ++
 arch/riscv/kernel/Makefile    |  6 ++++-
 arch/riscv/kernel/sbi.c       | 44 --------------------------------
 arch/riscv/kernel/sbi_ecall.c | 48 +++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 45 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi_ecall.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 7cffd4ffecd0..5843a10b380e 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <linux/cpumask.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_RISCV_SBI
 enum sbi_ext_id {
@@ -304,6 +305,7 @@ struct sbiret {
 };
 
 void sbi_init(void);
+long __sbi_base_ecall(int fid);
 struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
 			  unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5,
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 06d407f1b30b..7f88cc4931f5 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -20,17 +20,21 @@ endif
 ifdef CONFIG_RISCV_ALTERNATIVE_EARLY
 CFLAGS_alternative.o := -mcmodel=medany
 CFLAGS_cpufeature.o := -mcmodel=medany
+CFLAGS_sbi_ecall.o := -mcmodel=medany
 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_alternative.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_cpufeature.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sbi_ecall.o = $(CC_FLAGS_FTRACE)
 endif
 ifdef CONFIG_RELOCATABLE
 CFLAGS_alternative.o += -fno-pie
 CFLAGS_cpufeature.o += -fno-pie
+CFLAGS_sbi_ecall.o += -fno-pie
 endif
 ifdef CONFIG_KASAN
 KASAN_SANITIZE_alternative.o := n
 KASAN_SANITIZE_cpufeature.o := n
+KASAN_SANITIZE_sbi_ecall.o := n
 endif
 endif
 
@@ -88,7 +92,7 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
-obj-$(CONFIG_RISCV_SBI)		+= sbi.o
+obj-$(CONFIG_RISCV_SBI)		+= sbi.o sbi_ecall.o
 ifeq ($(CONFIG_RISCV_SBI), y)
 obj-$(CONFIG_SMP)		+= sbi-ipi.o
 obj-$(CONFIG_SMP) += cpu_ops_sbi.o
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 837bdab2601b..ace9e2f59c41 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -14,9 +14,6 @@
 #include <asm/smp.h>
 #include <asm/tlbflush.h>
 
-#define CREATE_TRACE_POINTS
-#include <asm/trace.h>
-
 /* default SBI version is 0.1 */
 unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
 EXPORT_SYMBOL(sbi_spec_version);
@@ -27,36 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
 			   unsigned long start, unsigned long size,
 			   unsigned long arg4, unsigned long arg5) __ro_after_init;
 
-struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
-			  unsigned long arg2, unsigned long arg3,
-			  unsigned long arg4, unsigned long arg5,
-			  int fid, int ext)
-{
-	struct sbiret ret;
-
-	trace_sbi_call(ext, fid);
-
-	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
-	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
-	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
-	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
-	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
-	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
-	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
-	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
-	asm volatile ("ecall"
-		      : "+r" (a0), "+r" (a1)
-		      : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
-		      : "memory");
-	ret.error = a0;
-	ret.value = a1;
-
-	trace_sbi_return(ext, ret.error, ret.value);
-
-	return ret;
-}
-EXPORT_SYMBOL(__sbi_ecall);
-
 int sbi_err_map_linux_errno(int err)
 {
 	switch (err) {
@@ -535,17 +502,6 @@ long sbi_probe_extension(int extid)
 }
 EXPORT_SYMBOL(sbi_probe_extension);
 
-static long __sbi_base_ecall(int fid)
-{
-	struct sbiret ret;
-
-	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
-	if (!ret.error)
-		return ret.value;
-	else
-		return sbi_err_map_linux_errno(ret.error);
-}
-
 static inline long sbi_get_spec_version(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
diff --git a/arch/riscv/kernel/sbi_ecall.c b/arch/riscv/kernel/sbi_ecall.c
new file mode 100644
index 000000000000..24aabb4fbde3
--- /dev/null
+++ b/arch/riscv/kernel/sbi_ecall.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Rivos Inc. */
+
+#include <asm/sbi.h>
+#define CREATE_TRACE_POINTS
+#include <asm/trace.h>
+
+long __sbi_base_ecall(int fid)
+{
+	struct sbiret ret;
+
+	ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
+	if (!ret.error)
+		return ret.value;
+	else
+		return sbi_err_map_linux_errno(ret.error);
+}
+EXPORT_SYMBOL(__sbi_base_ecall);
+
+struct sbiret __sbi_ecall(unsigned long arg0, unsigned long arg1,
+			  unsigned long arg2, unsigned long arg3,
+			  unsigned long arg4, unsigned long arg5,
+			  int fid, int ext)
+{
+	struct sbiret ret;
+
+	trace_sbi_call(ext, fid);
+
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
+	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	asm volatile ("ecall"
+		       : "+r" (a0), "+r" (a1)
+		       : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
+		       : "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	trace_sbi_return(ext, ret.error, ret.value);
+
+	return ret;
+}
+EXPORT_SYMBOL(__sbi_ecall);
-- 
2.39.2


