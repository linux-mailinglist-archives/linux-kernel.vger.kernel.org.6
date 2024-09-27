Return-Path: <linux-kernel+bounces-342139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F31988AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B02283FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DF1C4624;
	Fri, 27 Sep 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bHyuwQvQ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C51C2DA9
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466664; cv=none; b=VoYLrZ7Gp8cNj6421WBcVRjhh52WkFdMYRzdDQkNP5hcnupzhkvSBTIwOn+M6oSRgPiUjB+oXNF8ZRpbEauXzebk7m3mDMVcSsMG5Sivw9X/wx7qKjIHF6tjS1xvpUZ+a2ybP/tEK1FvNtjeMmbJ2yp+HhLXqBY6m7tq1MRX2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466664; c=relaxed/simple;
	bh=6XTpH0cJVK/rYZRKbB+rtFzk/FmVEmfgufGBwZzuFdY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NxIwe68MnweFgCzXabHg9EjSIB7QwGDLzHLJxwlrMHZdYxTBOMGGMViFXCKbzJyrKy3A/Mobbk3+ixAHGxUy2PC/GrnobQubOqpAQlh+qVvn1CcKo4Zs6VfbDKtW5M45mb7xE275hc5lnimNGkMuou0VnzXWurSk0dRbixDW8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bHyuwQvQ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=NfcLlfp3hJU+ZP8AcK7eQOnm49ijhTFuRZhXuJusWdk=; b=bHyuwQvQT7o2T0qGfWDXlhlujs
	aaa3jE9tpaELGtF+iv0LWr8h+2sgtvCsnZ6rwEw9UgxIOqt7mbdF8bYmuecTbBas0ZL0WRPkkrmnt
	yIwsh6E/PYYjGgKB2fsx24RPKQt3pRfFsw3EcLdvjA5FwdMZHlIZZFUKSzLoXrsimKbqJvBMBlg0g
	MC3+3CqaEn793NhhzrxZtSdCjy3gDYbs0+rfnmmzQeSZBxIO2Ek+VraLHWDu2qHG3f4JdShp9kl3q
	FEb4mnf8kyCxvGitSosv01lQv8GujGbcRmRFTUXASFHgs7LxSQ0yj6K+UppxESRHzoOF8h0AcsakS
	FZiembbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-00000002Ono-2o0X;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C2C7A3021DE; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.069013308@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:03 +0200
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
 Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 07/14] x86/ibt: Clean up is_endbr()
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Pretty much every caller of is_endbr() actually wants to test something at an
address and ends up doing get_kernel_nofault(). Fold the lot into a more
convenient helper.

Note: this effectively reverts commit a8497506cd2c ("bpf: Avoid
get_kernel_nofault() to fetch kprobe entry IP") which was entirely the
wrong way to go about doing things. The right solution is to optimize
get_kernel_nofault() itself, it really doesn't need STAC/CLAC nor the
speculation barrier. Using __get_user is a historical hack, not a
requirement.

Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c         |    2 +-
 arch/x86/include/asm/ibt.h     |    5 +++--
 arch/x86/kernel/alternative.c  |   19 +++++++++++++------
 arch/x86/kernel/kprobes/core.c |   11 +----------
 arch/x86/net/bpf_jit_comp.c    |    4 ++--
 kernel/trace/bpf_trace.c       |   14 ++------------
 6 files changed, 22 insertions(+), 33 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2845,7 +2845,7 @@ static bool is_uprobe_at_func_entry(stru
 		return true;
 
 	/* endbr64 (64-bit only) */
-	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
+	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
 		return true;
 
 	return false;
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -65,7 +65,7 @@ static __always_inline __attribute_const
 	return 0x001f0f66; /* osp nopl (%rax) */
 }
 
-static inline bool is_endbr(u32 val)
+static inline bool __is_endbr(u32 val)
 {
 	if (val == gen_endbr_poison())
 		return true;
@@ -74,6 +74,7 @@ static inline bool is_endbr(u32 val)
 	return val == gen_endbr();
 }
 
+extern __noendbr bool is_endbr(u32 *val);
 extern __noendbr u64 ibt_save(bool disable);
 extern __noendbr void ibt_restore(u64 save);
 
@@ -102,7 +103,7 @@ extern bool __do_kernel_cp_fault(struct
 
 #define __noendbr
 
-static inline bool is_endbr(u32 val) { return false; }
+static inline bool is_endbr(u32 *val) { return false; }
 
 static inline u64 ibt_save(bool disable) { return 0; }
 static inline void ibt_restore(u64 save) { }
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -852,16 +852,23 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+__noendbr bool is_endbr(u32 *val)
+{
+	u32 endbr;
+
+	if (get_kernel_nofault(endbr, val))
+		return false;
+
+	return __is_endbr(endbr);
+}
+
 static void poison_cfi(void *addr);
 
 static void __init_or_module poison_endbr(void *addr, bool warn)
 {
-	u32 endbr, poison = gen_endbr_poison();
-
-	if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
-		return;
+	u32 poison = gen_endbr_poison();
 
-	if (!is_endbr(endbr)) {
+	if (!is_endbr(addr)) {
 		WARN_ON_ONCE(warn);
 		return;
 	}
@@ -988,7 +995,7 @@ static u32  cfi_seed __ro_after_init;
 static u32 cfi_rehash(u32 hash)
 {
 	hash ^= cfi_seed;
-	while (unlikely(is_endbr(hash) || is_endbr(-hash))) {
+	while (unlikely(__is_endbr(hash) || __is_endbr(-hash))) {
 		bool lsb = hash & 1;
 		hash >>= 1;
 		if (lsb)
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -373,16 +373,7 @@ static bool can_probe(unsigned long padd
 kprobe_opcode_t *arch_adjust_kprobe_addr(unsigned long addr, unsigned long offset,
 					 bool *on_func_entry)
 {
-	u32 insn;
-
-	/*
-	 * Since 'addr' is not guaranteed to be safe to access, use
-	 * copy_from_kernel_nofault() to read the instruction:
-	 */
-	if (copy_from_kernel_nofault(&insn, (void *)addr, sizeof(u32)))
-		return NULL;
-
-	if (is_endbr(insn)) {
+	if (is_endbr((u32 *)addr)) {
 		*on_func_entry = !offset || offset == 4;
 		if (*on_func_entry)
 			offset = 4;
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -625,7 +625,7 @@ int bpf_arch_text_poke(void *ip, enum bp
 	 * See emit_prologue(), for IBT builds the trampoline hook is preceded
 	 * with an ENDBR instruction.
 	 */
-	if (is_endbr(*(u32 *)ip))
+	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
 	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
@@ -2971,7 +2971,7 @@ static int __arch_prepare_bpf_trampoline
 		/* skip patched call instruction and point orig_call to actual
 		 * body of the kernel function.
 		 */
-		if (is_endbr(*(u32 *)orig_call))
+		if (is_endbr(orig_call))
 			orig_call += ENDBR_INSN_SIZE;
 		orig_call += X86_PATCH_SIZE;
 	}
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1027,19 +1027,9 @@ static const struct bpf_func_proto bpf_g
 #ifdef CONFIG_X86_KERNEL_IBT
 static unsigned long get_entry_ip(unsigned long fentry_ip)
 {
-	u32 instr;
+	if (is_endbr((void *)(fentry_ip - ENDBR_INSN_SIZE)))
+		return fentry_ip - ENDBR_INSN_SIZE;
 
-	/* We want to be extra safe in case entry ip is on the page edge,
-	 * but otherwise we need to avoid get_kernel_nofault()'s overhead.
-	 */
-	if ((fentry_ip & ~PAGE_MASK) < ENDBR_INSN_SIZE) {
-		if (get_kernel_nofault(instr, (u32 *)(fentry_ip - ENDBR_INSN_SIZE)))
-			return fentry_ip;
-	} else {
-		instr = *(u32 *)(fentry_ip - ENDBR_INSN_SIZE);
-	}
-	if (is_endbr(instr))
-		fentry_ip -= ENDBR_INSN_SIZE;
 	return fentry_ip;
 }
 #else



