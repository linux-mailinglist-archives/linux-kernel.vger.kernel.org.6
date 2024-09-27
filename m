Return-Path: <linux-kernel+bounces-342134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50905988AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32471F23A99
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40501C331C;
	Fri, 27 Sep 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="boCoGFWl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BC046B8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466655; cv=none; b=R9BEhl34Pkr+nvOdcJKAvQ5snH/CyL+yGib0SCaO9gBjqoJ8cXWVfIz+ZBA9zbneycm5Nr8A+OmIGMEALE3SEMs6ZmUCbF9VgjJapgQH7fTe2v0M9dNjxwLSdh9EeiReUfsEpUJhRSBbushbvBe6pftGp8b8+Hss3ZExM5izkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466655; c=relaxed/simple;
	bh=8sZxPuRbomSMJfL/W9LjjPUHMhM2X6DLtr5iTM4vWh8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=vBQHY4lygPaVOeGKgSrRaqWj7LGgx2+EvxBUlqkyckHoPXhmSIt++LUd4FHkgs4MfQzWwtHLiIBOU8WHGaYa2tso7XIDhV4ibC9Hm4e/L0uv2zSQziVKG6MVnVOaeZ26GAi7uKSmoFcTUhJ+x4Vka0OrJm9FBNGblYbY1rv/F18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=boCoGFWl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=RpIFeMYhriEM2/4B/8JXzCFYxG/jfIBuyxGPfy1TFiA=; b=boCoGFWllgiin496ZhslbBChPl
	YvAxQ/SKtVk9dyQMFw47OnySwaaD9/YqEF5h0fmOtsyMUv5D7HiEon1nklas9pfEjo9eira9ewJIk
	tmZuUR9DCfeycS79BQtqILg4SIxr9Rp5UFXjgjo7orxf3quRbrCAUNRd+iK72dwQgu9R/Ld3/TLc4
	BEdQkpOQZRJzOduL20es0MW0+JDfCOhlkB9h/+lRfIC/C11EIQ+2qQ6x+dxf0dwr/jnnd8QVmEzse
	MEdE+XOXikBCeA6Cy83+niMHhZOb567ws8cgVAEdFqe0sB70VGjFjZvnj3/eJzYg0SBIpoHOsmC7l
	rYRig5ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzH-0000000AVcz-04jp;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DE849308CC7; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.808912874@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:10 +0200
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
Subject: [PATCH 14/14] x86/fineibt: Add FineIBT+BHI mitigation
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Due to FineIBT weakness, add an additional mitigation for BHI.

Use the 5 bytes of the nop at -1 and the 4 byte poison to squirrel in
a BHI mitigation.

Relies on clang-cfi to emit an additional piece of magic in the kCFI
pre-amble, identifying which function arguments are pointers.

An additional u8 (next to the existing u32) is emitted like:

	movl	0x12345678, %eax	// CFI hash
	movb	0x12, %al		// CFI args

This u8 is a bitmask, where BIT(n) indicates the n'th argument is a
pointer, notably the 6 possible argument registers are:

	rdi, rsi, rdx, rcx, r8 and r9

Single bit can be inlined, while 2-4 bits have combinatoric stubs with
the required magic in. Anything more will fall back to
__bhi_args_all which additionally poisons %rsp for good measure, in
case things overflowed to the stack.


  FineIBT+				FineIBT+BHI

  __cfi_foo:				__cfi_foo:
    endbr64				  endbr64
    subl	$0x12345678, %r10d        subl	$0x12345678, %r10d
    jz	foo+4                             jz	+2
    ud2                                   ud2
    nop                                   call	__bhi_args_foo
  foo:                                  foo+4:
    ud1 0x0(%eax), %eax
    ...                                   ...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/cfi.h    |    1 
 arch/x86/kernel/alternative.c |   82 ++++++++++++++++++++++++++++++++++++++----
 arch/x86/net/bpf_jit_comp.c   |   16 ++++++--
 tools/objtool/check.c         |   16 ++++----
 4 files changed, 98 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -97,6 +97,7 @@ enum cfi_mode {
 	CFI_OFF,	/* Taditional / IBT depending on .config */
 	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
 	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
+	CFI_FINEIBT_BHI,
 };
 
 extern enum cfi_mode cfi_mode;
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -932,7 +932,31 @@ __noendbr bool is_endbr(u32 *val)
 	if (get_kernel_nofault(endbr, val))
 		return false;
 
-	return __is_endbr(endbr);
+	if (__is_endbr(endbr))
+		return true;
+
+#if defined(CONFIG_FINEIBT) && defined(CONFIG_X86_KERNEL_IBT_PLUS)
+	if (cfi_mode != CFI_FINEIBT_BHI)
+		return false;
+
+	/*
+	 * The BHI clobbers 'replace' the ENDBR poison, but dynamic call
+	 * patching (static_call, kprobes, etc..) still need to be able
+	 * to identify and skip the foo()+0 'endbr'.
+	 */
+
+	/* REX CMOVNE, see bhi_args_1() */
+	if ((endbr & 0xc2fffff9) == 0xc2450f49)
+		return true;
+
+	/* CALL __bhi_args_* */
+	void *dest = (void *)val + 4 + (s32)endbr;
+	if (dest >= (void *)__bhi_args_6c1 &&
+	    dest <= (void *)__bhi_args_all)
+		return true;
+#endif
+
+	return false;
 }
 
 static void poison_cfi(void *addr);
@@ -1190,6 +1214,8 @@ static __init int cfi_parse_cmdline(char
 			cfi_mode = CFI_KCFI;
 		} else if (!strcmp(str, "fineibt")) {
 			cfi_mode = CFI_FINEIBT;
+		} else if (IS_ENABLED(CONFIG_X86_KERNEL_IBT_PLUS) && !strcmp(str, "fineibt+bhi")) {
+			cfi_mode = CFI_FINEIBT_BHI;
 		} else if (!strcmp(str, "norand")) {
 			cfi_rand = false;
 		} else {
@@ -1208,10 +1234,9 @@ early_param("cfi", cfi_parse_cmdline);
  *
  * __cfi_\func:					__cfi_\func:
  *	movl   $0x12345678,%eax		// 5	     endbr64			// 4
- *	nop					     subl   $0x12345678,%r10d   // 7
+ *	movb   $0x12,%al		// 2	     subl   $0x12345678,%r10d   // 7
  *	nop					     jz     1f			// 2
  *	nop					     ud2			// 2
- *	nop					1:   nop			// 1
  *	nop
  *	nop
  *	nop
@@ -1279,6 +1304,17 @@ static u32 decode_preamble_hash(void *ad
 	return 0; /* invalid hash value */
 }
 
+static u8 decode_preamble_args(void *addr)
+{
+	u8 *p = addr;
+
+	/* b0 12	movb $0x12, %al */
+	if (p[5] == 0xb0)
+		return p[6];
+
+	return 0xff; /* invalid args */
+}
+
 static u32 decode_caller_hash(void *addr)
 {
 	u8 *p = addr;
@@ -1371,6 +1407,7 @@ static int cfi_rewrite_preamble(s32 *sta
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 		u32 hash;
+		u8 args;
 
 		/*
 		 * When the function doesn't start with ENDBR the compiler will
@@ -1385,11 +1422,25 @@ static int cfi_rewrite_preamble(s32 *sta
 			 addr, addr, 5, addr))
 			return -EINVAL;
 
+		args = decode_preamble_args(addr);
+
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
 
 		*(u8 *)(addr + fineibt_preamble_jccd8) += 4;
+
+		if (cfi_mode != CFI_FINEIBT_BHI)
+			continue;
+
+		WARN_ONCE(args == 0xff, "no CFI args found at %pS %px %*ph\n",
+			  addr, addr, 7, addr);
+
+		/*
+		 * Stash the ARGS byte in the NOP at __cfi_foo+15, see
+		 * cfi_rewrite_endbr().
+		 */
+		*(u8 *)(addr + fineibt_preamble_size - 1) = args;
 	}
 
 	return 0;
@@ -1401,11 +1452,26 @@ static void cfi_rewrite_endbr(s32 *start
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
+		u8 args;
 
 		if (!is_endbr(addr + 16))
 			continue;
 
-		poison_endbr(addr + 16);
+		if (cfi_mode != CFI_FINEIBT_BHI) {
+			poison_endbr(addr + 16);
+			continue;
+		}
+
+		/* recover the args byte */
+		args = *(u8 *)(addr + fineibt_preamble_size - 1);
+		*(u8 *)(addr + fineibt_preamble_size - 1) = BYTES_NOP1;
+		if (args) {
+			/* only skip the UD2 */
+			*(u8 *)(addr + fineibt_preamble_jccd8) = 2;
+
+			/* write BHI clobber in the 5 bytes that hold: nop + poison */
+			bhi_args(args, addr + fineibt_preamble_size - 1);
+		}
 	}
 }
 
@@ -1506,6 +1572,7 @@ static void __apply_fineibt(s32 *start_r
 		return;
 
 	case CFI_FINEIBT:
+	case CFI_FINEIBT_BHI:
 		/* place the FineIBT preamble at func()-16 */
 		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
@@ -1519,8 +1586,10 @@ static void __apply_fineibt(s32 *start_r
 		/* now that nobody targets func()+0, remove ENDBR there */
 		cfi_rewrite_endbr(start_cfi, end_cfi);
 
-		if (builtin)
-			pr_info("Using FineIBT CFI\n");
+		if (builtin) {
+			pr_info("Using FineIBT%s CFI\n",
+				cfi_mode == CFI_FINEIBT_BHI ? "+BHI" : "");
+		}
 		return;
 
 	default:
@@ -1548,6 +1617,7 @@ static void poison_cfi(void *addr)
 	 */
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
+	case CFI_FINEIBT_BHI:
 		/*
 		 * FineIBT prefix should start with an ENDBR.
 		 */
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -401,10 +401,17 @@ static void emit_fineibt(u8 **pprog, u32
 
 	EMIT_ENDBR();
 	EMIT3_off32(0x41, 0x81, 0xea, hash);		/* subl $hash, %r10d	*/
-	EMIT2(0x74, 0x07);				/* jz.d8 +7		*/
-	EMIT2(0x0f, 0x0b);				/* ud2			*/
-	EMIT1(0x90);					/* nop			*/
-	EMIT_ENDBR_POISON();
+	if (cfi_mode == CFI_FINEIBT_BHI) {
+		EMIT2(0x74, 0x02);			/* jz.d8 +2		*/
+		EMIT2(0x0f, 0x0b);			/* ud2			*/
+		EMIT1(0x2e);				/* cs			*/
+		EMIT4(0x49, 0x0f, 0x45, 0xfa);		/* cmovne %r10, %rdi	*/
+	} else {
+		EMIT2(0x74, 0x07);			/* jz.d8 +7		*/
+		EMIT2(0x0f, 0x0b);			/* ud2			*/
+		EMIT1(0x90);				/* nop			*/
+		EMIT_ENDBR_POISON();
+	}
 
 	*pprog = prog;
 }
@@ -438,6 +445,7 @@ static void emit_cfi(u8 **pprog, u32 has
 
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
+	case CFI_FINEIBT_BHI:
 		emit_fineibt(&prog, hash);
 		break;
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4397,11 +4397,9 @@ static int validate_ibt_insn(struct objt
 			continue;
 
 		off = reloc->sym->offset;
-		if (reloc_type(reloc) == R_X86_64_PC32 ||
-		    reloc_type(reloc) == R_X86_64_PLT32)
-			off += arch_dest_reloc_offset(reloc_addend(reloc));
-		else
-			off += reloc_addend(reloc);
+		off += reloc_addend(reloc);
+		if (arch_pc_relative_reloc(reloc))
+			off = arch_dest_reloc_offset(off);
 
 		dest = find_insn(file, reloc->sym->sec, off);
 		if (!dest)
@@ -4456,10 +4454,14 @@ static int validate_ibt_insn(struct objt
 static int validate_ibt_data_reloc(struct objtool_file *file,
 				   struct reloc *reloc)
 {
+	long offset = reloc->sym->offset;
 	struct instruction *dest;
 
-	dest = find_insn(file, reloc->sym->sec,
-			 reloc->sym->offset + reloc_addend(reloc));
+	offset += reloc_addend(reloc);
+	if (reloc_type(reloc) == R_X86_64_PLT32) // the fuck ?!
+		offset = arch_dest_reloc_offset(offset);
+
+	dest = find_insn(file, reloc->sym->sec, offset);
 	if (!dest)
 		return 0;
 



