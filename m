Return-Path: <linux-kernel+bounces-380647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F9D9AF419
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6203B21C23
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E66216A3E;
	Thu, 24 Oct 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uNEOLXL0"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091EF19E975
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729803158; cv=none; b=UKzVxzU1Pw6Ggd+91XRU6AXnjlnwICPsOTt38UOo88nDVoUB90AnTZr/gSaU8ES9ISc+GD9wxOu3k3DlQ9seLbGwJ+EZ1SsjN9rvPBY8AJi6tYehDOrxw1wwAJmMDK33qpX/WRsGAFdF8RlhmQqlq+yfLK+smQZasDkMI2wgypI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729803158; c=relaxed/simple;
	bh=L9BShAhiejngC85CGtvqPp19DVnJzRgOAZgmZ2Y/Mew=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kTCNaGVOb4aX0bT1eUhICzD1IZKzz2H3D26K8QEQos2X6WoAb7TB8VVC9dSRUjs/gSPDoqCO8aczkXe8uL6cWwz67FrdDlZrMXYEjS6OXcs47kdcyp64QgU4feeiRWNwDcoNgX/AhfrH1pDFCprAhyJ413qbWvxFGYB4f11OpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uNEOLXL0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e376aa4586so25724137b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729803155; x=1730407955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sIvMqrIAkqxwNJ/YN2SAKUMTqQSL0GgUejEt0+51yMQ=;
        b=uNEOLXL0twZ4+iX9ywb0qpZTTY6GJut/WbyX7yGoTwHg4t+ApPYTCk0NmiJy1BICwa
         HDDZ6ev1Cjgs0hKjQSWLwEd0FCopvCHqDLbs5Y/WLu/K0LA7AiJ2dy89u9wR2dBalj/n
         0PYu7XWNLPght0U22hH3pwQKTy0nP0DcQv3z9B6PyIRltmZWhJs4ygnajtswqSr2IyxB
         3RR8GiPw6VSB40dcWE94o9LDT4+zZqU7tFDdFYUAm0xjvqnE+Zmnvw9YIswrYnAhONZI
         MQ2oA/WUtVYFyUZ3le19va59PJm0OUmJjIOLQ3mhl5vtrl25ODiYxz68j34sK5TvMmoF
         KHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729803155; x=1730407955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIvMqrIAkqxwNJ/YN2SAKUMTqQSL0GgUejEt0+51yMQ=;
        b=apDaj6RCZ1QoYVSfQdFsd7QArSvr2C6VLXh/XaMK/xqngYRu46Xxo4m1JUKTJV+h+B
         8dcMlbVQY1yBCmUXWU5S09bf0V4ZUhQMh7maZWCv6H/B2imjdtir8SZ4wa/rZh9LJBWR
         +jqMuGVMYvkqIVsuGODyou3djzA1LSx/UCUAnRuPWMqApKr27QSgmZJDJAqhi2KT6k0/
         PRkkxhiQfMItg5dWHgTkqDdUEHOetsCx08PdSRdqPj4nevQZxuCvKr7p6UIYFFfNoVah
         kQJERuWmwn6lGtgDJO8cWhCL+y+fA8+pb8t/c754rwjrKBVXUbrpuRshaKPW9EKayWv7
         VRzg==
X-Forwarded-Encrypted: i=1; AJvYcCXNSVd1xoOre0fyn/GQNhUE9mbf/YLMrbvjXQLp0lu02bi/ie5zQDatdxUFkeGgmD2i3sC+bRRvb2DLSKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeOd8mSesQ3s739dYErcCL882ZJmbGskqNgEIHme9iVA0YA63
	r3nscxECp3yjxVGU+BwtD+TjPhHy3/mRMoXKjuDpOWCeDM7nLWuNDh3XGBwkE5/dWh3X2fT7Tp3
	Lag==
X-Google-Smtp-Source: AGHT+IGwO1wQ/PmUjhIuouna2MjV7/4C20etjLZzRMe0ybJvx0T+E1qilfBePaekfhpbeHk4DBkPtLiBOJE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:47e4:54e:bc8e:cb18])
 (user=surenb job=sendgmr) by 2002:a05:690c:6501:b0:6e3:b93:3ae2 with SMTP id
 00721157ae682-6e858158d33mr963917b3.1.1729803154840; Thu, 24 Oct 2024
 13:52:34 -0700 (PDT)
Date: Thu, 24 Oct 2024 13:52:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241024205231.1944747-1-surenb@google.com>
Subject: [PATCH 1/2] mm: convert mm_lock_seq to a proper seqcount
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii@kernel.org, jannh@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	mhocko@kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	david@redhat.com, willy@infradead.org, brauner@kernel.org, oleg@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Convert mm_lock_seq to be seqcount_t and change all mmap_write_lock
variants to increment it, in-line with the usual seqcount usage pattern.
This lets us check whether the mmap_lock is write-locked by checking
mm_lock_seq.sequence counter (odd=locked, even=unlocked). This will be
used when implementing mmap_lock speculation functions.
As a result vm_lock_seq is also change to be unsigned to match the type
of mm_lock_seq.sequence.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Applies over mm-unstable

This conversion was discussed at [1] and these patches will likely be
incorporated into the next version od Andrii's patcset.
The issue of the seqcount_t.sequence being an unsigned rather than
unsigned long will be addressed separately in collaoration with Jann Horn.

[1] https://lore.kernel.org/all/20241010205644.3831427-2-andrii@kernel.org/

 include/linux/mm.h               | 12 +++----
 include/linux/mm_types.h         |  7 ++--
 include/linux/mmap_lock.h        | 58 +++++++++++++++++++++-----------
 kernel/fork.c                    |  5 +--
 mm/init-mm.c                     |  2 +-
 tools/testing/vma/vma.c          |  4 +--
 tools/testing/vma/vma_internal.h |  4 +--
 7 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4ef8cf1043f1..77644118b200 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -698,7 +698,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
@@ -715,7 +715,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
@@ -730,7 +730,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -738,7 +738,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	*mm_lock_seq = vma->vm_mm->mm_lock_seq;
+	*mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
@@ -749,7 +749,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	unsigned int mm_lock_seq;
 
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
@@ -767,7 +767,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	unsigned int mm_lock_seq;
 
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ff8627acbaa7..80fef38d9d64 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -715,7 +715,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	unsigned int vm_lock_seq;
 	/* Unstable RCU readers are allowed to read this. */
 	struct vma_lock *vm_lock;
 #endif
@@ -887,6 +887,9 @@ struct mm_struct {
 		 * Roughly speaking, incrementing the sequence number is
 		 * equivalent to releasing locks on VMAs; reading the sequence
 		 * number can be part of taking a read lock on a VMA.
+		 * Incremented every time mmap_lock is write-locked/unlocked.
+		 * Initialized to 0, therefore odd values indicate mmap_lock
+		 * is write-locked and even values that it's released.
 		 *
 		 * Can be modified under write mmap_lock using RELEASE
 		 * semantics.
@@ -895,7 +898,7 @@ struct mm_struct {
 		 * Can be read with ACQUIRE semantics if not holding write
 		 * mmap_lock.
 		 */
-		int mm_lock_seq;
+		seqcount_t mm_lock_seq;
 #endif
 
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..6b3272686860 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,39 +71,38 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
-/*
- * Drop all currently-held per-VMA locks.
- * This is called from the mmap_lock implementation directly before releasing
- * a write-locked mmap_lock (or downgrading it to read-locked).
- * This should normally NOT be called manually from other places.
- * If you want to call this manually anyway, keep in mind that this will release
- * *all* VMA write locks, including ones from further up the stack.
- */
-static inline void vma_end_write_all(struct mm_struct *mm)
+static inline void mm_lock_seqcount_init(struct mm_struct *mm)
 {
-	mmap_assert_write_locked(mm);
-	/*
-	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
-	 * mmap_lock being held.
-	 * We need RELEASE semantics here to ensure that preceding stores into
-	 * the VMA take effect before we unlock it with this store.
-	 * Pairs with ACQUIRE semantics in vma_start_read().
-	 */
-	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
+	seqcount_init(&mm->mm_lock_seq);
+}
+
+static inline void mm_lock_seqcount_begin(struct mm_struct *mm)
+{
+	do_raw_write_seqcount_begin(&mm->mm_lock_seq);
+}
+
+static inline void mm_lock_seqcount_end(struct mm_struct *mm)
+{
+	do_raw_write_seqcount_end(&mm->mm_lock_seq);
 }
+
 #else
-static inline void vma_end_write_all(struct mm_struct *mm) {}
+static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
+static inline void mm_lock_seqcount_begin(struct mm_struct *mm) {}
+static inline void mm_lock_seqcount_end(struct mm_struct *mm) {}
 #endif
 
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
+	mm_lock_seqcount_init(mm);
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	mm_lock_seqcount_begin(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -111,6 +110,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	mm_lock_seqcount_begin(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -120,10 +120,30 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret)
+		mm_lock_seqcount_begin(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
 
+/*
+ * Drop all currently-held per-VMA locks.
+ * This is called from the mmap_lock implementation directly before releasing
+ * a write-locked mmap_lock (or downgrading it to read-locked).
+ * This should normally NOT be called manually from other places.
+ * If you want to call this manually anyway, keep in mind that this will release
+ * *all* VMA write locks, including ones from further up the stack.
+ */
+static inline void vma_end_write_all(struct mm_struct *mm)
+{
+	mmap_assert_write_locked(mm);
+	/*
+	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
+	 * mmap_lock being held.
+	 */
+	mm_lock_seqcount_end(mm);
+}
+
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
diff --git a/kernel/fork.c b/kernel/fork.c
index fd528fb5e305..0cae6fc651f0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -447,7 +447,7 @@ static bool vma_lock_alloc(struct vm_area_struct *vma)
 		return false;
 
 	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return true;
 }
@@ -1260,9 +1260,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
-#ifdef CONFIG_PER_VMA_LOCK
-	mm->mm_lock_seq = 0;
-#endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 24c809379274..6af3ad675930 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -40,7 +40,7 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 #ifdef CONFIG_PER_VMA_LOCK
-	.mm_lock_seq	= 0,
+	.mm_lock_seq	= SEQCNT_ZERO(init_mm.mm_lock_seq),
 #endif
 	.user_ns	= &init_user_ns,
 	.cpu_bitmap	= CPU_BITS_NONE,
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 8fab5e13c7c3..9bcf1736bf18 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -89,7 +89,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 	 * begun. Linking to the tree will have caused this to be incremented,
 	 * which means we will get a false positive otherwise.
 	 */
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return vma;
 }
@@ -214,7 +214,7 @@ static bool vma_write_started(struct vm_area_struct *vma)
 	int seq = vma->vm_lock_seq;
 
 	/* We reset after each check. */
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	/* The vma_start_write() stub simply increments this value. */
 	return seq > -1;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index e76ff579e1fd..1d9fc97b8e80 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -241,7 +241,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	unsigned int vm_lock_seq;
 	struct vma_lock *vm_lock;
 #endif
 
@@ -416,7 +416,7 @@ static inline bool vma_lock_alloc(struct vm_area_struct *vma)
 		return false;
 
 	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return true;
 }

base-commit: 9c111059234a949a4d3442a413ade19cc65ab927
-- 
2.47.0.163.g1226f6d8fa-goog


