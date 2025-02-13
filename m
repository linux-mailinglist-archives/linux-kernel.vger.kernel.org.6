Return-Path: <linux-kernel+bounces-514023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F05A35173
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1547188FA96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED42245B01;
	Thu, 13 Feb 2025 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mfuOxG4q"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3397270EB2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486826; cv=none; b=T0JrXfBBAOcMzhRZhTQc03/1/a/CAlIGEY4HnziSkB2st4VIEm5Ys44XuJbrRlhaZeHtxEMoET1APP/xNe1H06qCoolyfqrrGOLaMFmtLSa9zZHmZjVuOuUVgU9UFoUI+lxd3PwZfz3sqdGgaLDwDmBTBwzYnGHyWSCcqbVuHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486826; c=relaxed/simple;
	bh=KABNpsb25nd8x3O/oXZpCeD64dxAEJiUS2WGVDITMD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7tM8zXP8KKukLEXaKb1DpsOIGAok4l4PmAQHkmpRSY2ANFKOzP9jZVVijlDYS0xODwVp2P4soygU40pssxKQop9+eUmlyxi6s8pJRNXu/t8lbpvH+peL2MQ8NjkrfLdi3DZke1dxhj+30P83cx9q+IG6X2FcaoCEjNps11rKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mfuOxG4q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f379b7bb3so26395825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486824; x=1740091624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nixUczrejX4FKBcz+HGm8JxV/4Rz6UEjTIeiIS536Tg=;
        b=mfuOxG4qHIiNgbAI52ssBmz1Y9eamsYLh7Nq9JRHwOBAS166WRb/oNfXk+i8CpNMm+
         kbK07TYg2BghHPo1+5S9+0NsETT3tzwS0SsTn4dZaFEAxh5HiILSzJgiO9TxITuhHX0z
         A8Rmj4yURrkesWynjVdFZMke8i+IVxJr+t6VwI6ngjDvLXjWQTnTurjpE4bz8RWAgc8M
         NUnz0FHzOyHgt++snPFYgLlwLH/5JLFn7JEY82q0IGM0NU0IBP4OKdreFZfyqvf9Ylu6
         Sj3Bx2aj77KcHFdYr0ExaYoeC9Ghp6Rjug2s9CMwKp2nVUfsxDTXihg/uiTUSk32RryU
         Y1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486824; x=1740091624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nixUczrejX4FKBcz+HGm8JxV/4Rz6UEjTIeiIS536Tg=;
        b=XjWif7bzqhfYTEQcUPXf4roYmCbv32AOw6KqNFEQ5kPA3GfQh/Uawpvv8ZV1lHNs4r
         HiASgPU3YC75ablrqDcs8lFisDgsJpYbMxQsUAgN0XElI3CDKQlKNKth3WLvuPAqk4BP
         JlozJfIY17QcIyYEm0v1WNVHEN+FAnhGEqD6tkLy8x5AgzCt/HtbJ3lKTkkVhZJ+mY5l
         kmbW5xKMk9Uo1sU6xxiZDhdMvUyWhgs+Jrv+hpmkRV/iEYofBjY5EFnbG7q1K6MV23FZ
         ZvAti4eaVT21kT2lLXGNXoeeQQXohyxBWIXNVGFOoKYziCv48UqzP4AZFydwVohAXzlD
         oKgA==
X-Forwarded-Encrypted: i=1; AJvYcCUnyqFP0om6QyM9cm26fmtu+bjuuAzkKgxIDWZ3uQWs7+AaeetksLyN5VJJGEaa4jg8cZWZLCqc+gr/HC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YygV2UpK/1TDQ/7K+CDKXaxstnbSMj+IvOTkTnqkR+J2/0MHwpD
	G9nXMvrD0BH5Jxb8LI08TaqYT4E98z6+lBcxkD+7aZRnm6CrkFq8VxYD7D8pFw0MY7VBZH/F6UA
	MPQ==
X-Google-Smtp-Source: AGHT+IHexWPTyEo/ZnzJkqYLOzvXPZYi2c9eLV49bS4E26ucZsJK7lHyl46qKggig4vIRb/FsPaNzCiwY30=
X-Received: from pgjp13.prod.google.com ([2002:a63:e64d:0:b0:ad8:73cf:4390])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c998:b0:1ee:1e05:206d
 with SMTP id adf61e73a8af0-1ee5e5b7c8amr15452640637.21.1739486823384; Thu, 13
 Feb 2025 14:47:03 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:39 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-3-surenb@google.com>
Subject: [PATCH v10 02/18] mm: move per-vma lock into vm_area_struct
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
	kernel-team@android.com, surenb@google.com, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset="UTF-8"

Back when per-vma locks were introduces, vm_lock was moved out of
vm_area_struct in [1] because of the performance regression caused by
false cacheline sharing.  Recent investigation [2] revealed that the
regressions is limited to a rather old Broadwell microarchitecture and
even there it can be mitigated by disabling adjacent cacheline
prefetching, see [3].

Splitting single logical structure into multiple ones leads to more
complicated management, extra pointer dereferences and overall less
maintainable code.  When that split-away part is a lock, it complicates
things even further.  With no performance benefits, there are no reasons
for this split.  Merging the vm_lock back into vm_area_struct also allows
vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.  Move
vm_lock back into vm_area_struct, aligning it at the cacheline boundary
and changing the cache to be cacheline-aligned as well.  With kernel
compiled using defconfig, this causes VMA memory consumption to grow from
160 (vm_area_struct) + 40 (vm_lock) bytes to 256 bytes:

    slabinfo before:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    160   51    2 : ...

    slabinfo after moving vm_lock:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    256   32    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
which is 5.5MB per 100000 VMAs.  Note that the size of this structure is
dependent on the kernel configuration and typically the original size is
higher than 160 bytes.  Therefore these calculations are close to the
worst case scenario.  A more realistic vm_area_struct usage before this
change is:

     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    176   46    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 54 to 64 pages,
which is 3.9MB per 100000 VMAs.  This memory consumption growth can be
addressed later by optimizing the vm_lock.

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h               | 28 ++++++++++--------
 include/linux/mm_types.h         |  6 ++--
 kernel/fork.c                    | 49 ++++----------------------------
 tools/testing/vma/vma_internal.h | 33 +++++----------------
 4 files changed, 32 insertions(+), 84 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 16b3cd3de29a..e75fae95b48d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -697,6 +697,12 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_lock_init(struct vm_area_struct *vma)
+{
+	init_rwsem(&vma->vm_lock.lock);
+	vma->vm_lock_seq = UINT_MAX;
+}
+
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
@@ -714,7 +720,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
+	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
 		return false;
 
 	/*
@@ -729,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
 	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock->lock);
+		up_read(&vma->vm_lock.lock);
 		return false;
 	}
 	return true;
@@ -744,7 +750,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
 	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock->lock, subclass);
+	down_read_nested(&vma->vm_lock.lock, subclass);
 }
 
 /*
@@ -756,13 +762,13 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
 static inline void vma_start_read_locked(struct vm_area_struct *vma)
 {
 	mmap_assert_locked(vma->vm_mm);
-	down_read(&vma->vm_lock->lock);
+	down_read(&vma->vm_lock.lock);
 }
 
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	rcu_read_lock(); /* keeps vma alive till the end of up_read */
-	up_read(&vma->vm_lock->lock);
+	up_read(&vma->vm_lock.lock);
 	rcu_read_unlock();
 }
 
@@ -791,7 +797,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock->lock);
+	down_write(&vma->vm_lock.lock);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -799,7 +805,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock->lock);
+	up_write(&vma->vm_lock.lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -811,7 +817,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock->lock))
+	if (!rwsem_is_locked(&vma->vm_lock.lock))
 		vma_assert_write_locked(vma);
 }
 
@@ -844,6 +850,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 #else /* CONFIG_PER_VMA_LOCK */
 
+static inline void vma_lock_init(struct vm_area_struct *vma) {}
 static inline bool vma_start_read(struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
@@ -878,10 +885,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
-/*
- * WARNING: vma_init does not initialize vma->vm_lock.
- * Use vm_area_alloc()/vm_area_free() if vma needs locking.
- */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
@@ -890,6 +893,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
+	vma_lock_init(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8efafef4637e..8a645bcb2b31 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -740,8 +740,6 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	/* Unstable RCU readers are allowed to read this. */
-	struct vma_lock *vm_lock;
 #endif
 
 	/*
@@ -794,6 +792,10 @@ struct vm_area_struct {
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Unstable RCU readers are allowed to read this. */
+	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
+#endif
 } __randomize_layout;
 
 #ifdef CONFIG_NUMA
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..bdbabe73fb29 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
-#ifdef CONFIG_PER_VMA_LOCK
-
-/* SLAB cache for vm_area_struct.lock */
-static struct kmem_cache *vma_lock_cachep;
-
-static bool vma_lock_alloc(struct vm_area_struct *vma)
-{
-	vma->vm_lock = kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
-	if (!vma->vm_lock)
-		return false;
-
-	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = UINT_MAX;
-
-	return true;
-}
-
-static inline void vma_lock_free(struct vm_area_struct *vma)
-{
-	kmem_cache_free(vma_lock_cachep, vma->vm_lock);
-}
-
-#else /* CONFIG_PER_VMA_LOCK */
-
-static inline bool vma_lock_alloc(struct vm_area_struct *vma) { return true; }
-static inline void vma_lock_free(struct vm_area_struct *vma) {}
-
-#endif /* CONFIG_PER_VMA_LOCK */
-
 struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
@@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 		return NULL;
 
 	vma_init(vma, mm);
-	if (!vma_lock_alloc(vma)) {
-		kmem_cache_free(vm_area_cachep, vma);
-		return NULL;
-	}
 
 	return vma;
 }
@@ -496,10 +463,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	 * will be reinitialized.
 	 */
 	data_race(memcpy(new, orig, sizeof(*new)));
-	if (!vma_lock_alloc(new)) {
-		kmem_cache_free(vm_area_cachep, new);
-		return NULL;
-	}
+	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
@@ -511,7 +475,6 @@ void __vm_area_free(struct vm_area_struct *vma)
 {
 	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
-	vma_lock_free(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
@@ -522,7 +485,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 						  vm_rcu);
 
 	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
 	__vm_area_free(vma);
 }
 #endif
@@ -3200,11 +3163,9 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-
-	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
-#ifdef CONFIG_PER_VMA_LOCK
-	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
-#endif
+	vm_area_cachep = KMEM_CACHE(vm_area_struct,
+			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
+			SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index bb273927af0f..4506e6fb3c6f 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -275,10 +275,10 @@ struct vm_area_struct {
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
-	 *  - vm_lock->lock (in write mode)
+	 *  - vm_lock.lock (in write mode)
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
-	 *  - vm_lock->lock (in read or write mode)
+	 *  - vm_lock.lock (in read or write mode)
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
@@ -287,7 +287,7 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	struct vma_lock *vm_lock;
+	struct vma_lock vm_lock;
 #endif
 
 	/*
@@ -464,17 +464,10 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
-static inline bool vma_lock_alloc(struct vm_area_struct *vma)
+static inline void vma_lock_init(struct vm_area_struct *vma)
 {
-	vma->vm_lock = calloc(1, sizeof(struct vma_lock));
-
-	if (!vma->vm_lock)
-		return false;
-
-	init_rwsem(&vma->vm_lock->lock);
+	init_rwsem(&vma->vm_lock.lock);
 	vma->vm_lock_seq = UINT_MAX;
-
-	return true;
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *);
@@ -497,6 +490,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
+	vma_lock_init(vma);
 }
 
 static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
@@ -507,10 +501,6 @@ static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 		return NULL;
 
 	vma_init(vma, mm);
-	if (!vma_lock_alloc(vma)) {
-		free(vma);
-		return NULL;
-	}
 
 	return vma;
 }
@@ -523,10 +513,7 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		return NULL;
 
 	memcpy(new, orig, sizeof(*new));
-	if (!vma_lock_alloc(new)) {
-		free(new);
-		return NULL;
-	}
+	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 
 	return new;
@@ -696,14 +683,8 @@ static inline void mpol_put(struct mempolicy *)
 {
 }
 
-static inline void vma_lock_free(struct vm_area_struct *vma)
-{
-	free(vma->vm_lock);
-}
-
 static inline void __vm_area_free(struct vm_area_struct *vma)
 {
-	vma_lock_free(vma);
 	free(vma);
 }
 
-- 
2.48.1.601.g30ceb7b040-goog


