Return-Path: <linux-kernel+bounces-331478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E199297AD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42C0284A6C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D9517C9E9;
	Tue, 17 Sep 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rdtrZAh1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bVNUUhpq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49215C14F
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563258; cv=none; b=nIgct2bHHD8xt3MPqKAQAPncKsZOyUQs93HRIEbGV9RryE4PD/ipEOUvvniaVD2rbrOEwRZlCKdl5AV9GIe7KhriZWEHvGaP0NWw4WICPaaaXRXTOvrqIwyB9f+ZCQjprQYuLpU179EWuX7X6cpP2WDf0ovnQBfpbs6LaIm1nNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563258; c=relaxed/simple;
	bh=0hYW5Y7NChAh9G5FQ84NZfN9aizta0+1DBcUqyKh46M=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=JKA3v3CFsd0yeSsi4UYNZn8hVXwlUuVNXN3+ouGd0BVP0Uk/E3hI8+dwV+EAkASRD5AHkGhP/C2PBi1zNErgqWhnlq3rI7mcnDt7tMEmm/FxfD4ENOan4E+gtzv9EIXg/W0PTC/15hfrweMk+Cgc50Rfil9IyK676BRuAcvGmN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rdtrZAh1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bVNUUhpq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=1BWLbpB42A8rSm7pZcwVPssr/q++mY2ctu0kZjrfpfY=;
	b=rdtrZAh1NeG7MxZIC0XQtglAhv3z/5+Ycju9MYpvne8Esdt73rnaMXXuEKcKhq90vsmk5d
	wL6YSgOI6rGqk8YXyrVJUg1SdT2WdZ3m0zgBFX+tv3vRY1Fgf+fm31s6fiMrCzX2LTvv1w
	qUS1FC7/YlxKRSPWi+pSqoChBkpLlD9FOUE06SPWFY5bW4HgVrHgNKRd9po1JaVBL4vJFr
	1ys6JuaNc99MQ536L1YXXZepNFo7gN6dhNoSYoTFZuJ7KI3i8SRF5nmi85I1cbdifwlGQI
	JL2wTdLvFllTCIRwKfVagKA3VsTe2rXuunvK02YlGN0CTbVQo5v1aPi40+iR5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=1BWLbpB42A8rSm7pZcwVPssr/q++mY2ctu0kZjrfpfY=;
	b=bVNUUhpq0nspCHcuMzww5lOFOMppy3winoxMyNwS4fkZjbwvKEOJSr4VG5q0UbTjnvNNJj
	I5nYSKGg0jxHrrAw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/fred for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656198906.2471820.7237893424649453751.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:12 +0200 (CEST)

Linus,

please pull the latest x86/fred branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fred-2024-09=
-17

up to:  fe85ee391966: x86/entry: Set FRED RSP0 on return to userspace instead=
 of context switch

Updates for x86 FRED:

  - Enable FRED right after init_mem_mapping() because at that point the
    early IDT fault handler is replaced by the real fault handler. The real
    fault handler retrieves the faulting address from the stack frame and
    not from CR2 when the FRED feature is set. But that obviously only
    works when FRED is enabled in the CPU as well.

  - Set SS to __KERNEL_DS when enabling FRED to prevent a corner case where
    ERETS can observe a SS mismatch and raises a #GP.


Thanks,

	tglx

------------------>
Andrew Cooper (1):
      x86/msr: Switch between WRMSRNS and WRMSR with the alternatives mechani=
sm

Xin Li (Intel) (6):
      x86/fred: Parse cmdline param "fred=3D" in cpu_parse_early_param()
      x86/fred: Move FRED RSP initialization into a separate function
      x86/fred: Enable FRED right after init_mem_mapping()
      x86/fred: Set SS to __KERNEL_DS when enabling FRED
      x86/entry: Test ti_work for zero before processing individual bits
      x86/entry: Set FRED RSP0 on return to userspace instead of context swit=
ch


 arch/x86/include/asm/entry-common.h | 13 +++++++++--
 arch/x86/include/asm/fred.h         | 23 ++++++++++++++++++-
 arch/x86/include/asm/msr.h          | 25 +++++++++------------
 arch/x86/include/asm/processor.h    |  3 ++-
 arch/x86/include/asm/switch_to.h    |  6 +----
 arch/x86/kernel/cpu/common.c        | 22 ++++++++++++++++--
 arch/x86/kernel/cpu/cpuid-deps.c    |  1 -
 arch/x86/kernel/fred.c              | 45 +++++++++++++++++++++++++++++------=
--
 arch/x86/kernel/setup.c             |  7 +++++-
 arch/x86/kernel/smpboot.c           |  2 +-
 arch/x86/kernel/traps.c             | 28 +----------------------
 11 files changed, 111 insertions(+), 64 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry=
-common.h
index fb2809b20b0a..77d20555e04d 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -8,6 +8,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/io_bitmap.h>
 #include <asm/fpu/api.h>
+#include <asm/fred.h>
=20
 /* Check that the stack and regs on entry from user mode are sane. */
 static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
@@ -44,8 +45,7 @@ static __always_inline void arch_enter_from_user_mode(struc=
t pt_regs *regs)
 }
 #define arch_enter_from_user_mode arch_enter_from_user_mode
=20
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work)
+static inline void arch_exit_work(unsigned long ti_work)
 {
 	if (ti_work & _TIF_USER_RETURN_NOTIFY)
 		fire_user_return_notifiers();
@@ -56,6 +56,15 @@ static inline void arch_exit_to_user_mode_prepare(struct p=
t_regs *regs,
 	fpregs_assert_state_consistent();
 	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
+}
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
+		arch_exit_work(ti_work);
+
+	fred_update_rsp0();
=20
 #ifdef CONFIG_COMPAT
 	/*
diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index e86c7ba32435..25ca00bd70e8 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -36,6 +36,7 @@
=20
 #ifdef CONFIG_X86_FRED
 #include <linux/kernel.h>
+#include <linux/sched/task_stack.h>
=20
 #include <asm/ptrace.h>
=20
@@ -84,13 +85,33 @@ static __always_inline void fred_entry_from_kvm(unsigned =
int type, unsigned int
 }
=20
 void cpu_init_fred_exceptions(void);
+void cpu_init_fred_rsps(void);
 void fred_complete_exception_setup(void);
=20
+DECLARE_PER_CPU(unsigned long, fred_rsp0);
+
+static __always_inline void fred_sync_rsp0(unsigned long rsp0)
+{
+	__this_cpu_write(fred_rsp0, rsp0);
+}
+
+static __always_inline void fred_update_rsp0(void)
+{
+	unsigned long rsp0 =3D (unsigned long) task_stack_page(current) + THREAD_SI=
ZE;
+
+	if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fred_rsp0) !=
=3D rsp0)) {
+		wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
+		__this_cpu_write(fred_rsp0, rsp0);
+	}
+}
 #else /* CONFIG_X86_FRED */
 static __always_inline unsigned long fred_event_data(struct pt_regs *regs) {=
 return 0; }
 static inline void cpu_init_fred_exceptions(void) { }
+static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
-static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned =
int vector) { }
+static inline void fred_entry_from_kvm(unsigned int type, unsigned int vecto=
r) { }
+static inline void fred_sync_rsp0(unsigned long rsp0) { }
+static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index d642037f9ed5..001853541f1e 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -99,19 +99,6 @@ static __always_inline void __wrmsr(unsigned int msr, u32 =
low, u32 high)
 		     : : "c" (msr), "a"(low), "d" (high) : "memory");
 }
=20
-/*
- * WRMSRNS behaves exactly like WRMSR with the only difference being
- * that it is not a serializing instruction by default.
- */
-static __always_inline void __wrmsrns(u32 msr, u32 low, u32 high)
-{
-	/* Instruction opcode for WRMSRNS; supported in binutils >=3D 2.40. */
-	asm volatile("1: .byte 0x0f,0x01,0xc6\n"
-		     "2:\n"
-		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a"(low), "d" (high));
-}
-
 #define native_rdmsr(msr, val1, val2)			\
 do {							\
 	u64 __val =3D __rdmsr((msr));			\
@@ -312,9 +299,19 @@ do {							\
=20
 #endif	/* !CONFIG_PARAVIRT_XXL */
=20
+/* Instruction opcode for WRMSRNS supported in binutils >=3D 2.40 */
+#define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
+
+/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR=
. */
 static __always_inline void wrmsrns(u32 msr, u64 val)
 {
-	__wrmsrns(msr, val, val >> 32);
+	/*
+	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
+	 * DS prefix to avoid a trailing NOP.
+	 */
+	asm volatile("1: " ALTERNATIVE("ds wrmsr", WRMSRNS, X86_FEATURE_WRMSRNS)
+		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
+		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
 }
=20
 /*
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processo=
r.h
index a75a07f4931f..399f7d1c4c61 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -582,7 +582,8 @@ extern void switch_gdt_and_percpu_base(int);
 extern void load_direct_gdt(int);
 extern void load_fixmap_gdt(int);
 extern void cpu_init(void);
-extern void cpu_init_exception_handling(void);
+extern void cpu_init_exception_handling(bool boot_cpu);
+extern void cpu_init_replace_early_idt(void);
 extern void cr4_init(void);
=20
 extern void set_task_blockstep(struct task_struct *task, bool on);
diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_t=
o.h
index c3bd0c0758c9..75248546403d 100644
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -70,13 +70,9 @@ static inline void update_task_stack(struct task_struct *t=
ask)
 #ifdef CONFIG_X86_32
 	this_cpu_write(cpu_tss_rw.x86_tss.sp1, task->thread.sp0);
 #else
-	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
-		/* WRMSRNS is a baseline feature for FRED. */
-		wrmsrns(MSR_IA32_FRED_RSP0, (unsigned long)task_stack_page(task) + THREAD_=
SIZE);
-	} else if (cpu_feature_enabled(X86_FEATURE_XENPV)) {
+	if (!cpu_feature_enabled(X86_FEATURE_FRED) && cpu_feature_enabled(X86_FEATU=
RE_XENPV))
 		/* Xen PV enters the kernel on the thread stack. */
 		load_sp0(task_top_of_stack(task));
-	}
 #endif
 }
=20
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d4e539d4e158..a4735d9b5a1d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1510,6 +1510,11 @@ static void __init cpu_parse_early_param(void)
 	if (cmdline_find_option_bool(boot_command_line, "nousershstk"))
 		setup_clear_cpu_cap(X86_FEATURE_USER_SHSTK);
=20
+	/* Minimize the gap between FRED is available and available but disabled. */
+	arglen =3D cmdline_find_option(boot_command_line, "fred", arg, sizeof(arg));
+	if (arglen !=3D 2 || strncmp(arg, "on", 2))
+		setup_clear_cpu_cap(X86_FEATURE_FRED);
+
 	arglen =3D cmdline_find_option(boot_command_line, "clearcpuid", arg, sizeof=
(arg));
 	if (arglen <=3D 0)
 		return;
@@ -2171,7 +2176,7 @@ static inline void tss_setup_io_bitmap(struct tss_struc=
t *tss)
  * Setup everything needed to handle exceptions from the IDT, including the =
IST
  * exceptions which use paranoid_entry().
  */
-void cpu_init_exception_handling(void)
+void cpu_init_exception_handling(bool boot_cpu)
 {
 	struct tss_struct *tss =3D this_cpu_ptr(&cpu_tss_rw);
 	int cpu =3D raw_smp_processor_id();
@@ -2190,10 +2195,23 @@ void cpu_init_exception_handling(void)
 	/* GHCB needs to be setup to handle #VC. */
 	setup_ghcb();
=20
+	if (cpu_feature_enabled(X86_FEATURE_FRED)) {
+		/* The boot CPU has enabled FRED during early boot */
+		if (!boot_cpu)
+			cpu_init_fred_exceptions();
+
+		cpu_init_fred_rsps();
+	} else {
+		load_current_idt();
+	}
+}
+
+void __init cpu_init_replace_early_idt(void)
+{
 	if (cpu_feature_enabled(X86_FEATURE_FRED))
 		cpu_init_fred_exceptions();
 	else
-		load_current_idt();
+		idt_setup_early_pf();
 }
=20
 /*
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-dep=
s.c
index b7d9f530ae16..8bd84114c2d9 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -83,7 +83,6 @@ static const struct cpuid_dep cpuid_deps[] =3D {
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
 	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_FRED,			X86_FEATURE_LKGS      },
-	{ X86_FEATURE_FRED,			X86_FEATURE_WRMSRNS   },
 	{}
 };
=20
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 4bcd8791ad96..8d32c3f48abc 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -21,17 +21,53 @@
=20
 #define FRED_STKLVL(vector, lvl)	((lvl) << (2 * (vector)))
=20
+DEFINE_PER_CPU(unsigned long, fred_rsp0);
+EXPORT_PER_CPU_SYMBOL(fred_rsp0);
+
 void cpu_init_fred_exceptions(void)
 {
 	/* When FRED is enabled by default, remove this log message */
 	pr_info("Initialize FRED on CPU%d\n", smp_processor_id());
=20
+	/*
+	 * If a kernel event is delivered before a CPU goes to user level for
+	 * the first time, its SS is NULL thus NULL is pushed into the SS field
+	 * of the FRED stack frame.  But before ERETS is executed, the CPU may
+	 * context switch to another task and go to user level.  Then when the
+	 * CPU comes back to kernel mode, SS is changed to __KERNEL_DS.  Later
+	 * when ERETS is executed to return from the kernel event handler, a #GP
+	 * fault is generated because SS doesn't match the SS saved in the FRED
+	 * stack frame.
+	 *
+	 * Initialize SS to __KERNEL_DS when enabling FRED to avoid such #GPs.
+	 */
+	loadsegment(ss, __KERNEL_DS);
+
 	wrmsrl(MSR_IA32_FRED_CONFIG,
 	       /* Reserve for CALL emulation */
 	       FRED_CONFIG_REDZONE |
 	       FRED_CONFIG_INT_STKLVL(0) |
 	       FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));
=20
+	wrmsrl(MSR_IA32_FRED_STKLVLS, 0);
+	wrmsrl(MSR_IA32_FRED_RSP0, 0);
+	wrmsrl(MSR_IA32_FRED_RSP1, 0);
+	wrmsrl(MSR_IA32_FRED_RSP2, 0);
+	wrmsrl(MSR_IA32_FRED_RSP3, 0);
+
+	/* Enable FRED */
+	cr4_set_bits(X86_CR4_FRED);
+	/* Any further IDT use is a bug */
+	idt_invalidate();
+
+	/* Use int $0x80 for 32-bit system calls in FRED mode */
+	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
+	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
+}
+
+/* Must be called after setup_cpu_entry_areas() */
+void cpu_init_fred_rsps(void)
+{
 	/*
 	 * The purpose of separate stacks for NMI, #DB and #MC *in the kernel*
 	 * (remember that user space faults are always taken on stack level 0)
@@ -47,13 +83,4 @@ void cpu_init_fred_exceptions(void)
 	wrmsrl(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
 	wrmsrl(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
 	wrmsrl(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
-
-	/* Enable FRED */
-	cr4_set_bits(X86_CR4_FRED);
-	/* Any further IDT use is a bug */
-	idt_invalidate();
-
-	/* Use int $0x80 for 32-bit system calls in FRED mode */
-	setup_clear_cpu_cap(X86_FEATURE_SYSENTER32);
-	setup_clear_cpu_cap(X86_FEATURE_SYSCALL32);
 }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6129dc2ba784..f1fea506e20f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1039,7 +1039,12 @@ void __init setup_arch(char **cmdline_p)
=20
 	init_mem_mapping();
=20
-	idt_setup_early_pf();
+	/*
+	 * init_mem_mapping() relies on the early IDT page fault handling.
+	 * Now either enable FRED or install the real page fault handler
+	 * for 64-bit in the IDT.
+	 */
+	cpu_init_replace_early_idt();
=20
 	/*
 	 * Update mmu_cr4_features (and, indirectly, trampoline_cr4_features)
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 0c35207320cb..dc4fff8fccce 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -246,7 +246,7 @@ static void notrace start_secondary(void *unused)
 		__flush_tlb_all();
 	}
=20
-	cpu_init_exception_handling();
+	cpu_init_exception_handling(false);
=20
 	/*
 	 * Load the microcode before reaching the AP alive synchronization
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4fa0b17e5043..197d5888b0e2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1402,34 +1402,8 @@ DEFINE_IDTENTRY_SW(iret_error)
 }
 #endif
=20
-/* Do not enable FRED by default yet. */
-static bool enable_fred __ro_after_init =3D false;
-
-#ifdef CONFIG_X86_FRED
-static int __init fred_setup(char *str)
-{
-	if (!str)
-		return -EINVAL;
-
-	if (!cpu_feature_enabled(X86_FEATURE_FRED))
-		return 0;
-
-	if (!strcmp(str, "on"))
-		enable_fred =3D true;
-	else if (!strcmp(str, "off"))
-		enable_fred =3D false;
-	else
-		pr_warn("invalid FRED option: 'fred=3D%s'\n", str);
-	return 0;
-}
-early_param("fred", fred_setup);
-#endif
-
 void __init trap_init(void)
 {
-	if (cpu_feature_enabled(X86_FEATURE_FRED) && !enable_fred)
-		setup_clear_cpu_cap(X86_FEATURE_FRED);
-
 	/* Init cpu_entry_area before IST entries are set up */
 	setup_cpu_entry_areas();
=20
@@ -1437,7 +1411,7 @@ void __init trap_init(void)
 	sev_es_init_vc_handling();
=20
 	/* Initialize TSS before setting up traps so ISTs work */
-	cpu_init_exception_handling();
+	cpu_init_exception_handling(true);
=20
 	/* Setup traps as cpu_init() might #GP */
 	if (!cpu_feature_enabled(X86_FEATURE_FRED))


