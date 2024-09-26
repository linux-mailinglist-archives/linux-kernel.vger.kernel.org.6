Return-Path: <linux-kernel+bounces-339965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C1986CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC41EB209BF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A7718952E;
	Thu, 26 Sep 2024 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NNkKpxYo"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B76224D6
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333218; cv=none; b=fyAUX9Ltu5ZCjEZK1SAuvfJfb4O93eXr01O9558ilMpoyBFjW58Je5o8z38tqW4zOE0sfbohJ/cTnDd+tnNXSi+8ElDoC5T7Du98XNYxyMARXyIwDSEOQt56p7uce98FklUHOS9DFSzUNhIJ6Bek1cqCisVu4S/hdCUg9jx7+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333218; c=relaxed/simple;
	bh=BaPXwB7UqH53ZIAmolBim0wq4X5L/EYzHYfb/hyU8GE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6mCsrYl5pdhhIEwNbdxBMiibdX5HD+wXjSUc6CZeX5m3GTFfIiGop1c9YAg/z/fMFdGOSnyexyv1zpnm1NEhwFWKgMgiHY+PzmXnN1hiiuMxBfqVQ+hUsJVly4fNjPkZTnttA9+CKc7fkI7+HeRAT0CBQ4zNLnMUuERIYQ49rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NNkKpxYo; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a9ac0092d9so66625685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333216; x=1727938016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEMasL/thV9Tj1Tfta4uIol3BYRuzPr3NckO1OF+52k=;
        b=NNkKpxYo7407DlqqocTygZh1oqeiubN/3l0lv4nc647FeYnv3taUT6ev0nmd2ANbC4
         HQWxYDIspYWUgwI8ktcR9HlsCROV/joheXNQohkrUtPR4acUEVhMpKvOzVNRdVN4BA9a
         sWNmdb1z2lnu7gS8nhGQSb7NNCsT/8TjHvoEVtJnYjmCBCPp6/JX726cDgAYmUfKR0xQ
         7RQwHpRvq8K70OGnyQRjuyi0vlHgmrcyZjZcuPN1nAkMCR0ymqL9o3pWvqhsqVzlxapi
         GJOAX+jbBwRAcdctQHzOAaLTevVp6n/OqKjQlkInmYw/qNcS9pfA81jp5dJ3dKlChCw8
         EX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333216; x=1727938016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEMasL/thV9Tj1Tfta4uIol3BYRuzPr3NckO1OF+52k=;
        b=vKMRv6llCCEuwvGeXNMKJFc0LdNsbvHcDerwsgqCVloo5FJB3hnsjwUAO7+UGbmX0f
         H88fgAxmtrkw99FTaqmMMPySWr7CWCm0hn5mS6/fp6ASJRl3/g98L4GkVXXsgUzJf4zy
         IaFLFqkh9P52pfZqGGHTTj1URghUXqw9D2uYztf+iT7BPX0GvSYp7lrik8ZyOqPVjg1/
         L64efhj8v9vuPHVQnVl8ekhvuD1qsOHSwSCRgNPqNr93GFzbHOUWtQkRC5jgPzYw32R8
         bV5gszY1l7W6A9yaDS1vebL3NcomdgMz+Bl+OLdsxp8/hml0u6P4DJehZQXFhI3376Bp
         P4hg==
X-Gm-Message-State: AOJu0YzXbcncLFjO1TemyuqcnZMkyIBK3R3C19Uypoo/VowslGZVq9CC
	+FQpU8JMhK80+gjkC5EwfmZ8JCx3BJCfhuo8TosyM7Sf2+Q9wjRBykD82W6C1Ic=
X-Google-Smtp-Source: AGHT+IFdBHDg/pcI8fYkiDBKrKz5/bcsNyjF/Vh4ia+kT/ICQCu69/2acL+Eh3ZQbIhYSZdsv978Jw==
X-Received: by 2002:a05:622a:20b:b0:458:4b6b:ff16 with SMTP id d75a77b69052e-45b5def4888mr86143491cf.32.1727333215740;
        Wed, 25 Sep 2024 23:46:55 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:46:55 -0700 (PDT)
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
Subject: [PATCH v5 01/13] mm: pgtable: introduce pte_offset_map_{ro|rw}_nolock()
Date: Thu, 26 Sep 2024 14:46:14 +0800
Message-Id: <5aeecfa131600a454b1f3a038a1a54282ca3b856.1727332572.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1727332572.git.zhengqi.arch@bytedance.com>
References: <cover.1727332572.git.zhengqi.arch@bytedance.com>
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
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/split_page_table_lock.rst |  7 ++++
 include/linux/mm.h                         |  5 +++
 mm/pgtable-generic.c                       | 48 ++++++++++++++++++++++
 3 files changed, 60 insertions(+)

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
index e9077ab169723..46828b9a74f2c 100644
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
index a78a4adf711ac..daa08b91ab6b2 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -317,6 +317,31 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
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
+	pte_t *pte;
+
+	VM_WARN_ON_ONCE(!pmdvalp);
+	pte = __pte_offset_map(pmd, addr, pmdvalp);
+	if (likely(pte))
+		*ptlp = pte_lockptr(mm, pmdvalp);
+	return pte;
+}
+
 /*
  * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal implementation
  * __pte_offset_map_lock() below, is usually called with the pmd pointer for
@@ -356,6 +381,29 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
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


