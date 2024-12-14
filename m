Return-Path: <linux-kernel+bounces-445935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A09F1DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4004D1686BA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 09:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C67B16F27E;
	Sat, 14 Dec 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VBI/9JXs"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355927E0FF
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167028; cv=none; b=EdqjMOqfiNkw6qi6DC2PNq96+3CCla1Gl1xuonX2E2U7DlQ8Ym9TXwtLyXkvNb7Jl/3R2KF9F2AkB17zjoFO//VF8WvdR7t6yscczrjfkew1sUtt043lJAtsrWHk7zhX+4/2Xa1GBHcgVb7sdN6S4vnY8tYgwhYu9j+5AlakxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167028; c=relaxed/simple;
	bh=CnaAuCIjIGmiKSYtT+I1U505CPuTYPZahEmuA+VOoDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFq+hpk2NWX6SWy8/KqM8sdXAp7WYzumnXz1RIv+8BsqYvNA1R1ur+YspQ+tuW2j4g9jDXNU6SoM9Pz9ryrVezpr5dPnU2hNmp2OcET9owLVZQcQdZbu1nIUCswE18FANKogEr5EJ7Oe0K1Zj5kDH/OynaLFfJC2m2RMtBv6SSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VBI/9JXs; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728e3826211so2067038b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 01:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734167026; x=1734771826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W0KMvrB9Jil9zRQ2f7XfdU3YONHwHkiAoiFljp+njo=;
        b=VBI/9JXsEC1O5sF7V/Xa2U8EJY7sZUHu3FGbqOMnSYj7R0NYsS93vL89WoAWWD2HnP
         e2qzs+EJG9bm3DwZXU/PrkNejJw+0xCQ48kvUREoERLEU+MdDOQHglX9r0bN+VQi123k
         0GNI8AeQAYQ9j9kh8WhxFM1EcKH6Uzrycdrc+hdHSRXRvzbSJ/qaP10AcpWJeBp9+vsF
         Lh5IgSe3d5bkpHvEwRoJ0y1n4s82fhB+AFfJielgjE6e4Os+PwC3tGFOX+mSjZ/TSEQn
         jT6Xa7fsQ3oEXD60Ms1uSkack3jGeP8BWRvBSMpojqmnBM36Is7vfrf4a5X/zDsI4Bdd
         jXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167026; x=1734771826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W0KMvrB9Jil9zRQ2f7XfdU3YONHwHkiAoiFljp+njo=;
        b=loGXD6NpqJRHPqFlxODRYsprb9Jernie6v3v2qTexp2VxC4/xXFzFOTgh7rzQZ16RS
         seLEkG0rfPPAS9ZS4/IGvhVKehmqQFx0rIbU0UmqqY9i+ETCNk7IfDWxoD2kBC5khDn5
         6ZqwLTNs44lJjjWvdGE4WZdRq/DkAZfhq6TT3+aMgTUNNSmTkdxlg53jW9JWdTEyX+Yg
         wtdJ9Xfu1WEqNk4mFHkfxHo8gt0ae+TPwaszlhW/kAMOYzQzxTGJCY9ZCnKsS+Ju9Wna
         uM0P2bgvQswLsp7aAJlCIUDMlVJuwgBIG1z8a3N4Y994QGYLPgUrTpbanxakq9xYG0FF
         saUA==
X-Forwarded-Encrypted: i=1; AJvYcCUY1NPY2PMoPlBY7vYtxWFtKmcfRl0Xne3aTy3ye03rpAkCAd+U3UmWlXsfhYS1hIbb9YppFCA9Sw1Fnio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHU7lPuAwzamnotc81lm0yGGx06PSjVamB5W5OMy/oL9xvmn3
	orq683t1J6Jr8YvGtG7v8azJlxdu60m3f/0lxahIvsTa9FUUVS5IkU84P4akQ2g=
X-Gm-Gg: ASbGncuxM68n5WyDSRa+q2DYVCrQCilUoQxs/iA+aiH+SlDpuTtTB/900aVNpE50vi6
	8zOLR0Pr0bNlZQREuqVrqFgv8yAUZQ47gz3X0krmySXH98n5q5De3EQlXlpJ+iPQYZ2ASpW9yTt
	dthHIu1eKHFQCCh9h9CeZ1oaR4kYfNoIgtLoWoc60imdjJi0qVgfwVBoOSDMekykQ43UD8rudMg
	ES3K/BrYCR807aBlp4GUByFvRZQPZmD/mDe6qTd1+t4ZVEd0sbRWOs6aiiTqSOgWfyWquzXWgHL
	XNKtufAyb+xnDxOM6iKZc9zHs69fYg==
X-Google-Smtp-Source: AGHT+IFq7u9PWr4pIiPNWcOSLFRHni+qPQ4ESKUOWoSzAEQHr7L/XMr4iW3HNmhbkmKWJmb1Wl5pRQ==
X-Received: by 2002:a05:6a21:a247:b0:1e1:afa9:d39b with SMTP id adf61e73a8af0-1e1dfc12584mr8746124637.7.1734167026495;
        Sat, 14 Dec 2024 01:03:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([2409:8a28:f4f:a9a4:5d46:4ef0:daa9:1db8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5a90ba0sm905731a12.16.2024.12.14.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:03:46 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 01/12] Revert "mm: pgtable: make ptlock be freed by RCU"
Date: Sat, 14 Dec 2024 17:02:47 +0800
Message-Id: <1fdb3ee32e6958ad82229941b2213ef76b7c4705.1734164094.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734164094.git.zhengqi.arch@bytedance.com>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 2f3443770437e49abc39af26962d293851cbab6d.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 +--------
 mm/memory.c              | 22 ++++++----------------
 3 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e7902980439cc..5e73e53c34e9e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2988,7 +2988,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return &(ptdesc->ptl->ptl);
+	return ptdesc->ptl;
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index df8f5152644ec..5d8779997266e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,13 +434,6 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
-#if ALLOC_SPLIT_PTLOCKS
-struct pt_lock {
-	spinlock_t ptl;
-	struct rcu_head rcu;
-};
-#endif
-
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -485,7 +478,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		struct pt_lock *ptl;
+		spinlock_t *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index d9af83dd86bbf..83765632e20b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7041,34 +7041,24 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock;
+	spinlock_t *ptl;
 
-	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!pt_lock)
+	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!ptl)
 		return false;
-	ptdesc->ptl = pt_lock;
+	ptdesc->ptl = ptl;
 	return true;
 }
 
-static void ptlock_free_rcu(struct rcu_head *head)
-{
-	struct pt_lock *pt_lock;
-
-	pt_lock = container_of(head, struct pt_lock, rcu);
-	kmem_cache_free(page_ptl_cachep, pt_lock);
-}
-
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	struct pt_lock *pt_lock = ptdesc->ptl;
-
-	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
+	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
 }
 #endif
 
-- 
2.20.1


