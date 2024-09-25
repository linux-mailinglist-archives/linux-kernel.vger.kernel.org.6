Return-Path: <linux-kernel+bounces-339129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAF99860FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C048BB3180C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2DD22EF0;
	Wed, 25 Sep 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bVanpqNG"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531761C2A3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270167; cv=none; b=MxqElglDZxdWvPdOY9rv2M8Rg4eEyiIs/fP6HcRBra6uQKM9MBhxGVHlklno2n+Y3bfCBvZZFoMaTA2lOg5PdtfR0RezRiF+j0O7IvidvGqusBBLGgYo25USVel91IUHbpbI9XNtgBhxpWKBI0CLNJZuP7T6nuque49v/qCmRz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270167; c=relaxed/simple;
	bh=fBhGSMjhMtoS+sssw22+A3cFZxLZD4jCuP8TuuwwN5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JawOA81n2MnYU+oB5fRc/tWQSSD8CtOdGz1oHiLJACgk+hwccynfVlEbXwRXaSqcO+/cIhF8wfJ73MkIy71AidOD5v94z6Y0YWd2xhpoyynF8JRP1r7KK1UxQ1jeWEgzFfHyoWc3GUmOnkq9o+775GiYYzwz+xsulN2cPpYk12I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bVanpqNG; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2da55ea8163so4439642a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727270163; x=1727874963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUZr870RxrrFu6w7eKXju873kveoqn8JgQz1DEy7APc=;
        b=bVanpqNGb0dd7h1gxN9Faz9C77i4ZBg7IOVRVmZtIxpOL2LJr5UEoooAwM/a2V6bJq
         Tf0fMa23LWoO69Da4u+iQI9ZNWKqvq5L0+B8PfTrsYqktSiTYiWc7ED0CsCuewtnTu1K
         XDyy2NhSm4IFOnLZHjymCV9EU7nt/mhQulOayYTQaBwZgfACXGdHrPCqObDaKNScdlPF
         ldYiCmlweoM1eMV3InU5g3imfqo5Xo7cl5s3QYYXOaGXfpYCwOcs1hBjIrcnl/G1AqrR
         yA0apA07cz4ukgIBOqjXCRAoQal7RFI0O+UVJyo2KeMvyH6Ric8L4GcCq+fe+ub0gkZv
         8bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270163; x=1727874963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUZr870RxrrFu6w7eKXju873kveoqn8JgQz1DEy7APc=;
        b=hrvHV+V/5r2calXfPC06ytxInaNVO/driJ8nij04Vl2VSzfkLxqcDjwTe5ixAf6AuL
         LY1Z6bHn5jvML8zQ7c3LkmvIFqNWnV64bLh7+yHqVaOBrdx9c4k3EaM9+eUoqmsJ/pdf
         Gjz6zvnFmBL5dcsdKdKnyH2RC78L4t3yXDdEYIBpDToyVRdvo1sUGMqoy8ENgyfi+9hg
         /C1sfn5jAZDSaeFXXtnTfO+LETb4zc/A0ZIJdKU6KraO92D2a6y1a/37G+5EUQD7l7hH
         4WjbR4ZEkjRWwsKr+ZzyIXjvlMDmJ/8CwS7SQ2NuSGnFmDCpvaa5eAesCTaOOsCvKQDX
         nOCw==
X-Forwarded-Encrypted: i=1; AJvYcCXQautYDV5iC4kXaJ90dAAcsQiBmvxDhN+orMrUtCuzr/j/a2HbL4A69ekGvPSBg2O2Y9HTpweESEFgvuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYUt+09PdONcum0PP8cAPzyFTuEa/gyRgPksqjNg+aCa5VBmF
	3jNEOm6T3JwEonfOWOFg4sTsVacz4GreXliZBX4IRSoJDBfwJ11j0J8n4YIA3RA=
X-Google-Smtp-Source: AGHT+IEhlHpjI+8wsZk7tT5ZjtXOCrHZxQOsS5bllHX66BpvT7eERAq7uAvuz0YO0YW3V4DhsSRq+g==
X-Received: by 2002:a17:90b:2d8c:b0:2d8:82a2:b093 with SMTP id 98e67ed59e1d1-2e06ae4dafcmr3339715a91.13.1727270162651;
        Wed, 25 Sep 2024 06:16:02 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1e09e2sm1479465a91.32.2024.09.25.06.15.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Sep 2024 06:16:02 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	guoren@kernel.org,
	christoph.muellner@vrull.eu,
	ajones@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lihangjing@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH v3 1/2] riscv: process: Introduce idle thread using Zawrs extension
Date: Wed, 25 Sep 2024 21:15:46 +0800
Message-Id: <20240925131547.42396-2-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240925131547.42396-1-luxu.kernel@bytedance.com>
References: <20240925131547.42396-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zawrs extension introduces a new instruction WRS.NTO, which will
register a reservation set and causes the hart to temporarily stall
execution in a low-power state until a store occurs to the reservation
set or an interrupt is observed.

This commit implements new version of idle thread for RISC-V via Zawrs
extension.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
Reviewed-by: Hangjing Li <lihangjing@bytedance.com>
Reviewed-by: Liang Deng <dengliang.1214@bytedance.com>
Reviewed-by: Wen Chai <chaiwen.cc@bytedance.com>
---
 arch/riscv/Kconfig                 | 10 ++++++++
 arch/riscv/include/asm/cpuidle.h   | 11 +-------
 arch/riscv/include/asm/processor.h | 18 +++++++++++++
 arch/riscv/kernel/cpu.c            |  5 ++++
 arch/riscv/kernel/process.c        | 41 +++++++++++++++++++++++++++++-
 5 files changed, 74 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 939ea7f6a228..56cf6000d286 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
@@ -1153,6 +1154,15 @@ endmenu # "Power management options"
 
 menu "CPU Power Management"
 
+config RISCV_ZAWRS_IDLE
+	bool "Idle thread using ZAWRS extensions"
+	depends on RISCV_ISA_ZAWRS
+	default y
+	help
+		Adds support to implement idle thread using ZAWRS extension.
+
+		If you don't know what to do here, say Y.
+
 source "drivers/cpuidle/Kconfig"
 
 source "drivers/cpufreq/Kconfig"
diff --git a/arch/riscv/include/asm/cpuidle.h b/arch/riscv/include/asm/cpuidle.h
index 71fdc607d4bc..94c9ecb46571 100644
--- a/arch/riscv/include/asm/cpuidle.h
+++ b/arch/riscv/include/asm/cpuidle.h
@@ -10,15 +10,6 @@
 #include <asm/barrier.h>
 #include <asm/processor.h>
 
-static inline void cpu_do_idle(void)
-{
-	/*
-	 * Add mb() here to ensure that all
-	 * IO/MEM accesses are completed prior
-	 * to entering WFI.
-	 */
-	mb();
-	wait_for_interrupt();
-}
+void cpu_do_idle(void);
 
 #endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index efa1b3519b23..d0dcdb7e7392 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -12,6 +12,7 @@
 
 #include <vdso/processor.h>
 
+#include <asm/insn-def.h>
 #include <asm/ptrace.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
@@ -148,6 +149,21 @@ static inline void wait_for_interrupt(void)
 	__asm__ __volatile__ ("wfi");
 }
 
+static inline void wrs_nto(unsigned long *addr)
+{
+	int val;
+
+	__asm__ __volatile__(
+#ifdef CONFIG_64BIT
+			"lr.d %[p], %[v]\n\t"
+#else
+			"lr.w %[p], %[v]\n\t"
+#endif
+			ZAWRS_WRS_NTO "\n\t"
+			: [p] "=&r" (val), [v] "+A" (*addr)
+			: : "memory");
+}
+
 extern phys_addr_t dma32_phys_limit;
 
 struct device_node;
@@ -177,6 +193,8 @@ extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
 #define RISCV_SET_ICACHE_FLUSH_CTX(arg1, arg2)	riscv_set_icache_flush_ctx(arg1, arg2)
 extern int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread);
 
+extern void select_idle_routine(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index f6b13e9f5e6c..97a7144fa6cd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -23,6 +23,11 @@ bool arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return phys_id == cpuid_to_hartid_map(cpu);
 }
 
+void __init arch_cpu_finalize_init(void)
+{
+	select_idle_routine();
+}
+
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
  * isn't an enabled and valid RISC-V hart node.
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index e4bc61c4e58a..77769965609e 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -15,6 +15,7 @@
 #include <linux/tick.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
+#include <linux/static_call.h>
 
 #include <asm/unistd.h>
 #include <asm/processor.h>
@@ -35,11 +36,49 @@ EXPORT_SYMBOL(__stack_chk_guard);
 
 extern asmlinkage void ret_from_fork(void);
 
-void noinstr arch_cpu_idle(void)
+static __cpuidle void default_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM accesses are completed prior
+	 * to entering WFI.
+	 */
+	mb();
+	wait_for_interrupt();
+}
+
+static __cpuidle void wrs_idle(void)
+{
+	/*
+	 * Add mb() here to ensure that all
+	 * IO/MEM accesses are completed prior
+	 * to entering WRS.NTO.
+	 */
+	mb();
+	wrs_nto(&current_thread_info()->flags);
+}
+
+DEFINE_STATIC_CALL_NULL(riscv_idle, default_idle);
+
+void __cpuidle cpu_do_idle(void)
+{
+	static_call(riscv_idle)();
+}
+
+void __cpuidle arch_cpu_idle(void)
 {
 	cpu_do_idle();
 }
 
+void __init select_idle_routine(void)
+{
+	if (IS_ENABLED(CONFIG_RISCV_ZAWRS_IDLE) &&
+			riscv_has_extension_likely(RISCV_ISA_EXT_ZAWRS))
+		static_call_update(riscv_idle, wrs_idle);
+	else
+		static_call_update(riscv_idle, default_idle);
+}
+
 int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
 {
 	if (!unaligned_ctl_available())
-- 
2.20.1


