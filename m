Return-Path: <linux-kernel+bounces-208127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3814B902126
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B63286084
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D87FBD1;
	Mon, 10 Jun 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knyCcpvA"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7D7F499
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020949; cv=none; b=tBYKYuQx3MiwRd55dC+a89JXcGiVHMHEUMg9OxFLN3uappzyH20LD4E/DZqQfK8cpRt2m1d00uxbOHwq62CreEcbiFurV/BzR5outS9hGMlWcLxHck7zGL7E5kF9WHiiBvl1CnBuq/9FNt1xzVt6hNg7QmhG6FQAbn/Rdoj7IqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020949; c=relaxed/simple;
	bh=h/qbehpgmUCcOjdGYJT1hLUR76dnOV7H89VeLNo0XKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DN8YNo93cruQC3u9C8l3TebqxJzxtvECdLa9UhsMzzbpjumnkRkFRNCYs3jmGRn2JTwYLZTXP74fTr+LTm8KRevc5ntNdk0l9vX8TZhQIcyMQC8j2BNwSHUD1bPdNhoZpkVi/ujlvL3E6KDlPEdcxKD8pkCRP8aguMKxRVkDrWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knyCcpvA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bfff08fc29so3612957a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718020948; x=1718625748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBEr8X48gppOS9Pq+Sw4WgX0PyIHU3keRQ8aF5ykbn0=;
        b=knyCcpvAODywqCHbEn5GDvs8/vOlyVXW2a4khQW8voEYBHFpeJrIUzAe7q4fA55g1n
         cVQRRfNJ7NH0G7beHBAvmSEHnjtJzcGMDhxGd1kPFudwoknnd1yNcSpejkpTncUOQEKG
         3k72x9391Zk6jcDDVTGGzXMjtVYb3uzoLl7PzOosOdsv+TGN4+0UlWmo/ioBvz9lH6dg
         XuHAcXa7dtbGy/EZ1VYALgXt5bi9ViUPppf2+F1vffx0LcwwaWXg+Cr1VG1sMr+E3ay1
         lSjW46wMN2TjNWQVvgW0TC+UkGZ7ppNNWBAxnrc6UQHdYkbBhE7QABJT8Fuqq04ZWkW1
         o+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718020948; x=1718625748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBEr8X48gppOS9Pq+Sw4WgX0PyIHU3keRQ8aF5ykbn0=;
        b=fCHvLurkQEvMpURkmsIcDYFNaJzMEG7ZGt/0iv5JjbC5t9/vMK9zGXpe/sGoCSUgOq
         mPddk9zkLi6vi8Mwi/XyH9w6Y8aEWbHRXQlRWpwi+wVQ/m07DTsFP49luFF04lsYswXG
         eMJC+D/HtYO8U85hS4TpFQx297cvnV1QuhsiqsUABhRwLnZ485CTURSWxiBZhKsmWlzx
         jaJFifVxKCiNegRAClHXpjXnX4OABHYyQDT7sKJ1KDR6Y3a63XZ0CdfLPGevYFvt+/M2
         Evt45BIMEVvnTrq0AyqB7vhGCKki9DsdqwxRyOobXT/Z05f1tvfEQ0J2N4ouIb3qQOJ/
         rSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRf6DiThxvpp4KN+ytDR0ONZEnfcl8mq6LlduSIhflMZcza8Iz7qafHjigHgDX3GzmP3PQ2r0vR6Z8YGevk4wAVYVePXPYSlyTcm8P
X-Gm-Message-State: AOJu0YznvhBriK56DVa+Zz9pB6jEGu4hkxdHcwlYVCxZAUfDw+IEjPbX
	WvROXWRX9NS7qfa1NgJHHl3iEIgodFpgGghQp8pPK+1bwWm7GGrN
X-Google-Smtp-Source: AGHT+IFSTF5zRph+kFCZTrfNYOUKk6N+AfTH+6+XT32Q1zGJQ4AHy88EyqrdIXL9+OQ1MKB+a7QwUQ==
X-Received: by 2002:a17:90a:5e43:b0:2bf:f248:3506 with SMTP id 98e67ed59e1d1-2c2bcaf984fmr8656864a91.12.1718020947621;
        Mon, 10 Jun 2024 05:02:27 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::304c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c302f0ebdcsm2478478a91.23.2024.06.10.05.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:02:27 -0700 (PDT)
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
Subject: [PATCH v7 1/4] mm/rmap: remove duplicated exit code in pagewalk loop
Date: Mon, 10 Jun 2024 20:02:06 +0800
Message-Id: <20240610120209.66311-2-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20240610120209.66311-1-ioworker0@gmail.com>
References: <20240610120209.66311-1-ioworker0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the labels walk_done and walk_done_err as exit points to
eliminate duplicated exit code in the pagewalk loop.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/rmap.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index e8fc5ecb59b2..ddffa30c79fb 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1679,9 +1679,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			/* Restore the mlock which got missed */
 			if (!folio_test_large(folio))
 				mlock_vma_folio(folio, vma);
-			page_vma_mapped_walk_done(&pvmw);
-			ret = false;
-			break;
+			goto walk_done_err;
 		}
 
 		pfn = pte_pfn(ptep_get(pvmw.pte));
@@ -1719,11 +1717,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			if (!anon) {
 				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
-				if (!hugetlb_vma_trylock_write(vma)) {
-					page_vma_mapped_walk_done(&pvmw);
-					ret = false;
-					break;
-				}
+				if (!hugetlb_vma_trylock_write(vma))
+					goto walk_done_err;
 				if (huge_pmd_unshare(mm, vma, address, pvmw.pte)) {
 					hugetlb_vma_unlock_write(vma);
 					flush_tlb_range(vma,
@@ -1738,8 +1733,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 					 * actual page and drop map count
 					 * to zero.
 					 */
-					page_vma_mapped_walk_done(&pvmw);
-					break;
+					goto walk_done;
 				}
 				hugetlb_vma_unlock_write(vma);
 			}
@@ -1811,9 +1805,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			if (unlikely(folio_test_swapbacked(folio) !=
 					folio_test_swapcache(folio))) {
 				WARN_ON_ONCE(1);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			/* MADV_FREE page check */
@@ -1852,23 +1844,17 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
 				folio_set_swapbacked(folio);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			if (swap_duplicate(entry) < 0) {
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 
 			/* See folio_try_share_anon_rmap(): clear PTE first. */
@@ -1876,9 +1862,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			    folio_try_share_anon_rmap_pte(folio, subpage)) {
 				swap_free(entry);
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				ret = false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				goto walk_done_err;
 			}
 			if (list_empty(&mm->mmlist)) {
 				spin_lock(&mmlist_lock);
@@ -1918,6 +1902,12 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (vma->vm_flags & VM_LOCKED)
 			mlock_drain_local();
 		folio_put(folio);
+		continue;
+walk_done_err:
+		ret = false;
+walk_done:
+		page_vma_mapped_walk_done(&pvmw);
+		break;
 	}
 
 	mmu_notifier_invalidate_range_end(&range);
-- 
2.33.1


