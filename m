Return-Path: <linux-kernel+bounces-448006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F1E9F39C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56C11888991
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908020C484;
	Mon, 16 Dec 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVdqGo9D"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59F320C03E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377086; cv=none; b=WKyVZSUXEmELt6M275rK2qq42fJVfGKeStXW6DRnPEtRjgBqNI53Vl6PDClylQlVrTt7xjttf0dEa/zqKXMHJFgcIF2QVmPws14P8VdnwOsd/c1+n8DbWNv9sx2VE7OFmZoHfZ9N+ZpiHli78S0edwHvibFP+c/qqJ67F6LWCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377086; c=relaxed/simple;
	bh=ZJJNm2gxTiBYukTk0g+FcnabqsE7DubybHOIkBFTfc0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MsddDx8eYbxkbccHhQ73WPP2bhRrSU+X/ZHvgK+oKJmSqKehr996hHK9Ae0NONeD24qJY7aZI9e6r3Nf2BSgA2ncb42U+Vz+A5nMR2dNfipDhJ4UWf7yi4+7WgHwQHUJu9EL+OLpim+kFSmx9WxRmp9Clirg6QemOXnXPQ5HoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVdqGo9D; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725e3c6ad0dso6091590b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377084; x=1734981884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWr5wuN/XFwhP0jdgiadjUA9/QQ6j9qWDWV+i5/abRA=;
        b=wVdqGo9DPRttr0DODFLQGI3+CfABxr6qlxi6mLRTuGvfWNBFIUUxvG7GfUgammWS74
         rufGk9M466ydraAtfJ7DvfBHrJESgF9arOYpE4IRkSkhkSSvzzfXl6RruOw5yF50jc26
         CQVapc8L2enxtql13kleJMU/yoZghY8YPdBOFcMLDI6TwlxGlh0S+X7b+k1HAtx0FFp9
         6VtA7P7/tnlqTYWKANcSyi1gyeBdAVyR62XYtmuRhfUnddEuODtsBUP7XEzUTJmB+kzV
         WXS3Fv/upg0CN4tXGm1PHoMq6Z8jac1gxJ66826TAwJpv1pstwpAB35HHUObOChDrGM/
         DQAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377084; x=1734981884;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWr5wuN/XFwhP0jdgiadjUA9/QQ6j9qWDWV+i5/abRA=;
        b=tCHgD3EHHOxstUqgl8yTqa/nKaLv9iQQxQUEhdM3ylwnyW3Di1VogxcrZVAzvovaqj
         V1374OdrQ+fDx/OYT0kfhU4/Z6/HF2SlQEpOL0l2aDKCG+0Xo1ZJ5sER4SB58nm4q854
         RpfnZ1i/qK5mnqZdczxBF9SkZvpgz1du2HZjhYLJw+zHmvFo1YZdm/8SmgHkCbv7CWcR
         3aSvc6k56XyzTIo66U5ElVeJGcIkqGspWbtNERXfgCyG5n4at/y1qyF5/h6vpUmuKwN/
         cY9uBLAF6Ub1ylJZp4ZYyBV5F5aDw5eLtSz4QPnRQYNO/cg4ZckirHk/5UC85h8ZpO/5
         gh6A==
X-Forwarded-Encrypted: i=1; AJvYcCWh5k5yWQtydl1giKvUSPL3l84F2m9vVNy8p5NbZAaajQyqOKLdx9ek70Rqb4nWceDqWQtoqS+Qdhyc0ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzySc6ArfsDCzZ/LwDOORFp1sKZvdjbqr7l8NAEjejK8oodPTS
	r2cBf8mAszLFfomGoltCTOBCAOLrJSJjaAu+4T4zfPK01+ptm8lhAfZf+P67eeJGM79ql6e1I36
	6Dw==
X-Google-Smtp-Source: AGHT+IG2bwhxLQwIlqUIeB8kJPQ7+AcPBBfyUQeVN2TC0lLVCS5WDt3dsxGA1e6kkw4Q6iS5TtnTtrsPmuM=
X-Received: from pgbdq26.prod.google.com ([2002:a05:6a02:f9a:b0:7fd:577a:6d1e])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328d:b0:1e1:9bc1:6d6d
 with SMTP id adf61e73a8af0-1e1dfde67b3mr25323185637.31.1734377083981; Mon, 16
 Dec 2024 11:24:43 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:13 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-11-surenb@google.com>
Subject: [PATCH v6 10/16] mm: replace vm_lock and detached flag with a
 reference count
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
a writer. When writer takes write lock, it both increments vm_refcnt and
sets the top usable bit to indicate its presence. If there are readers,
writer will wait using newly introduced mm->vma_writer_wait. Since all
writers take mmap_lock in write mode first, there can be only one writer
at a time. The last reader to release the lock will signal the writer
to wake up.
refcount might overflow if there are many competing readers, in which case
read-locking will fail. Readers are expected to handle such failures.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h               | 95 ++++++++++++++++++++++++--------
 include/linux/mm_types.h         | 23 ++++----
 kernel/fork.c                    |  9 +--
 mm/init-mm.c                     |  1 +
 mm/memory.c                      | 33 +++++++----
 tools/testing/vma/linux/atomic.h |  5 ++
 tools/testing/vma/vma_internal.h | 57 ++++++++++---------
 7 files changed, 147 insertions(+), 76 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ccb8f2afeca8..d9edabc385b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -32,6 +32,7 @@
 #include <linux/memremap.h>
 #include <linux/slab.h>
 #include <linux/cacheinfo.h>
+#include <linux/rcuwait.h>
 
 struct mempolicy;
 struct anon_vma;
@@ -699,10 +700,27 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
 #ifdef CONFIG_PER_VMA_LOCK
 static inline void vma_lock_init(struct vm_area_struct *vma)
 {
-	init_rwsem(&vma->vm_lock.lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	static struct lock_class_key lockdep_key;
+
+	lockdep_init_map(&vma->vmlock_dep_map, "vm_lock", &lockdep_key, 0);
+#endif
+	refcount_set(&vma->vm_refcnt, VMA_STATE_DETACHED);
 	vma->vm_lock_seq = UINT_MAX;
 }
 
+static inline void vma_refcount_put(struct vm_area_struct *vma)
+{
+	int refcnt;
+
+	if (!__refcount_dec_and_test(&vma->vm_refcnt, &refcnt)) {
+		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+
+		if (refcnt & VMA_STATE_LOCKED)
+			rcuwait_wake_up(&vma->vm_mm->vma_writer_wait);
+	}
+}
+
 /*
  * Try to read-lock a vma. The function is allowed to occasionally yield false
  * locked result to avoid performance overhead, in which case we fall back to
@@ -710,6 +728,8 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
  */
 static inline bool vma_start_read(struct vm_area_struct *vma)
 {
+	int oldcnt;
+
 	/*
 	 * Check before locking. A race might cause false locked result.
 	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
@@ -720,13 +740,20 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
+
+	rwsem_acquire_read(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
+	/* Limit at VMA_STATE_LOCKED - 2 to leave one count for a writer */
+	if (unlikely(!__refcount_inc_not_zero_limited(&vma->vm_refcnt, &oldcnt,
+						      VMA_STATE_LOCKED - 2))) {
+		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
 		return false;
+	}
+	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
 
 	/*
-	 * Overflow might produce false locked result.
+	 * Overflow of vm_lock_seq/mm_lock_seq might produce false locked result.
 	 * False unlocked result is impossible because we modify and check
-	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
+	 * vma->vm_lock_seq under vma->vm_refcnt protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
 	 *
 	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
@@ -734,10 +761,12 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock.lock);
+	if (oldcnt & VMA_STATE_LOCKED ||
+	    unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
+		vma_refcount_put(vma);
 		return false;
 	}
+
 	return true;
 }
 
@@ -749,8 +778,17 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
  */
 static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
+	int oldcnt;
+
 	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock.lock, subclass);
+	rwsem_acquire_read(&vma->vmlock_dep_map, subclass, 0, _RET_IP_);
+	/* Limit at VMA_STATE_LOCKED - 2 to leave one count for a writer */
+	if (unlikely(!__refcount_inc_not_zero_limited(&vma->vm_refcnt, &oldcnt,
+						      VMA_STATE_LOCKED - 2))) {
+		rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+		return false;
+	}
+	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
 	return true;
 }
 
@@ -762,15 +800,13 @@ static inline bool vma_start_read_locked_nested(struct vm_area_struct *vma, int
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
 	rcu_read_lock(); /* keeps vma alive till the end of up_read */
-	up_read(&vma->vm_lock.lock);
+	vma_refcount_put(vma);
 	rcu_read_unlock();
 }
 
@@ -813,25 +849,42 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock.lock))
+	if (refcount_read(&vma->vm_refcnt) <= VMA_STATE_ATTACHED)
 		vma_assert_write_locked(vma);
 }
 
-static inline void vma_mark_attached(struct vm_area_struct *vma)
+/*
+ * WARNING: to avoid racing with vma_mark_attached(), should be called either
+ * under mmap_write_lock or when the object has been isolated under
+ * mmap_write_lock, ensuring no competing writers.
+ */
+static inline bool is_vma_detached(struct vm_area_struct *vma)
 {
-	vma->detached = false;
+	return refcount_read(&vma->vm_refcnt) == VMA_STATE_DETACHED;
 }
 
-static inline void vma_mark_detached(struct vm_area_struct *vma)
+static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
-	/* When detaching vma should be write-locked */
 	vma_assert_write_locked(vma);
-	vma->detached = true;
+
+	if (is_vma_detached(vma))
+		refcount_set(&vma->vm_refcnt, VMA_STATE_ATTACHED);
 }
 
-static inline bool is_vma_detached(struct vm_area_struct *vma)
+static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
-	return vma->detached;
+	vma_assert_write_locked(vma);
+
+	if (is_vma_detached(vma))
+		return;
+
+	/* We are the only writer, so no need to use vma_refcount_put(). */
+	if (!refcount_dec_and_test(&vma->vm_refcnt)) {
+		/*
+		 * Reader must have temporarily raised vm_refcnt but it will
+		 * drop it without using the vma since vma is write-locked.
+		 */
+	}
 }
 
 static inline void release_fault_lock(struct vm_fault *vmf)
@@ -896,10 +949,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-#ifdef CONFIG_PER_VMA_LOCK
-	/* vma is not locked, can't use vma_mark_detached() */
-	vma->detached = true;
-#endif
 	vma_numab_state_init(vma);
 	vma_lock_init(vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 825f6328f9e5..803f718c007c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/types.h>
 
 #include <asm/mmu.h>
 
@@ -599,9 +600,9 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
 }
 #endif
 
-struct vma_lock {
-	struct rw_semaphore lock;
-};
+#define VMA_STATE_DETACHED	0x0
+#define VMA_STATE_ATTACHED	0x1
+#define VMA_STATE_LOCKED	0x40000000
 
 struct vma_numab_state {
 	/*
@@ -679,19 +680,13 @@ struct vm_area_struct {
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
+	 *  - vm_refcnt VMA_STATE_LOCKED is set
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
-	 *  - vm_lock->lock (in read or write mode)
+	 *  - vm_refcnt VMA_STATE_LOCKED is set or vm_refcnt > VMA_STATE_ATTACHED
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
@@ -754,7 +749,10 @@ struct vm_area_struct {
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
 
@@ -889,6 +887,7 @@ struct mm_struct {
 					  * by mmlist_lock
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
+		struct rcuwait vma_writer_wait;
 		/*
 		 * This field has lock-like semantics, meaning it is sometimes
 		 * accessed with ACQUIRE/RELEASE semantics.
diff --git a/kernel/fork.c b/kernel/fork.c
index 8cb19c23e892..283909d082cb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -465,10 +465,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	data_race(memcpy(new, orig, sizeof(*new)));
 	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
-#ifdef CONFIG_PER_VMA_LOCK
-	/* vma is not locked, can't use vma_mark_detached() */
-	new->detached = true;
-#endif
 	vma_numab_state_init(new);
 	dup_anon_vma_name(orig, new);
 
@@ -488,8 +484,6 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 	struct vm_area_struct *vma = container_of(head, struct vm_area_struct,
 						  vm_rcu);
 
-	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
 	__vm_area_free(vma);
 }
 #endif
@@ -1228,6 +1222,9 @@ static inline void mmap_init_lock(struct mm_struct *mm)
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
index c6356ea703d8..cff132003e24 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6331,7 +6331,25 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 #ifdef CONFIG_PER_VMA_LOCK
 void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
 {
-	down_write(&vma->vm_lock.lock);
+	bool detached;
+
+	/*
+	 * If vma is detached then only vma_mark_attached() can raise the
+	 * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
+	 */
+	if (!refcount_inc_not_zero(&vma->vm_refcnt)) {
+		WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
+		return;
+	}
+
+	rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
+	/* vma is attached, set the writer present bit */
+	refcount_add(VMA_STATE_LOCKED, &vma->vm_refcnt);
+	/* wait until state is VMA_STATE_ATTACHED + (VMA_STATE_LOCKED + 1) */
+	rcuwait_wait_event(&vma->vm_mm->vma_writer_wait,
+		   refcount_read(&vma->vm_refcnt) == VMA_STATE_ATTACHED + (VMA_STATE_LOCKED + 1),
+		   TASK_UNINTERRUPTIBLE);
+	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -6339,7 +6357,10 @@ void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock.lock);
+	detached = refcount_sub_and_test(VMA_STATE_LOCKED + 1,
+					 &vma->vm_refcnt);
+	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+	VM_BUG_ON_VMA(detached, vma); /* vma should remain attached */
 }
 EXPORT_SYMBOL_GPL(__vma_start_write);
 
@@ -6355,7 +6376,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	struct vm_area_struct *vma;
 
 	rcu_read_lock();
-retry:
 	vma = mas_walk(&mas);
 	if (!vma)
 		goto inval;
@@ -6363,13 +6383,6 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_start_read(vma))
 		goto inval;
 
-	/* Check if the VMA got isolated after we found it */
-	if (is_vma_detached(vma)) {
-		vma_end_read(vma);
-		count_vm_vma_lock_event(VMA_LOCK_MISS);
-		/* The area was replaced with another one */
-		goto retry;
-	}
 	/*
 	 * At this point, we have a stable reference to a VMA: The VMA is
 	 * locked and we know it hasn't already been isolated.
diff --git a/tools/testing/vma/linux/atomic.h b/tools/testing/vma/linux/atomic.h
index e01f66f98982..2e2021553196 100644
--- a/tools/testing/vma/linux/atomic.h
+++ b/tools/testing/vma/linux/atomic.h
@@ -9,4 +9,9 @@
 #define atomic_set(x, y) do {} while (0)
 #define U8_MAX UCHAR_MAX
 
+#ifndef atomic_cmpxchg_relaxed
+#define  atomic_cmpxchg_relaxed		uatomic_cmpxchg
+#define  atomic_cmpxchg_release         uatomic_cmpxchg
+#endif /* atomic_cmpxchg_relaxed */
+
 #endif	/* _LINUX_ATOMIC_H */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 0cdc5f8c3d60..b55556b16060 100644
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
@@ -132,10 +132,6 @@ typedef __bitwise unsigned int vm_fault_t;
  */
 #define pr_warn_once pr_err
 
-typedef struct refcount_struct {
-	atomic_t refs;
-} refcount_t;
-
 struct kref {
 	refcount_t refcount;
 };
@@ -228,15 +224,14 @@ struct mm_struct {
 	unsigned long def_flags;
 };
 
-struct vma_lock {
-	struct rw_semaphore lock;
-};
-
-
 struct file {
 	struct address_space	*f_mapping;
 };
 
+#define VMA_STATE_DETACHED	0x0
+#define VMA_STATE_ATTACHED	0x1
+#define VMA_STATE_LOCKED	0x40000000
+
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
@@ -264,16 +259,13 @@ struct vm_area_struct {
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
-	/* Flag to indicate areas detached from the mm->mm_mt tree */
-	bool detached;
-
 	/*
 	 * Can only be written (using WRITE_ONCE()) while holding both:
 	 *  - mmap_lock (in write mode)
-	 *  - vm_lock.lock (in write mode)
+	 *  - vm_refcnt VMA_STATE_LOCKED is set
 	 * Can be read reliably while holding one of:
 	 *  - mmap_lock (in read or write mode)
-	 *  - vm_lock.lock (in read or write mode)
+	 *  - vm_refcnt VMA_STATE_LOCKED is set or vm_refcnt > VMA_STATE_ATTACHED
 	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
 	 * while holding nothing (except RCU to keep the VMA struct allocated).
 	 *
@@ -282,7 +274,6 @@ struct vm_area_struct {
 	 * slowpath.
 	 */
 	unsigned int vm_lock_seq;
-	struct vma_lock vm_lock;
 #endif
 
 	/*
@@ -335,6 +326,10 @@ struct vm_area_struct {
 	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+#ifdef CONFIG_PER_VMA_LOCK
+	/* Unstable RCU readers are allowed to read this. */
+	refcount_t vm_refcnt;
+#endif
 } __randomize_layout;
 
 struct vm_fault {};
@@ -461,21 +456,37 @@ static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
 
 static inline void vma_lock_init(struct vm_area_struct *vma)
 {
-	init_rwsem(&vma->vm_lock.lock);
+	refcount_set(&vma->vm_refcnt, VMA_STATE_DETACHED);
 	vma->vm_lock_seq = UINT_MAX;
 }
 
-static inline void vma_mark_attached(struct vm_area_struct *vma)
+static inline bool is_vma_detached(struct vm_area_struct *vma)
 {
-	vma->detached = false;
+	return refcount_read(&vma->vm_refcnt) == VMA_STATE_DETACHED;
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_mark_attached(struct vm_area_struct *vma)
+{
+	vma_assert_write_locked(vma);
+
+	if (is_vma_detached(vma))
+		refcount_set(&vma->vm_refcnt, VMA_STATE_ATTACHED);
+}
+
 static inline void vma_mark_detached(struct vm_area_struct *vma)
 {
-	/* When detaching vma should be write-locked */
 	vma_assert_write_locked(vma);
-	vma->detached = true;
+
+	if (is_vma_detached(vma))
+		return;
+
+	if (!refcount_dec_and_test(&vma->vm_refcnt)) {
+		/*
+		 * Reader must have temporarily raised vm_refcnt but it will
+		 * drop it without using the vma since vma is write-locked.
+		 */
+	}
 }
 
 extern const struct vm_operations_struct vma_dummy_vm_ops;
@@ -488,8 +499,6 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_mm = mm;
 	vma->vm_ops = &vma_dummy_vm_ops;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
-	/* vma is not locked, can't use vma_mark_detached() */
-	vma->detached = true;
 	vma_lock_init(vma);
 }
 
@@ -515,8 +524,6 @@ static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 	memcpy(new, orig, sizeof(*new));
 	vma_lock_init(new);
 	INIT_LIST_HEAD(&new->anon_vma_chain);
-	/* vma is not locked, can't use vma_mark_detached() */
-	new->detached = true;
 
 	return new;
 }
-- 
2.47.1.613.gc27f4b7a9f-goog


