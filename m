Return-Path: <linux-kernel+bounces-412018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FA69D026E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 09:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AA7B252D8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122282899;
	Sun, 17 Nov 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="In7hjj2H"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36570155312
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731830994; cv=none; b=ULIMvE9SCCMO2W9yifmI4Jcjq9daxsFvg0DPXiO2AdUpnzB7PUzGlpiHLdWOaxWp11eXf5zWBjfOnMC5GzzkgzEjcSv579L0SpyPPLi81i4q0KUTMjT2uGsyHEaLYHfIb6whW5Uful3azXoxMaNC/SaFkGBkyDF/7AG5juZ1oLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731830994; c=relaxed/simple;
	bh=hCh3MdPAENPnaEG91WJ1QkZxj9VE0Fejb/Ohi4bjigE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RIFA2cQoZJFKelucyT0bOnmRupL90O9Jr6Ubhh3JKa7cbo0KnwejEZ6+acu+1RSKjH0YzgZieaB/P9tVtKKFwnZTXB8PDIJnPrrScF8aTuY6bO5EkJeuQBJMa2+RATiNNj6wX6xTQYYgIbNxc2hZeZPyFtFSYMJMOkTVkhrL19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=In7hjj2H; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3891b4a68bso343257276.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 00:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731830991; x=1732435791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ydc3xnWflSOvT3mKyRecGyeDU6jHNwbSKwasb1j3Pls=;
        b=In7hjj2Hhxb5DeTzfWxDaQ+1Yh/+U5nIl0v2CnunqS7f613p2P4eTQOa/DbKr/78s4
         W9Y3NLwAfdUbeNOAz2fFNG+2BYjepEJJauaEUejFfnahyDe/VLag0dZVksf6Q6d2rk5y
         QUQNQmtoFRnLtl2zhqEgK2RF74BN1VfzBm/qe3/EH3uSGxjfYUXmrQBmICldpfMzNdSZ
         a4oyvFwAsxCy9kZfmoZVfHvQda52sGs748s8f3ezNr52TCkPg2+slXNmzyoEjbXkDcEg
         SKfogxUilhoFreAbW6CnWfJHGcT+iD3Tua0X6tJHwddDTG5mSr48TFCj/DxfCkTFiZOO
         k5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731830991; x=1732435791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ydc3xnWflSOvT3mKyRecGyeDU6jHNwbSKwasb1j3Pls=;
        b=EUmBaDBceVqyVP4XMILSnv3F1aQOA56FLzfHpN7ItErL/9YWiGyPfIJzYZm9WzmaQo
         ff0e+ksfyQvLbdYX7fu7NxYR9dF4+dPukdfoz+8A0zZDbHecs+8Bjux82NG+t/2TMrf/
         IovE1zMo0aTzt5T99l0D8jdx8djStJUay6xlBsQyGNKM7oeTuAIgAri0fmYYSgNM/YkA
         Zu9VwEDgLFl5zdKCeqyEuSyn1FGisqQbibGyJrGbhoWOqsnJkEIXYfrNn6dCp2NfpHi4
         QVd6ZWjfhft3d2q3MTwuid+aUWLrDUmiTZTa/WeyErsewZsq47H6eQ3Nfpsyw4/6ydKa
         aW1A==
X-Forwarded-Encrypted: i=1; AJvYcCWajPrDtJNn5osz4snYmetbV0/ff+cBtazlO4CSgpLaGaxJBKJJW5hn/Ne0KwRWMwtdFeWBZ6H95K07OcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOKRyA2/A5697WgoL/ObccvDmLzMw38wN/9tXEk0UkCjutxCK
	2R1sq7vh9C6iCR94R6x7yvCMTw9RopyAGsR4PFUvPBbDL/ZUwb6KVfMi3OEYFWUqELSvVOAutD6
	R1g==
X-Google-Smtp-Source: AGHT+IFBFQn/cqW/Nbk+DrZLqER7IMLE2PxGHl++p5as9o7fv/NkZldv72m8b+Y3E+tx/FPb9DpLbddXQ/Q=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:bafc:6633:f766:6415])
 (user=surenb job=sendgmr) by 2002:a25:e097:0:b0:e28:eae7:f838 with SMTP id
 3f1490d57ef6-e3825bc27f4mr8116276.0.1731830990609; Sun, 17 Nov 2024 00:09:50
 -0800 (PST)
Date: Sun, 17 Nov 2024 00:09:30 -0800
In-Reply-To: <20241117080931.600731-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241117080931.600731-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241117080931.600731-5-surenb@google.com>
Subject: [PATCH v3 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
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
it is locked, then attached at a new address or to a new mm while being
read-locked;
For case #1 current checks will help detecting cases when:
- vma was reused but not yet added into the tree (detached check)
- vma was reused at a different address range (address check);
We are missing the check for vm_mm to ensure the reused vma was not
attached to a different mm. This patch adds the missing check.
For case #2, we pass mm to vma_start_read() to prevent access to
unstable vma->vm_mm.
For case #3, we write-lock the vma in vma_mark_attached(), ensuring that
vma does not get re-attached while read-locked by a user of the vma
before it was recycled.
This write-locking should not cause performance issues because contention
during vma_mark_attached() can happen only in the rare vma reuse case.
Even when this happens, it's the slowpath (write-lock) which will be
waiting, not the page fault path.
After these provisions, SLAB_TYPESAFE_BY_RCU is added to vm_area_cachep.
This will facilitate vm_area_struct reuse and will minimize the number
of call_rcu() calls.
Adding a freeptr_t into vm_area_struct (unioned with vm_start/vm_end)
could be used to avoids bloating the structure, however currently
custom free pointers are not supported in combination with a ctor
(see the comment for kmem_cache_args.freeptr_offset).

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h               | 48 ++++++++++++++++++++++++-----
 include/linux/mm_types.h         | 13 +++-----
 kernel/fork.c                    | 53 +++++++++++++++++++-------------
 mm/memory.c                      |  7 +++--
 mm/vma.c                         |  2 +-
 tools/testing/vma/vma_internal.h |  7 +++--
 6 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd1b6190df28..d8e10e1e34ad 100644
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
@@ -690,12 +690,32 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
+#define VMA_BEFORE_LOCK		offsetof(struct vm_area_struct, vm_lock)
+#define VMA_LOCK_END(vma)	\
+	(((void *)(vma)) + offsetofend(struct vm_area_struct, vm_lock))
+#define VMA_AFTER_LOCK		\
+	(sizeof(struct vm_area_struct) - offsetofend(struct vm_area_struct, vm_lock))
+
+static inline void vma_clear(struct vm_area_struct *vma)
+{
+	/* Preserve vma->vm_lock */
+	memset(vma, 0, VMA_BEFORE_LOCK);
+	memset(VMA_LOCK_END(vma), 0, VMA_AFTER_LOCK);
+}
+
+static inline void vma_copy(struct vm_area_struct *new, struct vm_area_struct *orig)
+{
+	/* Preserve vma->vm_lock */
+	data_race(memcpy(new, orig, VMA_BEFORE_LOCK));
+	data_race(memcpy(VMA_LOCK_END(new), VMA_LOCK_END(orig), VMA_AFTER_LOCK));
+}
+
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
  * using mmap_lock. The function should never yield false unlocked result.
  */
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	/*
 	 * Check before locking. A race might cause false locked result.
@@ -704,7 +724,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
@@ -721,7 +741,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock.lock);
 		return false;
 	}
@@ -810,7 +830,18 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
 
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
+	/* vma shoudn't be already attached */
+	VM_BUG_ON_VMA(!vma->detached, vma);
+
+	/*
+	 * Lock here can be contended only if the vma got reused after
+	 * lock_vma_under_rcu() found it but before it had a chance to
+	 * read-lock it. Write-locking the vma guarantees that the vma
+	 * won't be attached until all its old users are out.
+	 */
+	down_write(&vma->vm_lock.lock);
 	vma->detached = false;
+	up_write(&vma->vm_lock.lock);
 }
 
 static inline void vma_mark_detached(struct vm_area_struct *vma)
@@ -847,7 +878,11 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 #else /* CONFIG_PER_VMA_LOCK */
 
 static inline void vma_lock_init(struct vm_area_struct *vma) {}
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline void vma_clear(struct vm_area_struct *vma)
+		{ memset(vma, 0, sizeof(*vma)); }
+static inline void vma_copy(struct vm_area_struct *new, struct vm_area_struct *orig)
+		{ data_race(memcpy(new, orig, sizeof(*new))); }
+static inline bool vma_start_read(struct mm_struct *mm, struct vm_area_struct *vma)
 		{ return false; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
@@ -883,7 +918,7 @@ extern const struct vm_operations_struct vma_dummy_vm_ops;
 
 static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 {
-	memset(vma, 0, sizeof(*vma));
+	vma_clear(vma);
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
@@ -892,7 +927,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->detached = true;
 #endif
 	vma_numab_state_init(vma);
-	vma_lock_init(vma);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5c4bfdcfac72..8f6b0c935c2b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -667,15 +667,10 @@ struct vma_numab_state {
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
-	union {
-		struct {
-			/* VMA covers [vm_start; vm_end) addresses within mm */
-			unsigned long vm_start;
-			unsigned long vm_end;
-		};
-#ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
-#endif
+	struct {
+		/* VMA covers [vm_start; vm_end) addresses within mm */
+		unsigned long vm_start;
+		unsigned long vm_end;
 	};
 
 	/*
diff --git a/kernel/fork.c b/kernel/fork.c
index f0cec673583c..76c68b041f8a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -436,6 +436,11 @@ static struct kmem_cache *vm_area_cachep;
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
+static void vm_area_ctor(void *data)
+{
+	vma_lock_init(data);
+}
+
 struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
@@ -462,8 +467,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	 * orig->shared.rb may be modified concurrently, but the clone
 	 * will be reinitialized.
 	 */
-	data_race(memcpy(new, orig, sizeof(*new)));
-	vma_lock_init(new);
+	vma_copy(new, orig);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
 #ifdef CONFIG_PER_VMA_LOCK
 	/* vma is not locked, can't use vma_mark_detached() */
@@ -475,32 +479,37 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
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
+#endif
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
@@ -3135,9 +3144,11 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = KMEM_CACHE(vm_area_struct,
-			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
-			SLAB_ACCOUNT);
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), 0,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT, vm_area_ctor);
+
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/memory.c b/mm/memory.c
index d0197a0c0996..c8a3e820ed66 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6275,7 +6275,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	if (!vma_start_read(vma))
+	if (!vma_start_read(mm, vma))
 		goto inval;
 
 	/* Check if the VMA got isolated after we found it */
@@ -6292,8 +6292,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * fields are accessible for RCU readers.
 	 */
 
-	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+	/* Check since vm_mm/vm_start/vm_end might change before we lock the VMA */
+	if (unlikely(vma->vm_mm != mm ||
+		     address < vma->vm_start || address >= vma->vm_end))
 		goto inval_end_read;
 
 	rcu_read_unlock();
diff --git a/mm/vma.c b/mm/vma.c
index 73104d434567..050b83df3df2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -382,7 +382,7 @@ void remove_vma(struct vm_area_struct *vma, bool unreachable)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	if (unreachable)
-		__vm_area_free(vma);
+		vm_area_free_unreachable(vma);
 	else
 		vm_area_free(vma);
 }
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 2fed366d20ef..fd668d6cafc0 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -632,14 +632,15 @@ static inline void mpol_put(struct mempolicy *)
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


