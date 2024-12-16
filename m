Return-Path: <linux-kernel+bounces-448009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6259F39CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E3318853B1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09810208977;
	Mon, 16 Dec 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbHz9gD2"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0F20CCDE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377092; cv=none; b=fjshJ6pCmrHpjx8/QGJbkNxh/98oSLfgnylovrmbgmXpqV2aP6nKeOw3alOjACamvZ9mscne/wurQNDdO70kwBcAXYgTin54meUqTsdb2Uz+c3WA75J6fem5yavc7yu0TbKHVdapzNyWqnk/WIF5/P0zRVafEhMsJx5/sdjVZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377092; c=relaxed/simple;
	bh=94fhfIX6Q2WlSK+YdFVONdwPdyOaDHKJvIkaNQuymuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ND4rxNCz6BWALwf1qcx55SOPrIh6qU/vq2n2+rO3aYA3Px8uEX2CjXLpDG5tDMj9PucQhebgdZyeXLRwxcmIaHrJN5PqWlT2K1Ge4VNFGAXCTbWOpMurmY57py80VSKjBiB0bIzVrIsLTua9SJQuj+ODF32m+4Er1ezUu/64RDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbHz9gD2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fdde44f4f2so2850293a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734377090; x=1734981890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eye0eVNbsQT4TepH1/hu+cBmomL+3TKzfNRnkVWyI/4=;
        b=nbHz9gD2diPARnvxYSwXEyz38Xz1txu+dB8pNgGfqxUnesPjYVbymTheviPU7TYGVE
         Kgr6yYha0FbNkTGNVxrmZAQcGbitCqL5cW7ekyA0VgGPAgiHHKcT1KpVg3KO17yWX8Nq
         NLjSJJtzEk5ailYS0QtKjXdBvTgDaYSQPivQQnj9utCjEzzJsYt5TZntI2wRa4bO1GNR
         miwwkLts+gK+oa1Clq2VT2vOfl8K6ujrzFquKrnr42yno+oE59sE9Cgu+vlVPpmeyQAt
         a1yyhAAV5AT13GKmt1A1wRqwWzUCmu8Wu0eOVMu1KqhoRP64JTbBrZ2aTgPL3aBVGNs8
         6V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734377090; x=1734981890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eye0eVNbsQT4TepH1/hu+cBmomL+3TKzfNRnkVWyI/4=;
        b=iUiiFxgl8xPMZPQKyF7D7Gp1wvuikwNhb70BwHODQzQtLYsMi1d2bdHFBtIWJ4azKQ
         LaIym4zfFL9Mva3bHrriZioF1bQSRPBDBllDUPKduRloCtn48MDloXxLzvmuGSSSTwU5
         BOGwQrmLSUB9wEdYC7Zt5JdhuEzrljEB3Z7L5gPWLpU5dHYIdx9YyFP6PHJW2A7WbWwY
         YJfBM2MFGAayxLjbZSTNJW/dr/oTaxOwu/hKi4w4ft+rK/uZ5IkkeqaIyBtvjsoOHNLr
         2FdcTp8hr1A3RtfunRaj4lGiQwWI7XAnqrRMD7fusJOddYVyqvAedKxJ7THsBgrn5fQs
         hsRA==
X-Forwarded-Encrypted: i=1; AJvYcCUfPLS8WjXHtnnN85wTbdIWHpDlB1wQMA0e/bfuut5efQKQlaeyXZ5VL1qCw7t2bQpeK/6NhsXdeU8SQtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2zDCr+z9x0DpssrvlmEzG+TLTQCTrRTypwSJ75p/d66Zrphf
	vGDwMrjjbjzzf3uPR4ROuC/6BR4zUqVVst9V21zpkiDAvpl7eVt4qnrKJIY5yEbJwy5g3sJDz/H
	i4w==
X-Google-Smtp-Source: AGHT+IFpyvj1Cl0PXtve1a3hZL9RrpgDnkSC5MatBr/H5K08KaVaYCnO8eim/kS1J5eWUMkZBi1DYQsuwp4=
X-Received: from pfbdf1.prod.google.com ([2002:a05:6a00:4701:b0:728:ec44:ed90])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9f04:b0:1e0:b5ae:8fc1
 with SMTP id adf61e73a8af0-1e1dfd3da76mr21067006637.13.1734377089941; Mon, 16
 Dec 2024 11:24:49 -0800 (PST)
Date: Mon, 16 Dec 2024 11:24:16 -0800
In-Reply-To: <20241216192419.2970941-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216192419.2970941-1-surenb@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241216192419.2970941-14-surenb@google.com>
Subject: [PATCH v6 13/16] mm: introduce vma_ensure_detached()
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

vma_start_read() can temporarily raise vm_refcnt of a write-locked and
detached vma:

// vm_refcnt==1 (attached)
vma_start_write()
    vma->vm_lock_seq = mm->mm_lock_seq

                    vma_start_read()
                       vm_refcnt++; // vm_refcnt==2

vma_mark_detached()
    vm_refcnt--; // vm_refcnt==1

// vma is detached but vm_refcnt!=0 temporarily

                       if (vma->vm_lock_seq == mm->mm_lock_seq)
                           vma_refcount_put()
                               vm_refcnt--; // vm_refcnt==0

This is currently not a problem when freeing the vma because RCU grace
period should pass before kmem_cache_free(vma) gets called and by that
time vma_start_read() should be done and vm_refcnt is 0. However once
we introduce possibility of vma reuse before RCU grace period is over,
this will become a problem (reused vma might be in non-detached state).
Introduce vma_ensure_detached() for the writer to wait for readers until
they exit vma_start_read().

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h               |  9 ++++++
 mm/memory.c                      | 55 +++++++++++++++++++++++---------
 tools/testing/vma/vma_internal.h |  8 +++++
 3 files changed, 57 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b73cf64233a4..361f26dedab1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -863,6 +863,15 @@ static inline bool is_vma_detached(struct vm_area_struct *vma)
 	return refcount_read(&vma->vm_refcnt) == VMA_STATE_DETACHED;
 }
 
+/*
+ * WARNING: to avoid racing with vma_mark_attached(), should be called either
+ * under mmap_write_lock or when the object has been isolated under
+ * mmap_write_lock, ensuring no competing writers.
+ * Should be called after marking vma as detached to wait for possible
+ * readers which temporarily raised vm_refcnt to drop it back and exit.
+ */
+void vma_ensure_detached(struct vm_area_struct *vma);
+
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
 	vma_assert_write_locked(vma);
diff --git a/mm/memory.c b/mm/memory.c
index cff132003e24..534e279f98c1 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6329,18 +6329,10 @@ struct vm_area_struct *lock_mm_and_find_vma(struct mm_struct *mm,
 #endif
 
 #ifdef CONFIG_PER_VMA_LOCK
-void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
+static inline bool __vma_enter_locked(struct vm_area_struct *vma)
 {
-	bool detached;
-
-	/*
-	 * If vma is detached then only vma_mark_attached() can raise the
-	 * vm_refcnt. mmap_write_lock prevents racing with vma_mark_attached().
-	 */
-	if (!refcount_inc_not_zero(&vma->vm_refcnt)) {
-		WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-		return;
-	}
+	if (!refcount_inc_not_zero(&vma->vm_refcnt))
+		return false;
 
 	rwsem_acquire(&vma->vmlock_dep_map, 0, 0, _RET_IP_);
 	/* vma is attached, set the writer present bit */
@@ -6350,6 +6342,22 @@ void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
 		   refcount_read(&vma->vm_refcnt) == VMA_STATE_ATTACHED + (VMA_STATE_LOCKED + 1),
 		   TASK_UNINTERRUPTIBLE);
 	lock_acquired(&vma->vmlock_dep_map, _RET_IP_);
+
+	return true;
+}
+
+static inline void __vma_exit_locked(struct vm_area_struct *vma, bool *is_detached)
+{
+	*is_detached = refcount_sub_and_test(VMA_STATE_LOCKED + 1,
+					     &vma->vm_refcnt);
+	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
+}
+
+void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
+{
+	bool locked;
+
+	locked = __vma_enter_locked(vma);
 	/*
 	 * We should use WRITE_ONCE() here because we can have concurrent reads
 	 * from the early lockless pessimistic check in vma_start_read().
@@ -6357,13 +6365,30 @@ void __vma_start_write(struct vm_area_struct *vma, unsigned int mm_lock_seq)
 	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
 	 */
 	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
-	detached = refcount_sub_and_test(VMA_STATE_LOCKED + 1,
-					 &vma->vm_refcnt);
-	rwsem_release(&vma->vmlock_dep_map, _RET_IP_);
-	VM_BUG_ON_VMA(detached, vma); /* vma should remain attached */
+	if (locked) {
+		bool detached;
+
+		__vma_exit_locked(vma, &detached);
+		/* vma was originally attached and should remain so */
+		VM_BUG_ON_VMA(detached, vma);
+	}
 }
 EXPORT_SYMBOL_GPL(__vma_start_write);
 
+void vma_ensure_detached(struct vm_area_struct *vma)
+{
+	if (is_vma_detached(vma))
+		return;
+
+	if (__vma_enter_locked(vma)) {
+		bool detached;
+
+		/* Wait for temporary readers to drop the vm_refcnt */
+		__vma_exit_locked(vma, &detached);
+		VM_BUG_ON_VMA(!detached, vma);
+	}
+}
+
 /*
  * Lookup and lock a VMA under RCU protection. Returned VMA is guaranteed to be
  * stable and not isolated. If the VMA is not found or is being modified the
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index b55556b16060..ac0a59906fea 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -465,6 +465,14 @@ static inline bool is_vma_detached(struct vm_area_struct *vma)
 	return refcount_read(&vma->vm_refcnt) == VMA_STATE_DETACHED;
 }
 
+static inline void vma_ensure_detached(struct vm_area_struct *vma)
+{
+	if (is_vma_detached(vma))
+		return;
+
+	refcount_set(&vma->vm_refcnt, VMA_STATE_DETACHED);
+}
+
 static inline void vma_assert_write_locked(struct vm_area_struct *);
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
-- 
2.47.1.613.gc27f4b7a9f-goog


