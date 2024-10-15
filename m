Return-Path: <linux-kernel+bounces-364969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E542199DBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4200287E69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02DF18B48D;
	Tue, 15 Oct 2024 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fN7/qsc1"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00A1714B5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956077; cv=none; b=KWKwZKHYNpp2mofzfIwdhx8l/7Z+cg0LsIk+V4VgHuyGdpbd4FAUJ8NftJix/M9doghvaDnumgOmZl8+WC5+6fQoMYKjRXubfQuqW5xKss3zXPexCkPBzE9DbifPduQk3VOAndyvvk/cX5fCRK3u0eWb4I1SUySl96Hw0wLBBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956077; c=relaxed/simple;
	bh=2xzcSmJ90OeB9AEpfOWapA2ZrBMBcKUdC05kW071KNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5QkCB6ZBLFSUPIqUKEe5f05gSeqPL3m6WuESUPCh5e8lM6132Hl6lwuBQdJPCOrUhDefCaubMj7xui24xSSGyqY5cQVJgz0f7pUIg7o7xJSdpeDp0eHr4+mCOfzBt02Gk0lx/b2HnIB2hNk9NKhi65jbNTjhu479UW/41Gu3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fN7/qsc1; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so1064958a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956075; x=1729560875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpMDq1IEGMMPwRojJ8i4AsUukx9XqidcnS2hx9BDF5Q=;
        b=fN7/qsc1pHAiYSTN8RNhHeD/Vnt7Na8+2BfQZfne7XiawzmOb8fEYE3GlVQnd3Ydha
         pF4xRTcVpQY8c36eQC8bnKN9qv8y/K4yl0qZYyKgemiNmFZtr8QXlPaTrTRXMTBYSO+4
         vEcvjCCY+1po+n9rTgRYogmIAWNEMzD5NDidfwxzyOxfZAQr3+MeQ+QFP70UKJKqtfh7
         3FHgSBu5pnyxtdaJ2W7lpsTUfetVRqY+ErnYqXZAxatEEYfevUoaUau0LGv0FD+5ZPl6
         Fkhk21rvVdDmvSEmWnasc2yg/5J3rSLYFux7arfXBOq2al5c/LX+6nz9eWIMELEzY37q
         rnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956075; x=1729560875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpMDq1IEGMMPwRojJ8i4AsUukx9XqidcnS2hx9BDF5Q=;
        b=d+c2yzFzihmUX3dHpYKSwa+rqwDGQyW1cVCT8N3VclgH//HXr6GpNwSin3hfmtv5Zl
         P2CkBl073gWsegRsxsFwSFL/i9HxNARntKvfLthtnWZ1B59koA4lv5MjQlc+LcwFXNqE
         SLS0I0gPZL0KMNorDRDiWtpGZcuaE0ZCIjaxiGRVylZJmx7LN/JqnTo9+mHwkZwhQ5dh
         sX1un8sfBZMQuHPpw7HqLrSwnqQCPMw0dEwXHqNQP2NgrPfalwEqGLnySdgrsm424HLx
         sx69vlfIrjfbyo+LZVO1TnfvDTXTKu0m6wx6DOllPad6WCAN0EUbTFS2ReS862Zd4i7I
         zttQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnRW+4LSHIK33d6G4xqCIyhmiTbgTgDP0SyyePxn9Ua6X1LqpqRqIuB/SRKe6JU9zGra3nAqEx4TiQycI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIK559nauMFuR85LnA9bcp+8LxcaqSy7SJi8385hZtdMdeWvf
	iFEGCdDsCcaaDNx6k6ll48zM55f2lIfgaOAMJbAsIOR01BmktN4M
X-Google-Smtp-Source: AGHT+IElYihUi5SaCUs0c7LmxcpRmW8kQkNDCDqxwFSQ+3TwWSxwbS4zt9B7T8hR9EdwB2YanBkkig==
X-Received: by 2002:a05:6a21:168e:b0:1cf:3677:1c63 with SMTP id adf61e73a8af0-1d8c95d56c3mr14328100637.25.1728956075539;
        Mon, 14 Oct 2024 18:34:35 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:34 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC RESEND v2 10/13] book3s64/hash: Add kfence functionality
Date: Tue, 15 Oct 2024 07:03:33 +0530
Message-ID: <52f01906734ece9d4f9292c252cf02e7cd267f99.1728954719.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1728954719.git.ritesh.list@gmail.com>
References: <cover.1728954719.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that linear map functionality of debug_pagealloc is made generic,
enable kfence to use this generic infrastructure.

1. Define kfence related linear map variables.
   - u8 *linear_map_kf_hash_slots;
   - unsigned long linear_map_kf_hash_count;
   - DEFINE_RAW_SPINLOCK(linear_map_kf_hash_lock);
2. The linear map size allocated in RMA region is quite small
   (KFENCE_POOL_SIZE >> PAGE_SHIFT) which is 512 bytes by default.
3. kfence pool memory is reserved using memblock_phys_alloc() which has
   can come from anywhere.
   (default 255 objects => ((1+255) * 2) << PAGE_SHIFT = 32MB)
4. The hash slot information for kfence memory gets added in linear map
   in hash_linear_map_add_slot() (which also adds for debug_pagealloc).

Reported-by: Pavithra Prakash <pavrampu@linux.vnet.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kfence.h     |   5 -
 arch/powerpc/mm/book3s64/hash_utils.c | 162 +++++++++++++++++++++++---
 2 files changed, 149 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
index f3a9476a71b3..fab124ada1c7 100644
--- a/arch/powerpc/include/asm/kfence.h
+++ b/arch/powerpc/include/asm/kfence.h
@@ -10,7 +10,6 @@
 
 #include <linux/mm.h>
 #include <asm/pgtable.h>
-#include <asm/mmu.h>
 
 #ifdef CONFIG_PPC64_ELF_ABI_V1
 #define ARCH_FUNC_PREFIX "."
@@ -26,10 +25,6 @@ static inline void disable_kfence(void)
 
 static inline bool arch_kfence_init_pool(void)
 {
-#ifdef CONFIG_PPC64
-	if (!radix_enabled())
-		return false;
-#endif
 	return !kfence_disabled;
 }
 #endif
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index cffbb6499ac4..53e6f3a524eb 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -40,6 +40,7 @@
 #include <linux/random.h>
 #include <linux/elf-randomize.h>
 #include <linux/of_fdt.h>
+#include <linux/kfence.h>
 
 #include <asm/interrupt.h>
 #include <asm/processor.h>
@@ -66,6 +67,7 @@
 #include <asm/pte-walk.h>
 #include <asm/asm-prototypes.h>
 #include <asm/ultravisor.h>
+#include <asm/kfence.h>
 
 #include <mm/mmu_decl.h>
 
@@ -271,7 +273,7 @@ void hash__tlbiel_all(unsigned int action)
 		WARN(1, "%s called on pre-POWER7 CPU\n", __func__);
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
+#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
 static void kernel_map_linear_page(unsigned long vaddr, unsigned long idx,
 				   u8 *slots, raw_spinlock_t *lock)
 {
@@ -325,11 +327,13 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long idx,
 				     mmu_linear_psize,
 				     mmu_kernel_ssize, 0);
 }
+#endif
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
 static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
-static inline void hash_debug_pagealloc_alloc_slots(void)
+static void hash_debug_pagealloc_alloc_slots(void)
 {
 	unsigned long max_hash_count = ppc64_rma_size / 4;
 
@@ -352,7 +356,8 @@ static inline void hash_debug_pagealloc_alloc_slots(void)
 		      __func__, linear_map_hash_count, &ppc64_rma_size);
 }
 
-static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
+static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr,
+							int slot)
 {
 	if (!debug_pagealloc_enabled() || !linear_map_hash_count)
 		return;
@@ -386,20 +391,148 @@ static int hash_debug_pagealloc_map_pages(struct page *page, int numpages,
 	return 0;
 }
 
-int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+#else /* CONFIG_DEBUG_PAGEALLOC */
+static inline void hash_debug_pagealloc_alloc_slots(void) {}
+static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot) {}
+static int __maybe_unused
+hash_debug_pagealloc_map_pages(struct page *page, int numpages, int enable)
 {
-	return hash_debug_pagealloc_map_pages(page, numpages, enable);
+	return 0;
 }
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
-#else /* CONFIG_DEBUG_PAGEALLOC */
-int hash__kernel_map_pages(struct page *page, int numpages,
-					 int enable)
+#ifdef CONFIG_KFENCE
+static u8 *linear_map_kf_hash_slots;
+static unsigned long linear_map_kf_hash_count;
+static DEFINE_RAW_SPINLOCK(linear_map_kf_hash_lock);
+
+static phys_addr_t kfence_pool;
+
+static inline void hash_kfence_alloc_pool(void)
+{
+
+	// allocate linear map for kfence within RMA region
+	linear_map_kf_hash_count = KFENCE_POOL_SIZE >> PAGE_SHIFT;
+	linear_map_kf_hash_slots = memblock_alloc_try_nid(
+					linear_map_kf_hash_count, 1,
+					MEMBLOCK_LOW_LIMIT, ppc64_rma_size,
+					NUMA_NO_NODE);
+	if (!linear_map_kf_hash_slots) {
+		pr_err("%s: memblock for linear map (%lu) failed\n", __func__,
+				linear_map_kf_hash_count);
+		goto err;
+	}
+
+	// allocate kfence pool early
+	kfence_pool = memblock_phys_alloc_range(KFENCE_POOL_SIZE, PAGE_SIZE,
+				MEMBLOCK_LOW_LIMIT, MEMBLOCK_ALLOC_ANYWHERE);
+	if (!kfence_pool) {
+		pr_err("%s: memblock for kfence pool (%lu) failed\n", __func__,
+				KFENCE_POOL_SIZE);
+		memblock_free(linear_map_kf_hash_slots,
+				linear_map_kf_hash_count);
+		linear_map_kf_hash_count = 0;
+		goto err;
+	}
+	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
+
+	return;
+err:
+	pr_info("Disabling kfence\n");
+	disable_kfence();
+}
+
+static inline void hash_kfence_map_pool(void)
+{
+	unsigned long kfence_pool_start, kfence_pool_end;
+	unsigned long prot = pgprot_val(PAGE_KERNEL);
+
+	if (!kfence_pool)
+		return;
+
+	kfence_pool_start = (unsigned long) __va(kfence_pool);
+	kfence_pool_end = kfence_pool_start + KFENCE_POOL_SIZE;
+	__kfence_pool = (char *) kfence_pool_start;
+	BUG_ON(htab_bolt_mapping(kfence_pool_start, kfence_pool_end,
+				    kfence_pool, prot, mmu_linear_psize,
+				    mmu_kernel_ssize));
+	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
+}
+
+static inline void hash_kfence_add_slot(phys_addr_t paddr, int slot)
 {
+	unsigned long vaddr = (unsigned long) __va(paddr);
+	unsigned long lmi = (vaddr - (unsigned long)__kfence_pool)
+					>> PAGE_SHIFT;
+
+	if (!kfence_pool)
+		return;
+	BUG_ON(!is_kfence_address((void *)vaddr));
+	BUG_ON(lmi >= linear_map_kf_hash_count);
+	linear_map_kf_hash_slots[lmi] = slot | 0x80;
+}
+
+static int hash_kfence_map_pages(struct page *page, int numpages, int enable)
+{
+	unsigned long flags, vaddr, lmi;
+	int i;
+
+	WARN_ON_ONCE(!linear_map_kf_hash_count);
+	local_irq_save(flags);
+	for (i = 0; i < numpages; i++, page++) {
+		vaddr = (unsigned long)page_address(page);
+		lmi = (vaddr - (unsigned long)__kfence_pool) >> PAGE_SHIFT;
+
+		/* Ideally this should never happen */
+		if (lmi >= linear_map_kf_hash_count) {
+			WARN_ON_ONCE(1);
+			continue;
+		}
+
+		if (enable)
+			kernel_map_linear_page(vaddr, lmi,
+					       linear_map_kf_hash_slots,
+					       &linear_map_kf_hash_lock);
+		else
+			kernel_unmap_linear_page(vaddr, lmi,
+						 linear_map_kf_hash_slots,
+						 &linear_map_kf_hash_lock);
+	}
+	local_irq_restore(flags);
 	return 0;
 }
-static inline void hash_debug_pagealloc_alloc_slots(void) {}
-static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot) {}
-#endif /* CONFIG_DEBUG_PAGEALLOC */
+#else
+static inline void hash_kfence_alloc_pool(void) {}
+static inline void hash_kfence_map_pool(void) {}
+static inline void hash_kfence_add_slot(phys_addr_t paddr, int slot) {}
+static int __maybe_unused
+hash_kfence_map_pages(struct page *page, int numpages, int enable)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
+int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	void *vaddr = page_address(page);
+
+	if (is_kfence_address(vaddr))
+		return hash_kfence_map_pages(page, numpages, enable);
+	else
+		return hash_debug_pagealloc_map_pages(page, numpages, enable);
+}
+
+static void hash_linear_map_add_slot(phys_addr_t paddr, int slot)
+{
+	if (is_kfence_address(__va(paddr)))
+		hash_kfence_add_slot(paddr, slot);
+	else
+		hash_debug_pagealloc_add_slot(paddr, slot);
+}
+#else
+static void hash_linear_map_add_slot(phys_addr_t paddr, int slot) {}
+#endif
 
 /*
  * 'R' and 'C' update notes:
@@ -559,7 +692,8 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			break;
 
 		cond_resched();
-		hash_debug_pagealloc_add_slot(paddr, ret);
+		// add slot info in debug_pagealloc / kfence linear map
+		hash_linear_map_add_slot(paddr, ret);
 	}
 	return ret < 0 ? ret : 0;
 }
@@ -940,7 +1074,7 @@ static void __init htab_init_page_sizes(void)
 	bool aligned = true;
 	init_hpte_page_sizes();
 
-	if (!debug_pagealloc_enabled()) {
+	if (!debug_pagealloc_enabled_or_kfence()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
@@ -1261,6 +1395,7 @@ static void __init htab_initialize(void)
 	prot = pgprot_val(PAGE_KERNEL);
 
 	hash_debug_pagealloc_alloc_slots();
+	hash_kfence_alloc_pool();
 	/* create bolted the linear mapping in the hash table */
 	for_each_mem_range(i, &base, &end) {
 		size = end - base;
@@ -1277,6 +1412,7 @@ static void __init htab_initialize(void)
 		BUG_ON(htab_bolt_mapping(base, base + size, __pa(base),
 				prot, mmu_linear_psize, mmu_kernel_ssize));
 	}
+	hash_kfence_map_pool();
 	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
 
 	/*
-- 
2.46.0


