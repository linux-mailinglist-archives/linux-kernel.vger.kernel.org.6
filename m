Return-Path: <linux-kernel+bounces-185798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958E8CBB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559A4282E50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4BA78285;
	Wed, 22 May 2024 06:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="ZjKPR4ec"
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDDF757E3
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358412; cv=none; b=Gru15+7GMszZ/AcwVNljsJWLAFM6tpXArmIxxAjij8CQDLAUno28yqEiKslQ3BD11AXJw7J9N4yucM3nmiTpc0aQLHJKTFMR7h1PIW5IOQ8LpiUUi1nAXaGrCBoP63XL5Bmww3BKSa/b8GlJhrK3Zcaq8qqT/DrcGOEE6mjSlvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358412; c=relaxed/simple;
	bh=1gwBS5Cq9Mt+mBuCChuoPiJyX6uoYGfOwAsbB/VA+Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xqc98aqdES0poOivGW8DTg+7eq6r1tmKcwa97yuKi6CHhEhILHSBmvBGyChoSsj3kgEafYbMKeSYc3J096iFzlZ6hjULyemK2JVwdxQLhRzuGRRVz9VXsU092Vgin3PjIxRrooA2nFY9SVjzVKXwgi0C5TeSM0he0QEY2s4/a0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=ZjKPR4ec; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716358407; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+clcXfgLVBiQX5MySmBhLxW05UlCMsdDj9QlU2/Rreg=;
	b=ZjKPR4ecna7g4lVxy83K70sx+gDSrYJadj0Zhc7uYD23/TFA730XJ6LPbtUDMG788r8d06230EUxvjtthztl5IgEoJnae68wmvjfZyXJCu1AuWWcr++rUC4qRojStwqafw33vMoPKe1Yw7DO/T9lT/PAD0UJvjHvjQiHHdtKA5M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045129160;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.Xk0LCMY_1716358405;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.Xk0LCMY_1716358405)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 14:13:26 +0800
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
Subject: [PATCH v4 3/3] mm: Use update_mmu_tlb_range() to simplify code
Date: Wed, 22 May 2024 14:12:04 +0800
Message-Id: <20240522061204.117421-4-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240522061204.117421-1-libang.li@antgroup.com>
References: <20240522061204.117421-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let us simplify the code by update_mmu_tlb_range().

Reviewed-by: Lance Yang <ioworker0@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b5453b86ec4b..1297474546d6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4416,7 +4416,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int nr_pages = 1;
 	pte_t entry;
-	int i;
 
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
@@ -4486,8 +4485,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		update_mmu_tlb(vma, addr, vmf->pte);
 		goto release;
 	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
-		for (i = 0; i < nr_pages; i++)
-			update_mmu_tlb(vma, addr + PAGE_SIZE * i, vmf->pte + i);
+		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		goto release;
 	}
 
-- 
2.19.1.6.gb485710b


