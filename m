Return-Path: <linux-kernel+bounces-512846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C3FA33E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0021E188D287
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31D6209F2A;
	Thu, 13 Feb 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8i9M/0B"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B442227EB6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447157; cv=none; b=DofDRI+VAdgwaxKoqpi07AGVXqY5pYWsgo7QY5nKNzUdAyJvooy0/aOdJWVfVTknrMTOqpCK4hEY6vNFE1V28YjJKCyjuY17OtWPmVz/W54IRUpsUvQ0AP1898160A4+6t/QuGGlu/vQ1uRJrEOGVK+VEzuZxy6AlULm6A+HS7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447157; c=relaxed/simple;
	bh=wnO+LqqljARF7zFGsjfnzayc7yBAYtpzFvs/xZU9Lh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Bh0cz/433W6Gyc8D23vUipyzl0JU1zjA//fnmtLlkCzjHM0s5fvSJh+PBBFAODzvQhx86FokUGr/tM88nda++kJK0NJNPAt19wM1AlqQExk5dXgeJ7fY0B4xfiThRb+kUb6AyPMLD9deSPDLMWxV3rRc7eRnmuWLPDsIpuD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8i9M/0B; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4e4iRZQzfs5/TgKoEzkPjUoLhuH9cDxxCyB6VN1NHA4=; b=T8i9M/0BQPMbJKsQmbH2N1c5lg
	m+j9eWngfDTJeqEVfU/SKgRG+A2Dr9jMf9PCUgREOpReagjwO6187u6oyCVQO5r533iEeyjx/Nl6M
	J/GDI3HjAYsnUjhMzDB0gdf7wOZInf5tq/LijgELanW5TP+N53/cnpRRoGzX2EI3m//ZaOmY5twJa
	+lMvvdtNF3yNsPvusnVK6aQYRUw0mKua2pijHT3bCDJkP2kEkJUkLo4Pp7NliycKwvKtFXcuIJPQ/
	KXWwqBcAWNA/2kVa3Yab+UC34HIFymWqoKd0+xejj86+yxksN18d2zM6f7DtAVF88ccv+9N2qICwD
	k2DXK7cQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiXfA-00000008Asc-3tFE;
	Thu, 13 Feb 2025 11:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9858E3001FD; Thu, 13 Feb 2025 12:45:47 +0100 (CET)
Date: Thu, 13 Feb 2025 12:45:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, alyssa.milburn@intel.com,
	scott.d.constable@intel.com, joao@overdrivepizza.com,
	andrew.cooper3@citrix.com, jpoimboe@kernel.org,
	jose.marchesi@oracle.com, hjl.tools@gmail.com,
	ndesaulniers@google.com, nathan@kernel.org, ojeda@kernel.org,
	kees@kernel.org, alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 00/11] x86/ibt: FineIBT-BHI
Message-ID: <20250213114547.GB30841@noisy.programming.kicks-ass.net>
References: <20250207121529.222723073@infradead.org>
 <CABCJKudA8aUf=SDsVOOsWX_Cq6LAcioOjgtpv+uq+WGwJbxFPA@mail.gmail.com>
 <20250213104802.GE28068@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213104802.GE28068@noisy.programming.kicks-ass.net>

On Thu, Feb 13, 2025 at 11:48:02AM +0100, Peter Zijlstra wrote:

> > One thing I realized is that CONFIG_CFI_PERMISSIVE doesn't actually do
> > anything when FineIBT is used since we lose track of CFI trap
> > locations. I'm not sure if that's worth fixing, but perhaps we could
> > disable FineIBT when permissive mode is enabled to avoid confusion?
> 
> Hmm, yeah, that's one thing I keep forgetting about. Let me try and fix
> it and see how ugly it gets before offering an opinion :-)

Completely untested and on top of this series minus the last two patches
-- basically what I just pushed into:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/core

WDYT?

---

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index e285933506e9..1fec1e445a25 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1410,6 +1410,36 @@ static void poison_cfi(void *addr)
 	}
 }
 
+bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	/*
+	 * FineIBT preamble:
+	 *
+	 *  __cfi_foo:
+	 *     endbr64
+	 *     subl $0x12345678, %r10d
+	 *     jz   1f
+	 *     ud2
+	 *  1: nop
+	 *  foo:
+	 *
+	 * regs->ip points to the UD2 instruction.
+	 */
+	unsigned long addr = regs->ip - (4+7+2);
+	u32 hash;
+
+	if (!is_endbr((void *)addr)) {
+Efault:
+		return false;
+	}
+
+	*target = addr + fineibt_preamble_size;
+
+	__get_kernel_nofault(&hash, *(u32 *)(addr + fineibt_preamble_hash), u32, Efault);
+	*type = (u32)regs->r10 + hash;
+	return true;
+}
+
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
@@ -1421,6 +1451,11 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 static void poison_cfi(void *addr) { }
 #endif
 
+bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type)
+{
+	return false;
+}
+
 #endif
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
diff --git a/arch/x86/kernel/cfi.c b/arch/x86/kernel/cfi.c
index e6bf78fac146..4c682076c656 100644
--- a/arch/x86/kernel/cfi.c
+++ b/arch/x86/kernel/cfi.c
@@ -61,6 +61,8 @@ static bool decode_cfi_insn(struct pt_regs *regs, unsigned long *target,
 	return true;
 }
 
+extern bool decode_fineibt_insn(struct pt_regs *regs, unsigned long *target, u32 *type);
+
 /*
  * Checks if a ud2 trap is because of a CFI failure, and handles the trap
  * if needed. Returns a bug_trap_type value similarly to report_bug.
@@ -70,11 +72,25 @@ enum bug_trap_type handle_cfi_failure(struct pt_regs *regs)
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

