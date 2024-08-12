Return-Path: <linux-kernel+bounces-283158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395594EE06
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486A0282AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663917C216;
	Mon, 12 Aug 2024 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xHksR5wg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n8L4MPkK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7317ADEB
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469003; cv=none; b=NBhtxNxSZ7vzfv9FPXRcHTuvUYDsKNOpY7gLG2tFbWLxCfUMfRzxv7N/f0mAykEgOYDR4ATtWob8P1T4wDVinD3dCAn51+vhy23gBHwQ2lJCQRlOkz3CCLDrPpY2dQIcOC/6UWXtov3cvlS0aOE8xDqsyszBM/UqWOC3dFd+S9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469003; c=relaxed/simple;
	bh=WvevEbP8D958O/3vj8JJJL696UZfTwyYvT1LihQGni4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QydkdPOGXY9zlLitF7s0HR3iWqFV4yKYdhhURnVAUz45kG6lGZ6i4nySrthHzXb3RsQsZv/BYEKq9O6bM7O4yfWZ1dGr87b/oRIcnJP05/Ux49aKZ0YfdeRxlAsMi5e83/OAqQBHGoU7qUdnfOyf1gOlbPPdVJdTAzpYvCMNv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xHksR5wg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n8L4MPkK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723468999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A7JxLQ4GaBcBiQHaFCM5RVtLA2sAvh5lCsc+Dmgvh24=;
	b=xHksR5wgjGKQQY+PS1knAh9h2bGDBEZwAhyTB9gxeUZCytQuSvrRMgnguhRGKBCPRPcnmE
	LKG4a7xnAZlBDZM1kf3ahP5i3jFQDWm4hBu7UNxsSQFAsN62zqjgpbs7usvKECMV/hrEpt
	ZLdQsHxmdp6+seozkWAuj/3yDHLTgeyEThRfP/qh/G/tHZAJVhQMfJiw34BZSE5XZPtmpZ
	nzM6SLc1Jr1S/VTbV+k/8ZBu1gm7J2vqEbMLb9/iDg1riqsc3Cu4N0WgkGelO/A74+vkUA
	gA+GuNhOiq7yYGA+snr7fe8O42bg3As1mKsghEt+pDCcRW5PDpBGAQ6vSEOSjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723468999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A7JxLQ4GaBcBiQHaFCM5RVtLA2sAvh5lCsc+Dmgvh24=;
	b=n8L4MPkKy6cTANWZ2r1oPhZEMfH5EWLX5SaXsaCGpg1F7uCQh9onVoGxocK7XzrzTbzISv
	waTUSK1fCm6F6yAg==
To: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, max8rr8@gmail.com,
 linux-kernel@vger.kernel.org, x86@kernel.org, jhubbard@nvidia.com, Kees
 Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <87ikw6rrau.ffs@tglx>
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
 <87ikw6rrau.ffs@tglx>
Date: Mon, 12 Aug 2024 15:23:19 +0200
Message-ID: <87frr9swmw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 12 2024 at 12:03, Thomas Gleixner wrote:
> On Mon, Aug 12 2024 at 17:41, Alistair Popple wrote:
>> The same applies to the rest of the DIRECT_MAP_END users here. Perhaps
>> it would be better to define this as DIRECT_MAP_SIZE and calculate this
>> based off PAGE_OFFSET instead?
>
> Duh, yes. I shouldn't try to write patches at 30C :)

We can avoid the calculation and expose the end of the physical address
space for memory. This time I actually built and ran it :)

Thanks,

        tglx
---
 arch/x86/include/asm/page_64.h          |    1 +
 arch/x86/include/asm/pgtable_64_types.h |    2 ++
 arch/x86/mm/kaslr.c                     |   21 ++++++++++++++++++---
 include/linux/mm.h                      |    4 ++++
 kernel/resource.c                       |    6 ++----
 mm/memory_hotplug.c                     |    2 +-
 mm/sparse.c                             |    2 +-
 7 files changed, 29 insertions(+), 9 deletions(-)

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
@@ -134,10 +134,12 @@ extern unsigned int ptrs_per_p4d;
 # define VMALLOC_START		vmalloc_base
 # define VMALLOC_SIZE_TB	(pgtable_l5_enabled() ? VMALLOC_SIZE_TB_L5 : VMALLOC_SIZE_TB_L4)
 # define VMEMMAP_START		vmemmap_base
+# define PHYSMEM_END		physmem_end
 #else
 # define VMALLOC_START		__VMALLOC_BASE_L4
 # define VMALLOC_SIZE_TB	VMALLOC_SIZE_TB_L4
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
+# define PHYSMEM_END		((1ULL << MAX_PHYSMEM_BITS) - 1)
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
 
 /*
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
+# define PHYSMEM_END	(1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT))
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

