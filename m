Return-Path: <linux-kernel+bounces-530736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D359AA437A5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617C1175350
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07EF81727;
	Tue, 25 Feb 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFNygbvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D6F260A33
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472230; cv=none; b=iNIylEYPN7zVZK1PaV/6SXPiWGyUWEc2D4YJNMUJpiMtVhYw2q54xGbVVJbu1R/e3nooTW9QZymZmNf3UnGk0cCtqEDh9gk8mTVgN9cCiLr2pmgbDa+kfRjngDQQNX/46RyHrrKVCtaNF/edZwsoPC4wwLlcXOvyIobTQnKpv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472230; c=relaxed/simple;
	bh=y8ff9ry3eCNa0zxLgjbjNuPaHO5Pr9a2HPBF1IduA2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SD9/ovRdW3IiA5PNkToMcy32qFWDoF+Bse9cX8oJifBTIf0DVCICcREXl7gIByZoCnWRLojjGekwbov5kecRCO2yWcWZU+oFwih7w60LGyNoGGsw/3CR8bIUzcsnvLFlKtOmuCwywG1lNL0bRX6ybmstRaO+WUhCv3JXvQy82X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFNygbvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C163BC4CEE7;
	Tue, 25 Feb 2025 08:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740472229;
	bh=y8ff9ry3eCNa0zxLgjbjNuPaHO5Pr9a2HPBF1IduA2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uFNygbvru2Ail2mhT9GAZ4lcaiF9sGKpxvTXGJS+8Obo5vPhB2auqrITYx9h47YjM
	 osZfbsQmrNs8grDGLfnO9MJq/DZXm/OAp55qB1f8cv+GMMFWm/He3TCO/q1ayt30E3
	 wQ9/HlHpxTK0dl6wv9++6zExnjCabR0wjoCzwMKyr3oGYBHCADKHexYf/P/aiF5Fg1
	 3KpX5Rhf4110ooqzcDXDfHlW9GDOGuXwLAv83+svXXMy9tUODOBKfNFThT6FPiYm/4
	 RVVPxm37niLHlxjyx/qCDmujpR0985PFtHfCTI2FCX/WpYq19Wr9KZ0wFmchVDkteq
	 4W0VR638u333w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Frank van der Linden <fvdl@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm-unstable 1/2] mm/mm_init: rename __init_reserved_page_zone to __init_page_from_nid
Date: Tue, 25 Feb 2025 10:30:16 +0200
Message-ID: <20250225083017.567649-2-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250225083017.567649-1-rppt@kernel.org>
References: <20250225083017.567649-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

__init_reserved_page_zone() function finds the zone for pfn and nid and
performs initialization of a struct page with that zone and nid.
There is nothing in that function about reserved pages and it is
misnamed.

Rename it to __init_page_from_nid() to better reflect what the function
does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/hugetlb.c  | 2 +-
 mm/internal.h | 2 +-
 mm/mm_init.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9faa1034704f..778c21da22f0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3392,7 +3392,7 @@ static void __init hugetlb_bootmem_free_invalid_page(int nid, struct page *page,
 
 	while (npages--) {
 		pfn = page_to_pfn(page);
-		__init_reserved_page_zone(pfn, nid);
+		__init_page_from_nid(pfn, nid);
 		free_reserved_page(page);
 		page++;
 	}
diff --git a/mm/internal.h b/mm/internal.h
index b07550db2bfd..5c0b81abbc1b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1465,7 +1465,7 @@ static inline bool pte_needs_soft_dirty_wp(struct vm_area_struct *vma, pte_t pte
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
 				unsigned long zone, int nid);
-void __meminit __init_reserved_page_zone(unsigned long pfn, int nid);
+void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 133640a93d1d..f9a02b1e2fce 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -653,7 +653,7 @@ static inline void fixup_hashdist(void) {}
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
-void __meminit __init_reserved_page_zone(unsigned long pfn, int nid)
+void __meminit __init_page_from_nid(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
 	int zid;
@@ -733,7 +733,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
 	if (early_page_initialised(pfn, nid))
 		return;
 
-	__init_reserved_page_zone(pfn, nid);
+	__init_page_from_nid(pfn, nid);
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
-- 
2.47.2


