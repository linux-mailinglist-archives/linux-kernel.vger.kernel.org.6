Return-Path: <linux-kernel+bounces-364961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035AC99DBB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54E64B22CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA316FF4E;
	Tue, 15 Oct 2024 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5k2DIow"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAA16DC36
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956043; cv=none; b=UqKX/s+NnijTKXVY4moFitEFZhsWd/P1CJPlP21XLwon3BDiVderrTWq9B/WlIeTDb1jFMCdizn02OVQ3SqYbdY7nu4CBJNPPTK3GPmFegXEfPxaheW50vdbCvyByhW/mYTeHjAeTjtLA+DdOoKYlhKS/CK0SbChYUqH532gf9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956043; c=relaxed/simple;
	bh=L3Ba7Q5bU38/cxIB9cSQHYQb0MRnuxWke3X0IYEi7MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dif1uGsk/TVJYDVWbLh0t9eLs8dS+9D9qJEPeLQc7FCRxw/Rl29/Oe0m72FTUzCpToNqdNNJf4bN6vtIUvL6RWSUCCDGLdCLZGruDIao53lIf8wiGxtS+5wUIyCEk7dCrKzcI1PK1ZNtphpKY19WFU76Yc8RAcYHBktty8c272E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5k2DIow; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e681bc315so921843b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956042; x=1729560842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gdBU6NTSnQ45ASWgUOhpCdQmMAIjthCFPvKHCG5k1I=;
        b=K5k2DIowlLCmzXEY03Ak8wOeUb/pQhIf0ur7dYq3hpkpNsqQ2Rtukh9HcL3mZXAKK/
         +uPck8u2XS9GJoBjVDWkPAdj7QehBwhg218JgYnETvWfcGlLiUYe6LpsbYyR3bHiwTGv
         G5y/LTYc5ZYHCulz6kSObuij+NsrjPWkAJoA15hrJa1HAmdoIdbcxGB9ni7iUytf2Vvr
         0dBntlEWYi3fw7s9AGgqmxkMph7NGghj++O1JHoOdandIyVr511SNKxPrOunNClettFM
         EbbP0h/SDt/deETGH+8V7UHoisCZoCZq/4XXZMmqgDunoiR2uKbH1xB3p/TNoOpmeujE
         PIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956042; x=1729560842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gdBU6NTSnQ45ASWgUOhpCdQmMAIjthCFPvKHCG5k1I=;
        b=iBBoQWS7JAbuVHQ9l7XW0WrR8JD4Ou6z+AxgfG81FglstNIC8Prk+LACdYd6NOMqry
         BXfmFJA6Tfo78vEHltfvxxluHMmeNNUb1+jRggi+ooG2JZ+EMfZL5sFQbtCmcu7CrkUE
         CWqeak96PV3wy+KeTUZo7NFgAIEKIJOldD0SBNq7dbrPAzIr+Q3xsj0yjw+hLnreR7Id
         yIZ1NcEdLaSN5Sc+OBk63l5OXnBryry5nghG1e/zyvYRgdr2Rz4wcgmnEafHElTo3kf4
         jylqpUFZ4D9hFAM/3X1PoffJ3y1rMS/MuVjCVeijb8S7Wqng2U35JkVsjwFqfx/DTUpo
         4+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGqDEbL4IB++L1iW8DEuChni/rT9iZJVvD05Qp47dx/vRSZAJr7YGZFWFbSNVnIgAzsMoquT7dFUuRKsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTS/Ni45/82gdULJkDzYgSs++uwIPDxf6d3Ddk3NhxIVcFLB5d
	nZvrGyK/7y46Jclur+6+wy1ZjP7sUD5vWWd55j5BPTJwOgVlamzS
X-Google-Smtp-Source: AGHT+IEiFeaAHOWvlSRTf6MSOaFyHyrBNKW3yk4oAKnnkBoJktpp0QXSxa/Okqxxx4ycP0dnhBWBFw==
X-Received: by 2002:a62:f252:0:b0:71e:5709:2330 with SMTP id d2e1a72fcca58-71e570923afmr12036633b3a.7.1728956041587;
        Mon, 14 Oct 2024 18:34:01 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:01 -0700 (PDT)
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
Subject: [RFC RESEND v2 03/13] book3s64/hash: Remove kfence support temporarily
Date: Tue, 15 Oct 2024 07:03:26 +0530
Message-ID: <00ba1fdbf7e135fab9d3d1c8872674079452446a.1728954719.git.ritesh.list@gmail.com>
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
index e1eadd03f133..296bb74dbf40 100644
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


