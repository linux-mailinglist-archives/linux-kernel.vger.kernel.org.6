Return-Path: <linux-kernel+bounces-542252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9E4A4C79D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A721884B00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C581621C19C;
	Mon,  3 Mar 2025 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjfVU4a9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C52475C2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019447; cv=none; b=BY35ll26xn4ZqthkUfoNwWnPhduInqqcUFWUjyrV8574k4/HDcQOIi0lJJ9PM1ZE+MEpNc1C2aWVatjqJhcwYQ6crZvaFaq4mV7/Ze0mGVcUcjD+w72N9cBTItslO/b+pbLN5/h2kQyynXCzRwPmwo6/LyLl8oFbMPPC/EQRA7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019447; c=relaxed/simple;
	bh=d9bRuBXmVv0p2a7zWAANlT4EIsScBcQtDcfcUcIlMKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NF9DmT+UnQMbC0Nd+WXIx8LqlJjv6vnLh0zaGJVXmVOXqVzKn1NdRjAOPy7L1c6yHjY3Y67O78gEnio3nBRGG2WGIiLBKqV5f/O/wAf1ffvx7Pk1iCjM+B8RpE4IDjQFSq1yZmwSdcggOLrdhVNmf6H1eTK0+KGqioBm3gcCfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjfVU4a9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6obLj5/+7cSJHkmjj4/LIEhJkcwhtMxgxzLmveILbME=;
	b=gjfVU4a9g7SEb0NNUrJBdFraOhexJm/spWZuhy46PCJE8iR4F6/mxhIl1set2ObNkRLlxW
	VhNrGpSKXgE0lPRA/ide1ulgzGxyCUGeijxU26In/cMYXdPp2EhFZpGaH92NVz9DphEmlX
	I40YIGvK3f5Fo1VbdV+NrGX8EHuPHHI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Cjcqov2VMxSiuTxszc6frA-1; Mon, 03 Mar 2025 11:30:33 -0500
X-MC-Unique: Cjcqov2VMxSiuTxszc6frA-1
X-Mimecast-MFC-AGG-ID: Cjcqov2VMxSiuTxszc6frA_1741019433
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39104223bb5so609673f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019433; x=1741624233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6obLj5/+7cSJHkmjj4/LIEhJkcwhtMxgxzLmveILbME=;
        b=S3z4owNDS5LGP9ROce6HRAhiLZxJRaa7KUPqOOx+SMDjd47hewsAsNrnnqByp1mhIx
         bDh3XBl1KqInE+M1fUFjMV05eT1nXuDC8UIFhSLLteKexmSpGdAortOmxE2l83yScMD6
         /YkYsPb1yIOv0AnpuzdNYE9gYSktpMp2FR508hyYAzi4tb5O+UnfjHYNlk9VCzVfXcow
         y7rbVZrv70y0KCN4iQIDhgqXSjPa4ppGQByxlWCcmb4OjQeiTBAiD9mOeSxqOdUJ1mxs
         UhN1LcuAme3Mip4GGFxcWM1b1hFxcOtnDxD4P9YqYf+qjVDF5KIDw2ocEegsX9Xlrfvh
         5xYw==
X-Gm-Message-State: AOJu0YwH5ZFD4Sz46QZ3IZryF9NPnnEDJV+0mGB0qkZbwNT1n5YH+zX4
	FsSvvHuYJxI1Vt7z64sa23IMwk0eR6vM2joDfTdtYjMPGcdyCUvMvQ3pjZb5lc6VRtlG1k+RFHm
	MUt23JhCjtxAQS4D6cjSvgUEBdAy46kU5Iak/NbrjJMYhRX3xK2W2+Cp4fACWiz8sz0eO1sJ+aZ
	gV5Ting0LidMegbrCCIe6oTtOeGoCNac3zmOZirdxZ5REI
X-Gm-Gg: ASbGnctrX62iUNvxDF5mE+3J7MMlPC7nDZfMeVyDYQkHJ08ID+zGea9pW2F7ug0p/Gl
	MZu144HEV16fiiq3QKJmfrN8VK4aooiZDfisId8vn2U9f3aLyjTX2k7Itrmc/xltfEHz2gBC+yq
	lFK/eCUzUq9aRvbI/+kbtM90LO0qucNZ2oF8jaPaurKsJHH97s/exIOekV/b28J+clliB+jjJ8z
	PA4pkY4tJv01Zhj7op8Tn6IpezmA0i/FOV7v67Z2H/FsJ1RIpEPT14gyEzFqfu5mzSkfkignQFg
	2a//3bVasONTvahiQWR93NUNhVkxhJmzt3qlCnPpRqHUCCto76T/Bz8FzxGYJONUaPaCvdEiyDW
	f
X-Received: by 2002:a05:6000:21c6:b0:390:fd23:c145 with SMTP id ffacd0b85a97d-390fd23c2c2mr4404044f8f.36.1741019432670;
        Mon, 03 Mar 2025 08:30:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8V3sUJRCUTqrZLWnaeVZz5cWv6qO720rAawUL8eI33aPl04j18jrwhTf4sp/MF8gqzp2DbA==
X-Received: by 2002:a05:6000:21c6:b0:390:fd23:c145 with SMTP id ffacd0b85a97d-390fd23c2c2mr4403996f8f.36.1741019432210;
        Mon, 03 Mar 2025 08:30:32 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bbfece041sm38658125e9.1.2025.03.03.08.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:31 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 07/20] mm/rmap: pass dst_vma to folio_dup_file_rmap_pte() and friends
Date: Mon,  3 Mar 2025 17:30:00 +0100
Message-ID: <20250303163014.1128035-8-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need access to the destination MM when modifying the large mapcount
of a non-hugetlb large folios next. So pass in the destination VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 42 +++++++++++++++++++++++++-----------------
 mm/huge_memory.c     |  2 +-
 mm/memory.c          | 10 +++++-----
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 6abf7960077aa..e795610bade80 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -335,7 +335,8 @@ static inline void hugetlb_remove_rmap(struct folio *folio)
 }
 
 static __always_inline void __folio_dup_file_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum rmap_level level)
+		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
+		enum rmap_level level)
 {
 	const int orig_nr_pages = nr_pages;
 
@@ -366,45 +367,47 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
  * @folio:	The folio to duplicate the mappings of
  * @page:	The first page to duplicate the mappings of
  * @nr_pages:	The number of pages of which the mapping will be duplicated
+ * @dst_vma:	The destination vm area
  *
  * The page range of the folio is defined by [page, page + nr_pages)
  *
  * The caller needs to hold the page table lock.
  */
 static inline void folio_dup_file_rmap_ptes(struct folio *folio,
-		struct page *page, int nr_pages)
+		struct page *page, int nr_pages, struct vm_area_struct *dst_vma)
 {
-	__folio_dup_file_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE);
+	__folio_dup_file_rmap(folio, page, nr_pages, dst_vma, RMAP_LEVEL_PTE);
 }
 
 static __always_inline void folio_dup_file_rmap_pte(struct folio *folio,
-		struct page *page)
+		struct page *page, struct vm_area_struct *dst_vma)
 {
-	__folio_dup_file_rmap(folio, page, 1, RMAP_LEVEL_PTE);
+	__folio_dup_file_rmap(folio, page, 1, dst_vma, RMAP_LEVEL_PTE);
 }
 
 /**
  * folio_dup_file_rmap_pmd - duplicate a PMD mapping of a page range of a folio
  * @folio:	The folio to duplicate the mapping of
  * @page:	The first page to duplicate the mapping of
+ * @dst_vma:	The destination vm area
  *
  * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
  *
  * The caller needs to hold the page table lock.
  */
 static inline void folio_dup_file_rmap_pmd(struct folio *folio,
-		struct page *page)
+		struct page *page, struct vm_area_struct *dst_vma)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_LEVEL_PTE);
+	__folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, dst_vma, RMAP_LEVEL_PTE);
 #else
 	WARN_ON_ONCE(true);
 #endif
 }
 
 static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
-		struct page *page, int nr_pages, struct vm_area_struct *src_vma,
-		enum rmap_level level)
+		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma, enum rmap_level level)
 {
 	const int orig_nr_pages = nr_pages;
 	bool maybe_pinned;
@@ -470,6 +473,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
  * @folio:	The folio to duplicate the mappings of
  * @page:	The first page to duplicate the mappings of
  * @nr_pages:	The number of pages of which the mapping will be duplicated
+ * @dst_vma:	The destination vm area
  * @src_vma:	The vm area from which the mappings are duplicated
  *
  * The page range of the folio is defined by [page, page + nr_pages)
@@ -488,16 +492,18 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
  * Returns 0 if duplicating the mappings succeeded. Returns -EBUSY otherwise.
  */
 static inline int folio_try_dup_anon_rmap_ptes(struct folio *folio,
-		struct page *page, int nr_pages, struct vm_area_struct *src_vma)
+		struct page *page, int nr_pages, struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
-	return __folio_try_dup_anon_rmap(folio, page, nr_pages, src_vma,
-					 RMAP_LEVEL_PTE);
+	return __folio_try_dup_anon_rmap(folio, page, nr_pages, dst_vma,
+					 src_vma, RMAP_LEVEL_PTE);
 }
 
 static __always_inline int folio_try_dup_anon_rmap_pte(struct folio *folio,
-		struct page *page, struct vm_area_struct *src_vma)
+		struct page *page, struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
-	return __folio_try_dup_anon_rmap(folio, page, 1, src_vma,
+	return __folio_try_dup_anon_rmap(folio, page, 1, dst_vma, src_vma,
 					 RMAP_LEVEL_PTE);
 }
 
@@ -506,6 +512,7 @@ static __always_inline int folio_try_dup_anon_rmap_pte(struct folio *folio,
  *				 of a folio
  * @folio:	The folio to duplicate the mapping of
  * @page:	The first page to duplicate the mapping of
+ * @dst_vma:	The destination vm area
  * @src_vma:	The vm area from which the mapping is duplicated
  *
  * The page range of the folio is defined by [page, page + HPAGE_PMD_NR)
@@ -524,11 +531,12 @@ static __always_inline int folio_try_dup_anon_rmap_pte(struct folio *folio,
  * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
  */
 static inline int folio_try_dup_anon_rmap_pmd(struct folio *folio,
-		struct page *page, struct vm_area_struct *src_vma)
+		struct page *page, struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	return __folio_try_dup_anon_rmap(folio, page, HPAGE_PMD_NR, src_vma,
-					 RMAP_LEVEL_PMD);
+	return __folio_try_dup_anon_rmap(folio, page, HPAGE_PMD_NR, dst_vma,
+					 src_vma, RMAP_LEVEL_PMD);
 #else
 	WARN_ON_ONCE(true);
 	return -EBUSY;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 07d43ca6db1c6..8e8b07e8b12fe 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1782,7 +1782,7 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	src_folio = page_folio(src_page);
 
 	folio_get(src_folio);
-	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, src_vma))) {
+	if (unlikely(folio_try_dup_anon_rmap_pmd(src_folio, src_page, dst_vma, src_vma))) {
 		/* Page maybe pinned: split and retry the fault on PTEs. */
 		folio_put(src_folio);
 		pte_free(dst_mm, pgtable);
diff --git a/mm/memory.c b/mm/memory.c
index 1efc393e32b6d..73b783c7d7d51 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -866,7 +866,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		folio_get(folio);
 		rss[mm_counter(folio)]++;
 		/* Cannot fail as these pages cannot get pinned. */
-		folio_try_dup_anon_rmap_pte(folio, page, src_vma);
+		folio_try_dup_anon_rmap_pte(folio, page, dst_vma, src_vma);
 
 		/*
 		 * We do not preserve soft-dirty information, because so
@@ -1020,14 +1020,14 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		folio_ref_add(folio, nr);
 		if (folio_test_anon(folio)) {
 			if (unlikely(folio_try_dup_anon_rmap_ptes(folio, page,
-								  nr, src_vma))) {
+								  nr, dst_vma, src_vma))) {
 				folio_ref_sub(folio, nr);
 				return -EAGAIN;
 			}
 			rss[MM_ANONPAGES] += nr;
 			VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
 		} else {
-			folio_dup_file_rmap_ptes(folio, page, nr);
+			folio_dup_file_rmap_ptes(folio, page, nr, dst_vma);
 			rss[mm_counter_file(folio)] += nr;
 		}
 		if (any_writable)
@@ -1045,7 +1045,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		 * guarantee the pinned page won't be randomly replaced in the
 		 * future.
 		 */
-		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, src_vma))) {
+		if (unlikely(folio_try_dup_anon_rmap_pte(folio, page, dst_vma, src_vma))) {
 			/* Page may be pinned, we have to copy. */
 			folio_put(folio);
 			err = copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
@@ -1055,7 +1055,7 @@ copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma
 		rss[MM_ANONPAGES]++;
 		VM_WARN_ON_FOLIO(PageAnonExclusive(page), folio);
 	} else {
-		folio_dup_file_rmap_pte(folio, page);
+		folio_dup_file_rmap_pte(folio, page, dst_vma);
 		rss[mm_counter_file(folio)]++;
 	}
 
-- 
2.48.1


