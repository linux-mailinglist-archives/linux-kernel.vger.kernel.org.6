Return-Path: <linux-kernel+bounces-372119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EDA9A44B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD159281892
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51591362;
	Fri, 18 Oct 2024 17:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQBv5G2N"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366F2040BB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272632; cv=none; b=MMZp8Sy8EMxQVA3p0pTcvpA0O3mtn+/wJPcn/Pmt60SrESJXCt5h7RCmU3Tqwtkb6uxuCVayulFdQ2aXtbJlZ7pFjW9oV3mnXG0oNoNWUmD9GEedfu3c7c4bBVdd2Sgr33QsczXPgpn05qSujeuG+IQjWS53GcdS6AFjvp/smGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272632; c=relaxed/simple;
	bh=mAFFiFfCRXSppOaaN188Oqy1JAdt7Lpi79C9uG0gueA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7vahSRBaGr7IqdLY7N8mSKXrLkJuuWSKczMCdke5yqPVOUzwcF15Z0p9U0UiJzkwCH3kNJfpT9deo1qt6YxgK1zaJ7sybR7xNKYS2mBRxkRKdrLfpTs6z1xvS+K2YRiR8s+sCsIZoKlU/U3DRritk/toz0r22BFmyvwl5l/eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQBv5G2N; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e6f085715so1847435b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272629; x=1729877429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7m6nw0SlLNWzWwVTYubL573BHmMjcLP6yP7O1snSbI=;
        b=eQBv5G2NHOwCNsGJmXbNZzxeCtRsMnZ70lqhWVXqiJ5sQep86LTiAzHE7hqHYyjTfN
         QqG4dihxI2c3htnigTDkcqJ24RcryKFf4F/J41TJXWOarkclsZdje6J1aWgOUEP619Iz
         LfwkH/2ocngJbR6nT9LajWn7guzFqPTOe+IAPvEpas3lCbJRVH6A859dAhE01gp13Zbj
         4s4u9IcYtuUj3YgOEV1/WdPrbUzOMI0HO2zg87NtKE/UMTw+qfACGsb0z2HMQyvX+TGn
         XM+riwfgXcs69iVyf9xdaJ7x5CMnh474se9+3BHUmCdNcVrFl8xAfJzHfGu3biQVotVp
         +pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272629; x=1729877429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7m6nw0SlLNWzWwVTYubL573BHmMjcLP6yP7O1snSbI=;
        b=n4ujNcLNhxMPXFAkTGfbXwQeRZViECYBXYXZIRuHj+r6swfm/EsdVfqaA+khOlBtAZ
         vfTayU7Qn5yngxIhrOys+UNTojTQjJ8cR/hHMlVd3wkgFzarrmiaAiNNtUHMY8wJhmcp
         XJ3AwV00ibjKIVAUJ0F0nYZJ+IrLzdn03AiGN5GK4I+YFCGbsrJMOT3a5J5d4HWu+G4O
         s4n54Mf0Xj03sNOdwOI6xCfXCUcMzis/eki90T8td0/y2gCAwURHvKRQE+hZMSNtKvWa
         5vcPc8bfHoueIOz+MWFbKC2jwhZPLhx/rgKkaC0B8SeIXEGqA8QPX6MTN6Yd0g0RJWdz
         c4mA==
X-Forwarded-Encrypted: i=1; AJvYcCVpGA4F/ayYKAOFn/bXJFG0Z/psf8muz8YrsCtoyA2f2PJSvgwrD4ec9POg2yCuOphlHIPyyU+IIBGomCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDwHQHS9rk1wPsGZmp0wNoD8yj/b+ZwKVqN/DzvNYHlQYsOEf
	3gwqPxzjkrlEttoNBu6GafhBE50i7wO3CfNEiDYKFbbNf3mYLSJB
X-Google-Smtp-Source: AGHT+IH29uhXoWddJW63rmOfdUmm3F60bMAd8Lb1nxktQLiJXibpBjYFtPZvdFulLgU3PQV9sp2ESA==
X-Received: by 2002:a05:6a00:3e0f:b0:71e:4a1b:2204 with SMTP id d2e1a72fcca58-71ea331b398mr4152501b3a.25.1729272629392;
        Fri, 18 Oct 2024 10:30:29 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:28 -0700 (PDT)
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
Subject: [PATCH v3 02/12] book3s64/hash: Remove kfence support temporarily
Date: Fri, 18 Oct 2024 22:59:43 +0530
Message-ID: <1761bc39674473c8878dedca15e0d9a0d3a1b528.1729271995.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1729271995.git.ritesh.list@gmail.com>
References: <cover.1729271995.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kfence on book3s Hash on pseries is anyways broken. It fails to boot
due to RMA size limitation. That is because, kfence with Hash uses
debug_pagealloc infrastructure. debug_pagealloc allocates linear map
for entire dram size instead of just kfence relevant objects.
This means for 16TB of DRAM it will require (16TB >> PAGE_SHIFT)
which is 256MB which is half of RMA region on P8.
crash kernel reserves 256MB and we also need 2048 * 16KB * 3 for
emergency stack and some more for paca allocations.
That means there is not enough memory for reserving the full linear map
in the RMA region, if the DRAM size is too big (>=16TB)
(The issue is seen above 8TB with crash kernel 256 MB reservation).

Now Kfence does not require linear memory map for entire DRAM.
It only needs for kfence objects. So this patch temporarily removes the
kfence functionality since debug_pagealloc code needs some refactoring.
We will bring in kfence on Hash support in later patches.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/include/asm/kfence.h     |  5 +++++
 arch/powerpc/mm/book3s64/hash_utils.c | 16 +++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
index fab124ada1c7..f3a9476a71b3 100644
--- a/arch/powerpc/include/asm/kfence.h
+++ b/arch/powerpc/include/asm/kfence.h
@@ -10,6 +10,7 @@
 
 #include <linux/mm.h>
 #include <asm/pgtable.h>
+#include <asm/mmu.h>
 
 #ifdef CONFIG_PPC64_ELF_ABI_V1
 #define ARCH_FUNC_PREFIX "."
@@ -25,6 +26,10 @@ static inline void disable_kfence(void)
 
 static inline bool arch_kfence_init_pool(void)
 {
+#ifdef CONFIG_PPC64
+	if (!radix_enabled())
+		return false;
+#endif
 	return !kfence_disabled;
 }
 #endif
diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index a408ef7d850e..e22a8f540193 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -431,7 +431,7 @@ int htab_bolt_mapping(unsigned long vstart, unsigned long vend,
 			break;
 
 		cond_resched();
-		if (debug_pagealloc_enabled_or_kfence() &&
+		if (debug_pagealloc_enabled() &&
 			(paddr >> PAGE_SHIFT) < linear_map_hash_count)
 			linear_map_hash_slots[paddr >> PAGE_SHIFT] = ret | 0x80;
 	}
@@ -814,7 +814,7 @@ static void __init htab_init_page_sizes(void)
 	bool aligned = true;
 	init_hpte_page_sizes();
 
-	if (!debug_pagealloc_enabled_or_kfence()) {
+	if (!debug_pagealloc_enabled()) {
 		/*
 		 * Pick a size for the linear mapping. Currently, we only
 		 * support 16M, 1M and 4K which is the default
@@ -1134,7 +1134,7 @@ static void __init htab_initialize(void)
 
 	prot = pgprot_val(PAGE_KERNEL);
 
-	if (debug_pagealloc_enabled_or_kfence()) {
+	if (debug_pagealloc_enabled()) {
 		linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
 		linear_map_hash_slots = memblock_alloc_try_nid(
 				linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
@@ -2120,7 +2120,7 @@ void hpt_do_stress(unsigned long ea, unsigned long hpte_group)
 	}
 }
 
-#if defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
+#ifdef CONFIG_DEBUG_PAGEALLOC
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 
 static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
@@ -2194,7 +2194,13 @@ int hash__kernel_map_pages(struct page *page, int numpages, int enable)
 	local_irq_restore(flags);
 	return 0;
 }
-#endif /* CONFIG_DEBUG_PAGEALLOC || CONFIG_KFENCE */
+#else /* CONFIG_DEBUG_PAGEALLOC */
+int hash__kernel_map_pages(struct page *page, int numpages,
+					 int enable)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_PAGEALLOC */
 
 void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
-- 
2.46.0


