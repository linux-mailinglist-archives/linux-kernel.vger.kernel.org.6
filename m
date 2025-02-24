Return-Path: <linux-kernel+bounces-529081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C1AA41FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F833BC1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2721323BD0C;
	Mon, 24 Feb 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWXkAWk7"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E035D1519A1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401163; cv=none; b=siyYj1wEDJ19GYiJc0XPzEB9+7YHVBnne76KZHLKZXaudSjKiJS8swKo5+b+wt5W8vLOxy4/tWUpficDrsWboM0H3k0EqnPeSk7kardQzSMN0y7Nr5WHPp6k6rfc2kDPPsjIwCg96ojsdPRuCjJHlYyzqYgIjfo/iCpDKmk5q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401163; c=relaxed/simple;
	bh=dmnvdlhWgDbi0hbRIMm67vsauH0yLfpdhG3wN4mRELw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W+EErwjL3tC8yz0HVfRsYooAa8rLaC2+TZdQxdcDeYkYWTb8MwmeqpXHq7iceg2ee4q/Bb9+Urts/W5Yg4c5mAlItKCf0Zc7ht+G4xjrPrp1bzM4tDS+6JlK/up4YcJiiFrcyq6HmRZ+ttx83gEAeNAzOSiDCSB02wFx7IFRpU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gWXkAWk7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=+q7hDJj0ov0CGa+ulzmF01G7YVJQ+Z0Z7dP4W5sCcZQ=; b=gWXkAWk7YWuYOxPSyxU2L0q6up
	DP9/Sk0zc/kP4mvTMJjl4YNtfpQ+jj2B/bpshFsisvebih2BPH/eIcQpLcAyGihb7VlzMMvQ2nA7L
	WP7bg4OGyCy8rPHatDEvN6eoYPgZijGIw0TB1jS+LqMHZ1NQK6OOBksyp13gn9IyWgpjKpLEN+CiY
	imRnIROmFPyl7xLYPNiJgzI1dr83GZ8AIXLja39czqeHhYz+NMivdiOCCC5Liy1wGpXp4/CRLU/v7
	YEMelmmPIt0PFTrzBt2QQ8XQUourScSQPHB5rRjN2KbVWrTMxrqLcHQELqtTTWH+fZsaYL+67H1ZX
	TvXQ9ePQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXqN-00000003C2c-1pnH;
	Mon, 24 Feb 2025 12:45:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 327AA307FAE; Mon, 24 Feb 2025 13:45:54 +0100 (CET)
Message-ID: <20250224124200.820402212@infradead.org>
User-Agent: quilt/0.66
Date: Mon, 24 Feb 2025 13:37:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com,
 mhiramat@kernel.org,
 jmill@asu.edu
Subject: [PATCH v4 09/10] x86/ibt: Implement FineIBT-BHI mitigation
References: <20250224123703.843199044@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

While WAIT_FOR_ENDBR is specified to be a full speculation stop; it
has been shown that some implementations are 'leaky' to such an extend
that speculation can escape even the FineIBT preamble.

To deal with this, add additional hardening to the FineIBT preamble.

Notably, using a new LLVM feature:

  https://github.com/llvm/llvm-project/commit/e223485c9b38a5579991b8cebb6a200153eee245

which encodes the number of arguments in the kCFI preamble's register.

Using this register<->arity mapping, have the FineIBT preamble CALL
into a stub clobbering the relevant argument registers in the
speculative case.

(This is where Scott goes and gives more details...)

Suggested-by: Scott Constable <scott.d.constable@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
---
 Makefile                      |    3 +
 arch/x86/Kconfig              |    8 +++
 arch/x86/include/asm/cfi.h    |    6 ++
 arch/x86/kernel/alternative.c |  107 ++++++++++++++++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c   |   29 +++++++----
 5 files changed, 134 insertions(+), 19 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -1014,6 +1014,9 @@ CC_FLAGS_CFI	:= -fsanitize=kcfi
 ifdef CONFIG_CFI_ICALL_NORMALIZE_INTEGERS
 	CC_FLAGS_CFI	+= -fsanitize-cfi-icall-experimental-normalize-integers
 endif
+ifdef CONFIG_FINEIBT_BHI
+	CC_FLAGS_CFI	+= -fsanitize-kcfi-arity
+endif
 ifdef CONFIG_RUST
 	# Always pass -Zsanitizer-cfi-normalize-integers as CONFIG_RUST selects
 	# CONFIG_CFI_ICALL_NORMALIZE_INTEGERS.
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2473,6 +2473,10 @@ config CC_HAS_RETURN_THUNK
 config CC_HAS_ENTRY_PADDING
 	def_bool $(cc-option,-fpatchable-function-entry=16,16)
 
+config CC_HAS_KCFI_ARITY
+	def_bool $(cc-option,-fsanitize=kcfi -fsanitize-kcfi-arity)
+	depends on CC_IS_CLANG && !RUST
+
 config FUNCTION_PADDING_CFI
 	int
 	default 59 if FUNCTION_ALIGNMENT_64B
@@ -2498,6 +2502,10 @@ config FINEIBT
 	depends on X86_KERNEL_IBT && CFI_CLANG && MITIGATION_RETPOLINE
 	select CALL_PADDING
 
+config FINEIBT_BHI
+	def_bool y
+	depends on FINEIBT && CC_HAS_KCFI_ARITY
+
 config HAVE_CALL_THUNKS
 	def_bool y
 	depends on CC_HAS_ENTRY_PADDING && MITIGATION_RETHUNK && OBJTOOL
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -100,6 +100,7 @@ enum cfi_mode {
 };
 
 extern enum cfi_mode cfi_mode;
+extern bool cfi_bhi;
 
 typedef u8 bhi_thunk[32];
 extern bhi_thunk __bhi_args[];
@@ -129,6 +130,7 @@ static inline int cfi_get_offset(void)
 #define cfi_get_offset cfi_get_offset
 
 extern u32 cfi_get_func_hash(void *func);
+extern int cfi_get_func_arity(void *func);
 
 #ifdef CONFIG_FINEIBT
 extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
@@ -152,6 +154,10 @@ static inline u32 cfi_get_func_hash(void
 {
 	return 0;
 }
+static inline int cfi_get_func_arity(void *func)
+{
+	return 0;
+}
 #endif /* CONFIG_CFI_CLANG */
 
 #if HAS_KERNEL_IBT == 1
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -932,6 +932,7 @@ void __init_or_module apply_seal_endbr(s
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+bool cfi_bhi __ro_after_init = false;
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;
@@ -992,6 +993,21 @@ u32 cfi_get_func_hash(void *func)
 
 	return hash;
 }
+
+int cfi_get_func_arity(void *func)
+{
+	bhi_thunk *target;
+	s32 disp;
+
+	if (cfi_mode != CFI_FINEIBT && !cfi_bhi)
+		return 0;
+
+	if (get_kernel_nofault(disp, func - 4))
+		return 0;
+
+	target = func + disp;
+	return target - __bhi_args;
+}
 #endif
 
 #ifdef CONFIG_FINEIBT
@@ -1049,6 +1065,12 @@ static __init int cfi_parse_cmdline(char
 			} else {
 				pr_err("Ignoring paranoid; depends on fineibt.\n");
 			}
+		} else if (!strcmp(str, "bhi")) {
+			if (cfi_mode == CFI_FINEIBT) {
+				cfi_bhi = true;
+			} else {
+				pr_err("Ignoring bhi; depends on fineibt.\n");
+			}
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -1101,6 +1123,7 @@ asm(	".pushsection .rodata				\n"
 	"fineibt_preamble_start:			\n"
 	"	endbr64					\n"
 	"	subl	$0x12345678, %r10d		\n"
+	"fineibt_preamble_bhi:				\n"
 	"	jne	fineibt_preamble_start+6	\n"
 	ASM_NOP3
 	"fineibt_preamble_end:				\n"
@@ -1108,9 +1131,11 @@ asm(	".pushsection .rodata				\n"
 );
 
 extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_bhi[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_bhi  (fineibt_preamble_bhi - fineibt_preamble_start)
 #define fineibt_preamble_ud   6
 #define fineibt_preamble_hash 7
 
@@ -1183,13 +1208,16 @@ extern u8 fineibt_paranoid_end[];
 #define fineibt_paranoid_ind  (fineibt_paranoid_ind - fineibt_paranoid_start)
 #define fineibt_paranoid_ud   0xd
 
-static u32 decode_preamble_hash(void *addr)
+static u32 decode_preamble_hash(void *addr, int *reg)
 {
 	u8 *p = addr;
 
-	/* b8 78 56 34 12          mov    $0x12345678,%eax */
-	if (p[0] == 0xb8)
+	/* b8+reg 78 56 34 12          movl    $0x12345678,\reg */
+	if (p[0] >= 0xb8 && p[0] < 0xc0) {
+		if (reg)
+			*reg = p[0] - 0xb8;
 		return *(u32 *)(addr + 1);
+	}
 
 	return 0; /* invalid hash value */
 }
@@ -1198,11 +1226,11 @@ static u32 decode_caller_hash(void *addr
 {
 	u8 *p = addr;
 
-	/* 41 ba 78 56 34 12       mov    $0x12345678,%r10d */
+	/* 41 ba 88 a9 cb ed       mov    $(-0x12345678),%r10d */
 	if (p[0] == 0x41 && p[1] == 0xba)
 		return -*(u32 *)(addr + 2);
 
-	/* e8 0c 78 56 34 12	   jmp.d8  +12 */
+	/* e8 0c 88 a9 cb ed	   jmp.d8  +12 */
 	if (p[0] == JMP8_INSN_OPCODE && p[1] == fineibt_caller_jmp)
 		return -*(u32 *)(addr + 2);
 
@@ -1267,7 +1295,7 @@ static int cfi_rand_preamble(s32 *start,
 		void *addr = (void *)s + *s;
 		u32 hash;
 
-		hash = decode_preamble_hash(addr);
+		hash = decode_preamble_hash(addr, NULL);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
 			return -EINVAL;
@@ -1285,6 +1313,7 @@ static int cfi_rewrite_preamble(s32 *sta
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		int arity;
 		u32 hash;
 
 		/*
@@ -1295,7 +1324,7 @@ static int cfi_rewrite_preamble(s32 *sta
 		if (!is_endbr(addr + 16))
 			continue;
 
-		hash = decode_preamble_hash(addr);
+		hash = decode_preamble_hash(addr, &arity);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
 			return -EINVAL;
@@ -1303,6 +1332,19 @@ static int cfi_rewrite_preamble(s32 *sta
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
+
+		WARN_ONCE(!IS_ENABLED(CONFIG_FINEIBT_BHI) && arity,
+			  "kCFI preamble has wrong register at: %pS %*ph\n",
+			  addr, 5, addr);
+
+		if (!cfi_bhi || !arity)
+			continue;
+
+		text_poke_early(addr + fineibt_preamble_bhi,
+				text_gen_insn(CALL_INSN_OPCODE,
+					      addr + fineibt_preamble_bhi,
+					      __bhi_args[arity]),
+				CALL_INSN_SIZE);
 	}
 
 	return 0;
@@ -1470,8 +1512,9 @@ static void __apply_fineibt(s32 *start_r
 		cfi_rewrite_endbr(start_cfi, end_cfi);
 
 		if (builtin) {
-			pr_info("Using %sFineIBT CFI\n",
-				cfi_paranoid ? "paranoid " : "");
+			pr_info("Using %sFineIBT%s CFI\n",
+				cfi_paranoid ? "paranoid " : "",
+				cfi_bhi ? "+BHI" : "");
 		}
 		return;
 
@@ -1522,7 +1565,7 @@ static void poison_cfi(void *addr)
 		/*
 		 * kCFI prefix should start with a valid hash.
 		 */
-		if (!decode_preamble_hash(addr))
+		if (!decode_preamble_hash(addr, NULL))
 			break;
 
 		/*
@@ -1571,6 +1614,47 @@ static bool decode_fineibt_preamble(stru
 }
 
 /*
+ * regs->ip points to one of the UD2 in __bhi_args[].
+ */
+static bool decode_fineibt_bhi(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	unsigned long addr;
+	u32 hash;
+
+	if (!cfi_bhi)
+		return false;
+
+	if (regs->ip < (unsigned long)__bhi_args ||
+	    regs->ip >= (unsigned long)__bhi_args_end)
+		return false;
+
+	/*
+	 * Fetch the return address from the stack, this points to the
+	 * FineIBT preamble. Since the CALL instruction is in the 5 last
+	 * bytes of the preamble, the return address is in fact the target
+	 * address.
+	 */
+	__get_kernel_nofault(&addr, regs->sp, unsigned long, Efault);
+	*target = addr;
+
+	addr -= fineibt_preamble_size;
+	if (!exact_endbr((void *)addr))
+		return false;
+
+	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
+	*type = (u32)regs->r10 + hash;
+
+	/*
+	 * The UD2 sites are constructed with a RET immediately following,
+	 * as such the non-fatal case can use the regular fixup.
+	 */
+	return true;
+
+Efault:
+	return false;
+}
+
+/*
  * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_start[]
  * sequence.
  */
@@ -1601,6 +1685,9 @@ bool decode_fineibt_insn(struct pt_regs
 	if (decode_fineibt_paranoid(regs, target, type))
 		return true;
 
+	if (decode_fineibt_bhi(regs, target, type))
+		return true;
+
 	return decode_fineibt_preamble(regs, target, type);
 }
 
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -410,15 +410,20 @@ static void emit_nops(u8 **pprog, int le
  * Emit the various CFI preambles, see asm/cfi.h and the comments about FineIBT
  * in arch/x86/kernel/alternative.c
  */
+static int emit_call(u8 **prog, void *func, void *ip);
 
-static void emit_fineibt(u8 **pprog, u32 hash)
+static void emit_fineibt(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
 	u8 *prog = *pprog;
 
 	EMIT_ENDBR();
 	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
-	EMIT2(0x75, 0xf9);				/* jne.d8 .-7		*/
-	EMIT3(0x0f, 0x1f, 0x00);			/* nop3			*/
+	if (cfi_bhi) {
+		emit_call(&prog, __bhi_args[arity], ip + 11);
+	} else {
+		EMIT2(0x75, 0xf9);			/* jne.d8 .-7		*/
+		EMIT3(0x0f, 0x1f, 0x00);		/* nop3			*/
+	}
 	EMIT_ENDBR_POISON();
 
 	*pprog = prog;
@@ -447,13 +452,13 @@ static void emit_kcfi(u8 **pprog, u32 ha
 	*pprog = prog;
 }
 
-static void emit_cfi(u8 **pprog, u32 hash)
+static void emit_cfi(u8 **pprog, u8 *ip, u32 hash, int arity)
 {
 	u8 *prog = *pprog;
 
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
-		emit_fineibt(&prog, hash);
+		emit_fineibt(&prog, ip, hash, arity);
 		break;
 
 	case CFI_KCFI:
@@ -504,13 +509,17 @@ static void emit_prologue_tail_call(u8 *
  * bpf_tail_call helper will skip the first X86_TAIL_CALL_OFFSET bytes
  * while jumping to another program
  */
-static void emit_prologue(u8 **pprog, u32 stack_depth, bool ebpf_from_cbpf,
+static void emit_prologue(u8 **pprog, u8 *ip, u32 stack_depth, bool ebpf_from_cbpf,
 			  bool tail_call_reachable, bool is_subprog,
 			  bool is_exception_cb)
 {
 	u8 *prog = *pprog;
 
-	emit_cfi(&prog, is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash);
+	if (is_subprog) {
+		emit_cfi(&prog, ip, cfi_bpf_subprog_hash, 5);
+	} else {
+		emit_cfi(&prog, ip, cfi_bpf_hash, 1);
+	}
 	/* BPF trampoline can be made to work without these nops,
 	 * but let's waste 5 bytes for now and optimize later
 	 */
@@ -1479,7 +1488,7 @@ static int do_jit(struct bpf_prog *bpf_p
 
 	detect_reg_usage(insn, insn_cnt, callee_regs_used);
 
-	emit_prologue(&prog, stack_depth,
+	emit_prologue(&prog, image, stack_depth,
 		      bpf_prog_was_classic(bpf_prog), tail_call_reachable,
 		      bpf_is_subprog(bpf_prog), bpf_prog->aux->exception_cb);
 	/* Exception callback will clobber callee regs for its own use, and
@@ -3046,7 +3055,9 @@ static int __arch_prepare_bpf_trampoline
 		/*
 		 * Indirect call for bpf_struct_ops
 		 */
-		emit_cfi(&prog, cfi_get_func_hash(func_addr));
+		emit_cfi(&prog, image,
+			 cfi_get_func_hash(func_addr),
+			 cfi_get_func_arity(func_addr));
 	} else {
 		/*
 		 * Direct-call fentry stub, as such it needs accounting for the



