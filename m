Return-Path: <linux-kernel+bounces-514685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCB2A35A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57EF16BACA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914DE24292B;
	Fri, 14 Feb 2025 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nt+Lj0eR"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B073B139D1B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525190; cv=none; b=ewqRVf/v1xw+7r+XxXjvNYMOPWsiBXEDKPZlC949COX8nuoIviA26emoKoOE5L7p+M1buVYLAC5vN1+KaFOhssJefFo+cr/n73ZEuyyLHTeGlUqJrCwoaf1OIx7NltqUm3tggEEobFekspW4PIx2nqpA5PChWCycBx1vZ7P180A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525190; c=relaxed/simple;
	bh=t/7bK4IivyX8NjW9vzwnhy+F5l6QrXRG+wv+wq0KWkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lv4xFL84yru0qSlIShU5ky2rU/tBW3K6tVUshnJgKKLzlb8A3/4M92Di3PCU/xq7AMWviL2VTvlO8lcuPRI4lFSqnIvgR/AjYxpqusammszkfnFknxkOhx+Y0vFZ7UmsBhscBw/XpZccpWm+NTndQ0+XJyFrtfVbn4ooNkpCWWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nt+Lj0eR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XDBRO4C2r1jKbVjno0RQlxrE1N66bGEWyj0pTIdUTh0=; b=nt+Lj0eREkyl4nkoJ71gNpo6fJ
	gDjx7gIu89UOnMk2C3pcqJ2T4LOKA21xD7heuzXv6qoHoRkZnrqxAypGXkqNqthvrl1iaGeqWBvq1
	SOibnLuARKYpxoc2kKBG3UOdUW2ew80msCL0ET8pmXlUk37FMa127u2zMjOzv9+qRF4VSAXmNlZwU
	LzHUrwLIkkiKLNTljeibkU7iy6ZAsUWDdZS6qDfh2Jer930E41/geaQ7AjU5oUG1MpwcXvqVIN7r4
	kdrBvuGjpzQRG+XEiu5vNz4SpatGUw7x2yGoMcWRf+rMaKDVd9Xh313bzKO23TZX/dQnUN+jRgYdy
	qm4A/1qA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tirxk-00000001DKO-3X4E;
	Fri, 14 Feb 2025 09:26:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E941E3002F0; Fri, 14 Feb 2025 10:26:19 +0100 (CET)
Date: Fri, 14 Feb 2025 10:26:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 00/11] x86/ibt: FineIBT-BHI
Message-ID: <20250214092619.GB21726@noisy.programming.kicks-ass.net>
References: <20250207121529.222723073@infradead.org>
 <CABCJKudA8aUf=SDsVOOsWX_Cq6LAcioOjgtpv+uq+WGwJbxFPA@mail.gmail.com>
 <20250213104802.GE28068@noisy.programming.kicks-ass.net>
 <20250213114547.GB30841@noisy.programming.kicks-ass.net>
 <20250213191202.GA3105334@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213191202.GA3105334@google.com>

On Thu, Feb 13, 2025 at 07:12:02PM +0000, Sami Tolvanen wrote:

> > +	__get_kernel_nofault(&hash, *(u32 *)(addr + fineibt_preamble_hash), u32, Efault);
> 
> You have an extra * here, should be just (u32 *).

Doh :-), I started by doing a plain deref and then figured I should be
careful and wrap it in the nofault thing.


> Otherwise, LGTM.
> 
> One minor issue is that since the trap is in the preamble, we don't
> get caller information in the warning message:
> 
> [   19.080184] CFI failure at __cfi_lkdtm_increment_int+0xd/0x10
> (target: lkdtm_increment_int+0x0/0x20; expected type: 0x7e0c52a5)
> 
> But this is followed by a call trace, so it's not really necessary
> either. With the __get_kernel_nofault argument fixed:
> 
> Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Thanks.

I did some more clean-ups. I'll stick it on top of those patches slated
for x86/core.

---
Subject: x86/ibt: Handle FineIBT in handle_cfi_failure()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 13 Feb 2025 12:45:47 +0100

Sami reminded me that FineIBT failure does not hook into the regular
CFI failure case, and as such CFI_PERMISSIVE does not work.

Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/include/asm/cfi.h    |   11 +++++++++++
 arch/x86/kernel/alternative.c |   30 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cfi.c         |   22 ++++++++++++++++++----
 3 files changed, 59 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -126,6 +126,17 @@ static inline int cfi_get_offset(void)
 
 extern u32 cfi_get_func_hash(void *func);
 
+#ifdef CONFIG_FINEIBT
+extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
+#else
+static inline bool
+decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	return false;
+}
+
+#endif
+
 #else
 static inline enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1065,6 +1065,7 @@ asm(	".pushsection .rodata			\n"
 	"	endbr64				\n"
 	"	subl	$0x12345678, %r10d	\n"
 	"	je	fineibt_preamble_end	\n"
+	"fineibt_preamble_ud2:			\n"
 	"	ud2				\n"
 	"	nop				\n"
 	"fineibt_preamble_end:			\n"
@@ -1072,9 +1073,11 @@ asm(	".pushsection .rodata			\n"
 );
 
 extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_ud2[];
 extern u8 fineibt_preamble_end[];
 
 #define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_ud2  (fineibt_preamble_ud2 - fineibt_preamble_start)
 #define fineibt_preamble_hash 7
 
 asm(	".pushsection .rodata			\n"
@@ -1410,6 +1413,33 @@ static void poison_cfi(void *addr)
 	}
 }
 
+/*
+ * regs->ip points to a UD2 instruction, return true and fill out target and
+ * type when this UD2 is from a FineIBT preamble.
+ *
+ * We check the preamble by checking for the ENDBR instruction relative to the
+ * UD2 instruction.
+ */
+bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	unsigned long addr = regs->ip - fineibt_preamble_ud2;
+	u32 endbr, hash;
+
+	__get_kernel_nofault(&endbr, addr, u32, Efault);
+	if (endbr != gen_endbr())
+		return false;
+
+	*target = addr + fineibt_preamble_size;
+
+	__get_kernel_nofault(&hash, addr + fineibt_preamble_hash, u32, Efault);
+	*type = (u32)regs->r10 + hash;
+
+	return true;
+
+Efault:
+	return false;
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -70,11 +70,25 @@ enum bug_trap_type handle_cfi_failure(st
 	unsigned long target;
 	u32 type;
 
-	if (!is_cfi_trap(regs->ip))
-		return BUG_TRAP_TYPE_NONE;
+	switch (cfi_mode) {
+	case CFI_KCFI:
+		if (!is_cfi_trap(regs->ip))
+			return BUG_TRAP_TYPE_NONE;
+
+		if (!decode_cfi_insn(regs, &target, &type))
+			return report_cfi_failure_noaddr(regs, regs->ip);
+
+		break;
 
-	if (!decode_cfi_insn(regs, &target, &type))
-		return report_cfi_failure_noaddr(regs, regs->ip);
+	case CFI_FINEIBT:
+		if (!decode_fineibt_insn(regs, &target, &type))
+			return BUG_TRAP_TYPE_NONE;
+
+		break;
+
+	default:
+		return BUG_TRAP_TYPE_NONE;
+	}
 
 	return report_cfi_failure(regs, regs->ip, &target, type);
 }

