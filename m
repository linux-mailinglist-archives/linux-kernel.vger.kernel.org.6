Return-Path: <linux-kernel+bounces-533952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49595A460A7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598D73AB0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA762206A4;
	Wed, 26 Feb 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGvwjXfF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0392921D3E8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740576189; cv=none; b=U1YPQGSiluMaTghDkFSYsQqcaHSToutOmk6qYDABWYksTKzr97Zka8AoiEXEC9u8Uh/cK5KuT0ixzAXszOFGQgBVJqsLVWMyHtSuMNT/gG5N7YYPWqaV1K9vo78DBcCMM0ptKhshw2Q7S6iy4YLPRYtpopaVS9eTBt7hC+MHEZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740576189; c=relaxed/simple;
	bh=hv5cF+FmSUQB66FkGgLYhQwLyFrYJdO5vHdxITDFaBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=baGaMDwsdTCMMHSQw7RVZhaqK2nJh74ZTm6DDQIyhNjrA3FeJHJNngn3OV6tR6jB26ZBNAcBtRP69qYWwgTaUTYilg/i0cGzuveV5tUGAJgselPUq5ir0+Oq/+pts7TOwoyvqn0n6UqaLBGkaS9LMojS+33yKOW42aopoEoJeQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGvwjXfF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740576186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BAb0fo+MBCG8218JfZux3TlZkyXUvKJVFQvJ8mnhkhM=;
	b=XGvwjXfFzKIPTi6p5SZxIUXyTYbnkrJyGvzKnI4lkUCYKE4fkdNWR3HgLalh2/labApSEm
	kGhs389EMuWf8xKyNxtSfdesy2aNKKrfMixpQWMDRqDr/ui/jSDeB71pC9BzzSHC5XUtfb
	nJd89FIcLCsozHa4MM5ZckgSX1XuntE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-ofYFlhFiMTKirA2obOBxYQ-1; Wed, 26 Feb 2025 08:23:05 -0500
X-MC-Unique: ofYFlhFiMTKirA2obOBxYQ-1
X-Mimecast-MFC-AGG-ID: ofYFlhFiMTKirA2obOBxYQ_1740576184
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43995bff469so52006995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740576184; x=1741180984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BAb0fo+MBCG8218JfZux3TlZkyXUvKJVFQvJ8mnhkhM=;
        b=kzNwwie4y7Aw0N5O+ecv729ZYOXGpnTTBusp7HaVMmWnUHmJ73hbffnwmlIjbLs3ko
         V2BOyrsXEXxYYnYa2tfZCbWbyVNZ7kmczBva1qPgx30Wgevq0ZjqHo36ndXK3fq9V+Kr
         VzAID2VSawKRSxwD1uO/KJMQe8hpjzlWKE4ejDGg9qtZ1X8PYjxZqUPM+c7AZua0JBus
         Fo5ohkHykDDifjnMvSGX2wm3sMHDNaZGS+tSMJoXytsCYIn0ferydEi9GX5em3A5xR5a
         Co/F+yddvQ+V9FJaT08jKd73tOXQcxP9ZDkDyeFF4aIn8On8F+fSnDCwSxNOKO7arUrG
         Hx3w==
X-Gm-Message-State: AOJu0YzhLozib9aGEO6AgzNDsvHo68/eB/iTSd9WxDr5pF6C4PU8kvjq
	e9haaRE5IpxTftU+d5Tw8XDS6Ode5eyF2gEvlVTf0nJVmPO38wV1bt61LDZkvR9VAAAinau6oS2
	SvQ4oYG8SrMLTkEbcKKXn206WvKyKvn/OflC+ST0jkHjObyrW4YD3N5+EyAVa5W9v8PrXl4A/kE
	a95CPRYZ3PjMk38aeS5PDdJO5OAo7KgRVoJItHNg5alqr+
X-Gm-Gg: ASbGncufZAfuiKIHc39ZmuCEQqPDhUe0Pvi0eQvEFxVp0gEVWxYXPtNKI4wJg09X471
	r3tO2jNBVteuJJrc8jBye4BbArXo6W9nGHkMl6jsld3UJZtK+CNyzjH8xLb9l9kiR9K1OgkpaZ4
	g0K/pg7/m3Q37q6nnBoXyiVwIW++7OquXdTP+aemO1Vj5ozOdqzKSnK1sPbmkPJDitzaf0a6pw6
	7zZomYIzs0MRRaQL5uW92+DKwhfnEP96T0j9JiBgfKYTmi+sHmIGVoCX8B8QpeCldvbZt/+BXtY
	5k5+gJCdt7ADdSVEELcyXFbRFwdcBqRfWNahDlxLKP9oKUurLwMGHdq6nFBBisPudLhsn3f8aOl
	w
X-Received: by 2002:a05:600c:4592:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-439aebe4a26mr212630805e9.30.1740576184323;
        Wed, 26 Feb 2025 05:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoD5SxjMPjT8fOACKzMgPJ46QVfUBCrCDwzS4nahkgUmdQJJ3IdcsNuACc+12Ckl886xGDnw==
X-Received: by 2002:a05:600c:4592:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-439aebe4a26mr212630455e9.30.1740576183915;
        Wed, 26 Feb 2025 05:23:03 -0800 (PST)
Received: from localhost (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba549eb9sm21310625e9.37.2025.02.26.05.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 05:23:03 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 3/5] mm/memory: pass folio and pte to restore_exclusive_pte()
Date: Wed, 26 Feb 2025 14:22:55 +0100
Message-ID: <20250226132257.2826043-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226132257.2826043-1-david@redhat.com>
References: <20250226132257.2826043-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's pass the folio and the pte to restore_exclusive_pte(), so we
can avoid repeated page_folio() and ptep_get(). To do that,
pass the pte to try_restore_exclusive_pte() and use a folio in there
already.

While at it, just avoid the "swp_entry_t entry" variable in
try_restore_exclusive_pte() and add a folio-locked check to
restore_exclusive_pte().

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 507045fa719cc..2a0b4dd858769 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -719,14 +719,13 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 #endif
 
 static void restore_exclusive_pte(struct vm_area_struct *vma,
-				  struct page *page, unsigned long address,
-				  pte_t *ptep)
+		struct folio *folio, struct page *page, unsigned long address,
+		pte_t *ptep, pte_t orig_pte)
 {
-	struct folio *folio = page_folio(page);
-	pte_t orig_pte;
 	pte_t pte;
 
-	orig_pte = ptep_get(ptep);
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+
 	pte = pte_mkold(mk_pte(page, READ_ONCE(vma->vm_page_prot)));
 	if (pte_swp_soft_dirty(orig_pte))
 		pte = pte_mksoft_dirty(pte);
@@ -753,16 +752,15 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
  * Tries to restore an exclusive pte if the page lock can be acquired without
  * sleeping.
  */
-static int
-try_restore_exclusive_pte(pte_t *src_pte, struct vm_area_struct *vma,
-			unsigned long addr)
+static int try_restore_exclusive_pte(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *ptep, pte_t orig_pte)
 {
-	swp_entry_t entry = pte_to_swp_entry(ptep_get(src_pte));
-	struct page *page = pfn_swap_entry_to_page(entry);
+	struct page *page = pfn_swap_entry_to_page(pte_to_swp_entry(orig_pte));
+	struct folio *folio = page_folio(page);
 
-	if (trylock_page(page)) {
-		restore_exclusive_pte(vma, page, addr, src_pte);
-		unlock_page(page);
+	if (folio_trylock(folio)) {
+		restore_exclusive_pte(vma, folio, page, addr, ptep, orig_pte);
+		folio_unlock(folio);
 		return 0;
 	}
 
@@ -868,7 +866,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * (ie. COW) mappings.
 		 */
 		VM_BUG_ON(!is_cow_mapping(src_vma->vm_flags));
-		if (try_restore_exclusive_pte(src_pte, src_vma, addr))
+		if (try_restore_exclusive_pte(src_vma, addr, src_pte, orig_pte))
 			return -EBUSY;
 		return -ENOENT;
 	} else if (is_pte_marker_entry(entry)) {
@@ -4030,7 +4028,8 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 				&vmf->ptl);
 	if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
-		restore_exclusive_pte(vma, vmf->page, vmf->address, vmf->pte);
+		restore_exclusive_pte(vma, folio, vmf->page, vmf->address,
+				      vmf->pte, vmf->orig_pte);
 
 	if (vmf->pte)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.48.1


