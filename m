Return-Path: <linux-kernel+bounces-447998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2F19F39B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D64816CD20
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAEA209F4C;
	Mon, 16 Dec 2024 19:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQYDeRyF"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36B2080F0
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377070; cv=none; b=PIJYGSHkY933tV2XjaFEtIaJNHHOtTWqKmVO+fMp8B72e4Qr5X0ny9OjbbszXt56Fmg4KsbbkM3Ss71FRDTzkkQccYWsNottLH/iTw76oVKqOon0NIvXewFtrZqUjct/XUEzmQiYsqRfAGcut5oR/uC8xnWHOPlURmf6Iy6hQWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377070; c=relaxed/simple;
	bh=kmoyPqZq10++Hy23vjHJHRFTdBDcIK5HS+uu7lfS46w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D42S7FqW1wY8u5jlUh3FaW4AlD8HWr+cCS5tAy2ZCczP9WgunEyHoRMqD1pu+DgXGTEDYLInawjDb/WyZb2sxK8xtBUuDrbjc7uzjJ2sCvEWTcK9ATEwJRDptSVxJG5h1s9ToUDp9Qj+pAi/6x9U92XAhOGjLnenBIi2MAIei/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQYDeRyF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728f1c4b95aso3338171b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377067; x=1734981867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=igJVFGm55VljdfCWWP1FWPjwRGLgL1kTgn08p8BmWdc=;
        b=lQYDeRyFj24gFusq99k/Nkem8JKJ780AqI0Pprsj9eXJG85Y09NuptynU9Y+JV8FxB
         ssvWy3wReKuxzWYn6apnY/RXfJlGUDuMhjz01gxf7Q39CceryUJXOiOQnePiguiaZyCf
         5ugTIt9puCiPi4yPsurId73zA7La6dnAZVacA87Ut949LRcOMfPksWOvaEN96fPPWaIa
         ZYqPW7g8QmOOTsh3O2/MqSKq/XfLrrAiCEeWlZU7E56n35hXYvEKRc0QqkhYw349euU3
         UHCu7fuglhYIMkGK6vKd9qSPSxqTPJri3ZojKfcHKMLeJerc4plbAAIGFHQ7Q4xZpbsn
         smLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377067; x=1734981867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igJVFGm55VljdfCWWP1FWPjwRGLgL1kTgn08p8BmWdc=;
        b=VZErglneQJk+DornCgoIAAWG98cN7QxXQ5bUrpDU42ruXbR7+/5yvVBzIOtvOAKfDE
         qb6k+RnZ/VG0fXNoKk0JaJ30OHQbpGfz5x55vXQCCk4ZeabZfQc3fU1JsIzoE1CoKgz2
         TftJgt31lUua4TT7qfHyy6/I6JMMcPxYCLow4v3XZMKX15LfMSQxVq4SMAxnUXYOomat
         CWhzYnJpr4ghCvnDiV6phf7WNfTCRxjdCLuIRBxYDC3+cywvPVc6SrnJIeoimpGhDK0O
         zh0nKWaBCnmJrD3eHQL/4ePe+jfPjw/YLTOnOaOrpu2A27DoeGnu620a6kWHLAZAqIUr
         XBrg==
X-Forwarded-Encrypted: i=1; AJvYcCWlNA+yOwfpaFTkOKP+OdYezXP4U0Zjn1/HH7lFjXmU2gqZyHlKUQo0/07nHFwQmb0LkFeE2mBF2EHbnQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwdV20FSkuIrys5S4GOfWBUhVJ5R90plJI9ey1OhDVCBFvPpRZ
	PXND3DwiYdtAn+bFM+zJXs+QkeRMQjyrvGU9ZOxaIyN8uqJxzyiTM1mb0NE+wzZ93qnluHgyzTA
	E8w==
X-Google-Smtp-Source: AGHT+IH2UojHUVJ+gBvUhOeXPQ2zGfzEXizGrigN1NQ9dKN5xlrh19HGwEfI3CKJSRYp1fQb42E5oINrzxo=
X-Received: from pfbbk15.prod.google.com ([2002:aa7:830f:0:b0:728:e508:8a3e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cd5:b0:724:f86e:e3d9
 with SMTP id d2e1a72fcca58-7290c181255mr20564216b3a.14.1734377067561; Mon, 16
 Dec 2024 11:24:27 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:05 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-3-surenb@google.com>
Subject: [PATCH v6 02/16] mm: move per-vma lock into vm_area_struct
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	lokeshgidra@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	klarasmodin@gmail.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	surenb@google.com
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
---
 include/linux/mm.h               | 28 ++++++++++--------
 include/linux/mm_types.h         |  6 ++--
 kernel/fork.c                    | 49 ++++----------------------------
 tools/testing/vma/vma_internal.h | 33 +++++----------------
 4 files changed, 32 insertions(+), 84 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3815a43ba504..e1768a9395c9 100644
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
index 266f53b2bb49..825f6328f9e5 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -700,8 +700,6 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	/* Unstable RCU readers are allowed to read this. */
-	struct vma_lock *vm_lock;
 #endif
 
 	/*
@@ -754,6 +752,10 @@ struct vm_area_struct {
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
index 8dc670fe90d4..eb3e35d65e95 100644
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
@@ -3189,11 +3152,9 @@ void __init proc_caches_init(void)
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
index b973b3e41c83..568c18d24d53 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -270,10 +270,10 @@ struct vm_area_struct {
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
@@ -282,7 +282,7 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	struct vma_lock *vm_lock;
+	struct vma_lock vm_lock;
 #endif
 
 	/*
@@ -459,17 +459,10 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
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
@@ -492,6 +485,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
+	vma_lock_init(vma);
 }
 
 static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
@@ -502,10 +496,6 @@ static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 		return NULL;
 
 	vma_init(vma, mm);
-	if (!vma_lock_alloc(vma)) {
-		free(vma);
-		return NULL;
-	}
 
 	return vma;
 }
@@ -518,10 +508,7 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		return NULL;
 
 	memcpy(new, orig, sizeof(*new));
-	if (!vma_lock_alloc(new)) {
-		free(new);
-		return NULL;
-	}
+	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 
 	return new;
@@ -691,14 +678,8 @@ static inline void mpol_put(struct mempolicy *)
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
2.47.1.613.gc27f4b7a9f-goog


