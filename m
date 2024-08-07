Return-Path: <linux-kernel+bounces-278390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4B94AF9C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D244BB2566D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41D13D262;
	Wed,  7 Aug 2024 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZjySrnU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405F3535D4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055011; cv=none; b=mHGjEGSAwKnZdlPds4h69OrqPpj9Pq/5BRTBwpKbBD75ahA8OGTVy/4echFa2vNMZma4jGlVsGDNhZIVkVmFKyHOHe6GlsrLG8fbb8gntnd7WiTRhurC2kbNHC1syp7Rij7yYhrmMpEH+Anlob//YqqHwUXDuq1VcA2yRocLxuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055011; c=relaxed/simple;
	bh=8IxW4VOrEOrBBQRN06pTf1aXaF8Jwcby7xkrfxUwnGo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qO/rgWAemLXVQA6YLJcg/e1Oo1TyCf78jrSuqizcASZhrW0Hcq6ZM0LYp1BQ7V7+RB88yB7iD6M7NPVZoZCWE9L0RWJq3aKvVVfHdF9uBPwaEqScaLrKYUz6gS4voO1CblN0WN0mtKp95yLa+IjOaRBcNX/cJWBB6Lp3TcyRVzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZjySrnU; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0e78047c98so163657276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723055009; x=1723659809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cjXSF+1fbqU97i86m9sMAF3Z3GIA4RGwT8VUdkERoWQ=;
        b=pZjySrnUnQMvHaeSkwlsRQj/sF7j5lUsm6MMbFLKY/HpQ2y2HCc+BvkXmhk+DIBkNu
         mrHK3+WvyHySJUMgzYZx3W3adAxDL8nyeBc/GCaNfwxqyaoORTyJQmJY/OcwO16MOAou
         VYtqV3EOzclTctW9FnJUBDRiu5R5r3IKrBaRkq0KD+Kmsy3G72lJSe6o0RDuwFwYHXgK
         nyBHnucvEivnobGPz49FHAma8xLdUZYYawoinw87TqOugMZ0q8Ts2vwIuhCkkL6B7+5P
         QL8kwYl/M1Q561w9TPNdZLjL6kzbLk/3htR0UQWcKTc+bMrggUiu54yOZjtLCAsUUCyQ
         jyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055009; x=1723659809;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cjXSF+1fbqU97i86m9sMAF3Z3GIA4RGwT8VUdkERoWQ=;
        b=uXQaIJlDrTRB3eVvCANFfVoPkQBote1SxjcANIE5Ks1REd8QaGKqMhhT8sda7GNIrr
         jmQMd+IuDuYfM2VaZO+b0MNVwd7e96pKTGKRdfoFm/Z+cq/CoXsf8I1SpAV6qcGApiH1
         RGYnK0Vhm0msdaAvr1H9md7hx5PwvHjfjh5ulaXdUB21NAIyvyCd/MQ0kMxLrDO3plXQ
         8coHaqsXW3i13TUgzEKszCLEQ64kL4m1nCmOAgnqB2f9oniULRSVknEgHbiBpQX/zIWm
         TwybGfT/xNrh/Rl9z2OhlaGjg4iKnaBVOEYhabNyaytrkl5zJct7o4oRgfiZKkqY0Mt6
         0OCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWowXCCVC+vVhNpK9mCYS4NU5hFjcmDUACpgXFbBV8Fjn1UHBS/mnOLJYpI3BUhB2GmwfUl9qyth6fnpI54XufVRlPJegdbOQLbKgqK
X-Gm-Message-State: AOJu0YxnWn1WXHXmrfIbfHI8gHYR7BZDPw7cuvnp1yxWOC88fS48Phaq
	Ouk1fWgIi2o0YK3lEuGZC5WkcIP5xHcVHLalW3p+C5ubSlJQG1E0hEP/9gucYMk/sLqAp/iWjQM
	2OQ==
X-Google-Smtp-Source: AGHT+IFtx5yrvIDKj1aGdZVeI2pMIZ2SGpwEbJe4uOfEhEUZrEjZMvJ+vqxMzJTMkybTvvTGLvjEDJyxMmE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f905:b850:1bd5:78f6])
 (user=surenb job=sendgmr) by 2002:a05:6902:f11:b0:e0b:ea2e:7b00 with SMTP id
 3f1490d57ef6-e0bea2e811dmr71355276.5.1723055009092; Wed, 07 Aug 2024 11:23:29
 -0700 (PDT)
Date: Wed,  7 Aug 2024 11:23:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240807182325.2585582-1-surenb@google.com>
Subject: [RFC 1/1] mm: introduce mmap_lock_speculation_{start|end}
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org, andrii.nakryiko@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
Discussion [1] follow-up. If proves to be useful can be included in that
patchset. Based on mm-unstable.

[1] https://lore.kernel.org/all/20240730134605.GO33588@noisy.programming.kicks-ass.net/

 include/linux/mm_types.h  |  3 +++
 include/linux/mmap_lock.h | 53 +++++++++++++++++++++++++++++++--------
 kernel/fork.c             |  3 ---
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 003619fab20e..a426e6ced604 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
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
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index de9dc20b01ba..5410ce741d75 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,15 +71,12 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
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
+static inline void init_mm_lock_seq(struct mm_struct *mm)
+{
+	mm->mm_lock_seq = 0;
+}
+
+static inline void inc_mm_lock_seq(struct mm_struct *mm)
 {
 	mmap_assert_write_locked(mm);
 	/*
@@ -91,19 +88,52 @@ static inline void vma_end_write_all(struct mm_struct *mm)
 	 */
 	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
 }
+
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq)
+{
+	/* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
+	*seq = smp_load_acquire(&mm->mm_lock_seq);
+	/* Allow speculation if mmap_lock is not write-locked */
+	return (*seq & 1) == 0;
+}
+
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq)
+{
+	/* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
+	return seq == smp_load_acquire(&mm->mm_lock_seq);
+}
+
 #else
-static inline void vma_end_write_all(struct mm_struct *mm) {}
+static inline void init_mm_lock_seq(struct mm_struct *mm) {}
+static inline void inc_mm_lock_seq(struct mm_struct *mm) {}
+static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int *seq) { return false; }
+static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int seq) { return false; }
 #endif
 
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
+	inc_mm_lock_seq(mm);
+}
+
 static inline void mmap_init_lock(struct mm_struct *mm)
 {
 	init_rwsem(&mm->mmap_lock);
+	init_mm_lock_seq(mm);
 }
 
 static inline void mmap_write_lock(struct mm_struct *mm)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write(&mm->mmap_lock);
+	inc_mm_lock_seq(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -111,6 +141,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	inc_mm_lock_seq(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -120,6 +151,8 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret)
+		inc_mm_lock_seq(mm);
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 3d590e51ce84..73e37af8a24d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	seqcount_init(&mm->write_protect_seq);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
-#ifdef CONFIG_PER_VMA_LOCK
-	mm->mm_lock_seq = 0;
-#endif
 	mm_pgtables_bytes_init(mm);
 	mm->map_count = 0;
 	mm->locked_vm = 0;

base-commit: 98808d08fc0f78ee638e0c0a88020fbbaf581ec6
-- 
2.46.0.rc2.264.g509ed76dc8-goog


