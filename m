Return-Path: <linux-kernel+bounces-184477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227738CA735
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86E411F21CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1220323;
	Tue, 21 May 2024 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOi7s/3z"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7612BAF0
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264206; cv=none; b=C+ZtkyXqARaPPmqld6vK/yQKddoNyNvyk5f1dHmGSZ1EDOPbRKVYtXrunsZ/uT9Zb5CWmbjbNkXh4utjgv5udzxn2PtE+9iUzn3M9vARUHwwLaYGVEZlqa+gCdPfJTCULKU+Ufjyz42nrjJfK8y+cCnmAkWIhJcdhOyy4X8tCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264206; c=relaxed/simple;
	bh=Ri0CtFVWdMyUGCRsOo0I73K7wAWbNqPqRMtJDx20tx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P54hduG73QW8dsrWhC1wLB/ZVZTcLxYocMV4rcCVH/jLiGgDBR4E1pD2NwUbqwrI/PlWX/+QTb+/kTomWEJEj+wBnS9ZKyWLAlgh5azTLCKXPTLf0LVd+RXUa+B7xGFI/rUydmGk6oR4rQnvEh/sTRx9jVziJGL8uHSnaGchMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOi7s/3z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1ee7963db64so28412725ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716264205; x=1716869005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYO5X0diZdV5MQxI/s9TBFrpTwF5UWPwxcd05AKrshs=;
        b=kOi7s/3z78hrT4r++Bg8J8f4+qn/xH0XLGI3/DdfAmb440iPppuJEpWeJqBu1wAz5p
         MDLOLH2OSySl18anruVXVrCanruzd/dKKy00lPZFMDoLqrT2WnTTFLoCrRk6mpphElog
         ewMCj3WQai8bPlttr3cM8vpglp8W3l2Fgf6E0vkjAW5yf9VoUf+MrHauinsQ196Ddx1M
         fvKWfYinC5KXn5ifXDiRBglI12PFm5RAWDOorq8OhXKSpXG4MwdCiPe9DpMRaeUx6wGv
         MLbl8cQDUA0VdXJkmz430YAUL3qWHNuA/DHlC+NZO3orksqRqI/XI/BthpZROQF1I85T
         Q3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264205; x=1716869005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYO5X0diZdV5MQxI/s9TBFrpTwF5UWPwxcd05AKrshs=;
        b=dKdEURv2jD0rdRAGcJquUyWM/m4AZpfRvJLYWtYVGR/cT57g/JBlyhzf6qm/3MCKqZ
         wiUZOHVm1+FiyZotNvn5MirPgiSQGL6yLkTdeKxx/RfaPLBS4DIbxn55pgsUKOys5DDa
         Dv8GBUwBXTKo+kVlQOtel+6hQc7qGwRphXO7qdLW28lkyk+sTS5vTc2KdUOKVMPaN4nu
         jAZwa0Dvg55h3vQuTN2eJ3Atd3n1lmg7875mtEVEniX7F9AJ6rCl0IKtmdJ0Ud9asRNt
         ZLzFI3hq1IfdRx+YLvMyKbH4c4KuCtlJnXaHC8dCD/X7LpRIx1AGlKthlVeU83z41lxY
         xTfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNcQI9++e1AOjMslii/8eXMy8Lyos3kCBnE4nFQSW4W7v6F2gnJZ4wMxZp7ayU24kBH3t7q8mTrJDtABkUknqEeaFBfhX5Kfl12GX1
X-Gm-Message-State: AOJu0Yw3TFk4gqyLkx7B+RJ/qYbZEPG9bWT1H3LowXeS/1qdr+YeV28o
	+aI+ob4zCapnJumALf25bH+3JpUcrana+PFSTYQ+LL2kvJqM5Syv
X-Google-Smtp-Source: AGHT+IFHWJ8Khw4UYbDOUMggQ1QP0WPVAp1DDDpri8gSJPT7ekQdp3hNnE42q4+S2/k3OBjhL7AVhw==
X-Received: by 2002:a05:6a21:1509:b0:1b1:c77f:56c3 with SMTP id adf61e73a8af0-1b1c77f59a0mr12895842637.7.1716264204618;
        Mon, 20 May 2024 21:03:24 -0700 (PDT)
Received: from LancedeMBP.lan.lan ([2403:2c80:6::302d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62bfsm211683945ad.74.2024.05.20.21.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 21:03:24 -0700 (PDT)
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
Subject: [PATCH v6 1/3] mm/rmap: remove duplicated exit code in pagewalk loop
Date: Tue, 21 May 2024 12:02:42 +0800
Message-Id: <20240521040244.48760-2-ioworker0@gmail.com>
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

Introduce the labels walk_done and walk_done_err as exit points to
eliminate duplicated exit code in the pagewalk loop.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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


