Return-Path: <linux-kernel+bounces-285566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BB4950FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04291F2472A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4581AB516;
	Tue, 13 Aug 2024 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gm2yjerx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O43mwkXa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50D1A256C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588181; cv=none; b=fJnvNdL5/9Ww/s52mnPi9DWDvx83qsj7NCQYQ3twZA6KwViPXWXZaxBf4O2gTseZtcXV94bpIN2nnXQ0CFJt0PwKfaJlbeNPCaj/d5Tww7zP+EIOxuvBTIevwV3nI8bFM6nbDS436w06WeJPnAQYPVKl+I786iBRGu6x6+bcwu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588181; c=relaxed/simple;
	bh=EdUo+KBrgA/eDY1IZO9kY+gNrRm4MOrLSPmRnKckTOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nlkmzoNA0V6OIjIFNFZet7rIOnR7tzxcQeUuMD2jlEnB1CnPWk1TU68/o7BpkfAphEPjn8828A6TbkjeVr2q5bKsp1quoLYsvZj4fdLObBplKypOjGfOc5arjaGIuL0PryQ2QiVyXmqNR2DmD6gzEEl/YXRZwIvnJTAlw4R4iw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gm2yjerx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O43mwkXa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723588176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSQozabB5oXXlbGC/Voz9NEQnop8mpnE16RwHB2qbT0=;
	b=Gm2yjerxdpyFuPVK+ZzeMEa4D0rBkSvEqVmGOd+NC9SOLSpzbU4Boaa2iIhDAxVDXYHmcc
	BTCpXAHVwGRa2PhVCA0/RQ2hUqO1EkxGiN62wuOWuIqndGgB80754GP99wwaXBlJCDZIu0
	MGRjmkjTpPXNdEvkimYkREftnxZJ3DhuaBsJf21/PoKCEVIiUeR/3dfHoogGlCj3nEn1Xx
	NEyaB4RtO2fMwAUTxZXWIPebOKtxholvkUm3dYxpL0V5laIL+gVOPPMjeAMgHqiuGIFx9v
	xdjJQCWdXSYkJxpnyr87kn0L/BOf2dIkPHQdACpgZj1KO0BG3+TuR02Y2ACJPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723588176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSQozabB5oXXlbGC/Voz9NEQnop8mpnE16RwHB2qbT0=;
	b=O43mwkXaoQ/oeU+7uvgCmPNiAeK76Yg7BC6WHjABMMHL6MYswlq0j0VTgpgSLnRPDjwWb+
	OvHvukvgm5xfbWCA==
To: Alistair Popple <apopple@nvidia.com>
Cc: x86@kernel.org, Dan Williams <dan.j.williams@intel.com>,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 max8rr8@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 jhubbard@nvidia.com, Kees Cook <keescook@chromium.org>, Andrew Morton
 <akpm@linuxfoundation.org>, David Hildenbrand <david@redhat.com>, Oscar
 Salvador <osalvador@suse.de>, linux-mm@kvack.org
Subject: x86/kaslr: Expose and use the end of the physical memory address space
In-Reply-To: <87le10p3ak.ffs@tglx>
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpks23v.ffs@tglx> <87o75y428z.fsf@nvdebian.thelocal>
 <87ikw6rrau.ffs@tglx> <87frr9swmw.ffs@tglx>
 <87bk1x42vk.fsf@nvdebian.thelocal> <87sev8rfyx.ffs@tglx>
 <87le10p3ak.ffs@tglx>
Date: Wed, 14 Aug 2024 00:29:36 +0200
Message-ID: <87ed6soy3z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

iounmap() on x86 occasionally fails to unmap because the provided valid
ioremap address is not below high_memory. It turned out that this
happens due to KASLR.

KASLR uses the full address space between PAGE_OFFSET and vaddr_end to
randomize the starting points of the direct map, vmalloc and vmemmap
regions.  It thereby limits the size of the direct map by using the
installed memory size plus an extra configurable margin for hot-plug
memory.  This limitation is done to gain more randomization space
because otherwise only the holes between the direct map, vmalloc,
vmemmap and vaddr_end would be usable for randomizing.

The limited direct map size is not exposed to the rest of the kernel, so
the memory hot-plug and resource management related code paths still
operate under the assumption that the available address space can be
determined with MAX_PHYSMEM_BITS.

request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
downwards.  That means the first allocation happens past the end of the
direct map and if unlucky this address is in the vmalloc space, which
causes high_memory to become greater than VMALLOC_START and consequently
causes iounmap() to fail for valid ioremap addresses.

MAX_PHYSMEM_BITS cannot be changed for that because the randomization
does not align with address bit boundaries and there are other places
which actually require to know the maximum number of address bits.  All
remaining usage sites of MAX_PHYSMEM_BITS have been analyzed and found
to be correct.

Cure this by exposing the end of the direct map via PHYSMEM_END and use
that for the memory hot-plug and resource management related places
instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
maps to a variable which is initialized by the KASLR initialization and
otherwise it is based on MAX_PHYSMEM_BITS as before.

To prevent future hickups add a check into add_pages() to catch callers
trying to add memory above PHYSMEM_END.

Fixes: 0483e1fa6e09 ("x86/mm: Implement ASLR for kernel memory regions")
Reported-by: Max Ramanouski <max8rr8@gmail.com>
Reported-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/page_64.h          |    1 +
 arch/x86/include/asm/pgtable_64_types.h |    4 ++++
 arch/x86/mm/init_64.c                   |    4 ++++
 arch/x86/mm/kaslr.c                     |   21 ++++++++++++++++++---
 include/linux/mm.h                      |    4 ++++
 kernel/resource.c                       |    6 ++----
 mm/memory_hotplug.c                     |    2 +-
 mm/sparse.c                             |    2 +-
 8 files changed, 35 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -17,6 +17,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+extern unsigned long physmem_end;
 
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -140,6 +140,10 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
+#ifdef CONFIG_RANDOMIZE_MEMORY
+# define PHYSMEM_END		physmem_end
+#endif
+
 /*
  * End of the region for which vmalloc page tables are pre-allocated.
  * For non-KMSAN builds, this is the same as VMALLOC_END.
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -958,8 +958,12 @@ static void update_end_of_memory_vars(u6
 int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	      struct mhp_params *params)
 {
+	unsigned long end = ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
 	int ret;
 
+	if (WARN_ON_ONCE(end > PHYSMEM_END))
+		return -ERANGE;
+
 	ret = __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
 
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -47,13 +47,24 @@ static const unsigned long vaddr_end = C
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
+	unsigned long *end;
 	unsigned long size_tb;
 } kaslr_regions[] = {
-	{ &page_offset_base, 0 },
-	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 0 },
+	{
+		.base	= &page_offset_base,
+		.end	= &physmem_end,
+	},
+	{
+		.base	= &vmalloc_base,
+	},
+	{
+		.base	= &vmemmap_base,
+	},
 };
 
+/* The end of the possible address space for physical memory */
+unsigned long physmem_end __ro_after_init;
+
 /* Get size in bytes used by the memory region */
 static inline unsigned long get_padding(struct kaslr_memory_region *region)
 {
@@ -82,6 +93,8 @@ void __init kernel_randomize_memory(void
 	BUILD_BUG_ON(vaddr_end != CPU_ENTRY_AREA_BASE);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
 
+	/* Preset the end of the possible address space for physical memory */
+	physmem_end = ((1ULL << MAX_PHYSMEM_BITS) - 1);
 	if (!kaslr_memory_enabled())
 		return;
 
@@ -134,6 +147,8 @@ void __init kernel_randomize_memory(void
 		 */
 		vaddr += get_padding(&kaslr_regions[i]);
 		vaddr = round_up(vaddr + 1, PUD_SIZE);
+		if (kaslr_regions[i].end)
+			*kaslr_regions[i].end = __pa(vaddr) - 1;
 		remain_entropy -= entropy;
 	}
 }
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_ma
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
+#ifndef PHYSMEM_END
+# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+#endif
+
 #include <asm/page.h>
 #include <asm/processor.h>
 
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1826,8 +1826,7 @@ static resource_size_t gfr_start(struct
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
 
-		end = min_t(resource_size_t, base->end,
-			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		end = min_t(resource_size_t, base->end, PHYSMEM_END);
 		return end - size + 1;
 	}
 
@@ -1844,8 +1843,7 @@ static bool gfr_continue(struct resource
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+	       addr <= min_t(resource_size_t, base->end, PHYSMEM_END);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_ra
 
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
+	const u64 max_phys = PHYSMEM_END;
 	struct range mhp_range;
 
 	if (need_mapping) {
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struc
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long max_sparsemem_pfn = (PHYSMEM_END + 1) >> PAGE_SHIFT;
 
 	/*
 	 * Sanity checks - do not allow an architecture to pass

