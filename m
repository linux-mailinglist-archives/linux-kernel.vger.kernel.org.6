Return-Path: <linux-kernel+bounces-339977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E49986CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BF27B25AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 06:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B9618C03C;
	Thu, 26 Sep 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DdvRyMbm"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7659418C013
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 06:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333310; cv=none; b=NSruVibWd4q+skO7R0oPu9tc9HzRI8PrxC99teD+XLAbFCgy9x/1OCpY4NPcQLnrLvzOXPihd0bn06gLTb8awzYX7i1ElsM/bwiHmnCFf03nTL2M3mZgPi8TUjBKF7NzEtixVD/R7un3lYqU1gAqS9Xb29XQEey6//xmOJJfnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333310; c=relaxed/simple;
	bh=extMSNBrZETWpUQUJhKJu/3q7Zw4ufuaAk1jyXFXQTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUjiJlOL3U9aHmLMf63MuUrsWWkNUDmj/UtQdzBUStTzraftFcbEGjt1g+uGEU61gmVNc0WZO15Z+ZnS8uqiv0VpzF2QklTvMm2diyMWBaMolpvYUByc1CFORVQPaq1htLD4S2NrLvrMJfCp010BuE6MfyvQBzt5+7Wr4w5dQNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DdvRyMbm; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99fdf2e1aso75144685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1727333307; x=1727938107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XK9xLAd1aeWWLl9nHV9gcamA18VQvE5iTgorpb3Ql3Q=;
        b=DdvRyMbmuRpYlAWdqR7eSOgytLQTCWEIRd1lSnf2R8XLRjt8o7vD5p3k28/65dzuGi
         HcsuBLrv5fS+Huw+440SfjyBxi+durdgb0OSdVQYR7m8hVM8IKedaTYOYF95hcBHcNjC
         nu1NinOapX55OHGRbBZyR6j3mybcZn6LL4RmEAbI9qww1T4T+R4DhKpuTQlPplPqmu+t
         tQzzrAI8mtw71U6BXnOi/BkDCc0D+izQ5sEFdTALYEKO2tFYiRmHPfib6BoaG78ghbAW
         POw5duGX9JmT6SlM1Eb51uEjv/MlLjz+I2QLx6ogJmty8pUkUrASZJO9iT52PNXZ5LTZ
         cZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727333307; x=1727938107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XK9xLAd1aeWWLl9nHV9gcamA18VQvE5iTgorpb3Ql3Q=;
        b=gPYR/JQd4Jzhntwma2ESDQyHfuJZbxEap8m17FUdoYb3JVMkD/MIZ23SWOWCgpQrM4
         jcGyNT1WptMjXRWVezNFvMusioLTKbnDNN1YY86G4g8938pO1fO+Z7S385s4GvR6mIKG
         DEzVf9Psoi4aaj48TTo2y2s2i4aLlAZ0nK3+xAwAWIHyFxh8/FsXkHeSPbWgJUKgZXZU
         ePAah3AiHMpLOT7/hrfkk8nN1RdvOQ+o6M6TH4cpUYMLJ3GbaLpNgQ4r4F9ZmBqrJcNO
         /gd/ZoB55mpDKb9D62Rqzy+pv77p3y+FCCLQ5uxFRFYFJljmPHi4QBh3q6UJaURgS5wy
         jaWw==
X-Gm-Message-State: AOJu0Yx2ycauafjM26dxd2uU0u/y+5GCq/ZUxSXMeRztW7VFNgJnmvMI
	8JxgvWEZs+SNW8KDD2bvLb+AUobYT5bqEJhz51AzqNSRCsxLM2ZjQ1aXcMe4iXA=
X-Google-Smtp-Source: AGHT+IHnYRThLjQtuqQ25g++f96or6jGXpOGKBOHjBYtOEzyfC2Zv3m6NDV/6g7eYEpePNjEvQY05w==
X-Received: by 2002:a05:622a:2996:b0:458:37c6:46fa with SMTP id d75a77b69052e-45b5def2036mr66535021cf.28.1727333307294;
        Wed, 25 Sep 2024 23:48:27 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b5257ff1esm23024611cf.38.2024.09.25.23.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 23:48:26 -0700 (PDT)
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
Subject: [PATCH v5 13/13] mm: pgtable: remove pte_offset_map_nolock()
Date: Thu, 26 Sep 2024 14:46:26 +0800
Message-Id: <d04f9bbbcde048fb6ffa6f2bdbc6f9b22d5286f9.1727332572.git.zhengqi.arch@bytedance.com>
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

Now no users are using the pte_offset_map_nolock(), remove it.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Acked-by: David Hildenbrand <david@redhat.com>
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
index 46828b9a74f2c..60a55b28cf679 100644
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
index daa08b91ab6b2..5297dcc38c37a 100644
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
@@ -372,15 +360,6 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
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


