Return-Path: <linux-kernel+bounces-295105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE519596DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C3CB2267D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315FE199945;
	Wed, 21 Aug 2024 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="V9d7gzZf"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24A01898E1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228375; cv=none; b=fe46k2n/EPyQAb7G4dCvMp3LTrZDam6+wXfGM/K4hxZMbYbJFhCcc3yVe6K9MoHfB0EMH/5Jbzbv36OkO2vwzfizWZDtQfgtw1O4jYUlr7K/8KJ+4wghlERvgv947CQRttPOJ25SpsvrzNA/FR3gWY7m78yJfIfCnh1CyOEMKgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228375; c=relaxed/simple;
	bh=wK8isjDAuZDQnKwQW3LujcJ9UW8AZ4wxQ3aOMNHx6L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z1AxDLds0z7JNAq8R3iMTRHh1yrXbnem0ah3Ne4RWgzUOX+N+KUxMqL0zxbD5N7gHIiPlPrEwmzMMir6iOn/3Jniqzy7yRdd60MgpKyjbTrUiWgJjvRq0aDMZd/HKgq8I+vTBe6I402GECN7mWZ4x6t2GtxHnWbMGK8e38gt2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=V9d7gzZf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7141feed424so768679b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724228373; x=1724833173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgE/WG98IUTB5tF1fVgrlRXpW1wPHqZ1M9xizEuPG+g=;
        b=V9d7gzZfi6A/NiEM/iqvqeFJeb3U7LVXAmyCZ+rsra5sVbWlKETATeUGA2j5Qg3AL3
         LdnuOlthkQZZeC9sA1C4Oxj34YdASM98y8aurT9N132imv0ZrPFJuXGGryjCqdLgAijv
         5p5sPuDZqa+sfm/LdJcFQiN1bxq+NqcAR+NqIsszFxiqmhsnjK0mhy0x1neijpQMTQl3
         I3LOHd66ViJvy9XQuB0kUjfsSk5kuDr31CU8LGlp23citaV4Zw5E0SWRQV8HIlwfKg+D
         EVI8mSoMtub0wRiRGm1WN3wn+RlsUGJSS4kfm3LJfwR5EKrDDG9SU9X5EUeZky1NbgiM
         bfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724228373; x=1724833173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgE/WG98IUTB5tF1fVgrlRXpW1wPHqZ1M9xizEuPG+g=;
        b=E6nDyYgawVZWn7/z1uHWQZMNMmMU8BSeTuaRGzLh5FLVYEmoMUadX0nMPT85mAKR1s
         HhRBic05k85VRsOoxnB7R4DDSjr5mvcM7d8bgkQmQnQ6dOoW2TyvRyNLCZKMrHcrlsBT
         /blINbuY6CVsHjm6YnOY0CoaAoZNsShhNaqGLz0juO/sLo40e7gCsbLEBesconp3pTjj
         UBPqUZOhOwVuO8RjQbfk+5whCWwbQtFIQ0XN9Z1eA2PlmhKtHYZFWwGtKxWEQk7FQIz9
         nRHF8x1BvlgvvW8xO67uO3kBWcI9xH8I+iwMyW9v3+H/JcaYGk+fwYu28gxLt0cpJPhf
         BZfA==
X-Gm-Message-State: AOJu0YwX6D0KnRrhRRGJ5oAFp6ZOinDxCtrAqk6ogJxRr1eRbwVa3Ojq
	tdBtxrP6S9cHn7ke7Xs1qFY2HmA7c5ZLzbCX8hodT4IlStxXBSiD8r5JdhBuJDA=
X-Google-Smtp-Source: AGHT+IF11KqU9EwWDBxqOuV+x8Or0DtjlDyZMn8HSaNUPAUvyVetfGjOkbkYFHx43yYUuJqRZJ73CA==
X-Received: by 2002:a05:6a21:2986:b0:1c0:e49a:6900 with SMTP id adf61e73a8af0-1cad80ef085mr1849540637.7.1724228372801;
        Wed, 21 Aug 2024 01:19:32 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eb9049b0sm1091453a91.17.2024.08.21.01.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 01:19:32 -0700 (PDT)
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
Subject: [PATCH 01/14] mm: pgtable: introduce pte_offset_map_{readonly|maywrite}_nolock()
Date: Wed, 21 Aug 2024 16:18:44 +0800
Message-Id: <cf9ba8ef10d198584ee907affa516ecebbe29244.1724226076.git.zhengqi.arch@bytedance.com>
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
For 1), just rename it to pte_offset_map_readonly_nolock(). For 2), in
addition to changing the name to pte_offset_map_maywrite_nolock(), it also
outputs the pmdval when successful. This can help the caller recheck *pmd
once the PTL is taken. In some cases we can pass NULL to pmdvalp: either
the mmap_lock for write, or pte_same() check on contents, is also enough
to ensure that the pmd entry is stable.

Subsequent commits will convert pte_offset_map_nolock() into the above
two functions one by one, and finally completely delete it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/mm/split_page_table_lock.rst |  7 ++++
 include/linux/mm.h                         |  5 +++
 mm/pgtable-generic.c                       | 43 ++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/mm/split_page_table_lock.rst b/Documentation/mm/split_page_table_lock.rst
index e4f6972eb6c04..f54f717ae8bdf 100644
--- a/Documentation/mm/split_page_table_lock.rst
+++ b/Documentation/mm/split_page_table_lock.rst
@@ -19,6 +19,13 @@ There are helpers to lock/unlock a table and other accessor functions:
  - pte_offset_map_nolock()
 	maps PTE, returns pointer to PTE with pointer to its PTE table
 	lock (not taken), or returns NULL if no PTE table;
+ - pte_offset_map_readonly_nolock()
+	maps PTE, returns pointer to PTE with pointer to its PTE table
+	lock (not taken), or returns NULL if no PTE table;
+ - pte_offset_map_maywrite_nolock()
+	maps PTE, returns pointer to PTE with pointer to its PTE table
+	lock (not taken) and the value of its pmd entry, or returns NULL
+	if no PTE table;
  - pte_offset_map()
 	maps PTE, returns pointer to PTE, or returns NULL if no PTE table;
  - pte_unmap()
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 00501f85f45f0..1fe0ceabcaf39 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2954,6 +2954,11 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 
 pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 			unsigned long addr, spinlock_t **ptlp);
+pte_t *pte_offset_map_readonly_nolock(struct mm_struct *mm, pmd_t *pmd,
+				      unsigned long addr, spinlock_t **ptlp);
+pte_t *pte_offset_map_maywrite_nolock(struct mm_struct *mm, pmd_t *pmd,
+				      unsigned long addr, pmd_t *pmdvalp,
+				      spinlock_t **ptlp);
 
 #define pte_unmap_unlock(pte, ptl)	do {		\
 	spin_unlock(ptl);				\
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index a78a4adf711ac..29d1fd6fd2963 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -317,6 +317,33 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
+pte_t *pte_offset_map_readonly_nolock(struct mm_struct *mm, pmd_t *pmd,
+				      unsigned long addr, spinlock_t **ptlp)
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
+pte_t *pte_offset_map_maywrite_nolock(struct mm_struct *mm, pmd_t *pmd,
+				      unsigned long addr, pmd_t *pmdvalp,
+				      spinlock_t **ptlp)
+{
+	pmd_t pmdval;
+	pte_t *pte;
+
+	pte = __pte_offset_map(pmd, addr, &pmdval);
+	if (likely(pte))
+		*ptlp = pte_lockptr(mm, &pmdval);
+	if (pmdvalp)
+		*pmdvalp = pmdval;
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
+ * pte_offset_map_readonly_nolock(mm, pmd, addr, ptlp), above, is like
+ * pte_offset_map(); but when successful, it also outputs a pointer to the
+ * spinlock in ptlp - as pte_offset_map_lock() does, but in this case without
+ * locking it.  This helps the caller to avoid a later pte_lockptr(mm, *pmd),
+ * which might by that time act on a changed *pmd: pte_offset_map_readonly_nolock()
+ * provides the correct spinlock pointer for the page table that it returns.
+ * For readonly case, the caller does not need to recheck *pmd after the lock is
+ * taken, because the RCU lock will ensure that the PTE page will not be freed.
+ *
+ * pte_offset_map_maywrite_nolock(mm, pmd, addr, pmdvalp, ptlp), above, is like
+ * pte_offset_map_readonly_nolock(); but when successful, it also outputs the
+ * pdmval. For cases where pte or pmd entries may be modified, that is, maywrite
+ * case, this can help the caller recheck *pmd once the lock is taken. In some
+ * cases we can pass NULL to pmdvalp: either the mmap_lock for write, or
+ * pte_same() check on contents, is also enough.
+ *
  * Note that free_pgtables(), used after unmapping detached vmas, or when
  * exiting the whole mm, does not take page table lock before freeing a page
  * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
-- 
2.20.1


