Return-Path: <linux-kernel+bounces-542261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B4EA4C7AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 17:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BFF16B748
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 16:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5422528E0;
	Mon,  3 Mar 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwOnyGqG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548DC2512C8
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019459; cv=none; b=f4pL4Cd26dLVErf2niT4VaTmUzd3BHg2R/+Izbp57CiA8APcE/PFeM8EHJ8WEnAG3rtkmBND9MeVn0e0r/VIQIsbnVLRW8SrenW3Z75qTh0JJJOKTXxBoDGQwJwQZrTWdLK1PV2LMYpU1c3XcGvdyage4CRXqs2DVJdukDk6LlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019459; c=relaxed/simple;
	bh=RlWl3fpiF9O9sdm/iMb9TRR2Zh30yDuqbmqk7QeHHkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZacg2RXerq4vwbouvquu6vd255pFLiGrhtxiXsWrrTLB2672WvM7gwR4kDpdkoIqBmCvfzb6BVt1e8ThV3cG+9NgIwrMuthBbavvjS8kWHHwOlMMmq9BuEcQ2W0skpY3VFT+mhXvrBNLoEpiF1aIajWRQN6bK0w98wz5OX4yHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwOnyGqG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqnqolcXMjdbgOoHxDkquZtgq0jreZJuwmbRkc4obqU=;
	b=MwOnyGqGuxXsCA22FD5B14+EtjOIxiFA5IX7ln1YQZ8aE4bco6hCNYqfyEM2Ur9Un5Wc/v
	tkotJRCVFRfrVndtB7cXywlTrYf+A6ukbvxPhssB8MOJb7N36/c1vIgWtsMOzDfLz0wnIh
	aT7eGb+4dnf39wYR+AWNuAQ8gca/r78=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-DBLIWoh1Ny2dzss-yhHoZA-1; Mon, 03 Mar 2025 11:30:45 -0500
X-MC-Unique: DBLIWoh1Ny2dzss-yhHoZA-1
X-Mimecast-MFC-AGG-ID: DBLIWoh1Ny2dzss-yhHoZA_1741019444
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390e271517fso2720805f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 08:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019444; x=1741624244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqnqolcXMjdbgOoHxDkquZtgq0jreZJuwmbRkc4obqU=;
        b=IWPaOEWF1jkafTpllMXNTujXcGPfk3Cg3rRi0hmNVhWl/9Kmw1dOQM0/uftc9OTuWA
         c/XmwTtWbiTVXVm3XCUhE0KmjEYBiKkHIkbn9DJmZWWT+W8U+uvsx9PtzLgMTqGhJki8
         m9RWthKME3ZAR6pxUi8b4YB1hTorUisGSJ0pBFQfJk1moFgIHb/CM6atLqav/7MuUwfC
         78RsoWIlaC4KWfd/6XBrhtBVnEQI7RCwrzbm3h2gcCiS4depGW605rI41nXSzHGOK3as
         N69vN3yWKVSscwZ+biEfjr4MOker8Opf7Vr/ow9Kc0qsCz6hnvQJ6QVHxp2kwCbXJZ3v
         TjDQ==
X-Gm-Message-State: AOJu0Yyee29P8d8ZyKAwTqBPHzxky/N+umO96GWiocPgbSix6E9kRumo
	mbK2gdG0QqQo376dOKcaXerE1yz7MEh2yKWj6w4EvLGphBuXvLqmThrx6PmF+eA51bdRP2tEWMA
	wEnwwuAR/MASXVxlH0KmJB82dH56/KAZTpQqtyedVDkhuCnyS0x/p0IePnjbGVr7AZkTboA1LKq
	dwLCOv1iVXvcWlQ0HZRL+YvprlLPip7smGxDXaV91kxOSJ
X-Gm-Gg: ASbGncsZg92lYyBICcsUcB1nGiQXCVVr0tBdYqNPRHY8bGZ4WL6b3X6jx6kRZ/1H/UW
	bvYr6Gu/2nNEwCiVoaPCirvHbhMwRAkHKyhvzkM1bg+UGDF2wMsTpTFIZLIziKwQBvllmYFkjmw
	KLuhAGlBCTh+SFcljZyHZ+WNiNtDlokn6E4hSIlqNmwFgNQU+E4FU0+S6ml/fA0AhrNc1oKk15L
	Y/oJOGEaLjLvY+e2YjGQPhsDh8O5HZRDK/FxNwVjfWNHaS9gzsOQfimQDowBuNHj8Q0Gnpa6QMD
	JoJeSH7UhtAp7avkj8RqBPHgsSXy2sIfYnj7uRIbHakx7h95OWDrDHHAUJnE49SlEb8CeAqjzsC
	E
X-Received: by 2002:a05:6000:1fa3:b0:390:f400:2083 with SMTP id ffacd0b85a97d-390f400227cmr11383338f8f.0.1741019443776;
        Mon, 03 Mar 2025 08:30:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnhjPORrAR9y+RvgL1OaYsuXRTyHneFQKcSCvW+9sKqMuJZykkJsayBSNel9nRS5Z27sSgaA==
X-Received: by 2002:a05:6000:1fa3:b0:390:f400:2083 with SMTP id ffacd0b85a97d-390f400227cmr11383264f8f.0.1741019443130;
        Mon, 03 Mar 2025 08:30:43 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc032d049sm46650855e9.5.2025.03.03.08.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:42 -0800 (PST)
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
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v3 11/20] mm/rmap: use folio_large_nr_pages() in add/remove functions
Date: Mon,  3 Mar 2025 17:30:04 +0100
Message-ID: <20250303163014.1128035-12-david@redhat.com>
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

Let's just use the "large" variant in code where we are sure that we
have a large folio in our hands: this way we are sure that we don't
perform any unnecessary "large" checks.

While at it, convert the VM_BUG_ON_VMA to a VM_WARN_ON_ONCE.

Maybe in the future there will not be a difference in that regard
between large and small folios; in that case, unifying the handling again
will be easy. E.g., folio_large_nr_pages() will simply translate to
folio_nr_pages() until we replace all instances.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 08846b7eced60..c9922928616ee 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1274,7 +1274,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
-				nr_pages = folio_nr_pages(folio);
+				nr_pages = folio_large_nr_pages(folio);
 				/*
 				 * We only track PMD mappings of PMD-sized
 				 * folios separately.
@@ -1522,14 +1522,11 @@ void folio_add_anon_rmap_pmd(struct folio *folio, struct page *page,
 void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags)
 {
-	const int nr = folio_nr_pages(folio);
 	const bool exclusive = flags & RMAP_EXCLUSIVE;
-	int nr_pmdmapped = 0;
+	int nr = 1, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_WARN_ON_FOLIO(!exclusive && !folio_test_locked(folio), folio);
-	VM_BUG_ON_VMA(address < vma->vm_start ||
-			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
 
 	/*
 	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
@@ -1547,6 +1544,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	} else if (!folio_test_pmd_mappable(folio)) {
 		int i;
 
+		nr = folio_large_nr_pages(folio);
 		for (i = 0; i < nr; i++) {
 			struct page *page = folio_page(folio, i);
 
@@ -1559,6 +1557,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
+		nr = folio_large_nr_pages(folio);
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		folio_set_large_mapcount(folio, 1, vma);
@@ -1568,6 +1567,9 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		nr_pmdmapped = nr;
 	}
 
+	VM_WARN_ON_ONCE(address < vma->vm_start ||
+			address + (nr << PAGE_SHIFT) > vma->vm_end);
+
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 	mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 }
@@ -1681,7 +1683,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED)) {
-				nr_pages = folio_nr_pages(folio);
+				nr_pages = folio_large_nr_pages(folio);
 				if (level == RMAP_LEVEL_PMD)
 					nr_pmdmapped = nr_pages;
 				nr = nr_pages - (nr & FOLIO_PAGES_MAPPED);
-- 
2.48.1


