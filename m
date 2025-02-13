Return-Path: <linux-kernel+bounces-514038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54F7A35198
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F2E3ADB3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409112753E3;
	Thu, 13 Feb 2025 22:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjIBpu1k"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC3222D7A1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486857; cv=none; b=sAEQBQAlnmEqd0iHVBqfSyoUkko6qs4Sw11ozfp83TBbBOzpDa9WSpc0xUswlyNDpEpEOWHRu9qsyePW+gz7mimm1517u6qG+s8KzoN7Vdv4wvgm/Djr2Tx/FvbIoHJTjoDbNMpxAQN3mLd6U9l2z9lbJrSGK0bGPCaA4AC7o/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486857; c=relaxed/simple;
	bh=1KeUMAl8R/7P3nk3JbGxsisaDeiJQf3xdjP2Bgr3ggM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EW0HKFZdqnWS6V2ZR6x0wsXwQbYXany+jjk1gQvIfJyxuR2u9Y5MY1EL+8zQ+asmeXFBBOuMtJLS0YqmDWYo+TPoraBk/jA1kFNvjaELkwZp5FXrljGs7rY2UHQvn+NgNvuZJzpXiMkXlAB5lWWMhrqjLiyZWs+N4m5pcu846Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjIBpu1k; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f444af89fso20257005ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486854; x=1740091654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4MXvj5u5NFB0K8/f5IiPMekR+5md5clULG3qbt/TlOg=;
        b=vjIBpu1kuWJvoMtVWCLEEuZYy4kLFROPXgzRRIGvhPOr2RFYV4fxTTOHqslSyRyq2C
         T61Nrwe/W1ySl4VAV5S9+p3FTjmxSozVa3MCdz/97F4T/ov0H2+SVZWQmavLgPLQnw57
         yQXhDZ4BrAv6OM9r4EhMojkp1H+NZFgo3cj8qkShMO3fUBRwYTDsnNt6XRGc9DVkjvMo
         4HiTRdgHczK1Y8ghUZqqzGRo+P6zJ9CKPY/iqoXjLJnWVvw2ozqcVLgxM5ABXVUj4QKx
         OHYPqSGhT8QHgpLM4K8wPEYFlLHAQ/LZAG41mNq3qTxLsD/qe9aSPpXkh1zxJq3M7JhA
         iYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486854; x=1740091654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MXvj5u5NFB0K8/f5IiPMekR+5md5clULG3qbt/TlOg=;
        b=MEHooeXCvxa20INrklTTh5yNgYYQWl1WZrEuo9RTdc/WPa3nvcuBL1cRbhhFeiEH8t
         IU9bEJha8fr3cxtrphcxaDRfyom6+Mk8JMPV2lbI7cQdHmG4vRZzUtsqhjE9d6F1oQcz
         PLsXxMC8uNplFsveCDme51/tEKR7UYVkusdWKwEXXlorRDJfxZdUE5VThWabNRchPdGh
         WqUX724oUgQ5AcoUhMkVnxU3uKu5+K8mLSzkT0ktHS9Qw/jOMa1aeFRAIe+wvZIS6EZt
         GYaQr3FGW4qSv+jEUSsHQkrfmXSj0cJMMjSzO8LO8RD5nuIx0snxlOCvG+1RmcjC/3sM
         eCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCKRkLnFOpghthZA2BguUrpeNJh2VdpBXXx4s9AHE3vhsQMzW0KVOQGUwKOGLfqZ19bolcAW1N5V3yHMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUn057J4vPozbtxpIDMIHf7oXKAqCcXnnmqlhzqwGkyMj5ray
	+DOkMbI+jU2h1jXMpzwsBRL081zClTtO8QH5S9vbxtH2crmWMiWnDLqCf90HLngdcK9Zd7HIA8o
	DKA==
X-Google-Smtp-Source: AGHT+IFObHFHIWBZFemkWn8ckufyLtHvFFGrsnemtMs+Zktx9OES6MSNojKQ+ZzlKftfhzzQkT2kzbGTjvc=
X-Received: from pgid14.prod.google.com ([2002:a63:ed0e:0:b0:801:e378:a64a])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4d2:b0:21f:1ae1:dd26
 with SMTP id d9443c01a7336-220bbcd0acbmr133795865ad.52.1739486853879; Thu, 13
 Feb 2025 14:47:33 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:54 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-18-surenb@google.com>
Subject: [PATCH v10 17/18] mm: make vma cache SLAB_TYPESAFE_BY_RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, mhocko@suse.com, 
	vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
object reuse before RCU grace period is over will be detected by
lock_vma_under_rcu().
Current checks are sufficient as long as vma is detached before it is
freed. The only place this is not currently happening is in exit_mmap().
Add the missing vma_mark_detached() in exit_mmap().
Another issue which might trick lock_vma_under_rcu() during vma reuse
is vm_area_dup(), which copies the entire content of the vma into a new
one, overriding new vma's vm_refcnt and temporarily making it appear as
attached. This might trick a racing lock_vma_under_rcu() to operate on
a reused vma if it found the vma before it got reused. To prevent this
situation, we should ensure that vm_refcnt stays at detached state (0)
when it is copied and advances to attached state only after it is added
into the vma tree. Introduce vm_area_init_from() which preserves new
vma's vm_refcnt and use it in vm_area_dup(). Since all vmas are in
detached state with no current readers when they are freed,
lock_vma_under_rcu() will not be able to take vm_refcnt after vma got
detached even if vma is reused. vma_mark_attached() in modified to
include a release fence to ensure all stores to the vma happen before
vm_refcnt gets initialized.
Finally, make vm_area_cachep SLAB_TYPESAFE_BY_RCU. This will facilitate
vm_area_struct reuse and will minimize the number of call_rcu() calls.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
Changes since v9 [1]:
- Use refcount_set_release() in vma_mark_attached(), per Will Deacon

[1] https://lore.kernel.org/all/20250111042604.3230628-17-surenb@google.com/

 include/linux/mm.h               |  4 +-
 include/linux/mm_types.h         | 13 ++++--
 include/linux/slab.h             |  6 ---
 kernel/fork.c                    | 73 ++++++++++++++++++++------------
 mm/mmap.c                        |  3 +-
 mm/vma.c                         | 11 ++---
 mm/vma.h                         |  2 +-
 tools/include/linux/refcount.h   |  5 +++
 tools/testing/vma/linux/atomic.h |  1 +
 tools/testing/vma/vma_internal.h |  9 +---
 10 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 88693568c9ef..7b21b48627b0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -258,8 +258,6 @@ void setup_initial_init_mm(void *start_code, void *end_code,
 struct vm_area_struct *vm_area_alloc(struct mm_struct *);
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
 void vm_area_free(struct vm_area_struct *);
-/* Use only if VMA has no other users */
-void __vm_area_free(struct vm_area_struct *vma);
 
 #ifndef CONFIG_MMU
 extern struct rb_root nommu_region_tree;
@@ -890,7 +888,7 @@ static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
 	vma_assert_write_locked(vma);
 	vma_assert_detached(vma);
-	refcount_set(&vma->vm_refcnt, 1);
+	refcount_set_release(&vma->vm_refcnt, 1);
 }
 
 void vma_mark_detached(struct vm_area_struct *vma);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 63ab51699120..689b2a746189 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -584,6 +584,12 @@ static inline void *folio_get_private(struct folio *folio)
 
 typedef unsigned long vm_flags_t;
 
+/*
+ * freeptr_t represents a SLUB freelist pointer, which might be encoded
+ * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
+ */
+typedef struct { unsigned long v; } freeptr_t;
+
 /*
  * A region containing a mapping of a non-memory backed file under NOMMU
  * conditions.  These are held in a global tree and are pinned by the VMAs that
@@ -687,6 +693,9 @@ struct vma_numab_state {
  *
  * Only explicitly marked struct members may be accessed by RCU readers before
  * getting a stable reference.
+ *
+ * WARNING: when adding new members, please update vm_area_init_from() to copy
+ * them during vm_area_struct content duplication.
  */
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
@@ -697,9 +706,7 @@ struct vm_area_struct {
 			unsigned long vm_start;
 			unsigned long vm_end;
 		};
-#ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
-#endif
+		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
 	};
 
 	/*
diff --git a/include/linux/slab.h b/include/linux/slab.h
index ad902a2d692b..f8924fd6ea26 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -243,12 +243,6 @@ enum _slab_flag_bits {
 #define SLAB_NO_OBJ_EXT		__SLAB_FLAG_UNUSED
 #endif
 
-/*
- * freeptr_t represents a SLUB freelist pointer, which might be encoded
- * and not dereferenceable if CONFIG_SLAB_FREELIST_HARDENED is enabled.
- */
-typedef struct { unsigned long v; } freeptr_t;
-
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/kernel/fork.c b/kernel/fork.c
index 48a0038f606f..364b2d4fd3ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -449,6 +449,42 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 	return vma;
 }
 
+static void vm_area_init_from(const struct vm_area_struct *src,
+			      struct vm_area_struct *dest)
+{
+	dest->vm_mm = src->vm_mm;
+	dest->vm_ops = src->vm_ops;
+	dest->vm_start = src->vm_start;
+	dest->vm_end = src->vm_end;
+	dest->anon_vma = src->anon_vma;
+	dest->vm_pgoff = src->vm_pgoff;
+	dest->vm_file = src->vm_file;
+	dest->vm_private_data = src->vm_private_data;
+	vm_flags_init(dest, src->vm_flags);
+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
+	       sizeof(dest->vm_page_prot));
+	/*
+	 * src->shared.rb may be modified concurrently when called from
+	 * dup_mmap(), but the clone will reinitialize it.
+	 */
+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
+	       sizeof(dest->vm_userfaultfd_ctx));
+#ifdef CONFIG_ANON_VMA_NAME
+	dest->anon_name = src->anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
+	       sizeof(dest->swap_readahead_info));
+#endif
+#ifndef CONFIG_MMU
+	dest->vm_region = src->vm_region;
+#endif
+#ifdef CONFIG_NUMA
+	dest->vm_policy = src->vm_policy;
+#endif
+}
+
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 {
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
@@ -458,11 +494,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
 	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-	/*
-	 * orig->shared.rb may be modified concurrently, but the clone
-	 * will be reinitialized.
-	 */
-	data_race(memcpy(new, orig, sizeof(*new)));
+	vm_area_init_from(orig, new);
 	vma_lock_init(new, true);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 	vma_numab_state_init(new);
@@ -471,7 +503,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	return new;
 }
 
-void __vm_area_free(struct vm_area_struct *vma)
+void vm_area_free(struct vm_area_struct *vma)
 {
 	/* The vma should be detached while being destroyed. */
 	vma_assert_detached(vma);
@@ -480,25 +512,6 @@ void __vm_area_free(struct vm_area_struct *vma)
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
-#ifdef CONFIG_PER_VMA_LOCK
-static void vm_area_free_rcu_cb(struct rcu_head *head)
-{
-	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
-						  vm_rcu);
-
-	__vm_area_free(vma);
-}
-#endif
-
-void vm_area_free(struct vm_area_struct *vma)
-{
-#ifdef CONFIG_PER_VMA_LOCK
-	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
-#else
-	__vm_area_free(vma);
-#endif
-}
-
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -3156,6 +3169,11 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
+
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3172,8 +3190,9 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = KMEM_CACHE(vm_area_struct,
-			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
diff --git a/mm/mmap.c b/mm/mmap.c
index 6401a1d73f4a..15d6cd7cc845 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1305,7 +1305,8 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, /* unreachable = */ true);
+		vma_mark_detached(vma);
+		remove_vma(vma);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index a16a83d0253f..c7abef5177cc 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -420,19 +420,14 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable)
+void remove_vma(struct vm_area_struct *vma)
 {
 	might_sleep();
 	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
-	if (unreachable) {
-		vma_mark_detached(vma);
-		__vm_area_free(vma);
-	} else {
-		vm_area_free(vma);
-	}
+	vm_area_free(vma);
 }
 
 /*
@@ -1218,7 +1213,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, /* unreachable = */ false);
+		remove_vma(vma);
 
 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
diff --git a/mm/vma.h b/mm/vma.h
index 55be77ff042f..7356ca5a22d3 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -218,7 +218,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);
 
-void remove_vma(struct vm_area_struct *vma, bool unreachable);
+void remove_vma(struct vm_area_struct *vma);
 
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
diff --git a/tools/include/linux/refcount.h b/tools/include/linux/refcount.h
index 36cb29bc57c2..1ace03e1a4f8 100644
--- a/tools/include/linux/refcount.h
+++ b/tools/include/linux/refcount.h
@@ -60,6 +60,11 @@ static inline void refcount_set(refcount_t *r, unsigned int n)
 	atomic_set(&r->refs, n);
 }
 
+static inline void refcount_set_release(refcount_t *r, unsigned int n)
+{
+	atomic_set_release(&r->refs, n);
+}
+
 static inline unsigned int refcount_read(const refcount_t *r)
 {
 	return atomic_read(&r->refs);
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
index 788c597c4fde..683383d0f2bf 100644
--- a/tools/testing/vma/linux/atomic.h
+++ b/tools/testing/vma/linux/atomic.h
@@ -7,6 +7,7 @@
 #define atomic_inc(x) uatomic_inc(x)
 #define atomic_read(x) uatomic_read(x)
 #define atomic_set(x, y) uatomic_set(x, y)
+#define atomic_set_release(x, y) uatomic_set(x, y)
 #define U8_MAX UCHAR_MAX
 
 #ifndef atomic_cmpxchg_relaxed
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index b385170fbb8f..572ab2cea763 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -476,7 +476,7 @@ static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
 	vma_assert_write_locked(vma);
 	vma_assert_detached(vma);
-	refcount_set(&vma->vm_refcnt, 1);
+	refcount_set_release(&vma->vm_refcnt, 1);
 }
 
 static inline void vma_mark_detached(struct vm_area_struct *vma)
@@ -696,14 +696,9 @@ static inline void mpol_put(struct mempolicy *)
 {
 }
 
-static inline void __vm_area_free(struct vm_area_struct *vma)
-{
-	free(vma);
-}
-
 static inline void vm_area_free(struct vm_area_struct *vma)
 {
-	__vm_area_free(vma);
+	free(vma);
 }
 
 static inline void lru_add_drain(void)
-- 
2.48.1.601.g30ceb7b040-goog


