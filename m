Return-Path: <linux-kernel+bounces-302178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BF695FADD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B462878CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C21A00D0;
	Mon, 26 Aug 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxcAdmuP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CAC19F48D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705065; cv=none; b=oIjDtQ7aKyS2N51TJPpYc7nzjaebL9E2jgrI2cEL+pzNfxLG614h6D0XKdPFg5KMuqwjZqtE3vZlG0wvYQZ30K/pRIm+6ZwqdHmArXMUqNneBxTZutEOkUJ4Mgnio9Q1FPONOaagRsDyhLp5ChmcjIe9oBYcWpk+eEdNYeWMXUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705065; c=relaxed/simple;
	bh=tylq1muqjeOnFYCjzZOC/g07tmHzw2/ZVGGdJsJupkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTMYJkHQKispQu96h+TlYs2yuTFhs0RnOSnQ9BHHkJ7m/FydfRd237Wrt5B4Ormf2YpWgNv6+wLLhzTBfPlQeyyrkfyD6nbaoIU6AUybcpHccd754qNSq4MANEqagRV49fvu7amI/ThyyjN1WKCgdA/xOaYV1yIrPpxR9RAHmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxcAdmuP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moprxbUn5M7+L+63SZwwyqeq4iL0OHeeIJZbsfnkOho=;
	b=HxcAdmuPLoLk68HBgsFHMBqHzb3/HG0/m9q/YAKsQa2mSWy7hp18G1FsjSvE5iTW+OqvlS
	VMCq2Hv4UindeGb2QaUSEYKR4MrkG7UGBoHZBp3BSQXMi5rfSn2cms1lsBhXDtijYD5deA
	pvNZk1YZMrPOqcXq3j3aIVjCF6tY9kw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Wob4E6cPPrKtuoz43f_vBA-1; Mon, 26 Aug 2024 16:44:21 -0400
X-MC-Unique: Wob4E6cPPrKtuoz43f_vBA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d4335cceso884882085a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705061; x=1725309861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moprxbUn5M7+L+63SZwwyqeq4iL0OHeeIJZbsfnkOho=;
        b=ffX0qyfr+EYXxbDy37iwFOhMIiv5H1AephRWUHT1mY1WpDrvuhH2vCyJpMsh9GYb1y
         z98cDLYPh0EyQ4AHLfkVMwXydrhPbC+dIVJFLOSaxn8RWp7NoIJDZ1j/pm5wjowm+/kz
         cIxGUs2sFOzt+LfVJP/WbTNKoX1Mct9H3YmjiLUBii6pID8WbQDl5vurhYde2foGbbnI
         Fqc8+1Y13yYiYTxsXR+1aP6MBV9joInYLpdQP9ES1dzhE6eW7hExIm4pZLtPDanptjJ1
         W6cQRBpGE22z+qLWhS56wxQzt1ZKSp8RKRPCxBp0gIUgmdOAtsChxSgRMa1LrHDgOGIS
         oAYQ==
X-Gm-Message-State: AOJu0YyM9kGFZpiuEagdqFsFwhYbWTClsusftMagGoBiOi3eZL6hLprz
	yN4vcdWhTmuYbvVM9vMCT4VUA/OxJZ714CG5WNrRaKxRtYcLSHn+Nnm4GY4fIWeuIj3s/LD0i2J
	TEu+ppUJ7nRWVKzoJ5XxTfYUSUBxthoWFUuNWNsfG7WGjRZ+HmkSIh4wfYNeOACGLqbfaw2BinT
	OeRp+39NmDJVQdGt8RSo4lMQRJ58QTSlmtiClwpPd98wE=
X-Received: by 2002:a05:620a:1a92:b0:7a1:e341:d543 with SMTP id af79cd13be357-7a7e4cf3a3fmr158799485a.28.1724705060771;
        Mon, 26 Aug 2024 13:44:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8L+Naz3FkxDynSQ3yMse2qHglqFkf4LqBPi/5cD3sQEuFfYs6yWPMbT2Qk9XtpK98A+7trg==
X-Received: by 2002:a05:620a:1a92:b0:7a1:e341:d543 with SMTP id af79cd13be357-7a7e4cf3a3fmr158793685a.28.1724705060390;
        Mon, 26 Aug 2024 13:44:20 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:19 -0700 (PDT)
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
Subject: [PATCH v2 12/19] mm/x86/pat: Use the new follow_pfnmap API
Date: Mon, 26 Aug 2024 16:43:46 -0400
Message-ID: <20240826204353.2228736-13-peterx@redhat.com>
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

Cc: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 1fa0bf6ed295..f73b5ce270b3 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -951,23 +951,20 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 		resource_size_t *phys)
 {
-	pte_t *ptep, pte;
-	spinlock_t *ptl;
+	struct follow_pfnmap_args args = { .vma = vma, .address = vma->vm_start };
 
-	if (follow_pte(vma, vma->vm_start, &ptep, &ptl))
+	if (follow_pfnmap_start(&args))
 		return -EINVAL;
 
-	pte = ptep_get(ptep);
-
 	/* Never return PFNs of anon folios in COW mappings. */
-	if (vm_normal_folio(vma, vma->vm_start, pte)) {
-		pte_unmap_unlock(ptep, ptl);
+	if (!args.special) {
+		follow_pfnmap_end(&args);
 		return -EINVAL;
 	}
 
-	*prot = pgprot_val(pte_pgprot(pte));
-	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
-	pte_unmap_unlock(ptep, ptl);
+	*prot = pgprot_val(args.pgprot);
+	*phys = (resource_size_t)args.pfn << PAGE_SHIFT;
+	follow_pfnmap_end(&args);
 	return 0;
 }
 
-- 
2.45.0


