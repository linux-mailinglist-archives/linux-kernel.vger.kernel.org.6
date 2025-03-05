Return-Path: <linux-kernel+bounces-547456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7DEA50961
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFA63AA011
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728C254840;
	Wed,  5 Mar 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5tb1b18"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8761E253F3C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198587; cv=none; b=cfcLxbvlWm3ZnKroQl4T/9RXnqlU/Byq6+p3p6huwVnDlSCqTFO8yx2BGPzWqCX7/mFkc6xqitVX8cLdfHg/OaqajLsIzkHpzSmdbr7+xZbiQQYmakcd1e9ZMclorv8gdbD9DZ+buV5vKHwAOxxcyShGIV+70JU6WBzUGviDy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198587; c=relaxed/simple;
	bh=OqLt2zId8LUFKARGxIVzcXznGs9Ytza2liDWujZpc8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOYapv8y9pHJ7rR7Y6WK/3aiAGMVYKhjsUpq8OnEhJC9bpQ5u2XkGom4BD6mNhVap/gklZtQyB/620lDvDJhw68njWd3bHKp0u4Fb6F5rb9YMDslUqXF5sujnHlJ90gmU2lKX/xpf26vtjGtZcU0AOg+USW1qo68Fx6T5V+6JeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5tb1b18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FBFC4CED1;
	Wed,  5 Mar 2025 18:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741198587;
	bh=OqLt2zId8LUFKARGxIVzcXznGs9Ytza2liDWujZpc8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5tb1b18FoCnv4378bvS3h3FozmbWmysT2y3RwuHzECCmJPFN9mtaSFgXIRlhhSQP
	 NyjxjtXqPftmaLx3OTJhNzZNB0lE/f9exNaPLlRczJhYQ6ln/Xq8ZwyeZ6Aj/xk1NJ
	 HBuMny/ZCKifdmvK3jAb65tdp0uY5mnirM6RyPEaonb9YW7JmIg5W24imxDPppoKJw
	 hC5hGKAVqNNVLiH1G3FPg/mRTHxy+fpG/IvWx5jvkF5zrGVDT0R1f8vW4LJiEZBf5T
	 fQmHOeNyU5pRA/ixwasJ+S2kiqveFW4zNS2NpGcWVuuYUbTlC6zcHerl3AXN0y+BOJ
	 VPl9SODsmawoA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <howlett@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 06/16] mm/madvise: pass madvise_behavior struct to madvise_vma_behavior()
Date: Wed,  5 Mar 2025 10:16:01 -0800
Message-Id: <20250305181611.54484-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305181611.54484-1-sj@kernel.org>
References: <20250305181611.54484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most internal madvise logics are executed by madvise_walk_vmas() visit
function, namely madvise_vma_behavior().  The function receives only a
single behavior value, so difficult to extend for tlb flushes batching
and potential future optimizations that may require information more
than single behavior value.  Modify it to receive
'struct madvise_behavior' object instead, for upcoming tlb flushes
batching change and possible future optimizations.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/madvise.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 3346e593e07d..8c4c128eaeb7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1241,6 +1241,10 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 			       &guard_remove_walk_ops, NULL);
 }
 
+struct madvise_behavior {
+	int behavior;
+};
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1249,8 +1253,10 @@ static long madvise_guard_remove(struct vm_area_struct *vma,
 static int madvise_vma_behavior(struct vm_area_struct *vma,
 				struct vm_area_struct **prev,
 				unsigned long start, unsigned long end,
-				unsigned long behavior)
+				unsigned long behavior_arg)
 {
+	struct madvise_behavior *arg = (struct madvise_behavior *)behavior_arg;
+	int behavior = arg->behavior;
 	int error;
 	struct anon_vma_name *anon_name;
 	unsigned long new_flags = vma->vm_flags;
@@ -1665,10 +1671,6 @@ static bool is_memory_populate(int behavior)
 	}
 }
 
-struct madvise_behavior {
-	int behavior;
-};
-
 static int madvise_do_behavior(struct mm_struct *mm,
 		unsigned long start, size_t len_in,
 		struct madvise_behavior *madv_behavior)
@@ -1687,7 +1689,8 @@ static int madvise_do_behavior(struct mm_struct *mm,
 	if (is_memory_populate(behavior))
 		error = madvise_populate(mm, start, end, behavior);
 	else
-		error = madvise_walk_vmas(mm, start, end, behavior,
+		error = madvise_walk_vmas(mm, start, end,
+					  (unsigned long)madv_behavior,
 					  madvise_vma_behavior);
 	blk_finish_plug(&plug);
 	return error;
-- 
2.39.5

