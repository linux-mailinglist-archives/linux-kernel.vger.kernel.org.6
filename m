Return-Path: <linux-kernel+bounces-439112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF819EAAEC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1A2283BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9022E40A;
	Tue, 10 Dec 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hH61w8jt"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979D12DD88
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820318; cv=none; b=DknF3MRU38t1thuacz/I0Wr+nSSAz3s1paXdBIqqxURqL8rVoo1oAzY48IUTm3CSiAYTL/MRrafUZarfxso4tj2LWzk64xxhHmzhq6amRFpIAB8y2niAVe1slhlOc0jXOUR0MInsfHF746RpO1uZ2M3ntTRsh/9Gs56VzRhOJW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820318; c=relaxed/simple;
	bh=vRnz0oBDYwZgNoM0b9ZCNyD2bwqRfXb+CZ4l1nL6YUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCyhF25VqvEXpmKNRFKYyY34FlSbDkRyZoh3Sh4gRf/UkLViTLzRXaqR8dYcs+cTFgPi1C2STyyIj/Erd0kkR7UyJfIHNHdSuRdzUMYbWMKDXRBsGCGELUdOdYUz93sKWFYcpQJP8BuC6jZA1qG/FUYGvEJA4Z+IccKFWhp8JkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hH61w8jt; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so3310692a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 00:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733820316; x=1734425116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Niwmr5rUid6tm0Hp/quWe/OSvUvk3d2Sf0tLqBvPqbs=;
        b=hH61w8jt4F2lk5YcMni9vz+9O6H6bZ+CMl/DTA5O6Qzrl5CPgyexO7123rCGuzxDy/
         Cg/eHDV2FxPtC/x8qZ1+U4XeJU7OszwT5W26+gjlm+tjnDfMWMxni8oAR19a5AwDmp60
         vy28PH3RLoqAUn0xaD1l7vwNVJacSRji60sOReuw43WXqXe2rWajNx1oCj+xJ2ezZbJx
         X3ai3DosXyDNZhL66rzk3Pd6bG607PZqW+qtAYZomqy2kVQ06PFF8iggaQgQqyKtjklv
         CMa4OJ45Y6DA8AAr+GwZgAQ6L5cQnmlF8aT9yBt/+05sUNYIeOIarhFvRG5ICXC3u7/g
         ssog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820316; x=1734425116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Niwmr5rUid6tm0Hp/quWe/OSvUvk3d2Sf0tLqBvPqbs=;
        b=o/xIdWDXVP3iU4jR8eBzbvi8ejVvEDL1ZuLIO5B8m/VZtuHxmUcovehQo8xG/HUdfV
         COkm6MScxHf/0NfAEzsChBSzcRRj+q8hdSy9tuf6tQYlFo63HDtz6QYde9NmXs7yDoXB
         PXWrtt+yXB1eigzstfH0sa4uzC0yobaIvFuYXr9IujXgUXAyKVdbqWb0EknyL5xBQ9bz
         dPDv9V+FyAgma02wfHe6oOzFKC7GvCeb3z0KCCBTg/Q7s/5/3b7heoQuVraOGab7Mdpe
         dw8Y5hq6fqr8Q3uYmwpBNd87zQoA7dHI2I683Xn9jzbUHf+hQTlURFXxXOBBGwCIIUIP
         KWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPneh+0zWQgEWCJtt/RynwZXY9JVQr2vnftURkVdbsiycOtfHSlEKY8MNQDVddAFeM9J+WrHULjIhoI4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9f6s14xfsl4QC6mHDdEwowDdqTUfRpip3hanV5cFZujVPEEa
	7NF3nZ5dOyadOIrhcGP5/vcXRgE4xAH8VuLlZ9p/00jIY/jR5i2+cT7ju2xOUQ8=
X-Gm-Gg: ASbGncu3bXGGwLYZuQLQgfggrzoGaGSENvBC48m532vKeQz74rgog+k/Vby91FDn0BQ
	E+3QRhurc75gfzHiu0Pz8uBKVux1QuEd42O7uUjHLIEdFdScGdHJY9TI3Df8ki7OwwUU3du2ICC
	0fu5dIBY/5nKCxCQ52arkMNWjOZzKL/zSZNGpIrlW8kGKTNO2H57s4DMcf7hrjPRuhwpLunYR8Z
	UuTnwE9xvlHYJdwmPh9CsznAEduFGWUHL0Y4IgQbNZA3YXqATZa9Snsxv+OlN5Z79wAunruCHOU
	Mt2TDucqAjd4jK+fAlk=
X-Google-Smtp-Source: AGHT+IEoD4PcTbX2Xdaqk8HuoEBvaFrwzOLStkOiWJYI9VBD46uedAzdCImEWINRDJRn2KW+Js8ZLg==
X-Received: by 2002:a17:90a:c88f:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2ef69e16df7mr24803575a91.15.1733820315774;
        Tue, 10 Dec 2024 00:45:15 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7d302606sm6016395a91.18.2024.12.10.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:45:15 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com
Subject: [PATCH v4 12/11] mm: pgtable: make ptlock be freed by RCU
Date: Tue, 10 Dec 2024 16:44:31 +0800
Message-Id: <20241210084431.91414-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <841c1f35478d5354872d307888979c9e20de9c09.1733305182.git.zhengqi.arch@bytedance.com>
References: <841c1f35478d5354872d307888979c9e20de9c09.1733305182.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ALLOC_SPLIT_PTLOCKS is enabled, the ptdesc->ptl will be a pointer and
a ptlock will be allocated for it, and it will be freed immediately before
the PTE page is freed. Once we support empty PTE page reclaimation, it may
result in the following use-after-free problem:

	CPU 0				CPU 1

					pte_offset_map_rw_nolock(&ptlock)
					--> rcu_read_lock()
	madvise(MADV_DONTNEED)
	--> ptlock_free (free ptlock immediately!)
	    free PTE page via RCU
					/* UAF!! */
					spin_lock(ptlock)

To avoid this problem, make ptlock also be freed by RCU.

Reported-by: syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com
Tested-by: syzbot+1c58afed1cfd2f57efee@syzkaller.appspotmail.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm.h       |  2 +-
 include/linux/mm_types.h |  9 ++++++++-
 mm/memory.c              | 22 ++++++++++++++++------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e2d38c5867b32..e836ef6291265 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2988,7 +2988,7 @@ void ptlock_free(struct ptdesc *ptdesc);
 
 static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
 {
-	return ptdesc->ptl;
+	return &(ptdesc->ptl->ptl);
 }
 #else /* ALLOC_SPLIT_PTLOCKS */
 static inline void ptlock_cache_init(void)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5d8779997266e..df8f5152644ec 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -434,6 +434,13 @@ FOLIO_MATCH(flags, _flags_2a);
 FOLIO_MATCH(compound_head, _head_2a);
 #undef FOLIO_MATCH
 
+#if ALLOC_SPLIT_PTLOCKS
+struct pt_lock {
+	spinlock_t ptl;
+	struct rcu_head rcu;
+};
+#endif
+
 /**
  * struct ptdesc -    Memory descriptor for page tables.
  * @__page_flags:     Same as page flags. Powerpc only.
@@ -478,7 +485,7 @@ struct ptdesc {
 	union {
 		unsigned long _pt_pad_2;
 #if ALLOC_SPLIT_PTLOCKS
-		spinlock_t *ptl;
+		struct pt_lock *ptl;
 #else
 		spinlock_t ptl;
 #endif
diff --git a/mm/memory.c b/mm/memory.c
index 91900a1479322..b5babc4bc36bc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7044,24 +7044,34 @@ static struct kmem_cache *page_ptl_cachep;
 
 void __init ptlock_cache_init(void)
 {
-	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(spinlock_t), 0,
+	page_ptl_cachep = kmem_cache_create("page->ptl", sizeof(struct pt_lock), 0,
 			SLAB_PANIC, NULL);
 }
 
 bool ptlock_alloc(struct ptdesc *ptdesc)
 {
-	spinlock_t *ptl;
+	struct pt_lock *pt_lock;
 
-	ptl = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
-	if (!ptl)
+	pt_lock = kmem_cache_alloc(page_ptl_cachep, GFP_KERNEL);
+	if (!pt_lock)
 		return false;
-	ptdesc->ptl = ptl;
+	ptdesc->ptl = pt_lock;
 	return true;
 }
 
+static void ptlock_free_rcu(struct rcu_head *head)
+{
+	struct pt_lock *pt_lock;
+
+	pt_lock = container_of(head, struct pt_lock, rcu);
+	kmem_cache_free(page_ptl_cachep, pt_lock);
+}
+
 void ptlock_free(struct ptdesc *ptdesc)
 {
-	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
+	struct pt_lock *pt_lock = ptdesc->ptl;
+
+	call_rcu(&pt_lock->rcu, ptlock_free_rcu);
 }
 #endif
 
-- 
2.20.1


