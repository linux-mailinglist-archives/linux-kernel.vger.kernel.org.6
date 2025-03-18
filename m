Return-Path: <linux-kernel+bounces-566874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17CA67DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5744189C504
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBBD20E034;
	Tue, 18 Mar 2025 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxIfL1dT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00B1F3BBF
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328707; cv=none; b=gZpKpHdNpBOrvJKJwU9a0t+CogGCblx/2yTjrMsyS5jD5VtL2ejg3cdCI8DurWHUaRSs1y/KVZJGeDaC68ruCELGq+YeKghjGKHIe6ujimU9/vwD7Fgxe1y/cQOpk9PhAAWugjLD83DMUkqnVcX89SMyQAJ1/hUTK9lST9ESHbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328707; c=relaxed/simple;
	bh=xAwV9Y6Vgq0sIjEIOAlHPBwq8tUxFrolp8bIwfCWP20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwYheotGB4vyKtn9pv0mt1PPCxHJ+Pkay23ce6GG90GyOjU+jHCy9jvF3XaBmsKt7KldaQc67rw4v/M5OEFHsx602AL29ogiHMMmyzaalIVpfeGI7UgI8eCFUoenyCNY0IVQ1O/c0XNKIQZd2lHqtxg31Jj8pnbf2t+K7XV9uNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxIfL1dT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6688EC4CEEE;
	Tue, 18 Mar 2025 20:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328706;
	bh=xAwV9Y6Vgq0sIjEIOAlHPBwq8tUxFrolp8bIwfCWP20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxIfL1dTzVPI1c286U6F4KlGCP9M9Qx2vtBgNerAIgQAXn9lyC8iPuLzuwrIQQgRT
	 LCl0KPw2q77MfUKfqUfOQP2+EwzPrMW0FzjSapYPG1xw1Fthhw9A3pkYcYhIl3yGOR
	 LwVrzuWK9DTPTHkLH34uuzoWoq5EsXBBIiKGQ/n+z+cXa4EbYwkSEMR1rT/zmFsrna
	 v0JMZfSn2w45DrVMWBb68tqiw+NiqZyH1D+85iAjekgvQ1e35UZZsfssKclM9KmzPW
	 Mv5XgQY3jOYYKt1iIvJn1OwQwBufLDNcbfPrY9UWLk56uZK5fS+tkU4uvtAqWPNHhN
	 /J+rkzPZjg2VQ==
Date: Tue, 18 Mar 2025 21:11:40 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by
 default
Message-ID: <Z9nTfFiPv0-Lxm-_@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
 <Z9m1rtmlk1PxGIQA@gmail.com>
 <CAHk-=whAUHyXM29_9w_T26=15D1KZnuR3R+f4MT9f-C89oukvA@mail.gmail.com>
 <Z9m_kUqxqMPfU8Fl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9m_kUqxqMPfU8Fl@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> > And then *if* there are any places that want to out-line the asm 
> > (why would you do that? At that point you'd be better off just 
> > writing assembler!), they could use an explicit __asm__ instead 
> > with a comment.
> > 
> > Sadly, I think doing just a mindless
> > 
> >     #define asm(...) __asm__ __inline__(__VA_ARGS__)
> > 
> > doesn't work, because we also have
> > 
> >         register void *tos asm("r11");
> > 
> > kind of patterns.

Plus we also have a lot of plain asm() statements in .c files in file 
scope that GCC doesn't accept with an __inline keyword:

    CC      kernel/configs.o
  kernel/configs.c:23:5: error: expected ‘(’ before ‘__inline’
     23 | asm __inline (
        |     ^~~~~~~~
        |     (
  make[3]: *** [scripts/Makefile.build:207: kernel/configs.o] Error 1

Because allowing that would have been way too simple. :-/

And a lot of helper macros that are used in such a scope are affected 
as well.

> > So first we'd have to change those to use __asm__(), and *then* we
> > could do the "asm() is always __asm__ __inline__()" thing.
> 
> Yeah, I'll try this out. Should this be done for all architectures, 
> or just for x86 for the time being?
> 
> I'm not sure an arch opt-in is worth it, it will only end up in the 
> active architectures picking it, but none of the others, and we'll 
> live with the duality forever.

So the attached patch builds on x86-[64|32]{defconfig|allmodconfig}
and boots on x86-64 defconfig.

The central part is:

 /* Make regular asm() templates inline too, on compilers that support it: */
 
 #ifdef CONFIG_CC_HAS_ASM_INLINE
 # define asm_inline __asm__ __inline
 # define asm(...) asm_inline(__VA_ARGS__)
 #else
 # define asm_inline asm
 #endif

And I fixed up the places where this isn't syntactically correct:

 35 files changed, 82 insertions(+), 79 deletions(-)

I haven't looked at code generation much yet, but text size changes are 
minimal:

      text	   data	    bss	     dec	    hex	filename
  29429076	7931870	1401196	38762142	24f769e	vmlinux.before
  29429631	7931870	1401200	38762701	24f78cd	vmlinux.after

Which is promising, assuming I haven't messed up anywhere.

Tested on GCC 14.2.0.

... and obviously this will break the build on all other architectures 
that have CONFIG_CC_HAS_ASM_INLINE, given that two dozen files had to 
be fixed on x86 alone.

Thanks,

	Ingo

===============>
From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 18 Mar 2025 20:32:13 +0100
Subject: [PATCH] compiler/gcc: Make asm() templates asm __inline__() by default

Not-Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/coco/sev/shared.c                  | 10 +++++-----
 arch/x86/crypto/curve25519-x86_64.c         |  2 +-
 arch/x86/include/asm/alternative.h          |  2 +-
 arch/x86/include/asm/asm.h                  |  2 +-
 arch/x86/include/asm/cfi.h                  |  2 +-
 arch/x86/include/asm/irq_stack.h            |  2 +-
 arch/x86/include/asm/linkage.h              |  2 +-
 arch/x86/include/asm/paravirt.h             |  2 +-
 arch/x86/include/asm/static_call.h          |  4 ++--
 arch/x86/include/asm/uaccess.h              |  4 ++--
 arch/x86/include/asm/xen/hypercall.h        | 12 ++++++------
 arch/x86/kernel/alternative.c               |  6 +++---
 arch/x86/kernel/callthunks.c                |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c   |  6 +++---
 arch/x86/kernel/kprobes/opt.c               |  2 +-
 arch/x86/kernel/rethook.c                   |  2 +-
 arch/x86/kernel/static_call.c               |  2 +-
 arch/x86/kernel/uprobes.c                   |  2 +-
 arch/x86/kvm/emulate.c                      |  4 ++--
 arch/x86/lib/error-inject.c                 |  2 +-
 include/linux/compiler_types.h              |  7 +++++--
 include/linux/export-internal.h             |  4 ++--
 include/linux/export.h                      |  2 +-
 include/linux/init.h                        |  2 +-
 include/linux/linkage.h                     |  4 ++--
 include/linux/pci.h                         |  2 +-
 include/linux/tracepoint.h                  |  2 +-
 include/vdso/math64.h                       |  2 +-
 kernel/configs.c                            |  2 +-
 kernel/kheaders.c                           |  2 +-
 samples/ftrace/ftrace-direct-modify.c       | 12 ++++++------
 samples/ftrace/ftrace-direct-multi-modify.c | 12 ++++++------
 samples/ftrace/ftrace-direct-multi.c        | 12 ++++++------
 samples/ftrace/ftrace-direct-too.c          | 12 ++++++------
 samples/ftrace/ftrace-direct.c              | 12 ++++++------
 35 files changed, 82 insertions(+), 79 deletions(-)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 2e4122f8aa6b..ac8b898e1d26 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -281,11 +281,11 @@ static inline int svsm_process_result_codes(struct svsm_call *call)
  */
 static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)
 {
-	register unsigned long rax asm("rax") = call->rax;
-	register unsigned long rcx asm("rcx") = call->rcx;
-	register unsigned long rdx asm("rdx") = call->rdx;
-	register unsigned long r8  asm("r8")  = call->r8;
-	register unsigned long r9  asm("r9")  = call->r9;
+	register unsigned long rax __asm__("rax") = call->rax;
+	register unsigned long rcx __asm__("rcx") = call->rcx;
+	register unsigned long rdx __asm__("rdx") = call->rdx;
+	register unsigned long r8  __asm__("r8")  = call->r8;
+	register unsigned long r9  __asm__("r9")  = call->r9;
 
 	call->caa->call_pending = 1;
 
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index dcfc0de333de..7d664bc8b2fd 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -542,7 +542,7 @@ static inline void fmul2(u64 *out, const u64 *f1, const u64 *f2, u64 *tmp)
  * Requires f2 to be smaller than 2^17 */
 static inline void fmul_scalar(u64 *out, const u64 *f1, u64 f2)
 {
-	register u64 f2_r asm("rdx") = f2;
+	register u64 f2_r __asm__("rdx") = f2;
 
 	asm volatile(
 		/* Compute the raw multiplication of f1*f2 */
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index e3903b731305..ab6c80eaf7f5 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -272,7 +272,7 @@ static inline int alternatives_text_reserved(void *start, void *end)
 
 /* Macro for creating assembler functions avoiding any C magic. */
 #define DEFINE_ASM_FUNC(func, instr, sec)		\
-	asm (".pushsection " #sec ", \"ax\"\n"		\
+	__asm__ (".pushsection " #sec ", \"ax\"\n"	\
 	     ".global " #func "\n\t"			\
 	     ".type " #func ", @function\n\t"		\
 	     ASM_FUNC_ALIGN "\n"			\
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 2bec0c89a95c..5b88c875d512 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -219,7 +219,7 @@ static __always_inline __pure void *rip_rel_ptr(void *p)
  * gets set up by the containing function.  If you forget to do this, objtool
  * may print a "call without frame pointer save/setup" warning.
  */
-register unsigned long current_stack_pointer asm(_ASM_SP);
+register unsigned long current_stack_pointer __asm__(_ASM_SP);
 #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 31d19c815f99..5fd236a9ac25 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -140,7 +140,7 @@ static inline u32 cfi_get_func_hash(void *func)
 #endif /* CONFIG_CFI_CLANG */
 
 #if HAS_KERNEL_IBT == 1
-#define CFI_NOSEAL(x)	asm(IBT_NOSEAL(__stringify(x)))
+#define CFI_NOSEAL(x)	__asm__(IBT_NOSEAL(__stringify(x)))
 #endif
 
 #endif /* _ASM_X86_CFI_H */
diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index 562a547c29a5..478291297ff2 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -80,7 +80,7 @@
  */
 #define call_on_stack(stack, func, asm_call, argconstr...)		\
 {									\
-	register void *tos asm("r11");					\
+	register void *tos __asm__("r11");				\
 									\
 	tos = ((void *)(stack));					\
 									\
diff --git a/arch/x86/include/asm/linkage.h b/arch/x86/include/asm/linkage.h
index dc31b13b87a0..8753b9f2e473 100644
--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -13,7 +13,7 @@
  * The generic version tends to create spurious ENDBR instructions under
  * certain conditions.
  */
-#define _THIS_IP_ ({ unsigned long __here; asm ("lea 0(%%rip), %0" : "=r" (__here)); __here; })
+#define _THIS_IP_ ({ unsigned long __here; __asm__ ("lea 0(%%rip), %0" : "=r" (__here)); __here; })
 #endif
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..7090d1478982 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -648,7 +648,7 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
-	asm(".pushsection " section ", \"ax\";"				\
+	__asm__(".pushsection " section ", \"ax\";"			\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    ASM_FUNC_ALIGN						\
diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 41502bd2afd6..23e6dca3dc63 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -32,7 +32,7 @@
  * and __static_call_fixup().
  */
 #define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, insns)			\
-	asm(".pushsection .static_call.text, \"ax\"		\n"	\
+	__asm__(".pushsection .static_call.text, \"ax\"		\n"	\
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
@@ -58,7 +58,7 @@
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
 
 #define ARCH_ADD_TRAMP_KEY(name)					\
-	asm(".pushsection .static_call_tramp_key, \"a\"		\n"	\
+	__asm__(".pushsection .static_call_tramp_key, \"a\"	\n"	\
 	    ".long " STATIC_CALL_TRAMP_STR(name) " - .		\n"	\
 	    ".long " STATIC_CALL_KEY_STR(name) " - .		\n"	\
 	    ".popsection					\n")
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a7755c1a441..32715343ebb1 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -76,7 +76,7 @@ extern int __get_user_bad(void);
 #define do_get_user_call(fn,x,ptr)					\
 ({									\
 	int __ret_gu;							\
-	register __inttype(*(ptr)) __val_gu asm("%"_ASM_DX);		\
+	register __inttype(*(ptr)) __val_gu __asm__("%"_ASM_DX);	\
 	__chk_user_ptr(ptr);						\
 	asm volatile("call __" #fn "_%c[size]"				\
 		     : "=a" (__ret_gu), "=r" (__val_gu),		\
@@ -171,7 +171,7 @@ extern void __put_user_nocheck_8(void);
 ({									\
 	int __ret_pu;							\
 	void __user *__ptr_pu;						\
-	register __typeof__(*(ptr)) __val_pu asm("%"_ASM_AX);		\
+	register __typeof__(*(ptr)) __val_pu __asm__("%"_ASM_AX);	\
 	__typeof__(*(ptr)) __x = (x); /* eval x once */			\
 	__typeof__(ptr) __ptr = (ptr); /* eval ptr once */		\
 	__chk_user_ptr(__ptr);						\
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9d33af..0ecce35f287f 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -120,12 +120,12 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 #endif
 
 #define __HYPERCALL_DECLS						\
-	register unsigned long __res  asm(__HYPERCALL_RETREG);		\
-	register unsigned long __arg1 asm(__HYPERCALL_ARG1REG) = __arg1; \
-	register unsigned long __arg2 asm(__HYPERCALL_ARG2REG) = __arg2; \
-	register unsigned long __arg3 asm(__HYPERCALL_ARG3REG) = __arg3; \
-	register unsigned long __arg4 asm(__HYPERCALL_ARG4REG) = __arg4; \
-	register unsigned long __arg5 asm(__HYPERCALL_ARG5REG) = __arg5;
+	register unsigned long __res  __asm__(__HYPERCALL_RETREG);		\
+	register unsigned long __arg1 __asm__(__HYPERCALL_ARG1REG) = __arg1; \
+	register unsigned long __arg2 __asm__(__HYPERCALL_ARG2REG) = __arg2; \
+	register unsigned long __arg3 __asm__(__HYPERCALL_ARG3REG) = __arg3; \
+	register unsigned long __arg4 __asm__(__HYPERCALL_ARG4REG) = __arg4; \
+	register unsigned long __arg5 __asm__(__HYPERCALL_ARG5REG) = __arg5;
 
 #define __HYPERCALL_0PARAM	"=r" (__res), ASM_CALL_CONSTRAINT
 #define __HYPERCALL_1PARAM	__HYPERCALL_0PARAM, "+r" (__arg1)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c71b575bf229..cde99c0e2502 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -942,7 +942,7 @@ extern unsigned int __bpf_prog_runX(const void *ctx,
 __ADDRESSABLE(__bpf_prog_runX);
 
 /* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
-asm (
+__asm__ (
 "	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
 "	.type	cfi_bpf_hash,@object				\n"
 "	.globl	cfi_bpf_hash					\n"
@@ -959,7 +959,7 @@ extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
 __ADDRESSABLE(__bpf_callback_fn);
 
 /* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
-asm (
+__asm__ (
 "	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
 "	.type	cfi_bpf_subprog_hash,@object			\n"
 "	.globl	cfi_bpf_subprog_hash				\n"
@@ -1598,7 +1598,7 @@ int alternatives_text_reserved(void *start, void *end)
 
 extern void int3_magic(unsigned int *ptr); /* defined in asm */
 
-asm (
+__asm__ (
 "	.pushsection	.init.text, \"ax\", @progbits\n"
 "	.type		int3_magic, @function\n"
 "int3_magic:\n"
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 8418a892d195..5d865c851b4f 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -64,7 +64,7 @@ static const struct core_text builtin_coretext = {
 	.name = "builtin",
 };
 
-asm (
+__asm__ (
 	".pushsection .rodata				\n"
 	".global skl_call_thunk_template		\n"
 	"skl_call_thunk_template:			\n"
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 42cc162f7fc9..49381dc69837 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -446,9 +446,9 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	unsigned int size;
 	void *mem_r;
 #else
-	register unsigned int line_size asm("esi");
-	register unsigned int size asm("edi");
-	register void *mem_r asm(_ASM_BX);
+	register unsigned int line_size __asm__("esi");
+	register unsigned int size __asm__("edi");
+	register void *mem_r __asm__(_ASM_BX);
 #endif /* CONFIG_KASAN */
 
 	/*
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 36d6809c6c9e..eb394142a3b3 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -101,7 +101,7 @@ static void synthesize_set_arg1(kprobe_opcode_t *addr, unsigned long val)
 	*(unsigned long *)addr = val;
 }
 
-asm (
+__asm__ (
 			".pushsection .rodata\n"
 			"optprobe_template_func:\n"
 			".global optprobe_template_entry\n"
diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c0111ae79..bb3ebb6c7618 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -19,7 +19,7 @@ __visible void arch_rethook_trampoline_callback(struct pt_regs *regs);
  * When a target function returns, this code saves registers and calls
  * arch_rethook_trampoline_callback(), which calls the rethook handler.
  */
-asm(
+__asm__(
 	".text\n"
 	".global arch_rethook_trampoline\n"
 	".type arch_rethook_trampoline, @function\n"
diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index 9e51242ed125..13984965b8a7 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -41,7 +41,7 @@ static u8 __is_Jcc(u8 *insn) /* Jcc.d32 */
 
 extern void __static_call_return(void);
 
-asm (".global __static_call_return\n\t"
+__asm__ (".global __static_call_return\n\t"
      ".type __static_call_return, @function\n\t"
      ASM_FUNC_ALIGN "\n\t"
      "__static_call_return:\n\t"
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 5a952c5ea66b..2a56d8313cbb 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -310,7 +310,7 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 
 #ifdef CONFIG_X86_64
 
-asm (
+__asm__ (
 	".pushsection .rodata\n"
 	".global uretprobe_trampoline_entry\n"
 	"uretprobe_trampoline_entry:\n"
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 60986f67c35a..80800901474d 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -311,7 +311,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 
 #define __FOP_START(op, align) \
 	extern void em_##op(struct fastop *fake); \
-	asm(".pushsection .text, \"ax\" \n\t" \
+	__asm__(".pushsection .text, \"ax\" \n\t" \
 	    ".global em_" #op " \n\t" \
 	    ".align " __stringify(align) " \n\t" \
 	    "em_" #op ":\n\t"
@@ -1069,7 +1069,7 @@ static __always_inline u8 test_cc(unsigned int condition, unsigned long flags)
 	void (*fop)(void) = (void *)em_setcc + FASTOP_SIZE * (condition & 0xf);
 
 	flags = (flags & EFLAGS_MASK) | X86_EFLAGS_IF;
-	asm("push %[flags]; popf; " CALL_NOSPEC
+	__asm__("push %[flags]; popf; " CALL_NOSPEC
 	    : "=a"(rc), ASM_CALL_CONSTRAINT : [thunk_target]"r"(fop), [flags]"r"(flags));
 	return rc;
 }
diff --git a/arch/x86/lib/error-inject.c b/arch/x86/lib/error-inject.c
index b5a6d83106bc..0fd65281078c 100644
--- a/arch/x86/lib/error-inject.c
+++ b/arch/x86/lib/error-inject.c
@@ -7,7 +7,7 @@
 
 asmlinkage void just_return_func(void);
 
-asm(
+__asm__(
 	".text\n"
 	".type just_return_func, @function\n"
 	".globl just_return_func\n"
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 981cc3d7e3aa..4c59faf2c22f 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -473,10 +473,13 @@ struct ftrace_likely_data {
   #define ASM_INPUT_RM "rm"
 #endif
 
+/* Make regular asm() templates inline too, on compilers that support it: */
+
 #ifdef CONFIG_CC_HAS_ASM_INLINE
-#define asm_inline asm __inline
+# define asm_inline __asm__ __inline
+# define asm(...) asm_inline(__VA_ARGS__)
 #else
-#define asm_inline asm
+# define asm_inline asm
 #endif
 
 /* Are two types/vars the same type (ignoring qualifiers)? */
diff --git a/include/linux/export-internal.h b/include/linux/export-internal.h
index d445705ac13c..61dfbc986c9a 100644
--- a/include/linux/export-internal.h
+++ b/include/linux/export-internal.h
@@ -38,7 +38,7 @@
  * former apparently works on all arches according to the binutils source.
  */
 #define __KSYMTAB(name, sym, sec, ns)						\
-	asm("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
+	__asm__("	.section \"__ksymtab_strings\",\"aMS\",%progbits,1"	"\n"	\
 	    "__kstrtab_" #name ":"					"\n"	\
 	    "	.asciz \"" #name "\""					"\n"	\
 	    "__kstrtabns_" #name ":"					"\n"	\
@@ -63,7 +63,7 @@
 #define KSYMTAB_DATA(name, sec, ns)	__KSYMTAB(name, name, sec, ns)
 
 #define SYMBOL_CRC(sym, crc, sec)   \
-	asm(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
+	__asm__(".section \"___kcrctab" sec "+" #sym "\",\"a\""	"\n" \
 	    ".balign 4"						"\n" \
 	    "__crc_" #sym ":"					"\n" \
 	    ".long " #crc					"\n" \
diff --git a/include/linux/export.h b/include/linux/export.h
index a8c23d945634..ca2fc2cc5db8 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -70,7 +70,7 @@
 	extern typeof(sym) sym;					\
 	__ADDRESSABLE(sym)					\
 	__GENDWARFKSYMS_EXPORT(sym)				\
-	asm(__stringify(___EXPORT_SYMBOL(sym, license, ns)))
+	__asm__(__stringify(___EXPORT_SYMBOL(sym, license, ns)))
 
 #endif
 
diff --git a/include/linux/init.h b/include/linux/init.h
index ee1309473bc6..85bc49b7e34d 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -259,7 +259,7 @@ extern struct module __this_module;
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 #define ____define_initcall(fn, __stub, __name, __sec)		\
 	__define_initcall_stub(__stub, fn)			\
-	asm(".section	\"" __sec "\", \"a\"		\n"	\
+	__asm__(".section	\"" __sec "\", \"a\"	\n"	\
 	    __stringify(__name) ":			\n"	\
 	    ".long	" __stringify(__stub) " - .	\n"	\
 	    ".previous					\n");	\
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index 5c8865bb59d9..74bc0c88f8ca 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -23,14 +23,14 @@
 #endif
 
 #ifndef cond_syscall
-#define cond_syscall(x)	asm(				\
+#define cond_syscall(x)	__asm__(			\
 	".weak " __stringify(x) "\n\t"			\
 	".set  " __stringify(x) ","			\
 		 __stringify(sys_ni_syscall))
 #endif
 
 #ifndef SYSCALL_ALIAS
-#define SYSCALL_ALIAS(alias, name) asm(			\
+#define SYSCALL_ALIAS(alias, name) __asm__(		\
 	".globl " __stringify(alias) "\n\t"		\
 	".set   " __stringify(alias) ","		\
 		  __stringify(name))
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..0904d24c9e17 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2206,7 +2206,7 @@ enum pci_fixup_pass {
 #define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
 				    class_shift, hook)			\
 	__ADDRESSABLE(hook)						\
-	asm(".section "	#sec ", \"a\"				\n"	\
+	__asm__(".section "	#sec ", \"a\"			\n"	\
 	    ".balign	16					\n"	\
 	    ".short "	#vendor ", " #device "			\n"	\
 	    ".long "	#class ", " #class_shift "		\n"	\
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index a351763e6965..4f0f7cca7a62 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -149,7 +149,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 }
 
 #define __TRACEPOINT_ENTRY(name)					\
-	asm("	.section \"__tracepoints_ptrs\", \"a\"		\n"	\
+	__asm__("	.section \"__tracepoints_ptrs\", \"a\"	\n"	\
 	    "	.balign 4					\n"	\
 	    "	.long 	__tracepoint_" #name " - .		\n"	\
 	    "	.previous					\n")
diff --git a/include/vdso/math64.h b/include/vdso/math64.h
index 22ae212f8b28..d391d9622414 100644
--- a/include/vdso/math64.h
+++ b/include/vdso/math64.h
@@ -10,7 +10,7 @@ __iter_div_u64_rem(u64 dividend, u32 divisor, u64 *remainder)
 	while (dividend >= divisor) {
 		/* The following asm() prevents the compiler from
 		   optimising this loop into a modulo operation.  */
-		asm("" : "+rm"(dividend));
+		__asm__("" : "+rm"(dividend));
 
 		dividend -= divisor;
 		ret++;
diff --git a/kernel/configs.c b/kernel/configs.c
index a28c79c5f713..076342773995 100644
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -20,7 +20,7 @@
  * "IKCFG_ST" and "IKCFG_ED" are used to extract the config data from
  * a binary kernel image or a module. See scripts/extract-ikconfig.
  */
-asm (
+__asm__ (
 "	.pushsection .rodata, \"a\"		\n"
 "	.ascii \"IKCFG_ST\"			\n"
 "	.global kernel_config_data		\n"
diff --git a/kernel/kheaders.c b/kernel/kheaders.c
index 378088b07f46..1468c46806a3 100644
--- a/kernel/kheaders.c
+++ b/kernel/kheaders.c
@@ -16,7 +16,7 @@
  * compressed kernel headers are stored. The file is first compressed with xz.
  */
 
-asm (
+__asm__ (
 "	.pushsection .rodata, \"a\"		\n"
 "	.global kernel_headers_data		\n"
 "kernel_headers_data:				\n"
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index cfea7a38befb..a59d68845a58 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -27,7 +27,7 @@ static unsigned long my_ip = (unsigned long)schedule;
 #ifdef CONFIG_RISCV
 #include <asm/asm.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -64,7 +64,7 @@ asm (
 #include <asm/ibt.h>
 #include <asm/nospec-branch.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -96,7 +96,7 @@ asm (
 
 #ifdef CONFIG_S390
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -135,7 +135,7 @@ asm (
 
 #ifdef CONFIG_ARM64
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -167,7 +167,7 @@ asm (
 
 #ifdef CONFIG_LOONGARCH
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -239,7 +239,7 @@ asm (
 "	bctr\n"
 #endif
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 8f7986d698d8..0f45e47e5137 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -25,7 +25,7 @@ extern void my_tramp2(void *);
 #ifdef CONFIG_RISCV
 #include <asm/asm.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -68,7 +68,7 @@ asm (
 #include <asm/ibt.h>
 #include <asm/nospec-branch.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -106,7 +106,7 @@ asm (
 
 #ifdef CONFIG_S390
 
-asm (
+__asm__ (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp1, @function\n"
 "       .globl          my_tramp1\n"
@@ -148,7 +148,7 @@ asm (
 
 #ifdef CONFIG_ARM64
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -187,7 +187,7 @@ asm (
 #ifdef CONFIG_LOONGARCH
 #include <asm/asm.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
@@ -273,7 +273,7 @@ asm (
 #define PPC_FTRACE_RECOVER_IP ""
 #endif
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp1, @function\n"
 "	.globl		my_tramp1\n"
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index db326c81a27d..c687682780fa 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -20,7 +20,7 @@ extern void my_tramp(void *);
 #ifdef CONFIG_RISCV
 #include <asm/asm.h>
 
-asm (
+__asm__ (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
@@ -47,7 +47,7 @@ asm (
 #include <asm/ibt.h>
 #include <asm/nospec-branch.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -70,7 +70,7 @@ asm (
 
 #ifdef CONFIG_S390
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -95,7 +95,7 @@ asm (
 
 #ifdef CONFIG_ARM64
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -119,7 +119,7 @@ asm (
 #ifdef CONFIG_LOONGARCH
 
 #include <asm/asm.h>
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -189,7 +189,7 @@ asm (
 #define PPC_FTRACE_RECOVER_IP ""
 #endif
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 3d0fa260332d..63b778b7285b 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -22,7 +22,7 @@ extern void my_tramp(void *);
 #ifdef CONFIG_RISCV
 #include <asm/asm.h>
 
-asm (
+__asm__ (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
@@ -52,7 +52,7 @@ asm (
 #include <asm/ibt.h>
 #include <asm/nospec-branch.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -80,7 +80,7 @@ asm (
 
 #ifdef CONFIG_S390
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -104,7 +104,7 @@ asm (
 
 #ifdef CONFIG_ARM64
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -128,7 +128,7 @@ asm (
 
 #ifdef CONFIG_LOONGARCH
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -201,7 +201,7 @@ asm (
 "	bctr\n"
 #endif
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 956834b0d19a..7ad16e5c4a5b 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -19,7 +19,7 @@ extern void my_tramp(void *);
 #ifdef CONFIG_RISCV
 #include <asm/asm.h>
 
-asm (
+__asm__ (
 "       .pushsection    .text, \"ax\", @progbits\n"
 "       .type           my_tramp, @function\n"
 "       .globl          my_tramp\n"
@@ -45,7 +45,7 @@ asm (
 #include <asm/ibt.h>
 #include <asm/nospec-branch.h>
 
-asm (
+__asm__ (
 "	.pushsection    .text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -67,7 +67,7 @@ asm (
 
 #ifdef CONFIG_S390
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -91,7 +91,7 @@ asm (
 
 #ifdef CONFIG_ARM64
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -113,7 +113,7 @@ asm (
 
 #ifdef CONFIG_LOONGARCH
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"
@@ -174,7 +174,7 @@ asm (
 "	bctr\n"
 #endif
 
-asm (
+__asm__ (
 "	.pushsection	.text, \"ax\", @progbits\n"
 "	.type		my_tramp, @function\n"
 "	.globl		my_tramp\n"

