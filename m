Return-Path: <linux-kernel+bounces-308515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A9A965DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3265128954B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFD17D36A;
	Fri, 30 Aug 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHXbKTUy"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92117E000;
	Fri, 30 Aug 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012295; cv=none; b=lrg1OQvZjU8o9GrOtaw64TobuYOqDXYIcNzyec96YNxUndAuNdm4Ghl4oJcoNyOwbpLSq5Gz8ZrFQ4WRvHd34O4i7i4DTFvid/A59m1FGShevmyLDRc2t8nVRnW7r9lzOAOfu+peFDh6x7tN6ever1GPVq5Q2lthAmargZhmZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012295; c=relaxed/simple;
	bh=+Hrdoy36XqHCkKjq0CLngQMsQdp34ew3vkSdw5Kw+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKWMwzPu3eDeWVREhmHfUf9fsD63VfVhGZatC010oVuMfWq79z2pldUidlaQXvRSckK0cRSfM3Eqv/nl18k8DkfQ2ZSH0VvHd4KB51Jcnz/3hh0EueGGt4+Lu3EmIsRSy5xLLPwjeIGtJvJj9oL6QuiBHlVDq8E3bvLQ9g3q2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHXbKTUy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a8134aefe8so26184485a.2;
        Fri, 30 Aug 2024 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012289; x=1725617089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVfBrp+oNzgiShEzXHur6LLPz7aGRa6cdgG73sD1ODc=;
        b=LHXbKTUyutmOnY2QNke3+GZxzyZW+PaclRwQaY97NJNUGKkN7zXqWqpw+4MPBsuOHi
         m+ZyIOJ7w+tXW90ZwknlwqA4n1E20gbnQM+DMeSWNxQgdewYA0R4B3Nmbj4xDRNP1KJA
         JSfqFxSPhvrByM1x7OwfJqS4aTW8vTCbQcOAz18JrioQvw7yhe2B1V+uvKpt1tTt1lfq
         zGxbnUv9L8Gc7LMQ6fDqVsoT2YGTy6RiEfOgmCcqNuEGKs5gDL9rY1AFiLA2/JRnMkme
         JTagULEa+djRKGsKkbYpQYU8jkkDIJ7N8jqvLhLSYbBLPQw/BevyIcSqaTLbPLeNhkiI
         jH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012289; x=1725617089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVfBrp+oNzgiShEzXHur6LLPz7aGRa6cdgG73sD1ODc=;
        b=Il/U8eNWl8MDjLyluwjCFRKmvITpgz24bJPOknJg6MCFw++cf1TLNy2rR0nf+wYTkU
         zNAcv5Ut8Q/a4KVdiILlmoFC4lmjOeaeGSSELVj+ZwDSByOOIAvnY12DMjcglW+SNl02
         DCGMzzDul3qDQp2MSyFUNZz1vSOUYJkxKojaajIVX43XLiyv52Z0rXXcEb1zOJawT6xG
         iolCCFQzl+X/bscgvSSQjrryowurn9nYYfj9ZH+ReZHaIggHt0vw8135UXMxKU6gsm+e
         IqVZKcqNI/QxpUzJpUR7wtfXy+WA/zaxXth6Irt29XsIj0rzWm4CZFrygoJVbdylNpVk
         HRKg==
X-Forwarded-Encrypted: i=1; AJvYcCUH0RrrdRl4H+wzK2Vl1gdxh5k2ySmGMARuNUBDqO0iIdLwbImu5uALmeVrpUnR/Ce84jA2BVe2OuURN4C7@vger.kernel.org, AJvYcCVXrco4FB6rn7LUCmxTJqb8oNhJbbjUfkaInZCiREsOnpWii4A/jR9w25zYfM5xwdUvAPB6FozR+KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKyq3BtBBkdPvx7JNCK/jJE9wNyru2CnJkzCkfF714cq+wikC
	L1A52i0iweiRxvxaR7jBZ7JiFtEfT42cHAkJOJCH36++UhGn9w5H
X-Google-Smtp-Source: AGHT+IGdkW+88y1JPZ8HJseiLWBGoeU0Lq8Ru1U+26rkyCLiExAn2mKtW62AzHffSX6x/E3+lb5IPw==
X-Received: by 2002:a05:620a:319d:b0:79f:249:9f9f with SMTP id af79cd13be357-7a80427d35amr433621985a.62.1725012289265;
        Fri, 30 Aug 2024 03:04:49 -0700 (PDT)
Received: from localhost (fwdproxy-ash-113.fbsv.net. [2a03:2880:20ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4cd7csm130315085a.69.2024.08.30.03.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:48 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 5/6] mm: split underused THPs
Date: Fri, 30 Aug 2024 11:03:39 +0100
Message-ID: <20240830100438.3623486-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830100438.3623486-1-usamaarif642@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
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
was underused, i.e. how many of the base 4K pages of the entire THP
were zero-filled. If this number goes above a certain threshold (decided by
/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none), the
shrinker will attempt to split that THP. Then at remap time, the pages
that were zero-filled are mapped to the shared zeropage, hence saving
memory.

Suggested-by: Rik van Riel <riel@surriel.com>
Co-authored-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst |  6 +++
 include/linux/khugepaged.h                 |  1 +
 include/linux/vm_event_item.h              |  1 +
 mm/huge_memory.c                           | 60 +++++++++++++++++++++-
 mm/khugepaged.c                            |  3 +-
 mm/vmstat.c                                |  1 +
 6 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 56a086900651..aca0cff852b8 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -471,6 +471,12 @@ thp_deferred_split_page
 	splitting it would free up some memory. Pages on split queue are
 	going to be split under memory pressure.
 
+thp_underused_split_page
+	is incremented when a huge page on the split queue was split
+	because it was underused. A THP is underused if the number of
+	zero pages in the THP is above a certain threshold
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
index aae5c7c5cfb4..aed952d04132 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -105,6 +105,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		THP_SPLIT_PAGE,
 		THP_SPLIT_PAGE_FAILED,
 		THP_DEFERRED_SPLIT_PAGE,
+		THP_UNDERUSED_SPLIT_PAGE,
 		THP_SPLIT_PMD,
 		THP_SCAN_EXCEED_NONE_PTE,
 		THP_SCAN_EXCEED_SWAP_PTE,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 166f8810f3c6..a97aeffc55d6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1187,6 +1187,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(vma->vm_mm);
+		deferred_split_folio(folio, false);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
 		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
@@ -3652,6 +3653,39 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 	return READ_ONCE(ds_queue->split_queue_len);
 }
 
+static bool thp_underused(struct folio *folio)
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
@@ -3689,13 +3723,35 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+		bool did_split = false;
+		bool underused = false;
+
+		if (!folio_test_partially_mapped(folio)) {
+			underused = thp_underused(folio);
+			if (!underused)
+				goto next;
+		}
 		if (!folio_trylock(folio))
 			goto next;
-		/* split_huge_page() removes page from list on success */
-		if (!split_folio(folio))
+		if (!split_folio(folio)) {
+			did_split = true;
+			if (underused)
+				count_vm_event(THP_UNDERUSED_SPLIT_PAGE);
 			split++;
+		}
 		folio_unlock(folio);
 next:
+		/*
+		 * split_folio() removes folio from list on success.
+		 * Only add back to the queue if folio is partially mapped.
+		 * If thp_underused returns false, or if split_folio fails
+		 * in the case it was underused, then consider it used and
+		 * don't add it back to split_queue.
+		 */
+		if (!did_split && !folio_test_partially_mapped(folio)) {
+			list_del_init(&folio->_deferred_list);
+			ds_queue->split_queue_len--;
+		}
 		folio_put(folio);
 	}
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5bfb5594c604..bf1734e8e665 100644
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
 
@@ -1237,6 +1237,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
 	set_pmd_at(mm, address, pmd, _pmd);
 	update_mmu_cache_pmd(vma, address, pmd);
+	deferred_split_folio(folio, false);
 	spin_unlock(pmd_ptl);
 
 	folio = NULL;
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f41984dc856f..bb081ae4d0ae 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1385,6 +1385,7 @@ const char * const vmstat_text[] = {
 	"thp_split_page",
 	"thp_split_page_failed",
 	"thp_deferred_split_page",
+	"thp_underused_split_page",
 	"thp_split_pmd",
 	"thp_scan_exceed_none_pte",
 	"thp_scan_exceed_swap_pte",
-- 
2.43.5


