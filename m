Return-Path: <linux-kernel+bounces-259204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1FC939291
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E11A2826F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73F16F0C3;
	Mon, 22 Jul 2024 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHf3266t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930C16EB55;
	Mon, 22 Jul 2024 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665913; cv=none; b=J4bnQ/Yzq2j5gdSqoV2LxuolPX5K5gErNKjVCytb/y1umezVyw4upAvUJYw/kYviL1EN5yuGOxqzISI/X4TLjspUIh/4Py+1FunXBr/I8p4uMdJEpbPDEFzodSec1G+lP1BbUp97WLfBQ/2uZqJOjs+B/8iGvEqwfzuNexaIrmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665913; c=relaxed/simple;
	bh=l9EjIfv6+sSlfSlf2706MZEMzHMLAVB6WTLtNdYV9ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuXPKuF/W3rqkhBwQ0h/eVa/7H7hoeN0ZKoxpbqonSW3PD7uqjMYCFQapiLeUbwsTjavrpskmxGfv9T3Pn2jVpOU8fuXnuj86n1rAVyYxzh0bFkqGbgI+3cB6br69Sa5VjexSLdRAw/UKwGV4lf0m1oU8gMchn6OXiea8FPD6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHf3266t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFDBC4AF11;
	Mon, 22 Jul 2024 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721665913;
	bh=l9EjIfv6+sSlfSlf2706MZEMzHMLAVB6WTLtNdYV9ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VHf3266tBLh5T0zuGEeX8TLkx25+9bXEtG0INx+1LdwxmnN8IjYrw7z+A4VC9EDcC
	 tAOeKJrxempBnDc4SuzAjb6ReaTFHNv4WUJM/152sK4yR1S+k/g7vD1lz+3wn23BPS
	 6FJ9lymAWKXoBuhb02vspq3xVRMEm0kHUb/FCvRCICIfh1jM9etbv1Ln/tz2SrRQ1z
	 KJZWeY6JHFC0bXtFqWXuwAbM85YkH9ZXiM5A8NORx9dWoRR62Bg2kgj6k2QXfUbP89
	 mHXRUQ6SK765EV688MbepBms1SrPfcQz8z32kBdreACuyzmbmkmOd3d4ebNlLNMMUI
	 dZ1HQuJcQLxwg==
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
	christian.koenig@amd.com,
	maz@kernel.org,
	oliver.upton@linux.dev
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Date: Mon, 22 Jul 2024 18:29:24 +0200
Message-ID: <20240722163111.4766-3-dakr@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722163111.4766-1-dakr@kernel.org>
References: <20240722163111.4766-1-dakr@kernel.org>
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
efficiently. For instance, vrealloc() can be optimized to allocate and
map additional pages to grow the allocation or unmap and free unused
pages to shrink the allocation.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 arch/arm64/kvm/nested.c                   |  1 -
 arch/powerpc/platforms/pseries/papr-vpd.c |  5 +-
 drivers/gpu/drm/drm_exec.c                |  3 +-
 fs/xfs/xfs_log_recover.c                  |  2 +-
 include/linux/slab.h                      |  4 +-
 kernel/resource.c                         |  3 +-
 lib/fortify_kunit.c                       |  3 +-
 mm/util.c                                 | 89 +++++++++++++++--------
 8 files changed, 66 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index de789e0f1ae9..1ff3079aabc9 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -62,7 +62,6 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
 	tmp = kvrealloc(kvm->arch.nested_mmus,
-			size_mul(sizeof(*kvm->arch.nested_mmus), kvm->arch.nested_mmus_size),
 			size_mul(sizeof(*kvm->arch.nested_mmus), num_mmus),
 			GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!tmp)
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
index 4423dd344239..1997981827fb 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2128,7 +2128,7 @@ xlog_recover_add_to_cont_trans(
 	old_ptr = item->ri_buf[item->ri_cnt-1].i_addr;
 	old_len = item->ri_buf[item->ri_cnt-1].i_len;
 
-	ptr = kvrealloc(old_ptr, old_len, len + old_len, GFP_KERNEL);
+	ptr = kvrealloc(old_ptr, len + old_len, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	memcpy(&ptr[old_len], dp, len);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..c9cb42203183 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -841,8 +841,8 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 #define kvcalloc_node(...)			alloc_hooks(kvcalloc_node_noprof(__VA_ARGS__))
 #define kvcalloc(...)				alloc_hooks(kvcalloc_noprof(__VA_ARGS__))
 
-extern void *kvrealloc_noprof(const void *p, size_t oldsize, size_t newsize, gfp_t flags)
-		      __realloc_size(3);
+void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags)
+		__realloc_size(2);
 #define kvrealloc(...)				alloc_hooks(kvrealloc_noprof(__VA_ARGS__))
 
 extern void kvfree(const void *addr);
diff --git a/kernel/resource.c b/kernel/resource.c
index 14777afb0a99..9f747bb7cd03 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -450,8 +450,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			/* re-alloc */
 			struct resource *rams_new;
 
-			rams_new = kvrealloc(rams, rams_size * sizeof(struct resource),
-					     (rams_size + 16) * sizeof(struct resource),
+			rams_new = kvrealloc(rams, (rams_size + 16) * sizeof(struct resource),
 					     GFP_KERNEL);
 			if (!rams_new)
 				goto out;
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index f9ad60a9c7bd..ecb638d4cde1 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -306,8 +306,7 @@ DEFINE_ALLOC_SIZE_TEST_PAIR(vmalloc)
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
index bc488f0121a7..0ff5898cc6de 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -608,6 +608,28 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 }
 EXPORT_SYMBOL(vm_mmap);
 
+static gfp_t kmalloc_gfp_adjust(gfp_t flags, size_t size)
+{
+	/*
+	 * We want to attempt a large physically contiguous block first because
+	 * it is less likely to fragment multiple larger blocks and therefore
+	 * contribute to a long term fragmentation less than vmalloc fallback.
+	 * However make sure that larger requests are not too disruptive - no
+	 * OOM killer and no allocation failure warnings as we have a fallback.
+	 */
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
  * __kvmalloc_node - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
@@ -627,32 +649,15 @@ EXPORT_SYMBOL(vm_mmap);
  */
 void *__kvmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
 {
-	gfp_t kmalloc_flags = flags;
 	void *ret;
 
-	/*
-	 * We want to attempt a large physically contiguous block first because
-	 * it is less likely to fragment multiple larger blocks and therefore
-	 * contribute to a long term fragmentation less than vmalloc fallback.
-	 * However make sure that larger requests are not too disruptive - no
-	 * OOM killer and no allocation failure warnings as we have a fallback.
-	 */
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
-	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b), kmalloc_flags, node);
-
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
 	 * requests
 	 */
+	ret = __kmalloc_node_noprof(PASS_BUCKET_PARAMS(size, b),
+				    kmalloc_gfp_adjust(flags, size),
+				    node);
 	if (ret || size <= PAGE_SIZE)
 		return ret;
 
@@ -715,18 +720,42 @@ void kvfree_sensitive(const void *addr, size_t len)
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
+	n = krealloc_noprof(p, size, kmalloc_gfp_adjust(flags, size));
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


