Return-Path: <linux-kernel+bounces-333061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D51A97C300
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF47283A44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAED11CA1;
	Thu, 19 Sep 2024 02:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQgwLw4R"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A8210FF
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714616; cv=none; b=Gs4+xFAgcyYqTHmzUt+cpcUoJkqzUlHYV74IwR0+THnFMCcjcAh+ATxA6yKo6h14FO9CUyhrLecv1dT25Vr75D4jdKzjrYdaCL23Zqpy5XnUaE2FJrCLhgxodZXKbVFFmurq+oUECiMmgpbd6SEdmraNP7xAI46BNJNr4LCBRjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714616; c=relaxed/simple;
	bh=ll46Y5ohND+TUmqRmSlDtnD60Fmr6r5zMc07Tyy0M5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUWgzejn6qJth8Op5ntpUoMQk9hvIM8L3A31FG8PtfUQh2mRfU4B1YGQ4Td6nwDTOC+OemStbiL8jlk79nuJgdZfquQbnv/yMGgFXsRDWh8M+wqYwN8wJOmhSm7iu0I+nYe/SA1fmCvvRtUyUnnt85myrI8q1z0ZyVtx1lYR/zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQgwLw4R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2068bee21d8so4131005ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714615; x=1727319415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/MHsxmP9bN1bxx4msR28qZ2la9zK0wSY8EDrce3K+zQ=;
        b=KQgwLw4Rx2irx/shbP0Ng1/6rkR2AUHbGx2qGWjqqci5ACLwb7LsXQJapqHR+Ki6dV
         P3iZEbfPc6dCDe7KaIb0HICbVxExA3jEb5qlXT2GQWeQW2vUeLjxSjvHVwl/HfTVpz5E
         dsXLv4qguBpYcaAlnLCzxAbuTppjmEUzAwRpQbOvXrI24WtLsjBe6IhzGjSQN2+6L+NI
         Xlriw0JVecBrrv55+H9UYxEMLsM3Rh5nrJcRcTTRZ1VKIXfrZdAsJRPM2pCKqdU4e7wS
         GiNwbFBZhqOGcZwDJuWBI6JqrVoIDsTUPTZ3qtTC84yI/cK3rKrIbjc7j8VztKAASUOh
         vu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714615; x=1727319415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/MHsxmP9bN1bxx4msR28qZ2la9zK0wSY8EDrce3K+zQ=;
        b=OfLItC9SkChnXTpid1ZmwSxXNkd1Zd8Agy8Z8iByrxSwF0+Rm9d8Bl7DXsuDdbc08E
         3OPhl+Anx4isHHiE2J/cAecF5+oN0tQYvfK0Fc/q+b5ypl0G7EaVu/6LzGMZir6kJyZn
         ZpvTBHJNHYhi54C/5l5qePSsJ2MpHh5shk8rzgZGQLNBQfPNO8yKNchsE1Pnzrf8+7VT
         PenrBlHiPINi+E0v2NxA6Wa6EWkfjcriGpnRhQeiC5wUQ+l6vxzpxTbEnHYbA25k5Hwm
         /ksdlzPz184TyzpxZpxo021uADV7al5oK6mY+CxWh9mhd+Te3dwF3lL4YW5qUbLUYSHK
         EEHA==
X-Forwarded-Encrypted: i=1; AJvYcCWFRGuWCRbm80y5PE5nE4iKHmDA2CNRgMaWS8clb+hvzewpP6KP+PdOpRH3TL4CfRNn0MRm+gx4hFIuFS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4V5SJByG9UY+TBdx0PoMIJmvRXuZpwTc9qOC1i4VYJrPF7AwH
	zCrZPHwxVcRRXU6rys/V/8zmIevxMYEqHd3UT55qKrwMo5vXE6LH
X-Google-Smtp-Source: AGHT+IEGxeiVxZh5o9vYhwB8mBVBHLv/pSg64zA2+3t1GDmylunq7BBEStCgtPZymo2nVWUT4NL8Bw==
X-Received: by 2002:a17:902:f70c:b0:206:8acc:8871 with SMTP id d9443c01a7336-2076e39c331mr311700805ad.31.1726714614667;
        Wed, 18 Sep 2024 19:56:54 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:56:54 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFC v2 06/13] book3s64/hash: Add hash_debug_pagealloc_alloc_slots() function
Date: Thu, 19 Sep 2024 08:26:04 +0530
Message-ID: <47af6bef68ce0a82da4694174f004d11519e8757.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
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


