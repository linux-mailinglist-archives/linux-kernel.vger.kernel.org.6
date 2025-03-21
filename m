Return-Path: <linux-kernel+bounces-570760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D1A6B444
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCC83B8AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737971E3DDE;
	Fri, 21 Mar 2025 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HoI9vKEQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57E1E9919
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537172; cv=none; b=qWg0DDP0hJYW+IOqKPP/f59q2Kzv0/l4ZfpEzwNvIoNjxGV7WTWBiNvuShtggNwUdhpErJjrXRPRBZotFWWAt8rS7PkTNwY4K+c2dW9aTAG7IlvrKnhGdDlUCrpJCHKTbdBhnx/dixttTBJPQ7vhXhTN/B6nOmeENzQ+3oK73gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537172; c=relaxed/simple;
	bh=7RH9zhEEADKHaK0m0DTHqN6Zk4O0+WTkuGYLuqyzjPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuJYYQlxFJyLdmyZStaM0XBIVJM36vWYsKundCeuCe0co5cekTywPo8qIgUy2nWSnmKkOItx8ft+Sl0JLoR9/OzlwM5PcZMy1edNh3rl+dL6HiLsl29Ek6XSjX/Wgu1SME8sM60pTceVZlfXg7wyuyAqfhfZ8u7GM/Lfr/OzwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HoI9vKEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55FBC4CEE8;
	Fri, 21 Mar 2025 06:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742537171;
	bh=7RH9zhEEADKHaK0m0DTHqN6Zk4O0+WTkuGYLuqyzjPI=;
	h=From:To:Cc:Subject:Date:From;
	b=HoI9vKEQHa/onv//4dfMX3DelKjqEBX8sCT/wD+qTw9g2I0Q8lJ+4wvFp2pfqEJjE
	 juMxPMlMFpL2kdMYEBEIiLn49i1ud5A6EZ8mjHJ9oz4+uhJuDrWo4r73tL0VEMjh/N
	 f6HiRSxO/pbKZcgztAbEnk70WN6euoQClN1nivUNYvQGDxgAydbrugjrOEhy1WW06A
	 31y5OBFudzObq7+96ITNy+sdL/2UTSElsq1xbYXEpEp8RhfqOyu0BlK0H9huQz1ZQO
	 NnLYKzY7mNIN5M5mHPxWL+Vv7DBWSUI0xCbVmjfohSenLSfspfgkHpcNqBDror0hXU
	 F6yJUOBJ5nWpw==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] tracing: Disable branch profiling in noinstr code
Date: Thu, 20 Mar 2025 23:05:24 -0700
Message-ID: <52a664ec9e14ef53c39c3d4fa400c2f1d29348c0.1742537096.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_TRACE_BRANCH_PROFILING inserts a call to ftrace_likely_update()
for each use of likely() or unlikely().  If the caller is noinstr, that
breaks the noinstr rules.

Disable branch profiling for files which have noinstr functions.  Fixes
many warnings like the following:

  vmlinux.o: warning: objtool: do_syscall_64+0x40: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __rdgsbase_inactive+0x33: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: warning: objtool: handle_bug.isra.0+0x198: call to ftrace_likely_update() leaves .noinstr.text section
  ...

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/coco/Makefile                 | 4 ++++
 arch/x86/coco/sev/Makefile             | 3 +++
 arch/x86/coco/sev/core.c               | 2 --
 arch/x86/coco/tdx/Makefile             | 3 +++
 arch/x86/entry/Makefile                | 3 +++
 arch/x86/events/amd/Makefile           | 6 ++++++
 arch/x86/kernel/Makefile               | 3 +++
 arch/x86/kernel/acpi/Makefile          | 3 +++
 arch/x86/kernel/cpu/Makefile           | 3 +++
 arch/x86/kernel/cpu/mce/Makefile       | 5 +++++
 arch/x86/kernel/cpu/microcode/Makefile | 4 ++++
 arch/x86/kernel/fpu/Makefile           | 3 +++
 arch/x86/kernel/head64.c               | 2 --
 arch/x86/kvm/Makefile                  | 3 +++
 arch/x86/mm/Makefile                   | 4 ++++
 arch/x86/mm/kasan_init_64.c            | 1 -
 arch/x86/mm/mem_encrypt_amd.c          | 2 --
 arch/x86/mm/mem_encrypt_identity.c     | 2 --
 arch/x86/um/vdso/um_vdso.c             | 4 ----
 arch/x86/xen/Makefile                  | 3 +++
 drivers/acpi/Makefile                  | 4 ++++
 drivers/cpuidle/Makefile               | 3 +++
 drivers/idle/Makefile                  | 5 ++++-
 kernel/Makefile                        | 5 +++++
 kernel/entry/Makefile                  | 3 +++
 kernel/sched/Makefile                  | 5 +++++
 kernel/time/Makefile                   | 6 ++++++
 lib/Makefile                           | 5 +++++
 28 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index eabdc7486538..4652d578ff86 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -1,6 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_REMOVE_core.o	= -pg
 KASAN_SANITIZE_core.o	:= n
+
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 CFLAGS_core.o		+= -fno-stack-protector
 
 obj-y += core.o
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index dcb06dc8b5ae..3389701f02c3 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -10,6 +10,9 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_core.o = -pg
 endif
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 KASAN_SANITIZE_core.o	:= n
 KMSAN_SANITIZE_core.o	:= n
 KCOV_INSTRUMENT_core.o	:= n
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 96c7bc698e6b..d14bce0f82cc 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -9,8 +9,6 @@
 
 #define pr_fmt(fmt)	"SEV: " fmt
 
-#define DISABLE_BRANCH_PROFILING
-
 #include <linux/sched/debug.h>	/* For show_regs() */
 #include <linux/percpu-defs.h>
 #include <linux/cc_platform.h>
diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index b3c47d3700e2..48cd79754ce3 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y += debug.o tdcall.o tdx.o tdx-shared.o
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index ce1cc1622385..7234a0271299 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,6 +7,9 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index 527d947eb76b..6ed95f60ff2f 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_brs.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 obj-$(CONFIG_CPU_SUP_AMD)		+= core.o lbr.o
 obj-$(CONFIG_PERF_EVENTS_AMD_BRS)	+= brs.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 84cfa179802c..41206d15d32c 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -19,6 +19,9 @@ CFLAGS_REMOVE_head64.o = -pg
 CFLAGS_REMOVE_head32.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
+#
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
 
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index 842a5f449404..88624ae32cdf 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 4efdf5c2efc8..016fae1f86c3 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -3,6 +3,9 @@
 # Makefile for x86-compatible CPU details, features and quirks
 #
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 # Don't trace early stages of a secondary CPU boot
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_common.o = -pg
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 015856abdbb1..878d03c77050 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,4 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+#
+
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
diff --git a/arch/x86/kernel/cpu/microcode/Makefile b/arch/x86/kernel/cpu/microcode/Makefile
index 193d98b33a0a..8409a9a7efe2 100644
--- a/arch/x86/kernel/cpu/microcode/Makefile
+++ b/arch/x86/kernel/cpu/microcode/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 microcode-y				:= core.o
 obj-$(CONFIG_MICROCODE)			+= microcode.o
 microcode-$(CONFIG_CPU_SUP_INTEL)	+= intel.o
diff --git a/arch/x86/kernel/fpu/Makefile b/arch/x86/kernel/fpu/Makefile
index 78c5621457d4..e510d6893363 100644
--- a/arch/x86/kernel/fpu/Makefile
+++ b/arch/x86/kernel/fpu/Makefile
@@ -3,4 +3,7 @@
 # Build rules for the FPU support code:
 #
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y				+= init.o bugs.o core.o regset.o signal.o xstate.o
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 05f8b8acf784..fa9b6339975f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -5,8 +5,6 @@
  *  Copyright (C) 2000 Andrea Arcangeli <andrea@suse.de> SuSE
  */
 
-#define DISABLE_BRANCH_PROFILING
-
 /* cpu_feature_enabled() cannot be used this early */
 #define USE_EARLY_PGTABLE_L5
 
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index f9dddb8cb466..3682723a0712 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 ccflags-y += -I $(srctree)/arch/x86/kvm
 ccflags-$(CONFIG_KVM_WERROR) += -Werror
 
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 690fbf48e853..978001602a46 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
 KCOV_INSTRUMENT_tlb.o			:= n
 KCOV_INSTRUMENT_mem_encrypt.o		:= n
diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
index 9dddf19a5571..0539efd0d216 100644
--- a/arch/x86/mm/kasan_init_64.c
+++ b/arch/x86/mm/kasan_init_64.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define DISABLE_BRANCH_PROFILING
 #define pr_fmt(fmt) "kasan: " fmt
 
 /* cpu_feature_enabled() cannot be used this early */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index b56c5c073003..7490ff6d83b1 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -7,8 +7,6 @@
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
-#define DISABLE_BRANCH_PROFILING
-
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/mm.h>
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 9fce5b87b8c5..5eecdd92da10 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -7,8 +7,6 @@
  * Author: Tom Lendacky <thomas.lendacky@amd.com>
  */
 
-#define DISABLE_BRANCH_PROFILING
-
 /*
  * Since we're dealing with identity mappings, physical and virtual
  * addresses are the same, so override these defines which are ultimately
diff --git a/arch/x86/um/vdso/um_vdso.c b/arch/x86/um/vdso/um_vdso.c
index cbae2584124f..0cf7d5ee4e51 100644
--- a/arch/x86/um/vdso/um_vdso.c
+++ b/arch/x86/um/vdso/um_vdso.c
@@ -5,10 +5,6 @@
  * This vDSO turns all calls into a syscall so that UML can trap them.
  */
 
-
-/* Disable profiling for userspace code */
-#define DISABLE_BRANCH_PROFILING
-
 #include <linux/time.h>
 #include <linux/getcpu.h>
 #include <asm/unistd.h>
diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index a9ec8c9f5c5d..e8f41e2c09b2 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
 CFLAGS_REMOVE_spinlock.o = -pg
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40208a0f5dfb..797070fc9a3f 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -5,6 +5,10 @@
 
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
 
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_processor_idle.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 #
 # ACPI Boot-Time Table Parsing
 #
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index d103342b7cfc..1de9e92c5b0f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -3,6 +3,9 @@
 # Makefile for cpuidle.
 #
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 obj-$(CONFIG_DT_IDLE_STATES)		  += dt_idle_states.o
diff --git a/drivers/idle/Makefile b/drivers/idle/Makefile
index 0a3c37510079..a34af1ba09bd 100644
--- a/drivers/idle/Makefile
+++ b/drivers/idle/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_INTEL_IDLE)			+= intel_idle.o
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
+obj-$(CONFIG_INTEL_IDLE)			+= intel_idle.o
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..434929de17ef 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -21,6 +21,11 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_irq_work.o = $(CC_FLAGS_FTRACE)
 endif
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_context_tracking.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
 # in coverage traces.
 KCOV_INSTRUMENT_softirq.o := n
diff --git a/kernel/entry/Makefile b/kernel/entry/Makefile
index 095c775e001e..d4b8bd0af79b 100644
--- a/kernel/entry/Makefile
+++ b/kernel/entry/Makefile
@@ -6,6 +6,9 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
+# Branch profiling isn't noinstr-safe
+ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 CFLAGS_REMOVE_common.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_common.o		+= -fno-stack-protector
 
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 976092b7bd45..8ae86371ddcd 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -22,6 +22,11 @@ ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_build_policy.o += -DDISABLE_BRANCH_PROFILING
+CFLAGS_build_utility.o += -DDISABLE_BRANCH_PROFILING
+endif
 #
 # Build efficiency:
 #
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index fe0ae82124fe..e6e9b85d4db5 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -1,4 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_sched_clock.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 obj-y += time.o timer.o hrtimer.o sleep_timeout.o
 obj-y += timekeeping.o ntp.o clocksource.o jiffies.o timer_list.o
 obj-y += timeconv.o timecounter.o alarmtimer.o
diff --git a/lib/Makefile b/lib/Makefile
index fcdee83deb5c..8627b7ab827b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,6 +5,11 @@
 
 ccflags-remove-$(CONFIG_FUNCTION_TRACER) += $(CC_FLAGS_FTRACE)
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_smp_processor_id.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 # These files are disabled because they produce lots of non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. For example,
 # rbtree can be global and individual rotations don't correlate with inputs.
-- 
2.48.1


