Return-Path: <linux-kernel+bounces-431511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3BE9E3E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384BE16741B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9A20B817;
	Wed,  4 Dec 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QpfgU2ty"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4C1B87C4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326271; cv=none; b=CFKrsrUqCDYDoI5VBeakNFno2SrSLWhUKHC9J5RB9i0eAuG6fmzBcyAxKZg0RSS/IQOOPS+OxzNu4Ftjusj+tLbIL4YU/mi9QYOhMI3ZjSHpqxVdUYUMim/s2rye8leA7hEtn1CT0uA8y86XOv/6ers6sQNzctMVMWBHUkq5g0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326271; c=relaxed/simple;
	bh=FnedYdliMkbNvjlTKXUvEgoTb3hgJGdO2wOtZxecK28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0v1HX/0vjivc4FIDuttSXzbhMqT0lwPjMJcCMU+wDkNbFHjDKvVeFcfmJ7rwSi9M2RztqW61rixNp0WEA86CUjyFOc7+HsKF85Gu/iyMhxHLEURrnPe/2jKsFHmtCTdjwwtxmv+39skrgNKoK3ByjyMWJUxhTugswulbFZeWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QpfgU2ty; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733326268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l9fhs8oLh1QjbfUj0vlrM+TGXkkJdF2GwEtvfsxMfMY=;
	b=QpfgU2tyhl5hqyddIyJKgqqlVUWVbI9+zvHwRNAUfpmKaf/7eURvG491f3s/6LEbXOQYSE
	+CqL7bfrummARaXZYdCQzmoLjFt4/5mPLMH4+Kk+OLrPiqFhyZA6x9dk71phDzHhajuztz
	ZyZNv0/6rmgdMIFVh10Iv0gtClaPXRQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-j0eL1E2VOTy_n2NJgJIBxQ-1; Wed, 04 Dec 2024 10:31:05 -0500
X-MC-Unique: j0eL1E2VOTy_n2NJgJIBxQ-1
X-Mimecast-MFC-AGG-ID: j0eL1E2VOTy_n2NJgJIBxQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e1339790so3131841f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326264; x=1733931064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9fhs8oLh1QjbfUj0vlrM+TGXkkJdF2GwEtvfsxMfMY=;
        b=DBq4OHTN+Yv4enRR+rgI5a9/LFEuxFdJWKX2jpQMfQp34zGgQTCr3BxmjGrWRJOK87
         TH0LbezbrJC4Hphy1md6WSPabJRCn+a/ru4d9KTtQHnvx9rkvsOgf1BJ96ikBlrG96gx
         vZyB2RLk+HUfw2P31xloVG1O5vcjzsvasHmaZ6Wq4ZJzjg7KqdNFmrqCAyxMa8X66JpB
         MgANaVim6qV6cQLbZ8/pINS3UMoF0xfqZb25i4lhfWCpfNywd25P7fRHtpUB0HIBUoCk
         S+9dOThCE2o+0CpdwESkCZ0CvywXU67HjoOTpyzvxOMOwplkvjclAj0aPRV9aZR3QP9R
         07IQ==
X-Gm-Message-State: AOJu0Yx8vZKDJXNEHdz4Esu0pGBORCof/VSAkLUuaAIMXnHBHQMpi5Tf
	rM7dHI89GQmI5J9cpgG92lCe8yi+LWWrO2AeVQ102IlQj2bbuJ7nNPKmNH23V6gqcW+o0/1v1xv
	dJuuHG1yzh2wdMKAmeyYkiraGZguqXnNHXey4KQnsieM2baIuJsRtR8DKh676pMfrQ1F4riVN3A
	HTxAHr3UlUw5VhQCiAzDejNRTi5Eja3nHqZ3SB4hTzHHZD
X-Gm-Gg: ASbGncsGKXPjNEZUbEZiMMmeEFb+d5CNu8ZviaeXZv7nQgBKR+DA+KFE8VhZQq4ASUD
	IiS56ufmG49QyX57+uXUYiwbdGqKu2pj8jCP3LHRueKo2s02b+qs+wMRYUKSVfNejdffJ4dWTz5
	paXWloFxucJnppay4jx7aD5stir1DtpXWosr5aMEqt3LK+Lx4SIzJHyGDmLQzPgk/fxkfi6HUIl
	7eq0SZHl60Fq1vhsK/gKFCdZ5FBtBM7O4MG7ZaSxp3OrRSqeiaEVISutfKwsx+zWt5EiFYuUzsa
	l29pRTqKHqdjSZqxjRR7YWhFi2bAwJeSs/Y=
X-Received: by 2002:a05:6000:1845:b0:385:fb8d:865b with SMTP id ffacd0b85a97d-385fd43b822mr6278190f8f.48.1733326264438;
        Wed, 04 Dec 2024 07:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFK3GfFKAdadjhJ8yUNAOcQLour5Trqk91M2KqVctSQG28t/yBAlyfLEoVLJ5g8CHGaYcEHVA==
X-Received: by 2002:a05:6000:1845:b0:385:fb8d:865b with SMTP id ffacd0b85a97d-385fd43b822mr6278120f8f.48.1733326263725;
        Wed, 04 Dec 2024 07:31:03 -0800 (PST)
Received: from localhost (p200300cbc70be10038d68aa111b0a20a.dip0.t-ipconnect.de. [2003:cb:c70b:e100:38d6:8aa1:11b0:a20a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-385dc169d79sm16684772f8f.92.2024.12.04.07.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 07:31:02 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>,
	Guillaume Morin <guillaume@morinfr.org>
Subject: [PATCH v1] mm/hugetlb: don't map folios writable without VM_WRITE when copying during fork()
Date: Wed,  4 Dec 2024 16:31:00 +0100
Message-ID: <20241204153100.1967364-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we have to trigger a hugetlb folio copy during fork() because the anon
folio might be pinned, we currently unconditionally create a writable
PTE.

However, the VMA might not have write permissions (VM_WRITE) at that
point.

Fix it by checking the VMA for VM_WRITE. Make the code less error prone
by moving checking for VM_WRITE into make_huge_pte(), and letting
callers only specify whether we should try making it writable.

A simple reproducer that longter-pins the folios using liburing to then
mprotect(PROT_READ) the folios befor fork() [1] results in:

Before:
[FAIL] access should not have worked

After:
[PASS] access did not work as expected

[1] https://gitlab.com/davidhildenbrand/scratchspace/-/raw/main/reproducers/hugetlb-mkwrite-fork.c

This is rather a corner case, so stable might not be warranted.

Fixes: 4eae4efa2c29 ("hugetlb: do early cow when page pinned on src mm")
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Guillaume Morin <guillaume@morinfr.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5c8de0f5c760..6db4e8176303 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5141,12 +5141,12 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 };
 
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
-				int writable)
+		bool try_mkwrite)
 {
 	pte_t entry;
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-	if (writable) {
+	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
 					 vma->vm_page_prot)));
 	} else {
@@ -5199,7 +5199,7 @@ static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
 {
-	pte_t newpte = make_huge_pte(vma, &new_folio->page, 1);
+	pte_t newpte = make_huge_pte(vma, &new_folio->page, true);
 
 	__folio_mark_uptodate(new_folio);
 	hugetlb_add_new_anon_rmap(new_folio, vma, addr);
@@ -6223,8 +6223,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 		hugetlb_add_new_anon_rmap(folio, vma, vmf->address);
 	else
 		hugetlb_add_file_rmap(folio);
-	new_pte = make_huge_pte(vma, &folio->page, ((vma->vm_flags & VM_WRITE)
-				&& (vma->vm_flags & VM_SHARED)));
+	new_pte = make_huge_pte(vma, &folio->page, vma->vm_flags & VM_SHARED);
 	/*
 	 * If this pte was previously wr-protected, keep it wr-protected even
 	 * if populated.
@@ -6556,7 +6555,6 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	spinlock_t *ptl;
 	int ret = -ENOMEM;
 	struct folio *folio;
-	int writable;
 	bool folio_in_pagecache = false;
 
 	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
@@ -6710,12 +6708,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	 * For either: (1) CONTINUE on a non-shared VMA, or (2) UFFDIO_COPY
 	 * with wp flag set, don't set pte write bit.
 	 */
-	if (wp_enabled || (is_continue && !vm_shared))
-		writable = 0;
-	else
-		writable = dst_vma->vm_flags & VM_WRITE;
-
-	_dst_pte = make_huge_pte(dst_vma, &folio->page, writable);
+	_dst_pte = make_huge_pte(dst_vma, &folio->page,
+				 !wp_enabled && !(is_continue && !vm_shared));
 	/*
 	 * Always mark UFFDIO_COPY page dirty; note that this may not be
 	 * extremely important for hugetlbfs for now since swapping is not
-- 
2.47.1


