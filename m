Return-Path: <linux-kernel+bounces-255764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714EE9344D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 00:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27841284AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705A6CDCC;
	Wed, 17 Jul 2024 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TU1wOqp3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCC664A98;
	Wed, 17 Jul 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721255134; cv=none; b=Qoq6sYxtUU7GhmPkc7TkntUYTPUyXCo5a4J81FfF1sqYDhqJbCPFgsxwPFOLLGLNC3Or1MWcz1wuZq6vo0l4hf2xKQSL36KEXO1EwXbcOQnoZ2Nd1w0w70uW+Ww+LiE9g1ZJkA8Mn7MWDnDy9jbcTTeMgTieizpCk9TT0kzyQIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721255134; c=relaxed/simple;
	bh=q6Wwch18E7w/rj6z/NtXtCgXxoq1cCuw2p/00HKzoug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDT8ubF8rwlKGWvQldcNmNhs38yqhCSpLKgj8VvKj98AXb3I4yBiTOG9eDiMXB53RVCqtDJbofkaBltz1MGTdxiLfUuf2FZrug8JsaGVmm+gw1+3RDugAXSYTS0rIUW83zeNyWlmH6x1Pp/L97fm985UjDLLeiMfMZH+lzCb+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU1wOqp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26296C2BD10;
	Wed, 17 Jul 2024 22:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721255134;
	bh=q6Wwch18E7w/rj6z/NtXtCgXxoq1cCuw2p/00HKzoug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TU1wOqp3HqZeeURDJIDlL2o2KRjuK80l5lZxxJkdvvG3NwNrd7Bfoff7B0aGFzSUO
	 E2PYgrbgVop0vwAH1xUIZSzOwQUQXuJcOkQ2e0qnGu880I6GQa2q0JK21PlRuHiMYA
	 bOnJfK6tIytukZMFLd9eemS8pkTxH/B11b1tVA4VFj1q0VCg26IbJaXve/ZF+5gN/J
	 8px0llDgAw7BQZa83S470IIiY4NJcGbTxJeTnDT8EqpKn0I7kxwUJZLihx5V5/z9ld
	 ydzMi1RLJgJKO3gEZ4pE3ZbtysErMUiU0/ixJ7WnRr5VLOtJ1pXmrqn5bzaafI3LCe
	 jlP/5Uc8Ghevg==
From: Danilo Krummrich <dakr@kernel.org>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	urezki@gmail.com,
	hch@infradead.org,
	kees@kernel.org,
	ojeda@kernel.org,
	wedsonaf@gmail.com,
	mhocko@kernel.org,
	mpe@ellerman.id.au,
	chandan.babu@oracle.com,
	christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Date: Thu, 18 Jul 2024 00:24:02 +0200
Message-ID: <20240717222427.2211-3-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717222427.2211-1-dakr@kernel.org>
References: <20240717222427.2211-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Besides the obvious (and desired) difference between krealloc() and
kvrealloc(), there is some inconsistency in their function signatures
and behavior:

 - krealloc() frees the memory when the requested size is zero, whereas
   kvrealloc() simply returns a pointer to the existing allocation.

 - krealloc() behaves like kmalloc() if a NULL pointer is passed, whereas
   kvrealloc() does not accept a NULL pointer at all and, if passed,
   would fault instead.

 - krealloc() is self-contained, whereas kvrealloc() relies on the caller
   to provide the size of the previous allocation.

Inconsistent behavior throughout allocation APIs is error prone, hence make
kvrealloc() behave like krealloc(), which seems superior in all mentioned
aspects.

Besides that, implementing kvrealloc() by making use of krealloc() and
vrealloc() provides oppertunities to grow (and shrink) allocations more
efficiently. For instance, vrealloc() could be optimized to extend the
existing allocation if there is enough contiguous space left in the
virtual address space at the end of the existing allocation.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 arch/powerpc/platforms/pseries/papr-vpd.c |  5 +-
 drivers/gpu/drm/drm_exec.c                |  3 +-
 fs/xfs/xfs_log_recover.c                  |  2 +-
 include/linux/slab.h                      |  3 +-
 kernel/resource.c                         |  3 +-
 lib/fortify_kunit.c                       |  3 +-
 mm/util.c                                 | 72 ++++++++++++++++-------
 7 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr-vpd.c b/arch/powerpc/platforms/pseries/papr-vpd.c
index c29e85db5f35..1574176e3ffc 100644
--- a/arch/powerpc/platforms/pseries/papr-vpd.c
+++ b/arch/powerpc/platforms/pseries/papr-vpd.c
@@ -156,10 +156,7 @@ static int vpd_blob_extend(struct vpd_blob *blob, const char *data, size_t len)
 	const char *old_ptr = blob->data;
 	char *new_ptr;
 
-	new_ptr = old_ptr ?
-		kvrealloc(old_ptr, old_len, new_len, GFP_KERNEL_ACCOUNT) :
-		kvmalloc(len, GFP_KERNEL_ACCOUNT);
-
+	new_ptr = kvrealloc(old_ptr, new_len, GFP_KERNEL_ACCOUNT);
 	if (!new_ptr)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 2da094bdf8a4..18e366cc4993 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -145,8 +145,7 @@ static int drm_exec_obj_locked(struct drm_exec *exec,
 		size_t size = exec->max_objects * sizeof(void *);
 		void *tmp;
 
-		tmp = kvrealloc(exec->objects, size, size + PAGE_SIZE,
-				GFP_KERNEL);
+		tmp = kvrealloc(exec->objects, size + PAGE_SIZE, GFP_KERNEL);
 		if (!tmp)
 			return -ENOMEM;
 
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 4fe627991e86..bbe5ecb2345b 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2132,7 +2132,7 @@ xlog_recover_add_to_cont_trans(
 	old_ptr = item->ri_buf[item->ri_cnt-1].i_addr;
 	old_len = item->ri_buf[item->ri_cnt-1].i_len;
 
-	ptr = kvrealloc(old_ptr, old_len, len + old_len, GFP_KERNEL);
+	ptr = kvrealloc(old_ptr, len + old_len, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	memcpy(&ptr[old_len], dp, len);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7247e217e21b..41ede46d3bd2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -808,8 +808,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 #define kvcalloc_node(...)			alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
 #define kvcalloc(...)				alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
 
-extern void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
-		      __realloc_size(3);
+extern void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags) __realloc_size(2);
 #define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
 
 extern void kvfree(const void *addr);
diff --git a/kernel/resource.c b/kernel/resource.c
index fcbca39dbc45..46e064c8dce2 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -458,8 +458,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			/* re-alloc */
 			struct resource *rams_new;
 
-			rams_new = kvrealloc(rams, rams_size * sizeof(struct resource),
-					     (rams_size + 16) * sizeof(struct resource),
+			rams_new = kvrealloc(rams, (rams_size + 16) * sizeof(struct resource),
 					     GFP_KERNEL);
 			if (!rams_new)
 				goto out;
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 27ea8bf0252c..acbdc7855100 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -308,8 +308,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(vmalloc)
 	orig = kvmalloc(prev_size, gfp);				\
 	KUNIT_EXPECT_TRUE(test, orig != NULL);				\
 	checker(((expected_pages) * PAGE_SIZE) * 2,			\
-		kvrealloc(orig, prev_size,				\
-			  ((alloc_pages) * PAGE_SIZE) * 2, gfp),	\
+		kvrealloc(orig, ((alloc_pages) * PAGE_SIZE) * 2, gfp),	\
 		kvfree(p));						\
 } while (0)
 DEFINE_ALLOC_SIZE_TEST_PAIR(kvmalloc)
diff --git a/mm/util.c b/mm/util.c
index 983baf2bd675..6a4eb9c1d9b7 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -598,6 +598,21 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_mmap);
 
+static gfp_t to_kmalloc_flags(gfp_t flags, size_t size)
+{
+	if (size > PAGE_SIZE) {
+		flags |= __GFP_NOWARN;
+
+		if (!(flags & __GFP_RETRY_MAYFAIL))
+			flags |= __GFP_NORETRY;
+
+		/* nofail semantic is implemented by the vmalloc fallback */
+		flags &= ~__GFP_NOFAIL;
+	}
+
+	return flags;
+}
+
 /**
  * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
@@ -616,7 +631,6 @@ EXPORT_SYMBOL(vm_mmap);
  */
 void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
-	gfp_t kmalloc_flags = flags;
 	void *ret;
 
 	/*
@@ -626,17 +640,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 	 * However make sure that larger requests are not too disruptive - no
 	 * OOM killer and no allocation failure warnings as we have a fallback.
 	 */
-	if (size > PAGE_SIZE) {
-		kmalloc_flags |= __GFP_NOWARN;
-
-		if (!(kmalloc_flags & __GFP_RETRY_MAYFAIL))
-			kmalloc_flags |= __GFP_NORETRY;
-
-		/* nofail semantic is implemented by the vmalloc fallback */
-		kmalloc_flags &= ~__GFP_NOFAIL;
-	}
-
-	ret = kmalloc_node_noprof(size, kmalloc_flags, node);
+	ret = kmalloc_node_noprof(size, to_kmalloc_flags(flags, size), node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -704,18 +708,42 @@ void kvfree_sensitive(const void *addr, size_t len)
 }
 EXPORT_SYMBOL(kvfree_sensitive);
 
-void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
+/**
+ * kvrealloc - reallocate memory; contents remain unchanged
+ * @p: object to reallocate memory for
+ * @size: the size to reallocate
+ * @flags: the flags for the page level allocator
+ *
+ * The contents of the object pointed to are preserved up to the lesser of the
+ * new and old size (__GFP_ZERO flag is effectively ignored).
+ *
+ * If @p is %NULL, kvrealloc() behaves exactly like kvmalloc(). If @size is 0
+ * and @p is not a %NULL pointer, the object pointed to is freed.
+ *
+ * Return: pointer to the allocated memory or %NULL in case of error
+ */
+void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
 {
-	void *newp;
+	void *n;
+
+	if (is_vmalloc_addr(p))
+		return vrealloc_noprof(p, size, flags);
+
+	n = krealloc_noprof(p, size, to_kmalloc_flags(flags, size));
+	if (!n) {
+		/* We failed to krealloc(), fall back to kvmalloc(). */
+		n = kvmalloc_noprof(size, flags);
+		if (!n)
+			return NULL;
+
+		if (p) {
+			/* We already know that `p` is not a vmalloc address. */
+			memcpy(n, p, ksize(p));
+			kfree(p);
+		}
+	}
 
-	if (oldsize >= newsize)
-		return (void *)p;
-	newp = kvmalloc_noprof(newsize, flags);
-	if (!newp)
-		return NULL;
-	memcpy(newp, p, oldsize);
-	kvfree(p);
-	return newp;
+	return n;
 }
 EXPORT_SYMBOL(kvrealloc_noprof);
 
-- 
2.45.2


