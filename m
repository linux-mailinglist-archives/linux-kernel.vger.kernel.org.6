Return-Path: <linux-kernel+bounces-284717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E94950465
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62143288265
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE219B586;
	Tue, 13 Aug 2024 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLJ86kFt"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912E199EB4;
	Tue, 13 Aug 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550633; cv=none; b=TiFpMBNiQLmKxTdV+nGEJ93Y0kZ+/M6QmGCZrsIlVNNFVIxboGm69wxM+Qp/chjOvusquvUPe9b2TT+DIIRRT/480tCLLIMrb9Uhtmjz11BJY4gzvVrIZSMgJ2jqQrhQHKHCRD/bztpsHPSuVn5Q2n7DtcJY4AOwGPeJWSmlK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550633; c=relaxed/simple;
	bh=wuwopemU10Mqsny+RRhShmjAob6TMoVAPVpJZJOv+bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sED1tTny39uEtQhYscHR5g5Xpz4E62sE58LjsVgcAB4S9Zxlkvxn3v06gVrmsy9qUygOY3LaZV+JOClGXH1Kfnat2aw164NWys3iDeBx3Sskbi6usg7yP1WbtiahT7BIXEgDGKijDdfm2c2Yyl1DwjBUGM4TvsH4+zHun2o7Cs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLJ86kFt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a3375015f8so376800985a.1;
        Tue, 13 Aug 2024 05:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550629; x=1724155429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3e8jqaD9j4AlkmfSijGsYDb40oSO+aTFas99401M0M=;
        b=CLJ86kFtCnsNq9nYhB1jETDlV8JXv3oSrzwACANFPbTke086D0aKyWMaG95qoB+S0w
         p2Fq703vl9iVTKwQiUFYIoLyfy7uZaxZsmDBfoATKoFwn0SREaYgOlhF/p3phsnnQpPU
         snDfNQjVuPdP9aUX/lXOIuPNoGT/VBBqp2tFKzKnpZ836NxGk3VPA1gmhzUHEgwK8sk4
         2hR2RyC2PkOgbVrVxxmO6eqCRk25P4LVLGy+QZszIu3LODGQy7+MVAXua/rLkkcYUDSl
         cNUF58DM2rjaLg7kiEcDM9OcKuubXDzGXqGO/J+5vjl+2A5Vh40AUEqqmG1hAarmv7El
         +FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550629; x=1724155429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3e8jqaD9j4AlkmfSijGsYDb40oSO+aTFas99401M0M=;
        b=t9GA+tTvg6XJgnVSeSFM65ZO874oA6Xv7clcTI44u6P7lpmcYYKVLAlMsN9kULe1hr
         Xolr3OLlYMrtZqD+R4gVWHQ8swaNrHEtL27AjkDuMz47P8skXG7PZ9E5NbkHgsZQ8sQ1
         9kE8u4k/awt6UWKZL0oQfzzYTLb3fCEJowmju8k5G7BHomhdQ7OJwAPd159lcfzOLHjR
         Me6/+6hfa8lJDO08ZG+UYmAlJDwaPgopemrV7BYJxK0gYXtCiEGSBnbJ94VdDnyclWzw
         ZVN4v+A2xn48U1iynQVRmTqR1OgYEaREnxhJVrBboPsUkw/MDyV+4WcLRE1oXKBKBInM
         UcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSNg42kMxrc8O08dicJzQpoI08X0jgdEpopPqYFzRRe5LISwWGGyQ5CRWv713stG+C3OzQS3K4TKZjMn76RxbvJnVlTcu3JOYVjd6pZGYZbZ448Tkdhrqog584frEkHyP3G+Ouk83g
X-Gm-Message-State: AOJu0YyzfC9oDCQkKzYl3vR9hSET2LgD3s3SOWV/vjVGp/5ivNcDZ03x
	rKtHUToiDd+wNfleY9+YSq9cnANgM5Dep8TVlWOknT7EltvOLr5V
X-Google-Smtp-Source: AGHT+IEFfd2FYRK2Jx6dZup0/ifNGdrGzF8HSf/AxkPfSro8RvwQqrR7qIuXRhOvG6+PgXGqlDdltw==
X-Received: by 2002:a05:620a:2441:b0:79f:b72:fb30 with SMTP id af79cd13be357-7a4e1667d8amr395537185a.59.1723550629311;
        Tue, 13 Aug 2024 05:03:49 -0700 (PDT)
Received: from localhost (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7e040e0sm333193985a.101.2024.08.13.05.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:48 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 5/6] mm: split underutilized THPs
Date: Tue, 13 Aug 2024 13:02:48 +0100
Message-ID: <20240813120328.1275952-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an attempt to mitigate the issue of running out of memory when
THP is always enabled. During runtime whenever a THP is being faulted in
(__do_huge_pmd_anonymous_page) or collapsed by khugepaged
(collapse_huge_page), the THP is added to  _deferred_list. Whenever
memory reclaim happens in linux, the kernel runs the deferred_split
shrinker which goes through the _deferred_list.

If the folio was partially mapped, the shrinker attempts to split it.
If the folio is not partially mapped, the shrinker checks if the THP
was underutilized, i.e. how many of the base 4K pages of the entire THP
were zero-filled. If this number goes above a certain threshold (decided by
/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none), the
shrinker will attempt to split that THP. Then at remap time, the pages
that were zero-filled are mapped to the shared zeropage, hence saving
memory.

Suggested-by: Rik van Riel <riel@surriel.com>
Co-authored-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  6 ++
 include/linux/khugepaged.h                 |  1 +
 include/linux/vm_event_item.h              |  1 +
 mm/huge_memory.c                           | 76 ++++++++++++++++++++--
 mm/khugepaged.c                            |  3 +-
 mm/vmstat.c                                |  1 +
 6 files changed, 80 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..60522f49178b 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -447,6 +447,12 @@ thp_deferred_split_page
 	splitting it would free up some memory. Pages on split queue are
 	going to be split under memory pressure.
 
+thp_underutilized_split_page
+	is incremented when a huge page on the split queue was split
+	because it was underutilized. A THP is underutilized if the
+	number of zero pages in the THP is above a certain threshold
+	(/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none).
+
 thp_split_pmd
 	is incremented every time a PMD split into table of PTEs.
 	This can happen, for instance, when application calls mprotect() or
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index f68865e19b0b..30baae91b225 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
 
+extern unsigned int khugepaged_max_ptes_none __read_mostly;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
 
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index aae5c7c5cfb4..bf1470a7a737 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -105,6 +105,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SPLIT_PAGE,
 		THP_SPLIT_PAGE_FAILED,
 		THP_DEFERRED_SPLIT_PAGE,
+		THP_UNDERUTILIZED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
 		THP_SCAN_EXCEED_NONE_PTE,
 		THP_SCAN_EXCEED_SWAP_PTE,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c024ab0f745c..6b32b2d4ab1e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1087,6 +1087,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(vma->vm_mm);
+		deferred_split_folio(folio, false);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
 		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
@@ -3522,6 +3523,39 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
+static bool thp_underutilized(struct folio *folio)
+{
+	int num_zero_pages = 0, num_filled_pages = 0;
+	void *kaddr;
+	int i;
+
+	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
+		return false;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		kaddr = kmap_local_folio(folio, i * PAGE_SIZE);
+		if (!memchr_inv(kaddr, 0, PAGE_SIZE)) {
+			num_zero_pages++;
+			if (num_zero_pages > khugepaged_max_ptes_none) {
+				kunmap_local(kaddr);
+				return true;
+			}
+		} else {
+			/*
+			 * Another path for early exit once the number
+			 * of non-zero filled pages exceeds threshold.
+			 */
+			num_filled_pages++;
+			if (num_filled_pages >= HPAGE_PMD_NR - khugepaged_max_ptes_none) {
+				kunmap_local(kaddr);
+				return false;
+			}
+		}
+		kunmap_local(kaddr);
+	}
+	return false;
+}
+
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 		struct shrink_control *sc)
 {
@@ -3555,17 +3589,45 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+		bool did_split = false;
+		bool underutilized = false;
+
+		if (folio_test_partially_mapped(folio))
+			goto split;
+		underutilized = thp_underutilized(folio);
+		if (underutilized)
+			goto split;
+		continue;
+split:
 		if (!folio_trylock(folio))
-			goto next;
-		/* split_huge_page() removes page from list on success */
-		if (!split_folio(folio))
-			split++;
+			continue;
+		did_split = !split_folio(folio);
 		folio_unlock(folio);
-next:
-		folio_put(folio);
+		if (did_split) {
+			/* Splitting removed folio from the list, drop reference here */
+			folio_put(folio);
+			if (underutilized)
+				count_vm_event(THP_UNDERUTILIZED_SPLIT_PAGE);
+			split++;
+		}
 	}
+
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	list_splice_tail(&list, &ds_queue->split_queue);
+	/*
+	 * Only add back to the queue if folio is partially mapped.
+	 * If thp_underutilized returns false, or if split_folio fails in
+	 * the case it was underutilized, then consider it used and don't
+	 * add it back to split_queue.
+	 */
+	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+		if (folio_test_partially_mapped(folio))
+			list_move(&folio->_deferred_list, &ds_queue->split_queue);
+		else {
+			list_del_init(&folio->_deferred_list);
+			ds_queue->split_queue_len--;
+		}
+		folio_put(folio);
+	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index cdd1d8655a76..02e1463e1a79 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -85,7 +85,7 @@ static DECLARE_WAIT_QUEUE_HEAD(khugepaged_wait);
  *
  * Note that these are only respected if collapse was initiated by khugepaged.
  */
-static unsigned int khugepaged_max_ptes_none __read_mostly;
+unsigned int khugepaged_max_ptes_none __read_mostly;
 static unsigned int khugepaged_max_ptes_swap __read_mostly;
 static unsigned int khugepaged_max_ptes_shared __read_mostly;
 
@@ -1235,6 +1235,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
+	deferred_split_folio(folio, false);
 	spin_unlock(pmd_ptl);
 
 	folio = NULL;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index c3a402ea91f0..91cd7d4d482b 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1384,6 +1384,7 @@ const char * const vmstat_text[] = {
 	"thp_split_page",
 	"thp_split_page_failed",
 	"thp_deferred_split_page",
+	"thp_underutilized_split_page",
 	"thp_split_pmd",
 	"thp_scan_exceed_none_pte",
 	"thp_scan_exceed_swap_pte",
-- 
2.43.5


