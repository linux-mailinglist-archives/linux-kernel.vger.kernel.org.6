Return-Path: <linux-kernel+bounces-302180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBC95FAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD11F23DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236071A0707;
	Mon, 26 Aug 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHPLT0oc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0131A01B4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705069; cv=none; b=Df1NOVj3CCWdz554pG96WRzx/3UtMcf3dnqbLVJfuTL5c4NAkb92waxIKOWyVpZ710vzhxr2bN+pk8JAQFHDcH0abOlVIOXOsIVTFs14SwpVbC69d34pqTjjz8yiFMAGIc9bK54lHST2vynlWp6WS3p4nE35KxJf//XwiDKvG/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705069; c=relaxed/simple;
	bh=RxaKGf99KcIXWtv8SyMqO8KfjLx2VTZrfelSTDMLhuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lx6h8AZnxKnXTBT7qm7g7rlIDXBgenkcYH5z4HlUFL+Jqc0XIy2fd17lzDX5IODxLRLegVuS1blHI28FJdmTZuh8qYZHcgvRrmnB1yh3UI95mindnCbIR/1GselFYTMKUTqAnXvYKej5H5k/wZF1VImXyz6/47dQVUzAUvt0BV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHPLT0oc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d0kI5he4gLOJUpsF87CpEeiS1FOCa69CaYI81su9df0=;
	b=XHPLT0ocyeIQ6bYspsizMfyy1L6CijBqwhoWZYQQKXNk5pXtlAAmZMWKWiCexzSL0kNvjI
	+TbjBiSfURXsDzVHKba+Jtk3fRwp2PyRZmfY4iq+qek+n77XJpc/GLCkS2p1OUneD2wf70
	i3Zj+AJdEOOwMpGLsPMKrRUv81iBb1s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-dEu0rxf5Nmqf_AHydX0Tyw-1; Mon, 26 Aug 2024 16:44:25 -0400
X-MC-Unique: dEu0rxf5Nmqf_AHydX0Tyw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1dbbe6d6fso633463085a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705064; x=1725309864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0kI5he4gLOJUpsF87CpEeiS1FOCa69CaYI81su9df0=;
        b=Py0L0XL9lnzd3qgzwntIlrW6bFYBFcPadQVyYEhGVRI3Nc74bNDbEfgkDuKUKY7OEp
         XAizfzHfmApGS/RgeSTr40jybYegSfyYPwoS6P5hgJ1IDviWUNWb7umFGBFkM6sJGmQx
         dquDXlsEURe89kMg3vPkxCGJA51x6wrIip1QgnCsJSY8GoGOCWX/ugPf1H41IZuuiiDa
         IaaWqJpCtuxwZx6cPAEUWeCQnrk0KT+V/oreJkIvFaXQNCnaCWaykOVfXKvcP8PaONRU
         hVSc4HcEGB7ZwPOKWstV7/1Ap9j3UX/YfplCfy9zWgtzN8twR7mm2q9j68prvKLyWQgs
         5neQ==
X-Gm-Message-State: AOJu0YzXXgkhEO5/60yk2QiWEb6BPS5epjD0OC3xog50qNJgHIgLYDL0
	kgjQBteaCbMq96i/Rha2m/AWXCPKcnmcQcqsUjjN8t5b3J/+zXNTQnoHZj+gVasAE2+oE0ji7Bb
	Pj9tBpdDuw78ZbI/BZRUWQOtBoDjRPmLWC+QFJPEsM38qTZhOt6ccl1xjciyOmp/FXik5RVZ+Ed
	PlMxbut+dvharf9PYkMAg20X8/fD70Jrf4v4NSxUZAH6Q=
X-Received: by 2002:a05:620a:2484:b0:79e:ff41:fd47 with SMTP id af79cd13be357-7a7e4dc9528mr93290485a.28.1724705064691;
        Mon, 26 Aug 2024 13:44:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEloa5qz2QVMofE8PCWJJ6gTfdMgC7cjn+h2anZ9qsldjcOaIzzaCXqVOAeeqkMcyU6B13FuA==
X-Received: by 2002:a05:620a:2484:b0:79e:ff41:fd47 with SMTP id af79cd13be357-7a7e4dc9528mr93286485a.28.1724705064315;
        Mon, 26 Aug 2024 13:44:24 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:23 -0700 (PDT)
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
Subject: [PATCH v2 14/19] acrn: Use the new follow_pfnmap API
Date: Mon, 26 Aug 2024 16:43:48 -0400
Message-ID: <20240826204353.2228736-15-peterx@redhat.com>
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/virt/acrn/mm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index db8ff1d0ac23..4c2f28715b70 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -177,9 +177,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	vma = vma_lookup(current->mm, memmap->vma_base);
 	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
 		unsigned long start_pfn, cur_pfn;
-		spinlock_t *ptl;
 		bool writable;
-		pte_t *ptep;
 
 		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
 			mmap_read_unlock(current->mm);
@@ -187,16 +185,20 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 		}
 
 		for (i = 0; i < nr_pages; i++) {
-			ret = follow_pte(vma, memmap->vma_base + i * PAGE_SIZE,
-					 &ptep, &ptl);
+			struct follow_pfnmap_args args = {
+				.vma = vma,
+				.address = memmap->vma_base + i * PAGE_SIZE,
+			};
+
+			ret = follow_pfnmap_start(&args);
 			if (ret)
 				break;
 
-			cur_pfn = pte_pfn(ptep_get(ptep));
+			cur_pfn = args.pfn;
 			if (i == 0)
 				start_pfn = cur_pfn;
-			writable = !!pte_write(ptep_get(ptep));
-			pte_unmap_unlock(ptep, ptl);
+			writable = args.writable;
+			follow_pfnmap_end(&args);
 
 			/* Disallow write access if the PTE is not writable. */
 			if (!writable &&
-- 
2.45.0


