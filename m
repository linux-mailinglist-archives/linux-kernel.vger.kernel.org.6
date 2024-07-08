Return-Path: <linux-kernel+bounces-243885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E1C929C25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B7E281440
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C50013AF9;
	Mon,  8 Jul 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJIjQAs5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803E9125DE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420052; cv=none; b=rMbdqCebda8K7VwlZfTSV0OCnKXpSdme501ft8d2n08fZ1JZW16J9n6ZhFAdZbnq5GC8ppZR+ap1BDDapDOyIOsqg7nZ0m3wHxlB8/ITKGmf2Hn/CFTv7VPSxAqCbdC/FWHBhi+Uiqs9I4LYqrldHw3turozQ49/pCBQK9IyDmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420052; c=relaxed/simple;
	bh=q7EkaLpJ/goiOKVT9D8Ig3s/2pCWyrNA2sFi+gAcE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckvjXmFZdljpGpLFA5/EuJqSoL6JJVIc97EUJzTf06nAOG4H2SkI/TRCV356NX5KxoKoJbZhhuj0688vc6AEIYMOKLCUlms5xaz70DWPBOBhnADeaz7mr4iDMNDCd/gsdqYoT/d6ci4q6gbVNnLu8DH3BzhnqzahO+mKWktyRZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJIjQAs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60DDC116B1;
	Mon,  8 Jul 2024 06:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720420052;
	bh=q7EkaLpJ/goiOKVT9D8Ig3s/2pCWyrNA2sFi+gAcE8c=;
	h=From:To:Cc:Subject:Date:From;
	b=sJIjQAs5ZGXjbLeP++6RmvZHC0YRyCHMnt4tZx/Lf73m6icR9LOiXmmd1a0oQjGku
	 Yuw7ZthHhCeghr1avEhndKIk1BKh38M2/GVn/LWQrlKvPcXNjoy1plYUUxcL7MPStE
	 enWR5fw3NWaZbH+wbGROz1htD1r2m+/IJuEUhCmLE3+YaOUA1KAEJ6Sjw5jNmcZEH+
	 B0wjq/rJCnxq3Dp9n9NQj1ZmsSmlK20m/+T1ZXk9LyGzVdDX6H+OsvGx9R4mjwfEhe
	 JiIAJhq3CEBmoP1CPOIaNuQnttD665cV2Ent+9OIkpduOPxd4BQaFT1DnvRVXitVVn
	 OABcqRzNRkSHg==
From: alexs@kernel.org
To: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org (open list)
Cc: "Alex Shi (Tencent)" <alexs@kernel.org>
Subject: [PATCH] mm/memcg: alignment memcg_data define condition
Date: Mon,  8 Jul 2024 14:32:36 +0800
Message-ID: <20240708063236.1096395-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (Tencent)" <alexs@kernel.org>

commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
extensions") changed the folio/page->memcg_data define condition from
MEMCG to SLAB_OBJ_EXT. The code works well, since config SLAB_OBJ_EXT is
fold into MEMCG in init/Kconfig.

But many related functions that deal with memcg_data still defined under
MEMCG instead of SLAB_OBJ_EXT, and FOLIO_MATCH with memcg_data are defined
under MEMCG too. That looks weird and incorrect with memcg_data raw
meaning.

So let's put memcg_data under MEMCG config to alignment the definition
with FOLIO_MATCH and its usage in functions.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ef09c4eef6d3..c067db6fa711 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -180,7 +180,7 @@ struct page {
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-#ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
 #endif
 
@@ -343,7 +343,7 @@ struct folio {
 			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
-#ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
 #endif
 #if defined(WANT_PAGE_VIRTUAL)
-- 
2.43.0


