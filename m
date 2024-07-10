Return-Path: <linux-kernel+bounces-247039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D33C92CA33
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB6AB21DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5B1482D8;
	Wed, 10 Jul 2024 05:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMiQltgp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3993D556
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589929; cv=none; b=rZhRUBO5gK1/n2IAFGFp9koY5ER69T3DKEx2j/07JoTVuzZjCKvNfmxlFBUjActh6tEwh8ID3ENcIR/CVf2Z37ajBIaXjWnEJAPI9z6/cNL06D0Bms1ZELMzh46DD8k49Sxk0v9aFhcKFul05U7Ao6mC/LDBecRgDb2tPAOhhxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589929; c=relaxed/simple;
	bh=0d4cP947oug9+yh/lXbN8zl/s8ML5Qlhl1hpGfexJYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnljlsL9Js6g7KkjopWRScNNSeaCOGdDtXEGCy4fKRuq1OeRqtbSy3K4XhGswHfOrjTf1HOcSXVI1zYvz3hcBnIRZZeY2HfBsckJIElc4PX8yYY4YGbHH5ILedGcCiqaQQOqpPw+W2SoFMaE1apIHmt7i/GK6on1d14J2jCA9gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMiQltgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26BDC32781;
	Wed, 10 Jul 2024 05:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720589929;
	bh=0d4cP947oug9+yh/lXbN8zl/s8ML5Qlhl1hpGfexJYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QMiQltgpMUPWs1Q7h76lz62PCZ1OELHV5XkE9PVucBPmq+OA/Gp2FplsZVp0lwX9e
	 ivViTZZ/1hmhDsJR5c5iu+/RCBEBg/Apwj6mVi+cM4P1n0c1e16yMIlDWULRn5U0ef
	 41h+1+vjPg2/xZOgAG4YVeyAz/O+b7S7IZm7sp/EsvkQEUQvlsUqWq1z9ZxU8ka5Ns
	 mWAvIeoZ77vQOUDc+Hd1ErMaA7nBiQYu0Jo3TOPVDIagtsIYXOnHAbukAWZd81K/IU
	 ckQf50+a7kZeoCei1gqvKNaYYYRQnFBP2nc0bJjG8kzb7Ru/vDS+ZWEXbgJgDZBXCI
	 GBnACTH3c+smw==
From: alexs@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Alex Shi (Tencent)" <alexs@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yoann Congal <yoann.congal@smile.fr>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [REF PATCH v3 2/2] mm/slab: decouple the SLAB_OBJ_EXT from MEMCG
Date: Wed, 10 Jul 2024 13:43:36 +0800
Message-ID: <20240710054336.190410-2-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710054336.190410-1-alexs@kernel.org>
References: <20240710054336.190410-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alex Shi (Tencent)" <alexs@kernel.org>

commit 21c690a349ba ("mm: introduce slabobj_ext to support slab object
extensions") selected SLAB_OBJ_EXT on MEMCG just for SLAB_MATCH
memcg_data, that included SLAB_OBJ_EXT for MEMCG. In fact, I didn't see
the necessary to enable SLAB_OBJ_EXT for MEMCG.

Let's decouple the SLAB_OBJ_EXT from MEMCG and move out
alloc_slab_obj_exts() definition from SLAB_OBJ_EXT only. To alignment
the alloc_slab_obj_exts() return 0 for good. change its return value to
'-1' for always failed with !SLAB_OBJ_EXT. Now we could save unnecessary
code from MEMCG but !SLAB_OBJ_EXT.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
---
 init/Kconfig | 1 -
 mm/slab.h    | 6 +++---
 mm/slub.c    | 6 +++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 26bf8bb0a7ce..61e43ac9fe75 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -965,7 +965,6 @@ config MEMCG
 	bool "Memory controller"
 	select PAGE_COUNTER
 	select EVENTFD
-	select SLAB_OBJ_EXT
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
diff --git a/mm/slab.h b/mm/slab.h
index 8ffdd4f315f8..6c727ecc1068 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -559,9 +559,6 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 	return (struct slabobj_ext *)(obj_exts & ~OBJEXTS_FLAGS_MASK);
 }
 
-int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-                        gfp_t gfp, bool new_slab);
-
 #else /* CONFIG_SLAB_OBJ_EXT */
 
 static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
@@ -571,6 +568,9 @@ static inline struct slabobj_ext *slab_obj_exts(struct slab *slab)
 
 #endif /* CONFIG_SLAB_OBJ_EXT */
 
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab);
+
 static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 {
 	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
diff --git a/mm/slub.c b/mm/slub.c
index cc11f3869cc6..f531c2d67238 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2075,10 +2075,10 @@ alloc_tagging_slab_free_hook(struct kmem_cache *s, struct slab *slab, void **p,
 
 #else /* CONFIG_SLAB_OBJ_EXT */
 
-static int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
-			       gfp_t gfp, bool new_slab)
+int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
+			gfp_t gfp, bool new_slab)
 {
-	return 0;
+	return -1;
 }
 
 static inline void free_slab_obj_exts(struct slab *slab)
-- 
2.43.0


