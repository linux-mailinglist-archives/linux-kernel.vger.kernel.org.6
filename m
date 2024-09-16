Return-Path: <linux-kernel+bounces-330549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4197A007
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B0E2833C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A7615625A;
	Mon, 16 Sep 2024 11:08:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8004155C97
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484892; cv=none; b=uvmwG2YSOqxfmGgCmoOtUCHNL8VvgvBxSg3azbEfKaX4z8ZFgGLrynuvlV1SJR5K9qxy4Eo3pNaicZW9IQKvVhZZkpNLOz8u+/5+rztZ0BCGgpx/qIIrTgbJ2xTmoeIK71Q4/zU9d5NPzzcGVEaVTS2bGJRC9fyj1kAo67xlz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484892; c=relaxed/simple;
	bh=SlxPPXkO/fNfzVA5uO56YUKVgem7p+wES/1xBe8JqeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPKR1fIe4wZ9RMnVDBk1IUHphKLNH7KUmujqyd5xPdj1e18QXE/KiZ7wfCFOC998znMjk4LtLlcEEKHaerMVyUyvOBsMtMAgCwf49wbh+w44D178IdzX8gi+yKODKYTYJvyaGQnzlm+/TtYt1m81SWoTyzk0+qe14AJFRJ0vR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AAE812FC;
	Mon, 16 Sep 2024 04:08:39 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.42.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF6683F64C;
	Mon, 16 Sep 2024 04:08:04 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	willy@infradead.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	baohua@kernel.org,
	hughd@google.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	baolin.wang@linux.alibaba.com,
	gshan@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v2 1/2] mm: Make pte_range_none() return number of empty PTEs
Date: Mon, 16 Sep 2024 16:37:53 +0530
Message-Id: <20240916110754.1236200-2-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916110754.1236200-1-dev.jain@arm.com>
References: <20240916110754.1236200-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for the second patch, make pte_range_none() return
the number of contiguous empty PTEs.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 mm/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 6469ac99f2f7..8bb1236de93c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4617,16 +4617,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	return ret;
 }
 
-static bool pte_range_none(pte_t *pte, int nr_pages)
+static int pte_range_none(pte_t *pte, int nr_pages)
 {
 	int i;
 
 	for (i = 0; i < nr_pages; i++) {
 		if (!pte_none(ptep_get_lockless(pte + i)))
-			return false;
+			return i;
 	}
 
-	return true;
+	return nr_pages;
 }
 
 static struct folio *alloc_anon_folio(struct vm_fault *vmf)
@@ -4671,7 +4671,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 	order = highest_order(orders);
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		if (pte_range_none(pte + pte_index(addr), 1 << order))
+		if (pte_range_none(pte + pte_index(addr), 1 << order) == 1 << order)
 			break;
 		order = next_order(&orders, order);
 	}
@@ -4787,7 +4787,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	if (nr_pages == 1 && vmf_pte_changed(vmf)) {
 		update_mmu_tlb(vma, addr, vmf->pte);
 		goto release;
-	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+	} else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
 		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		goto release;
 	}
@@ -5121,7 +5121,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		update_mmu_tlb(vma, addr, vmf->pte);
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
-	} else if (nr_pages > 1 && !pte_range_none(vmf->pte, nr_pages)) {
+	} else if (nr_pages > 1 && pte_range_none(vmf->pte, nr_pages) != nr_pages) {
 		update_mmu_tlb_range(vma, addr, vmf->pte, nr_pages);
 		ret = VM_FAULT_NOPAGE;
 		goto unlock;
-- 
2.30.2


