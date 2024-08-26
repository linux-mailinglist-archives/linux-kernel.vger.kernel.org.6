Return-Path: <linux-kernel+bounces-302179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4895FADF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FDD1F24006
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA911A00ED;
	Mon, 26 Aug 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROlX2I7U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138551A00D1
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705067; cv=none; b=aHkMNnybE71Nv1iqleMykHsscnlw0SD4qN57+lvkzTIAc+ApPXhJYBrQeVDwGk0hiAXkN9gZXXDkMVnw4+PV36lHrwBoqhEqPyzSelp/YXF62a2eajqZ7N57PkA2lBxCYSbjXxHDsK6ey4R9lL6zMLelGNsxHHXT53GD0c+VH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705067; c=relaxed/simple;
	bh=BQuf5gTrb+LFvvLLmklTnMaR8Ti7tRzNRxtQXaWJ5ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlE7I70UTiR8msX2u0CahdHProLEtj28gGggDRw8L6yID4yDUYaDh07bxBzN2+j51tRW7L6bc6bgjiB/qu8sfrbZ42qHI7LbjwuEKIey5Wl6eTnOIeCppqOJtHl0bYsTXQoBysU3P5agasYV8zLl1eAlqdkHOf3QIGFO6mQYosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROlX2I7U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HLBqit68L/U2mdwYaFkydFK3txHa+LkmL8n2YTQXnnw=;
	b=ROlX2I7Uk0h0z/EbbmrjDDC5L29amroUx7hw0sQuUWaJcsejLWRGRU00SYIbG5ySa8JXjC
	uqyVHAHgbUauLWAMse/7JAyxacnpa+tFTp2wyIVzB9I3jgPPt6i+dEz79NV8nepxwu/3Cm
	oJ3OMld4i7C3pSc++uPKF+BlKbQ9V3o=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-2Rh4yhghMe2FmPIezQmz3A-1; Mon, 26 Aug 2024 16:44:23 -0400
X-MC-Unique: 2Rh4yhghMe2FmPIezQmz3A-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6643016423fso96108047b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705063; x=1725309863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLBqit68L/U2mdwYaFkydFK3txHa+LkmL8n2YTQXnnw=;
        b=HMlr6j/52tp66i3aMRgsC36P4O7LHk23fxzf7OT52NznTKJGhUVmAkkZjkzHvmX7IN
         xvXjpbwNtZKMxtMnWFhsPklSyrzrOiKxifq0OZQbSu1afrTE8csYMPqgfEFHrnlWYwAe
         OE2+PHoJRrPKREJrriperHslBqFrrLstvFO18gqjJ7nmKM3vAuvX4dqNNujAcrccIsyR
         iilHMYknzC+0ioEyAcCWqFZvt7bilXQKwKDcVg7SS9T3lESNsWP/sZe2u07o4QTlDxWW
         o5A6SZ/i7oP62DfSAio/X4V8t7bODPxh8NZFUPp369uBPZscdmy0Y7Xv9+oXTn79kQMB
         E/uQ==
X-Gm-Message-State: AOJu0Yx2fTiRmIfDDFXhOH44XXb382Au7LuMgATU7pFY4EbA2LwIXmiJ
	/p0I8c2t3v6gUlD0LfW69JS4QNce4ia5W/NqYXcVcgkZ6X4gRVK6fmsqt0RFtVkGnBIFj+5dTZB
	EA8McMv2sl5pQb8Th62O95yrX9O5ZlxtSU9AdCwgH3RvizTFm0Q8bHfTNaEcD9bfoKzUxtxSDlV
	aHHzOBEEFEw6X13OgwjBpWpPSzT6gN3n7vslspomd1ZGI=
X-Received: by 2002:a05:690c:39b:b0:62f:aaaa:187a with SMTP id 00721157ae682-6c625a4cc55mr151107117b3.14.1724705062820;
        Mon, 26 Aug 2024 13:44:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeaoJv/EbB8r7mSzacjacGidgTJuNMUQKi5I30qkj93MEO5BseX564RMMiUfXmELj5ALvNSw==
X-Received: by 2002:a05:690c:39b:b0:62f:aaaa:187a with SMTP id 00721157ae682-6c625a4cc55mr151106717b3.14.1724705062426;
        Mon, 26 Aug 2024 13:44:22 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:21 -0700 (PDT)
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
Subject: [PATCH v2 13/19] vfio: Use the new follow_pfnmap API
Date: Mon, 26 Aug 2024 16:43:47 -0400
Message-ID: <20240826204353.2228736-14-peterx@redhat.com>
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

Use the new API that can understand huge pfn mappings.

Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0960699e7554..bf391b40e576 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -513,12 +513,10 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 			    unsigned long vaddr, unsigned long *pfn,
 			    bool write_fault)
 {
-	pte_t *ptep;
-	pte_t pte;
-	spinlock_t *ptl;
+	struct follow_pfnmap_args args = { .vma = vma, .address = vaddr };
 	int ret;
 
-	ret = follow_pte(vma, vaddr, &ptep, &ptl);
+	ret = follow_pfnmap_start(&args);
 	if (ret) {
 		bool unlocked = false;
 
@@ -532,19 +530,17 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 		if (ret)
 			return ret;
 
-		ret = follow_pte(vma, vaddr, &ptep, &ptl);
+		ret = follow_pfnmap_start(&args);
 		if (ret)
 			return ret;
 	}
 
-	pte = ptep_get(ptep);
-
-	if (write_fault && !pte_write(pte))
+	if (write_fault && !args.writable)
 		ret = -EFAULT;
 	else
-		*pfn = pte_pfn(pte);
+		*pfn = args.pfn;
 
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 	return ret;
 }
 
-- 
2.45.0


