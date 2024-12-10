Return-Path: <linux-kernel+bounces-438833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50AA9EA702
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 05:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6425C282F84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 04:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122DE226165;
	Tue, 10 Dec 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bodIUL0I"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96CE221D8D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803697; cv=none; b=owf0WBsqhagGJqfb6hYzozHLaaA2E8KAMza1/R+rzckn4+1mvC0UUaj3wffUBgjcjuV+pFZk6MtrJu5hH9mXuuUQh78ncy+ZQKIT7RGDqQCvMai9dKb/QmYq6IjtJkiVj9ihLt7GbSGkku6f3GOsJ4HMYqO7HmB/s1JK/8Uq2V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803697; c=relaxed/simple;
	bh=2EreavHoP96YSHO6gB3dHcCFTOGvdN4giySUOzF+fd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YxyNM2QokrvAia3XbnbqdBEVAqPIgJtl+o+tbbQd8hnZ2uCVtSZCCcduhFIp9N9FLDumbxn2NVvOQI4DnC5q6DaW9aGMzOW9ZuaYOFa9qMcqFtpppgcLY0LDgl7XdCmu4EburyDfFWjB8SNnoImwwyfTjAUqV7JXMyflqauODDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bodIUL0I; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733803690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8RMk/oHGm+u3KEDKg9lygnIdO4nQMUWy6C7jj8RjEic=;
	b=bodIUL0Is6mb8MAJO4BUgh+VmZQ1HWYkUTPb5XGpHvdTiL2C4DqIMW6OveUiG7JPULqauw
	uJNMAMGq1i70blX9TuyhgiHWniO8RMsDlboslPqyUBCTZqos8yilqPx1mVA8Qm83iHk/lp
	F6B8f37ALq2bO1FVzaJDtuVe0V3GOFw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: slub: fix SUnreclaim for post charged objects
Date: Mon,  9 Dec 2024 20:06:57 -0800
Message-ID: <20241210040657.3441287-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Large kmalloc directly allocates from the page allocator and then use
lruvec_stat_mod_folio() to increment the unreclaimable slab stats for
global and memcg. However when post memcg charging of slab objects was
added in commit 9028cdeb38e1 ("memcg: add charging of already allocated
slab objects"), it missed to correctly handle the unreclaimable slab
stats for memcg.

One user visisble effect of that bug is that the node level
unreclaimable slab stat will work correctly but the memcg level stat can
underflow as kernel correctly handles the free path but the charge path
missed to increment the memcg level unreclaimable slab stat. Let's fix
by correctly handle in the post charge code path.

Fixes: 9028cdeb38e1 ("memcg: add charging of already allocated slab objects")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/slub.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f62c829b7b6b..88bf2bf51bd6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2189,9 +2189,24 @@ bool memcg_slab_post_charge(void *p, gfp_t flags)
 
 	folio = virt_to_folio(p);
 	if (!folio_test_slab(folio)) {
-		return folio_memcg_kmem(folio) ||
-			(__memcg_kmem_charge_page(folio_page(folio, 0), flags,
-						  folio_order(folio)) == 0);
+		int size;
+
+		if (folio_memcg_kmem(folio))
+			return true;
+
+		if (__memcg_kmem_charge_page(folio_page(folio, 0), flags,
+					     folio_order(folio)))
+			return false;
+
+		/*
+		 * This folio has already been accounted in the global stats but
+		 * not in the memcg stats. So, subtract from the global and use
+		 * the interface which adds to both global and memcg stats.
+		 */
+		size = folio_size(folio);
+		node_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B, -size);
+		lruvec_stat_mod_folio(folio, NR_SLAB_UNRECLAIMABLE_B, size);
+		return true;
 	}
 
 	slab = folio_slab(folio);
-- 
2.43.5


