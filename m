Return-Path: <linux-kernel+bounces-170108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD48BD1F4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9878C1F239E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511F4155A24;
	Mon,  6 May 2024 15:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="u6jU+xOc"
Received: from out187-1.us.a.mail.aliyun.com (out187-1.us.a.mail.aliyun.com [47.90.187.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249615574E
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011056; cv=none; b=j8yHQSyibTq2JzWoxh1UcKFJLGmCDvCHX2niGq/M5LH4FJg+4VfbnaAWn6JDwx/TrlOYkluPNKiRgW0FWvPGtO8CuH6jxMhStW5h2yc1bbJl60GMS/1wRWKxuw4XNJpshHCbJGX/S7poR0eBOTk86LL5qpaJ3erOh10hhL9MrCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011056; c=relaxed/simple;
	bh=icpePUeswEr53u3rw5CGtDkngqPYtbaGrZOhDxsPtc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R9hq0RgvTAyFVQlj4NhdGm2SYxX+/6gKfCiCL2P56mDuoYXAjib2z2YdaSe6/cRT60606lj50pVnF/k6SI9bMQ/AvWqUoEwH4wLWHNOnI5H1wPxNBjSjK5ZtbEBMcuI0+lgG18Ly8/wmHuS+5zJrWvDCSoBgSz2tqoDfP9RTtgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=u6jU+xOc; arc=none smtp.client-ip=47.90.187.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715011043; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=pTrt2D6LnlSlcqnfLWOg4gAqNc+Zz7gJTsSV/QHl4Kk=;
	b=u6jU+xOcFJ1Q70WH10dGsLlx1HnJrJssmMdS5Lx+lpjN4quxtLIgif1j1sdoLSVLFOmUW7AzFncatfwJjokmtYdwGWexLbcOCQs60BeySP6aPQEhWvAATUPotD0MzZhk6u+HSDrNAYcI57Tv9RI96Eef+XwQkg/ipP0WSKyfyyc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047199;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XTcewE9_1715010723;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XTcewE9_1715010723)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 23:52:04 +0800
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
Subject: [PATCH v2 2/5] mips: Add update_mmu_tlb_range()
Date: Mon, 06 May 2024 23:51:17 +0800
Message-Id: <20240506155120.83105-3-libang.li@antgroup.com>
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
 arch/mips/include/asm/pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index e27a4c83c548..9416c9b971e5 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -597,6 +597,10 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define	__HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
 
+#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
+#define update_mmu_tlb_range(vma, address, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, address, ptep, nr)
+
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 	unsigned long address, pmd_t *pmdp)
 {
-- 
2.19.1.6.gb485710b


