Return-Path: <linux-kernel+bounces-281203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFE594D44A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBE7DB2445F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E619D081;
	Fri,  9 Aug 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENtipaz7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7319CD1B
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219785; cv=none; b=HSOUV1ibjiakUlML7UauEMkFH7weXUuc3IrXCI1z/T99MGRkimP6AAYviIZI5tG81KR3Pq9ORs2wcRqdd2rOnrzySeSXjdle0Uelt8QJEG1nTHGWC3Vp1rwRD/qeoPck5IPTsb8Mf5hJ7oqmgqZWTtLksHSA2ln076NeUHU+Wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219785; c=relaxed/simple;
	bh=F3zrw7GW4L3DDhmifn0KqTitiZnPFDtSbk8TCndoYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMtLiB42oiRHDi11nGqN2Yz99Wm4LNKk6YrRl9eE3a5DugWhKdSgabKRJNI5P2GYOLYyLqsuW6c70fPGQa/oyBmwYvzEn6ZfkcZ63PXe2CfupKgEMSNoqT4ScsEY4nq7zeB/t5ROihadlByMz943A7fvk/eP/txO489lvfMxZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENtipaz7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kaY3EfeA+k09YWgS+MfGM8qkjlv58srLyvVau/9jXnU=;
	b=ENtipaz71rh2SAEy6Xo9IA/buT9UMTfHL6cA5S+sVuOehMSBPE1/+eSkZQYWDUfUcpe0Gt
	Rf18eqOlJ9N4WhQE4LKahRnOg57KbatxJzFRTjXxQnH0+isW5TRfstVspvF3vfvqzcOC4h
	AOSOrCTbe+Ca8o0gtbdzbtO4mzhglmM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-PwZyIpg0MoCO9hCcZk4YtA-1; Fri, 09 Aug 2024 12:09:41 -0400
X-MC-Unique: PwZyIpg0MoCO9hCcZk4YtA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-45009e27b83so4905631cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219780; x=1723824580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaY3EfeA+k09YWgS+MfGM8qkjlv58srLyvVau/9jXnU=;
        b=n9qESL0swkgXmM8BtYVZNGdLt3+GUYypHLLSFRIyqt4TDfP/0rs+3Q+T4c40V4e7bi
         r0O8qbYNuYzC+ViXg1WEI/OkF/jljEKaWDQVIPcF0OkFZk8aZUF/hH4LyRCrnOSS1XvK
         kIUs27UKBHfLr6r1Xdy/zGj+nRtoRUVmS7fe711yb8Cq6Qi5GLUZcDHMoBCyH3ThmkMP
         LQBIkGPT1/UORGIJcpSOhEAwoogjIgWWwFIKK99jyHyY0JR7nQF2kxgfhiKnUmF3b7zS
         pPEyTKtT7BzJAXPmNtqBm1CR64cax4JjOCY9OtK0dVr181l/X8uknohbgrR+8nMFSvzR
         W1aA==
X-Forwarded-Encrypted: i=1; AJvYcCWefYFwgVDeJjQWqULXOnxP/v7DSrPI9SUrjno1rGDjqIxzSYRw39XuWhP0YhnHXCW4Se/LjO4A+U6et+GMYjskVMffcgk/M4x0BDRc
X-Gm-Message-State: AOJu0Yy/Go+5gZgwEF4J7FIgoyyjYQN6QyVxH+d+3EhVUrMXTm0kwBd6
	3U1/jeU9UNtQZexxDDLYMfzxMyh0R1v98U8z5OlEQ+ETWP2DK8opH77aNgkFV8fNrV5a82d5hF0
	MyiNscHCYpfdbHUNQs6wK5ao19CmYX3+UnW1C7N2NN/8bI2V7JedGkhwqmVhWOw==
X-Received: by 2002:ac8:5912:0:b0:450:efd:723 with SMTP id d75a77b69052e-453125552fbmr13163341cf.4.1723219780567;
        Fri, 09 Aug 2024 09:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtbIkutydCKQHHfrahTRflQkyMYGSh3zYrObmthmw14T659Ni251Xo72HIqIFQZU+hooLp2A==
X-Received: by 2002:ac8:5912:0:b0:450:efd:723 with SMTP id d75a77b69052e-453125552fbmr13162951cf.4.1723219780083;
        Fri, 09 Aug 2024 09:09:40 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	peterx@redhat.com,
	Will Deacon <will@kernel.org>,
	Gavin Shan <gshan@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alistair Popple <apopple@nvidia.com>,
	Borislav Petkov <bp@alien8.de>,
	David Hildenbrand <david@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kvm@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-s390@vger.kernel.org
Subject: [PATCH 11/19] s390/pci_mmio: Use follow_pfnmap API
Date: Fri,  9 Aug 2024 12:09:01 -0400
Message-ID: <20240809160909.1023470-12-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240809160909.1023470-1-peterx@redhat.com>
References: <20240809160909.1023470-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new API that can understand huge pfn mappings.

Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/pci/pci_mmio.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index 5398729bfe1b..de5c0b389a3e 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -118,12 +118,11 @@ static inline int __memcpy_toio_inuser(void __iomem *dst,
 SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 		const void __user *, user_buffer, size_t, length)
 {
+	struct follow_pfnmap_args args = { };
 	u8 local_buf[64];
 	void __iomem *io_addr;
 	void *buf;
 	struct vm_area_struct *vma;
-	pte_t *ptep;
-	spinlock_t *ptl;
 	long ret;
 
 	if (!zpci_is_enabled())
@@ -169,11 +168,13 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
 
-	ret = follow_pte(vma, mmio_addr, &ptep, &ptl);
+	args.address = mmio_addr;
+	args.vma = vma;
+	ret = follow_pfnmap_start(&args);
 	if (ret)
 		goto out_unlock_mmap;
 
-	io_addr = (void __iomem *)((pte_pfn(*ptep) << PAGE_SHIFT) |
+	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
 
 	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE)
@@ -181,7 +182,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 
 	ret = zpci_memcpy_toio(io_addr, buf, length);
 out_unlock_pt:
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 out_unlock_mmap:
 	mmap_read_unlock(current->mm);
 out_free:
@@ -260,12 +261,11 @@ static inline int __memcpy_fromio_inuser(void __user *dst,
 SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 		void __user *, user_buffer, size_t, length)
 {
+	struct follow_pfnmap_args args = { };
 	u8 local_buf[64];
 	void __iomem *io_addr;
 	void *buf;
 	struct vm_area_struct *vma;
-	pte_t *ptep;
-	spinlock_t *ptl;
 	long ret;
 
 	if (!zpci_is_enabled())
@@ -308,11 +308,13 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
 
-	ret = follow_pte(vma, mmio_addr, &ptep, &ptl);
+	args.vma = vma;
+	args.address = mmio_addr;
+	ret = follow_pfnmap_start(&args);
 	if (ret)
 		goto out_unlock_mmap;
 
-	io_addr = (void __iomem *)((pte_pfn(*ptep) << PAGE_SHIFT) |
+	io_addr = (void __iomem *)((args.pfn << PAGE_SHIFT) |
 			(mmio_addr & ~PAGE_MASK));
 
 	if ((unsigned long) io_addr < ZPCI_IOMAP_ADDR_BASE) {
@@ -322,7 +324,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	ret = zpci_memcpy_fromio(buf, io_addr, length);
 
 out_unlock_pt:
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 out_unlock_mmap:
 	mmap_read_unlock(current->mm);
 
-- 
2.45.0


