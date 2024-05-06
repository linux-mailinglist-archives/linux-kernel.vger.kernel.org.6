Return-Path: <linux-kernel+bounces-170109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035498BD1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2ABC2849F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B7156645;
	Mon,  6 May 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="qDceAnEA"
Received: from out187-17.us.a.mail.aliyun.com (out187-17.us.a.mail.aliyun.com [47.90.187.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E7D15575D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011059; cv=none; b=rMT9pAEVbni7JeOlGfrKjkgnDswTxkwWCjeHzF7Nh1iHLoIaZt+DXwAUOVkjaCbqeqTbwj9Zsi0yp6+1Udx+lofa2zjmz5Xu7oQexmTuRGJsLcX3Q1n6eVffSvXe4WUvjJZwn94No8hVF12caEK5e4KG+qmcItJFcqr0A2R6DDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011059; c=relaxed/simple;
	bh=HuCGta02kYZoOPnIDyqaTZyalnCbKeZWEKYWZVof4MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DD5xtIhLgZo9B1PlLAm5GdlGI5x5wnGasvkJw1p/tJ0MoqBWiORC4ZEE7t/JlUwWhyoyAy9DJkKryp9EWBHZbBszz4DhO6OvxQ5ifQPoi60K5ldcAG5ufkQMKldfViNEcafH5s9xFN4cN1eyALfPRCtIeLmW+Aenkha6oeIWYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=qDceAnEA; arc=none smtp.client-ip=47.90.187.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715011046; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=fZLMp0zX1lVO/AMMqpo0KyiatSIXbG3CSPTawlIjnSU=;
	b=qDceAnEAF3MzzYPlofjvl4gHUhttJKT7L08pjDxKVU0NUEgl8GiKwIkvXDfvHZXdkKhmp8K8KwDvABc6E2o4pd83mAUJ5P0vE91UscupQXZWMldK0PmW3z/pnwEUBkv4isr3Ea4BzxzvxwBoJ7V+NFZ1Az4khL+2vzUWNtgK7AY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047192;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XTcewEm_1715010727;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XTcewEm_1715010727)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 23:52:08 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc:  <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <loongarch@lists.linux.dev>,
   <linux-riscv@lists.infradead.org>,
   <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <ioworker0@gmail.com>,
   <libang.linux@gmail.com>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v2 4/5] xtensa: Add update_mmu_tlb_range()
Date: Mon, 06 May 2024 23:51:19 +0800
Message-Id: <20240506155120.83105-5-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240506155120.83105-1-libang.li@antgroup.com>
References: <20240506155120.83105-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added update_mmu_tlb_range function, we can batch update tlb of an
address range.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 arch/xtensa/include/asm/pgtable.h | 4 ++++
 arch/xtensa/mm/tlb.c              | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 9a7e5e57ee9a..57f97e7e06d0 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -414,6 +414,10 @@ void update_mmu_tlb(struct vm_area_struct *vma,
 		    unsigned long address, pte_t *ptep);
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 
+void update_mmu_tlb_range(struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, unsigned int nr);
+#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
+
 #endif /* !defined (__ASSEMBLY__) */
 
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index d8b60d6e50a8..05efba86b870 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -169,6 +169,12 @@ void update_mmu_tlb(struct vm_area_struct *vma,
 	local_flush_tlb_page(vma, address);
 }
 
+void update_mmu_tlb_range(struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, unsigned int nr)
+{
+	local_flush_tlb_range(vma, address, address + PAGE_SIZE * nr);
+}
+
 #ifdef CONFIG_DEBUG_TLB_SANITY
 
 static unsigned get_pte_for_vaddr(unsigned vaddr)
-- 
2.19.1.6.gb485710b


