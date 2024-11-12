Return-Path: <linux-kernel+bounces-406643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FB49C61BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08241285947
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6DB219CA4;
	Tue, 12 Nov 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2RFyqnJ/"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A94219E29
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731440810; cv=none; b=NBZhgs/zhQOrtN3JKLoC4NBZO0WUU+OMtLHggmBL5Rlt8RH4qOHLiwfjjB51MF7H9+2SHb+tnPZXppbRt70PyRxtqzVMFgxtzMaPXl7LDsJVJI2Zwe4mkWNelVctGFAX89N2a3AzV4JUjGuttDUr8xNJHvtJXq5UDOowg9RM+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731440810; c=relaxed/simple;
	bh=rfBRxsPj/5tld+/cAQjpb8EYhSKHX4+Ihi7SR77+O00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S5eXX5R0GInM2GVxUlhZGy1V0azqzSUHywWrn/OzYKrmvboaYcHfxg1MOUXaTjrxwy3y4vUmkfwQfAW6LV/BQ43/2LKrRZ4bmro39lf7ZwnOA6DG1WDZTbuXveS3dfaQupTt4osrhsicPp2quhMoD6p82g435kgVmb4Ex945LaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2RFyqnJ/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2954ada861so10232071276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731440807; x=1732045607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sF1WO2dwupFGo3hDXc/ZlrjGweMpYlCC+167fV/bC4w=;
        b=2RFyqnJ/bH5OkeQF8Zbb3ZQC+ofmaT3tC/SJQtjT1s9kemXNswIyE6IUfkEpdtBZq5
         URKaYfkb8BVmJxurJ3bgH+3lTolhSZmBjl2hwm+3IBXy0tbp/6aImPlXyIgdrgA/PCoa
         MNaup/z04u34saIxT351TCwUC7sERbvYWJ/BF75Vx5g/BNKx3ocwhOd6KrF8YEMqFdEy
         Sppk0dL4bU/paQbPoHpy77MK2cNdjUyQ8fHq1IR1ntXx9TeMWekW/HJvnx2uZQ5FvEIa
         KHcPPbMRuq65RIfLeF3PonWLf91i5/TrIioZWBv9CTMfB7N/PDDW4l+LFf+Rjhxq5ZUn
         zrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731440807; x=1732045607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sF1WO2dwupFGo3hDXc/ZlrjGweMpYlCC+167fV/bC4w=;
        b=g7mOYmkr3UyWJhU4labL4wJYxMaKMMoYVbb53iOEpuzwE26QuM+pccj1C593cqhWgh
         NL/vkeR/LXC7VMWHC6nXXVMvC2HjNycjJItH+gZxw0k1pStmp5eDUJITsarugdWzMEjN
         Y7szoVjwRoYw7yHB98tUR1I5NBhD1g8jTupv2OabZfqSBnrtuFiZ7jY4qPmVUzU8UHMO
         IXxr1lj9zg+eE0PW0p8ZBiuTYtAzfOD9FVvMLZaTEHuTA8k8lUJUW2Z/9pdEdi/qzHPi
         RMj6DBWfkhQr7LToGAbVaHL+9DBqskdm9iZRW8ZtsqoNUV2VsWxrIG5ey2FeWygWILWe
         Qs2A==
X-Forwarded-Encrypted: i=1; AJvYcCWZiFQ5jeL7IezZEykBxzqFh1129EK6PSYL6xq6wLXT1gjnUQQdkKYsqu/cJRlpVG5QHGPgfiN8TMB4phY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMfL/2Z4I5Qk2U0ltXKr5nZZR9yxG04MG5glZu/hVKbkx4T53
	JKbmHGABoGbR8PvkDd0zdN/32i/7rOwl48VnUyGW5T9lMzDjlav2TJ5LfbZEKAzVEPPJrtddt59
	L5A==
X-Google-Smtp-Source: AGHT+IGT7bUbztUxwofDze+pdbzWP41mkYNy17hbQqt2HDfFo+siQLTPoStIHl62MnUeX+5yshC7tcTeIN8=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:cad5:5dc6:1298:ec42])
 (user=surenb job=sendgmr) by 2002:a25:3302:0:b0:e28:e4a7:3206 with SMTP id
 3f1490d57ef6-e337f8e44f5mr69931276.8.1731440807574; Tue, 12 Nov 2024 11:46:47
 -0800 (PST)
Date: Tue, 12 Nov 2024 11:46:32 -0800
In-Reply-To: <20241112194635.444146-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112194635.444146-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112194635.444146-3-surenb@google.com>
Subject: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
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
which is 5.5MB per 100000 VMAs. This memory consumption growth can be
addressed later by optimizing the vm_lock.

[1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
[2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
[3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h       | 28 +++++++++++++----------
 include/linux/mm_types.h |  6 +++--
 kernel/fork.c            | 49 ++++------------------------------------
 3 files changed, 25 insertions(+), 58 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 01ce619f3d17..a5eb0be3e351 100644
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
@@ -729,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
 	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock->lock, subclass);
+	down_read_nested(&vma->vm_lock.lock, subclass);
 }
 
 /*
@@ -739,13 +745,13 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
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
 
@@ -774,7 +780,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock->lock);
+	down_write(&vma->vm_lock.lock);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -782,7 +788,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock->lock);
+	up_write(&vma->vm_lock.lock);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -794,7 +800,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock->lock))
+	if (!rwsem_is_locked(&vma->vm_lock.lock))
 		vma_assert_write_locked(vma);
 }
 
@@ -827,6 +833,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 #else /* CONFIG_PER_VMA_LOCK */
 
+static inline void vma_lock_init(struct vm_area_struct *vma) {}
 static inline bool vma_start_read(struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
@@ -861,10 +868,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
 
-/*
- * WARNING: vma_init does not initialize vma->vm_lock.
- * Use vm_area_alloc()/vm_area_free() if vma needs locking.
- */
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
 	memset(vma, 0, sizeof(*vma));
@@ -873,6 +876,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
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
-- 
2.47.0.277.g8800431eea-goog


