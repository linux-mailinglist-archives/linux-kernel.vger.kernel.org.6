Return-Path: <linux-kernel+bounces-435765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C229E7C00
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A41316D7E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AE92147F0;
	Fri,  6 Dec 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0eTDpMW"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F83213E81
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525537; cv=none; b=lI5MeuiNPZmGz6WxM33+oiKLpmOiXIdiDJ1ebmbxGa6uSv+G6A6TzXoad87SPcwMRYHP4aNl5Q0YGlYdP79fW4SeECaOWZsYzh9j+wAgda91ZwBxXHShDouHFg7xbkQWAmavY4HbKHQu/mnKw4Tz7hWrOwx21MEtzCLyJnTnADk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525537; c=relaxed/simple;
	bh=+Y7GyVaJVqChVxJXlxPgNwWTN8ML6a/45dk/ORefJis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mgybtyFldZAWE62ajQRhNaKu+zulCCxF2zY/ohOAlhfoSLY1zGX6N4iOskACFiRNR2zACJaEfVW90tqL9d0akdsqTF9F8AtjddujiwaZTPxMI1wDTGcets0eNNZ9Hmzl3SBgyVzIDiFM1GWi6uDWaNJjN4r1ADiITyeCRrGuJa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0eTDpMW; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2153861c470so24349505ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 14:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733525535; x=1734130335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xWkv895t2vkmivZEcKc0VmEj0Py63DFJG/LYdHvb3Y=;
        b=H0eTDpMWTpNe9+PmAf6rdiLr2nAVZpFt9a904UXcC3aDI/OyjdXD66vW2wcClUoEqd
         6c1gMfJlSMTiGJueleHSfCm3Z1M+tH18VFNFoyMXS0qvAflIyKPTtxSuKyu3iPP6Tbnu
         deQ1LrF8NeO7RZDgyj3p82SbPdAmKw6xDrJ5HW6egatu8uMbtVT8VRyRRdlFn8lrIqED
         dy1i/IlOMvK5mpNFRJSEWFzwlIniU88R+8fIBXyVd+SMn9f9Lmz1ji2TPMTJDCnxHxNq
         3Fso37oz5paQdLFKc2UHqjdHZ19DLG1jGs/zOJQXJzLcLrL9WmsZZQeJZDycLZkuQEz3
         Gn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733525535; x=1734130335;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7xWkv895t2vkmivZEcKc0VmEj0Py63DFJG/LYdHvb3Y=;
        b=tAyh/rlESZACQougv+LAYseLwouhTyYZ2ezpzNvUV10XB3ZN8pFnrAskfOuE2l95Vt
         0miTTnzlmeOXjxgfOgWy9DMgqXsd+R7a2YzF+SiaxCToghDEg965Rkt095MY++bV9U7B
         fO7rJWZ8qFrI3bazJuHk2b1x9FYbHz6ZVUAo3P2eoE35BAQDICCQ6SOD8jdZBR6KWIDm
         FnOcIVY/RwYmvs44VVcPJfOFRc6gnLej12KcXCIfxkN8zA6JcGy7nLDbQfDL0xPjFyUB
         kqVaDhHyPUTPPbEgzIVFBQkwGJUhRCwq9aSzxYiEfbCce4Wt1I45cvOg4XnY1EO/xJAO
         f56w==
X-Forwarded-Encrypted: i=1; AJvYcCX8fPb/nisSLsjYMlnECK/hN+tfvqlPGjUKJMeuzGWd7GyQ7UxuY15RskUdKHwpN6scZ3VWqCIF8JGEQms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjPxXyQAN6Gur4CEXyej6spm7TQL3/Y4Uly+SoDfQfbdoY3/7u
	eInzrx4jNJpN5dQBkK4qXvHFEeAaiS43cBXl7GoJAgiy3ZfDQvYyZnP6mVkp4sty1r0JUVHaOv5
	glA==
X-Google-Smtp-Source: AGHT+IE5HYCr7W0ZnBekrRI/mwxgnpYPkvPquVys2NZfqfzmdtEe1gkkS7IzDbSltL7UMNDRR9lW/VjGZAs=
X-Received: from plbkd6.prod.google.com ([2002:a17:903:13c6:b0:20c:526b:44a8])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc86:b0:215:9091:4f57
 with SMTP id d9443c01a7336-21614dac170mr62965795ad.43.1733525534992; Fri, 06
 Dec 2024 14:52:14 -0800 (PST)
Date: Fri,  6 Dec 2024 14:52:01 -0800
In-Reply-To: <20241206225204.4008261-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206225204.4008261-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206225204.4008261-5-surenb@google.com>
Subject: [PATCH v5 4/6] mm: make vma cache SLAB_TYPESAFE_BY_RCU
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

To enable SLAB_TYPESAFE_BY_RCU for vma cache we need to ensure that
object reuse before RCU grace period is over will be detected inside
lock_vma_under_rcu().
lock_vma_under_rcu() enters RCU read section, finds the vma at the
given address, locks the vma and checks if it got detached or remapped
to cover a different address range. These last checks are there
to ensure that the vma was not modified after we found it but before
locking it.
vma reuse introduces several new possibilities:
1. vma can be reused after it was found but before it is locked;
2. vma can be reused and reinitialized (including changing its vm_mm)
while being locked in vma_start_read();
3. vma can be reused and reinitialized after it was found but before
it is locked, then attached at a new address or to a new mm while
read-locked;
For case #1 current checks will help detecting cases when:
- vma was reused but not yet added into the tree (detached check)
- vma was reused at a different address range (address check);
We are missing the check for vm_mm to ensure the reused vma was not
attached to a different mm. This patch adds the missing check.
For case #2, we pass mm to vma_start_read() to prevent access to
unstable vma->vm_mm. This might lead to vma_start_read() returning
a false locked result but that's not critical if it's rare because
it will only lead to a retry under mmap_lock.
For case #3, we ensure the order in which vma->detached flag and
vm_start/vm_end/vm_mm are set and checked. vma gets attached after
vm_start/vm_end/vm_mm were set and lock_vma_under_rcu() should check
vma->detached before checking vm_start/vm_end/vm_mm. This is required
because attaching vma happens without vma write-lock, as opposed to
vma detaching, which requires vma write-lock. This patch adds memory
barriers inside is_vma_detached() and vma_mark_attached() needed to
order reads and writes to vma->detached vs vm_start/vm_end/vm_mm.
After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep.
This will facilitate vm_area_struct reuse and will minimize the number
of call_rcu() calls.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h               |  36 +++++--
 include/linux/mm_types.h         |  10 +-
 include/linux/slab.h             |   6 --
 kernel/fork.c                    | 157 +++++++++++++++++++++++++------
 mm/memory.c                      |  15 ++-
 mm/vma.c                         |   2 +-
 tools/testing/vma/vma_internal.h |   7 +-
 7 files changed, 179 insertions(+), 54 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2bf38c1e9cca..3568bcbc7c81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -257,7 +257,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *);
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *);
 void vm_area_free(struct vm_area_struct *);
 /* Use only if VMA has no other users */
-void __vm_area_free(struct vm_area_struct *vma);
+void vm_area_free_unreachable(struct vm_area_struct *vma);
 
 #ifndef CONFIG_MMU
 extern struct rb_root nommu_region_tree;
@@ -706,8 +706,10 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
  * using mmap_lock. The function should never yield false unlocked result.
+ * False locked result is possible if mm_lock_seq overflows or if vma gets
+ * reused and attached to a different mm before we lock it.
  */
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	/*
 	 * Check before locking. A race might cause false locked result.
@@ -716,7 +718,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
@@ -733,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock.lock);
 		return false;
 	}
@@ -822,7 +824,15 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
 
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
-	vma->detached = false;
+	/*
+	 * This pairs with smp_rmb() inside is_vma_detached().
+	 * vma is marked attached after all vma modifications are done and it
+	 * got added into the vma tree. All prior vma modifications should be
+	 * made visible before marking the vma attached.
+	 */
+	smp_wmb();
+	/* This pairs with READ_ONCE() in is_vma_detached(). */
+	WRITE_ONCE(vma->detached, false);
 }
 
 static inline void vma_mark_detached(struct vm_area_struct *vma)
@@ -834,7 +844,18 @@ static inline void vma_mark_detached(struct vm_area_struct *vma)
 
 static inline bool is_vma_detached(struct vm_area_struct *vma)
 {
-	return vma->detached;
+	bool detached;
+
+	/* This pairs with WRITE_ONCE() in vma_mark_attached(). */
+	detached = READ_ONCE(vma->detached);
+	/*
+	 * This pairs with smp_wmb() inside vma_mark_attached() to ensure
+	 * vma->detached is read before vma attributes read later inside
+	 * lock_vma_under_rcu().
+	 */
+	smp_rmb();
+
+	return detached;
 }
 
 static inline void release_fault_lock(struct vm_fault *vmf)
@@ -859,7 +880,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_lock_init(struct vm_area_struct *vma) {}
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
@@ -893,6 +914,7 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
+/* Use on VMAs not created using vm_area_alloc() */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index be3551654325..5d8779997266 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -543,6 +543,12 @@ static inline void *folio_get_private(struct folio *folio)
 
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
@@ -657,9 +663,7 @@ struct vm_area_struct {
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
index 10a971c2bde3..681b685b6c4e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -234,12 +234,6 @@ enum _slab_flag_bits {
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
index 71990f46aa4e..e7e76a660e4c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -436,6 +436,98 @@ static struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
+static void vm_area_ctor(void *data)
+{
+	struct vm_area_struct *vma = (struct vm_area_struct *)data;
+
+#ifdef CONFIG_PER_VMA_LOCK
+	/* vma is not locked, can't use vma_mark_detached() */
+	vma->detached = true;
+#endif
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	vma_lock_init(vma);
+}
+
+#ifdef CONFIG_PER_VMA_LOCK
+
+static void vma_clear(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	vma->vm_mm = mm;
+	vma->vm_ops = &vma_dummy_vm_ops;
+	vma->vm_start = 0;
+	vma->vm_end = 0;
+	vma->anon_vma = NULL;
+	vma->vm_pgoff = 0;
+	vma->vm_file = NULL;
+	vma->vm_private_data = NULL;
+	vm_flags_init(vma, 0);
+	memset(&vma->vm_page_prot, 0, sizeof(vma->vm_page_prot));
+	memset(&vma->shared, 0, sizeof(vma->shared));
+	memset(&vma->vm_userfaultfd_ctx, 0, sizeof(vma->vm_userfaultfd_ctx));
+	vma_numab_state_init(vma);
+#ifdef CONFIG_ANON_VMA_NAME
+	vma->anon_name = NULL;
+#endif
+#ifdef CONFIG_SWAP
+	memset(&vma->swap_readahead_info, 0, sizeof(vma->swap_readahead_info));
+#endif
+#ifndef CONFIG_MMU
+	vma->vm_region = NULL;
+#endif
+#ifdef CONFIG_NUMA
+	vma->vm_policy = NULL;
+#endif
+}
+
+static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *dest)
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
+	memcpy(&dest->shared, &src->shared, sizeof(dest->shared));
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
+#else /* CONFIG_PER_VMA_LOCK */
+
+static void vma_clear(struct vm_area_struct *vma, struct mm_struct *mm)
+{
+	vma_init(vma, mm);
+}
+
+static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *dest)
+{
+	/*
+	 * orig->shared.rb may be modified concurrently, but the clone
+	 * will be reinitialized.
+	 */
+	data_race(memcpy(dest, src, sizeof(*dest)));
+}
+
+#endif /* CONFIG_PER_VMA_LOCK */
+
 struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
@@ -444,7 +536,7 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 	if (!vma)
 		return NULL;
 
-	vma_init(vma, mm);
+	vma_clear(vma, mm);
 
 	return vma;
 }
@@ -458,49 +550,46 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
 	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-	/*
-	 * orig->shared.rb may be modified concurrently, but the clone
-	 * will be reinitialized.
-	 */
-	data_race(memcpy(new, orig, sizeof(*new)));
-	vma_lock_init(new);
-	INIT_LIST_HEAD(&new->anon_vma_chain);
-#ifdef CONFIG_PER_VMA_LOCK
-	/* vma is not locked, can't use vma_mark_detached() */
-	new->detached = true;
-#endif
+	vma_copy(orig, new);
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
 	return new;
 }
 
-void __vm_area_free(struct vm_area_struct *vma)
+static void __vm_area_free(struct vm_area_struct *vma, bool unreachable)
 {
+#ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * With SLAB_TYPESAFE_BY_RCU, vma can be reused and we need
+	 * vma->detached to be set before vma is returned into the cache.
+	 * This way reused object won't be used by readers until it's
+	 * initialized and reattached.
+	 * If vma is unreachable, there can be no other users and we
+	 * can set vma->detached directly with no risk of a race.
+	 * If vma is reachable, then it should have been already detached
+	 * under vma write-lock or it was never attached.
+	 */
+	if (unreachable)
+		vma->detached = true;
+	else
+		VM_BUG_ON_VMA(!is_vma_detached(vma), vma);
+	vma->vm_lock_seq = UINT_MAX;
+#endif
+	VM_BUG_ON_VMA(!list_empty(&vma->anon_vma_chain), vma);
 	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
-#ifdef CONFIG_PER_VMA_LOCK
-static void vm_area_free_rcu_cb(struct rcu_head *head)
+void vm_area_free(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
-						  vm_rcu);
-
-	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
-	__vm_area_free(vma);
+	__vm_area_free(vma, false);
 }
-#endif
 
-void vm_area_free(struct vm_area_struct *vma)
+void vm_area_free_unreachable(struct vm_area_struct *vma)
 {
-#ifdef CONFIG_PER_VMA_LOCK
-	call_rcu(&vma->vm_rcu, vm_area_free_rcu_cb);
-#else
-	__vm_area_free(vma);
-#endif
+	__vm_area_free(vma, true);
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
@@ -3141,6 +3230,12 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+		.ctor = vm_area_ctor,
+	};
+
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3157,9 +3252,11 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = KMEM_CACHE(vm_area_struct,
-			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
 			SLAB_ACCOUNT);
+
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/memory.c b/mm/memory.c
index b252f19b28c9..6f4d4d423835 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6368,10 +6368,16 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	if (!vma_start_read(vma))
+	if (!vma_start_read(mm, vma))
 		goto inval;
 
-	/* Check if the VMA got isolated after we found it */
+	/*
+	 * Check if the VMA got isolated after we found it.
+	 * Note: vma we found could have been recycled and is being reattached.
+	 * It's possible to attach a vma while it is read-locked, however a
+	 * read-locked vma can't be detached (detaching requires write-locking).
+	 * Therefore if this check passes, we have an attached and stable vma.
+	 */
 	if (is_vma_detached(vma)) {
 		vma_end_read(vma);
 		count_vm_vma_lock_event(VMA_LOCK_MISS);
@@ -6385,8 +6391,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * fields are accessible for RCU readers.
 	 */
 
-	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+	/* Check if the vma we locked is the right one. */
+	if (unlikely(vma->vm_mm != mm ||
+		     address < vma->vm_start || address >= vma->vm_end))
 		goto inval_end_read;
 
 	rcu_read_unlock();
diff --git a/mm/vma.c b/mm/vma.c
index cdc63728f47f..648784416833 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -414,7 +414,7 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	if (unreachable)
-		__vm_area_free(vma);
+		vm_area_free_unreachable(vma);
 	else
 		vm_area_free(vma);
 }
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 0cdc5f8c3d60..3eeb1317cc69 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -685,14 +685,15 @@ static inline void mpol_put(struct mempolicy *)
 {
 }
 
-static inline void __vm_area_free(struct vm_area_struct *vma)
+static inline void vm_area_free(struct vm_area_struct *vma)
 {
 	free(vma);
 }
 
-static inline void vm_area_free(struct vm_area_struct *vma)
+static inline void vm_area_free_unreachable(struct vm_area_struct *vma)
 {
-	__vm_area_free(vma);
+	vma->detached = true;
+	vm_area_free(vma);
 }
 
 static inline void lru_add_drain(void)
-- 
2.47.0.338.g60cca15819-goog


