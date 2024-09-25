Return-Path: <linux-kernel+bounces-339301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E62A98628C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8206E1C261C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A337818DF65;
	Wed, 25 Sep 2024 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gj5dJdjV"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2818C358
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276538; cv=none; b=iPY5jJ3OJt8j1MTLdbdoWSMUpXm9GcIJgwP2Yi8A4bcsmxhsiWWaWQg+ftw3YglGxTtDzMgnFkpovzCan0H7a5zz++NxsaYI8uybq/3VOTzSFNHcS6q8DwvMRuBfv+DGEojko4bH6Uh/X4tmcC5D4Z8hMsxFS/5Je7bL6DEVDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276538; c=relaxed/simple;
	bh=YEhtCMnlAL7XzGF/XPf7I5bMm2iUu7a6ID53CAvxp54=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sFInatoePElTFOUy3nMRSqiDwnnXa4SX0B/aRjont7/VQprAHMhdySy+a3IvOAioSlQCzaZ88KIA1N2vrlDoTOa8E/r8RITpj20qii/+KIQfGpn4vK/Hv+nxe+UGRyz44eEXo+0+Uhv88RFfp48NZ9lam1ez8ZPI8cnTVF6/tmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gj5dJdjV; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso52454055e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276533; x=1727881333; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lbdYNYYjAy1sBuzi5nxjXTZJl29neWIaYfW2XPgVAg0=;
        b=Gj5dJdjVsPjXxyOtWycvi8g71uQt/m9D48QHQP9xImYEkU3ClzH3UEAjj1k4wAZ3Ut
         2W1hhqYUsGvPkCUiigrOhNz5HSo6qSnzJQ0nDKGtAmUob6SpDEMh9Z//MfzuL4iNTDIk
         d6flNQoX/2WMTm3Lvn7x7djDhT4r+jQia3PjRbtC+BFoxPrdLIx4pIeYBUNV3vFhiJ0E
         TBGLVwaG7Vb1lBu+ZOXzoGxyA+ZpZeKDwt3/RhToS981eJputQUogR69DbmrtNYVbN+a
         umFvtrqbCgnJrItX0sDaQ2Oz617qud9Inv9aG6kfDoKyWGK4g2M+KRBn52+WvQFqECdV
         3NbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276533; x=1727881333;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbdYNYYjAy1sBuzi5nxjXTZJl29neWIaYfW2XPgVAg0=;
        b=atmvP3WbF2aqFHEsvyVXiBdp7oIZIVYnTlORp9LoYofwJfnv89IA3Ec0uTC2RU8+GO
         XA6P39+Qa5ULyFKbG4A7b4CbQJtRk/SvuJsuRtncriXKMzrlMey+ddVS3pEwx1D0QXfM
         jzKPgWWcSKC0Tie+0xh8+CBBQC6ZJ4rApDdgJnAEIAMrQC6XWyQK3Hqskdp6ErqBDDVq
         AzgrzANPO7evRGCxVHiohWbqmyWRR1Y5T9cs/Wy8tXtzVJatumcbw3O+cY79EjiqOsl0
         5YO5dp9RAy+9zxOh5JeslaPmgB7LpXRc0/A4Y26m7OXlcNaPC2HZnwIc8HnNH8omSoMe
         slWg==
X-Gm-Message-State: AOJu0YwNFdsGbQiRjFbBXfFte/eu8LvLo4qpR+5eZBUejHCvK7E74y8X
	phhX4qye50Js6j3C59bkD/bmX7YH6ll/BatkfEH2rcfpM9xdFydsVHYm/HQcx7NZrW8ltrVKi23
	GhWDiz+f/zk5p0B5ym0FSCyQotz7nYQKBbizs7yt41a8ItII1bVVCPT885LOuVmGxo4YFTTfAaR
	uBb+L8Aj9Q82DzKL0WVKgsfSsVWzlX8A==
X-Google-Smtp-Source: AGHT+IFnkqBxjgA6y6VoEKdvu8v/U0MfKMiOBhmPl2wzAg6akAfpHBzng9kRstyeb7SA5yNN5ghxNG0E
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:5709:b0:42c:a879:3d0f with SMTP id
 5b1f17b1804b1-42e960af3c0mr226155e9.0.1727276532377; Wed, 25 Sep 2024
 08:02:12 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:09 +0200
In-Reply-To: <20240925150059.3955569-30-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925150059.3955569-30-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=8267; i=ardb@kernel.org;
 h=from:subject; bh=shvywZQQiQz7Xv2EgZXJycFhGuSPaFO7HVAh5zMbRYk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6o42nf3njrQ8av3JMd/3S06Rasbd1hMzGC0+MS4UY
 uxSiOjvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABP5Jcbwz0iltm/h1Ke2pf/a
 nXTOnbRVCO637fRRuzetQ4Xl5cn2bIb/Lutep90WfOBcvpZFhO10i1thpKiD2UTd0wxh9l82pHa zAAA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-39-ardb+git@google.com>
Subject: [RFC PATCH 09/28] x86/tools: Remove special relocation handling for
 per-CPU variables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Due to the placement of per-CPU variables in a special, 0x0 based
disjoint memory segment in the ELF binary, the KASLR relocation tool
needed to perform special processing for references to such variables,
as they were not affected by KASLR displacement.

This meant that absolute references could be ignored, and RIP-relative
references had to be compensated for KASLR, by applying the same offset
but negated.

None of this is necessary any longer, so remove this handling from the
relocation host tool.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c |  14 +--
 arch/x86/tools/relocs.c         | 130 +-------------------
 2 files changed, 2 insertions(+), 142 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 04a35b2c26e9..89f01375cdb7 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -235,7 +235,7 @@ static void handle_relocations(void *output, unsigned long output_len,
 
 	/*
 	 * Process relocations: 32 bit relocations first then 64 bit after.
-	 * Three sets of binary relocations are added to the end of the kernel
+	 * Two sets of binary relocations are added to the end of the kernel
 	 * before compression. Each relocation table entry is the kernel
 	 * address of the location which needs to be updated stored as a
 	 * 32-bit value which is sign extended to 64 bits.
@@ -245,8 +245,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 	 * kernel bits...
 	 * 0 - zero terminator for 64 bit relocations
 	 * 64 bit relocation repeated
-	 * 0 - zero terminator for inverse 32 bit relocations
-	 * 32 bit inverse relocation repeated
 	 * 0 - zero terminator for 32 bit relocations
 	 * 32 bit relocation repeated
 	 *
@@ -267,16 +265,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 		long extended = *reloc;
 		extended += map;
 
-		ptr = (unsigned long)extended;
-		if (ptr < min_addr || ptr > max_addr)
-			error("inverse 32-bit relocation outside of kernel!\n");
-
-		*(int32_t *)ptr -= delta;
-	}
-	for (reloc--; *reloc; reloc--) {
-		long extended = *reloc;
-		extended += map;
-
 		ptr = (unsigned long)extended;
 		if (ptr < min_addr || ptr > max_addr)
 			error("64-bit relocation outside of kernel!\n");
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 10add45b99f1..942c029a5067 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -29,7 +29,6 @@ static struct relocs		relocs16;
 static struct relocs		relocs32;
 
 #if ELF_BITS == 64
-static struct relocs		relocs32neg;
 static struct relocs		relocs64;
 # define FMT PRIu64
 #else
@@ -287,34 +286,6 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 	return name;
 }
 
-static Elf_Sym *sym_lookup(const char *symname)
-{
-	int i;
-
-	for (i = 0; i < shnum; i++) {
-		struct section *sec = &secs[i];
-		long nsyms;
-		const char *strtab;
-		Elf_Sym *symtab;
-		Elf_Sym *sym;
-
-		if (sec->shdr.sh_type != SHT_SYMTAB)
-			continue;
-
-		nsyms = sec->shdr.sh_size/sizeof(Elf_Sym);
-		symtab = sec->symtab;
-		strtab = sec->link->strtab;
-
-		for (sym = symtab; --nsyms >= 0; sym++) {
-			if (!sym->st_name)
-				continue;
-			if (strcmp(symname, strtab + sym->st_name) == 0)
-				return sym;
-		}
-	}
-	return 0;
-}
-
 #if BYTE_ORDER == LITTLE_ENDIAN
 # define le16_to_cpu(val)	(val)
 # define le32_to_cpu(val)	(val)
@@ -722,79 +693,8 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 	}
 }
 
-/*
- * The .data..percpu section is a special case for x86_64 SMP kernels.
- * It is used to initialize the actual per_cpu areas and to provide
- * definitions for the per_cpu variables that correspond to their offsets
- * within the percpu area. Since the values of all of the symbols need
- * to be offsets from the start of the per_cpu area the virtual address
- * (sh_addr) of .data..percpu is 0 in SMP kernels.
- *
- * This means that:
- *
- *	Relocations that reference symbols in the per_cpu area do not
- *	need further relocation (since the value is an offset relative
- *	to the start of the per_cpu area that does not change).
- *
- *	Relocations that apply to the per_cpu area need to have their
- *	offset adjusted by by the value of __per_cpu_load to make them
- *	point to the correct place in the loaded image (because the
- *	virtual address of .data..percpu is 0).
- *
- * For non SMP kernels .data..percpu is linked as part of the normal
- * kernel data and does not require special treatment.
- *
- */
-static int per_cpu_shndx = -1;
-static Elf_Addr per_cpu_load_addr;
-
-static void percpu_init(void)
-{
-	int i;
-
-	for (i = 0; i < shnum; i++) {
-		ElfW(Sym) *sym;
-
-		if (strcmp(sec_name(i), ".data..percpu"))
-			continue;
-
-		if (secs[i].shdr.sh_addr != 0)	/* non SMP kernel */
-			return;
-
-		sym = sym_lookup("__per_cpu_load");
-		if (!sym)
-			die("can't find __per_cpu_load\n");
-
-		per_cpu_shndx = i;
-		per_cpu_load_addr = sym->st_value;
-
-		return;
-	}
-}
-
 #if ELF_BITS == 64
 
-/*
- * Check to see if a symbol lies in the .data..percpu section.
- *
- * The linker incorrectly associates some symbols with the
- * .data..percpu section so we also need to check the symbol
- * name to make sure that we classify the symbol correctly.
- *
- * The GNU linker incorrectly associates:
- *	__init_begin
- *	__per_cpu_load
- */
-static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-{
-	int shndx = sym_index(sym);
-
-	return (shndx == per_cpu_shndx) &&
-		strcmp(symname, "__init_begin") &&
-		strcmp(symname, "__per_cpu_load");
-}
-
-
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
@@ -805,12 +705,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	if (sym->st_shndx == SHN_UNDEF)
 		return 0;
 
-	/*
-	 * Adjust the offset if this reloc applies to the percpu section.
-	 */
-	if (sec->shdr.sh_info == per_cpu_shndx)
-		offset += per_cpu_load_addr;
-
 	switch (r_type) {
 	case R_X86_64_NONE:
 		/* NONE can be ignored. */
@@ -819,33 +713,22 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_PC32:
 	case R_X86_64_PLT32:
 		/*
-		 * PC relative relocations don't need to be adjusted unless
-		 * referencing a percpu symbol.
+		 * PC relative relocations don't need to be adjusted.
 		 *
 		 * NB: R_X86_64_PLT32 can be treated as R_X86_64_PC32.
 		 */
-		if (is_percpu_sym(sym, symname))
-			add_reloc(&relocs32neg, offset);
 		break;
 
 	case R_X86_64_PC64:
 		/*
 		 * Only used by jump labels
 		 */
-		if (is_percpu_sym(sym, symname))
-			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n", symname);
 		break;
 
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
 	case R_X86_64_GOTPCREL:
-		/*
-		 * References to the percpu area don't need to be adjusted.
-		 */
-		if (is_percpu_sym(sym, symname))
-			break;
-
 		if (shn_abs) {
 			/*
 			 * Whitelisted absolute symbols do not require
@@ -1076,7 +959,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 	/* Order the relocations for more efficient processing */
 	sort_relocs(&relocs32);
 #if ELF_BITS == 64
-	sort_relocs(&relocs32neg);
 	sort_relocs(&relocs64);
 #else
 	sort_relocs(&relocs16);
@@ -1109,13 +991,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 		for (i = 0; i < relocs64.count; i++)
 			if (!i || relocs64.offset[i] != relocs64.offset[i - 1])
 				write_reloc(relocs64.offset[i], stdout);
-
-		/* Print a stop */
-		write_reloc(0, stdout);
-
-		/* Now print each inverse 32-bit relocation */
-		for (i = 0; i < relocs32neg.count; i++)
-			write_reloc(relocs32neg.offset[i], stdout);
 #endif
 
 		/* Print a stop */
@@ -1180,9 +1055,6 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_symtabs();
 	read_relocs();
 
-	if (ELF_BITS == 64)
-		percpu_init();
-
 	if (show_absolute_syms) {
 		print_absolute_symbols();
 		return;
-- 
2.46.0.792.g87dc391469-goog


