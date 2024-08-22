Return-Path: <linux-kernel+bounces-296754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308CB95AEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60432855B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269CA17DFE6;
	Thu, 22 Aug 2024 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I3pID1MM"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B117C7D5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310837; cv=none; b=ZEDwNkFgr6r4pDrrJWobmm1Bs/HnXaVHqOxBG7dMxnK9Epm6ZWSDP4ePs9eOky0z1vjw9CUR3H6RbbAo/+CedKQXPRw/Yuf1ZBHYUEGyJ8ZH+/rMkEmMOXzJi0UeHHZtbFvYZQjUEcl6THdcjNdRKHGHPtK1Ne2PXKNjYFwDNNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310837; c=relaxed/simple;
	bh=x09LfGHiLcReHBhPIDfpc7YYhL+zohEqRTd3hoyo6yA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvGoDZmi1XlqUsqwCUTYY2KOh2cMjHHUsddw1DbSsY9WkOCmH2HN/a4si0HZNsetRwuXCdOeF8xJviy/KS1MyU2TEujYMN2XZWG2EIegI5+vdKgQOOdV5W/u/PPQxyOIKuJ69Qx0n4E40nQGT0hC5+823cQnsWB0dXxKIHBLgLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I3pID1MM; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db1d4dab7fso291815b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310834; x=1724915634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CO0xfYDzsVihapVFXw+qMWwHYfpsvq03XEdZOsUU02k=;
        b=I3pID1MM3YuM7bQfkQ7gjkTXTaS71xo4ssYD+guF1lQRQsM/4wD+rts50U/2D7SjPq
         Bf9vzimBJA+E1XnVBnMLPSlIeDJFiyOenr69D8KEbDEuvZnThmKkW4x+vNBYDmox50Yw
         MvSkKctPXpKK5bG07OXqaqUBoHptDRAKn5UjxUXv6kcbO8S8u/vazqTL66bAt+QhINvb
         k+PN/HCFFS82oRJ72ij7VqS0nUP2E+7NfHR71BeM7eULFSFwhi2K/Ewz812yt1dj7QVf
         M8+RT5Fyd7091hOoz60ppaT36Jjudx0QmcU9TCuiFuAaSoFK5MkvmAJNduObiEHL2wy0
         gvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310834; x=1724915634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CO0xfYDzsVihapVFXw+qMWwHYfpsvq03XEdZOsUU02k=;
        b=Y5NQE2DLiI0/YeWMJzcd5bHCWgxRhz1vuIs1qFZVt559qAmte/iOdlZXfudZ3a+9v8
         zDeDCQSZaq9J2s1Ad6pRhjcJf+ykrlCo7eFlEv2jze0BFTY9mGex8uk8atPmCUfyMqwK
         ckAM4x5EmvTMzGawtgOq6hk/UG0kC2mLKRzdnitq5lDjruITElm+cM62+gVa0R49Y4yK
         8wHmWoQlbKh9ogfdLbrh9CVF+6NR1HoAC9Liq4Tr8th+b6anPAXaTCWxEUAGQJNjDT2V
         pAXgWnE1UuHYiYn47+c1sp7TbpSzoAfZvh1mKkfLRpqq145C12XoQULGFgH6EKBbejid
         EsDQ==
X-Gm-Message-State: AOJu0YyCpPe4nT51icMSmXRtZ0F5pL2XG7k8YI+DguttdttXVxCVQo9l
	ESIlEbEVzsd7o1NSsb2ohUsWhWJ/HhxyWGlYiRbPyaJPLO8lmtFSBtp4Q+ktDcA=
X-Google-Smtp-Source: AGHT+IHZvtclVw9AATG67WMtfqsJZD4bpWoHNpEdN87kwQejpgQ5CLrsmOGdaNcwygIvYs6P1O1W6A==
X-Received: by 2002:a05:6808:148a:b0:3db:15ed:2a24 with SMTP id 5614622812f47-3de1950bb78mr6135912b6e.24.1724310834483;
        Thu, 22 Aug 2024 00:13:54 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:13:54 -0700 (PDT)
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
Subject: [PATCH v2 01/14] mm: pgtable: introduce pte_offset_map_{ro|rw}_nolock()
Date: Thu, 22 Aug 2024 15:13:16 +0800
Message-Id: <e866151ccd257ca14a9361ba59f8c3086aa76e4f.1724310149.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1724310149.git.zhengqi.arch@bytedance.com>
References: <cover.1724310149.git.zhengqi.arch@bytedance.com>
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
index a78a4adf711ac..9a1666574c959 100644
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
+	BUG_ON(!pmdvalp);
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


