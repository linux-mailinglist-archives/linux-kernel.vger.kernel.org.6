Return-Path: <linux-kernel+bounces-302168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630DC95FAC7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 22:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8B3284C80
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49019CCEC;
	Mon, 26 Aug 2024 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBoBoFEr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01119AD7E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724705045; cv=none; b=jPJ8GaI5wCBqO7th/TXw+JICmylW0N3EAWy8JmXSDmYLMD1eF2x8Th+bVPEwWSCZRKupfJeG05J00fQ+O963Uyty4DeCh1B+zwdoq5nY1RFWkSUW3nu17kzV1idT5qTHoay6qQYSRqS6IVVmDGckYP9VizFp2SruQ6WYp8zHySk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724705045; c=relaxed/simple;
	bh=34MqcYAeedS1HMCphQeI6ozj3aHeCly2AzsezqBdon4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GucAZB7W2lC5v7fJL+6YsagsI8Ba//jUQPiOYRHyRQ+bi9NjxbWlhFhGK6NCjRCttWXJmLYmQ7hVroGtX2sceN7Qk6iHINyua+Xad0EOStND024+r8t8wuO5SxSnkEfAtDqIz6PnbEnfvgvuboc+oCOCB+zBP7hBimRst7OImm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBoBoFEr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724705043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rCV2q6t08l8ndW0pGxUU3F/GDhRRI1SX3G16E23iQDg=;
	b=jBoBoFEr0jb36+d9AWMwiUzDB1QmjCvw8b41LINAueOmv0Ve5Ce3jQphOq0oMQPNTZ3Ryw
	l4OCLP2nHjw3eZ0VCK3LfGQVkxfIHoBBOTuV8x5AY/EaOKV6WKf04RmmO/5ZJs8DdNaVYW
	wP8QHhV4K2UY+8b7ymLfVmzvfL1VUMc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-1HBWbHlSPBmy2Tvgr0nz-w-1; Mon, 26 Aug 2024 16:44:01 -0400
X-MC-Unique: 1HBWbHlSPBmy2Tvgr0nz-w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a66b52c944so520440285a.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724705040; x=1725309840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rCV2q6t08l8ndW0pGxUU3F/GDhRRI1SX3G16E23iQDg=;
        b=IpEZi+CyuC3SOqLLrTqhWn9VFSxBhXo862xmGD9TnignRtJ6fh5f4SzEPxzYc9rvW1
         RpMBJIFWnePDgqeTd5F/eYbskWry9FsJ4JbxIFcJ+1y3tOHkTtauZM9yQwKdcwqErieR
         XSpUUmQZHssAxkre1b6X1ObMgkcSBL0IHObXBDki+oAPgHGbh/JsGmksFJca/DXio+jq
         HkudBuAKuTz89AFCN92jfG0S4WzpWQ16PQB0DanuQjbFaMQmlC4yAXpCg2FmEynpxNnf
         eazw7yHYayNr1nofTzXqCdNfN5/N+TYfwJgEOKAQew7Rk5Kt2wcg1qEUsXppcrkhcQJ7
         oqkg==
X-Gm-Message-State: AOJu0Yz+fPAD3+xH+JO1frZJSvbP8GvUaIRdLuWy+rwxxJdD+cugXj8A
	t9vn2zDIzp3qFPUlRH7toZOCnV8gLdMNHqwwRMnaFtQqZaIYAN+P4o3JQ8l6eQLSLzCU79bJ5Yy
	W5Z6Vo0eBd1A23kqpsIfKhH9jmFVuMqnVZlQ2tFeyno1LEyXeGZyl0Aznubzm1uda++6Z0ceVwV
	TZzSXIwH36uy3QENQ60wJOjHjfrtJ/jyWI372UBH/QH3U=
X-Received: by 2002:a05:620a:28c8:b0:7a1:62ad:9d89 with SMTP id af79cd13be357-7a7e4e6d3c1mr92956985a.64.1724705040577;
        Mon, 26 Aug 2024 13:44:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW5yVxsMo5HJEI7stPZogQTAiTuzeFOof5FGrO8bEsBYthlHw7SRF31ZNT2saoeMAKCiiqzA==
X-Received: by 2002:a05:620a:28c8:b0:7a1:62ad:9d89 with SMTP id af79cd13be357-7a7e4e6d3c1mr92952485a.64.1724705040096;
        Mon, 26 Aug 2024 13:44:00 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3fd6c1sm491055185a.121.2024.08.26.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 13:43:59 -0700 (PDT)
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
	Alex Williamson <alex.williamson@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v2 02/19] mm: Drop is_huge_zero_pud()
Date: Mon, 26 Aug 2024 16:43:36 -0400
Message-ID: <20240826204353.2228736-3-peterx@redhat.com>
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

It constantly returns false since 2017.  One assertion is added in 2019 but
it should never have triggered, IOW it means what is checked should be
asserted instead.

If it didn't exist for 7 years maybe it's good idea to remove it and only
add it when it comes.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 10 ----------
 mm/huge_memory.c        | 13 +------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4902e2f7e896..b550b5a248bb 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -433,11 +433,6 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
-static inline bool is_huge_zero_pud(pud_t pud)
-{
-	return false;
-}
-
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
@@ -578,11 +573,6 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return false;
 }
 
-static inline bool is_huge_zero_pud(pud_t pud)
-{
-	return false;
-}
-
 static inline void mm_put_huge_zero_folio(struct mm_struct *mm)
 {
 	return;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a81eab98d6b8..3f74b09ada38 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1429,10 +1429,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
 	ptl = pud_lock(mm, pud);
 	if (!pud_none(*pud)) {
 		if (write) {
-			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
-				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
+			if (WARN_ON_ONCE(pud_pfn(*pud) != pfn_t_to_pfn(pfn)))
 				goto out_unlock;
-			}
 			entry = pud_mkyoung(*pud);
 			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
 			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
@@ -1680,15 +1678,6 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	if (unlikely(!pud_trans_huge(pud) && !pud_devmap(pud)))
 		goto out_unlock;
 
-	/*
-	 * When page table lock is held, the huge zero pud should not be
-	 * under splitting since we don't split the page itself, only pud to
-	 * a page table.
-	 */
-	if (is_huge_zero_pud(pud)) {
-		/* No huge zero pud yet */
-	}
-
 	/*
 	 * TODO: once we support anonymous pages, use
 	 * folio_try_dup_anon_rmap_*() and split if duplicating fails.
-- 
2.45.0


