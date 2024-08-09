Return-Path: <linux-kernel+bounces-281194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FC794D436
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843131F22B57
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CE7199249;
	Fri,  9 Aug 2024 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENTiQqA4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D431991D8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723219763; cv=none; b=YzSeEJQxk4TeXSg1bKZL+0uH25keMIuJiQyNtWecYo5HvV0f1DHhErv16SwL0z6xNilTyGF5fXtWdQyd+bAhrqmYu+3p+M8fv2FFeJWPMD24bKxkQcdYcRvIZCkuM30RInE/PVZa8vaESv8nlRr7jFfyZwA1p/HMMOAQv/Yk5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723219763; c=relaxed/simple;
	bh=AwZNgy93B60KruQhwAcu4Flier/Awee4T8kw3wLwJnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gqb7c8TTMw4mQaOK7qdHGxLW8vq1VdBUPSlbCSAdmtHJG3yF0Z+zIlDgdzxkCxL9OjEuar+2CKgZfolNWZ5QgJbfMknfygFEhPicxINDLlQh66Ysy5Cd9bffKV2ijizRtFk58ZH4riF8Rtw4OmgUrhS9Sg1qs9sCOuLXDievY1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENTiQqA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723219761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVA/urUlESz7em6kHS5QV39/c1UeLmTRXD3YGysY/mU=;
	b=ENTiQqA4VbQN/w4C/smJFN+6Yu24MJ6sEnmnXFNX7tpxuYeDHqzBr7m3xWbC4F3Dw31Ha5
	8uzxv0lSCKdq24EQtipjZd9rLENU1sY4Gq6AMsTDAKhBL3oN9JI1yhA8OVYqlC8mKUpdxj
	eIPGIdcIaSvd8c5Dp0k+B6KeUWWm8Sk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-TG5umZlmM0q2YehwUODtCw-1; Fri, 09 Aug 2024 12:09:19 -0400
X-MC-Unique: TG5umZlmM0q2YehwUODtCw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a1d3c02fcfso7765785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723219759; x=1723824559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVA/urUlESz7em6kHS5QV39/c1UeLmTRXD3YGysY/mU=;
        b=KR6AbbTkZiX9gn64hcFxKC/Tlb3zWW/3j+XqCjyvOn0QIOLVU2DWmij1Z6re2TlsQb
         8Kf2/2mntfGALWVAhnDhHVfQW5cUv+FiGwnmxTGjNl28lYKrxvgKAjp/q7PULVYsPTRg
         ao1mHRHbWhGuyJKCwSF2JX/BeghvTJEod6OqtkOVn27uI8KwiAwpSvLq9IWl2Vxaal30
         y2ITMbCEmyYYzbV0WKrH1e2W8V3qv9lF7jpV8fsYzdslUoxtQD5+I4aCvD5EnUqKtCLr
         o2gT7sn8S1WAcv5NV4fn3IvYEI1ve2kAvMZnsk/YTgAPGiceuVhahOMtbGnZTVdQLImY
         1nHw==
X-Forwarded-Encrypted: i=1; AJvYcCXzzMNu6+GYa9+LOu7ran0iSGfeLtFE2xeJ4toDXVUJ4iC0wqnAUxKqEAljCa1YUEhIVA5MQIv3sPxR2hOyQI0nlNC+be3u6Pc6eLeE
X-Gm-Message-State: AOJu0YyPIUE2QG3l2ybsqURYzat75e99IP/ErzP0HIB/C+EilhL/pYVm
	+gVSpdGxCyQ3Si6OasWGrVRTW2pEm73goVFHboiDsMXFxIRqwUTttUbE+hES6pqagZkC7W3w2p/
	2VsB+Lp+CYjCu+Z946ixAgwTG2yOSAk2Nj5ij5Lw6TfLUIIuw6OwuDUEVPxPnUQ==
X-Received: by 2002:a05:620a:2906:b0:7a1:3ff9:1e1 with SMTP id af79cd13be357-7a4c16af689mr138619685a.0.1723219759091;
        Fri, 09 Aug 2024 09:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHesXKAH7m1pKPVMriR5+O5cSg1VUsP7Em6MavFjtwcHLSKYNYbUt0UMVXsf+PUo1OYJsvsTg==
X-Received: by 2002:a05:620a:2906:b0:7a1:3ff9:1e1 with SMTP id af79cd13be357-7a4c16af689mr138614585a.0.1723219758659;
        Fri, 09 Aug 2024 09:09:18 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c870016csm22526741cf.19.2024.08.09.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 09:09:18 -0700 (PDT)
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
	Matthew Wilcox <willy@infradead.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH 02/19] mm: Drop is_huge_zero_pud()
Date: Fri,  9 Aug 2024 12:08:52 -0400
Message-ID: <20240809160909.1023470-3-peterx@redhat.com>
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

It constantly returns false since 2017.  One assertion is added in 2019 but
it should never have triggered, IOW it means what is checked should be
asserted instead.

If it didn't exist for 7 years maybe it's good idea to remove it and only
add it when it comes.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/huge_mm.h | 10 ----------
 mm/huge_memory.c        | 13 +------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 6370026689e0..2121060232ce 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -421,11 +421,6 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
 	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
 }
 
-static inline bool is_huge_zero_pud(pud_t pud)
-{
-	return false;
-}
-
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
 void mm_put_huge_zero_folio(struct mm_struct *mm);
 
@@ -566,11 +561,6 @@ static inline bool is_huge_zero_pmd(pmd_t pmd)
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
index 0aafd26d7a53..39c401a62e87 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1245,10 +1245,8 @@ static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
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
@@ -1496,15 +1494,6 @@ int copy_huge_pud(struct mm_struct *dst_mm, struct mm_struct *src_mm,
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


