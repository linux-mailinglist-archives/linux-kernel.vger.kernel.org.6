Return-Path: <linux-kernel+bounces-372120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EF19A44B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CBAB22824
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0660220494C;
	Fri, 18 Oct 2024 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cet/MpG4"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099C204943
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272637; cv=none; b=DxSB5t90bM+qZL30vzwWSHsENvhB0/WEWG57xc2nrBSgu2RInymSJqN+zvniJxRPqE0bN+NTtruc42ucIpDz01cEZdDGJyF1ziCKBq58dnzz1OBbQG3Gd2sks+zGTXLftAdKnOtl2K39qX3dx/SH89eJpFGQpI3ITKDpDxACnWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272637; c=relaxed/simple;
	bh=qf4m6j7PPG75kG42Tc21klYl7CuPttrtdBNmIdfIt/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHoxkEUl0L6Q8wKFNKgIbp7cuhLJtGJ8GOpe/ymUJCVvDJSExNTuIKQfPgmaqEYNxGtPgqsktY3jzsrOd9BnHyAx0dZ/csBgnO2TgkkXmUvSq0ZggbCbnSBOLgph8wwTNnfZIpmwjqzQT2NjLXMjyEXub8GN2foWFzgWMwrUp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cet/MpG4; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso2453300a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272634; x=1729877434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKeOGzBwhkORap+bFaXRZ5k5ETEZTGkTXkc6r1BfTnM=;
        b=Cet/MpG4kvfdCQe8kcz0OglK7FZtxONAfapZkQnAjRLbCPXKA+tuGZp5N3vzZsC2LK
         Y3XFF+G11g9TnuZBPgznfYFL8cOvqQMQm6mdz3+xvfNQdn1Jm3NwTXVoRf3bp67/qY2Q
         nM/iviDVPEx1QZw5JlTYeAYoAuXPBepVBHjUWC0zscem62bJRVVtjg4oPfx5wS5xe1/i
         KqLRl5P5pUOchJiISf2H92nSXhn4eK7Y/zBGiEBMmAtDnjrFVYbeDkSk7+OtWVKCB7d/
         3NP0XxbiPptY6L/ZjGRVFTpjaV7qE8kwdwyM0djtQKwShQ6facU+adB2n96v2Ow+2oNX
         ByTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272634; x=1729877434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKeOGzBwhkORap+bFaXRZ5k5ETEZTGkTXkc6r1BfTnM=;
        b=QRS4XzdtZjztVGXAnZbJ58HxsoO5jV7sRVHdjFZQU2pWz4e3m37nRkcETwSoH4vKtp
         v8omNnOShYZp4ssaH4UVf15f0rcqeV5CIcDDrXqxBivAQDSHxRZk+AzaA8LAj0dSqwPQ
         on4/Q4Z8sHuasR4nnkXWYDyEUSH+fdgpd0FYOwoyhtv7Srt/uC8csACcVpZ0tUDMjy+G
         Md3D//7Kihz3117KUeGMDiNP54xsZbOrIBZYUxycK/MC3tM8g77IPgMMa/VHN4VPKvZS
         RVzvLsJDVydtmi1J8b7y0rICsVkeDRhnFCIplRXzoxdg8FW3M1Wp+vA5yHNWwrzsbka7
         t4fA==
X-Forwarded-Encrypted: i=1; AJvYcCWYg3U6VId7bHjeoDuXYtiGy7FGalvftgpWSju1d3OfYQeQAHA3TzHSCFe9LeN1A+Kzqd+TNxMkssQxcfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhBPBIg627KKhDnX8VjeaHHkLBv0CdJVJkDjdacDbjlllws8E
	W+XvS23LGXorbsb/U4DWx7S7SroZ3Mal08NCkZxAACbqpAeo/sgP
X-Google-Smtp-Source: AGHT+IEHDVJvXPkTfxkfLhiJ891PgPvrAItwAzBFVy3rywsUuhpfmzOVbkrBnF6delxgn8dQGKkFxQ==
X-Received: by 2002:a05:6a20:d98:b0:1cf:38b0:57ff with SMTP id adf61e73a8af0-1d92c5ac311mr4139493637.48.1729272634341;
        Fri, 18 Oct 2024 10:30:34 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ea3311f51sm1725242b3a.36.2024.10.18.10.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 10:30:33 -0700 (PDT)
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
Subject: [PATCH v3 03/12] book3s64/hash: Refactor kernel linear map related calls
Date: Fri, 18 Oct 2024 22:59:44 +0530
Message-ID: <56c610310aa50b5417976a39c5f15b78bc76c764.1729271995.git.ritesh.list@gmail.com>
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

This just brings all linear map related handling at one place instead of
having those functions scattered in hash_utils file.
Makes it easy for review.

No functionality changes in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 164 +++++++++++++-------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index e22a8f540193..fb2f717e9e74 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -273,6 +273,88 @@ void hash__tlbiel_all(unsigned int action)
 		WARN(1, "%s called on pre-POWER7 CPU\n", __func__);
 }
 
+#ifdef CONFIG_DEBUG_PAGEALLOC
+static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
+
+static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
+{
+	unsigned long hash;
+	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
+	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
+	unsigned long mode = htab_convert_pte_flags(pgprot_val(PAGE_KERNEL), HPTE_USE_KERNEL_KEY);
+	long ret;
+
+	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
+
+	/* Don't create HPTE entries for bad address */
+	if (!vsid)
+		return;
+
+	if (linear_map_hash_slots[lmi] & 0x80)
+		return;
+
+	ret = hpte_insert_repeating(hash, vpn, __pa(vaddr), mode,
+				    HPTE_V_BOLTED,
+				    mmu_linear_psize, mmu_kernel_ssize);
+
+	BUG_ON (ret < 0);
+	raw_spin_lock(&linear_map_hash_lock);
+	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
+	linear_map_hash_slots[lmi] = ret | 0x80;
+	raw_spin_unlock(&linear_map_hash_lock);
+}
+
+static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
+{
+	unsigned long hash, hidx, slot;
+	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
+	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
+
+	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
+	raw_spin_lock(&linear_map_hash_lock);
+	if (!(linear_map_hash_slots[lmi] & 0x80)) {
+		raw_spin_unlock(&linear_map_hash_lock);
+		return;
+	}
+	hidx = linear_map_hash_slots[lmi] & 0x7f;
+	linear_map_hash_slots[lmi] = 0;
+	raw_spin_unlock(&linear_map_hash_lock);
+	if (hidx & _PTEIDX_SECONDARY)
+		hash = ~hash;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot += hidx & _PTEIDX_GROUP_IX;
+	mmu_hash_ops.hpte_invalidate(slot, vpn, mmu_linear_psize,
+				     mmu_linear_psize,
+				     mmu_kernel_ssize, 0);
+}
+
+int hash__kernel_map_pages(struct page *page, int numpages, int enable)
+{
+	unsigned long flags, vaddr, lmi;
+	int i;
+
+	local_irq_save(flags);
+	for (i = 0; i < numpages; i++, page++) {
+		vaddr = (unsigned long)page_address(page);
+		lmi = __pa(vaddr) >> PAGE_SHIFT;
+		if (lmi >= linear_map_hash_count)
+			continue;
+		if (enable)
+			kernel_map_linear_page(vaddr, lmi);
+		else
+			kernel_unmap_linear_page(vaddr, lmi);
+	}
+	local_irq_restore(flags);
+	return 0;
+}
+#else /* CONFIG_DEBUG_PAGEALLOC */
+int hash__kernel_map_pages(struct page *page, int numpages,
+					 int enable)
+{
+	return 0;
+}
+#endif /* CONFIG_DEBUG_PAGEALLOC */
+
 /*
  * 'R' and 'C' update notes:
  *  - Under pHyp or KVM, the updatepp path will not set C, thus it *will*
@@ -2120,88 +2202,6 @@ void hpt_do_stress(unsigned long ea, unsigned long hpte_group)
 	}
 }
 
-#ifdef CONFIG_DEBUG_PAGEALLOC
-static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
-
-static void kernel_map_linear_page(unsigned long vaddr, unsigned long lmi)
-{
-	unsigned long hash;
-	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
-	unsigned long mode = htab_convert_pte_flags(pgprot_val(PAGE_KERNEL), HPTE_USE_KERNEL_KEY);
-	long ret;
-
-	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
-
-	/* Don't create HPTE entries for bad address */
-	if (!vsid)
-		return;
-
-	if (linear_map_hash_slots[lmi] & 0x80)
-		return;
-
-	ret = hpte_insert_repeating(hash, vpn, __pa(vaddr), mode,
-				    HPTE_V_BOLTED,
-				    mmu_linear_psize, mmu_kernel_ssize);
-
-	BUG_ON (ret < 0);
-	raw_spin_lock(&linear_map_hash_lock);
-	BUG_ON(linear_map_hash_slots[lmi] & 0x80);
-	linear_map_hash_slots[lmi] = ret | 0x80;
-	raw_spin_unlock(&linear_map_hash_lock);
-}
-
-static void kernel_unmap_linear_page(unsigned long vaddr, unsigned long lmi)
-{
-	unsigned long hash, hidx, slot;
-	unsigned long vsid = get_kernel_vsid(vaddr, mmu_kernel_ssize);
-	unsigned long vpn = hpt_vpn(vaddr, vsid, mmu_kernel_ssize);
-
-	hash = hpt_hash(vpn, PAGE_SHIFT, mmu_kernel_ssize);
-	raw_spin_lock(&linear_map_hash_lock);
-	if (!(linear_map_hash_slots[lmi] & 0x80)) {
-		raw_spin_unlock(&linear_map_hash_lock);
-		return;
-	}
-	hidx = linear_map_hash_slots[lmi] & 0x7f;
-	linear_map_hash_slots[lmi] = 0;
-	raw_spin_unlock(&linear_map_hash_lock);
-	if (hidx & _PTEIDX_SECONDARY)
-		hash = ~hash;
-	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	slot += hidx & _PTEIDX_GROUP_IX;
-	mmu_hash_ops.hpte_invalidate(slot, vpn, mmu_linear_psize,
-				     mmu_linear_psize,
-				     mmu_kernel_ssize, 0);
-}
-
-int hash__kernel_map_pages(struct page *page, int numpages, int enable)
-{
-	unsigned long flags, vaddr, lmi;
-	int i;
-
-	local_irq_save(flags);
-	for (i = 0; i < numpages; i++, page++) {
-		vaddr = (unsigned long)page_address(page);
-		lmi = __pa(vaddr) >> PAGE_SHIFT;
-		if (lmi >= linear_map_hash_count)
-			continue;
-		if (enable)
-			kernel_map_linear_page(vaddr, lmi);
-		else
-			kernel_unmap_linear_page(vaddr, lmi);
-	}
-	local_irq_restore(flags);
-	return 0;
-}
-#else /* CONFIG_DEBUG_PAGEALLOC */
-int hash__kernel_map_pages(struct page *page, int numpages,
-					 int enable)
-{
-	return 0;
-}
-#endif /* CONFIG_DEBUG_PAGEALLOC */
-
 void hash__setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
-- 
2.46.0


