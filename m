Return-Path: <linux-kernel+bounces-268632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5672D942724
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F6C1C22B34
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06A91A4F05;
	Wed, 31 Jul 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI85PgWk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282721A4B4E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408563; cv=none; b=OkyZUmBp9cSjDb/pMbXcQte1Vv87u+2xlVqWteFaOPugjHJZRa0LU2ZWoRmJaE/nlWi0+pn5y0+PanG0ztXo+3/geL9ndpK2tSN2EoXgVAVlFx/jCYDsz1ByFPS7/nTKCfxhDqSHJ3hKtx7p/0QnrYgZUivE62dttGkM0K6t3Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408563; c=relaxed/simple;
	bh=mFTpCV7XNA0Q39wY6mTWVaq5W4nsa4d0OkBcY1l+IsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXhHOHj6YbfduOfHQM1+xQCIAOSp92AFG6LOjk2CyFCI5gS05TW79U5E65K2RCAgxH5dKvB96vA+rYlkj2/aSk9w4x06wjmRxMJuirPEICucFfb6DXkXiCUFCax1WVS3j5Ti5wliSPM+AQTtO7IGUhrbDsBStf7XUoO30iu84EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI85PgWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4669AC116B1;
	Wed, 31 Jul 2024 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408562;
	bh=mFTpCV7XNA0Q39wY6mTWVaq5W4nsa4d0OkBcY1l+IsU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QI85PgWkPs/n+4oHRNul+S2Hb87b9WfYCiP9KF36fh0yy05RRPF8RDd0RTg6h8e0T
	 hmx6DVEUupfOip8hPEYA30Lq0l5BlASGFYOBVjFfAc+HU2dM0cLqdExkqi/LAfwuPJ
	 5bri/GYwmerEpO9awQlnLQf6o/74Tnt5u3b4XpL37eEs+2npF3NDP/BJ58Jy77hnuq
	 V/d8r9A2ezC3fjXGp+1XXZXLwT1PrLLBKjrnyxIeD+rTAIhHFVSsgOJZB9+NdjuDMv
	 XcRqv/SkuTbN30JM+64812/Ic5yUn7Hb6zLh4PCNxjjWcRvbXGlO4vddrsIh7Fx4Ff
	 iKCuUz8yS1o1Q==
From: chrisl@kernel.org
Date: Tue, 30 Jul 2024 23:49:16 -0700
Subject: [PATCH v5 4/9] mm: swap: clean up initialization helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-swap-allocator-v5-4-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

From: Kairui Song <kasong@tencent.com>

At this point, alloc_cluster is never called already, and
inc_cluster_info_page is called by initialization only, a lot of dead
code can be dropped.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 44 ++++++++++----------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8a72c8a9aafd..34e6ea13e8e4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -438,20 +438,6 @@ static void swap_users_ref_free(struct percpu_ref *ref)
 	complete(&si->comp);
 }
 
-static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *si, unsigned long idx)
-{
-	struct swap_cluster_info *ci = list_first_entry(&si->free_clusters,
-							struct swap_cluster_info, list);
-
-	lockdep_assert_held(&si->lock);
-	lockdep_assert_held(&ci->lock);
-	VM_BUG_ON(cluster_index(si, ci) != idx);
-	VM_BUG_ON(ci->count);
-	list_del(&ci->list);
-	ci->flags = 0;
-	return ci;
-}
-
 static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
 	VM_BUG_ON(ci->count != 0);
@@ -472,34 +458,24 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 }
 
 /*
- * The cluster corresponding to page_nr will be used. The cluster will be
- * removed from free cluster list and its usage counter will be increased by
- * count.
+ * The cluster corresponding to page_nr will be used. The cluster will not be
+ * added to free cluster list and its usage counter will be increased by 1.
+ * Only used for initialization.
  */
-static void add_cluster_info_page(struct swap_info_struct *p,
-	struct swap_cluster_info *cluster_info, unsigned long page_nr,
-	unsigned long count)
+static void inc_cluster_info_page(struct swap_info_struct *p,
+	struct swap_cluster_info *cluster_info, unsigned long page_nr)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
-	struct swap_cluster_info *ci = cluster_info + idx;
+	struct swap_cluster_info *ci;
 
 	if (!cluster_info)
 		return;
-	if (cluster_is_free(ci))
-		alloc_cluster(p, idx);
 
-	VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
-	ci->count += count;
-}
+	ci = cluster_info + idx;
+	ci->count++;
 
-/*
- * The cluster corresponding to page_nr will be used. The cluster will be
- * removed from free cluster list and its usage counter will be increased by 1.
- */
-static void inc_cluster_info_page(struct swap_info_struct *p,
-	struct swap_cluster_info *cluster_info, unsigned long page_nr)
-{
-	add_cluster_info_page(p, cluster_info, page_nr, 1);
+	VM_BUG_ON(ci->count > SWAPFILE_CLUSTER);
+	VM_BUG_ON(ci->flags);
 }
 
 /*

-- 
2.46.0.rc1.232.g9752f9e123-goog


