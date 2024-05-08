Return-Path: <linux-kernel+bounces-173616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503718C02FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAC7B245F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B04BA94;
	Wed,  8 May 2024 17:19:58 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312518627B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188797; cv=none; b=lcU/sGJlbtc5O663khekb0f/4hpPTev3MG6c1PctwFuCDr1ApqLzZDHofcm8O1jvp4SHKRwA34X24G2Yn2/PfX/W/KQq1ryvJgeOoiny6hn2FkMJSI8ImkGU0fIg38SE7V9oiJc8o13Sf1WROoT3YEDjOUfz1D6JejMIfSTrDQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188797; c=relaxed/simple;
	bh=d5/sE0MYU4BSovjEJ+Rmuzt4ZRaDdJqKmm1JL1KAQfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjDtB9ovY/yWDir1NrNWOD/0QQlZwTFaO5XDJahp7opEVzpCGML+fvu28BCBtfBOvkbk/Pw6O5XoZsupuLIk+CBTWgVvS1svSVLqyqXYo2VG+DRr1FO+cho3cUhtlTaJz8xl7xQccAzgGKiC5qWvc2BFhH0RT3P/uF1h+qxSr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:985a:f2a2:ae2e:5981])
	by andre.telenet-ops.be with bizsmtp
	id LhKp2C00J241EGo01hKpM5; Wed, 08 May 2024 19:19:52 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s4kwX-00F6do-8V;
	Wed, 08 May 2024 19:19:49 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1s4kxJ-0007Ld-DN;
	Wed, 08 May 2024 19:19:49 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Greg Ungerer <gerg@linux-m68k.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Matthew Wilcox <willy@infradead.org>,
	Finn Thain <fthain@linux-m68k.org>,
	Michael Schmitz <schmitzmic@gmail.com>
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC v2] m68k: Add full preempt support
Date: Wed,  8 May 2024 19:19:36 +0200
Message-Id: <938326f254e686682d4726410f207579385f2ae2.1715188484.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a Preemptible Kernel is only supported on the Coldfire CPU
family.  Extend preempt support to the full Classic M68K CPU family
(68020+ with MMU, and 68000-derivatives without MMU).

Make sure preemption is disabled in loops involving cache and TLB
flushing.

Co-developed-by: Finn Thain <fthain@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This patch touches Coldfire cache handling and other code paths taken on
Coldfire.  Perhaps these parts should be spun off in a separate patch as
bug fixes? Or are they not needed?

v2:
  - Disable preemption in get_pointer_table() (Finn) and
    free_pointer_table() (Michael),
  - Call preempt_enable_no_resched() instead of
    sched_preempt_enable_no_resched(), cfr. commit ba74c1448f127649
    ("sched/rt: Document scheduler related skip-resched-check sites").

v1 at
https://lore.kernel.org/all/7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org/
---
 arch/m68k/68000/entry.S               | 15 +++++++++++++++
 arch/m68k/Kconfig                     |  1 -
 arch/m68k/coldfire/cache.c            |  6 ++++++
 arch/m68k/include/asm/cacheflush_mm.h | 23 +++++++++++++++++++++++
 arch/m68k/include/asm/tlbflush.h      | 16 ++++++++++++++++
 arch/m68k/kernel/entry.S              | 16 ++++++++++++++++
 arch/m68k/mm/cache.c                  | 15 +++++++++++++++
 arch/m68k/mm/motorola.c               | 27 ++++++++++++++++++++++++---
 8 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/68000/entry.S b/arch/m68k/68000/entry.S
index 72e95663b62ffd54..1f79deb91da4dcbb 100644
--- a/arch/m68k/68000/entry.S
+++ b/arch/m68k/68000/entry.S
@@ -87,6 +87,21 @@ ret_from_exception:
 	btst	#5,%sp@(PT_OFF_SR)	/* check if returning to kernel*/
 	jeq	Luser_return		/* if so, skip resched, signals*/
 
+#ifdef CONFIG_PREEMPTION
+	movel	%sp,%d1			/* get thread_info pointer */
+	andl	#-THREAD_SIZE,%d1	/* at base of kernel stack */
+	movel	%d1,%a0
+	movel	%a0@(TINFO_FLAGS),%d1	/* get thread_info->flags */
+	btst	#TIF_NEED_RESCHED,%d1
+	jeq	Lkernel_return
+
+	movel	%a0@(TINFO_PREEMPT),%d1
+	jne	Lkernel_return
+
+	pea	Lkernel_return
+	jmp	preempt_schedule_irq	/* preempt the kernel */
+#endif /* CONFIG_PREEMPTION */
+
 Lkernel_return:
 	RESTORE_ALL
 
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 99837d4e8c977485..ef350af5a3b03853 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -11,7 +11,6 @@ config M68K
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
-	select ARCH_NO_PREEMPT if !COLDFIRE
 	select ARCH_USE_MEMTEST if MMU_MOTOROLA
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
diff --git a/arch/m68k/coldfire/cache.c b/arch/m68k/coldfire/cache.c
index 98ee89b87439cdc4..592fd1d579bef348 100644
--- a/arch/m68k/coldfire/cache.c
+++ b/arch/m68k/coldfire/cache.c
@@ -10,6 +10,8 @@
 /***************************************************************************/
 
 #include <linux/kernel.h>
+#include <linux/preempt.h>
+
 #include <asm/coldfire.h>
 #include <asm/mcfsim.h>
 
@@ -25,6 +27,8 @@
 
 void mcf_cache_push(void)
 {
+	preempt_disable();
+
 	__asm__ __volatile__ (
 		"clrl	%%d0\n\t"
 		"1:\n\t"
@@ -42,6 +46,8 @@ void mcf_cache_push(void)
 		  "i" (DCACHE_SIZE / CACHE_WAYS),
 		  "i" (CACHE_WAYS)
 		: "d0", "a0" );
+
+	preempt_enable();
 }
 
 /***************************************************************************/
diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
index 9a71b0148461a455..b3c77d5097aeea9e 100644
--- a/arch/m68k/include/asm/cacheflush_mm.h
+++ b/arch/m68k/include/asm/cacheflush_mm.h
@@ -3,6 +3,8 @@
 #define _M68K_CACHEFLUSH_H
 
 #include <linux/mm.h>
+#include <linux/preempt.h>
+
 #ifdef CONFIG_COLDFIRE
 #include <asm/mcfsim.h>
 #endif
@@ -63,6 +65,8 @@ static inline void flush_cf_icache(unsigned long start, unsigned long end)
 {
 	unsigned long set;
 
+	preempt_disable();
+
 	for (set = start; set <= end; set += (0x10 - 3)) {
 		__asm__ __volatile__ (
 			"cpushl %%ic,(%0)\n\t"
@@ -75,12 +79,16 @@ static inline void flush_cf_icache(unsigned long start, unsigned long end)
 			: "=a" (set)
 			: "a" (set));
 	}
+
+	preempt_enable();
 }
 
 static inline void flush_cf_dcache(unsigned long start, unsigned long end)
 {
 	unsigned long set;
 
+	preempt_disable();
+
 	for (set = start; set <= end; set += (0x10 - 3)) {
 		__asm__ __volatile__ (
 			"cpushl %%dc,(%0)\n\t"
@@ -93,12 +101,16 @@ static inline void flush_cf_dcache(unsigned long start, unsigned long end)
 			: "=a" (set)
 			: "a" (set));
 	}
+
+	preempt_enable();
 }
 
 static inline void flush_cf_bcache(unsigned long start, unsigned long end)
 {
 	unsigned long set;
 
+	preempt_disable();
+
 	for (set = start; set <= end; set += (0x10 - 3)) {
 		__asm__ __volatile__ (
 			"cpushl %%bc,(%0)\n\t"
@@ -111,6 +123,8 @@ static inline void flush_cf_bcache(unsigned long start, unsigned long end)
 			: "=a" (set)
 			: "a" (set));
 	}
+
+	preempt_enable();
 }
 
 /*
@@ -228,14 +242,21 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
 		addr = ((unsigned long) vaddr) & ~(PAGE_SIZE - 1);
 		start = addr & ICACHE_SET_MASK;
 		end = (addr + nr * PAGE_SIZE - 1) & ICACHE_SET_MASK;
+
+		preempt_disable();
+
 		if (start > end) {
 			flush_cf_bcache(0, end);
 			end = ICACHE_MAX_ADDR;
 		}
 		flush_cf_bcache(start, end);
+
+		preempt_enable();
 	} else if (CPU_IS_040_OR_060) {
 		unsigned long paddr = __pa(vaddr);
 
+		preempt_disable();
+
 		do {
 			__asm__ __volatile__("nop\n\t"
 					     ".chip 68040\n\t"
@@ -244,6 +265,8 @@ static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
 					     : : "a" (paddr));
 			paddr += PAGE_SIZE;
 		} while (--nr);
+
+		preempt_enable();
 	} else {
 		unsigned long _tmp;
 		__asm__ __volatile__("movec %%cacr,%0\n\t"
diff --git a/arch/m68k/include/asm/tlbflush.h b/arch/m68k/include/asm/tlbflush.h
index 6d42e2906887931b..f95a8e9c9912a3e8 100644
--- a/arch/m68k/include/asm/tlbflush.h
+++ b/arch/m68k/include/asm/tlbflush.h
@@ -101,6 +101,7 @@ static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end
 
 #else
 
+#include <linux/preempt.h>
 
 /* Reserved PMEGs. */
 extern char sun3_reserved_pmeg[SUN3_PMEGS_NUM];
@@ -115,6 +116,8 @@ static inline void flush_tlb_all(void)
 	unsigned long addr;
 	unsigned char ctx, oldctx;
 
+	preempt_disable();
+
 	oldctx = sun3_get_context();
 	for (addr = 0x00000000; addr < TASK_SIZE; addr += SUN3_PMEG_SIZE) {
 		for (ctx = 0; ctx < 8; ctx++) {
@@ -133,6 +136,8 @@ static inline void flush_tlb_all(void)
 			pmeg_vaddr[addr] = 0;
 		}
 	}
+
+	preempt_enable();
 }
 
 /* Clear user TLB entries within the context named in mm */
@@ -142,6 +147,8 @@ static inline void flush_tlb_mm (struct mm_struct *mm)
 	unsigned char seg;
 	unsigned long i;
 
+	preempt_disable();
+
 	oldctx = sun3_get_context();
 	sun3_put_context(mm->context);
 
@@ -157,6 +164,8 @@ static inline void flush_tlb_mm (struct mm_struct *mm)
 	}
 
 	sun3_put_context(oldctx);
+
+	preempt_enable();
 }
 
 /* Flush a single TLB page. In this case, we're limited to flushing a
@@ -167,6 +176,8 @@ static inline void flush_tlb_page (struct vm_area_struct *vma,
 	unsigned char oldctx;
 	unsigned char i;
 
+	preempt_disable();
+
 	oldctx = sun3_get_context();
 	sun3_put_context(vma->vm_mm->context);
 	addr &= ~SUN3_PMEG_MASK;
@@ -179,6 +190,7 @@ static inline void flush_tlb_page (struct vm_area_struct *vma,
 	}
 	sun3_put_context(oldctx);
 
+	preempt_enable();
 }
 /* Flush a range of pages from TLB. */
 
@@ -190,6 +202,8 @@ static inline void flush_tlb_range (struct vm_area_struct *vma,
 
 	start &= ~SUN3_PMEG_MASK;
 
+	preempt_disable();
+
 	oldctx = sun3_get_context();
 	sun3_put_context(mm->context);
 
@@ -207,6 +221,8 @@ static inline void flush_tlb_range (struct vm_area_struct *vma,
 		start += SUN3_PMEG_SIZE;
 	}
 	sun3_put_context(oldctx);
+
+	preempt_enable();
 }
 
 static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 3bcdd32a6b36613d..9933679ea28b44ab 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -241,7 +241,23 @@ syscall_exit_work:
 ENTRY(ret_from_exception)
 .Lret_from_exception:
 	btst	#5,%sp@(PT_OFF_SR)	| check if returning to kernel
+#ifdef CONFIG_PREEMPTION
+	jeq	2f
+
+	movel   %curptr@(TASK_STACK),%a0
+	tstb	%a0@(TINFO_FLAGS+3)	| check TIF_NEED_RESCHED
+	jpl	1f
+
+	movel	%a0@(TINFO_PREEMPT),%d1
+	jne	1f
+
+	pea	1f
+	jmp	preempt_schedule_irq	| preempt the kernel
+#else /* !CONFIG_PREEMPTION */
 	bnes	1f			| if so, skip resched, signals
+#endif /* !CONFIG_PREEMPTION */
+
+2:
 	| only allow interrupts when we are really the last one on the
 	| kernel stack, otherwise stack overflow can occur during
 	| heavy interrupt load
diff --git a/arch/m68k/mm/cache.c b/arch/m68k/mm/cache.c
index dde978e66f14fb31..d23958bc2a815ea7 100644
--- a/arch/m68k/mm/cache.c
+++ b/arch/m68k/mm/cache.c
@@ -8,6 +8,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/preempt.h>
+
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
 
@@ -62,14 +64,21 @@ void flush_icache_user_range(unsigned long address, unsigned long endaddr)
 		unsigned long start, end;
 		start = address & ICACHE_SET_MASK;
 		end = endaddr & ICACHE_SET_MASK;
+
+		preempt_disable();
+
 		if (start > end) {
 			flush_cf_icache(0, end);
 			end = ICACHE_MAX_ADDR;
 		}
 		flush_cf_icache(start, end);
+
+		preempt_enable();
 	} else if (CPU_IS_040_OR_060) {
 		address &= PAGE_MASK;
 
+		preempt_disable();
+
 		do {
 			asm volatile ("nop\n\t"
 				      ".chip 68040\n\t"
@@ -78,6 +87,8 @@ void flush_icache_user_range(unsigned long address, unsigned long endaddr)
 				      : : "a" (virt_to_phys_slow(address)));
 			address += PAGE_SIZE;
 		} while (address < endaddr);
+
+		preempt_enable();
 	} else {
 		unsigned long tmp;
 		asm volatile ("movec %%cacr,%0\n\t"
@@ -103,12 +114,16 @@ void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 		unsigned long start, end;
 		start = addr & ICACHE_SET_MASK;
 		end = (addr + len) & ICACHE_SET_MASK;
+
+		preempt_disable();
+
 		if (start > end) {
 			flush_cf_icache(0, end);
 			end = ICACHE_MAX_ADDR;
 		}
 		flush_cf_icache(start, end);
 
+		preempt_enable();
 	} else if (CPU_IS_040_OR_060) {
 		asm volatile ("nop\n\t"
 			      ".chip 68040\n\t"
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index c1761d309fc6128c..81ce42b062e78839 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 #include <linux/kernel.h>
+#include <linux/preempt.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -139,10 +140,13 @@ void __init init_pointer_table(void *table, int type)
 
 void *get_pointer_table(int type)
 {
-	ptable_desc *dp = ptable_list[type].next;
-	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
-	unsigned int tmp, off;
+	unsigned int mask, tmp, off;
+	ptable_desc *dp;
+
+	preempt_disable();
 
+	dp = ptable_list[type].next;
+	mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
 	/*
 	 * For a pointer table for a user process address space, a
 	 * table is taken from a page allocated for the purpose.  Each
@@ -153,9 +157,13 @@ void *get_pointer_table(int type)
 		void *page;
 		ptable_desc *new;
 
+		preempt_enable_no_resched();
+
 		if (!(page = (void *)get_zeroed_page(GFP_KERNEL)))
 			return NULL;
 
+		preempt_disable();
+
 		if (type == TABLE_PTE) {
 			/*
 			 * m68k doesn't have SPLIT_PTE_PTLOCKS for not having
@@ -170,6 +178,8 @@ void *get_pointer_table(int type)
 		PD_MARKBITS(new) = ptable_mask(type) - 1;
 		list_add_tail(new, dp);
 
+		preempt_enable_no_resched();
+
 		return (pmd_t *)page;
 	}
 
@@ -180,6 +190,9 @@ void *get_pointer_table(int type)
 		/* move to end of list */
 		list_move_tail(dp, &ptable_list[type]);
 	}
+
+	preempt_enable_no_resched();
+
 	return page_address(PD_PAGE(dp)) + off;
 }
 
@@ -190,6 +203,8 @@ int free_pointer_table(void *table, int type)
 	unsigned long page = ptable & PAGE_MASK;
 	unsigned int mask = 1U << ((ptable - page)/ptable_size(type));
 
+	preempt_disable();
+
 	dp = PD_PTABLE(page);
 	if (PD_MARKBITS (dp) & mask)
 		panic ("table already free!");
@@ -203,6 +218,9 @@ int free_pointer_table(void *table, int type)
 		if (type == TABLE_PTE)
 			pagetable_pte_dtor(virt_to_ptdesc((void *)page));
 		free_page (page);
+
+		preempt_enable_no_resched();
+
 		return 1;
 	} else if (ptable_list[type].next != dp) {
 		/*
@@ -211,6 +229,9 @@ int free_pointer_table(void *table, int type)
 		 */
 		list_move(dp, &ptable_list[type]);
 	}
+
+	preempt_enable_no_resched();
+
 	return 0;
 }
 
-- 
2.34.1


