Return-Path: <linux-kernel+bounces-522042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BDA3C52A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC1D3B20EB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2F31FF1D9;
	Wed, 19 Feb 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hnaZuDrb"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9CE198E81
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983012; cv=none; b=II9Pk9U4MwqyaTX/LdPW8Ps6zV9uM0cCSJjFr4Ea1Lp1x9/Yfsw/Tj73JHtN54xkX6uAPypDTEZmy5B95hRF0yuXz1DWoX6adxfPCosvdC7Ctfc5RX65bjH6o97NFaCyk9PXgfYmRVhB0q+DIaE2lNWdFc+NSADSMLpcOMmduQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983012; c=relaxed/simple;
	bh=T+ErmRUTbrmeEaOqBtf+5hjN0fLX2iTXUYqwBSnsnbE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oben5lGne8HxcSdvpPTrS5RdybEpbR/33FE5znSFA3DLmNE38FtX3VbriNy11KAyIc+ocgvOlPWbEz5Lgep6WQlKTJVePfQqwrp8YzxcrHIW2AVf85/GdrGWl0su7pJeIRiqpkHuAPJYmLvI1S5uQV/++/z4+bg3N+WtziO4Ir8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hnaZuDrb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=NNBJ3WzBo+K7wIvhm3+Ot5P/kY6iwqtzBK2LJIsIOww=; b=hnaZuDrb2Uq8vZvBIxG3I2y8/k
	/zDNHUTkoYf3GBNdn1ZaFnHGTrO5aEU9wk0szEM8u8nXMSde49qr2SPU04NCleUupsgsgLy3l5/Ix
	T60h+BWZMlGU++gSs1Yte8rG8851jwETEKL9O6ynun3KxFoAUZ/wr5KIciuAWBG2iUqjkWmbcSQCw
	PIDxq2jxaEw4RIbee1BOgGVnmWCMlJf8CepeL6DF1CC8gKWJNxVS7J92NTNXQIPbsEOkcAci3DUXX
	iX4HhDMnaduYVcQhOH0f4doXWYdOVyVYHXTmHyomeZkxRZKhWjF0D9bZcGp89Mspa9BL2Fjj0vtf3
	31fuY4Kw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkn41-00000002HAW-0689;
	Wed, 19 Feb 2025 16:36:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 0E14230651E; Wed, 19 Feb 2025 17:36:43 +0100 (CET)
Message-ID: <20250219163515.040300905@infradead.org>
User-Agent: quilt/0.66
Date: Wed, 19 Feb 2025 17:21:14 +0100
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
Subject: [PATCH v3 07/10] x86/ibt: Add paranoid FineIBT mode
References: <20250219162107.880673196@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Due to concerns about circumvention attacks against FineIBT on 'naked'
ENDBR, add an additional caller side hash check to FineIBT. This
should make it impossible to pivot over such a 'naked' ENDBR
instruction at the cost of an additional load.

The specific pivot reported was against the SYSCALL entry site and
FRED will have all those holes fixed up.

This specific fineibt_paranoid_start[] sequence was concocted by
Scott.

Reported-by: Jennifer Miller <jmill@asu.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250215210729.GA25168@noisy.programming.kicks-ass.net
---
 arch/x86/include/asm/cfi.h    |    8 +-
 arch/x86/kernel/alternative.c |  143 ++++++++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cfi.c         |    4 -
 3 files changed, 143 insertions(+), 12 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -105,7 +105,7 @@ extern bool cfi_warn;
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
-enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
+enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs);
 #define __bpfcall
 extern u32 cfi_bpf_hash;
 extern u32 cfi_bpf_subprog_hash;
@@ -128,10 +128,10 @@ static inline int cfi_get_offset(void)
 extern u32 cfi_get_func_hash(void *func);
 
 #ifdef CONFIG_FINEIBT
-extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
+extern bool decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u32 *type);
 #else
 static inline bool
-decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	return false;
 }
@@ -139,7 +139,7 @@ decode_fineibt_insn(struct pt_regs *regs
 #endif
 
 #else
-static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+static inline enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -741,6 +741,11 @@ void __init_or_module noinline apply_ret
 		op2 = insn.opcode.bytes[1];
 
 		switch (op1) {
+		case 0x70 ... 0x7f:	/* Jcc.d8 */
+			/* See cfi_paranoid. */
+			WARN_ON_ONCE(cfi_mode != CFI_FINEIBT);
+			continue;
+
 		case CALL_INSN_OPCODE:
 		case JMP32_INSN_OPCODE:
 			break;
@@ -995,6 +1000,8 @@ u32 cfi_get_func_hash(void *func)
 static bool cfi_rand __ro_after_init = true;
 static u32  cfi_seed __ro_after_init;
 
+static bool cfi_paranoid __ro_after_init = false;
+
 /*
  * Re-hash the CFI hash with a boot-time seed while making sure the result is
  * not a valid ENDBR instruction.
@@ -1037,6 +1044,12 @@ static __init int cfi_parse_cmdline(char
 		} else if (!strcmp(str, "warn")) {
 			pr_alert("CFI mismatch non-fatal!\n");
 			cfi_warn = true;
+		} else if (!strcmp(str, "paranoid")) {
+			if (cfi_mode == CFI_FINEIBT) {
+				cfi_paranoid = true;
+			} else {
+				pr_err("Ignoring paranoid; depends on fineibt.\n");
+			}
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}
@@ -1116,6 +1129,52 @@ extern u8 fineibt_caller_end[];
 
 #define fineibt_caller_jmp (fineibt_caller_size - 2)
 
+/*
+ * Since FineIBT does hash validation on the callee side it is prone to
+ * circumvention attacks where a 'naked' ENDBR instruction exists that
+ * is not part of the fineibt_preamble sequence.
+ *
+ * Notably the x86 entry points must be ENDBR and equally cannot be
+ * fineibt_preamble.
+ *
+ * The fineibt_paranoid caller sequence adds additional caller side
+ * hash validation. This stops such circumvetion attacks dead, but at the cost
+ * of adding a load.
+ *
+ * <fineibt_paranoid_start>:
+ *  0:   41 ba 78 56 34 12       mov    $0x12345678, %r10d
+ *  6:   45 3b 53 f7             cmp    -0x9(%r11), %r10d
+ *  a:   4d 8d 5b <f0>           lea    -0x10(%r11), %r11
+ *  e:   75 fd                   jne    d <fineibt_paranoid_start+0xd>
+ * 10:   41 ff d3                call   *%r11
+ * 13:   90                      nop
+ *
+ * Notably LEA does not modify flags and can be reordered with the CMP,
+ * avoiding a dependency. Again, using a non-taken (backwards) branch
+ * for the failure case, abusing LEA's immediate 0xf0 as LOCK prefix for the
+ * JCC.d8, causing #UD.
+ */
+asm(	".pushsection .rodata				\n"
+	"fineibt_paranoid_start:			\n"
+	"	movl	$0x12345678, %r10d		\n"
+	"	cmpl	-9(%r11), %r10d			\n"
+	"	lea	-0x10(%r11), %r11		\n"
+	"	jne	fineibt_paranoid_start+0xd	\n"
+	"fineibt_paranoid_ind:				\n"
+	"	call	*%r11				\n"
+	"	nop					\n"
+	"fineibt_paranoid_end:				\n"
+	".popsection					\n"
+);
+
+extern u8 fineibt_paranoid_start[];
+extern u8 fineibt_paranoid_ind[];
+extern u8 fineibt_paranoid_end[];
+
+#define fineibt_paranoid_size (fineibt_paranoid_end - fineibt_paranoid_start)
+#define fineibt_paranoid_ind  (fineibt_paranoid_ind - fineibt_paranoid_start)
+#define fineibt_paranoid_ud   0xd
+
 static u32 decode_preamble_hash(void *addr)
 {
 	u8 *p = addr;
@@ -1279,18 +1338,48 @@ static int cfi_rewrite_callers(s32 *star
 {
 	s32 *s;
 
+	BUG_ON(fineibt_paranoid_size != 20);
+
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		struct insn insn;
+		u8 bytes[20];
 		u32 hash;
+		int ret;
+		u8 op;
 
 		addr -= fineibt_caller_size;
 		hash = decode_caller_hash(addr);
-		if (hash) {
+		if (!hash)
+			continue;
+
+		if (!cfi_paranoid) {
 			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
 			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
 			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
+			/* rely on apply_retpolines() */
+			continue;
 		}
-		/* rely on apply_retpolines() */
+
+		/* cfi_paranoid */
+		ret = insn_decode_kernel(&insn, addr + fineibt_caller_size);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		op = insn.opcode.bytes[0];
+		if (op != CALL_INSN_OPCODE && op != JMP32_INSN_OPCODE) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		memcpy(bytes, fineibt_paranoid_start, fineibt_paranoid_size);
+		memcpy(bytes + fineibt_caller_hash, &hash, 4);
+
+		ret = emit_indirect(op, 11, bytes + fineibt_paranoid_ind);
+		if (WARN_ON_ONCE(ret != 3))
+			continue;
+
+		text_poke_early(addr, bytes, fineibt_paranoid_size);
 	}
 
 	return 0;
@@ -1307,8 +1396,15 @@ static void __apply_fineibt(s32 *start_r
 
 	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
-		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT)) {
+			/*
+			 * FRED has much saner context on exception entry and
+			 * is less easy to take advantage of.
+			 */
+			if (!cpu_feature_enabled(X86_FEATURE_FRED))
+				cfi_paranoid = true;
 			cfi_mode = CFI_FINEIBT;
+		}
 	}
 
 	/*
@@ -1365,8 +1461,10 @@ static void __apply_fineibt(s32 *start_r
 		/* now that nobody targets func()+0, remove ENDBR there */
 		cfi_rewrite_endbr(start_cfi, end_cfi);
 
-		if (builtin)
-			pr_info("Using FineIBT CFI\n");
+		if (builtin) {
+			pr_info("Using %sFineIBT CFI\n",
+				cfi_paranoid ? "paranoid " : "");
+		}
 		return;
 
 	default:
@@ -1439,7 +1537,8 @@ static void poison_cfi(void *addr)
  * We check the preamble by checking for the ENDBR instruction relative to the
  * 0xEA instruction.
  */
-bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+static bool decode_fineibt_preamble(int ud_type, struct pt_regs *regs,
+				    unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud;
 	u32 hash;
@@ -1464,6 +1563,38 @@ bool decode_fineibt_insn(struct pt_regs
 	return false;
 }
 
+/*
+ * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_start[]
+ * sequence.
+ */
+static bool decode_fineibt_paranoid(int ud_type, struct pt_regs *regs,
+				    unsigned long *target, u32 *type)
+{
+	unsigned long addr = regs->ip - fineibt_paranoid_ud;
+	u32 hash;
+
+	__get_kernel_nofault(&hash, addr + fineibt_caller_hash, u32, Efault);
+	*target = regs->r11 + fineibt_preamble_size;
+	*type = regs->r10;
+
+	/*
+	 * Since the trapping instruction is the exact, but LOCK prefixed,
+	 * Jcc.d8 that got us here, the normal fixup will work.
+	 */
+	return true;
+
+Efault:
+	return false;
+}
+
+bool decode_fineibt_insn(int ud_type, struct pt_regs *regs,
+			 unsigned long *target, u32 *type)
+{
+	if (ud_type == BUG_LOCK)
+		return decode_fineibt_paranoid(ud_type, regs, target, type);
+	return decode_fineibt_preamble(ud_type, regs, target, type);
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -65,7 +65,7 @@ static bool decode_cfi_insn(struct pt_re
  * Checks if a ud2 trap is because of a CFI failure, and handles the trap
  * if needed. Returns a bug_trap_type value similarly to report_bug.
  */
-enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
+enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
 {
 	unsigned long target, addr = regs->ip;
 	enum bug_trap_type btt;
@@ -82,7 +82,7 @@ enum bug_trap_type handle_cfi_failure(st
 		break;
 
 	case CFI_FINEIBT:
-		if (!decode_fineibt_insn(regs, &target, &type))
+		if (!decode_fineibt_insn(ud_type, regs, &target, &type))
 			return BUG_TRAP_TYPE_NONE;
 
 		break;



