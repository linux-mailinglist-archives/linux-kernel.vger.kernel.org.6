Return-Path: <linux-kernel+bounces-291346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA1956114
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A2A1C21267
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EAF335BA;
	Mon, 19 Aug 2024 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faY1Ik9T"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE863BE46;
	Mon, 19 Aug 2024 02:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034714; cv=none; b=fKGhy72RS2Oe3ldioS4COjfOa33bp7+zM3BiYOLinQ9zIx+FBLVPEGD/n0yz7QDcrlU4KLZVJjD4bJlfz4XNRUcwT/ZR9Rt6QGMHfQwb2hXsgk0KlnX+3yLFcQriOVylM5XfSGqDrcp5bkep6SlSJTOjCwSJoCsdwuaNjHk5fUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034714; c=relaxed/simple;
	bh=7960Kdu80UYNselAaKrcv+t7dmc7UVlFDU1k5afrQ+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G4t4bX1t2wWdifwybB/E5WrPxh+gDcnNIB3LbT0RUyAVOngrtwyTu8B3ysJ+HMDO5L2fZzsMNfl/OLajRG5sjmH0eVfOYSe9VyO9+0H2iU3HpkoqKquXT/SWaVPuUrEj2Iw3U3lLRXcqxLhWyBXf3WGJqxfhXFqWycQO4dNsLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faY1Ik9T; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44ff7cc5432so30688681cf.3;
        Sun, 18 Aug 2024 19:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724034712; x=1724639512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHbAGWI5YhvG8+e8FC6gBqfnjsq6DXdxHGGYZ2mM3LI=;
        b=faY1Ik9Tj1UwU/coFamXQMlF4BRsHd+13GRFu5FPt4FK3GM53vugN3zchBPgp9p42p
         W5n/qk5K2E4aD/89d7si8yyltx4qzIks3w3Odh83cEcXkGWnOgJk2hqD9oXAIbWjDZQR
         6hhfbcQkB0jjK5YfmOD1R9mwlUBzasRqQlKfrWAqn9Wlc3qJ3R06pehJruXx6l8s1/oR
         6PsQq5phSTLXpmP/clUZusakiG3047K3tNNxkUKNtRAn0PZH2QBo8uZ+ojZDfWlGoeW1
         zKXYughMAQ44rn215uIqIjd/HaHiHzd+/FOPLfNd5cePjBBLPUHn5frKWrUMOHzqT1eK
         Y47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034712; x=1724639512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHbAGWI5YhvG8+e8FC6gBqfnjsq6DXdxHGGYZ2mM3LI=;
        b=ljszhrBVH201TwgjsHWV5Ehb17epJOtRINGxOuTTf9qh21l4nG/rRep/RuKMoEQO3X
         5bycJS3UBmhbh53UJB1dy7DNrGxrGeKl58AHr1B9BtIFLkVsENhq7SKuefOKRHlkcSgQ
         GEEZSm6coKZQR0x+n3VwQ0hFqylIlW1++j54/lRmOdkpNT/FUKcBezeTs7ZTlDS/cZIT
         ZpP6hWdoSJLANvyXRqCnMT9o8bwB74w/0HbiumrRnDZ1gFI8h12Fx6txfqlJyFgYb04L
         SL3BSYf2KIvxcyyYhiX7l9dTU/TnW0VjSKdbnC1FCQNirrzQfVaVgAOB97JwqKWitkhj
         ZMdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaCBOGubP6BvRY1ShZ6lwdtiaRjr/zezVIXrgOzkiSXpjmEcikICBLskyoRh4sk3CFrocmpPCuOorGCieRZbUwXGlF5FfBQDqz6pSjasBA7UAJX4BNpl19rQfWpUoYR/tN215RU4hN
X-Gm-Message-State: AOJu0YxwxOnXzgExE3dVEiQFn2/F253mpuBbAwzWb1amNVsD/4cG3DhZ
	mEwGfhiTRJy5ANum67JjeJOGVcjQLWMWPcYB3ARVpEM4fG9qAJ4o
X-Google-Smtp-Source: AGHT+IEpaTMKPf3VW76AVnS5nT7RUI9JcYK6qI1yzTo5GJ8U9EnjvGJNpHkQcNL620aPLntPx4HfJA==
X-Received: by 2002:a05:622a:988:b0:44f:e132:14df with SMTP id d75a77b69052e-4537425375emr117719541cf.21.1724034711670;
        Sun, 18 Aug 2024 19:31:51 -0700 (PDT)
Received: from localhost (fwdproxy-ash-003.fbsv.net. [2a03:2880:20ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff4bc2sm36832461cf.37.2024.08.18.19.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:31:50 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 1/6] mm: free zapped tail pages when splitting isolated thp
Date: Mon, 19 Aug 2024 03:30:54 +0100
Message-ID: <20240819023145.2415299-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819023145.2415299-1-usamaarif642@gmail.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

If a tail page has only two references left, one inherited from the
isolation of its head and the other from lru_add_page_tail() which we
are about to drop, it means this tail page was concurrently zapped.
Then we can safely free it and save page reclaim or migration the
trouble of trying it.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/huge_memory.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 04ee8abd6475..147655821f09 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3059,7 +3059,9 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	unsigned int new_nr = 1 << new_order;
 	int order = folio_order(folio);
 	unsigned int nr = 1 << order;
+	struct folio_batch free_folios;
 
+	folio_batch_init(&free_folios);
 	/* complete memcg works before add pages to LRU */
 	split_page_memcg(head, order, new_order);
 
@@ -3143,6 +3145,27 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		if (subpage == page)
 			continue;
 		folio_unlock(new_folio);
+		/*
+		 * If a folio has only two references left, one inherited
+		 * from the isolation of its head and the other from
+		 * lru_add_page_tail() which we are about to drop, it means this
+		 * folio was concurrently zapped. Then we can safely free it
+		 * and save page reclaim or migration the trouble of trying it.
+		 */
+		if (list && folio_ref_freeze(new_folio, 2)) {
+			VM_WARN_ON_ONCE_FOLIO(folio_test_lru(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_test_large(new_folio), new_folio);
+			VM_WARN_ON_ONCE_FOLIO(folio_mapped(new_folio), new_folio);
+
+			folio_clear_active(new_folio);
+			folio_clear_unevictable(new_folio);
+			list_del(&new_folio->lru);
+			if (!folio_batch_add(&free_folios, new_folio)) {
+				mem_cgroup_uncharge_folios(&free_folios);
+				free_unref_folios(&free_folios);
+			}
+			continue;
+		}
 
 		/*
 		 * Subpages may be freed if there wasn't any mapping
@@ -3153,6 +3176,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		 */
 		free_page_and_swap_cache(subpage);
 	}
+
+	if (free_folios.nr) {
+		mem_cgroup_uncharge_folios(&free_folios);
+		free_unref_folios(&free_folios);
+	}
 }
 
 /* Racy check whether the huge page can be split */
-- 
2.43.5


