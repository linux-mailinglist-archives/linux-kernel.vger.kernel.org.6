Return-Path: <linux-kernel+bounces-280044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDFB94C4FB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4770B1C20B5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB4213E409;
	Thu,  8 Aug 2024 19:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOrviBRd"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C54374C3
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723143615; cv=none; b=fU/TjsaS8USB/xREiv2SWo1zuhdXaWGoyIlk4rtl0Fb5RNVB72Frmvb5/XXF9fWbbkMyGX4UuMqgvzvOaaLA3CYnPjmD++mZsx9IQagtj5qkwu8GQpd0WLtayXNWED20cQpke6oVtK1E9dsQPQYRniJxD03mOrPKxUQtH8cEU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723143615; c=relaxed/simple;
	bh=l/2ay84gjQ+lMkzytIQ5z26CeenYurtSiml/PX0Veoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KcaBGCuRKs6wD0W0b2GlzR7NRaILc8EbFDhqpFOmWbsJPVOy9CWceojnj8btnkOXzcN04ro8uINiXDNSJUOpHrGqC1ub0WPH/uDFlfptP/z6Gzfv77ohYkIK1mBmwxy8P2TUkJOgbCt3ajW6QaUo1QERuvjuv0tIzW8uHXUmVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOrviBRd; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so172578566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723143606; x=1723748406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7J2unFknJRVaAPZnv6P83G7JcPOGmdhcXFSmISXSAk=;
        b=TOrviBRdrUfZ1ObszMfw3M2vB3jeY2kd6bT/PrC4gLhWfT6Pqog4cgNErXvyjrOB6y
         dVqSqAPCEOtlmKxHgrXFqBG0o7vvCZirgxNtdTvrMP+FvuPnu/P6iSqMPJThGKhtR/Db
         xgSaIzcCQjnIdHNVZjM9/BmXmg68b9kPXn2fT00B+zofL2KOVlENQ7XvgYgvBNopGO+D
         h5HqcaOdiawJfE+91Mg8zQot8KEQes0Jv/gF2zqlQKHrcKsIqL1K1Yw1ElpXR+zfI2Np
         ik9Lou6xp16gXUuH0mQHCTO3VHrdX9g+A6vu9B1IB/BngaL6+9rMPOTKyZChtBFnV/Ae
         XIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723143606; x=1723748406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M7J2unFknJRVaAPZnv6P83G7JcPOGmdhcXFSmISXSAk=;
        b=BRXTFdWiB+R/8k4PucemDe6KZd5sVAfFs/Eu0m6puUHwUAEVqnwmWxt28NSUvxyToy
         XIIHWZeQQzwAAA++8F9Us5fuF+jVEvUCeMSSZ52nIlSJji8skf8X6FdJwYmk2ABgxARI
         30cH8U8+tb470+6Ut0D4u8SLCMrTgcT7KBYkjyWdTB/AykJku8BVs3iToa9KEH3m3f2h
         idnjZ6EEzQ2gyvmiV8ZDA6JX44felO/mpq7lPsm1GKAYKGu2l9RsQdeTXEA236WcTNxK
         aSBZGxH0Tba8M7ZhHWQpJSthsSjpq1BLM0cyzzBd7EHrEvb4AP0m6UOlgCMRWRBvtnI1
         Bwkg==
X-Gm-Message-State: AOJu0YyIFYl6ea8GGZIjDGPWz+Uoaz9VLWzVYi1QvUlPm2WVAFfftL90
	zaY7C3txOOCKjXpWWLaFhkTTvMmrxV7y9dPUvLgSlIBezPEatOr4
X-Google-Smtp-Source: AGHT+IF3hl8d6AuywCjf1zHEmLj97N7p3hhhjrNyTjZJm3475UCyf+pIhGgiblWRA0cx6yNmWA5yCA==
X-Received: by 2002:a17:907:f154:b0:a7a:97a9:ba28 with SMTP id a640c23a62f3a-a8090d796f8mr190544766b.26.1723143605640;
        Thu, 08 Aug 2024 12:00:05 -0700 (PDT)
Received: from f.. (cst-prg-72-52.cust.vodafone.cz. [46.135.72.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec7266sm772744066b.196.2024.08.08.12.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:00:04 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: surenb@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	pedro.falcato@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [RFC PATCH] vm: align vma allocation and move the lock back into the struct
Date: Thu,  8 Aug 2024 20:59:49 +0200
Message-ID: <20240808185949.1094891-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACHTUNG: this is more of a request for benchmarking than a patch
proposal at this stage

I was pointed at your patch which moved the vma lock to a separate
allocation [1]. The commit message does not say anything about making
sure the object itself is allocated with proper alignment and I found
that the cache creation lacks the HWCACHE_ALIGN flag, which may or may
not be the problem.

I verified with a simple one-liner than on a stock kernel the vmas keep
roaming around with a 16-byte alignment:
# bpftrace -e 'kretprobe:vm_area_alloc  { @[retval & 0x3f] = count(); }'
@[16]: 39
@[0]: 46
@[32]: 53
@[48]: 56

Note the stock vma lock cache also lacks the alignment flag. While I
have not verified experimentally, if they are also romaing it would mean
that 2 unrelated vmas can false-share locks. If the patch below is a
bust, the flag should probably be added to that one.

The patch has slapped-around vma lock cache removal + HWALLOC for the
vma cache. I left a pointer to not change relative offsets between
current fields. I does compile without CONFIG_PER_VMA_LOCK.

Vlastimil says you tested a case where the struct got bloated to 256
bytes, but the lock remained separate. It is unclear to me if this
happened with allocations made with the HWCACHE_ALIGN flag though.

There is 0 urgency on my end, but it would be nice if you could try
this out with your test rig.

1: https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/T/#u

---
 include/linux/mm.h       | 18 +++++++--------
 include/linux/mm_types.h | 10 ++++-----
 kernel/fork.c            | 47 ++++------------------------------------
 mm/userfaultfd.c         |  6 ++---
 4 files changed, 19 insertions(+), 62 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 43b40334e9b2..6d8b668d3deb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -687,7 +687,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
+	if (unlikely(down_read_trylock(&vma->vm_lock) == 0))
 		return false;
 
 	/*
@@ -702,7 +702,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
 	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock->lock);
+		up_read(&vma->vm_lock);
 		return false;
 	}
 	return true;
@@ -711,7 +711,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
 	rcu_read_lock(); /* keeps vma alive till the end of up_read */
-	up_read(&vma->vm_lock->lock);
+	up_read(&vma->vm_lock);
 	rcu_read_unlock();
 }
 
@@ -740,7 +740,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock->lock);
+	down_write(&vma->vm_lock);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -748,7 +748,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock->lock);
+	up_write(&vma->vm_lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -760,7 +760,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock->lock))
+	if (!rwsem_is_locked(&vma->vm_lock))
 		vma_assert_write_locked(vma);
 }
 
@@ -827,10 +827,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
-/*
- * WARNING: vma_init does not initialize vma->vm_lock.
- * Use vm_area_alloc()/vm_area_free() if vma needs locking.
- */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
@@ -839,6 +835,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
+	init_rwsem(&vma->vm_lock);
+	vma->vm_lock_seq = -1;
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 003619fab20e..caffdb4eeb94 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -615,10 +615,6 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
 }
 #endif
 
-struct vma_lock {
-	struct rw_semaphore lock;
-};
-
 struct vma_numab_state {
 	/*
 	 * Initialised as time in 'jiffies' after which VMA
@@ -716,8 +712,7 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	int vm_lock_seq;
-	/* Unstable RCU readers are allowed to read this. */
-	struct vma_lock *vm_lock;
+	void *vm_dummy;
 #endif
 
 	/*
@@ -770,6 +765,9 @@ struct vm_area_struct {
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_PER_VMA_LOCK
+	struct rw_semaphore vm_lock ____cacheline_aligned_in_smp;
+#endif
 } __randomize_layout;
 
 #ifdef CONFIG_NUMA
diff --git a/kernel/fork.c b/kernel/fork.c
index 92bfe56c9fed..eab04a24d5f1 100644
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
-	vma->vm_lock_seq = -1;
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
@@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	 * will be reinitialized.
 	 */
 	data_race(memcpy(new, orig, sizeof(*new)));
-	if (!vma_lock_alloc(new)) {
-		kmem_cache_free(vm_area_cachep, new);
-		return NULL;
-	}
+	init_rwsem(&new->vm_lock);
+	new->vm_lock_seq = -1;
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
@@ -511,7 +476,6 @@ void __vm_area_free(struct vm_area_struct *vma)
 {
 	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
-	vma_lock_free(vma);
 	kmem_cache_free(vm_area_cachep, vma);
 }
 
@@ -522,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 						  vm_rcu);
 
 	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock), vma);
 	__vm_area_free(vma);
 }
 #endif
@@ -3192,10 +3156,7 @@ void __init proc_caches_init(void)
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
 
-	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
-#ifdef CONFIG_PER_VMA_LOCK
-	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
-#endif
+	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT|SLAB_HWCACHE_ALIGN);
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b7715ecf292..e95ecb2063d2 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -92,7 +92,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 		 * mmap_lock, which guarantees that nobody can lock the
 		 * vma for write (vma_start_write()) under us.
 		 */
-		down_read(&vma->vm_lock->lock);
+		down_read(&vma->vm_lock);
 	}
 
 	mmap_read_unlock(mm);
@@ -1468,9 +1468,9 @@ static int uffd_move_lock(struct mm_struct *mm,
 		 * See comment in uffd_lock_vma() as to why not using
 		 * vma_start_read() here.
 		 */
-		down_read(&(*dst_vmap)->vm_lock->lock);
+		down_read(&(*dst_vmap)->vm_lock);
 		if (*dst_vmap != *src_vmap)
-			down_read_nested(&(*src_vmap)->vm_lock->lock,
+			down_read_nested(&(*src_vmap)->vm_lock,
 					 SINGLE_DEPTH_NESTING);
 	}
 	mmap_read_unlock(mm);
-- 
2.43.0


