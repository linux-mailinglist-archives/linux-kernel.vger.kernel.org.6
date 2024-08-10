Return-Path: <linux-kernel+bounces-281984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2717F94DDD2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2670281AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981C316A925;
	Sat, 10 Aug 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ph1ua+Sd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LpQjqRZa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C72146D75
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723311969; cv=none; b=aFPZ3XecOOWMmizgc2131SBNUzHb8d/IUnjvSMp4Q0WFlgQ4XqbepfdvEbUHpcZ9CZs8+i4d0AGn5GglgHFoEEuUPPDKX/oQau/I0DDmb1twipxLHsoODlqGHmD6utug+upGOFT3aUul2Jz1xasaQJkz6u2nlaWZwMoibm7GTR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723311969; c=relaxed/simple;
	bh=JTNMgfQtVwkkVKjqYOBrdQWfVXStXcI2hVHTvE3FmgA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=inhqoosd65KicbxmBntYkP0ilUBPR2mQauuTBPvET8QUK53iVFcoN51/tQjnV0MHp4il7eDV16/7RA38ROlLKRQIeB6j/8ilCkW7jKURRPfKKVEM7vKwYzjlSKtboasRzzTY5ldoPuot7QSO3EKu97qpztKzCWGDco5ki31PPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ph1ua+Sd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LpQjqRZa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723311957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUb4AlgNB58dd6JbJA6Sbywb/cISHzjG2AO1g9F4Vyw=;
	b=ph1ua+SdINW0OUZmAVStRT+BkwSmIqNHj32+viFS0WNeAcP7Cv4OukDFSdjxEnlNB+F37q
	LbydquxkrzGI52j61etfdtWJb234JZUfZFgItNbRz0q3JoGORWrzLZMAe760sUO9GsQ9V3
	LCsnoKCYhkDaHMamzL+fhuq5ge4xk+c9pUqiJMU3Xwvb7B2DhySkcXgEPIi1nscp/hzw73
	wRJ+XSVOapgiMTNCB97iJ72lLHREdCB7YEdQlgORnUfW8ANk4wqVnt3zTaKwpbgiSKdiaS
	DuZdp8iw3kK+j4vTw+PDfnnNB0CZqbUWdHG7VEmUCSZBWAh1luooSIiqYSBHVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723311957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mUb4AlgNB58dd6JbJA6Sbywb/cISHzjG2AO1g9F4Vyw=;
	b=LpQjqRZan8vhTtuW2GTYbdYeVU64eJ5ueqJRTgqJrOap/UZir+KfXrS30J7WIJ5W0YNT0t
	mULUdeEfIkdeYODA==
To: Dan Williams <dan.j.williams@intel.com>, Alistair Popple
 <apopple@nvidia.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 max8rr8@gmail.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 jhubbard@nvidia.com, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/1] x86/ioremap: Use is_vmalloc_addr in iounmap
In-Reply-To: <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230810100011.14552-1-max8rr8@gmail.com> <87le17yu5y.ffs@tglx>
 <66b4eb2a62f6_c1448294b0@dwillia2-xfh.jf.intel.com.notmuch>
 <877ccryor7.ffs@tglx>
 <66b4f305eb227_c144829443@dwillia2-xfh.jf.intel.com.notmuch>
 <66b4f4a522508_c1448294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <87zfpmyhvr.ffs@tglx>
 <66b523ac448e2_c1448294ec@dwillia2-xfh.jf.intel.com.notmuch>
 <87seve4e37.fsf@nvdebian.thelocal>
 <66b59314b3d4_c1448294d3@dwillia2-xfh.jf.intel.com.notmuch>
Date: Sat, 10 Aug 2024 19:45:56 +0200
Message-ID: <87zfpks23v.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Aug 08 2024 at 20:55, Dan Williams wrote:
> Alistair Popple wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> > Thomas Gleixner wrote:
>> >> Wait. MAX_PHYSMEM_BITS is either 46 (4-level) or 52 (5-level), which is
>> >> fully covered by the identity map space.
>> >> 
>> >> So even if the search starts from top of that space, how do we end up
>> >> with high_memory > VMALLOC_START?
>> >> 
>> >> That does not make any sense at all
>> >
>> > Max, or Alistair can you provide more details of how private memory spills over
>> > into the VMALLOC space on these platforms?
>> 
>> Well I was hoping pleading ignorance on x86 memory maps would get me out
>> of having to look too deeply :-) But alas...
>> 
>> It appears the problem originates in KASLR which can cause the VMALLOC
>> region to overlap with the top of the linear map.
>> 
>> > I too would have thought that MAX_PHYSMEM_BITS protects against this?
>> 
>> Me too, until about an hour ago. As noted above
>> request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
>> down. Therefore VMALLOC_START needs to be greater than PAGE_OFFSET + (1
>> << MAX_PHYSMEM_BITS) - 1.  However the default configuration for KASLR
>> as set by RANDOMIZE_MEMORY_PHYSICAL_PADDING is to only provide 10TB
>> above what max_pfn is set to at boot time (and even then only if
>> CONFIG_MEMORY_HOTPLUG is enabled).

Duh.

>> Obviously ZONE_DEVICE memory ends up being way above that and crosses
>> into the VMALLOC region.

So we need to go through all usage sites of MAX_PHYSMEM_BITS and fix
them up...

>> 	@@ -2277,6 +2277,7 @@ config RANDOMIZE_MEMORY_PHYSICAL_PADDING
>> 		depends on RANDOMIZE_MEMORY
>> 		default "0xa" if MEMORY_HOTPLUG
>> 		default "0x0"
>> 	+       range 0x40 0x40 if GET_FREE_REGION
>> 		range 0x1 0x40 if MEMORY_HOTPLUG
>> 		range 0x0 0x40
>> 		help

That reduces the entropy to the minimum and papers over the problem with
4-level paging, but it won't solve the problem on systems with 5-level
paging.

There the 64T of padding are just not cutting it. MAX_PHYSMEM_BITS is 52
for 5 level ....

> 	 @@ -1824,10 +1824,11 @@ static resource_size_t gfr_start(struct resource *base, resource_size_t size,
> 					  resource_size_t align, unsigned long flags)
> 	  {
> 		 if (flags & GFR_DESCENDING) {
> 	 +               u64 kaslr_pad = CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING << 40;
> 			 resource_size_t end;
> 
> 			 end = min_t(resource_size_t, base->end,
> 	 -                           (1ULL << MAX_PHYSMEM_BITS) - 1);
> 	 +                           (1ULL << MAX_PHYSMEM_BITS) - kaslr_pad - 1);
> 			 return end - size + 1;
> 		 }

This needs a fixup of gfr_continue() too, but it does not work at
all. The size of the direct map is calculated as:

       memory_tb = DIV_ROUND_UP(max_pfn << PAGE_SHIFT, 1UL << TB_SHIFT) +
                CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING;

That size is used to calculate the address above which the vmalloc area
is placed.

So assume 6T RAM installed + 10T space for hotplug memory. That means
the vmalloc area can start right above 16T. But 64T - 10T = 54T which is
slightly larger than 16T :)

I came up with the uncompiled below. I fixed up the obvious places, but
did not go through all usage sites of MAX_PHYSMEM_BITS yet.

Thanks,

        tglx
---
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -187,6 +187,8 @@ extern unsigned int ptrs_per_p4d;
 #define KMSAN_MODULES_ORIGIN_START	(KMSAN_MODULES_SHADOW_START + MODULES_LEN)
 #endif /* CONFIG_KMSAN */
 
+#define DIRECT_MAP_END		(VMALLOC_START - 1)
+
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
 #ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_ma
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
 
+#ifndef DIRECT_MAP_END
+# define DIRECT_MAP_END	((1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT)) - 1)
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
+		end = min_t(resource_size_t, base->end, DIRECT_MAP_END);
 		return end - size + 1;
 	}
 
@@ -1844,8 +1843,7 @@ static bool gfr_continue(struct resource
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <= min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+	       addr <= min_t(resource_size_t, base->end, DIRECT_MAP_END);
 }
 
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_ra
 
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;
+	const u64 max_phys = DIRECT_MAP_END;
 	struct range mhp_range;
 
 	if (need_mapping) {
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struc
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_pfn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn = 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long max_sparsemem_pfn = (DIRECT_MAP_END + 1) >> PAGE_SHIFT;
 
 	/*
 	 * Sanity checks - do not allow an architecture to pass

