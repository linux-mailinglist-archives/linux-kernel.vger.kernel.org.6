Return-Path: <linux-kernel+bounces-396733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D709BD161
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56766B24624
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510041D9A6F;
	Tue,  5 Nov 2024 15:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFwEFWLY"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121D1D414B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822310; cv=none; b=JD85Y4I5f/OtNQbIz/px+/A2dLPAj8IFEp4IL+7L0/KUDnjbV+U0sehWhfxrPg3iZxSQ0ynjzSTR9nYfYMQGKPIGvR4cDcA0iaCaNhNJ9kwljsdti9eW8t+YTDk1DU3s7U51a0sIP9A2/BIkQ62at7OItqe8cRnVqCRd/jz95c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822310; c=relaxed/simple;
	bh=TmUCx4UpY+BQFLsOPmL14Hg7eWM+uT42BafZdQbiR4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVn36whMQYROhNihT8CVSPXPEBg8GUogkR2CbdWrW0u6TKqGIzw3nPfr2ocK3kDb/xfliPrTaP0cVw4sc/kfVlXq4s28gBAv9ZVogawVr8CRzYUEKdi0KmNiESZEzlouicEu2OrXGlRZqp4QNEhXG1afWv6GiQ0vRl7V6S4mmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFwEFWLY; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b14f3927ddso431239285a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822307; x=1731427107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9WD19gdt8CNaGFyWP/88P7iTTjUvAoc05Lsqx3RBdA=;
        b=lFwEFWLYXvWTEem7BdaXVuN2n/Q9W6OamrTz1TT6U9uOLNjA30m6Dbk0vvsVfGIhC6
         VWCvFw6DdhNSEejGbwNJcdMn1zsCfkKTMeQQb6pBmuIxuW3hBawKGjUmLo5WopctwM4k
         qKuwFjaup1TC5gQbjZBZ2MjogzdII1tAGCfjawaBodAx5lEbFDUbKmN1bR7qDSRvxwVB
         bD6ej9ARQNERFL7WdDRxllmcJ0c4+5EVzBPEkSU3izV223P0qweiD/0Zpu4yvyp6kbFA
         QoFvCm6ARqX8NZhYJUXPzHzolliIBKyu9w5Z/KngrGqGPWcTAWQzCusSixxfUSXH/H0L
         fMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822307; x=1731427107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9WD19gdt8CNaGFyWP/88P7iTTjUvAoc05Lsqx3RBdA=;
        b=DKJFi7y6jArL5VMgsOjMOEN96uIbIo4CfwofJ9PYqOgDTPTjKPPiJHi1CbS8WnL1O7
         ObzFl9EDhSYYfMqL/+hTmTi4xRXyHfkgG2+lmk1n6nk3JljoFxsWt4kAamGC4UQLLH55
         kUTByi1ROAv9OWBAMN9hPz1Efw3AKPiJdpuXRpau42RuUOMSLbfxwWI80T/jrIfej1cj
         gM2yzRbwwpkMwbQi2RCxGwhEBcgNXbC/4yyZGLNbTIdjthiVk73kdkf5G3fXEFUuI7as
         OTymn0ekspS0KSatkCyEQ3O9Kt9S0YKKtIqoZcBtOsiD/LdEUgrlmicT9jeJJfE8VS/p
         nqOQ==
X-Gm-Message-State: AOJu0Yx16Oer28W3OrB/UilZnW7J0Im41QpYmlmCeK4E8giFy/ca5Uh3
	2fSDP5UHGcaW33jMexZYxVix5mNb0oCqIJVIo4SbLRBsysd/qsaY3Ji/
X-Google-Smtp-Source: AGHT+IFBJUBm5do6sgjewQawqaxPEnRX6M4L/ZUZIiKr4vCweI0y7slZ6Q4FQihmyy14BQsPKfVOOw==
X-Received: by 2002:a05:6214:469a:b0:6d3:45ad:d850 with SMTP id 6a1803df08f44-6d345addb51mr358711426d6.26.1730822307045;
        Tue, 05 Nov 2024 07:58:27 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:26 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v5 11/16] x86/boot/64: Remove inverse relocations
Date: Tue,  5 Nov 2024 10:57:56 -0500
Message-ID: <20241105155801.1779119-12-brgerst@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241105155801.1779119-1-brgerst@gmail.com>
References: <20241105155801.1779119-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inverse relocations were needed to offset the effects of relocation for
RIP-relative accesses to zero-based percpu data.  Now that the percpu
section is linked normally as part of the kernel image, they are no
longer needed.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/boot/compressed/misc.c |  14 +---
 arch/x86/tools/relocs.c         | 130 +-------------------------------
 2 files changed, 2 insertions(+), 142 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 0d37420cad02..1cdcd4aaf395 100644
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
@@ -263,16 +261,6 @@ static void handle_relocations(void *output, unsigned long output_len,
 		*(uint32_t *)ptr += delta;
 	}
 #ifdef CONFIG_X86_64
-	while (*--reloc) {
-		long extended = *reloc;
-		extended += map;
-
-		ptr = (unsigned long)extended;
-		if (ptr < min_addr || ptr > max_addr)
-			error("inverse 32-bit relocation outside of kernel!\n");
-
-		*(int32_t *)ptr -= delta;
-	}
 	for (reloc--; *reloc; reloc--) {
 		long extended = *reloc;
 		extended += map;
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index a661a6bab4cf..8d9e82748615 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -29,7 +29,6 @@ static struct relocs		relocs16;
 static struct relocs		relocs32;
 
 #if ELF_BITS == 64
-static struct relocs		relocs32neg;
 static struct relocs		relocs64;
 # define FMT PRIu64
 
@@ -90,7 +89,6 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"__initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
-	"__per_cpu_load|"
 	"init_per_cpu__.*|"
 	"__end_rodata_hpage_align|"
 #endif
@@ -289,34 +287,6 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 	return name;
 }
 
-static Elf_Sym *sym_lookup(const char *symname)
-{
-	int i;
-
-	for (i = 0; i < shnum; i++) {
-		struct section *sec = &secs[i];
-		long nsyms;
-		char *strtab;
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
@@ -765,78 +735,8 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
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
- *
- * The "gold" linker incorrectly associates:
- *	init_per_cpu__gdt_page
- */
-static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
-{
-	return 0;
-}
-
-
 static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		      const char *symname)
 {
@@ -847,12 +747,6 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
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
@@ -862,32 +756,21 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 	case R_X86_64_PLT32:
 	case R_X86_64_REX_GOTPCRELX:
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
-		/*
-		 * References to the percpu area don't need to be adjusted.
-		 */
-		if (is_percpu_sym(sym, symname))
-			break;
-
 		if (shn_abs) {
 			/*
 			 * Whitelisted absolute symbols do not require
@@ -1094,7 +977,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 	/* Order the relocations for more efficient processing */
 	sort_relocs(&relocs32);
 #if ELF_BITS == 64
-	sort_relocs(&relocs32neg);
 	sort_relocs(&relocs64);
 #else
 	sort_relocs(&relocs16);
@@ -1126,13 +1008,6 @@ static void emit_relocs(int as_text, int use_real_mode)
 		/* Now print each relocation */
 		for (i = 0; i < relocs64.count; i++)
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
@@ -1185,9 +1060,6 @@ void process(FILE *fp, int use_real_mode, int as_text,
 	read_symtabs(fp);
 	read_relocs(fp);
 
-	if (ELF_BITS == 64)
-		percpu_init();
-
 	if (show_absolute_syms) {
 		print_absolute_symbols();
 		return;
-- 
2.47.0


