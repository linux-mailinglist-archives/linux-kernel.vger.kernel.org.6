Return-Path: <linux-kernel+bounces-295119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5B79596FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9C09283B62
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52681CB153;
	Wed, 21 Aug 2024 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WLYzURG+"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414E1CB14C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228456; cv=none; b=AfDMi9lbhxR3ftKHhHS4w8jj6uV7pTPHj8CUS1/yxoslBLla40CQb9kFGDt46hBe6Ri1z8VXDdkdH9ASJv8CYxScK10gY1zIhk83p5Z3tkdBFtY8mMgAo7H4O3p+DtpXdig464eBHHJanypxz57mwKsNokyBKJdqsOgUxBtYQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228456; c=relaxed/simple;
	bh=CfjhG+zBfgBTHbDX5rndwLBFWLKwheXgYDb9hI3tnlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eYCED+gyNkTrwuqDLf/3fUZOosYly0fwFUWOpf8cLanD+COngiAQB+pYyAoH4LCRTMW2hmLBobVD9ANdrRm7tt/WRVFbCjKNxQnrTkNd/e3rm8zzSc3AvMhQVT+an/QvS8ESt8JBwYL1pVg6egcg3Tk0iOs0UoFxw18LzAv/22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WLYzURG+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so3875136a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228455; x=1724833255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FpkIwk88smkdA0CmKwnRaaffLUYg3/8r+GLLHrp0y28=;
        b=WLYzURG+sGHUmP+vlsBG8pccYIjUPOfMq3Vj++fCmYrlb7drXFOZ6L3qQsE0nQ5Fbq
         xW5SWudCVc2AacP2ndziK9FWhbJ7MYOlSd1zMXQIEFRfmTKw/RSP3TlJxl4ULrDZLMf/
         GGChNvKcF4MVLh4QFAAZbnmm1LgWbS7hN0TBRKmGWiBf5Cq7LWXMy8ce8cPtKuuLbMFJ
         GclYyqMveE0+CKrUS83nskEpCYoQB+ZeqGg5kqqu8GfKm0jRerxBot2gSEF3enLR8iPD
         FhlIy82ALDRntOUFxS4MifL5obVOVPmkOeNMoThndE97/FqQxUqub1zPZIDruo79/Mje
         7eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228455; x=1724833255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpkIwk88smkdA0CmKwnRaaffLUYg3/8r+GLLHrp0y28=;
        b=q7ZY59z1GM14wPAKB4vxIiH04fZRGW7zbJ6jIgf3gpNG8QSLghfRo9rCkJFOykNh4o
         3uY/oUdgxZm40vgksfCkayv7/YuR4IaO+VbQ0E7vkMMHHnn2kFgXrjnPM9kL8ZZQoZD+
         2xC9shC3d9Ew8DW9RpnwkI8KwzvM92d8/6VD0kdO6PtwoEJy+coGmMqS7CPwBlBAS1tN
         Ghd6KlPInfsob7lZ14KLwttp0kIDc0wK7aBcvHq1khnN7zW5SpdrpaUFaEAboGXxqI7a
         QY9k/NW5QzqP4Jw3XlkQ4rGf1KKFRm8vhDyVhctwxcnsUbkAVqqE2cRPh3zvdGZsEuuX
         Gs2Q==
X-Gm-Message-State: AOJu0YxGPRWs/wX2poZ2xlMT8riYV6rRyIQEHVs+1994B6c2c6WLTdvU
	AooASh0TNSIlT3ymZEI4kovntEJBJhYOMwwgavZHaHkZGs+NpIgbvwMEM8GiMck=
X-Google-Smtp-Source: AGHT+IGrVkekNFESU70hIpUuBMPasbPeBaSvK0LFz7NLCJlpTpTqHUrWHKc0kKTsT//aSMihe2hbaA==
X-Received: by 2002:a05:6a20:ce47:b0:1c4:a49b:403 with SMTP id adf61e73a8af0-1cad81a4248mr2186429637.46.1724228454750;
        Wed, 21 Aug 2024 01:20:54 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:20:54 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	vishal.moola@gmail.com,
	peterx@redhat.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 13/14] mm: pgtable: remove pte_offset_map_nolock()
Date: Wed, 21 Aug 2024 16:18:56 +0800
Message-Id: <129f11e3434c5af898096c1cf3fe378f50bc94b3.1724226076.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724226076.git.zhengqi.arch@bytedance.com>
References: <cover.1724226076.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now no users are using the pte_offset_map_nolock(), remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/mm/split_page_table_lock.rst |  3 ---
 include/linux/mm.h                         |  2 --
 mm/pgtable-generic.c                       | 21 ---------------------
 3 files changed, 26 deletions(-)

diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index f54f717ae8bdf..596b425fb28e6 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -16,9 +16,6 @@ There are helpers to lock/unlock a table and other accessor functions:
  - pte_offset_map_lock()
 	maps PTE and takes PTE table lock, returns pointer to PTE with
 	pointer to its PTE table lock, or returns NULL if no PTE table;
- - pte_offset_map_nolock()
-	maps PTE, returns pointer to PTE with pointer to its PTE table
-	lock (not taken), or returns NULL if no PTE table;
  - pte_offset_map_readonly_nolock()
 	maps PTE, returns pointer to PTE with pointer to its PTE table
 	lock (not taken), or returns NULL if no PTE table;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1fe0ceabcaf39..f7c207c3ab701 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2952,8 +2952,6 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_readonly_nolock(struct mm_struct *mm, pmd_t *pmd,
 				      unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_maywrite_nolock(struct mm_struct *mm, pmd_t *pmd,
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 29d1fd6fd2963..9ba2e423bdb41 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -305,18 +305,6 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 	return NULL;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
-			     unsigned long addr, spinlock_t **ptlp)
-{
-	pmd_t pmdval;
-	pte_t *pte;
-
-	pte = __pte_offset_map(pmd, addr, &pmdval);
-	if (likely(pte))
-		*ptlp = pte_lockptr(mm, &pmdval);
-	return pte;
-}
-
 pte_t *pte_offset_map_readonly_nolock(struct mm_struct *mm, pmd_t *pmd,
 				      unsigned long addr, spinlock_t **ptlp)
 {
@@ -374,15 +362,6 @@ pte_t *pte_offset_map_maywrite_nolock(struct mm_struct *mm, pmd_t *pmd,
  * and disconnected table.  Until pte_unmap(pte) unmaps and rcu_read_unlock()s
  * afterwards.
  *
- * pte_offset_map_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
- * but when successful, it also outputs a pointer to the spinlock in ptlp - as
- * pte_offset_map_lock() does, but in this case without locking it.  This helps
- * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that time
- * act on a changed *pmd: pte_offset_map_nolock() provides the correct spinlock
- * pointer for the page table that it returns.  In principle, the caller should
- * recheck *pmd once the lock is taken; in practice, no callsite needs that -
- * either the mmap_lock for write, or pte_same() check on contents, is enough.
- *
  * pte_offset_map_readonly_nolock(mm, pmd, addr, ptlp), above, is like
  * pte_offset_map(); but when successful, it also outputs a pointer to the
  * spinlock in ptlp - as pte_offset_map_lock() does, but in this case without
-- 
2.20.1


