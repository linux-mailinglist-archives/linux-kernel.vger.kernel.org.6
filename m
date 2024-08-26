Return-Path: <linux-kernel+bounces-302181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6E95FAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896DD1C2130A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8291A0704;
	Mon, 26 Aug 2024 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE2//aLs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2D1A01DB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705071; cv=none; b=HxgmESalJihDU2kghNU1ZDBMpJvGpR7ohcz6yXE9nflOZ/eRyrJ1IDEixkawLHQonzRKiz65sESRKdGdv4rTvntwm2VtRuV6pnAKyBYiUVuxbUhewjoNdY1C3g7WUk2yMIqc5PfWU4NaIO2zmDxpS403LhsDf6mDeOdlDTk88Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705071; c=relaxed/simple;
	bh=hpLmEYhsByAEmqEdBsP006I9UauZryxW/FlKEPWnJc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foliOG1ioSZ/GpC5VLARFpBkC3YFkbvdOgHZU5LarTYOgoAr3wvqiAZ0JC7qcxjgHFUrKOtDjB1pJux78JezjakFAFWyytFULk1zCG/7zbYLybu8eX4b8Ai1T/v40wclXGgKBqljyvl8wNwQSPTXJa+JjkWInEGjDNWuA4YT7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RE2//aLs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t75nynj+5ccZ6qy3UooqAYOOLyCQeJyCwmKKtTf1Ss4=;
	b=RE2//aLsidYqxI/Vq6eXXVa8odw+UOLLRE4cBut+e9JGmNhrdEGZav1WTRmgPolejdkoS2
	GXNceF38y1X7f85RMpx7fRHAn8o442O4PKfKb9LIQkO53QWXQISHWxIDypra9ZkyCgoLm1
	ySXdhrh0LQKdxI7FLpsx0tu4+ft/VvY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-D7N-VvAvOwC6mlQfdZ9-7Q-1; Mon, 26 Aug 2024 16:44:27 -0400
X-MC-Unique: D7N-VvAvOwC6mlQfdZ9-7Q-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-27061a48e70so6268040fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705066; x=1725309866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t75nynj+5ccZ6qy3UooqAYOOLyCQeJyCwmKKtTf1Ss4=;
        b=MNnhRXH2hWKqWD7GuqQiTNR0Oqk8pbmXq1inENNDPRmW/tD2XP9QtNI9bSGgqlSosb
         nngxzAAV9IUrJj/rUzEtCOfdt7LVXbQVD24mnteAeI+TbPnkODecTHdk7bSx3w7INT1a
         yWBw3bYN2kpqgVPv8JrIbl+PRno7gl9ntxpf9buboZZusbbm7OCzrOvOW0pKI5W3dVqh
         Ff4OdRzpKzJPzUoD9jgVm+I9e0j6t/L9PSwXM/kbun7C2wBzMDEn1moOODRLHAwkFpFe
         rHO/ZjdL1ie7b2CGcHYlaKAYTN26D0ILLzoNuyLiAu/n82697yC17+4DbK5SK71X5ntq
         4Xlw==
X-Gm-Message-State: AOJu0YxgU2mMFFCG6cAejK1SM2KsztbSMnnU+6yWauissbZO7DfDyiE1
	V0CZ05kWYalsGeHyXlwNdKpIthMO+s6jz3jMGzY8c7wPI3e5qdTzSF+OSNvnMM8uXlAdl0Id1qR
	egRNEzTDiR0AhmbzoZ7kiVc7lit3BbuMp4OodkIdbkiZm4KxayAFNKOW/Ya0e9XBz/jK5QgDEvR
	L7TaXnVCp3rmaBSJIbjzYs9ZZOEzFPt7A+DR28JAtm7U8=
X-Received: by 2002:a05:6358:3a07:b0:1ad:10ff:341e with SMTP id e5c5f4694b2df-1b5c3a3b69dmr1457845255d.4.1724705066593;
        Mon, 26 Aug 2024 13:44:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoPajws+HFHWojCbb3D8qBEyBE/zIeN3nkxAxD5pVBn23+qUQ20h6jqSHyvqmBY4DTTGYw+g==
X-Received: by 2002:a05:6358:3a07:b0:1ad:10ff:341e with SMTP id e5c5f4694b2df-1b5c3a3b69dmr1457841255d.4.1724705066240;
        Mon, 26 Aug 2024 13:44:26 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:44:25 -0700 (PDT)
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
Subject: [PATCH v2 15/19] mm/access_process_vm: Use the new follow_pfnmap API
Date: Mon, 26 Aug 2024 16:43:49 -0400
Message-ID: <20240826204353.2228736-16-peterx@redhat.com>
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
 mm/memory.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 0b136c398257..b5d07f493d5d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6342,34 +6342,34 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	unsigned long prot = 0;
 	void __iomem *maddr;
-	pte_t *ptep, pte;
-	spinlock_t *ptl;
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
+	bool writable;
+	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
 
 retry:
-	if (follow_pte(vma, addr, &ptep, &ptl))
+	if (follow_pfnmap_start(&args))
 		return -EINVAL;
-	pte = ptep_get(ptep);
-	pte_unmap_unlock(ptep, ptl);
+	prot = pgprot_val(args.pgprot);
+	phys_addr = (resource_size_t)args.pfn << PAGE_SHIFT;
+	writable = args.writable;
+	follow_pfnmap_end(&args);
 
-	prot = pgprot_val(pte_pgprot(pte));
-	phys_addr = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
-
-	if ((write & FOLL_WRITE) && !pte_write(pte))
+	if ((write & FOLL_WRITE) && !writable)
 		return -EINVAL;
 
 	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
 	if (!maddr)
 		return -ENOMEM;
 
-	if (follow_pte(vma, addr, &ptep, &ptl))
+	if (follow_pfnmap_start(&args))
 		goto out_unmap;
 
-	if (!pte_same(pte, ptep_get(ptep))) {
-		pte_unmap_unlock(ptep, ptl);
+	if ((prot != pgprot_val(args.pgprot)) ||
+	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
+	    (writable != args.writable)) {
+		follow_pfnmap_end(&args);
 		iounmap(maddr);
-
 		goto retry;
 	}
 
@@ -6378,7 +6378,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	else
 		memcpy_fromio(buf, maddr + offset, len);
 	ret = len;
-	pte_unmap_unlock(ptep, ptl);
+	follow_pfnmap_end(&args);
 out_unmap:
 	iounmap(maddr);
 
-- 
2.45.0


