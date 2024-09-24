Return-Path: <linux-kernel+bounces-336580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01288983CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769421F230DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB70B5FEE4;
	Tue, 24 Sep 2024 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gn+5kId8"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A142A8F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158237; cv=none; b=sJYbN4Cde2eWor4suFhC39pOoWOSPg1lRW3P864c5Rgt2BnOYfcZzFxIpKX/xWNN+DCMvPkyCVFXDe6juuOCTQxAgPnqLn0+6Ha9ABTnTuaA5bO6fQuvsDWOa1vMRJ5Q7KY4IPlx/FRdcmqiyzryzSSyrMxdSSmuKYXh3jwunTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158237; c=relaxed/simple;
	bh=ZbaeWw3Cvpk7pq6FuZm+ealD8Sv3/4DHQMcnViX1FcU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/2lJoF9RERihrcoHdXv6EV0Cv6IWc2VWAiuLt4CAPlV7cFjaAisfgHdS4k/8FsS4Qw4rmnKyqy7EcbqAm1+O9R2sMwRj33I2xSKXIkib2RBfNX/+WEGMx3QY7icTtIk7IsHiPBxUWSN7yUJCExK1lzyb5Y2VhwyYuQHs4tfXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gn+5kId8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2057c6c57b5so30983215ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158234; x=1727763034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFV2Gg1HPn9r0uTPIEIMJioMCNlgr9zWJ7S9CBl14ro=;
        b=gn+5kId81ccBpHvWdF97g6P4FqzaOivDPrrQTDybkP8N12qzRJxR8ldChPpOVXLT0Z
         d+GGLXYnknKm3K0QG5jPY6M9PkYVLJj45LW7WVlKnfnME0AhqZocvDwRVn0rOfE2LjP6
         FjIkvrVoN7T8NvUdGRgTM5fRuHSS+UHcIC+e7Crh1gut3VIzF+nHNreSvZZixBd++cSX
         KRFR2HEpXuQ56UnT5Vx7slr7JVYHi6iUQemD1lzMGUcQAxUaIs85s+GmBDJ+v/W93tJs
         8NgtK13umGb7M8v1f9vKzsEpZQ8uqUlc9NEtkqUpsc4bRUOtrrZ2EDKgDfLwvhzaoU2B
         Gq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158234; x=1727763034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wFV2Gg1HPn9r0uTPIEIMJioMCNlgr9zWJ7S9CBl14ro=;
        b=imXHp+dfdEz8b+VBJH1HFgm7UmTSGJ9BmQhtpgKqeZsgZu9tSYUjOlIWUt/DXEPs1B
         0HSCL8W+QpLLxZAchj30mvbk1VlXzymeHwb3KHDsag3XHCs5lJDmxHB2NPtr0JHL0gg3
         +rf27unlc/ZnhGwQdJWm5ixCDxAvUNaH+pmoHuvbPjjlB39ti0Cfd9KPZ6ff0hOPQk3X
         0XA67wBLgB0mEFj/GfafqKpiANl7okfIjk7dZ77zpDNQ0kYNYe+uDLQs4ilwuHtl5A8T
         jV0cOOuXnycjTmc6FmgBGBpaxk7Wa2HuzV6Jzo8B7MSww5LT8Ppo/zLJtmCHWdvKe6uJ
         9/lA==
X-Gm-Message-State: AOJu0Yyb9M2077hjA0OyqvQRExBIPg7Q7+hZBpfWASUkAPBY200fEirb
	zix9PLo1K+0pokX9jrmc0hR0gVFZm0KNcNjVVPppnSYcDXQvxKk9k3fv8nicz9I=
X-Google-Smtp-Source: AGHT+IFurxEbSfxWnkgUvSmQpfQ7iOb3of4fLdIGxM8iu8OEamvgIzhTlXEYzcUx/o7HLvoMu2wctg==
X-Received: by 2002:a17:902:ce8c:b0:207:6d2:1aa5 with SMTP id d9443c01a7336-20aed0b299cmr27872445ad.13.1727158234439;
        Mon, 23 Sep 2024 23:10:34 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:10:33 -0700 (PDT)
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
Subject: [PATCH v4 01/13] mm: pgtable: introduce pte_offset_map_{ro|rw}_nolock()
Date: Tue, 24 Sep 2024 14:09:53 +0800
Message-Id: <1a4fea06f8cada72553a8d8992a92e9c09f2c9d4.1727148662.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727148662.git.zhengqi.arch@bytedance.com>
References: <cover.1727148662.git.zhengqi.arch@bytedance.com>
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
pmdval when successful. It is applicable for may-write cases where any
modification operations to the page table may happen after the
corresponding spinlock is held afterwards. But the users should make sure
the page table is stable like checking pte_same() or checking pmd_same()
by using the output pmdval before performing the write operations.

Note: "RO" / "RW" expresses the intended semantics, not that the *kmap*
will be read-only/read-write protected.

Subsequent commits will convert pte_offset_map_nolock() into the above
two functions one by one, and finally completely delete it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/mm/split_page_table_lock.rst |  7 +++
 include/linux/mm.h                         |  5 +++
 mm/pgtable-generic.c                       | 50 ++++++++++++++++++++++
 3 files changed, 62 insertions(+)

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
index 546a9406859ad..9a4550cd830c9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3017,6 +3017,11 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 
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
index a78a4adf711ac..262b7065a5a2e 100644
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
@@ -356,6 +383,29 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
  * recheck *pmd once the lock is taken; in practice, no callsite needs that -
  * either the mmap_lock for write, or pte_same() check on contents, is enough.
  *
+ * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like pte_offset_map();
+ * but when successful, it also outputs a pointer to the spinlock in ptlp - as
+ * pte_offset_map_lock() does, but in this case without locking it.  This helps
+ * the caller to avoid a later pte_lockptr(mm, *pmd), which might by that time
+ * act on a changed *pmd: pte_offset_map_ro_nolock() provides the correct spinlock
+ * pointer for the page table that it returns. Even after grabbing the spinlock,
+ * we might be looking either at a page table that is still mapped or one that
+ * was unmapped and is about to get freed. But for R/O access this is sufficient.
+ * So it is only applicable for read-only cases where any modification operations
+ * to the page table are not allowed even if the corresponding spinlock is held
+ * afterwards.
+ *
+ * pte_offset_map_rw_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
+ * pte_offset_map_ro_nolock(); but when successful, it also outputs the pdmval.
+ * It is applicable for may-write cases where any modification operations to the
+ * page table may happen after the corresponding spinlock is held afterwards.
+ * But the users should make sure the page table is stable like checking pte_same()
+ * or checking pmd_same() by using the output pmdval before performing the write
+ * operations.
+ *
+ * Note: "RO" / "RW" expresses the intended semantics, not that the *kmap* will
+ * be read-only/read-write protected.
+ *
  * Note that free_pgtables(), used after unmapping detached vmas, or when
  * exiting the whole mm, does not take page table lock before freeing a page
  * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
-- 
2.20.1


