Return-Path: <linux-kernel+bounces-396363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE369BCC23
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17103B226BF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B881D47D9;
	Tue,  5 Nov 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LfkT4zbr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686841D63CA
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807280; cv=none; b=rhK8jtc5aZcukXIfCkQjKFOS47AbbWuLDCdMKX97ff/frjGRx5mlRulSSnA8742oWLUPLlsgxkk9Cs6zIgJaLWJFG6jCMlG0gilvrSrkeKcyl0y+LF0LDRh5OKWEhN2HooFjeIUJT/kD7+WXA1/1jEy4RMQh4zTuos9ckv6ZbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807280; c=relaxed/simple;
	bh=szNbdrhpnXndxOrDkWTwLe8HuddLoKwrXGrWpxacWgQ=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FHke5cgFwApdHEuKUoXaOXp7/91xikcwBbEBJzVSWl6XYUrMvJYW1qNIOd8bErGa/GaBynK0o15Z2lyfVnHGzepfti8a0xPuKuudjIRcg2xyHxKwXlHpqxnvRyWHHRQOvjX9jY18WFlHu9vsSxxdSd07wUVS0gk8W6h2AeIyoEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LfkT4zbr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=Gw8dwo72+WnkSuAPs5HKzZFSe0d/EX/tyM4AjGZfcWo=; b=LfkT4zbrvblasAIxLglP2cvNp/
	93zjKEKEka/Rs8FL2F/de9I46BGUND8X047jBRwaBJWEuewBwjiwGcOwOCC1kb848kBdN0l4DGzsp
	kDmPlKv8i5/o8O14neKf8zCUY+XzJCRpUi1b42GrYbzFsJ/uo6hAhl2zWlMmzEDLbA3PZISBqt+kk
	JqF9FRk29kmxj55bft+a0TtFO62KRH7m0GaOKTpKvwCs9Xx20850ueVb4MH0G/f1T01Up3eCwrYFJ
	6oiUkkrZaZPnuc2/kS4nbLJkBmxs6FAnn9pE5/NPk5dl9pWCogorNggRFmomWjXlNoQHlf6kyV7JG
	lN9z0OsA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2E-00000002iAH-16GU;
	Tue, 05 Nov 2024 11:47:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DEB7830078C; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114521.962085613@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:03 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 alexei.starovoitov@gmail.com,
 ebiggers@kernel.org,
 samitolvanen@google.com,
 kees@kernel.org
Subject: [PATCH 2/8] x86/cfi: Clean up linkage
References: <20241105113901.348320374@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

With the introduction of kCFI the addition of ENDBR to
SYM_FUNC_START* no longer suffices to make the function indirectly
callable. This now requires the use of SYM_TYPED_FUNC_START.

As such, remove the implicit ENDBR from SYM_FUNC_START* and add some
explicit annotations to fix things up again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/crypto/aesni-intel_asm.S     |    2 ++
 arch/x86/entry/calling.h              |    1 +
 arch/x86/entry/entry_64.S             |    1 +
 arch/x86/entry/entry_64_fred.S        |    1 +
 arch/x86/include/asm/linkage.h        |   18 ++++++------------
 arch/x86/include/asm/paravirt_types.h |   12 +++++++++++-
 arch/x86/include/asm/special_insns.h  |    4 ++--
 arch/x86/kernel/acpi/madt_playdead.S  |    1 +
 arch/x86/kernel/acpi/wakeup_64.S      |    1 +
 arch/x86/kernel/ftrace_64.S           |    5 +++++
 arch/x86/kernel/irqflags.S            |    1 +
 arch/x86/kernel/paravirt.c            |   14 ++++++++++++--
 arch/x86/lib/retpoline.S              |    1 +
 arch/x86/mm/mem_encrypt_boot.S        |    1 +
 arch/x86/power/hibernate_asm_64.S     |    2 ++
 arch/x86/xen/xen-asm.S                |    5 +++++
 16 files changed, 53 insertions(+), 17 deletions(-)

--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -17,6 +17,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/objtool.h>
 #include <asm/frame.h>
 
 #define STATE1	%xmm0
@@ -1071,6 +1072,7 @@ SYM_FUNC_END(_aesni_inc)
  *		      size_t len, u8 *iv)
  */
 SYM_FUNC_START(aesni_ctr_enc)
+	ANNOTATE_NOENDBR
 	FRAME_BEGIN
 	cmp $16, LEN
 	jb .Lctr_enc_just_ret
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -431,6 +431,7 @@ For 32-bit we have the following convent
 /* rdi:	arg1 ... normal C conventions. rax is saved/restored. */
 .macro THUNK name, func
 SYM_FUNC_START(\name)
+	ANNOTATE_NOENDBR
 	pushq %rbp
 	movq %rsp, %rbp
 
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -176,6 +176,7 @@ SYM_CODE_END(entry_SYSCALL_64)
  */
 .pushsection .text, "ax"
 SYM_FUNC_START(__switch_to_asm)
+	ANNOTATE_NOENDBR
 	/*
 	 * Save callee-saved registers
 	 * This must match the order in inactive_task_frame
--- a/arch/x86/entry/entry_64_fred.S
+++ b/arch/x86/entry/entry_64_fred.S
@@ -58,6 +58,7 @@ SYM_CODE_END(asm_fred_entrypoint_kernel)
 
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 SYM_FUNC_START(asm_fred_entry_from_kvm)
+	ANNOTATE_NOENDBR
 	push %rbp
 	mov %rsp, %rbp
 
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -119,33 +119,27 @@
 
 /* SYM_FUNC_START -- use for global functions */
 #define SYM_FUNC_START(name)				\
-	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)	\
-	ENDBR
+	SYM_START(name, SYM_L_GLOBAL, SYM_F_ALIGN)
 
 /* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
 #define SYM_FUNC_START_NOALIGN(name)			\
-	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
-	ENDBR
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)
 
 /* SYM_FUNC_START_LOCAL -- use for local functions */
 #define SYM_FUNC_START_LOCAL(name)			\
-	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)	\
-	ENDBR
+	SYM_START(name, SYM_L_LOCAL, SYM_F_ALIGN)
 
 /* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
 #define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
-	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
-	ENDBR
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)
 
 /* SYM_FUNC_START_WEAK -- use for weak functions */
 #define SYM_FUNC_START_WEAK(name)			\
-	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)	\
-	ENDBR
+	SYM_START(name, SYM_L_WEAK, SYM_F_ALIGN)
 
 /* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
 #define SYM_FUNC_START_WEAK_NOALIGN(name)		\
-	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
-	ENDBR
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)
 
 #endif /* _ASM_X86_LINKAGE_H */
 
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -246,7 +246,17 @@ extern struct paravirt_patch_template pv
 
 int paravirt_disable_iospace(void);
 
-/* This generates an indirect call based on the operation type number. */
+/*
+ * This generates an indirect call based on the operation type number.
+ *
+ * Since alternatives run after enabling CET/IBT -- the latter setting/clearing
+ * capabilities and the former requiring all capabilities being finalized --
+ * these indirect calls are subject to IBT and the paravirt stubs should have
+ * ENDBR on.
+ *
+ * OTOH since this is effectively a __nocfi indirect call, the paravirt stubs
+ * don't need to bother with CFI prefixes.
+ */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
 	"call *%[paravirt_opptr];"
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -42,14 +42,14 @@ static __always_inline void native_write
 	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
 }
 
-static inline unsigned long __native_read_cr3(void)
+static __always_inline unsigned long __native_read_cr3(void)
 {
 	unsigned long val;
 	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
 	return val;
 }
 
-static inline void native_write_cr3(unsigned long val)
+static __always_inline void native_write_cr3(unsigned long val)
 {
 	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
 }
--- a/arch/x86/kernel/acpi/madt_playdead.S
+++ b/arch/x86/kernel/acpi/madt_playdead.S
@@ -14,6 +14,7 @@
  * rsi: PGD of the identity mapping
  */
 SYM_FUNC_START(asm_acpi_mp_play_dead)
+	ANNOTATE_NOENDBR
 	/* Turn off global entries. Following CR3 write will flush them. */
 	movq	%cr4, %rdx
 	andq	$~(X86_CR4_PGE), %rdx
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -17,6 +17,7 @@
 	 * Hooray, we are in Long 64-bit mode (but still running in low memory)
 	 */
 SYM_FUNC_START(wakeup_long64)
+	ANNOTATE_NOENDBR
 	movq	saved_magic(%rip), %rax
 	movq	$0x123456789abcdef0, %rdx
 	cmpq	%rdx, %rax
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -146,12 +146,14 @@ SYM_FUNC_END(ftrace_stub_graph)
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
+	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(__fentry__)
 EXPORT_SYMBOL(__fentry__)
 
 SYM_FUNC_START(ftrace_caller)
+	ANNOTATE_NOENDBR
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
@@ -197,6 +199,7 @@ SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
 SYM_FUNC_START(ftrace_regs_caller)
+	ANNOTATE_NOENDBR
 	/* Save the current flags before any operations that can change them */
 	pushfq
 
@@ -310,6 +313,7 @@ SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
 SYM_FUNC_START(ftrace_stub_direct_tramp)
+	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
 	RET
 SYM_FUNC_END(ftrace_stub_direct_tramp)
@@ -317,6 +321,7 @@ SYM_FUNC_END(ftrace_stub_direct_tramp)
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 SYM_FUNC_START(__fentry__)
+	ANNOTATE_NOENDBR
 	CALL_DEPTH_ACCOUNT
 
 	cmpq $ftrace_stub, ftrace_trace_function
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -9,6 +9,7 @@
  */
 .pushsection .noinstr.text, "ax"
 SYM_FUNC_START(native_save_fl)
+	ENDBR
 	pushf
 	pop %_ASM_AX
 	RET
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -106,6 +106,16 @@ static noinstr void pv_native_write_cr2(
 	native_write_cr2(val);
 }
 
+static noinstr unsigned long pv_native_read_cr3(void)
+{
+	return __native_read_cr3();
+}
+
+static noinstr void pv_native_write_cr3(unsigned long cr3)
+{
+	native_write_cr3(cr3);
+}
+
 static noinstr unsigned long pv_native_get_debugreg(int regno)
 {
 	return native_get_debugreg(regno);
@@ -199,8 +209,8 @@ struct paravirt_patch_template pv_ops =
 #ifdef CONFIG_PARAVIRT_XXL
 	.mmu.read_cr2		= __PV_IS_CALLEE_SAVE(pv_native_read_cr2),
 	.mmu.write_cr2		= pv_native_write_cr2,
-	.mmu.read_cr3		= __native_read_cr3,
-	.mmu.write_cr3		= native_write_cr3,
+	.mmu.read_cr3		= pv_native_read_cr3,
+	.mmu.write_cr3		= pv_native_write_cr3,
 
 	.mmu.pgd_alloc		= __paravirt_pgd_alloc,
 	.mmu.pgd_free		= paravirt_nop,
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -326,6 +326,7 @@ SYM_FUNC_END(retbleed_untrain_ret)
 #if defined(CONFIG_MITIGATION_UNRET_ENTRY) || defined(CONFIG_MITIGATION_SRSO)
 
 SYM_FUNC_START(entry_untrain_ret)
+	ANNOTATE_NOENDBR
 	ALTERNATIVE JMP_RETBLEED_UNTRAIN_RET, JMP_SRSO_UNTRAIN_RET, X86_FEATURE_SRSO
 SYM_FUNC_END(entry_untrain_ret)
 __EXPORT_THUNK(entry_untrain_ret)
--- a/arch/x86/mm/mem_encrypt_boot.S
+++ b/arch/x86/mm/mem_encrypt_boot.S
@@ -72,6 +72,7 @@ SYM_FUNC_START(sme_encrypt_execute)
 SYM_FUNC_END(sme_encrypt_execute)
 
 SYM_FUNC_START(__enc_copy)
+	ANNOTATE_NOENDBR
 /*
  * Routine used to encrypt memory in place.
  *   This routine must be run outside of the kernel proper since
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -26,6 +26,7 @@
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
 SYM_FUNC_START(restore_registers)
+	ANNOTATE_NOENDBR
 	/* go back to the original page tables */
 	movq    %r9, %cr3
 
@@ -119,6 +120,7 @@ SYM_FUNC_END(restore_image)
 
 	/* code below has been relocated to a safe page */
 SYM_FUNC_START(core_restore_code)
+	ANNOTATE_NOENDBR
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -28,6 +28,7 @@
  * non-zero.
  */
 SYM_FUNC_START(xen_irq_disable_direct)
+	ENDBR
 	movb $1, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	RET
 SYM_FUNC_END(xen_irq_disable_direct)
@@ -67,6 +68,7 @@ SYM_FUNC_END(check_events)
  * then enter the hypervisor to get them handled.
  */
 SYM_FUNC_START(xen_irq_enable_direct)
+	ENDBR
 	FRAME_BEGIN
 	/* Unmask events */
 	movb $0, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
@@ -97,6 +99,7 @@ SYM_FUNC_END(xen_irq_enable_direct)
  * x86 use opposite senses (mask vs enable).
  */
 SYM_FUNC_START(xen_save_fl_direct)
+	ENDBR
 	testb $0xff, PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_mask)
 	setz %ah
 	addb %ah, %ah
@@ -104,6 +107,7 @@ SYM_FUNC_START(xen_save_fl_direct)
 SYM_FUNC_END(xen_save_fl_direct)
 
 SYM_FUNC_START(xen_read_cr2)
+	ENDBR
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
 	_ASM_MOV XEN_vcpu_info_arch_cr2(%_ASM_AX), %_ASM_AX
@@ -112,6 +116,7 @@ SYM_FUNC_START(xen_read_cr2)
 SYM_FUNC_END(xen_read_cr2);
 
 SYM_FUNC_START(xen_read_cr2_direct)
+	ENDBR
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu_info + XEN_vcpu_info_arch_cr2), %_ASM_AX
 	FRAME_END



