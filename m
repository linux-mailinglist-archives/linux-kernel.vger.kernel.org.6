Return-Path: <linux-kernel+bounces-277979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C594A8E9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4361F2882BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90D20FA99;
	Wed,  7 Aug 2024 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9r5ggmq"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B833205E26;
	Wed,  7 Aug 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038475; cv=none; b=d0tmr9jm0x1Wilu8mvy5s7Rt76toZhdOK9qVP4813ESCPv55Ywj1V1hmDhxyzo7yrCRxLX61DJx0OWp0atE3yCmkTjc4T/ayt4RhVhGcl+CGOnsxuNocxfvkWICZkGDW1b7ufJL0rXcXuSUWiB9YWZ38b8fmBo2BM/t77cSDjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038475; c=relaxed/simple;
	bh=p66aD1odS2UnB0Ny8r28ppPrQa0gHfqqnbeVQQKYhCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+01N3XNS+MinlGIjCG5hnzed3kQcUj0qGoDhkBAsHnnk9bcxuoRru1/PmWuoYT4xcuLLs7DfnVJDNRnAPy/5MJB46KMCAdcb14+YB+kBi06n+AyQmsCDFc9e+UIXkSLuISRJ8EbIZExQKnXYHvXSMl0DX3t572GzJISwj0ThcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9r5ggmq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b7b28442f9so18173926d6.3;
        Wed, 07 Aug 2024 06:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723038470; x=1723643270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F2nIf6zw5vVHufTEQlJ7PQV7MoC3hptBv2LFMCFET0=;
        b=S9r5ggmqzXNYnVBsZ34VeHB6Tm+xs8ePa5HQgYHI4weUsOZrF9hcyJ8dGEnNvXn1Tn
         JmWF5J4MtoGmfs/ygKHaXfLJLrAH1JahGBXR64q1KELGKOPEKgEc0uHbRl9ENGePw4KW
         0df/9SQz2FyXUCLd8WjQYBfZPxDoZgJ+BtdEDa8eDM10QP2PP6WklkQabWeqB8bMCAj6
         aE3Ai/eCaIuFipEXK4y7RGdRu/B7I7g7xrXwGdgu4dIEONJf1KzKEq5CMQWCmEFXvwCh
         XM3FiVsFvJzA17lIp9jlEv5oqAcGWF3WIca6631mmK2EMJPNeNYWXieQymrCHMk2XI/p
         N8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038470; x=1723643270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2F2nIf6zw5vVHufTEQlJ7PQV7MoC3hptBv2LFMCFET0=;
        b=wM5U2fe1P9Oueo1sR9rM8Uaf1X4qtQhkBQOj3ySE2lARSkRYdHBnlP0oPhdZRPd6OI
         xlkPNgXwzUjvWGBog6HKCjgwXySk3pQIGdxOawEcLh4EHNQMzsh04WdsFhM7KkjoNOlA
         HNPzw3sNSW+67+BjGZRNQQhKLiwp3GMscYu5zSBK2sien72xqWF0BAxitDbLT2d3H8gj
         5+Tr+HKjQeGoRXsnuTbWnNFms1OVobjosEsk8GILV6RvhdvZuKkPfohnSQtTztvEAxz4
         RSI/PHnWWbUVVkjZT901jBuoXUaKz55+TiJQt6rKsZtJtclpFLX1Yw6sAcx9r4XnCxYb
         Yu+A==
X-Forwarded-Encrypted: i=1; AJvYcCV0h5wBT/bW9LfSpgsziFAE5Q6+mKwXeT/5jykLzkpj0UBXlbfXQ9W8iH2AHpXDl8LDRsvSFvj9Y8k2fwLUVn4uDD53zWmwur02Tq/dRlSjcNOhh4yVZAKmUN7LsEeSFp6KmQndolHB
X-Gm-Message-State: AOJu0YwlvYoIDgIKKGDZq3qOuRp3BoFLK/c9VddcMlmt036RRi7YYecd
	SSKlX6Z2nX/67uQK2zoSjdZDV04Yt2Xk10TGGNUIc6eWu8heT/YP
X-Google-Smtp-Source: AGHT+IHd6+AR7fFImq+YnnPV/gYUqKZIkNuw6bsKXvN9+xmQQQij3URAzDd8enV5jAyvwQK5JWM+6g==
X-Received: by 2002:a05:6214:4a02:b0:6b7:4398:594c with SMTP id 6a1803df08f44-6bb9843efd0mr215917216d6.38.1723038469978;
        Wed, 07 Aug 2024 06:47:49 -0700 (PDT)
Received: from localhost (fwdproxy-ash-002.fbsv.net. [2a03:2880:20ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7b8826sm56639146d6.64.2024.08.07.06.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:47:49 -0700 (PDT)
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
Subject: [PATCH v2 4/4] mm: split underutilized THPs
Date: Wed,  7 Aug 2024 14:46:49 +0100
Message-ID: <20240807134732.3292797-5-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807134732.3292797-1-usamaarif642@gmail.com>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an attempt to mitigate the issue of running out of memory when THP
is always enabled. During runtime whenever a THP is being faulted in
(__do_huge_pmd_anonymous_page) or collapsed by khugepaged
(collapse_huge_page), the THP is added to  _deferred_list. Whenever memory
reclaim happens in linux, the kernel runs the deferred_split
shrinker which goes through the _deferred_list.

If the folio was partially mapped, the shrinker attempts to split it.
A new boolean is added to be able to distinguish between partially
mapped folios and others in the deferred_list at split time in
deferred_split_scan. Its needed as __folio_remove_rmap decrements
the folio mapcount elements, hence it won't be possible to distinguish
between partially mapped folios and others in deferred_split_scan
without the boolean.

If folio->_partially_mapped is not set, the shrinker checks if the THP
was underutilized, i.e. how many of the base 4K pages of the entire THP
were zero-filled. If this number goes above a certain threshold (decided by
/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none), the
shrinker will attempt to split that THP. Then at remap time, the pages that
were zero-filled are mapped to the shared zeropage, hence saving memory.

Suggested-by: Rik van Riel <riel@surriel.com>
Co-authored-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst |   6 ++
 include/linux/huge_mm.h                    |   4 +-
 include/linux/khugepaged.h                 |   1 +
 include/linux/mm_types.h                   |   2 +
 include/linux/vm_event_item.h              |   1 +
 mm/huge_memory.c                           | 118 ++++++++++++++++++---
 mm/hugetlb.c                               |   1 +
 mm/internal.h                              |   4 +-
 mm/khugepaged.c                            |   3 +-
 mm/memcontrol.c                            |   3 +-
 mm/migrate.c                               |   3 +-
 mm/rmap.c                                  |   2 +-
 mm/vmscan.c                                |   3 +-
 mm/vmstat.c                                |   1 +
 14 files changed, 130 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 058485daf186..24eec1c03ad8 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -447,6 +447,12 @@ thp_deferred_split_page
 	splitting it would free up some memory. Pages on split queue are
 	going to be split under memory pressure.
 
+thp_underutilized_split_page
+	is incremented when a huge page on the split queue was split
+	because it was underutilized. A THP is underutilized if the
+	number of zero pages in the THP are above a certain threshold
+	(/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none).
+
 thp_split_pmd
 	is incremented every time a PMD split into table of PTEs.
 	This can happen, for instance, when application calls mprotect() or
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..00af84aa88ea 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
-void deferred_split_folio(struct folio *folio);
+void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio);
@@ -484,7 +484,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return 0;
 }
-static inline void deferred_split_folio(struct folio *folio) {}
+static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
index f68865e19b0b..30baae91b225 100644
--- a/include/linux/khugepaged.h
+++ b/include/linux/khugepaged.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched/coredump.h> /* MMF_VM_HUGEPAGE */
 
+extern unsigned int khugepaged_max_ptes_none __read_mostly;
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern struct attribute_group khugepaged_attr_group;
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 485424979254..443026cf763e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -311,6 +311,7 @@ typedef struct {
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
  * @_deferred_list: Folios to be split under memory pressure.
+ * @_partially_mapped: Folio was partially mapped.
  * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
  *
  * A folio is a physically, virtually and logically contiguous set
@@ -393,6 +394,7 @@ struct folio {
 			unsigned long _head_2a;
 	/* public: */
 			struct list_head _deferred_list;
+			bool _partially_mapped;
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
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
index 891562665e19..d2008f748e92 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -73,6 +73,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 					  struct shrink_control *sc);
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
+static bool split_underutilized_thp = true;
 
 static atomic_t huge_zero_refcount;
 struct folio *huge_zero_folio __read_mostly;
@@ -438,6 +439,27 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+static ssize_t split_underutilized_thp_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", split_underutilized_thp);
+}
+
+static ssize_t split_underutilized_thp_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int err = kstrtobool(buf, &split_underutilized_thp);
+
+	if (err < 0)
+		return err;
+
+	return count;
+}
+
+static struct kobj_attribute split_underutilized_thp_attr = __ATTR(
+	thp_low_util_shrinker, 0644, split_underutilized_thp_show, split_underutilized_thp_store);
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -446,6 +468,7 @@ static struct attribute *hugepage_attr[] = {
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
+	&split_underutilized_thp_attr.attr,
 	NULL,
 };
 
@@ -1002,6 +1025,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
 		mm_inc_nr_ptes(vma->vm_mm);
+		deferred_split_folio(folio, false);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
 		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
@@ -3260,6 +3284,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			 * page_deferred_list.
 			 */
 			list_del_init(&folio->_deferred_list);
+			folio->_partially_mapped = false;
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -3316,11 +3341,12 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		list_del_init(&folio->_deferred_list);
+		folio->_partially_mapped = false;
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
-void deferred_split_folio(struct folio *folio)
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3335,6 +3361,9 @@ void deferred_split_folio(struct folio *folio)
 	if (folio_order(folio) <= 1)
 		return;
 
+	if (!partially_mapped && !split_underutilized_thp)
+		return;
+
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
 	 * this may cause a race condition to corrupt deferred split queue.
@@ -3348,14 +3377,14 @@ void deferred_split_folio(struct folio *folio)
 	if (folio_test_swapcache(folio))
 		return;
 
-	if (!list_empty(&folio->_deferred_list))
-		return;
-
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	folio->_partially_mapped = partially_mapped;
 	if (list_empty(&folio->_deferred_list)) {
-		if (folio_test_pmd_mappable(folio))
-			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		if (partially_mapped) {
+			if (folio_test_pmd_mappable(folio))
+				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		}
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3380,6 +3409,39 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
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
+		if (memchr_inv(kaddr, 0, PAGE_SIZE) == NULL) {
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
@@ -3404,6 +3466,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		} else {
 			/* We lost race with folio_put() */
 			list_del_init(&folio->_deferred_list);
+			folio->_partially_mapped = false;
 			ds_queue->split_queue_len--;
 		}
 		if (!--sc->nr_to_scan)
@@ -3412,18 +3475,45 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+		bool did_split = false;
+		bool underutilized = false;
+
+		if (folio->_partially_mapped)
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
 
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
-	list_splice_tail(&list, &ds_queue->split_queue);
+	/*
+	 * Only add back to the queue if folio->_partially_mapped is set.
+	 * If thp_underutilized returns false, or if split_folio fails in
+	 * the case it was underutilized, then consider it used and don't
+	 * add it back to split_queue.
+	 */
+	list_for_each_entry_safe(folio, next, &list, _deferred_list) {
+		if (folio->_partially_mapped)
+			list_move(&folio->_deferred_list, &ds_queue->split_queue);
+		else {
+			list_del_init(&folio->_deferred_list);
+			ds_queue->split_queue_len--;
+		}
+		folio_put(folio);
+	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5a32157ca309..df2da47d0637 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
 		INIT_LIST_HEAD(&folio->_deferred_list);
+		folio->_partially_mapped = false;
 		folio_put(folio);
 	}
 }
diff --git a/mm/internal.h b/mm/internal.h
index 7a3bcc6d95e7..d646464ba0d7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -657,8 +657,10 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
-	if (order > 1)
+	if (order > 1) {
 		INIT_LIST_HEAD(&folio->_deferred_list);
+		folio->_partially_mapped = false;
+	}
 }
 
 static inline void prep_compound_tail(struct page *head, int tail_idx)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f3b3db104615..5a434fdbc1ef 100644
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9b3ef3a70833..bd8facce2a2b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4651,7 +4651,8 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
 			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list), folio);
+			!list_empty(&folio->_deferred_list) &&
+			folio->_partially_mapped, folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
diff --git a/mm/migrate.c b/mm/migrate.c
index 151bf1b6204d..395f1b0deb45 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1731,7 +1731,8 @@ static int migrate_pages_batch(struct list_head *from,
 			 * use _deferred_list.
 			 */
 			if (nr_pages > 2 &&
-			   !list_empty(&folio->_deferred_list)) {
+			   !list_empty(&folio->_deferred_list) &&
+			   folio->_partially_mapped) {
 				if (try_split_folio(folio, split_folios) == 0) {
 					nr_failed++;
 					stats->nr_thp_failed += is_thp;
diff --git a/mm/rmap.c b/mm/rmap.c
index 2630bde38640..1b5418121965 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1582,7 +1582,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		 */
 		if (folio_test_anon(folio) && partially_mapped &&
 		    list_empty(&folio->_deferred_list))
-			deferred_split_folio(folio);
+			deferred_split_folio(folio, true);
 	}
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c89d0551655e..1bee9b1262f6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1233,7 +1233,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * Split partially mapped folios right away.
 					 * We can free the unmapped pages without IO.
 					 */
-					if (data_race(!list_empty(&folio->_deferred_list)) &&
+					if (data_race(!list_empty(&folio->_deferred_list) &&
+					    folio->_partially_mapped) &&
 					    split_folio_to_list(folio, folio_list))
 						goto activate_locked;
 				}
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 5082431dad28..525fad4a1d6d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1367,6 +1367,7 @@ const char * const vmstat_text[] = {
 	"thp_split_page",
 	"thp_split_page_failed",
 	"thp_deferred_split_page",
+	"thp_underutilized_split_page",
 	"thp_split_pmd",
 	"thp_scan_exceed_none_pte",
 	"thp_scan_exceed_swap_pte",
-- 
2.43.5


