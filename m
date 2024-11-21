Return-Path: <linux-kernel+bounces-417215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF219D50B4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7B5B2607A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498B1A072C;
	Thu, 21 Nov 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7bGXUhG"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDF198A2F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206513; cv=none; b=br/1RSDmKyCYro8Q7Z+hGY4g4mQZT0pJuOwV6f7Va/t9GvrYwXXmtUPPR/zHrYn+50BEWQjKSOujAsFUHVypT8ZJGOs4MFcY2KJDwe4kWlchGbK1p7EsdTW5IkTVsKfueWD/UAt+GScZmWnLKm9fTrf9xswI4wXPK6f1oaWwYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206513; c=relaxed/simple;
	bh=nnel4EeHSnDDVYCG1k+73k7sW55U7QqQ9yJ6GiUx6/E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sqK5ZsW6YA6e3/7S0pcbQ6wxdlgL4GuRyGtE+rU0S8ny5jeWh7tgCRx6tWv2W1hxyRdbU5ZT8FY3EPe4H+X8r77rUO5HRXinnwPE9q/Wt1kkO9i7H5OPTQh1RY2but/3yFVVfFiqncVZuBqKH8mCy3vLJsDnXKlfscW1nRNByUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7bGXUhG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3810bac8a7so1898387276.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732206511; x=1732811311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ8UTjZk7jir+LycT80EIvFwdpwWL3Ztdnpnjs747EY=;
        b=Q7bGXUhGQMwq49vt4eiq95kKCOt2z5PanNH86XocAkjO6K53VG/bu8jo1BJkf4rFwz
         ZSXGo/Ar4pcL6QWUdNPbxAYLD2+M8d9pEhocCw7GcLStFgaJp4CXn2T6Lf3ig63fZ7Hi
         /jSqOSYKKuOjn4IfDYNX7FtxRmiEJls4DX/kW5m2Tx2kcNfar3TLDwv00ONmVAefbj6B
         ooARBgG6BgIKAuHYdScbcjumDvwpQafSrWF5Qqaq/S2+RUJ/Rob+mlPr3+AqGdaYhFfw
         csAOI43YGRsivhByPGT1xtzpfciVE30p+g27WtPZfeZj2JguBfFvZPBKETYxSVr5HBQP
         +Pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206511; x=1732811311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ8UTjZk7jir+LycT80EIvFwdpwWL3Ztdnpnjs747EY=;
        b=SS/4r6RREywOHcu420vSnmaj59F7bCMCnnwULnWfTQ6bRKp8KEb6n94fKCSeIDuqwS
         FLTQ0JT/oiFCroGn6NbbMQqFyfgDlBtSeoSctC8vpf/cMBWvR+4oAa9X99Nmbo+tfaDK
         GBAaEy/uWNMK2kWIz4blub1VpkTlTMXAwVuE94a8z1CGAVCdUb6hG5JGHNhQPUfwEA6o
         lonO8by9cJ/7ZtpBKLcecX2KXqUQyOlW5PQarh/dpJRCpOJu/tGzk64FJa2tczLDb0Ej
         Yf6h9gZ44yrsF18dSHlcqEnHya4Trgbe2a3c9BLizDGvC5eJB7/2TLqXZRnxscgA9gna
         K4mg==
X-Forwarded-Encrypted: i=1; AJvYcCUqtd6XCfkKFzTAqglgPm4tXx46q6O7vH01ZkGLObmI7igxachQOSdjpk392WzCrFXJnCbThuCkz3yNT0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3rbgEWMnhzLIwnr4q9308LIYH0gCiTcxB7H99ihhDsYjno3l
	eleMwg6TXyBffcCORFyonqJTUEgsylOW/DqynWaq/tYDbEgowyyeFlgGRcUkxvdedsZGlwpMZ1a
	P3g==
X-Google-Smtp-Source: AGHT+IEiWQTUWgLiCmkwi9eVp67gN+iglBj6XKTbng/qFRBIlXjEnuyDXqw9cHcVPHq3FWFlD33DHj9qCN0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2a00:79e0:2e3f:8:ab6:ec44:b69c:2388])
 (user=surenb job=sendgmr) by 2002:a25:8811:0:b0:e25:6701:410b with SMTP id
 3f1490d57ef6-e38cb5f7069mr34619276.5.1732206510848; Thu, 21 Nov 2024 08:28:30
 -0800 (PST)
Date: Thu, 21 Nov 2024 08:28:25 -0800
In-Reply-To: <20241121162826.987947-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121162826.987947-1-surenb@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241121162826.987947-2-surenb@google.com>
Subject: [PATCH v2 2/3] mm: convert mm_lock_seq to a proper seqcount
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
Changes since v1 [1]
- Added ASSERT_EXCLUSIVE_WRITER() instead of a comment in
vma_end_write_all, per Peter Zijlstra

[1] https://lore.kernel.org/all/20241024205231.1944747-1-surenb@google.com/

 include/linux/mm.h               | 12 +++----
 include/linux/mm_types.h         |  7 ++--
 include/linux/mmap_lock.h        | 55 +++++++++++++++++++++-----------
 kernel/fork.c                    |  5 +--
 mm/init-mm.c                     |  2 +-
 tools/testing/vma/vma.c          |  4 +--
 tools/testing/vma/vma_internal.h |  4 +--
 7 files changed, 53 insertions(+), 36 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index feb5c8021bef..e6de22738ee1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -710,7 +710,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * we don't rely on for anything - the mm_lock_seq read against which we
 	 * need ordering is below.
 	 */
-	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
@@ -727,7 +727,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * after it has been unlocked.
 	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
@@ -742,7 +742,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 }
 
 /* WARNING! Can only be used if mmap_lock is expected to be write-locked */
-static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
+static bool __is_vma_write_locked(struct vm_area_struct *vma, unsigned int *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
 
@@ -750,7 +750,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	*mm_lock_seq = vma->vm_mm->mm_lock_seq;
+	*mm_lock_seq = vma->vm_mm->mm_lock_seq.sequence;
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
@@ -761,7 +761,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
  */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	unsigned int mm_lock_seq;
 
 	if (__is_vma_write_locked(vma, &mm_lock_seq))
 		return;
@@ -779,7 +779,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 
 static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
+	unsigned int mm_lock_seq;
 
 	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 381d22eba088..ac72888a54b8 100644
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
@@ -909,6 +909,9 @@ struct mm_struct {
 		 * Roughly speaking, incrementing the sequence number is
 		 * equivalent to releasing locks on VMAs; reading the sequence
 		 * number can be part of taking a read lock on a VMA.
+		 * Incremented every time mmap_lock is write-locked/unlocked.
+		 * Initialized to 0, therefore odd values indicate mmap_lock
+		 * is write-locked and even values that it's released.
 		 *
 		 * Can be modified under write mmap_lock using RELEASE
 		 * semantics.
@@ -917,7 +920,7 @@ struct mm_struct {
 		 * Can be read with ACQUIRE semantics if not holding write
 		 * mmap_lock.
 		 */
-		int mm_lock_seq;
+		seqcount_t mm_lock_seq;
 #endif
 
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..083b7fa2588e 100644
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
 
@@ -120,10 +120,27 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
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
+	ASSERT_EXCLUSIVE_WRITER(mm->mm_lock_seq);
+	mm_lock_seqcount_end(mm);
+}
+
 static inline void mmap_write_unlock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_released(mm, true);
diff --git a/kernel/fork.c b/kernel/fork.c
index e58d27c05788..8cd36645b9fc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -449,7 +449,7 @@ static bool vma_lock_alloc(struct vm_area_struct *vma)
 		return false;
 
 	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return true;
 }
@@ -1262,9 +1262,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
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
index b33b47342d41..9074aaced9c5 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -87,7 +87,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 	 * begun. Linking to the tree will have caused this to be incremented,
 	 * which means we will get a false positive otherwise.
 	 */
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return vma;
 }
@@ -212,7 +212,7 @@ static bool vma_write_started(struct vm_area_struct *vma)
 	int seq = vma->vm_lock_seq;
 
 	/* We reset after each check. */
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	/* The vma_start_write() stub simply increments this value. */
 	return seq > -1;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index c5b9da034511..4007ec580f85 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -231,7 +231,7 @@ struct vm_area_struct {
 	 * counter reuse can only lead to occasional unnecessary use of the
 	 * slowpath.
 	 */
-	int vm_lock_seq;
+	unsigned int vm_lock_seq;
 	struct vma_lock *vm_lock;
 #endif
 
@@ -406,7 +406,7 @@ static inline bool vma_lock_alloc(struct vm_area_struct *vma)
 		return false;
 
 	init_rwsem(&vma->vm_lock->lock);
-	vma->vm_lock_seq = -1;
+	vma->vm_lock_seq = UINT_MAX;
 
 	return true;
 }
-- 
2.47.0.338.g60cca15819-goog


