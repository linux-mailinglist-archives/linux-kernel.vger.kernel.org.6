Return-Path: <linux-kernel+bounces-396361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E75C9BCC21
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2484B21997
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBE41D54F7;
	Tue,  5 Nov 2024 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4N8yrcN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D61D47BB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807273; cv=none; b=rMpwMNFl+lLmUBOa9IiHeJbLbUCbCv9izy4y9BuvXOwYkiJXgOJfIusy2pxBoZslb1g4pVmOv/BFNAJYhDP7dtxmTvlr6hy+11aKge+Ocdi42HoPlSM72bkeWHhca2atsA2to2P/3mRhafzrJs93NsSQY/W7iuZMkLhi9AyjY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807273; c=relaxed/simple;
	bh=i7gFE+znCSf4z6/z37OXu8XImOO5k5+Va5+A9jBrxdY=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=K1TfBknEAoof+G3f6gUtMiuW+b1/znOmyq637LF1LN6Cjw11xqdA1KQ4xpqxMnT9ZoS5Ch0v49ayXFitNa6k1ybrGUd1tH21B1OUf+nab9PIr9FFUatlT1PRznzAGh9WitOGZrjCLime53N23hXx+auq+bXPZUAI/x/Gxa0eVfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i4N8yrcN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=3o7t3O7fUXIkmp/wzDZzl8w3wuT+Vx4nYWMPZM5XCCg=; b=i4N8yrcN7lIMFndH48y6VKEocW
	8XckZ0ojuxEJ2pl4JfzxS3ISnFnEhmrKvpsd3e3B5YPeK5Mg6mh6wo1G7TzEYASDhAD5N4op1eY5d
	3b33Ff0KdgPhaEUwtb8EK0BD60arlBRsrySsUd7ZPKnNSUiwmzrw4KVQmaZEQ9ksLyfijzlE+AwrJ
	F/tju0TBO2EL0UQ7igv0Flwae7p1i199sry3I1qYIN3BI8e8LwoyFodoHiZIHVjhyYDKUmvxdQNei
	VabsLeo1s/ZJE449Tx7+rqCTkD4j1gGYI+NI/lakYXw3i9a3ZMGn+K6KfZMpG8uWKJIynQS2bkTWO
	sASNPKHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2F-0000000Bjjt-0DOh;
	Tue, 05 Nov 2024 11:47:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id F08CF300DDC; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114522.395526267@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:07 +0100
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
 kees@kernel.org,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 6/8] x86/ibt: Clean up is_endbr()
References: <20241105113901.348320374@infradead.org>
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 arch/x86/events/core.c         |    2 +-
 arch/x86/include/asm/ibt.h     |    5 +++--
 arch/x86/kernel/alternative.c  |   20 ++++++++++++++------
 arch/x86/kernel/kprobes/core.c |   11 +----------
 arch/x86/net/bpf_jit_comp.c    |    4 ++--
 kernel/trace/bpf_trace.c       |   14 ++------------
 6 files changed, 23 insertions(+), 33 deletions(-)

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
@@ -852,16 +852,24 @@ void __init_or_module noinline apply_ret
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
+__noendbr bool is_endbr(u32 *val)
+{
+	u32 endbr;
+
+	__get_kernel_nofault(&endbr, val, u32, Efault);
+	return __is_endbr(endbr);
+
+Efault:
+	return false;
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
@@ -988,7 +996,7 @@ static u32  cfi_seed __ro_after_init;
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



