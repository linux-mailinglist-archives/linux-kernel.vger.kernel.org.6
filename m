Return-Path: <linux-kernel+bounces-404752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3079C47B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE10328131B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607491BD9DC;
	Mon, 11 Nov 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YehisEEE"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772881F6665
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358520; cv=none; b=lVGO5txrwHq/PdU3Hr3aMby/A1AXe34XA6ni6qEi0Dtt12Il1P1DfIYqQBURXeON+pMfBGz7/v4aJMVtFkVFesf1yDY0Pj7l8SZoD/766F0josgbwWbJ+1NFQoIbWvuxO2MLKxbFsVpTytQJySKaXodvt6xvqp6pisk1ZOkXmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358520; c=relaxed/simple;
	bh=x2DwPfktU+N2hAPypNzw01OFrB7f7HEUMaxrxZN82Lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HNes/WO8N1tHQFLe68rfojH8ZGUorG52NE8E4g9N9OeL6eG8SxDAoedrA7SFkgqeGFgzHAjPV9b69ayh/ghg2Wxg3qBaX/sHOV3F2daYKBUdoELn4PsbQJA+h7BtT8+2hKtI8adtdEUPdQ0Zy/QzIRUhVQtXkLattIuz3CEW6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YehisEEE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2904d0cad0so8295000276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731358517; x=1731963317; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ifdJ2eX7iGI1j7/6aWcHQxmdsxhJaJa3q49onQy2Ll4=;
        b=YehisEEEprtOQgVrhHAlraTM4YAXQzIy9ctxqVb9xPdhJ8m8k1BuClwIvdNQSTVhKH
         9jEcyqcNtcjYjO/32tnVLggZkVhXEJgqglNCKr0nymkp7jlR0CN2vSMxIlrpgakHdvf1
         L91BVc01YNWa63dD4Ilzqm7HBE2PwQFW7fMvrcACoCaQjKXV5N+nxY9lhJngMvmcMl81
         eX23eEaNh4twBjeJQvYI1HUjSyHgn91EkPIHrMzO+j3XJKDcyX+LjKw+2T1ukp52u0eW
         ZrWpt8EosFHRbNbEM+np97EJ0RJKdkaJ+VgQEer+qQFsm2UAjib4NXz95xjZpcgBX2nF
         kbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358517; x=1731963317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifdJ2eX7iGI1j7/6aWcHQxmdsxhJaJa3q49onQy2Ll4=;
        b=o+kKPX38yXihScYjAhk64ha2fP1Udy+uOk0RcLD8bEV7fhkYRc11H7I3iyMWS6MTPR
         NoPdnsZULKf/+w6ug7K/trcSCMpNSlWoKNkGfYnAQmDLTZFV19U0jaTV0IwIsCe9QcZ2
         2ONQMv6m7FXOrQvPmVbGljRoTksOfwOBCqDdsjCet6IgvEm6okHkUgHEwiTLKiqupw7F
         RfgdmdVEr7BSYFDsDMvZVXvdAdbKrEUDK+LOLsi7VowGM0VQdkWv/GWcqG0UlUnWKfDk
         YAWYGhOfLmSEOm9SRsgEMjaHJ1z6+cs7j1LDmCS6yOAmpD1tH/OYl/uVMHt51RL77IAi
         aQpA==
X-Forwarded-Encrypted: i=1; AJvYcCXy7toAjggWjpWcG16t8UNuIeceJUqCnztR0MajZJIUor/c3jW9OYM2Drq6P2SC/YkgATivwJixYCwWp9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcVmoL3BPGsuX45ox52OevyusTM/7B8+rbZzWjnRRvApRn9W/
	1CToXLF1g8SSasRFJBbe7hiu8uZpoDPxVC7AMWtnmRUM5IFgy3L/TNsApNwAuAkXwu1aTeu5FCg
	8zw==
X-Google-Smtp-Source: AGHT+IHUDRefIenXEALrWCUUFASKqSkv9c9zYj40iRYol9Wb1hfXY9ZKD83QbQvFvfVT3Q58PHh5dYLSl+c=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:53af:d9fa:522d:99b1])
 (user=surenb job=sendgmr) by 2002:a25:7144:0:b0:e30:d518:30f1 with SMTP id
 3f1490d57ef6-e337f83cceemr4619276.1.1731358516486; Mon, 11 Nov 2024 12:55:16
 -0800 (PST)
Date: Mon, 11 Nov 2024 12:55:05 -0800
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111205506.3404479-4-surenb@google.com>
Subject: [PATCH 3/4] mm: replace rw_semaphore with atomic_t in vma_lock
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

rw_semaphore is a sizable structure of 40 bytes and consumes
considerable space for each vm_area_struct. However vma_lock has
two important specifics which can be used to replace rw_semaphore
with a simpler structure:
1. Readers never wait. They try to take the vma_lock and fall back to
mmap_lock if that fails.
2. Only one writer at a time will ever try to write-lock a vma_lock
because writers first take mmap_lock in write mode.
Because of these requirements, full rw_semaphore functionality is not
needed and we can replace rw_semaphore with an atomic variable.
When a reader takes read lock, it increments the atomic, unless the
top two bits are set indicating a writer is present.
When writer takes write lock, it sets VMA_LOCK_WR_LOCKED bit if there
are no readers or VMA_LOCK_WR_WAIT bit if readers are holding the lock
and puts itself onto newly introduced mm.vma_writer_wait. Since all
writers take mmap_lock in write mode first, there can be only one writer
at a time. The last reader to release the lock will signal the writer
to wake up.
atomic_t might overflow if there are many competing readers, therefore
vma_start_read() implements an overflow check and if that occurs it
exits with a failure to lock. vma_start_read_locked{_nested} may cause
an overflow but it is later handled by __vma_end_read().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h        | 142 ++++++++++++++++++++++++++++++++++----
 include/linux/mm_types.h  |  18 ++++-
 include/linux/mmap_lock.h |   3 +
 kernel/fork.c             |   2 +-
 mm/init-mm.c              |   2 +
 5 files changed, 151 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c1c2899464db..27c0e9ba81c4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -686,7 +686,41 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
 #ifdef CONFIG_PER_VMA_LOCK
 static inline void vma_lock_init(struct vma_lock *vm_lock)
 {
-	init_rwsem(&vm_lock->lock);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	static struct lock_class_key lockdep_key;
+
+	lockdep_init_map(&vm_lock->dep_map, "vm_lock", &lockdep_key, 0);
+#endif
+	atomic_set(&vm_lock->count, VMA_LOCK_UNLOCKED);
+}
+
+static inline unsigned int vma_lock_reader_count(unsigned int counter)
+{
+	return counter & VMA_LOCK_RD_COUNT_MASK;
+}
+
+static inline void __vma_end_read(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	unsigned int count, prev, new;
+
+	count = (unsigned int)atomic_read(&vma->vm_lock.count);
+	for (;;) {
+		if (unlikely(vma_lock_reader_count(count) == 0)) {
+			/*
+			 * Overflow was possible in vma_start_read_locked().
+			 * When detected, wrap around preserving writer bits.
+			 */
+			new = count | ~(VMA_LOCK_WR_LOCKED | VMA_LOCK_WR_WAIT);
+		} else
+			new = count - 1;
+		prev = atomic_cmpxchg(&vma->vm_lock.count, count, new);
+		if (prev == count)
+			break;
+		count = prev;
+	}
+	rwsem_release(&vma->vm_lock.dep_map, _RET_IP_);
+	if (vma_lock_reader_count(new) == 0 && (new & VMA_LOCK_WR_WAIT))
+		wake_up(&mm->vma_writer_wait);
 }
 
 /*
@@ -696,6 +730,9 @@ static inline void vma_lock_init(struct vma_lock *vm_lock)
  */
 static inline bool vma_start_read(struct vm_area_struct *vma)
 {
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned int count, prev, new;
+
 	/*
 	 * Check before locking. A race might cause false locked result.
 	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
@@ -703,11 +740,35 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(mm->mm_lock_seq.sequence))
 		return false;
 
-	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
-		return false;
+	rwsem_acquire_read(&vma->vm_lock.dep_map, 0, 0, _RET_IP_);
+	count = (unsigned int)atomic_read(&vma->vm_lock.count);
+	for (;;) {
+		/* Is VMA is write-locked or writer is waiting? */
+		if (count & (VMA_LOCK_WR_LOCKED | VMA_LOCK_WR_WAIT)) {
+			rwsem_release(&vma->vm_lock.dep_map, _RET_IP_);
+			return false;
+		}
+
+		new = count + 1;
+		/* If atomic_t overflows, fail to lock. */
+		if (new & (VMA_LOCK_WR_LOCKED | VMA_LOCK_WR_WAIT)) {
+			rwsem_release(&vma->vm_lock.dep_map, _RET_IP_);
+			return false;
+		}
+
+		/*
+		 * Atomic RMW will provide implicit mb on success to pair with smp_wmb in
+		 * vma_start_write, on failure we retry.
+		 */
+		prev = atomic_cmpxchg(&vma->vm_lock.count, count, new);
+		if (prev == count)
+			break;
+		count = prev;
+	}
+	lock_acquired(&vma->vm_lock.dep_map, _RET_IP_);
 
 	/*
 	 * Overflow might produce false locked result.
@@ -720,8 +781,8 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
-		up_read(&vma->vm_lock.lock);
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&mm->mm_lock_seq))) {
+		__vma_end_read(mm, vma);
 		return false;
 	}
 	return true;
@@ -733,8 +794,30 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
  */
 static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
 {
-	mmap_assert_locked(vma->vm_mm);
-	down_read_nested(&vma->vm_lock.lock, subclass);
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned int count, prev, new;
+
+	mmap_assert_locked(mm);
+
+	rwsem_acquire_read(&vma->vm_lock.dep_map, subclass, 0, _RET_IP_);
+	count = (unsigned int)atomic_read(&vma->vm_lock.count);
+	for (;;) {
+		/* We are holding mmap_lock, no active or waiting writers are possible. */
+		VM_BUG_ON_VMA(count & (VMA_LOCK_WR_LOCKED | VMA_LOCK_WR_WAIT), vma);
+		new = count + 1;
+		/* Unlikely but if atomic_t overflows, wrap around to. */
+		if (WARN_ON(new & (VMA_LOCK_WR_LOCKED | VMA_LOCK_WR_WAIT)))
+			new = 0;
+		/*
+		 * Atomic RMW will provide implicit mb on success to pair with smp_wmb in
+		 * vma_start_write, on failure we retry.
+		 */
+		prev = atomic_cmpxchg(&vma->vm_lock.count, count, new);
+		if (prev == count)
+			break;
+		count = prev;
+	}
+	lock_acquired(&vma->vm_lock.dep_map, _RET_IP_);
 }
 
 /*
@@ -743,14 +826,15 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
  */
 static inline void vma_start_read_locked(struct vm_area_struct *vma)
 {
-	mmap_assert_locked(vma->vm_mm);
-	down_read(&vma->vm_lock.lock);
+	vma_start_read_locked_nested(vma, 0);
 }
 
 static inline void vma_end_read(struct vm_area_struct *vma)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	rcu_read_lock(); /* keeps vma alive till the end of up_read */
-	up_read(&vma->vm_lock.lock);
+	__vma_end_read(mm, vma);
 	rcu_read_unlock();
 }
 
@@ -774,12 +858,34 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_l
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
+	unsigned int count, prev, new;
 	unsigned int mm_lock_seq;
 
+	might_sleep();
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
 
-	down_write(&vma->vm_lock.lock);
+	rwsem_acquire(&vma->vm_lock.dep_map, 0, 0, _RET_IP_);
+	count = (unsigned int)atomic_read(&vma->vm_lock.count);
+	for (;;) {
+		if (vma_lock_reader_count(count) > 0)
+			new = count | VMA_LOCK_WR_WAIT;
+		else
+			new = count | VMA_LOCK_WR_LOCKED;
+		prev = atomic_cmpxchg(&vma->vm_lock.count, count, new);
+		if (prev == count)
+			break;
+		count = prev;
+	}
+	if (new & VMA_LOCK_WR_WAIT) {
+		lock_contended(&vma->vm_lock.dep_map, _RET_IP_);
+		wait_event(vma->vm_mm->vma_writer_wait,
+			   atomic_cmpxchg(&vma->vm_lock.count, VMA_LOCK_WR_WAIT,
+					  VMA_LOCK_WR_LOCKED) == VMA_LOCK_WR_WAIT);
+
+	}
+	lock_acquired(&vma->vm_lock.dep_map, _RET_IP_);
+
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -787,7 +893,10 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	up_write(&vma->vm_lock.lock);
+	/* Write barrier to ensure vm_lock_seq change is visible before count */
+	smp_wmb();
+	rwsem_release(&vma->vm_lock.dep_map, _RET_IP_);
+	atomic_set(&vma->vm_lock.count, VMA_LOCK_UNLOCKED);
 }
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
@@ -797,9 +906,14 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
 
+static inline bool is_vma_read_locked(struct vm_area_struct *vma)
+{
+	return vma_lock_reader_count((unsigned int)atomic_read(&vma->vm_lock.count)) > 0;
+}
+
 static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	if (!rwsem_is_locked(&vma->vm_lock.lock))
+	if (!is_vma_read_locked(vma))
 		vma_assert_write_locked(vma);
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5c4bfdcfac72..789bccc05520 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -615,8 +615,23 @@ static inline struct anon_vma_name *anon_vma_name_alloc(const char *name)
 }
 #endif
 
+#define VMA_LOCK_UNLOCKED		0
+#define VMA_LOCK_WR_LOCKED		(1 << 31)
+#define VMA_LOCK_WR_WAIT		(1 << 30)
+
+#define VMA_LOCK_RD_COUNT_MASK		(VMA_LOCK_WR_WAIT - 1)
+
 struct vma_lock {
-	struct rw_semaphore lock;
+	/*
+	 * count & VMA_LOCK_RD_COUNT_MASK > 0 ==> read-locked with 'count' number of readers
+	 * count & VMA_LOCK_WR_LOCKED != 0 ==> write-locked
+	 * count & VMA_LOCK_WR_WAIT != 0 ==> writer is waiting
+	 * count = 0 ==> unlocked
+	 */
+	atomic_t count;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
 };
 
 struct vma_numab_state {
@@ -883,6 +898,7 @@ struct mm_struct {
 					  * by mmlist_lock
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
+		struct wait_queue_head vma_writer_wait;
 		/*
 		 * This field has lock-like semantics, meaning it is sometimes
 		 * accessed with ACQUIRE/RELEASE semantics.
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index 58dde2e35f7e..769ab97fff3e 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -121,6 +121,9 @@ static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
 	mm_lock_seqcount_init(mm);
+#ifdef CONFIG_PER_VMA_LOCK
+	init_waitqueue_head(&mm->vma_writer_wait);
+#endif
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
diff --git a/kernel/fork.c b/kernel/fork.c
index 9e504105f24f..726050c557e2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -486,7 +486,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
 						  vm_rcu);
 
 	/* The vma should not be locked while being destroyed. */
-	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
+	VM_BUG_ON_VMA(is_vma_read_locked(vma), vma);
 	__vm_area_free(vma);
 }
 #endif
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 6af3ad675930..db058873ba18 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -40,6 +40,8 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
+	.vma_writer_wait =
+		__WAIT_QUEUE_HEAD_INITIALIZER(init_mm.vma_writer_wait),
 	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
 #endif
 	.user_ns	= &init_user_ns,
-- 
2.47.0.277.g8800431eea-goog


