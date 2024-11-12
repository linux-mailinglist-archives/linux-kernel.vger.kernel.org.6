Return-Path: <linux-kernel+bounces-406011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BA19C5A12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40AF91F23481
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD71FC7D0;
	Tue, 12 Nov 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="iWlROZva"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B4A7F477
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731420975; cv=none; b=rhS1C2hon2pUG7encJzsoHQajkuSEB97jkJjehZd+eML/zEmdlXrec2lOdF44EbypuQpifk25FoGcY6sdzFdu7B+E7eMjZBdIDSuad7ek/FPjM5bkpjOin/fydZAgo0oGr4Q3uH8tYbEgZak4RXozArRsFlNNpHVxaQiW5iY23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731420975; c=relaxed/simple;
	bh=XpOotAdpt0XBu2S2xXqrIVvyOx0WvsisqjSWMtFrzFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9eEM398STaChtx3VYhBjy/6ScnpN8GeXukTQbehUTZN1bf3+gRG30ttT1L+B2I08EECEJiH0qpvpOCGBu9MWqRr5X+3ZJTwgzBSdMAS2XEHVkh7uympX042IvMJM7mREMUMaWtlljt5wl1Ul7Fujv94xlLS/wy9Ylg2anrFEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=iWlROZva; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731420973; x=1762956973;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=acm1kyvqupguFjJWytnDbuQ5A0QhLVvL3XceyiCM+CM=;
  b=iWlROZvaWelJ8r2nIMqNbgi2WovE98l+5Gpu7OYvLZE3v+toHWXQdQL5
   duHoMaMtxXsH8I4OaNueyYkd6GhA/pTp7/pougV7wZUOUnKbzMt9p7h9y
   Q8DXFVrkO2NVmToKRXFtW67c35krJny1jJwvfzptyOGr8S9OxEqUU5Xm8
   k=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208";a="469329413"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:16:05 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:56879]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.85:2525] with esmtp (Farcaster)
 id 9c695df4-969b-4e86-bbb0-610ddcc3be65; Tue, 12 Nov 2024 14:16:05 +0000 (UTC)
X-Farcaster-Flow-ID: 9c695df4-969b-4e86-bbb0-610ddcc3be65
Received: from EX19EXOUWC001.ant.amazon.com (10.250.64.135) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 14:16:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.174) by
 EX19EXOUWC001.ant.amazon.com (10.250.64.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 14:16:04 +0000
Received: from email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 14:16:04 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com [10.15.97.110])
	by email-imr-corp-prod-pdx-all-2c-475d797d.us-west-2.amazon.com (Postfix) with ESMTP id 7D8D5A0126;
	Tue, 12 Nov 2024 14:16:04 +0000 (UTC)
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 1332D2084A; Tue, 12 Nov 2024 14:16:04 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Mike Kravetz <mike.kravetz@oracle.com>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC PATCH 5.10.y] mm: hugetlb: call huge_pte_offset with i_mmap_rwsem held
Date: Tue, 12 Nov 2024 14:16:01 +0000
Message-ID: <20241112141601.34540-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

huge_pte_offset() walks the page table to the find the pte associated
with the huge page. the PMD page can be shared with another process and
pmd unsharing is possible (so the PUD-ranged pgtable page can go away
while the page table walk is under way. It can be done by a pmd unshare
with a follow up munmap() on the other process).

Protect against this race by taking i_mmap_rwsem while the page table
walk is going on and till the pointer to the PMD is being used.

The upstream kernel has a new lock [1] for fixing this issue and
backporting the whole series is not trivial. This patch is my attempt at
fixing this issue and I am sending this as an RFC to receive feedback if we
can fix it using another method.

Once I receive the feedback and we have a path forward, I will send that
patch to all stable branches that have this issue.

[1] https://lwn.net/Articles/908092/

Here is an example kernel panic due to the issue being fixed in this
patch:

 Unable to handle kernel paging request at virtual address ffffffffc0000698
 Mem abort info:
 ESR = 0x96000004
 EC = 0x25: DABT (current EL), IL = 32 bits
 SET = 0, FnV = 0
 EA = 0, S1PTW = 0
 Data abort info:
 ISV = 0, ISS = 0x00000004
 CM = 0, WnR = 0
 swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000729ec000
 [ffffffffc0000698] pgd=0000000000000000, p4d=0000000000000000
 Internal error: Oops: 96000004 [#1] SMP
 Modules linked in: xt_tcpmss ip6table_filter tcp_diag [.....]
 CPU: 3 PID: 62456 Comm: postgres Not tainted 5.10.184-175.731.amzn2.aarch64 #1
 Hardware name: Amazon EC2 caspianr1g.16xlarge/, BIOS 1.0 11/1/2018
 pstate: 80400005 (Nzcv daif +PAN -UAO -TCO BTYPE=--)
 pc : huge_pte_offset+0x88/0x118
 lr : hugetlb_fault+0x60/0x5f0
 sp : ffff80001c6d3d00
 x29: ffff80001c6d3d00 x28: ffff0003cdfa0000
 x27: 0000000000000000 x26: ffff0003ce90d6a8
 x25: 0000000000000007 x24: 00000a60da660000
 x23: ffff0003ce90d640 x22: ffff800012256ed8
 x21: 00000a60da600000 x20: ffff00040388d130
 x19: ffff00040388d130 x18: 0000000000000000
 x17: 0000000000000000 x16: 0000000000000000
 x15: 0000000000000000 x14: 0000000000000000
 x13: 0000000000000000 x12: 0000000000000000
 x11: 0000000000000000 x10: 0000000000000000
 x9 : ffff800010345880 x8 : 0000000000000000
 x7 : 0000000040000000 x6 : 0000000040000000
 x5 : 0000000000000183 x4 : 00000000000000d3
 x3 : ffffffffc0000000 x2 : 0000000000200000
 x1 : 00000a60da600000 x0 : ffffffffc0000698
 Call trace:
 huge_pte_offset+0x88/0x118
 handle_mm_fault+0x1b0/0x240
 do_page_fault+0x150/0x420
 do_translation_fault+0xb8/0xf4
 do_mem_abort+0x48/0xa8
 el0_da+0x44/0x80
 el0_sync_handler+0xe0/0x120
 Code: eb00005f 54000380 d3557424 8b040c60 (f8647863)
 ---[ end trace 6cffaf3375de3ad9 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 Kernel Offset: disabled
 CPU features: 0x0804800e,7a00a238
 Memory Limit: 2048 MB
 ---[ end Kernel panic - not syncing: Oops: Fatal exception ]---

Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
 mm/hugetlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 02b7c8f9b0e87..a991b62afac4e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4545,7 +4545,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	mapping = vma->vm_file->f_mapping;
 
+	i_mmap_lock_read(mapping);
 	ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
 	if (ptep) {
 		/*
@@ -4556,10 +4558,13 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		entry = huge_ptep_get(ptep);
 		if (unlikely(is_hugetlb_entry_migration(entry))) {
 			migration_entry_wait_huge(vma, mm, ptep);
+			i_mmap_unlock_read(mapping);
 			return 0;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
+		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+			i_mmap_unlock_read(mapping);
 			return VM_FAULT_HWPOISON_LARGE |
 				VM_FAULT_SET_HINDEX(hstate_index(h));
+		}
 	}
 
 	/*
@@ -4573,8 +4578,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * is OK, as huge_pte_alloc will return the same value unless
 	 * something has changed.
 	 */
-	mapping = vma->vm_file->f_mapping;
-	i_mmap_lock_read(mapping);
 	ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
 	if (!ptep) {
 		i_mmap_unlock_read(mapping);
-- 
2.40.1


