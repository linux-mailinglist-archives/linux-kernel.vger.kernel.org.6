Return-Path: <linux-kernel+bounces-372122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F539A44BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4261C234C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D7820409D;
	Fri, 18 Oct 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfFuc2s0"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E9204F7E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272649; cv=none; b=OtUWfaqXQEmKa6iFmrRehWsaVpXZZRDbnYPfxLQdsxphnuppBdWoTXZinJn/icgmwlyJM/VPeudSjdT0Chjll1NwHrOv03ZSjGJxO1aYDLx5y0cI5nAvD+TaNNE3/+yFzQ5EjpNxFgP0M7BgXks8ntbv05vqLVIJtHYTVWFVrqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272649; c=relaxed/simple;
	bh=E1R3Fouo1t2LcLOJd8YnFBZMjXJ6qjnl450cBxYMuHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OG7ZKhPcLkU9CQZHY30nUMuKYnTWgmeGRdlKcpHI6shJObGdqYGguOJOhS26vfRWXOznK+28fGE8ThcQV6W7c/MkF3nGx/F92bd5JyMj6nBqXUjaYJMqI7nHHRQC+WK3VYUFj0fzXm5DY9ub0ORpnBR+JCZHAA7bjzY2BSKISfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfFuc2s0; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e579abb99so1707090b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272646; x=1729877446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfUSdtWOnTBS3aUaneALBJjz6yO/1MpkxmVLk8hKBQI=;
        b=ZfFuc2s0+HsxfAphN9wVfwOqxCyFrsja5boTwpQha2SC4RTOFzxvqCB7M/M9qhqTDM
         MX+xpirtKgHSewC9BtJdmvwvNyM2NUtoS3srHxMtqDJp0YEGC1EH6NMQ+6Ff53ZIc7Jy
         EfUPRiqTP/Dal9seRt5quBjUMiT6di27oTrLTAHz1JqFFcybwtocFUaBOgbuV8e2aaw9
         nt7+ZKcrE7UUIMxrqQU+bbVq0hmCzAJJVq0vqo2SQfj4WAvKPTaoYhYWLtlX7EYz+FeN
         8BwhYZsLhX6EiHEuZlDoSeUiojJkBWBzumjzfjKz4jWogyBlwiPqkpIVKZ+0K1b4+nLi
         n0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272646; x=1729877446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfUSdtWOnTBS3aUaneALBJjz6yO/1MpkxmVLk8hKBQI=;
        b=Lr1Y/SQZ9ywyB/Ov0yrXxUG55KPQb9exaTg7WFVqRfV5NqySUnCkj4yvDHTewIpH3T
         XHbHNyQO2osdq6fsH240hFjXM0BjjXwbpthhh6F4J9rXQNCLwqy3FI2N4Peh/7nHFDOo
         ggxVnZ5KpwLMTg/Xq7djBpECwxteKlluNtalfWPfdUMkFrITsYZVJykZXuM08UdPoWOG
         WKrnqT/4ZmC8wPmlkBcqMeYDGeiFGZ9oD1elE999jj4/FK1kPo4qeDnG/1zkq7DzvCU4
         blin3Velg7j7NZiLTIRva6bnZ3fbIf1Nb4qtUMUm3lfy6Ujyz32A3asW3IlxceZXailg
         Iw3w==
X-Forwarded-Encrypted: i=1; AJvYcCXjUNfwx9JYNcjEKx/+EAknRsfnNDLap62Yq8N4yFWT9kp4HkEmVzqexukZhaOZOqm+C+TJq3qDEdKxESA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCs2D10vVqg89moDQDbifAcewWVyWRb5W7VnRAPi7FZyztVWiz
	9A7SFuRPvuzKvTitAhxvtm8hmJtMSx5x+ktvmvXSDMdT94htoKSXIv0prrm6
X-Google-Smtp-Source: AGHT+IEH/PHoy0SvfRofUPBZ0xaaeQuP6mqbjcomFuXt7qmLHoVJL01TXC7JEI5XORTcA+JdNts71g==
X-Received: by 2002:a05:6a00:6618:b0:71e:4e2a:38c4 with SMTP id d2e1a72fcca58-71ea31e53d5mr3448284b3a.14.1729272646416;
        Fri, 18 Oct 2024 10:30:46 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:45 -0700 (PDT)
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
Subject: [PATCH v3 05/12] book3s64/hash: Add hash_debug_pagealloc_alloc_slots() function
Date: Fri, 18 Oct 2024 22:59:46 +0530
Message-ID: <d1d5aabe1e4c693a983e59ccf3de08e3c28c5161.1729271995.git.ritesh.list@gmail.com>
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

This adds hash_debug_pagealloc_alloc_slots() function instead of open
coding that in htab_initialize(). This is required since we will be
separating the kfence functionality to not depend upon debug_pagealloc.

Now that everything required for debug_pagealloc is under a #ifdef
config. Bring in linear_map_hash_slots and linear_map_hash_count
variables under the same config too.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 29 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index de3cabd66812..0b63acf62d1d 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -123,8 +123,6 @@ EXPORT_SYMBOL_GPL(mmu_slb_size);
 #ifdef CONFIG_PPC_64K_PAGES
 int mmu_ci_restrictions;
 #endif
-static u8 *linear_map_hash_slots;
-static unsigned long linear_map_hash_count;
 struct mmu_hash_ops mmu_hash_ops __ro_after_init;
 EXPORT_SYMBOL(mmu_hash_ops);
 
@@ -274,6 +272,8 @@ void hash__tlbiel_all(unsigned int action)
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
+static u8 *linear_map_hash_slots;
+static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
 
 static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
@@ -328,6 +328,19 @@ static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
 				     mmu_kernel_ssize, 0);
 }
 
+static inline void hash_debug_pagealloc_alloc_slots(void)
+{
+	if (!debug_pagealloc_enabled())
+		return;
+	linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
+	linear_map_hash_slots = memblock_alloc_try_nid(
+			linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
+			ppc64_rma_size,	NUMA_NO_NODE);
+	if (!linear_map_hash_slots)
+		panic("%s: Failed to allocate %lu bytes max_addr=%pa\n",
+		      __func__, linear_map_hash_count, &ppc64_rma_size);
+}
+
 static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot)
 {
 	if (!debug_pagealloc_enabled())
@@ -361,6 +374,7 @@ int hash__kernel_map_pages(struct page *page, int numpages,
 {
 	return 0;
 }
+static inline void hash_debug_pagealloc_alloc_slots(void) {}
 static inline void hash_debug_pagealloc_add_slot(phys_addr_t paddr, int slot) {}
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
@@ -1223,16 +1237,7 @@ static void __init htab_initialize(void)
 
 	prot = pgprot_val(PAGE_KERNEL);
 
-	if (debug_pagealloc_enabled()) {
-		linear_map_hash_count = memblock_end_of_DRAM() >> PAGE_SHIFT;
-		linear_map_hash_slots = memblock_alloc_try_nid(
-				linear_map_hash_count, 1, MEMBLOCK_LOW_LIMIT,
-				ppc64_rma_size,	NUMA_NO_NODE);
-		if (!linear_map_hash_slots)
-			panic("%s: Failed to allocate %lu bytes max_addr=%pa\n",
-			      __func__, linear_map_hash_count, &ppc64_rma_size);
-	}
-
+	hash_debug_pagealloc_alloc_slots();
 	/* create bolted the linear mapping in the hash table */
 	for_each_mem_range(i, &base, &end) {
 		size = end - base;
-- 
2.46.0


