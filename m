Return-Path: <linux-kernel+bounces-327276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038F977345
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8516CB20F71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F11C2322;
	Thu, 12 Sep 2024 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ppWphQR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7714B19E96A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174949; cv=none; b=nr8PW8F9QyOqaFaZ39oOrP/n8t4n8JSLmHr9g6fouMtLwJCEDw6d9BmFFyM+itcQjD6p5eAei5W80bWxq/s5IqbwPqgF0cU10SkojXp69O9FSGxrhKAN+wOm0nocgAlZMkFNa4MGJKhFivRGSpIddhmotM9cS/NDIW1kIjiVDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174949; c=relaxed/simple;
	bh=9IUEbaJMxHsAIMsHxNOMcYWGOuHWxLZOE+KiDgaa434=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gUOoy1EJJib+Fb1XNOAlPeoJ0vhBt5AoSEzjhks4aNXFy+hkRM4lyNjp3IxMm+evGqBS1LFk/mBKHtfwvFUXfa4KFjToOZpCigyvJaZuOx1fM2fqvXaG8MApqhpOoey4F/c9bhz5k1LMczmeFaV3A78azsIYEwZ5Eph7/bYYfw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ppWphQR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ceef1b984so556961276.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174946; x=1726779746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhdYG9qzYkU8fhMrG0yOrq2vgwt4qH3lwD7TAy4ybww=;
        b=1ppWphQRYlve4GAv9C+ueN3qY5e7DqEw+P4ws1pGBOTNGI+BZASyOjtw4EO6OScPla
         a513w0BvR9X8PS7FeFnIFujIT+Cy4y0rOOSTZkoqnoy95u769fKiZaSTfUiR1QNFy/kU
         4g9Bm+D1JFTSlOdAzX7VOc0wmgN85mJF3vkH/NLlKc1Eud5vsAmD36JywoN05G6NH0KQ
         RQQf4toocQftncBumoyBNTK9TpXI6NcjrpVsjTYRZ3iT2bzVMONV6rmRtqhXIv0ydIrg
         2Kj5ZB/HIAgonpW2Ht7r0aE9EwMikXDXK8HGin3V4FDyQmF1K/qZANlhsJR4xsYZ8+Jz
         ecPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174946; x=1726779746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhdYG9qzYkU8fhMrG0yOrq2vgwt4qH3lwD7TAy4ybww=;
        b=Y6eCOufK7jZJTcvOb+uLukyu/hyBHkoeg2so4rmsmc9E7a7PcIe1D7GPKIa72kwg+e
         watxBA/8sA+aTqSIFf74u6fb4pWkkG94+sRuNcH8zhT9x6P9IsvLf5ARKJjSUvy6sqv2
         cOHHNBfmS8n5k5cRrIdXuMuNXPg5t1+ZlgmgJsQxn05UFWi5Xa3WvKdYbfwucv8RrM/s
         9j9d3H2JdspeG3QI2+H+OWBOC+n7Gd57L7bdSHsCN4WMGUVRVhPvzQUvZ6Ze8lkU2Ivk
         aLjylSEqSboQXBhFZYb8x9cdkZ4m0IDvTVpC4/9OL5GekDJM5TwO8rMTdJngtWeKnPwD
         TSAw==
X-Forwarded-Encrypted: i=1; AJvYcCVGkrMZeTNfPeXi6OmGuUZ1hM+7DmDQIG+mcqlrrrzJO2jOI/p7GWTHHE+x+EFxpPhKoscXGjxYfPO0ONk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxI4eZMwSTkM5h7l+LgI/jsqSO36jXAGTX7yXRDKJQq4SAenO
	wgejwrdXVAh/7ts7ivoCsCeeZBKbr/kspOjdN/yyj49Uv4dMDAtWZOvmpw3qivRSLBXhZGHXS5M
	kYg==
X-Google-Smtp-Source: AGHT+IEPfAUTVLLk7c4i9PufrTZIibPhbQ62xoH444q1VdGgK0TSyAVusflkXa93qX5xScpfTaJSu0i6+jw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:68a2:335d:594f:da63])
 (user=surenb job=sendgmr) by 2002:a25:26cb:0:b0:e1a:8735:8390 with SMTP id
 3f1490d57ef6-e1daff7cd07mr967276.4.1726174946099; Thu, 12 Sep 2024 14:02:26
 -0700 (PDT)
Date: Thu, 12 Sep 2024 14:02:22 -0700
In-Reply-To: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912210222.186542-1-surenb@google.com>
Subject: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
From: Suren Baghdasaryan <surenb@google.com>
To: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

Add helper functions to speculatively perform operations without
read-locking mmap_lock, expecting that mmap_lock will not be
write-locked and mm is not modified from under us.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
Changes since v1 [1]:
- Made memory barriers in inc_mm_lock_seq and mmap_lock_speculation_end
more strict, per Jann Horn

[1] https://lore.kernel.org/all/20240906051205.530219-2-andrii@kernel.org/

 include/linux/mm_types.h  |  3 ++
 include/linux/mmap_lock.h | 74 ++++++++++++++++++++++++++++++++-------
 kernel/fork.c             |  3 --
 3 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..5d8cdebd42bc 100644
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
index de9dc20b01ba..a281519d0c12 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -71,39 +71,86 @@ static inline void mmap_assert_write_locked(const struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+static inline void init_mm_lock_seq(struct mm_struct *mm)
+{
+	mm->mm_lock_seq = 0;
+}
+
 /*
- * Drop all currently-held per-VMA locks.
- * This is called from the mmap_lock implementation directly before releasing
- * a write-locked mmap_lock (or downgrading it to read-locked).
- * This should normally NOT be called manually from other places.
- * If you want to call this manually anyway, keep in mind that this will release
- * *all* VMA write locks, including ones from further up the stack.
+ * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE semantics)
+ * or write-unlocked (RELEASE semantics).
  */
-static inline void vma_end_write_all(struct mm_struct *mm)
+static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
 {
 	mmap_assert_write_locked(mm);
 	/*
 	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
 	 * mmap_lock being held.
-	 * We need RELEASE semantics here to ensure that preceding stores into
-	 * the VMA take effect before we unlock it with this store.
-	 * Pairs with ACQUIRE semantics in vma_start_read().
 	 */
-	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
+
+	if (acquire) {
+		WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+		/*
+		 * For ACQUIRE semantics we should ensure no following stores are
+		 * reordered to appear before the mm->mm_lock_seq modification.
+		 */
+		smp_wmb();
+	} else {
+		/*
+		 * We need RELEASE semantics here to ensure that preceding stores
+		 * into the VMA take effect before we unlock it with this store.
+		 * Pairs with ACQUIRE semantics in vma_start_read().
+		 */
+		smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
+	}
+}
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
+	/* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
+	smp_rmb();
+	return seq == READ_ONCE(mm->mm_lock_seq);
 }
+
 #else
-static inline void vma_end_write_all(struct mm_struct *mm) {}
+static inline void init_mm_lock_seq(struct mm_struct *mm) {}
+static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire) {}
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
+	inc_mm_lock_seq(mm, false);
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
+	inc_mm_lock_seq(mm, true);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -111,6 +158,7 @@ static inline void mmap_write_lock_nested(struct mm_struct *mm, int subclass)
 {
 	__mmap_lock_trace_start_locking(mm, true);
 	down_write_nested(&mm->mmap_lock, subclass);
+	inc_mm_lock_seq(mm, true);
 	__mmap_lock_trace_acquire_returned(mm, true, true);
 }
 
@@ -120,6 +168,8 @@ static inline int mmap_write_lock_killable(struct mm_struct *mm)
 
 	__mmap_lock_trace_start_locking(mm, true);
 	ret = down_write_killable(&mm->mmap_lock);
+	if (!ret)
+		inc_mm_lock_seq(mm, true);
 	__mmap_lock_trace_acquire_returned(mm, true, ret == 0);
 	return ret;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 61070248a7d3..c86e87ed172b 100644
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

base-commit: 015bdfcb183759674ba1bd732c3393014e35708b
-- 
2.46.0.662.g92d0881bb0-goog


