Return-Path: <linux-kernel+bounces-182792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E278C8FEE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7215F282818
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7A410A35;
	Sat, 18 May 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="0IlDP5wf"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799BC8D1
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716018711; cv=none; b=WXsakBZJFJ32Xk3nDzR54LEuVOacdQDUdUMRPuPwmVDkE2s8ZIHlnIzWQSTg9sPybUIXoJZ5FgPhkNd1WZhHJn0S5Bt+Mu9HaFiVvC8Fq95M57ggceMg0BWYhZysT9LomG30fE9T5jTZkK+YtD4JXa31tcXrlMsk8lbiD25GIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716018711; c=relaxed/simple;
	bh=ezZZUjXre2eUUn/DDsHxMohnuZJYrK0JL7K6dgq80Rs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oycQXBCJ+iJsoLRdh0bfbBm6RKXL4kXw03KaTo1zA96trH98l9BrCXVcE6COfJzafuOOHGs4QlQR5lU5edqdgxiKC/c1akk+e6flvlTAJjFcDLuHOMVrhEtyl9Put9LLY8Gu36sgjvfu22xuDGiT0gTgIcljwJwniONH+5T9dS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=0IlDP5wf; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716018701; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MvaQlNmLKjB1JJG125kcLMl74RVFk5etnjUBr5sySWs=;
	b=0IlDP5wf+f6nRHb1uwC+DFTFkgr5wFHSQYK4a1lx22LkveOy8pulAeT3912AVIHSp9Tjjc+Bw2N9xd9zDmN4on1gERrUMinmxDE4eSSEERoUJ4ukg0bQSOI3MQea0c9x1tjJll3Bt2njP95WC6xagfRKhzy5flJ1RxmMkepXcrU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XgA9uMj_1716018698;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XgA9uMj_1716018698)
          by smtp.aliyun-inc.com;
          Sat, 18 May 2024 15:51:39 +0800
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
Subject: [PATCH v3 3/3] mm: Use update_mmu_tlb_range() to simplify code
Date: Sat, 18 May 2024 15:49:14 +0800
Message-Id: <20240518074914.52170-4-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240518074914.52170-1-libang.li@antgroup.com>
References: <20240518074914.52170-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let us simplify the code by update_mmu_tlb_range().

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index eea6e4984eae..2d53e29cf76e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4421,7 +4421,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	int nr_pages = 1;
 	pte_t entry;
-	int i;
 
 	/* File mapping without ->vm_ops ? */
 	if (vma->vm_flags & VM_SHARED)
@@ -4491,8 +4490,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
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


