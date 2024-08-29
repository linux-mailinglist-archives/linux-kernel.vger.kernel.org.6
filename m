Return-Path: <linux-kernel+bounces-307335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDC5964BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C93B22AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4EA2BD08;
	Thu, 29 Aug 2024 16:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HvdmRVvi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EC31B29C6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724950257; cv=none; b=b/9FN4N9cDki6+VLQSChaTfINDQak9wshsVWKUwGWdf0AFtpKTieiMSs4sg7FuRaIdXaH4qJnYs/TFZP1ZQGJ2+hkgO2VBuLL5Sd/RJ5qllM4VKc8aCIx446rjND9IP0LafgQq4fQcD93HDIXAf95dP6aTYmSX8qa/8905GvIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724950257; c=relaxed/simple;
	bh=yegqliMJP+87moz0ZxITu98ra8g6mOh/EZZ5LNLAxO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9YIZf+IHJau2yI2CfayfozwP2tBqYQB9EYQM/HgpSBCLOdacuZ2CiYiy+2k9DgO3WYG3bnjg2I+ZZF0GL5i4bhoRevKm7EsgVQP7nrHDwK7tyarUEwRHRYdLeQmjEeYzoEWuXxcth5o+Z5yMbi8RYPrdNBdpsaNpGaphiD07JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HvdmRVvi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42bb4f8a4bfso5479175e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724950253; x=1725555053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NNRo4pYlVhAaDob5jz389OO0K96/Tof4H7HpMWmLpCE=;
        b=HvdmRVviFfnj3Lw6ILJbeT64GUMhumvSpgVBVtKY5NamLbPeaCclSB7SaqjR0RJFbF
         9V5yzSKxe0QNh4IiKyx60XASF3msBo7Bv9xX/0CLOkrIgdmbz3eYnlWzo51ZQWCs1dPg
         lpluEu/oIWZDdKkt1Yi7TnLgwYNUQC/yeZ3B48xWhOdLyEcuF+m7Q2/9dPfl1VO19jb+
         Ix6qfsLxR6RbuuMvx9dOQfJLGGzBeIZKJxfIeOFVN7n6pHTbY/0ndwgY3na5gOV/jbWO
         22sc7HRb8h9CXc02AQL3fflsdcwYzUM+nQxNx8h81KVU2klG7wUQqoH+2mQywONHtJ2U
         GE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724950253; x=1725555053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNRo4pYlVhAaDob5jz389OO0K96/Tof4H7HpMWmLpCE=;
        b=JPZ8QlkDfvS4GyoziwK2+23Hu4TrPw3PL0WbvodPZInFc0t1c2U8SgWB6UFxhxtVAV
         k+CC1TtaBXL9LSfxOM8qc5sJBLof5LOtkhcuHRVE87Q8PneOg/nTEkcwdnF79rOLd2Ot
         1LT4CoRCnaGILqjUBzIHK8AqzUbnQgdl1MOmAa1ifzFyEDKUIgaK0VU+kuqG5OOa0iEc
         ckvils3zLjT3TkSso6xe9Q6I6uYHVvXvjiEW4NYbPfD5InWiL+Eupd/uV8M+NCvMZADK
         Nau56AbsZisOW5c/kEm98IUqykvXY0i0mZjiwkhlHbl44VDY+KLcEUv86e2uxVcOeYkn
         QVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6TIsYHTGSjbKLAzp5cXJ39wlXNj/Pyo2+kP40d1xFSeQeIT6LLy/mppoBbLvctR2A8HTbGDvH4k/c1N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySOZXgAE6+Uuo9FLUUCb5Ik60RT+8ioHOQiOo/lqrTQWV49X5e
	5ZIRxnNpNcF5Q7btRNJ6RGnKUL4ddAV3VfjzoacT7fEQOQSBd9CyJuQCZGKfVRM=
X-Google-Smtp-Source: AGHT+IGiImxHTvG37n8UL0B/l76NzCvlfBmx0BJGM9uNrDMyVOCeNKcJXBtNbCYakEaAYL3zIFmgPw==
X-Received: by 2002:adf:fd81:0:b0:368:3562:7c76 with SMTP id ffacd0b85a97d-3749fe43401mr1919619f8f.3.1724950252528;
        Thu, 29 Aug 2024 09:50:52 -0700 (PDT)
Received: from alex-rivos.home (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ef8adcbsm1852277f8f.71.2024.08.29.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 09:50:52 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Tomsich <philipp.tomsich@vrull.eu>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com
Subject: [PATCH -fixes v2] riscv: Fix RISCV_ALTERNATIVE_EARLY
Date: Thu, 29 Aug 2024 18:50:48 +0200
Message-Id: <20240829165048.49756-1-alexghiti@rivosinc.com>
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

Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/linux-riscv/20240813-pony-truck-3e7a83e9759e@spud/
Reported-by: syzbot+cfbcb82adf6d7279fd35@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-riscv/00000000000065062c061fcec37b@google.com/
Fixes: 1745cfafebdf ("riscv: don't use global static vars to store alternative data")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v2:
* Move sbi_err_map_linux_errno() in sbi.h (Samuel)

 arch/riscv/include/asm/sbi.h  | 20 ++++++++++-
 arch/riscv/kernel/Makefile    |  6 +++-
 arch/riscv/kernel/sbi.c       | 63 -----------------------------------
 arch/riscv/kernel/sbi_ecall.c | 48 ++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 65 deletions(-)
 create mode 100644 arch/riscv/kernel/sbi_ecall.c

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 7cffd4ffecd0..7bd3746028c9 100644
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
@@ -373,7 +375,23 @@ static inline unsigned long sbi_mk_version(unsigned long major,
 		| (minor & SBI_SPEC_VERSION_MINOR_MASK);
 }
 
-int sbi_err_map_linux_errno(int err);
+static inline int sbi_err_map_linux_errno(int err)
+{
+	switch (err) {
+	case SBI_SUCCESS:
+		return 0;
+	case SBI_ERR_DENIED:
+		return -EPERM;
+	case SBI_ERR_INVALID_PARAM:
+		return -EINVAL;
+	case SBI_ERR_INVALID_ADDRESS:
+		return -EFAULT;
+	case SBI_ERR_NOT_SUPPORTED:
+	case SBI_ERR_FAILURE:
+	default:
+		return -ENOTSUPP;
+	};
+}
 
 extern bool sbi_debug_console_available;
 int sbi_debug_console_write(const char *bytes, unsigned int num_bytes);
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
index 837bdab2601b..1989b8cade1b 100644
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
@@ -27,55 +24,6 @@ static int (*__sbi_rfence)(int fid, const struct cpumask *cpu_mask,
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
-int sbi_err_map_linux_errno(int err)
-{
-	switch (err) {
-	case SBI_SUCCESS:
-		return 0;
-	case SBI_ERR_DENIED:
-		return -EPERM;
-	case SBI_ERR_INVALID_PARAM:
-		return -EINVAL;
-	case SBI_ERR_INVALID_ADDRESS:
-		return -EFAULT;
-	case SBI_ERR_NOT_SUPPORTED:
-	case SBI_ERR_FAILURE:
-	default:
-		return -ENOTSUPP;
-	};
-}
-EXPORT_SYMBOL(sbi_err_map_linux_errno);
-
 #ifdef CONFIG_RISCV_SBI_V01
 static unsigned long __sbi_v01_cpumask_to_hartmask(const struct cpumask *cpu_mask)
 {
@@ -535,17 +483,6 @@ long sbi_probe_extension(int extid)
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


