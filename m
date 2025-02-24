Return-Path: <linux-kernel+bounces-529603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A71A42889
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A097189AAF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9FE26618D;
	Mon, 24 Feb 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3Aa4IoS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B60E264FBC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416183; cv=none; b=CoFheQw+Iz0eQtLYV8LxGzngyMmaltnPyaWkPfqM/4AYw/S4Rz4EzmLJFV46LWwlcwy6/01OTR5+6ESm+I7E4KaHKZM6UBU/+TBfajlBpIi1gBKFSvqHWvJk9AXKcjjVttYcw+GyDqGmB5Vwy2HOIqpcm0QEI+OppHSWrfbOhuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416183; c=relaxed/simple;
	bh=bXPvxNVE3XeaBKg/JoFKv1juEo8KZy99yrPhS4Bp1Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dsuBGfdbTxbyQZoWaF2V7ORGRzP632h5yZ1rPuk5OqZ/3Z8Z5OQX0S0kqEoybPMyLO7m4Xw1WrxZM5hKen8/RfEersRpEF3R7yYi09IZCymMtg7FKL7wBSBTNOl/f7bJe2SEu1wGuz3q6qEgU47njwC7bObx+UNG0ty4ITyU/UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3Aa4IoS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JowchFKNsu8Ay0dQlyPFoFvu2rxlXy5D20/ejxoZdUQ=;
	b=J3Aa4IoSZzYkuctLYARUtsuacmOWp72z/ykZSxcdELHGG+MGY4IHEty8fcdPJ88/sY87iW
	Vg2/cC+kUov7PtBFRchGJ/t8FDFdssvsttu+sG2iQHq9TGd8et6PfC8rud4DcR1RIbIU4j
	jordv74/naJRxo5JJE8jvymFLnJ+iAQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-mAVDyivfOAi7xRDR3MvRXA-1; Mon, 24 Feb 2025 11:56:19 -0500
X-MC-Unique: mAVDyivfOAi7xRDR3MvRXA-1
X-Mimecast-MFC-AGG-ID: mAVDyivfOAi7xRDR3MvRXA_1740416178
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4bf0d5faso2472196f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416178; x=1741020978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JowchFKNsu8Ay0dQlyPFoFvu2rxlXy5D20/ejxoZdUQ=;
        b=I2XJ/pjvCwV2y18Z6IYdlVnwcoHsKIA8J31eMnD285G3/NA0mfE/lxQZLHgUnP/Cgp
         pymFnvfyCDoRE6/Sosi+UbuGB51dODXadWlPzie7Oh5oWPEKxFl+rGARomwhRxwpGK2j
         wbIcPeRNuhRADUz9u02u7FUGufg7uEEAewaztQrCj4vAh18uKnNXBaQPDfzACfHEp9ij
         cwWqmY3mcnk+h7nSG4tWlyE2jeG66b7KSlim1nWPU/9ywIJZ4LHho6dhtY/Ibi71Kct/
         UiWeeW9NDdh2BvdnIe2pOxP1c8E3jx7agAqX3sOoKtrHkB4Ni5qPXobg3kik9CmVLDr+
         BDrA==
X-Gm-Message-State: AOJu0YxIuUKbWfBtw4sCTsv00KdIyp8WuAByKDHalh7gX8tZVwDIcJj5
	Z2PaznAuA9akJyUgf7qwPpl6sEzmhDh0LqKXYBj2j5gQGZya1aklkDNZJ2zibu9PKKH/CO4z5BM
	AchIk7nTOrrpfaOtsU9GrVYlD86bq6fGvXRlNt+qpv5zuVvX7Rbr4Vm1HiBkJlkHTW9HbLx3jaA
	nDACHU1mOBNKKf2XTxP2ekY0c0l+SqhaCUHgDltCMhdLqx
X-Gm-Gg: ASbGnctseaf1BnBSif7L9Idh3U2UvVn4qKHxtAhj9xv3FvXsacRu0+YL4knn6Q5CrkP
	nIbPV3NZvYx/JKmvGhxIaBAIDoHSzBDFkMTR4UuyvuW0+dUlkOiB7HfnMWO6s+Iry179tksu066
	KXDL4+oen0A+ao0PKhHPZzsDzg3sfQAxvUQ7YRh2f4tlBlFyeJXyUJPRhXAy58p1icKuwK0siLW
	j+lO62oQNQYER0q4c6I2Ne3FbZLk7XtuUv9x76sEnPo7H91toGhlkVwlQBjf/zQGeEikdkwSST6
	LhKcrWjGd3sKmJpNIhrOhji5nHcGOpPArDUIsBNA2g==
X-Received: by 2002:a5d:47a3:0:b0:38d:d8fb:e90f with SMTP id ffacd0b85a97d-38f6e975ca7mr11045691f8f.24.1740416178162;
        Mon, 24 Feb 2025 08:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEppyEZ/CiRop1NWtbK9zceuiQ/u5I/zpQhUebwrOc1yf1KZs6E/F1s5c1KapHNpyvpSRQcvA==
X-Received: by 2002:a5d:47a3:0:b0:38d:d8fb:e90f with SMTP id ffacd0b85a97d-38f6e975ca7mr11045649f8f.24.1740416177739;
        Mon, 24 Feb 2025 08:56:17 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258f5fb6sm31629683f8f.44.2025.02.24.08.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:17 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 06/20] mm: move _entire_mapcount in folio to page[2] on 32bit
Date: Mon, 24 Feb 2025 17:55:48 +0100
Message-ID: <20250224165603.1434404-7-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

Ordinary folios only use the entire mapcount with PMD mappings, so
order-1 folios don't apply. Similarly, hugetlb folios are always larger
than order-1, turning the entire mapcount essentially unused for all
order-1 folios. Moving it to order-1 folios will not change anything.

On 32bit, simply check in folio_entire_mapcount() whether we have an
order-1 folio, and return 0 in that case.

Note that THPs on 32bit are not particularly common (and we don't care
too much about performance), but we want to keep it working reliably,
because likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", the 32bit specifics will go
away again; even small folios could then have a pincount.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  3 ++-
 mm/internal.h            |  5 +++--
 mm/page_alloc.c          | 12 ++++++++----
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1a4ee028a851e..9c1290588a11e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1333,6 +1333,8 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 static inline int folio_entire_mapcount(const struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio_large_order(folio) == 1))
+		return 0;
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 31f466d8485bc..c83dd2f1ee25e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -385,9 +385,9 @@ struct folio {
 			union {
 				struct {
 					atomic_t _large_mapcount;
-					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
 #ifdef CONFIG_64BIT
+					atomic_t _entire_mapcount;
 					atomic_t _pincount;
 #endif /* CONFIG_64BIT */
 				};
@@ -409,6 +409,7 @@ struct folio {
 	/* public: */
 			struct list_head _deferred_list;
 #ifndef CONFIG_64BIT
+			atomic_t _entire_mapcount;
 			atomic_t _pincount;
 #endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
diff --git a/mm/internal.h b/mm/internal.h
index d33db24c8b17b..ffdc91b19322e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -721,10 +721,11 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
-	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1) {
 		atomic_set(&folio->_pincount, 0);
+		atomic_set(&folio->_entire_mapcount, -1);
+	}
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3dff99cc54161..7036530bd1bca 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -947,10 +947,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 	switch (page - head_page) {
 	case 1:
 		/* the first tail page: these may be in place of ->mapping */
-		if (unlikely(folio_entire_mapcount(folio))) {
-			bad_page(page, "nonzero entire_mapcount");
-			goto out;
-		}
 		if (unlikely(folio_large_mapcount(folio))) {
 			bad_page(page, "nonzero large_mapcount");
 			goto out;
@@ -960,6 +956,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
+				bad_page(page, "nonzero entire_mapcount");
+				goto out;
+			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
@@ -973,6 +973,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
+				bad_page(page, "nonzero entire_mapcount");
+				goto out;
+			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
-- 
2.48.1


