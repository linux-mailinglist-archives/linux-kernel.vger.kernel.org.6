Return-Path: <linux-kernel+bounces-300707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AAA95E76D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 05:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0441C20E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 03:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF902A1D8;
	Mon, 26 Aug 2024 03:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PzJ62BWz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639A21FA5
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724643954; cv=none; b=RVFyLvPVEWsEsuNE8u4WmORe0odMh64tREmeu7kjqZAKMC88Qp61RanaoaVPgBz5ELy0OpsSsiWjaIuGjv737zsLWaB4ZDUgLKrtufzEpJl6aosABz6ujjxN5l2RCOezQG3FFHtH4rLXLOLYauJ37dmNFJ7dcq23ONCG8xWa7nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724643954; c=relaxed/simple;
	bh=M9XWxvAXe9Y9VlNoNxPVfKIIAp2h5vrt/nQ9Kj/R3IA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGkgpdYZl9wkSjjGGDizEQSSoUCuXPGc9Cy6wfegqNKvAkPw7mnEYQ8/beV1F5drbjQ7v0vGg4KHeHiiWf5c9GKCvaauVgGjVHw2yce13UBnGz7Gl+mw3JRzeh1XZ6DnRmG9nvQVSNu+wCkgiq1xfGDwFCq/P3Q0NyFBQRNHBsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PzJ62BWz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201f2b7fe0dso32532095ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 20:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724643951; x=1725248751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvWOwClfiaH1DttbH7BPu8W++zXReNa1Df7Gb//N78M=;
        b=PzJ62BWzghe4X6G1/OQYS79j6qwLJ7OFCI/hNI4vv8B6/82TYtFz5V8iNIZ7ThW2gC
         dXAClddzOQ1WFs38kQKbxUfLvrC8VM0wTs6qLWqIj8GXtAg5Y4O5YHzom6t7mKSb1H0h
         AWUiycjaIm6vISmp6mVptDnIFG9chXpodUball0uRTdaURGPQaRWb5VIocTZsi5JButX
         pY5dHdN7b1QcMNjDk7/a3bVEwkqgHaAKnFPdMgOhJW3Kvxw9TvxEfFsHFrI8wc3sgdIs
         ZVuSqo5/yMQHTLAy02nplK39krtLeuqRXy0qfxps14eWUkj7RzeI6w2MTFfWRNdNEPMx
         8Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724643951; x=1725248751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvWOwClfiaH1DttbH7BPu8W++zXReNa1Df7Gb//N78M=;
        b=DMyX1ZeJ0zzEfR3ovPE9Acf5ZwXbWk5XQCo0cuaBtGx8lbliEE2riOjqd2lm7rSLqV
         +KqsY0iP5rTEHnss2lxkqNT69I9YphjUeLKkmS6GdVtI+63VBPeFET7NfnBakDQygwo+
         urkCJj5nJVWKJVQHTFp+gQQsObMqssvuA7eXBmLRlfn0gVa8GAYI3sRhFlXsbjr/mbhU
         C8uLPoxP41I1af+vk8zhkq/2exbUohQ/gtw4jZawQnOg1eHzPITOKcGfcD3tDQZ0DaVd
         iq8pUd22ul5V8fJf/rZHYQ3UJT/Zw3V+RIJvntXNWA8UgpldwqibaUdoSW4IKz0bwxb3
         cdcg==
X-Gm-Message-State: AOJu0Yzp/Z6GTgliQR7pUZjA1mDBTmPk+gmuaLX0DjN+Rk35dlZqEQcX
	FlFJ1GSqkyNkZEiu+hcZRzY3/rolCEcRY2ESN9BM49GG5e2+FRWzq68T/0rfi9BBBL5ce1byHKm
	d
X-Google-Smtp-Source: AGHT+IGAkZ33RhQT3ptanHl7KQvF7KkwrtMZ12R2MHtdXUQfC4ypCCwefP5BwgNzFzSw2mbOlGcnOw==
X-Received: by 2002:a17:903:2301:b0:1fb:2bed:6418 with SMTP id d9443c01a7336-2039e515956mr105951845ad.57.1724643951510;
        Sun, 25 Aug 2024 20:45:51 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385566479sm59745285ad.58.2024.08.25.20.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 20:45:51 -0700 (PDT)
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 01/14 update] mm: pgtable: introduce pte_offset_map_{ro|rw}_nolock()
Date: Mon, 26 Aug 2024 11:45:12 +0800
Message-Id: <20240826034512.76917-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
References: <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the usage of pte_offset_map_nolock() can be divided into the
following two cases:

1) After acquiring PTL, only read-only operations are performed on the PTE
   page. In this case, the RCU lock in pte_offset_map_nolock() will ensure
   that the PTE page will not be freed, and there is no need to worry
   about whether the pmd entry is modified.

2) After acquiring PTL, the pte or pmd entries may be modified. At this
   time, we need to ensure that the pmd entry has not been modified
   concurrently.

To more clearing distinguish between these two cases, this commit
introduces two new helper functions to replace pte_offset_map_nolock().
For 1), just rename it to pte_offset_map_ro_nolock(). For 2), in addition
to changing the name to pte_offset_map_rw_nolock(), it also outputs the
pmdval when successful. This can help the caller recheck *pmd once the PTL
is taken. In some cases, that is, either the mmap_lock for write, or
pte_same() check on contents, is also enough to ensure that the pmd entry
is stable. But in order to prevent the interface from being abused, we
choose to pass in a dummy local variable instead of NULL.

Subsequent commits will convert pte_offset_map_nolock() into the above
two functions one by one, and finally completely delete it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
Change to use VM_WARN_ON_ONCE() instead of BUG_ON(). (David Hildenbrand)

 Documentation/mm/split_page_table_lock.rst |  7 ++++
 include/linux/mm.h                         |  5 +++
 mm/pgtable-generic.c                       | 43 ++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index e4f6972eb6c04..08d0e706a32db 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -19,6 +19,13 @@ There are helpers to lock/unlock a table and other accessor functions:
  - pte_offset_map_nolock()
 	maps PTE, returns pointer to PTE with pointer to its PTE table
 	lock (not taken), or returns NULL if no PTE table;
+ - pte_offset_map_ro_nolock()
+	maps PTE, returns pointer to PTE with pointer to its PTE table
+	lock (not taken), or returns NULL if no PTE table;
+ - pte_offset_map_rw_nolock()
+	maps PTE, returns pointer to PTE with pointer to its PTE table
+	lock (not taken) and the value of its pmd entry, or returns NULL
+	if no PTE table;
  - pte_offset_map()
 	maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
  - pte_unmap()
diff --git a/include/linux/mm.h b/include/linux/mm.h
index da29b066495d6..a00cb35ce065f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2954,6 +2954,11 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 
 pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 			unsigned long addr, spinlock_t **ptlp);
+pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, spinlock_t **ptlp);
+pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, pmd_t *pmdvalp,
+				spinlock_t **ptlp);
 
 #define pte_unmap_unlock(pte, ptl)	do {		\
 	spin_unlock(ptl);				\
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711ac..7abcea4451a71 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -317,6 +317,33 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
+pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, spinlock_t **ptlp)
+{
+	pmd_t pmdval;
+	pte_t *pte;
+
+	pte = __pte_offset_map(pmd, addr, &pmdval);
+	if (likely(pte))
+		*ptlp = pte_lockptr(mm, &pmdval);
+	return pte;
+}
+
+pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
+				unsigned long addr, pmd_t *pmdvalp,
+				spinlock_t **ptlp)
+{
+	pmd_t pmdval;
+	pte_t *pte;
+
+	VM_WARN_ON_ONCE(!pmdvalp);
+	pte = __pte_offset_map(pmd, addr, &pmdval);
+	if (likely(pte))
+		*ptlp = pte_lockptr(mm, &pmdval);
+	*pmdvalp = pmdval;
+	return pte;
+}
+
 /*
  * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal implementation
  * __pte_offset_map_lock() below, is usually called with the pmd pointer for
@@ -356,6 +383,22 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
  * recheck *pmd once the lock is taken; in practice, no callsite needs that -
  * either the mmap_lock for write, or pte_same() check on contents, is enough.
  *
+ * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
+ * pte_offset_map(); but when successful, it also outputs a pointer to the
+ * spinlock in ptlp - as pte_offset_map_lock() does, but in this case without
+ * locking it.  This helps the caller to avoid a later pte_lockptr(mm, *pmd),
+ * which might by that time act on a changed *pmd: pte_offset_map_ro_nolock()
+ * provides the correct spinlock pointer for the page table that it returns.
+ * For readonly case, the caller does not need to recheck *pmd after the lock is
+ * taken, because the RCU lock will ensure that the PTE page will not be freed.
+ *
+ * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
+ * pte_offset_map_ro_nolock(); but when successful, it also outputs the
+ * pdmval. For cases where pte or pmd entries may be modified, that is, maywrite
+ * case, this can help the caller recheck *pmd once the lock is taken. In some
+ * cases, that is, either the mmap_lock for write, or pte_same() check on
+ * contents, is also enough to ensure that the pmd entry is stable.
+ *
  * Note that free_pgtables(), used after unmapping detached vmas, or when
  * exiting the whole mm, does not take page table lock before freeing a page
  * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
-- 
2.20.1


