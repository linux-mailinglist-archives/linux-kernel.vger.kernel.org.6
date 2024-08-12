Return-Path: <linux-kernel+bounces-283857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BABBA94F9B2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 00:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 464E2B22940
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187619923F;
	Mon, 12 Aug 2024 22:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgwnhIBt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA2E199238
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502240; cv=none; b=KucicxyMpjqfsH7rCLYmtCquBXJQn66DucmIgtN1fN4FCgPtaZ9eljlHlCHpNKuRwHmbUgt4FR+n3HiuxqqtcXRHcm61LqibUKX4L4Ps4mtw1GUUjzX4qzACsdtnzTfzYtmXyFlEjiQcrgLq0k0gruiaKQEoiqLv3TCcTTVk0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502240; c=relaxed/simple;
	bh=raeKwom20BEIx8mfvC/p6iMwG5L5vKHG/+gLhpcw2wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IpB0u9IM5oeY9bkhla9H6OVVbA6lMTyQvXzfbjhF9TYrB8ruVOJEHiRCbYkYE+o7Q0b7vGisbirQ4TmjlCr5Cj1hxqsZ+LuGFS+CAgE/NJ4tbEoyxqlNndfDxW3R0y35MEGMNWu+nQhmAWH3SaX+cxxcm4z2MoU0c5l+Emo16uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgwnhIBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91499C4AF0E;
	Mon, 12 Aug 2024 22:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502239;
	bh=raeKwom20BEIx8mfvC/p6iMwG5L5vKHG/+gLhpcw2wU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgwnhIBtrgdzhJrEEVGhm+SZ9S75g8uE4ZD/Z6YnWtAcDhIiTr3u2QUucxhDTE3Jx
	 Fz2nqABIzpCgORqas1LsGv+vYKrG6ry8k45ZK26wbJN5Dn5vwxYmJ7q5IB9uatbb0J
	 9LoSAg5v0HBlXSzATbuZgGcqk7GCq+lKznAlJzg1tbDMz7cEntEkYeI1jDKLTaHi4V
	 G4sSC4NJ5KZH3IqzMcJN8mmPXLE3OCTH2vR7SLnPZvjGu07lMPA1b+rqtffXV3A5Qw
	 g9kKZYkTA4D/bHp/xSsJ67vNXacGLyqHE1Gv4zFKl1sTNZn3bKQJy3uosLpNhRz70X
	 Av317cUR7y90Q==
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
Subject: [PATCH v2 2/2] mm: krealloc: clarify valid usage of __GFP_ZERO
Date: Tue, 13 Aug 2024 00:34:35 +0200
Message-ID: <20240812223707.32049-2-dakr@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812223707.32049-1-dakr@kernel.org>
References: <20240812223707.32049-1-dakr@kernel.org>
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
Changes in v2:
 - additionally to what we require callers to do, briefly explain what the
   implementation does (Andrew)
---
 include/linux/slab.h | 10 ++++++++++
 mm/slab_common.c     | 20 ++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c9cb42203183..2282e67a01c7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -733,6 +733,16 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
  * @new_n: new number of elements to alloc
  * @new_size: new size of a single member of the array
  * @flags: the type of memory to allocate (see kmalloc)
+ *
+ * If __GFP_ZERO logic is requested, callers must ensure that, starting with the
+ * initial memory allocation, every subsequent call to this API for the same
+ * memory allocation is flagged with __GFP_ZERO. Otherwise, it is possible that
+ * __GFP_ZERO is not fully honored by this API.
+ *
+ * See krealloc_noprof() for further details.
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
  */
 static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(void *p,
 								       size_t new_n,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cff602cedf8e..1b380eb3b4f2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1301,11 +1301,27 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
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
+ * This is the case, since krealloc() only knows about the bucket size of an
+ * allocation (but not the exact size it was allocated with) and hence
+ * implements the following semantics for shrinking and growing buffers with
+ * __GFP_ZERO.
+ *
+ *         new             bucket
+ * 0       size             size
+ * |--------|----------------|
+ * |  keep  |      zero      |
+ *
+ * In any case, the contents of the object pointed to are preserved up to the
+ * lesser of the new and old sizes.
+ *
  * Return: pointer to the allocated memory or %NULL in case of error
  */
 void *krealloc_noprof(const void *p, size_t new_size, gfp_t flags)
-- 
2.46.0


