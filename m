Return-Path: <linux-kernel+bounces-415080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA8E9D3154
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF41B23EBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4D217C77;
	Wed, 20 Nov 2024 00:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYt1nlNW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6298493
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732061318; cv=none; b=bQ6nCQGQpF7AdIpWIDMoSPuwNcwKZSn+7oZAJKzfBIjPkmdQu2jl+ALwI2TZQ3/wsuMZ5s8TXTj3O9D0vYGxq3dA/Le9W/cLwcV5PirBbJ0QG+10UG+/CLmalT5EEPUZNy17u3ojy3J3xPyu8/WTmJ9gSMYX+tLsTtL3qettYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732061318; c=relaxed/simple;
	bh=4M+B8m74WYSHQ0SMTEGpYtV04WsOuJHHo+ablXb6fXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqs6xHwwCbbBd0tKqOWApZk8iXwHXjLuNjlUXgz6D8F3I/tOxqC0cO8lqO5+af5Xpu3UoZZ6tmehTQ0ccBD31J8zs2n5ozadinhjAHhI0puqGavvr/c+nn9syUBCik5rJWtDCjQzBTB+GChOcHjDE/+L2105mj6JvN7Kf9OK+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYt1nlNW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35a643200so73968677b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732061315; x=1732666115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAziw9WSyfucuyGMOXxhGKNJRHbYSYaYgevUTnXgAr0=;
        b=yYt1nlNWleftomyl7TdJhkbY/R0KIrHw0w33QBAg0UTEum+IJdeiL5Siwl5NKPul1S
         cnQjxhtBiCzEIrB8jMhJ5ipphpwfB8poav0lCgunnj2RuoSpFLp3dNKjYXXw77/U/RVB
         Qjp72pWVGCs41DUMyfwzRN0MRoV1yasKAKPPAOponB6evG2O8+h5nEZtBXLxV7eptv6U
         V80/ihTvGcK7U/IdIDddsa11Pq41Dr7htVAqquzmcANTfMUntiRjeA6UEjv9p54gju0p
         28IXL2r6MaFmQTGSa90oivIqjfAYZGRPNXUc6dRq9e5GYKCwA/34z1d8gasmHHWc/G+z
         jmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732061315; x=1732666115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAziw9WSyfucuyGMOXxhGKNJRHbYSYaYgevUTnXgAr0=;
        b=gTGNgAu1jRr9qbRCSnKLzXMTHWrrAE/flL194wqfcmD0jKS7NaZf3PYkpS3dSVyjZP
         yT/rVKH3GOIWlJO8GVaJ1oVX9Phz2Oovz6aSMw1inH7+CBe1TjhLFKdd5hCg5EcdXhM7
         tK79vciJqWDde+7yBW7MvEBaZUIFO5kgrMMyjKos+I/VLgVO+81OLLfI1KTw5nv/nBjx
         HJL3mWfrTzn0PHBi0OBIp3+vrIWcMTCKKIMRHft23JYFJR/gw1XZzXow/zEXyDa/2Trb
         pdGJ7Obh0Q/lACL8rSjK5ohTNMZM/PY4xBiYCX+Co0bsgZCcyiiKbx1ND3nJj52BZ4N9
         75ig==
X-Forwarded-Encrypted: i=1; AJvYcCWy6vC1JAZxub4Mhdd/qBTsD9jbacwfqoWMh1S2efcIWWFfhQNbFTAiIJ1VaqfZ76Jds9JCJyQ/Wdg6kFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZwjAF1SawX2YOikhGosKEEHMcvb3Hfs8pQX2WeYE/WYkHgyx4
	+h14mSJU5vD5uajzTmLlR57ndGZFxZoLe8Erf70GRYIn0vHOKT3UkwojZ7sRNLONReYQgQMQe8+
	yww==
X-Google-Smtp-Source: AGHT+IFLT4jYBs99DKrHbDQ7ZGcoHlaQ/f9ZNKPO2rEer0ezgVKwkvp1ZV9dvMBREnqovNlsd6vvhAEH4wE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:af45:bbc1:fc75:e695])
 (user=surenb job=sendgmr) by 2002:a05:690c:3301:b0:6db:b2ed:7625 with SMTP id
 00721157ae682-6eebcfba548mr28807b3.0.1732061315061; Tue, 19 Nov 2024 16:08:35
 -0800 (PST)
Date: Tue, 19 Nov 2024 16:08:23 -0800
In-Reply-To: <20241120000826.335387-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241120000826.335387-3-surenb@google.com>
Subject: [PATCH v4 2/5] mm: move per-vma lock into vm_area_struct
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

Back when per-vma locks were introduces, vm_lock was moved out of
vm_area_struct in [1] because of the performance regression caused by
false cacheline sharing. Recent investigation [2] revealed that the
regressions is limited to a rather old Broadwell microarchitecture and
even there it can be mitigated by disabling adjacent cacheline
prefetching, see [3].
Splitting single logical structure into multiple ones leads to more
complicated management, extra pointer dereferences and overall less
maintainable code. When that split-away part is a lock, it complicates
things even further. With no performance benefits, there are no reasons
for this split. Merging the vm_lock back into vm_area_struct also allows
vm_area_struct to use SLAB_TYPESAFE_BY_RCU later in this patchset.
Move vm_lock back into vm_area_struct, aligning it at the cacheline
boundary and changing the cache to be cacheline-aligned as well.
With kernel compiled using defconfig, this causes VMA memory consumption
to grow from 160 (vm_area_struct) + 40 (vm_lock) bytes to 256 bytes:

    slabinfo before:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    160   51    2 : ...

    slabinfo after moving vm_lock:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    256   32    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
which is 5.5MB per 100000 VMAs. Note that the size of this structure is
dependent on the kernel configuration and typically the original size is
higher than 160 bytes. Therefore these calculations are close to the
worst case scenario. A more realistic vm_area_struct usage before this
change is:

     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    176   46    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 54 to 64 pages,
which is 3.9MB per 100000 VMAs.
This memory consumption growth can be addressed later by optimizing the
vm_lock.

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               | 28 ++++++++++--------
 include/linux/mm_types.h         |  6 ++--
 kernel/fork.c                    | 49 ++++----------------------------
 tools/testing/vma/vma_internal.h | 33 +++++----------------
 4 files changed, 32 insertions(+), 84 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ba2e480ae63..737c003b0a1e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -684,6 +684,12 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
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
@@ -701,7 +707,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
+	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
 		return false;
 
 	/*
@@ -716,7 +722,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
 	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock->lock);
+		up_read(&vma->vm_lock.lock);
 		return false;
 	}
 	return true;
@@ -731,7 +737,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
 	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock->lock, subclass);
+	down_read_nested(&vma->vm_lock.lock, subclass);
 }
 
 /*
@@ -743,13 +749,13 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
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
 
@@ -778,7 +784,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock->lock);
+	down_write(&vma->vm_lock.lock);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -786,7 +792,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock->lock);
+	up_write(&vma->vm_lock.lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -798,7 +804,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock->lock))
+	if (!rwsem_is_locked(&vma->vm_lock.lock))
 		vma_assert_write_locked(vma);
 }
 
@@ -831,6 +837,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 #else /* CONFIG_PER_VMA_LOCK */
 
+static inline void vma_lock_init(struct vm_area_struct *vma) {}
 static inline bool vma_start_read(struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
@@ -865,10 +872,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
-/*
- * WARNING: vma_init does not initialize vma->vm_lock.
- * Use vm_area_alloc()/vm_area_free() if vma needs locking.
- */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
@@ -877,6 +880,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
+	vma_lock_init(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 80fef38d9d64..5c4bfdcfac72 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -716,8 +716,6 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	/* Unstable RCU readers are allowed to read this. */
-	struct vma_lock *vm_lock;
 #endif
 
 	/*
@@ -770,6 +768,10 @@ struct vm_area_struct {
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
index 0061cf2450ef..7823797e31d2 100644
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
@@ -3168,11 +3131,9 @@ void __init proc_caches_init(void)
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
index 1d9fc97b8e80..11c2c38ca4e8 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -230,10 +230,10 @@ struct vm_area_struct {
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
@@ -242,7 +242,7 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	struct vma_lock *vm_lock;
+	struct vma_lock vm_lock;
 #endif
 
 	/*
@@ -408,17 +408,10 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
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
@@ -439,6 +432,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
+	vma_lock_init(vma);
 }
 
 static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
@@ -449,10 +443,6 @@ static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 		return NULL;
 
 	vma_init(vma, mm);
-	if (!vma_lock_alloc(vma)) {
-		free(vma);
-		return NULL;
-	}
 
 	return vma;
 }
@@ -465,10 +455,7 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		return NULL;
 
 	memcpy(new, orig, sizeof(*new));
-	if (!vma_lock_alloc(new)) {
-		free(new);
-		return NULL;
-	}
+	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 
 	return new;
@@ -638,14 +625,8 @@ static inline void mpol_put(struct mempolicy *)
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
2.47.0.338.g60cca15819-goog


