Return-Path: <linux-kernel+bounces-170194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862DE8BD334
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCD1EB21A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CEE156F54;
	Mon,  6 May 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="M5suovjN"
Received: from out0-204.mail.aliyun.com (out0-204.mail.aliyun.com [140.205.0.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AF7156962
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014403; cv=none; b=I48jR+Dilep5gjClrYyNeRS+gwO/NyqpCfWkSF6xeGg0P9wIYJq7Dt6RXjSnxwGclAcl6h45kJBo1N39SYoj6R9X5bzDVSr7kzx7EOrkF+QSEX5FMD7Fz+51nySS4Gk6JTt7TV92kpIOyMt0aeXavwB9FyG2U8di5sam+DkyLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014403; c=relaxed/simple;
	bh=e7JJYP/g+sDc4N/7sf9h13R9fpx4WxxFXgInVxkTCBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seIhzJCdvFc5vnU4OZLrNAlZ8DQR5y1NwdM8HX7G6W/HWG1WvIzwVl9AbfYInoGXiy0DMEz5URMkDxYa6I0oUTUnC750T70EpVDKJQIi3QDnrS4jseEGJoKZ2yw57dJ2mu8bgpTj1gZrrJtir2nlRYhswLReOI3Efs2ZaAjXcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=M5suovjN; arc=none smtp.client-ip=140.205.0.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1715014398; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ymFvshx88TI9/EMP30aaqBdjrnITBbXYS6oOftHtOBQ=;
	b=M5suovjN6Fv9Goro4oyrEfRW3uE+PwuEtO1cMCOsIPqvpMgccj54ki/Er0Kf3w9EN+98J8MeH/taoLpnQwPZYi5GJTPCvjBXy8h2wrkvQf6se7McnSNB3QnjQt2WedfjlR6/4sZVUmN/tZRJ6U0S58DGw/wocU9wGml6xhbdFgo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XTf7qIH_1715010729;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XTf7qIH_1715010729)
          by smtp.aliyun-inc.com;
          Mon, 06 May 2024 23:52:10 +0800
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
Subject: [PATCH v2 5/5] mm: Add update_mmu_tlb_range()
Date: Mon, 06 May 2024 23:51:20 +0800
Message-Id: <20240506155120.83105-6-libang.li@antgroup.com>
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

After the commit 19eaf44954df ("mm: thp: support allocation of anonymous
multi-size THP"), it may need to batch update tlb of an address range
through the update_mmu_tlb function. We can simplify this operation by
adding the update_mmu_tlb_range function, which may also reduce the
execution of some unnecessary code in some architectures.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 include/linux/pgtable.h | 8 ++++++++
 mm/memory.c             | 4 +---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..869bfe6054f1 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -737,6 +737,14 @@ static inline void update_mmu_tlb(struct vm_area_struct *vma,
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #endif
 
+#ifndef __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
+static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
+				unsigned long address, pte_t *ptep, unsigned int nr)
+{
+}
+#define __HAVE_ARCH_UPDATE_MMU_TLB_RANGE
+#endif
+
 /*
  * Some architectures may be able to avoid expensive synchronization
  * primitives when modifications are made to PTE's which are already
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


