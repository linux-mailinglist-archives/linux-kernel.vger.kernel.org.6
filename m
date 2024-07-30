Return-Path: <linux-kernel+bounces-268147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4F49420D0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975D51C22F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957818C92D;
	Tue, 30 Jul 2024 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz3I3PPg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2861B18CBF8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368543; cv=none; b=hztZVhXl7o6pgFg7ttZe8Ebewa3uP/3fu+P8DeVimf1kT/5CKiwCw0GEl9utZ3M8iV+WclUN+e1Nvacrf3No6ARRsr+dz3hhGKqObj0/k7bPF9D2EJ1mHAQhJzXYu9cl9B8Q3jY/5DhfL1LBL8OdrfRq2ny1UbOE6oVn807cNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368543; c=relaxed/simple;
	bh=M76h9UGEvDOvQR6+2Hn3EAWaBbezIN4frYXV3T3puu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2aZVAifh1JSgKV+ZhAEUAHAbQLVpfSWiVnAy/RdPr2FxDYLhzfjQqZrC60T4V0FaBNTvPJeWgFKXEdD4mTJYybpWae4l/U2D9C7kPOuV5b6A75n2Yi7FBhHzvYeykdlGlvbz0RdzTAERx42fjZ2RsYJvnePKR1L/HSf4eEF5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz3I3PPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA1AC4AF0A;
	Tue, 30 Jul 2024 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368542;
	bh=M76h9UGEvDOvQR6+2Hn3EAWaBbezIN4frYXV3T3puu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hz3I3PPgpwhw3lVSMpgtM9ztVA3tbfI3MKtbxzj+0dqVYZnDDiwozDj8zEop394Cg
	 Lo4e9zEyKWlHpuwes3fvlngGhlKbyJ3hEfxUckaBRS8L4XYmHhfNGkGrHH4LwRFp2d
	 gmSUg53aPKuRhlU2exxn36PshWOinMgX2bl3ZpmINY16Two2v7FM5XcCx7ZuG6yqX/
	 t7DVl5p2nTwixIb9yqcJSqSlsM8NlCBn8hPAzkCGpqgAD39qhx/7JPa8R3zbLAdF3e
	 8F+baNJp21sb5CKXM0Ya0JuaXP5kaEj7OWUc7KsCsbju0tjkN4OsaAYA3D8bOUJ57y
	 Pt0i6ic5OCsEQ==
From: Danilo Krummrich <dakr@kernel.org>
To: akpm@linux-foundation.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/2] mm: krealloc: clarify valid usage of __GFP_ZERO
Date: Tue, 30 Jul 2024 21:42:06 +0200
Message-ID: <20240730194214.31483-2-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730194214.31483-1-dakr@kernel.org>
References: <20240730194214.31483-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properly document that if __GFP_ZERO logic is requested, callers must
ensure that, starting with the initial memory allocation, every
subsequent call to this API for the same memory allocation is flagged
with __GFP_ZERO. Otherwise, it is possible that __GFP_ZERO is not fully
honored by this API.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 include/linux/slab.h |  8 ++++++++
 mm/slab_common.c     | 10 ++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c9cb42203183..26f14c04000a 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -733,6 +733,14 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
  * @new_n: new number of elements to alloc
  * @new_size: new size of a single member of the array
  * @flags: the type of memory to allocate (see kmalloc)
+ *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
  */
 static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(void *p,
 								       size_t new_n,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cff602cedf8e..faa13f42b111 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1301,11 +1301,17 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
  * @new_size: how many bytes of memory are required.
  * @flags: the type of memory to allocate.
  *
- * The contents of the object pointed to are preserved up to the
- * lesser of the new and old sizes (__GFP_ZERO flag is effectively ignored).
  * If @p is %NULL, krealloc() behaves exactly like kmalloc().  If @new_size
  * is 0 and @p is not a %NULL pointer, the object pointed to is freed.
  *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
+ *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
 void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
-- 
2.45.2


