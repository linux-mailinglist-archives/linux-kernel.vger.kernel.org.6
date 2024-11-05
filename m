Return-Path: <linux-kernel+bounces-396731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95549BD15E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AA52831DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101941D516F;
	Tue,  5 Nov 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egwzwXQb"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58598185B69
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822308; cv=none; b=O4a6xkgKylNUcgcQ8TgsJbXug32jMIttpRresEMnGZt6xef4F6+B5dr3tZiGfPTXVo4uo1WZmKUYB0v4+Jm5B1tcBuQvBzXz+8E4UloNNlf95OFsfuLyPGcISMSZ62irYZ997rA5TdHkNISE0qyvK3z44YcPQUZkAhi63WxJ2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822308; c=relaxed/simple;
	bh=wOAN3PdAyvx5lN8DA7Jr9l+PSsU2gFDnV0QIPvGQy/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Si9YjAvnGA9jcTCNy3u1jwnf99gyRgXFBYjgYQkteiWW2ILIfZOSdgvtTXOt21sqJCDnwlx87rrsrSbpf+X0g0uHJo5dq5NAYo/4HOD/HsHcT/Jfn7U8J8hi11hrYXesTyRerw5RW/kQEx4uLW8desOPg0eLAmd8X6i0VNQ/Yvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egwzwXQb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbf0769512so36330506d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730822305; x=1731427105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pk5EeZ2tUI9SbgFH2i6WD82PzVaWkSaCnBLgM6sYjJg=;
        b=egwzwXQbDJkZv8Xp2ui08hpVsdADolNn2uiYdguAgm30DllyNcxLFcMkP5sp63pj6Z
         ZoGkwXbNsArzqd/toeCVNr48HynlTBu/tvvl5hFobNs2UCIeGFULHJPVADpaU6ToTDI6
         I1Z4OyVlQLJFNV6HzAa3q4v1/40p9v3Q0uP4Zi1GRl6Nb+YrGq5Loktg462jNkgTF+zG
         Bgm1DIAI3HYZQ9XQvUdjDXLadSI0FpL7ut1XyASKaNDGOxAltCYL/Y8BYXqvsC7uaiFK
         ohmAHLG6hXlpCqYL8lA9h+Pr+3TnWDL0rOv/HyW+R1f2ncTTvbM3XMpXeZcVyie5ESC4
         T3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730822305; x=1731427105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pk5EeZ2tUI9SbgFH2i6WD82PzVaWkSaCnBLgM6sYjJg=;
        b=j6OuIkqCpoLfcoemOmiQjqpzWmM1TOaxetIiXHcw0TS0CSNxQzPMvpI0VXZz7C5Ke6
         DFmGqMTmOPONAoCC0FK8H8VGfreqilZzG/gkqqRBpk1vBdPDSwzjRHdRBPNtrFYtvOgI
         /w0kkQIuRVaED/drHnvgtdvnuI//ldp8Zr2l3cSNchs7t+f58a96YkspxbcAfEm86gOB
         oEuPkdEi/jHX0BSrok1v/hjcn9EXH9WgSKaG/DbG4K1ByN2/+GwO+EbExGeGrgaoa0RV
         FqQgh4Zj9qyETx6MEniSU7zv+vLMX+tn17AXqEx3+96rreNWKbCoOMFqhhxXehdigsps
         ztNg==
X-Gm-Message-State: AOJu0YzJDjApUbx7imu3nY+nHURn+gMUH4wCnws71M+33BloG6HZNLh3
	tPZefvdGdwTJJ9l84HyShbWWSrQ3VdM38brV7pNSPkbW9Lh3jYD/Dqak
X-Google-Smtp-Source: AGHT+IHIjQBB17G0K2htaT5VK8YQAH65Fg43pxrKi708tGNDua0ae1fTrV8uoFQ9p0Zb8EH0bTLwXg==
X-Received: by 2002:a05:6214:5c89:b0:6d3:55ee:35d with SMTP id 6a1803df08f44-6d355ee0410mr327056846d6.7.1730822304772;
        Tue, 05 Nov 2024 07:58:24 -0800 (PST)
Received: from citadel.lan ([2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fc6d07sm61710586d6.44.2024.11.05.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 07:58:24 -0800 (PST)
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
Subject: [PATCH v5 09/16] x86/percpu/64: Use relative percpu offsets
Date: Tue,  5 Nov 2024 10:57:54 -0500
Message-ID: <20241105155801.1779119-10-brgerst@gmail.com>
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

The percpu section is currently linked at absolute address 0, because
older compilers hardcoded the stack protector canary value at a fixed
offset from the start of the GS segment.  Now that the canary is a
normal percpu variable, the percpu section does not need to be linked
at a specific address.

x86-64 will now calculate the percpu offsets as the delta between the
initial percpu address and the dynamically allocated memory, like other
architectures.  Note that GSBASE is limited to the canonical address
width (48 or 57 bits, sign-extended).  As long as the kernel text,
modules, and the dynamically allocated percpu memmory are all in the
negative address space, the delta will not overflow this limit.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/processor.h |  6 +++++-
 arch/x86/kernel/head_64.S        | 19 +++++++++----------
 arch/x86/kernel/setup_percpu.c   | 12 ++----------
 arch/x86/kernel/vmlinux.lds.S    | 29 +----------------------------
 arch/x86/platform/pvh/head.S     |  5 ++---
 arch/x86/tools/relocs.c          | 10 +++-------
 arch/x86/xen/xen-head.S          |  9 ++++-----
 init/Kconfig                     |  2 +-
 8 files changed, 27 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a113c3f4f558..ae50d5d4fa26 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -428,7 +428,11 @@ DECLARE_INIT_PER_CPU(fixed_percpu_data);
 
 static inline unsigned long cpu_kernelmode_gs_base(int cpu)
 {
-	return (unsigned long)per_cpu(fixed_percpu_data.gs_base, cpu);
+#ifdef CONFIG_SMP
+	return per_cpu_offset(cpu);
+#else
+	return 0;
+#endif
 }
 
 extern asmlinkage void entry_SYSCALL32_ignore(void);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index c3028b4df85f..ffbcb0aea450 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -61,11 +61,14 @@ SYM_CODE_START_NOALIGN(startup_64)
 	/* Set up the stack for verify_cpu() */
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
-	/* Setup GSBASE to allow stack canary access for C code */
+	/*
+	 * Set up GSBASE.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
 	movl	$MSR_GS_BASE, %ecx
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movl	%edx, %eax
-	shrq	$32,  %rdx
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	wrmsr
 
 	call	startup_64_setup_gdt_idt
@@ -353,16 +356,12 @@ SYM_INNER_LABEL(common_startup_64, SYM_L_LOCAL)
 	movl %eax,%fs
 	movl %eax,%gs
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.
+	/*
+	 * Set up GSBASE.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-#ifndef CONFIG_SMP
-	leaq	INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-#endif
 	movl	%edx, %eax
 	shrq	$32, %rdx
 	wrmsr
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index b30d6e180df7..1e7be9409aa2 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -23,18 +23,10 @@
 #include <asm/cpumask.h>
 #include <asm/cpu.h>
 
-#ifdef CONFIG_X86_64
-#define BOOT_PERCPU_OFFSET ((unsigned long)__per_cpu_load)
-#else
-#define BOOT_PERCPU_OFFSET 0
-#endif
-
-DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off) = BOOT_PERCPU_OFFSET;
+DEFINE_PER_CPU_READ_MOSTLY(unsigned long, this_cpu_off);
 EXPORT_PER_CPU_SYMBOL(this_cpu_off);
 
-unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init = {
-	[0 ... NR_CPUS-1] = BOOT_PERCPU_OFFSET,
-};
+unsigned long __per_cpu_offset[NR_CPUS] __ro_after_init;
 EXPORT_SYMBOL(__per_cpu_offset);
 
 /*
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index d61c3584f3e6..42d1c05b0207 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -99,12 +99,6 @@ const_pcpu_hot = pcpu_hot;
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
-	percpu PT_LOAD FLAGS(6);        /* RW_ */
-#endif
-	init PT_LOAD FLAGS(7);          /* RWE */
-#endif
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
@@ -199,21 +193,7 @@ SECTIONS
 		__init_begin = .; /* paired with __init_end */
 	}
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
-	/*
-	 * percpu offsets are zero-based on SMP.  PERCPU_VADDR() changes the
-	 * output PHDR, so the next output section - .init.text - should
-	 * start another segment - init.
-	 */
-	PERCPU_VADDR(INTERNODE_CACHE_BYTES, 0, :percpu)
-	ASSERT(SIZEOF(.data..percpu) < CONFIG_PHYSICAL_START,
-	       "per-CPU data too large - increase CONFIG_PHYSICAL_START")
-#endif
-
 	INIT_TEXT_SECTION(PAGE_SIZE)
-#ifdef CONFIG_X86_64
-	:init
-#endif
 
 	/*
 	 * Section for code used exclusively before alternatives are run. All
@@ -330,9 +310,7 @@ SECTIONS
 		EXIT_DATA
 	}
 
-#if !defined(CONFIG_X86_64) || !defined(CONFIG_SMP)
 	PERCPU_SECTION(INTERNODE_CACHE_BYTES)
-#endif
 
 	RUNTIME_CONST_VARIABLES
 	RUNTIME_CONST(ptr, USER_PTR_MAX)
@@ -476,16 +454,11 @@ PROVIDE(__ref_stack_chk_guard = __stack_chk_guard);
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
  */
-#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x) + __per_cpu_load
+#define INIT_PER_CPU(x) init_per_cpu__##x = ABSOLUTE(x)
 INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-#ifdef CONFIG_SMP
-. = ASSERT((fixed_percpu_data == 0),
-           "fixed_percpu_data is not at start of per-cpu area");
-#endif
-
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
 . = ASSERT((retbleed_return_thunk & 0x3f) == 0, "retbleed_return_thunk not cacheline-aligned");
 #endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index b0a9a58952aa..c931e680ef15 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -165,9 +165,8 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	 * the per cpu areas are set up.
 	 */
 	movl $MSR_GS_BASE,%ecx
-	leaq INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
-	movq %edx, %eax
-	shrq $32, %rdx
+	xorl %eax, %eax
+	xorl %edx, %edx
 	wrmsr
 
 	/*
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 7d7fc7f0a250..8b5e2bc3d241 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -834,12 +834,7 @@ static void percpu_init(void)
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
-	int shndx = sym_index(sym);
-
-	return (shndx == per_cpu_shndx) &&
-		strcmp(symname, "__init_begin") &&
-		strcmp(symname, "__per_cpu_load") &&
-		strncmp(symname, "init_per_cpu_", 13);
+	return 0;
 }
 
 
@@ -1055,7 +1050,8 @@ static int cmp_relocs(const void *va, const void *vb)
 
 static void sort_relocs(struct relocs *r)
 {
-	qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
+	if (r->count)
+		qsort(r->offset, r->count, sizeof(r->offset[0]), cmp_relocs);
 }
 
 static int write32(uint32_t v, FILE *f)
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ae4672ea00bb..1796884b727d 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -51,15 +51,14 @@ SYM_CODE_START(startup_xen)
 
 	leaq	__top_init_kernel_stack(%rip), %rsp
 
-	/* Set up %gs.
-	 *
-	 * The base of %gs always points to fixed_percpu_data.
+	/*
+	 * Set up GSBASE.
 	 * Note that, on SMP, the boot cpu uses init data section until
 	 * the per cpu areas are set up.
 	 */
 	movl	$MSR_GS_BASE,%ecx
-	movq	$INIT_PER_CPU_VAR(fixed_percpu_data),%rax
-	cdq
+	xorl	%eax, %eax
+	xorl	%edx, %edx
 	wrmsr
 
 	mov	%rsi, %rdi
diff --git a/init/Kconfig b/init/Kconfig
index c521e1421ad4..b374c0de5cfd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1849,7 +1849,7 @@ config KALLSYMS_ALL
 config KALLSYMS_ABSOLUTE_PERCPU
 	bool
 	depends on KALLSYMS
-	default X86_64 && SMP
+	default n
 
 # end of the "standard kernel features (expert users)" menu
 
-- 
2.47.0


