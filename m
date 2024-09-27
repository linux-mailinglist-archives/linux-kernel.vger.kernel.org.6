Return-Path: <linux-kernel+bounces-342142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF76988AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8EA285642
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E661C689A;
	Fri, 27 Sep 2024 19:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OMoaUILg"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFF01C3F3F
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466665; cv=none; b=Z/K3s3336UfM3IH8y+sXF4atk8/tUFufmobnGUs6m/AfmgfUnCY+Dr1jWZ04wPcoUhbMfOsDG198nc0gszZTMWNNS/ixx+e26t1QV7c0JzP6dzJv3wCz++578qi/J1rpAJ9nwDd/SIFCQogHiskIB89LlknKwhNyxfq47RlR7vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466665; c=relaxed/simple;
	bh=LQeE+d/8C5Kwujs85E9lBJI2GTyBoJtRrDx/j1NZMCw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KaLfT/gHZ+PMbhhl1dceKeO0fVJ0tm7XHTNg7Jw5cisKvQMoMAf53Vn/8iMyw3Pt7SsJlD4bQd1PyY2g3sBorgn4QAdqa0jo4yoxqRyS2gFmw/zx8gVU0thk9LSSR3mA4jZ1EuKVJzOe1uGLOSHNfbrOdsZNdHABLioK60tby1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OMoaUILg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=mM3DKa+Drporg9ZpHE6FFapZzeMpklgm+8jriIQrSHY=; b=OMoaUILgRAD8nwxugy76yojmhh
	xKLCr8DWVvzbggKxBemrkj4ZqbEA0U0TLl3ZRkoRqfMAZo+lKL4fjdxQFZsauPQewyavveGsLgeE3
	hIOWHa0jyIZnIJABV0fR3tHElMUsiHrXHpGt6eEW4gmLIhbrjt/mG/nKJoCUYCwgYuRNzHlIxP7oo
	rZibB8qIpU7Aorx6EG1/ez5jiOHSpHlLhM71JKQXnsQN+vhajLN/sjoWxfkY8fegeYu9jHqEyQdjU
	5NvqltzAJ5KjJ6wHf6jqNY8Bxoa1hAhTLxrBZi74oEKqwYwYIntXw0hnhXKc88uhGOyUmxIywjRJj
	CSPcQbIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzH-00000002Onw-2Ose;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CA7B3308CB6; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.283644921@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:05 +0200
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
Subject: [PATCH 09/14] x86/ibt: Implement IBT+
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

As originally conceived, use UD1 based poison to seal IBT. This is also fatal
on !IBT hardware.

This requires all direct (tail) calls avoid ever touching ENDBR. To that
purpose rewrite them using the .call_sites and .tail_call_sites sections from
objtool --direct-call.

Since this is a wee bit tricky, stick this in a 'def_bool y' config option.

This again stacks 3 layers of relocation, just like the earlier callthunk patch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |    4 +
 arch/x86/include/asm/alternative.h |    1 
 arch/x86/include/asm/cfi.h         |   14 ++---
 arch/x86/include/asm/ibt.h         |    9 +++
 arch/x86/kernel/alternative.c      |   89 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/module.c           |    9 +++
 arch/x86/kernel/static_call.c      |   23 ++++++++-
 arch/x86/net/bpf_jit_comp.c        |    6 ++
 scripts/Makefile.lib               |    1 
 tools/objtool/check.c              |    2 
 10 files changed, 144 insertions(+), 14 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1866,6 +1866,10 @@ config X86_KERNEL_IBT
 	  does significantly reduce the number of ENDBR instructions in the
 	  kernel image.
 
+config X86_KERNEL_IBT_PLUS
+	depends on X86_KERNEL_IBT
+	def_bool y
+
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Memory Protection Keys"
 	def_bool y
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -98,6 +98,7 @@ extern struct alt_instr __alt_instructio
 extern int alternatives_patched;
 
 extern void alternative_instructions(void);
+extern void apply_direct_call_offset(s32 *start, s32 *end);
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 extern void apply_retpolines(s32 *start, s32 *end);
 extern void apply_returns(s32 *start, s32 *end);
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -31,12 +31,12 @@
  * IBT:
  *
  * foo:
- *   endbr64
+ *   endbr64 / osp nop3 / ud1 0x0(%eax), %edx
  *   ... code here ...
  *   ret
  *
  * direct caller:
- *   call foo / call foo+4
+ *   call foo / call foo+4	# must be +4 when IBT+
  *
  * indirect caller:
  *   lea foo(%rip), %r11
@@ -50,12 +50,12 @@
  *   movl $0x12345678, %eax
  *				# 11 nops when CONFIG_CALL_PADDING
  * foo:
- *   endbr64			# when IBT
+ *   endbr64 / osp nop3 / ud1	# when IBT
  *   ... code here ...
  *   ret
  *
  * direct call:
- *   call foo			# / call foo+4 when IBT
+ *   call foo / call foo+4	# +4 possible with IBT, mandatory with IBT+
  *
  * indirect call:
  *   lea foo(%rip), %r11
@@ -72,16 +72,16 @@
  * __cfi_foo:
  *   endbr64
  *   subl 0x12345678, %r10d
- *   jz   foo
+ *   jz   foo+4
  *   ud2
  *   nop
  * foo:
- *   osp nop3			# was endbr64
+ *   osp nop3 / ud1 0x0(%eax), %edx	# was endbr64
  *   ... code here ...
  *   ret
  *
  * direct caller:
- *   call foo / call foo+4
+ *   call foo / call foo+4	# must be +4 when IBT+
  *
  * indirect caller:
  *   lea foo(%rip), %r11
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -58,11 +58,20 @@ static __always_inline __attribute_const
 
 static __always_inline __attribute_const__ u32 gen_endbr_poison(void)
 {
+#ifdef CONFIG_X86_KERNEL_IBT_PLUS
+	/*
+	 * When we rewrite direct calls to +4, the endbr at +0 becomes unused,
+	 * poisong it with a UD1 to trip !IBT hardware and to ensure these
+	 * bytes are really unused.
+	 */
+	return 0x0048b90f; /* ud1 0x0(%eax), %edx */
+#else
 	/*
 	 * 4 byte NOP that isn't NOP4 (in fact it is OSP NOP3), such that it
 	 * will be unique to (former) ENDBR sites.
 	 */
 	return 0x001f0f66; /* osp nopl (%rax) */
+#endif
 }
 
 static inline bool __is_endbr(u32 val)
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -171,6 +171,8 @@ static void add_nop(u8 *buf, unsigned in
 		*buf = INT3_INSN_OPCODE;
 }
 
+extern s32 __call_sites[], __call_sites_end[];
+extern s32 __tail_call_sites[], __tail_call_sites_end[];
 extern s32 __retpoline_sites[], __retpoline_sites_end[];
 extern s32 __return_sites[], __return_sites_end[];
 extern s32 __cfi_sites[], __cfi_sites_end[];
@@ -423,6 +425,19 @@ static int alt_replace_call(u8 *instr, u
 	if (!target)
 		target = bug;
 
+#ifdef CONFIG_X86_KERNEL_IBT_PLUS
+	/*
+	 * apply_direct_call_offset() would have patched the alternative to
+	 * "CALL BUG_func+4" *if* that function has an ENDBR. And *if* target
+	 * also has an ENDBR this all works out. Except if BUG_func() and target()
+	 * do not agree on the having of ENDBR, then things go sideways.
+	 */
+	if (is_endbr(bug))
+		bug += ENDBR_INSN_SIZE;
+	if (is_endbr(target))
+		target += ENDBR_INSN_SIZE;
+#endif
+
 	/* (BUG_func - .) + (target - BUG_func) := target - . */
 	*(s32 *)(insn_buff + 1) += target - bug;
 
@@ -850,6 +865,64 @@ void __init_or_module noinline apply_ret
 
 #endif /* CONFIG_MITIGATION_RETPOLINE && CONFIG_OBJTOOL */
 
+#ifdef CONFIG_X86_KERNEL_IBT_PLUS
+__init_or_module void apply_direct_call_offset(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	/*
+	 * incompatible with call depth tracking
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH))
+		return;
+
+	for (s = start; s < end; s++) {
+		void *dest, *addr = (void *)s + *s;
+		struct insn insn;
+		int ret;
+
+		ret = insn_decode_kernel(&insn, addr);
+		if (WARN_ON_ONCE(ret < 0))
+			continue;
+
+		dest = addr + insn.length + insn.immediate.value;
+		if (!is_endbr(dest))
+			continue;
+
+		switch (insn.opcode.bytes[0]) {
+		case CALL_INSN_OPCODE:
+		case JMP32_INSN_OPCODE:
+			apply_reloc(4, addr+1, 4);
+			continue;
+
+		case JMP8_INSN_OPCODE:
+		case 0x70 ... 0x7f: /* Jcc.d8 */
+			apply_reloc(1, addr+1, 4);
+			continue;
+
+		case 0x0f:
+			switch (insn.opcode.bytes[1]) {
+			case 0x80 ... 0x8f:
+				apply_reloc(4, addr+2, 4);
+				continue;
+
+			default:
+				break;
+			}
+			break;
+
+		default:
+			break;
+		}
+
+		printk("at: %pS, instruction: %*ph\n", addr, insn.length, addr);
+		BUG();
+	}
+}
+#else
+__init_or_module void apply_direct_call_offset(s32 *start, s32 *end) { }
+#endif
+
 #ifdef CONFIG_X86_KERNEL_IBT
 
 __noendbr bool is_endbr(u32 *val)
@@ -1067,6 +1140,7 @@ asm(	".pushsection .rodata			\n"
 	"fineibt_preamble_start:		\n"
 	"	endbr64				\n"
 	"	subl	$0x12345678, %r10d	\n"
+	"fineibt_preamble_jcc:			\n"
 	"	je	fineibt_preamble_end	\n"
 	"	ud2				\n"
 	"	nop				\n"
@@ -1075,10 +1149,13 @@ asm(	".pushsection .rodata			\n"
 );
 
 extern u8 fineibt_preamble_start[];
+extern u8 fineibt_preamble_jcc[];
 extern u8 fineibt_preamble_end[];
 
-#define fineibt_preamble_size (fineibt_preamble_end - fineibt_preamble_start)
-#define fineibt_preamble_hash 7
+#define fineibt_preamble_size	(fineibt_preamble_end - fineibt_preamble_start)
+#define fineibt_preamble_offset	(fineibt_preamble_jcc - fineibt_preamble_start)
+#define fineibt_preamble_hash	(fineibt_preamble_offset - 4)
+#define fineibt_preamble_jccd8	(fineibt_preamble_offset + 1)
 
 asm(	".pushsection .rodata			\n"
 	"fineibt_caller_start:			\n"
@@ -1217,6 +1294,8 @@ static int cfi_rewrite_preamble(s32 *sta
 		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
 		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
 		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
+
+		*(u8 *)(addr + fineibt_preamble_jccd8) += 4;
 	}
 
 	return 0;
@@ -1726,6 +1805,12 @@ void __init alternative_instructions(voi
 	 */
 	paravirt_set_cap();
 
+	/*
+	 * Adjust all (tail) calls to func()+4 to avoid ENDBR.
+	 */
+	apply_direct_call_offset(__call_sites, __call_sites_end);
+	apply_direct_call_offset(__tail_call_sites, __tail_call_sites_end);
+
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
 			__cfi_sites, __cfi_sites_end, true);
 
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -227,7 +227,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	const Elf_Shdr *s, *alt = NULL, *locks = NULL,
 		*orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
-		*calls = NULL, *cfi = NULL;
+		*calls = NULL, *tails = NULL, *cfi = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
@@ -245,6 +245,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 			returns = s;
 		if (!strcmp(".call_sites", secstrings + s->sh_name))
 			calls = s;
+		if (!strcmp(".tail_call_sites", secstrings + s->sh_name))
+			tails = s;
 		if (!strcmp(".cfi_sites", secstrings + s->sh_name))
 			cfi = s;
 		if (!strcmp(".ibt_endbr_seal", secstrings + s->sh_name))
@@ -284,6 +286,11 @@ int module_finalize(const Elf_Ehdr *hdr,
 		}
 
 		callthunks_patch_module_calls(&cs, me);
+		apply_direct_call_offset(cs.call_start, cs.call_end);
+	}
+	if (tails) {
+		void *tseg = (void *)tails->sh_addr;
+		apply_direct_call_offset(tseg, tseg + tails->sh_size);
 	}
 	if (alt) {
 		/* patch .altinstructions */
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -50,6 +50,23 @@ asm (".global __static_call_return\n\t"
      "ret; int3\n\t"
      ".size __static_call_return, . - __static_call_return \n\t");
 
+static void *translate_call_dest(void *dest, bool call)
+{
+	if (cpu_feature_enabled(X86_FEATURE_CALL_DEPTH)) {
+		if (!call)
+			return dest;
+
+		return callthunks_translate_call_dest(dest);
+	}
+
+	if (IS_ENABLED(CONFIG_X86_KERNEL_IBT_PLUS)) {
+		if (is_endbr(dest))
+			dest += 4;
+	}
+
+	return dest;
+}
+
 static void __ref __static_call_transform(void *insn, enum insn_type type,
 					  void *func, bool modinit)
 {
@@ -63,7 +80,7 @@ static void __ref __static_call_transfor
 
 	switch (type) {
 	case CALL:
-		func = callthunks_translate_call_dest(func);
+		func = translate_call_dest(func, true);
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
 		if (func == &__static_call_return0) {
 			emulate = code;
@@ -77,6 +94,7 @@ static void __ref __static_call_transfor
 		break;
 
 	case JMP:
+		func = translate_call_dest(func, false);
 		code = text_gen_insn(JMP32_INSN_OPCODE, insn, func);
 		break;
 
@@ -92,7 +110,8 @@ static void __ref __static_call_transfor
 			func = __static_call_return;
 			if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
 				func = x86_return_thunk;
-		}
+
+		} else func = translate_call_dest(func, false);
 
 		buf[0] = 0x0f;
 		__text_gen_insn(buf+1, op, insn+1, func, 5);
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -555,6 +555,8 @@ static int emit_patch(u8 **pprog, void *
 
 static int emit_call(u8 **pprog, void *func, void *ip)
 {
+	if (is_endbr(func))
+		func += ENDBR_INSN_SIZE;
 	return emit_patch(pprog, func, ip, 0xE8);
 }
 
@@ -562,11 +564,13 @@ static int emit_rsb_call(u8 **pprog, voi
 {
 	OPTIMIZER_HIDE_VAR(func);
 	ip += x86_call_depth_emit_accounting(pprog, func, ip);
-	return emit_patch(pprog, func, ip, 0xE8);
+	return emit_call(pprog, func, ip);
 }
 
 static int emit_jump(u8 **pprog, void *func, void *ip)
 {
+	if (is_endbr(func))
+		func += ENDBR_INSN_SIZE;
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -269,6 +269,7 @@ objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HA
 objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
 objtool-args-$(CONFIG_MITIGATION_CALL_DEPTH_TRACKING)	+= --direct-call
 objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
+objtool-args-$(CONFIG_X86_KERNEL_IBT_PLUS)		+= --direct-call
 objtool-args-$(CONFIG_FINEIBT)				+= --cfi
 objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
 ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1455,7 +1455,7 @@ static void annotate_call_site(struct ob
 		return;
 	}
 
-	if (!insn->sec->init && !insn->_call_dest->embedded_insn) {
+	if (!insn->_call_dest->embedded_insn) {
 		if (insn->type == INSN_CALL)
 			list_add_tail(&insn->call_node, &file->call_list);
 		else



