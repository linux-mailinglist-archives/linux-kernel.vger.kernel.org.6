Return-Path: <linux-kernel+bounces-299807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BF95DA41
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C761B2308C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 00:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C3429A1;
	Sat, 24 Aug 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Dlqesmt5"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7D2F36
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 00:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724460576; cv=none; b=Gax0k5+B5Atna6Z58A9O0xtkBax296iG1y++hyaPuokay/Cll7oCWF5dbJ1iUWx0a/htK4Ls6vfsZZhuodt+W60pwgJoftiBEswwZrf6d29dwaHfVzLOCM6fz6gFCdL91fcSj2Cl2qzCtlEJdXyHIf+qGa1Cd6ESP4TkYZOIPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724460576; c=relaxed/simple;
	bh=w9rDDAlfSNMTuC1fmD5tP7ci9D1wZNrPhOf7LhH4exs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=W+1UOYdzMBIul9CfCCNw/m5nrD3LYSGEFjHCiq7CA4fnHRVaoDqJSTT4oA/S8X5Abu1A2VZ7r1xr+wXcPhQXwyo8KC6glEgHA88oZaIZuVChmSHteFnH1sMxk9aHTpZjl51Jblum70J4RcCLryCL6gRwSNlZCv7B5P89NwbRlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Dlqesmt5; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093ba310b0so1597542a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724460573; x=1725065373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9LfDeeWKMLmiNvxF44yCZAImDGYCScd/uarouyejBQ=;
        b=Dlqesmt5C/U9+YDb6n77htiBEmvIOtF9dxBf0HWjEeRZ/iWY+FK7PxxCrX9QP6KpWd
         jCDSMD+p5RaI1VIjRoq1SZjmqOBFLeHjKG6paV8u5W/5NG4S61CAK+qaFtgy8UEDuxJM
         a7rY+pUU/890MOYI1L58JQoR4yNlyfB8BzsZFab1dImAOhZOkiPN9RetjR5oMk1yAwyT
         1W+EiIaJu35FH1NWQHJRs5QBV3dJXb/ClL6Ki4cyTtyTM3iuBXfz4A4yHXY3TcyqulWA
         KYQMcZ3+xQ6v7vq72rOX8/xoKSutJoWr63W91LD6zcemP37KYynlgAigWPjwHwRWqP+c
         Wfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724460573; x=1725065373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9LfDeeWKMLmiNvxF44yCZAImDGYCScd/uarouyejBQ=;
        b=tzsSIyT6PCg5S+4aUo7/yHs+bV4FnvUaSre9VDd+WA31bw8nieA5+9e7fnA4ZsRu22
         utjsLpRHgWkEzMpbOHuHGhupFRWXueNf8sBcoBz0xppZH49iKbX1SVC1h+/bdi0oOelM
         Oqi1pqAvCbAkWZ53bML2EOdYKhR25xe+B5lDiYdQRYYvnPuFHrapKqli8sXgJ4ZecUar
         r15WVqdmT0xR/J5Fn/pnPkC0QtchygTd12kJCa8gdZMrkMGv/Co2Wd80BAIoF3i62wax
         URtdU51TVix4kWu3IisqjDPWph2memWPJAB2RRKnAFkiqJ+M5DJaWQgQ1jNdorjFaiGF
         ya9g==
X-Forwarded-Encrypted: i=1; AJvYcCXZuyKvxVEaHNB1lW+NJEL3tUCc5BWWbSpnIRhyLCAsHBBKBuJDKWs/DQ9cLNz36K3tkVsUJyrNJ0MoSRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuOrgy6YOMTZSXHKjGITtVEI2wSEtiHpu/Ac33qP45FsO1uefd
	wjGpKHdsFhhpyUqKlrukVPlRnJFDNtKxYBhrnWyYh2DSxwba+P/GPIofTC9/rMI=
X-Google-Smtp-Source: AGHT+IHXN44/Uhpbc5HjU/UNIngFnsErN7xy0wmHCyVmt+yEtdYziYd3Gj1rFnHMzEVOqHQmQWL9yQ==
X-Received: by 2002:a05:6830:6004:b0:70a:9876:b76b with SMTP id 46e09a7af769-70e0ead89c3mr5064366a34.2.1724460573141;
        Fri, 23 Aug 2024 17:49:33 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb0b27sm7088692a91.45.2024.08.23.17.49.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Aug 2024 17:49:32 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com,
	samitolvanen@google.com,
	guoren@kernel.org,
	debug@rivosinc.com,
	charlie@rivosinc.com,
	cuiyunhui@bytedance.com,
	cleger@rivosinc.com,
	puranjay@kernel.org,
	antonb@tenstorrent.com,
	namcaov@gmail.com,
	andy.chiu@sifive.com,
	ajones@ventanamicro.com,
	samuel.holland@sifive.com,
	haxel@fzi.de,
	yang.zhang@hexintek.com,
	conor.dooley@microchip.com,
	evan@rivosinc.com,
	yang.lee@linux.alibaba.com,
	tglx@linutronix.de,
	haibo1.xu@intel.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RFC] riscv: use gp to save percpu offset
Date: Sat, 24 Aug 2024 08:49:20 +0800
Message-Id: <20240824004920.35877-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to directly fetching the per-CPU offset from memory (or cache),
using the global pointer (gp) to store the per-CPU offset can save one
memory access.

When compiling the kernel, the following command needs to be explicitly
specified:
export KCFLAGS="... -mno-relax"
export KAFLAGS="... -mno-relax"

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/asm.h      | 18 ++++++------------
 arch/riscv/include/asm/percpu.h   | 24 ++++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c   |  1 +
 arch/riscv/kernel/entry.S         |  4 ++--
 arch/riscv/kernel/head.S          |  9 ---------
 arch/riscv/kernel/smpboot.c       |  7 +++++++
 arch/riscv/kernel/suspend_entry.S |  2 --
 7 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 776354895b81..be4e4e5ac134 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -109,19 +109,13 @@
 	REG_L \dst, 0(\dst)
 .endm
 
-#ifdef CONFIG_SHADOW_CALL_STACK
-/* gp is used as the shadow call stack pointer instead */
-.macro load_global_pointer
+.macro load_pcpu_off_gp tmp
+	REG_L \tmp, TASK_TI_CPU(tp)
+	slli \tmp, \tmp, 3
+	la gp, __per_cpu_offset
+	add gp, gp, \tmp
+	REG_L gp, 0(gp)
 .endm
-#else
-/* load __global_pointer to gp */
-.macro load_global_pointer
-.option push
-.option norelax
-	la gp, __global_pointer$
-.option pop
-.endm
-#endif /* CONFIG_SHADOW_CALL_STACK */
 
 	/* save all GPs except x1 ~ x5 */
 	.macro save_from_x6_to_x31
diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/percpu.h
new file mode 100644
index 000000000000..858d0a93ff14
--- /dev/null
+++ b/arch/riscv/include/asm/percpu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_PERCPU_H
+#define __ASM_PERCPU_H
+
+static inline void set_my_cpu_offset(unsigned long off)
+{
+	asm volatile("addi gp, %0, 0" :: "r" (off));
+}
+
+static inline unsigned long __kern_my_cpu_offset(void)
+{
+	unsigned long off;
+
+	asm ("mv %0, gp":"=r" (off) :);
+	return off;
+}
+
+#define __my_cpu_offset __kern_my_cpu_offset()
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_PERCPU_H */
+
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index b09ca5f944f7..5cc6d1de4ab4 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -36,6 +36,7 @@ void asm_offsets(void)
 	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
 	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
 	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
+	OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
 	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ac2e908d4418..39d7e66567cf 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -77,8 +77,8 @@ SYM_CODE_START(handle_exception)
 	 */
 	csrw CSR_SCRATCH, x0
 
-	/* Load the global pointer */
-	load_global_pointer
+	/* load __per_cpu_offset[cpu] to gp*/
+	load_pcpu_off_gp t6
 
 	/* Load the kernel shadow call stack pointer if coming from userspace */
 	scs_load_current_if_task_changed s5
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..aa3d22967eef 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -110,9 +110,6 @@ relocate_enable_mmu:
 	la a0, .Lsecondary_park
 	csrw CSR_TVEC, a0
 
-	/* Reload the global pointer */
-	load_global_pointer
-
 	/*
 	 * Switch to kernel page tables.  A full fence is necessary in order to
 	 * avoid using the trampoline translations, which are only correct for
@@ -131,9 +128,6 @@ secondary_start_sbi:
 	csrw CSR_IE, zero
 	csrw CSR_IP, zero
 
-	/* Load the global pointer */
-	load_global_pointer
-
 	/*
 	 * Disable FPU & VECTOR to detect illegal usage of
 	 * floating point or vector in kernel space
@@ -228,9 +222,6 @@ SYM_CODE_START(_start_kernel)
 	csrr a0, CSR_MHARTID
 #endif /* CONFIG_RISCV_M_MODE */
 
-	/* Load the global pointer */
-	load_global_pointer
-
 	/*
 	 * Disable FPU & VECTOR to detect illegal usage of
 	 * floating point or vector in kernel space
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..844aede75662 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -41,6 +41,11 @@
 
 static DECLARE_COMPLETION(cpu_running);
 
+void __init smp_prepare_boot_cpu(void)
+{
+	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
+}
+
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	int cpuid;
@@ -212,6 +217,8 @@ asmlinkage __visible void smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int curr_cpuid = smp_processor_id();
 
+	set_my_cpu_offset(per_cpu_offset(curr_cpuid));
+
 	if (has_vector()) {
 		/*
 		 * Return as early as possible so the hart with a mismatching
diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
index 2d54f309c140..0ec850489e0c 100644
--- a/arch/riscv/kernel/suspend_entry.S
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -60,8 +60,6 @@ SYM_FUNC_START(__cpu_suspend_enter)
 SYM_FUNC_END(__cpu_suspend_enter)
 
 SYM_TYPED_FUNC_START(__cpu_resume_enter)
-	/* Load the global pointer */
-	load_global_pointer
 
 #ifdef CONFIG_MMU
 	/* Save A0 and A1 */
-- 
2.39.2


