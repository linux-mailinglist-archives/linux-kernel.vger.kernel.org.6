Return-Path: <linux-kernel+bounces-574489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EDFA6E5F5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427CA173257
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B081EFF95;
	Mon, 24 Mar 2025 21:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZpw+BNu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91521EE7AD
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853383; cv=none; b=O3FZTvAPJ8ElZ1PIKddfWSflQPt3YoO+FkNOw9K48v86Qjnti1tV4knZcSFhgAgLegPeNu00Sn5g4tBYDeXgtqsqOPPQJVeBxXa1iGg/VKZCscp6OBiOuovcLP0hTCxOeV/0gFtjaJKq8Lo4KYDUQfC2RGBdUnvP1zwsQHI04Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853383; c=relaxed/simple;
	bh=oKg4PMp9YXn1Ng8aPqaH+AE4nP+pk0Yy0+LvRr0vDWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQVQiTmgzdtbVxfMM1XkNEFZphJ0rfgRoMdQQP5jC9udPy5/VS5II4ME02fabZjImmPkg89vMZ+Xsl+xKLgpTmdXI12EyIsFytyRsW8RCEu6dJ+MbjUdcBKHSO3pcZqTieW/XFDo79vIs8UjKr/Uk3PzMqsPJ7RTprDN15JPbDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZpw+BNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA62C4CEE4;
	Mon, 24 Mar 2025 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853383;
	bh=oKg4PMp9YXn1Ng8aPqaH+AE4nP+pk0Yy0+LvRr0vDWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZpw+BNu+o6hCS8+d1ZnVk76hdtzoZ7P2y6rz+SoLVNJmC1LKQQz0tmfOrzYxRT0r
	 BBBcDb2sn4pvYh+ytPrmLTCnyk6lCjWYPgVa58v9YlY5EJdr5DRYxWXDLxCzcU3s0J
	 wUiw4qDRFHlqNEVnuf6ITY4wir5/v9nTkwj9kz9c6Fv9HLSF3Nai8O4v9kKeSZM0Or
	 WSdzm8MYuGc+XKROcG6LMb3H8VuHyGZA+sJ8YNgA+ytCvUpRzTeuEkfqWv9yTTI92u
	 KeRG8Ym+Mf/0F/u7z0bFAXtjNpMj90K+zIgXCcGTKlaa4Qf6GSS0pG16ZD1qDDxXEZ
	 KLh8te6ihMjeg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 04/22] objtool: Fix X86_FEATURE_SMAP alternative handling
Date: Mon, 24 Mar 2025 14:55:54 -0700
Message-ID: <de0621ca242130156a55d5d74fed86994dfa4c9c.1742852846.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For X86_FEATURE_SMAP alternatives which replace NOP with STAC or CLAC,
uaccess validation skips the NOP branch to avoid following impossible
code paths, e.g. where a STAC would be patched but a CLAC wouldn't.

However, it's not safe to assume an X86_FEATURE_SMAP alternative is
patching STAC/CLAC.  There can be other alternatives, like
static_cpu_has(), where both branches need to be validated.

Fix that by repurposing ANNOTATE_IGNORE_ALTERNATIVE for skipping either
original instructions or new ones.  This is a more generic approach
which enables the removal of the feature checking hacks and the
insn->ignore bit.

Fixes the following warnings:

  arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x8ec: __stack_chk_fail() missing __noreturn in .c/.h or NORETURN() in noreturns.h
  arch/x86/mm/fault.o: warning: objtool: do_user_addr_fault+0x8f1: unreachable instruction

Fixes: ea24213d8088 ("objtool: Add UACCESS validation")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503181736.zkZUBv4N-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/arch_hweight.h     |  8 +++--
 arch/x86/include/asm/smap.h             | 23 ++++++++++-----
 arch/x86/include/asm/xen/hypercall.h    |  6 ++--
 tools/objtool/arch/x86/special.c        | 33 +--------------------
 tools/objtool/check.c                   | 39 +++++++------------------
 tools/objtool/include/objtool/check.h   |  3 +-
 tools/objtool/include/objtool/special.h |  4 +--
 tools/objtool/special.c                 | 12 ++------
 8 files changed, 39 insertions(+), 89 deletions(-)

diff --git a/arch/x86/include/asm/arch_hweight.h b/arch/x86/include/asm/arch_hweight.h
index ba88edd0d58b..a0eaa8fda55f 100644
--- a/arch/x86/include/asm/arch_hweight.h
+++ b/arch/x86/include/asm/arch_hweight.h
@@ -16,7 +16,9 @@ static __always_inline unsigned int __arch_hweight32(unsigned int w)
 {
 	unsigned int res;
 
-	asm (ALTERNATIVE("call __sw_hweight32", "popcntl %1, %0", X86_FEATURE_POPCNT)
+	asm (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+			 "call __sw_hweight32",
+			 "popcntl %1, %0", X86_FEATURE_POPCNT)
 			 : "="REG_OUT (res)
 			 : REG_IN (w));
 
@@ -44,7 +46,9 @@ static __always_inline unsigned long __arch_hweight64(__u64 w)
 {
 	unsigned long res;
 
-	asm (ALTERNATIVE("call __sw_hweight64", "popcntq %1, %0", X86_FEATURE_POPCNT)
+	asm (ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+			 "call __sw_hweight64",
+			 "popcntq %1, %0", X86_FEATURE_POPCNT)
 			 : "="REG_OUT (res)
 			 : REG_IN (w));
 
diff --git a/arch/x86/include/asm/smap.h b/arch/x86/include/asm/smap.h
index 2de1e5a75c57..a984cdd6de30 100644
--- a/arch/x86/include/asm/smap.h
+++ b/arch/x86/include/asm/smap.h
@@ -16,23 +16,23 @@
 #ifdef __ASSEMBLY__
 
 #define ASM_CLAC \
-	ALTERNATIVE "", "clac", X86_FEATURE_SMAP
+	ALTERNATIVE __stringify(ANNOTATE_IGNORE_ALTERNATIVE), "clac", X86_FEATURE_SMAP
 
 #define ASM_STAC \
-	ALTERNATIVE "", "stac", X86_FEATURE_SMAP
+	ALTERNATIVE __stringify(ANNOTATE_IGNORE_ALTERNATIVE), "stac", X86_FEATURE_SMAP
 
 #else /* __ASSEMBLY__ */
 
 static __always_inline void clac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative("", "clac", X86_FEATURE_SMAP);
+	alternative(ANNOTATE_IGNORE_ALTERNATIVE "", "clac", X86_FEATURE_SMAP);
 }
 
 static __always_inline void stac(void)
 {
 	/* Note: a barrier is implicit in alternative() */
-	alternative("", "stac", X86_FEATURE_SMAP);
+	alternative(ANNOTATE_IGNORE_ALTERNATIVE "", "stac", X86_FEATURE_SMAP);
 }
 
 static __always_inline unsigned long smap_save(void)
@@ -40,7 +40,8 @@ static __always_inline unsigned long smap_save(void)
 	unsigned long flags;
 
 	asm volatile ("# smap_save\n\t"
-		      ALTERNATIVE("", "pushf; pop %0; " "clac" "\n\t",
+		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+				  "", "pushf; pop %0; clac",
 				  X86_FEATURE_SMAP)
 		      : "=rm" (flags) : : "memory", "cc");
 
@@ -50,16 +51,22 @@ static __always_inline unsigned long smap_save(void)
 static __always_inline void smap_restore(unsigned long flags)
 {
 	asm volatile ("# smap_restore\n\t"
-		      ALTERNATIVE("", "push %0; popf\n\t",
+		      ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE
+				  "", "push %0; popf",
 				  X86_FEATURE_SMAP)
 		      : : "g" (flags) : "memory", "cc");
 }
 
 /* These macros can be used in asm() statements */
 #define ASM_CLAC \
-	ALTERNATIVE("", "clac", X86_FEATURE_SMAP)
+	ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "", "clac", X86_FEATURE_SMAP)
 #define ASM_STAC \
-	ALTERNATIVE("", "stac", X86_FEATURE_SMAP)
+	ALTERNATIVE(ANNOTATE_IGNORE_ALTERNATIVE "", "stac", X86_FEATURE_SMAP)
+
+#define ASM_CLAC_UNSAFE \
+	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "clac", X86_FEATURE_SMAP)
+#define ASM_STAC_UNSAFE \
+	ALTERNATIVE("", ANNOTATE_IGNORE_ALTERNATIVE "stac", X86_FEATURE_SMAP)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9d33af..59a62c3780a2 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -231,14 +231,12 @@ static __always_inline void __xen_stac(void)
 	 * Suppress objtool seeing the STAC/CLAC and getting confused about it
 	 * calling random code with AC=1.
 	 */
-	asm volatile(ANNOTATE_IGNORE_ALTERNATIVE
-		     ASM_STAC ::: "memory", "flags");
+	asm volatile(ASM_STAC_UNSAFE ::: "memory", "flags");
 }
 
 static __always_inline void __xen_clac(void)
 {
-	asm volatile(ANNOTATE_IGNORE_ALTERNATIVE
-		     ASM_CLAC ::: "memory", "flags");
+	asm volatile(ASM_CLAC_UNSAFE ::: "memory", "flags");
 }
 
 static inline long
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 5f46d4e7f7f8..403e587676f1 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -5,10 +5,7 @@
 #include <objtool/builtin.h>
 #include <objtool/warn.h>
 
-#define X86_FEATURE_POPCNT (4 * 32 + 23)
-#define X86_FEATURE_SMAP   (9 * 32 + 20)
-
-void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+void arch_handle_alternative(struct special_alt *alt)
 {
 	static struct special_alt *group, *prev;
 
@@ -32,34 +29,6 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 	} else group = alt;
 
 	prev = alt;
-
-	switch (feature) {
-	case X86_FEATURE_SMAP:
-		/*
-		 * If UACCESS validation is enabled; force that alternative;
-		 * otherwise force it the other way.
-		 *
-		 * What we want to avoid is having both the original and the
-		 * alternative code flow at the same time, in that case we can
-		 * find paths that see the STAC but take the NOP instead of
-		 * CLAC and the other way around.
-		 */
-		if (opts.uaccess)
-			alt->skip_orig = true;
-		else
-			alt->skip_alt = true;
-		break;
-	case X86_FEATURE_POPCNT:
-		/*
-		 * It has been requested that we don't validate the !POPCNT
-		 * feature path which is a "very very small percentage of
-		 * machines".
-		 */
-		alt->skip_orig = true;
-		break;
-	default:
-		break;
-	}
 }
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8e2f3405d78c..bac88ca82dec 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -25,7 +25,6 @@
 struct alternative {
 	struct alternative *next;
 	struct instruction *insn;
-	bool skip_orig;
 };
 
 static unsigned long nr_cfi, nr_cfi_reused, nr_cfi_cache;
@@ -1704,6 +1703,7 @@ static int handle_group_alt(struct objtool_file *file,
 		orig_alt_group->first_insn = orig_insn;
 		orig_alt_group->last_insn = last_orig_insn;
 		orig_alt_group->nop = NULL;
+		orig_alt_group->ignore = orig_insn->ignore_alts;
 	} else {
 		if (orig_alt_group->last_insn->offset + orig_alt_group->last_insn->len -
 		    orig_alt_group->first_insn->offset != special_alt->orig_len) {
@@ -1743,7 +1743,6 @@ static int handle_group_alt(struct objtool_file *file,
 		nop->type = INSN_NOP;
 		nop->sym = orig_insn->sym;
 		nop->alt_group = new_alt_group;
-		nop->ignore = orig_insn->ignore_alts;
 	}
 
 	if (!special_alt->new_len) {
@@ -1760,7 +1759,6 @@ static int handle_group_alt(struct objtool_file *file,
 
 		last_new_insn = insn;
 
-		insn->ignore = orig_insn->ignore_alts;
 		insn->sym = orig_insn->sym;
 		insn->alt_group = new_alt_group;
 
@@ -1807,6 +1805,7 @@ static int handle_group_alt(struct objtool_file *file,
 	new_alt_group->first_insn = *new_insn;
 	new_alt_group->last_insn = last_new_insn;
 	new_alt_group->nop = nop;
+	new_alt_group->ignore = (*new_insn)->ignore_alts;
 	new_alt_group->cfi = orig_alt_group->cfi;
 	return 0;
 }
@@ -1924,8 +1923,6 @@ static int add_special_section_alts(struct objtool_file *file)
 		}
 
 		alt->insn = new_insn;
-		alt->skip_orig = special_alt->skip_orig;
-		orig_insn->ignore_alts |= special_alt->skip_alt;
 		alt->next = orig_insn->alts;
 		orig_insn->alts = alt;
 
@@ -2303,6 +2300,8 @@ static int read_annotate(struct objtool_file *file,
 static int __annotate_early(struct objtool_file *file, int type, struct instruction *insn)
 {
 	switch (type) {
+
+	/* Must be before add_special_section_alts() */
 	case ANNOTYPE_IGNORE_ALTS:
 		insn->ignore_alts = true;
 		break;
@@ -3496,11 +3495,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			return 1;
 		}
 
-		if (func && insn->ignore) {
-			WARN_INSN(insn, "BUG: why am I validating an ignored function?");
-			return 1;
-		}
-
 		visited = VISITED_BRANCH << state.uaccess;
 		if (insn->visited & VISITED_BRANCH_MASK) {
 			if (!insn->hint && !insn_cfi_match(insn, &state.cfi))
@@ -3572,24 +3566,19 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (propagate_alt_cfi(file, insn))
 			return 1;
 
-		if (!insn->ignore_alts && insn->alts) {
-			bool skip_orig = false;
-
+		if (insn->alts) {
 			for (alt = insn->alts; alt; alt = alt->next) {
-				if (alt->skip_orig)
-					skip_orig = true;
-
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
 					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
-
-			if (skip_orig)
-				return 0;
 		}
 
+		if (insn->alt_group && insn->alt_group->ignore)
+			return 0;
+
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
@@ -3776,23 +3765,15 @@ static int validate_unret(struct objtool_file *file, struct instruction *insn)
 
 		insn->visited |= VISITED_UNRET;
 
-		if (!insn->ignore_alts && insn->alts) {
+		if (insn->alts) {
 			struct alternative *alt;
-			bool skip_orig = false;
-
 			for (alt = insn->alts; alt; alt = alt->next) {
-				if (alt->skip_orig)
-					skip_orig = true;
-
 				ret = validate_unret(file, alt->insn);
 				if (ret) {
 					BT_INSN(insn, "(alt)");
 					return ret;
 				}
 			}
-
-			if (skip_orig)
-				return 0;
 		}
 
 		switch (insn->type) {
@@ -3943,7 +3924,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	struct instruction *prev_insn;
 	int i;
 
-	if (insn->ignore || insn->type == INSN_NOP || insn->type == INSN_TRAP || (func && func->ignore))
+	if (insn->type == INSN_NOP || insn->type == INSN_TRAP || (func && func->ignore))
 		return true;
 
 	/*
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index e1cd13cd28a3..00fb745e7233 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -34,6 +34,8 @@ struct alt_group {
 	 * This is shared with the other alt_groups in the same alternative.
 	 */
 	struct cfi_state **cfi;
+
+	bool ignore;
 };
 
 #define INSN_CHUNK_BITS		8
@@ -54,7 +56,6 @@ struct instruction {
 
 	u32 idx			: INSN_CHUNK_BITS,
 	    dead_end		: 1,
-	    ignore		: 1,
 	    ignore_alts		: 1,
 	    hint		: 1,
 	    save		: 1,
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e049679bb17b..72d09c0adf1a 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -16,8 +16,6 @@ struct special_alt {
 	struct list_head list;
 
 	bool group;
-	bool skip_orig;
-	bool skip_alt;
 	bool jump_or_nop;
 	u8 key_addend;
 
@@ -32,7 +30,7 @@ struct special_alt {
 
 int special_get_alts(struct elf *elf, struct list_head *alts);
 
-void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
+void arch_handle_alternative(struct special_alt *alt);
 
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 097a69db82a0..6cd7b1be5331 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -54,7 +54,7 @@ static const struct special_entry entries[] = {
 	{},
 };
 
-void __weak arch_handle_alternative(unsigned short feature, struct special_alt *alt)
+void __weak arch_handle_alternative(struct special_alt *alt)
 {
 }
 
@@ -92,15 +92,7 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 
 	reloc_to_sec_off(orig_reloc, &alt->orig_sec, &alt->orig_off);
 
-	if (entry->feature) {
-		unsigned short feature;
-
-		feature = bswap_if_needed(elf,
-					  *(unsigned short *)(sec->data->d_buf +
-							      offset +
-							      entry->feature));
-		arch_handle_alternative(feature, alt);
-	}
+	arch_handle_alternative(alt);
 
 	if (!entry->group || alt->new_len) {
 		new_reloc = find_reloc_by_dest(elf, sec, offset + entry->new);
-- 
2.48.1


