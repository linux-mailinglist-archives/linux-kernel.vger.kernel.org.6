Return-Path: <linux-kernel+bounces-286145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 242DE95172E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9A02876B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4602A149DEE;
	Wed, 14 Aug 2024 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MPSTG6x7"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC78B14A09C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625793; cv=none; b=kabkzkwxcabpLEFlpgQaXdEanQEQ7/nu0bBiraAbDni3lbdvKbPw9QlrpiuCalw5rqyJBfmDrNUV5kvc4Ewp6oT1vQKBUtTaSj/yE5UeSBaI++j+h8Ui5izLptzsf+vSv7kVHvZxh1hJGiVWOvHxTIc2Pm1l4MxUv8NC2RAPJyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625793; c=relaxed/simple;
	bh=ZsM6+DgcDj9z5sfvCweuiIs8bUgCkA1yqA6ch/fo/wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EwQFbOHZTOMpxtEqxRdekfwvcen3UuLEPoAB9OEUZV1uC4FPFfOdA+g5CP5QGUAsFquozyKJ/VT/a/ghPlKISyk7pVAJ3ECuWqXUEtTEjHHtBnlf8n++SOHeOiSPq9QbgQA3Z2tH5SpLmAaMC4aIqPJMOnnys3Y5us4azYopTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=MPSTG6x7; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso5590744b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723625791; x=1724230591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xswnBLwHxJrHYsJkrECwj9jBmYSXx50wzmQACaoOJYE=;
        b=MPSTG6x74KXk8cMe6Pow3uOG9a18LKul66NLAFMCYU+Xv7vptqp71fuB/UCaF1Ttrm
         QG0Up/H37hLZQ5OReHvnoQNViP13mND4w/MfSVUMkWpJwXQEFhMxXUFG7sh15faeBBDs
         sZBEmmccl/yv3z9FKMVY6DETrcTPBis8B8rTNpeD/BJBYkPIRwguzRWvYmh6+92uzPTh
         IWrpqJ/veZ12WAONoAxWbsEwEN4BxFC6Qbccw0lnlCuoOZhFOYVUt1rSXalpPyy9bom8
         Tid+KcOnFl4Kp2bCrxo1zYnceBfqDPmY4UXUIH2s65vuAuUFvSxpwxWtkrfGY0063Esx
         qq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625791; x=1724230591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xswnBLwHxJrHYsJkrECwj9jBmYSXx50wzmQACaoOJYE=;
        b=BM9uArts7GWF/kqxXE7zi/KkA7rg8nri09aNV7cZH8vEq+Q+XUQVXPaAe4Z3pnnon+
         VP7MERT5FaEku4RLajTUSJAgieVOS/KVTvxTMyCrD8s6X4ysRsZSz4a5z8wBneYsAqUw
         QsHxE1cPgotunQldjiShZFoPxH551aZkw5JgUFMo2phM2u5W7mENnUMm7pIJHG7dB2x4
         +DqBjq0IFl+NTkNDlVJ2xtxa/2ewirc826PP8XaY7j2nYZ4QTjsHFyOLOwq3gn0U30gr
         kSFDBHK7x90QpJTe2sLDCc0ZFuBq4f4YgeFzJNEYTfAqgk+tAny27hhfsOmiiqyMGdT0
         b52A==
X-Forwarded-Encrypted: i=1; AJvYcCXns7961fUfeDn5C8rcYi4tKCi9EknQAl8pg5wXJptW8ElVvHe+CpL4zj7QpqNSg553hJ53TYI6CQAId8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxam/zxMi6dsgJU7uh9qM+0SpwDcgyTlYdJLVRpLM6uZLSpgLdO
	fs73owBLJ/se6sZv7JxSCruAomJ5/ZF8ScXuwPoqVRGhTKrOOmv1ja02WlOU/TE=
X-Google-Smtp-Source: AGHT+IHCL/FoPksetPP9uSrL57foa2RYf5VItY5DJy2ZZShxFbar/elQ054Ynd2YhHuu4Nhm6f2xQQ==
X-Received: by 2002:a05:6a20:9e4b:b0:1c4:bde5:174b with SMTP id adf61e73a8af0-1c8eaf7db28mr2708359637.41.1723625791103;
        Wed, 14 Aug 2024 01:56:31 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd14a7b8sm25439615ad.100.2024.08.14.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:56:30 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com
Cc: llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 6/7] riscv: Implement KASAN_SW_TAGS
Date: Wed, 14 Aug 2024 01:55:34 -0700
Message-ID: <20240814085618.968833-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240814085618.968833-1-samuel.holland@sifive.com>
References: <20240814085618.968833-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for software tag-based KASAN using the RISC-V pointer
masking extension, which supports 7 and/or 16-bit tags. This implemen-
tation uses 7-bit tags, so it is compatible with either hardware mode.

Pointer masking is an optional ISA extension, and it must be enabled
using an SBI call to firmware on each CPU. This SBI call must be made
very early in smp_callin(), as dereferencing any tagged pointers before
that point will crash the kernel. If the SBI call fails on the boot CPU,
then KASAN is globally disabled, and the kernel boots normally (unless
stack tagging is enabled). If the SBI call fails on any other CPU, that
CPU is excluded from the system.

When pointer masking is enabled for the kernel's privilege mode, it must
be more careful about accepting tagged pointers from userspace.
Normally, __access_ok() accepts tagged aliases of kernel memory as long
as the MSB is zero, since those addresses cannot be dereferenced -- they
will cause a page fault in the uaccess routines. But when the kernel is
using pointer masking, those addresses are dereferenceable, so
__access_ok() must specifically check the most-significant non-tag bit.

Pointer masking does not apply to the operands of fence instructions, so
software is responsible for untagging those addresses.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 Documentation/dev-tools/kasan.rst | 14 ++++---
 arch/riscv/Kconfig                |  4 +-
 arch/riscv/include/asm/cache.h    |  4 ++
 arch/riscv/include/asm/kasan.h    | 20 ++++++++++
 arch/riscv/include/asm/page.h     | 19 ++++++++--
 arch/riscv/include/asm/pgtable.h  |  6 +++
 arch/riscv/include/asm/tlbflush.h |  4 +-
 arch/riscv/kernel/setup.c         |  6 +++
 arch/riscv/kernel/smpboot.c       |  8 +++-
 arch/riscv/lib/Makefile           |  2 +
 arch/riscv/lib/kasan_sw_tags.S    | 61 +++++++++++++++++++++++++++++++
 arch/riscv/mm/kasan_init.c        | 30 ++++++++++++++-
 arch/riscv/mm/physaddr.c          |  4 ++
 13 files changed, 167 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/lib/kasan_sw_tags.S

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index d7de44f5339d..6548aebac57f 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,8 +22,8 @@ architectures, but it has significant performance and memory overheads.
 
 Software Tag-Based KASAN or SW_TAGS KASAN, enabled with CONFIG_KASAN_SW_TAGS,
 can be used for both debugging and dogfood testing, similar to userspace HWASan.
-This mode is only supported for arm64, but its moderate memory overhead allows
-using it for testing on memory-restricted devices with real workloads.
+This mode is only supported on arm64 and riscv, but its moderate memory overhead
+allows using it for testing on memory-restricted devices with real workloads.
 
 Hardware Tag-Based KASAN or HW_TAGS KASAN, enabled with CONFIG_KASAN_HW_TAGS,
 is the mode intended to be used as an in-field memory bug detector or as a
@@ -340,12 +340,14 @@ Software Tag-Based KASAN
 ~~~~~~~~~~~~~~~~~~~~~~~~
 
 Software Tag-Based KASAN uses a software memory tagging approach to checking
-access validity. It is currently only implemented for the arm64 architecture.
+access validity. It is currently only implemented for the arm64 and riscv
+architectures.
 
 Software Tag-Based KASAN uses the Top Byte Ignore (TBI) feature of arm64 CPUs
-to store a pointer tag in the top byte of kernel pointers. It uses shadow memory
-to store memory tags associated with each 16-byte memory cell (therefore, it
-dedicates 1/16th of the kernel memory for shadow memory).
+or the pointer masking (Sspm) feature of RISC-V CPUs to store a pointer tag in
+the top byte of kernel pointers. It uses shadow memory to store memory tags
+associated with each 16-byte memory cell (therefore, it dedicates 1/16th of the
+kernel memory for shadow memory).
 
 On each memory allocation, Software Tag-Based KASAN generates a random tag, tags
 the allocated memory with this tag, and embeds the same tag into the returned
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..b963f7cea3b8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -117,6 +117,7 @@ config RISCV
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE if !XIP_KERNEL
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select HAVE_ARCH_KASAN_SW_TAGS if MMU && 64BIT
 	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
 	select HAVE_ARCH_KFENCE if MMU && 64BIT
 	select HAVE_ARCH_KGDB if !XIP_KERNEL
@@ -277,7 +278,8 @@ config PAGE_OFFSET
 
 config KASAN_SHADOW_OFFSET
 	hex
-	depends on KASAN_GENERIC
+	depends on KASAN
+	default 0xffffffff00000000 if KASAN_SW_TAGS
 	default 0xdfffffff00000000 if 64BIT
 	default 0xffffffff if 32BIT
 
diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index 570e9d8acad1..232288a060c6 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -16,6 +16,10 @@
 #define ARCH_KMALLOC_MINALIGN	(8)
 #endif
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
+#endif
+
 /*
  * RISC-V requires the stack pointer to be 16-byte aligned, so ensure that
  * the flat loader aligns it accordingly.
diff --git a/arch/riscv/include/asm/kasan.h b/arch/riscv/include/asm/kasan.h
index a4e92ce9fa31..f6b378ba936d 100644
--- a/arch/riscv/include/asm/kasan.h
+++ b/arch/riscv/include/asm/kasan.h
@@ -25,7 +25,11 @@
  *      KASAN_SHADOW_OFFSET = KASAN_SHADOW_END -
  *                              (1ULL << (64 - KASAN_SHADOW_SCALE_SHIFT))
  */
+#if defined(CONFIG_KASAN_GENERIC)
 #define KASAN_SHADOW_SCALE_SHIFT	3
+#elif defined(CONFIG_KASAN_SW_TAGS)
+#define KASAN_SHADOW_SCALE_SHIFT	4
+#endif
 
 #define KASAN_SHADOW_SIZE	(UL(1) << ((VA_BITS - 1) - KASAN_SHADOW_SCALE_SHIFT))
 /*
@@ -37,6 +41,14 @@
 
 #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define KASAN_TAG_KERNEL	0x7f /* native kernel pointers tag */
+#endif
+
+#define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
+#define arch_kasan_reset_tag(addr)	__tag_reset(addr)
+#define arch_kasan_get_tag(addr)	__tag_get(addr)
+
 void kasan_init(void);
 asmlinkage void kasan_early_init(void);
 void kasan_swapper_init(void);
@@ -48,5 +60,13 @@ void kasan_swapper_init(void);
 
 #endif /* CONFIG_KASAN */
 
+#ifdef CONFIG_KASAN_SW_TAGS
+bool kasan_boot_cpu_enabled(void);
+int kasan_cpu_enable(void);
+#else
+static inline bool kasan_boot_cpu_enabled(void) { return false; }
+static inline int kasan_cpu_enable(void) { return 0; }
+#endif
+
 #endif
 #endif /* __ASM_KASAN_H */
diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
index 09d15567b0b8..d4f038466f1d 100644
--- a/arch/riscv/include/asm/page.h
+++ b/arch/riscv/include/asm/page.h
@@ -89,6 +89,16 @@ typedef struct page *pgtable_t;
 #define PTE_FMT "%08lx"
 #endif
 
+#ifdef CONFIG_KASAN_SW_TAGS
+#define __tag_set(addr, tag)	((void *)((((u64)(addr) << 7) >> 7) | ((u64)(tag) << 57)))
+#define __tag_reset(addr)	((void *)((s64)((u64)(addr) << 7) >> 7))
+#define __tag_get(addr)		((u8)((u64)(addr) >> 57))
+#else
+#define __tag_set(addr, tag)	(addr)
+#define __tag_reset(addr)	(addr)
+#define __tag_get(addr)		0
+#endif
+
 #if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
 /*
  * We override this value as its generic definition uses __pa too early in
@@ -155,7 +165,7 @@ phys_addr_t linear_mapping_va_to_pa(unsigned long x);
 	})
 
 #define __va_to_pa_nodebug(x)	({						\
-	unsigned long _x = x;							\
+	unsigned long _x = (unsigned long)__tag_reset(x);			\
 	is_linear_mapping(_x) ?							\
 		linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);	\
 	})
@@ -179,7 +189,10 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
 #define pfn_to_virt(pfn)	(__va(pfn_to_phys(pfn)))
 
 #define virt_to_page(vaddr)	(pfn_to_page(virt_to_pfn(vaddr)))
-#define page_to_virt(page)	(pfn_to_virt(page_to_pfn(page)))
+#define page_to_virt(page)	({						\
+	__typeof__(page) __page = page;						\
+	__tag_set(pfn_to_virt(page_to_pfn(__page)), page_kasan_tag(__page));	\
+})
 
 #define page_to_phys(page)	(pfn_to_phys(page_to_pfn(page)))
 #define phys_to_page(paddr)	(pfn_to_page(phys_to_pfn(paddr)))
@@ -196,7 +209,7 @@ static __always_inline void *pfn_to_kaddr(unsigned long pfn)
 #endif /* __ASSEMBLY__ */
 
 #define virt_addr_valid(vaddr)	({						\
-	unsigned long _addr = (unsigned long)vaddr;				\
+	unsigned long _addr = (unsigned long)__tag_reset(vaddr);		\
 	(unsigned long)(_addr) >= PAGE_OFFSET && pfn_valid(virt_to_pfn(_addr));	\
 })
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 089f3c9f56a3..1b3bd1ff643a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -910,7 +910,13 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+/*
+ * When pointer masking is enabled for the kernel's privilege mode,
+ * __access_ok() must reject tagged aliases of kernel memory.
+ */
+#ifndef CONFIG_KASAN_SW_TAGS
 #define TASK_SIZE_MAX	LONG_MAX
+#endif
 
 #ifdef CONFIG_COMPAT
 #define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 72e559934952..68b3a85c6960 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -31,14 +31,14 @@ static inline void local_flush_tlb_all_asid(unsigned long asid)
 /* Flush one page from local TLB */
 static inline void local_flush_tlb_page(unsigned long addr)
 {
-	ALT_SFENCE_VMA_ADDR(addr);
+	ALT_SFENCE_VMA_ADDR(__tag_reset(addr));
 }
 
 static inline void local_flush_tlb_page_asid(unsigned long addr,
 					     unsigned long asid)
 {
 	if (asid != FLUSH_TLB_NO_ASID)
-		ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
+		ALT_SFENCE_VMA_ADDR_ASID(__tag_reset(addr), asid);
 	else
 		local_flush_tlb_page(addr);
 }
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a2cde65b69e9..fdc72edc4857 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -299,6 +299,12 @@ void __init setup_arch(char **cmdline_p)
 	riscv_user_isa_enable();
 }
 
+void __init smp_prepare_boot_cpu(void)
+{
+	if (kasan_boot_cpu_enabled())
+		kasan_init_sw_tags();
+}
+
 bool arch_cpu_is_hotpluggable(int cpu)
 {
 	return cpu_has_hotplug(cpu);
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 0f8f1c95ac38..a1cc555691b0 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -29,6 +29,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 #include <asm/irq.h>
+#include <asm/kasan.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
 #include <asm/tlbflush.h>
@@ -210,7 +211,11 @@ void __init smp_cpus_done(unsigned int max_cpus)
 asmlinkage __visible void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
-	unsigned int curr_cpuid = smp_processor_id();
+	unsigned int curr_cpuid;
+
+	/* Must be called first, before referencing any dynamic allocations */
+	if (kasan_boot_cpu_enabled() && kasan_cpu_enable())
+		return;
 
 	if (has_vector()) {
 		/*
@@ -225,6 +230,7 @@ asmlinkage __visible void smp_callin(void)
 	mmgrab(mm);
 	current->active_mm = mm;
 
+	curr_cpuid = smp_processor_id();
 	store_cpu_topology(curr_cpuid);
 	notify_cpu_starting(curr_cpuid);
 
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 8eec6b69a875..ae36616fe1f5 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -20,3 +20,5 @@ lib-$(CONFIG_RISCV_ISA_ZBC)	+= crc32.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
 lib-$(CONFIG_RISCV_ISA_V)	+= riscv_v_helpers.o
+
+obj-$(CONFIG_KASAN_SW_TAGS) += kasan_sw_tags.o
diff --git a/arch/riscv/lib/kasan_sw_tags.S b/arch/riscv/lib/kasan_sw_tags.S
new file mode 100644
index 000000000000..f7d3e0acba6a
--- /dev/null
+++ b/arch/riscv/lib/kasan_sw_tags.S
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2020 Google LLC
+ * Copyright (C) 2024 SiFive
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * Report a tag mismatch detected by tag-based KASAN.
+ *
+ * A compiler-generated thunk calls this with a custom calling convention.
+ * Upon entry to this function, the following registers have been modified:
+ *
+ *   x1/ra:     clobbered by call to this function
+ *   x2/sp:     decremented by 256
+ *   x6/t1:     tag from shadow memory
+ *   x7/t2:     tag from pointer
+ *   x10/a0:    fault address
+ *   x11/a1:    fault description
+ *   x28/t3:    clobbered by thunk
+ *   x29/t4:    clobbered by thunk
+ *   x30/t5:    clobbered by thunk
+ *   x31/t6:    clobbered by thunk
+ *
+ * The caller has decremented the SP by 256 bytes, and stored the following
+ * registers in slots on the stack according to their number (sp + 8 * xN):
+ *
+ *   x1/ra:     return address to user code
+ *   x8/s0/fp:  saved value from user code
+ *   x10/a0:    saved value from user code
+ *   x11/a1:    saved value from user code
+ */
+SYM_CODE_START(__hwasan_tag_mismatch)
+	/* Store the remaining unclobbered caller-saved regs */
+	sd	t0, (8 *  5)(sp)
+	sd	a2, (8 * 12)(sp)
+	sd	a3, (8 * 13)(sp)
+	sd	a4, (8 * 14)(sp)
+	sd	a5, (8 * 15)(sp)
+	sd	a6, (8 * 16)(sp)
+	sd	a7, (8 * 17)(sp)
+
+	/* a0 and a1 are already set by the thunk */
+	ld	a2, (8 *  1)(sp)
+	call	kasan_tag_mismatch
+
+	ld	ra, (8 *  1)(sp)
+	ld	t0, (8 *  5)(sp)
+	ld	a0, (8 * 10)(sp)
+	ld	a1, (8 * 11)(sp)
+	ld	a2, (8 * 12)(sp)
+	ld	a3, (8 * 13)(sp)
+	ld	a4, (8 * 14)(sp)
+	ld	a5, (8 * 15)(sp)
+	ld	a6, (8 * 16)(sp)
+	ld	a7, (8 * 17)(sp)
+	addi	sp, sp, 256
+	ret
+SYM_CODE_END(__hwasan_tag_mismatch)
+EXPORT_SYMBOL(__hwasan_tag_mismatch)
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index c301c8d291d2..b247c56206c5 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -11,6 +11,10 @@
 #include <asm/fixmap.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_KASAN_SW_TAGS
+static bool __kasan_boot_cpu_enabled __ro_after_init;
+#endif
+
 /*
  * Kasan shadow region must lie at a fixed address across sv39, sv48 and sv57
  * which is right before the kernel.
@@ -323,8 +327,11 @@ asmlinkage void __init kasan_early_init(void)
 {
 	uintptr_t i;
 
-	BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
-		KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		BUILD_BUG_ON(KASAN_SHADOW_OFFSET !=
+			KASAN_SHADOW_END - (1UL << (64 - KASAN_SHADOW_SCALE_SHIFT)));
+	else
+		BUILD_BUG_ON(KASAN_SHADOW_OFFSET != KASAN_SHADOW_END);
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
@@ -356,6 +363,8 @@ asmlinkage void __init kasan_early_init(void)
 				 KASAN_SHADOW_START, KASAN_SHADOW_END);
 
 	local_flush_tlb_all();
+
+	__kasan_boot_cpu_enabled = !kasan_cpu_enable();
 }
 
 void __init kasan_swapper_init(void)
@@ -534,3 +543,20 @@ void __init kasan_init(void)
 	csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | satp_mode);
 	local_flush_tlb_all();
 }
+
+#ifdef CONFIG_KASAN_SW_TAGS
+bool kasan_boot_cpu_enabled(void)
+{
+	return __kasan_boot_cpu_enabled;
+}
+
+int kasan_cpu_enable(void)
+{
+	struct sbiret ret;
+
+	/* sbi_fwft_set(POINTER_MASKING_PMLEN, 7, 0); */
+	ret = sbi_ecall(0x46574654, 0, 5, 7, 0, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
+}
+#endif
diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
index 18706f457da7..6d1cf6ffd54e 100644
--- a/arch/riscv/mm/physaddr.c
+++ b/arch/riscv/mm/physaddr.c
@@ -8,6 +8,8 @@
 
 phys_addr_t __virt_to_phys(unsigned long x)
 {
+	x = __tag_reset(x);
+
 	/*
 	 * Boundary checking aginst the kernel linear mapping space.
 	 */
@@ -24,6 +26,8 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
 	unsigned long kernel_start = kernel_map.virt_addr;
 	unsigned long kernel_end = kernel_start + kernel_map.size;
 
+	x = __tag_reset(x);
+
 	/*
 	 * Boundary checking aginst the kernel image mapping.
 	 * __pa_symbol should only be used on kernel symbol addresses.
-- 
2.45.1


