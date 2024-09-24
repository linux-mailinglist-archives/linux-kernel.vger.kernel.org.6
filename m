Return-Path: <linux-kernel+bounces-336593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC9A983CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 08:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D39E1F22DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 06:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D94139563;
	Tue, 24 Sep 2024 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YQZSlllJ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132D85283
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158311; cv=none; b=JxaUgEBAuVJPgbNI/ysRKRceD7fR707Vm+8TnG8vFzOGPPff2iMmKlEdAIUMtMrWzVq5AzZUtKb2DroCniok8d0szUoaSqm3IrG0HdH+oYTaV04LvkR/A2hwIhwPc8aFiUsghFhIDdhth9ZuNUjESg78P9IpYEEZkIROgfVHe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158311; c=relaxed/simple;
	bh=v9vdYPzOdAZ9IeVDUmMtwCMvWeEwkmvD5HbQnix6zVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dPyS4Fa4EFPFA0fNe9r45coSSlrWHqMBDMV51wpAO3EgMwmnQhxYB7tH+PZ6stY7341j5AplPiuDxitelmUTx0k/VkTXFOCDi2GcmsVte3Mt2pL6sRl+9aig98SKt91thHkxGJe50+9mGYmVo8xFOAaTHBlykyumC7z/B4XR/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YQZSlllJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20543fdb7acso40327665ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727158309; x=1727763109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0T9lvI1pcCPfr6v8oRbivQAnqkZ5MJutHJ+/bNj+/g=;
        b=YQZSlllJC6ojJjuXM4mrfdnYxfnGNccExsJd5xEdGqEEkLnASdok7vzGmkVaQrT6s+
         cOyMjcUHW1O8HT+P7M3g4Us6K2OSA1KW2CeJuEK1g84fc4fHi6FRz371IZZT4EXg22Pr
         wmsG76cBBCf2VRGjNlfBEYElXYGuCV9u8e2ZLGnGrQSG5VJMIyXF1xCR9z5Jq6j2lnvW
         ofVkJev1Q4EuPpu81YBW8hTMr0XEw0DuLKZCXJC9cACOiKVtjRzRlQwIdUdKuQnec1Kx
         QfjcHeWQr+Wsf6hT32xP7wN64XPmXypq909jC1eWrhq8y18EI4ilQfjLYE9pHf2nVqKQ
         szLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158309; x=1727763109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0T9lvI1pcCPfr6v8oRbivQAnqkZ5MJutHJ+/bNj+/g=;
        b=K1l42sO7/YS2ieVsQQ7VKcYbOubhgYL7xBjHhXATdrs9I7/amjLVpf7NxEhiyg3ue0
         dsHd3UpBjZjo27xn85DSbwXLVj62N95RUuwKv6vDXrObprElCc7+hs2pa5dvj98IYhhx
         a0C3XkC/8/UQ3eKY7Qi970aaNB47NLbbUtM7FnxOT1z2m37dD0vHI1+pZprZ9MHaHt7V
         veIz2crzuZ4wjYe7NsUIMkTz1moDEjoEAJRLoON+DFojDKZq3CPhWgvS8IzSq/SSP60z
         nPixZKDfZxncFqNEec/ZabGeR/BO+a7rwF+CeqGeUIMlZ+a5BmtRq7GrKhWy5+1nodEv
         W4cA==
X-Gm-Message-State: AOJu0YyIFC3iEKKOo268aMo6Sh7DkS23aSHpi43UVTP3juyyNQ7O+s7N
	vQbLizPp/Qxi25LjdnfSGjUYRZ4H24ul2tV0KSLpX8pSFKFCURYzoEUnZ8pWq4k=
X-Google-Smtp-Source: AGHT+IGkJQOlzg3g752NhI9RquMqodCfvTZ7obYXRPzPmN4sDO5P6Za1vWoZJJ9nTCdoHXRNF+rvtA==
X-Received: by 2002:a17:902:ec8a:b0:202:311c:1a59 with SMTP id d9443c01a7336-208d83b6ce8mr195135205ad.27.1727158308785;
        Mon, 23 Sep 2024 23:11:48 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af17229c9sm4344885ad.85.2024.09.23.23.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 23:11:48 -0700 (PDT)
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
Subject: [PATCH v4 13/13] mm: pgtable: remove pte_offset_map_nolock()
Date: Tue, 24 Sep 2024 14:10:05 +0800
Message-Id: <8eb7fcecf9ed8268980d0bd040c0a4f349cbca8f.1727148662.git.zhengqi.arch@bytedance.com>
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

Now no users are using the pte_offset_map_nolock(), remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
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
index 9a4550cd830c9..e2a4502ab019b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3015,8 +3015,6 @@ static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
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


