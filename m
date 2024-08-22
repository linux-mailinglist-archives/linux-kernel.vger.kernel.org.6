Return-Path: <linux-kernel+bounces-296780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7E95AF20
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B011C2289C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B2188939;
	Thu, 22 Aug 2024 07:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J+kCUQRc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6818892B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310904; cv=none; b=KqaVuzyUhOFWpHk5OjtSosRLl1JZ91O9NttX5cJPFazRtMK3pUlpPZlWwkPjlgIojLGko81QxvhnOVtkyQmswiHMvUvzQ8mbr8i7w3Gk+qYCQQOGwgraQhu+E1fyLpiWoI+j9q4ZCgRGl8Ei+QfkbOuQyqz5tXwGevJevrWLfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310904; c=relaxed/simple;
	bh=guFP/UvtdmTvqla5F80lTymUue3B5FcUPfzU+3Ti5Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BoI1rIjykyBJ7sj726kaQiCnOxpbK+TdX2Id9kVsaUBd0dxxHRr/WZ9WR4VaLPfSFTZssSeE+zMigpjEOd1N3gkn1Ma+nj4iPQRzxl/AQZOsmtcPAvQcgLBk3utiuz1aWfKWGiRFssaNRYXCqPBxLdHc7NBHdSWpLD8xBwDpEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J+kCUQRc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so392202b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724310903; x=1724915703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFdM7jnff0z8zF8oYknH78hRu/cQudWIIbslP9zGsAs=;
        b=J+kCUQRcx8ze1ZyKU3x9SsBB0Pkwsob02rFo3T021VU0R3hkW9rsenIH3hD1rlKq+a
         FtI+84imgQpBOTbGmmXfXyWmYGzAeOBBV/VFtUNBqJuvsdeBlTR8QwItzgdskxOg7VIR
         aA9/VybgStagTTqIUSG1uHOuo/cSeJEcjCDu5Dl79K/077WPogpTb0x5xQ7I+Gj0BzXQ
         CzZGHNdK71GtMnwJiTx+Hr5Mt5tD1k8KMHdBjc6Sb3BbruqswpajWs9QcC77PySpGx9Y
         y4v9Z/t8zOsmv9Ykp2glMqEbPfn7flj/UlDn2Pvn5bF7FuC9axvwKNuXPdM/vUKghCLo
         k5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724310903; x=1724915703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFdM7jnff0z8zF8oYknH78hRu/cQudWIIbslP9zGsAs=;
        b=OIqxtPhNrV6NyQhf87FcVw0tSyIaxUcz5/caUUVcxxDDJ/D2V64QFLMkmVRGiEQ5fM
         dC9kV5qQ3RU6SWu9xoKAHSFiVGHf4vp1KIT2zU9HskyAUaRl9GJnBVLfqz43Ak2xols+
         E0PdjiI1nzs68KG9nXoJhfQMpDrEgpztM0TSC6CPVvbjU7U2K5hX5hmtgq2rtTEHGz2S
         cg9S3aiXABj28K7TCDZ9rA2bem0slcRQGxsA9aPFLR1n4GFjntFDuEzxTLyejeoEjPOs
         NjdaQm/WOcnD8tiBtCvsOLkN5yiY8/rFdl4xOdRp3eXPL0+xgTt3yiRqPdN5zuGImbVC
         ZS0g==
X-Gm-Message-State: AOJu0YyHGKrfDAyxuy3SXp9AxAga/zY7PGXRSewIjWWbamiR1LRbeYYw
	AGcaCUQpJMSAd025JWMxo30sTAHROpkUjvel4lGvfTIIU0KuHtZbthUFu/pwoZ1TS+ZPoawTalX
	pDXA=
X-Google-Smtp-Source: AGHT+IElSFOoF4KMPSsF0Gy5tbhJtfEKgqkCJ+pjJm8bK93AAf5vkcbpbvWiZRIPotD+TEYG0fABhg==
X-Received: by 2002:a05:6a00:b53:b0:70d:2fb5:f996 with SMTP id d2e1a72fcca58-714234922a8mr5431869b3a.11.1724310902611;
        Thu, 22 Aug 2024 00:15:02 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([240e:473:c90:f96:d029:ea8a:4e6d:d272])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac994a3sm695095a12.16.2024.08.22.00.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:15:02 -0700 (PDT)
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
Subject: [PATCH v2 13/14] mm: pgtable: remove pte_offset_map_nolock()
Date: Thu, 22 Aug 2024 15:13:28 +0800
Message-Id: <061a61c5871948680488ad02fd1e03547948a500.1724310149.git.zhengqi.arch@bytedance.com>
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
index a00cb35ce065f..1d3e8882f6ba1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2952,8 +2952,6 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
 	return pte;
 }
 
-pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp);
 pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 9a1666574c959..3b6dd8bb5b134 100644
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
  * pte_offset_map_ro_nolock(mm, pmd, addr, ptlp), above, is like
  * pte_offset_map(); but when successful, it also outputs a pointer to the
  * spinlock in ptlp - as pte_offset_map_lock() does, but in this case without
-- 
2.20.1


