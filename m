Return-Path: <linux-kernel+bounces-522354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3FCA3C906
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D92947A31D6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2913722AE68;
	Wed, 19 Feb 2025 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G3u2HieI"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C021506A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739994291; cv=none; b=Cvcb67B49Ncz1WaYtrcPOCUN8FFnZ1wkRCTZz/dG6WjwnfLD36NssQmpv9z6iz3K8LSOFxXXzFNTHIkstJS5rjWoRGPhr5vd9ia05X5MgApFZfjQdWzakoDnkwxe/jc+SprPynssaXh0L0v0FAuySaQzp1aR57uABpAJkqBnTI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739994291; c=relaxed/simple;
	bh=ymig95u+TpKn0As+PdhtG2k8P1fnrnCQBHouZOQxhS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyNLpll/71SFkySUX3oRCtULMzDBYN9Q2P2VVLXNEXtvZBt1bUWMAIbrSlCVumYYPjQQjT5Q0YvRFBZ25Bomrj0Nx5QXVgOWUNO5YO1UmPLRFUDFY1S0SplTxUTsRcs87hBnXCfYwQpSPRZLKUQThkw8wX/oQHVsgfFlFmtMaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G3u2HieI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/27S/+lQuDD2Y9bYa5K5WKmTxxjEKpYYzyueogbRlfo=; b=G3u2HieI7JXhN63p1cG8J5Pc77
	JXNleKu2HLKc6+cKDMDakiHAM+xLQm9K26Kdpq9xuAtrfbQLm8FWYxEZClM4+BPvidCkDgG8YAkL5
	Nq0z7Zdii3RcN/ioAijl6cBiTYEyEEpyP53K95J8zR9f3mrOgYN9K+7jKlk6ntyT2GESGGQkrLVNO
	EBSD6jepO+3OB3xBDAVtzE0tsVyQ6l/tiBNnkrjRPosC1nC9bV28+MDFMiY77Ou67H7Ovon/dFL1E
	7HiWWlmyrcRpiW4qp6YwyqcZ7GEGo+jcKjfp3830GfK3+wTpg2S8u2hTJyZ5CAz506NIKnKXkF3mK
	Sl//u+jw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tkpzu-00000002Jff-1PYT;
	Wed, 19 Feb 2025 19:44:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 40084300783; Wed, 19 Feb 2025 20:44:41 +0100 (CET)
Date: Wed, 19 Feb 2025 20:44:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, samitolvanen@google.com, nathan@kernel.org,
	ojeda@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org,
	jmill@asu.edu
Subject: Re: [PATCH v3 06/10] x86/traps: Decode LOCK Jcc.d8 #UD
Message-ID: <20250219194441.GA28384@noisy.programming.kicks-ass.net>
References: <20250219162107.880673196@infradead.org>
 <20250219163514.928125334@infradead.org>
 <202502191013.72E4EFFF0@keescook>
 <20250219183329.GE23004@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219183329.GE23004@noisy.programming.kicks-ass.net>

On Wed, Feb 19, 2025 at 07:33:30PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2025 at 10:20:25AM -0800, Kees Cook wrote:
> 
> > I realize these are misplaced chunks, but passing ud_type into the
> > handler feels like a layering violation to me. I struggled with this
> > when making recommendations for the UBSAN handler too, so I'm not sure
> > I have any better idea. It feels like there should be a way to separate
> > this logic more cleanly. The handlers are all doing very similar things:
> > 
> > 1- find the address where a bad thing happened
> > 2- report about it
> > 3- whether to continue execution
> > 4- where to continue execution
> > 
> > The variability happens with 1 and 4, where it depends on the instruction
> > sequences. Meh, I dunno. I can't see anything cleaner, so passing down
> > ud_type does seem best.
> 
> Yeah, agreed. I couldn't get rid of relying on ud_type entirely (it was
> worse), I'll see if I can come up something.

Completely untested, but I think it should work...

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 896cf8cf4ea7..2f6a01f098b5 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -109,7 +109,7 @@ extern bhi_thunk __bhi_args_end[];
 struct pt_regs;
 
 #ifdef CONFIG_CFI_CLANG
-enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs);
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs);
 #define __bpfcall
 extern u32 cfi_bpf_hash;
 extern u32 cfi_bpf_subprog_hash;
@@ -133,10 +133,10 @@ extern u32 cfi_get_func_hash(void *func);
 extern int cfi_get_func_arity(void *func);
 
 #ifdef CONFIG_FINEIBT
-extern bool decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u32 *type);
+extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
 #else
 static inline bool
-decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u32 *type)
+decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
 {
 	return false;
 }
@@ -144,7 +144,7 @@ decode_fineibt_insn(int ud_type, struct pt_regs *regs, unsigned long *target, u3
 #endif
 
 #else
-static inline enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
+static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	return BUG_TRAP_TYPE_NONE;
 }
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 5bf5c0283259..d00eabf092f2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1631,7 +1631,7 @@ static void poison_cfi(void *addr)
  * We check the preamble by checking for the ENDBR instruction relative to the
  * 0xEA instruction.
  */
-static bool decode_fineibt_preamble(int ud_type, struct pt_regs *regs,
+static bool decode_fineibt_preamble(struct pt_regs *regs,
 				    unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_preamble_ud;
@@ -1660,7 +1660,7 @@ static bool decode_fineibt_preamble(int ud_type, struct pt_regs *regs,
 /*
  * regs->ip points to one of the UD2 in __bhi_args[].
  */
-static bool decode_fineibt_bhi(int ud_type, struct pt_regs *regs,
+static bool decode_fineibt_bhi(struct pt_regs *regs,
 			       unsigned long *target, u32 *type)
 {
 	unsigned long addr;
@@ -1696,12 +1696,15 @@ static bool decode_fineibt_bhi(int ud_type, struct pt_regs *regs,
  * regs->ip points to a LOCK Jcc.d8 instruction from the fineibt_paranoid_start[]
  * sequence.
  */
-static bool decode_fineibt_paranoid(int ud_type, struct pt_regs *regs,
+static bool decode_fineibt_paranoid(struct pt_regs *regs,
 				    unsigned long *target, u32 *type)
 {
 	unsigned long addr = regs->ip - fineibt_paranoid_ud;
 	u32 hash;
 
+	if (!is_cfi_trap(addr + fineibt_caller_size - LEN_UD2))
+		return false;
+
 	__get_kernel_nofault(&hash, addr + fineibt_caller_hash, u32, Efault);
 	*target = regs->r11 + fineibt_preamble_size;
 	*type = regs->r10;
@@ -1716,15 +1719,17 @@ static bool decode_fineibt_paranoid(int ud_type, struct pt_regs *regs,
 	return false;
 }
 
-bool decode_fineibt_insn(int ud_type, struct pt_regs *regs,
+bool decode_fineibt_insn(struct pt_regs *regs,
 			 unsigned long *target, u32 *type)
 {
-	if (ud_type == BUG_LOCK)
-		return decode_fineibt_paranoid(ud_type, regs, target, type);
 	if (regs->ip > (unsigned long)__bhi_args &&
 	    regs->ip < (unsigned long)__bhi_args_end)
-		return decode_fineibt_bhi(ud_type, regs, target, type);
-	return decode_fineibt_preamble(ud_type, regs, target, type);
+		return decode_fineibt_bhi(regs, target, type);
+
+	if (decode_fineibt_paranoid(regs, target, type))
+		return true;
+
+	return decode_fineibt_preamble(regs, target, type);
 }
 
 #else
diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index a1b03255f4b9..77086cf565ec 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -65,7 +65,7 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
  * Checks if a ud2 trap is because of a CFI failure, and handles the trap
  * if needed. Returns a bug_trap_type value similarly to report_bug.
  */
-enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
+enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
 	unsigned long target, addr = regs->ip;
 	u32 type;
@@ -81,7 +81,7 @@ enum bug_trap_type handle_cfi_failure(int ud_type, struct pt_regs *regs)
 		break;
 
 	case CFI_FINEIBT:
-		if (!decode_fineibt_insn(ud_type, regs, &target, &type))
+		if (!decode_fineibt_insn(regs, &target, &type))
 			return BUG_TRAP_TYPE_NONE;
 
 		break;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 67fa578c451b..8945e3e23240 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -333,21 +333,18 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		raw_local_irq_enable();
 
 	switch (ud_type) {
-	case BUG_EA:
-	case BUG_LOCK:
-		if (handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
-			if (regs->ip == addr)
-				regs->ip += ud_len;
+	case BUG_UD2:
+		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ) {
 			handled = true;
+			break;
 		}
-		break;
+		fallthrough;
 
-	case BUG_UD2:
-		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN ||
-		    handle_cfi_failure(ud_type, regs) == BUG_TRAP_TYPE_WARN) {
-			if (regs->ip == addr)
-				regs->ip += ud_len;
+	case BUG_EA:
+	case BUG_LOCK:
+		if (handle_cfi_failure(regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
+			break;
 		}
 		break;
 
@@ -363,6 +360,10 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		break;
 	}
 
+	/* Continue after the trapping instruction, unless overridden. */
+	if (handled && regs->ip == addr)
+		regs->ip += ud_len;
+
 	/* Restore failure location if we're not continuing execution. */
 	if (!handled && regs->ip != addr)
 		regs->ip = addr;

