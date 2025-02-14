Return-Path: <linux-kernel+bounces-514699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B6FA35A65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FE118929F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A555B4A08;
	Fri, 14 Feb 2025 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjNXKDqS"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C1245B17
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525457; cv=none; b=DEENESk45jswttW0sbKPJ70ovQ+S4JbpZt7DIYlDGAmsJUd4ma4N/aqzMEaJ7HTSSWeiKyB1BtUptiutPiJ3tF+RrpGthlIMNbq2QUtXMlvba6DZ7xERSMjnATffw31uB67tiEMUF7o2/f6L7lcmU7Fzzr+BHj1AAClv6CkkRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525457; c=relaxed/simple;
	bh=Kedg8XqTxqd04IMMh8xOggfRQcdVcBb9/a92aNXqnlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQhw0vccRGWlUql4XJpMgBTRRweGAbD3GKw1Go1dfvD8xCqs1Z85m+14RX0Bj4MUsQLHwAxrlBO9iVuJ/U+1gZeA0jQT+eMMHDMSyavd3iRUi//Q45a7ElpO6EoJ85ieX+y7sqlXe7/FSKU9VHEYThkzrOpOVNgPzpu4+5LZcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjNXKDqS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f48ebaadfso36754325ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739525455; x=1740130255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptqpPfUGDg1EiuURg84FX6mkSOnefIkRazcht+VYCyI=;
        b=RjNXKDqSy5GgZHInLOjZa+AqlIiwHpU2dcD9wvAansYyHdanR+cLbP3rPxSr+3f3qs
         tIK5PUy/v92des/eEii6Otu39vg7GzSLY37dlacXwpRyvetd0sYqXLGyJf3KMpeF9ecg
         /yNEEj3J0H/RDsYfAO/N0dDevF2t+dMH/KPZDY00KAOzDzIUGrgoPNQIUh8wtGu8n1AQ
         5OZehyzScI1Vf+kgOLY6BdxBl0OvMHje5VvhizIB+wt/U718NyFOCuZriaVgt8D4qr6e
         5V0lq/raxqWxQ6FDFHqHDbL7tNfc6EG3OG46db/Q8477Jt2Qj1J95i9IQpfFxnNyy8Nn
         epCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525455; x=1740130255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptqpPfUGDg1EiuURg84FX6mkSOnefIkRazcht+VYCyI=;
        b=PEF6pAjSz6/f/CAKvyuN4JM/H9YNoIJq3n/876M+4Fo7czFMpPiAtkjR2btw2r3kNR
         0GITdIfxb3Uuah4D9aPDWqV5UDhxoN7X2pYwjGZWZRJuTk5crBCiUoIPQWCMhCg1cO59
         e58xOzWGBpp0Z1mZr8a9Hm392m6L0V8M2AmDxOitAYRR3Q4FZfKM3NNgNWNyhoqmxeEc
         V+XCxhXsEjaqrjvzzH9tB/3pZQCOYKxKXnRbUF48DwUolFqRJj7pZp6FJwMPKxcme3PH
         rwbwkKtRerXJpr7NX/sIdDifA62dFasC5uwX/Xndczi9WKipE/lpa2MNUh668iyf0gq8
         F40g==
X-Forwarded-Encrypted: i=1; AJvYcCW3/LzEgGJ08FWNsMtSD12e3g/HvyWboJXYJN2CYIseOp0Ddb6bS02ub+o00zrgjW36JJt+QoIuPhLwupc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8WeMOzbQE3b5cVpR6SGOttIqXEefwYQGgxe1fuOJfU/5Fly2j
	6hYoZyvloVrWy7FG8mk43L+gIe8QSYea4BkaMC8CMx96pUhOAqlSdDH3OKpa
X-Gm-Gg: ASbGnct9BPutlgNhc+EqK0nF364P0LgYTVDPz/fd68KrRIcSnH0Pc4Dzblde63VdFa/
	YiPhNv7Wqir5wfUEPaTSBrnfKm8LL30KVpfzXFfzMOLLmuOA59036VRZg4zmDmDF7rzaUmBAPgj
	7wUaYF8CWZtBgFoJCDkw6O75rxOFdBTbVR27LPXdUNA3jS2UpLdkrFGZYHSN74ts0RngnUMFCK/
	IYob+8lV5Gx+Oc+SCML3uUbB4reKoxNl1Kt5fPg1NMRmRPDmXd2Z4VB+FnNzUnog+qyhT1slRfZ
	ff0ILb2KzmbaOe3LNna9wJgXSYZlho8=
X-Google-Smtp-Source: AGHT+IH6XcRb3dY+ed+qthaJ3tDEtbZeAuAInUKd60UoN8JUd4P8SIptONXNJZy3ckuGqMfBoSS1OA==
X-Received: by 2002:a17:902:f545:b0:216:393b:23d4 with SMTP id d9443c01a7336-220bbab0e0cmr183420735ad.11.1739525455176;
        Fri, 14 Feb 2025 01:30:55 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm25440515ad.148.2025.02.14.01.30.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 01:30:54 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	x86@kernel.org,
	ying.huang@intel.com,
	zhengtangquan@oppo.com
Subject: [PATCH v4 3/4] mm: Support batched unmap for lazyfree large folios during reclamation
Date: Fri, 14 Feb 2025 22:30:14 +1300
Message-Id: <20250214093015.51024-4-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250214093015.51024-1-21cnbao@gmail.com>
References: <20250214093015.51024-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Currently, the PTEs and rmap of a large folio are removed one at a time.
This is not only slow but also causes the large folio to be unnecessarily
added to deferred_split, which can lead to races between the
deferred_split shrinker callback and memory reclamation. This patch
releases all PTEs and rmap entries in a batch.
Currently, it only handles lazyfree large folios.

The below microbench tries to reclaim 128MB lazyfree large folios
whose sizes are 64KiB:

 #include <stdio.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <time.h>

 #define SIZE 128*1024*1024  // 128 MB

 unsigned long read_split_deferred()
 {
 	FILE *file = fopen("/sys/kernel/mm/transparent_hugepage"
			"/hugepages-64kB/stats/split_deferred", "r");
 	if (!file) {
 		perror("Error opening file");
 		return 0;
 	}

 	unsigned long value;
 	if (fscanf(file, "%lu", &value) != 1) {
 		perror("Error reading value");
 		fclose(file);
 		return 0;
 	}

 	fclose(file);
 	return value;
 }

 int main(int argc, char *argv[])
 {
 	while(1) {
 		volatile int *p = mmap(0, SIZE, PROT_READ | PROT_WRITE,
 				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

 		memset((void *)p, 1, SIZE);

 		madvise((void *)p, SIZE, MADV_FREE);

 		clock_t start_time = clock();
 		unsigned long start_split = read_split_deferred();
 		madvise((void *)p, SIZE, MADV_PAGEOUT);
 		clock_t end_time = clock();
 		unsigned long end_split = read_split_deferred();

 		double elapsed_time = (double)(end_time - start_time) / CLOCKS_PER_SEC;
 		printf("Time taken by reclamation: %f seconds, split_deferred: %ld\n",
 			elapsed_time, end_split - start_split);

 		munmap((void *)p, SIZE);
 	}
 	return 0;
 }

w/o patch:
~ # ./a.out
Time taken by reclamation: 0.177418 seconds, split_deferred: 2048
Time taken by reclamation: 0.178348 seconds, split_deferred: 2048
Time taken by reclamation: 0.174525 seconds, split_deferred: 2048
Time taken by reclamation: 0.171620 seconds, split_deferred: 2048
Time taken by reclamation: 0.172241 seconds, split_deferred: 2048
Time taken by reclamation: 0.174003 seconds, split_deferred: 2048
Time taken by reclamation: 0.171058 seconds, split_deferred: 2048
Time taken by reclamation: 0.171993 seconds, split_deferred: 2048
Time taken by reclamation: 0.169829 seconds, split_deferred: 2048
Time taken by reclamation: 0.172895 seconds, split_deferred: 2048
Time taken by reclamation: 0.176063 seconds, split_deferred: 2048
Time taken by reclamation: 0.172568 seconds, split_deferred: 2048
Time taken by reclamation: 0.171185 seconds, split_deferred: 2048
Time taken by reclamation: 0.170632 seconds, split_deferred: 2048
Time taken by reclamation: 0.170208 seconds, split_deferred: 2048
Time taken by reclamation: 0.174192 seconds, split_deferred: 2048
...

w/ patch:
~ # ./a.out
Time taken by reclamation: 0.074231 seconds, split_deferred: 0
Time taken by reclamation: 0.071026 seconds, split_deferred: 0
Time taken by reclamation: 0.072029 seconds, split_deferred: 0
Time taken by reclamation: 0.071873 seconds, split_deferred: 0
Time taken by reclamation: 0.073573 seconds, split_deferred: 0
Time taken by reclamation: 0.071906 seconds, split_deferred: 0
Time taken by reclamation: 0.073604 seconds, split_deferred: 0
Time taken by reclamation: 0.075903 seconds, split_deferred: 0
Time taken by reclamation: 0.073191 seconds, split_deferred: 0
Time taken by reclamation: 0.071228 seconds, split_deferred: 0
Time taken by reclamation: 0.071391 seconds, split_deferred: 0
Time taken by reclamation: 0.071468 seconds, split_deferred: 0
Time taken by reclamation: 0.071896 seconds, split_deferred: 0
Time taken by reclamation: 0.072508 seconds, split_deferred: 0
Time taken by reclamation: 0.071884 seconds, split_deferred: 0
Time taken by reclamation: 0.072433 seconds, split_deferred: 0
Time taken by reclamation: 0.071939 seconds, split_deferred: 0
...

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/rmap.c | 72 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 89e51a7a9509..8786704bd466 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1781,6 +1781,25 @@ void folio_remove_rmap_pud(struct folio *folio, struct page *page,
 #endif
 }
 
+/* We support batch unmapping of PTEs for lazyfree large folios */
+static inline bool can_batch_unmap_folio_ptes(unsigned long addr,
+			struct folio *folio, pte_t *ptep)
+{
+	const fpb_t fpb_flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
+	int max_nr = folio_nr_pages(folio);
+	pte_t pte = ptep_get(ptep);
+
+	if (!folio_test_anon(folio) || folio_test_swapbacked(folio))
+		return false;
+	if (pte_unused(pte))
+		return false;
+	if (pte_pfn(pte) != folio_pfn(folio))
+		return false;
+
+	return folio_pte_batch(folio, addr, ptep, pte, max_nr, fpb_flags, NULL,
+			       NULL, NULL) == max_nr;
+}
+
 /*
  * @arg: enum ttu_flags will be passed to this argument
  */
@@ -1794,6 +1813,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	struct page *subpage;
 	struct mmu_notifier_range range;
 	enum ttu_flags flags = (enum ttu_flags)(long)arg;
+	unsigned long nr_pages = 1, end_addr;
 	unsigned long pfn;
 	unsigned long hsz = 0;
 
@@ -1933,23 +1953,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (pte_dirty(pteval))
 				folio_mark_dirty(folio);
 		} else if (likely(pte_present(pteval))) {
-			flush_cache_page(vma, address, pfn);
-			/* Nuke the page table entry. */
-			if (should_defer_flush(mm, flags)) {
-				/*
-				 * We clear the PTE but do not flush so potentially
-				 * a remote CPU could still be writing to the folio.
-				 * If the entry was previously clean then the
-				 * architecture must guarantee that a clear->dirty
-				 * transition on a cached TLB entry is written through
-				 * and traps if the PTE is unmapped.
-				 */
-				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
+			if (folio_test_large(folio) && !(flags & TTU_HWPOISON) &&
+			    can_batch_unmap_folio_ptes(address, folio, pvmw.pte))
+				nr_pages = folio_nr_pages(folio);
+			end_addr = address + nr_pages * PAGE_SIZE;
+			flush_cache_range(vma, address, end_addr);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address, address + PAGE_SIZE);
-			} else {
-				pteval = ptep_clear_flush(vma, address, pvmw.pte);
-			}
+			/* Nuke the page table entry. */
+			pteval = get_and_clear_full_ptes(mm, address, pvmw.pte, nr_pages, 0);
+			/*
+			 * We clear the PTE but do not flush so potentially
+			 * a remote CPU could still be writing to the folio.
+			 * If the entry was previously clean then the
+			 * architecture must guarantee that a clear->dirty
+			 * transition on a cached TLB entry is written through
+			 * and traps if the PTE is unmapped.
+			 */
+			if (should_defer_flush(mm, flags))
+				set_tlb_ubc_flush_pending(mm, pteval, address, end_addr);
+			else
+				flush_tlb_range(vma, address, end_addr);
 			if (pte_dirty(pteval))
 				folio_mark_dirty(folio);
 		} else {
@@ -2027,7 +2050,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					 * redirtied either using the page table or a previously
 					 * obtained GUP reference.
 					 */
-					set_pte_at(mm, address, pvmw.pte, pteval);
+					set_ptes(mm, address, pvmw.pte, pteval, nr_pages);
 					folio_set_swapbacked(folio);
 					goto walk_abort;
 				} else if (ref_count != 1 + map_count) {
@@ -2040,10 +2063,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					 * We'll come back here later and detect if the folio was
 					 * dirtied when the additional reference is gone.
 					 */
-					set_pte_at(mm, address, pvmw.pte, pteval);
+					set_ptes(mm, address, pvmw.pte, pteval, nr_pages);
 					goto walk_abort;
 				}
-				dec_mm_counter(mm, MM_ANONPAGES);
+				add_mm_counter(mm, MM_ANONPAGES, -nr_pages);
 				goto discard;
 			}
 
@@ -2108,13 +2131,18 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			dec_mm_counter(mm, mm_counter_file(folio));
 		}
 discard:
-		if (unlikely(folio_test_hugetlb(folio)))
+		if (unlikely(folio_test_hugetlb(folio))) {
 			hugetlb_remove_rmap(folio);
-		else
-			folio_remove_rmap_pte(folio, subpage, vma);
+		} else {
+			folio_remove_rmap_ptes(folio, subpage, nr_pages, vma);
+			folio_ref_sub(folio, nr_pages - 1);
+		}
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
+		/* We have already batched the entire folio */
+		if (nr_pages > 1)
+			goto walk_done;
 		continue;
 walk_abort:
 		ret = false;
-- 
2.39.3 (Apple Git-146)


