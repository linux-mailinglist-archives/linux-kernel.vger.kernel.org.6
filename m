Return-Path: <linux-kernel+bounces-314578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5E396B554
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C9C4B242B5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 08:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981E1D096F;
	Wed,  4 Sep 2024 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U1BlvZVS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316E1CE710
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439331; cv=none; b=pHTWkTbhoQ6dNT5KphyMBw4xzo68ZML/Zm+DJhQU/jTuKaS2iRLrFjpaJdQWgdk/YrTvOLAvkM0MGKFYYY5UaCeMot6Ku09balzlfqevoxl/G+l9SDVcjR0YQRtm52dHGn0aYXwtme3cTKoWD2BIvNd7JVkJqrN5r6sB7hrPFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439331; c=relaxed/simple;
	bh=pGvXpoizu5EfkA5gqHIohJBgIdkJzD8TMccCB9Mq6Lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJaj5hlG6bN3Z/sV4PSIwGIZ8eX5nqCYPv7/dVIM/tYPrIkxoMsvqXzfR90SzNTMgPDlEfG8WE7LpX3w43vSojwyEoLOiSfFzzOcTHbMBwjVtKwQ4eQD+0pVr33esSBnWJLudSNCDOoZj4mk0xmeX/bO1Pa4Mudxsb0Nk2b+mSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U1BlvZVS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20573eb852aso3457815ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1725439330; x=1726044130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUS6V5hps9BhpBteFi/blbp/e+0aHtnhPyo5Zqj4Bag=;
        b=U1BlvZVS/ML764yO6TEsEJUdiRVInumsAABGCI7c9jw6TsXni8U5Kx/g5Y6tHRlFj/
         9FI8V4rEQdXZ0QBQ2tNNMtww9wJtRIlZQUhZfiG1eHHcAvnLWTNG1c6VMbxVv45Xj3cL
         aacZ0OKi6uG8gXq0TDdaTDGqv73/15ULx9w8h9xHx0VvT3S3bt5fTAt5cVbI5zALy9Tg
         aw2ihQ7CfHkujw5qv/k5Xw2/sd2/cmmA7+9bk18kqIlIq2CfXJ9wLl3+ZMdoDy3s3Ob1
         lXO30JutAs4Bu4CFg0mLhvjGTQEXeh3EFq79F9lwzg9lUIOAWr8M5oq2fUszaC3wXfTK
         UZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439330; x=1726044130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUS6V5hps9BhpBteFi/blbp/e+0aHtnhPyo5Zqj4Bag=;
        b=oBls/dIjhBGBP8H3wAJkvhBPQudnZtwvFTsoflJJH8gVnX5WieY2vvQNTZatHbHqFC
         R7A4smuhNLLIckgjkNv61aEydX/cjBWdIoNVfJX2QYh1H+zvfPHziMTrw7i9LVLxr+wf
         L2IuKCu0F3tLUZbL+UI4G8qkX2MkpHOTYJWslZYGdGe3muL7xlZKU28DpJIfd5tBcpIX
         aWP67yURs2kstdAGYb6bsifEh+h2PmHaAdZB4WLYD9FnbXaaYy6zCQCCxHa6kPw6r+Sg
         WCECnGlVIS3o7Pwj3GjMtYKwcumxpcmex51oCHbexTGS9o3/3v1iAo/F4uDEu6RAyizF
         RsiA==
X-Gm-Message-State: AOJu0YwYKykeRGILe7sKJSCfJsUpt1xVjn019EwAe4J2xNq+wngkd9qY
	IMqtPjwm/S4dlpCQhyhsXkFMGZHpi3NPkyCJDfhF3M+xQl1eIl/2XHTLEgo1Cyw=
X-Google-Smtp-Source: AGHT+IHV13v46mfi8eJv03VSK3v4h4kaXbg2iDfLcHBwpuweJiwY6TIZiDRC9qw17xCxMuqJ20qctg==
X-Received: by 2002:a17:902:ecc9:b0:1fb:7654:4a40 with SMTP id d9443c01a7336-206b833e006mr24427095ad.14.1725439329649;
        Wed, 04 Sep 2024 01:42:09 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae95a51csm9414045ad.117.2024.09.04.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:42:09 -0700 (PDT)
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
	ryan.roberts@arm.com,
	christophe.leroy2@cs-soprasteria.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 13/14] mm: pgtable: remove pte_offset_map_nolock()
Date: Wed,  4 Sep 2024 16:40:21 +0800
Message-Id: <20240904084022.32728-14-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
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
index 08d0e706a32db..581446d4a4eba 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -16,9 +16,6 @@ There are helpers to lock/unlock a table and other accessor functions:
  - pte_offset_map_lock()
 	maps PTE and takes PTE table lock, returns pointer to PTE with
 	pointer to its PTE table lock, or returns NULL if no PTE table;
- - pte_offset_map_nolock()
-	maps PTE, returns pointer to PTE with pointer to its PTE table
-	lock (not taken), or returns NULL if no PTE table;
  - pte_offset_map_ro_nolock()
 	maps PTE, returns pointer to PTE with pointer to its PTE table
 	lock (not taken), or returns NULL if no PTE table;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1fde9242231c9..5b5a774902bd6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3004,8 +3004,6 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 262b7065a5a2e..c68aa655b7872 100644
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
 pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp)
 {
@@ -374,15 +362,6 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
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
  * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
  * but when successful, it also outputs a pointer to the spinlock in ptlp - as
  * pte_offset_map_lock() does, but in this case without locking it.  This helps
-- 
2.20.1


