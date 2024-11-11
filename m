Return-Path: <linux-kernel+bounces-404750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5619C47D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E6DB2F172
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC52F1F6675;
	Mon, 11 Nov 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5wbO79a"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE71F26E5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358517; cv=none; b=SoqNeKo8wayDbK1feE/zihNXJE0N5R+AsdpQ5psPJaOxbTWSultl5wue6oL4z32p8PGuN3IBEp3PKINnMzI05LnxgWq2naPMki3gQizetU+TmL7OJuU9o2nVhRdf4q1+Dix0oXUAOUbSld8dozutMdRc0AIEL2FftyaZC0GDd5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358517; c=relaxed/simple;
	bh=i0otyTtW+AxnnzQXj1+ysEAu0ebKzOlI/9Vlt+Q/1pU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KbSfThS4ajaVuM69gP1/FwIjdd+CkQaILq8i4SVz9nT11tcRNIaIYq6bUek4j828uzYgNlzbmFe3GxAPdlucWsJbqwCyNYgMKtPxi5nQIZ0b/az7Ffijx7dkpkwgeymIPzPBSApXBrrpXD5xgZYXguUAflOHYYGdssHbXOh0s1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5wbO79a; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea8794f354so86215457b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731358514; x=1731963314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykW1gbgekt/rdC2PDe+Q7K6R2D2rbM+L22MrFdz7vw8=;
        b=t5wbO79adqNDLQh2mE4hQHHw0cq19lG1n8BfloH2Y2h74Jn9nrv0QzVEzzVKw69web
         LTsjuYW7oRh/2URUxtTEnsO/v/x/lBrCQzfBfQfpwRa0JXoCDglZwkH0wDOjWowKKTF0
         USaytxofR62sTjRJ/RpOEvibu+RuFmNP+1Kkf00IP7bhkjE7MDBtxsQL+imPJNMt2L7J
         TjJX34C9tgWR4Y5Obby8l2mF1ouAsEbZOu0r+BDGH98J9DcyuyqJUFUJu8+gHTKeaOSk
         t9QNWtFAFWcbdrgGnWIn8SiIPIjzbQwd/eoeAAab8S46YjnEJYdPnh6BDA9dpmJZXC1H
         l7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358514; x=1731963314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykW1gbgekt/rdC2PDe+Q7K6R2D2rbM+L22MrFdz7vw8=;
        b=XsrRxKMGQUqqpjihzuqqng3Z3BuQ3dV8dWtUu8eCE7+DTWWZ11xFEIvxbdetyDbFr4
         kSMfazZJ0Et0SbaT+oGnGLprnKEVR1WcGGTThaV3pPwGbZLvRnwgBLlUoFMab7ibqSj4
         sok/8+pULCt85LMv9oO6OO407ck5UjJ7fdZWjgWFRE+zhwEkBbhy4byXRisGDw7Vc4At
         al5Rw//sg7G3KMd3HNAD9OFYJSchZa8bh+v+WIqMcDjm5REDzBUs7UDjdn/MkJoAv1wJ
         NunGgJyC091fGmE7rWkbwDQ+bVloyFzGNRxKBDVSWjHegFB6/S/v+3paEKU1CdSbkwHg
         VWVg==
X-Forwarded-Encrypted: i=1; AJvYcCV/scVlYq9ZJ/DoopZOuEwr+niY0cnuG0XiaWP/EmgVHwTIK9Ztz626deRBKsIs1yNfmagnf/PykYfbhS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEv2O/SBV/9Tw7mQe8D56ggb7bIODOdZnf97ADIJBKLmG1OgH2
	bMmfyiUuD2ENyYksZKILUXYNYrqEfI8wa6i3Pcg7zv8wwMWZzCmytaBjB7c36CR0CSCSBbm9y3n
	49w==
X-Google-Smtp-Source: AGHT+IH1frtfP2Lf4sm0W9DSf94AOlw0snxCLYaHFUcao7FdY9FAQlPyHOnZbHHIWvjf/NOxp7z7fX74rks=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:53af:d9fa:522d:99b1])
 (user=surenb job=sendgmr) by 2002:a05:690c:887:b0:6b2:6cd4:7f9a with SMTP id
 00721157ae682-6eaddff31bcmr1462977b3.8.1731358514433; Mon, 11 Nov 2024
 12:55:14 -0800 (PST)
Date: Mon, 11 Nov 2024 12:55:04 -0800
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111205506.3404479-3-surenb@google.com>
Subject: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Back when per-vma locks were introduces, vm_lock was moved out of
vm_area_struct in [1] because of the performance regression caused by
false cacheline sharing. Recent investigation [2] revealed that the
regressions is limited to a rather old Broadwell microarchitecture and
even there it can be mitigated by disabling adjacent cacheline
prefetching, see [3].
This patchset moves vm_lock back into vm_area_struct, aligning it at the
cacheline boundary and changing the cache to be cache-aligned as well.
This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
(vm_lock) bytes to 256 bytes:

    slabinfo before:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vma_lock         ...     40  102    1 : ...
     vm_area_struct   ...    160   51    2 : ...

    slabinfo after moving vm_lock:
     <name>           ... <objsize> <objperslab> <pagesperslab> : ...
     vm_area_struct   ...    256   32    2 : ...

Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
which is 5.5MB per 100000 VMAs. This memory consumption growth will be
addressed in the patches that follow.

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/T/#m861679f3fe0e22c945d6334b88dc996fef5ea6cc
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 27 ++++++++++++----------
 include/linux/mm_types.h |  6 +++--
 kernel/fork.c            | 50 +++++-----------------------------------
 3 files changed, 25 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01ce619f3d17..c1c2899464db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -684,6 +684,11 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_PER_VMA_LOCK
+static inline void vma_lock_init(struct vma_lock *vm_lock)
+{
+	init_rwsem(&vm_lock->lock);
+}
+
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
@@ -701,7 +706,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
+	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
 		return false;
 
 	/*
@@ -716,7 +721,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
 	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock->lock);
+		up_read(&vma->vm_lock.lock);
 		return false;
 	}
 	return true;
@@ -729,7 +734,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
 	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock->lock, subclass);
+	down_read_nested(&vma->vm_lock.lock, subclass);
 }
 
 /*
@@ -739,13 +744,13 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
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
 
@@ -774,7 +779,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock->lock);
+	down_write(&vma->vm_lock.lock);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -782,7 +787,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock->lock);
+	up_write(&vma->vm_lock.lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -794,7 +799,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock->lock))
+	if (!rwsem_is_locked(&vma->vm_lock.lock))
 		vma_assert_write_locked(vma);
 }
 
@@ -861,10 +866,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
-/*
- * WARNING: vma_init does not initialize vma->vm_lock.
- * Use vm_area_alloc()/vm_area_free() if vma needs locking.
- */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
@@ -873,6 +874,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 	vma_mark_detached(vma, false);
 	vma_numab_state_init(vma);
+	vma_lock_init(&vma->vm_lock);
+	vma->vm_lock_seq = UINT_MAX;
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
index 0061cf2450ef..9e504105f24f 100644
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
@@ -496,10 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	 * will be reinitialized.
 	 */
 	data_race(memcpy(new, orig, sizeof(*new)));
-	if (!vma_lock_alloc(new)) {
-		kmem_cache_free(vm_area_cachep, new);
-		return NULL;
-	}
+	vma_lock_init(&new->vm_lock);
+	new->vm_lock_seq = UINT_MAX;
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
+	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
 	__vm_area_free(vma);
 }
 #endif
@@ -3168,11 +3132,9 @@ void __init proc_caches_init(void)
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
-- 
2.47.0.277.g8800431eea-goog


