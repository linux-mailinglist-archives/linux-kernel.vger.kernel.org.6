Return-Path: <linux-kernel+bounces-364963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635099DBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 03:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9011F2397F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 01:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F21D175D3A;
	Tue, 15 Oct 2024 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek00m7W4"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E017335C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728956048; cv=none; b=oQP5BbgsoEFnd9ReucCovC+qpyy8FUlH3xlQWu8YrFTwA9nEgOYv/DH2S3Lcnj6FV5zItPn6yhqWcVMhE55IU1/era8B6ETM+rowtwlIKBpcgAQsV+lgsyNpWafgiQC92BAHp2LZ+GCdkB1EHuNlQr/FfWrrZ2GpfcQEXio1klg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728956048; c=relaxed/simple;
	bh=FsG1hRAQUYRA/vEnlI+7JEFrFUI5bmUaSjg6v6DcwoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEMdYLosoddJEIVGFW499NJbMiYrv6J/XqQfruislSdx1qeRzAu3ADEMMrC4KH1l4l7V3xyB57Rf8sCHV0b7sJaDb+5YBWQtM28L0LM1iHAN5QZT6u65T1tWf/uteFXW8/SFluHaESpsHlfdVz5MVktilhaeLOUE9/nlkZ/MNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek00m7W4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so1815214a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728956046; x=1729560846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axWsqNzIpvlhLR7DqrnxUdvbHKQsISEkZ4mTeZAqu9w=;
        b=ek00m7W40mLApXCFYCdZiCe+U/CvuqRpi1N+T3rlsTLud1VSHUk6qeaJVCnV4uWH12
         CvDlavMfDrtRgV80JC7K0PgJCfdAMXKtsP4XoC14BPIq2s5zUwayi6C714RpYrOTBT24
         5FJNcvlMuL4hfQDMjHXHOVZHxxBd8CbFVlMyKPEjlKXZmWWgOLAb5+b1UghcSecdKbLI
         6llwnAevU/XOanGmS0w3tgdlkniSvgmJeSYlFR9xvMxUHoJ6pgMI82j+zoG0jTr1uRfF
         T/A1qYBjs9yan/gdRRRVZj0Lf2mA4Id3C2GpKsnImwC2msq75qdskgLSHpauTqsHSvq0
         CKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728956046; x=1729560846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axWsqNzIpvlhLR7DqrnxUdvbHKQsISEkZ4mTeZAqu9w=;
        b=Mds5w0DnBK4fJUPFZ5zOkiYgzgiZyInEH4oNfDETGcizwkQtGpS7NkjptikyTnVxP3
         0qwkKIEGSVph9toTl6UifSiN3V9VXJ5IFkgiNgtHqx9QoGjQ+1e++LQQAyrkfNBqkzeg
         RSDVBnU+30sr4UDwJHIjCCcJFGzy7b4rXwmIwg9NhrbhFeOKAMZ++1I8Bj4O2Oufzbg6
         LyR+IIYwD04MTawN1th0yvtrHd5FIBgTNv1eV5PSv/5DKg36STPxSvtkRlZLtZmil8xq
         WN4+zAm8sQTgrFgkOIbMSC8TL4gGfb+zSwA/J5+zoMsoMYslAhR5xN4UY6DkQ1bgeR7P
         ucbw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0O9ITZLttZ9fKyHoSbq4LGG0HGSLgBk//XxmMNRln3jhr/tYFWoVq/Kws7D60IKIuegu4SLjyEjogkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqNYRxaGZ0EcdZuQYXx946JddBAZFTIQK1VoD60drRYAnDUhV
	CW58Uc7pDAXPOvKD6GGPkgcZP0VxnnS73WtQw/o+u4bVh3qAnh3P
X-Google-Smtp-Source: AGHT+IG4I/3JRaWO1s0Oc1G3nloW3mFZD9rynaJ4QyFbWI1r3K+RwAKvmgR5I5AwDy8LCEp8stlWhw==
X-Received: by 2002:a05:6a20:2d1f:b0:1d8:a899:8899 with SMTP id adf61e73a8af0-1d8bcf561dfmr20114300637.29.1728956046508;
        Mon, 14 Oct 2024 18:34:06 -0700 (PDT)
Received: from dw-tp.. ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77508562sm189349b3a.186.2024.10.14.18.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 18:34:05 -0700 (PDT)
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
Subject: [RFC RESEND v2 04/13] book3s64/hash: Refactor kernel linear map related calls
Date: Tue, 15 Oct 2024 07:03:27 +0530
Message-ID: <5a4522af03014d41d98809dd58fab57b187e8b51.1728954719.git.ritesh.list@gmail.com>
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

This just brings all linear map related handling at one place instead of
having those functions scattered in hash_utils file.
Makes it easy for review.

No functionality changes in this patch.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/hash_utils.c | 164 +++++++++++++-------------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 296bb74dbf40..82151fff9648 100644
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


