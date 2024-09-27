Return-Path: <linux-kernel+bounces-342138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42131988AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A328AB25013
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4161C461B;
	Fri, 27 Sep 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxcwUHMB"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5311C3F3C
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466664; cv=none; b=BdWVVUmzpYktdzmr4jiXQbmhxcjSA6eDZJ2mlvYmTrowKYNpf86mF9QX7RCf0AP8fkfO2UQLsCfcl+gNMwW78+8THSPUrOjx1/nCDm43NTRF/iAU/Lc6hfvBFYJJ5b6bFrb1c06TzrR/qhkScnxRGnO8uj5QDALbVVhbv+pyptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466664; c=relaxed/simple;
	bh=kQaFbC4eVC0UP983bJ9oNVqQfL86oa2qo9PsnHN/zAM=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KL9JkbGlq6sKqAKK5kluDR4uFN9bRweccNc+rxXlNWBISMaqxK3TE8kZPjuXBkO73SEJ7boBuUBqDrotPLIDHsinc2LwYAi+6Q1IfXLzR7R2MNZPrdb+GIRQQPKvm/DkiLuLteuskEZGYe0F9hin3IhBl6Sd1W9aDlAobZL//6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hxcwUHMB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ROsGWBJKd8LF8eUnYQyESejYA9lwOOpnxR5fs87Okc8=; b=hxcwUHMByxq3qxzPft9/txX7I5
	67nI2rlZQMU9ZN9a/Hrpox1s73cCepAwmccVqqHdTFsjY9pr2OMDrvvcNpmrMNooVJK8Yb79cc72h
	9/lRhSElfLhLHsF11/HMqnpwE367cvrT1p2qbZyA3W/23RBLQU3unzG7PrnEHdoK+4GTNFDxf54Pt
	wtBu6t1YyEeXC9EXWOVWKCusLJl9HMVTPv4+Hb0Q4BmUcn6I2KEOEeY7fjGtl4jhRzrpy+eAHbNsZ
	XYIPkGIVQS+h8+F1FLiIKD8Kp7R6P+GkTfd3aFXgLYINGMu6D3J7Zl3TS5lmgjbFqDz4Z4KDavLbM
	EpV2bjVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-00000002Onn-2eO0;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id BEFC63011E4; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194924.949420892@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:02 +0200
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
 alexei.starovoitov@gmail.com
Subject: [PATCH 06/14] x86/traps: Prepare for ENDBR poison UD1 usage
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Prepare for ENDBR poison to become UD1 by making #UD recognise it as a valid
BUG address so we get a nice BUG splat when we trip on one.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |    6 ++-
 arch/x86/include/asm/ibt.h |    8 +++-
 arch/x86/kernel/cet.c      |   18 ++++++---
 arch/x86/kernel/traps.c    |   89 +++++++++++++++++++++++++++++++++------------
 4 files changed, 90 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,8 +22,10 @@
 #define SECOND_BYTE_OPCODE_UD2	0x0b
 
 #define BUG_NONE		0xffff
-#define BUG_UD1			0xfffe
-#define BUG_UD2			0xfffd
+#define BUG_UD2			0xfffe
+#define BUG_UD1			0xfffd
+#define BUG_UD1_UBSAN		0xfffc
+#define BUG_UD1_ENDBR		0xfffb
 
 #ifdef CONFIG_GENERIC_BUG
 
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -41,7 +41,7 @@
 	_ASM_PTR fname "\n\t"				\
 	".popsection\n\t"
 
-static inline __attribute_const__ u32 gen_endbr(void)
+static __always_inline __attribute_const__ u32 gen_endbr(void)
 {
 	u32 endbr;
 
@@ -56,7 +56,7 @@ static inline __attribute_const__ u32 ge
 	return endbr;
 }
 
-static inline __attribute_const__ u32 gen_endbr_poison(void)
+static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 {
 	/*
 	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
@@ -77,6 +77,10 @@ static inline bool is_endbr(u32 val)
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
+struct pt_regs;
+
+extern bool __do_kernel_cp_fault(struct pt_regs *regs);
+
 #else /* __ASSEMBLY__ */
 
 #ifdef CONFIG_X86_64
--- a/arch/x86/kernel/cet.c
+++ b/arch/x86/kernel/cet.c
@@ -81,6 +81,17 @@ static void do_user_cp_fault(struct pt_r
 
 static __ro_after_init bool ibt_fatal = true;
 
+bool __do_kernel_cp_fault(struct pt_regs *regs)
+{
+	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
+	if (!ibt_fatal) {
+		printk(KERN_DEFAULT CUT_HERE);
+		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+		return true;
+	}
+	return false;
+}
+
 static void do_kernel_cp_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	if ((error_code & CP_EC) != CP_ENDBR) {
@@ -93,12 +104,9 @@ static void do_kernel_cp_fault(struct pt
 		return;
 	}
 
-	pr_err("Missing ENDBR: %pS\n", (void *)instruction_pointer(regs));
-	if (!ibt_fatal) {
-		printk(KERN_DEFAULT CUT_HERE);
-		__warn(__FILE__, __LINE__, (void *)regs->ip, TAINT_WARN, regs, NULL);
+	if (__do_kernel_cp_fault(regs))
 		return;
-	}
+
 	BUG();
 }
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -94,10 +94,18 @@ __always_inline int is_valid_bugaddr(uns
 
 /*
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
- * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ * If it's a UD1, further decode to determine its use:
+ *
+ * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
+ * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
+ * static_call:  0f b9 cc                ud1    %esp,%ecx
+ * ENDBR Poison: 0f b9 48 00             ud1    0(%eax),%edx
+ *
+ * Notably UBSAN uses EAX, static_call uses ECX and ENDBR uses EDX.
  */
-__always_inline int decode_bug(unsigned long addr, u32 *imm)
+__always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
+	unsigned long start = addr;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -110,24 +118,41 @@ __always_inline int decode_bug(unsigned
 		return BUG_NONE;
 
 	v = *(u8 *)(addr++);
-	if (v == SECOND_BYTE_OPCODE_UD2)
+	if (v == SECOND_BYTE_OPCODE_UD2) {
+		*len = addr - start;
 		return BUG_UD2;
+	}
 
-	if (!IS_ENABLED(CONFIG_UBSAN_TRAP) || v != SECOND_BYTE_OPCODE_UD1)
+	if (v != SECOND_BYTE_OPCODE_UD1)
 		return BUG_NONE;
 
-	/* Retrieve the immediate (type value) for the UBSAN UD1 */
-	v = *(u8 *)(addr++);
-	if (X86_MODRM_RM(v) == 4)
-		addr++;
-
 	*imm = 0;
-	if (X86_MODRM_MOD(v) == 1)
-		*imm = *(u8 *)addr;
-	else if (X86_MODRM_MOD(v) == 2)
-		*imm = *(u32 *)addr;
-	else
-		WARN_ONCE(1, "Unexpected MODRM_MOD: %u\n", X86_MODRM_MOD(v));
+	v = *(u8 *)(addr++);		/* ModRM */
+
+	/* Decode immediate, if present */
+	if (X86_MODRM_MOD(v) != 3) {
+		if (X86_MODRM_RM(v) == 4)
+			addr++;		/* Skip SIB byte */
+
+		if (X86_MODRM_MOD(v) == 1) {
+			*imm = *(s8 *)addr;
+			addr += 1;
+
+		} else if (X86_MODRM_MOD(v) == 2) {
+			*imm = *(s32 *)addr;
+			addr += 4;
+		}
+	}
+
+	/* record instruction length */
+	*len = addr - start;
+
+	if (X86_MODRM_REG(v) == 0)	/* EAX */
+		return BUG_UD1_UBSAN;
+
+	if (X86_MODRM_REG(v) == 2 &&	/* RDX */
+	    *len == ENDBR_INSN_SIZE)
+		return BUG_UD1_ENDBR;
 
 	return BUG_UD1;
 }
@@ -258,8 +283,8 @@ static inline void handle_invalid_op(str
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
-	int ud_type;
-	u32 imm;
+	int ud_type, ud_len;
+	s32 ud_imm;
 
 	/*
 	 * Normally @regs are unpoisoned by irqentry_enter(), but handle_bug()
@@ -267,7 +292,7 @@ static noinstr bool handle_bug(struct pt
 	 * irqentry_enter().
 	 */
 	kmsan_unpoison_entry_regs(regs);
-	ud_type = decode_bug(regs->ip, &imm);
+	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -281,15 +306,35 @@ static noinstr bool handle_bug(struct pt
 	 */
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_enable();
-	if (ud_type == BUG_UD2) {
+
+	switch (ud_type) {
+	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
 		    handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
-			regs->ip += LEN_UD2;
+			regs->ip += ud_len;
+			handled = true;
+		}
+		break;
+
+	case BUG_UD1_UBSAN:
+		if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
+			pr_crit("%s at %pS\n",
+				report_ubsan_failure(regs, ud_imm),
+				(void *)regs->ip);
+		}
+		break;
+
+	case BUG_UD1_ENDBR:
+		if (__do_kernel_cp_fault(regs)) {
+			regs->ip += ud_len;
 			handled = true;
 		}
-	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
-		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
+		break;
+
+	default:
+		break;
 	}
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();



