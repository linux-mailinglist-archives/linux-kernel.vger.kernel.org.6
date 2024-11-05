Return-Path: <linux-kernel+bounces-396358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD349BCC1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5A828277E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B01D514C;
	Tue,  5 Nov 2024 11:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jpwn2L47"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947C1D47AE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807272; cv=none; b=U6Nc7VHVEepOmdJ43CVnol4xRHc2SSVys32Ng1CmI01lphSbXCn2SgHGcn9J9armCU9fAWQplljxFSq0c4pdttD1PXp62ByoDRsGeYwrgfg9DMAEr7d1vzuH6Nnq2idp5HtzcOfACexJdQy5kLLC2uKRzUMo1Mx4ofNckerO8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807272; c=relaxed/simple;
	bh=DYut+ZNmKVLDbuVR4KsvsENEo/4ybq+yq1mBLILhakU=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FY/wlNt67xyuwS1/u8hvu5fH5mrkSuf+lMQPTIEN8stYMudjHnMGbApAEWNcMOfWhhNttBE8FhEBvIIbIPyQpPpAYGjt4zCmyZdM1w4P95UZhUS0K775gTRmvQoJalt0dEWiOO7Cp5gdGSLbIHEZXzKhz2lnvGeCi511J6awJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jpwn2L47; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=B01bUPAtb2sG7Vee4RtuggO+7OEXdIKofz2GrH09qY4=; b=jpwn2L47UMSF3erRgMDRV7HMj5
	GBgysj7qg+E724WkQaQBrM/jkQmTQg9ObBl/KTjdDl1gGQ3kEAQPnp71P5NGNr08BordC60X/BNvu
	585XOYQECqRHWq9Dm+wcqFt1OhFY+abbz69vD8uYYs/+48fPbca5U0tIwv9a2Qoa00CZGgGw55OZa
	O+ajTG6dT7aogrqXK2ovVy3bsoHGkx1ZJtxhleL7SUerMwSKtRrcPVYCcdg3OEbxo6RNxUJnU+Bf1
	C/fG4V9PiK8KxY9zEAoBTy+uiMSu78x4z/QAk3bFQ/OEg8WVcJXmtHUBIsNxhQR+kaMFtDopB94Y7
	agGVYGyw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2F-0000000Bjjs-0DM3;
	Tue, 05 Nov 2024 11:47:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id ECA75300134; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114522.285032152@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:06 +0100
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
Subject: [PATCH 5/8] x86/traps: Cleanup and robustify decode_bug()
References: <20241105113901.348320374@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Notably, don't attempt to decode an immediate when MOD == 3.

Additionally have it return the instruction length, such that WARN
like bugs can more reliably skip to the correct instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |    5 +-
 arch/x86/include/asm/ibt.h |    4 +-
 arch/x86/kernel/cet.c      |   18 +++++++---
 arch/x86/kernel/traps.c    |   77 ++++++++++++++++++++++++++++++++-------------
 4 files changed, 73 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -22,8 +22,9 @@
 #define SECOND_BYTE_OPCODE_UD2	0x0b
 
 #define BUG_NONE		0xffff
-#define BUG_UD1			0xfffe
-#define BUG_UD2			0xfffd
+#define BUG_UD2			0xfffe
+#define BUG_UD1			0xfffd
+#define BUG_UD1_UBSAN		0xfffc
 
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
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -94,10 +94,17 @@ __always_inline int is_valid_bugaddr(uns
 
 /*
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
- * If it's a UD1, get the ModRM byte to pass along to UBSan.
+ * If it's a UD1, further decode to determine its use:
+ *
+ * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
+ * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
+ * static_call:  0f b9 cc                ud1    %esp,%ecx
+ *
+ * Notably UBSAN uses EAX, static_call uses ECX.
  */
-__always_inline int decode_bug(unsigned long addr, u32 *imm)
+__always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
+	unsigned long start = addr;
 	u8 v;
 
 	if (addr < TASK_SIZE_MAX)
@@ -110,24 +117,37 @@ __always_inline int decode_bug(unsigned
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
 
 	return BUG_UD1;
 }
@@ -258,10 +278,10 @@ static inline void handle_invalid_op(str
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	bool handled = false;
-	int ud_type;
-	u32 imm;
+	int ud_type, ud_len;
+	s32 ud_imm;
 
-	ud_type = decode_bug(regs->ip, &imm);
+	ud_type = decode_bug(regs->ip, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -281,15 +301,28 @@ static noinstr bool handle_bug(struct pt
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
 			handled = true;
 		}
-	} else if (IS_ENABLED(CONFIG_UBSAN_TRAP)) {
-		pr_crit("%s at %pS\n", report_ubsan_failure(regs, imm), (void *)regs->ip);
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
+	default:
+		break;
 	}
+
 	if (regs->flags & X86_EFLAGS_IF)
 		raw_local_irq_disable();
 	instrumentation_end();



