Return-Path: <linux-kernel+bounces-364965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD04899DBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5D21F20B68
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF86185920;
	Tue, 15 Oct 2024 01:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcSwee0A"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CA15B96E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956058; cv=none; b=U8veeoXy6BCOu/7P3/K2OEpgcA96FAJuxWYpalrZjtRUW74OHmIN5SUAlNOUbTVB/9E7IrCymp1MQ0IIHGCJaN2D0X2uK24uYSeLZqR3S+RDXsP2RjQGo+R+Aq8VHsvIUap7GBlusQ3QzOKLrGFiLHjzTu0TIG905mosYJ4uSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956058; c=relaxed/simple;
	bh=ll46Y5ohND+TUmqRmSlDtnD60Fmr6r5zMc07Tyy0M5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIbk9rTpQHqkdF8wqKHAENuiv4pw/shY9JJhvTyuhLqJ0HnZaaK+96oUav3dTBDfdQPt//QfAhc2Jf1zdk6KtAcl8fI+tpgau84mrn3NBeZ2xdFlrqt1P1uex8CTyfXjn46VEuEZZn0zbSizZjPhnPqVlaVMFNnEJS4+wzW6AF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcSwee0A; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e5a62031aso1363786b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956056; x=1729560856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MHsxmP9bN1bxx4msR28qZ2la9zK0wSY8EDrce3K+zQ=;
        b=TcSwee0AaZMkdxLVwzxlbaCFTTjtbU7AhSy9yINvy4IfMGOE4c82oU0zhHOqVB834O
         41qbtFENQW9lrTe4wFZ7h4u6Wq4LqCdwhqmewjF/3Wqq/wElJ9Y2/ngznkmbyg4V9dUg
         kssewrzOOsoZxeYeuoXi+QHY1eiYEEw0UMViCkil4C4OM36JYhhRXfQCQmggPYe53kkJ
         lAVVTeOFMvbYmyu/Ay0Op4FYgTPM7eSaEkIJxGeC6TEVHckyZACnnCiNgVOCwPO2gXHR
         pkEtt6pcGVbqwiXXBDOrizVoTsl8LzgwVEoH99yRdgBve29sDXB0Ah+pyQ7ttgYSTRnt
         nTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956056; x=1729560856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MHsxmP9bN1bxx4msR28qZ2la9zK0wSY8EDrce3K+zQ=;
        b=PksjHIEQ5fpoNN45qGVpFZYgivfS0remIBm0UPlftaSFRAnYyf52+0BnSbJkjtJQVb
         9iXaoT1l51bOwphv1PIBRvDDtuHswhIklmeHolM24wPM0xG0wG+LSabX5xJtI27dKU4X
         r58gEP7tU4F6+buObXE+6tFijUeyRRJrW2u3VOf+DZetndaVmsXSE6yIjGSXbV75ydOp
         yQvacHzImxkGngxQU9MvpkTJhoq3wALCVNvEBXkwhEVhUZO+vyGPkwmZJxN8eQTZp4KV
         1aYOjQaeVRBwCYRgcfZodrWWipq8WOR8Yg9yrTKTVodkN9j+cBJaTUPYIzaxg85NFerj
         2ATA==
X-Forwarded-Encrypted: i=1; AJvYcCVRl1lBk3tVjy0UVz9cFA0FZX5mTTtBsJKJupRz/m8bMRqegR2UMUVbbFL7c3z0zr4Od91DNu7Kz+qXgbs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxysv6NMaFO1nmT8toVKZtp+TIYTg2C2ljnOCePb9Vct2KszNP7
	XpeogH29r+k+2TdZOf08Vke6IcHs5/DquMrAnrLIg6t9iLWWGHb/
X-Google-Smtp-Source: AGHT+IEaRbtvLZbSifnrZqi1CARugZbYpE5zHqXON9KkesVGZbR8E08Sd3QxolQeAT6rqf3d5xyTkQ==
X-Received: by 2002:a05:6a20:9f47:b0:1d0:7df2:cf39 with SMTP id adf61e73a8af0-1d8c9577ca1mr13971673637.7.1728956056191;
        Mon, 14 Oct 2024 18:34:16 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:15 -0700 (PDT)
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
Subject: [RFC RESEND v2 06/13] book3s64/hash: Add hash_debug_pagealloc_alloc_slots() function
Date: Tue, 15 Oct 2024 07:03:29 +0530
Message-ID: <4245e8392bdcb0ea168b9700d356f75575511536.1728954719.git.ritesh.list@gmail.com>
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
index 6e3860224351..030c120d1399 100644
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


