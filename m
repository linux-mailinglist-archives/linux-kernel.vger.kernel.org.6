Return-Path: <linux-kernel+bounces-247038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4275492CA32
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F1E1C21F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E034C631;
	Wed, 10 Jul 2024 05:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwB9O0tj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B131CA87
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720589916; cv=none; b=QTis7x2LvZChy2ZfW5e5oyRDiCU9JHKqErIOCLt7BOCGqHdtJG/LtAQB51q3N22w1M9CQ0wHUo33BagE1wDYKfoN9qHwQvPZ6YZQPvq6gO/IFavfSfrStt2vJ+CkkhmnEtVhEJOE9ezhAq5yQIQRKqUPtSGuzwzYRmXBYZnwlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720589916; c=relaxed/simple;
	bh=it+lZnG8qkE+IDVtq8XvafLTCOle5Ypn5AUBVAIbtok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ob268s3wzF672xg20YRMtfRHNe4jn2plpDRXTrvJ40RI3tFUFHV+p60eQSJgtFoFol5u6JEgIiIUoOdcn55vzBOL9DA/kk6iNikp9qKQnS9Sd4Y6gcXBQPzRtm2eRjdiqHHSYNPRSGVLSUiqZB5+nzfmLTQASbfd28Kalylk7cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwB9O0tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8921C32782;
	Wed, 10 Jul 2024 05:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720589916;
	bh=it+lZnG8qkE+IDVtq8XvafLTCOle5Ypn5AUBVAIbtok=;
	h=From:To:Cc:Subject:Date:From;
	b=rwB9O0tjOmWTH7b+Jobb4sv4nhtpk7dp3Ax0d1ZIjx42t/HjR2M5GLNsv1fftL2kN
	 zJTqVaglzg/nTjChdLWzpUlXfSeeqSubCbh2tZpesARXZXdva3ixJNd5g13MdWe5yi
	 kl8QuazuQv8rdtaF17KI3BCz2fr/Uca838vx0D50bo+7A0H6vjqXMvFMIE11TfHW2Y
	 OtgpGyZAaj5k1UnI7tFWflJ7e9dYziNREcKF8u70Zl5uCaPhHGTUkb41wPNsvimxgq
	 2xclOoVNqblTybM5rA0p9SbxEdmhaSy2yxFh9ivXh1X1wi02q8QOMLfCJWkum9c3sD
	 ghnib4x0WNQaQ==
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
Subject: [PATCH v3 1/2] mm/memcg: alignment memcg_data define condition
Date: Wed, 10 Jul 2024 13:43:35 +0800
Message-ID: <20240710054336.190410-1-alexs@kernel.org>
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
MEMCG to SLAB_OBJ_EXT. And selected SLAB_OBJ_EXT for MEMCG, just for
SLAB_MATCH(memcg_data, obj_exts), even no other relationship between them.

Above action make memcg_data exposed and include SLAB_OBJ_EXT for
!MEMCG. That's incorrect in logcial and pay on code size.

As Vlastimil Babka suggested, let's add _unused_slab_obj_ext for
SLAB_MATCH for slab.obj_exts while !MEMCG. That could resolve the match
issue, clean up the feature logical. And decouple the SLAB_OBJ_EXT from
MEMCG in next patch.

Signed-off-by: Alex Shi (Tencent) <alexs@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoann Congal <yoann.congal@smile.fr>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
---
v1->v3: take Vlastimil's suggestion and move SLAB_OBJ_EXT/MEMCG decouple
to 2nd patch.
---
 include/linux/mm_types.h | 8 ++++++--
 mm/slab.h                | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ef09c4eef6d3..4ac3abc673d3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -180,8 +180,10 @@ struct page {
 	/* Usage count. *DO NOT USE DIRECTLY*. See page_ref.h */
 	atomic_t _refcount;
 
-#ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 	unsigned long memcg_data;
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+	unsigned long _unused_slab_obj_ext;
 #endif
 
 	/*
@@ -343,8 +345,10 @@ struct folio {
 			};
 			atomic_t _mapcount;
 			atomic_t _refcount;
-#ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 			unsigned long memcg_data;
+#elif defined(CONFIG_SLAB_OBJ_EXT)
+			unsigned long _unused_slab_obj_ext;
 #endif
 #if defined(WANT_PAGE_VIRTUAL)
 			void *virtual;
diff --git a/mm/slab.h b/mm/slab.h
index 3586e6183224..8ffdd4f315f8 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -98,7 +98,11 @@ SLAB_MATCH(flags, __page_flags);
 SLAB_MATCH(compound_head, slab_cache);	/* Ensure bit 0 is clear */
 SLAB_MATCH(_refcount, __page_refcount);
 #ifdef CONFIG_SLAB_OBJ_EXT
+#ifdef CONFIG_MEMCG
 SLAB_MATCH(memcg_data, obj_exts);
+#else
+SLAB_MATCH(_unused_slab_obj_ext, obj_exts);
+#endif
 #endif
 #undef SLAB_MATCH
 static_assert(sizeof(struct slab) <= sizeof(struct page));
-- 
2.43.0


