Return-Path: <linux-kernel+bounces-170431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E938BD6B8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211851C20BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E069C15B986;
	Mon,  6 May 2024 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTJax4pX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0015B553
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715030018; cv=none; b=I3W3lE8UTy15yms/LYUPQf5E+x9Grk63+c7Ead/KG4dv/YLS5sWazdg9Il9+YNgXO4haRWqiz1q8aAwiWeNkRcq6VdbWtPxL0ogYlHiSEzPnOtsArImd3Yl2oXX68e0onNPI5gxmDsesEYgehOkfwraHbfxnFCtX7PkSZ9rxzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715030018; c=relaxed/simple;
	bh=YjO9QGn2bMB8DnS7KC+KrRVB0eEc+IL78RT5Z8y4rnM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y4hr6GCegnwBPM7Mk44yPWIAdZY/HxVzCi7Iqar1HD891UU5AmCPl7ENf2SDpCMlc13QnxgHDGQuon+bwyQKcPN3HysaLZY6xYSy3bUE6xDzvTdd4G7B8oU6CqX8BbViG8YJMorCCT4EEe5WOIcSp43b6hiDu8oATeOq6KEnRzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTJax4pX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-620308b3684so44537967b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715030015; x=1715634815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tkIOqZtuIQ65ixx+A75YRomt7I/eCCvdSDVc11nJkCU=;
        b=QTJax4pXXw11m9aKaGIqDyZIdOX1RPhQNgzkiBIH04hnkRH2Q7B3B/5jgd/wBXQwRN
         B7QfAlNniwm75eL6jhFzgcWrkqzUwOb89k7dtOY2YsVJBYV9FG0VbPwtkfFEw3CLNqQe
         OXvY943kBMVqZTYoR9NjGY81kUbq2De1j2iZK0AYjj6xYPnEuveloDUij+crvZf6Zr/x
         6ps+rYAK6Aqy7pPD3O1kc5hL8H2S3unoxpoQmHfsg6An4rBEJnT46DBfEMYM/SiAbmxT
         o5/OeRSWyxutj9xOa0hGqUpvi5zJNvo90ETNkTi0aybS6c9dFPy5iGazQBOivIzzQDBq
         4ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715030015; x=1715634815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkIOqZtuIQ65ixx+A75YRomt7I/eCCvdSDVc11nJkCU=;
        b=X4XXg4i+IaQ2k9SlP5TbFCTrUNnBZEeKObVa9wLgZ/rYbCfat1cGnkwS4I3YvHn23N
         1x94XC8Gbo5aSQ00kQ0jz0rwrsOF6Sk8P2c1ZrNHSJWvCtSwdwHicV1cCnI6u87eC4+W
         oBGXnDBtSLZeKud1BEOMZaT2fNLq/Lnjeciudvd1riBjHE0zFjlyLOWyD1XtjcZFTexw
         eRSTd3DXejVkQ/UHsZLOaOQcspjYakoFAAn2s4pfO7mJuZlaBuXnG+E+Rm0wUs+KyBPJ
         7FCrchnraee1tf3Yor4rbs3KvCiUTRg24PTAXdcZrGO2IIQPZ3YH51u2DKeAVjFKnx8b
         G0og==
X-Forwarded-Encrypted: i=1; AJvYcCU6RhVULVwC1+CIzNEMW+C/NqHK+fEpoqWB44Zr5EgxUypqYdzxmB0rYi1+IhPuuDVuSbMBLGQJPUMO0+uYyQIUzkxZsKq1eZc18Xvs
X-Gm-Message-State: AOJu0YxAjN1T5GM9SbO4u+6KYHp+/k5ZR2ZdIw7qFwywmQ8+1GBcwBp9
	543e+R15TSoFKECkvCDf2UQFItaHNHfRhNnwVgjfY5ZhrqyuNUobopmNamr8DjhxCVehb94msvM
	Ljzw6jitZGK+pOYqQyw==
X-Google-Smtp-Source: AGHT+IG3PlOMnRhDMcxmvDdUmj2IwCD67o3STYlCV7CNoOWegWDmZgsvLAbMnPMgBvJyBssMqEqIOArJ5gB+jDH6
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:11:b0:61b:ee2c:d5ab with SMTP
 id bc17-20020a05690c001100b0061bee2cd5abmr3146524ywb.1.1715030015496; Mon, 06
 May 2024 14:13:35 -0700 (PDT)
Date: Mon,  6 May 2024 21:13:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240506211333.346605-1-yosryahmed@google.com>
Subject: [PATCH mm-unstable] mm: rmap: abstract updating per-node and
 per-memcg stats
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

A lot of intricacies go into updating the stats when adding or removing
mappings: which stat index to use and which function. Abstract this away
into a new static helper in rmap.c, __folio_mod_stat().

This adds an unnecessary call to folio_test_anon() in
__folio_add_anon_rmap() and __folio_add_file_rmap(). However, the folio
struct should already be in the cache at this point, so it shouldn't
cause any noticeable overhead.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

This applies on top of "mm: do not update memcg stats for
NR_{FILE/SHMEM}_PMDMAPPED":
https://lore.kernel.org/lkml/20240506192924.271999-1-yosryahmed@google.com/

David, I was on the fence about adding a Suggested-by here. You did
suggest adding a helper, but the one with the extra folio_test_anon()
was my idea and I didn't want to blame it on you. So I'll leave this up
to you :)

---
 mm/rmap.c | 56 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ed7f820369864..9ed995da47099 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1269,6 +1269,28 @@ static void __page_check_anon_rmap(struct folio *folio, struct page *page,
 		       page);
 }
 
+static void __folio_mod_stat(struct folio *folio, int nr, int nr_pmdmapped)
+{
+	int idx;
+
+	if (nr) {
+		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
+		__lruvec_stat_mod_folio(folio, idx, nr);
+	}
+	if (nr_pmdmapped) {
+		if (folio_test_anon(folio)) {
+			idx = NR_ANON_THPS;
+			__lruvec_stat_mod_folio(folio, idx, nr_pmdmapped);
+		} else {
+			/* NR_*_PMDMAPPED are not maintained per-memcg */
+			idx = folio_test_swapbacked(folio) ?
+				NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED;
+			__mod_node_page_state(folio_pgdat(folio), idx,
+					      nr_pmdmapped);
+		}
+	}
+}
+
 static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		unsigned long address, rmap_t flags, enum rmap_level level)
@@ -1276,10 +1298,6 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 	int i, nr, nr_pmdmapped = 0;
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
-	if (nr_pmdmapped)
-		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr_pmdmapped);
-	if (nr)
-		__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
 
 	if (unlikely(!folio_test_anon(folio))) {
 		VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -1297,6 +1315,8 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 		__page_check_anon_rmap(folio, page, vma, address);
 	}
 
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
+
 	if (flags & RMAP_EXCLUSIVE) {
 		switch (level) {
 		case RMAP_LEVEL_PTE:
@@ -1393,6 +1413,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		unsigned long address)
 {
 	int nr = folio_nr_pages(folio);
+	int nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
@@ -1425,27 +1446,22 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		atomic_set(&folio->_large_mapcount, 0);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		SetPageAnonExclusive(&folio->page);
-		__lruvec_stat_mod_folio(folio, NR_ANON_THPS, nr);
+		nr_pmdmapped = nr;
 	}
 
-	__lruvec_stat_mod_folio(folio, NR_ANON_MAPPED, nr);
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
 }
 
 static __always_inline void __folio_add_file_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
 {
-	pg_data_t *pgdat = folio_pgdat(folio);
 	int nr, nr_pmdmapped = 0;
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
 	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
-	if (nr_pmdmapped)
-		__mod_node_page_state(pgdat, folio_test_swapbacked(folio) ?
-			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
-	if (nr)
-		__lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr);
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
 	if (!folio_test_large(folio))
@@ -1494,10 +1510,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		enum rmap_level level)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
-	pg_data_t *pgdat = folio_pgdat(folio);
 	int last, nr = 0, nr_pmdmapped = 0;
 	bool partially_mapped = false;
-	enum node_stat_item idx;
 
 	__folio_rmap_sanity_checks(folio, page, nr_pages, level);
 
@@ -1541,20 +1555,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	}
 
-	if (nr_pmdmapped) {
-		/* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg */
-		if (folio_test_anon(folio))
-			__lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_pmdmapped);
-		else
-			__mod_node_page_state(pgdat,
-					folio_test_swapbacked(folio) ?
-					NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED,
-					-nr_pmdmapped);
-	}
 	if (nr) {
-		idx = folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE_MAPPED;
-		__lruvec_stat_mod_folio(folio, idx, -nr);
-
 		/*
 		 * Queue anon large folio for deferred split if at least one
 		 * page of the folio is unmapped and at least one page
@@ -1566,6 +1567,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		    list_empty(&folio->_deferred_list))
 			deferred_split_folio(folio);
 	}
+	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/*
 	 * It would be tidy to reset folio_test_anon mapping when fully
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


