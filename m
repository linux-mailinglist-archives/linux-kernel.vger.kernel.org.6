Return-Path: <linux-kernel+bounces-302185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFD95FAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C221F21CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D42C1A0B05;
	Mon, 26 Aug 2024 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/1cNYoV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04101A08CA
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705079; cv=none; b=urcx2g31GdDFpWrfYlxAAHVkSdoc5rm/XKGagUFA+SZk/jK6t+TFoEdalF6Awi4o18pE3q8a4JHxDZivZpZrBY8hKbo+iS5D/pQZve7+8Dz7qWbiTdK3Aj9DwicTBrm6uaxm/7fNYQ8W2fYVQgEUdXToYQUAT/1CGeFk3DqqDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705079; c=relaxed/simple;
	bh=Dmoew7i8XEW+gHBA0zJyGyEzte9fLwrtktcen/8enVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siQWQxqAAidqgmIoQVZj4PlgMjqPqD5ILXB+SRDBw/8DebIzBPGNuftx6MbjnaB/vlvjtSrQdN1c4v9tUFnq7m8srwuz7W1idHRP1mKKnj7hs5G4UFg3pGpW+iCRVGknG8RYpjWxyHFDAkxyfwk64Z5LgJv1GeGGjD5TTL62X7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/1cNYoV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9MPOki3YF/wyEgBnejzItxwjIF1moGifGifGb5OwzY4=;
	b=B/1cNYoVCU8JtQNCasWuX76tNt5qkXae3pQL3TMSvyd0LY/5KFzR34xaRtc6hh+TblYmUS
	LLnqdMlp1MqiCI/Ryioga/U4we8Jy1AkYjCLPuQVsuNlcIBf3z5j+uRbU6lZRMBij4u5pL
	p7umzSllBIqs5z41iVYSJZOt5lO1MTE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218--tNwjN3SMaGFcjz2lZb6fg-1; Mon, 26 Aug 2024 16:44:35 -0400
X-MC-Unique: -tNwjN3SMaGFcjz2lZb6fg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1df6b3a26so630300485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705075; x=1725309875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MPOki3YF/wyEgBnejzItxwjIF1moGifGifGb5OwzY4=;
        b=q9SWndwTKVqe0Nw9EndoQMZl6EPACIwr3cBl4FYGdDgKwMomlDp0v5jH5PUd4TOwIP
         EU4Ne4O3qbuDrxhCzO8Lo457pub2ErwzFyEx2wGnLlPuVOJ2LcIONOG2EwYULrx+Mj22
         HO1m+/v3SHD+U5LCnLx6Vq2lkAAjfxBKtDHF8c+d/rG22sXgpjbADzV1L5QgoQNT0LYL
         JpqWznXKJUn6+Kps9Poh9fo75+ZrP4hLMbgrmS3NeVq1pBd/1AmqCf8IHeiQc5oUYGen
         dbKDmthiwxVYEtQbGtPCx9zWPoYXRCNUHZkjCrICCVL4gCfMQqd0O9njgWbfL2kkhLxc
         pq6w==
X-Gm-Message-State: AOJu0YyU6HTMawZNCLBdLdtmRU/5JSF1P7PFcyTsRbRZe9yFAoTA8ZbV
	C80iTNFDXvj1tdfKRuKiwfUG6o+RjhTxY3W2vQRtZNteRfDypQVodphdyPpke7sUqAmWDAwcJhs
	tbrlIp2IMCD24N2xqXk9BQkY5ArhTtppg1GPyLrmWWJb2A0Bvr+nf21SwlIq75Gv5hqnzzfIHSW
	xXS5S+42ckV7YBoL8NhKLzonO0E4T6hLJSblqm1Yd78/M=
X-Received: by 2002:a05:620a:4007:b0:79f:595:f64a with SMTP id af79cd13be357-7a6897b7b14mr1477184685a.58.1724705074750;
        Mon, 26 Aug 2024 13:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpx2qE8XXNwFA/VbcshgEEhM7utf/nDzzwdfyOyUpm1p8Kz8GxiojqL+PSarI5vXlPZn99hQ==
X-Received: by 2002:a05:620a:4007:b0:79f:595:f64a with SMTP id af79cd13be357-7a6897b7b14mr1477180385a.58.1724705074328;
        Mon, 26 Aug 2024 13:44:34 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Gavin Shan <gshan@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alistair Popple <apopple@nvidia.com>,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Sean Christopherson <seanjc@google.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	Zi Yan <ziy@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 19/19] vfio/pci: Implement huge_fault support
Date: Mon, 26 Aug 2024 16:43:53 -0400
Message-ID: <20240826204353.2228736-20-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240826204353.2228736-1-peterx@redhat.com>
References: <20240826204353.2228736-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Williamson <alex.williamson@redhat.com>

With the addition of pfnmap support in vmf_insert_pfn_{pmd,pud}() we
can take advantage of PMD and PUD faults to PCI BAR mmaps and create
more efficient mappings.  PCI BARs are always a power of two and will
typically get at least PMD alignment without userspace even trying.
Userspace alignment for PUD mappings is also not too difficult.

Consolidate faults through a single handler with a new wrapper for
standard single page faults.  The pre-faulting behavior of commit
d71a989cf5d9 ("vfio/pci: Insert full vma on mmap'd MMIO fault") is
removed in this refactoring since huge_fault will cover the bulk of
the faults and results in more efficient page table usage.  We also
want to avoid that pre-faulted single page mappings preempt huge page
mappings.

Cc: kvm@vger.kernel.org
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 60 +++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ba0ce0075b2f..2d7478e9a62d 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -20,6 +20,7 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/pci.h>
+#include <linux/pfn_t.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -1657,14 +1658,20 @@ static unsigned long vma_to_pfn(struct vm_area_struct *vma)
 	return (pci_resource_start(vdev->pdev, index) >> PAGE_SHIFT) + pgoff;
 }
 
-static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t vfio_pci_mmap_huge_fault(struct vm_fault *vmf,
+					   unsigned int order)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct vfio_pci_core_device *vdev = vma->vm_private_data;
 	unsigned long pfn, pgoff = vmf->pgoff - vma->vm_pgoff;
-	unsigned long addr = vma->vm_start;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 
+	if (order && (vmf->address & ((PAGE_SIZE << order) - 1) ||
+		      vmf->address + (PAGE_SIZE << order) > vma->vm_end)) {
+		ret = VM_FAULT_FALLBACK;
+		goto out;
+	}
+
 	pfn = vma_to_pfn(vma);
 
 	down_read(&vdev->memory_lock);
@@ -1672,30 +1679,49 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fault *vmf)
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
 		goto out_unlock;
 
-	ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
-	if (ret & VM_FAULT_ERROR)
-		goto out_unlock;
-
-	/*
-	 * Pre-fault the remainder of the vma, abort further insertions and
-	 * supress error if fault is encountered during pre-fault.
-	 */
-	for (; addr < vma->vm_end; addr += PAGE_SIZE, pfn++) {
-		if (addr == vmf->address)
-			continue;
-
-		if (vmf_insert_pfn(vma, addr, pfn) & VM_FAULT_ERROR)
-			break;
+	switch (order) {
+	case 0:
+		ret = vmf_insert_pfn(vma, vmf->address, pfn + pgoff);
+		break;
+#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
+	case PMD_ORDER:
+		ret = vmf_insert_pfn_pmd(vmf, __pfn_to_pfn_t(pfn + pgoff,
+							     PFN_DEV), false);
+		break;
+#endif
+#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
+	case PUD_ORDER:
+		ret = vmf_insert_pfn_pud(vmf, __pfn_to_pfn_t(pfn + pgoff,
+							     PFN_DEV), false);
+		break;
+#endif
+	default:
+		ret = VM_FAULT_FALLBACK;
 	}
 
 out_unlock:
 	up_read(&vdev->memory_lock);
+out:
+	dev_dbg_ratelimited(&vdev->pdev->dev,
+			   "%s(,order = %d) BAR %ld page offset 0x%lx: 0x%x\n",
+			    __func__, order,
+			    vma->vm_pgoff >>
+				(VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT),
+			    pgoff, (unsigned int)ret);
 
 	return ret;
 }
 
+static vm_fault_t vfio_pci_mmap_page_fault(struct vm_fault *vmf)
+{
+	return vfio_pci_mmap_huge_fault(vmf, 0);
+}
+
 static const struct vm_operations_struct vfio_pci_mmap_ops = {
-	.fault = vfio_pci_mmap_fault,
+	.fault = vfio_pci_mmap_page_fault,
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	.huge_fault = vfio_pci_mmap_huge_fault,
+#endif
 };
 
 int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma)
-- 
2.45.0


