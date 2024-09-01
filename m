Return-Path: <linux-kernel+bounces-310207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8EF96764A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 13:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 942832820DC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C10817DFEB;
	Sun,  1 Sep 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="emEpfFDj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kEYHMedW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2561791ED
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725191054; cv=none; b=ZMogN31oYREYb7z1w+ttT2yJWdfDMC66y6h1imNLzxlFsMqda2PM6GGHfBEFB5NnMo8Cmta7E3a7n6eIvTxdISYnQIfOF9AoYUwN04nhHCvWSVuzQey70cMLgctC85zTDFLrCqvjtC9Ngbu8LhCvq/H5QbAZ+XE+txhsdDD2XH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725191054; c=relaxed/simple;
	bh=TfXVxu2wGnrJbIRyBM1qi2scKclXz48a4KzlmSscYUM=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=qlrQqP79c/zgr4Jm1D0AAhb9EcZSQ/KQfynUMIE8xNCnAYh/Yqptg7MxW9IiwfXiiKotco8qawAPhc87HI+Acvacf+H3in0aGp49nSeiZ9Hiiv6IdL2RVfTtrPoT1EDD96HuDg13sUHRBxSLkyn3X4t3Nen7lYE9QesejgNPnTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=emEpfFDj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kEYHMedW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725191045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=jBvRx7Dqom4DUsoxmIFX8PgAUrtbN4OX8yu7BoxxQ2Q=;
	b=emEpfFDjtQy3alfkXWz6tjpJMCHvwod10E/bJGCxxi+gXXSzVM1xwWRoHK7KPMMX6GxMc8
	9Ff+gxaDnhJ+UDRTtVObX76kc1AeNCnkOfF1BuDvyOFYvp3Y5FNPh31sX05SIXXwzsVssV
	eBB+DcLJNe8EH+kc0UVjYREGzJji5CUnR1bB5SpLDHZsWyvMFAHOU+5B9eieXmqU29NuoG
	gDRGVJJUGX0s7FkgSNPwRqIjbv/bQ0rFiSBVHMDNRr0nhaNUYbQw1ztqbNPzoRF28Yj2X9
	R+5fg+AQtwupc5L9g48J1rfBTwPNdf29GuPwYlsN/ibh9LFW2wJUmV+Z4xLCxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725191045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=jBvRx7Dqom4DUsoxmIFX8PgAUrtbN4OX8yu7BoxxQ2Q=;
	b=kEYHMedWgPAX1h5LaRIzNerPGSAwDO5TuAIlVH6chJfUT8YrdeDw0CI3DE9BCG7RE659rG
	ImZ1qNX0YZocRwCQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v6.11-rc7
References: <172519097408.1871736.16401401125691449823.tglx@xen13>
Message-ID: <172519097872.1871736.3370698904129727994.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  1 Sep 2024 13:44:04 +0200 (CEST)

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-=
09-01

up to:  a547a5880cba: x86/resctrl: Fix arch_mbm_* array overrun on SNC


A set of X86 fixes:

  - x2apic_disable() clears x2apic_state and x2apic_mode unconditionally,
    even when the state is X2APIC_ON_LOCKED, which prevents the kernel to
    disable it thereby creating inconsistent state.

    Reorder the logic so it actually works correctly

  - The XSTATE logic for handling LBR is incorrect as it assumes that
    XSAVES supports LBR when the CPU supports LBR. In fact both conditions
    need to be true. Otherwise the enablement of LBR in the IA32_XSS MSR
    fails and subsequently the machine crashes on the next XRSTORS
    operation because IA32_XSS is not initialized.

    Cache the XSTATE support bit during init and make the related functions
    use this cached information and the LBR CPU feature bit to cure this.

  - Cure a long standing bug in KASLR

    KASLR uses the full address space between PAGE_OFFSET and vaddr_end to
    randomize the starting points of the direct map, vmalloc and vmemmap
    regions.  It thereby limits the size of the direct map by using the
    installed memory size plus an extra configurable margin for hot-plug
    memory.  This limitation is done to gain more randomization space
    because otherwise only the holes between the direct map, vmalloc,
    vmemmap and vaddr_end would be usable for randomizing.
   =20
    The limited direct map size is not exposed to the rest of the kernel, so
    the memory hot-plug and resource management related code paths still
    operate under the assumption that the available address space can be
    determined with MAX_PHYSMEM_BITS.

    request_free_mem_region() allocates from (1 << MAX_PHYSMEM_BITS) - 1
    downwards.  That means the first allocation happens past the end of the
    direct map and if unlucky this address is in the vmalloc space, which
    causes high_memory to become greater than VMALLOC_START and consequently
    causes iounmap() to fail for valid ioremap addresses.

    Cure this by exposing the end of the direct map via PHYSMEM_END and use
    that for the memory hot-plug and resource management related places
    instead of relying on MAX_PHYSMEM_BITS. In the KASLR case PHYSMEM_END
    maps to a variable which is initialized by the KASLR initialization and
    otherwise it is based on MAX_PHYSMEM_BITS as before.

  - Prevent a data leak in mmio_read(). The TDVMCALL exposes the value of
    an initialized variabled on the stack to the VMM. The variable is only
    required as output value, so it does not have to exposed to the VMM in
    the first place.

  - Prevent an array overrun in the resource control code on systems with
    Sub-NUMA Clustering enabled because the code failed to adjust the index
    by the number of SNC nodes per L3 cache.

Thanks,

	tglx

------------------>
Kirill A. Shutemov (1):
      x86/tdx: Fix data leak in mmio_read()

Mitchell Levy (1):
      x86/fpu: Avoid writing LBR bit to IA32_XSS unless supported

Peter Newman (1):
      x86/resctrl: Fix arch_mbm_* array overrun on SNC

Thomas Gleixner (1):
      x86/kaslr: Expose and use the end of the physical memory address space

Yuntao Wang (1):
      x86/apic: Make x2apic_disable() work correctly


 arch/x86/coco/tdx/tdx.c                 |  1 -
 arch/x86/include/asm/fpu/types.h        |  7 +++++++
 arch/x86/include/asm/page_64.h          |  1 +
 arch/x86/include/asm/pgtable_64_types.h |  4 ++++
 arch/x86/include/asm/resctrl.h          |  6 ------
 arch/x86/kernel/apic/apic.c             | 11 ++++++-----
 arch/x86/kernel/cpu/resctrl/core.c      |  8 ++++++++
 arch/x86/kernel/fpu/xstate.c            |  3 +++
 arch/x86/kernel/fpu/xstate.h            |  4 ++--
 arch/x86/mm/init_64.c                   |  4 ++++
 arch/x86/mm/kaslr.c                     | 32 ++++++++++++++++++++++++++------
 include/linux/mm.h                      |  4 ++++
 include/linux/resctrl.h                 |  1 +
 kernel/resource.c                       |  6 ++----
 mm/memory_hotplug.c                     |  2 +-
 mm/sparse.c                             |  2 +-
 16 files changed, 70 insertions(+), 26 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 078e2bac2553..da8b66dce0da 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -389,7 +389,6 @@ static bool mmio_read(int size, unsigned long addr, unsig=
ned long *val)
 		.r12 =3D size,
 		.r13 =3D EPT_READ,
 		.r14 =3D addr,
-		.r15 =3D *val,
 	};
=20
 	if (__tdx_hypercall(&args))
diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/type=
s.h
index eb17f31b06d2..de16862bf230 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -591,6 +591,13 @@ struct fpu_state_config {
 	 * even without XSAVE support, i.e. legacy features FP + SSE
 	 */
 	u64 legacy_features;
+	/*
+	 * @independent_features:
+	 *
+	 * Features that are supported by XSAVES, but not managed as part of
+	 * the FPU core, such as LBR
+	 */
+	u64 independent_features;
 };
=20
 /* FPU state configuration information */
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index af4302d79b59..f3d257c45225 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -17,6 +17,7 @@ extern unsigned long phys_base;
 extern unsigned long page_offset_base;
 extern unsigned long vmalloc_base;
 extern unsigned long vmemmap_base;
+extern unsigned long physmem_end;
=20
 static __always_inline unsigned long __phys_addr_nodebug(unsigned long x)
 {
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/p=
gtable_64_types.h
index 9053dfe9fa03..a98e53491a4e 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -140,6 +140,10 @@ extern unsigned int ptrs_per_p4d;
 # define VMEMMAP_START		__VMEMMAP_BASE_L4
 #endif /* CONFIG_DYNAMIC_MEMORY_LAYOUT */
=20
+#ifdef CONFIG_RANDOMIZE_MEMORY
+# define PHYSMEM_END		physmem_end
+#endif
+
 /*
  * End of the region for which vmalloc page tables are pre-allocated.
  * For non-KMSAN builds, this is the same as VMALLOC_END.
diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
index 12dbd2588ca7..8b1b6ce1e51b 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -156,12 +156,6 @@ static inline void resctrl_sched_in(struct task_struct *=
tsk)
 		__resctrl_sched_in(tsk);
 }
=20
-static inline u32 resctrl_arch_system_num_rmid_idx(void)
-{
-	/* RMID are independent numbers for x86. num_rmid_idx =3D=3D num_rmid */
-	return boot_cpu_data.x86_cache_max_rmid + 1;
-}
-
 static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *r=
mid)
 {
 	*rmid =3D idx;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 66fd4b2a37a3..373638691cd4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1775,12 +1775,9 @@ static __init void apic_set_fixmap(bool read_apic);
=20
 static __init void x2apic_disable(void)
 {
-	u32 x2apic_id, state =3D x2apic_state;
+	u32 x2apic_id;
=20
-	x2apic_mode =3D 0;
-	x2apic_state =3D X2APIC_DISABLED;
-
-	if (state !=3D X2APIC_ON)
+	if (x2apic_state < X2APIC_ON)
 		return;
=20
 	x2apic_id =3D read_apic_id();
@@ -1793,6 +1790,10 @@ static __init void x2apic_disable(void)
 	}
=20
 	__x2apic_disable();
+
+	x2apic_mode =3D 0;
+	x2apic_state =3D X2APIC_DISABLED;
+
 	/*
 	 * Don't reread the APIC ID as it was already done from
 	 * check_x2apic() and the APIC driver still is a x2APIC variant,
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 1930fce9dfe9..8591d53c144b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -119,6 +119,14 @@ struct rdt_hw_resource rdt_resources_all[] =3D {
 	},
 };
=20
+u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+
+	/* RMID are independent numbers for x86. num_rmid_idx =3D=3D num_rmid */
+	return r->num_rmid;
+}
+
 /*
  * cache_alloc_hsw_probe() - Have to probe for Intel haswell server CPUs
  * as they do not have CPUID enumeration support for Cache allocation.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026fee5e0..1339f8328db5 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -788,6 +788,9 @@ void __init fpu__init_system_xstate(unsigned int legacy_s=
ize)
 		goto out_disable;
 	}
=20
+	fpu_kernel_cfg.independent_features =3D fpu_kernel_cfg.max_features &
+					      XFEATURE_MASK_INDEPENDENT;
+
 	/*
 	 * Clear XSAVE features that are disabled in the normal CPUID.
 	 */
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c53dcc..afb404cd2059 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -62,9 +62,9 @@ static inline u64 xfeatures_mask_supervisor(void)
 static inline u64 xfeatures_mask_independent(void)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_ARCH_LBR))
-		return XFEATURE_MASK_INDEPENDENT & ~XFEATURE_MASK_LBR;
+		return fpu_kernel_cfg.independent_features & ~XFEATURE_MASK_LBR;
=20
-	return XFEATURE_MASK_INDEPENDENT;
+	return fpu_kernel_cfg.independent_features;
 }
=20
 /* XSAVE/XRSTOR wrapper functions */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index d8dbeac8b206..ff253648706f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -958,8 +958,12 @@ static void update_end_of_memory_vars(u64 start, u64 siz=
e)
 int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	      struct mhp_params *params)
 {
+	unsigned long end =3D ((start_pfn + nr_pages) << PAGE_SHIFT) - 1;
 	int ret;
=20
+	if (WARN_ON_ONCE(end > PHYSMEM_END))
+		return -ERANGE;
+
 	ret =3D __add_pages(nid, start_pfn, nr_pages, params);
 	WARN_ON_ONCE(ret);
=20
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 37db264866b6..230f1dee4f09 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -47,13 +47,24 @@ static const unsigned long vaddr_end =3D CPU_ENTRY_AREA_B=
ASE;
  */
 static __initdata struct kaslr_memory_region {
 	unsigned long *base;
+	unsigned long *end;
 	unsigned long size_tb;
 } kaslr_regions[] =3D {
-	{ &page_offset_base, 0 },
-	{ &vmalloc_base, 0 },
-	{ &vmemmap_base, 0 },
+	{
+		.base	=3D &page_offset_base,
+		.end	=3D &physmem_end,
+	},
+	{
+		.base	=3D &vmalloc_base,
+	},
+	{
+		.base	=3D &vmemmap_base,
+	},
 };
=20
+/* The end of the possible address space for physical memory */
+unsigned long physmem_end __ro_after_init;
+
 /* Get size in bytes used by the memory region */
 static inline unsigned long get_padding(struct kaslr_memory_region *region)
 {
@@ -82,6 +93,8 @@ void __init kernel_randomize_memory(void)
 	BUILD_BUG_ON(vaddr_end !=3D CPU_ENTRY_AREA_BASE);
 	BUILD_BUG_ON(vaddr_end > __START_KERNEL_map);
=20
+	/* Preset the end of the possible address space for physical memory */
+	physmem_end =3D ((1ULL << MAX_PHYSMEM_BITS) - 1);
 	if (!kaslr_memory_enabled())
 		return;
=20
@@ -128,11 +141,18 @@ void __init kernel_randomize_memory(void)
 		vaddr +=3D entropy;
 		*kaslr_regions[i].base =3D vaddr;
=20
+		/* Calculate the end of the region */
+		vaddr +=3D get_padding(&kaslr_regions[i]);
 		/*
-		 * Jump the region and add a minimum padding based on
-		 * randomization alignment.
+		 * KASLR trims the maximum possible size of the
+		 * direct-map. Update the physmem_end boundary.
+		 * No rounding required as the region starts
+		 * PUD aligned and size is in units of TB.
 		 */
-		vaddr +=3D get_padding(&kaslr_regions[i]);
+		if (kaslr_regions[i].end)
+			*kaslr_regions[i].end =3D __pa_nodebug(vaddr - 1);
+
+		/* Add a minimum padding based on randomization alignment. */
 		vaddr =3D round_up(vaddr + 1, PUD_SIZE);
 		remain_entropy -=3D entropy;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..b3864156eaa4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -97,6 +97,10 @@ extern const int mmap_rnd_compat_bits_max;
 extern int mmap_rnd_compat_bits __read_mostly;
 #endif
=20
+#ifndef PHYSMEM_END
+# define PHYSMEM_END	((1ULL << MAX_PHYSMEM_BITS) - 1)
+#endif
+
 #include <asm/page.h>
 #include <asm/processor.h>
=20
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index b0875b99e811..d94abba1c716 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -248,6 +248,7 @@ struct resctrl_schema {
=20
 /* The number of closid supported by this resource regardless of CDP */
 u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
+u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
=20
 /*
diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..a83040fde236 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1826,8 +1826,7 @@ static resource_size_t gfr_start(struct resource *base,=
 resource_size_t size,
 	if (flags & GFR_DESCENDING) {
 		resource_size_t end;
=20
-		end =3D min_t(resource_size_t, base->end,
-			    (1ULL << MAX_PHYSMEM_BITS) - 1);
+		end =3D min_t(resource_size_t, base->end, PHYSMEM_END);
 		return end - size + 1;
 	}
=20
@@ -1844,8 +1843,7 @@ static bool gfr_continue(struct resource *base, resourc=
e_size_t addr,
 	 * @size did not wrap 0.
 	 */
 	return addr > addr - size &&
-	       addr <=3D min_t(resource_size_t, base->end,
-			     (1ULL << MAX_PHYSMEM_BITS) - 1);
+	       addr <=3D min_t(resource_size_t, base->end, PHYSMEM_END);
 }
=20
 static resource_size_t gfr_next(resource_size_t addr, resource_size_t size,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 66267c26ca1b..951878ab627a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1681,7 +1681,7 @@ struct range __weak arch_get_mappable_range(void)
=20
 struct range mhp_get_pluggable_range(bool need_mapping)
 {
-	const u64 max_phys =3D (1ULL << MAX_PHYSMEM_BITS) - 1;
+	const u64 max_phys =3D PHYSMEM_END;
 	struct range mhp_range;
=20
 	if (need_mapping) {
diff --git a/mm/sparse.c b/mm/sparse.c
index e4b830091d13..0c3bff882033 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -129,7 +129,7 @@ static inline int sparse_early_nid(struct mem_section *se=
ction)
 static void __meminit mminit_validate_memmodel_limits(unsigned long *start_p=
fn,
 						unsigned long *end_pfn)
 {
-	unsigned long max_sparsemem_pfn =3D 1UL << (MAX_PHYSMEM_BITS-PAGE_SHIFT);
+	unsigned long max_sparsemem_pfn =3D (PHYSMEM_END + 1) >> PAGE_SHIFT;
=20
 	/*
 	 * Sanity checks - do not allow an architecture to pass


