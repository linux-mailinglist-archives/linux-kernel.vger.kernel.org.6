Return-Path: <linux-kernel+bounces-291351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61F295611E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD88281B2F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367A5C603;
	Mon, 19 Aug 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVBvrXZk"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E7947A;
	Mon, 19 Aug 2024 02:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034721; cv=none; b=tW337Bs9U17Hex1WzENnNEkohaVasubmVV8fWb9GGLL5H+pbG4auWLp1TycQRVsqXJSyTfMp/StFBD2BAMgGnyFU5f76FKEpIJo5tHyBkwKdIXtDLMCOtYMhv0QXlUBYOQzl3nl5+RJaw45IMpoCbCGEPQEfFebiWTmqiPrulk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034721; c=relaxed/simple;
	bh=Gn/49yLWPZ+HZnELT0RsBnck5s3XyCzfPaGzaRAJSZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWG65ozoh6fqF4rFPIKH2Gh1Zj1PKvjVGi7uU2Xn5vkoFP8xj8m874SudgeLo5ECSTliumPUSUZpdGmR/sjYKwUWB/38B9PAr2bA8MWYAClKEKN11Z3lGQ6+NDe4Qeli8vP2IWwhvg8KU1/Ia/nR86RIV8G6t7EM+QvJ3+urZlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVBvrXZk; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e026a2238d8so3838147276.0;
        Sun, 18 Aug 2024 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724034717; x=1724639517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BDAWwS723hN3aXuX35eiOFn0OpaDg+7RbZaRdmjXne8=;
        b=YVBvrXZk14fXpDlX0Xx5PCTa0QDLjNCa1eMIZeyh1oZntBNrUa9qaOMj9fHyJdVdxS
         Y0L1MfUSnCqZyUQ0Lt5aFQnf0clziPWcCfgiK+fZHn9ShBP9DdI0Sev9sCToUxC4aMje
         vphTxkc+c4uX8F3hBdy8lLF7+ZbKz3xytAwYWOfc3gj/FKKXlY5yReE+jmOapS2AlAnT
         zFbHR/G/Swumrr7LhVbPwNvQcNZqfk0Tv/iiwh7zdfzV0ekSCfFRjCvqpCFv7fRoiDFn
         E1S0RDYSaWjSLPbrhVI7Fd/90uGn14NKd6aMdSnygXU2ZVEXnJ92jxznvMcxDVFB22FL
         VzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034717; x=1724639517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDAWwS723hN3aXuX35eiOFn0OpaDg+7RbZaRdmjXne8=;
        b=hhxr+bVJhow+WzK4+UmFQm9NFWfoE0Jpnh+LQbfXpuVrF7EaULwTlz4s5hOeqtRlaA
         0k3C4nZOi7c4DDeqBd77eujlb+5Ndk3/PwDWYy0+aa8wnRtZkV6DP6cPQ1HLrTM5YXVG
         tQTg2vpc7r32d1wFUkqTM8m2Ul9HVqM2kl08dAwyRWVz2kjio1l4Ef45W8wMFtqGE54f
         IGvMCRfcyHAM0RuivzxAgEbvsJND2JAbDvy9idC4InIwwCIqUP5QIJB57+Ly6S9QZxhw
         3kiFMyAjpN5oKmphnwLwslyaw0uDx1Kr4FSYtvrVXxRLDhzBKq+t5fGYIgwyYe5009L3
         47AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxYa65Sb/eIc50TC6yTGBTMbTArSBIxKcSJoNRYKyzrybUEBzPwXp5JafN2G/9SpYwyE4ztJpgYS3MAGlj@vger.kernel.org, AJvYcCXRRxkc35mh3io4XFkOWTG9nhVhhkutbxBBbeaS8pGP5zgfDqQwLlWwxBABOAsfSVjWiAE9e+5KuwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvh2DHH/Fx3zfXFyJOqYsgz5AvSFIp8Odek4hwLMAmLJVwteMf
	gpsavZpJcPnIZm+Oc4JA6Y+gcRekMFe/5cTjolWbpviCnFRMlvzi
X-Google-Smtp-Source: AGHT+IHePXgHOJtzLLyUXdkdD/gbE32Y/UIS3Wv6y/4aGanspmXVzMlLaX5LmK42xXQm7XY5FnN/nA==
X-Received: by 2002:a05:6902:18c3:b0:e13:d3ec:2b8f with SMTP id 3f1490d57ef6-e13d3ec34a5mr7085223276.52.1724034717319;
        Sun, 18 Aug 2024 19:31:57 -0700 (PDT)
Received: from localhost (fwdproxy-ash-014.fbsv.net. [2a03:2880:20ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a0046a4sm36947491cf.41.2024.08.18.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:31:56 -0700 (PDT)
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
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 5/6] mm: split underused THPs
Date: Mon, 19 Aug 2024 03:30:58 +0100
Message-ID: <20240819023145.2415299-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819023145.2415299-1-usamaarif642@gmail.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
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
index 058485daf186..40741b892aff 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -447,6 +447,12 @@ thp_deferred_split_page
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
index 70ee49dfeaad..f5363cf900f9 100644
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
@@ -3526,6 +3527,39 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
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
@@ -3559,13 +3593,35 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
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
index 6c42062478c1..2e138b22d939 100644
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
index c3a402ea91f0..6060bb7bbb44 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1384,6 +1384,7 @@ const char * const vmstat_text[] = {
 	"thp_split_page",
 	"thp_split_page_failed",
 	"thp_deferred_split_page",
+	"thp_underused_split_page",
 	"thp_split_pmd",
 	"thp_scan_exceed_none_pte",
 	"thp_scan_exceed_swap_pte",
-- 
2.43.5


