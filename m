Return-Path: <linux-kernel+bounces-571886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB226A6C3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54AF23B0FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F91EF090;
	Fri, 21 Mar 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGswRSrY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D69E18FC75
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586817; cv=none; b=YjzVeq6NEu3xS1i+V8Vt6htqOw75U94gZ137RO1QXHaav1Yj4dAy1MCwRAW0axHDczomNzvGSgT/YlcHPMZYqlHIY/kGa3Lwm3YVtVtdCb5SuM51kxdiPX5W/tTC68nMqFXUIVmEr6hlrPkk1bjQxaGki2wlFrtAxP8/P/sMzDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586817; c=relaxed/simple;
	bh=c8FJ+llQ15GZ1HQtRzW115bMUmPvehE6errInggrfG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojET08avbRM6QoS/iKPh7T4ampRqkRWTJtZKojnXDRbdG1tpzNg+xqtZLc+z7WAyfVtePEX6b5h7Fxe08cw3IX1Ztsh5KKnDcjOVaD6PqCwtlPxgAMwOz4FRgnzdduqGm+xHi1ipqiWe10Hk23+yF7PzuO2TrwZhDmo5qevSbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGswRSrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA3FC4CEE3;
	Fri, 21 Mar 2025 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742586816;
	bh=c8FJ+llQ15GZ1HQtRzW115bMUmPvehE6errInggrfG0=;
	h=From:To:Cc:Subject:Date:From;
	b=JGswRSrYaefnsu/qDucqjy+ZZpRVFm4Eqb2qyykO7km7B0+kEobeVTpFAMXdhe+n6
	 F1TA2VlV8ocwbeliCmEUDsGS1fwemJ+ihMB5sRcpFBRHjvKLUhESkgbvSd9PQ/37xs
	 1/GCbMgwYUEEGAWm0rT0muGczM4gBCt7h77EDYKvFPvqVAzrQXMnJxO6AisPGwFIeM
	 nhdqUtkL/b0dy7xeg9jJ8TAlKsrYCw+nZ9TyXBAs6uCRwJ/KUgELPrWAJ6K13WEU3p
	 BEhM7dj7C+Vc2dZsediKKZNmFUqeSTZp+kvaCtzP5FVOyXpTrd6IgncbF9RDsCBcti
	 dzAGOQIPi8yIg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] tracing: Disable branch profiling in noinstr code
Date: Fri, 21 Mar 2025 12:53:32 -0700
Message-ID: <fb94fc9303d48a5ed370498f54500cc4c338eb6d.1742586676.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_TRACE_BRANCH_PROFILING inserts a call to ftrace_likely_update()
for each use of likely() or unlikely().  That breaks noinstr rules if
the affected function is annotated as noinstr.

Disable branch profiling for files with noinstr functions.  In addition
to some individual files, this also includes the entire arch/x86
subtree, as well as the kernel/entry, drivers/cpuidle, and drivers/idle
directories, all of which are noinstr-heavy.

Due to the nature of how sched binaries are built by combining multiple
.c files into one, branch profiling is disabled more broadly across the
sched code than would otherwise be needed.

This fixes many warnings like the following:

  vmlinux.o: warning: objtool: do_syscall_64+0x40: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: warning: objtool: __rdgsbase_inactive+0x33: call to ftrace_likely_update() leaves .noinstr.text section
  vmlinux.o: warning: objtool: handle_bug.isra.0+0x198: call to ftrace_likely_update() leaves .noinstr.text section
  ...

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
v2:
- disable for entire arch/x86/* subtree
- improve commit log

 arch/x86/Kbuild                    | 4 ++++
 arch/x86/coco/sev/core.c           | 2 --
 arch/x86/kernel/head64.c           | 2 --
 arch/x86/mm/kasan_init_64.c        | 1 -
 arch/x86/mm/mem_encrypt_amd.c      | 2 --
 arch/x86/mm/mem_encrypt_identity.c | 2 --
 drivers/acpi/Makefile              | 4 ++++
 drivers/cpuidle/Makefile           | 3 +++
 drivers/idle/Makefile              | 5 ++++-
 kernel/Makefile                    | 5 +++++
 kernel/entry/Makefile              | 3 +++
 kernel/sched/Makefile              | 5 +++++
 kernel/time/Makefile               | 6 ++++++
 lib/Makefile                       | 5 +++++
 14 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index cf0ad89f5639..f7fb3d88c57b 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
+
+# Branch profiling isn't noinstr-safe.  Disable it for arch/x86/*
+subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-$(CONFIG_ARCH_HAS_CC_PLATFORM) += coco/
 
 obj-y += entry/
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


