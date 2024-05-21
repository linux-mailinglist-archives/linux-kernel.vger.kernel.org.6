Return-Path: <linux-kernel+bounces-184479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218A8CA737
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 826DAB2152A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9CD2B9AA;
	Tue, 21 May 2024 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feUU961q"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D0225D4
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264224; cv=none; b=asQzHYpqR3DCimsKZvltCIRftc6QAw5uQfSOY1Q6G0BsZuWLmrY26ohSi1oms52xMPG4mxxqI5DZNiX0aW035XNX6Fxu9y5qP4xOzsVu+tJKEMkHiVZO2SQ8q7XdqNEnMcaHLE3T1QN7edToUgl+pkJcLFj2UtoLYBs3LofO6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264224; c=relaxed/simple;
	bh=Wf3vDeQodEKo7KdRw+JOdQByT/BFepoU3b9aEGletHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqKKNIXQti0ZfvUvgLv0bURdT7SimccuvDT5Y27zgdCR1tE6+qHlXbswvo3LdX9HqEyab5VFAca/XpHfBPXfCee0kStfagmx02v3Bn/NxOEllNZ7VBQlMMLa78au94A9tUHytv7KHaw07CIcDe7Qhzza5SaWhMj2ar/lMYXaoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feUU961q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f304533064so9829895ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716264223; x=1716869023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX/01s4vYIQbr18bE5flsb5nej8ApaXUJjiKJpBs8CU=;
        b=feUU961qyO2bNymi6mpziXVBd6CKr2WrcWKuT8WOfqG7jCGycs+CzWRMEq8v48SJ/M
         gGe+Ch3vipSjhQ2UYmzumrjpHtiJ2iJ5ZaC3aooPcwDB0MOjhIp9sVHOzIzcHcT3lnFj
         D0xkIZ3tgOnWPOeWj++OnlDg2KqqHY6Fm6ODm7NNdw26FlDzXGV/Z4raZxHNtfQH8cic
         HYZrhXYfBnpHGI8n6HpNPQd2Ok6tdlUznY7rnLT9bsL/zbSOx8JbjmJZsWM+S+hAsg9U
         yINTZT1LIDul8teFNXS1kdnhYgf+3v8gDPU3tiSNFsrb+5PzbDLWUAKvJcnX/IJBeUF0
         ggJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264223; x=1716869023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uX/01s4vYIQbr18bE5flsb5nej8ApaXUJjiKJpBs8CU=;
        b=pQjGUTmVoHgJLhVPV1oFpfxSdr53iIA6YDKEn6W7RcmQyi6tbKIpknjBwy0r8m/lx8
         uuuL+9eylbETKOjbFaM79kxbMD44FBUCUr+GGgwvowIWxJVCNUkRlwOE8whcMTCBivf7
         RnaqGHImQPU2hK43cHcr2mynyFARU1HqSUOsNqie5DZMk6CDfml9XnUqeJxCuu1agPTZ
         LfIKRzZwqXHeG0K1vaWOxgdPghX9pRs2FXiP0lVJUjcgGOZkUWc8TTB3temPnGmr2x7A
         rL8I9uPt3kvge+P2pCTzIUf8EJimVXJjo0sv/wVLrftqv5NGvAfEERlo3wz+0r1TSiKw
         BFnA==
X-Forwarded-Encrypted: i=1; AJvYcCWeiDqljHdNeaqmgYi4+mrqhGwbGYhOCoH3+FbB2HmXDO4m5gindHQz0NFdAKUpfT1JVzXoJwTiCgxakl/1r6nbw2e4VD5rFAXtbcwE
X-Gm-Message-State: AOJu0YwZd/9eEQWE85eR+NMUDrcD0hYlefpo/HDf6FNi5nyFBK7mHCX1
	IFLcMbRy/bj6MlFVUdycadxPulHvSdi7EC5IcHKUnV+lpVuDUZyg
X-Google-Smtp-Source: AGHT+IHUenY7Vns4wwcjPnGW95ACeeeUgKgYAe9jFb6BEdQnC4grlMSeDLzUCyAEyHVP1CHFiQcmZg==
X-Received: by 2002:a17:903:230b:b0:1f2:fb9e:f697 with SMTP id d9443c01a7336-1f2fb9ef9d5mr87868225ad.2.1716264222544;
        Mon, 20 May 2024 21:03:42 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62bfsm211683945ad.74.2024.05.20.21.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 21:03:42 -0700 (PDT)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org,
	sj@kernel.org,
	baolin.wang@linux.alibaba.com,
	maskray@google.com,
	ziy@nvidia.com,
	ryan.roberts@arm.com,
	david@redhat.com,
	21cnbao@gmail.com,
	mhocko@suse.com,
	fengwei.yin@intel.com,
	zokeefe@google.com,
	shy828301@gmail.com,
	xiehuan09@gmail.com,
	libang.li@antgroup.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH v6 3/3] mm/vmscan: avoid split lazyfree THP during shrink_folio_list()
Date: Tue, 21 May 2024 12:02:44 +0800
Message-Id: <20240521040244.48760-4-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240521040244.48760-1-ioworker0@gmail.com>
References: <20240521040244.48760-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the user no longer requires the pages, they would use
madvise(MADV_FREE) to mark the pages as lazy free. Subsequently, they
typically would not re-write to that memory again.

During memory reclaim, if we detect that the large folio and its PMD are
both still marked as clean and there are no unexpected references
(such as GUP), so we can just discard the memory lazily, improving the
efficiency of memory reclamation in this case.

On an Intel i5 CPU, reclaiming 1GiB of lazyfree THPs using
mem_cgroup_force_empty() results in the following runtimes in seconds
(shorter is better):

--------------------------------------------
|     Old       |      New       |  Change  |
--------------------------------------------
|   0.683426    |    0.049197    |  -92.80% |
--------------------------------------------

Suggested-by: Zi Yan <ziy@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 include/linux/huge_mm.h |  9 +++++
 mm/huge_memory.c        | 80 +++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c               | 41 ++++++++++++++-------
 3 files changed, 117 insertions(+), 13 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 9fcb0b0b6ed1..cfd7ec2b6d0a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -411,6 +411,8 @@ static inline bool thp_migration_supported(void)
 
 void split_huge_pmd_locked(struct vm_area_struct *vma, unsigned long address,
 			   pmd_t *pmd, bool freeze, struct folio *folio);
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio);
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -478,6 +480,13 @@ static inline void split_huge_pmd_locked(struct vm_area_struct *vma,
 					 unsigned long address, pmd_t *pmd,
 					 bool freeze, struct folio *folio) {}
 
+static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
+					 unsigned long addr, pmd_t *pmdp,
+					 struct folio *folio)
+{
+	return false;
+}
+
 #define split_huge_pud(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 425272c6c50b..4793ffa912ca 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2687,6 +2687,86 @@ static void unmap_folio(struct folio *folio)
 	try_to_unmap_flush();
 }
 
+static bool __discard_trans_pmd_locked(struct vm_area_struct *vma,
+				       unsigned long addr, pmd_t *pmdp,
+				       struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
+
+	struct mm_struct *mm = vma->vm_mm;
+	int ref_count, map_count;
+	pmd_t orig_pmd = *pmdp;
+	struct page *page;
+
+	if (unlikely(!pmd_present(orig_pmd) || !pmd_trans_huge(orig_pmd)))
+		return false;
+
+	page = pmd_page(orig_pmd);
+	if (unlikely(page_folio(page) != folio))
+		return false;
+
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd)) {
+		folio_set_swapbacked(folio);
+		return false;
+	}
+
+	orig_pmd = pmdp_huge_clear_flush(vma, addr, pmdp);
+
+	/*
+	 * Syncing against concurrent GUP-fast:
+	 * - clear PMD; barrier; read refcount
+	 * - inc refcount; barrier; read PMD
+	 */
+	smp_mb();
+
+	ref_count = folio_ref_count(folio);
+	map_count = folio_mapcount(folio);
+
+	/*
+	 * Order reads for folio refcount and dirty flag
+	 * (see comments in __remove_mapping()).
+	 */
+	smp_rmb();
+
+	/*
+	 * If the folio or its PMD is redirtied at this point, or if there
+	 * are unexpected references, we will give up to discard this folio
+	 * and remap it.
+	 *
+	 * The only folio refs must be one from isolation plus the rmap(s).
+	 */
+	if (folio_test_dirty(folio) || pmd_dirty(orig_pmd))
+		folio_set_swapbacked(folio);
+
+	if (folio_test_swapbacked(folio) || ref_count != map_count + 1) {
+		set_pmd_at(mm, addr, pmdp, orig_pmd);
+		return false;
+	}
+
+	folio_remove_rmap_pmd(folio, page, vma);
+	zap_deposited_table(mm, pmdp);
+	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
+	if (vma->vm_flags & VM_LOCKED)
+		mlock_drain_local();
+	folio_put(folio);
+
+	return true;
+}
+
+bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
+			   pmd_t *pmdp, struct folio *folio)
+{
+	VM_WARN_ON_FOLIO(!folio_test_pmd_mappable(folio), folio);
+	VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE(!IS_ALIGNED(addr, HPAGE_PMD_SIZE));
+
+	if (folio_test_anon(folio) && !folio_test_swapbacked(folio))
+		return __discard_trans_pmd_locked(vma, addr, pmdp, folio);
+
+	return false;
+}
+
 static void remap_page(struct folio *folio, unsigned long nr)
 {
 	int i = 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 08a93347f283..249d6e305bec 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1630,6 +1630,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
 	unsigned long pfn;
 	unsigned long hsz = 0;
+	bool pmd_mapped = false;
 
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
@@ -1677,18 +1678,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			goto walk_done_err;
 		}
 
-		if (!pvmw.pte && (flags & TTU_SPLIT_HUGE_PMD)) {
-			/*
-			 * We temporarily have to drop the PTL and start once
-			 * again from that now-PTE-mapped page table.
-			 */
-			split_huge_pmd_locked(vma, range.start, pvmw.pmd, false,
-					      folio);
-			pvmw.pmd = NULL;
-			spin_unlock(pvmw.ptl);
-			pvmw.ptl = NULL;
-			flags &= ~TTU_SPLIT_HUGE_PMD;
-			continue;
+		if (!pvmw.pte) {
+			pmd_mapped = true;
+			if (unmap_huge_pmd_locked(vma, range.start, pvmw.pmd,
+						  folio))
+				goto walk_done;
+
+			if (flags & TTU_SPLIT_HUGE_PMD) {
+				/*
+				 * We temporarily have to drop the PTL and start
+				 * once again from that now-PTE-mapped page
+				 * table.
+				 */
+				split_huge_pmd_locked(vma, range.start,
+						      pvmw.pmd, false, folio);
+				pvmw.pmd = NULL;
+				spin_unlock(pvmw.ptl);
+				pvmw.ptl = NULL;
+				flags &= ~TTU_SPLIT_HUGE_PMD;
+				continue;
+			}
 		}
 
 		/* Unexpected PMD-mapped THP? */
@@ -1816,7 +1825,13 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
-				WARN_ON_ONCE(1);
+				/*
+				 * unmap_huge_pmd_locked() will unmark a
+				 * PMD-mapped folio as lazyfree if the folio or
+				 * its PMD was redirtied.
+				 */
+				if (!pmd_mapped)
+					WARN_ON_ONCE(1);
 				goto walk_done_err;
 			}
 
-- 
2.33.1


