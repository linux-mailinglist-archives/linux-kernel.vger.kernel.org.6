Return-Path: <linux-kernel+bounces-514033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46235A3518C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5730216E0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B3D270EC3;
	Thu, 13 Feb 2025 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eyge4hcf"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B8127FE92
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486846; cv=none; b=WoL/PpwvkdV21v4ltYFwTSdTGxjDal4cRm1J9ReIexiQLe3kbR2A9nYWFKUOnvxWaOjzq1Znkj//L4CKxFE3PfS8kPS3c+VXQtZsC5PD6ANTgNkcfhZXR8jGHnTmMfJacS3Mv91psYtgEC+YEhlJlYAH00drPmmPt2GJI7C3vEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486846; c=relaxed/simple;
	bh=z5rGC7bLaUBRVYMVo3oFk7L1/p6Jd740lfEdqHxRPzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JDX+C3LDNATS6gTzkbpskLGOrgEsaCGzVZ5leJEc00Ue6TyMLj9vo6IXCjp1T6qaoAhCzUNQZ9/Q5ngk/wbQnzUm89cyNtY/FJPtmPZvRpROCMhY8lx9gyaFsw8hfSzlFz5sXzTIHO/7im5naqSRokuIGW2J4q0o5zOe5NlfCik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eyge4hcf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f5ae4d62dso54142585ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739486844; x=1740091644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFgt1YPKwtEKZHtY8eCCGOT/871l+BokJrFagsVrDsk=;
        b=eyge4hcfuMoLOkuBfB/OMfr19GNzjlGVPuB7on+WcTSnjxoU/PtAveu21gXacrI4i0
         7wK1MtgscOrr4aL41D2MDD1eKPoDGK/IwO12MIIqiHl0IOPwJNlhWk1eqv4AodrOXMJw
         fRok1TGAg0wIEkEjuxSY/8AQlqDQv3nXtKp3cCuJFBzwpYvsDKnrZbOc6n1CXgO4CrNs
         Umbz+k471flYhQThlcjTibnGar315UlMbmePSLsOgRUreNPu39wfqLSkY6gKL6+DVVu7
         tCzE1laU6BxGJwO/yk9uGdH07DTn0kn0ka+9nFEm9E1bKMnaYwafA2tm19fLNfGZLBzz
         0s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739486844; x=1740091644;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFgt1YPKwtEKZHtY8eCCGOT/871l+BokJrFagsVrDsk=;
        b=ezEWYHA9J/zt7g4MmB+begjvE47XEr9vwVAEbv4m0eEBcDJgR1a+kkIpk+Zb/0x4oV
         JG9ouCGeu9jXFu5Z0l0gnApZMNRZpnBbITyXLFXEJgkeVvPyXgpYFrwMCVBT5KqGtUnT
         nk8jYce/OEtfKDIG4ipBEHatTSa6qMjnbBtJGSsaqCGex/IGNeY2ZhiF2h4018LdMtgd
         BFxU2oidf4ZYlQ0UrhjtjwObbNrFYG3rld95nU17YibqgJE6lYtqTl+fvLaUnIZl0WVZ
         bYj2cfwPdYgpQanXlGOMEAWobmx8TtDyTlHHVawTPCLm7/EG7cu8Mof+5hHC2VXYzxmh
         HKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYPysopqKx4SGyqFGY70syXAXIPITYBeNSBrauRjWrerFl1r/ILfw8jlF5tMgyQLGto1+rLkKkleHBHps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOr+bkNcYQr3vhFmZEBx6eCHHK8GkqrwAFFVw/4b3FIQ76NTxX
	9rUPUt1P9MgRkAHOtzQ7AUU3TS3tP8sogzGijZsPSYpW2Ea7l515otkd3F2nSl/Tu6/YXZ7AqvG
	Ouw==
X-Google-Smtp-Source: AGHT+IFBfclnXX1eyWHaQBadHjNWP/bw7xtO4voK2pMlEan4fNA0aBMg12hKdOHhEFlJAYATtSiZC0Oajhs=
X-Received: from plgb14.prod.google.com ([2002:a17:902:d50e:b0:21f:39fb:79d3])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32c8:b0:220:ea90:1925
 with SMTP id d9443c01a7336-220ea9019a9mr22932205ad.35.1739486843944; Thu, 13
 Feb 2025 14:47:23 -0800 (PST)
Date: Thu, 13 Feb 2025 14:46:49 -0800
In-Reply-To: <20250213224655.1680278-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250213224655.1680278-1-surenb@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250213224655.1680278-13-surenb@google.com>
Subject: [PATCH v10 12/18] mm: replace vm_lock and detached flag with a
 reference count
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

rw_semaphore is a sizable structure of 40 bytes and consumes
considerable space for each vm_area_struct. However vma_lock has
two important specifics which can be used to replace rw_semaphore
with a simpler structure:
1. Readers never wait. They try to take the vma_lock and fall back to
mmap_lock if that fails.
2. Only one writer at a time will ever try to write-lock a vma_lock
because writers first take mmap_lock in write mode.
Because of these requirements, full rw_semaphore functionality is not
needed and we can replace rw_semaphore and the vma->detached flag with
a refcount (vm_refcnt).

When vma is in detached state, vm_refcnt is 0 and only a call to
vma_mark_attached() can take it out of this state. Note that unlike
before, now we enforce both vma_mark_attached() and vma_mark_detached()
to be done only after vma has been write-locked. vma_mark_attached()
changes vm_refcnt to 1 to indicate that it has been attached to the vma
tree. When a reader takes read lock, it increments vm_refcnt, unless the
top usable bit of vm_refcnt (0x40000000) is set, indicating presence of
a writer. When writer takes write lock, it sets the top usable bit to
indicate its presence. If there are readers, writer will wait using newly
introduced mm->vma_writer_wait. Since all writers take mmap_lock in write
mode first, there can be only one writer at a time. The last reader to
release the lock will signal the writer to wake up.
refcount might overflow if there are many competing readers, in which case
read-locking will fail. Readers are expected to handle such failures.

In summary:
1. all readers increment the vm_refcnt;
2. writer sets top usable (writer) bit of vm_refcnt;
3. readers cannot increment the vm_refcnt if the writer bit is set;
4. in the presence of readers, writer must wait for the vm_refcnt to drop
to 1 (plus the VMA_LOCK_OFFSET writer bit), indicating an attached vma
with no readers;
5. vm_refcnt overflow is handled by the readers.

While this vm_lock replacement does not yet result in a smaller
vm_area_struct (it stays at 256 bytes due to cacheline alignment), it
allows for further size optimization by structure member regrouping
to bring the size of vm_area_struct below 192 bytes.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Changes since v9 [1]:
- Use __refcount_inc_not_zero_limited_acquire() in vma_start_read(),
per Hillf Danton
- Refactor vma_assert_locked() to avoid vm_refcnt read when CONFIG_DEBUG_VM=n,
per Mateusz Guzik
- Update changelog, per Wei Yang
- Change vma_start_read() to return EAGAIN if vma got isolated and changed
lock_vma_under_rcu() back to detect this condition, per Wei Yang
- Change VM_BUG_ON_VMA() to WARN_ON_ONCE() when checking vma detached state,
per Lorenzo Stoakes
- Remove Vlastimil's Reviewed-by since code is changed

[1] https://lore.kernel.org/all/20250111042604.3230628-12-surenb@google.com/

 include/linux/mm.h               | 128 ++++++++++++++++++++-----------
 include/linux/mm_types.h         |  22 +++---
 kernel/fork.c                    |  13 ++--
 mm/init-mm.c                     |   1 +
 mm/memory.c                      |  91 +++++++++++++++++++---
 tools/testing/vma/linux/atomic.h |   5 ++
 tools/testing/vma/vma_internal.h |  63 ++++++++-------
 7 files changed, 218 insertions(+), 105 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 557d66e187ff..11a042c27aee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -32,6 +32,7 @@
 #include <linux/memremap.h>
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
+#include <linux/rcuwait.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -697,19 +698,54 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
 #endif /* CONFIG_NUMA_BALANCING */
 
 #ifdef CONFIG_PER_VMA_LOCK
-static inline void vma_lock_init(struct vm_area_struct *vma)
+static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
 {
-	init_rwsem(&vma->vm_lock.lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	static struct lock_class_key lockdep_key;
+
+	lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
+#endif
+	if (reset_refcnt)
+		refcount_set(&vma->vm_refcnt, 0);
 	vma->vm_lock_seq = UINT_MAX;
 }
 
+static inline bool is_vma_writer_only(int refcnt)
+{
+	/*
+	 * With a writer and no readers, refcnt is VMA_LOCK_OFFSET if the vma
+	 * is detached and (VMA_LOCK_OFFSET + 1) if it is attached. Waiting on
+	 * a detached vma happens only in vma_mark_detached() and is a rare
+	 * case, therefore most of the time there will be no unnecessary wakeup.
+	 */
+	return refcnt & VMA_LOCK_OFFSET && refcnt <= VMA_LOCK_OFFSET + 1;
+}
+
+static inline void vma_refcount_put(struct vm_area_struct *vma)
+{
+	/* Use a copy of vm_mm in case vma is freed after we drop vm_refcnt */
+	struct mm_struct *mm = vma->vm_mm;
+	int oldcnt;
+
+	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+	if (!__refcount_dec_and_test(&vma->vm_refcnt, &oldcnt)) {
+
+		if (is_vma_writer_only(oldcnt - 1))
+			rcuwait_wake_up(&mm->vma_writer_wait);
+	}
+}
+
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
  * using mmap_lock. The function should never yield false unlocked result.
+ * Returns the vma on success, NULL on failure to lock and EAGAIN if vma got
+ * detached.
  */
-static inline bool vma_start_read(struct vm_area_struct *vma)
+static inline struct vm_area_struct *vma_start_read(struct vm_area_struct *vma)
 {
+	int oldcnt;
+
 	/*
 	 * Check before locking. A race might cause false locked result.
 	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
@@ -718,15 +754,25 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * need ordering is below.
 	 */
 	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
-		return false;
+		return NULL;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
-		return false;
+	/*
+	 * If VMA_LOCK_OFFSET is set, __refcount_inc_not_zero_limited_acquire()
+	 * will fail because VMA_REF_LIMIT is less than VMA_LOCK_OFFSET.
+	 * Acquire fence is required here to avoid reordering against later
+	 * vm_lock_seq check and checks inside lock_vma_under_rcu().
+	 */
+	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
+							      VMA_REF_LIMIT))) {
+		/* return EAGAIN if vma got detached from under us */
+		return oldcnt ? NULL : ERR_PTR(-EAGAIN);
+	}
 
+	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
 	/*
-	 * Overflow might produce false locked result.
+	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
 	 * False unlocked result is impossible because we modify and check
-	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
+	 * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
 	 *
 	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
@@ -735,10 +781,11 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
 	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock.lock);
-		return false;
+		vma_refcount_put(vma);
+		return NULL;
 	}
-	return true;
+
+	return vma;
 }
 
 /*
@@ -749,8 +796,14 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
  */
 static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
+	int oldcnt;
+
 	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock.lock, subclass);
+	if (unlikely(!__refcount_inc_not_zero_limited_acquire(&vma->vm_refcnt, &oldcnt,
+							      VMA_REF_LIMIT)))
+		return false;
+
+	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 1, _RET_IP_);
 	return true;
 }
 
@@ -762,16 +815,12 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
  */
 static inline bool vma_start_read_locked(struct vm_area_struct *vma)
 {
-	mmap_assert_locked(vma->vm_mm);
-	down_read(&vma->vm_lock.lock);
-	return true;
+	return vma_start_read_locked_nested(vma, 0);
 }
 
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
-	rcu_read_lock(); /* keeps vma alive till the end of up_read */
-	up_read(&vma->vm_lock.lock);
-	rcu_read_unlock();
+	vma_refcount_put(vma);
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
@@ -813,38 +862,35 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock.lock))
-		vma_assert_write_locked(vma);
+	unsigned int mm_lock_seq;
+
+	VM_BUG_ON_VMA(refcount_read(&vma->vm_refcnt) <= 1 &&
+		      !__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
 
+/*
+ * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
+ * assertions should be made either under mmap_write_lock or when the object
+ * has been isolated under mmap_write_lock, ensuring no competing writers.
+ */
 static inline void vma_assert_attached(struct vm_area_struct *vma)
 {
-	WARN_ON_ONCE(vma->detached);
+	WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
 }
 
 static inline void vma_assert_detached(struct vm_area_struct *vma)
 {
-	WARN_ON_ONCE(!vma->detached);
+	WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
 }
 
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
-	vma_assert_detached(vma);
-	vma->detached = false;
-}
-
-static inline void vma_mark_detached(struct vm_area_struct *vma)
-{
-	/* When detaching vma should be write-locked */
 	vma_assert_write_locked(vma);
-	vma_assert_attached(vma);
-	vma->detached = true;
+	vma_assert_detached(vma);
+	refcount_set(&vma->vm_refcnt, 1);
 }
 
-static inline bool is_vma_detached(struct vm_area_struct *vma)
-{
-	return vma->detached;
-}
+void vma_mark_detached(struct vm_area_struct *vma);
 
 static inline void release_fault_lock(struct vm_fault *vmf)
 {
@@ -867,9 +913,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 #else /* CONFIG_PER_VMA_LOCK */
 
-static inline void vma_lock_init(struct vm_area_struct *vma) {}
-static inline bool vma_start_read(struct vm_area_struct *vma)
-		{ return false; }
+static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt) {}
+static inline struct vm_area_struct *vma_start_read(struct vm_area_struct *vma)
+		{ return NULL; }
 static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -910,12 +956,8 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-#ifdef CONFIG_PER_VMA_LOCK
-	/* vma is not locked, can't use vma_mark_detached() */
-	vma->detached = true;
-#endif
 	vma_numab_state_init(vma);
-	vma_lock_init(vma);
+	vma_lock_init(vma, false);
 }
 
 /* Use when VMA is not part of the VMA tree and needs no locking */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8a645bcb2b31..48ddfedfff83 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/types.h>
 
 #include <asm/mmu.h>
 
@@ -639,9 +640,8 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
 }
 #endif
 
-struct vma_lock {
-	struct rw_semaphore lock;
-};
+#define VMA_LOCK_OFFSET	0x40000000
+#define VMA_REF_LIMIT	(VMA_LOCK_OFFSET - 1)
 
 struct vma_numab_state {
 	/*
@@ -719,19 +719,13 @@ struct vm_area_struct {
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
-	/*
-	 * Flag to indicate areas detached from the mm->mm_mt tree.
-	 * Unstable RCU readers are allowed to read this.
-	 */
-	bool detached;
-
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
-	 *  - vm_lock->lock (in write mode)
+	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
-	 *  - vm_lock->lock (in read or write mode)
+	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set or vm_refcnt > 1
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
@@ -794,7 +788,10 @@ struct vm_area_struct {
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
 #ifdef CONFIG_PER_VMA_LOCK
 	/* Unstable RCU readers are allowed to read this. */
-	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
+	refcount_t vm_refcnt ____cacheline_aligned_in_smp;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map vmlock_dep_map;
+#endif
 #endif
 } __randomize_layout;
 
@@ -929,6 +926,7 @@ struct mm_struct {
 					  * by mmlist_lock
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
+		struct rcuwait vma_writer_wait;
 		/*
 		 * This field has lock-like semantics, meaning it is sometimes
 		 * accessed with ACQUIRE/RELEASE semantics.
diff --git a/kernel/fork.c b/kernel/fork.c
index f1af413e5aa4..48a0038f606f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -463,12 +463,8 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	 * will be reinitialized.
 	 */
 	data_race(memcpy(new, orig, sizeof(*new)));
-	vma_lock_init(new);
+	vma_lock_init(new, true);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
-#ifdef CONFIG_PER_VMA_LOCK
-	/* vma is not locked, can't use vma_mark_detached() */
-	new->detached = true;
-#endif
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
@@ -477,6 +473,8 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 
 void __vm_area_free(struct vm_area_struct *vma)
 {
+	/* The vma should be detached while being destroyed. */
+	vma_assert_detached(vma);
 	vma_numab_state_free(vma);
 	free_anon_vma_name(vma);
 	kmem_cache_free(vm_area_cachep, vma);
@@ -488,8 +486,6 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
 						  vm_rcu);
 
-	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
 	__vm_area_free(vma);
 }
 #endif
@@ -1234,6 +1230,9 @@ static void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
 	mm_lock_seqcount_init(mm);
+#ifdef CONFIG_PER_VMA_LOCK
+	rcuwait_init(&mm->vma_writer_wait);
+#endif
 }
 
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 6af3ad675930..4600e7605cab 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -40,6 +40,7 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
+	.vma_writer_wait = __RCUWAIT_INITIALIZER(init_mm.vma_writer_wait),
 	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
 #endif
 	.user_ns	= &init_user_ns,
diff --git a/mm/memory.c b/mm/memory.c
index 3d9c5141193f..528407c0d7cf 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6393,9 +6393,47 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_PER_VMA_LOCK
+static inline bool __vma_enter_locked(struct vm_area_struct *vma, bool detaching)
+{
+	unsigned int tgt_refcnt = VMA_LOCK_OFFSET;
+
+	/* Additional refcnt if the vma is attached. */
+	if (!detaching)
+		tgt_refcnt++;
+
+	/*
+	 * If vma is detached then only vma_mark_attached() can raise the
+	 * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
+	 */
+	if (!refcount_add_not_zero(VMA_LOCK_OFFSET, &vma->vm_refcnt))
+		return false;
+
+	rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
+	rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
+		   refcount_read(&vma->vm_refcnt) == tgt_refcnt,
+		   TASK_UNINTERRUPTIBLE);
+	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
+
+	return true;
+}
+
+static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *detached)
+{
+	*detached = refcount_sub_and_test(VMA_LOCK_OFFSET, &vma->vm_refcnt);
+	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+}
+
 void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
 {
-	down_write(&vma->vm_lock.lock);
+	bool locked;
+
+	/*
+	 * __vma_enter_locked() returns false immediately if the vma is not
+	 * attached, otherwise it waits until refcnt is indicating that vma
+	 * is attached with no readers.
+	 */
+	locked = __vma_enter_locked(vma, false);
+
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -6403,10 +6441,40 @@ void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock.lock);
+
+	if (locked) {
+		bool detached;
+
+		__vma_exit_locked(vma, &detached);
+		WARN_ON_ONCE(detached); /* vma should remain attached */
+	}
 }
 EXPORT_SYMBOL_GPL(__vma_start_write);
 
+void vma_mark_detached(struct vm_area_struct *vma)
+{
+	vma_assert_write_locked(vma);
+	vma_assert_attached(vma);
+
+	/*
+	 * We are the only writer, so no need to use vma_refcount_put().
+	 * The condition below is unlikely because the vma has been already
+	 * write-locked and readers can increment vm_refcnt only temporarily
+	 * before they check vm_lock_seq, realize the vma is locked and drop
+	 * back the vm_refcnt. That is a narrow window for observing a raised
+	 * vm_refcnt.
+	 */
+	if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
+		/* Wait until vma is detached with no readers. */
+		if (__vma_enter_locked(vma, true)) {
+			bool detached;
+
+			__vma_exit_locked(vma, &detached);
+			WARN_ON_ONCE(!detached);
+		}
+	}
+}
+
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
  * stable and not isolated. If the VMA is not found or is being modified the
@@ -6424,15 +6492,18 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma)
 		goto inval;
 
-	if (!vma_start_read(vma))
-		goto inval;
+	vma = vma_start_read(vma);
+	if (IS_ERR_OR_NULL(vma)) {
+		/* Check if the VMA got isolated after we found it */
+		if (PTR_ERR(vma) == -EAGAIN) {
+			vma_end_read(vma);
+			count_vm_vma_lock_event(VMA_LOCK_MISS);
+			/* The area was replaced with another one */
+			goto retry;
+		}
 
-	/* Check if the VMA got isolated after we found it */
-	if (is_vma_detached(vma)) {
-		vma_end_read(vma);
-		count_vm_vma_lock_event(VMA_LOCK_MISS);
-		/* The area was replaced with another one */
-		goto retry;
+		/* Failed to lock the VMA */
+		goto inval;
 	}
 	/*
 	 * At this point, we have a stable reference to a VMA: The VMA is
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
index 3e1b6adc027b..788c597c4fde 100644
--- a/tools/testing/vma/linux/atomic.h
+++ b/tools/testing/vma/linux/atomic.h
@@ -9,4 +9,9 @@
 #define atomic_set(x, y) uatomic_set(x, y)
 #define U8_MAX UCHAR_MAX
 
+#ifndef atomic_cmpxchg_relaxed
+#define  atomic_cmpxchg_relaxed		uatomic_cmpxchg
+#define  atomic_cmpxchg_release         uatomic_cmpxchg
+#endif /* atomic_cmpxchg_relaxed */
+
 #endif	/* _LINUX_ATOMIC_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 34277842156c..ba838097d3f6 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -25,7 +25,7 @@
 #include <linux/maple_tree.h>
 #include <linux/mm.h>
 #include <linux/rbtree.h>
-#include <linux/rwsem.h>
+#include <linux/refcount.h>
 
 extern unsigned long stack_guard_gap;
 #ifdef CONFIG_MMU
@@ -135,10 +135,6 @@ typedef __bitwise unsigned int vm_fault_t;
  */
 #define pr_warn_once pr_err
 
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
 struct kref {
 	refcount_t refcount;
 };
@@ -233,15 +229,12 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access */
 };
 
-struct vma_lock {
-	struct rw_semaphore lock;
-};
-
-
 struct file {
 	struct address_space	*f_mapping;
 };
 
+#define VMA_LOCK_OFFSET	0x40000000
+
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
@@ -269,16 +262,13 @@ struct vm_area_struct {
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
-	/* Flag to indicate areas detached from the mm->mm_mt tree */
-	bool detached;
-
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
-	 *  - vm_lock.lock (in write mode)
+	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
-	 *  - vm_lock.lock (in read or write mode)
+	 *  - vm_refcnt bit at VMA_LOCK_OFFSET is set or vm_refcnt > 1
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
@@ -287,7 +277,6 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	struct vma_lock vm_lock;
 #endif
 
 	/*
@@ -340,6 +329,10 @@ struct vm_area_struct {
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Unstable RCU readers are allowed to read this. */
+	refcount_t vm_refcnt;
+#endif
 } __randomize_layout;
 
 struct vm_fault {};
@@ -464,33 +457,40 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 	return mas_find(&vmi->mas, ULONG_MAX);
 }
 
-static inline void vma_lock_init(struct vm_area_struct *vma)
-{
-	init_rwsem(&vma->vm_lock.lock);
-	vma->vm_lock_seq = UINT_MAX;
-}
-
+/*
+ * WARNING: to avoid racing with vma_mark_attached()/vma_mark_detached(), these
+ * assertions should be made either under mmap_write_lock or when the object
+ * has been isolated under mmap_write_lock, ensuring no competing writers.
+ */
 static inline void vma_assert_attached(struct vm_area_struct *vma)
 {
-	WARN_ON_ONCE(vma->detached);
+	WARN_ON_ONCE(!refcount_read(&vma->vm_refcnt));
 }
 
 static inline void vma_assert_detached(struct vm_area_struct *vma)
 {
-	WARN_ON_ONCE(!vma->detached);
+	WARN_ON_ONCE(refcount_read(&vma->vm_refcnt));
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *);
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
-	vma->detached = false;
+	vma_assert_write_locked(vma);
+	vma_assert_detached(vma);
+	refcount_set(&vma->vm_refcnt, 1);
 }
 
 static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
-	/* When detaching vma should be write-locked */
 	vma_assert_write_locked(vma);
-	vma->detached = true;
+	vma_assert_attached(vma);
+	/* We are the only writer, so no need to use vma_refcount_put(). */
+	if (unlikely(!refcount_dec_and_test(&vma->vm_refcnt))) {
+		/*
+		 * Reader must have temporarily raised vm_refcnt but it will
+		 * drop it without using the vma since vma is write-locked.
+		 */
+	}
 }
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
@@ -503,9 +503,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	/* vma is not locked, can't use vma_mark_detached() */
-	vma->detached = true;
-	vma_lock_init(vma);
+	vma->vm_lock_seq = UINT_MAX;
 }
 
 static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
@@ -528,10 +526,9 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 		return NULL;
 
 	memcpy(new, orig, sizeof(*new));
-	vma_lock_init(new);
+	refcount_set(&new->vm_refcnt, 0);
+	new->vm_lock_seq = UINT_MAX;
 	INIT_LIST_HEAD(&new->anon_vma_chain);
-	/* vma is not locked, can't use vma_mark_detached() */
-	new->detached = true;
 
 	return new;
 }
-- 
2.48.1.601.g30ceb7b040-goog


